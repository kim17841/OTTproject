package com.test.test1.video.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.test1.alarm.service.AlarmService;
import com.test.test1.user.service.UserService;
import com.test.test1.video.dto.CommentDto;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.service.CommentService;
import com.test.test1.video.service.VideoService;

@Controller
@RequestMapping("comt/**")
public class CommentController {
	 
	@Autowired
	CommentService commentService;	
	@Autowired
	UserService userService;
	@Autowired
	VideoService videoService;
	@Autowired
	AlarmService alarmService;
	
//	원댓글 작성하기 02.20 장민실
	@RequestMapping(value="write", method=RequestMethod.POST)
	public ModelAndView insert(VideoDto v_dto, CommentDto c_dto, HttpSession session, ModelAndView mv) {
		String user_id = session.getAttribute("user_id").toString();
		String nickname = session.getAttribute("nickname").toString();
		int id = userService.getid(user_id);
		
//		원댓글 등록할때 pid값 자동증가를 위해 DB의 마지막 pid값 가져오기 start 02.23 장민실
		try {
			int pid = commentService.get_pid(c_dto);
			pid+=1;
			c_dto.setPid(pid);
		}catch(Exception e){
			e.printStackTrace();
		}
//		원댓글 등록할때 pid값 자동증가를 위해 DB의 마지막 pid값 가져오기 end
		
		c_dto.setUser_id(id);
		c_dto.setNickname(nickname);	
		
//		CommentDto 자체에서 video_id를 받아오지 못해 VideoDto에서 video_id 받아와서 값 넣어주기 start 02.21 장민실
		int video_id = v_dto.getVideo_id();
		c_dto.setVideo_id(video_id);
//		CommentDto 자체에서 video_id를 받아오지 못해 VideoDto에서 video_id 받아와서 값 넣어주기 end
		
		commentService.insert(c_dto);
		mv.addObject("c_dto", c_dto);
		mv.setViewName("redirect:/video/detail?video_id="+video_id);
		return mv;
	}
	
//	대댓글 작성하기 - 02.28 장민실
	@RequestMapping(value="cocomwrite", method=RequestMethod.POST)
	public ModelAndView cocomInsert(int pid, CommentDto dto, HttpSession session, ModelAndView mv) {
		String user_id = session.getAttribute("user_id").toString();
		String nickname = session.getAttribute("nickname").toString();
		int id = userService.getid(user_id);

		int depth = 1;          // depth=0 원댓글, depth=1 대댓글
		dto.setDepth(depth);
		dto.setPid(pid);
		
		dto.setUser_id(id);
		dto.setNickname(nickname);	
		
		commentService.cocomInsert(dto);
		
		/************************알람 - 03.06 장재호************************/
		alarmService.addComment(dto);
		/*****************************************************************/
		mv.addObject("cocom_dto", dto);
		return null;
	}	
	
//	대댓글 목록 불러오기 02.23 장민실
	@RequestMapping("cocomList/{pid}")
	@ResponseBody
	public ResponseEntity<List<CommentDto>> cocomList(@PathVariable("pid") int pid, int video_id, CommentDto dto) throws ParseException {
		List<CommentDto> cocom_list = commentService.cocomList(dto);
		
//		대댓글 목록 불러올때 js에서 fmt태그 적용불가로 date출력형식 바꿔주기 start 03.06 장민실
		for(CommentDto data: cocom_list) {
			Date list_date = data.getCreate_date();
			SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd a HH:mm:ss");
			String date_format = SDF.format(list_date);
			data.setCocom_date(date_format);
		}
//		대댓글 목록 불러올때 js에서 fmt태그 적용불가로 date출력형식 바꿔주기 end 03.06 장민실
		
		return new ResponseEntity<List<CommentDto>>(cocom_list, HttpStatus.OK);
	}
	
//	댓글 수정 02.27 장민실
	@RequestMapping("edit/{comment_id}")
	@ResponseBody
	public String edit(int comment_id, String commentary, CommentDto dto) {
		dto.setComment_id(comment_id);
		dto.setCommentary(commentary);
		commentService.edit(dto);
//		return null로 준 이유 : detail.js에서 따로 페이지 새로고침 처리해서
		return null;
	}
	
//	댓글,대댓글 삭제 02.23 장민실
	@RequestMapping("delete")
	@ResponseBody
	public String delete(int comment_id) {
		commentService.delete(comment_id);
//		return null로 준 이유 : detail.js에서 따로 페이지 새로고침 처리해서
		return null;
	}
	
	
	

}
