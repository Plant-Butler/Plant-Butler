package com.plant.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.plant.vo.UserVo;

@Mapper
public interface MemberMapper {
	
	UserVo selectMember(String userId, String password);
	boolean insert(UserVo vo) throws SQLException;
	int duplicateId(String userId);


}
