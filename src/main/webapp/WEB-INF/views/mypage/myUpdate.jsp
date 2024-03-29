<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<%@ include file="../main/header.jsp" %>
    <style>
        .myupdatetitle{
            margin-top: 10px;
        }
        table {
            text-align: center;
            margin-left: 480px;
            width: 70%;
        }
        button {
          width: 250px;
          height: 30px;
          border-radius: 5px;
        }
        .mutitle {
          background-color: #b8d4c8;
          border-radius: 10px;
        }
        td{
            padding: 10px;
        }
        input {
          text-align: center;
          width: 85%;
          height: 15%;
          border-radius: 10px;
          padding: 10px;
        }
        .submit {
            width: 80px;
        }
        .msg {
            text-align: left;
            width: 600px;
        }
        .nickCheck {
            width:20%;
        }
        .cta {
            background-color: white;
        }
        .doupdatemy {
            text-align: center;
            background-color: #b8d4c8;
            border-radius: 10px;
            font-size: 20px;
            color: black;
             border: none;
             height: 40px;
             width: 150px;
        }

        .doupdatemy input[type="submit"] {
          padding: 10px 20px;
          background-color: #4caf50;
          color: white;
          border: none;
          border-radius: 4px;
          cursor: pointer;
          font-size: 16px;
        }

        .doupdatemy input[type="submit"]:hover {
          background-color: #45a049;
        }
    </style>
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
</head>
<body style="text-align: center">
<br><br>

<section class="page-section cta">
<div style="margin-top: 80px">
<h1 class="myupdatetitle">회원 정보 수정</h1>
<br>
<hr style="width: 70%; margin:auto;">
<br>
<form name="joinform">
<table>
    <tr>
        <th><p class="mutitle">아이디</p></th>
        <td><input type="text" name="userId" id="userId" value="${userId}" readonly="readonly"></td>
    </tr>
    <tr>
        <th><p class="mutitle">비밀번호</p></th>
		<td><input type="password" name="password" id="password" onkeyup="pwdCheck()" required="required"></td>
		<td class="msg"><div id="password-message"></div></td>
	</tr>
	<tr>
		<th><p class="mutitle">비밀번호 확인</p></th>
		<td><input type="password" name="checkPwd" id="checkPwd" onkeyup="checkerPwd()" required="required"></td>
		<td class="msg"><div id="checkerPwd">동일한 암호를 입력하세요.</div></td>
    </tr>
    <tr>
        <th><p class="mutitle">닉네임</p></th>
		<td><input type="text" name="nickname" id="nickname" value="${nickname}" required="required" readonly="readonly"></td>
		<td class="msg"><input class = "submit nickCheck" type="button" value="중복확인" onclick="NickUpdate()" required="required"></td>
	</tr>
    <tr>
        <th><p class="mutitle">이메일</p></th>
		<td><input type="text" name="email" id="email" value="${email}" required="required"></td>
	</tr>
</table>
<br>
<br>
<td colspan="3"><button class="doupdatemy" type="button" onclick="updateMypage('${userId}')">수정</button></td>
</form>

</div>
</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px;">
  <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>


<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="/js/regist.js"></script>
</body>
</html>