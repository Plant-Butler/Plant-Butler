package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.CommentService;
import com.plant.service.PostService;
import com.plant.vo.CommentVo;
import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URI;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


@RestController
@RequestMapping("/community")
public class PostController {

    @Autowired
    private PostService postService;
    @Autowired
    private CommentService commentService;
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    /* 게시물 상세보기 */
    @GetMapping("/{postId}")
    public ModelAndView postDetail(@PathVariable int postId,
                                   @RequestParam(defaultValue = "1")Integer pageNum, @RequestParam(defaultValue = "15") Integer pageSize) {
        ModelAndView mv = new ModelAndView("/community/postDetail");
        PostVo postVo = postService.postDetail(postId);
        ArrayList<MyplantVo> myPlantList = postService.postMyPlantDetail(postId);
        //ArrayList<CommentVo> commentList = commentService.getCommentList(postId);

        PageInfo<CommentVo> commentList = commentService.getCommentList(postId, pageNum , pageSize);
        mv.addObject("post", postVo);
        mv.addObject("commentList", commentList);
        mv.addObject("myPlantList", myPlantList);

        return mv;
    }

    /* 첨부파일 다운로드 */
	@GetMapping("/download.do")
	public void download(@RequestParam("fileName") String encodedFileName, HttpServletResponse resp) throws IOException {
		String fileName = URLDecoder.decode(encodedFileName, StandardCharsets.UTF_8);
		String basePath = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/src/main/resources/static/uploads";
		File downloadFile = new File(basePath, fileName);
		fileName = URLEncoder.encode(fileName, "UTF-8");
		resp.setContentType("application/octet-stream");
		resp.setHeader("Cache-Control", "no-cache");
		resp.addHeader("Content-Disposition", "attachment;filename=" + fileName);
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

    /* 게시물 신고 */
    @PatchMapping("/{postId}")
    public ResponseEntity declarePost(@PathVariable int postId) {
        boolean flag = postService.declarePost(postId);

        logger.info("[Post Controller] declarePost(postId)");
        if(flag) {
            return new ResponseEntity<>(HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
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
			@ModelAttribute("post") PostVo post,
			@RequestParam(value="postMultiImage", required=false) List<MultipartFile> image,
			@RequestParam(value="postMultiFile", required=false) MultipartFile file,
			@RequestParam(value="selectedPlants", required=false) List<String> selectedPlants,
			RedirectAttributes redirectAttributes) {
	    try {
	        // 파일 저장할 디렉토리를
	        String uploadFile = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/src/main/resources/static/uploads/";
	        File dir2 = new File(uploadFile);
	        if (!dir2.exists()) {
	            dir2.mkdir();
	        }


	        // 이미지 파일 저장
			List<MultipartFile> images = image;
			StringBuilder fileNames = new StringBuilder();
	        if (images!= null && !images.isEmpty()) {
				int imageCount = 0;
				for (MultipartFile image1 : images) {
					if (!image1.isEmpty()) {
						String fileName = Objects.requireNonNull(image1.getOriginalFilename());
						// 쉼표를 추가하기 전에 이미지 수 확인
						if (imageCount > 0) {
							fileNames.append(",");
						}
						fileNames.append(fileName);
						// 이미지 파일을 저장할 위치 지정
						String uploadPath = "D:/23-04-BIT-final-project-new/workspace/Plant-Butler/src/main/resources/static/uploads/";
						File uploadDir = new File(uploadPath);
						if (!uploadDir.exists()) {
							uploadDir.mkdirs();
						}
						try (InputStream inputStream = image1.getInputStream()) {
							Files.copy(inputStream, Paths.get(uploadPath + fileName), StandardCopyOption.REPLACE_EXISTING);
						} catch (IOException e) {
							e.printStackTrace();
						}
						imageCount++;
					}
				}
			}

	        // 파일 저장
	        String filePath = null;
			String fileName = null;
	        if (file != null && !file.isEmpty()) {
	            fileName = file.getOriginalFilename();
	            File uploadedFile = new File(uploadFile + "/" + fileName);
	            file.transferTo(uploadedFile);
	            filePath = uploadedFile.getAbsolutePath();
	        }

	        // 파일 경로 post 객체에 저장
	        post.setPostImage(fileNames.toString());
	        post.setSelectedPlants(selectedPlants);
	        post.setPostFile(fileName);

			// 태그 영어 -> 한글
			if(post.getPostTag().equals("information")) {
				post.setPostTag("정보 공유");
			} else if(post.getPostTag().equals("boast")) {
				post.setPostTag("식물 자랑");
			} else {
				post.setPostTag("수다 ");
			}

	        boolean flag = postService.saveItem(post);
			if(selectedPlants.isEmpty()) {
			} else {
				boolean flag2 = postService.saveItem2(post);
			}
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
		PostVo post = postService.postDetail(postId);
		mv.addObject("post", post);
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
		boolean flag = postService.removeItemMP(postId);
	    boolean flag2 = postService.removeItem(postId);
	    if (flag2) {
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
