package com.plant.vo;

import java.sql.Timestamp;

public class MyplantVo {


	private int myplantId;

    private int plantId;

    private String userId;
    private String myplantNick;
    private String myplantImage;
    private int myplantWeight; // 화분 가로
    private int myplantLength; // 화분 세로
    private int myplantDepth;  // 화분 깊이
    private int myplantRadius1; // 화분 반지름1
    private int myplantRadius2; // 화분 반지름2
    private Timestamp firstDate;
    private UserVo user;
    public UserVo getUser() {
		return user;
	}

	public void setUser(UserVo user) {
		this.user = user;
	}

	public MyplantVo() {

    }

    public MyplantVo(int myplantId, int plantId, String userId, String myplantNick, String myplantImage, int myplantWeight, int myplantLength, int myplantDepth, int myplantRadius1, int myplantRadius2, Timestamp firstDate) {
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

    public Timestamp getFirstDate() {
        return firstDate;
    }

    public void setFirstDate(Timestamp firstDate) {
        this.firstDate = firstDate;
    }
}
