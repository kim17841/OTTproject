<!-- 02.23 장재호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<input type="hidden" value="${sessionScope.user_id}" id="socketuserID">
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="/resources/css/common/alarm.css" rel="stylesheet">
<script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<body>
<!-- 알람 섹션 -->
<div id="alarmDiv">
<i id="alarmI" class="fas fa-bell"></i>
</div>
<div id="alarm_Area">
</div>
</body>
<script src="/resources/js/common/alarm.js"></script>    
</html>
<!------------------------------------------------------------->