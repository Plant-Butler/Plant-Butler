package com.plant.dao;

import java.sql.SQLException;

import org.apache.ibatis.annotations.Mapper;

import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UserMapper {
	
	UserVo checkMember(String userId);
	boolean insert(UserVo vo) throws SQLException;
	int duplicateId(String userId);
	int duplicateNick(String nickname);

    boolean saveToken(@Param("token") String token, @Param("userId") String userId);

    String findToken(String token);

	boolean deleteToken(String token);
}
