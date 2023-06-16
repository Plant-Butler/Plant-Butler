<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@ include file="../main/header.jsp" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<style>
    div, table {
        font-family: 'Hahmlet', serif;
    }
    .result-tbl {
        width: 90%;
        border-collapse: separate;
        border-spacing: 0 30px;
        border: 1px solid #b8d4c8;
        border-radius: 5px;
        box-shadow: 0 10px 11px rgba(0, 0, 0, 0.1);
    }
    td {
        width: 90%;
    }
    .myrecom{
        margin-top: 200px;

    }
</style>
</head>
<body>
<body style="text-align: center">
<br>

<h2 class="myrecom">나에게 맞는 반려식물 결과</h2>
<br><br>
<c:forEach var="plant" items="${recomPlantList}">
    <table class="result-tbl">
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
            <th>비료 정보</th>
            <td><c:if test="${empty plant.frtlzrInfo}"> - </c:if> ${plant.frtlzrInfo}</td>
        </tr>
        <tr>
            <th>토양 정보</th>
            <td><c:if test="${empty plant.soilInfo}"> - </c:if> ${plant.soilInfo}</td>
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
<br><br>
<!-- Footer -->
<footer class="footer text-faded text-center py-5">
    <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

<!-- Footer -->
<footer class="footer text-faded text-center py-5">
    <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

</body>
</html>