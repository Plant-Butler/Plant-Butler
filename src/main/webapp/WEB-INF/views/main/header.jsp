<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.plant.vo.UserVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
</head>
<body>
<div id="header">
    <%
    //UserVo userVo = (UserVo) session.getAttribute("user");
    boolean isLoggedIn = true;

    // 테스트용
    UserVo userVo = new UserVo();
    userVo.setManager(0);
    //

    //if (userVo != null) {
    //	isLoggedIn = true;
    //}
    %>
    <a href="/home">사이트명</a>

    <!-- 로그인 후 디스플레이 -->
    <%if (isLoggedIn) {
        if (userVo.getManager() == 0) {
    %>
            <a href="/mypage">마이페이지</a> <a href="/diaries">식물일기</a>
    <%  } else {%>
            <a href="/manager">관리자페이지</a>
    <%  }
    };%>

    <!-- 로그인 전&후 디스플레이 -->
    <a href="/community">커뮤니티</a>

    <!-- 로그인/로그아웃 -->
    <%if (isLoggedIn) {%>
        <a href="/loginPage/logout">로그아웃</a>
    <%} else {%>
        <a href="/loginPage">로그인</a>
    <%};%>
</div>

</body>
</html>