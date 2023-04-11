const dropdown = document.querySelector("#dropdownLI");
const dropdiv = document.querySelector('.collapse');
dropdiv.style.transition = 'all 2s ease 0s';

dropdown.addEventListener('click', function(){
	dropdiv.classList.toggle('show');
});
