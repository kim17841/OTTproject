<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<!-- KAKAO MAP api -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2510b2e9fc85aeb4625d6a9d9d7b881b"></script>    
</head>
<footer>
   <br>
   <div id="f_Con1">
      <div id="map"></div>   
      <div id="f_Con2">
         <h3>주식회사 GOOTTFLEX</h3><br>
         <p>대표 군침이</p><br>
         <p>서울특별시 구로구 시흥대로163길 33 주호타워 2층</p><br>
         <p>사업자등록번호 111-00-22222</p><br>
         <p>대표번호 02-333-9999</p><br>
         <p>FAX: 02-333-9999</p><br>
         <p><a href="/qna/list">GOOTTFLEX 고객센터</a></p>
         <c:if test="${sessionScope.user_id == 'admin'}">
         <p><a href="/admin">관리자 페이지</a></p>
         </c:if>         
      </div>
   </div>
   <br>
</footer>

<script src="/resources/js/api/map.js"></script>
</html>