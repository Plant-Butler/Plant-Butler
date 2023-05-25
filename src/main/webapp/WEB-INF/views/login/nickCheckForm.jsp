<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NickCheckForm</title>
</head>

<script>
	function blankCheck(f) {
		var nickname = f.nickname.value;
		nickname = nickname.trim();
		if (nickname.length < 1) {
			alert("닉네임은 1자 이상 입력해주십시오.");
			return false;
		}
		return true;
	}
</script>

<body>
	<div style="text-align: center;">
		<h3>닉네임 중복 확인</h3>
		<form action="./nickCheckProc" method="post" onsubmit="return blankCheck(this)">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			닉네임: <input type="text" name="nickname"><input type="submit" value="중복확인">

		</form>
	</div>
</body>
</html>