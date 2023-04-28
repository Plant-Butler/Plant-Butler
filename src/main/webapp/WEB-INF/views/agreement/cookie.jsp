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
  <h1>쿠키 수집 동의서</h1>
	</div>
<br>
<h2>
쿠키란?
쿠키는 웹사이트가 사용자의 컴퓨터나 모바일 기기에 저장하는 작은 텍스트 파일입니다. 쿠키는 사용자가 웹사이트를 방문할 때마다 웹사이트에서 읽고 쓸 수 있는 정보를 제공합니다.

쿠키의 사용 목적
저희 웹사이트에서는 다음과 같은 목적으로 쿠키를 사용합니다.

사용자의 개인화된 경험 제공
웹사이트 이용 통계 및 분석
광고 게재 및 효과 측정
쿠키의 수집 및 이용 동의
저희 웹사이트에서는 쿠키를 사용합니다. 사용자가 본 동의서에 동의하지 않을 경우, 일부 기능이 제한될 수 있습니다.

쿠키의 관리 및 삭제
쿠키는 사용자의 웹브라우저에서 관리할 수 있습니다. 대부분의 웹브라우저에서는 쿠키를 허용하거나 차단하도록 설정할 수 있습니다. 사용자가 쿠키를 차단하는 경우, 일부 기능이 제한될 수 있습니다.

개인정보 처리방침
저희 웹사이트는 개인정보 처리방침을 통해 사용자의 개인정보 보호에 최선을 다하고 있습니다. 개인정보 처리방침에 대한 자세한 내용은 웹사이트 내 개인정보 처리방침 페이지를 참조해주세요.

위 내용을 확인하였으며, 쿠키의 수집 및 이용에 동의합니다.
</body>
</html>