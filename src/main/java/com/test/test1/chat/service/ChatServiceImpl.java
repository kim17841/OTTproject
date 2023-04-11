package com.test.test1.chat.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.test.test1.chat.dao.ChatDao;
import com.test.test1.chat.dto.ChatDto;

/* 02.26 장재호 */
@Service
public class ChatServiceImpl implements ChatService {

	@Autowired
	ChatDao chatDao;
	
	@Override
	public void userChatCreate(ChatDto chatDto) {		
		chatDao.userChatCreate(chatDto);
	}
	
	@Override
	public void adminChatCreate(ChatDto chatDto) {
		chatDao.adminChatCreate(chatDto);
	}

	@Override
	public void chatDelete(String id) {
		chatDao.chatDelete(id);		
	}

	@Override
	public List<ChatDto> getChatLog(ChatDto chatDto) {
		return chatDao.getChatLog(chatDto);
	}


}
/***********************************/