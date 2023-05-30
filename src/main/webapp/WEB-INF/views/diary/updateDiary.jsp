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
    <style>
        .max-small {
            width: auto; height: auto;
            max-width: 100px;
            max-height: 100px;
        }
    </style>
</head>
<body>
<body style="text-align: center"><br>

<section class="page-section cta">
    <div class="container">
        <form id="diaryUpdateForm" enctype="multipart/form-data">
            <c:if test="${not empty diary.diaryImage}">
                <p>
                    <c:forEach var="image" items="${fn:split(diary.diaryImage, ',')}">
                        <img class="max-small" src="/uploads/${image}">
                    </c:forEach>
                </p>
            </c:if>
            <input class="upload_img" type="file" name="diaryMultiImage" multiple>

            <div>
                <h4>제목</h4>
                <input type="text" name="diaryTitle" id="diaryTitle" value="${diary.diaryTitle}" required>
            </div>
            <div>
                <h4>오늘 식물관리의 칭찬 혹은 반성</h4>
                <textarea cols="150" rows="10" name="diaryPraiseRegret" id="diaryPraiseRegret" required>${diary.diaryPraiseRegret}</textarea>
            </div>
            <div>
                <h4>식물을 보며 느낀 나의 감정</h4>
                <textarea cols="150" rows="10" name="diaryEmotion" id="diaryEmotion" required>${diary.diaryEmotion}</textarea>
            </div>
            <div>
                <h4>당신의 식물은 오늘 얼마나 성장했나요?</h4>
                <textarea cols="150" rows="10" name="diaryGrowth" id="diaryGrowth" required>${diary.diaryGrowth}</textarea>
            </div>
            <div>
                <h4>기타</h4>
                <textarea cols="150" rows="10" name="diaryContent" id="diaryContent" required>${diary.diaryContent}</textarea>
            </div>

            <input type="hidden" name="diaryId" id="diaryId" value="${diary.diaryId}">
            <button type="button" onclick="modifyUpdate('${diary.diaryId}')">수정</button>
        </form>
    </div>
</section>

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
</body>
</html>