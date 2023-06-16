package com.plant.service;

import org.springframework.data.mongodb.repository.MongoRepository;
import com.plant.vo.TokenVo;
import org.springframework.data.mongodb.repository.Query;

import java.util.List;

public interface TokenRepository extends MongoRepository<TokenVo, String> {
    List<TokenVo> findByUserId(String userId);
    @Query("{ 'tokenNum' : ?0 }")
    TokenVo findByTokenNum(String token);
}