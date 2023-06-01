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
<style>
  #point{
    color: YellowGreen;
  }
  #nick {
    color: Green;
  }
  button {
    width: 300px;
    height: 50px;
    border-radius: 5px;
  }
  button:hover {
    background-color:YellowGreen;
    transition: 0.7s;
  }
</style>
</head>
<body>
<body style="text-align: center">


<br>
<h2><span id="nick">${nickname}</span> 님의 현재 포인트는 <span id="point">${point}</span> 점 입니다.</h2>
<br><br>
<button type="button" onclick="location.href='/mypage/${userId}'">내 정보 수정</button>
<br><br>
<button type="button" onclick = "location.href = '/mypage/suggestions/${userId}'">나에게 맞는 식물 결과</button>
<br><br>
<button type="button" onclick = "location.href = '/mypage/community/${userId}'">내 게시물/댓글</button>
<br><br>
<button type="button" onclick = "deleteUserCheck('${userId}', 0)">탈퇴하기</button>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/manager.js"></script>
</body>
</html>