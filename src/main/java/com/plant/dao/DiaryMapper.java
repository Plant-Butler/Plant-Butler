package com.plant.dao;

import com.plant.vo.DiaryVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface DiaryMapper {

    /* 전체 일기 조회*/
    ArrayList<DiaryVo> selectAllDiary(String userId) throws SQLException;

    /* 일기 상세조회 */
    DiaryVo selectDiary(int diaryId) throws SQLException;

    /* 일기 삭제 */
    int deleteDiary(int diaryId) throws SQLException;
}
