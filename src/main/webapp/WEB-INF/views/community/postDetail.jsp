<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.net.URLEncoder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<%@ include file="../main/header.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
        .box {
            width: 100px;
            height: 100px;
            border-radius: 70%;
            overflow: hidden;
        }
        .plantImg {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        #inputComment {
              width:1000px;
        }
</style>
</head>
<body>
<body style="text-align: center">
<br>
<table style="margin-left:auto;margin-right:auto;" width="1500" length="150">
    <tr>
        <td>[분류] ${post.postTag}</td>
        <td>[제목] ${post.postTitle}</td>
        <td>[닉네임] ${post.nickname}</td>
        <td>[조회수] ${post.readCount}</td>
        <td>[댓글] ${commentCount}</td>
        <td>[신고] ${post.flag}</td>
        <td>[날짜] <fmt:formatDate value="${post.postDate}" type="date"/></td>
    </tr>
</table>
<hr>
<c:if test="${not empty myPlantList}">
    [${post.nickname} 님의 반려식물] <br>
    <table style="margin-left:auto;margin-right:auto;" width="700" length="100">
        <c:forEach var="myPlant" items="${myPlantList}">
            <tr>
                <c:if test="${not empty myPlant.myplantImage}">
                    <td><div class="box" style="background: #BDBDBD;">
                        <a href="/uploads/${myPlant.myplantImage}"><img class="plantImg" src="/uploads/${myPlant.myplantImage}"></a>
                    </div></td>
                </c:if>
                <td>${myPlant.distbNm}</td>
                <td>${myPlant.myplantNick}</td>
                <td><fmt:formatDate value="${myPlant.firstDate}" type="date"/></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<br>
<br>
${post.postContent}
<br>

<c:if test="${not empty post.postImage}">
    <td>
        <c:forEach var="image" items="${fn:split(post.postImage, ',')}">
            <p><a href="/uploads/${image}"><img src="/uploads/${image}"></a></p>
        </c:forEach>

    </td>
</c:if>
<br>
<c:if test="${not empty post.postFile}">
[첨부파일]
    <a href="./download.do?fileName=${URLEncoder.encode(post.postFile, 'UTF-8')}">${post.postFile}</a>
</c:if>


<br>
<c:if test="${not empty sessionScope.user.userId}">
  <div style="overflow: hidden;">
    <div id="heart" style="float: left;">
        <button id="heartBtn" onclick="heart(${post.postId}, '${sessionScope.user.userId}')">
          <c:choose>
            <c:when test="${alreadyHeart == 1}">
              <i class="fa fa-heart" style="color: red;"></i>
            </c:when>
            <c:otherwise>
              <i class="fa fa-heart-o" style="color: red;"></i>
            </c:otherwise>
          </c:choose>
        </button>
        ${countHeart}
    </div>
    <button type="button" onclick="declare(0, ${post.postId}, 0)" style="float: right;">신고하기</button>
    <c:if test="${post.userId eq sessionScope.user.userId}">
        <button type="button" onclick="location.href='/community/form/${post.postId}'" style="float: right;">수정</button>
        <button type="button" onclick="del(0, ${post.postId}, 0)" style="float: right;">삭제</button>
    </c:if>
   </div>
</c:if>

<hr>
댓글

<table style="margin-left:auto;margin-right:auto;" width="1500" length="100">
    <!-- 댓글 작성 -->
        <c:if test="${not empty sessionScope.user.userId}">
            <form action="./comment" method="post" modelAttribute="commentVo">
                <tr>
                    <td>${sessionScope.user.nickname}</td>
                    <td><input type="text" name="commentContent" id="inputComment"></td>
                    <td><input type="submit" value="작성" style="width:200px"></td>
                    <td><input type="hidden" name="userId" value="${sessionScope.user.userId}">
                        <input type="hidden" name="postId" value="${post.postId}"></td>
                </tr>
            </form>
         </c:if>

    <!-- 댓글 목록 -->
        <c:forEach var="comment" items="${commentList.list}">
            <tr>
                <td>${comment.nickname}</td>
                <td><span id="commentContent_${comment.commentId}">${comment.commentContent}</span></td>
                <td>신고 ${comment.flag} <fmt:formatDate value="${comment.commentDate}" type="date"/>
                <c:if test="${not empty sessionScope.user.userId}">
                    <button type="button" onclick="declare(${comment.commentId}, ${post.postId}, 1)">신고하기</button></td>
                    <c:if test="${comment.userId eq sessionScope.user.userId}">
                        <td><button type="button" onclick="updateBox('${comment.commentContent}', ${comment.commentId}, ${post.postId})">수정</button>
                        <button type="button" onclick="del(${comment.commentId}, ${post.postId}, 1)">삭제</button></td>
                    </c:if>
                </c:if>
            </tr>
        </c:forEach>
</table>

<div>
    <!-- 이전 페이지 -->
    <c:if test="${commentList.navigateFirstPage > 1}">
        <a href="/community/${post.postId}?pageNum=${commentList.navigateFirstPage - 1}">◀</a>
    </c:if>

    <c:forEach var="pageNum" begin="${commentList.navigateFirstPage}" end="${commentList.navigateLastPage}">
        <c:choose>
            <c:when test="${pageNum == commentList.pageNum}">
                <span>${pageNum}</span>
            </c:when>
            <c:otherwise>
                <a href="/community/${post.postId}?pageNum=${pageNum}">${pageNum}</a>
            </c:otherwise>
        </c:choose>
    </c:forEach>

    <!-- 다음 페이지 -->
    <c:if test="${commentList.navigateLastPage < commentList.pages}">
        <a href="/community/${post.postId}?pageNum=${commentList.navigateLastPage + 1}">▶</a>
    </c:if>
</div>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/postDetail.js"></script>

</body>
</html>