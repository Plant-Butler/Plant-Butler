<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script type="module" src="/js/mainscript.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<%@ include file="../main/header.jsp" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<style>
 h1, h2, div, button{
    font-family: 'Hahmlet', serif;
 }

 #mypage-ttl {
    background-color: #b8d4c8;
    display: inline-block;
    padding: 10px;
    border-radius: 5px;
 }
  #point{
    color: #b8d4c8;
  }
  button {
    width: 300px;
    height: 50px;
    border-radius: 5px;
    background-color:#b8d4c8;
  }
  button:hover {
    background-color:white;
    transition: 0.7s;
  }
    .spacing {
        margin-right: 80px;
    }

   .cta {
      background-color: white;
   }

   .options{
    border: none;
   }

    .mypagetitle{
       font-family: 'Hahmlet', serif;
       font-size: 3em;
       color: #000000;
       text-align: center;
       font-weight: 700;
       font-style: normal;
    }
</style>
</head>
<body>
<body style="text-align: center;">

<section class="page-section cta">
<div class="container" style="margin-top: 150px">
    <h1 class="mypagetitle">마이페이지</h1>
    <br><br>
    <h2><span id="nick">${nickname}</span> 님의 현재 포인트는 <span id="point">${point}</span> 점 입니다.</h2>
    <br>
    <hr style="width: 70%; margin:auto;">
    <br><br><br>
    <button class="options" type="button" onclick = "location.href = '/mypage/suggestions/${userId}'">나에게 맞는 식물 결과</button>
    <span class="spacing"></span>
    <button class="options" type="button" onclick="location.href='/mypage/${userId}'">내 정보 수정</button>
    <br><br><br>
    <button class="options" type="button" onclick = "location.href = '/mypage/community/${userId}'">내 게시물/댓글</button>
    <span class="spacing"></span>
    <button class="options" type="button" onclick = "deleteUserCheck('${userId}', 0)">탈퇴하기</button>
</div>
</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 200px;">
  <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>


<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/manager.js"></script>
</body>
</html>