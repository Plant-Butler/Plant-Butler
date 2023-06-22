package com.plant.dao;

import com.plant.vo.DiseaseVo;
import com.plant.vo.PestVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;

@Mapper
public interface DiagnosisMapper {

    /* 질병 조건 조회 */
    DiseaseVo diseaseDetail(String predictedClass) throws SQLException;
    PestVo pestDetail(String predictedClass) throws SQLException;

}
