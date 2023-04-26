package com.plant.service;

import com.plant.dao.ManagerMapper;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class ManagerService {

    @Autowired
    private ManagerMapper mapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 전체 회원 조회 */
    public ArrayList<UserVo> getUserList() {
        ArrayList<UserVo> userList = null;

        try {
            userList = (ArrayList<UserVo>) mapper.getUserList();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        logger.info("[Manager Service] getUserList()");
        return userList;
    }

    /* 우수회원 추가 */
    public boolean selectBestUser(String userId) {
        boolean flag = false;

        int affectedCnt = mapper.selectBestUser(userId);
        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }
}
