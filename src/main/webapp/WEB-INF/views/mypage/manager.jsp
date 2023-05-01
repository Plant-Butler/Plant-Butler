<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자페이지</title>
</head>
<body>
<h1>게시물 관리</h1>
<table>
      <div id="post-list"></div>
</table>


<div id="user-list">
<h1> 회원관리 </h1> (3인 선택)
<table>
    <tr><th>아이디</th><th>포인트</th><th>우수회원 선택</th><th>회원삭제</th></tr>
    <c:forEach var="user" items="${userList}" varStatus="status">
        <tr>
            <td><a href= "/mypage">${user.userId}</a></td>
            <td>${user.point} 점</td>
            <td><button type="button" class="select-best" onclick="selectBest('${user.userId}', ${status.index})">우수회원 선택</button></td>
            <td><button type="button" class="delete-best" onclick="deleteBest('${user.userId}', ${status.index})">우수회원 취소</button></td>
        </tr>
    </c:forEach>
</table>
<button type="button" onclick="deleteAllBest()">우수회원 초기화</button>
<!-- paging -->
-	<c:if test="${paging.prev}">
		<a href='<c:url value="./list?page=${paging.startPage-1}"/>'>이전</a>
	</c:if>
	<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pageNum">
		<a href='<c:url value="/list?page=${pageNum}"/>'>${pageNum}</a>
	</c:forEach>
	<c:if test="${paging.next}">
		<a href='<c:url value="/list?page=${paging.endPage+1}"/>'>다음</a>
	</c:if>
</div>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
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
            error: function(xhr, status, error) {
                alert('이미 추가된 회원입니다.');
            }
        });
    }

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
                error: function(xhr, status, error) {
                    alert('이미 취소된 회원입니다.');
                }
            });
        }

            function deleteAllBest() {
                $.ajax({
                    url: "/manager/best-user/all",
                    type: "DELETE",
                    success: function(response) {
                        alert('초기화되었습니다');
                        $(".select-best").text("우수회원 선택");
                    },
                    error: function(xhr, status, error) {
                        alert('오류가 발생했습니다.');
                    }
                });
            }


        $.ajax({
            url: "/manager/post-list",
            type: "GET",
            dataType: "json",
            success: function(data) {
                var html = "";
                for (var i = 0; i < data.length; i++) {
                    var post = data[i];
                    html += "<tr><td><a href= ''>" + post.postTitle +
                            "</a></td><td>" + post.userId +
                            "</td><td> 신고 " + post.flag +
                            "회 </td><td><button type='button'>삭제</button></td></tr>";
                }
                $("#post-list").html(html);
            },
            error: function(xhr, status, error) {
                alert('게시물 목록을 가져오는 도중 오류가 발생했습니다.');
            }
        });
</script>
</body>
</html>