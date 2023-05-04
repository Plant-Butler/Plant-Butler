package com.plant.controller;

import com.plant.service.UserService;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URI;

@RestController
@RequestMapping("")
public class UserController {
	
	@Autowired
	private UserService userService;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/* 회원가입 폼 */	
	@GetMapping("/registPage")
	public ModelAndView viewRegist() {
		ModelAndView mv = new ModelAndView("/login/regist");
		logger.info("회원가입 페이지 호출");
		return mv;
	}
	
	/* 회원가입 */	
	@PostMapping("/registPage")
	public ResponseEntity<?> regist(@ModelAttribute("user") UserVo user, HttpServletResponse response) throws IOException {
		System.out.println(user.getUserId());
		System.out.println(user.getPassword());
		boolean flag = userService.regist(user);
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
	public ResponseEntity<String> login(@ModelAttribute UserVo user, HttpSession session) {
		UserVo user1 = userService.validMember(user);
		logger.info("로그인");
		if (user1 != null) {
			session.setAttribute("user", user1);
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
    public ModelAndView cookie(HttpSession session) {
        ModelAndView mv = new ModelAndView("agreement/cookie");
        return mv;
    }
    /* 웹푸시 동의 */
    @GetMapping("/webpush")
    public ModelAndView webpush(HttpSession session) {
        ModelAndView mv = new ModelAndView("agreement/webpush");
        return mv;
    }


}
