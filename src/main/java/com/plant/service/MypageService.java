package com.plant.service;

import com.plant.dao.MypageMapper;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

@Service
public class MypageService {

    @Autowired
    private MypageMapper mypageMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 회원정보 수정 */
    public boolean updateMypage(UserVo user) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = mypageMapper.updateMypage(user);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Comment Service] updateComment(commentVo)");
        System.out.println("user = " + user.getPassword());
        System.out.println("affectedCnt = " + affectedCnt);
        System.out.println("flag = " + flag);
        return flag;
    }
}
