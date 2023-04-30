package com.plant.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.service.MainService;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@RestController
public class MainController {

    @Autowired
    private MainService mainService;
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
    public ModelAndView openCommunity(@RequestParam(defaultValue = "1")Integer pageNum, @RequestParam(defaultValue = "15") Integer pageSize,
                                      @RequestParam(required = false) String searchField, @RequestParam(required = false) String keyword) {
        ModelAndView mv = new ModelAndView();
        Map<String, Object> params = new HashMap<>();
        params.put("searchField", searchField);
        params.put("keyword", keyword);
        PageInfo<PostVo> list = mainService.getCommunityList(pageNum , pageSize, params);
        mv.addObject("posts", list);
        System.out.println(list);
        mv.setViewName("community/communityList");
        return mv;
    }
    /* 식물일기 이동 (로그인 후) */
    @GetMapping(value="/diaries")
    public ModelAndView openDiary() {
        ModelAndView mv = new ModelAndView("");
        return mv;
    }


}
