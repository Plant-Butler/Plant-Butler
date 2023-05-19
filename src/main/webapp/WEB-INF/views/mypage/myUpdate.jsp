<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<%@ include file="../main/header.jsp" %>
<style>
    table {
        text-align: center;
        margin-left:630px;
        width: 1000px;
    }
    button {
      width: 250px;
      height: 30px;
      border-radius: 5px;
    }
    th {
      width: 150px;
      height: 70px;
    }
    input {
      text-align: center;
      width: 300px;
      height: 25px;
    }
    .submit {
        width: 80px;
    }
    .msg {
        text-align: left;
        width: 500px;
    }
</style>
</head>
<body>
<body style="text-align: center">
<br><br>
<form name="joinform">
<table>
    <tr>
        <th>아이디 </th>
        <td><input type="text" name="userId" id="userId" value="${user.userId}" readonly="readonly"></td>
    </tr>
    <tr>
        <th>비밀번호 </th>
		<td><input type="password" name="password" id="password" onkeyup="pwdCheck()" required="required"></td>
		<td class="msg"><div id="password-message"></div></td>
	</tr>
	<tr>
		<th>비밀번호 확인 </th>
		<td><input type="password" name="checkPwd" id="checkPwd" onkeyup="checkerPwd()" required="required"></td>
		<td class="msg"><div id="checkerPwd">동일한 암호를 입력하세요.</div></td>
    </tr>
    <tr>
        <th>닉네임 </th>
		<td><input type="text" name="nickname" id="nickname" value="${user.nickname}" required="required"></td>
		<td class="msg"><input class = "submit" type="button" value="중복확인" onclick="NickUpdate()" required="required"></td>
	</tr>
    <tr>
        <th>이메일 </th>
		<td><input type="text" name="email" id="email" value="${user.email}" required="required"></td>
	</tr>
	<tr>
	    <th></th><td><button type="button" onclick="updateMypage('${user.userId}')">수정</button></td><td></td>
	</tr>
</table>
</form>


<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="/js/regist.js"></script>
</body>
</html>