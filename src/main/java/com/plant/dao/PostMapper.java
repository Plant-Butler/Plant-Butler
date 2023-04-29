package com.plant.dao;

import com.plant.vo.PostVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PostMapper {

    /* 게시물 상세조회 */
    PostVo postDetail(int postId);
}
