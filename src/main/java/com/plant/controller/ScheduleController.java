package com.plant.controller;

import com.plant.service.ScheduleService;
import com.plant.vo.ScheduleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

@RestController
@RequestMapping("/myplants/{myplantId}/schedule")
public class ScheduleController {
    @Autowired
    private ScheduleService scheduleService;

    @GetMapping("")
    public ModelAndView myPlantSchedule(@PathVariable Long myplantId){
        ModelAndView model = new ModelAndView();
        ArrayList<ScheduleVo> scheduleVos = scheduleService.getScheduleList(myplantId);
        model.addObject("schedulelist",scheduleVos);
        model.setViewName("schedule/myPlantSchedule");
        return model;
    }

    @GetMapping("/form")
    public ModelAndView getScheduleRegistForm(@PathVariable Long myplantId){
        ModelAndView model = new ModelAndView();
        model.setViewName("schedule/registSchedule");
        return model;

    }
}
