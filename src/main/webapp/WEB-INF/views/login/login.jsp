<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <script type="module" src="/js/mainscript.js"></script>
    <%@ include file="../main/header.jsp" %>
    <script>
        var csrfToken = '${_csrf.token}';
        var csrfHeader = '${_csrf.headerName}';
    </script>
</head>
<body style="text-align: center">
<style>
    input {
        width:250px;
        text-align: center;
    }
</style>

<br>
<form>
    <div class="wrap" style="margin-top: 500px">
        <div class="login">
            <br>
            <h2>로그인</h2>
            <br>
            <div class="login_id">
                <h4>아이디</h4>
                <input type="text" name="userId" id="userId" placeholder="ID">
            </div>
            <div class="login_pw">
                <h4>비밀번호</h4>
                <input type="password" name="password" id="password" placeholder="Password">
            </div>
            <br><button type="button" onclick="login()">로그인</button>
        </div>
    </div>
</form>
<div class="login_etc">
    <p style="text-align:middle;"><a type="submit" href='./registPage'>회원가입</a><p>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function login() {
        let userId = document.getElementById("userId").value;
        let password = document.getElementById("password").value;
        let data = {
            userId: userId,
            password: password
        };

        console.log(userId);
        console.log(data);

        $.ajax({
            type: "POST",
            url: "/loginPage/login",
            data: data,
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(data) {
                if (data === 'success') {
                    alert("환영합니다!");
                    location.href = '/home';
                }
            },
            error: function(xhr, status, error) {
                console.log('error:', error);
                alert('아이디 또는 비밀번호가 올바르지 않습니다.');
            }
        });
    }


</script>
</body>
</html>