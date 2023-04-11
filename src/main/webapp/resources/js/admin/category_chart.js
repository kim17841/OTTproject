/* 관리자 페이지의 카테고리 차트 - 02.16 장재호 */
const cat = document.querySelector('#categoryH').value.split(", "); //카테고리 별 조회수 값
const hitArr = new Array();
const categoryArr = new Array();

/* 배열에 카테고리 정보, 조회수 정보만 뽑아옴 */
cat.forEach(function(data){
	if(data.indexOf('hit') != -1){
		hitArr.push(data.split(" : ")[1]);
	}
	if(data.indexOf('category_name') != -1){
		categoryArr.push(data.split(" : ")[1]);
	}
})

/* 차트에 칼라 부여*/
const rgb = new Array();
for(var i=0; i<categoryArr.length; i++){
	let r = Math.floor(Math.random() * 256);
	let g = Math.floor(Math.random() * 256);
	let b = Math.floor(Math.random() * 256);
	rgb.push("rgb(" + r + "," + g + "," + b + ")");
}

var ctx = document.getElementById('categoryChart');
var chart = new Chart(ctx, {
	// 챠트 종류를 선택
	type: 'bar',

	// 챠트를 그릴 데이타
	data: {
		labels: categoryArr,
		datasets: [{
			label: '카테고리 별 조회수',
			data: hitArr,
			backgroundColor: rgb,
			borderColor: rgb,
			borderWidth: 1
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