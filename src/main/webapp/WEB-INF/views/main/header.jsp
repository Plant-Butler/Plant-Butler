<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.plant.vo.UserVo" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>header</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>

<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Raleway:100,100i" rel="stylesheet"/>

<link href="/css/styles.css" rel="stylesheet" />

</head>
<body>
    <header>
        <h1 class="site-heading text-center text-faded d-none d-lg-block">
             <span class="site-heading-lower">Plantery</span>
        </h1>
    </header>
    <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
        <div class="container">
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mx-auto">
                    <%
                    UserVo userVo = (UserVo) session.getAttribute("user");
                    System.out.println("user session = " + userVo);
                    boolean isLoggedIn = false;

                    if (userVo != null) {
                        isLoggedIn = true;
                    }
                    %>

                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/home">HOME</a></li>

                    <!-- 로그인 후 디스플레이 -->
                    <%if (isLoggedIn) {
                        if (userVo.getManager() == 0) {
                    %>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/mypage">마이페이지</a></li>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/diaries">식물일기</a></li>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/myplants">내 식물</a></li>

                    <%  } else {%>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/manager">관리자페이지</a></li>
                    <%  }
                    };%>

                    <!-- 로그인 전&후 디스플레이 -->
                    <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/community">커뮤니티</a></li>

                    <!-- 로그인/로그아웃 -->
                    <%if (isLoggedIn) {%>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/logout">로그아웃</a></li>
                    <%} else {%>
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/loginPage">로그인</a></li>
                    <%};%>
                </ul>
            </div>
        </div>
    </nav>


        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/js/scripts.js"></script>
<br><br>


</body>
</html>