package com.plant.dao;

import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Mapper
public interface PostMapper {

    /* 게시물 상세조회 */
    PostVo postDetail(int postId) throws SQLException;

    /* 내 반려식물 상세정보 */
    ArrayList<MyplantVo> postMyPlantDetail(int postId) throws SQLException;

    /* 상세조회 시 조회수 상승 */
    void upReadCount(int postId) throws SQLException;

    /* 게시물 신고 */
    int declarePost(int postId) throws SQLException;

	boolean insert(PostVo vo) throws SQLException;

	boolean insert2(PostVo post) throws SQLException;

	List<PostVo> all();

	int updateItem(PostVo post) throws SQLException;

	int deleteItem(int postId) throws SQLException;

	List<MyplantVo> plantall(String userId);

	boolean writepoint(PostVo post);

    boolean deleteItemMp(int postId);

    public List<PostVo> getCommunityList(Map<String, Object> params);

    int getCommentCount(int postId) throws SQLException;

    /* 좋아요 눌려있는지 확인 */
    int searchHeart(HashMap<String, Object> map);

    /* 게시물 좋아요 */
    int insertHeart(HashMap<String, Object> map);

    /* 게시물 좋아요 취소 */
    int deleteHeart(HashMap<String, Object> map);

    /* 게시물 좋아요 개수 카운트 */
    int countHeart(int postId);

    /* 게시물 등록 시 이미지, 첨부파일 저장 */
    boolean insertFiles(PostVo post) throws SQLException;
}