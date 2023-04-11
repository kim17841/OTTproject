<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title></title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
	<script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
	<link href="/resources/css/mypage/user_mydetail.css" rel="stylesheet">
	<script src="https://kit.fontawesome.com/885ba80ba8.js" crossorigin="anonymous"></script>
</head>
<body>
<div id="navSection">
<%@ include file="/WEB-INF/views/common/navbar3.jsp" %>
</div>

    <div class="container">
        <div class="card">
            <div class="form">
                <div class="left-side">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU alt=">
                </div>
                <div class="right-side">
                    <div class="input_text2"><span>ID</span><input type="text" name="id" value="${data.id}" disabled></div>
                    <div class="input_text2"><span>EMAIL</span><input type="text" name="id" value="${data.email}" disabled></div>
                    <div class="input_text2"><span>NICKNAME</span><input type="text" name="id" value="${data.nickname}" disabled></div>
                    <div class="input_text2"><span>PHONE_NUM</span><input type="text" name="id" value="${data.phone_num}" disabled></div>

                    <button type="button" id="btnWrite" >modify</button>
                </div>
            </div>
        </div>
    </div>


   <div id="user_info_myModal">  <!-- 팝업처럼 하기 위한 배경 -->
        <form name="form1" method="post" action="/mypage/info_modify"> <!-- "info_modify"페이지에 데이터 전송 -->
            <div class="wrap">  <!-- 실제 팝업창 -->
                <a class="closebtn">X</a> <!-- 회원정보 수정창 닫기 버튼 -->
                <h2>Modifying member information</h2>

                <!-- email 입력 -->
                <div class="input_text">
                    <input type="email" placeholder="... @ ..." name="email" value="${data.email}" class="input_size" id="modify_email">
                    <!-- email 입력 상태 확인 메세지란 - 정규표현식에 위배되면 출력됨 -->
                </div>
                 <!-- email 중복체크 -->
                <div class="other">
                    <button class="emailCheck" type="button" disabled>Email Duplicate Check</button>						
                    <span id="emailchk_msg"></span>
                </div>

                <!-- 이메일 인증 -->
                <div class="input_text">
                    <!-- 인증번호 입력 / 확인버튼 추기 ___  이메일로 받은 인증번호를 사용자가 입력-->
                    <input type="text" placeholder="Enter authentication number" autocomplete="off" class="authorkey" maxlength="6">
                    <!-- 인증번호 발급해준 것과 사용자 입력값 비교 -->
                    <button class="key_submit" id="author_submit">Check</button>
                    <button class="email_checkbtn">Email Authentication</button> <!-- 이메일 인증 버튼 -->
                </div>
               

                <!-- nickname 입력 -->
                <div class="input_text">
                    <input type="text" placeholder="Spaces, excluding special characters"  name="nickname" value="${data.nickname}" class="input_size" id="modify_nickname" oninput="nick()">
                </div>
                <!-- nickname 유효성 체크관련 경고메시지란  - 정규표현식에 위배되면 출력됨  -->
                <div class="other">
                    <span id="nicknamechk_msg"></span>
                </div>
            

                <!-- phone_num 입력 -->
                <div class="input_text">
                    <input type="text" placeholder="000-0000-0000" name="phone_num" value="${data.phone_num}" class="input_size" id="modify_phone_num"  oninput="autoHyphen(this)" maxlength="13" >
                </div>            
                <!-- phone_num 유효성 체크관련 경고메시지란  - 정규표현식에 위배되면 출력됨  -->
                <div class="other">
                    <span id="phone_numchk_msg"></span>
                </div>                    
                
                <!-- 정보 수정 변경 버튼  -->
                <input type="button" value="Correction of information" class="changeBtn" id="modifybtn" onclick="updateBtn()">

            </div>
        </form>
    </div>
	<hr>
	   <!-- 내보관함 리스트 -02.18 김범수 -->
   <!-- 보관함 리스트 영역-->
   <div class="section">
      <!-- 내보관함 text -->
      <h1 class="mylocker_text">My locker</h1>
      <!-- 내보관함 슬라이드 - 양옆 버튼 추가 + 버튼 누르면 케러셀처럼 넘어감-->
      <div class="slider">
         <!-- 내보관함 리스트 출력 영역-->
         <c:forEach var="movie" items="${dto}">
            <div class="video_div">
               <a href="/video/detail?video_id=${movie.video_id}"> <img src="${movie.image_url}" alt="Image not found"></a>
            </div> 
         </c:forEach>
         
      </div>
   </div>  

	<script src="/resources/js/mypage/user_mydetail.js"></script>
	<script src="/resources/js/mypage/user_info_modify.js"></script>	  
	<script src="/resources/js/mypage/mylocker.js"></script>
</body>
</html>