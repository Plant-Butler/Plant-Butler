package com.plant.dao;

import com.github.pagehelper.Page;
import com.plant.vo.BestUserVo;
import com.plant.vo.CommentVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Mapper
public interface ManagerMapper {

    ArrayList<UserVo> getUserList() throws SQLException;

    int insertBestUser(String userId) throws SQLException;

    ArrayList<BestUserVo> getBestUser() throws SQLException;

    int deleteBestUser(String userId) throws SQLException;

    int deleteAllBestUser() throws SQLException;

    ArrayList<PostVo> mgmtPostList() throws SQLException;

    ArrayList<CommentVo> mgmtCommentList() throws SQLException;

    int deleteUser(String userId) throws SQLException;

    public List<PostVo> getCommunityList(Map<String, Object> params);

    int getCommentCount(int postId) throws SQLException;

}
