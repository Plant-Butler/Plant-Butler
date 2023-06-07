package com.plant.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.CommentMapper;
import com.plant.dao.DiagnosisMapper;
import com.plant.vo.DiseaseVo;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class DiagnosisService {

    @Autowired
    private DiagnosisMapper diagnosisMapper;
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


}
