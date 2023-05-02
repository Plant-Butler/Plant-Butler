package com.plant.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plant.dao.PostMapper;
import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;


@Service
public class PostService {
	private final PostMapper postMapper;
	
    @Autowired
    public PostService(PostMapper commMapper) {
        this.postMapper = commMapper;
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


	/* 게시물 수정 */
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
	    System.out.println(plantList);
	    return plantList;
	}
	/* 모든 게시물 */
	public List<PostVo> getAllPosts() throws SQLException {
		List<PostVo> postList = null;
		postList = postMapper.all();
		return postList;
	}

}
