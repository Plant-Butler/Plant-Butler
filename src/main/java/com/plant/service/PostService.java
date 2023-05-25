package com.plant.service;

import com.plant.dao.PostMapper;
import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;



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

    /* 게시물 저장1 */
	public boolean saveItem(PostVo post) {
		boolean flag = false;
		try {
			flag = postMapper.insert(post);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
    /* 게시물 저장2 */
	public boolean saveItem2(PostVo post) {
		boolean flag = false;
		try {
			flag = postMapper.insert2(post);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}


    public boolean updateItem(PostVo post) throws SQLException {
        boolean flag = false;
        int affectedCnt = 0;
        try {
            affectedCnt = postMapper.updateItem(post);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }

	
	/* 게시물 삭제 */
	public boolean removeItem(int postId) {
		boolean flag = false;
		int affectedCnt = 0;
        try {
            affectedCnt = postMapper.deleteItem(postId);
        } catch (SQLException e) {
        }
        if(affectedCnt > 0) {
            flag = true;
        }
		return flag;
	}
	/* 게시물 작성 포인트 */
	public boolean writepoint(PostVo post) {
		boolean flag = false;
		flag = postMapper.writepoint(post);
		return flag;
	}
	
	/* 게시물 작성 시 내 식물 리스트 보여주기 */
	public List<MyplantVo> plantall(String userId) {
	    List<MyplantVo> plantList = postMapper.plantall(userId);
	    return plantList;
	}
	/* 모든 게시물 */
	public List<PostVo> getAllPosts() throws SQLException {
		List<PostVo> postList = null;
		postList = postMapper.all();
		return postList;
	}

    public boolean removeItemMP(int postId) {
        boolean flag = postMapper.deleteItemMp(postId);
        return flag;
    }

    /* 좋아요 눌려있는지 확인 */
    public int searchHeart(HashMap<String, Object> map) {
        int result = postMapper.searchHeart(map);
        return result;
    }

    /* 게시물 좋아요 */
    public boolean addHeart(HashMap<String, Object> map) {
        boolean flag = false;

        int affectedCnt = 0;
        affectedCnt = postMapper.insertHeart(map);

        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }

    /* 게시물 좋아요 취소 */
    public boolean deleteHeart(HashMap<String, Object> map) {
        boolean flag = false;

        int affectedCnt = 0;
        affectedCnt = postMapper.deleteHeart(map);

        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }

    /* 게시물 좋아요 개수 카운트 */
    public int countHeart(int postId) {
        int hearts = postMapper.countHeart(postId);
        return hearts;
    }
}
