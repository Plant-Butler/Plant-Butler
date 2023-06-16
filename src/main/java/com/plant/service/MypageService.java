package com.plant.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.MypageMapper;
import com.plant.vo.CommentVo;
import com.plant.vo.PlantVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class MypageService {


    private final MypageMapper mypageMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public MypageService(MypageMapper mypageMapper){
        this.mypageMapper = mypageMapper;
    }

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

        logger.info("[Mypage Service] updateComment(commentVo)");
        System.out.println("user = " + user.getPassword());
        System.out.println("affectedCnt = " + affectedCnt);
        System.out.println("flag = " + flag);
        return flag;
    }

    /* 내 게시물 */
    public PageInfo<PostVo> myPostList(String userId, Integer pageNum, Integer pageSize) {
        ArrayList<PostVo> postList = null;
        PageHelper.startPage(pageNum, pageSize);
        try {
            postList = (ArrayList<PostVo>) mypageMapper.myPostList(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        PageInfo<PostVo> pageInfo = new PageInfo<>(postList,10);
        logger.info("[Mypage Service] myPostList()");
        return pageInfo;
    }

    /* 내 댓글 */
    public PageInfo<CommentVo> myCommentList(String userId, Integer pageNum, Integer pageSize) {
        ArrayList<CommentVo> commentList = null;
        PageHelper.startPage(pageNum, pageSize);
        try {
            commentList = (ArrayList<CommentVo>) mypageMapper.myCommentList(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        PageInfo<CommentVo> pageInfo = new PageInfo<>(commentList,10);
        logger.info("[Mypage Service] myCommentList()");
        return pageInfo;
    }

    /* 반려식물 추천 서비스 결과 */
    public ArrayList<PlantVo> myRecomList(String userId) {
        ArrayList<PlantVo> recomPlantList = null;
        try {
            recomPlantList = mypageMapper.myRecomList(userId);
        } catch (SQLException e) {
        }
        return recomPlantList;
    }
}
