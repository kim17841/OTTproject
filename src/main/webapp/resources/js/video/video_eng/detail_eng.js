// detail 페이지 내 영상부분 찜하기, 좋아요, 싫어요 버튼 누를시 칠해져있는 아이콘으로 변경하기
// 내보관함 페이지 이동 - 02.16 김범수 수정
const comu_btn = document.querySelectorAll('.comu_btn');

for(var i = 1; i<comu_btn.length; i++) {
    comu_btn[i].addEventListener('click', function(){
        this.classList.toggle('fas');
    });
}

comu_btn[0].addEventListener('click', function(){
	let title = $('#title_data').val(); // 찜하기 버튼 value - 02.28 김범수
    if(this.className.includes('fas')){ // 내보관함에서 삭제
    	$.ajax({
    		url : 'mylocker_de',
    		type : 'post',
    		data : {'title' : title},		
    	})
    	this.className = 'far fa-heart comu_btn';
    	alert('Wishlist has been removed');
    
    }else { // 내보관함에 담기
    	$.ajax({
    		url : 'mylocker_in',
    		type : 'post',
    		data : {'title' : title},
    	})
    	this.className = 'fas fa-heart comu_btn';
    	alert('Wishlist is complete');
    }
});

//댓글 이미지 로딩 - 03.06김범수
$(function() {
	$('.com_img').ready(function() {
		let fileInput = document.querySelectorAll('.com_img');
		
		for(let i = 0; i < fileInput.length; i++){
			let formData = new FormData();
			
			formData.append("uploadFile", fileInput[i].currentSrc);
			$.ajax({
				url: '/mypage/onload',
		    	processData : false,
		    	contentType : false,
				data : formData,
		    	type : 'POST',
				dataType : 'text',
				success : function(result2) {
					if(result2 == "" || result2 == null){return}
					let fileCallPath = encodeURI(result2); // 해당 파일의 이름
					fileInput[i].src = "/mypage/display?fileName=" + fileCallPath;
				}
			});
		}
	})
});

//대댓글 이미지 로딩 - 03.06김범수
function imgOnload() {
	$('.cocom_img').ready(function() {
		let fileInput = document.querySelectorAll('.cocom_img');
		
		for(let i = 0; i < fileInput.length; i++){
			let formData = new FormData();
			
			formData.append("uploadFile", fileInput[i].currentSrc);
			$.ajax({
				url: '/mypage/onload',
		    	processData : false,
		    	contentType : false,
				data : formData,
		    	type : 'POST',
				dataType : 'text',
				success : function(result2) {
					if(result2 == "" || result2 == null){return}
					let fileCallPath = encodeURI(result2); // 해당 파일의 이름
					fileInput[i].src = "/mypage/display?fileName=" + fileCallPath;
				}
			});
		}
	});
}

///////////////////////////////// 댓글, 대댓글 공통  ///////////////////////////////////////

	// 부모요소와 자식요소 찾아가기 start
	function findid(element, parentSelector, childSelector) {
		const parent = element.closest(parentSelector);
		if (parent) {
			const child = parent.querySelector(childSelector);
			if (child) {
				return child.value;
			}
		}
		return null;
	}
	// 부모요소와 자식요소 찾아가기 end

	// 댓글, 대댓글 수정 중 수정취소 버튼클릭시 영역 없애기 start
	function comt_edit_cancle(e) {
	   e.setAttribute('class', 'on');
	   let text_div = e.parentNode;
	   $(text_div).empty();
	}
	// 댓글, 대댓글 수정 중 수정취소 버튼클릭시 영역 없애기 end
	
	// 댓글, 대댓글 삭제 start
	$(document).on('click', '.comment_delete', function(e){
		e.preventDefault();
		let comment_id = findid(e.target, '.comment_btn', '.c_id_input');
		
		$.ajax({
			data : { comment_id : comment_id },
			url : '/comt/delete',
			type : 'POST',
			success : function(){
				window.location.reload();
				alert("Deletion complete.");
			}
		});		
	});
	// 댓글, 대댓글 삭제 end	
	
	// text area 내용이 원래 내용일경우 클릭했을때 자동으로 없애기 start 03.08 장민실
	function text_clear(e) {
		if(e.value == e.defaultValue) {
			e.value='';
		}
	}
	// text area 내용이 원래 내용일경우 클릭했을때 자동으로 없애기 start 03.08 장민실
	
///////////////////////////////// 댓글, 대댓글 공통  ///////////////////////////////////////
	
///////////////////////////////// 원댓글  ///////////////////////////////////////
	
	// 원댓글 작성하기 start
	$("#comment_write_btn").on('click', function(event){ 
		document.comt_write.action="/comt/write";
		document.comt_write.submit();
	});
	// 원댓글 작성하기 end
	   
// 댓글 수정 영역 start
	
	// 댓글 수정버튼 눌렀을때 수정 폼 가져오기
	$(".comment_update").on('click', function(e){
		let comt_edit_div = this.parentNode.nextElementSibling.nextElementSibling;
		let comt_text = this.parentNode.parentNode.parentNode.previousElementSibling.innerText;
		let comtEditText = "";
		comtEditText += "<p class='comt_edit_title text'>Edit comment</p>";
		comtEditText += "<form name='comt_edit' method='post'>";
		comtEditText += "      <textarea rows='3' cols='60' onclick='text_clear(this)' class='com_edit_text'>" + comt_text + "</textarea>";
		comtEditText += "      <button type='button' class='edit_complete' onclick='comt_edit_complete(this)'>edit complete</button>";
		comtEditText += "      <button type='button' class='edit_cancle' onclick='comt_edit_cancle(this)'>edit cancle</button>";
		comtEditText += "</form>";
		$(comt_edit_div).html(comtEditText);
	});
	   
	// 댓글 수정완료 버튼클릭
	function comt_edit_complete(e) {
		e.setAttribute('class', 'on');
		let comment_id = findid(e, 'td', '.c_id_input');
		let commentary = findid(e, '.comt_edit', '.com_edit_text');
		   
		$.ajax({
			data : { comment_id : comment_id, commentary : commentary },
			url : "/comt/edit/" + comment_id,
			type : 'POST',
			success : function(){
				window.location.reload();
				alert("Comments have been edited.");
			}
		});		
	};
//  댓글 수정 영역 end
	
///////////////////////////////// 원댓글  ///////////////////////////////////////
		
///////////////////////////////// 대댓글  ///////////////////////////////////////
		
	// 대댓글 작성하기 start
	$(".cocom_write_btn").on('click', function(e){
		let cocom_insert_div = this.parentNode.nextElementSibling;
		let cocomForm = "";
		cocomForm += "<p class='cocom_write_title text'>Write a reply</p>"
		cocomForm += "<form name='cocom_write' method='post'>";
		cocomForm += "      <textarea rows='3' cols='60' class='cocom_text'></textarea>";
		cocomForm += "      <button type='button' class='cocom_complete' onclick='cocom_complete(this)'>Register reply</button>";
		cocomForm += "      <button type='button' class='cocom_cancle' onclick='comt_edit_cancle(this)'>deregistration</button>";
		cocomForm += "</form>";
		$(cocom_insert_div).html(cocomForm);
	});   	
	   
	function cocom_complete(e) {
		e.setAttribute('class', 'on');
		let video_id = document.querySelector('#v_input').value;
		let pid = findid(e, 'td', '.c_pid_input');
		let commentary = findid(e, '.cocomt_insert', '.cocom_text');
		   
		$.ajax({
			data : { video_id : video_id, pid : pid, commentary : commentary },
			url : "/comt/cocomwrite",
			type : 'POST',
			success : function(){
				window.location.reload();
				alert("Your reply is complete.");
			}
		});			   
		   
	}		
	// 대댓글 작성하기 end
	
//  대댓글 수정 영역 start
	// 대댓글 수정버튼 눌렀을때 수정 폼 가져오기
	$(document).on('click', '.cocomt_update', function(e){
		e.preventDefault();
		let cocom_edit_div = this.parentNode.nextElementSibling;
		let comt_text = this.parentNode.parentNode.parentNode.previousElementSibling.innerText;
		let comtEditText = "";
		comtEditText += "<p class='comt_edit_title text'>Edit comment</p>";
		comtEditText += "<form name='comt_edit' method='post'>";
		comtEditText += "      <textarea rows='3' cols='60' onclick='text_clear(this)' class='com_edit_text'>" + comt_text + "</textarea>";
		comtEditText += "      <button type='button' class='edit_complete' onclick='cocom_edit_complete(this)'>edit complete</button>";
		comtEditText += "      <button type='button' class='edit_cancle' onclick='comt_edit_cancle(this)'>edit cancle</button>";
		comtEditText += "</form>";
		$(cocom_edit_div).html(comtEditText);
	});
	
	// 대댓글 수정완료 버튼클릭
	function cocom_edit_complete(e) {
		e.setAttribute('class', 'on');
		let comment_id = findid(e, '.cocom_td', '.c_id_input');
		let commentary = findid(e, '.cocom_edit', '.com_edit_text');
		   
		$.ajax({
			data : { comment_id : comment_id, commentary : commentary },
			url : "/comt/edit/" + comment_id,
			type : 'POST',
			success : function(){
				window.location.reload();
				alert("Comments have been edited.");
			}
		});		
	};
//  대댓글 수정 영역 end
		
	// DB의 대댓글 불러와서 영역에 넣어주기 start
	let cocom_list_tf = false;
		
	$(".cocom_list_btn").on('click', function(e){
		let video_id = findid(e.target, '.comment_btn', '#v_input');
		let pid = findid(e.target, '.comment_btn', '.c_pid_input');
		let cocomListDiv = this.parentNode.nextElementSibling.nextElementSibling.nextElementSibling;

		if(cocom_list_tf===false) { 
			cocomt_list(video_id, pid, cocomListDiv);
			cocom_list_tf=true;
		}
		else if(cocom_list_tf===true) {
			$(cocomListDiv).empty();
			cocom_list_tf=false;
		}
	})
		
	function cocomt_list(video_id, pid, cocomListDiv) {
		$.ajax({
			type: "post",
			url: "/comt/cocomList/" + pid,
			data: { video_id : video_id },
			success: function(list) {

				let cocomText = "";
				
				if(list.length===0) {
					alert("There are no registered replies.");
				}	// 대댓글 없을때 if end
		         
				else {
					$(list).each(function(){
						// 대댓글 이미지 작업 - 03.06 김범수
						cocomText += "<tr>";
						if(this.img != null && this.img != '') {
							cocomText += "<td class='cocom_title text'>"
							cocomText += "	<div class='user_img_area'>"
							cocomText += "		<img src='" + this.img + "' class='cocom_img'>"
							cocomText += "	</div>"
						}
						else {
							cocomText += "<td class='cocom_title text'>"
							cocomText += "	<div class='user_img_area'>"
							cocomText += "		<img src='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU' class='img_tag2'>"
							cocomText += "	</div>"
						}
						///////////////////////////////
		     	        cocomText += this.nickname + "&nbsp;&nbsp;" + this.cocom_date + "</td>";
		     	        cocomText += "</tr>";
		     	        cocomText += "<tr>";
		     	        cocomText += "	<td class='cocom_contents text'>" + this.commentary + "</td>";
		     	        cocomText += "</tr>";
		     	       if (this.nickname === session) {
		     	    	   cocomText += "<td class='cocom_td'>";
		     	    	   cocomText += "   <div class='comment_btn' id='cocom_cd_btn'>";
		     	    	   cocomText += "		<input type='hidden' class='c_id_input' name='comment_id' value=" + this.comment_id + ">";
		     	    	   cocomText += "		<input type='button' class='cocomt_update' value='edit'>";
		     	    	   cocomText += "		<input type='button' class='comment_delete' value='delete'>";
		     	    	   cocomText += "   </div>";
		     	    	   cocomText += "<div class='cocom_edit'></div>";
		     	    	  cocomText += "<hr class='cocom_hr'>";
		     	    	   cocomText += "</td>";
		     	       }	// 로그인유저와 대댓글 작성자가 같을때 if end
					});
					$(cocomListDiv).html(cocomText);
					imgOnload(); // 대댓글 이미지 작업 - 03.06 김범수
		         }	// 대댓글 있을때 else end
		      }
		   });
		}
		// DB의 대댓글 불러와서 영역에 넣어주기 end
		
///////////////////////////////// 대댓글  ///////////////////////////////////////
	
///////////////////////////////// 영상 좋아요, 싫어요  ///////////////////////////////////////

	// 영상 좋아요 버튼 클릭
	$("#video_like").on('click', function(e){		
		document.comt_write.action="/inter/video_like";
		document.comt_write.submit();		
	});
	
	// 영상 싫어요 버튼 클릭
	$("#video_bad").on('click', function(e){
		document.comt_write.action="/inter/video_unlike";
		document.comt_write.submit();
	});

///////////////////////////////// 영상 좋아요, 싫어요  ///////////////////////////////////////

