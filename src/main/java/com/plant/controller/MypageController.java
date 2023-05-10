package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.CommentService;
import com.plant.service.MypageService;
import com.plant.service.PostService;
import com.plant.vo.CommentVo;
import com.plant.vo.PlantVo;
import com.plant.vo.PostVo;
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
import java.net.URI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

@RestController
@RequestMapping("/mypage")
public class MypageController {

    @Autowired
    private MypageService mypageService;
    @Autowired
    private PostService postService;
    @Autowired
    private CommentService commentService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 마이페이지 이동 (로그인 후) */
    @GetMapping(value=" ")
    public ModelAndView openMypage(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/mypage/mypage");
        HttpSession session = request.getSession();
        UserVo userVo = (UserVo) session.getAttribute("user");
        String userId = userVo.getUserId();;
        mv.addObject("userId", userId);
        return mv;
    }

    /* 회원정보 수정 페이지 이동 */
    @GetMapping(value="/{userId}")
    public ModelAndView openUpdatePage(@PathVariable String userId) {
        ModelAndView mv = new ModelAndView("/mypage/myUpdate");
        return mv;
    }

    /* 회원정보 수정 */
    @PutMapping(value="/{userId}")
    public ResponseEntity<Map<String, Object>> updateMypage(@ModelAttribute UserVo user) {
        boolean flag = mypageService.updateMypage(user);

        logger.info("[Mypage Controller] updateMypage(user)");
        System.out.println("user = " + user.getPassword());
        HttpHeaders headers = new HttpHeaders();
        if(flag) {
            headers.setLocation(URI.create("/mypage/" + user.getUserId()));
            return new ResponseEntity<>(headers, HttpStatus.SEE_OTHER);
        } else {
            return new ResponseEntity<>( headers, HttpStatus.BAD_REQUEST);
        }

    }

    /* 내 게시물, 댓글 모아보기 */
    @GetMapping(value="/community/{userId}")
    public ModelAndView myCommunity(@PathVariable String userId,
                                    @RequestParam(defaultValue = "1") int postPage,
                                    @RequestParam(defaultValue = "1") int commentPage) {
        ModelAndView mv = new ModelAndView("/mypage/myCommunity");

        PageInfo<PostVo> postList = mypageService.myPostList(userId, postPage, 10);
        PageInfo<CommentVo> commentList = mypageService.myCommentList(userId, commentPage, 10);
        mv.addObject("postList", postList);
        mv.addObject("commentList", commentList);

        return mv;
    }

    /* 게시물, 댓글 선택삭제 */
    @DeleteMapping(value="/community")
    public ResponseEntity<Boolean> remove(@RequestParam Map<String, String> map) {
        boolean flag = false;

        String list = map.get("idxList");
        ArrayList<String> idxList = new ArrayList<>(Arrays.asList(list.split(",")));
        int num = Integer.parseInt(map.get("num"));

        // 게시물
        if(num == 0) {
            for(String idx : idxList) {
                int postId = Integer.parseInt(idx);
                flag = postService.removeItem(postId);
                if (!flag) {
                    break;
                }
            }
        // 댓글
        } else if (num == 1){
            for(String idx : idxList) {
                int commentId = Integer.parseInt(idx);
                flag = commentService.deleteComment(commentId);
                if (!flag) {
                    break;
                }
            }
        }

        if(flag) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }
    }

    /* 반려식물 추천 서비스 결과 */
    @GetMapping(value="/suggestions/{userId}")
    public ModelAndView myRecom(@PathVariable String userId) {
        ModelAndView mv = new ModelAndView("/mypage/myRecom");

        ArrayList<PlantVo> recomPlantList = mypageService.myRecomList(userId);
        mv.addObject("recomPlantList", recomPlantList);

        return mv;
    }
}
