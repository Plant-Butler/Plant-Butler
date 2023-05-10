<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@ include file="../main/header.jsp" %>
<style>
    table, td {
        text-align: center;
        margin-left:auto;
        margin-right:auto;
        border: 1px solid;
    }
    td {
        width: 90%;
    }
</style>
</head>
<body>
<body style="text-align: center">
<br>
<
<c:forEach var="plant" items="${recomPlantList}">
    <table width="1500" height="250">
        <tr>
            <th colspan="2"><img class="plantImg" src="/uploads/${plant.image}"></th>
        </tr>
        <tr>
            <th colspan="2">${plant.distbNm}</th>
        </tr>
        <tr>
            <th>분류</th>
            <td>${plant.clCodeNm}</td>
        </tr>
        <tr>
            <th>조언</th>
            <td>${plant.adviseInfo}</td>
        </tr>
        <tr>
            <th>관리 수준</th>
            <td>${plant.managelevelCodeNm}</td>
        </tr>
        <tr>
            <th>특별관리 정보</th>
            <td><c:if test="${empty plant.speclmanageInfo}"> - </c:if> ${plant.speclmanageInfo}</td>
        </tr>
        <tr>
            <th>기능성</th>
            <td>${plant.fncltyInfo}</td>
        </tr>
    </table>
    <br><br>
</c:forEach>

</body>
</html>