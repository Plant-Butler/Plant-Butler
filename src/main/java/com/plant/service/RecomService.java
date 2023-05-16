package com.plant.service;

import com.plant.dao.RecomMapper;
import com.plant.vo.PlantVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class RecomService {

    @Autowired
    private RecomMapper recomMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 추천 결과 보기 */
    public ArrayList<PlantVo> getResultList (PlantVo plantVo) {
        ArrayList<PlantVo> resultList = null;
        try {
            resultList = recomMapper.getResultList(plantVo);
        } catch (SQLException e) {}
        return resultList;
    }

    /* 추천 결과 최초 저장 */
    public boolean saveResultList(HashMap<String, Object> map) {
        boolean flag = false;
        try {
            flag = recomMapper.insertResultPlant(map);
        } catch (SQLException e) {}

        logger.info("[RecomController Service] saveResultList()");
        return flag;
    }

    /* 추천 서비스 이용한 적 있는지 조회 */
    public int getRecomCnt(String userId) {
        int count = 0;
        try {
            count = recomMapper.selectRecomCnt(userId);
        } catch (SQLException e) {}
        return count;
    }

    /* 기존 추천 결과 삭제 */
    public boolean deleteOriginal(String userId) {
        boolean flag = false;
        int affectedCnt = 0;

        try {
            affectedCnt = recomMapper.deleteResultList(userId);
        } catch (SQLException e) {}


        if(affectedCnt > 0) {
            flag = true;
        }

        return flag;
    }
}
