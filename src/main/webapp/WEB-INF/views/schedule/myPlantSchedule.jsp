<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-04-27
  Time: 오후 3:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div>
    사용자에게 맞는 물의 양
</div>
<h1>myPlantSchedule</h1>

<table style="border-spacing: 40px;">
    <thead>
    <tr>
        <th scope="col">스케쥴번호</th>
        <th scope="col">내식물</th>
        <th scope="col">작성자</th>
        <th scope="col">작성일자</th>
        <th scope="col">watering</th>
        <th scope="col">nutri</th>
        <th scope="col">prun</th>
        <th scope="col">soil</th>
        <th scope="col">ventilation</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="schedule" items="${schedulelist}">
        <tr>
            <td>${schedule.scheduleId}</td>
            <td>${schedule.myplantId}</td>
            <td>${schedule.userId}</td>
            <td>${schedule.scheduleDate}</td>
            <td>${schedule.watering}</td>
            <td>${schedule.nutri}</td>
            <td>${schedule.prun}</td>
            <td>${schedule.soil}</td>
            <td>${schedule.ventilation}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
