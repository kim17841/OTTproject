let hypenTf = true;  // 전화번호 하이픈 기능 true로 초기화 설정 
let nickTf = true;   // 닉네임 기능 true로 초기화  설정


var email_equal = false;  // 이메일 수정할 때, 기존 이메일값과 수정하려는 이메일값이 같은지 다른지 구분하기 위해 설정한 초기값
var email_pre = document.querySelector("#modify_email").value; // 기존 저장되어있는 이메일의 값


if(modalTf === true){   // 'user_mydetail.js'에 모달창 열기 버튼 클릭시만 적용되도록 조건설정
	let modify_btn = document.querySelector("#modifybtn");   //  모달창ON상태에 수정하기버튼
}



// - (하이픈) 자동 추가 기능 추가      23/02/21  김지혜 
	   const autoHyphen = function(target) {
	       target.value = target.value
	       .replace(/[^0-9]/g, '')
	       .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	       if(target.value.length == 13){// 입력한 전화번호 값의 길이가 13인 경우,
	    	   hypenTf=true;// 최종 전화번호 수정조건 통과.
	       }
	       else hypenTf=false; //길이가 13이 아닌 경우, 최종 전화번호 수정조건 불통.
	   }
	   
	// 닉네임 - 공백, 특수문제 제어  _   23/02/21 추가  김지혜 
	   const nick = function() {		
		   const nick = document.querySelector('#modify_nickname');
		   var specialCheck = /[`~!@#$%^&*|\\\'\";:\/?]/gi;

	   	   if (nick.value == null || nick.value == "") {
	   		   	$('#nicknamechk_msg').html("닉네임 입력은 필수입니다.");
	   	      	nick.focus(); // 닉네임입력란에 focus될 수 있도록 지정. 
	   	        nickTf=false; 
	   	   } 
	   	   else if (nick.value.search(/\s/) != -1) { //닉네임 공백포함제어 
	   	        $('#nicknamechk_msg').html("닉네임은 공백을 포함 할 수 없습니다.");
	   	        nick.focus();
	   	        nickTf=false; 
	   	   }
	   	   else if (specialCheck.test(nick.value)) {
	   	        $('#nicknamechk_msg').html("닉네임은 특수문자를 포함 할 수 없습니다.");
	   	        nick.focus(); // 닉네임 특수문자제어 
	   	        nickTf=false; 
	   	   }else{
	   	        $('#nicknamechk_msg').html("");
	   	        $('#modifybtn').attr('disabled', false);
	   	        nickTf=true;  // 닉네임값 수정버튼 통과 
	   	   }
	   }; //nick() end_
	   

	   // 최종 수정하기버튼 클릭시 onclick으로 호출될 함수  _ 02/21 김지혜 
	   function updateBtn(){
		      
		   const email_after = document.querySelector("#modify_email").value; 
		   if(email_pre != email_after){  // 인증을 받았을 경우, email_equal === ture를 가지므로 해당 조건문은 타지 않도록 함.
			   if(email_equal === false){  // 변경하려는 이메일 값에 인증을 받지 않았을 경우 
				   alert("이메일 인증확인해주세요.");
				   return;  // 이메일 인증번호까지 인증받지 않을 경우, 전화번호와 닉네임이 형식에 알맞게 작성되었을지라도 수정처리 되지 않도록 함.
			   }
		   }else{ //이메일 값에 변동이 없을 경우, 이메일 인증을 타지 않도록 읽기전용으로 설정. 
			   
		   }
		   if(hypenTf===true && nickTf===true){   // 전화번호와 닉네임 형식대로 잘 들어온 경우 수정가능하도록 처리 
			   alert("정상적으로 수정되었습니다.");
	           $('#modifybtn').attr('type', 'submit'); // type속성 submit로 변환하여 넘어갈 수 있도록 함. 
	      //    document.form1.action="/mypage/info_mydetail"; // 페이지 이동
		   } // if end_ 
	   } // updateBtn() end _ 
			

	// 이메일 유효성검사(@를 포함 & NULL,공백포함X), 이메일 중복(AJAX를 통한 DB중복조회)처리  (23/02/20 ~ 23/02/21 김지혜) 	   
$(function(){
	
	var data_email = document.querySelector("#modify_email"); // 모달창영역의 이메일
	var emailCheck = document.querySelector(".emailCheck"); //모달창영역의 이메일 중복체크 버튼 	
	
	// 이메일 중복체크 버튼 [비]활성화 조건 추가  23/02/22 김지혜
	// 모달창에 이메일 수정란에 입력한 정보    
	var email_now = document.querySelector("#modify_email");
	
	email_now.addEventListener('keyup', function(){
		if(email_pre != email_now.value){ // 기존 이메일 정보와 수정을 위해 입력한 값이 다를 경우 
			$('.emailCheck').attr('disabled', false); // 이메일 중복체크 버튼 활성화 
		}
		else{
			$('.emailCheck').attr('disabled', true); // 이메일 중복 체크 버튼 비활성화유지
		}
	})
			
			emailCheck.addEventListener("click", function(e){
		
		         e.preventDefault(); // 먼저, 다른 처리 막음. 
		         var email = data_email.value; // 이메일정보 수정하기위해 입력한 이메일 값
		         
		     	 $('.email_checkbtn').attr('disabled', true); // 중복체크를 하지 않으면, 이메일 인증번호 활성화되지 않도록 설정
		     	 $('#modifybtn').attr('disabled', true); // 올바른 이메일  미기입시 수정처리되지 않도록 버튼 disable설정
		     	 
		         if(!email.includes('@')){ // @ 형식에 맞지 않을 경우 경고창에 메시지 
					$('#emailchk_msg').html('올바른 이메일을 입력해 주세요');
					$("#modify_email").focus();  
					
					return;
				}
				else if(email == null || email == ""){ // 이메일 값이 없는 것을 방지
					$('#emailchk_msg').html('이메일을 입력해 주세요');
		            $("#modify_email").focus();  
		            return;
		        }
				else{ // DB 중복체크 
					$('#modifybtn').attr('disabled', true); // 올바른 이메일  미기입시 수정처리되지 않도록 버튼 disable설정
					$.ajax({
						type : 'post',
			            url : '/user/emailCheck',  // 다른 user컨트롤러에서의 메소드 호출.
			            data : {'email':email},
						success : function(tf){   // 중복이 아닐 경우 
							$('#emailchk_msg').html('이메일 사용 가능합니다');
							$('.email_checkbtn').attr('disabled', false); // 이메일 인증 disable해제
						},
						error : function(tf) {   // 중복일 경우 
							$('#emailcheck').html("이메일이 중복되었습니다");
				        }	
					}) // ajax end 
				}// else end 			
			}); 		
			
			// 이메일 인증번호인증확인 추가 _ 23/02/22 김지혜
			var authorCheckBtn = document.querySelector(".email_checkbtn"); //모달창영역의 이메일 인증번호인증확인 버튼 
	
			authorCheckBtn.addEventListener("click", function(e){
				
				e.preventDefault();			// 일단, 시스템 자체의 submit을 막음	
				var email = data_email.value; // 이메일정보 수정하기위해 입력한 이메일 값
					
			
				if(email ==null || email== ""){  // 이메일 값이 없는 것을 방지
					$('#emailchk_msg').html('이메일을 입력해 주세요');
					$('#modifybtn').attr('disabled', true); // 수정처리되지 않도록 버튼 disable설정
					$("#email").focus(); 
			        return;
				}
				else if(!email.match('@')){ // 입력받은 이메일에 @없는 걸 방지
					$('#emailchk_msg').html('올바른 이메일 형태를 입력해주세요');
					$('#modifybtn').attr('disabled', true); // 수정처리되지 않도록 버튼 disable설정
		            $("#email").focus();
		            return;
		        }
		        else if(email === email_pre) { // 입력한 이메일과 기존저장한 이메일과 동일한 경우 인증번호전송이 안가도록 처리.
		        	alert("입력한 이메일은 기존저장한 이메일과 동일합니다.")
		        	return;
		        }
				$('.email_checkbtn').attr('disabled', true); // 인증번호 미기입시 수정처리되지 않도록 버튼 disable설정
				alert("인증번호 전송이 완료되었습니다");
				
				// ajax를 통해 컨트롤러 mailCheck메소드로 새롭게 받은 email 정보를 넘긴다.
				$.ajax({
					type: "GET",
					url : "/user/mailCheck?email="+ email, // mailCheck메소드에 email값 전송   
					success:function(data){
						code = data; // 인증번호가 담기는 구역
					}// success end
				});// ajax end
			}); // 클릭이벤트리스너 end 
	

		      // 인증번호 확인 버튼 클릭시 이벤트추가    23/02/14 김지혜 
		      $('#author_submit').click(function(e){
		         e.preventDefault(); // 키에 대한 submit을 막아놓음
		         
		         var inputCode = $('.authorkey').val(); //사용자가 인증번호를 입력하는 input의 value
		         
		      	 $('.email_checkbtn').attr('disabled', true); // 중복체크를 하지 않으면, 이메일 인증번호 활성화되지 않도록 설정
		      	$('.email_checkbtn').css('color', '#CCCCCC');
		     	 $('#modifybtn').attr('disabled', true); // 올바른 이메일  미기입시 수정처리되지 않도록 버튼 disable설정
		     	 
		         // 사용자가 입력하지 않은경우
		         if(inputCode === null || inputCode === ""){
		            alert("인증번호를 입력해주세요.");
		            $('#modifybtn').attr('disabled', true); // 인증번호 미기입시 수정처리되지 않도록 버튼 disable설정
		            return;
		         }
		         // 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
		         else if(inputCode == code){ 
		        	email_equal = true; // 인증번호 확인 받기 전까지 값은 초기값 설정처럼 'false'이지만, 인증번호인증이 된 경우 true로 바꿔줌. 
		            alert("인증번호가 일치합니다.");
		            $('#modifybtn').attr('disabled', false); // 최종 정보수정버튼 읽기전용 해제
		            return true;
		         }else{// 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
		            alert("인증번호를 다시 확인 해주세요.");
		            $('#modifybtn').attr('disabled', true); // 수정처리되지 않도록 버튼 disable설정
		            return;
		         }
		      }); // event end


});// 전체 담고있는 제이쿼리 함수 end



