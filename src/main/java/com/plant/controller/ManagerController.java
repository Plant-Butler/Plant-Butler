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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

@RestController
@RequestMapping("/manager")
public class ManagerController {

    private final ManagerService managerService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public ManagerController(ManagerService managerService){
        this.managerService = managerService;
    }

    /* 게시물 + 댓글 + 회원 */
    @GetMapping(value=" ")
    public ModelAndView managerist( @RequestParam(defaultValue = "1") int postPage,
                                    @RequestParam(defaultValue = "1") int commentPage,
                                    @RequestParam(defaultValue = "1") int userPage) {
        ModelAndView mv = new ModelAndView("/mypage/manager");

        PageInfo<PostVo> postList = managerService.mgmtPostList(postPage, 15);
        PageInfo<CommentVo> commentList = managerService.mgmtCommentList(commentPage, 15);
        PageInfo<UserVo> userList = managerService.getUserList(userPage, 15);
        mv.addObject("postList", postList);
        mv.addObject("commentList", commentList);
        mv.addObject("userList", userList);

        return mv;
    }

    /* 우수회원 추가 */
    @PostMapping(value="/best-user/{userId}")
    public ResponseEntity<Void> insertBestUser(@RequestParam("userId") String userId) {
        boolean flag = managerService.insertBestUser(userId);

        logger.info("[Manager Controller] insertBestUser()");

        if(flag) {
            return new ResponseEntity<>(HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_ACCEPTABLE);
        }
    }

    /* 우수회원에서 삭제 */
    @DeleteMapping(value="/best-user/{userId}")
    public ResponseEntity<Void> deleteBestUser(@RequestParam("userId") String userId) {
        boolean flag = managerService.deleteBestUser(userId);

        logger.info("[Manager Controller] deleteBestUser()");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    /* 우수회원 초기화 */
    @DeleteMapping(value="/best-user/all")
    public ResponseEntity<Void> deleteAllBestUser() {
        managerService.deleteAllBestUser();
        logger.info("[Manager Controller] deleteAllBestUser()");
        return new ResponseEntity<>(HttpStatus.OK);
    }

    /* 우수회원 광고 */
    @GetMapping(value="/best-list")
    public ResponseEntity<ArrayList<BestUserVo>> selectBestUser() {
        ArrayList<BestUserVo> bestList = managerService.getBestUser();
        logger.info(bestList.toString());
        logger.info("[Manager Controller] selectBestUser()");
        return new ResponseEntity<>(bestList, HttpStatus.OK);
    }

    /* 회원 삭제 */
    @DeleteMapping(value="/{userId}")
    public ResponseEntity<Void> deleteUser(@PathVariable String userId) {
        boolean flag = managerService.deleteUser(userId);

        logger.info("[Manager Controller] deleteUser(userId)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

}
