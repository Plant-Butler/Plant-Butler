package com.plant.dao;

import com.plant.vo.CommentVo;
import com.plant.vo.PlantVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface MypageMapper {

    /* 회원정보 수정 */
    int updateMypage(UserVo user) throws SQLException;

    /* 내 게시물 */
    ArrayList<PostVo> myPostList(String userId) throws SQLException;

    /* 내 댓글 */
    ArrayList<CommentVo> myCommentList(String userId) throws SQLException;

    /* 반려식물 추천 서비스 결과 */
    ArrayList<PlantVo> myRecomList(String userId) throws SQLException;
}
