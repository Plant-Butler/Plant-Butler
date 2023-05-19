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
import java.util.Map;

@Service
public class RecomService {

    @Autowired
    private RecomMapper recomMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 추천 결과 보기 */
    public ArrayList<PlantVo> getResultList (PlantVo plantVo) {
        ArrayList<PlantVo> resultList = null;
        try {
            resultList = recomMapper.selectResultList(plantVo);
        } catch (SQLException e) { throw new RuntimeException(e); }
        return resultList;
    }

    /* 추천 결과 최초 저장 */
    public boolean saveResultList(HashMap<String, Object> map) {
        boolean flag = false;
        try {
            flag = recomMapper.insertResultPlant(map);
        } catch (SQLException e) { throw new RuntimeException(e); }

        logger.info("[RecomController Service] saveResultList()");
        return flag;
    }

    /* 추천 서비스 이용한 적 있는지 조회 */
    public int getRecomCnt(String userId) {
        int count = 0;
        try {
            count = recomMapper.selectRecomCnt(userId);
        } catch (SQLException e) { throw new RuntimeException(e); }
        return count;
    }

    /* 기존 추천 결과 삭제 */
    public boolean deleteOriginal(String userId) {
        boolean flag = false;
        int affectedCnt = 0;

        try {
            affectedCnt = recomMapper.deleteResultList(userId);
        } catch (SQLException e) { throw new RuntimeException(e); }


        if(affectedCnt > 0) {
            flag = true;
        }

        return flag;
    }

    /* 추천 식물 상세정보 */
    public PlantVo getPlantDetail(int plantId) {
        PlantVo vo = null;

        try {
            vo = recomMapper.selectPlantDetail(plantId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return vo;
    }

    /* 추천 식물 화분 크기 계산 */
    public Map<String, Integer> calcPot(int plantId) {
        Map<String, Integer> potMap = new HashMap<>();
        PlantVo vo = this.getPlantDetail(plantId);

        String hg =  vo.getGrowthHgInfo();
        String ara = vo.getGrowthAraInfo();

        int idealHg = 0;
        int idealAra = 0;

        if (hg != null && ara != null) {
            idealHg = Integer.parseInt(hg) / 3;
            idealAra = Integer.parseInt(ara) + 5;
        }

        potMap.put("idealHg", idealHg);
        potMap.put("idealAra", idealAra);

        return potMap;
    }
}
