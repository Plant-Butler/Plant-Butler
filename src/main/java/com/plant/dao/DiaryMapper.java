package com.plant.dao;

import com.plant.vo.DiaryVo;
import com.plant.vo.MyplantVo;
import com.plant.vo.ScheduleVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface DiaryMapper {

    /* 전체 식물일기 조회 */
    ArrayList<DiaryVo> selectAllDiary(String userId) throws SQLException;

    /* 식물일기 상세조회 */
    DiaryVo selectDiary(int diaryId) throws SQLException;

    /* 식물일기 상세조회 시 내 식물 */
    ArrayList<MyplantVo> selectMyplants(int diaryId) throws SQLException;

    /* 식물일기 상세조회 시 내 식물 관리기록 */
    ArrayList<ScheduleVo> selectSchedule(int diaryId) throws SQLException;

    /* 식물일기 작성 */
    int insertDiary(DiaryVo diary) throws SQLException;

    /* 식물일기 작성 포인트 */
    void diaryPoint(String userId) throws SQLException;

    /* 식물일기 작성 시 내 식물 첨부 */
    int insertMyplant(@Param("diaryId") int diaryId, @Param("myplantId") int myplantId) throws SQLException;

    /* 내 식물 관리기록 불러오기 */
    ScheduleVo showSchedule(int myplantId) throws SQLException;

    /* 식물일기 수정 */
    int updateDiary(DiaryVo diary) throws SQLException;

    /* 식물일기 삭제 */
    int deleteDiary(int diaryId) throws SQLException;

}
