package com.plant.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.PostMapper;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Service
public class MainService {

    private final PostMapper postMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public MainService(PostMapper postMapper){
        this.postMapper = postMapper;
    }


    public PageInfo<PostVo> getCommunityList(int pageNum, int pageSize, Map<String, Object> params) {
        PageHelper.startPage(pageNum, pageSize);
        List<PostVo> list = postMapper.getCommunityList(params);
        PageInfo<PostVo> pageInfo = new PageInfo<>(list,10);
        return pageInfo;
    }

    public int getCommentCount(int postId) {
        int postid = 0;
        try {
            postid = postMapper.getCommentCount(postId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return postid;
    }
}