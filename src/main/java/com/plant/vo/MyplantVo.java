package com.plant.vo;

import java.sql.Date;

public class MyplantVo {

    private int myplantId;

    private int plantId;
    private int postId;
    private String userId;
    private String distbNm;
    private String myplantNick;
    private String myplantImage;
    private int myplantPot; // 화분 가로
    private int myplantLength; // 화분 세로
    private int myplantRadius1; // 화분 반지름1
    private int myplantRadius2; // 화분 반지름2
    private Date firstDate;

    private int represent;

    private long scheduleDate;

    private int webPushDate;
    private String webPushTime;

    private int webPushDate2;
    private String webPushTime2;





    public MyplantVo() {

    }

    public MyplantVo(int myplantId, int plantId, String userId, String myplantNick, String myplantImage, int myplantPot, int myplantLength, int myplantRadius1, int myplantRadius2, Date firstDate, int represent, long scheduleDate,int webPushDate,String webPushTime,int webPushDate2,String webPushTime2) {
        this.myplantId = myplantId;
        this.plantId = plantId;
        this.userId = userId;
        this.myplantNick = myplantNick;
        this.myplantImage = myplantImage;
        this.myplantPot = myplantPot;
        this.myplantLength = myplantLength;
        this.myplantRadius1 = myplantRadius1;
        this.myplantRadius2 = myplantRadius2;
        this.firstDate = firstDate;
        this.represent = represent;
        this.scheduleDate = scheduleDate;
        this.webPushDate =  webPushDate;
        this.webPushTime = webPushTime;
        this.webPushDate2 =  webPushDate2;
        this.webPushTime2 = webPushTime2;
    }

    public int getMyplantId() {
        return myplantId;
    }

    public void setMyplantId(int myplantId) {
        this.myplantId = myplantId;
    }

    public int getPlantId() {
        return plantId;
    }

    public void setPlantId(int plantId) {
        this.plantId = plantId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getDistbNm() {
        return distbNm;
    }

    public void setDistbNm(String distbNm) {
        this.distbNm = distbNm;
    }

    public String getMyplantNick() {
        return myplantNick;
    }

    public void setMyplantNick(String myplantNick) {
        this.myplantNick = myplantNick;
    }

    public String getMyplantImage() {
        return myplantImage;
    }

    public void setMyplantImage(String myplantImage) {
        this.myplantImage = myplantImage;
    }

    public int getMyplantPot() {
        return myplantPot;
    }

    public void setMyplantPot(int myplantPot) {
        this.myplantPot = myplantPot;
    }

    public int getMyplantLength() {
        return myplantLength;
    }

    public void setMyplantLength(int myplantLength) {
        this.myplantLength = myplantLength;
    }


    public int getMyplantRadius1() {
        return myplantRadius1;
    }

    public void setMyplantRadius1(int myplantRadius1) {
        this.myplantRadius1 = myplantRadius1;
    }

    public int getMyplantRadius2() {
        return myplantRadius2;
    }

    public void setMyplantRadius2(int myplantRadius2) {
        this.myplantRadius2 = myplantRadius2;
    }

    public Date getFirstDate() {
        return firstDate;
    }

    public void setFirstDate(Date firstDate) {
        this.firstDate = firstDate;
    }

    public int getRepresent() {
        return represent;
    }

    public void setRepresent(int represent) {
        this.represent = represent;
    }

    public long getScheduleDate() {
        return scheduleDate;
    }

    public void setScheduleDate(long scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

    public int getWebPushDate() {
        return webPushDate;
    }

    public void setWebPushDate(int webPushDate) {
        this.webPushDate = webPushDate;
    }

    public String getWebPushTime() {
        return webPushTime;
    }

    public void setWebPushTime(String webPushTime) {
        this.webPushTime = webPushTime;
    }

    public int getWebPushDate2() {
        return webPushDate2;
    }

    public void setWebPushDate2(int webPushDate2) {
        this.webPushDate2 = webPushDate2;
    }

    public String getWebPushTime2() {
        return webPushTime2;
    }

    public void setWebPushTime2(String webPushTime2) {
        this.webPushTime2 = webPushTime2;
    }

    @Override
    public String toString() {
        return "MyplantVo{" +
                "myplantId=" + myplantId +
                ", plantId=" + plantId +
                ", postId=" + postId +
                ", userId='" + userId + '\'' +
                ", distbNm='" + distbNm + '\'' +
                ", myplantNick='" + myplantNick + '\'' +
                ", myplantImage='" + myplantImage + '\'' +
                ", myplantPot=" + myplantPot +
                ", myplantLength=" + myplantLength +
                ", myplantRadius1=" + myplantRadius1 +
                ", myplantRadius2=" + myplantRadius2 +
                ", firstDate=" + firstDate +
                ", represent=" + represent +
                ", scheduleDate=" + scheduleDate +
                ", webPushDate=" + webPushDate +
                ", webPushTime='" + webPushTime + '\'' +
                ", webPushDate2=" + webPushDate2 +
                ", webPushTime2='" + webPushTime2 + '\'' +
                '}';
    }
}
