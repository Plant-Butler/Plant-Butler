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

    private final MyPlantMapper myPlantMapper;
    private Logger logger = LoggerFactory.getLogger(this.getClass());
    public MyPlantService(MyPlantMapper myPlantMapper) {
        this.myPlantMapper = myPlantMapper;
    }


    public ArrayList<MyplantVo> myPlantList(String userId) throws SQLException {
        return (ArrayList<MyplantVo>) myPlantMapper.selectMyPlants(userId);

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
    public boolean insertWebPushData2(int myplantId, int dayInput, String timeInput) {
        boolean flag = myPlantMapper.insertWebPushData2(myplantId,dayInput,timeInput);
        return flag;

    }

    public boolean insertWebPushData3(int myplantId, int dayInput, String timeInput) {
        boolean flag = myPlantMapper.insertWebPushData3(myplantId,dayInput,timeInput);
        return flag;
    }


    public boolean point(long todayInDays) {
        boolean flag = myPlantMapper.point(todayInDays);
        return flag;
    }

    public void deleteSchedule(int myplantId) {
        myPlantMapper.deleleMyPlantSchedule(myplantId);
    }


    public void deleteSchedule2(int myplantId) {
        myPlantMapper.deleleMyPlantSchedule2(myplantId);
    }

    public boolean saveFiles(MyplantVo myplantVo) {
        boolean flag = false;
        flag = myPlantMapper.insertFiles(myplantVo);
        return flag;
    }

    public void deleteSchedule3(int myplantId) {myPlantMapper.deleleMyPlantSchedule3(myplantId);}

}