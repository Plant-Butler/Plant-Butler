<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <%@ include file="../main/header.jsp" %>
    <style>
        @font-face {
            font-family: 'KimjungchulGothic-Bold';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/KimjungchulGothic-Bold.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }
        table, td {
            text-align: center;
            margin-left: auto;
            margin-right: auto;
            border: 1px solid;
        }

        td {
            width: 90%;
        }

        .container {
            display: grid;
            grid-template-columns: 50% 50%;
            font-family: 'KimjungchulGothic-Bold';
            font-size: 20px;
            grid-column-gap: 120px;
            grid-template-areas:
        "a b1"
        "a b2"
        "a b3"
        "a b4"
        "a b5"
        "a b6"
        "a b7"
        "a b8";


        }

        .a {
            grid-area: a;
            width: 100%;
            height: auto;
            margin-bottom: 30px;
        }

        .b1 {
            grid-area: b1;
            font-size: 45px;
            color: #198754;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;
            white-space: normal;
        }

        .b2 {
            grid-area: b2;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;
            width:max-content;
        }

        .b3 {
            grid-area: b3;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;
            width:max-content;
        }

        .b4 {
            grid-area: b4;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;
            width:max-content;
        }

        .b5 {
            grid-area: b5;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;
            width:max-content;
        }

        .b6 {
            grid-area: b6;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;
            width:max-content;
        }

        .b7 {
            grid-area: b7;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;
            white-space: normal;
        }

        .b8 {
            grid-area: b8;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
            height: min-content;

            white-space: normal;
        }
        .b1, .b2, .b3, .b4, .b5, .b6, .b7, .b8 {
            justify-self: end;
        }
    </style>

    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
</head>

<body style="text-align: center; margin-top: 200px;">
<br>
<h2 style="font-family: 'KimjungchulGothic-Bold', serif; font-size: 60px;">나에게 맞는 반려식물 결과</h2>
<br><br>
<div class="swiper" style="margin-bottom: 100px;">
    <!-- If we need pagination -->
    <div class="swiper-pagination"></div>
    <!-- Additional required wrapper -->
    <!-- If we need navigation buttons -->
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
    <!-- If we need scrollbar -->
    <div class="swiper-scrollbar"></div>
    <div class="swiper-wrapper">
        <c:forEach var="plant" items="${recomPlantList}">
            <div class="swiper-slide">
                <div class="container">
                    <div class="a">
                        <img class="plantImg" src="${plant.image}">
                    </div>
                        <div class="b1">${plant.distbNm}</div>
                        <div class="b2">${plant.clCodeNm}</div>
                        <div class="b3">비료 주기 : ${plant.frtlzrInfo}</div>
                        <div class="b4"><c:if test="${empty plant.soilInfo}"> - </c:if>적합한 토양 : ${plant.soilInfo}</div>
                        <div class="b5">${plant.adviseInfo}</div>
                        <div class="b6">키우기 난이도 : ${plant.managelevelCodeNm}</div>
                        <div class="b7"><c:if test="${empty plant.speclmanageInfo}"> - </c:if> ${plant.speclmanageInfo}</div>
                        <div class="b8">${plant.fncltyInfo}</div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script>
    $(document).ready(function () {
        var swiper = new Swiper('.swiper', {
            pagination: {
                el: '.swiper-pagination',
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
            scrollbar: {
                el: '.swiper-scrollbar',
            },
        });
    });
</script>
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px;">
    <div class="container1"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>
</body>
</html>