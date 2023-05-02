package com.plant.service;

import com.plant.dao.MyPlantMapper;
import com.plant.dao.PostMapper;
import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class PostService {

    @Autowired
    private PostMapper postMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 게시물 상세조회 */
    public PostVo postDetail(int postId) {
        PostVo postVo = null;
        try {
            postVo = postMapper.postDetail(postId);
            // 조회수 상승
            postMapper.upReadCount(postId);
        } catch (SQLException e) {
        }
        logger.info("[Post Service] postDetail()");
        return postVo;
    }

    /* 내 반려식물 상세정보 */
    public ArrayList<MyplantVo> postMyPlantDetail(int postId) {
        ArrayList<MyplantVo> myPlantList = null;
        try {
            myPlantList = postMapper.postMyPlantDetail(postId);
        } catch (SQLException e) {
        }
        logger.info("[Post Service] postMyPlantDetail(postId)");
        return myPlantList;
    }

    /* 게시물 신고 */
    public boolean declarePost(int postId) {
        boolean flag = false;

        int affectedCnt = 0;
        try {
            affectedCnt = postMapper.declarePost(postId);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }

        logger.info("[Comment Service] declareComment(commentId)");
        return flag;
    }
}
