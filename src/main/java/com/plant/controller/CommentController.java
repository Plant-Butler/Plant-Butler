package com.plant.controller;

import com.plant.service.CommentService;
import com.plant.vo.CommentVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;


@RestController
@RequestMapping("/community/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 댓글 작성 */
    @PostMapping("")
    public ResponseEntity<?> postComment(@ModelAttribute("CommentVo") CommentVo commentVo) {
        boolean flag = commentService.postComment(commentVo);

        logger.info("[Comment Controller] postComment()");
        HttpHeaders headers = new HttpHeaders();
        if(flag) {
            headers.setLocation(URI.create("./" + commentVo.getPostId()));
            return new ResponseEntity<>(headers, HttpStatus.SEE_OTHER);
        } else {
            return new ResponseEntity<>(headers, HttpStatus.BAD_REQUEST);
        }
    }
}
