package com.plant.dao;

import com.plant.vo.PlantVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface RecomMapper {

    /* 추천 결과 보기 */
    ArrayList<PlantVo> getResultList(PlantVo plantVo) throws SQLException;

    /* 추천 결과 최초 저장 */
    boolean insertResultPlant(HashMap<String, Object> map) throws SQLException;

    /* 추천 서비스 이용한 적 있는지 조회 */
    int selectRecomCnt(String userId) throws SQLException;

    /* 기존 추천 결과 삭제 */
    int deleteResultList(String userId) throws SQLException;
}
