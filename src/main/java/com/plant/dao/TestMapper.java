package com.plant.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.plant.vo.TestVo;

@Mapper
public interface TestMapper {

	List<TestVo> selectBoardList() throws SQLException;

	void write(TestVo vo) throws SQLException;

}
