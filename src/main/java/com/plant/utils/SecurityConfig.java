package com.plant.utils;

import com.plant.service.CustomUserDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final PasswordEncoder passwordEncoder;
    private final CustomUserDetailsService detailsService;

    public SecurityConfig(PasswordEncoder passwordEncoder, CustomUserDetailsService detailsService) {
        this.passwordEncoder = passwordEncoder;
        this.detailsService = detailsService;
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .authorizeRequests()
                .antMatchers("/home/**", "/login/**", "/loginPage/**", "/community/**", "/css/**", "/js/**", "/assets/**", "/uploads/**","/images/**","/diagnosis/**").permitAll()
                .antMatchers("/registPage", "/idCheckForm", "/idCheckProc", "/nickCheckForm", "/nickCheckProc","/firebase-messaging-sw.js").permitAll()
                .antMatchers("/diaries/**", "/suggestions/**", "/mypage/**", "/myplants/**", "/diagnosis/**").hasAnyRole("USER", "ADMIN")
                .antMatchers("/manager/**", "/swagger-ui/**").hasRole("ADMIN")
                .anyRequest().authenticated()
                    .and()
                .formLogin()
                    .loginPage("/loginPage")
                    .and()
                .httpBasic()
                    .and()
                .logout()
                    .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                    .logoutSuccessUrl("/home")
                    .and()
                .logout()
                    .clearAuthentication(true) // 인증 정보 삭제
                    .invalidateHttpSession(true) // 세션 무효화
                    .and()
                .sessionManagement()
                    .maximumSessions(1)
                    .maxSessionsPreventsLogin(true)
                    .expiredUrl("/loginPage");
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(detailsService).passwordEncoder(passwordEncoder);
    }
}