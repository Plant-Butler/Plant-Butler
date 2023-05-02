package com.plant.dao;

import com.plant.vo.BestUserVo;
import com.plant.vo.CommentVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface ManagerMapper {

    ArrayList<UserVo> getUserList() throws SQLException;

    int insertBestUser(String userId) throws SQLException;

    ArrayList<BestUserVo> getBestUser() throws SQLException;

    int deleteBestUser(String userId) throws SQLException;

    int deleteAllBestUser() throws SQLException;

    ArrayList<PostVo> mgmtPostList() throws SQLException;

    ArrayList<CommentVo> mgmtCommentList() throws SQLException;

    void set0() throws SQLException;
    void set1() throws SQLException;
    int deleteUser(String userId) throws SQLException;
}
