package com.plant.service;

import com.plant.dao.MyPlantMapper;
import com.plant.dao.PostMapper;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

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


}
