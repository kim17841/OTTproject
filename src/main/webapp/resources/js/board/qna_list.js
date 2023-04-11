$(function() {
	/* URL을 통한 접근 시 에러 View에 alert - 02.18 장재호 */
	const url = new URL(window.location.href);
	const urlParams = url.searchParams;
	if(urlParams.get('error') != null){
		alert(urlParams.get('error'));
	}

	/* 체크박스 전체 선택 기능 - 02.17 장재호 */
	  $('.js-check-all').on('click', function() {
		if ( $(this).prop('checked') ) {
		  	$('th input[type="checkbox"]').each(function() {
		  		$(this).prop('checked', true);
	        $(this).closest('tr').addClass('active');
		  	})
	  	} else {
	  		$('th input[type="checkbox"]').each(function() {
		  		$(this).prop('checked', false);
	        $(this).closest('tr').removeClass('active');
		  	})
	  	}

	  });

	  $('th[scope="row"] input[type="checkbox"]').on('click', function() {
	    if ( $(this).closest('tr').hasClass('active') ) {
	      $(this).closest('tr').removeClass('active');
	    } else {
	      $(this).closest('tr').addClass('active');
	    }
	  });
	  
	//selectbox 선택한 값만 검색 - 02.07 장재호
	  $('#searchBtn').click(function(){
	  	if($('input[type=text]').val() == 'undefined' || $('input[type=text]').val() == ''){		
	  		alert("검색어를 입력하세요");
	  		return;
	  	}
	  	document.form1.submit();
	  });
	  
	//검색 시 페이징처리 처리 - 02.14 장재호
	//1) 페이지 버튼 클릭 시 pageNum값을 가지고 form태그로 이동하도록 처리
	//2) 화면에 검색키워드가 미리 남겨지도록 처리.
	var pagination = document.querySelector("#pagination");
	var pageUL = document.querySelector('#pageUL');
	pagination.onclick = function() {
		event.preventDefault();
		if((event.target.className).indexOf("right") != -1){
			document.form2.page.value = Number(document.form2.page.value) +5;
			document.form2.submit();
			return;
		}else if((event.target.className).indexOf("left") != -1){
			document.form2.page.value = Number(document.form2.page.value) -5;
			document.form2.submit();
			return;
		}else if(event.target.tagName == 'A' || event.target.tagName == 'I'){
			document.form2.page.value = event.target.textContent;
			document.form2.submit();
		}
		else return;
	}
	
	/* 비밀번호 걸려있는 게시글일 시 비밀번호 입력 시키기 - 02.17 장재호 */
	$('.moveDetail').on('click', function(e){
		//체크박스 선택 시 
		if(e.target.tagName === 'DIV' || e.target.tagName === 'INPUT'){
			return;
		}
		const nick = e.target.parentElement.children[2].textContent;
		const locker = e.target.parentElement.children[1];
		//비밀번호 걸려있는 글 접근 시
		if(locker.children.length == 2){
			//1. 관리자 접근 시 허용
			if($(".adminID").val() == 'admin' && $('.adminNick').val() == 'admin'){
				location.href='/qna/list/'+locker.textContent;
				return;
			}
			//2.비밀번호 입력 값이 다를 경우 접근 불가
			const passwordCheck = prompt("비밀번호를 입력하세요", "비밀번호 입력");
			if(passwordCheck != $('.passwordInput').val()){ 
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
			else location.href='/qna/list/'+locker.textContent;
		}
		//비밀번호 없는 글
		else location.href='/qna/list/'+locker.textContent;
	})
	
});

const checkbox = document.querySelectorAll('.checkNum');

/* 질문 삭제(체크박스 기능) - 02.17 장재호 */
function qnaDelete(){
	const delArr = new Array();	
	
	checkbox.forEach(function(e){
		//체크 된 녀석의 질문번호 받아오기
		if(e.checked){
			delArr.push(e.parentElement.nextElementSibling.value);			
		}
	})
	
	//삭제 선택 안하고 삭제 버튼만 클릭 시 막기
	if(delArr.length == 0){
		alert("삭제할 게시물을 선택해 주세요");
		return;
	}
	
	//삭제 게시물 PK 전송
	if(confirm("삭제하시겠습니까?")){
		$.ajax({
			url : 'qnaDeletes',
			data : JSON.stringify(delArr),
			type : 'post',
			contentType: 'application/json; charset=utf-8',	
			success:function(data){
				alert("삭제 완료");
			}
		});
		location.href="/qna/list";
	}
}




