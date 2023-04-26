<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<%@ include file="../main/header.jsp" %>
</head>
<body>
<div id="sugNdMy" data-isLoggedIn="<%= isLoggedIn %>" >
    <!-- 나에게 맞는 식물 찾기 -->
    <a onclick="serviceSug()" >
        나에게 맞는 식물 찾기<img class="" src=""/>
    </a>

    <!-- 내 식물 -->
    <a onclick="serviceMy()" >
        내 식물<img class="" src=""/>
    </a>
</div>

<h1> 이번달 우수회원 </h1>



<script>
    let isLoggedIn = document.getElementById("sugNdMy").getAttribute("data-isLoggedIn");
    function serviceSug() {
        if (isLoggedIn == "true") {
            location.href = "/suggestions"
        } else {
            alert('로그인 후 이용해주세요')
            location.href = "/loginPage"
        }
    }

    function serviceMy() {
        if (isLoggedIn == "true") {
            location.href = "/myplants"
        } else {
            alert('로그인 후 이용해주세요')
            location.href = "/loginPage"
        }
    }
</script>
</body>
</html>