package com.test.test1.user.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.mypage.dto.ImgDto;
import com.test.test1.user.dao.UserDao;
import com.test.test1.user.dto.UserDto;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	UserDao userDao;


	// 개인정보상세조회 
	@Override
	public UserDto detail(String user_id) {
		return userDao.detail(user_id);
	}
	
	// 개인정보수정내용 저장 23/02/20 김지혜 
	@Override
	public void infoModify(UserDto dto) {
		userDao.infoModify(dto);
	}
	
	@Override
	public void create(UserDto userDto) {
		userDao.create(userDto);
	}
	
	@Override
	public String login(UserDto userDto) {
		return userDao.login(userDto);
	}
	
	@Override
	public List<UserDto> list(Criteria cri) throws Exception {
		return userDao.list(cri);		
	}
	
	@Override
	public String idCheck(String id) {
		return userDao.idCheck(id);
	}

	@Override
	public String findid(String email) {
		return userDao.findid(email);
	}

	@Override
	public String findpw(UserDto dto) {
		return userDao.findpw(dto);
	}

	@Override
	public String emailCheck(String email) {
		return userDao.emailCheck(email);
	}
	
	@Override
	public void paid(Map<String, Object> map) {
		userDao.paid(map);
	}
	
	@Override
	public void changepw(UserDto dto) {
		userDao.changepw(dto);
	}


	@Override
	public String paidCheck(String ID) {
		return userDao.paidCheck(ID);
	}

	@Override
	public void rePaid(Map<String, Object> map) {
		userDao.rePaid(map);		
	}

	@Override
	public int listCount(Criteria cri) {
		return userDao.listCount(cri);
	}

	@Override
	public void paidUpdate(int months) {
		userDao.paidUpdate(months);		
	}

	@Override
	public void addVisit() {
		userDao.addVisit();
	}
	
//	video detail 내 댓글등록 위해 유저정보 받아오기 02.20 장민실
	@Override
	public int getid(String user_id) {
		return userDao.getid(user_id);
	}

// 프로필 이미지 변경 - 02.24 김범수
	@Override
	public void img_update(ImgDto dto) {
		userDao.img_update(dto);
	}

	@Override
	public String navbarImg(String id) {
		return userDao.navbarImg(id);
	}



}






	
