package com.test.test1.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.user.dao.ApiLoginDao;
import com.test.test1.user.dto.UserDto;

@Service
public class ApiLoginServiceImpl implements ApiLoginService {

	@Autowired
	ApiLoginDao apiLoginDao;
	
	@Override
	public String apiCheck(String email) {
		return apiLoginDao.apiCheck(email);
	}

	@Override
	public void apiSignUp(UserDto userDto) {
		apiLoginDao.apiSignUp(userDto);
	}

	@Override
	public String apiSignIn(String email) {
		return apiLoginDao.apiSignIn(email);
	}

	@Override
	public String getNick(String id) {
		return apiLoginDao.getNick(id);
	}

}
