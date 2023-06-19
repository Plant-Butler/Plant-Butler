package com.plant.dao;

import com.plant.vo.MyplantVo;
import com.plant.vo.PlantVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.sql.SQLException;
import java.util.ArrayList;


@Mapper
public interface MyPlantMapper {

	ArrayList<MyplantVo> selectMyPlants(String UserId) throws SQLException;

	boolean insertMyplant(MyplantVo myplantVo) throws SQLException;

	void deleleMyplant(int myplantId);

	MyplantVo searchPlant(int myplantId);

	ArrayList<PlantVo> selectPlantInfo(String plantId);

    void editMyPlant(MyplantVo myplantVo);

	PlantVo searchPlantToNum(int plantId);

	void registRepresent(@Param("userId") String userId);

	void registRepresent2(@Param("myplantId") int myplantId);


    boolean insertWebPushData(@Param("myplantId") int myplantId,@Param("dayInput") int dayInput, @Param("timeInput") String timeInput);

	boolean point(long todayInDays);

    boolean insertFiles(MyplantVo myplantVo);
}