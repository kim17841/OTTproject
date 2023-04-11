package com.test.test1.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.test.test1.user.dto.UserDto;
import com.test.test1.user.service.ApiLoginService;

//api로그인 구현 컨트롤러 - 02.08 장재호
@Controller
@RequestMapping("/user/**")
public class ApiLoginController {
	
	@Autowired
	ApiLoginService apiLoginService;
	
	//카카오 로그인 시 데이터 받아와서 처리 - 02.10 장재호
	@RequestMapping(value = "kakaoLogin", method = RequestMethod.POST)
	@ResponseBody
	public String kakaoLogin(UserDto userDto, HttpSession session) {
		String result = apiLoginService.apiCheck(userDto.getEmail());
		if(result==null) { //가입가능
	    	result = "ok";
	    	return result;
	    }
	    else {//기가입 유저 -> 세션추가 후 로그인처리
	    	session.setAttribute("user_id", userDto.getEmail());
	    	session.setAttribute("nickname", apiLoginService.apiSignIn(userDto.getEmail()));
	    	//nickname alert를 위한 리턴
	    	result = session.getAttribute("nickname").toString();    	
	    	return result;
	    }
	}
	
	//로그인 시 DB닉네임 출력 - 02.27 장재호
	@RequestMapping(value = "kakaoLogins", method = RequestMethod.POST, produces="application/json; charset=utf-8")
	@ResponseBody
	public String kakaoLogins(String id) {
		return apiLoginService.getNick(id);
	}
	
	
	@RequestMapping(value = "kakaoSignUp", method = RequestMethod.POST)
	public String kakaoSignUp(UserDto userDto, HttpSession session) {
		userDto.setCreate_type("kakao"); //create_type 입력
		apiLoginService.apiSignUp(userDto); //가입 진행
		//자동로그인 처리를 위한 세션에 삽입
		session.setAttribute("user_id", userDto.getEmail()); 
		session.setAttribute("nickname", userDto.getNickname());
		return "/video/list";
	}
	
	//콜백화면 이동 - 02.09 장재호
	@RequestMapping(value = "naverLogin", method = RequestMethod.GET)
	public String naverLogin() {
		return "api/naverCallback";
	}
	
	//네이버 로그인 시 로그인 데이터를 받아 가입 혹은 로그인처리 - 02.09 장재호
	@RequestMapping(value = "naverSaved", method = RequestMethod.POST, produces="application/json; charset=utf-8")
	@ResponseBody
	public String naverLogin(UserDto userDto, HttpSession session) {
		//result : 가입여부
		String result = apiLoginService.apiCheck(userDto.getEmail());			    
	    if(result==null) {//가입가능
	    	result = "ok";
	    	return result;
	    }
	    else {//기가입 유저 -> 세션추가 후 로그인처리
	    	session.setAttribute("user_email", userDto.getEmail());
	    	session.setAttribute("nickname", apiLoginService.apiSignIn(userDto.getEmail()));
	    	result = session.getAttribute("nickname").toString();    	
	    	return result;
	    }
	}
	
	//js prompt 입력값(사용할 닉네임) 받아와 가입처리 - 02.10 장재호
	@RequestMapping(value = "naverSignin", method = RequestMethod.POST)
	public String naverSignUp(UserDto userDto, HttpSession session) {
		//테이블 create_type 명시를 위한 dto삽입
		userDto.setCreate_type("naver");
		apiLoginService.apiSignUp(userDto);
		//가입 시 자동로그인
		session.setAttribute("user_email", userDto.getEmail()); 
		session.setAttribute("nickname", userDto.getNickname());
		return "/video/list";
	}
}
