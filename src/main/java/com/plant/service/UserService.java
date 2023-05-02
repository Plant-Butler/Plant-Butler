package com.plant.service;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plant.dao.UserMapper;
import com.plant.vo.UserVo;

@Service
public class UserService {
    private final UserMapper userMapper;

    @Autowired
    public UserService(UserMapper memberMapper) {
        this.userMapper = memberMapper;
    }
	
	/* Register */
	public boolean regist(UserVo user) {
		boolean flag = false;
		try {
			flag = userMapper.insert(user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public UserVo validMember(UserVo user) throws SQLException {
		boolean flag = false;
		UserVo vo = userMapper.checkMember(user);
		System.out.println("I'm in service");
		return vo;
	}
	
	public int duplicateId(String userId) {
		int cnt = userMapper.duplicateId(userId);
		return cnt;
	}
	
	public int duplicateNick(String nickname) {
		int cnt = userMapper.duplicateNick(nickname);
		return cnt;
	}
	
}

	
	