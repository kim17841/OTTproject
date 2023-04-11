package com.test.test1.chat.dao;
/* 02.26 장재호 */

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.test.test1.chat.dto.ChatDto;

@Repository
public class ChatDao {

	@Autowired
	SqlSession ss;
	
	public void userChatCreate(ChatDto chatDto) {
		ss.insert("chat.userChatCreate", chatDto);
	}

	public void adminChatCreate(ChatDto chatDto) {
		ss.insert("chat.adminChatCreate", chatDto);
	}

	public void chatDelete(String id) {
		ss.delete("chat.delete", id);		
	}

	public List<ChatDto> getChatLog(ChatDto chatDto) {
		String uuid = chatDto.getUuid();
		if(uuid != null) {
			return ss.selectList("chat.getLogAdmin", chatDto.getUuid());
		}
		else {
			return ss.selectList("chat.getLog", chatDto.getId());
		}
	}


}
/***********************************/