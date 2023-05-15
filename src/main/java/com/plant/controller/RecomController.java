package com.plant.controller;

import com.plant.service.RecomService;
import com.plant.vo.PlantVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;

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

}
