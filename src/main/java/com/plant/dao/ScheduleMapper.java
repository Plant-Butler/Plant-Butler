package com.plant.dao;

import com.plant.vo.CommentVo;
import com.plant.vo.ScheduleVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

@Mapper
public interface ScheduleMapper {


    ArrayList<ScheduleVo> selectScheduleList(Long myplantId);

    boolean registSchedule(ScheduleVo scheduleVo);

    boolean deleteSchedule(int scheduleId);

    Timestamp checkWatering(Long myplantId);


    Timestamp checkSchedule(Long myplantId);

    ArrayList<ScheduleVo> getScheduleListToUserId(String userId);

    void setSchedule(int myplantId, long scheduleDate);
}
