<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 찾기</title>
<%@ include file="../main/header.jsp" %>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/recomResult.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/recomResult.css">
</head>
<body style="text-align: center">
<section class="page-section cta">

    <div class="container">
        <div class="row">
            <div class="cta-inner bg-faded text-center rounded">
                <h1>${nickname}님에게 어울리는 식물이에요</h1> <br><br>

                <div class="carousel-container">
                    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <c:forEach var="plant" items="${resultList}" varStatus="status">
                                <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                    <table class="recommend-result">
                                        <tr>
                                            <th class="recommend-result" colspan="2"><img class="plantImg img-thumbnail" src="/uploads/${plant.image}"></th>
                                        </tr>
                                        <tr>
                                            <th class="recommend-result">${plant.plntzrNm} ${plant.distbNm}</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <button id="show${status.index}" onclick='show(${plant.plant_id}, "${fn:escapeXml(plant.distbNm)}", "${plant.soilInfo}")' class="btn btn-light">분양 준비하기</button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </c:forEach>
                        </div>
                        <ol class="carousel-indicators">
                            <c:forEach var="plant" items="${resultList}" varStatus="status">
                                <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></li>
                            </c:forEach>
                        </ol>
                        <br>
                        <c:forEach var="plant" items="${resultList}" varStatus="status">
                            <input type="hidden" name="plant_id${status.index}" value="${plant.plant_id}">
                        </c:forEach>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
                <br>
            </div>
        </div>
        <br><br><br>
        <button onclick="savePlants()" class="btn btn-light">마이페이지에 저장</button>
    </div>
    <br><br><br><br><br>


        <!-- 지도 -->
        <div class="row">
            <div class="col-xl-9 mx-auto">
                <h1>근처에서 바로 입양을 준비해볼까요?</h1>
            </div>
        </div>
        <br>
        <div class="map_wrap">
            <div id="map" style="width:50%;height:100%;position:relative;overflow:hidden;border-radius:20px;margin-left:32%;"></div>
            <div id="menu_wrap" class="bg_white" style="margin-left: 18%;">
                <div class="option">
                    <div>
                        <form onsubmit="searchPlaces(); return false;">
                            키워드 : <input type="text" value="꽃집" id="keyword" size="15">
                        </form>
                    </div>
                </div>
                <hr>
                <ul id="placesList"></ul>
                <div id="pagination"></div>
            </div>
        </div>


<br><br><br>
</section>

        <!-- 모달 팝업 -->
        <div class="background">
            <div class="window">
                <div class="popup">
                    <br>
                    <button id="close" onclick="closePop()" class="btn btn-success" style="float: right;">닫기</button>
                    <br><br>
                    <div class="plant-detail"></div>
                    <br><br>
                    <h2 class="modal-ttl">분양 준비하기</h2>
                    <p class="modal-txt">인터넷을 통해 간단히 입양을 준비해보세요</p>
                    <div class="plant-shop"></div><br>
                    <div class="soil-shop"></div><br>
                    <p class="modal-txt">Tip! <br> 화분은 분양 받을 식물 크기에 비교해 가로는 5cm 크게, 세로는 1/3 작아야 적합해요.</p>
                    <div class="pot-shop"></div><br>
                </div>
            </div>
        </div>

<!-- Footer -->
<footer class="footer text-faded text-center py-5">
    <div class="container"><p class="m-0 small">tile image 작가 kues1 출처 Freepik
                            <br> Copyright &copy; Plantery 2023</p></div>
</footer>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${mapApiKey}&libraries=services"></script>
<script src="/js/KakaoFlower.js"></script>
</body>
</html>