package com.plant.dao;

import com.plant.vo.ScheduleVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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

    void setSchedule(@Param("myplantId") int myplantId, @Param("scheduleDate") long scheduleDate);

    boolean findSchedule(int myplantId);

    String getToken(String userId);
}
