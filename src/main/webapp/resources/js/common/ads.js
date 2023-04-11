const adsClose = document.querySelector('#adsClose');
const adsCon = document.querySelector("#adsCon");
adsClose.addEventListener('click', function(){
	adsCon.classList.toggle("closeAds")
})