package com.plant.service;

import com.plant.dao.MyPlantMapper;
import com.plant.vo.MyplantVo;
import com.plant.vo.PlantVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;

@Service
public class MyPlantService {
    @Autowired
    private MyPlantMapper myPlantMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    public ArrayList<MyplantVo> MyPlantList(String UserId) {
        ArrayList<MyplantVo> myPlant = new ArrayList<>();
        try {
            System.out.println(UserId);
            myPlant = (ArrayList<MyplantVo>) myPlantMapper.selectMyPlants(UserId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



        return myPlant;
    }


    public boolean registMyPlant(MyplantVo myplantVo) {
        boolean flag = false;

        try {
            flag = myPlantMapper.insertMyplant(myplantVo);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return flag;
    }

    public void deleteMyPlant(int myplantId) {
        myPlantMapper.deleleMyplant(myplantId);
    }

    public MyplantVo myPlantDetail(int myplantId) {
        MyplantVo myplantVo = new MyplantVo();
        myplantVo = (MyplantVo)myPlantMapper.searchPlant(myplantId);
        return myplantVo;
    }

    public ArrayList<PlantVo> searchPlantInfo(String plantId) {
        ArrayList<PlantVo> plantVo = new ArrayList<>();
        plantVo = (ArrayList<PlantVo>)myPlantMapper.selectPlantInfo(plantId);
        return plantVo;
    }

    public void editMyPlantInfo(MyplantVo myplantVo) {
        myPlantMapper.editMyPlant(myplantVo);
    }

    public PlantVo searchPlantToNum(int plantId) {
        PlantVo plantVo = myPlantMapper.searchPlantToNum(plantId);
        return plantVo;
    }
    public void registRepresent(String userId,int myplantId) {
        myPlantMapper.registRepresent(userId);
        myPlantMapper.registRepresent2(myplantId);


    }

    public boolean insertWebPushData(int myplantId,int dayInput, String timeInput) {
       boolean flag = myPlantMapper.insertWebPushData(myplantId,dayInput,timeInput);
        return flag;
    }


    public boolean point(long todayInDays) {
        boolean flag = myPlantMapper.point(todayInDays);
        return flag;
    }

    public boolean saveFiles(MyplantVo myplantVo) {
        boolean flag = false;
        flag = myPlantMapper.insertFiles(myplantVo);
        return flag;
    }
}