package com.plant.vo;

import io.swagger.annotations.ApiModel;

import java.sql.Timestamp;

@ApiModel(value="내 식물 관리기록", description = "내 식물 관리기록 (물, 영양제, 가지치기, 분갈이, 환기) VO")
public class ScheduleVo {
    private int scheduleId;
    private int myplantId;
    private String userId;
    private Timestamp scheduleDate;
    private int watering;   // 물
    private int nutri;      // 영양제
    private int prun;       // 가지치기
    private int soil;       // 분갈이
    private int ventilation;// 환기

    public ScheduleVo() {}

    public ScheduleVo(int scheduleId, int myplantId, String userId, Timestamp scheduleDate, int watering, int nutri, int prun, int soil, int ventilation) {
        this.scheduleId = scheduleId;
        this.myplantId = myplantId;
        this.userId = userId;
        this.scheduleDate = scheduleDate;
        this.watering = watering;
        this.nutri = nutri;
        this.prun = prun;
        this.soil = soil;
        this.ventilation = ventilation;
    }

    public ScheduleVo(int myplantId, Timestamp scheduleDate) {
        this.myplantId = myplantId;
        this.scheduleDate = scheduleDate;
    }

    public int getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(int scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Timestamp getScheduleDate() {
        return scheduleDate;
    }

    public void setScheduleDate(Timestamp scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    public int getMyplantId() {
        return myplantId;
    }

    public void setMyplantId(int myplantId) {
        this.myplantId = myplantId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public int getWatering() {
        return watering;
    }

    public void setWatering(int watering) {
        this.watering = watering;
    }

    public int getNutri() {
        return nutri;
    }

    public void setNutri(int nutri) {
        this.nutri = nutri;
    }

    public int getPrun() {
        return prun;
    }

    public void setPrun(int prun) {
        this.prun = prun;
    }

    public int getSoil() {
        return soil;
    }

    public void setSoil(int soil) {
        this.soil = soil;
    }

    public int getVentilation() {
        return ventilation;
    }

    public void setVentilation(int ventilation) {
        this.ventilation = ventilation;
    }

    @Override
    public String toString() {
        return "ScheduleVo{" +
                "scheduleId=" + scheduleId +
                ", myplantId=" + myplantId +
                ", userId='" + userId + '\'' +
                ", scheduleDate=" + scheduleDate +
                ", watering=" + watering +
                ", nutri=" + nutri +
                ", prun=" + prun +
                ", soil=" + soil +
                ", ventilation=" + ventilation +
                '}';
    }
}
