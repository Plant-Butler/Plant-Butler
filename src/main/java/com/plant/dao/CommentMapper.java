package com.plant.dao;

import com.plant.vo.CommentVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface CommentMapper {

    /* 댓글 전체조회 */
    ArrayList<CommentVo> getCommentList(int postId) throws SQLException;

    /* 댓글 등록 */
    int postComment(CommentVo commentVo) throws SQLException;

    /* 댓글 등록시 포인트 상승 */
    void commentPoint(String userId) throws SQLException;

    /* 댓글 삭제 */
    int deleteComment(int commentId) throws SQLException;

    /* 댓글 수정 */
    int updateComment(CommentVo commentVo) throws SQLException;

    /* 댓글 신고 */
    int declareComment(int commentId) throws SQLException;
}
