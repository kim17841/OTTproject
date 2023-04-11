package com.test.test1.user.service;

import com.test.test1.user.dto.UserDto;

public interface ApiLoginService {

	String apiCheck(String email);

	void apiSignUp(UserDto userDto);

	String apiSignIn(String email);

	String getNick(String id);

}
