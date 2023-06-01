package com.plant.vo;

public class UserVo {

    private String userId;
    private String nickname;
    private String password;
    private String email;
    private int point;
    private int manager;

    private String token;

    public UserVo() {}

    public UserVo(String nickname, String password, String email) {
        this.nickname = nickname;
        this.password = password;
        this.email = email;
    }

    public UserVo(String userId, String nickname, String password, String email, int point, int manager, String token) {
        this.userId = userId;
        this.nickname = nickname;
        this.password = password;
        this.email = email;
        this.point = point;
        this.manager = manager;
        this.token = token;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getPoint() {
        return point;
    }

    public void setPoint(int point) {
        this.point = point;
    }

    public int getManager() {
        return manager;
    }

    public void setManager(int manager) {
        this.manager = manager;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}