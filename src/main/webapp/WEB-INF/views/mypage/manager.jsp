<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<%@ include file="../main/header.jsp" %>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<style>

    @font-face {
        font-family: 'KimjungchulGothic-Bold';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/KimjungchulGothic-Bold.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }
    table {
        margin-left:auto;
        margin-right:auto;
    }
    th {
        border: 1px solid;
    }
    .managertitle{
        font-family: 'KimjungchulGothic-Bold';

    }
</style>
</head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/manager.js"></script>
<body style="text-align: center">
<section class="page-section cta">
<div style="margin-top: 110px">
        <br><br>
        <div style="display:flex; justify-content:space-between; width:80%;margin: auto; " class="cta">
        <div style="width:33%;">
        <h2 class="managertitle">게시물 관리</h2>
            <br><br><br><br><br>
        <table class="table table-striped">
            <th>제목</th><th>아이디</th><th>신고</th><th>삭제</th>
               <c:forEach var="post" items="${postList.list}">
                     <tr>
                        <td><a href= '/community/${post.postId}'>${post.postTitle}</a></td>
                        <td>${post.userId}</td>
                        <td>신고 ${post.flag}회 </td>
                        <td><button type='button' onclick='deleteM(0, ${post.postId}, 0)'>삭제</button></td>
                     </tr>
               </c:forEach>
        </table>
        <%-- 이전 페이지 버튼 --%>
                    <c:if test="${postList.navigateFirstPage > 1}">
                        <a href="?postPage=${postList.navigateFirstPage - 1}&commentPage=${commentList.pageNum}&userPage=${userList.pageNum}" aria-label="Previous">◀</a>
                    </c:if>
                    <%-- 페이지 번호 출력 --%>
                    <c:forEach var="pageNum" begin="${postList.navigateFirstPage}" end="${postList.navigateLastPage}">
                        <c:choose>
                            <c:when test="${pageNum == postList.pageNum}">
                                <span>${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?postPage=${pageNum}&commentPage=${commentList.pageNum}&userPage=${userList.pageNum}">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <%-- 다음 페이지 버튼 --%>
                    <c:if test="${postList.navigateLastPage < postList.pages}">
                        <a href="?postPage=${boardList.navigateLastPage + 1}&commentPage=${commentList.pageNum}&userPage=${userList.pageNum}">▶</a>
                    </c:if>
        </div>
        <div style="width:33%;">
        <h2 class="managertitle">댓글 관리</h2>
            <br><br><br><br><br>
        <table class="table table-striped">
            <th>내용</th><th>아이디</th><th>신고</th><th>삭제</th>
            <c:forEach var="comment" items="${commentList.list}">
                <tr>
                    <td><a href= '/community/${comment.postId}'>${comment.commentContent}</a></td>
                    <td>${comment.userId}</td>
                    <td> 신고 ${comment.flag}회 </td>
                    <td><button type='button' onclick='deleteM(${comment.commentId}, ${comment.postId}, 1)'>삭제</button></td>
                </tr>
            </c:forEach>
        </table>
        <%-- 이전 페이지 버튼 --%>
                    <c:if test="${commentList.navigateFirstPage > 1}">
                        <a href="?commentPage=${commentList.navigateFirstPage - 1}&userPage=${userList.pageNum}">◀</a>
                    </c:if>
                    <%-- 페이지 번호 출력 --%>
                    <c:forEach var="pageNum" begin="${commentList.navigateFirstPage}" end="${commentList.navigateLastPage}">
                        <c:choose>
                            <c:when test="${pageNum == commentList.pageNum}">
                                <span>${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="?postPage=${postList.pageNum}&commentPage=${pageNum}&userPage=${userList.pageNum}">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <%-- 다음 페이지 버튼 --%>
                    <c:if test="${commentList.navigateLastPage < commentList.pages}">
                        <a href="?postPage=${postList.pageNum}&commentPage=${commentList.navigateLastPage + 1}&userPage=${userList.pageNum}">▶</a>
                    </c:if>

        </div>
        <div style="width:33%;">
            <h2 class="managertitle"> 회원관리 </h2> <h7 class="managertitle">(3인 선택)</h7>
        <br>
        <p class="managertitle">현재 우수회원</p>
        <table id="best-user-table">
            <tbody></tbody>
        </table>
        <table class="table table-striped">
            <tr><th>아이디</th><th>포인트</th><th>우수회원 선택</th><th>우수회원 취소</th><th>회원삭제</th></tr>
            <c:forEach var="user" items="${userList.list}" varStatus="status">
                <tr>
                    <td>${user.userId}</td>
                    <td>${user.point} 점</td>
                    <td><button type="button" class="select-best" onclick="selectBest('${user.userId}', ${status.index})">우수회원 선택</button></td>
                    <td><button type="button" class="delete-best" onclick="deleteBest('${user.userId}', ${status.index})">우수회원 취소</button></td>
                    <td><button type="button" class="delete-best" onclick="deleteUserCheck('${user.userId}', 1)">회원삭제</button></td>
                </tr>
            </c:forEach>
        </table>
        <button type="button" onclick="deleteAllBest()">우수회원 초기화</button><br>
            <!-- 이전 페이지 -->
                    <c:if test="${userList.navigateFirstPage > 1}">
                        <a href="?postPage=${postList.pageNum}&commentPage=${commentList.pageNum}&userPage=${userList.navigateFirstPage - 1}">◀</a>
                    </c:if>
                    <%-- 페이지 번호 출력 --%>
                    <c:forEach var="pageNum" begin="${userList.navigateFirstPage}" end="${userList.navigateLastPage}">
                        <c:choose>
                            <c:when test="${pageNum == userList.pageNum}">
                                <span>${pageNum}</span>
                            </c:when>
                            <c:otherwise>
                               <a href="?postPage=${postList.pageNum}&commentPage=${commentList.pageNum}&userPage=${pageNum}">${pageNum}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <%-- 다음 페이지 버튼 --%>
                    <c:if test="${userList.navigateLastPage < userList.pages}">
                        <a href="?postPage=${postList.pageNum}&commentPage=${commentList.pageNum}&userPage=${userList.navigateLastPage + 1}">▶</a>
                    </c:if>
        </div>
    </div>
</div>
</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px;">
  <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

</body>
</html>