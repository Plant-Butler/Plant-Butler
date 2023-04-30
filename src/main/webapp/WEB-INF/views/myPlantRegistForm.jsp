<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-04-26
  Time: 오전 11:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>regist form</h1>
<form action="/myplants/form" method="post">
<table>
  <tr><td>식물아이디 :</td><td><input type="text" name = "plantId"></td><td></td></tr>
  <tr><td>유저아이디 :</td><td><input type="text" name = "userId"></td><td></td></tr>
  <tr><td>식물닉네임 :</td><td><input type="text" name = "myplantNick"></td><td></td></tr>
  <tr><td>내 식물 이미지:</td><td><input type="text" name= "myplantImage"></td><td></td></tr>
  <tr><td>내 식물 무게 :</td><td><input type="text" name = "myplantWeight"></td><td></td></tr>
  <tr><td>내 식물 높이 :</td><td><input type="text" name = "myplantLength"></td><td></td></tr>
  <tr><td>내 식물 깊이 :</td><td><input type="text" name = "myplantDepth"></td><td></td></tr>
  <tr><td>내 화분 지름 1:</td><td><input type="text" name="myplantRadius1"></td><td></td></tr>
  <tr><td>내 화분 지름 2:</td><td><input type="text" name ="myplantRadius2"></td><td></td></tr>

</table>
  <button type="submit">제출하기</button>
</form>

</body>
</html>
