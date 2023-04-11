package com.test.test1.user.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.test1.user.dto.UserDto;

@Repository
public class ApiLoginDao {

	@Autowired
	SqlSession session;
	
	public String apiCheck(String email) {
		return session.selectOne("apiUser.apiCheck", email);
	}

	public void apiSignUp(UserDto userDto) {
		session.insert("apiUser.apiSignUp",userDto);
	}

	public String apiSignIn(String email) {
		return session.selectOne("apiUser.apiSignIn", email);
	}

	public String getNick(String id) {
		return session.selectOne("apiUser.getNick", id);
	}	
	
}
