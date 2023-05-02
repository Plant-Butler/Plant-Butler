package com.plant.dao;

import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface PostMapper {

    /* 게시물 상세조회 */
    PostVo postDetail(int postId) throws SQLException;

    /* 내 반려식물 상세정보 */
    ArrayList<MyplantVo> postMyPlantDetail(int postId) throws SQLException;

    /* 상세조회 시 조회수 상승 */
    void upReadCount(int postId) throws SQLException;

    /* 게시물 신고 */
    int declarePost(int postId) throws SQLException;
}
