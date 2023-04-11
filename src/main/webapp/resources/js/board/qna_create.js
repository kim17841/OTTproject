const title = document.querySelector('input[id=title]');
const content = document.querySelector('textarea[id=content]');
const idInput = document.querySelector('input[id=id]');

/* 작성자가 회원일 때, 자동으로 세션에서 값을 받아 작성자 란 입력 못하게 - 02.18 장재호 */
window.onload = function(){
	if(idInput.value != ''){
		idInput.readOnly = true;
		idInput.style.backgroundColor = "#F5F5F5";
	}
}

// 등록 버튼 클릭 시 
function qCreate(){
	if(title.value == "") {
		alert("제목을 입력하세요");
		document.form1.q_subject.focus();
		return;
	}
	if(idInput.value == ""){
		alert("작성자를 입력하세요");
		document.form1.id.focus();
		return;
	}
	if(content.value == ""){
		alert("내용을 입력하세요");
		document.form1.q_content.focus();
		return;
	}
	
	if(idInput.readOnly == false){
		const newV = idInput.value;
		idInput.value = "guest_" + newV;
	}
	
	document.form1.action="create"
	document.form1.submit();	
}