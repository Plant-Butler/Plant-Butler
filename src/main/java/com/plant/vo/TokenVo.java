package com.plant.vo;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.index.Indexed;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.Collection;

@Document(collection = "tokens")
public class TokenVo {

    private String userId;

    @Id
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