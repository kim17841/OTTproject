package com.test.test1.board.qna.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.test1.alarm.dao.AlarmDao;
import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.board.qna.dto.PageMaker;
import com.test.test1.board.qna.dto.QnaDto;
import com.test.test1.board.qna.service.QnaService;
import com.test.test1.user.service.UserService;

@Controller
@RequestMapping("/qna/**")
public class QnaController {

	@Autowired
	QnaService qnaService;
	@Autowired
	UserService userService;
	//02.23장재호 추가
	@Autowired
	AlarmDao alarmDao;
	
	//qna 게시판 출력 - 02.07 장재호
	//user Key값으로 닉네임을 리스트에 출력
	@RequestMapping("list")
	public ModelAndView qnaList(ModelAndView mv, Criteria cri) throws Exception {
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri); //page, perpagenum 셋팅
		pageMaker.setTotalCount(qnaService.listCount(cri)); //총 게시글 수 셋팅
		
		//View에 페이징 처리를 위한 조건 및 그에 맞는 게시판 리스트 전송
		mv.addObject("pageMaker", pageMaker);
		mv.addObject("data", qnaService.list(cri)); 
		
		mv.setViewName("board/qna/qna_list");

		return mv;
		
	}
	
	//질문생성 페이지 - 02.07 장재호
	@RequestMapping("create")
	public String qCreate() {
		return "board/qna/qna_create";
	}
	
	//질문생성하기 - 02.07 장재호
	@RequestMapping(value = "create", method = RequestMethod.POST)
	public String qCreate(QnaDto qnaDto) {
		qnaService.qCreate(qnaDto);
		return "redirect:/qna/list";
	}
	
	//QNA 상세 - 02.07 장재호
	//상세페이지 접근 시 비밀글이면 접근 불가 - 02.17 장재호
	@RequestMapping("list/{question_id}")
	public ModelAndView qnaDetail(ModelAndView mv, @PathVariable int question_id, HttpServletRequest request) {
		//이전 주소 경로
		String result = request.getHeader("REFERER");
		if(result == null) {
			mv.addObject("error", "잘못된 접근입니다");
			mv.setViewName("redirect:/qna/list");
		}
		else {
			mv.addObject("data", qnaService.detail(question_id));
			mv.setViewName("board/qna/qna_detail");
		}
		return mv;
	}
	
	//수정하기 - 02.07 장재호
	@RequestMapping(value="modify", method=RequestMethod.POST, produces="application/text; charset=UTF-8;")
	@ResponseBody
	public String qnaModify(ModelAndView mv, QnaDto qnaDto) {
		qnaService.modify(qnaDto);
		return "수정완료";
	}
	
	//삭제하기 - 02.07 장재호
	@RequestMapping("qnaDelete")
	public String qnaDelete(int question_id) {
		qnaService.delete(question_id);
		return "redirect:/qna/list";
	}	
	
	//selectbox를 통한 다중 삭제 - 02.17 장재호
	@RequestMapping(value="qnaDeletes", method=RequestMethod.POST)
	public String qnaDeletes(@RequestBody List<Integer> delArr) {
		qnaService.deletes(delArr);
		return "redirect:/qna/list";
	}	
	
	//답변 생성 - 02.18 장재호
	//웹소켓 알람기능 추가 - 02.23장재호
	@RequestMapping(value="answerCreate", method=RequestMethod.POST)
	public String answerCreate(QnaDto qnaDto) {
		qnaService.answerCreate(qnaDto);
		alarmDao.addQnaAlarm(qnaDto); //웹소켓 알람기능 추가 - 02.23장재호
		return "redirect:/qna/list";		
	}
	
	//답변 수정, 보기 클릭 시 답변 불러오기 - 02.18 장재호
	@RequestMapping(value="answerGet", method=RequestMethod.POST, produces="application/text; charset=UTF-8;")
	@ResponseBody
	public String answerGet(int question_id) {
		return qnaService.answerGet(question_id);
	}
	
	
}
