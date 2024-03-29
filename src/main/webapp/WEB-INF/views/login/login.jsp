<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<%@ include file="../main/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/login.css">
    <meta charset="UTF-8">
    <title>로그인</title>
    <script type="module" src="/js/mainscript.js"></script>
    <%@ include file="../main/header.jsp" %>
    <script>
        var csrfToken = '${_csrf.token}';
        var csrfHeader = '${_csrf.headerName}';
    </script>
</head>
<div class="header-background">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<body style="text-align: center">
    <section class="loginsection">
        <div class="form-box">
            <div class = "form-value">
                    <h2 class="loginh2"> 로그인 </h2>
                    <div class="inputbox">
                        <ion-icon name="person-outline"></ion-icon>
                        <input type="text" name="userId" id="userId" required>
                        <label for="">Username</label>
                    </div>
                    <div class="inputbox">
                        <ion-icon name="lock-closed-outline"></ion-icon>
                        <input type="password" name="password" id="password" required>
                        <label for="">Password</label>
                    </div>
                    <div class="signin">
                        <a href="./registPage">회원가입</a>
                    </div>
                   <button class="loginbutton" type="button" onclick="login()">로그인</button
                </form>
            </div>
        </div>
    </section>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

<style>
    input {
        width: 250px;
        text-align: center;
    }
</style>

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
</div>
</html>