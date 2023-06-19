package com.plant.dao;

import com.plant.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;

@Mapper
public interface UserMapper {
	
	UserVo checkMember(String userId);
	boolean insert(UserVo vo) throws SQLException;
	int duplicateId(String userId);
	int duplicateNick(String nickname);

    boolean saveToken(@Param("token") String token, @Param("userId") String userId);

    String findToken(String token);

	boolean deleteToken(String token);

	/* 갱신된 현재 포인트 */
    int selectPoint(String userId);
}
