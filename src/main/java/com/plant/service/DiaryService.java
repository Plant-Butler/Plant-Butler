package com.plant.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.DiaryMapper;
import com.plant.vo.DiaryVo;
import com.plant.vo.MyplantVo;
import com.plant.vo.ScheduleVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class DiaryService {


    private final DiaryMapper diaryMapper;

    public DiaryService(DiaryMapper diaryMapper){
        this.diaryMapper = diaryMapper;
    }
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 전체 식물일기 조회 */
    public PageInfo<DiaryVo> getDiaryList(String userId, int pageNum, int pageSize) {
        ArrayList<DiaryVo> diaryList = null;

        PageHelper.startPage(pageNum, pageSize);

        try {
            diaryList = diaryMapper.selectAllDiary(userId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 목록 데이터 로드 실패", e);
        }

        // 첨부된 이미지 여러개일 시 첫번째 이미지만 가져오기
        for(DiaryVo vo: diaryList) {
            String img = vo.getDiaryImage();
            if(img.contains(",")) {
                int idx = img.indexOf(",");
                String firstImg = img.substring(0, idx);
                vo.setDiaryImage(firstImg);
            }
        }

        PageInfo<DiaryVo> pageInfo = new PageInfo<>(diaryList,15);
        return pageInfo;
    }

    /* 식물일기 상세조회 */
    public DiaryVo getDiaryDetail(int diaryId) {
        DiaryVo vo = null;
        try {
            vo = diaryMapper.selectDiary(diaryId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 상세 데이터 로드 실패", e);
        }
        return vo;
    }

    /* 식물일기 상세조회 시 내 식물 */
    public ArrayList<MyplantVo> selectedMyplants(int diaryId) {
        ArrayList<MyplantVo> myPlantList = null;

        try {
            myPlantList = diaryMapper.selectMyplants(diaryId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 내 식물 데이터 로드 실패", e);
        }

        return myPlantList;
    }

    /* 식물일기 상세조회 시 내 식물 관리기록 */
    public ArrayList<ScheduleVo> selectedSchedules(int diaryId) {
        ArrayList<ScheduleVo> scheduleList = null;

        try {
            scheduleList = diaryMapper.selectSchedule(diaryId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 내 식물 관리기록 데이터 로드 실패", e);
        }

        return scheduleList;
    }

    /* 식물일기 작성 + 포인트 */
    public boolean postDiary(DiaryVo diary) {
        boolean flag = false;
        int affectedCnt = 0;

        try {
            affectedCnt = diaryMapper.insertDiary(diary);
            diaryMapper.diaryPoint(diary.getUserId());
        } catch (SQLException e) {
            throw new RuntimeException("일기 데이터 등록 실패", e);
        }

        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }

    /* 식물일기 작성 시 내 식물 첨부 */
    public boolean addMyplant(int diaryId, int myplantId) {
        boolean flag = false;
        int affectedCnt = 0;

        try {
            affectedCnt = diaryMapper.insertMyplant(diaryId, myplantId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 내 식물 데이터 등록 실패", e);
        }

        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }

    /* 식물일기 작성 시 내 식물 관리기록 불러오기 */
    public ScheduleVo getSchedule(int myplantId) {
        ScheduleVo vo = null;
        try {
            vo = diaryMapper.showSchedule(myplantId);
        } catch (SQLException e) {
            throw new RuntimeException("일기 내 관리기록 데이터 로드 실패", e);
        }
        return vo;
    }

    /* 식물일기 수정 */
    public boolean modifyDiary(DiaryVo diary) {
        boolean flag = false;
        int affectedCnt = 0;

        try {
            affectedCnt = diaryMapper.updateDiary(diary);
        } catch (SQLException e) {
            throw new RuntimeException("일기 수정 실패", e);
        }

        if(affectedCnt > 0) {
            flag = true;
        }
        return flag;
    }

    /* 식물일기 삭제 */
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
