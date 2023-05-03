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
    private int myplantWeight; // 화분 가로
    private int myplantLength; // 화분 세로
    private int myplantDepth;  // 화분 깊이
    private int myplantRadius1; // 화분 반지름1
    private int myplantRadius2; // 화분 반지름2
    private Date firstDate;



    public MyplantVo() {

    }

    public MyplantVo(int myplantId, int plantId, String userId, String myplantNick, String myplantImage, int myplantWeight, int myplantLength, int myplantDepth, int myplantRadius1, int myplantRadius2, Date firstDate) {
        this.myplantId = myplantId;
        this.plantId = plantId;
        this.userId = userId;
        this.myplantNick = myplantNick;
        this.myplantImage = myplantImage;
        this.myplantWeight = myplantWeight;
        this.myplantLength = myplantLength;
        this.myplantDepth = myplantDepth;
        this.myplantRadius1 = myplantRadius1;
        this.myplantRadius2 = myplantRadius2;
        this.firstDate = firstDate;
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

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
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

    public int getMyplantWeight() {
        return myplantWeight;
    }

    public void setMyplantWeight(int myplantWeight) {
        this.myplantWeight = myplantWeight;
    }

    public int getMyplantLength() {
        return myplantLength;
    }

    public void setMyplantLength(int myplantLength) {
        this.myplantLength = myplantLength;
    }

    public int getMyplantDepth() {
        return myplantDepth;
    }

    public void setMyplantDepth(int myplantDepth) {
        this.myplantDepth = myplantDepth;
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

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getDistbNm() {
        return distbNm;
    }

    public void setDistbNm(String distbNm) {
        this.distbNm = distbNm;
    }

    @Override
    public String toString() {
        return "MyplantVo{" +
                "myplantId=" + myplantId +
                ", plantId=" + plantId +
                ", userId='" + userId + '\'' +
                ", myplantNick='" + myplantNick + '\'' +
                ", myplantImage='" + myplantImage + '\'' +
                ", myplantWeight=" + myplantWeight +
                ", myplantLength=" + myplantLength +
                ", myplantDepth=" + myplantDepth +
                ", myplantRadius1=" + myplantRadius1 +
                ", myplantRadius2=" + myplantRadius2 +
                ", firstDate=" + firstDate +
                '}';
    }
}
