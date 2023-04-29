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

}
