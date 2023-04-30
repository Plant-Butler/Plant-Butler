package com.plant.service;

import com.plant.dao.CommentMapper;
import com.plant.dao.PostMapper;
import com.plant.vo.CommentVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class CommentService {

    @Autowired
    private CommentMapper commentMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 댓글 전체조회 */
    public ArrayList<CommentVo> getCommentList(int postId) {
        ArrayList<CommentVo> commentList = null;
        try {
            commentList = commentMapper.getCommentList(postId);
        } catch (SQLException e) {
        }
        return commentList;
    }

    /* 댓글 작성 + 포인트 */
    public boolean postComment(CommentVo commentVo) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = commentMapper.postComment(commentVo);
            commentMapper.commentPoint(commentVo.getUserId());
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Comment Service] postComment()");
        return flag;
    }

    /* 댓글 삭제 */
    public boolean deleteComment(int commentId) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = commentMapper.deleteComment(commentId);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Comment Service] deleteComment(commentId)");
        return flag;
    }

    /* 댓글 수정 */
    public boolean updateComment(CommentVo commentVo) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = commentMapper.updateComment(commentVo);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Comment Service] updateComment(commentVo)");
        return flag;
    }
}
