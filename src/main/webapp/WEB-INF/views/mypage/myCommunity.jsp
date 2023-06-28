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
    @font-face {
        font-family: 'KimjungchulGothic-Bold';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/KimjungchulGothic-Bold.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }
    th {
        border: 1px solid;
    }
    .mytitle{
        font-family: 'KimjungchulGothic-Bold';
    }
    .manage-button{
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
    .manage-button {
        background-color: #e6a756;
        margin-left: 20px;
    }

    .manage-button:hover {
        background-color: #e6a756;
    }
    .delete-button{
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
    .delete-button {
        background-color: #e6a756;
        margin-left: 20px;
    }

    .delete-button:hover {
        background-color: #e6a756;
    }
    .mytable{
        width: 800px;

    }
</style>

</head>
<body style="text-align: center">

<br>
<section class="page-section cta">
    <div class="container-box" style="margin-top: 150px; margin-left: 100px; width: 2000px">
        <div style="display:flex; justify-content:space-between; width:2000px;">
        <div style="width:40%;">
            <h1 class="mytitle"><span style="width: 200px;margin-left: 20px">내 게시물</span></h1>
        <br><br>

        <table class="mytable table table-striped" style="margin-left:10px;" width="100%">
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
            <br><br>
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
                    <br><br> <br><br>
        <button class="manage-button" type="button" onclick="deleteSeveral(0)">게시물 삭제</button>
        </div>

        <br>

        <div style="width:60%;">
        <h1 class="mytitle"><span style="width: 300px;margin-right: 300px">내 댓글</span></h1>
            <br>
        <table class="mytable table table-striped" style="margin-left:50px;"  width="100%" >
            <th><input type="checkbox" name="checkAll2" id="checkAll2"><th>내용</th><th>작성날짜</th><th>신고</th><br>
            <c:forEach var="comment" items="${commentList.list}">
                <tr>
                    <td><input type="checkbox" name="comment" id="comment" value='<c:out value="${comment.commentId}"/>'></td>
                    <td><a href= '/community/${comment.postId}'>${comment.commentContent}</a></td>
                    <td><fmt:formatDate value="${comment.commentDate}" type="date"/></td>
                    <td> ${comment.flag}회 </td>
                </tr>
            </c:forEach>
        </table>
            <br><br>
        <%-- 이전 페이지 버튼 --%>
            <div id="pageing"style="width: 900px">
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
                    <br><br> <br><br>
        <button class="delete-button" type="button" onclick="deleteSeveral(1)">댓글 삭제</button>
            </div>
        </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px;">
  <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/myCommunity.js"></script>
</body>
</html>