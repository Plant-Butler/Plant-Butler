package com.plant.vo;



public class TokenVo {

    private String userId;


    private String tokenNum;

    public TokenVo() {
    }

    public TokenVo(String userId, String tokenNum) {
        this.userId = userId;
        this.tokenNum = tokenNum;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getTokenNum() {
        return tokenNum;
    }

    public void setTokenNum(String tokenNum) {
        this.tokenNum = tokenNum;
    }

    @Override
    public String toString() {
        return "TokenVo{" +
                "userId='" + userId + '\'' +
                ", tokenNum='" + tokenNum + '\'' +
                '}';
    }
}
