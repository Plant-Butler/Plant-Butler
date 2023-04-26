package com.plant.dao;

import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface ManagerMapper {

    ArrayList<UserVo> getUserList() throws SQLException;

    int selectBestUser(String userId);

}
