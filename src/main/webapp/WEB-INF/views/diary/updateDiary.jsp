<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물일기</title>
<%@ include file="../main/header.jsp" %>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<link rel="stylesheet" href="/css/updateDiary.css">
</head>
<body style="text-align: center"><br>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<div style="margin-top: 230px">
<h1 class="newdiarytitle">일기 수정</h1>
<br><br><br>
<section class="newdiarysection">
    <form id="diaryUpdateForm" enctype="multipart/form-data">
        <div class="diary_wrapper">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div>
            <h4 class="minititle">제목</h4><br>
            <input type="text" name="diaryTitle" id="diaryTitle" value="${diary.diaryTitle}" required>
        </div>
        <br>
        <br>
        <div>
            <h4 class="minititle">오늘 식물관리의 칭찬 혹은 반성</h4><br>
            <textarea  class="diaryinput" cols="140" rows="5" name="diaryPraiseRegret" id="diaryPraiseRegret" required>${diary.diaryPraiseRegret}</textarea>
        </div>
        <br>
        <br>
        <div>
            <h4 class="minititle">식물을 보며 느낀 나의 감정</h4><br>
            <textarea  class="diaryinput" cols="140" rows="5" name="diaryEmotion" id="diaryEmotion" required>${diary.diaryEmotion}</textarea>
        </div>
        <br>
        <br>
        <div>
            <h4 class="minititle">당신의 식물은 오늘 얼마나 성장했나요?</h4><br>
            <textarea  class="diaryinput" cols="140" rows="5" name="diaryGrowth" id="diaryGrowth" required>${diary.diaryGrowth}</textarea>
        </div>
        <br>
        <br>
        <div>
            <h4 class="minititle">자유</h4><br>
            <textarea  class="diaryinput" cols="140" rows="5" name="diaryContent" id="diaryContent" required>${diary.diaryContent}</textarea>
        </div>
        <br>
        <br>
        <c:if test="${not empty diary.diaryImage}">
        <h4 class="minititle">첨부된 사진</h4><br>
        <div class="mb-3" style="margin-left:auto; margin-right:auto;">
                <p>
                    <c:forEach var="image" items="${fn:split(diary.diaryImage, ',')}">
                        <img class="max-small" src="/uploads/${image}">
                    </c:forEach>
                </p>
        </div>
        </c:if>
        <h4 class="minititle">사진 첨부</h4><br>
            <div class="mb-3" style="margin-left:auto; margin-right:auto;">
                <input class="upload_img form-control" type="file" name="diaryMultiImage" multiple>
            </div>
        <br>
        <br>
        <input type="hidden" name="diaryId" id="diaryId" value="${diary.diaryId}">
        </div>
        <br><br><br>
        <button type="button" onclick="modifyUpdate('${diary.diaryId}')"  class="newdiarysubmit">수정</button>
    </form>
</section>
<br><br><br>
<br><br><br><br><br><br>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>


    function modifyUpdate(diaryId) {

        const form = document.getElementById("diaryUpdateForm");
        const diary = new FormData(form);

        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");

        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        })

        $.ajax({
            url: "/diaries/" + diaryId,
            type: "PUT",
            data: diary,
            processData: false,
            contentType: false,
            success: function(response) {
                if(response) {
                    alert('수정되었습니다');
                    window.location.href = "/diaries";
                } else {
                    alert('수정에 실패하였습니다.');
                }
            },
            error: function(request, status, error) {
                alert('오류가 발생했습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }
</script>
<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 100px; flex-shrink: 0;">
    <div class="container"><p class="m-0 small">
                             Copyright &copy; Plantery 2023</p></div>
</footer>
</body>
</html>