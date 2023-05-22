package com.plant.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.DiaryMapper;
import com.plant.vo.DiaryVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class DiaryService {

    @Autowired
    private DiaryMapper diaryMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 전체 일기 조회 */
    public PageInfo<DiaryVo> getDiaryList(String userId, int pageNum, int pageSize) {
        ArrayList<DiaryVo> diaryList = null;

        PageHelper.startPage(pageNum, pageSize);

        try {
            diaryList = diaryMapper.selectAllDiary(userId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 목록 데이터 로드 실패", e);
        }

        PageInfo<DiaryVo> pageInfo = new PageInfo<>(diaryList,15);
        return pageInfo;
    }

    /* 일기 상세조회 */
    public DiaryVo getDiaryDetail(int diaryId) {
        DiaryVo vo = null;
        try {
            vo = diaryMapper.selectDiary(diaryId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 상세 데이터 로드 실패", e);
        }
        return vo;
    }

    /* 일기 삭제 */
    public boolean removeDiary(int diaryId) {
        boolean flag = false;
        int affectedCnt = 0;

        try {
            affectedCnt = diaryMapper.deleteDiary(diaryId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 삭제 실패", e);
        }

        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }
}
