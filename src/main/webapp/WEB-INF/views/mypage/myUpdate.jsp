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
        margin-left:auto;
        margin-right:auto;
    }
</style>
</head>
<body>
<body style="text-align: center">
<br><br>
<form name="joinform">
<table>
    <tr>
        <td>아이디 </td>
        <td><input type="text" name="userId" id="userId" value="${user.userId}" readonly="readonly"></td>
    </tr>
    <tr>
        <td>비밀번호 </td>
		<td><input type="password" name="password" id="password" onkeyup="pwdCheck()" required="required"></td>
		<td><div id="password-message"></div></td>
	</tr>
	<tr>
		<td>비밀번호 확인 </td>
		<td><input type="password" name="checkPwd" id="checkPwd" onkeyup="checkerPwd()" required="required"></td>
		<td><div id="checkerPwd">  동일한 암호를 입력하세요.</div></td>
    </tr>
    <tr>
        <td>닉네임 </td>
		<td><input type="text" name="nickname" id="nickname" value="${user.nickname}" required="required" readonly="readonly"></td>
		<td><input class = "submit" type="button" value="중복확인" onclick="NickUpdate()" required="required"></td>
	</tr>
    <tr>
        <td>이메일 </td>
		<td><input type="text" name="email" id="email" value="${user.email}" required="required"></td>
	</tr>
	<tr>
	    <td></td><td><button type="button" onclick="updateMypage('${user.userId}')">수정</button></td><td></td>
	</tr>
</table>
</form>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="/js/regist.js"></script>
</body>
</html>