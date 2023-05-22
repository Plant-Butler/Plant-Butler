package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.MainService;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
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
        ModelAndView mv = new ModelAndView("/suggestions/questions");
        return mv;
    }

    /* 커뮤니티 이동 */
    @GetMapping(value="/community")
    public ModelAndView openCommunity(@RequestParam(defaultValue = "1")Integer pageNum, @RequestParam(defaultValue = "15") Integer pageSize,
                                      @RequestParam(required = false) String searchField, @RequestParam(required = false) String keyword,@RequestParam(required = false) String tag) {
        ModelAndView mv = new ModelAndView();
        Map<String, Object> params = new HashMap<>();
        params.put("searchField", searchField);
        params.put("keyword", keyword);
        params.put("tag",tag);
        PageInfo<PostVo> list = mainService.getCommunityList(pageNum , pageSize, params);
        System.out.println(list);
        List<PostVo> postList = list.getList();
        /*댓글수 조회 로직*/
        for (PostVo post : postList) {
            post.setCommentCount(mainService.getCommentCount(post.getPostId()));
        }
        mv.addObject("posts", list);
        mv.setViewName("/community/postList");
        return mv;
    }


}
