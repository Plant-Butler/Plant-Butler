package com.plant.controller;

import com.plant.service.ManagerService;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.net.URI;
import java.util.ArrayList;

@RestController
@RequestMapping("/manager")
public class ManagerController {

    @Autowired
    private ManagerService service;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 전체 회원 목록 */
    @GetMapping(value=" ")
    public ModelAndView getUserList() {
        ModelAndView mv = new ModelAndView("/mypage/manager");
        ArrayList<UserVo> userList = service.getUserList();
        mv.addObject("userList", userList);

        logger.info("[Manager Controller] getUserList()");
        return mv;
    }

    /* 우수회원 추가 */
    @PostMapping(value="/best-user/{userId}")
    public ResponseEntity<?> selectBestUser(@RequestParam("userId") String userId) {
        boolean flag = service.selectBestUser(userId);

        logger.info("[Manager Controller] selectBestUser()");
        HttpHeaders headers = new HttpHeaders();

        if(flag) {
            headers.setLocation(URI.create("/manager"));
            return new ResponseEntity<>(headers, HttpStatus.MOVED_PERMANENTLY);
        } else {
            return new ResponseEntity<>(headers, HttpStatus.BAD_REQUEST);
        }
    }

    /* 우수회원 삭제 */
    @DeleteMapping(value="{userId}")
    public ResponseEntity<?> deleteBestUser(@RequestParam("userId") String userId) {
        // service.

        logger.info("[Manager Controller] deleteBestUser()");
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(URI.create("/manager"));
        return new ResponseEntity<>(headers, HttpStatus.OK);
    }


}
