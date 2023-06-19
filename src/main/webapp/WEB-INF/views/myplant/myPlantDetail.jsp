
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
    <link rel="stylesheet" href="/css/myplantDetail.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
    <title>Title</title>
    <%@ include file="../main/header.jsp" %>
</head>
<body>

<div style=" padding-left: 200px; padding-right: 200px;">
<div id="representContainer">
    <button class="btn btn-primary" onclick="registRepresent()">대표식물로 지정</button>
    <button id="editBtn" class="btn btn-primary">수정하기</button>

    <button id="saveBtn" style="display:none;" class="btn btn-primary">저장하기</button>

</div>
<div>
<div class="swiper">
    <!-- Additional required wrapper -->
    <input class="upload_img input-editable" type="file" id="myplantImagesInput" name="myplantImages" style="display:none;" multiple>
    <div class="swiper-wrapper" >
        <c:forEach var="image" items="${imageUrls}">
            <div class="swiper-slide"><p><img id="slide-image" src="${image}" ></p></div>
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
<div id="myplantContainer" style=" margin-left: 500px;">
    <p name="myplantFirstDate" id="myplantFirstDate">${plant.distbNm} ${plant.plntbneNm}</p>
    <p>${myPlant.firstDate}</p>
        <p class="editable" name="myplantNick">${myPlant.myplantNick}</p>
        <p><input type="text" class="input-editable" name="myplantNick" value="${myPlant.myplantNick}" style="display:none;"></p>
        <p name="plant">${plant.fncltyInfo}</p>
        <div style="display: flex; flex-wrap: wrap; border: 1px solid #000; border-top: 1px solid rgba(0, 0, 0, 0.1); border-left: 1px solid rgba(0, 0, 0, 0); border-right: 1px solid rgba(0, 0, 0, 0); border-bottom: 1px solid rgba(0, 0, 0, 0.2); margin-top: 50px; margin-bottom: 50px">
            <div style="width: 50%;">
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
            <div style="width: 50%;">
                <p class="editable" name="myplantLength">화분 높이 : ${myPlant.myplantLength}cm</p>
                <div class="input-editable" style="display:none;">
                    <p>화분 높이 :<input type="text" name="myplantLength" value="${myPlant.myplantLength}"></p>
                </div>
            </div>
            <div style="width: 50%;">
                <p><span id="radius1Label">화분 밑 지름 : </span><span class="editable" name="myplantRadius1">${myPlant.myplantRadius1}cm</span></p>
                <input type="text" class="input-editable" name="myplantRadius1" value="${myPlant.myplantRadius1}" style="display:none;">
            </div>
            <div style="width: 50%;">
                <p><span id="radius2Label">화분 윗 지름 : </span><span class="editable" name="myplantRadius2">${myPlant.myplantRadius2}cm</span></p>
                <input type="text" class="input-editable" name="myplantRadius2" value="${myPlant.myplantRadius2}" style="display:none;">
            </div>
        </div>
            <div id ="plantdetail2" style="display: flex; flex-wrap: wrap; border: 1px solid #000; border-top: 1px solid rgba(0, 0, 0, 0.1); border-left: 1px solid rgba(0, 0, 0, 0); border-right: 1px solid rgba(0, 0, 0, 0); border-bottom: 1px solid rgba(0, 0, 0, 0.2);">
                <div style="width: 50%;">
                <p name="plant"><span class="highlight">생육온도</span><br>${plant.grwhTpCodeNm}가 적당해요</p>
                </div>
                <div style="width: 50%;">
                    <p name="plant"><span class="highlight">키우기 난이도</span><br>${plant.managedemanddoCodeNm}</p>
                </div>
                <div style="width: 50%;">
                    <p name="plant"><span class="highlight">적정습도</span><br>${plant.hdCodeNm}</p>
                </div>
                <div style="width: 50%;">
                    <p name="plant"><span class="highlight">비료요구도</span><br>${plant.frtlzrInfo}</p>
                </div>
            </div>
</div>

    <h1 id="detailTitle">자세히 알아보기</h1>
    <div>
        <div id="buttonNav">
        <button class="btn btn-success rounded-pill px-3" type="button" id="button1">물</button>
        <button class="btn btn-success rounded-pill px-3" type="button" id="button2">빛</button>
        <button class="btn btn-success rounded-pill px-3" type="button" id="button3">관리</button>
        </div>
        <div id="content1" class="content">
            <div id="season"><h2>계절에 따른 물 주는 시기</h2></div>
            <div style="display: flex; flex-wrap: wrap;">
                <img id="seasonImage" src="/images/watering.jpg" style="width: 45%; height: auto;"></p>
                <div style="width: 55%;">
            <p name="plant"><span class="seasonTitle">봄</span><br>${plant.watercycleSprngCodeNm}</p>
            <p name="plant"><span class="seasonTitle">여름</span><br>${plant.watercycleSummerCodeNm}</p>
            <p name="plant"><span class="seasonTitle">가을</span><br>${plant.watercycleAutumnCodeNm}</p>
            <p name="plant"><span class="seasonTitle">겨울</span> <br>${plant.watercycleWinterCodeNm}</p>
                </div>
            </div>
        </div>
        <div id="content2" class="content">
            <div style="display: flex; flex-wrap: wrap;">
            <img id="lightImage" src="/images/plantlight.jpg" style="width: 45%; height: auto;"></p>
            <div style="width: 55%;">
            <p name="plant"><span class="seasonTitle">광요구도</span><br>${plant.lighttdemanddoCodeNm}</p>
            <p name="plant"><span class="seasonTitle">배치장소</span><br>${plant.postngplaceCodeNm}</p>
            </div>
            </div>
        </div>
        <div id="content3" class="content">
            <p name="plant">병충해 관리 정보 : ${plant.dlthtsManageInfo}</p>
            <p name="plant">특별관리정보 : ${plant.speclmanageInfo}</p>
            <p name="plant">병해충 : ${plant.dlthtsCodeNm}</p>
        </div>

    </div>


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

        var fileInput = document.getElementById("myplantImagesInput");
        var files = fileInput.files;

        var formData = new FormData();
        for (var i = 0; i < files.length; i++) {
          formData.append("myplantImages", files[i]);
        }

        var myplantVo = {
            myplantId:${myPlant.myplantId},
            plantId:${myPlant.plantId},
            userId:"${myPlant.userId}",
            myplantNick: $("input[name='myplantNick']").val(),
            myplantPot: $("input[name='myplantPot']:checked").val(),
            myplantLength: $("input[name='myplantLength']").val(),
            myplantRadius1: $("input[name='myplantRadius1']").val(),
            myplantRadius2: $("input[name='myplantRadius2']").val(),
        };
        formData.append("myplantVo", JSON.stringify(myplantVo));

        $.ajax({
            url: "/myplants/"+${myPlant.myplantId},
            method: "POST",
            headers: {
                [csrfHeader]: csrfToken // CSRF 토큰을 요청 헤더에 추가
            },
            data: formData,
            processData: false,
            contentType: false,
            xhrFields: {
                withCredentials: true
            },
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
            $("#radius1Label").text("화분 밑 지름 : ");
            $("#radius2Label").text("화분 윗 지름 : ");
        } else {
            $("#radius1Label").text("화분 가로 : ");
            $("#radius2Label").text("화분 세로 : ");
        }
    });

    // 라디오 버튼 변경 시 radius1Label과 radius2Label의 내용을 변경
    $("input[name='myplantPot']").on("change", function () {
        if ($(this).val() === "1") {
            $("#radius1Label").text("내 화분 밑 지름 : ");
            $("#radius2Label").text("내 화분 윗 지름 : ");
        } else {
            $("#radius1Label").text("내 화분 가로 : ");
            $("#radius2Label").text("내 화분 세로 : ");
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
    $(document).ready(function(){
        $(".content").hide(); // hide all contents
        $("#content1").fadeIn(); // fade in the first content

        $("#button1").click(function(){
            $(".content").hide(); // hide all contents
            $("#content1").fadeIn(); // fade in the first content
        });
        $("#button2").click(function(){
            $(".content").hide(); // hide all contents
            $("#content2").fadeIn(); // fade in the second content
        });
        $("#button3").click(function(){
            $(".content").hide(); // hide all contents
            $("#content3").fadeIn(); // fade in the third content
        });
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
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 100px; flex-shrink: 0;">
    <div class="container">
        <p class="m-0 small">© Plantery 2023</p>
    </div>
</footer>
</html>