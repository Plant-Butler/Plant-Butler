package com.plant.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.plant.service.TestService;
import com.plant.vo.TestVo;

@RestController
@RequestMapping("/test")
// 테스트용
public class TestController {
	
	@Autowired
	private TestService testService;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping(value="/test")
	public String index() {
		return "test";
	}
	
	/* 전체 게시물 목록 */
	@GetMapping(value="/all")
	public ModelAndView readAll() {
		ModelAndView mv = new ModelAndView("test");
		ArrayList<TestVo> testList = testService.boardList();
		mv.addObject("testList", testList);
		
		return mv;
	}
	
	/* 게시글 작성폼 */
	@GetMapping(value=" ")
	public ModelAndView writeForm() {
		ModelAndView mv = new ModelAndView("test2");
		
		return mv;
	}
	
	/* 게시글 작성 */
	@PostMapping(value=" ")
	public void write(TestVo vo) {
		testService.write(vo);
		
		logger.info("write 테스트 컨트롤러 호출");
		System.out.println(vo.toString());
		
	}

}
