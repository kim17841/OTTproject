<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/resources/css/common/table.css">
<link href="/resources/css/admin/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/admin/main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
<!-- 검색 -->
<link rel="stylesheet" href="/resources/css/board/qna_create.css">
<!-- 검색 및 테이블 -->
<link rel="stylesheet" href="/resources/css/board/qna_list.css">
<link rel="stylesheet" href="/resources/css/board/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
</head>
<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">

	<!-- Sidebar -->
	<ul id="navUL" class="navbar-nav bg-secondary sidebar sidebar-dark accordion" id="accordionSidebar">
		<!-- Sidebar - Brand -->
		<a class="sidebar-brand d-flex align-items-center justify-content-center" href="/admin">
			<div class="sidebar-brand-icon rotate-n-15">
				<i class="fas fa-laugh-wink"></i>
			</div>
			<div class="sidebar-brand-text mx-3">관리자 페이지</div>
		</a>	
		<!-- Divider -->
		<hr class="sidebar-divider my-0">	
		<!-- Nav Item - Dashboard -->
		<li class="nav-item active">
			<a class="nav-link" href="/admin/userlist">
				<i class="fas fa-fw fa-tachometer-alt"></i>
				<span>회원 관리</span>
			</a>
		</li>

		<!-- Divider -->
		<hr class="sidebar-divider">
		
		<!-- Heading -->
		<div class="sidebar-heading">
		    databases
		</div>
		
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item">
		    <a id="dropdownLI" class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
		        aria-expanded="true" aria-controls="collapseTwo">
		        <i class="fas fa-fw fa-cog"></i>
		        <span>Database</span>
		    </a>
		    <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
		        <div class="bg-white py-2 collapse-inner rounded">
		            <h6 class="collapse-header">Video Database:</h6>
		            <a class="collapse-item" href="/admin/databases/video">Video</a>
		            <a class="collapse-item" href="/admin/databases/others">Others</a>
		        </div>
		    </div>
		</li>
		
		<hr class="sidebar-divider">
		<div class="sidebar-heading">
		    1:1chat
		</div>
		
		<!-- Nav Item - Pages Collapse Menu -->
		<li class="nav-item">
		    <a id="dropdownLI" class="nav-link collapsed" aria-expanded="true" aria-controls="collapseTwo" href="/admin/adminchat">
		        <i class="fas fa-fw fa-cog"></i>
		        <span>Chat</span>
		    </a>
		</li>	
		<!-- Divider -->
	    <hr class="sidebar-divider d-none d-md-block">
	</ul>
	<!-- End of Sidebar -->
	
	<!-- Content Wrapper -->
	<div id="content-wrapper" class="d-flex flex-column">
	
		<!-- Main Content -->
		<div id="content">
	
			<!-- Topbar -->
			<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
				<div class="d-sm-flex align-items-center justify-content-between mb-4">
					<h1 class="h3 mb-0 text-gray-800">Video Details</h1>
				</div>
			</nav>
			
			<!-- Begin Page Content -->
			<div class="container-fluid">
			
				<div class="page-wrapper p-t-100 p-b-50">
				    <div class="wrapper wrapper--w900">
				        <div class="card card-6">
				            <div class="card-body">
				            <form method="post" name="videoCreateForm" action="/admin/videoCreate">	
				                <div class="form-row">
				                    <div class="name">제목</div>
				                    <div class="value">
				                        <div class="input-group">
				                            <input id="title" class="input--style-6" type="text" name="title" placeholder="제목 입력">
				                        </div>
				                    </div>
				                </div>
				                <div class="form-row">
				                    <div class="name">줄거리</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <textarea class="textarea--style-6" id="content" name="summary" placeholder="줄거리 입력"></textarea>
				                        </div>
				                    </div>
				                </div>
  				                <div class="form-row">
				                    <div class="name">출연진</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <textarea class="textarea--style-6" id="content" name="actor_name" placeholder="출연진 구분을 쉼표(,)로 처리 해 주시기 바랍니다 *띄어쓰기 금지*"></textarea>
				                        </div>
				                    </div>
				                </div>
				                <div class="form-row">
				                    <div class="name">URL</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <input class="input--style-6" id="content" name="video_url" placeholder="video URL">
				                        </div>
				                    </div>
				                </div>
	   			                <div class="form-row">
				                    <div class="name">이미지URL</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <input class="input--style-6" id="content" name="image_url" placeholder="image URL">
				                        </div>
				                    </div>
				                </div>
				                <div class="form-row">
				                    <div class="name">제작년도<br>국가<br>등급</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <input style="width:33%;" class="input--style-6" id="content2" name="create_country" placeholder="제작년도">
				                            <input style="width:33%;" class="input--style-6" id="content2" name="create_year" placeholder="국가">
				                            <input style="width:33%;" class="input--style-6" id="content2" name="grade" placeholder="등급">
				                        </div>
				                    </div>
				                </div>
				                <div class="form-row">
				                    <div class="name">카테고리<br>장르</div>
				                    <div class="value">
				                        <div class="input-group">
  				                            <input style="width:50%;" class="input--style-6" id="content2" name="category_name" placeholder="카테고리">
				                            <input style="width:50%;" class="input--style-6" id="content2" name="genre_name" placeholder="장르">
				                        </div>
				                    </div>
				                    <div class="centerBtn">
										<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="videoCreate()">등록하기</button>									
										<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="location.href='/admin/databases/video'">목록으로</button>	
				                    </div>                    
				                </div>
       			                </form>				                
				            </div>
				        </div>
				    </div>
				</div>			
			</div>
		</div>
	</div>
</div>
<script src="/resources/js/admin/admin_video_create.js"></script>
<script src="/resources/js/admin/admin_video_detail.js"></script>
<script src="/resources/js/admin/admin_main.js"></script>
</body>
</html>