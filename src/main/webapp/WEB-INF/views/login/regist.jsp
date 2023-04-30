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
  <h1>Register</h1>
	</div>
<!-- 	<hr> -->
<br>
	<form action="./regist" method="post" name="joinform">
		<table>
			<div>
			<tr>
				<td class = "title">아이디 :</td>
				<td><input class = "regist_id" type="text" name="userId" id="userId" readonly="readonly"></td>
				<td><input class = "submit" type="button" value="중복확인" onclick="IdCheck()" required="required"></td>
			</tr>
			</div>
			<div>
			<tr>
				<td class = "title">닉네임 :</td>
				<td><input class = "regist_id" type="text" name="nickname" id="nickname"></td>
			</tr>
			</div>
			<tr>
				<td class = "title">비밀번호 :</td>
				<td><input  class = "regist_pw" type="password" name="password" id="password" required="required"></td>
				<td></td>
			</tr>
			</div>
			<div>
			<tr>
				<td class = "title">비밀번호 확인 :</td>
				<td><input  class = "regist_pw" type="password" name="checkPwd" id="checkPwd" onkeyup="checkerPwd()" required="required"></td>
				<td><div id="checkerPwd">  동일한 암호를 입력하세요.</div></td>
			</tr>
			</div>
			<div>
			<tr>
				<td class = "title">이메일 :</td>
				<td><input class = "regist_id" type="text" name="email" id="email"></td>
			</tr>
			</div>
			<div>
				<td>
				  <a href="./cookie" target="_self">쿠키 수집 동의 약관</a>
				  <input type="checkbox" name="cookie" value="cookie" id="cookie" required>
				</td>
				<tr>
				  <td>
				    <a href="./webpush" target="_self">웹푸시 동의 약관</a>
				    <input type="checkbox" name="webpush" value="webpush" id="webpush" required>
				  </td>
				</tr>
			</div>
			<div>
			<tr>

                <td colspan="1"><input class="submit" type="submit" value="가입하기"
					onclick="finalCheck()"></td>

			</tr>
			</div>
		</table>
	</form>
</body>
</html>