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
</head>
<body>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<style>
    @font-face {
        font-family: 'KimjungchulGothic-Bold';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/KimjungchulGothic-Bold.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }
  .buttonlist {
      margin-left: 90px;
  }

  .newpost{
       margin-left: 1250px;
  }
  .btn {
    font-family: 'KimjungchulGothic-Bold';
    display: inline-block;
    padding: 8px 16px;
    font-size: 14px;
    text-align: center;
    text-decoration: none;
    border: none;
    border-radius: 4px;
    background-color: #198754;
    color: white;
    cursor: pointer;
    margin-right: 10px;
    margin-bottom: 10px;
  }

  .btn-primary {
    background-color: #4198754;
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
   }
 .posth1{
    font-family: 'KimjungchulGothic-Bold' !important;
    font-size: 3em;
    color: #000000;
    text-align: center;
    font-weight: 700;
    font-style: normal;
 }

    .custom-table th.col-1,
    .custom-table td.col-1 {
        width: 10%;
    }

    .active>.page-link, .page-link.active {
        z-index: 3;
        color: white;
        background-color: #4CAF50;
        border-color: #4CAF50;
    }
    .page-link {
        position: relative;
        display: block;
        padding: var(--bs-pagination-padding-y) var(--bs-pagination-padding-x);
        font-size: var(--bs-pagination-font-size);
        color: black;
        text-decoration: none;
        background-color: var(--bs-pagination-bg);
        border: var(--bs-pagination-border-width) solid var(--bs-pagination-border-color);
        transition: #4CAF50 .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }
    select option:hover {
      background-color: #4CAF50;
    }


</style>
<div style="margin-top: 300px">

    <!-- 검색 -->

    <!-- 리스트 테이블 -->
    <h1 class="posth1">커뮤니티</h1>
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
        <div class="form-group mr-2">
            <select name="searchField" id="searchField" class="form-control">
                <option value="post_title">제목</option>
                <option value="user_id">작성자</option>
            </select>
        </div>
        <div class="form-group mr-2">
            <input type="text" id="searchText" name="keyword" class="form-control">
        </div>
        <button class="btn btn-outline-success" type="submit">검색</button>
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
<footer class="footer text-faded text-center py-5"
        style="background-image: url('/images/footer.jpg'); height: 150px; flex-shrink: 0;">
    <div class="container">
        <p class="m-0 small">© Plantery 2023</p>
    </div>
</footer>
</body>

</html>