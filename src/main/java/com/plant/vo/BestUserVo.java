package com.plant.vo;

public class BestUserVo {

    private String userId;
    private String nickname;
    private String myplantImage;
    private String distbNm;
    private String myplantNick;

    public BestUserVo() {}

    public BestUserVo(String userId, String nickname, String myplantImage, String distbNm, String myplantNick) {
        this.userId = userId;
        this.nickname = nickname;
        this.myplantImage = myplantImage;
        this.distbNm = distbNm;
        this.myplantNick = myplantNick;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getMyplantImage() {
        return myplantImage;
    }

    public void setMyplantImage(String myplantImage) {
        this.myplantImage = myplantImage;
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
}
