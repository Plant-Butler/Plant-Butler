package com.plant.dao;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.vo.BestUserVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;
import com.github.pagehelper.Page;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

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

    public List<PostVo> getCommunityList(Map<String, Object> params);

    Page<PostVo> selsectAll();
}
