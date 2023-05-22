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
</head>
<body>
<body style="text-align: center"><br>

<section class="page-section cta">
    <div class="container">
        <table>
            <tr>
                <th>제목</th>
                <th>날짜</th>
            </tr>
            <c:forEach var="list" items="${diaryList.list}">
                <tr>
                    <td><a href="/diaries/${list.diaryId}">${list.diaryTitle}</a></td>
                    <td><fmt:formatDate value="${list.diaryDate}" type="date"/></td>
                </tr>
            </c:forEach>
        </table>

        <!-- 이전 -->
        <c:if test="${diaryList.navigateFirstPage > 1}">
                <a href="/diaries?pageNum=${diaryList.navigateFirstPage - 1}">◀</a>
            </c:if>

            <c:forEach var="pageNum" begin="${diaryList.navigateFirstPage}" end="${diaryList.navigateLastPage}">
                <c:choose>
                    <c:when test="${pageNum == diaryList.pageNum}">
                        <span>${pageNum}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/diaries?pageNum=${pageNum}">${pageNum}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

        <!-- 다음 -->
        <c:if test="${diaryList.navigateLastPage < diaryList.pages}">
            <a href="/diaries?pageNum=${diaryList.navigateLastPage + 1}">▶</a>
        </c:if>
    </div>
</section>

</body>
</html>