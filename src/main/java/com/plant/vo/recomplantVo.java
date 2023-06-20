package com.plant.vo;


import io.swagger.annotations.ApiModel;

@ApiModel(value="반려식물 추천서비스 결과", description = "반려식물 추천서비스의 결과 식물 VO")
public class recomplantVo {
    private String userId;

    private int plantId;

    public recomplantVo() {
    }

    public recomplantVo(String userId, int plantId) {
        this.userId = userId;
        this.plantId = plantId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getPlantId() {
        return plantId;
    }

    public void setPlantId(int plantId) {
        this.plantId = plantId;
    }
}
