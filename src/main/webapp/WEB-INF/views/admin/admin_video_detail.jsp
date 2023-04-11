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
				            <form method="post" name="videoModifyForm">	
				            <input type="hidden" name="video_id" value="${data.video_id}">			            
				                <div class="form-row">
				                    <div class="name">제목</div>
				                    <div class="value">
				                        <div class="input-group">
				                            <input id="title" class="input--style-6" type="text" name="title" value="${data.title}">
				                        </div>
				                    </div>
				                </div>
				                <div class="form-row">
				                    <div class="name">줄거리</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <textarea class="textarea--style-6" id="content" name="summary">${data.summary}</textarea>
				                        </div>
				                    </div>
				                </div>
				                <div class="form-row">
				                    <div class="name">URL</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <input class="input--style-6" id="content" name="video_url" value="${data.video_url}">
				                        </div>
				                    </div>
				                </div>
	   			                <div class="form-row">
				                    <div class="name">이미지URL</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <input class="input--style-6" id="content" name="image_url" value="${data.image_url}">
				                        </div>
				                    </div>
				                </div>
				                <div class="form-row">
				                    <div class="name">제작년도, 국가, 등급</div>
				                    <div class="value">
				                        <div class="input-group">                        
				                            <input style="width:33%;" class="input--style-6" id="content2" name="create_country" value="${data.create_country}">
				                            <input style="width:33%;" class="input--style-6" id="content2" name="create_year" value="${data.create_year}">
				                            <input style="width:33%;" class="input--style-6" id="content2" name="grade" value="${data.grade}">
				                        </div>
				                    </div>
				                </div>
				                </form>
				                <div class="form-row">
				                    <div class="name">업로드 일자</div>
				                    <div class="value">
				                        <div class="input-group">
				                            <input class="input--style-6" id="content" name="video_url" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${data.upload_date}" />" readonly>
				                        </div>
				                    </div>
				                    <div class="centerBtn">
					                  	<form id="centerForm" name="dataform1">
					                  		<input type="hidden" name="delVideoID" value="${video_id}" type="number">					                  	
											<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="dataModify()">수정하기</button>						
											<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="dataDelete()">삭제하기</button>			
										</form>
										<button class="btn btn--radius-2 btn--blue-2" type="button" onclick="location.href='/admin/databases/video'">목록으로</button>	
				                    </div>                    
				                </div>
				            </div>
				        </div>
				    </div>
				</div>			
			</div>
		</div>
	</div>
</div>
<script src="/resources/js/admin/admin_video_detail.js"></script>
<script src="/resources/js/admin/admin_main.js"></script>
</body>
</html>