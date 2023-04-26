package com.plant.vo;

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
