package com.plant.service;

import com.plant.dao.UserMapper;
import com.plant.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private final UserMapper userMapper;

    public CustomUserDetailsService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public UserDetails loadUserByUsername(String userId) {
        UserVo user = userMapper.checkMember(userId);

        // 권한 설정
        Set<SimpleGrantedAuthority> authorities = new HashSet<>();
        if (user.getManager() == 1) {
            // 관리자
            authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else {
            // 일반 사용자
            authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        }

        user.setAuthorities(authorities);

        return user;
    }
}