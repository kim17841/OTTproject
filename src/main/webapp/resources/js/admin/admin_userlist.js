/* 자동화 되어 있긴 하지만 혹시 모를 회원 삭제(체크박스 기능) - 02.18 장재호 */
const checkbox = document.querySelectorAll('.checkNum');
function userDelete(){
	const delArr = new Array();	
	
	checkbox.forEach(function(e){
		//체크 된 녀석의 질문번호 받아오기
		if(e.checked){
			delArr.push(e.parentElement.parentElement.nextElementSibling.textContent);
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
			url : '/admin/userDeletes',
			data : JSON.stringify(delArr),
			type : 'post',
			contentType: 'application/json; charset=utf-8',	
			success:function(data){
				alert("성공");				
			}
		});
	}
}

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
});

