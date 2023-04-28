<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Member Registration</title>
<link href="./resources/css/style.css" rel="stylesheet">
<style type="text/css">
	#checkerPwd {
		color: red;
	}
</style>
<script type="text/javascript">
	function IdCheck() {
		window.open("./idCheckForm", "idWin", "width=400, height=350");
	}
	
	function checkerPwd() {
		var pw1 = document.joinform.password.value;
		var pw2 = document.joinform.checkPwd.value;
		if ((pw1 != pw2) || (pw1 == "") || (pw2 == "")) {
			document.getElementById('checkerPwd').style.color = "red";
			document.getElementById('checkerPwd').innerHTML = "동일한 암호를 입력하세요.";
		} else {
			document.getElementById('checkerPwd').style.color = "black";
			document.getElementById('checkerPwd').innerHTML = "암호가 확인 되었습니다.";
		}
	}
	
	function finalCheck() {
		var id = document.joinform.userId.value;
		var pw1 = document.joinform.password.value;
		var pw2 = document.joinform.checkPwd.value;
		if ((id != null) && (pw1 == pw2) && (pw1 != "") && (pw2 != "")) {
			alert('가입 완료! 로그인해주세요');	
		} 
	}
</script>
<style type="text/css"> 
	.about-section {
  padding: 40px;
  text-align: center;
  background-color: #474e5d;
  color: white;
  }
  
  * {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: "Noto Sans KR", sans-serif;
}

a {
  text-decoration: none;
  color: black;
}
.title {
  font-family: 'Jua', sans-serif;
  font-size: 15px;

}

.wrap {
  width: 100%;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(0, 0, 0, 0.1);
}

.regist {
  width: 600px;
  height: 600px;
  background: white;
  border-radius: 20px;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
}
.submit_box {
  font-family: 'Jua', sans-serif;
  width: 150%;
  height: 10px;
}
h2 {
  color: #4682b4;
  font-size: 2em;
}
.login_sns {
  padding: 20px;
  display: flex;
}


.regist_id {
	  width: 100%;
	  height: 50px;
	  border-radius: 30px;
	  margin-top: 10px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
}

.regist_id input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.regist_pw {
	  width: 100%;
	  height: 50px;
	  border-radius: 30px;
	  margin-top: 10px;
	  padding: 0px 20px;
	  border: 1px solid lightgray;
	  outline: none;
}

.regist_pw input {
  width: 100%;
  height: 50px;
  border-radius: 30px;
  margin-top: 10px;
  padding: 0px 20px;
  border: 1px solid lightgray;
  outline: none;
}

.login_etc {
  padding: 10px;
  width: 80%;
  font-size: 14px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-weight: bold;
}


  	.submit {
  font-family: 'Jua', sans-serif;
  color: #494949;
  text-decoration: none;
  background: #ffffff;
  padding: 5px;
  border: 2px solid #494949;
  border-radius: 40px;
  display: inline-block;
  transition: all 0.4s ease 0s;
}

.submit input {
  width: 100%;
  height: 50px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: linear-gradient(to right, #4682B4, #003458);
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
}
.submit:hover {
  font-family: 'Jua', sans-serif;
  color: #ffffff;
  background: #003458;
  border-color: #003458;
  transition: all 0.4s ease 0s;
}
.register_box {
  width: 150%;
  height: 20px;
}

.register {
  font-family: 'Open Sans';
  color: #494949;
  text-decoration: none;
  background: #ffffff;
  padding: 5px;
  border: 4px solid #494949;
  display: inline-block;
  transition: all 0.4s ease 0s;
}

.register:hover {
  color: #ffffff;
  background: #003458;
  border-color: #003458;
  transition: all 0.4s ease 0s;
}
.submit_register {
   margin-top: 50px;
   width: 80%;
    margin: auto;
   align-items: center;
   text-align: center;
           font-weight: normal;
}
.submit_register input {
  width: 50%;
  height: 40px;
  border: 0;
  outline: none;
  border-radius: 40px;
  background: linear-gradient(to right, #4682B4, #003458);
  color: white;
  font-size: 1.2em;
  letter-spacing: 2px;
  font-family: 'Jua', sans-serif;
}

  </style>


<body style="text-align: center">
	<div class="about-section">
  <h1>웹 푸시 약관 동의</h1>
	</div>
<!-- 	<hr> -->
<br>
<h2>웹푸시 알림 약관 동의서

개요
본 약관은 웹푸시 알림 서비스 이용과 관련하여, 이용자의 권리, 의무, 책임 사항 및 개인정보 처리 방침 등을 규정함을 목적으로 합니다.

이용자 정보 수집 항목 및 이용 목적
이용자의 웹푸시 알림 서비스 이용에 필요한 최소한의 정보만을 수집하며, 다음과 같은 목적으로 이용합니다.

이메일 주소: 서비스 이용 안내 및 공지사항 전달을 위한 정보 수신
기기 식별자: 서비스 이용 환경에 따른 최적화 및 서비스 향상을 위한 정보 수집
개인정보의 제3자 제공
이용자의 개인정보는 제3자에게 제공되지 않으며, 법령에 의해 요구되는 경우에는 예외로 합니다.

개인정보 보유 및 이용 기간
이용자가 서비스 이용을 중단하거나 회원 탈퇴를 요청한 경우, 수집된 개인정보는 즉시 파기됩니다. 다만, 법령에 의해 보존하여야 하는 경우에는 해당 기간 동안 보존됩니다.

개인정보의 파기 절차 및 방법
이용자의 개인정보는 보유 기간이 종료된 후, 즉시 파기됩니다. 파기 절차 및 방법은 다음과 같습니다.

파기절차: 이용자가 제공한 개인정보는 개인정보보호책임자의 승인을 받아 파기합니다.
파기방법: 전자적 파일 형태의 경우 복구 및 재생이 불가능한 방법으로 기록을 삭제하며, 인쇄물 등은 분쇄하거나 소각하는 방식으로 파기합니다.
이용자의 권리
이용자는 언제든지 자신의 개인정보에 대해 열람, 정정, 삭제를 요구할 수 있습니다. 이 경우, 서비스 운영자는 지체 없이 필요한 조치를 취합니다.</h2>
	
</body>
</html>