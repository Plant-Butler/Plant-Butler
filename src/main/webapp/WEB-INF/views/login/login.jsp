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
</div> 
<br>
	<form action="./home" method="get" class = "right">
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
            <div class="submit">
                <input type="submit" value="begin">
            </div>
        </div>
    </div>
	</form>
</body>
</html>