package com.plant.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.plant.vo.UserVo;

@Mapper
public interface UserMapper {
	
	UserVo checkMember(UserVo user);
	boolean insert(UserVo vo) throws SQLException;
	int duplicateId(String userId);
	int duplicateNick(String nickname);

}
