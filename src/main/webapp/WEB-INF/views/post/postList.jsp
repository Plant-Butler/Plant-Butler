<%--
  Created by IntelliJ IDEA.
  User: dbsdu
  Date: 2023-04-29
  Time: 오전 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 목록</title>
</head>
<body>
<%@ include file="../main/header.jsp" %>

<!-- 검색 -->

<!-- 리스트 테이블 -->
<table style="border-spacing: 40px;">
    <thead>
    <tr>
        <th scope="col">태그</th>
        <th scope="col">제목</th>
        <th scope="col">작성자</th>
        <th scope="col">조회수</th>
        <th scope="col">작성일자</th>
        <th scope="col">댓글수</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="post" items="${posts.list}">
        <tr>
            <td>${post.postTag}</td>
            <td><a href="/community/${post.postId}">${post.postTitle}</a></td>
            <td>${post.userId}</td>
            <td>${post.readCount}</td>
            <td><fmt:formatDate value="${post.postDate}" type="date"/></td>
            <td>${post.commentCount}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<form action="/community" method="get">
    <div>
        <select name="searchField" id="searchField">
            <option value="post_title">제목</option>
            <option value="user_id">작성자</option>
        </select>
        <input type="text" id="searchText" name="keyword">
        <button type="submit">검색 </button> <p style="text-align:right;"><div class=submit_box><a class = "submit" href="./community/form">새 게시물 등록</a></div><p>
    </div>
</form>

<!-- 페이징 -->
<div>
    <!-- 이전 페이지 그룹 버튼 -->
    <c:if test="${posts.navigateFirstPage > 1}">
        <a href="community?pageNum=${posts.navigateFirstPage - 1}&searchField=${param.searchField}&searchText=${param.searchText}">◀</a>
    </c:if>

    <c:forEach var="pageNum" begin="${posts.navigateFirstPage}" end="${posts.navigateLastPage}">
        <c:choose>
            <c:when test="${pageNum == posts.pageNum}">
                <span>${pageNum}</span>
            </c:when>
            <c:otherwise>
                <a href="community?pageNum=${pageNum}&searchField=${param.searchField}&searchText=${param.searchText}">${pageNum}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 페이지 그룹 버튼 -->
    <c:if test="${posts.navigateLastPage < posts.pages}">
        <a href="community?pageNum=${posts.navigateLastPage + 1}&searchField=${param.searchField}&searchText=${param.searchText}">▶</a>
    </c:if>
</div>

</body>
</html>