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
<!-- 나에게 맞는 식물 찾기 -->
<%if (isLoggedIn) { %>
     <a href="/suggestions">
        사진<img class="" src=""/>
     </a>
<% } else { %>
     <a href="/loginPage">관리자페이지</a>
<%  }; %>

<a href="/suggestions">
    사진<img class="" src=""/>
</a>
</body>
</html>