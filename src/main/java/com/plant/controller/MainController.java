package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.MainService;
import com.plant.service.ManagerService;
import com.plant.service.S3Service;
import com.plant.vo.BestUserVo;
import com.plant.vo.PostVo;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@RestController
@Api(tags = "메인페이지 API")
public class MainController {

    private final MainService mainService;
    private final ManagerService managerService;
    private final S3Service s3Service;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public MainController(MainService mainService, ManagerService managerService, S3Service s3Service) {
        this.mainService = mainService;
        this.managerService = managerService;
        this.s3Service = s3Service;
    }

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

    /* 우수회원 광고 */
    @GetMapping(value="/home/best-list")
    public ResponseEntity<ArrayList<BestUserVo>> selectBestUser() {
        ArrayList<BestUserVo> bestList = managerService.getBestUser();

        for(BestUserVo vo : bestList) {
            String imageList = vo.getMyplantImage();
            if(imageList != null) {
                StringTokenizer images = new StringTokenizer(imageList, ",");
                String imageUrl = null;
                while(images.hasMoreTokens()) {
                    imageUrl = s3Service.getUrl(images.nextToken(), "myplant", vo.getMyplantId());
                    vo.setMyplantImage(imageUrl);
                }
            }
        }

        logger.info("[Manager Controller] selectBestUser()");
        return new ResponseEntity<>(bestList, HttpStatus.OK);
    }


}
