package com.plant.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
@Mapper
public interface PostMapper {
	
	boolean insert(PostVo vo) throws SQLException;
	boolean insert2(PostVo post) throws SQLException;
	List<PostVo> all();
	int updateItem(PostVo post) throws SQLException;
	int deleteItem(int postId) throws SQLException;
	List<MyplantVo> plantall(String userId);
	boolean writepoint(PostVo post);
	
}