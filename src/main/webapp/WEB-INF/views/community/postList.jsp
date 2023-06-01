<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../main/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 목록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
</head>
<body>
<style>
    .buttonlist {
        margin-left: 90px;
    }

    .newpost{
        margin-left: 1200px;
    }
    .btn {
        display: inline-block;
        padding: 8px 16px;
        font-size: 14px;
        text-align: center;
        text-decoration: none;
        border: none;
        border-radius: 4px;
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
        margin-right: 10px;
        margin-bottom: 10px;
    }

    .btn-primary {
        background-color: #4CAF50;
    }

    .btn-primary:hover {
        background-color: #45a049;
    }
    .custom-table {
        width: 90%;
    }
    .btn-container {
        margin-right: 10px;
    }
    .posttitle{
        color: #000000;
        text-decoration: none;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
    }
    .posth1{
        font-size: 3em;
        color: #000000;
        text-align: center;
    }

    .custom-table th.col-1,
    .custom-table td.col-1 {
        width: 10%;
    }

</style>
<div style="margin-top: 300px">

    <!-- 검색 -->

    <!-- 리스트 테이블 -->
    <h1 class="posth1" style="font-family: 'Hahmlet', serif;">커뮤니티</h1>
    <br>
    <div class="buttonlist">
        <a class="btn btn-primary" href="/community?tag=수다">수다</a>
        <a class="btn btn-primary" href="/community?tag=정보 공유">정보 공유</a>
        <a class="btn btn-primary" href="/community?tag=식물 자랑">식물 자랑</a>
        <a class="btn btn-primary newpost" href="/community/form">새 게시물 등록</a>
    </div>

    <table class="table table-hover custom-table">
        <thead>
        <tr>
            <th scope="col" class="col-1">태그</th>
            <th scope="col" class="col-4">제목</th>
            <th scope="col" class="col-2">작성자</th>
            <th scope="col" class="col-1">조회수</th>
            <th scope="col" class="col-2">작성일자</th>
            <th scope="col" class="col-2">댓글수</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="post" items="${posts.list}">
            <tr>
                <td>${post.postTag}</td>
                <td><a href="/community/${post.postId}" class = "posttitle">${post.postTitle}</a></td>
                <td>${post.userId}</td>
                <td>${post.readCount}</td>
                <td><fmt:formatDate value="${post.postDate}" type="date"/></td>
                <td>${post.commentCount}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="d-flex justify-content-center my-3">
        <form action="/community" method="get" class="d-flex">
            <select name="searchField" id="searchField">
                <option value="post_title">제목</option>
                <option value="user_id">작성자</option>
            </select>
            <input type="text" id="searchText" name="keyword">
            <button class="btn btn-outline-success" type="submit">검색 </button> <p style="text-align:right;">
        </form>
    </div>






    <!-- 페이징 -->
    <div class="d-flex justify-content-center my-3">
        <nav aria-label="Page navigation">
            <ul class="pagination">

                <!-- 이전 페이지 그룹 버튼 -->
                <c:if test="${posts.navigateFirstPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="community?pageNum=${posts.navigateFirstPage - 1}&searchField=${param.searchField}&searchText=${param.searchText}&tag=${param.tag}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>

                <c:forEach var="pageNum" begin="${posts.navigateFirstPage}" end="${posts.navigateLastPage}">
                    <c:choose>
                        <c:when test="${pageNum == posts.pageNum}">
                            <li class="page-item active">
                                <span class="page-link">${pageNum}</span>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="page-item">
                                <a class="page-link" href="community?pageNum=${pageNum}&searchField=${param.searchField}&searchText=${param.searchText}&tag=${param.tag}">${pageNum}</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- 다음 페이지 그룹 버튼 -->
                <c:if test="${posts.navigateLastPage < posts.pages}">
                    <li class="page-item">
                        <a class="page-link" href="community?pageNum=${posts.navigateLastPage + 1}&searchField=${param.searchField}&searchText=${param.searchText}&tag=${param.tag}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>
</body>
</html>