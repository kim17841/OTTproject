package com.test.test1.common;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.test.test1.user.service.UserService;

@Controller
public class MainController {

	@Autowired
	UserService userService;
	
	//메인페이지 접근 - 02.06 장재호
	//일 방문자수 추가 - 02.19 장재호
	//영문페이지 작업 - 03.06 장재호
	@RequestMapping("/")
	public ModelAndView Main(String language, ModelAndView mv, HttpSession ss) {
		//일 방문자수 ++ - 02.19 장재호		
		userService.addVisit();
		ss.setAttribute("language", "kor");
		if(language != null && language.contains("eng")) {
			ss.setAttribute("language", "eng");
			mv.setViewName("common/common_eng/start");
		}
		else {
			mv.setViewName("common/start");
		}
		return mv;
	}

}
