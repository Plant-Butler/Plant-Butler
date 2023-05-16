package com.plant.controller;

import com.plant.service.RecomService;
import com.plant.vo.PlantVo;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;

@RestController
@RequestMapping("/suggestions")
public class RecomController {

    @Autowired
    private RecomService recomService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 추천 결과 보기 */
    @GetMapping(value="/result")
    public ModelAndView getResultList(@ModelAttribute PlantVo plantVo) {
        ModelAndView mv = new ModelAndView("/suggestions/result");
        ArrayList<PlantVo> resultList = recomService.getResultList(plantVo);
        mv.addObject("resultList", resultList);
        return mv;
    }

    /* 추천 결과 저장 */
    @PostMapping(value="/result")
    public ResponseEntity<Boolean> saveResultList(@ModelAttribute("idxList") String plantIds, HttpSession session) {
        boolean flag = false;
        boolean cntFlag = false;

        UserVo user = (UserVo) session.getAttribute("user");
        String userId = user.getUserId();

        int already = recomService.getRecomCnt(userId);
        if(already > 0) {
            // 기존 결과 리셋
            cntFlag = recomService.deleteOriginal(userId);
        }

        ArrayList<String> plntIds = new ArrayList<>(Arrays.asList(plantIds.split(",")));
        HashMap<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        for (String id : plntIds) {
            int plantId = Integer.parseInt(id);
            map.put("plant_id", plantId);

            // 결과 저장
            flag = recomService.saveResultList(map);
            if (!flag) break;
        }


        logger.info("[RecomController Controller] saveResultList()");
        if(flag || (already>0 && cntFlag)) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }
}
