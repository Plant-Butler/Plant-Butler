package com.plant.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.plant.service.MyPlantService;
import com.plant.service.S3Service;
import com.plant.service.ScheduleService;
import com.plant.utils.ApiKey;
import com.plant.vo.MyplantVo;
import com.plant.vo.PlantVo;
import com.plant.vo.ScheduleVo;
import com.plant.vo.UserVo;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.net.URI;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.StringTokenizer;

@RestController
@RequestMapping("/myplants")
@Api(tags = "내 식물 API")
public class PlantController {

    private final MyPlantService myPlantService;
    private final ScheduleService scheduleService;
    private final S3Service s3Service;
    private final ApiKey apiKey;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public PlantController(MyPlantService myPlantService, ScheduleService scheduleService, S3Service s3Service, ApiKey apiKey) {
        this.myPlantService = myPlantService;
        this.scheduleService = scheduleService;
        this.s3Service = s3Service;
        this.apiKey = apiKey;
    }

    @GetMapping(value = "")
    /* 메인페이지 이동 */
    public ModelAndView main() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo user = (UserVo) authentication.getPrincipal();
        String userId = user.getUserId();
        ModelAndView model = new ModelAndView();
        ArrayList<MyplantVo> plantList = null; //세션에서 얻은 유저의 아이디를 통해 해당 유저의 식물 목록 불러오기
        try {
            plantList = myPlantService.myPlantList(userId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        ArrayList<ScheduleVo> scheduleVos = scheduleService.getScheduleListToUserId(userId);//세션에서 얻은 유저의 아이디를 통해 해당 유저의 스케쥴 작성 목록 불러오기
        /* 각 식물 리스트의 관리기록 작성일 계산 */
        long scheduleDate = 0;
        for (int i = 0; i < plantList.size(); i++) {
            boolean matchFound = false;
            for (int y = 0; y < scheduleVos.size(); y++) {
                if (scheduleVos.get(y).getMyplantId() == plantList.get(i).getMyplantId()) {
                    scheduleDate = scheduleVos.get(y).getScheduleDate().getTime() / (1000 * 60 * 60 * 24);//해당 식물에 맞는 스케쥴 작성 목록이 있는지 찾기
                    scheduleService.setSchedule(plantList.get(i).getMyplantId(), scheduleDate);
                    matchFound = true;
                    break;
                }
            }
            if (!matchFound) {
                Timestamp time = new Timestamp(plantList.get(i).getFirstDate().getTime());
                scheduleDate = plantList.get(i).getFirstDate().getTime() / (1000 * 60 * 60 * 24);
                scheduleService.setSchedule(plantList.get(i).getMyplantId(), scheduleDate);//해당 식물에 대한 스케쥴이 없으면 식물 등록일을 대신 추가하기
                System.out.println(time);
            }
        }
        /* 현재 시각 계산 */
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        long todayInDays = timestamp.getTime() / (1000 * 60 * 60 * 24);
        String gisang = apiKey.getGisangKey();
        String mise = apiKey.getMiseKey();
        String kakaoMap = apiKey.getKakaomapKey();
        model.addObject("endDate", todayInDays);
        model.addObject("gisang", gisang);
        model.addObject("kakaoMap", kakaoMap);
        model.addObject("mise", mise);

        // 이미지
        for(MyplantVo vo : plantList) {
            String imageList = vo.getMyplantImage();
            if(imageList != null) {
                StringTokenizer images = new StringTokenizer(imageList, ",");
                String imageUrl = null;
                while(images.hasMoreTokens()) {
                    imageUrl = s3Service.getUrl(images.nextToken(), "myplant", vo.getMyplantId());
                    vo.setMyplantImage(imageUrl);
                }
            }
        }

        model.addObject("plantList", plantList);
        model.setViewName("myplant/myplants");
        return model;
    }

    @GetMapping(value = "/form")
    /* 등록페이지 이동 */
    public ModelAndView myPlantRegistForm() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo user = (UserVo) authentication.getPrincipal();
        String userId = user.getUserId();
        ModelAndView model = new ModelAndView();
        model.addObject("userId", userId);
        model.setViewName("myplant/myPlantRegistForm");
        return model;
    }

    @PostMapping(value = "/form")
    /* 내 식물 등록하기 */
    public ResponseEntity<MyplantVo> registMyPlant(@ModelAttribute MyplantVo myplantVo,
                                                   @RequestParam(value = "uploadedImages", required = false) List<MultipartFile> images) {

        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        long scheduleDate = timestamp.getTime() / (1000 * 60 * 60 * 24);
        myplantVo.setScheduleDate(scheduleDate);
        boolean flag = myPlantService.registMyPlant(myplantVo);

        // 이미지 저장
        StringBuilder fileNames = new StringBuilder();
        if (images != null && images.stream().anyMatch(image -> !image.isEmpty())) {
            int imageCount = 0;
            for (MultipartFile image : images) {
                try {
                    s3Service.upload(image, "myplant", myplantVo.getMyplantId());
                    String fileName = Objects.requireNonNull(image.getOriginalFilename());
                    if (imageCount > 0) {
                        fileNames.append(",");
                    }
                    fileNames.append(fileName);
                } catch (IOException e) {
                    throw new RuntimeException("이미지 업로드 오류", e);
                }
                imageCount++;
            }
        }
        myplantVo.setMyplantImage(fileNames.toString());
        boolean flag2 = myPlantService.saveFiles(myplantVo);

        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(URI.create("/myplants"));
        if (flag || flag2) {
            return new ResponseEntity<>(headers, HttpStatus.SEE_OTHER);
        } else {
            return new ResponseEntity<>(headers, HttpStatus.BAD_REQUEST);
        }
    }


    @DeleteMapping(value="/form/{myplantId}")
    public ResponseEntity<Void> deleteMyPlant(@PathVariable("myplantId") int myplantId) {
        myPlantService.deleteMyPlant(myplantId);
        return ResponseEntity.noContent().build();
    }

    /* 내 식물 상세조회 */
    @GetMapping(value="/{myplantId}/{plantId}")
    public ModelAndView myPlantDetail(@PathVariable("myplantId") int myplantId , @PathVariable("plantId") int plantId){
        ModelAndView model = new ModelAndView();
        MyplantVo myplantVo = myPlantService.myPlantDetail(myplantId);
        PlantVo plantVo = myPlantService.searchPlantToNum(plantId);
        model.addObject("myPlant", myplantVo);
        model.addObject("plant",plantVo);
        model.setViewName("myplant/myPlantDetail");

        // 이미지
        String imageList = myplantVo.getMyplantImage();
        if(imageList != null) {
            StringTokenizer images = new StringTokenizer(imageList, ",");
            ArrayList<String> imageUrls = new ArrayList<>();
            while(images.hasMoreTokens()) {
                String imageUrl = s3Service.getUrl(images.nextToken(), "myplant", myplantVo.getMyplantId());
                imageUrls.add(imageUrl);
            }
            model.addObject("imageUrls", imageUrls);
        }
        return model;

    }
    @PostMapping(value="/{myplantId}", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Void>editMyPlantInfo(@PathVariable int myplantId,
                                               @RequestParam("myplantVo") String myplantVoJson,
                                               @RequestParam(value = "myplantImages", required = false) List<MultipartFile> images){

        MyplantVo myplantVo = null;
        try {
            myplantVo = new ObjectMapper().readValue(myplantVoJson, MyplantVo.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        // 기존 이미지 삭제
        MyplantVo oriMyplant = myPlantService.myPlantDetail(myplantId);
        String imageList = oriMyplant.getMyplantImage();
        if(imageList != null) {
            StringTokenizer oriImages = new StringTokenizer(imageList, ",");
            while(oriImages.hasMoreTokens()) {
                s3Service.delete(oriImages.nextToken(), "myplant" , myplantId);
            }
        }

        // 이미지 저장
        StringBuilder fileNames = new StringBuilder();
        if (images != null && images.stream().anyMatch(image -> !image.isEmpty())) {
            int imageCount = 0;
            for (MultipartFile image : images) {
                try {
                    s3Service.upload(image, "myplant", myplantId);
                    String fileName = Objects.requireNonNull(image.getOriginalFilename());
                    if (imageCount > 0) {
                        fileNames.append(",");
                    }
                    fileNames.append(fileName);
                } catch (IOException e) {
                    throw new RuntimeException("이미지 업로드 오류", e);
                }
                imageCount++;
            }
        }
        myplantVo.setMyplantImage(fileNames.toString());

        myPlantService.editMyPlantInfo(myplantVo);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @GetMapping(value="/search/{plantId}")
    public ResponseEntity <ArrayList<PlantVo>> searchPlantInfo(@PathVariable("plantId") String plantId){
        ArrayList<PlantVo> plantVo =  myPlantService.searchPlantInfo(plantId);
        return new ResponseEntity<>(plantVo,HttpStatus.OK);

    }

    @PostMapping("/{myplantId}/{userId}/represent")
    public ResponseEntity<Void> insertRepresent(@PathVariable int myplantId, @PathVariable String userId) {
        myPlantService.registRepresent(userId, myplantId);
        return ResponseEntity.ok().build();
    }

}
