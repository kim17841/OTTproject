/* 답변 모달 창 - 02.18 장재호 */
const closebtn = document.querySelector('.closebtn');
const popup = document.querySelector('.popup');
const contentArea = document.querySelector('#contentArea');
const question_id = document.querySelector('input[name=question_id]').value;
const btnCenter = document.querySelector('#btnCenter');
const q_subject = document.querySelector('#alarmSubejct').value;
const alarmID = document.querySelector('#alarmID').value;

function modal(e){ //답변 on-off
	//답변보기 눌렸을 때 받아와서 띄워줌		
	$(function(){
		$.ajax({
			url : "answerGet",
			type : 'post',
			data : {"question_id" : question_id},
			dataType : 'text',
			success : function(data){
				contentArea.value = data;
				contentArea.style.backgroundColor = '#F5F5F5';
			}
		})
	})
	if(e.textContent == "답변 보기"){
		contentArea.readOnly = true;
	}
	else{
		btnCenter.style.display = 'block';
		contentArea.readOnly = false;
		contentArea.style.backgroundColor = '#fff !important';
	}
	popup.style.display = 'block';
}
closebtn.addEventListener('click', function(){
	popup.style.display = 'none';
});

/* 답변 등록 - 02.18 장재호 */
function answerCreate(){
	if(contentArea.value == ''){
		alert("답변을 입력해 주세요");
		return;
	}
	let id = $('input[name="id"]').val();
	
	/* 알람 기능 추가 - 02.23 장재호 */
	$.ajax({
		url : '/qna/answerCreate',
		type : 'post',
		data : {"question_id" : question_id, "answer" : contentArea.value, "id" : alarmID},		
        success : function(data){
        	/* alarm.jsp -> sock 변수 선언 해 둔 socket 생성 시 */
        	if(sock){
        		let socketMsg = id + "," + q_subject; /* 작성자와 question_id 보냄. */
    			sock.send(socketMsg);
        	}
        	else{
        		alert("소켓 전송 실패");
        	}
        	window.location.href="/qna/list";
        },error : function(error){
        }
	})
}
