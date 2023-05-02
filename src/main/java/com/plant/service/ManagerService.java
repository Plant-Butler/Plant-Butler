package com.plant.service;

import com.plant.dao.ManagerMapper;
import com.plant.vo.BestUserVo;
import com.plant.vo.PostVo;
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
    public boolean insertBestUser(String userId) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = mapper.insertBestUser(userId);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }

    /* 우수회원 광고 */
    public ArrayList<BestUserVo> getBestUser() {
        ArrayList<BestUserVo> bestList = null;

        try {
            bestList = mapper.getBestUser();
        } catch (SQLException e) {
        }
        logger.info(bestList.toString());
        logger.info("[Manager Service] getBestUser()");
        return bestList;
    }

    /* 우수회원에서 삭제 */
    public boolean deleteBestUser(String userId) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = mapper.deleteBestUser(userId);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Manager Service] deleteBestUser(userId)");
        return flag;
    }

    /* 우수회원 초기화 */
    public void deleteAllBestUser() {
        try {
            mapper.deleteAllBestUser();
        } catch (SQLException e) {}
        logger.info("[Manager Service] deleteAllBestUser()");
    }

    /* 전체 게시물 신고 수 정렬 */
    public ArrayList<PostVo> mgmtPostList() {
        ArrayList<PostVo> postList = null;

        try {
            postList = (ArrayList<PostVo>) mapper.mgmtPostList();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        logger.info("[Manager Service] getPostList()");
        return postList;
    }
}
