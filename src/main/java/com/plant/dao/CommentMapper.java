package com.plant.dao;

import com.plant.vo.CommentVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface CommentMapper {

    /* 댓글 전체조회 */
    ArrayList<CommentVo> getCommentList(int postId) throws SQLException;
}
