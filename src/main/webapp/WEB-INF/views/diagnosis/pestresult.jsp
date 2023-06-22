<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.plant.vo.UserVo"%>
<%@ page import="com.plant.vo.PostVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>식물병 진단</title>
    <%@ include file="../main/header.jsp" %>
</head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<style type="text/css">
    body {
    font-family: 'Hahmlet', serif;
    margin: 0;
    padding: 0;
    }

    .result-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
        width: 1000px;
        text-align: center;
    }

    .result-title {
        font-size: 40px; /* 수정된 부분 */
        color: #000000;
        text-align: center;
        margin-top: 100px; /* 수정된 부분 */
        font-family: 'Hahmlet', serif;
        margin-right: -20px;
    }

    .result-subtitle {
        text-align: center;
        font-size: 40px;
        margin-top: 20px;
        color: #198754;
        margin-right: -25px;
    }

    .result-content {
        margin: 0 auto;
        text-align: center;
        background-color: #ffffff;
        padding: 20px;
        border-radius: 10px;
        margin-top: 30px;
        width: 1000px;
    }

    .result-image {
        text-align: center;
        margin-top: 20px;
        border-radius: 10px;
        width: 500px;
        location: center;
        margin-left: auto;
        margin-right: auto;
    }

    .result-image img {
        max-width: 100%;
        height: auto;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }


    .result-detail {
        margin-top: 30px;
    }

    .result-solution {
        margin-top: 20px;
    }

    .button-container {
        text-align: center;
        margin-right: -20px;
        margin-top: 30px;
    }

    .result-button {
        background-color: #198754;
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 3px 2px;
        cursor: pointer;
        border-radius: 10px;
        transition: background-color 0.3s;
    }

    .result-button:hover {
        background-color: #45a049;
    }

    .footer {
        background-color: #f8f8f8;
        padding: 10px 0;
    }

    .footer p {
        margin: 0;
    }

    .footer .container {
        max-width: 960px;
    }

    .shortdetail {
        font-weight: bold;
    }

    .detailtitle {
        font-size: 20px;
        border-radius: 10px;
        background-color: #b8d4c8;
        padding: 10px;
        color: black;
        display: inline-block;
        text-align: center;
     }
     .diseaseimage{
        width: 400px; /* 원하는 가로 크기로 조정 */
        height: auto;
        border-radius: 4px;
     }
     .imagecaption{
        font-family: 'Hahmlet', serif;
     }
</style>
<body>

<section class="page-section cta">
    <div class="container">
        <h1 class="result-title">진단 결과</h1>
        <p class="result-subtitle">${pclass}</p>
        <br>
        <hr>
        <div class="result-content">
            <div class="result-image">
                <img src="${pest.image}" alt="Image">
                <p class="imagecaption">${pclass} 예시 이미지</p>
            </div>
            <div class="detail">
                <br>
                <p class="detailtitle">상세 설명</p>
                    <p class="result-detail">${pest.detail}</p>
                </div>
                <div class="detail">
                 <br>
                <p class="detailtitle">해결책/예방법</p>
                    <p class="result-solution">${pest.solution}</p>
                </div>
            </div>

        <div class="button-container">
            <button type="button" class="result-button" onclick="window.location.href='/home'">메인화면</button>
            <button type="button" class="result-button" onclick="window.location.href='/diagnosis'">다시하기</button>
        </div>
    </div>
</section>

<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 100px; flex-shrink: 0;">
    <div class="container">
        <p class="m-0 small">Copyright &copy; Plantery 2023</p>
    </div>
</footer>
</body>
</html>
