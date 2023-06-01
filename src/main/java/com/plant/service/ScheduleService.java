package com.plant.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.stereotype.Service;

import com.plant.dao.ScheduleMapper;
import com.plant.vo.ScheduleVo;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;

@Service
public class ScheduleService {

    @Autowired
    private ScheduleMapper scheduleMapper;

    public ArrayList<ScheduleVo> getScheduleList(Long myplantId) {
        ArrayList<ScheduleVo> scheduleVos = scheduleMapper.selectScheduleList(myplantId);
        return scheduleVos;
    }

    public boolean registSchedule(ScheduleVo scheduleVo) {
        boolean flag = false;
        flag = scheduleMapper.registSchedule(scheduleVo);
        return flag;
    }

    public boolean deleteSchedule(int scheduleId) {
        boolean flag = false;
        flag = scheduleMapper.deleteSchedule(scheduleId);
            return flag;
        }
    public Timestamp checkWatering(Long myplantId) {
        Timestamp date = scheduleMapper.checkWatering(myplantId);
        return date;
    }


    public Timestamp checkSchedule(Long myplantId) {
        Timestamp date2 = scheduleMapper.checkSchedule(myplantId);
        return date2;
    }

    public ArrayList<ScheduleVo> getScheduleListToUserId(String userId) {
        ArrayList<ScheduleVo> scheduleVos = scheduleMapper.getScheduleListToUserId(userId);
        return scheduleVos;
    }

    public void setSchedule(int myplantId, long scheduleDate) {
        scheduleMapper.setSchedule(myplantId,scheduleDate);
    }


    public boolean findSchedule(int myplantId) {
        boolean flag = scheduleMapper.findSchedule(myplantId);
        return flag;
    }

    public String[] getToken(String userId) {
        String[] token = scheduleMapper.getToken(userId);
        return token;
    }
}
