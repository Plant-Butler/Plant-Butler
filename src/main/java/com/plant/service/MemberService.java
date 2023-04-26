package com.plant.service;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plant.dao.MemberMapper;
import com.plant.vo.UserVo;

@Service
public class MemberService {
    private final MemberMapper memberMapper;

    @Autowired
    public MemberService(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }
	
	/* Register */
	public boolean regist(UserVo user) {
		boolean flag = false;
		try {
			flag = memberMapper.insert(user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public UserVo isMember(String userId, String password) throws SQLException {
		boolean flag = false;
		UserVo user = null;
		user = memberMapper.selectMember(userId, password);
		return user;
	}
	
	public int duplicateId(String userId) {
		int cnt = memberMapper.duplicateId(userId);
		return cnt;
	}
}
	