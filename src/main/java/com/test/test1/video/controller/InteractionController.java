package com.test.test1.video.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.test1.user.service.UserService;
import com.test.test1.video.dto.VideoInteractionDto;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.service.InteractionService;

@Controller
@RequestMapping("inter/**")
public class InteractionController {
	
	@Autowired
	InteractionService interactionService;
	@Autowired
	UserService userService;
	
//	비디오 좋아요 - 03.06 장민실
	@RequestMapping(value="video_like", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView video_like(VideoDto v_dto, VideoInteractionDto vi_dto, HttpSession session, ModelAndView mv) {
		String user_id = session.getAttribute("user_id").toString();
		int id = userService.getid(user_id);		
		vi_dto.setUser_id(id);		
		int video_id = v_dto.getVideo_id();
		vi_dto.setVideo_id(video_id);
		
		List<VideoInteractionDto> v_inter_info = interactionService.get_v_inter_info(vi_dto);
		for(VideoInteractionDto data: v_inter_info) {
			vi_dto.setV_idx(data.getV_idx());
			vi_dto.setUnlike(data.getUnlike());
		}
		int v_idx = vi_dto.getV_idx();
		int unlike = vi_dto.getUnlike();
		
		if(v_idx != 0) {	// 누른값이 있을때 if start
			if(v_idx != 0 && unlike == 1) {
				vi_dto.setV_idx(v_idx);
				interactionService.v_delete(vi_dto);
				int like = 1;
				vi_dto.setLike(like);
				interactionService.video_like(vi_dto);
			}	// 누른값이 unlike일때 if end
			vi_dto.setV_idx(v_idx);
			interactionService.v_delete(vi_dto);
		}	// 누른값이 like일때 if end
		else if(v_idx == 0) {
			int like = 1;
			vi_dto.setLike(like);
			interactionService.video_like(vi_dto);
		}	// 누른값이 없을때 else if end
		mv.addObject("video_inter_dto", vi_dto);
		mv.setViewName("redirect:/video/detail?video_id="+video_id);
		return mv;
	}
	
//	비디오 싫어요 - 03.07 장민실
	@RequestMapping(value="video_unlike", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView video_unlike(VideoDto v_dto, VideoInteractionDto vi_dto, HttpSession session, ModelAndView mv) {
		String user_id = session.getAttribute("user_id").toString();
		int id = userService.getid(user_id);		
		vi_dto.setUser_id(id);		
		int video_id = v_dto.getVideo_id();
		vi_dto.setVideo_id(video_id);
		
		List<VideoInteractionDto> v_inter_info = interactionService.get_v_inter_info(vi_dto);
		for(VideoInteractionDto data: v_inter_info) {
			vi_dto.setV_idx(data.getV_idx());
			vi_dto.setLike(data.getLike());
		}
		int v_idx = vi_dto.getV_idx();
		int like = vi_dto.getLike();		
		
		if(v_idx != 0) {	// 누른값이 있을때 if start
			if(v_idx != 0 && like == 1) {
				vi_dto.setV_idx(v_idx);
				interactionService.v_delete(vi_dto);
				int unlike = 1;
				vi_dto.setUnlike(unlike);
				interactionService.video_unlike(vi_dto);
			}	// 누른값이 like일때 if end
			vi_dto.setV_idx(v_idx);
			interactionService.v_delete(vi_dto);
		}	// 누른값이 unlike일때 if end
		else if(v_idx == 0) {
			int unlike = 1;
			vi_dto.setUnlike(unlike);
			interactionService.video_unlike(vi_dto);
		}	// 누른값이 없을때 else if end
		
		mv.addObject("video_inter_dto", vi_dto);
		mv.setViewName("redirect:/video/detail?video_id="+video_id);
		return mv;
	}
	

	
	
	
	

}
