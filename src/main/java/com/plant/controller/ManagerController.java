package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.ManagerService;
import com.plant.vo.BestUserVo;
import com.plant.vo.CommentVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

@RestController
@RequestMapping("/manager")
public class ManagerController {

    @Autowired
    private ManagerService service;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 게시물 + 댓글 + 회원 */
    @GetMapping(value=" ")
    public ModelAndView managerist( @RequestParam(defaultValue = "1") int postPage,
                                    @RequestParam(defaultValue = "1") int commentPage,
                                    @RequestParam(defaultValue = "1") int userPage) {
        ModelAndView mv = new ModelAndView("/mypage/manager");
        //ArrayList<UserVo> userList = service.getUserList();

        PageInfo<PostVo> postList = service.mgmtPostList(postPage, 10);
        PageInfo<CommentVo> commentList = service.mgmtCommentList(commentPage, 10);
        PageInfo<UserVo> userList = service.getUserList(userPage, 10);
        mv.addObject("postList", postList);
        mv.addObject("commentList", commentList);
        mv.addObject("userList", userList);

        return mv;
    }

    /* 우수회원 추가 */
    @PostMapping(value="/best-user/{userId}")
    public ResponseEntity<?> insertBestUser(@RequestParam("userId") String userId) {
        boolean flag = service.insertBestUser(userId);

        logger.info("[Manager Controller] insertBestUser()");
        HttpHeaders headers = new HttpHeaders();

        if(flag) {
            //headers.setLocation(URI.create("/manager"));
            return new ResponseEntity<>(headers, HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>(headers, HttpStatus.NOT_ACCEPTABLE);
        }
    }

    /* 우수회원에서 삭제 */
    @DeleteMapping(value="/best-user/{userId}")
    public ResponseEntity<?> deleteBestUser(@RequestParam("userId") String userId) {
        boolean flag = service.deleteBestUser(userId);

        logger.info("[Manager Controller] deleteBestUser()");
        HttpHeaders headers = new HttpHeaders();
        if(flag) {
            //headers.setLocation(URI.create("/manager"));
            return new ResponseEntity<>(headers, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(headers, HttpStatus.BAD_REQUEST);
        }
    }

    /* 우수회원 초기화 */
    @DeleteMapping(value="/best-user/all")
    public ResponseEntity<?> deleteAllBestUser() {
        service.deleteAllBestUser();
        logger.info("[Manager Controller] deleteAllBestUser()");
        HttpHeaders headers = new HttpHeaders();
        //headers.setLocation(URI.create("/manager"));
        return new ResponseEntity<>(headers, HttpStatus.OK);
    }

    /* 우수회원 광고 */
    @GetMapping(value="/best-list")
    public ResponseEntity<ArrayList<BestUserVo>> selectBestUser() {
        ArrayList<BestUserVo> bestList = service.getBestUser();
        logger.info(bestList.toString());
        logger.info("[Manager Controller] selectBestUser()");
        return new ResponseEntity<>(bestList, HttpStatus.OK);
    }

    /* 회원 삭제 */
    @DeleteMapping(value="/{userId}")
    public ResponseEntity<Void> deleteUser(@PathVariable String userId) {
        boolean flag = service.deleteUser(userId);

        logger.info("[Manager Controller] deleteUser(userId)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

}
