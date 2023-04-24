package com.plant.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.plant.vo.TestVo;

@Repository
@Mapper
public class TestDao {
	
	@Autowired
	private SqlSession sqlSession;	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public List<TestVo> findAll() throws SQLException{
		List<TestVo> list = new ArrayList<>();
		
		// TestMapper.xml 파일에서 명시
		list = sqlSession.selectList("mapper.test.selectBoardList");
		return list;
	}

	public void write(TestVo vo) {
		logger.info("write 테스트 DAO 호출");
		sqlSession.insert("mapper.test.write");
	}

}
