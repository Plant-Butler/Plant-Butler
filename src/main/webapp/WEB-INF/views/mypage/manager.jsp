<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
<%@ include file="../main/header.jsp" %>
</head>
<body>
<h1>게시물 관리</h1>
<table>
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

<h1>댓글 관리</h1>
<table>
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


<div id="user-list">
<h1> 회원관리 </h1> (3인 선택)
<table>
    <tr><th>아이디</th><th>포인트</th><th>우수회원 선택</th><th>우수회원 취소</th><th>회원삭제</th></tr>
    <c:forEach var="user" items="${userList.list}" varStatus="status">
        <tr>
            <td><a href= "/mypage">${user.userId}</a></td>
            <td>${user.point} 점</td>
            <td><button type="button" class="select-best" onclick="selectBest('${user.userId}', ${status.index})">우수회원 선택</button></td>
            <td><button type="button" class="delete-best" onclick="deleteBest('${user.userId}', ${status.index})">우수회원 취소</button></td>
            <td><button type="button" class="delete-best" onclick="deleteUserCheck('${user.userId}')">회원삭제</button></td>
        </tr>
    </c:forEach>
</table>
<button type="button" onclick="deleteAllBest()">우수회원 초기화</button><br>
    <!-- 이전 페이지 -->
            <c:if test="${userList.navigateFirstPage > 1}">
                <a href="?userPage=${userList.navigateFirstPage - 1}">◀</a>
            </c:if>
            <%-- 페이지 번호 출력 --%>
            <c:forEach var="pageNum" begin="${userList.navigateFirstPage}" end="${userList.navigateLastPage}">
                <c:choose>
                    <c:when test="${pageNum == userList.pageNum}">
                        <span>${pageNum}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="?userPage=${pageNum}">${pageNum}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <%-- 다음 페이지 버튼 --%>
            <c:if test="${userList.navigateLastPage < userList.pages}">
                <a href="?userPage=${userList.navigateLastPage + 1}">▶</a>
            </c:if>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>

    // 우수회원 선택
    function selectBest(userId, index) {
        $.ajax({
            url: "/manager/best-user/" + userId,
            type: "POST",
            data: {
                userId : userId
            },
            success: function(response) {
                console.log(userId);
                alert('추가되었습니다');
                $(".select-best").eq(index).text("우수회원 선택완료");
            },
            error: function(request, status, error) {
                alert('이미 추가된 회원입니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

        // 우수회원 취소
        function deleteBest(userId, index) {
            $.ajax({
                url: "/manager/best-user/" + userId,
                type: "DELETE",
                data: {
                    userId : userId
                },
                success: function(response) {
                    console.log(userId);
                    alert('취소되었습니다');
                    $(".select-best").eq(index).text("우수회원 선택");
                },
                error: function(request, status, error) {
                    alert('이미 취소된 회원입니다.');
                        console.log("code: " + request.status)
                        console.log("message: " + request.responseText)
                        console.log("error: " + error);
                }
            });
        }

        // 우수회원 초기화
        function deleteAllBest() {
            $.ajax({
               url: "/manager/best-user/all",
               type: "DELETE",
               success: function(response) {
                   alert('초기화되었습니다');
                   $(".select-best").text("우수회원 선택");
               },
               error: function(request, status, error) {
                   alert('오류가 발생했습니다.');
                   console.log("code: " + request.status)
                   console.log("message: " + request.responseText)
                   console.log("error: " + error);
               }
            });
        }

        // 회원 삭제 확인/취소 창
        function deleteUserCheck(userId) {
         if (confirm('강제로 탈퇴처리 하시겠습니까?') == true){    //확인
             deleteUser(userId);
         } else {
             return false;
         }
        }

        // 회원 삭제
        function deleteUser(userId) {
            $.ajax({
               url: "/manager/" + userId,
               type: "DELETE",
               success: function(response) {
                   alert('탈퇴처리 되었습니다');
                   window.location.href = "/manager";
               },
               error: function(request, status, error) {
                   alert('오류가 발생했습니다.');
                   console.log("code: " + request.status)
                   console.log("message: " + request.responseText)
                   console.log("error: " + error);
               }
            });
        }

    // 게시물 or 댓글 삭제
    function deleteM(commentId, postId, num) {
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
            type: "DELETE",
            data: data,
            success: function(response) {
                alert('삭제되었습니다.');
                window.location.href = "/manager";
            },
            error: function(request, status, error) {
                alert('삭제 중 오류가 발생했습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }
</script>
</body>
</html>