package com.plant.controller;

import com.plant.service.CommentService;
import com.plant.service.UserService;
import com.plant.vo.CommentVo;
import com.plant.vo.UserVo;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;


@RestController
@RequestMapping("/community/comment")
@Api(tags = "커뮤니티 댓글 API")
public class CommentController {

    private final CommentService commentService;
    private final UserService userService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public CommentController(CommentService commentService, UserService userService) {
        this.commentService = commentService;
        this.userService = userService;
    }

    /* 댓글 작성 */
    @PostMapping("")
    public ResponseEntity<Void> postComment(@ModelAttribute("CommentVo") CommentVo commentVo) {
        boolean flag = commentService.postComment(commentVo);
        int point = commentService.getPoint(commentVo.getUserId());

        // 포인트 Authentication 반영
        UserVo userVo = userService.getUserVo();
        userService.getNewPoint(userVo, userVo.getUserId());

        logger.info("[Comment Controller] postComment()");
        HttpHeaders headers = new HttpHeaders();
        if(flag) {
            headers.setLocation(URI.create("./" + commentVo.getPostId()));
            return new ResponseEntity<>(headers, HttpStatus.SEE_OTHER);
        } else {
            return new ResponseEntity<>(headers, HttpStatus.BAD_REQUEST);
        }
    }

    /* 댓글 수정 */
    @PutMapping("/{commentId}")
    public ResponseEntity<Void> updateComment(@ModelAttribute("CommentVo") CommentVo commentVo) {
        boolean flag = commentService.updateComment(commentVo);

        logger.info("[Comment Controller] updateComment(commentVo)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    /* 댓글 삭제 */
    @DeleteMapping("/{commentId}")
    public ResponseEntity<Void> deleteComment(@PathVariable int commentId) {
        boolean flag = commentService.deleteComment(commentId);

        logger.info("[Comment Controller] deleteComment(commentId)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    /* 댓글 신고 */
    @PatchMapping("/{commentId}")
    public ResponseEntity<Void> declareComment(@PathVariable int commentId) {
        boolean flag = commentService.declareComment(commentId);

        logger.info("[Comment Controller] declareComment(commentId)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

}
