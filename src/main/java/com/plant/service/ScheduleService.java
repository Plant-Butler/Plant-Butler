package com.plant.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.plant.dao.ScheduleMapper;
import com.plant.vo.ScheduleVo;
@Service
public class ScheduleService {
    @Autowired
    private ScheduleMapper scheduleMapper;

    public ArrayList<ScheduleVo> getScheduleList(Long myplantId) {
        ArrayList<ScheduleVo> scheduleVos = scheduleMapper.selectScheduleList(myplantId);
        return scheduleVos;
    }
}
