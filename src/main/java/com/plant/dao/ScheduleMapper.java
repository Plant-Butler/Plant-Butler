package com.plant.dao;

import com.plant.vo.CommentVo;
import com.plant.vo.ScheduleVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.ArrayList;

@Mapper
public interface ScheduleMapper {


    ArrayList<ScheduleVo> selectScheduleList(Long myplantId);
}
