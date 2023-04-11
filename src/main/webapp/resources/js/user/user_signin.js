
////////// 아이디 / 비밀번호 빈칸 방지 -> 로그인 체크 - 02.06 김범수 ///////
// 로그인을 빈칸으로 제출하는 것을 방지
$(function(){ 
    $(".login_submit").click(function(e){
    	e.preventDefault();
        var id=$("input[type=text]").val(); // 아이디 입력값
        var password=$("input[type=password]").val(); // 비밀번호 입력값
                   
        if(id== "" || id == null){ //아이디 빈칸 방지
        	if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
        		$('#id').html("please check ID");
        	}
        	else{
                $('#id').html("아이디를 입력해주세요");
        	}
            $("input[type=text]").focus();
            return;
        }
        else{
        	$('#id').html("");
            if(password == "" || password == null){ //비밀번호 빈칸 방지 
            	if($('#sessionL').val() == 'eng'){ //영문ver 추가 - 03.06 장재호
            		$('#password').html("please check PW");
            	}
            	else{
                    $('#password').html("비밀번호를 입력해주세요");	
            	}            	
                $("input[type=password]").focus();
                return;
            }
            else{
            	$('#password').html("");
                // 로그인 체크 메소드로의 이동
            	$('.login_form').submit();
            }
        }
    });
});

