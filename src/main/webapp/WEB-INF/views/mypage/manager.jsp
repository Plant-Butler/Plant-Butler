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
<h1></h1>

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
<form action="/manager/best-user/all" method="POST">
    <input type="hidden" name="_method" value="DELETE"/>
    <input type="submit" value="우수회원 초기화">
</form>



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
</script>
</body>
</html>