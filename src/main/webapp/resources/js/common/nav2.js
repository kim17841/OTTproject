// qna 네비바 js
// nav바 작업으로 nav2 추가 - 02.28 김범수
// 로고 클릭시 페이지 새로고침  추가 0227 장재호
  function back(){
     if($('#sessionID').val() != null){
        window.location.href="/video/list";
     }
     else window.location.reload();
  }   
    


  // 네비바 스크롤시 백그라운드 적용 
  function handleScroll() {
      const scrolled = window.scrollY > 50;
      const nav = document.querySelector('nav');
      if (scrolled) {
          nav.classList.add('scrolled');
      }else{
          nav.classList.remove('scrolled');
      }
  } 



  window.addEventListener('scroll', handleScroll);
  
////////////////////////02.28 김범수 네비바 작업 //////////////////// 
// 02.28 네비바 작업
function signout() {
   $.ajax({
      url : "/user/sign_out",
      success : function() {
         location.href = "/"
      }
   })
};

//이미지 로딩 위한 메서드 - 02.24김범수
$(function() {
   $('.nav_img_tag').ready(function() {
      $.ajax({
         url : '/user/navbarImg2',
         dataType : 'text',
         success : function(result2) {
            if(result2 == "" || result2 == null){return}
            let fileCallPath = encodeURI(result2); // 해당 파일의 이름
            $('.nav_img_tag').attr('src', "/mypage/display?fileName=" + fileCallPath);
         }
      });
   })
});