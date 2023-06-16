<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.plant.vo.UserVo" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>header</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
            crossorigin="anonymous"></script>
    </script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Raleway:100,100i" rel="stylesheet"/>

<link href="/css/styles2.css" rel="stylesheet" />

</head>
<body>
    <header id="mainheader">
        <h1 id ="headertitle" class="site-heading text-center text-faded d-none d-lg-block" style="height: 80px; width: 100%;">
             <span class="site-heading-lower" style="width: 100%;">Plantery</span>
        </h1>
        <nav class="navbar navbar-expand-lg navbar-dark py-lg-4" id="mainNav">
            <div class="container">
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/home" style="font-size: 17px">HOME</a></li>
                        <sec:authorize access="isAuthenticated()">
                            <sec:authentication property="principal" var="userPrincipal" />

                            <%-- 로그인 후 디스플레이 --%>
                            <sec:authorize access="hasRole('ROLE_USER')">
                                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/mypage" style="font-size: 17px">마이페이지</a></li>
                                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/diaries" style="font-size: 17px">식물일기</a></li>
                                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/myplants" style="font-size: 17px">내 식물</a></li>
                            </sec:authorize>

                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <%-- 관리자만 표시하는 경우 --%>
                                <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/manager" style="font-size: 17px">관리자페이지</a></li>
                            </sec:authorize>

                            <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/community" style="font-size: 17px">커뮤니티</a></li>
                            <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/logout" style="font-size: 17px">로그아웃</a></li>
                        </sec:authorize>

                        <sec:authorize access="!isAuthenticated()">
                            <%-- 로그인 전 디스플레이 --%>
                            <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/community" style="font-size: 17px">커뮤니티</a></li>

                            <%-- 로그인 --%>
                            <li class="nav-item px-lg-4"><a class="nav-link text-uppercase" href="/loginPage" style="font-size: 17px">로그인</a></li>
                        </sec:authorize>
                    </ul>
                </div>
            </div>
        </nav>
    </header>



        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/js/scripts.js"></script>
<br><br>


</body>
</html>