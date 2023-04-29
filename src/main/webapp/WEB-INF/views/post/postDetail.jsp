<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.plant.vo.UserVo"%>
<%@page import="com.plant.vo.PostVo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<%@ include file="../main/header.jsp" %>
</head>
<body>

[제목] ${post.postTitle}  [닉네임] ${post.nickname}  [조회수] ${post.readCount} [댓글] [신고] ${post.flag} [날짜] <fmt:formatDate value="${post.postDate}" type="date"/>
<hr>
[분류] ${post.postTag}
<br><br>
${post.postContent}

<c:if test="${not empty post.postImage}">
이미지
	<img src="/images/${post.postImage}" />
</c:if>

<c:if test="${not empty post.postFile}">
[첨부파일]
     <a href='./download.do?fileName=<%=URLEncoder.encode("${post.postFile}", "UTF-8")%>'>${post.postFile}</a>
</c:if>


<br>
<c:if test="${post.userId eq sessionScope.user.userId}">
    <button type="button" onclick="location.href='/community/form/${post.postId}'">수정</button>
    <button type="button" onclick="deletePost(${post.postId})">삭제</button>
</c:if>


<hr>
댓글


<table width="800">
        <!-- 댓글 작성 -->
        <tr>
            <td><input type="text" name="nickname" value="${sessionScope.user.nickname}" readonly="readonly"></td>
            <td><input type="text" name="commentContent"></td>
            <td></td><td></td>
            <form action="./comment" method="post">
                <td><input type="submit" value="작성"></td>
            </form>
        </tr>
    <!-- 댓글 목록 -->
    <c:forEach var="comment" items="${commentList}">
        <tr>
            <td>${comment.nickname}</td>
            <td>${comment.commentContent}</td>
            <td>신고 ${comment.flag}</td>
            <td><fmt:formatDate value="${comment.commentDate}" type="date"/></td>
            <td><button type="button" onclick="">신고하기</button></td>
            <c:if test="${comment.userId eq sessionScope.user.userId}">
                <button type="button" onclick="">수정</button>
                <button type="button" onclick="deleteComm(${comment.commentId})">삭제</button>
            </c:if>
        </tr>
    </c:forEach>
</table>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
    function deletePost(postId) {
        $.ajax({
            url: "/community/" + postId,
            type: "DELETE",
            data: {
                postId : postId
            },
            success: function(response) {
                alert('삭제되었습니다.');
            },
            error: function(xhr, status, error) {
                alert('게시물을 삭제할 수 없습니다.');
            }
        });
    }
</script>

</body>
</html>