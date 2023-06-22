package com.plant.controller;

import com.github.pagehelper.PageInfo;
import com.plant.service.*;
import com.plant.vo.CommentVo;
import com.plant.vo.MyplantVo;
import com.plant.vo.PostVo;
import com.plant.vo.UserVo;
import io.swagger.annotations.Api;
import io.swagger.v3.oas.annotations.Operation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URI;
import java.sql.SQLException;
import java.util.*;

@RestController
@RequestMapping("/community")
@Api(tags = "커뮤니티 게시물 API")
public class PostController {

	private final PostService postService;
	private final CommentService commentService;
	private final MainService mainService;
	private final UserService userService;
	private final S3Service s3Service;
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	public PostController(PostService postService, CommentService commentService, MainService mainService, UserService userService, S3Service s3Service) {
		this.postService = postService;
		this.commentService = commentService;
		this.mainService = mainService;
		this.userService = userService;
		this.s3Service = s3Service;
	}

	/* 게시물 상세보기 */
	@GetMapping("/{postId}")
	@Operation(summary = "게시물 상세보기", description = "커뮤니티에 작성된 게시물을 상세 조회합니다.")
	public ModelAndView postDetail(@PathVariable int postId,
								   @RequestParam(defaultValue = "1")Integer pageNum, @RequestParam(defaultValue = "15") Integer pageSize) {
		ModelAndView mv = new ModelAndView("/community/postDetail");
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserVo user = null;
		if (authentication.getPrincipal() != "anonymousUser") {
			user = (UserVo) authentication.getPrincipal();
			String userId = "";
			if (user != null) {
				userId = user.getUserId();
				int alreadyHeart = this.searchHeart(postId, userId);
				mv.addObject("alreadyHeart", alreadyHeart);
			}
		}

		// 게시물 내용
		PostVo postVo = postService.postDetail(postId);
		PageInfo<CommentVo> commentList = commentService.getCommentList(postId, pageNum, pageSize);
		mv.addObject("post", postVo);
		mv.addObject("commentList", commentList);
		mv.addObject("user", user);

		// 댓글 수
		int commentCount = mainService.getCommentCount(postId);
		mv.addObject("commentCount", commentCount);

		// 좋아요 수
		int countHeart = postService.countHeart(postId);
		mv.addObject("countHeart", countHeart);

		// 첨부된 내 식물
		ArrayList<MyplantVo> myPlantList = postService.postMyPlantDetail(postId);
		for(MyplantVo vo : myPlantList) {
			String imageList = vo.getMyplantImage();
			if(imageList != null) {
				StringTokenizer images = new StringTokenizer(imageList, ",");
				String imageUrl = null;
				while(images.hasMoreTokens()) {
					imageUrl = s3Service.getUrl(images.nextToken(), "myplant", vo.getMyplantId());
					vo.setMyplantImage(imageUrl);
				}
			}
		}
		mv.addObject("myPlantList", myPlantList);


		// 이미지
		String imageList = postVo.getPostImage();
		if(imageList != null) {
			StringTokenizer images = new StringTokenizer(imageList, ",");
			ArrayList<String> imageUrls = new ArrayList<>();
			while(images.hasMoreTokens()) {
				String imageUrl = s3Service.getUrl(images.nextToken(), "post", postId);
				imageUrls.add(imageUrl);
			}
			mv.addObject("imageUrls", imageUrls);
		}

        return mv;
    }

    /* 첨부파일 다운로드 */
	@GetMapping("/download/{postId}/{oriFileName}")
	@Operation(summary = "첨부파일 다운로드", description = "게시물 상세조회 시 첨부된 파일을 다운로드합니다.")
	public ResponseEntity<byte[]> download(@PathVariable int postId, @PathVariable String oriFileName) throws IOException {
		return s3Service.getObject(oriFileName, "post", postId);
	}

	/* 게시물 신고 */
	@PatchMapping("/{postId}")
	@Operation(summary = "게시물 신고", description = "로그인 유저가 커뮤니티에 작성된 게시물을 신고합니다.")
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
	@Operation(summary = "게시물 작성 폼 오픈", description = "로그인 유저가 게시물 작성을 위해 작성폼을 엽니다.")
	public ModelAndView newform() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserVo user = (UserVo) authentication.getPrincipal();
		ModelAndView mv = new ModelAndView("/community/newPost");
		mv.addObject("userVo",user);
		logger.info("게시물 등록 페이지 호출");
		return mv;
	}

	/* 새로운 게시물 등록 */
	@PostMapping("/form")
	@Operation(summary = "게시물 작성", description = "로그인 유저가 이미지, 첨부파일 등을 포함한 게시물을 작성합니다.")
	public ResponseEntity<String> upload(
			@ModelAttribute("post") PostVo post,
			@RequestParam(value="postMultiImage", required=false) List<MultipartFile> images,
			@RequestParam(value="postMultiFile", required=false) MultipartFile file,
			@RequestParam(value="selectedPlants", required=false) List<String> selectedPlants,
			RedirectAttributes redirectAttributes) {

		// 첨부한 내 식물
		post.setSelectedPlants(selectedPlants);
		boolean flag = postService.saveItem(post);

		// 이미지 저장
		StringBuilder fileNames = new StringBuilder();
		if(images != null && images.stream().anyMatch(image -> ! image.isEmpty())) {
			int imageCount = 0;
			for(MultipartFile image : images) {
				try {
					s3Service.upload(image, "post", post.getPostId());
					String fileName = Objects.requireNonNull(image.getOriginalFilename());
					if (imageCount > 0) {
						fileNames.append(",");
					}
					fileNames.append(fileName);
				} catch (IOException e) {
					throw new RuntimeException("이미지 업로드 오류", e);
				}
				imageCount++;
			}
		}
		post.setPostImage(fileNames.toString());

		// 첨부파일 저장
		if(!file.isEmpty()) {
			try {
				s3Service.upload(file, "post", post.getPostId());
			} catch (IOException e) {
				throw new RuntimeException("첨부파일 업로드 오류", e);
			}
			post.setPostFile(file.getOriginalFilename());
		}

		boolean flag2 = postService.saveFiles(post);


		boolean flag3 = false;
		if(!selectedPlants.isEmpty()) {
			flag3 = postService.saveItem2(post);
		}

		if (flag || flag2 || flag3) {
	    	boolean flag4 = postService.writepoint(post);

			// 포인트 Authentication 반영
			UserVo userVo = userService.getUserVo();
			userService.getNewPoint(userVo, userVo.getUserId());

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
	}

	/* 게시물 수정 폼 */
	@GetMapping("/form/{postId}")
	@Operation(summary = "게시물 수정 폼 오픈", description = "로그인 유저가 게시물 수정을 위해 수정폼을 엽니다.")
	public ModelAndView updateForm(@PathVariable int postId) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserVo user = (UserVo) authentication.getPrincipal();
		String userId = user.getUserId();
		ModelAndView mv = new ModelAndView("/community/updateForm");
		PostVo post = postService.postDetail(postId);
		mv.addObject("userId",userId);
		mv.addObject("post", post);

		// 이미지
		String imageList = post.getPostImage();
		if(imageList != null) {
			StringTokenizer images = new StringTokenizer(imageList, ",");
			ArrayList<String> imageUrls = new ArrayList<>();
			while(images.hasMoreTokens()) {
				String imageUrl = s3Service.getUrl(images.nextToken(), "post", postId);
				imageUrls.add(imageUrl);
			}
			mv.addObject("imageUrls", imageUrls);
		}

		logger.info("게시물 수정 폼 호출");
		return mv;
	}

	/* 게시물 수정 */
	@PutMapping("/{postId}")
	@Operation(summary = "게시물 수정", description = "로그인 유저가 제목, 내용, 이미지, 첨부파일을 포함한 게시물을 수정합니다.")
	public ResponseEntity<String> update(
			@PathVariable int postId,
			@ModelAttribute PostVo post,
			@RequestParam(value="postMultiImage", required=false) List<MultipartFile> images,
			@RequestParam(value="postMultiFile", required=false) MultipartFile file) throws SQLException {

		// 기존 이미지 및 파일 삭제
		PostVo oriPost = postService.postDetail(postId);
		s3Service.delete(oriPost.getPostFile(), "post" , postId);
		String imageList = oriPost.getPostImage();
		if(imageList != null) {
			StringTokenizer oriImages = new StringTokenizer(imageList, ",");
			while(oriImages.hasMoreTokens()) {
				s3Service.delete(oriImages.nextToken(), "post" , postId);
			}
		}

		// 이미지 저장
		StringBuilder fileNames = new StringBuilder();
		if(images != null && images.stream().anyMatch(image -> ! image.isEmpty())) {
			int imageCount = 0;
			for(MultipartFile image : images) {
				try {
					s3Service.upload(image, "post", post.getPostId());
					String fileName = Objects.requireNonNull(image.getOriginalFilename());
					if (imageCount > 0) {
						fileNames.append(",");
					}
					fileNames.append(fileName);
				} catch (IOException e) {
					throw new RuntimeException("이미지 업로드 오류", e);
				}
				imageCount++;
			}
		}
		post.setPostImage(fileNames.toString());

		// 첨부파일 저장
		if(!file.isEmpty()) {
			try {
				s3Service.upload(file, "post", post.getPostId());
			} catch (IOException e) {
				throw new RuntimeException("첨부파일 업로드 오류", e);
			}
			post.setPostFile(file.getOriginalFilename());
		}

		boolean flag = postService.updateItem(post);
		if (flag) {
			boolean flag3 = postService.writepoint(post);
			return ResponseEntity.ok().build();
		} else {
			return ResponseEntity
					.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.build();
		}

	}

	/* 게시물 삭제 */
	@DeleteMapping(value="/{postId}")
	@Operation(summary = "게시물 삭제", description = "로그인 유저가 자신의 게시물을 삭제합니다.")
	public ResponseEntity<Void> remove(@RequestParam("postId") int postId) {
		logger.info("게시글 삭제 postId = " +  postId);
		boolean flag1 = postService.removeItemMP(postId);
		boolean flag2 = postService.removeItem(postId);
		if (flag2) {
			return ResponseEntity.ok().build();
		} else {
			return ResponseEntity.badRequest().build();
		}
	}

	/* 내 식물 리스트 보여주기 */
	@GetMapping(value="/plantall")
	@Operation(summary = "게시물 작성 시 내 식물 리스트", description = "로그인 유저가 게시물 작성 시 첨부할 내 식물 리스트를 가져옵니다.")
	public ResponseEntity<List<MyplantVo>> plantall(@RequestParam("userId") String userId) {
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

	/* 게시물 좋아요 */
	@PostMapping(value="/{postId}/heart")
	@Operation(summary = "게시물 좋아요", description = "로그인 유저가 게시물에 좋아요를 추가합니다.")
	public ResponseEntity<String> addHeart(@PathVariable int postId, HttpSession session) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		UserVo user = (UserVo) authentication.getPrincipal();
		String userId = user.getUserId();
		// 좋아요 눌려있는지 확인
		HashMap<String, Object> map = new HashMap<>();
		map.put("postId", postId);
		map.put("userId", userId);
		int alreadyHeart = this.searchHeart(postId, userId);
		boolean flag = false;
		String result = "";
		if (alreadyHeart == 0) {
			// 좋아요 추가
			flag = postService.addHeart(map);
			result = "add";
		} else {
			// 좋아요 취소
			flag = postService.deleteHeart(map);
			result = "delete";
		}

		if(flag) {
			return new ResponseEntity<>(result, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
		}
	}

	/* 게시물 좋아요 클릭한 적 있는지 확인 */
	public int searchHeart(int postId, String userId) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("postId", postId);
		map.put("userId", userId);
		int alreadyHeart = postService.searchHeart(map);

		return alreadyHeart;
	}

}
