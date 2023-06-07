package com.plant.controller;

import com.plant.service.CommentService;
import com.plant.service.DiagnosisService;
import com.plant.vo.MyplantVo;
import com.plant.vo.DiseaseVo;
import net.sf.jsqlparser.Model;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
import java.util.ArrayList;

@RestController
@RequestMapping("")
public class DiagnosisController {

    @Autowired
    private DiagnosisService diagnosisService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 사진 업로드 */
    @GetMapping("/diagnosis")
    public ModelAndView showDiagnosisPage() {
        ModelAndView mv = new ModelAndView("/diagnosis/upload");
        logger.info("진단 페이지 호출");
        return mv;
    }

    /* 이미지 전송 & 결과 디스플레이 */
    @PostMapping(value = "/transferImage")
    public ModelAndView uploadImage(@RequestParam("image") MultipartFile file, RedirectAttributes redirectAttributes) {
        ModelAndView mv = new ModelAndView("/diagnosis/result");
        try {
            final String UPLOAD_DIR = "D:/final/Plant-Butler/uploads/";

            // 저장할 폴더가 존재하지 않는다면 새로 생성
            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // 저장 경로 설정
            Path img_path = Paths.get(UPLOAD_DIR + file.getOriginalFilename());

            // 파일 저장
            Files.write(img_path, file.getInputStream().readAllBytes());
            System.gc();

            String imagePath = img_path.toString();
            ProcessBuilder processBuilder = new ProcessBuilder("python", "D:/ml/checking.py", imagePath);
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

            // "Predicted class"를 기준으로 문자열 자르기
            int predictedClassIndex = result.indexOf("Predicted class:");
            String predictedClassLine = result.substring(predictedClassIndex);
            String predictedClass = predictedClassLine.split(",")[0].trim();
            // finalClass = predictedClass.split(",")[1].trim();
            // "Confidence"를 기준으로 문자열 자르기
            int confidenceIndex = result.indexOf("Confidence:");
            String confidenceLine = result.substring(confidenceIndex);
            String confidence = confidenceLine.split(",")[0].trim();
            // 원하는 결과 변수로 저장 후 반환
            String desiredResult = "Predicted class: " + predictedClass + ", Confidence: " + confidence;
            mv.addObject("result", desiredResult);
            mv.addObject("pclass", predictedClass);
            mv.addObject("confidence", confidence);
            DiseaseVo diseaseVo = diagnosisService.diseaseInfo(predictedClass);

//            String image = "uploads/bacterial_spot.jpg";
//            mv.addObject("image", image);

            mv.addObject("disease", diseaseVo);
            return mv;

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return mv;
        }
    }


    /* 결과 디스플레이 */
    @PostMapping(value = "/result")
    public ModelAndView checkResult(@RequestParam("image") MultipartFile file, RedirectAttributes redirectAttributes) {
        ModelAndView mv = new ModelAndView("/diagnosis/result");

        return mv;
    }
}
