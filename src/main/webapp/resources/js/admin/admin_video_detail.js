const input = document.querySelectorAll('input');
const textarea = document.querySelectorAll('textarea');

/* 창 로드 시 */
window.onload = function(){
	/* readonly 색상 수정 */
	input.forEach(function(e){
		if(e.readOnly){
			e.style.backgroundColor = "#F5F5F5";
		}
	});
}


function dataDelete(){	
	if(confirm("삭제하시겠습니까?")){		
		document.dataform1.action="/videoDataDelete"
		document.dataform1.submit();
	}
}

function dataModify(){
	if(confirm("수정하시겠습니까?")){
		document.videoModifyForm.action="/videoDataModify"
		document.videoModifyForm.submit();
	}
}
