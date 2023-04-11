var naverLogin = new naver.LoginWithNaverId({
	clientId: "XMsvnx3R1_T_0aXB93xf",
	callbackUrl: "http://localhost:8080/user/naverLogin",
	isPopup: false, /* 팝업을 통한 연동처리 여부 */
	loginButton: {color: "green", type: 1, height: 20}
});

naverLogin.init();/* 설정정보를 초기화하고 연동을 준비 */