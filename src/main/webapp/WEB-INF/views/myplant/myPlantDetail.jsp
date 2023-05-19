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
    <script>
        function registRepresent() {
            const represent = 1;
            fetch(`/myplants/${myplantId}/represent`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'text/plain',
                },
                body: represent.toString(),
            })
                .then((response) => {
                    if (response.ok) {
                        window.location.replace("/myplants");
                    } else {

                        console.error('Error:', response.statusText);
                    }
                })
                .catch((error) => {
                    console.error('Error:', error);
                });
        }
    </script>
</head>
<body>
<h1>내 식물 상세보기</h1> <button class="btn btn-primary" onclick="registRepresent()">대표식물로 지정</button>
<table>
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
        <td>내 화분 종류 :</td>
        <td>
            <c:choose>
                <c:when test="${myPlant.myplantWeight==1}">
                    <p class="editable" name="myplantWeight">원통형</p>
                </c:when>
                <c:otherwise>
                    <p class="editable" name="myplantWeight">사각형</p>
                </c:otherwise>
            </c:choose>
            <input type="radio" class="input-editable" id="cylinder" name="myplantWeight" value="1" style="display:none;">
            <label class="input-editable" for="cylinder" style="display:none;">원통형</label>
            <input type="radio" class="input-editable" id="rectangle" name="myplantWeight" value="2" style="display:none;">
            <label class="input-editable" for="rectangle" style="display:none;">사각형</label>

        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 화분 높이 :</td>
        <td>
            <p class="editable" name="myplantLength">${myPlant.myplantLength}</p>
            <input type="text" class="input-editable" name="myplantLength" value="${myPlant.myplantLength}" style="display:none;">
        </td>
        <td></td>
    </tr>
    <tr>
        <td>내 화분 깊이 :</td>
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
    <tr>
        <td>조언 :</td>
        <td><p name="plant">${plant.adviseInfo}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>키우기 난이도 :</td>
        <td><p name="plant">${plant.managedemanddoCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>생장속도 :</td>
        <td><p name="plant">${plant.grwtveCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>생육온도 :</td>
        <td><p name="plant">${plant.grwhTpCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>겨울 최저 온도 :</td>
        <td><p name="plant">${plant.winterLwetTpCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>비료정보 :</td>
        <td><p name="plant">${plant.frtlzrInfo}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>토양 정보 :</td>
        <td><p name="plant">${plant.soilInfo}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>물주기 봄 :</td>
        <td><p name="plant">${plant.watercycleSprngCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>물주기 여름 :</td>
        <td><p name="plant">${plant.watercycleSummerCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>물주기 가을 :</td>
        <td><p name="plant">${plant.watercycleAutumnCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>물주기 겨울 :</td>
        <td><p name="plant">${plant.watercycleWinterCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>병충해 관리정보 :</td>
        <td><p name="plant">${plant.dlthtsManageInfo}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>특별관리정보 :</td>
        <td><p name="plant">${plant.speclmanageInfo}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>기능성정보 :</td>
        <td><p name="plant">${plant.fncltyInfo}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>관리요구도 :</td>
        <td><p name="plant">${plant.managedemanddoCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>광요구도 :</td>
        <td><p name="plant">${plant.lighttdemanddoCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>배치장소 :</td>
        <td><p name="plant">${plant.postngplaceCodeNm}</p>
        </td>
        <td></td>
    </tr>
    <tr>
        <td>병해충 :</td>
        <td><p name="plant">${plant.dlthtsCodeNm}</p>
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
            $(".editable").hide();
            $(".input-editable").show();
            $("#editBtn").hide();
            $("#saveBtn").show();
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
                myplantWeight: $("input[name='myplantWeight']:checked").val(),
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