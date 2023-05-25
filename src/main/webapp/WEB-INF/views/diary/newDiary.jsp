<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        <form action="./form" method="post" enctype="multipart/form-data">
            <input class="upload_img" type="file" name="diaryMultiImage" multiple>

            <div>
                <h4>제목</h4>
                <input type="text" name="diaryTitle" id="diaryTitle" required>
            </div>
            <div>
                <h4>내 식물</h4>
                <c:forEach var="myplant" items="${myplantList}">
                    <input type='checkbox' name='selectedMyplant' id='id_${myplant.myplantId}' value='${myplant.myplantId}'> ${myplant.myplantNick}
                    <input type="hidden" name="myplantNick" id="nick_${myplant.myplantId}" value="${myplant.myplantNick}">
                </c:forEach>
            </div>
            <div id="scheduleContainer"></div>
            <div>
                <h4>오늘 식물관리의 칭찬 혹은 반성</h4>
                <textarea cols="150" rows="10" name="diaryPraiseRegret" id="diaryPraiseRegret" required>스스로 잘한 점이나 부족했던 점을 기록해보세요.</textarea>
            </div>
            <div>
                <h4>식물을 보며 느낀 나의 감정</h4>
                <textarea cols="150" rows="10" name="diaryEmotion" id="diaryEmotion" required>나의 반려식물과 어떤 정서적 교감이 있었는지 기록해보세요.</textarea>
            </div>
            <div>
                <h4>당신의 식물은 오늘 얼마나 성장했나요?</h4>
                <textarea cols="150" rows="10" name="diaryGrowth" id="diaryGrowth" required>내일은 오늘보다 더 자라있을거예요.</textarea>
            </div>
            <div>
                <h4>기타</h4>
                <textarea cols="150" rows="10" name="diaryContent" id="diaryContent" required>기록하고 싶은 말을 자유롭게 적어보세요.</textarea>
            </div>

            <input type="hidden" name="userId" id="userId" value="${user.userId}">
            <input type="submit" value="작성">
        </form>
    </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

    $("input[type='checkbox']").change(function(e) {
        // 선택한 내 식물의 인덱스
        var selectedPlant = $(this).val();
        var checkboxId = document.getElementById("id_" + selectedPlant);

        var scheduleContainer = document.getElementById("scheduleContainer");
        var myplantNick = document.getElementById("nick_" + selectedPlant).value;

        // 체크박스 선택
        if ($(checkboxId).prop("checked")) {
            $.ajax({
                url: "/diaries/schedule",
                type: "GET",
                data: {
                    selectedPlant: selectedPlant
                },
                success: function(response) {
                    console.log(response);
                    var html = '';

                    if (response !== '') {
                        html += '<div id="schedule_' + selectedPlant + '">';
                        html += '<table><tr><td>' + myplantNick + '</td>';
                        html += '<td>물주기 ' + response.watering + '회</td>';
                        html += '<td>영양제 ' + response.nutri + '회</td>';
                        html += '<td>가지치기 ' + response.prun + '회</td>';
                        html += '<td>분갈이 ' + response.soil + '회</td>';
                        html += '<td>환기 ' + response.ventilation + '회</td></tr></table>';
                        html += '</div>';
                    } else {
                        html += '<div id="schedule_' + selectedPlant + '">';
                        html += '<table><tr><td>' + myplantNick + '</td>';
                        html += '<td>오늘은 아무런 관리 기록도 작성하지 않았어요<td></tr></table>';
                        html += '</div>';
                    }

                    scheduleContainer.innerHTML += html;
                },
                error: function(request, status, error) {
                    alert('오류가 발생했습니다.');
                    console.log("code: " + request.status);
                    console.log("message: " + request.responseText);
                    console.log("error: " + error);
                }
            });

        // 체크박스 해제
        } else {
            var scheduleDiv = document.getElementById("schedule_" + selectedPlant);
            if (scheduleDiv) {
                scheduleDiv.remove();
            }
        }
    });

</script>
</body>
</html>