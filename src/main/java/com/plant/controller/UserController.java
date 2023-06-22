package com.plant.controller;

import com.plant.service.CustomUserDetailsService;
import com.plant.service.UserService;
import com.plant.vo.TokenVo;
import com.plant.vo.UserVo;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URI;

@RestController
@RequestMapping("")
@Api(tags = "사용자 서비스 API")
public class UserController {


	private final UserService userService;

	private final CustomUserDetailsService detailService;

	private final PasswordEncoder passwordEncoder;

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public  UserController(UserService userService,CustomUserDetailsService detailService,PasswordEncoder passwordEncoder){
		this.userService = userService;
		this.detailService = detailService;
		this.passwordEncoder = passwordEncoder;
	}

	/* 회원가입 폼 */
	@GetMapping("/registPage")
	public ModelAndView viewRegist() {
		ModelAndView mv = new ModelAndView("/login/regist");
		logger.info("회원가입 페이지 호출");
		return mv;
	}
	
	/* 회원가입 */
	@PostMapping("/registPage")
	public ResponseEntity<?> regist(@ModelAttribute("user") UserVo user, @RequestParam(value = "tokenValue", required = false) String token,HttpServletResponse response) throws IOException {
		user.setPassword(passwordEncoder.encode(user.getPassword()));

		TokenVo tokenvo = new TokenVo();
		boolean flag = userService.regist(user);
		String userId = user.getUserId();
		boolean flag2 = userService.saveToken(token,userId);
		logger.info("회원가입");
		if (flag) {
			URI location = ServletUriComponentsBuilder.fromCurrentContextPath().path("/loginPage").build().toUri();
			response.sendRedirect(location.toString());
			return ResponseEntity.ok().build();
		} else {
			return ResponseEntity.badRequest().body("회원가입에 실패하였습니다.");
		}


	}
	
	/* 로그인 페이지 */
	@GetMapping("/loginPage")
	public ModelAndView login() {
		ModelAndView mv = new ModelAndView("/login/login");	
		logger.info("로그인 페이지 호출");
		return mv;
	}

	/* 로그인 */
	@PostMapping("/loginPage/login")
	public ResponseEntity<String> login(@ModelAttribute UserVo user) {
		String userId = user.getUserId();
		System.out.println(userId);
		UserVo userFromDB = userService.validMember(userId);
		if (passwordEncoder.matches(user.getPassword(), userFromDB.getPassword())) {
			UserDetails userDetails = detailService.loadUserByUsername(userFromDB.getUserId());
			Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
			SecurityContextHolder.getContext().setAuthentication(authentication);
			System.out.println("userDetails = " + userDetails);
			return ResponseEntity.ok("success");
		} else {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("");
		}
	}

	/* 로그아웃 */
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mv = new ModelAndView("redirect:/home");
		session.invalidate();
		return mv;
	}
	/* 아이디 체크 1 */
	@GetMapping("/idCheckForm")
	public ModelAndView idCheckForm() {
		ModelAndView mv = new ModelAndView("/login/idCheckForm");
		return mv;
	}
	/* 아이디 체크 2 */
	@PostMapping("/idCheckProc")
	public ModelAndView idCheckProc(@RequestParam("id") String id) {
	    ModelAndView mv = new ModelAndView("/login/idCheckProc");
	    int cnt = userService.duplicateId(id);
	    mv.addObject("cnt", cnt);
	    mv.addObject("id", id);
	    return mv;
	}
	
	/* 닉네임 체크 1 */
	@GetMapping("/nickCheckForm")
	public ModelAndView nickCheckForm() {
		ModelAndView mv = new ModelAndView("/login/nickCheckForm");
		return mv;
	}
	/* 닉네임 체크 2 */
	@PostMapping("/nickCheckProc")
	public ModelAndView nickCheckProc(@RequestParam("nickname") String nickname) {
	    ModelAndView mv = new ModelAndView("/login/nickCheckProc");
	    int cnt = userService.duplicateNick(nickname);
	    mv.addObject("cnt", cnt);
	    mv.addObject("nickname", nickname);
	    return mv;
	}
	
	/* 쿠키 동의 */
    @GetMapping("/cookie")
    public ModelAndView cookie() {
        ModelAndView mv = new ModelAndView("agreement/cookie");
        return mv;
    }
    /* 웹푸시 동의 */
    @GetMapping("/webpush")
    public ModelAndView webpush() {
        ModelAndView mv = new ModelAndView("agreement/webpush");
        return mv;
    }

	@PostMapping("/token")
	public ResponseEntity<Void> getToken(@RequestParam String userId,@RequestParam String token){
		boolean search = userService.findToken(token);
		TokenVo tokenvo = new TokenVo();
		System.out.println(search);
		if(search==false) {
			boolean flag = userService.saveToken(token, userId);
		}
		return new ResponseEntity<>(HttpStatus.OK);
	}

	public void deleteToken(String token){
		boolean flag = userService.deleteToken(token);
	}
}
