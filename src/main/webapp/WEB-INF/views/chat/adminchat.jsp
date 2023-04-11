<!-- 02.25 장재호 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" />
<link rel="stylesheet" href="/resources/css/admin/main.css">
<link href="/resources/css/admin/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="/resources/css/board/qna_list.css">
<link rel="stylesheet" href="/resources/css/board/style.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="/resources/css/board/searchbar.css">
<script src="/resources/js/chat/adminchat.js"></script>
</head>
<body>

<!-- Page Wrapper -->
<div id="wrapper">

	<!-- Sidebar -->
	<ul id="navUL" class="navbar-nav bg-secondary sidebar sidebar-dark accordion">
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
					<h1 class="h3 mb-0 text-gray-800">Chat</h1>
				</div>
			</nav>
			<!-- End of Topbar -->
	
			<!-- Begin Page Content -->
			<div class="container-fluid">
			
				<!-- 채팅 -->
				<div class="template" style="display:none;">
					<form>
						<input type="text" class="message" onkeydown="if(event.keyCode === 13) return false;">
						<input value="Send" type="button" class="sendBtn">
					</form>
					<br />
					<textarea id="messageArea"rows="10" cols="50" class="console" disabled="disabled"></textarea>
				</div>
			</div>
		</div>
	</div>
</div>	
<script src="/resources/js/admin/admin_main.js"></script>	
</body>
</html>
<!-- -------------------------------------------- -->