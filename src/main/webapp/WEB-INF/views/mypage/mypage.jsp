<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%@ include file="../main/header.jsp" %>
</head>
<body>

<br>
<button type="button" onclick="location.href='/mypage/${userId}'">내 정보 수정</button>
<br><br>
<button type="button" onclick = "location.href = '/mypage/suggestions/${userId}'">나에게 맞는 식물 결과 </button>
<br><br>
<button type="button" onclick = "location.href = '/myplants'">내 식물 </button>
<br><br>
<button type="button" onclick = "location.href = '/mypage/community/${userId}'">내 게시물 댓글</button>
<br><br>
<button type="button" onclick = "location.href = '/secession'">탈퇴하기 </button>

</body>
</html>