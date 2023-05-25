package com.plant.controller;

import com.plant.service.MyPlantService;
import com.plant.service.ScheduleService;
import com.plant.service.webpushService;
import com.plant.vo.MyplantVo;
import com.plant.vo.PlantVo;
import com.plant.vo.ScheduleVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.net.URI;
import java.net.http.HttpResponse;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

@RestController
@RequestMapping("/myplants/{myplantId}/schedule")
public class ScheduleController {
    @Autowired
    private ScheduleService scheduleService;
    @Autowired
    private MyPlantService myPlantService;

    @Autowired
    private webpushService webpush;

    @GetMapping("")
    public ModelAndView myPlantSchedule(@PathVariable Long myplantId){
        ModelAndView model = new ModelAndView();
        ArrayList<ScheduleVo> scheduleVos = scheduleService.getScheduleList(myplantId);
        MyplantVo myplant1 = myPlantService.myPlantDetail(myplantId.intValue());

        PlantVo plantVo = myPlantService.searchPlantToNum(myplant1.getPlantId());
        Timestamp date = scheduleService.checkWatering(myplantId);
        System.out.println(date);
        double water1 = 0;
        if(date==null){
            date = new Timestamp(myplant1.getFirstDate().getTime());
        }
        Timestamp date2 = scheduleService.checkSchedule(myplantId);
        if(date2==null){
            date2 = new Timestamp(myplant1.getFirstDate().getTime());
        }
        if(myplant1.getMyplantPot()==1){
        double water = (1.0/12.0) * Math.PI * myplant1.getMyplantLength() * (Math.pow(myplant1.getMyplantRadius1() / 2.0, 2) + (myplant1.getMyplantRadius1() / 2.0) * (myplant1.getMyplantRadius2() / 2.0) + Math.pow(myplant1.getMyplantRadius2() / 2.0, 2));
        water1 = water/1000;}
        else if(myplant1.getMyplantPot()==2){
            double water =(myplant1.getMyplantRadius2() * myplant1.getMyplantRadius2() * myplant1.getMyplantLength()*(1.0/4.0));
            water1 = water/1000;
        }
        String water2 = String.format("%.2f", water1);
        model.addObject("water",water2);
        model.addObject("date",date);
        model.addObject("date2",date2);
        model.addObject("myplantId",myplantId);
        model.addObject("schedulelist",scheduleVos);
        model.addObject("myplant1",myplant1);
        model.addObject("plantVo",plantVo);
        model.setViewName("schedule/myPlantSchedule");
        return model;
    }
    @DeleteMapping("/{scheduleId}")
    public ResponseEntity deleteSchedule(@PathVariable int scheduleId){
        boolean flag = false;
        flag = scheduleService.deleteSchedule(scheduleId);
        return new ResponseEntity(HttpStatus.OK);
    }

    @GetMapping("/form")
    public ModelAndView getScheduleRegistForm(@PathVariable Long myplantId){
        ModelAndView model = new ModelAndView();
        model.setViewName("schedule/registSchedule");
        return model;

    }
    @PostMapping("/form")
    public RedirectView registSchedule(@ModelAttribute ScheduleVo scheduleVo){
        boolean flag = false;
        flag = scheduleService.registSchedule(scheduleVo);
        return new RedirectView("/myplants/{myplantId}/schedule");
    }

    @GetMapping("/push")
    public ModelAndView pushPage(@PathVariable int myplantId){
        ModelAndView model = new ModelAndView();
        MyplantVo myplantVo = myPlantService.myPlantDetail(myplantId);
        model.addObject("myplantId", myplantId);
        model.addObject("now", new Date());
        model.addObject("myplantvo",myplantVo);
        model.setViewName("schedule/push");
        return model;
    }

    @PostMapping("/push")
    public ModelAndView setpush(@PathVariable int myplantId, @RequestParam("dayInput")int dayInput ,@RequestParam("timeInput") String timeInput,@RequestParam("userId")String userId){
        String[] parts = timeInput.split(":");
        String cronExpression = "0 " + parts[1] + " " + parts[0] + " */" + dayInput + " * ?";
        String token = scheduleService.getToken(userId);
        webpush.scheduleTask(myplantId,cronExpression,token);
        boolean flag = myPlantService.insertWebPushData(myplantId,dayInput,timeInput);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/myplants/"+myplantId+"/schedule/push");
        return mav;
    }
    @DeleteMapping ("/push/delete")
    public ResponseEntity deletepush(@PathVariable int myplantId){
        webpush.cancelTask(myplantId);
        return ResponseEntity.ok().build();
    }

}
