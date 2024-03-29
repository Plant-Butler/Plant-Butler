<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물일기</title>
<%@ include file="../main/header.jsp" %>
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
    div, h1, h5 {
        font-family: 'KimjungchulGothic-Bold';
    }
    a {
        text-decoration: none;
    }

    button {
        margin: auto;
        margin-top: 30px;
    }

    .card {
       height: 100%;
       box-shadow: 0 10px 11px rgba(0, 0, 0, 0.1);
    }

    .card-img-top {
       height: 300px;
       object-fit: cover;
    }
    .cta {
        background-color: white;
    }
    .diarylisttitle{
        margin-top: 15px;
    }

    .mydiarytitle{
        font-family: 'KimjungchulGothic-Bold';
        font-size: 3em;
        color: #000000;
        text-align: center;
        margin-top: 100px;
        font-weight: 700;
        font-style: normal;
    }
    .newdiary{
        display: inline-block;
        padding: 8px 16px;
        font-size: 17px;
        text-align: center;
        text-decoration: none;
        border: none;
        border-radius: 4px;
        background-color: #198754;
        color: white;
        cursor: pointer;
        margin-left: 1150px;
        margin-bottom: 5px;
    }
    .page-link{
        background-color: #4CAF50 !important;
        border-color: #4CAF50 !important;


</style>
</head>
<body>
<body style="text-align: center;"><br>

<section class="page-section cta">
    <div class="container">
        <h1 class="mydiarytitle">하루 일기</h1>
        <hr>
        <button onclick="location.href='/diaries/form'" class="newdiary">작성하기</button>
        <br>
        <br>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach var="list" items="${diaryList.list}">
                <div class="col">
                        <a href="/diaries/${list.diaryId}">
                            <div class="card">
                                <c:choose>
                                    <c:when test="${not empty list.diaryImage}">
                                        <img src="${list.diaryImage}" class="card-img-top">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/assets/img/brick-wall-painted-in-white.jpg" class="card-img-top">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-body">
                                    <h5 class="card-title">${list.diaryTitle}</h5>
                                </div>
                                <div class="card-footer">
                                    <small class="text-muted"><fmt:formatDate value="${list.diaryDate}" type="date"/></small>
                                </div>
                            </div>
                        </a>
                </div>
            </c:forEach>
        </div>
    </div>
    <br>
    <br>
    <br><br>

        <!-- 이전 -->
        <ul class="pagination d-flex justify-content-center">
            <c:if test="${diaryList.navigateFirstPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="/diaries?pageNum=${diaryList.navigateFirstPage - 1}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                        <span class="sr-only"></span>
                    </a>
                </li>
            </c:if>

                    <c:forEach var="pageNum" begin="${diaryList.navigateFirstPage}" end="${diaryList.navigateLastPage}">
                        <c:choose>
                            <c:when test="${pageNum == diaryList.pageNum}">
                                <li class="page-item active"><span class="page-link">${pageNum}</span></li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item"><a class="page-link" href="/diaries?pageNum=${pageNum}">${pageNum}</a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

            <!-- 다음 -->
            <c:if test="${diaryList.navigateLastPage < diaryList.pages}">
                <a class="page-link" href="/diaries?pageNum=${diaryList.navigateLastPage + 1}" aria-label="Next">
                    <span aria-hidden="true">&raquo;</span>
                    <span class="sr-only"></span>
                    </a>
            </c:if>
        </ul>

        <br>

    </div>
</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px;">
    <div class="container"><p class="m-0 small">brick-wall-painted-in-white 작가 kues1 출처 Freepik
        <br> Copyright &copy; Plantery 2023</p></div>
</footer>
</body>
</html>