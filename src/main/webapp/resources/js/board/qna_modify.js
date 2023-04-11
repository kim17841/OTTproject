const content = document.querySelector('textarea[id=content]');
const question_id2 = document.querySelector('input[name=question_id]').value;

// 등록 버튼 클릭 시 
function qModify(){
	if(content.value == ""){
		alert("내용을 입력하세요");
		content.focus();
		return;
	}
	else{
		const modifying = content.value;
		$.ajax({
			url : 'modify',
			type : 'post',
			data : {'question_id' : question_id2, 'q_content' : modifying},
			dataType : 'text',
			success : function(data){
				if(data == "수정완료"){
					alert("수정 완료");
					location.href = "/qna/list";
				}
			}
		});
	}
}