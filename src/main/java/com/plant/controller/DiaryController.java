package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.DiaryService;
import com.plant.service.PostService;
import com.plant.service.S3Service;
import com.plant.service.UserService;
import com.plant.vo.DiaryVo;
import com.plant.vo.MyplantVo;
import com.plant.vo.ScheduleVo;
import com.plant.vo.UserVo;
import io.swagger.annotations.Api;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.StringTokenizer;

@RestController
@RequestMapping("/diaries")
@Api(tags = "식물일기 API")
public class DiaryController {

    private final DiaryService diaryService;
    private final PostService postService;
    private final UserService userService;
    private final S3Service s3Service;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public DiaryController(DiaryService diaryService, PostService postService, UserService userService, S3Service s3Service) {
        this.diaryService = diaryService;
        this.postService = postService;
        this.userService = userService;
        this.s3Service = s3Service;
    }

    /* 전체 식물일기 조회 */
    @GetMapping(value="")
    public ModelAndView getDiaryList(@RequestParam(defaultValue = "1")Integer pageNum,
                                     @RequestParam(defaultValue = "9") Integer pageSize) {
        ModelAndView mv = new ModelAndView("/diary/diaryList");

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        String userId = userVo.getUserId();

        PageInfo<DiaryVo> diaryList = diaryService.getDiaryList(userId, pageNum, pageSize);

        // 이미지
        for(DiaryVo vo : diaryList.getList()) {
            String imageList = vo.getDiaryImage();
            if(imageList != null) {
                StringTokenizer images = new StringTokenizer(imageList, ",");
                String imageUrl = null;
                while(images.hasMoreTokens()) {
                    imageUrl = s3Service.getUrl(images.nextToken(), "diary", vo.getDiaryId());
                    vo.setDiaryImage(imageUrl);
                }
            }
        }

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

        for(MyplantVo vo : myPlantList) {
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

        mv.addObject("diary", diary);
        mv.addObject("myPlantList", myPlantList);
        mv.addObject("scheduleList", scheduleList);

        // 이미지
        String imageList = diary.getDiaryImage();
        if(imageList != null) {
            StringTokenizer images = new StringTokenizer(imageList, ",");
            ArrayList<String> imageUrls = new ArrayList<>();
            while(images.hasMoreTokens()) {
                String imageUrl = s3Service.getUrl(images.nextToken(), "diary", diaryId);
                imageUrls.add(imageUrl);
            }
            mv.addObject("imageUrls", imageUrls);
        }

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
                                             @RequestParam(value="diaryMultiImage", required=false) List<MultipartFile> images,
                                             @RequestParam(value="selectedMyplant", required=false) List<Integer> myplants) {

        // 일기 내용 + 내 식물
        boolean flag1 = false;
        boolean flag2 = false;
        flag1 = diaryService.postDiary(diary);
        if(myplants != null) {
            for(int myplantId : myplants) {
                flag2 = diaryService.addMyplant(diary.getDiaryId(), myplantId);
            }
        }

        // 이미지 저장
        StringBuilder fileNames = new StringBuilder();
        if(images != null && images.stream().anyMatch(image -> ! image.isEmpty())) {
            int imageCount = 0;
            for (MultipartFile image : images) {
                try {
                    s3Service.upload(image, "diary", diary.getDiaryId());
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
        diary.setDiaryImage(fileNames.toString());
        boolean flag3 = diaryService.saveFiles(diary);

        // 포인트 Authentication 반영
        UserVo userVo = userService.getUserVo();
        userService.getNewPoint(userVo, userVo.getUserId());

        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(URI.create("/diaries"));

        logger.info("[Diary Controller] postDiary()");
        if(flag1 || flag2 || flag3) {
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

        // 이미지
        String imageList = diary.getDiaryImage();
        if(imageList != null) {
            StringTokenizer images = new StringTokenizer(imageList, ",");
            ArrayList<String> imageUrls = new ArrayList<>();
            while(images.hasMoreTokens()) {
                String imageUrl = s3Service.getUrl(images.nextToken(), "diary", diaryId);
                imageUrls.add(imageUrl);
            }
            mv.addObject("imageUrls", imageUrls);
        }
        logger.info("[Diary Controller] modifyDiaryForm()");
        return mv;
    }

    /* 식물일기 수정 */
    @PutMapping(value="/{diaryId}")
    public ResponseEntity<Boolean> modifyDiary(@PathVariable int diaryId,
                                               @ModelAttribute DiaryVo diary,
                                               @RequestParam(value="diaryMultiImage", required=false) List<MultipartFile> images) {

        // 기존 이미지 삭제
        DiaryVo oriDiary = diaryService.getDiaryDetail(diaryId);
        String imageList = oriDiary.getDiaryImage();
        if(imageList != null) {
            StringTokenizer oriImages = new StringTokenizer(imageList, ",");
            while(oriImages.hasMoreTokens()) {
                s3Service.delete(oriImages.nextToken(), "diary" , diaryId);
            }
        }

        // 이미지 저장
        StringBuilder fileNames = new StringBuilder();
        if(images != null && images.stream().anyMatch(image -> ! image.isEmpty())) {
            int imageCount = 0;
            for (MultipartFile image : images) {
                try {
                    s3Service.upload(image, "diary", diary.getDiaryId());
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

        // 기존 이미지 삭제
        DiaryVo oriDiary = diaryService.getDiaryDetail(diaryId);
        String imageList = oriDiary.getDiaryImage();
        if(imageList != null) {
            StringTokenizer oriImages = new StringTokenizer(imageList, ",");
            while(oriImages.hasMoreTokens()) {
                s3Service.delete(oriImages.nextToken(), "diary" , diaryId);
            }
        }

        flag = diaryService.removeDiary(diaryId);

        logger.info("[Diary Controller] removeDiary()");
        if(flag) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }

}
