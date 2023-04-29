package com.plant.dao;

import com.plant.vo.PostVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;

@Mapper
public interface PostMapper {

    /* 게시물 상세조회 */
    PostVo postDetail(int postId) throws SQLException;

    /* 상세조회 시 조회수 상승 */
    void upReadCount(int postId) throws SQLException;
}
