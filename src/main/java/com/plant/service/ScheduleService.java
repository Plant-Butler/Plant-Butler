package com.plant.service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.plant.dao.ManagerMapper;
import com.plant.dao.ScheduleMapper;
import com.plant.vo.PostVo;
import com.plant.vo.ScheduleVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
@Service
public class ScheduleService {
    @Autowired
    private ScheduleMapper scheduleMapper;

    public ArrayList<ScheduleVo> getScheduleList(Long myplantId) {
        ArrayList<ScheduleVo> scheduleVos = scheduleMapper.selectScheduleList(myplantId);
        return scheduleVos;
    }
}
