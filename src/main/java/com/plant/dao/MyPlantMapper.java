package com.plant.dao;

import com.plant.vo.MyplantVo;
import com.plant.vo.PlantVo;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


@Mapper
public interface MyPlantMapper {

	ArrayList<MyplantVo> selectMyPlants(String UserId) throws SQLException;

	void insertMyplant(MyplantVo myplantVo) throws SQLException;

	void deleleMyplant(int myplantId);

	MyplantVo searchPlant(int myplantId);

	ArrayList<PlantVo> selectPlantInfo(String plantId);

    void editMyPlant(MyplantVo myplantVo);

	PlantVo searchPlantToNum(int plantId);

	void registRepresent(int result,int myplantId);

	void registRepresent2();


}