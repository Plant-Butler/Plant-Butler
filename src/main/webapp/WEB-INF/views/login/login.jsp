<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<link href="./resources/css/style.css" rel="stylesheet">

</head>
<body style="text-align: center">

<br>
   <form>
      <div class="wrap">
        <div class="login">
           <h3>Plant</h3>
           <br>
            <h2>Log-in</h2>
            <br>
            <div class="login_id">
                <h4>ID</h4>
                <input type="text" name="userId" id="userId" placeholder="ID">
            </div>
            <div class="login_pw">
                <h4>Password</h4>
                <input type="password" name="password" id="password" placeholder="Password">
            </div>
            <div class="login_etc">
                 <p style="text-align:middle;"><a type="submit" href='./registPage'>Register</a><p>
            </div>
                <button type="button" onclick="login()">로그인</button>

        </div>
    </div>
   </form>

   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    function login(){
        let userId = document.getElementById("userId").value;
        let password = document.getElementById("password").value;
        let data = {};
        data.userId = userId;
        data.password = password;
        console.log(userId);
        console.log(data);

        $.ajax({
          type: "POST",
          url: "/loginPage/login",
          data: data,
          success: function(data) {
            if (data === 'success') {
              alert("로그인 성공");
              location.href = '/home';
            }
          },
          error: function(xhr, status, error) {
            console.log('error:', error);
            alert('아이디 또는 비밀번호가 올바르지 않습니다.');
          }
        });
    };


    </script>
</body>
</html>