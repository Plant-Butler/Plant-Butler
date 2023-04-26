package com.plant.controller;
import com.plant.service.MyPlantService;
import com.plant.vo.MyplantVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.net.URI;
import java.sql.SQLException;
import java.util.ArrayList;

@RestController
@RequestMapping("/myplants")
public class PlantController {

    @Autowired
    private MyPlantService MyPlantService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    @GetMapping(value="")
    public ModelAndView main() {
        String UserId = "윤영민";
        ArrayList<MyplantVo> plantList = new ArrayList<>();
        ModelAndView model = new ModelAndView();

        plantList = MyPlantService.MyPlantList(UserId);

        System.out.println(plantList);
        model.addObject("plantList", plantList);

        model.setViewName("myplants");
        return model;
    }
    @GetMapping(value="/form")
    public ModelAndView myPlantRegistForm() {
        ModelAndView model = new ModelAndView();
        model.setViewName("myPlantRegistForm");
        return model;
    }
    @PostMapping(value="/form")
    public ResponseEntity<MyplantVo> registMyPlant(MyplantVo myplantVo){
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
}
