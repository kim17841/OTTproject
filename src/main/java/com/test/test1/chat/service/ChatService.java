package com.test.test1.chat.service;

import java.util.List;

import com.test.test1.chat.dto.ChatDto;

/* 02.26 장재호 */
public interface ChatService {

	void userChatCreate(ChatDto chatDto);
	
	void adminChatCreate(ChatDto chatDto);

	void chatDelete(String id);

	List<ChatDto> getChatLog(ChatDto chatDto);

}
/***********************************/