package com.plant.controller;

import com.plant.service.PostService;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.*;

@RestController
@RequestMapping("/community")
public class PostController {

    @Autowired
    private PostService postService;
//    @Autowired
//    private CommentService commentService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 게시물 상세보기 */
    @GetMapping("/{postId}")
    public ModelAndView postDetail(@PathVariable int postId) {
        ModelAndView mv = new ModelAndView("/post/postDetail");
        PostVo postVo = postService.postDetail(postId);

        // 게시물
        mv.addObject("post", postVo);
        // 조회수 상승

        // 댓글

        return mv;
    }

    /* 첨부파일 다운로드 */
    @GetMapping("/download.do")
    public void download(@RequestParam("fileName") String fileName, HttpServletResponse resp) {
        File downloadFile = new File("D:\\23-02-bit-mini-01\\upload_files\\data\\"+fileName);

        try {
            fileName = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        resp.setContentType("text/html; charset=UTF-8");
        resp.setHeader("Cache-Control", "no-cache");
        resp.addHeader("Content-Disposition", "attachment;filename="+fileName);
        try {
            FileInputStream fis = new FileInputStream(downloadFile);
            OutputStream os = resp.getOutputStream();
            byte[] buffer = new byte[256];
            int length = 0;
            while((length=fis.read(buffer))!=-1){
                os.write(buffer, 0, length);
            }
            os.close();
            fis.close();
        } catch (FileNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }
}
