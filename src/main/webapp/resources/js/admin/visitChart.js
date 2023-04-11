/* 관리자 페이지의 장르 차트 - 02.16 장재호 */
const visit = document.querySelector('#visitH').value.split(", "); //카테고리 별 조회수 값
const numArr = new Array();
const visitArr = new Array();
const visitArr2 = new Array();

/* 배열에 장르 정보, 조회수 정보만 뽑아옴 */
visit.forEach(function(data){
	if(data.indexOf('number') != -1){
		numArr.push(data.split(" : ")[1]);
	}
	if(data.indexOf('visit_date') != -1){
		visitArr.push(data.split(" : ")[1]);
	}
})

visitArr.forEach(function(e){
	visitArr2.push(e.split(" ")[2]);
})

/* 차트에 칼라 부여*/
const rgb4 = new Array();
for(var i=0; i<visitArr.length; i++){
	let r = Math.floor(Math.random() * 256);
	let g = Math.floor(Math.random() * 256);
	let b = Math.floor(Math.random() * 256);
	rgb4.push("rgb(" + r + "," + g + "," + b + ")");
}

var ctx4 = document.getElementById('visitChart');
var chart4 = new Chart(ctx4, {
	// 챠트 종류를 선택
	type: 'line',

	// 챠트를 그릴 데이타
	data: {
        labels: visitArr2,
        datasets: [{
          label: '주간 방문자',
          backgroundColor: 'transparent',
          borderColor: 'red',
          data: numArr
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