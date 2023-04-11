
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/board/qna_create.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/navbar3.jsp" %>
<!-- 질문등록 폼 -->
<div class="page-wrapper p-t-100 p-b-50">
    <div class="wrapper wrapper--w900">
        <div class="card card-6">
            <div class="card-heading">
               <h2 class="title">질문 등록</h2>
            </div>
            <div class="card-body">
                <form name="form1" method="POST" onSubmit="return false;">
                    <div class="form-row">
                        <div class="name">제목</div>
                        <div class="value">
                        	<div class="input-group">
                            	<input id="title" class="input--style-6" type="text" name="q_subject" placeholder="제목">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">작성자</div>
                        <div class="value">
                           	<div class="input-group">                        
                            	<input id="id" class="input--style-6" type="text" name="id" value="${sessionScope.user_id}" placeholder="작성자 입력">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">비밀번호</div>
                        <div class="value">
                            <div class="input-group">
                                <input class="input--style-6" type="password" name="password" placeholder="비밀번호 입력">
                            </div>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="name">내용</div>
                        <div class="value">
                            <div class="input-group">
                                <textarea class="textarea--style-6" id="content" name="q_content" placeholder="질문을 작성해 주세요"></textarea>
                            </div>
                        </div>
                        <button class="btn btn--radius-2 btn--blue-2" type="submit" onclick="qCreate()">등록</button>
                    </div>
                    <!-- 
                    <div class="form-row">
                        <div class="name">첨부파일</div>
                        <div class="value">
                            <div class="input-group js-input-file">
                                <input class="input-file" type="file" name="file_cv" id="file">
                                <label class="label--file" for="file">Choose file</label>
                                <span class="input-file__info">No file chosen</span>
                            </div>
                            <div class="label--desc">Upload your CV/Resume or any other relevant file. Max file size 50 MB</div>
                        </div>
                    </div>
                     -->
                </form>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/resources/js/board/qna_create.js"></script>
<script src="/resources/js/board/q_create_global.js"></script>
</html>