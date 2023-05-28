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
<link rel="stylesheet" href="/css/recomResult.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/recomResult.js"></script>
</head>
<body style="text-align: center">
${user.nickname}님에게 어울리는 식물이에요. <br><br>

<c:forEach var="plant" items="${resultList}">
        <table width="1500" height="300">
            <tr>
                <!-- <th colspan="2"><img class="plantImg" src="/uploads/${plant.image}"></th> -->
            </tr>
            <tr>
                <th colspan="2">${plant.plntzrNm} ${plant.distbNm}</th>
            </tr>
            <tr>
                <td colspan="2"><button id="show" onclick='show(${plant.plant_id}, "${fn:escapeXml(plant.distbNm)}", "${plant.soilInfo}")'>이 식물 분양 준비하기</button></td>
            </tr>
        </table>
    <input type="hidden" name="plant_id" value="${plant.plant_id}">
</c:forEach>
<button onclick="savePlants()">저장하기</button>

<!-- 모달 팝업 -->
<div class="background">
    <div class="window">
        <div class="popup">
             <button id="close" onclick="closePop()">창 닫기</button><br><br>
                 <div class="plant-detail"></div>
                 <h3>분양 준비하기</h3> 사진을 클릭하면 구매처로 이동합니다.<br>
                <div class="plant-shop"></div><br>
                <div class="soil-shop"></div><br>
                화분은 분양 받을 식물 크기에 비교해 가로는 5cm 크게, 세로는 1/3 작아야 적합해요.
                <div class="pot-shop"></div><br>
        </div>
    </div>
</div>

<!-- 지도 -->
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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${mapApiKey}&libraries=services"></script>
<script src="/js/KakaoFlower.js"></script>
</body>
</html>