<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.regex.Pattern" %>
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
   function NickCheck() {
      window.open("./nickCheckForm", "nickWin", "width=400, height=350");
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

        function pwdCheck() {
          var password = document.getElementById("password").value;
          var pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/; // 정규 표현식 패턴 설정
          var isValidPassword = pattern.test(password); // 패턴에 맞는지 확인하여 true 또는 false로 반환

          var passwordMessage = document.getElementById("password-message"); // 안내 메시지를 출력할 영역

          if (!isValidPassword) {
            passwordMessage.innerHTML = "영문 대/소문자, 숫자, 특수문자를 모두 포함 8자 이상이어야 합니다";
            passwordMessage.style.color = "red";
          } else {
            passwordMessage.innerHTML = "비밀번호가 유효합니다.";
            passwordMessage.style.color = "green";
          }

          // 비밀번호 유효성 체크 결과를 반환

          return isValidPassword;
        }


        function finalCheck(event) {
          var id = document.joinform.userId.value;
          var pw1 = document.joinform.password.value;
          var nickname = document.joinform.nickname.value;
          var pw2 = document.joinform.checkPwd.value;
          var email = document.joinform.email.value;
          var cookie = document.joinform.cookie.checked;
          var webpush = document.joinform.webpush.checked;
          var email_regex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
          var pwd_regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
          // pwdCheck() 함수 호출하여 비밀번호 유효성 체크 결과 받아옴
          var isValidPassword = pwdCheck();
            if ((id != null) && (pw1 == pw2) && (pw1 != "") && (pw2 != "") && (email_regex.test(email)) &&(pwd_regex.test(pw1)) && cookie && webpush) {
                alert('가입 완료! 로그인해주세요');
            } else {
                alert("조건이 맞지 않습니다. 다시 시도해주세요.");
                    event.preventDefault();
                    return false;
             }
        }


</script>


<body style="text-align: center">
   <div class="about-section">
  <h1>Register</h1>
   </div>
<br>
   <form id = "myform" action="./registPage" method="post" name="joinform" onsubmit="return finalCheck(event);">
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
            <td><input class = "regist_id" type="text" name="nickname" id="nickname" readonly="readonly"></td>
            <td><input class = "submit" type="button" value="중복확인" onclick="NickCheck()" required="required"></td>
         </tr>
         </div>
         <tr>
            <td class = "title">비밀번호 :</td>
            <td><input class="regist_pw" type="password" name="password" id="password" required="required" onkeyup="pwdCheck()">
               <td><div id="password-message"></div></td>
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
              <td class="title">이메일 :</td>
              <td><input class="regist_id" type="email" name="email" id="email" required="required" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"></td>
            </tr>
         </div>
         <div>
         <tr>
           <td>쿠키 수집 동의 약관</td>
           <td><p style="font-size: 9px; display:inline-block; margin-left: 10px;">이 사이트는 쿠키를 사용합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 쿠키 사용에 동의하십니까?</p></td>
           <td><input type="checkbox" name="cookie" value="cookie" id="cookie" style="display:inline-block; margin-left: 10px;" required></td>
         </tr>

            <tr>

                <td>웹푸시 동의 약관</td>
                <td><p style="font-size: 9px; display:inline-block; margin-left: 10px;">이 사이트에서는 웹 푸시 알림을 제공합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 웹 푸시 알림 사용에 동의하십니까?</p></td>
               <td><input type="checkbox" name="webpush" value="webpush" id="webpush" style="display:inline-block; margin-left: 10px;" required></td>

            </tr>
         </div>
         <div>
         <tr>

                <td colspan="1"><input class="submit" type="submit" value="가입하기"></td>

         </tr>
         </div>
      </table>
   </form>
</body>
</html>