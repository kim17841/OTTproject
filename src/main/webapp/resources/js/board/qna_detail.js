const input = document.querySelectorAll('input');
const answerValue = document.querySelector('#answerValue');
const adminCreate1 = document.querySelector('#adminCreate1');

/* 창 로드 시 */
window.onload = function(){
	/* 본인이면 내용 수정 가능, 아니면 불가 */
	if($('#sessionID').val() != $('#userID').val()){
		$('#content').attr('readonly', true);
		$('#content').css("background-color", "#F5F5F5");
	};
	
	/* readonly 색상 수정 */
	input.forEach(function(e){
		if(e.readOnly){
			e.style.backgroundColor = "#F5F5F5";
		}
	});
	
	/* 답변 완료 시 수정 불가 및 관리자 버튼 수정 */
	if(answerValue.value != ''){
		$('#content').attr('readonly', true);
		$('#content').css("background-color", "#F5F5F5");
		adminCreate1.textContent = "답변 수정";
	}
}


function qnaDelete(){	
	if(confirm("삭제하시겠습니까?")){		
		document.form1.action="qnaDelete"
		document.form1.submit();
	}
}
