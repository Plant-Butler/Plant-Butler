<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>
<%@ include file="../main/header.jsp" %>
</head>
<body>

<table>
    <tr>
        <td>아이디 </td>
        <td><input type="text" name="userId" id="userId" value="${sessionScope.user.userId}" readonly="readonly"></td>
    </tr>
    <tr>
        <td>비밀번호 </td>
		<td><input type="password" name="password" id="password" required="required"></td>
	</tr>
		<td>비밀번호 확인 </td>
		<td><input type="password" name="checkPwd" id="checkPwd" onkeyup="checkerPwd()" required="required"></td>
		<td><div id="checkerPwd">  동일한 암호를 입력하세요.</div></td>
    </tr>
    <tr>
        <td>닉네임 </td>
		<td><input type="text" name="nickname" id="nickname" value="${sessionScope.user.nickname}" required="required"></td>
	</tr>
    <tr>
        <td>이메일 </td>
		<td><input type="text" name="email" id="email" value="${sessionScope.user.email}" required="required"></td>
	</tr>
	<tr>
	    <td><button type="button" onclick="updateMypage('${sessionScope.user.userId}')">수정</button></td>
	</tr>
</table>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function checkerPwd() {
		var pw1 = $('#password').val();
		var pw2 = $('#checkPwd').val();
		if ((pw1 == pw2) || (pw1 != "") || (pw2 != "")) {
			document.getElementById('checkerPwd').style.color = "red";
			document.getElementById('checkerPwd').innerHTML = "일치하는 비밀번호입니다.";
		}
	}

    function updateMypage(userId) {
        let password = $('#password').val();
        let checkPwd = $('#checkPwd').val();
        let nickname = $('#nickname').val();
        let email = $('#email').val();
        console.log(password);
        console.log(nickname);

        if((password = "") || (nickname == "") || (email = "")) {
            alert('전부 입력해주세요');
        }

        let user = {
            password: password,
            nickname: nickname,
            email: email
        };

        $.ajax({
            url: '/mypage/' + userId,
            type: 'PATCH',
            contentType: 'application/json',
            data: user,
            success: function (result) {
                if (result.success) {
                   alert(result.message);
                } else {
                   alert('수정에 실패하였습니다');
                }
            },
            error: function(request, status, error) {
                alert('오류가 발생하였습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }

        });
    }
</script>
</body>
</html>