<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<title>마이페이지</title>
<%@ include file="../main/header.jsp" %>
<style>
    th {
        border: 1px solid;
    }
</style>

</head>
<body style="text-align: center">

<br>
<section class="page-section cta">
    <div class="container" style="margin-top: 150px">
        <div style="display:flex; justify-content:space-between; width:1200px;">
        <div style="width:49%;">
        <h1>내 게시물</h1>
        <br>
        <table style="margin-left:30px;" width="100%">
            <th><input type="checkbox" name="checkAll1" id="checkAll1"></th><th>분류</th><th>제목</th><th>작성날짜</th><th>신고</th>
               <c:forEach var="post" items="${postList.list}">
                     <tr>
                        <td><input type="checkbox" name="post" id="post" value='<c:out value="${post.postId}"/>'></td>
                        <td>${post.postTag}</td>
                        <td><a href= '/community/${post.postId}'>${post.postTitle}</a></td>
                        <td><fmt:formatDate value="${post.postDate}" type="date"/></td>
                        <td>${post.flag}회 </td>
                     </tr>
               </c:forEach>
        </table>
        <%-- 이전 페이지 버튼 --%>
                    <c:if test="${postList.navigateFirstPage > 1}">
                        <a href="?postPage=${postList.navigateFirstPage - 1}">◀</a>
                    </c:if>
                    <%-- 페이지 번호 출력 --%>
                    <c:forEach var="pageNum" begin="${postList.navigateFirstPage}" end="${postList.navigateLastPage}">
                        <c:choose>
                            <c:when test="${pageNum == postList.pageNum}">
                                <span>${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?postPage=${pageNum}">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <%-- 다음 페이지 버튼 --%>
                    <c:if test="${postList.navigateLastPage < postList.pages}">
                        <a href="?postPage=${boardList.navigateLastPage + 1}">▶</a>
                    </c:if>
                    <br><br>
        <button type="button" onclick="deleteSeveral(0)">게시물 삭제</button>
        </div>

        <br>

        <div style="width:49%;">
        <h1>내 댓글</h1>
        <br>
        <table style="margin-left:70px;"  width="100%" >
            <th><input type="checkbox" name="checkAll2" id="checkAll2"><th>내용</th><th>작성날짜</th><th>신고</th>
            <c:forEach var="comment" items="${commentList.list}">
                <tr>
                    <td><input type="checkbox" name="comment" id="comment" value='<c:out value="${comment.commentId}"/>'></td>
                    <td><a href= '/community/${comment.postId}'>${comment.commentContent}</a></td>
                    <td><fmt:formatDate value="${comment.commentDate}" type="date"/></td>
                    <td> ${comment.flag}회 </td>
                </tr>
            </c:forEach>
        </table>
        <%-- 이전 페이지 버튼 --%>
                    <c:if test="${commentList.navigateFirstPage > 1}">
                        <a href="?commentPage=${commentList.navigateFirstPage - 1}">◀</a>
                    </c:if>
                    <%-- 페이지 번호 출력 --%>
                    <c:forEach var="pageNum" begin="${commentList.navigateFirstPage}" end="${commentList.navigateLastPage}">
                        <c:choose>
                            <c:when test="${pageNum == commentList.pageNum}">
                                <span>${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?commentPage=${pageNum}">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <%-- 다음 페이지 버튼 --%>
                    <c:if test="${commentList.navigateLastPage < commentList.pages}">
                        <a href="?commentPage=${commentList.navigateLastPage + 1}">▶</a>
                    </c:if>
                    <br><br>
        <button type="button" onclick="deleteSeveral(1)">댓글 삭제</button>
        </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 200px;">
  <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/myCommunity.js"></script>
</body>
</html>