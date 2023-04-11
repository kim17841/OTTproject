<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title></title>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
   <%@ include file="/WEB-INF/views/common/navbar3.jsp" %>
   <link href="/resources/css/mypage/user_mydetail.css" rel="stylesheet">
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"/>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
   <script src="https://kit.fontawesome.com/885ba80ba8.js" crossorigin="anonymous"></script>
</head>
<body>
<!--네비바 추가 0227 김지혜  -->   
<div id="navSection">

</div>
<!--네비바 end  -->  
    <div class="container">
        <div class="card">
            <div class="form">
                <div class="left-side">
                   <!-- 02.24 김범수 - 프로필 작업으로 수정 -->
                   <c:choose>
                      <c:when test="${data.img != null && data.img != ''}">
                         <img src="${data.img}" id="img_onload" class="img_tag"> 
                      </c:when>
                      <c:when test="${data.img == null}">
                         <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="img_tag">
                      </c:when>
                   </c:choose>
                   <div class="input_file_box">
                      <label class="input_button" for="uploadFile">프로필 변경</label>
                  <input type="file" name='uploadFile' id="uploadFile">
                   </div>
                </div>
                <div class="right-side">
                    <div class="input_text2"><span>ID</span><input type="text" name="Info_Id" value="${data.id}" disabled></div>
                    <div class="input_text2"><span>EMAIL</span><input type="text" name="Info_Email" value="${data.email}" disabled></div>
                    <div class="input_text2"><span>NICKNAME</span><input type="text" name="Info_Nickname" value="${data.nickname}" disabled></div>
                    <div class="input_text2"><span>PHONE_NUM</span><input type="text" name="Info_Phone_num" value="${data.phone_num}" disabled></div>
                    <div class="input_text2"><span>결제 기간</span><input type="text" name="paid" value="<fmt:formatDate value='${data.expiration_date}' pattern='yyyy-MM-dd HH:mm:ss' />" disabled></div>

                    <button type="button" id="btnWrite" >수정하기</button>
                </div>
            </div>
        </div>
    </div>


   <div id="user_info_myModal">  <!-- 팝업처럼 하기 위한 배경 -->
        <form name="form1" method="post" action="/mypage/info_modify"> <!-- "info_modify"페이지에 데이터 전송 -->
            <div class="wrap">  <!-- 실제 팝업창 -->
                <a class="closebtn">X</a> <!-- 회원정보 수정창 닫기 버튼 -->
                <h2>회원정보 수정</h2>

                <!-- email 입력 -->
                <div class="input_text">
                    <input type="email" placeholder="... @ ..." name="email" value="${data.email}" class="input_size" id="modify_email">
                    <!-- email 입력 상태 확인 메세지란 - 정규표현식에 위배되면 출력됨 -->
                </div>
                 <!-- email 중복체크 -->
                <div class="other">
                    <button class="emailCheck" type="button" disabled>이메일 중복체크</button>                  
                    <span id="emailchk_msg"></span>
                </div>

                <!-- 이메일 인증 -->
                <div class="input_text">
                    <!-- 인증번호 입력 / 확인버튼 추기 ___  이메일로 받은 인증번호를 사용자가 입력-->
                    <input type="text" placeholder="인증번호 입력" autocomplete="off" class="authorkey" maxlength="6">
                    <!-- 인증번호 발급해준 것과 사용자 입력값 비교 -->
                    <button class="key_submit" id="author_submit">확인</button>
                    <button class="email_checkbtn">이메일 인증</button> <!-- 이메일 인증 버튼 -->
                </div>
               

                <!-- nickname 입력 -->
                <div class="input_text">
                    <input type="text" placeholder="공백, 특수문자 제외 "  name="nickname" value="${data.nickname}" class="input_size" id="modify_nickname" oninput="nick()">
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
                <input type="button" value="정보 수정" class="changeBtn" id="modifybtn" onclick="updateBtn()">

            </div>
        </form>
    </div>
   <hr>
<!-- 내보관함 리스트 -02.18 김범수 -->
   <div class="section">
      <h1 class="mylocker_text">내보관함</h1>
      <div class="swiper-container">
         <div class="swiper-wrapper">
            <c:forEach var="movie" items="${dto}">
               <div class="swiper-slide">
                  <div class="test"><a href="/video/detail?video_id=${movie.video_id}"> <img src="${movie.image_url}"></a></div>
               </div>
            </c:forEach>
         </div>
         <!-- 네비게이션바 -->
            <c:if test = "${fn:length(dto) > 6}">
            <div id="next1" class="swiper-button-next"><i class='fa-solid fa-angle-right slick-arrow'></i></div>
         </c:if>
         <c:if test = "${fn:length(dto) > 6}">
            <div id="prev1" class="swiper-button-prev"><i class='fa-solid fa-angle-left slick-arrow'></i></div><!-- 이전 버튼 -->
         </c:if>
      </div>
   </div>
   <hr>

<!-- 시청기록 리스트 -02.18 김범수 -->
   <div class="section">
      <h1 class="mylocker_text">시청기록</h1>
      <div class="swiper-container">
         <div class="swiper-wrapper">
            <c:forEach var="userlist" items="${userlist}">
               <div class="swiper-slide">
                  <div class="test"><a href="/video/detail?video_id=${userlist.video_id}"> <img src="${userlist.image_url}"></a></div>
               </div>
            </c:forEach>
         </div>
         <!-- 네비게이션 -->
         <c:if test = "${fn:length(userlist) > 6}">
            <div id="next2" class="swiper-button-next"><i class='fa-solid fa-angle-right slick-arrow'></i></div>
         </c:if>
         <c:if test = "${fn:length(userlist) > 6}">
            <div id="prev2" class="swiper-button-prev"><i class='fa-solid fa-angle-left slick-arrow'></i></div><!-- 이전 버튼 -->
         </c:if>
      </div>
   </div>

   
<!-- footer start  -->
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<!-- footer end  -->
   <script src="/resources/js/mypage/user_mydetail.js"></script>
   <script src="/resources/js/mypage/user_info_modify.js"></script>     
</body>
</html>