<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/board/qna_answer_modal.css">
<link rel="stylesheet" href="/resources/css/board/qna_create.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%@ include file="/WEB-INF/views/common/alarm.jsp" %>
</head>
<body>
<div class="popup">
	<div class="pwrap">
		<a class="closebtn">X</a>
		<div class="page-wrapper">
			<div class="wrapper wrapper--w900">
				<div class="card card-6">
					<div class="card-heading">
						<h2 class="title">내용</h2>
					</div>
					<div id="answerBody" class="card-body">
						<textarea class="textarea--style-6" id="contentArea" name="answer"></textarea>
						<input type="hidden" name="question_id" value="${question_id}">
					</div>
				</div>
			</div>
			<c:if test="${sessionScope.user_id == 'admin' && sessionScope.nickname == 'admin'}">			
				<button id="btnCenter" class="btn btn--radius-2 btn--blue-2" type="submit" onclick="answerCreate()">등록</button>
			</c:if>			
		</div>
	</div>
</div>
<input id="alarmSubejct" type="hidden" value="${data.q_subject}">
<input id="alarmID" type="hidden" value="${data.id}">
<script src="/resources/js/board/qna_answer.js"></script>
</body>
</html>