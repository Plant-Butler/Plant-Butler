package com.plant.dao;

import com.plant.vo.PlantVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface RecomMapper {

    /* 추천 결과 보기 */
    ArrayList<PlantVo> getResultList(PlantVo plantVo) throws SQLException;
}
