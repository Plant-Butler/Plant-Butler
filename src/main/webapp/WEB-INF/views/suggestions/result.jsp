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
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/recomResult.css">
</head>
<body style="text-align: center">
<div class="white-box cta">

    <div class="container">
        <div class="row">
            <div class="col-xl-9 mx-auto">
                <h1>${nickname}님에게 어울리는 식물이에요.</h1> <br><br>
            </div>
        </div>
        <c:forEach var="plant" items="${resultList}">
                <table>
                    <tr>
                        <th colspan="2"><img class="plantImg img-thumbnail" src="/uploads/${plant.image}"></th>
                    </tr>
                    <tr>
                        <th>${plant.plntzrNm} ${plant.distbNm}</th>
                    </tr>
                    <tr>
                        <td><button id="show" onclick='show(${plant.plant_id}, "${fn:escapeXml(plant.distbNm)}", "${plant.soilInfo}")' class="btn btn-outline-success">분양 준비하기</button></td>
                    </tr>
                </table>
                <br>
            <input type="hidden" name="plant_id" value="${plant.plant_id}">
        </c:forEach>
        <br><br><br>
        <button onclick="savePlants()" class="btn btn-outline-success">마이페이지에 저장</button>
        <br><br><br><br><br>
    </div>


        <!-- 지도 -->
        <div class="row">
            <div class="col-xl-9 mx-auto">
                <h1>근처에서 바로 입양을 준비해볼까요?</h1>
            </div>
        </div>
        <div class="map_wrap">
            <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
            <div id="menu_wrap" class="bg_white">
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
</div>

        <!-- 모달 팝업 -->
        <div class="background">
            <div class="window">
                <div class="popup">
                     <button id="close" onclick="closePop()">X</button><br><br>
                         <div class="plant-detail"></div>
                         <br>
                         <h3>분양 준비하기</h3> 사진을 클릭하면 구매처로 이동합니다.<br>
                        <div class="plant-shop"></div><br>
                        <div class="soil-shop"></div><br>
                        화분은 분양 받을 식물 크기에 비교해 가로는 5cm 크게, 세로는 1/3 작아야 적합해요.
                        <div class="pot-shop"></div><br>
                </div>
            </div>
        </div>

<!-- Footer -->
<footer class="footer text-faded text-center py-5">
    <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${mapApiKey}&libraries=services"></script>
<script src="/js/KakaoFlower.js"></script>
</body>
</html>