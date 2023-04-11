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
<link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<link rel="stylesheet" href="/resources/css/common/navbar2.css">
<link rel="stylesheet" href="/resources/css/video/list.css">
<!-- Fontawesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/common_eng/pay_modal.jsp" %>
    <!-- =========== video list 네비바 =========== / navbar start 네비바 수정 _ 0227 김지혜-->
    <nav id="navbar">
        <div class="logo">
            <img src="/resources/img/user/logo4.png" id="logo" onclick="back()" alt="">
        </div>
          <!-- menu start -->
        <div class="menu">
            <ul class="menu_ul">
                <li class="menu_text_li" id="menu1">
                   <p>Movie</p>
               <ul class="drop_menu_ul drop_menu_ul_1">
                 <li class="drop_menu_li" onclick="toggleSubMenu('actionSubMenu')">Action</li>
                 <li class="drop_menu_li" onclick="toggleSubMenu('dramaSubMenu')">Drama</li>
                 <li class="drop_menu_li" onclick="toggleSubMenu('fantasySubMenu')">Fantasy</li>
                 <li class="drop_menu_li" onclick="toggleSubMenu('sfSubMenu')">SF</li>
                 <li class="drop_menu_li" onclick="toggleSubMenu('crimeSubMenu')">Crime</li>
               </ul>
                </li>
                <li class="menu_text_li" id="menu2" onclick="ani_q()"> 
                    <p>Animation</p>    
                </li>
            </ul>
        </div>
<!-- menu end -->

<!-- search start -->
        <div class="search_area">
            <input type="search" id="search">
            <i class="fas fa-search fa-lg icons" id="search_icon"></i>
        </div>
<!-- search end -->
      
      <div>
         <%@ include file="/WEB-INF/views/common/alarm.jsp" %>      
      </div>

<!-- my info start -->
        <div class="info">
            <ul class="info_ul">
                <li class="info_li">
               <c:choose>
                  <c:when test="${img != null && img != ''}">
                     <img src="${img}" id="img_onload" class="img_tag"> 
                  </c:when>
                  <c:when test="${img == null}">
                     <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="img_tag">
                  </c:when>
               </c:choose>
                    <ul class="drop_menu_ul">
                        <li class="drop_menu_li" onclick ="location.href='/mypage/info_mydetail'">Mychannel</li>
                        <li class="drop_menu_li" onclick ="modal2()">Pay</li>
	                     <li class="drop_menu_li">
	                            <div class="langdropdown">
	                            <form name="lanForm">                            
	                                <select name="language" class="selectbox" onchange="lanChange()">
	                                    <option value="none" class="select" id="none_text">Language</option>
	                                    <option value="kor" class="select">한국어</option>
	                                    <option value="eng" class="select">English</option>
	                                </select>
	                           </form>
	                            </div>
	                     </li>
	                     <li class="drop_menu_li" onclick ="location.href='/qna/list'">QNA</li>
                        <li class="drop_menu_li" onclick="signout()">Logout</li>
                    </ul>
                </li>
            </ul>
        </div>
<!-- my info end -->
    </nav>   
<!-- navbar end -->
<script src="/resources/js/common/nav1.js"></script>
<script src="/resources/js/common/language.js"></script>
</body>
</html>