<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-04-27
  Time: 오전 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Title</title>
</head>
<body>
<h1>내 식물 상세보기</h1>
<table>
    <tr class="nonedit">
        <td>내식물 번호 :</td>
        <td><p class="editable" name="myplantId" contenteditable="false">${myPlant.myplantId}</p></td>
        <td></td>
    </tr>
    <tr class="nonedit">
        <td>식물아이디 :</td>
        <td><p class="editable" name="plantId" contenteditable="false">${myPlant.plantId}</p></td>
        <td></td>
    </tr>
    <tr class="nonedit">
        <td>유저아이디 :</td>
        <td><p class="editable" name="userId" contenteditable="false">${myPlant.userId}</p></td>
        <td></td>
    </tr>
    <tr>
        <td>식물닉네임 :</td>
        <td>
            <p class="editable" name="myplantNick">${myPlant.myplantNick}</p>
            <input type="text" class="input-editable" name="myplantNick" value="${myPlant.myplantNick}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 식물 이미지:</td>
        <td>
            <c:forEach var="image" items="${fn:split(myPlant.myplantImage, ',')}">
                <p><a href="/uploads/${image}"><img src="/uploads/${image}"></a></p>
            </c:forEach>

        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 식물 무게 :</td>
        <td>
            <p class="editable" name="myplantWeight">${myPlant.myplantWeight}</p>
            <input type="text" class="input-editable" name="myplantWeight" value="${myPlant.myplantWeight}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 식물 높이 :</td>
        <td>
            <p class="editable" name="myplantLength">${myPlant.myplantLength}</p>
            <input type="text" class="input-editable" name="myplantLength" value="${myPlant.myplantLength}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 식물 깊이 :</td>
        <td>
            <p class="editable" name="myplantDepth">${myPlant.myplantDepth}</p>
            <input type="text" class="input-editable" name="myplantDepth" value="${myPlant.myplantDepth}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 화분 지름 1:</td>
        <td>
            <p class="editable" name="myplantRadius1">${myPlant.myplantRadius1}</p>
            <input type="text" class="input-editable" name="myplantRadius1" value="${myPlant.myplantRadius1}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 화분 지름 2:</td>
        <td><p class="editable" name="myplantRadius2">${myPlant.myplantRadius2}</p>
        <input type="text" class="input-editable" name="myplantRadius2" value="${myPlant.myplantRadius2}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>분양일:</td>
        <td><p class="editable" name="myplantRadius2">${myPlant.firstDate}</p>
            <input type="text" class="input-editable" name="firstDate" value="${myPlant.firstDate}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>품종 :</td>
        <td><p name="plant">${plant.distbNm}</p>
        </td>
        <td></td>
    </tr>
        <td colspan="3">
            <button id="editBtn">수정</button>
            <button id="saveBtn" style="display:none;">저장</button>
        </td>
    </tr>
    <script>
        $("#editBtn").on("click", function () {
            $("tr.nonedit").hide();
            $(".editable").hide(); // p 태그 숨기기
            $(".input-editable").show(); // input 태그 보이기
            $("#editBtn").hide(); // 수정 버튼 숨기기
            $("#saveBtn").show(); // 저장 버튼 보이기
        });
    </script>

    <script>
        $("#saveBtn").on("click", function () {
            var myplantVo = {
                myplantId:${myPlant.myplantId},
                plantId:${myPlant.plantId},
                userId:"${myPlant.userId}",
                myplantNick: $("input[name='myplantNick']").val(),
                myplantImage: $("input[name='myplantImage']").val(),
                myplantWeight: $("input[name='myplantWeight']").val(),
                myplantLength: $("input[name='myplantLength']").val(),
                myplantDepth: $("input[name='myplantDepth']").val(),
                myplantRadius1: $("input[name='myplantRadius1']").val(),
                myplantRadius2: $("input[name='myplantRadius2']").val(),
                myplantRadius2: $("input[name='myplantRadius2']").val(),
            };

            $.ajax({
                url: "/myplants/"+${myPlant.myplantId},
                method: "POST",
                contentType: "application/json",
                data: JSON.stringify(myplantVo),
                success: function () {
                    alert("성공적으로 수정되었습니다.");
                    location.reload();
                },
                error: function () {
                    alert("수정에 실패했습니다. 다시 시도해주세요.");
                },
            });
        });
    </script>
</table>

</body>
</html>