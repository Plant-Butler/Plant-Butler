package com.plant.controller;

import com.plant.service.RecomService;
import com.plant.service.S3Service;
import com.plant.utils.ApiKey;
import com.plant.utils.ShopApi;
import com.plant.vo.PlantVo;
import com.plant.vo.UserVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.v3.oas.annotations.Operation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/suggestions")
@Api(tags = "반려식물 추천 서비스 API")
public class RecomController {

    private final RecomService recomService;
    private final S3Service s3Service;
    private final ApiKey apiKeys;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public RecomController(RecomService recomService, S3Service s3Service, ApiKey apiKeys) {
        this.recomService = recomService;
        this.s3Service = s3Service;
        this.apiKeys = apiKeys;
    }

    /* 추천 결과 보기 */
    @GetMapping(value="/result")
    @Operation(summary = "반려식물 추천 결과 보기", description = "반려식물 추천 서비스의 결과로 나온 반려식물 및 주변의 꽃집 정보 등을 출력합니다.")
    @ApiImplicitParam(name="plantVo", value="식물데이터 VO", paramType="query")
    public ModelAndView getResultList(@ModelAttribute PlantVo plantVo) {
        ModelAndView mv = new ModelAndView("/suggestions/result");
        ArrayList<PlantVo> resultList = recomService.getResultList(plantVo);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        String nickname = userVo.getNickname();

        String mapApiKey = apiKeys.getKakaomapKey();

        for(PlantVo vo : resultList) {
            String imageUrl = s3Service.getUrlwithFolder("plant-image", vo.getDistbNm());
            vo.setImage(imageUrl);
        }

        mv.addObject("resultList", resultList);
        mv.addObject("nickname", nickname);
        mv.addObject("mapApiKey", mapApiKey);
        logger.info("[RecomController Controller] getResultList()");
        return mv;
    }

    /* 추천 결과 저장 */
    @PostMapping(value="/result")
    @Operation(summary = "반려식물 추천 결과 저장", description = "반려식물 추천 서비스의 결과를 마이페이지에 저장합니다.")
    @ApiImplicitParam(name="idxList", value="추천 식물들의 id값", paramType="query")
    public ResponseEntity<Boolean> saveResultList(@ModelAttribute("idxList") String plantIds) {
        boolean flag = false;
        boolean cntFlag = false;

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        UserVo userVo = (UserVo) authentication.getPrincipal();
        String userId = userVo.getUserId();

        int already = recomService.getRecomCnt(userId);
        if(already > 0) {
            // 기존 결과 리셋
            cntFlag = recomService.deleteOriginal(userId);
        }

        ArrayList<String> plntIds = new ArrayList<>(Arrays.asList(plantIds.split(",")));
        HashMap<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        for (String id : plntIds) {
            int plantId = Integer.parseInt(id);
            map.put("plant_id", plantId);

            // 결과 저장
            flag = recomService.saveResultList(map);
            if (!flag) break;
        }

        logger.info("[RecomController Controller] saveResultList()");
        if(flag || (already>0 && cntFlag)) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }

    /* 추천 식물 상세정보 + 인터넷 쇼핑 상품정보
    *
    * 1. 추천받은 반려식물의 물주기, 배치장소 등 상세정보
    * 2. 해당 식물의 인터넷 쇼핑 상품정보
    * 3. 해당 식물에 적합한 토양의 인터넷 쇼핑 상품정보
    * 4. 해당 식물에 적합한 크기의 화분 인터넷 쇼핑 상품정보
    *
    */
    @GetMapping(value="/result/detail")
    @Operation(summary = "반려식물 추천 결과 식물 상세정보", description = "반려식물 추천 결과 식물의 상세정보 및 상품정보를 출력합니다.")
    @ApiImplicitParams({@ApiImplicitParam(name="plant_id", value="식물 id값", paramType="query"),
            @ApiImplicitParam(name="distbNm", value="식물명", paramType="query"),
            @ApiImplicitParam(name="soilInfo", value="토양정보", paramType="query")
    })
    public ResponseEntity<Map> getDetailInfo(@RequestParam("plant_id") int plantId, @RequestParam("distbNm") String distbNm,
                                       @RequestParam("soilInfo") String soilInfo) {
        Map<String, Object> resultMap = new HashMap<>();

        // 상세정보
        PlantVo plantVo = recomService.getPlantDetail(plantId);
        resultMap.put("plantVo", plantVo);

        // 인터넷 쇼핑 상품정보
        ShopApi shop = new ShopApi(apiKeys);

        int idealHg = recomService.calcPot(plantId).get("idealHg");
        int idealAra = recomService.calcPot(plantId).get("idealAra");

        String plantText = null;
        String soilText = null;
        String potText = null;
        try {
            plantText = URLEncoder.encode(distbNm, "UTF-8");
            soilText = URLEncoder.encode(soilInfo, "UTF-8");
            potText = URLEncoder.encode("화분 가로" + idealAra + "cm 세로 " + idealHg + "cm", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }

        String apiURL1 = "https://openapi.naver.com/v1/search/shop?query=" + plantText;
        String apiURL2 = "https://openapi.naver.com/v1/search/shop?query=" + soilText;
        String apiURL3 = "https://openapi.naver.com/v1/search/shop?query=" + potText;

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", shop.getClientId());
        requestHeaders.put("X-Naver-Client-Secret", shop.getClientSecret());
        String responseBody1 = shop.get(apiURL1,requestHeaders);
        String responseBody2 = shop.get(apiURL2,requestHeaders);
        String responseBody3 = shop.get(apiURL3,requestHeaders);

        resultMap.put("responseBody1", responseBody1);
        resultMap.put("responseBody2", responseBody2);
        resultMap.put("responseBody3", responseBody3);

        logger.info("[RecomController Controller] getDetailInfo()");
        return new ResponseEntity<>(resultMap, HttpStatus.OK);
    }
}
