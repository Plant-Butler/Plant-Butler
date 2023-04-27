<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-04-27
  Time: 오전 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>내 식물 상세보기</h1>

<table>
    <tr><td>식물아이디 :</td><td><input type="text" name = "plantId" value="${myPlant.plantId}"></td><td></td></tr>
    <tr><td>유저아이디 :</td><td><input type="text" name = "userId" value="${myPlant.userId}"></td><td></td></tr>
    <tr><td>식물닉네임 :</td><td><input type="text" name = "myplantNick" value="${myPlant.myplantNick}"></td><td></td></tr>
    <tr><td>내 식물 이미지:</td><td><input type="text" name = "myplantImage" value="${myPlant.myplantImage}"></td><td></td></tr>
    <tr><td>내 식물 무게 :</td><td><input type="text" name = "myplantWeight" value="${myPlant.myplantWeight}"></td><td></td></tr>
    <tr><td>내 식물 높이 :</td><td><input type="text" name = "myplantLength" value="${myPlant.myplantLength}"></td><td></td></tr>
    <tr><td>내 식물 깊이 :</td><td><input type="text" name = "myplantDepth" value="${myPlant.myplantDepth}"></td><td></td></tr>
    <tr><td>내 화분 지름 1:</td><td><input type="text" name = "myplantRadius1" value="${myPlant.myplantRadius1}"></td><td></td></tr>
    <tr><td>내 화분 지름 2:</td><td><input type="text" name = "myplantRadius2" value="${myPlant.myplantRadius2}"></td><td></td></tr>
</table>

</body>
</html>
