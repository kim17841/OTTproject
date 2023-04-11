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
			<h3>CORPORATION GOOTTFLEX</h3><br>
			<p>Representative gunchim</p><br>
			<p>2nd floor of Juho Tower, 33, Siheung-daero 163-gil, Guro-gu, Seoul</p><br>
			<p>Business registration number 111-00-22222</p><br>
			<p>Representative number 02-333-9999</p><br>
			<p>FAX: 02-333-9999</p><br>
			<p><a href="/qna/list">GOOTTFLEX Customer Service</a></p>
			 <c:if test="${sessionScope.user_id == 'admin'}">
	         <p><a href="/admin">관리자 페이지</a></p>
         	</c:if>      
		</div>
	</div>
	<br>
</footer>

<script src="/resources/js/api/map.js"></script>
</html>