var code1 = ""; // 아이디 이메일 전송 인증번호 저장할 공간
var code2 = ""; // 비밀번호 이메일 전송 인증번호 저장할 공간
var email1= ""; // 아이디 이메일 인증 - 이메일이 들어갈 변수 지정 
var email2= ""; // 비밀번호 이메일 인증 - 이메일이 들어갈 변수 지정 
var id = ""; // id가 들어갈 변수 지정
var inputCode = ""; //사용자가 입력한 인증번호

/////////////// 아이디찾기 이메일 인증 - 0209 김범수 ///////////
$(function(){
	//////////// 이메일 인증 버튼 클릭 이벤트 /////////////
	$('#emailchk1').click(function(e) {
		// 시스템 자체의 submit을 막음
		e.preventDefault();
		
		// 사용자가 입력한 이메일
		email1 = $("#input_email1").val();
		
		var inputResult = $('#email_text1'); // 인증 상태 메세지
		/****************영문ver 추가 - 03.06 장재호****************/
		if($('#sessionL').val() == 'eng'){
			if(email1 == null || email1 == ""){ // 이메일 값이 없는 것을 방지
				inputResult.html('please enter E-MAIL');
				$("#input_email1").focus(); 
				return;
			}
			else if(!email1.match('@')){ // 입력받은 이메일에 @없는 걸 방지
				inputResult.text("please check your E-MAIL");
				$("#input_email1").focus();
				return;
			}
			else{ // 위 조건에 걸리지 않으면 상태메세지 없앰
				inputResult.text("");
			}
			inputResult.html('Authentication numbers transfer completed');
		}
		else{
			if(email1 == null || email1 == ""){ // 이메일 값이 없는 것을 방지
				inputResult.html('이메일을 입력해주세요');
				$("#input_email1").focus(); 
				return;
			}
			else if(!email1.match('@')){ // 입력받은 이메일에 @없는 걸 방지
				inputResult.text("올바른 이메일 형태를 입력해주세요");
				$("#input_email1").focus();
				return;
			}
			else{ // 위 조건에 걸리지 않으면 상태메세지 없앰
				inputResult.text("");
			}
			inputResult.html('인증번호 전송이 완료되었습니다');
		}
		/********************************************************/

		// ajax로 통해 컨트롤러(mailCheck메소드)로 email의 정보를 넘김 / 넘기는게 성공하면 인증번호 데이터를 code에 담음
		$.ajax({
			type : "GET",
			url : "mailCheck?email=" + email1, // 해당 메소드에 email값을 보냄
			success:function(data1){
				code1 = data1; // 인증 번호가 담기는 구역
			} 
		}); // ajax end
	}); //event function end


	// 인증번호 확인 버튼 클릭시 이벤트
	$('#author_submit1').click(function(e){
		e.preventDefault(); // 키에 대한 submit을 막아놓음
		
		var inputCode = $('#author1').val(); //사용자가 인증번호를 입력하는 input의 value
		var inputResult = $('#email_text1'); // 인증 상태 메세지
		
		/********************영문 ver 추가 - 03.06 장재호*****************/
		if($('#sessionL').val() == 'eng'){
			// 사용자가 입력하지 않은경우
			if(inputCode === null || inputCode === ""){
				inputResult.html("enter Authentication numbers");
				return;
			}
			// 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
			else if(inputCode == code1){
				inputResult.html("correct");
				$("#input_email1").attr("disabled", true);
				
			}else{// 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
				inputResult.html("please check numbers");
				return;
			}
		}
		else{
			console.log($('#input_email1'));
			// 사용자가 입력하지 않은경우
			if(inputCode === null || inputCode === ""){
				inputResult.html("인증번호를 입력해주세요.");
				return;
			}
			// 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
			else if(inputCode == code1){
				inputResult.html("인증번호가 일치합니다.");
				$("#input_email1").attr("disabled", true);
				
			}else{// 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
				inputResult.html("인증번호를 다시 확인 해주세요.");
				return;
			}
		}
		/****************************************************/

	}); // event function end

	////////////////02.10 - 아이디 찾기 //////////
	$('.login_submit_id').click(function(){
		inputCode = $('#author1').val();
		var inputResult = $('#email_text1');
		email1 = $("#input_email1").val();
		if(email1 == "" || email1 == null || !email1.match('@')){
			if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
				$('#submit_id_text').html('please Authentication first');
			}
			else{
				$('#submit_id_text').html('이메일 인증을 먼저 해주세요');
			}
			$("#input_email1").focus();
			return;
		}
		else if(inputCode == "" || inputCode == null || inputCode != code1){
			if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
				$('#submit_id_text').html('please enter Authentication numbers');
			}
			else{
				$('#submit_id_text').html('인증번호를 입력해주세요');
			}
			$('#author1').focus();
			return;
		}
		else{
			if(email1 != null){ // 위의 ajax에서 이메일을 제대로 받아온 경우
				$.ajax({
					url : 'findid', // 위의 ajax에서 이메일을 제대로 받아온 경우
					dataType : 'text',
					data : {"email" : email1},
					type : 'post',
					// 정보에 맞는 값이 있는 경우
					success:function(id) {		
						/*****************영문 ver 추가 - 03.06 장재호********************/
						// 빽단에서 받아온 id값이 없는 경우 
						if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
							if(id == null || id == ""){
								$('#submit_id_text').html('not found ID');
								return;
							}
							// 빽단에서 받아온 id값이 있어 제대로 출력된 경우 
							else{ 
								alert('your ID is '+id);
								$('#submit_id_text').html('');
							}
						}
						else{
							if(id == null || id == ""){
								$('#submit_id_text').html('등록된 정보가 없습니다');
								return;
							}
							// 빽단에서 받아온 id값이 있어 제대로 출력된 경우 
							else{ 
								alert('아이디는'+id+'입니다');
								$('#submit_id_text').html('');
							}
						}
						/**********************************************************/
					},
					// 정보에 맞는 값이 없는 경우
					error : function() { //영문 ver - 03.06 장재호
						if($('#sessionL').val() == 'eng'){
							$('#submit_id_text').html('not found');
						}
						else{
							$('#submit_id_text').html('등록된 정보가 없습니다');
						}
						return;
					}		
				}); // ajax end
			}
			
			//이메일을 입력하지 않을 경우
			else{
				if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
					$('#submit_id_text').html('please Authenticaion first'); 
					inputResult.html('enter Authentication numbers');
				}
				else{
					$('#submit_id_text').html('이메일 인증을 먼저해주세요'); 
					inputResult.html('인증번호를 입력해주세요');
				}

				return;
			}
		}
	}); // event function end
}); // function end


/////////////// 비밀번호 찾기 이메일 인증 - 0213 김범수 ///////////
$(function(){
	// 이메일 인증 버튼 클릭 이벤트
	$('#emailchk2').click(function(e) {
		// 시스템 자체의 submit을 막음
		e.preventDefault();
		
		// 사용자가 입력한 이메일
		email2 = $("#input_email2").val();
		
		var inputResult = $('#email_text2'); // 인증 상태 메세지
		
		if(email2 == null || email2 == ""){ // 이메일 값이 없는 것을 방지
			if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
				inputResult.html('enter E-MAIL');
			}
			else{
				inputResult.html('이메일을 입력해주세요');
			}
			$("#input_email2").focus(); 
			return;
		}
		else if(!email2.match('@')){ // 입력받은 이메일에 @없는 걸 방지
			if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
				inputResult.text("check your EMAIL");
			}
			else{
				inputResult.text("이메일 형태를 확인해주세요");
			}
			$("#input_email2").focus();
			return;
		}
		else{ // 올바른 이메일 형식을 입력받은 경우
			inputResult.text("");
		}
		
		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
			inputResult.html('Authentication numbers have been sent');
		}
		else{
			inputResult.html('인증번호 전송이 완료되었습니다');
		}
		// ajax로 통해 컨트롤러(mailCheck메소드)로 email의 정보를 넘김 / 넘기는게 성공하면 인증번호 데이터를 code에 담음
		$.ajax({
			type : "GET",
			url : "mailCheck?email=" + email2, // 해당 메소드에 email값을 보냄
			success:function(data2){
				code2 = data2; // 인증 번호가 담기는 구역
			} // success end
		}); // ajax end
	}); //event function end

	// 인증번호 확인 버튼 클릭시 이벤트
	$('#author_submit2').click(function(e){
		e.preventDefault(); // 키에 대한 submit을 막아놓음
		
		inputCode = $('#author2').val(); //사용자가 인증번호를 입력하는 input의 value
		var inputResult = $('#email_text2'); // 인증 상태 메세지
		
		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
			// 사용자가 입력하지 않은경우
			if(inputCode === null || inputCode === ""){
				inputResult.html("enter Authentication numbers");
				return;
			}
			// 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
			else if(inputCode == code2){
				inputResult.html("correct");
				$("#input_email2").attr("disabled", true);
				
			}else{// 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
				inputResult.html("please check Authentication numbers");
				return;
			}
		}
		else{
			// 사용자가 입력하지 않은경우
			if(inputCode === null || inputCode === ""){
				inputResult.html("인증번호를 입력해주세요.");
				return;
			}
			// 사용자가 입력한 인증번호와 발급한 인증번호가 맞을 경우
			else if(inputCode == code2){
				inputResult.html("인증번호가 일치합니다.");
				$("#input_email2").attr("disabled", true);
				
			}else{// 사용자가 입력한 인증번호와 발급한 인증번호가 일치하지 않을 경우
				inputResult.html("인증번호를 다시 확인 해주세요.");
				return;
			}
		}
	}); //event function end

	//////////비밀번호 찾기 - 02.10 김범수 ////////
    $("#pw_submit").click(function(){
    	id = $('#id').val();
    	email2 = $("#input_email2").val();
    	inputCode = $('#author2').val();
    	var allData = {'email' : email2, 'id' : id}
		
    	if(id == null || id == ""){ // 아이디를 입력하지 않은 경우
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#submit_pw_text').html('enter ID');
    		}
    		else{
    			$('#submit_pw_text').html('아이디를 입력해주세요');
    		}
    		$('#id').focus();
    		return;
    	}
    	else{ // 아이디를 입력한 경우
    		if(email2 == null || email2 == ""){
        		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
        			$('#submit_pw_text').html('Authentication E-MAIL first');
        		}
        		else{
        			$('#submit_pw_text').html('이메일 인증을 먼저해주세요');
        		}
    			$("#input_email2").focus();
    			return;
    		}
    		else if(inputCode == null || inputCode == ""){
        		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
        			$('#submit_pw_text').html('enter Authentication numbers');
        		}
        		else{
        			$('#submit_pw_text').html('인증번호를 입력해주세요');
        		}
    			$('#author2').focus();
    			return;
    		}
    		else{
    			$('#submit_pw_text').html('');
    	    	if(inputCode == "" || inputCode == null || inputCode != code2){
            		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
            			$('#submit_pw_text').html('Authentication E-MAIL first');
            		}
            		else{
            			$('#submit_pw_text').html('이메일 인증을 먼저해주세요');
            		}
    	    		return;
    	    	}
    	    	else{
    	    		$('#submit_pw_text').html('');
    	    		$.ajax({
    	        		url : 'findpw',
    	        		data : allData,
    	        		type : 'post',
    	        		success : function(nick) {
    	        			if(nick == 'ok'){ //일치하는 정보가 있는 경우 - 리턴값이 ok이면 팝업창을 띄움
    	        				$('.popup').css('display', 'block');
    	        			}
    	        			else if(nick == 'no'){ //일치하는 정보가 없을 경우
    	                		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    	                			$('#submit_pw_text').html('no matching information found');
    	                		}
    	                		else{
    	                			$('#submit_pw_text').html('해당 정보와 일치하는 정보가 없습니다.');
    	                		}
    	        				return;
    	        			}
    	        			else{ // 잘못된 접근 방지
    	                		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    	                			$('#submit_pw_text').html('wrong access');
    	                		}
    	                		else{
    	                			$('#submit_pw_text').html('잘못된 접근입니다.');
    	                		}
    	        				return;
    	        			}
    	    			} // success end
    	        	}); // ajax end
    	    	}
        	}
    	}	
    }); //event function end
}); // function end


/////////////// 비밀번호 정규표현식, 변경 - 0213 김범수 ///////////
$(function() {
    //////// 비밀번호 변경 확인 - 02.11 김범수 ////////
	$('#pw_checkbtn').click(function(){
		var pw = $('#pw').val(); // 비밀번호 입력값
		var pw_confirm = $('#pw_confirm').val(); // 비밀번호 확인 입력값
		
		if(pw != null && pw != "" && pw_confirm != null && pw_confirm != ""){ // 비밀번호/비밀번호 확인란에 값이 있는 경우
			if(pw == pw_confirm){ // 비밀번호/비밀번호 확인란의 값이 같은 경우
        		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
        			$('#check_result').html('correct');
        		}
        		else{
        			$('#check_result').html('비밀번호가 일치합니다');
        		}
				$('#change_pw').attr('disabled', false);
			}
			else{ // 비밀번호/비밀번호 확인란의 값이 다른 경우
        		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
        			$('#check_result').html('incorrect PW');
        		}        		
        		else{
        			$('#check_result').html('비밀번호가 일치하지 않습니다');	
        		}				
				return;
			}
		}
		else if(pw == null || pw == "" || pw_confirm == null || pw_confirm == ""){ // 비밀번호/비밀번호 확인란에 값이 없는 경우
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#check_result').html('enter PW');
    		}
    		else{
    			$('#check_result').html('비밀번호를 입력해주세요');
    		}
			return;
		}
		else{ // 비밀번호/비밀번호 확인란의 값이 다른 경우
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#check_result').html('incorrect PW');
    		}
    		else{
    			$('#check_result').html('비밀번호가 일치하지 않습니다');
    		}
			return;
		}
	}); //event function end

	///// 비밀번호 변경 창에서의 정규 표현식 - 02.12 김범수 ///////
	$('#pw').blur(function() {
		var pw = $('#pw').val();
		var num = pw.search(/[0-9]/g); // 숫자 정규식
		var eng = pw.search(/[a-z]/ig); // 문자 정규식
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); // 특수문자 정규식
		
		if(pw.length < 8 || pw.length > 20){
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#input_regex').html("enter between 8~20");
    		}
    		else{
    			$('#input_regex').html("8자리 ~ 20자리 이내로 입력해주세요.");
    		}
		 	$('#pw_confirm').attr('disabled', true);
		 	$('#pw').focus();
		 	return ;
		 }else if(pw.search(/\s/) != -1){
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#input_regex').html("enter without spaces");
    		}
    		else{
    			$('#input_regex').html("비밀번호는 공백 없이 입력해주세요.");
    		}
		 	$('#pw_confirm').attr('disabled', true);
		 	$('#pw').focus();
			return ;
		 }else if(num < 0 || eng < 0 || spe < 0 ){
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#input_regex').html("mixture of eng, numbers, characters(!@#$...)");
    		}
    		else{
    			$('#input_regex').html("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
    		}
		 	$('#pw_confirm').attr('disabled', true);
		 	$('#pw').focus();
		 	return;
		 }else{
			 $('#input_regex').html("");
			 $('#pw_confirm').attr('disabled', false); // 비밀번호 확인란 disable 해제
		 }
	}); //event function end

	///// 비밀번호 확인 창에서의 정규 표현식 - 02.12 김범수 ///////
	$('#pw_confirm').blur(function() {
		var pw_c = $('#pw_confirm').val();
		var num = pw_c.search(/[0-9]/g); // 숫자 정규식
		var eng = pw_c.search(/[a-z]/ig); // 문자 정규식
		var spe = pw_c.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi); // 특수문자 정규식
		
		if(pw_c.length < 8 || pw_c.length > 20){
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#input_confirm_regex').html("enter between 8~20");
    		}
    		else{
    			$('#input_confirm_regex').html("8자리 ~ 20자리 이내로 입력해주세요.");
    		}
		 	$('#pw_confirm').focus();
		 	return ;
		 }else if(pw_c.search(/\s/) != -1){
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#input_confirm_regex').html("enter without spaces");
    		}
    		else{
    			$('#input_confirm_regex').html("비밀번호는 공백 없이 입력해주세요.");
    		}
		 	$('#pw_confirm').focus();
			return ;
		 }else if(num < 0 || eng < 0 || spe < 0 ){
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			$('#input_confirm_regex').html("mixture of eng, numbers, characters(!@#$...)");
    		}
    		else{
    			$('#input_confirm_regex').html("영문,숫자, 특수문자를 혼합하여 입력해주세요.");
    		}
		 	$('#pw_confirm').focus();
		 	return;
		 }else{
			 $('#input_confirm_regex').html("");

		 }
	}); //event function end
	
	/////// 닫기 버튼 클릭 이벤트
	$('.closebtn').click(function() { 
		$('.popup').css('display', 'none');
	}) //event function end
	
	//////// 비밀번호 찾기 -> 비밀번호 변경 후 db로 연결 - 02.12 김범수 /////
	$('#change_pw').click(function() {
		// 비밀번호 변경한 값을 ajax로 전송 -> 변경 확인 메세지
		var pw = $('#pw').val();
		var pw_confirm = $('#pw_confirm').val();
		var pw_data = {'password' : pw, 'id' : id}
		if(pw != null && pw_confirm != null && pw == pw_confirm){ // 비밀번호 값/비밀번호 확인 값이 null아니고 비밀번호와 비밀번호확인 값이 맞는 경우
			$.ajax({
				url : 'changepw',
				type : 'post',
				data : pw_data,
				success : function() {
		    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
		    			alert('done');
		    		}
		    		else{
		    			alert('비밀번호가 변경되었습니다')
		    		}
					$('.popup').css('display', 'none');
					location.href = 'signin';
				}
			}); // ajax end
		}
		else{
    		if($('#sessionL').val() == 'eng'){ //영문 ver 추가 - 03.06 장재호
    			alert('fail : check PW');
    		}
    		else{
    			alert('비밀번호 변경 실패 : 비밀번호를 확인해주세요');
    		}
			return;
		}

	}); // event function end
	
	$('#eye1').on('click',function(){
		$('#password_input').toggleClass('active'); // 부모 태그 .input.password가 active 토글활성화
		if($('#password_input').hasClass('active') == true){  // active가 활성화가 될 때 자식 input의 타입을 text로 바꿔서 비밀번호 텍스트를 보이게 함 
			$(this).attr('class',"fa-solid fa-eye fa-lg").prev('input').attr('type',"text");
		}else{ // Class값이 'active'가 아닐 경우 
			$(this).attr('class',"fa-solid fa-eye-slash fa-lg").prev('input').attr('type','password');
		}
	});
	// 비밀번호확인란 눈모양 이벤트리스너 
	$('#eye2').on('click',function(){
		$('#password_confirm').toggleClass('active'); // 부모 태그 .input.password가 active 토글활성화
		if($('#password_confirm').hasClass('active') == true){  // active가 활성화가 될 때 자식 input의 타입을 text로 바꿔서 비밀번호 텍스트를 보이게 함 
			$(this).attr('class',"fa-solid fa-eye fa-lg").prev('input').attr('type',"text");
		}else{ // Class값이 'active'가 아닐 경우 
			$(this).attr('class',"fa-solid fa-eye-slash fa-lg").prev('input').attr('type','password');
		}
	});
}); // function end


