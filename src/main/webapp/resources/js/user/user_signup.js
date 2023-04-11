// code : 인증번호를 담을 변수  / email : 이메일을 담을 변수
   var code = "";
   var email = "";

   //혹시 모를 청개구리의 enter키 입력 방지      _ 장재호
   document.addEventListener('keydown', function(e){
      if (e.key === 'Enter'){
         e.preventDefault();
      };
   }, true);
   

   // 아이디  i, 비밀번호 p, 닉네임 n, 휴대폰  c, 동의  d
   var i=0, p=0, n=0, c=0, d=0;

   
   window.onload = function(){
	   if($('#nicknamecheck').val() != null){
		   n=1
	   }
	   if($('#phone_numcheck').val() != null){
		   c=1
	   }
   }


   // 전화번호 표현식 맞지 않을 경우 제어_ 정규표현식   23/02/01 김지혜 
   // - (하이픈) 자동 추가 기능으로  수정  23/02/09 김지혜 
   const autoHyphen = function(target) {
       target.value = target.value
       .replace(/[^0-9]/g, '')
       .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
       if(target.value.length == 13) c=1; // 최종 전화번호 가입조건 통과.
       else c=0;
   }
   
   
$(function(){   
   // 제이쿼리를 이용한 이메일 중복확인   
   $("#email_btn").click(function() {
      var email = $('#email').val();
      if(!email.includes('@')){
    	  if($('#sessionL').val() == 'eng'){ //영문ver - 03.06 장재호
    		  $('#emailcheck').html('please check your E-MAIL format');
    	  }
    	  else{
    	      $('#emailcheck').html('올바른 이메일을 입력해 주세요');    		  
    	  }
      }
      else{
         $.ajax({
            type : 'post',
            url : 'emailCheck',
            data : {'email':email},
            success:function(tf){
            	if($('#sessionL').val() == 'eng'){ //영문ver - 03.06 장재호
            		if(tf){
                        $('#emailcheck').html("duplicate");
                    }
                	else{
                        $('#emailcheck').html("available");
                	}
            	}
            	else{
            		if(tf){
	                    $('#emailcheck').html("중복된 이메일입니다.");
	                }
	            	else{
	                    $('#emailcheck').html("이메일 사용 가능합니다");
	            	}
            	}
	            	
            },
         })         
      }
   });   


   // 패스워드 눈모양 클릭 시 text로 보이기   ( 23/02/09 김지혜 ) 
   // 비밀번호란 눈모양 이벤트리스너 
   $('#eye1').on('click',function(){
      $('#password').toggleClass('active'); // 부모 태그 .input.password가 active 토글활성화
      
      if($('#password').hasClass('active') == true){  // active가 활성화가 될 때 자식 input의 타입을 text로 바꿔서 비밀번호 텍스트를 보이게 함 
           $(this).attr('class',"fa-solid fa-eye fa-lg")
              .prev('input').attr('type',"text");
      }else{ // Class값이 'active'가 아닐 경우 
          $(this).attr('class',"fa-solid fa-eye-slash fa-lg")
              .prev('input').attr('type','password');
          }
   });
      // 비밀번호확인란 눈모양 이벤트리스너 
   $('#eye2').on('click',function(){
       $('#password1').toggleClass('active'); // 부모 태그 .input.password가 active 토글활성화
   
       if($('#password1').hasClass('active') == true){  // active가 활성화가 될 때 자식 input의 타입을 text로 바꿔서 비밀번호 텍스트를 보이게 함 
            $(this).attr('class',"fa-solid fa-eye fa-lg")
               .prev('input').attr('type',"text");
       }else{ // Class값이 'active'가 아닐 경우 
           $(this).attr('class',"fa-solid fa-eye-slash fa-lg")
               .prev('input').attr('type','password');
          }
   });




   
   // 닉네임 - 뷰단은 띄어쓰기. 특수문제 제어  _   23/02/09 김지혜 
   const nick = document.querySelector('#nicknamecheck');
   var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?]/gi;
   nick.addEventListener('keyup', function(){
       n=0; // 초기기본값에 최종가입되지 않도록 막음.
       /********************* 영문ver 추가 - 03.06 장재호 ********************/
       if($('#sessionL').val() == 'eng'){
           if (nick.value == null || nick.value == "") {
               $('#nncheck').html("please enter your nickname");
               nick.focus(); // 닉네임입력란에 focus될 수 있도록 지정. 
              //닉네임 빈칸 포함 안됨
              } else if (nick.value.search(/\s/) != -1) {
                 $('#nncheck').html("can't contain spaces");
                 nick.focus();
              }else if (specialCheck.test(nick.value)) {
                 $('#nncheck').html("can't contain characters(!@#$%^...)");
                 nick.focus(); // 올바르게 닉네임이 입력안될 시 다른 항목으로 넘어갈 수 없도록 차단.
              }else{
                 n=1; // 최종 닉네임 항목 통과
                 $('#nncheck').html("");
              }
       }
       else{
           if (nick.value == null || nick.value == "") {
               $('#nncheck').html("닉네임 입력은 필수입니다.");
               nick.focus(); // 닉네임입력란에 focus될 수 있도록 지정. 
              //닉네임 빈칸 포함 안됨
              } else if (nick.value.search(/\s/) != -1) {
                 $('#nncheck').html("닉네임은 공백을 포함 할 수 없습니다.");
                 nick.focus();
              }else if (specialCheck.test(nick.value)) {
                 $('#nncheck').html("닉네임은 특수문자를 포함 할 수 없습니다.");
                 nick.focus(); // 올바르게 닉네임이 입력안될 시 다른 항목으로 넘어갈 수 없도록 차단.
              }else{
                 n=1; // 최종 닉네임 항목 통과
                 $('#nncheck').html("");
             }
       }
       /**********************************************************/
   });

   


   //  동의항목   23/02/08 김지혜
      $('#checkbox').on('click',function(e){
         
         // 모두 동의하기를 선택했을 경우
         if(e.target.id == 'selectAll') {
            if(e.target.checked) $('input[type=checkbox]').prop('checked', true);  // e.target.checked상태가  true일 경우, 체크 상태로 변환.
            else $('input[type=checkbox]').prop('checked', false); // e.target.checked상태가  아닐 경우, 체크 상태 해제.
            d=1;  // 동의항목조건 최종 통과.
         }
   
         // 동의항목 3개 모두 체크상태일 경우, 모두 동의하기까지 checked상태
         if($('#check1').is(':checked') && $('#check2').is(':checked') && $('#check3').is(':checked')){
            $('#selectAll').prop('checked', true);
            d=1; // 동의항목조건 최종 통과.
         }
         
         // 동의항목 3개 모두 체크상태가 아닐 경우, 모두 동의하기까지 checked가 아닌 상태
         if($('#check1').is(':checked') == false || $('#check2').is(':checked') == false || $('#check3').is(':checked') == false){         
            $('#selectAll').prop('checked', false);
            d=0; // 동의항목 조건 통과불가능.
         }
      });


        
   //  아이디입력요소 추가  23/02/09 김지혜       
   // 아이디 형식 확인_ 가입하기 버튼을 클릭했을 시, (UserController에 idCheck 참고) 
      $('#btn').click(function(){
         let id = $('#id').val();
         if(id == null || id == ""){ // 아이디입력값이 null이거나 빈칸일 경우 제어.
        	 //영문ver 추가 - 03.06 장재호
        	 if($('#sessionL').val() == 'eng'){
                 $('#idcheck').html('enter your ID');
        	 }
        	 else{
                 $('#idcheck').html('아이디를 입력해주세요'); 
        	 }
            return;
         }else{
            //ajax로 id 보내기 -> idCheck 매핑된 곳으로 보내서 중복 확인
            $.ajax({
               url : 'idCheck',
               type : 'post',
               data : {'id' : id}, // 입력한 id data
               dataType : 'text', 
               success : function(result){            	   
                  //result가 text 형태로 와서 false가 text 형태로 비교
            	   /********************영문ver 추가 - 03.06 장재호*******************/
            	   if($('#sessionL').val() == 'eng'){
                       if(result == 'false'){      //false = 사용가능
                           $('#idcheck').html('available');
                           i=1;  // 아이디영역은 최종 가입에 조건만족
                        }else{
                           $('#idcheck').html('duplicate');
                        }
            	   }
            	   else{
                       if(result == 'false'){      //false = 사용가능
                           $('#idcheck').html('사용 가능한 ID입니다.');
                           i=1;  // 아이디영역은 최종 가입에 조건만족
                        }else{
                           $('#idcheck').html('중복된 ID입니다.');
                        }
            	   }
            	   /***********************************************************/

               }, // 
               error : function(){
            	   //영문 ver 추가 - 03.06 장재호
            	   if($('#sessionL').val() == 'eng'){
            		   alert('please restart');
            	   }
            	   else{
                       alert('다시 실행해주세요.');   
            	   }            	   
               }
            });
         }
      });

   
   // 아이디 이메일 인증번호 확인 추가 23/02/14 김지혜 
      // 이메일 인증 버튼 클릭 이벤트
      $('#emailchk').click(function(e) {
         // 일단, 시스템 자체의 submit을 막음
         e.preventDefault();
         const spanText = document.querySelector('#emailcheck'); // 이메일 중복체크관련 메시지
         /******************************영문ver추가 - 03.06 장재호************************************/
         if($('#sessionL').val() == 'eng'){
             if(spanText.textContent.length == 0){
            	 alert("please click check btn");
            	 return;
             }
             if(spanText.textContent.indexOf("중복") != -1){
            	 alert("duplicate");
            	 return;
             }
             // 사용자가 입력한 이메일
             email = $("#email").val();
             
             if(email == null || email == ""){ // 이메일 값이 없는 것을 방지
                alert("enter your email");
               $("#email").focus(); 
                return;
             }
             else if(!email.match('@')){ // 입력받은 이메일에 @없는 걸 방지
                alert("please check your email");
                $("#email").focus();
                return;
             }
             else{ // 위 조건에 걸리지 않으면 상태메세지 뜨지 않음.
                 alert("Authentication number transfer completed");
             }
         }
         else{
             if(spanText.textContent.length == 0){
            	 alert("이메일 중복체크를 해주세요");
            	 return;
             }
             if(spanText.textContent.indexOf("중복") != -1){
            	 alert("이미 사용중인 이메일입니다.");
            	 return;
             }
             // 사용자가 입력한 이메일
             email = $("#email").val();
             
             if(email == null || email == ""){ // 이메일 값이 없는 것을 방지
                alert("이메일을 입력해주세요");
               $("#email").focus(); 
                return;
             }
             else if(!email.match('@')){ // 입력받은 이메일에 @없는 걸 방지
                alert("올바른 이메일 형태를 입력해주세요");
                $("#email").focus();
                return;
             }
             else{ // 위 조건에 걸리지 않으면 상태메세지 뜨지 않음.
                 alert("인증번호 전송이 완료되었습니다");
             }
         }
         /************************************************************************************/

         // ajax로 통해 컨트롤러(mailCheck메소드)로 email의 정보를 넘김 / 넘기는 것이 성공될 시, 인증번호 데이터를 code에 담음
         $.ajax({
            type : "GET",
            url : "mailCheck?email=" + email, // 해당 메소드에 email값을 보냄
            success:function(data){
               code = data; // 인증 번호가 담기는 구역
            } // success end
         }); // ajax end
      }); //event function end




      // 인증번호 확인 버튼 클릭시 이벤트추가    23/02/14 김지혜 
      $('#author_submit').click(function(e){
         e.preventDefault(); // 키에 대한 submit을 막아놓음
         
         var inputCode = $('#author').val(); //사용자가 인증번호를 입력하는 input의 value
         
         // 사용자가 입력하지 않은경우
         /************영문ver 추가 - 03.06 장재호************/
         if($('#sessionL').val() == 'eng'){
             if(inputCode === null || inputCode === ""){
                 alert("enter Authentication number");
                 $('#submit').attr('readonly', true);
                 return;
              }
              // 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
              else if(inputCode == code){
                 alert("correct");
                 $('#submit').attr('readonly', false);
                 
              }else{// 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
                 alert("please check Authentication number");
                 $('#submit').attr('readonly', true);
                 return;
              }
         }
         else{
             if(inputCode === null || inputCode === ""){
                 alert("인증번호를 입력해주세요.");
                 $('#submit').attr('readonly', true);
                 return;
              }
              // 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
              else if(inputCode == code){
                 alert("인증번호가 일치합니다.");
                 $('#submit').attr('readonly', false);
                 $("#email").attr('readonly', true); //중복확인 끝나면 이메일 변경 불가 - 03.09 장재호
                 
              }else{// 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
                 alert("인증번호를 다시 확인 해주세요.");
                 $('#submit').attr('readonly', true);
                 return;
              }
         }
         /***********************************************/

      }); // event end
      
}); // function end   
   
   
   // ================================================  최종 가입하기 =================================================

   // 최종 가입하기 버튼시 실행.  최종 수정 23/02/14 김지혜 
   $(function signup(){
      $('#submit').click(function(e){    	  
             // 비밀번호확인 과 비밀번호 일치시   비밀번호유효성검사하는 PWtest()함수 호출. (23/02/09 김지혜)
         if(($("#password").val()) == ($("#password1").val())){
            PWtest();
         }else {
        	 e.preventDefault();
        	 if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
                 $("#pwMsg").html("uncorrect PW");
                 $("#password").focus();
                 alert("uncorrect PW"); 
        	 }
        	 else{
                 $("#pwMsg").html("비밀번호가 일치하지 않습니다.");
                 $("#password").focus();
                 alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요."); 
        	 } 
            return;
         };
         // 아이디  (i) 비밀번호 (p) 닉네임 (n) 전화번호 (c) 동의 (d) 모두 조건을 만족할 경우(값이 1이 됨), 최종회원가입 성공. 
         if(i==1 && p==1 && n==1 && c==1 && d==1 && ($('#email').attr('readonly'))){
        	 if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
        		 alert("done");
        	 }
        	 else{
        		 alert("가입이 완료되었습니다.");
        	 }
         }else{
        	 e.preventDefault();
        	 if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
        		 alert("fail. please check");
        	 }
        	 else{
        		 alert("회원가입 실패. 다시 입력확인해주세요. ");	 
        	 }            
         }
      });
   });
   
   
   
// 호출할 PWtest함수 ----------------------------------------------------------------------------   
   
   // 비밀번호 유효성검사 함수 (가입하기를 클릭했을 때, 비밀번호와 비밀번호확인이 같을시 이 함수 호출) 
   function PWtest() {
   // 비밀번호 유효성검사  (23/02/08 김지혜) 

      var pwMsg = document.querySelector("#pwMsg"); // 비밀번호 유효성검사결과 상황메시지 view에 띄울 공간 
      var pw = $("#password").val();   // 비밀번호가 가진 value값 
      // 비밀번호 유효성검사 
       var num = pw.search(/[0-9]/g);
       var eng = pw.search(/[a-z]/ig);
       var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
         
       /**************************영문ver 추가 - 03.06 장재호*******************/
       if($('#sessionL').val() == 'eng'){
           // 비밀번호 입력값이 8자리~20자리 이내일 때, view단에 띄우기.
           if(pw.length < 8 || pw.length > 20){
              pwMsg.innerText = "please enter between 8~20";
               p=0; // 최종 가입되지 않도록 막음. 
              return ;
           }// 비밀번호 입력값에 공백이 있을 때, view단에 띄우기.
           else if(pw.search(/\s/) != -1){ 
              pwMsg.innerText = "can't include spaces";
              p=0;  // 최종 가입되지 않도록 막음. 
              return ;
           }// 비밀번호 입력값에 영문,숫자,특수문자를 혼합이 되지 않아있을 때, view단에 띄우기.
           else if(num < 0 || eng < 0 || spe < 0){
              pwMsg.innerText ="mixture of eng, numbers, characters(!@#$....)";
              p=0;  // 최종 가입되지 않도록 막음. 
              return ;
           }else{
              pwMsg.innerText ="";
              p=1; // 모든 비밀번호 조건은 만족하여 최종 가입가능하도록 지정.
              return ;
           }
       }
       else{
           // 비밀번호 입력값이 8자리~20자리 이내일 때, view단에 띄우기.
           if(pw.length < 8 || pw.length > 20){
              pwMsg.innerText = "8자리 ~ 20자리 이내로 입력해주세요.";
               p=0; // 최종 가입되지 않도록 막음. 
              return ;
           }// 비밀번호 입력값에 공백이 있을 때, view단에 띄우기.
           else if(pw.search(/\s/) != -1){ 
              pwMsg.innerText = "비밀번호는 공백 없이 입력해주세요.";
              p=0;  // 최종 가입되지 않도록 막음. 
              return ;
           }// 비밀번호 입력값에 영문,숫자,특수문자를 혼합이 되지 않아있을 때, view단에 띄우기.
           else if(num < 0 || eng < 0 || spe < 0){
              pwMsg.innerText ="영문,숫자,특수문자를 혼합하여 입력해주세요.";
              p=0;  // 최종 가입되지 않도록 막음. 
              return ;
           }else{
              pwMsg.innerText ="";
              p=1; // 모든 비밀번호 조건은 만족하여 최종 가입가능하도록 지정.
              return ;
           }
       }
       /****************************************************************/
   };
