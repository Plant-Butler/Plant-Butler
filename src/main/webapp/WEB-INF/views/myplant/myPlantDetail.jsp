<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-04-27
  Time: 오전 9:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>

<head>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Title</title>
    <%@ include file="../main/header.jsp" %>
</head>
<body>
<div style=" padding-left: 200px; padding-right: 200px;">
<div style="margin-bottom: 30px;"><button class="btn btn-primary" onclick="registRepresent()">대표식물로 지정</button></div>
<div>
<div class="swiper" style="width: 500px; height: 600px; float: left; margin-right: 70px">
    <!-- Additional required wrapper -->
    <div class="swiper-wrapper" >
        <c:forEach var="image" items="${fn:split(myPlant.myplantImage, ',')}">
            <div class="swiper-slide"><p><img src="/uploads/${image}" style="object-fit: contain; width: 100%; height: 100%;"></p></div>
        </c:forEach>
    </div>
    <!-- If we need pagination -->
    <div class="swiper-pagination"></div>
    <!-- If we need navigation buttons -->
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
    <!-- If we need scrollbar -->
    <div class="swiper-scrollbar"></div>
</div>
<div style=" margin-left: 500px;">
    ${plant.distbNm}
        <p class="editable" name="myplantNick">${myPlant.myplantNick}</p>
        <p><input type="text" class="input-editable" name="myplantNick" value="${myPlant.myplantNick}" style="display:none;"></p>
        <p name="plant">${plant.fncltyInfo}</p>
        <div style="display: flex; flex-wrap: wrap; border: 1px solid #000;">
            <div style="width: 50%; border-right: 1px solid #000; border-bottom: 1px solid #000;">
                <c:choose>
                    <c:when test="${myPlant.myplantPot==1}">
                        <p class="editable" name="myplantPot">원통형 화분</p>
                    </c:when>
                    <c:otherwise>
                        <p class="editable" name="myplantPot">사각형 화분</p>
                    </c:otherwise>
                </c:choose>
                <input type="radio" class="input-editable" id="cylinder" name="myplantPot" value="1" style="display:none;">
                <label class="input-editable" for="cylinder" style="display:none;">원통형 화분</label>
                <input type="radio" class="input-editable" id="rectangle" name="myplantPot" value="2" style="display:none;">
                <label class="input-editable" for="rectangle" style="display:none;">사각형 화분</label>
            </div>
            <div style="width: 50%; border-bottom: 1px solid #000;">
                <p class="editable" name="myplantLength">화분 높이 : ${myPlant.myplantLength}cm</p>
                <div class="input-editable" style="display:none;">
                    <p>화분 높이 :<input type="text" name="myplantLength" value="${myPlant.myplantLength}"></p>
                </div>
            </div>
            <div style="width: 50%; border-right: 1px solid #000;">
                <p><span id="radius1Label">화분 밑 지름:</span><span class="editable" name="myplantRadius1">${myPlant.myplantRadius1}cm</span></p>
                <input type="text" class="input-editable" name="myplantRadius1" value="${myPlant.myplantRadius1}" style="display:none;">
            </div>
            <div style="width: 50%;">
                <p><span id="radius2Label">화분 윗 지름:</span><span class="editable" name="myplantRadius2">${myPlant.myplantRadius2}cm</span></p>
                <input type="text" class="input-editable" name="myplantRadius2" value="${myPlant.myplantRadius2}" style="display:none;">
            </div>
        </div>
            <p name="plant">생육온도<br>${plant.grwhTpCodeNm}가 적당해요</p>
            <p name="myplantFirstDate">분양일<br>${myPlant.firstDate}</p>
            <p name="plant">조언 : ${plant.adviseInfo}</p>
             <p name="plant">키우기 난이도 : ${plant.managedemanddoCodeNm}</p>
        <p name="plant">생장속도 : ${plant.grwtveCodeNm}</p>

        <p name="plant">겨울 최저 온도 : ${plant.winterLwetTpCodeNm}</p>

        <p name="plant">비료정보 : ${plant.frtlzrInfo}</p>

        <p name="plant">토양 정보 : ${plant.soilInfo}</p>
        <p name="plant">물주기 봄 : ${plant.watercycleSprngCodeNm}</p>
        <p name="plant">물주기 여름 : ${plant.watercycleSummerCodeNm}</p>
        <p name="plant">물주기 가을 : ${plant.watercycleAutumnCodeNm}</p>
        <p name="plant">물주기 겨울 : ${plant.watercycleWinterCodeNm}</p>
        <p name="plant">병충해 관리 정보 : ${plant.dlthtsManageInfo}</p>
        <p name="plant">특별관리정보 : ${plant.speclmanageInfo}</p>

        <td><p name="plant">관리요구도 : ${plant.managedemanddoCodeNm}</p>
            <p name="plant">광요구도 : ${plant.lighttdemanddoCodeNm}</p>

            <p name="plant">배치장소 : ${plant.postngplaceCodeNm}</p>
            <p name="plant">병해충 : ${plant.dlthtsCodeNm}</p>

</div>




    <td colspan="3">
            <button id="editBtn">수정</button>

            <button id="saveBtn" style="display:none;">저장</button>
        </td>
    </tr>
</div>




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
        var csrfToken = '${_csrf.token}';
        var csrfHeader = '${_csrf.headerName}';
        var myplantVo = {
            myplantId:${myPlant.myplantId},
            plantId:${myPlant.plantId},
            userId:"${myPlant.userId}",
            myplantNick: $("input[name='myplantNick']").val(),
            myplantImage: $("input[name='myplantImage']").val(),
            myplantPot: $("input[name='myplantPot']:checked").val(),
            myplantLength: $("input[name='myplantLength']").val(),
            myplantRadius1: $("input[name='myplantRadius1']").val(),
            myplantRadius2: $("input[name='myplantRadius2']").val(),
        };
        $.ajax({
            url: "/myplants/"+${myPlant.myplantId},
            method: "POST",
            headers: {
                [csrfHeader]: csrfToken // CSRF 토큰을 요청 헤더에 추가
            },
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

<script>
    $(document).ready(function () {

        if ($("input[name='myplantPot']:checked").val() === "1") {
            $("#radius1Label").text("화분 밑 지름:");
            $("#radius2Label").text("화분 윗 지름:");
        } else {
            $("#radius1Label").text("화분 가로:");
            $("#radius2Label").text("화분 세로:");
        }
    });

    // 라디오 버튼 변경 시 radius1Label과 radius2Label의 내용을 변경
    $("input[name='myplantPot']").on("change", function () {
        if ($(this).val() === "1") {
            $("#radius1Label").text("내 화분 밑 지름:");
            $("#radius2Label").text("내 화분 윗 지름:");
        } else {
            $("#radius1Label").text("내 화분 가로:");
            $("#radius2Label").text("내 화분 세로:");
        }
    });
</script>

<script>
    const swiper = new Swiper('.swiper', {
        // Optional parameters
        direction: 'vertical',
        loop: true,

        // If we need pagination
        pagination: {
            el: '.swiper-pagination',
        },

        // Navigation arrows
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },

        // And if we need scrollbar
        scrollbar: {
            el: '.swiper-scrollbar',
        },
    });
</script>
<script>
    function registRepresent() {
        var csrfToken = '${_csrf.token}';
        var csrfHeader = '${_csrf.headerName}';
        var userId = '${myPlant.userId}';
        fetch(`/myplants/${myPlant.myplantId}/${myPlant.userId}/represent`, {
            method: 'POST',
            headers: {
                [csrfHeader]: csrfToken
            },
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

</div>
</body>

</html>