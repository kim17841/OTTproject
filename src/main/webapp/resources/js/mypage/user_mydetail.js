// 모달창이용한 수정처리    _23/02/20 김지혜

   var modifyBtn = document.querySelector("#btnWrite");  // 수정하기 버튼
   
   // 모달창 요소 가져오기
   var modal = document.getElementById("user_info_myModal");
   // 모달창 닫기 버튼 요소 가져오기
   var closeBtn = document.getElementsByClassName("closebtn")[0];

   // 모달창의 보이는 상태 초기화 
   var modalTf = false; 
   
   // 모달창 열기 버튼 클릭 시 모달창 보이기
   modifyBtn.onclick = function() {

      // 수정하여 DB에 저장전, form에 저장되어 있는 값을 항상 불러오도록 함. 수정 23/03/06 김지혜 
      let fix_email = $("input[name='Info_Email']").val();  // 내 정보에 담겨있는 이메일값
      let modal_email = $('input[name="email"]');   // 모달창에 담겨있을 이메일값
      let fix_nickname = $('input[name="Info_Nickname"]').val(); // 내 정보에 담겨있는 닉네임값
      let modal_nickname = $('input[name="nickname"]');   // 모달창에 담겨있을 닉네임값
      let fix_phone_num = $('input[name="Info_Phone_num"]').val(); // 내 정보에 담겨있는 핸드폰번호값
      let modal_phone_num = $('input[name="phone_num"]'); // 모달창에 담겨있을 핸드폰번호값
      modal_email.val(fix_email);   
      modal_nickname.val(fix_nickname);
      modal_phone_num.val(fix_phone_num);
      
      modal.style.display = "block";
      modalTf = true; // 모달 창이 보일 경우 true로 설정
   }
   
   // 모달창 닫기 버튼 클릭 시 모달창 닫기
   closeBtn.onclick = function() {
      modal.style.display = "none";
      modalTf = false;// 모달 창이 보이지 않을 경우 false로 설정
   }

/////////////////////////////////////////////////////////////// 케러셀 이벤트
new Swiper('.swiper-container', {
   slidesPerView : 6, // 동시에 보여줄 슬라이드 갯수
   spaceBetween : 0, // 슬라이드간 간격

   navigation : { // 네비게이션
      nextEl : '.swiper-button-next', // 다음 버튼 클래스명
      prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
   },
});
   
//이미지 로딩 위한 메서드 - 02.24김범수
$(function() {
   $("input[type='file']").on("change", function(e){
      let formData = new FormData();
      let fileInput = $('input[name="uploadFile"]'); 
      let fileList = fileInput[0].files; //파일 객체
      let fileObj = fileList[0]; // 처음으로 선택된 파일
      if(!fileCheck(fileObj.name, fileObj.size)){
         return false;
      }
      formData.append("uploadFile", fileObj); //uploadFile라는 키값형성 - fileObj의 데이터가 여기에 담김
      
      $.ajax({
         url: '/mypage/upload',
          processData : false,
          contentType : false,
          data : formData, // form데이터 객체에 해당 파일의 정보가 담겨있음
          type : 'POST',
          dataType : 'json', // 제이슨타입으로 formdata를 전달
          success : function(result) {
            showUploadImage(result);  //이미지 출력 메서드
         },
          error : function(result){
             alert("이미지 파일이 아닙니다.");
          }
      });
   });
});

// 이미지인지 파일 체크, 용량 체크 - 02.24김범수
function fileCheck(fileName, fileSize){
   let regex = new RegExp("(.*?)\.(jpg|png)$"); // 이미지가 아닌 파일 잡는것
   let maxSize = 1048576; //1MB
   
   if(fileSize >= maxSize){
      alert("파일 사이즈 초과");
      return false;
   }
        
   if(!regex.test(fileName)){
      alert("해당 종류의 파일은 업로드할 수 없습니다.");
      return false;
   }   
   return true;   
}

//이미지 출력을 위한 메서드 - 02.24김범수
function showUploadImage(result){
   // 전달받은 데이터가 값이 없는 경우
   if(result == "" || result == null){return}
   let fileCallPath = encodeURI("C:\\upload\\"+result.uploadPath + result.uuid + "_" + result.fileName); // 해당 파일의 이름
   $('.img_tag').attr('src', "/mypage/display?fileName=" + fileCallPath);
   window.location.reload();
}

//이미지 로딩 위한 메서드 - 02.24김범수
$(function() {
   $("#img_onload").ready(function(){
      let formData = new FormData();
      let fileInput = $('#img_onload').attr('src'); 
      formData.append("uploadFile", fileInput); //uploadFile라는 키값형성 - fileObj의 데이터가 여기에 담김
      $.ajax({
         url: '/mypage/onload',
          processData : false,
          contentType : false,
          data : formData, // form데이터 객체에 해당 파일의 정보가 담겨있음
          type : 'POST',
          dataType : 'text', // 제이슨타입으로 formdata를 전달
          success : function(result) {
            showOnloadImage(result);  //이미지 출력 메서드
         },
          error : function(result){
             alert("이미지 파일이 아닙니다.");
          }
      });
   });
});

//이미지 로딩 위한 메서드 - 02.24김범수
function showOnloadImage(result){
	alert("Dsad");
	console.log("result", result);
   // 전달받은 데이터가 값이 없는 경우
   if(result == "" || result == null){return}
   let fileCallPath = encodeURI(result); // 해당 파일의 이름
   $('#img_onload').attr('src', "/mypage/display?fileName=" + fileCallPath);
}