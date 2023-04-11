/* 관리자 페이지의 장르 차트 - 02.16 장재호 */
const gen = document.querySelector('#genreH').value.split(", "); //카테고리 별 조회수 값
const hitArr2 = new Array();
const genreArr = new Array();
/* 배열에 장르 정보, 조회수 정보만 뽑아옴 */
gen.forEach(function(data){
	if(data.indexOf('hit') != -1){
		hitArr2.push(data.split(" : ")[1]);
	}
	if(data.indexOf('genre_name') != -1){
		genreArr.push(data.split(" : ")[1]);
	}
})


/* 차트에 칼라 부여*/
const rgb2 = new Array();
for(var i=0; i<genreArr.length; i++){
	let r = Math.floor(Math.random() * 256);
	let g = Math.floor(Math.random() * 256);
	let b = Math.floor(Math.random() * 256);
	rgb2.push("rgb(" + r + "," + g + "," + b + ")");
}

var ctx2 = document.getElementById('genreChart');
var chart2 = new Chart(ctx2, {
	// 챠트 종류를 선택
	type: 'bar',

	// 챠트를 그릴 데이타
	data: {
		labels: genreArr,
		datasets: [{
			label: '카테고리 별 조회수',
			data: hitArr2,
			backgroundColor: rgb2,
			borderColor: rgb2,
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