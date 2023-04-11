Kakao.init('2510b2e9fc85aeb4625d6a9d9d7b881b'); //발급받은 키 중 javascript키를 사용해준다.
//console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인 시 API 이용하여 정보 받아오기 - 02.10 장재호
//naverCallback.jsp와 같은 형식이니 참조하세요
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  const id = response.id;
        	  const nickname = response.properties.nickname;
        	  const email = response.kakao_account.email;
        	  $.ajax({
        		  type : 'post',
        		  url : 'user/kakaoLogin',
        		  data : {"id" : id, "nickname" : nickname, "email" : email},
        		  dataType : 'text',
        		  success: function(result){
        			  if(result=="ok"){
        				  var newNickname = prompt('사용하실 닉네임을 입력해주세요');
        				  if(newNickname != null){
        					  $.ajax({
        						  type : 'post',
        						  url : 'kakaoSignUp',
        						  data : {"id" : id, "nickname" : newNickname, "email": email}
        					  });
        					  alert(newNickname + "님 환영합니다.");
        					  location.href = "/video/list";
        				  }
        				  else{
        					  location.href = "/user/signin";
        				  }
        			  }
        			  else{
        				  $.ajax({
        					  url : '/user/kakaoLogins',
        					  data : {"id" : id},
        					  dataType : 'text',
        					  type : 'post',
        					  success : function(data){
                				  alert(nickname + "님 반갑습니다.");
                				  location.href = "/video/list";
        					  }
        				  })

        			  }
        		  }
        		  
        	  })
          },
          fail: function (error) {
          },
        })
      },
      fail: function (error) {
      },
    })
  }
