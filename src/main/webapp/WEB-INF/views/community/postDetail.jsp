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
<script>
    var csrfToken = "${_csrf.token}";
    var csrfHeader="${_csrf.headerName}";
</script>
</head>
<body style="margin-top: 300px">
<body style="text-align: center">
<style>
.commentitle{
    font-size: 25px;
    font-weight: bold;
    font-weight: bold;
}
.inputsize {
  width: 1000px;
  height: 35px;
  border-radius: 8px;
  border: none;
  border-bottom: 2px solid #D3D3D3;
  outline: none;
  margin-right: 20px;
}
.comment-form {
  margin-bottom: 10px;
}

.heart{
    margin-left: 400px;
}
.report {
  background-color: #4CAF50;
  color: #ffffff;
  border: none;
  padding: 5px 20px;
  font-size: 16px;
  cursor: pointer;
  border-radius: 4px;
}

.report:hover {
  background-color: #8BC34A;
}
.post-report{
    background-color: #4CAF50;
    color: #ffffff;
    border: none;
    padding: 5px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 4px;
    margin-left: 20px;
}
.post-report:hover{
    background-color: #8BC34A;
}
.comment-edit{
    border: none;
}
.new-comment{
    color: #000000;
    border: none;
    padding: 5px 20px;
    font-size: 16px;
    cursor: pointer;
    border-radius: 4px;
    width: 200px;
}
.myplant-container{
  width: 1000px; /* Adjust the width as per your requirement */
  margin-left: 450px;
  margin-right: 450px;
  background: #e9f8f1;
  border-radius: 10px;
  padding: 20px;
}
.overall{
    font-size: 15x;
}
.comment-width{
    width: 1000px;
}
.commentlist-width{
    width: 1000px;
}
.nickname {
   padding-right: 10px;
   color: green;
}

.report-container{
    margin-left: 700px;
}
.postupdate{
  background-color: #4CAF50;
  color: #ffffff;
  border: none;
  padding: 5px 20px;
  font-size: 16px;
  cursor: pointer;
  border-radius: 4px;
}
.postdelete{
  background-color: #4CAF50;
  color: #ffffff;
  border: none;
  padding: 5px 20px;
  font-size: 16px;
  cursor: pointer;
  border-radius: 4px;
}
.contentimg{
    width: 50%;
}
.postcontent{
    max-width: 800px; /* 원하는 너비로 조정 */
    margin: 0 auto; /* 가운데 정렬을 위한 마진 설정 */
    word-wrap: break-word;
}

</style>

<div class="about-section" style="margin-top: 300px">
<table style="margin-left:auto;margin-right:auto;" width="1500" length="150">
    <tr class="overall">
        <td>[분류] ${post.postTag}</td>
        <td>[제목] ${post.postTitle}</td>
        <td>[닉네임] ${post.nickname}</td>
        <td>[조회수] ${post.readCount}</td>
        <td>[댓글] ${commentCount}</td>
        <td>[신고] ${post.flag}</td>
        <td>[날짜] <fmt:formatDate value="${post.postDate}" type="date"/></td>
    </tr>
</table>
<div style="display: flex; justify-content: center;">
    <hr style="width: 70%;">
</div>
<div class= "myplant-container">
<c:if test="${not empty myPlantList}">
    <h2 class="commentitle">${post.nickname}님의 반려식물</h2> <br>
    <table style="margin-left:auto;margin-right:auto;" width="1000" length="100">
        <c:forEach var="myPlant" items="${myPlantList}">
            <tr>
                <c:if test="${not empty myPlant.myplantImage}">
                    <td class="tdimage">
                        <div class="box" style="background: #BDBDBD;">
                            <a href="/uploads/${myPlant.myplantImage}">
                                <img class="plantImg" src="/uploads/${myPlant.myplantImage}">
                            </a>
                        </div>
                    </td>
                </c:if>
                <td>${myPlant.distbNm}</td>
                <td>${myPlant.myplantNick}</td>
                <td>
                    <fmt:formatDate value="${myPlant.firstDate}" type="date"/>
                </td>
            </tr>
            <tr>
                <td colspan="4"><br></td>
            </tr>
        </c:forEach>
    </table>
</c:if>
<c:if test="${empty myPlantList}">
    <h2 class="commentitle">${post.nickname}님의 반려식물</h2> <br>
    <td>선택된 반려식물이 없습니다</td>
</c:if>
</div>
<br>
<br>
<br>
<c:if test="${not empty post.postImage}">
    <td>
        <c:forEach var="image" items="${fn:split(post.postImage, ',')}">
            <p><a href="/uploads/${image}"><img class="contentimg"  src="/uploads/${image}"></a></p>
            <br>
        </c:forEach>
    </td>
</c:if>
<br>
<div class="postcontent">
${post.postContent}
</div>
<br>
<br>
<br>
<c:if test="${not empty post.postFile}">
[첨부파일]
    <a href="./download.do?fileName=${URLEncoder.encode(post.postFile, 'UTF-8')}">${post.postFile}</a>
</c:if>
<br>
<br>
<br>
<div class="heart">
    <c:if test="${not empty user.userId}">
      <div style="overflow: hidden;">
        <div id="heart" style="float: left;">
            <button id="heartBtn" onclick="heart(${post.postId}, '${user.userId}')">
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
        <div class="report-container">
        <button class="post-report" type="button" onclick="declare(0, ${post.postId}, 0)">신고</button>
                <c:if test="${post.userId eq user.userId}">
                    <button class="postupdate" type="button" onclick="location.href='/community/form/${post.postId}'">수정</button>
                    <button class="postdelete" type="button" onclick="del(0, ${post.postId}, 0)">삭제</button>
                </c:if>
        </div>
       </div>
    </c:if>
</div>
<div style="display: flex; justify-content: center;">
    <hr style="width: 70%;">
</div><br>
    <h2 class="commentitle">댓글</h2>
<table style="margin-left:auto;margin-right:auto;width:1500px;height:100px;">
    <!-- 댓글 작성 -->
    <c:if test="${not empty user.userId}">
        <form action="./comment" method="post" modelAttribute="commentVo" class="comment-form">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <tr class="comment-width">
                <td class="nickname">${user.nickname}</td>
                <td><input class="inputsize" type="text" name="commentContent" id="inputComment" placeholder="댓글 입력"></td>
                <td><input class="new-comment" type="submit" value="작성"></td>
                <td>
                    <input type="hidden" name="userId" value="${user.userId}">
                    <input type="hidden" name="postId" value="${post.postId}">
                </td>
            </tr>
        </form>
    </c:if>

    <!-- 빈칸 -->
    <tr>
        <td colspan="4">&nbsp;</td>
    </tr>

    <!-- 댓글 목록 -->
    <c:forEach var="comment" items="${commentList.list}">
        <tr>
            <td>${comment.nickname}</td>
            <td class="commentlist-width"><span id="commentContent_${comment.commentId}">${comment.commentContent}</span></td>
            <td>신고 ${comment.flag} <fmt:formatDate value="${comment.commentDate}" type="date" />
                <c:if test="${not empty user.userId}">
                    <button class="report" type="button" onclick="declare(${comment.commentId}, ${post.postId}, 1)">신고</button></td>
                <c:if test="${comment.userId eq user.userId}">
                    <br><br>
                    <td>
                        <button class="comment-edit" type="button" onclick="updateBox('${comment.commentContent}', ${comment.commentId}, ${post.postId})">수정</button>
                        <button class="comment-edit" type="button" onclick="del(${comment.commentId}, ${post.postId}, 1)">삭제</button>
                    </td>
                </c:if>
            </tr>
        </c:if>
    </c:forEach>
</table>
</div>
<br><br>
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
</div><br><br><br>
              <br>
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 200px; flex-shrink: 0;">
    <div class="container">
        <p class="m-0 small">© Plantery 2023</p>
    </div>
</footer>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/postDetail.js"></script>

</body>
</html>