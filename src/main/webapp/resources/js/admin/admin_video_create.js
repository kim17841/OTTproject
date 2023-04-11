/* 관리자 VIDEO CREATE JS - 02.19 장재호 */
const inputVC = document.querySelectorAll('input');
const textAreaVC = document.querySelectorAll('textArea');
var error1 = "";
var error2 = "";
function videoCreate(){

	if(inputVC[0].value === ''){
		alert("제목을 입력해주세요");
		return;
	}
	
	if(textAreaVC[0].value == ''){
		alert("제목을 입력해주세요");
		return;
	}
	
	if(textAreaVC[1].value == ''){
		alert("출연진을 입력해주세요");
		return;
	}
	
	inputVC.forEach(function(e){
		if(e.value == ''){
			error1 = 1;
		}
		if(inputVC[0].value != e.value){
			if(e.value.indexOf(" ") != -1){
				alert("제목, 줄거리를 제외한 내용에는 띄어쓰기를 빼주세요");
				return;
			}
		}
	})
	
	textAreaVC.forEach(function(e){
		if(e.value == '' || e.value == "undefined"){
			error2 = 1;
		}
		
	});
	if(textAreaVC[1].value.indexOf(" ") != -1){
		alert("출연진 란에 띄어쓰기를 입력할 수 없습니다.");
		return;
	}
	
	if(textAreaVC[1].value.indexOf(",") == -1){
		alert("출연진 구분을 쉼표(',')로 해주시기 랍니다");				
		return;
	}
	
	if(error1 == "" && error2 == ""){
		document.videoCreateForm.submit();
	}
	else{
		alert("정보를 입력해주세요");
		error1 = "";
		error2 = "";
		return;
	}
}

$(function(){
	const url = new URL(window.location.href);
	const urlParams = url.searchParams;
	if(urlParams.get('error') != null){
		alert(urlParams.get('error'));
	}
})

	

