package com.plant.dao;

import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;

@Mapper
public interface MypageMapper {

    int updateMypage(UserVo user) throws SQLException;
}
