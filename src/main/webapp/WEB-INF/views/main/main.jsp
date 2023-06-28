<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인페이지</title>
    <%@ include file="../main/header.jsp" %>
    <style>
        .box {
            width: 100px;
            height: 100px;
            border-radius: 70%;
            overflow: hidden;
            margin-left:auto;
            margin-right:auto
        }
        .plantImg {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        table, tbody, td {
            width:1000px;
            margin-left:auto;
            margin-right:auto;
        }
        .best-users {
            margin-right: auto;
            margin-left: auto;
          background-color: #f8f8f8; /* 배경색 지정 */
          text-align: center; /* 텍스트 가운데 정렬 */
          border-radius: 10px; /* 테두리 둥글게 처리 */
          padding: 20px; /* 내부 여백 설정 */
        }

        /* 예시 스타일링 */
        .best-users {
            width: 1200px;
          background-color: #f8f8f8;
          text-align: center;
            margin-left: auto;
            margin-right: auto;
          border-radius: 10px;
          padding: 20px;
          box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
          margin-top: 20px; /* 위쪽 여백 추가 */
          font-family: Arial, sans-serif; /* 폰트 지정 */
          font-size: 18px; /* 폰트 크기 지정 */
          color: #333; /* 텍스트 색상 지정 */
        }
        .best-user-table td{
            width: 550px;
        }
        .bestusers{
        margin-top: 10px;
        font-family: 'KimjungchulGothic-Bold';
        font-size: 50px;
        }
    </style>

</head>
<body style="height: 5000px; text-align: center;   display: flex; flex-direction: column; background:#F4FAF9;">
<div class="content" style=" flex: 1;">
<link rel="stylesheet" href="https://unpkg.com/aos@2.3.1/dist/aos.css">
<link rel="stylesheet" href="../css/mainStyle.css">
<link rel="stylesheet" href="../css/styles.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://unpkg.com/typewriter-effect@latest/dist/core.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>


<section class="page-section clearfix" style="margin-top: 500px;">
    <div id="maintextdiv">
        <p class ="app" id="app"></p>
    </div>

        <div class="video-container content">
            <video autoplay muted loop id="video">
                <source src="images/plant2.mp4" type="video/mp4">
                Your browser does not support HTML5 video.
            </video>
            <div class="overlay-text" data-aos="zoom-out-right" data-aos-once="false"><span id="introText"></span></div>
        </div>
        <div class="container content" data-aos="zoom-out-right" data-aos-once="false">
            <div class="col-xl-9 mx-auto">
                <div class="intro">
                    <h2 class="section-heading mb-4">
                        <span class="section-heading-upper"></span>
                    </h2>
                    <p class="mb-3" style="font-size: 60px; margin-top: 500px;">나의 성향 & 취향 & 환경을<br>모두 고려한 최적의<br>반려 식물은 무엇일까요?</p>

                    <i class="bi bi-arrow-up-right-square" onclick="location.href='/suggestions'"></i>

                </div>
            </div>
        </div>
    </section>


    <section class="page-section">
        <div class="container content" style="margin-bottom:200px; margin-right: 400px;">
            <div class="row">
                <div class="col-xl-9 mx-auto">
                    <div class="best-users">
                        <h2 class="bestusers"> 이달의 우수회원 </h2>
                        <table id="best-user-table" style="font-family: 'KimjungchulGothic-Bold'; font-size: 25px;">
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script>
        var app = document.getElementById('app');
        var introText = document.getElementById('introText');

        var typewriter = new Typewriter(app, {
            loop: false,
            delay: 75,
        });

        typewriter
            .typeString('당신의 취향과 환경을 반영한')
            .pauseFor(500)
            .typeString('<br/>')
            .typeString('완벽한 <span style="color:#4BA888;">식물</span>을 찾아드립니다')
            .pauseFor(1000)
            .start();

        function checkScroll() {
            var introTextPosition = introText.getBoundingClientRect().top;

            if (introTextPosition < window.innerHeight) {
                var typewriter2 = new Typewriter(introText, {
                    loop: false,
                    delay: 75,
                });

            typewriter2
                .pauseFor(500)
                .typeString('<span style="color: #f6e1c5; font-weight: bold; font-family: Raleway, -apple-system, BlinkMacSystemFont, Segoe UI, Roboto, Helvetica Neue, Arial, sans-serif, Apple Color Emoji, Segoe UI Emoji, Segoe UI Symbol, Noto Color Emoji;">PLANTERY</span>와 함께')
                .typeString('<br/>')
                .typeString('당신만의 특별한 ')
                .typeString('<br/>')
                .typeString('식물을 발견하세요')
                .start();

                window.removeEventListener('scroll', checkScroll);
            }
        }

        window.addEventListener('scroll', checkScroll);
    </script>

    <script>
        AOS.init();
    </script>
</div>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/main.js"></script>
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 200px;">
    <div class="container">
        <p class="m-0 small">Copyright &copy; Plantery 2023</p>
    </div>
</footer>
</body>
</html>