<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ include file="../main/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>커뮤니티</title>

</head>
<body >
<div class = "about-section">
<h1><a class = "click_color" href="./main" id="notLine">Community</a></h1>

	<p style="text-align:right;"><a class = "submit" href="./logout">로그아웃</a> <a class = "submit" href="./mypage">마이페이지</a><p>
</div><br><br>
<p style="text-align:right;"><div class=submit_box><a class = "submit" href="./community/form">새 게시물 등록</a></div><p>
<br>
<div class = "overall">
<c:if test="${fn:length(postList) == 0}">
<table width=500 class = "post_list">
		<tr>
			<th>NO.</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>등록일</th>
		</tr>
			<tr>
				<td colspan="5">게시물이 없습니다.</td>		

			</tr>
	</table>
</c:if>
<c:if test="${fn:length(postList) > 0}">
	<table width=500 class = "post_list">
		<tr>
			<th>NO.</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>조회수</th>
			<th>등록일</th>
		</tr>
		<tr>
			<td colspan="5"><span id="backMsg"></span></td>
		</tr>
			<c:forEach var="post" items="${postList}">
				<tr>
					<td>${post.userId}</td>
					<td><a href="./community/detail/${post.postId}" id="notLine">${post.postTitle}</a></td>
		
					<td>${post.userId}</td>
					<td>${post.readCount}</td>
					<td><fmt:formatDate value="${post.postDate}" pattern="yyyy-MM-dd"/></td>
				</tr>
			</c:forEach>
	</table>
</c:if>
<br>
</div>
<!-- 검색 -->
<div class="form-inline">
	<form action="./search" method="get">	
	<select name="searchType" id="searchType">
		<option value="title" >제목</option>
		<option value="writer" >글쓴이</option>
		<option value="all" >제목/글쓴이</option>
	</select>
	<input class="form-control" type="text" id="keyword" name="keyword" value="${keyword}"/>
	<input type="submit" value="검색" id="search">
	</form>
	
</div>

<!-- 새 게시물 등록 -->


<br>

<!-- paging -->
-	<c:if test="${paging.prev}">
		<a href='<c:url value="./list?page=${paging.startPage-1}"/>'>이전</a>
	</c:if>
	<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pageNum">
		<a href='<c:url value="/list?page=${pageNum}"/>'>${pageNum}</a>
	</c:forEach>
	<c:if test="${paging.next}">
		<a href='<c:url value="/list?page=${paging.endPage+1}"/>'>다음</a>
	</c:if>
-
</body>
</html>