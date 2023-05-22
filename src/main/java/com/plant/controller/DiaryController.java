package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.DiaryService;
import com.plant.vo.DiaryVo;
import com.plant.vo.UserVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/diaries")
public class DiaryController {

    @Autowired
    private DiaryService diaryService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());


    /* 전체 일기 조회 */
    @GetMapping(value="")
    public ModelAndView getDiaryList(@RequestParam(defaultValue = "1")Integer pageNum,
                                     @RequestParam(defaultValue = "10") Integer pageSize, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/diary/diaryList");

        HttpSession session = request.getSession();
        UserVo userVo = (UserVo) session.getAttribute("user");
        String userId = userVo.getUserId();

        PageInfo<DiaryVo> diaryList = diaryService.getDiaryList(userId, pageNum, pageSize);
        mv.addObject("diaryList", diaryList);
        logger.info("[Diary Controller] getDiaryList()");
        return mv;
    }

    /* 일기 상세조회 */
    @GetMapping(value="/{diaryId}")
    public ModelAndView getDiaryDetail(@PathVariable int diaryId) {
        ModelAndView mv = new ModelAndView("/diary/diaryDetail");
        DiaryVo diary = diaryService.getDiaryDetail(diaryId);

        mv.addObject("diary", diary);
        logger.info("[Diary Controller] getDiaryDetail()");
        return mv;
    }

    /* 일기 삭제 */
    @DeleteMapping(value="/{diaryId}")
    public ResponseEntity<Boolean> removeDiary(@PathVariable int diaryId) {
        boolean flag = false;

        flag = diaryService.removeDiary(diaryId);

        logger.info("[Diary Controller] removeDiary()");
        if(flag) {
            return new ResponseEntity<>(true, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(false, HttpStatus.BAD_REQUEST);
        }

    }

}
