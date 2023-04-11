/* 매출 차트 */
const sales = document.querySelector('#salesH').value.split(", "); //카테고리 별 조회수 값
const amountArr = new Array();
const salesArr = new Array();
const salesArr2 = new Array();
/* 배열에 장르 정보, 조회수 정보만 뽑아옴 */
sales.forEach(function(data){
	if(data.indexOf('amount') != -1){
		amountArr.push(data.split(" : ")[1]);
	}
	if(data.indexOf('paid_date') != -1){
		salesArr.push(data.split(" : ")[1]);
	}
})
salesArr.forEach(function(e){
	salesArr2.push(e.split(" ")[2]);
})

/* 차트에 칼라 부여*/
const rgb3 = new Array();
for(var i=0; i<salesArr.length; i++){
	let r = Math.floor(Math.random() * 256);
	let g = Math.floor(Math.random() * 256);
	let b = Math.floor(Math.random() * 256);
	rgb2.push("rgb(" + r + "," + g + "," + b + ")");
}

var ctx3 = document.getElementById('salesChart').getContext('2d');
var chart3 = new Chart(ctx3, {
	// 챠트 종류를 선택
	type: 'line',

	// 챠트를 그릴 데이타	
	data: {
        labels: salesArr2,
        datasets: [{
          label: '주간 매출',
          backgroundColor: 'transparent',
          borderColor: 'red',
          data: amountArr
        }]
      },
      
	options: {
		scales: {
			yAxes: [{
				ticks: {
					beginAtZero: true
				}
			}]
		}
	}
});