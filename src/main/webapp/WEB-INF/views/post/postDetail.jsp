<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.net.URLEncoder"%>
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
<c:if test="${not empty sessionScope.user.userId}">
    <button type="button" onclick="declare(0, ${post.postId}, 0)">신고하기</button>
    <c:if test="${post.userId eq sessionScope.user.userId}">
        <button type="button" onclick="location.href='/community/form/${post.postId}'">수정</button>
        <button type="button" onclick="deletePost(${post.postId})">삭제</button>
    </c:if>
</c:if>

<hr>
댓글

<table width="800">
    <!-- 댓글 작성 -->
        <c:if test="${not empty sessionScope.user.userId}">
            <form action="./comment" method="post" modelAttribute="commentVo">
                <tr>
                    <td><input type="text" name="nickname" value="${sessionScope.user.nickname}" readonly="readonly"></td>
                    <td><input type="text" name="commentContent"></td>
                    <td><input type="hidden" name="userId" value="${sessionScope.user.userId}"></td>
                    <td><input type="hidden" name="postId" value="${post.postId}"</td>
                        <td><input type="submit" value="작성"></td>
                    </form>
                </tr>
            </form>
         </c:if>
    <!-- 댓글 목록 -->
        <c:forEach var="comment" items="${commentList}">
            <tr>
                <td>${comment.nickname}</td>
                <td><span id="commentContent_${comment.commentId}">${comment.commentContent}</span></td>
                <td>신고 ${comment.flag}</td>
                <td><fmt:formatDate value="${comment.commentDate}" type="date"/></td>
                <c:if test="${not empty sessionScope.user.userId}">
                    <td><button type="button" onclick="declare(${comment.commentId}, ${post.postId}, 1)">신고하기</button></td>
                    <c:if test="${comment.userId eq sessionScope.user.userId}">
                        <td><button type="button" onclick="updateBox(${comment.commentContent}, ${comment.commentId}, ${post.postId})">수정</button></td>
                        <td><button type="button" onclick="deleteComm(${comment.commentId}, ${post.postId})">삭제</button></td>
                    </c:if>
                </c:if>
            </tr>
        </c:forEach>
</table>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>

    // 댓글 수정창 열기
    function updateBox(commentContent, commentId, postId) {
          let span = document.getElementById("commentContent_" + commentId);

          let input = document.createElement("input");
          input.type = "text";
          input.name = "updatedComment";
          input.value = commentContent;

          //let updatedComment = input.value;
          let button = document.createElement("button");
          button.type = "button";
          button.onclick = function() {
            updateComment(input.value, commentId, postId);
          };
          button.innerHTML = "수정완료";

          span.innerHTML = "";
          span.appendChild(input);
          span.appendChild(button);
    }

    // 댓글 수정
    function updateComment(updatedComment, commentId, postId) {
        $.ajax({
            url: "/community/comment/" + commentId,
            type: "PUT",
            data: {
                commentContent : updatedComment,
                commentId : commentId
            },
            success: function(response) {
                window.location.href = "/community/" + postId;
            },
            error: function(request, status, error) {
                alert('댓글을 수정할 수 없습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

    // 게시물 삭제
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
            error: function(request, status, error) {
                alert('게시물을 삭제할 수 없습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

    // 댓글 삭제
    function deleteComm(commentId, postId) {
        $.ajax({
            url: "/community/comment/" + commentId,
            type: "DELETE",
            data: {
                commentId : commentId
            },
            success: function(response) {
                alert('삭제되었습니다.');
                window.location.href = "/community/" + postId;
            },
            error: function(request, status, error) {
                alert('댓글을 삭제할 수 없습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

    // 게시물 & 댓글 신고
    function declare(commentId, postId, num) {
        let url = "";
        let data = {};
        if(num == 0) {
            url = "/community/" + postId;
            data.postId = postId;
        } else {
            url =  "/community/comment/" + commentId;
            data.commentId = commentId;
        }

        $.ajax({
            url:  url,
            type: "PATCH",
            data: data,
            success: function(response) {
                alert('신고되었습니다.');
                window.location.href = "/community/" + postId;
            },
            error: function(request, status, error) {
                alert('신고 중 오류가 발생했습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

    // 댓글 신고
    function declareComment(commentId, postId) {
        $.ajax({
            url: "/community/comment/" + commentId,
            type: "PATCH",
            data: {
                commentId : commentId
            },
            success: function(response) {
                alert('신고되었습니다.');
                window.location.href = "/community/" + postId;
            },
            error: function(request, status, error) {
                alert('신고 중 오류가 발생했습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }
</script>

</body>
</html>