/* 결제 모달 창 - 02.14 장재호 */
const closebtn2 = document.querySelector('.closebtn2');
const popup2 = document.querySelector('.popup2');
const inputH = document.querySelector('.inputMonthH') //결제 개월 수 입력받는 inputhidden
const amount = document.querySelector('.amount');
const amountV = document.querySelector('.amountValue');

function modal2(){ //결제창 on-off
	popup2.style.display = 'block';
}
closebtn2.addEventListener('click', function(){
	popup2.style.display = 'none';
});

//결제 개월 수 view에 hidden으로 출력
function monthSelect(e){
	console.log(e.value);
	const paynum = (15000*e.value);
	inputH.value = e.value;
	amount.textContent = "결제 금액 : " + paynum + "원";
	amountV.value = paynum;
}

