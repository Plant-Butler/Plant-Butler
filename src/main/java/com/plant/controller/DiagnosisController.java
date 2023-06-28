package com.plant.controller;

import com.plant.service.DiagnosisService;
import com.plant.service.S3Service;
import com.plant.vo.DiseaseVo;
import com.plant.vo.PestVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.v3.oas.annotations.Operation;
import com.plant.vo.PestVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;

@RestController
@RequestMapping("/diagnosis")
@Api(tags = "내 식물 식물병/병해충 진단 API")
public class DiagnosisController {

    private final DiagnosisService diagnosisService;
    private final S3Service s3Service;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public DiagnosisController(DiagnosisService diagnosisService, S3Service s3Service) {
        this.diagnosisService = diagnosisService;
        this.s3Service = s3Service;
    }

    /* 질병 사진 업로드 */
    @GetMapping("")
    @Operation(summary = "식물병 이미지 업로드", description = "로그인 유저가 식물병 이미지 업로드")
    public ModelAndView showDiagnosisPage() {
        ModelAndView mv = new ModelAndView("/diagnosis/upload");
        logger.info("진단 페이지 호출");
        return mv;
    }

    /* 이미지 전송 & 결과 디스플레이 */
    @PostMapping(value = "/result")
    @Operation(summary = "식물병 진단AI 실행 및 진단결과 출력", description = "식물병 진단 모델 실행 및 진단결과와 해결법 확인")
    @ApiImplicitParam(name="image", value="식물병 이미지", paramType = "query")
    public ModelAndView uploadImage(@RequestParam("image") MultipartFile image, RedirectAttributes redirectAttributes) {
        ModelAndView mv = new ModelAndView("/diagnosis/result");

        if (image != null && !image.isEmpty()) {
            try {
                s3Service.upload(image, "diagnosis", 0);
            } catch (IOException e) {
                throw new RuntimeException("식물병 진단 이미지 업로드 오류", e);
            }
            String fileName = Objects.requireNonNull(image.getOriginalFilename());
        }
        String s3ImageUrl = s3Service.getUrl(image.getOriginalFilename(), "diagnosis", 0); // Get the S3 URL of the uploaded image
        logger.info("s3주소: {}", s3ImageUrl);
        ProcessBuilder processBuilder = new ProcessBuilder("python", "D:/ml/checking.py", s3ImageUrl);
        try{
        Process process = processBuilder.start();
        int exitCode = process.waitFor();
        if (exitCode != 0) {
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
            String errorLine;
            StringBuilder errorMessage = new StringBuilder();
            while ((errorLine = errorReader.readLine()) != null) {
                errorMessage.append(errorLine);
            }
            logger.error("Python script error: " + errorMessage.toString());
            return mv;
        }

        BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8));

        String line;
        StringBuilder responseMsg = new StringBuilder();
        while ((line = reader.readLine()) != null) {
            responseMsg.append(line);
        }
        logger.info("이미지 검색 호출");
        String result = responseMsg.toString();
        int predictedClassStartIndex = result.indexOf("Predicted class: ");
        int predictedClassEndIndex = result.indexOf(", Confidence:");
        String predictedClass = result.substring(predictedClassStartIndex + 17, predictedClassEndIndex).trim();
        if (predictedClass.equals("bacterial_spot")) {
            predictedClass = "세균성점무늬병";
        } else if (predictedClass.equals("apple_scab")) {
            predictedClass = "검은별무늬병";
        } else if (predictedClass.equals("cedar_apple_rust")) {
            predictedClass = "붉은별무늬병";
        } else if (predictedClass.equals("cercospora_gray_leaf_spot")) {
            predictedClass = "갈색무늬병";
        } else if (predictedClass.equals("citrus_greening")) {
            predictedClass = "감귤그린병";
        } else if (predictedClass.equals("common_rust")) {
            predictedClass = "녹병";
        } else if (predictedClass.equals("early_late_blight")) {
            predictedClass = "겹무늬병";
        } else if (predictedClass.equals("grape_esca_black_measles")) {
            predictedClass = "포도검은홍반병";
        } else if (predictedClass.equals("healthy")) {
            predictedClass = "건강한 상태";
        } else if (predictedClass.equals("isariopsis_leaf_spot")) {
            predictedClass = "포도나무갈색무늬병";
        } else if (predictedClass.equals("leaf_mold")) {
            predictedClass = "잎곰팡이병";
        } else if (predictedClass.equals("leaf_scorch")) {
            predictedClass = "붉은무늬병";
        } else if (predictedClass.equals("mosaic_virus")) {
            predictedClass = "모자이크 바이러스";
        } else if (predictedClass.equals("northern_leaf_blight")) {
            predictedClass = "북부잎마름병";
        } else if (predictedClass.equals("powdery_mildew")) {
            predictedClass = "흰가루병";
        } else if (predictedClass.equals("septoria_leaf_spot")) {
            predictedClass = "흰무늬병";
        } else if (predictedClass.equals("spider_mites")) {
            predictedClass = "점박이응애알레르기";
        } else if (predictedClass.equals("target_spot")) {
            predictedClass = "표적반점병";
        } else if (predictedClass.equals("yellowleaf__curl_virus")) {
            predictedClass = "토마토황화말림바이러스병";
        }

        int confidenceStartIndex = result.indexOf("Confidence: ");
        int confidenceEndIndex = result.indexOf("%");
        String confidence = result.substring(confidenceStartIndex + 12, confidenceEndIndex).trim();

        mv.addObject("pclass", predictedClass);
        mv.addObject("confidence", confidence);

            DiseaseVo diseaseVo = diagnosisService.diseaseInfo(predictedClass);

            // 예시 이미지
            String imageUrl = s3Service.getUrlwithFolder("diagnosis", predictedClass);
            System.out.println("predictedClass = " + predictedClass);
            System.out.println("imageUrl = " + imageUrl);
            diseaseVo.setImage(imageUrl);

            mv.addObject("disease", diseaseVo);
            return mv;

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return mv;
        }
    }

    /* 해충 사진 업로드 */
    @GetMapping("/pest")
    @Operation(summary = "병해충 이미지 업로드", description = "로그인 유저가 병해충 이미지 업로드")
    public ModelAndView showpestpage() {
        ModelAndView mv = new ModelAndView("/diagnosis/pestupload");
        logger.info("해충 진단 페이지 호출");
        return mv;
    }

    /* 해충 이미지 전송 & 결과 디스플레이 */
    @PostMapping(value = "/pest/result")
    @Operation(summary = "병해충 진단AI 실행 및 진단결과 출력", description = "병해충 진단 모델 실행 및 진단결과와 해결법 확인")
    @ApiImplicitParam(name="image2", value="병해충 이미지", paramType = "query")
    public ModelAndView uploadpestimage(@RequestParam("image2") MultipartFile image, RedirectAttributes redirectAttributes) {
        ModelAndView mv = new ModelAndView("/diagnosis/pestresult");
        if (image != null && !image.isEmpty()) {
            try {
                s3Service.upload(image, "diagnosis", 0);
            } catch (IOException e) {
                throw new RuntimeException("병해충 진단 이미지 업로드 오류", e);
            }
            String fileName = Objects.requireNonNull(image.getOriginalFilename());
        }
        String s3ImageUrl = s3Service.getUrl(image.getOriginalFilename(), "diagnosis", 0); // Get the S3 URL of the uploaded image
        logger.info("s3주소: {}", s3ImageUrl);
        ProcessBuilder processBuilder = new ProcessBuilder("python", "D:/ml/pest.py", s3ImageUrl);
        try{
            Process process = processBuilder.start();
            int exitCode = process.waitFor();
            if (exitCode != 0) {
                BufferedReader errorReader = new BufferedReader(new InputStreamReader(process.getErrorStream()));
                String errorLine;
                StringBuilder errorMessage = new StringBuilder();
                while ((errorLine = errorReader.readLine()) != null) {
                    errorMessage.append(errorLine);
                }
                logger.error("Python script error: " + errorMessage.toString());
                return mv;
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8));

            String line;
            StringBuilder responseMsg = new StringBuilder();
            while ((line = reader.readLine()) != null) {
                responseMsg.append(line);
            }
            logger.info("해충 이미지 검색 호출");
            String result = responseMsg.toString();

            int predictedClassStartIndex = result.indexOf("Predicted class: ");
            int predictedClassEndIndex = result.indexOf(", Confidence:");
            String predictedClass = result.substring(predictedClassStartIndex + 17, predictedClassEndIndex).trim();
            if (predictedClass.equals("aphids")) {
                predictedClass = "진딧물";
            } else if (predictedClass.equals("armyworm")) {
                predictedClass = "조밤나방";
            } else if (predictedClass.equals("beetle")) {
                predictedClass = "딱정벌레";
            } else if (predictedClass.equals("bollworm")) {
                predictedClass = "다래벌레";
            } else if (predictedClass.equals("grasshopper")) {
                predictedClass = "메뚜기";
            } else if (predictedClass.equals("mealybugsmites")) {
                predictedClass = "깍지벌레";
            } else if (predictedClass.equals("mites")) {
                predictedClass = "응애";
            } else if (predictedClass.equals("mosquito")) {
                predictedClass = "모기";
            } else if (predictedClass.equals("sawfly")) {
                predictedClass = "잎벌";
            } else if (predictedClass.equals("stemborer")) {
                predictedClass = "줄기벌레";
            } else if (predictedClass.equals("vaporariorum")) {
                predictedClass = "온실가루이";
            }
            int confidenceStartIndex = result.indexOf("Confidence: ");
            int confidenceEndIndex = result.indexOf("%");
            String confidence = result.substring(confidenceStartIndex + 12, confidenceEndIndex).trim();

            mv.addObject("pclass", predictedClass);
            mv.addObject("confidence", confidence);

            PestVo pestVo = diagnosisService.pestInfo(predictedClass);

            // 예시 이미지
            String imageUrl = s3Service.getUrlwithFolder("diagnosis", predictedClass);
            pestVo.setImage(imageUrl);

            mv.addObject("pest", pestVo);
            return mv;

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return mv;
        }
    }
}