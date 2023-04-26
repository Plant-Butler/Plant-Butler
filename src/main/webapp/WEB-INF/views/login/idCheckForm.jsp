<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IdCheckForm</title>
</head>

<script>
	function blankCheck(f) {
		var id = f.id.value;
		id = id.trim();
		if (id.length < 1) {
			alert("아이디는 1자 이상 입력해주십시오.");
			return false;
		}
		return true;
	}
</script>

<body>
	<div style="text-align: center;">
		<h3>아이디 중복 확인</h3>
		<form action="./idCheckProc" method="post" onsubmit="return blankCheck(this)">
			아이디: <input type="text" name="id"><input type="submit" value="중복확인">

		</form>
	</div>
</body>
</html>