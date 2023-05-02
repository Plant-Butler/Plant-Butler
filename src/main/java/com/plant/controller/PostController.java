package com.plant.controller;

import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.plant.service.PostService;
import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;


@RestController
@RequestMapping("/community")
public class PostController {
	
	@Autowired
	private PostService postService;
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	
	/* 커뮤니티 메인 페이지 */	
	@GetMapping(" ")
	public ModelAndView main() throws SQLException {
	    logger.info("커뮤니티 메인 페이지 호출");
	    List<PostVo> postList = postService.getAllPosts();
	    ModelAndView modelAndView = new ModelAndView();
	    modelAndView.addObject("postList", postList);
	    modelAndView.setViewName("/community/cmain");
	    return modelAndView;
	}

	
	/* 새로운 게시물 등록 폼 */	
	@GetMapping("/form")
	public ModelAndView newform() {
		ModelAndView mv = new ModelAndView("/community/newPost");
		logger.info("게시물 등록 페이지 호출");
		return mv;
	}
	
	/* 새로운 게시물 등록 */	
	@PostMapping("/form")
	public ResponseEntity<String> upload(
	    @RequestParam(value="userId") String userId,
	    @RequestParam(value="postTitle") String postTitle,
	    @RequestParam(value="postContent") String postContent,
	    @RequestParam(value="postTag", required=false) String postTag,
	    @RequestParam(value="postImage", required=false) MultipartFile image,
	    @RequestParam(value="postFile", required=false) MultipartFile file,
	    @RequestParam(value="selectedPlants", required=false) List<String> selectedPlants,
	    RedirectAttributes redirectAttributes) throws SQLException {
	    try {
	        // 업로드된 파일을 저장할 디렉토리를 지정합니다.
	        String uploadImage = "D://ml/image";
	        File dir = new File(uploadImage);
	        if (!dir.exists()) {
	            dir.mkdir();
	        }
	        String uploadFile = "D://ml/file";
	        File dir2 = new File(uploadFile);
	        if (!dir2.exists()) {
	            dir2.mkdir();
	        }

	        // 이미지 파일을 저장합니다.
	        String imagePath = null;
	        if (image != null && !image.isEmpty()) {
	            String imageName = image.getOriginalFilename();
	            File uploadedImage = new File(uploadImage + "/" + imageName);
	            image.transferTo(uploadedImage);
	            imagePath = uploadedImage.getAbsolutePath();
	        }

	        // 파일을 저장합니다.
	        String filePath = null;
	        if (file != null && !file.isEmpty()) {
	            String fileName = file.getOriginalFilename();
	            File uploadedFile = new File(uploadFile + "/" + fileName);
	            file.transferTo(uploadedFile);
	            filePath = uploadedFile.getAbsolutePath();
	        }

	        // 파일 경로를 post 객체에 저장합니다.
	        PostVo post = new PostVo();
	        post.setUserId(userId);
	        post.setPostTitle(postTitle);
	        post.setPostContent(postContent);
	        post.setPostTag(postTag);
	        post.setPostImage(imagePath);
	        post.setSelectedPlants(selectedPlants);
	        post.setPostFile(filePath);

	        boolean flag = postService.saveItem(post);
	        boolean flag2 = postService.saveItem2(post);
	        if (flag) {
	        	boolean flag3 = postService.writepoint(post);
	            String redirectUrl = "/community"; // 리다이렉트할 URL
	            URI location = ServletUriComponentsBuilder.fromCurrentContextPath()
	                .path(redirectUrl)
	                .build()
	                .toUri();
	            redirectAttributes.addAttribute("success", "true"); // 성공 여부를 파라미터로 전달
	            return ResponseEntity.status(HttpStatus.FOUND)
	                .location(location)
	                .build();
	        } else {
	            redirectAttributes.addAttribute("success", "false"); // 실패 여부를 파라미터로 전달
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	        }

	    } catch (IOException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	   
	    }

	}
	/* 게시물 수정 폼 */
	@GetMapping("/form/{postId}")
	public ModelAndView updateForm(@PathVariable int postId) {
		ModelAndView mv = new ModelAndView("/community/updateForm");
		logger.info("게시물 수정 폼 호출");
		return mv;
	}
	
	/* 게시물 수정 */	
	@PutMapping("/{postId}")
	public ResponseEntity<String> update(
			@PathVariable int postId,
			@RequestParam(value="userId") String userId,
			@RequestParam(value="postTitle") String postTitle,
			@RequestParam(value="postContent") String postContent,
			@RequestParam(value="postImage", required=false) MultipartFile image,
	        @RequestParam(value="postFile", required=false) MultipartFile file,
	        RedirectAttributes redirectAttributes) throws SQLException {
	    try {
	        String uploadImage = "D://ml/image";
	        File dir = new File(uploadImage);
	        if (!dir.exists()) {
	            dir.mkdir();
	        }
	        String uploadFile = "D://ml/file";
	        File dir2 = new File(uploadFile);
	        if (!dir2.exists()) {
	        	dir2.mkdir();
	        }
	        String imageName = image.getOriginalFilename();
	        System.out.println(imageName);
	        File uploadedImage = new File(uploadImage + "/" + imageName);
	        System.out.println(uploadedImage);
	        image.transferTo(uploadedImage);
	        System.out.println("here2");
	        
	        String fileName = file.getOriginalFilename();
	        System.out.println(fileName);
	        File uploadedFile = new File(uploadFile + "/" + fileName);
	        System.out.println(uploadedFile);
	        file.transferTo(uploadedFile);
	        System.out.println("file");
	        // 파일 경로를 post 객체에 저장합니다.
	        PostVo post = new PostVo();
	        post.setUserId(userId);
	        post.setPostTitle(postTitle);
	        post.setPostContent(postContent);
	        post.setPostImage(uploadedImage.getAbsolutePath());
	        post.setPostFile(uploadedFile.getAbsolutePath());
	        boolean flag = postService.updateItem(post);
	        
	        if (flag) {
	            String redirectUrl = "/community"; 
	            URI location = ServletUriComponentsBuilder.fromCurrentContextPath()
	                    .path(redirectUrl)
	                    .build()
	                    .toUri();
	            redirectAttributes.addAttribute("success", "true"); 
	            return ResponseEntity.status(HttpStatus.FOUND)
	                    .location(location)
	                    .build();
	        } else {
	            redirectAttributes.addAttribute("success", "false"); 
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	        }

	    } catch (IOException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
	}

	
	/* 게시물 삭제 */
	@DeleteMapping(value="/{postId}")
	public ResponseEntity<?> remove(@RequestParam("postId") int postId) {
	    logger.info("게시글 삭제 postId={}", postId);
	    boolean flag = postService.removeItem(postId);
	    if (flag) {
	        return ResponseEntity.ok().build();
	    } else {
	        return ResponseEntity.badRequest().build();
	    }
	}
	
	/* 내 식물 리스트 보여주기 */
	@GetMapping(value="/plantall")
	public ResponseEntity<?> plantall(@RequestParam("userId") String userId) {
		List<MyplantVo> plantList = postService.plantall(userId);
	    List<MyplantVo> resultList = new ArrayList<>();
	    for (int i=0; i< plantList.size(); i++) {
	    	resultList.add(plantList.get(i));
	    }
	    if (resultList != null) {
	        return ResponseEntity.ok(resultList);
	    } else {
	        return ResponseEntity.badRequest().build();
	    }
	}



}
