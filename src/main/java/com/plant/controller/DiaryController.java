package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.DiaryService;
import com.plant.service.PostService;
import com.plant.vo.DiaryVo;
import com.plant.vo.MyplantVo;
import com.plant.vo.ScheduleVo;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@RestController
@RequestMapping("/diaries")
public class DiaryController {

    @Autowired
    private DiaryService diaryService;
    @Autowired
    private PostService postService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    /* 전체 식물일기 조회 */
    @GetMapping(value="")
    public ModelAndView getDiaryList(@RequestParam(defaultValue = "1")Integer pageNum,
                                     @RequestParam(defaultValue = "10") Integer pageSize) {
        ModelAndView mv = new ModelAndView("/diary/diaryList");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        String userId = userVo.getUserId();

        PageInfo<DiaryVo> diaryList = diaryService.getDiaryList(userId, pageNum, pageSize);
        mv.addObject("diaryList", diaryList);
        logger.info("[Diary Controller] getDiaryList()");
        return mv;
    }

    /* 식물일기 상세조회
    *
    * 1. 제목 / 카테고리 별 내용 / 이미지 다수
    * 2. 내 식물 중 어떤 식물에 관해 썼는 지 -> 식물 프로필(사진, 닉네임, 종, 분양일)
    * 3. 해당 내 식물의 오늘자 관리기록
    *
    */
    @GetMapping(value="/{diaryId}")
    public ModelAndView getDiaryDetail(@PathVariable int diaryId) {
        ModelAndView mv = new ModelAndView("/diary/diaryDetail");

        // 제목 / 카테고리 별 내용 / 이미지 다수
        DiaryVo diary = diaryService.getDiaryDetail(diaryId);

        // 식물 프로필(사진, 닉네임, 종, 분양일), 관리기록
        ArrayList<MyplantVo> myPlantList = diaryService.selectedMyplants(diaryId);
        ArrayList<ScheduleVo> scheduleList = diaryService.selectedSchedules(diaryId);
        System.out.println("scheduleList = " + scheduleList);

        mv.addObject("diary", diary);
        mv.addObject("myPlantList", myPlantList);
        mv.addObject("scheduleList", scheduleList);
        logger.info("[Diary Controller] getDiaryDetail()");
        return mv;
    }

    /* 식물일기 작성 페이지 */
    @GetMapping(value="/form")
    public ModelAndView openDiaryForm() {
        ModelAndView mv = new ModelAndView("/diary/newDiary");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        String userId = userVo.getUserId();
        List<MyplantVo> myplantList = postService.plantall(userId);

        mv.addObject("myplantList", myplantList);
        mv.addObject("userId", userId);
        logger.info("[Diary Controller] openDiaryForm()");
        return mv;
    }

    /* 식물일기 작성
    *
    * 1. 제목 / 카테고리 별 내용 / 이미지 다수
    * 2. 내 식물 중 어떤 식물에 관해 작성할 것인지 체크 (중복체크 가능)
    *
    */
    @PostMapping("/form")
    public ResponseEntity<HttpHeaders> postDiary(@ModelAttribute DiaryVo diary,
                                             @RequestParam(value="diaryMultiImage", required=false) List<MultipartFile> image,
                                             @RequestParam(value="selectedMyplant", required=false) List<Integer> myplants) {

        String uploadFile = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/uploads/";
        File dir2 = new File(uploadFile);
        if (!dir2.exists()) {
            dir2.mkdir();
        }

        // 이미지
        List<MultipartFile> images = image;
        StringBuilder fileNames = new StringBuilder();
        if (images != null && !images.isEmpty()) {
            int imageCount = 0;
            for (MultipartFile image1 : images) {
                if (!image1.isEmpty()) {
                    String fileName = Objects.requireNonNull(image1.getOriginalFilename());
                    if (imageCount > 0) {
                        fileNames.append(",");
                    }
                    fileNames.append(fileName);
                    String uploadPath = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/uploads/";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    try (InputStream inputStream = image1.getInputStream()) {
                        Files.copy(inputStream, Paths.get(uploadPath + fileName), StandardCopyOption.REPLACE_EXISTING);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    imageCount++;
                }
            }
        }
        diary.setDiaryImage(fileNames.toString());

        // 일기 내용 + 내 식물
        boolean flag1 = false;
        boolean flag2 = false;
        flag1 = diaryService.postDiary(diary);
        if(myplants != null) {
            for(int myplantId : myplants) {
                flag2 = diaryService.addMyplant(diary.getDiaryId(), myplantId);
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(URI.create("/diaries"));

        logger.info("[Diary Controller] postDiary()");
        if(flag1 || flag2) {
            return new ResponseEntity<>(headers, HttpStatus.SEE_OTHER);
        } else {
            return new ResponseEntity<>(headers, HttpStatus.BAD_REQUEST);
        }

    }

    /* 내 식물 관리기록 불러오기
    *
    * 1. 식물일기 작성 시 선택한 내 식물의 오늘자 관리기록 불러오기
    *
    */
    @GetMapping(value="/schedule")
    public ResponseEntity<ScheduleVo> getSchedule(@RequestParam(value="selectedPlant") int selectedPlant) {
        ScheduleVo vo = diaryService.getSchedule(selectedPlant);

        logger.info("[Diary Controller] getSchedule()");
        return new ResponseEntity<>(vo, HttpStatus.OK);
    }

    /* 식물일기 수정 페이지 */
    @GetMapping("/form/{diaryId}")
    public ModelAndView modifyDiaryForm(@PathVariable int diaryId) {
        ModelAndView mv = new ModelAndView("/diary/updateDiary");
        DiaryVo diary = diaryService.getDiaryDetail(diaryId);
        mv.addObject("diary", diary);
        logger.info("[Diary Controller] modifyDiaryForm()");
        return mv;
    }

    /* 식물일기 수정 */
    @PutMapping(value="/{diaryId}")
    public ResponseEntity<Boolean> modifyDiary(@PathVariable int diaryId,
                                               @ModelAttribute DiaryVo diary,
                                               @RequestParam(value="diaryMultiImage", required=false) List<MultipartFile> image) {

        String uploadFile = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/uploads/";
        File dir2 = new File(uploadFile);
        if (!dir2.exists()) {
            dir2.mkdir();
        }

        // 이미지
        List<MultipartFile> images = image;
        StringBuilder fileNames = new StringBuilder();
        if (images != null && !images.isEmpty()) {
            int imageCount = 0;
            for (MultipartFile image1 : images) {
                if (!image1.isEmpty()) {
                    String fileName = Objects.requireNonNull(image1.getOriginalFilename());
                    if (imageCount > 0) {
                        fileNames.append(",");
                    }
                    fileNames.append(fileName);
                    String uploadPath = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/uploads/";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    try (InputStream inputStream = image1.getInputStream()) {
                        Files.copy(inputStream, Paths.get(uploadPath + fileName), StandardCopyOption.REPLACE_EXISTING);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                    imageCount++;
                }
            }
        }
        diary.setDiaryImage(fileNames.toString());

        // 일기 내용
        boolean flag = false;
        flag = diaryService.modifyDiary(diary);

        logger.info("[Diary Controller] modifyDiary()");
        if(flag) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }


    /* 식물일기 삭제 */
    @DeleteMapping(value="/{diaryId}")
    public ResponseEntity<Boolean> removeDiary(@PathVariable int diaryId) {
        boolean flag = false;
        flag = diaryService.removeDiary(diaryId);

        logger.info("[Diary Controller] removeDiary()");
        if(flag) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }

}
