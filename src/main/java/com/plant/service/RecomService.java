package com.plant.service;

import com.plant.dao.RecomMapper;
import com.plant.vo.PlantVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

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
}
