<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/resources/css/common/navbar1.css">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body>
<!-- =========== 로그인 회원가입 네비바 ===========  -->
   <!-- header start -->
    <nav id="navbar">
       <!-- 로고영역 -->
        <div class="logo">
            <img src="/resources/img/user/logo4.png" onclick="location.href='/'" alt="">
        </div>
        <!-- 다국어 지원 기능 영역 -->
        <form name="lanForm">
        <div class="langdropdown">
            <select name="language" class="selectbox" onchange="lanChange()">
                <option value="none" class="select">=== 선택 ===</option>
                <option value="kor" class="select">한국어</option>
                <option value="eng" class="select">영어</option>
            </select>
        </div>
        </form>
    </nav>
    <!-- header end -->

<script src="/resources/js/common/language.js"></script>
</body>
</html>