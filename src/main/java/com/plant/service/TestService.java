package com.plant.service;

import java.sql.SQLException;
import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plant.dao.TestDao;
import com.plant.vo.TestVo;


@Service
public class TestService {
	
	@Autowired 
	private TestDao testDao;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	/* 전체 게시물 목록 */
	public ArrayList<TestVo> boardList() {
		ArrayList<TestVo> boardList = null;
		
		try {
			boardList = (ArrayList<TestVo>) testDao.findAll();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return boardList;
	}
	
	/* 게시글 작성 */
	public void write(TestVo vo) {
		logger.info("write 테스트 서비스 호출");
		testDao.write(vo);
	}

}
