<!-- 02.25 장재호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
<link rel="stylesheet" href="/resources/css/chat/userchat.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<head>
</head>
<body>
<div id="userChat">
	<div class="chatArea hidden">
		<input type="hidden" id="sessionUserId" value="${sessionScope.user_id}">
		<textarea id="messageTextArea" rows="10" cols="50" disabled="disabled"></textarea>
		<br />
		<form id="buttonForm">
			<input id="textMessage" type="text" onkeydown="return enter()">
			<input onclick="sendMessage()" value="보내기" type="button">
			<input onclick="closeChat()" value="채팅종료" type="button">		
		</form>
	</div>
	<i id="chatIcon" class="fa-solid fa-comment-dots"></i>	
</div> 
<script src="/resources/js/chat/userchat.js"></script>
</body>
</html>

<!-------------------->