package com.plant.controller;

import com.plant.service.MypageService;
import com.plant.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/mypage")
public class MypageController {

    @Autowired
    private MypageService service;

    /* 마이페이지 이동 (로그인 후) */
    @GetMapping(value=" ")
    public ModelAndView openMypage(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/mypage/mypage");
//        HttpSession session = request.getSession();
//        UserVo userVo = (UserVo) session.getAttribute("user");
//        String userId = userVo.getUserId();

        // 테스트용
        String userId = "hao";
        mv.addObject("userId", userId);
        return mv;
    }

    /* 회원정보 수정 페이지 이동 */
    @GetMapping(value="/{userId}")
    public ModelAndView updateMypage(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/mypage/mypage");
        HttpSession session = request.getSession();
        UserVo userVo = (UserVo) session.getAttribute("user");
        String userId = userVo.getUserId();;

        //service.


        return mv;
    }

}
