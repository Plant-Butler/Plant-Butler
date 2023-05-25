package com.plant.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class ApiKey {

    // 네이버 쇼핑 검색
    @Value("${navershop-key}")
    private String navershopKey;
    @Value("${navershop-pass}")
    private String navershopPass;

    // 카카오 맵
    @Value("${kakaomap-key}")
    private String kakaomapKey;

    //기상청 날씨, 미세먼지
    @Value("${gisang-key}")
    private String gisangKey;
    @Value("${mise-key}")
    private String miseKey;

    public String getNavershopKey() {
        return navershopKey;
    }

    public String getNavershopPass() {
        return navershopPass;
    }

    public String getKakaomapKey() {
        return kakaomapKey;
    }

    public String getGisangKey(){return gisangKey;}

    public String getMiseKey(){return miseKey;}
}
