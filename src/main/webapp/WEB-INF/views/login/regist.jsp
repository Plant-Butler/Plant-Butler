<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.regex.Pattern" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Registration</title>
<%@ include file="../main/header.jsp" %>
<style type="text/css">
   #checkerPwd {
      color: red;
   }
   input {
      text-align: center;
      width:300px;
   }
   .submit {
        text-align: center;
        width:100px;
   }
</style>
</head>
<body>

<body style="text-align: center">
   <div class="about-section">
  <h1>회원가입</h1>
   </div>
<br>
   <form id = "myform" action="./registPage" method="post" name="joinform" onsubmit="return finalCheck(event);">
      <table style="margin-left:auto;margin-right:auto;" width="900" length="100">
         <div>
         <tr style="height:100px">
            <th class = "title">아이디 </th>
            <td><input class = "regist_id" type="text" name="userId" id="userId" readonly="readonly" placeholder="아이디를 입력하세요"></td>
            <td><input class = "submit" type="button" value="중복확인" onclick="IdCheck()" required="required"></td>
         </tr>
         </div>
         <div>
         <tr style="height:100px">
            <th class = "title">닉네임 </th>
            <td><input class = "regist_id" type="text" name="nickname" id="nickname" readonly="readonly" placeholder="닉네임을 입력하세요"></td>
            <td><input class = "submit" type="button" value="중복확인" onclick="NickCheck()" required="required"></td>
         </tr>
         </div>
         <tr style="height:100px">
            <th class = "title">비밀번호 </th>
            <td><input class="regist_pw" type="password" name="password" id="password" required="required" onkeyup="pwdCheck()" placeholder="비밀번호를 입력하세요">
               <td><div id="password-message"></div></td>
         </tr>
         </div>
         <div>
         <tr style="height:100px">
            <th class = "title">비밀번호 확인 </th>
            <td><input  class = "regist_pw" type="password" name="checkPwd" id="checkPwd" onkeyup="checkerPwd()" required="required" placeholder="비밀번호를 다시 입력하세요"></td>
            <td><div id="checkerPwd">  동일한 암호를 입력하세요.</div></td>
         </tr>
         </div>
         <div>
            <tr style="height:100px">
              <th class="title">이메일 </th>
              <td><input class="regist_id" type="email" name="email" id="email" required="required" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" placeholder="이메일을 입력하세요"></td>
            </tr>
         </div>
         <div>
         <tr style="height:100px">
           <th>쿠키 수집 동의 약관</th>
           <td><p style="font-size: 12px; display:inline-block;">이 사이트는 쿠키를 사용합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 쿠키 사용에 동의하십니까?</p></td>
           <td><input type="checkbox" name="cookie" value="cookie" id="cookie" style="display:inline-block; margin-left: 10px;" required></td>
         </tr>

            <tr style="height:100px">

                <th>웹푸시 동의 약관</th>
                <td><p style="font-size: 12px; display:inline-block;">이 사이트에서는 웹 푸시 알림을 제공합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 웹 푸시 알림 사용에 동의하십니까?</p></td>
               <td><input type="checkbox" name="webpush" value="webpush" id="webpush" style="display:inline-block; margin-left: 10px;" required></td>

            </tr>
            <tr style="height:100px">
                       <th>위치 정보 수집 동의 약관</th>
                       <td><p style="font-size: 12px; display:inline-block;">이 사이트는 사용자의 위치 정보를 사용합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 위치 정보 사용에 동의하십니까?</p></td>
                       <td><input type="checkbox" name="location" value="location" id="location" style="display:inline-block; margin-left: 10px;" required></td>
                     </tr>
         </div>
         <div>
         <tr style="height:100px">

                <td></td><td colspan="1"><input class="submit" type="submit" value="가입하기"></td><td></td>

         </tr>
         </div>
      </table>
   </form>
   <script src="./js/regist.js"></script>
</body>

</html>