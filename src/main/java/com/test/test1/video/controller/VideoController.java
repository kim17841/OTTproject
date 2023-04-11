package com.test.test1.video.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.test1.video.dto.CommentDto;
import com.test.test1.video.dto.VideoInteractionDto;
import com.test.test1.video.dto.RentalDTO;
import com.test.test1.algorithm.service.AlgorithmService;
import com.test.test1.user.service.UserService;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.dto.VideoEngDto;
import com.test.test1.video.service.CommentService;
import com.test.test1.video.service.InteractionService;
import com.test.test1.video.service.RentalService;
import com.test.test1.video.service.VideoService;

@Controller
@RequestMapping("/video/**")
public class VideoController { 
		
	@Autowired 
	VideoService videoService;
	
	@Autowired
	AlgorithmService algo;
	
	// 내보관함 페이지 구현 - 02.16 김범수
	@Autowired
	RentalService rentalService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	InteractionService interactionService;
	@Autowired
	UserService userService;
	
//	영상 전체조회 페이지 - 02.07 배철우
//	DTO 생성 후 DTO 활용하여 코드재생성 - 02.10 장민실
	public String access(HttpServletRequest request) {
		//URL접근 차단 - 02.18 장재호
		return request.getHeader("REFERER");
	}
	
	//영문버전 추가 - 03.06 장재호
	@RequestMapping("list")
	public ModelAndView list(ModelAndView mv, HttpSession ss, String language, HttpServletRequest request) {
		if(language != null) {
			ss.setAttribute("language", language);
		}
		if(ss.getAttribute("user_id") == null) {
			if(access(request) == null) {
				mv.addObject("error", "잘못된 접근입니다");
				mv.setViewName("redirect:/");
				return mv;
			}
			mv.addObject("error", "잘못된 접근입니다");
			mv.setViewName("redirect:/");
			return mv;
		}
		
		
		if(ss.getAttribute("user_id") != null) {
			ss.setAttribute("paid", userService.paidCheck((String)ss.getAttribute("user_id")));
		}
		List<VideoDto> list = videoService.list();
		if(ss.getAttribute("language") == "eng" || (language != null && language.contains("eng"))) {
			mv.setViewName("video/video_eng/list");
			ss.setAttribute("language", "eng");
		}
		else {
			ss.setAttribute("language", "kor");
			mv.setViewName("video/list");
		}
		mv.addObject("dto", list);		
		return mv;
	}

//	video_detail 02.07 배철우
//	DTO 생성 후 DTO 활용하여 코드재생성 + 배우정보 가져오기 - 02.14 장민실
//	알고리즘 구현을 위해 detail페이지 접근 시 PK값 저장 - 02.15 장재호
	@RequestMapping("detail")
	public ModelAndView detail(@RequestParam int video_id, ModelAndView mv, HttpSession session, RentalDTO dto, VideoInteractionDto vi_dto, HttpServletRequest request, String language) { //세션추가 - 02.15 장재호
/*--------------------------------------- db에 알고리즘 구현을 위한 값들 저장 - 02.15 장재호 ---------------------------------------*/
		System.out.println("ㅡㅡㅡㅡㅡㅡㅡ");
		System.out.println(video_id);
		System.out.println("ㅡㅡㅡㅡㅡㅡㅡ");
		
		if(session.getAttribute("user_id") == null) {
			if(access(request) == null) {
				mv.addObject("error", "잘못된 접근입니다");
				mv.setViewName("redirect:/");
				return mv;
			}
			mv.addObject("error", "잘못된 접근입니다");
			mv.setViewName("redirect:/");
			return mv;
		}
		String id = (String) session.getAttribute("user_id");
		if(access(request) != null && access(request).contains("video/list")) {
			Map<String, Object> map = new HashMap<>();
			map.put("id", id);
			map.put("video_id", video_id);
	//		if = 추가, else = 업데이트(클릭 수 업)
			if(algo.check(map) == null)	algo.insert(map);
			else algo.update(map);
		}
/*---------------------------내보관함 기능 구현 - rental_id detail.jsp로 꽂기 위한 값 저장 02.18 김범수-------------------------------*/
		dto.setId(id); // Id dto에 저장
		String rental_id = rentalService.getid(dto);// rental id를 가져오는 것
		mv.addObject("rental_id",rental_id);
/*--------------------------------------------------------------------------------------------------------------------*/
		
		List<VideoDto> actor = videoService.actor(video_id);
		List<VideoEngDto> actor_eng = videoService.actor_eng(video_id);
		
//		원댓글목록 가져오기 start - 02.21 장민실
		List<CommentDto> list = commentService.replyList(video_id);
		mv.addObject("replyList", list);
//		원댓글목록 가져오기 end - 02.21 장민실
		
//		영상 좋아요,싫어요 기능관련 idx,like,unlike 가져오기 start 03.06 장민실
		String user_id = session.getAttribute("user_id").toString();
		int inter_user_id = userService.getid(user_id);
		vi_dto.setUser_id(inter_user_id);
		vi_dto.setVideo_id(video_id);
		
		List<VideoInteractionDto> v_inter_info = interactionService.get_v_inter_info(vi_dto);
		for(VideoInteractionDto data: v_inter_info) {
			vi_dto.setV_idx(data.getV_idx());
			vi_dto.setLike(data.getLike());
			vi_dto.setUnlike(data.getUnlike());
		}
		mv.addObject("v_inter_info", vi_dto);
//		영상 좋아요,싫어요 기능관련 idx,like,unlike 가져오기 end 03.06 장민실
		
		mv.addObject("dto", videoService.detail(video_id));
		mv.addObject("dto_eng", videoService.detail_eng(video_id));
		mv.addObject("detail", actor);
		mv.addObject("detail_eng", actor_eng);
		
		if(session.getAttribute("language") == "eng" || (language != null && language == "eng")) {
			session.setAttribute("language", "eng");
			mv.setViewName("video/video_eng/detail_eng");
		}
		else {
			session.setAttribute("language", "kor");
			mv.setViewName("video/detail");
		}

		return mv;
	}	
	
//	 내보관함 기능 구현 - 02.15 김범수
	@RequestMapping(value = {"mylocker_in", "mylocker_de"}, method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView mylocker(String title, RentalDTO dto, HttpSession session, HttpServletRequest request, ModelAndView mv) throws Exception{
		String requestUrl = request.getRequestURL().toString();
		String id = (String) session.getAttribute("user_id");
		int video_id = videoService.getid(title); // 비디오 아이디를 가져오는것
		if(id == null) {
			mv.setViewName("redirect:/user/signin");
		}
		// rental_id insert
		if(requestUrl.contains("mylocker_in")) {
			dto.setVideo_id(video_id);
			dto.setId(id);
			rentalService.insert(dto);
			String rental_id = rentalService.getid(dto);
			mv.addObject("rental_id",rental_id);
			mv.setViewName("video/detail");
		}
		else {// rental_id delete
			dto.setId(id);
			dto.setVideo_id(video_id);
			rentalService.delete(dto);
			String rental_id = rentalService.getid(dto);
			mv.addObject("rental_id",rental_id);
			mv.setViewName("video/detail");
		}		
		return mv;	
	}
	     
}
