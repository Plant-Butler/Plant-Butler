package com.plant.controller;

import com.plant.service.MyPlantService;
import com.plant.service.ScheduleService;
import com.plant.service.TokenRepository;
import com.plant.service.webpushService;
import com.plant.vo.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.v3.oas.annotations.Operation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/myplants/{myplantId}/schedule")
@Api(tags = "내 식물 관리기록 API")
public class ScheduleController {

    private final TokenRepository tokenRepository;

    private final ScheduleService scheduleService;

    private final MyPlantService myPlantService;

    private final webpushService webpush;


    @Autowired
    public ScheduleController(TokenRepository tokenRepository,ScheduleService scheduleService,MyPlantService myPlantService,webpushService webpush){
        this.tokenRepository = tokenRepository;
        this.scheduleService = scheduleService;
        this.myPlantService = myPlantService;
        this.webpush = webpush;
    }

    @GetMapping("")
    @Operation(summary = "내 식물 관리페이지 이동", description = "내 반려식물의 관리 페이지로 이동하여 과거 기록까지 조회")
    @ApiImplicitParam(name="myplantId", value="내 식물 id값")
    public ModelAndView myPlantSchedule(@PathVariable Long myplantId){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        String userId = userVo.getUserId();
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
        model.addObject("userId",userId);
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
    @Operation(summary = "관리기록 삭제", description = "과거에 등록된 관리기록 삭제")
    @ApiImplicitParam(name="scheduleId", value="내 식물 관리기록 id값")
    public ResponseEntity deleteSchedule(@PathVariable int scheduleId){
        boolean flag = false;
        flag = scheduleService.deleteSchedule(scheduleId);
        return new ResponseEntity(HttpStatus.OK);
    }

    @GetMapping("/form")
    @Operation(summary = "관리기록 추가 폼 열기", description = "관리기록(물, 영양제, 분갈이, 가치지기, 환기)을 등록하기 위한 폼 열기")
    @ApiImplicitParam(name="myplantId", value="내 식물 id값")
    public ModelAndView getScheduleRegistForm(@PathVariable Long myplantId){
        ModelAndView model = new ModelAndView();
        model.setViewName("schedule/registSchedule");
        return model;

    }
    @PostMapping("/form")
    @Operation(summary = "관리기록 추가 ", description = "오늘의 관리기록(물, 영양제, 분갈이, 가치지기, 환기)을 추가")
    @ApiImplicitParam(name="ScheduleVo", value="내 식물 관리기록 VO")
    public RedirectView registSchedule(@ModelAttribute ScheduleVo scheduleVo){
        boolean flag = false;
        flag = scheduleService.registSchedule(scheduleVo);
        return new RedirectView("/myplants/{myplantId}/schedule");
    }

    @GetMapping("/push")
    @Operation(summary = "웹푸시 설정 페이지 이동", description = "웹푸시를 설정하는 페이지로 이동")
    @ApiImplicitParam(name="myplantId", value="내 식물 id값")
    public ModelAndView pushPage(@PathVariable int myplantId){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        String userId = userVo.getUserId();
        ModelAndView model = new ModelAndView();
        MyplantVo myplantVo = myPlantService.myPlantDetail(myplantId);
        model.addObject("userId",userId);
        model.addObject("myplantId", myplantId);
        model.addObject("now", new Date());
        model.addObject("myplantvo",myplantVo);
        model.setViewName("schedule/push");
        return model;
    }

    @PostMapping("/push")
    @Operation(summary = "물주기 웹푸시 설정", description = "물주기 웹푸시를 수신하기 위한 일정간격, 시간 설정")
    @ApiImplicitParams({@ApiImplicitParam(name="myplantId", value="내 식물 id값"),
            @ApiImplicitParam(name="dayInput", value="물 주기 웹푸시 간격"),
            @ApiImplicitParam(name="timeInput", value="물 주기 웹푸시 시간"),
            @ApiImplicitParam(name="userId", value="로그인 유저 id"),
            @ApiImplicitParam(name="water", value="물")
    })
    public ModelAndView setpush(@PathVariable int myplantId, @RequestParam(value = "dayInput")int dayInput ,@RequestParam(value = "timeInput") String timeInput,@RequestParam("userId")String userId,@RequestParam("water")String water){
        String[] parts = timeInput.split(":");
        String cronExpression = "0 " + parts[1] + " " + parts[0] + " */" + dayInput + " * ?";
        List<TokenVo> tokenObjects = tokenRepository.findByUserId(userId);
        String[] tokens = tokenObjects.stream()
                .map(TokenVo::getTokenNum)  // 이 메서드는 TokenVo 객체에서 token 문자열을 가져오는 메서드입니다.
                .toArray(String[]::new);
        for(int i = 0; i<tokens.length; i++){
            System.out.println(tokens[i]);
        }
        webpush.scheduleTask(myplantId,water,cronExpression,tokens);
        boolean flag = myPlantService.insertWebPushData(myplantId,dayInput,timeInput);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/myplants/"+myplantId+"/schedule/push");
        return mav;
    }
    @PostMapping("/push2")
    @Operation(summary = "영양제 웹푸시 설정", description = "영양제 웹푸시를 수신하기 위한 일정간격, 시간 설정")
    @ApiImplicitParams({@ApiImplicitParam(name="myplantId", value="내 식물 id값"),
            @ApiImplicitParam(name="dayInput", value="물 주기 웹푸시 간격"),
            @ApiImplicitParam(name="timeInput", value="물 주기 웹푸시 시간"),
            @ApiImplicitParam(name="userId", value="로그인 유저 id"),
            @ApiImplicitParam(name="drug", value="영양제")
    })
    public ModelAndView setpush2(@PathVariable int myplantId, @RequestParam(value = "dayInput")int dayInput ,@RequestParam(value = "timeInput") String timeInput,@RequestParam("userId")String userId,@RequestParam("drug")String drug){
        String[] parts = timeInput.split(":");
        String cronExpression = "0 " + parts[1] + " " + parts[0] + " */" + dayInput + " * ?";
        String[] token = scheduleService.getToken(userId);
        webpush.scheduleTask2(myplantId,drug,cronExpression,token);
        boolean flag = myPlantService.insertWebPushData2(myplantId,dayInput,timeInput);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("redirect:/myplants/"+myplantId+"/schedule/push");
        return mav;
    }


    @DeleteMapping ("/push/delete/{alarmType}")
    @Operation(summary = "웹푸시 삭제", description = "과거에 설정해놓은 웹푸시 설정을 삭제하여 더는 수신하지 않음")
    @ApiImplicitParams({@ApiImplicitParam(name="myplantId", value="내 식물 id값"),
            @ApiImplicitParam(name="alarmType", value="웹푸시 타입")
    })
    public ResponseEntity deletepush(@PathVariable("myplantId") int myplantId, @PathVariable("alarmType") String alarmType){
        String key = myplantId + "_" + alarmType;
        System.out.println(alarmType);
        if(alarmType.equals("water")){
        webpush.cancelTask(myplantId,key);}
        else {
            webpush.cancelTask2(myplantId,key);
        }
        return ResponseEntity.ok().build();
    }


}
