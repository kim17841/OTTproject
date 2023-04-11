/* 카테고리 장르 DB 삭제, 추가 02.19 - 장재호 */
function delTarget(e){
	event.target.type="submit";
}
/* 한번에 selectorAll하니 인식안됨 ㅡㅡ; */
$(function(){
	$('#categoryBtn').on('click',function(){
		//텅비었을경우 리턴
		if(event.target.previousElementSibling.value == ''){
			alert("입력 후 등록 버튼을 눌려주세요");
			return;
		}
		event.target.type="submit";
	})	
	
	$('#genreBtn').on('click',function(){
		//텅비었을경우 리턴
		if(event.target.previousElementSibling.value == ''){
			alert("입력 후 등록 버튼을 눌려주세요");
			return;
		}		
		event.target.type="submit";
	})
	
	$('#actorBtn').on('click',function(){
		//텅비었을경우 리턴
		if(event.target.previousElementSibling.value == ''){
			alert("입력 후 등록 버튼을 눌려주세요");
			return;
		}		
		event.target.type="submit";
	})	

})

