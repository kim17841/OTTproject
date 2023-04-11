<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link href="/resources/css/user/user_mydetail.css" rel="stylesheet">
</head>
<body>

<form name="form1" method="post">	

	
	<button type="button" id="">비밀번호 변경</button>
	
	<ul>
		<li>아이디 : 
			<input type="text" name="id" value="${list.id}" readonly>  <!-- 변경불가능한 텍스트인것을 알려주도록 색깔주기... 아이디는 변경 불가능이므로 읽기 전용으로 설정 -->
		</li>
		<li>이메일 : 
			<input type="email" name="email" id="email" value="${list.email}" >
		</li>
		<li>닉네임 : 
			<input type="text" name="nickname" id="nickname"  value="${list.nickname}">
		</li>	
		<li>휴대전화 : 
			<input type="text" name="phone_num" id="phone_num"  value="${list.phone_num}" >
		</li>
	</ul>
	
	<input id="submit" type="submit" value="변경하기">
</form>










	<script src="/resources/js/user/user_mydetail.js"></script>
</body>
</html>