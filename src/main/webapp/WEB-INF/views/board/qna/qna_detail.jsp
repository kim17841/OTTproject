<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/resources/css/board/qna_create.css">
<link rel="stylesheet" href="/resources/css/board/qna_list.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
<!-- 네비바 start -->
<%@ include file="/WEB-INF/views/common/navbar3.jsp" %>
<!-- 네비바  end -->
<div class="page-wrapper p-t-100 p-b-50">
    <div class="wrapper wrapper--w900">
        <div class="card card-6">
            <div class="card-heading">
               <h2 class="title">내용</h2>
            </div>
            <div class="card-body">
                <div class="form-row">
                    <div class="name">제목</div>
                    <div class="value">
                        <div class="input-group">
                            <input id="title" class="input--style-6" type="text" name="q_subject" value="${data.q_subject}" readonly>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="name">작성자</div>
                    <div class="value">
                        <div class="input-group">                        
                            <input id="id" class="input--style-6" type="text" name="id" value="${data.id}" readonly>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="name">내용</div>
                    <div class="value">
                        <div class="input-group">
                            <textarea class="textarea--style-6" id="content" name="q_content">${data.q_content}</textarea>
                        </div>
                    </div>
                    <div class="centerBtn">
	                  	<form id="centerForm" name="form1" onsubmit="return false">
							<input type="hidden" name="question_id" value="${question_id}">
	                  	<c:if test="${sessionScope.user_id == data.id}">
							<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="qModify()">수정하기</button>						
							<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="qnaDelete()">삭제하기</button>
						</c:if>

						</form>
						<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="location.href='/qna/list'">목록으로</button>						
						<c:if test="${sessionScope.user_id == 'admin' && sessionScope.nickname == 'admin'}">
							<button id="adminCreate1" class="btn btn--radius-2 btn--blue-2" type="button" onclick="modal(this)">답변 등록</button>	
						</c:if>
						<c:if test="${data.answer != null && sessionScope.user_id != 'admin' && sessionScope.nickname != 'admin'}">
							<button id="adminCreate2" class="btn btn--radius-2 btn--blue-2" type="button" onclick="modal(this)">답변 보기</button>	
						</c:if>	
                    </div>                    
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" value="${data.answer}" id="answerValue">
<input type="hidden" value="${sessionScope.user_id}" id="sessionID">
<input type="hidden" value="${data.id}" id="userID">
<%@ include file="/WEB-INF/views/board/qna/qna_answer.jsp" %>
<script src="/resources/js/board/qna_detail.js"></script>
<script src="/resources/js/board/qna_modify.js"></script>
</body>
</html>