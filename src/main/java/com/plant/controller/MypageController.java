package com.plant.controller;

import com.plant.service.MypageService;
import com.plant.utils.DynamicChangeScheduler;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.FileInputStream;
import java.net.URI;
import java.util.HashMap;
import java.util.Map;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.*;


@RestController
@RequestMapping("/mypage")
public class MypageController {

    @Autowired
    private DynamicChangeScheduler ps;
    @Autowired
    private MypageService mypageService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 마이페이지 이동 (로그인 후) */
    @GetMapping(value=" ")
    public ModelAndView openMypage(HttpServletRequest request) throws FirebaseMessagingException {
        ModelAndView mv = new ModelAndView("/mypage/mypage");
        HttpSession session = request.getSession();
        UserVo userVo = (UserVo) session.getAttribute("user");
        String userId = userVo.getUserId();;
        mv.addObject("userId", userId);

            Message message = Message.builder()
                    .putData("score", "이은서")
                    .putData("time", "너 너무 건방져")
                    .setToken("dVWGoN9HNhmtvZ2FlW06ei:APA91bGdNZeDPgD6EUeLGLC9PbAluNK4MRwp3hZNbVWHovUsOXGDl_WQvcxBO8oaPChVOfZinjVUNBL2ZfLlKOt_QbhZEBS3lb-7C7SYGE8xiGnO_TvruvXml0Ap17c1htVSOpfbE12v")
                    .build();
            String response = FirebaseMessaging.getInstance().send(message);
            System.out.println("Successfully sent message: " + response);

        return mv;
    }

    /* 회원정보 수정 페이지 이동 */
    @GetMapping(value="/{userId}")
    public ModelAndView openUpdatePage(@PathVariable String userId) {
        ModelAndView mv = new ModelAndView("/mypage/myUpdate");
        return mv;
    }

    /* 회원정보 수정 */
    @PatchMapping(value="/{userId}")
    public ResponseEntity<Map<String, Object>> updateMypage(@ModelAttribute("user") UserVo user) {
        boolean flag = mypageService.updateMypage(user);

        logger.info("[Comment Controller] updateMypage(user)");
        System.out.println("user = " + user.getPassword());
        Map<String, Object> result = new HashMap<>();
        HttpHeaders headers = new HttpHeaders();
        if(flag) {
            result.put("success", true);
            result.put("message", "수정되었습니다");
            headers.setLocation(URI.create("./" + user.getUserId()));
            return new ResponseEntity<>(result, headers, HttpStatus.SEE_OTHER);
        } else {
            return new ResponseEntity<>(result, headers, HttpStatus.BAD_REQUEST);
        }

    }

}
