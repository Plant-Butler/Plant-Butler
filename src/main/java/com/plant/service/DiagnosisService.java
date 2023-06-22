package com.plant.service;

import com.plant.dao.DiagnosisMapper;
import com.plant.vo.DiseaseVo;
import com.plant.vo.PestVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.sql.SQLException;

@Service
public class DiagnosisService {


    private final DiagnosisMapper diagnosisMapper;

    public DiagnosisService(DiagnosisMapper diagnosisMapper){
        this.diagnosisMapper = diagnosisMapper;
    }
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 질병 상세조회 */
    public DiseaseVo diseaseInfo(String predictedClass) {
        DiseaseVo diseaseVo = null;
        try {
            diseaseVo = diagnosisMapper.diseaseDetail(predictedClass);
        } catch (SQLException e) {

        }
        return diseaseVo;
    }

    /* 해충 상세조회 */
    public PestVo pestInfo(String predictedClass) {
        PestVo pestVo = null;
        try {
            pestVo = diagnosisMapper.pestDetail(predictedClass);
        } catch (SQLException e) {

        }
        return pestVo;
    }

}
