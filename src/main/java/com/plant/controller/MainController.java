package com.plant.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class MainController {

//    @Autowired
//    private ;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 메인페이지 */
    @GetMapping(value="/home")
    public ModelAndView main() {
        ModelAndView mv = new ModelAndView("/main/main");
        return mv;
    }

    /* 나에게 맞는 식물 이동 */
    @GetMapping(value="/suggestions")
    public ModelAndView openSuggestions() {
        ModelAndView mv = new ModelAndView("/suggestions/suggestions");
        return mv;
    }

    /* 커뮤니티 이동 */
    @GetMapping(value="/community")
    public ModelAndView openCommunity() {
        ModelAndView mv = new ModelAndView("");
        return mv;
    }

    /* 식물일기 이동 (로그인 후) */
    @GetMapping(value="/diaries")
    public ModelAndView openDiary() {
        ModelAndView mv = new ModelAndView("");
        return mv;
    }


}
