package com.plant.controller;

import com.plant.service.RecomService;
import com.plant.utils.ApiKey;
import com.plant.utils.ShopApi;
import com.plant.vo.PlantVo;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/suggestions")
public class RecomController {

    @Autowired
    private RecomService recomService;
    @Autowired
    private ApiKey apiKeys;
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    /* 추천 결과 보기 */
    @GetMapping(value="/result")
    public ModelAndView getResultList(@ModelAttribute PlantVo plantVo) {
        ModelAndView mv = new ModelAndView("/suggestions/result");
        ArrayList<PlantVo> resultList = recomService.getResultList(plantVo);

        String mapApiKey = apiKeys.getKakaomapKey();

        mv.addObject("resultList", resultList);
        mv.addObject("mapApiKey", mapApiKey);
        logger.info("[RecomController Controller] getResultList()");
        return mv;
    }

    /* 추천 결과 저장 */
    @PostMapping(value="/result")
    public ResponseEntity<Boolean> saveResultList(@ModelAttribute("idxList") String plantIds, HttpSession session) {
        boolean flag = false;
        boolean cntFlag = false;

        UserVo user = (UserVo) session.getAttribute("user");
        String userId = user.getUserId();

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
