package com.plant.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.CommentMapper;
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
    public PageInfo<CommentVo>  getCommentList(int postId, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        ArrayList<CommentVo> commentList = null;
        try {
            commentList = commentMapper.getCommentList(postId);
        } catch (SQLException e) {
        }

        PageInfo<CommentVo> pageInfo = new PageInfo<>(commentList,10);
        return pageInfo;
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

    /* 포인트 갱신 */
    public int getPoint(String userId) {
        int point = 0;

        try {
            point = commentMapper.getPoint(userId);
        } catch (SQLException e) {
        }

        return point;
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

    /* 댓글 신고 */
    public boolean declareComment(int commentId) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = commentMapper.declareComment(commentId);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Comment Service] declareComment(commentId)");
        return flag;
    }

}
