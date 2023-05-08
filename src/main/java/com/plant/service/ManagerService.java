package com.plant.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.ManagerMapper;
import com.plant.vo.BestUserVo;
import com.plant.vo.CommentVo;
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
    public PageInfo<UserVo> getUserList(Integer pageNum, Integer pageSize) {
        ArrayList<UserVo> userList = null;
        PageHelper.startPage(pageNum, pageSize);
        try {
            userList = (ArrayList<UserVo>) mapper.getUserList();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        PageInfo<UserVo> pageInfo = new PageInfo<>(userList,10);
        logger.info("[Manager Service] getUserList()");
        return pageInfo;
    }

    /* 전체 게시물 신고 수 정렬 */
    public PageInfo<PostVo> mgmtPostList(Integer pageNum, Integer pageSize) {
        ArrayList<PostVo> postList = null;
        PageHelper.startPage(pageNum, pageSize);
        try {
            postList = (ArrayList<PostVo>) mapper.mgmtPostList();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        PageInfo<PostVo> pageInfo = new PageInfo<>(postList,10);
        logger.info("[Manager Service] mgmtPostList()");
        return pageInfo;
    }

    /* 전체 댓글 신고 수 정렬 */
    public PageInfo<CommentVo> mgmtCommentList(Integer pageNum, Integer pageSize) {
        ArrayList<CommentVo> commentList = null;
        PageHelper.startPage(pageNum, pageSize);
        try {
            commentList = (ArrayList<CommentVo>) mapper.mgmtCommentList();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        PageInfo<CommentVo> pageInfo = new PageInfo<>(commentList,10);
        logger.info("[Manager Service] mgmtCommentList()");
        return pageInfo;
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

    /* 회원 삭제 */
    public boolean deleteUser(String userId) {
        boolean flag = false;

        int affectedCnt = 0;
        this.deleteBestUser(userId);
        try {
            affectedCnt = mapper.deleteUser(userId);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Manager Service] deleteUser(userId)");
        return flag;
    }
}
