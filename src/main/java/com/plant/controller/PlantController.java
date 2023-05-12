package com.plant.controller;

import com.plant.service.MyPlantService;
import com.plant.service.ScheduleService;
import com.plant.vo.MyplantVo;
import com.plant.vo.PlantVo;
import com.plant.vo.ScheduleVo;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.TimeZone;

@RestController
@RequestMapping("/myplants")
public class PlantController {

    @Autowired
    private MyPlantService MyPlantService;
    @Autowired
    private ScheduleService scheduleService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @GetMapping(value="")
    /* 메인페이지 이동 */
    public ModelAndView main(HttpSession session) {
        UserVo user = (UserVo) session.getAttribute("user");
        String userId = user.getUserId();
        ModelAndView model = new ModelAndView();
        ArrayList<MyplantVo> plantList = MyPlantService.MyPlantList(userId);
        ArrayList<ScheduleVo> scheduleVos = scheduleService.getScheduleListToUserId(userId);
        Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
        /* 각 식물 리스트의 관리기록 작성일 계산 */
        long scheduleDate = 0;
        for (int i = 0; i < plantList.size(); i++) {
            boolean matchFound = false;
            for (int y = 0; y < scheduleVos.size(); y++) {
                if (scheduleVos.get(y).getMyplantId() == plantList.get(i).getMyplantId()) {
                    scheduleDate =scheduleVos.get(y).getScheduleDate().getTime()/(1000 * 60 * 60 * 24);
                    scheduleService.setSchedule(plantList.get(i).getMyplantId(), scheduleDate);
                    matchFound = true;
                    break;
                }
            }
            if (!matchFound) {
                Timestamp time = new Timestamp(plantList.get(i).getFirstDate().getTime());
                scheduleDate =plantList.get(i).getFirstDate().getTime()/(1000 * 60 * 60 * 24);
                scheduleService.setSchedule(plantList.get(i).getMyplantId(), scheduleDate);
                System.out.println(time);
            }
        }
        /* 현재 시각 계산 */
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        long todayInDays = timestamp.getTime()/ (1000 * 60 * 60 * 24);
        model.addObject("endDate", todayInDays);
        model.addObject("plantList", plantList);
        model.setViewName("myplant/myplants");
        return model;
    }
    @GetMapping(value="/form")
    /* 메인페이지 이동 */
    public ModelAndView myPlantRegistForm(HttpSession session) {
        ModelAndView model = new ModelAndView();
        session.getAttribute("user");
        model.setViewName("myplant/myPlantRegistForm");
        return model;
    }
    @PostMapping(value="/form")
    public ResponseEntity<MyplantVo> registMyPlant(@ModelAttribute MyplantVo myplantVo, @RequestParam("uploadedImages") List<MultipartFile> uploadedImages){
        List<MultipartFile> images = uploadedImages;
        StringBuilder fileNames = new StringBuilder();
        if (images != null && !images.isEmpty()) {
            int imageCount = 0;
            for (MultipartFile image : images) {
                if (!image.isEmpty()) {
                    String fileName = Objects.requireNonNull(image.getOriginalFilename());
                    // 쉼표를 추가하기 전에 이미지 수를 확인
                    if (imageCount > 0) {
                        fileNames.append(",");
                    }
                    fileNames.append(fileName);
                    // 이미지 파일을 저장할 위치 지정
                    String uploadPath = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/src/main/resources/static/uploads/";
                    try (InputStream inputStream = image.getInputStream()) {
                        Files.copy(inputStream, Paths.get(uploadPath + fileName), StandardCopyOption.REPLACE_EXISTING);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    imageCount++;
                }
            }
        }
        myplantVo.setMyplantImage(fileNames.toString());
        MyPlantService.registMyPlant(myplantVo);
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(URI.create("/myplants"));
        return new ResponseEntity<>(myplantVo, headers, HttpStatus.SEE_OTHER);
    }
    @DeleteMapping(value="/form/{myplantId}")
    public ResponseEntity<Void> deleteMyPlant(@PathVariable("myplantId") int myplantId) {
        MyPlantService.deleteMyPlant(myplantId);
        return ResponseEntity.noContent().build();
    }
    @GetMapping(value="/{myplantId}&{plantId}")
    public ModelAndView myPlantDetail(@PathVariable("myplantId") int myplantId , @PathVariable("plantId") int plantId){
        ModelAndView model = new ModelAndView();
        MyplantVo myplantVo = MyPlantService.myPlantDetail(myplantId);
        PlantVo plantVo = MyPlantService.searchPlantToNum(plantId);
        model.addObject("myPlant", myplantVo);
        model.addObject("plant",plantVo);
        model.setViewName("myplant/myPlantDetail");
        return model;

    }
    @PostMapping(value="/{myplantId}")
    public ResponseEntity<Void>editMyPlantInfo(@RequestBody MyplantVo myplantVo){
        MyPlantService.editMyPlantInfo(myplantVo);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping(value="/search/{plantId}")
    public ResponseEntity <ArrayList<PlantVo>> searchPlantInfo(@PathVariable("plantId") String plantId){
        ArrayList<PlantVo> plantVo = new ArrayList<>();
        plantVo = MyPlantService.searchPlantInfo(plantId);
        return new ResponseEntity<>(plantVo,HttpStatus.OK);

    }

    @PostMapping("/{myplantId}/represent")
    public ResponseEntity<Void> insertRepresent(@RequestBody String represent,@PathVariable int myplantId) {
        int result = Integer.parseInt(represent);
        MyPlantService.registRepresent(result,myplantId);

        return ResponseEntity.ok().build();
    }

}