<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물일기</title>
<%@ include file="../main/header.jsp" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/newDiary.css">
</head>
<body style="text-align: center"><br>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<div style="margin-top: 230px">
<h1 class="newdiarytitle">새로운 이야기</h1>
<br><br><br>
<section class="newdiarysection">
        <form action="./form" method="post" enctype="multipart/form-data">
            <div class="diary_wrapper">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            <div>
                <h4 class="minititle">제목</h4><br>
                <input class="titleinput" type="text" name="diaryTitle" id="diaryTitle" required>
            </div>
            <br>
            <br>
            <div>
                <h4 class="minititle">내 식물</h4><br>
                <c:forEach var="myplant" items="${myplantList}">
                    <input class="myplantoption" type='checkbox' name='selectedMyplant' id='id_${myplant.myplantId}' value='${myplant.myplantId}'> ${myplant.myplantNick}
                    <input type="hidden" name="myplantNick" id="nick_${myplant.myplantId}" value="${myplant.myplantNick}">
                </c:forEach>
            </div>
            <div id="scheduleContainer"></div>
            <br>
            <br>
            <div>
                <h4 class="minititle">오늘 식물관리의 칭찬 혹은 반성</h4><br>
                <textarea  class="diaryinput" cols="140" rows="5" name="diaryPraiseRegret" id="diaryPraiseRegret" placeholder="스스로 잘한 점이나 부족했던 점을 기록해보세요" required></textarea>
            </div>
            <br>
            <br>
            <div>
                <h4 class="minititle">식물을 보며 느낀 나의 감정</h4><br>
                <textarea  class="diaryinput" cols="140" rows="5" name="diaryEmotion" id="diaryEmotion" placeholder="반려식물과의 교감을 기록해보세요" required></textarea>
            </div>
            <br>
            <br>
            <div>
                <h4 class="minititle">당신의 식물은 오늘 얼마나 성장했나요?</h4><br>
                <textarea  class="diaryinput" cols="140" rows="5" name="diaryGrowth" id="diaryGrowth" placeholder="내일은 오늘보다 더 자라있을거예요" required></textarea>
            </div>
            <br>
            <br>
            <div>
                <h4 class="minititle">자유</h4><br>
                <textarea  class="diaryinput" cols="140" rows="5" name="diaryContent" id="diaryContent" placeholder="기록하고 싶은 말을 자유롭게 적어보세요" required></textarea>
            </div>
            <br>
            <br>
            <h4 class="minititle">사진 첨부</h4><br>
            <div class="mb-3" style="margin-left:auto; margin-right:auto;">
                <input class="upload_img form-control" type="file"  name="diaryMultiImage" id="formFileMultiple" multiple>
            </div>
            <br>
            <br>
            <input type="hidden" name="userId" id="userId" value="${userId}">
            </div>
            <br>
            <br>
        <input type="submit" value="작성" class="newdiarysubmit">
    </form>
</section>
<br><br><br>
<br><br><br><br><br><br>
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
                        html += '<table><tr><th>' + myplantNick + '</th>';
                        html += '<td>  물주기 ' + response.watering + '회 | </td>';
                        html += '<td>영양제 ' + response.nutri + '회 | </td>';
                        html += '<td>가지치기 ' + response.prun + '회 | </td>';
                        html += '<td>분갈이 ' + response.soil + '회 | </td>';
                        html += '<td>환기 ' + response.ventilation + '회 | </td></tr></table>';
                        html += '</div>';
                    } else {
                        html += '<div id="schedule_' + selectedPlant + '">';
                        html += '<table><tr><th>' + myplantNick + '</th>';
                        html += '<td>  오늘은 관리 기록을 작성하지 않았어요<td></tr></table>';
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

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 100px; flex-shrink: 0;">
    <div class="container"><p class="m-0 small">
                             Copyright &copy; Plantery 2023</p></div>
</footer>
</body>
</html>