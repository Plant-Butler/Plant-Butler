package com.plant.dao;
import com.plant.vo.MyplantVo;
import org.apache.ibatis.annotations.Mapper;
import java.sql.SQLException;
import java.util.ArrayList;


@Mapper
public interface MyPlantMapper {
	ArrayList<MyplantVo> selectMyPlants(String UserId) throws SQLException;

}
