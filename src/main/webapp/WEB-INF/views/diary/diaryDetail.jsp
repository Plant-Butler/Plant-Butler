<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물일기</title>
 <%@ include file="../main/header.jsp" %>
</head>
<body>
<body style="text-align: center"><br>

<section class="page-section cta">
    <div class="container">
        <table>
            <tr>
                <c:if test="${not empty diary.diaryImage}">
                    <td>
                        <c:forEach var="image" items="${fn:split(diary.diaryImage, ',')}">
                            <p><a href="/uploads/${image}"><img src="/uploads/${image}"></a></p>
                        </c:forEach>
                    </td>
                </c:if>
            </tr>
            <tr>
                <td colspan="2">${diary.diaryTitle}</td>
            </tr>
            <tr>
                <td colspan="2"><fmt:formatDate value="${diary.diaryDate}" type="date"/></td>
            </tr>
            <tr>
                <td>오늘 식물관리의 칭찬 혹은 반성</td>
                <td>${diary.diaryPraiseRegret}</td>
            </tr>
            <tr>
                <td>식물을 보며 느낀 나의 감정</td>
                <td>${diary.diaryEmotion}</td>
            </tr>
            <tr>
                <td>당신의 식물은 오늘 얼마나 성장했나요?</td>
                <td>${diary.diaryGrowth}</td>
            </tr>
            <tr>
                <td>자유</td>
                <td>${diary.diaryContent}</td>
            </tr>
        </table>
        <button onclick="">수정</button>
        <button onclick="deleteCheck(${diary.diaryId})">삭제</button>
        <button onclick='location.href="/diaries"'>목록</button>
    </div>
</section>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>

    function deleteCheck(diaryId) {
         let say = '삭제하시겠습니까?';

         if (confirm(say) == true){
             deleteDiary(diaryId);
         } else {
             return false;
         }
    }

    function deleteDiary(diaryId) {
        $.ajax({
            url: "/diaries/" + diaryId,
            type: "DELETE",
            data: { diaryId : diaryId },
            success: function(response) {
                if(response) {
                    alert('삭제되었습니다');
                    window.location.href = "/diaries";
                } else {
                    alert('삭제에 실패하였습니다.');
                }
            },
            error: function(request, status, error) {
                alert('오류가 발생하였습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }
</script>

</body>
</html>