<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/common/navbar3.css">
    <!-- Fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/pay_modal.jsp" %>      

<!-- =========== qna =========== 네비바 -->
<!-- 세션에 아이디 값을 가지고 있을 경우 (로그인이 되어있을 경우)와 없을 때 넘어가는 경우가 다르게 설정  0227 장재호 -->
<input id="sessionID" type="hidden" value="${sessionScope.user_id}">
<!-- navbar start -->
    <nav id="navbar">
        <div class="logo">
            <img src="/resources/img/user/logo4.png" id="logo" onclick="back()" alt="">
        </div>  
           
         <div id="alarmSection">
         <%@ include file="/WEB-INF/views/common/alarm.jsp" %>      
      </div>

<!-- my info start -->
        <div class="info">
            <ul class="info_ul">
                <li class="info_li">
               <c:choose>
                  <c:when test="${img != null && img != ''}">
                     <img src="${img}" id="img_onload" class="nav_img_tag"> 
                  </c:when>
                  <c:when test="${img == null}">
                     <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="nav_img_tag">
                  </c:when>
               </c:choose>
               <form name="lanForm">               
                    <ul class="drop_menu_ul">
                        <li class="drop_menu_li" onclick ="location.href='/mypage/info_mydetail'">내채널</li>
                        <li class="drop_menu_li" onclick ="modal2()">결제</li>
                        <li class="drop_menu_li" onclick ="lanChange()">Language</li>
                        <li class="drop_menu_li" onclick ="location.href='/qna/list'">고객센터</li>
                        <li class="drop_menu_li" onclick="signout()">로그아웃</li>
                    </ul>
              </form>
                </li>
            </ul>
        </div>
<!-- my info end -->
    </nav>   
<!-- navbar end -->
<script src="/resources/js/common/nav2.js"></script>
<script src="/resources/js/common/language.js"></script>

</body>
</html>