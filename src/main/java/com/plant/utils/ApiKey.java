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

    public String getNavershopKey() {
        return navershopKey;
    }

    public String getNavershopPass() {
        return navershopPass;
    }

    public String getKakaomapKey() {
        return kakaomapKey;
    }
}
