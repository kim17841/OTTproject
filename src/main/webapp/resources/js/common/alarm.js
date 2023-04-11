/* 02.23 장재호 */
const alarmUL = document.querySelector("#alarmUL");
const alarmI = document.querySelector("#alarmI");
const alarmDiv = document.querySelector("#alarmDiv"); 
var sock = null;
const alarm_Area = document.querySelector("#alarm_Area");

$(document).ready(function(){
	connectWs();

});

//소켓
function connectWs(){
	var ws = new SockJS("http://localhost:8080/echo");
	sock = ws;

	ws.onopen = function() {
 		ws.send($('#socketuserID').val());
	};

	ws.onmessage = function(event) {
		/* 받을 알람이 있을 때 */
		if(event.data.length>0){
			let newAlarm = '';
			newAlarm += '<div class="alarm_Text">' + event.data + "</div>"
			$('#alarm_Area').append(newAlarm);
			alarmDiv.style.visibility = "visible";
		}
	};

	ws.onclose = function() {
	};

};

/* 알람창 추가 */

alarmDiv.addEventListener('click', function(){
	alarm_Area.classList.toggle('visible');
	$(this).stop(false, false);
});

alarm_Area.addEventListener('click', function(e){
	var endIdx = e.target.textContent.indexOf(")");
	var idx = e.target.textContent.substr(1, endIdx-1);
	console.log(e.target.className);
	if(e.target.className == 'alarm_Text'){
		$.ajax({
			url : '/alarmDel',
			data : {"idx" : idx},
			type : 'post'
		});
		
		$(e.target).remove();
		if(alarm_Area.children.length == 0){
			alarmDiv.style.visibility = "hidden";
		}
	}	
	
})
/* *************************** */