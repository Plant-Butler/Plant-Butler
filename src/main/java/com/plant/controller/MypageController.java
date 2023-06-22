package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.plant.service.*;
import com.plant.vo.CommentVo;
import com.plant.vo.PlantVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;


@RestController
@RequestMapping("/mypage")
@Api(tags = "마이페이지 API")
public class MypageController {


    private final MypageService mypageService;

    private final ManagerService managerService;

    private final PostService postService;

    private final CommentService commentService;

    private final S3Service s3Service;

    private final PasswordEncoder passwordEncoder;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public MypageController(MypageService mypageService,ManagerService managerService,PostService postService, CommentService commentService,S3Service s3Service, PasswordEncoder passwordEncoder){
        this.mypageService = mypageService;
        this.managerService = managerService;
        this.postService = postService;
        this.commentService = commentService;
        this.s3Service = s3Service;
        this.passwordEncoder = passwordEncoder;
    }

    /* 마이페이지 이동 (로그인 후) */
    @GetMapping(value=" ")
    public ModelAndView openMypage() throws FirebaseMessagingException {
        ModelAndView mv = new ModelAndView("/mypage/mypage");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            UserVo user = (UserVo) authentication.getPrincipal();
            mv.addObject("point", user.getPoint());
            mv.addObject("userId", user.getUserId());
            mv.addObject("nickname", user.getNickname());
        }
        return mv;
    }

    /* 회원정보 수정 페이지 이동 */
    @GetMapping(value="/{userId}")
    public ModelAndView openUpdatePage(@PathVariable String userId) {
        ModelAndView mv = new ModelAndView("/mypage/myUpdate");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()) {
            UserVo user = (UserVo) authentication.getPrincipal();
            mv.addObject("userId", user.getUserId());
            mv.addObject("nickname", user.getNickname());
            mv.addObject("email", user.getEmail());
        }
        return mv;
    }

    /* 회원정보 수정 */
    @PutMapping(value="/{userId}")
    public ResponseEntity<Void> updateMypage(@ModelAttribute UserVo user) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        userVo.setPassword(passwordEncoder.encode(user.getPassword()));
        userVo.setNickname(user.getNickname());
        userVo.setEmail(user.getEmail());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        boolean flag = mypageService.updateMypage(userVo);

        logger.info("[Mypage Controller] updateMypage(user)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }

    }

    /* 내 게시물, 댓글 모아보기 */
    @GetMapping(value="/community/{userId}")
    public ModelAndView myCommunity(@PathVariable String userId,
                                    @RequestParam(defaultValue = "1") int postPage,
                                    @RequestParam(defaultValue = "1") int commentPage) {
        ModelAndView mv = new ModelAndView("/mypage/myCommunity");

        PageInfo<PostVo> postList = mypageService.myPostList(userId, postPage, 10);
        PageInfo<CommentVo> commentList = mypageService.myCommentList(userId, commentPage, 10);
        mv.addObject("postList", postList);
        mv.addObject("commentList", commentList);

        return mv;
    }

    /* 게시물, 댓글 선택삭제 */
    @DeleteMapping(value="/community")
    public ResponseEntity<Boolean> remove(@RequestParam Map<String, String> map) {
        boolean flag = false;

        String list = map.get("idxList");
        ArrayList<String> idxList = new ArrayList<>(Arrays.asList(list.split(",")));
        int num = Integer.parseInt(map.get("num"));

        // 게시물
        if(num == 0) {
            for(String idx : idxList) {
                int postId = Integer.parseInt(idx);
                flag = postService.removeItem(postId);
                if (!flag) {
                    break;
                }
            }
        // 댓글
        } else if (num == 1){
            for(String idx : idxList) {
                int commentId = Integer.parseInt(idx);
                flag = commentService.deleteComment(commentId);
                if (!flag) {
                    break;
                }
            }
        }

        if(flag) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }

    /* 반려식물 추천 서비스 결과 */
    @GetMapping(value="/suggestions/{userId}")
    public ModelAndView myRecom(@PathVariable String userId) {
        ModelAndView mv = new ModelAndView("/mypage/myRecom");

        ArrayList<PlantVo> recomPlantList = mypageService.myRecomList(userId);

        for(PlantVo vo : recomPlantList) {
            String imageUrl = s3Service.getUrlwithFolder("plant-image", vo.getDistbNm());
            vo.setImage(imageUrl);
        }

        mv.addObject("recomPlantList", recomPlantList);

        return mv;
    }

    /* 회원 탈퇴 */
    @DeleteMapping(value="/{userId}")
    public ResponseEntity<Void> deleteUser(@PathVariable String userId) {
        boolean flag = managerService.deleteUser(userId);

        logger.info("[Mypage Controller] deleteUser(userId)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }
}
