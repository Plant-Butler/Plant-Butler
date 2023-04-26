package com.plant.controller;

import java.io.IOException;
import java.net.URI;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.plant.service.MemberService;
import com.plant.vo.UserVo;

@RestController
@RequestMapping("")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	/* 회원가입 폼 */	
	@GetMapping("/registPage")
	public ModelAndView viewRegist() {
		ModelAndView mv = new ModelAndView("/login/regist");
		logger.info("회원가입 페이지 호출");
		return mv;
	}
	
	/* 회원가입 */	
	@PostMapping("/regist")
	public ResponseEntity<?> regist(@ModelAttribute("user") UserVo user, HttpServletResponse response) throws IOException {
		System.out.println(user.getUserId());
		System.out.println(user.getPassword());
		boolean flag = memberService.regist(user);
		logger.info("회원가입");
	    if (flag) {
	        URI location = ServletUriComponentsBuilder.fromCurrentContextPath().path("/login").build().toUri();
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

//	/* 로그인 */
//	@PostMapping("/loginPage")
//	public ResponseEntity<String> login(@RequestParam("userId") String userId, @RequestParam("password") String password, 
//		HttpSession session,
//		RedirectAttributes redirectAttributes) throws SQLException {
//		UserVo user = memberService.isMember(userId, password);
//		logger.info("로그인");
//		if (user != null) {
//			session.setAttribute("userId", user);
//			redirectAttributes.addFlashAttribute("successMessage", "로그인에 성공했습니다.");
//			return ResponseEntity.status(HttpStatus.OK).body("로그인에 성공했습니다.");
//		} 
//
//		redirectAttributes.addFlashAttribute("errorMessage", "로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
//		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
//
//	}
//	@PostMapping("/loginPage")
//	public ResponseEntity<String> login(@RequestParam("userId") String userId, @RequestParam("password") String password, 
//		HttpSession session,
//		RedirectAttributes redirectAttributes) throws SQLException {
//		UserVo user = memberService.isMember(userId, password);
//		logger.info("로그인");
//		if (user != null) {
//			session.setAttribute("userId", user);
//			redirectAttributes.addFlashAttribute("successMessage", "로그인에 성공했습니다.");
//			URI location = ServletUriComponentsBuilder.fromCurrentContextPath()
//				.path("/home.jsp")
//				.build()
//				.toUri();
//			return ResponseEntity.status(HttpStatus.FOUND)
//				.location(location)
//				.build();
//		} 
//		redirectAttributes.addFlashAttribute("errorMessage", "로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
//		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
//	}
	@PostMapping("/loginPage")
	public ResponseEntity<String> login(@RequestParam("userId") String userId, @RequestParam("password") String password, 
		HttpSession session,
		RedirectAttributes redirectAttributes) throws SQLException {
		UserVo user = memberService.isMember(userId, password);
		logger.info("로그인");
		if (user != null) {
			session.setAttribute("userId", user);
			redirectAttributes.addFlashAttribute("successMessage", "로그인에 성공했습니다.");
			URI location = ServletUriComponentsBuilder.fromCurrentContextPath()
				.path("/home")
				.build()
				.toUri();
			return ResponseEntity.status(HttpStatus.FOUND)
				.location(location)
				.build();
		} 
		redirectAttributes.addFlashAttribute("errorMessage", "로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인에 실패했습니다. 아이디 또는 비밀번호를 확인하세요.");
	}
    /* 메인페이지 */
    @GetMapping(value="/home")
    public ModelAndView main() {
        ModelAndView mv = new ModelAndView("/home");
        return mv;
    }


	/* 로그아웃 */
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		ModelAndView mv = new ModelAndView("/home");
		session.invalidate();
		return mv;
	}
	
	@GetMapping("/idCheckForm")
	public ModelAndView idCheckForm() {
		ModelAndView mv = new ModelAndView("/login/idCheckForm");
		return mv;
	}
	
	@PostMapping("/idCheckProc")
	public ModelAndView idCheckProc(@RequestParam("id") String id) {
	    ModelAndView mv = new ModelAndView("/login/idCheckProc");
	    int cnt = memberService.duplicateId(id);
	    mv.addObject("cnt", cnt);
	    mv.addObject("id", id);
	    return mv;
	}

	
	
//	/* 전체 게시물 목록 */
//	@GetMapping(value="/all")
//	public ModelAndView readAll() {
//		ModelAndView mv = new ModelAndView("test");
//		ArrayList<TestVo> testList = testService.boardList();
//		mv.addObject("testList", testList);
//
//		return mv;
//	}
//	
//	/* 게시글 작성 */
//	@PostMapping(value=" ")
//	public ResponseEntity<?> write(TestVo vo) {
//		testService.write(vo);
//		logger.info("write 테스트 컨트롤러 호출");
//		HttpHeaders headers = new HttpHeaders();
//		headers.setLocation(URI.create("test/all"));
//		return new ResponseEntity<>(headers, HttpStatus.MOVED_PERMANENTLY);
//	}



}
