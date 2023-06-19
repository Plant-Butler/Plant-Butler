<title>myplants</title>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ include file="../main/header.jsp" %>

<head>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <link href="https://fonts.cdnfonts.com/css/sf-ui-text-2" rel="stylesheet">
    <link rel="stylesheet" href="../css/myplantStyle.css">
    <link rel="stylesheet" href="../css/card.css">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
    <meta name="_csrf" content="${_csrf.token}">
    <meta name="_csrf_header" content="${_csrf.headerName}">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script>
        async function fetchDataFromServer(cityName) {
            var encodedCityName = encodeURIComponent(cityName);
            console.log("encodedCityName:", encodedCityName);

            try {
                var response = await fetch(`http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty?serviceKey=${mise}&numOfRows=100&returnType=json&sidoName=`+encodedCityName);
                var data = await response.json();
                console.log("Fetched data:", data);

                return data;
             } catch (error) {
                console.error('Error:', error);
                throw error;
            }
        }
    </script>
    <script src="js/myplant.js"></script>
    <script>

        async function fetchWeatherDataFromServer(x ,y) {
            var x = x;
            var y = y;
            var date = new Date();  // 현재 날짜와 시간을 가져옵니다.

            var year = date.getFullYear();  // 연도를 가져옵니다.
            var month = date.getMonth() + 1;  // 월을 가져옵니다. 월은 0부터 시작하므로 1을 더해야 합니다.
            var day = date.getDate();  // 일을 가져옵니다.

            var date = new Date();
            var hours = date.getHours();
            var hoursMinusTwo = hours - 1;
            var time = (hoursMinusTwo < 10 ? '0' + hoursMinusTwo : hoursMinusTwo) + '00';

// 월과 일이 한 자릿수일 경우 앞에 '0'을 붙입니다.
            if (month < 10) month = '0' + month;
            if (day < 10) day = '0' + day;

// 날짜를 'YYYYMMdd' 형식의 문자열로 변환합니다.
            var formattedDate = '' + year + month + day;

            var rs = dfs_xy_conv("toXY",y,x);
            console.log(rs.x, rs.y);

            try {
                var response = await fetch('http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=${gisang}&numOfRows=60&dataType=JSON&pageNo=1&base_date='+formattedDate+'&base_time='+time+'&nx='+rs.x+'&ny='+rs.y);
                console.log(response);
                var data = await response.json();
                console.log("Fetched data:", data);

                return data;
            } catch (error) {
                console.error('Error:', error);
                throw error;
            }
        }
    </script>
</head>
<body style="margin-top: 150px;">
<style>
    @font-face {
        font-family: 'KimjungchulGothic-Bold';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302_01@1.0/KimjungchulGothic-Bold.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }
    .map_wrap {position:relative;width:30%;height:350px; border-radius: 50px; margin-top: 30px; visibility: hidden;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    .smallbutton{
        font-family: 'KimjungchulGothic-Bold';
        display: inline-block;
        padding: 8px 16px;
        font-size: 17px;
        text-align: center;
        text-decoration: none;
        border: none;
        border-radius: 4px;
        background-color: #198754;
        color: white;
        cursor: pointer;
        margin-right: 10px;
        margin-bottom: 10px;
        background-color: #198754 !important;
    }
    .smallbutton:hover {
        background-color: #45a049 !important;
    }
    .inbox{
        text-decoration: none;
        font-size: 14px;
    }

    .inbox2{
        text-decoration: none;
        margin-left: 150px;
        font-size: 14px;
    }
</style>

<br>
<div id="bodyContainer">
    <div>
        <div id="cityName" style="font-family: 'LINESeedKR-Bd', sans-serif; font-size: 30px; font-weight: bold;"></div>

        <div id="t1hValueContainer"></div><div id="skyValueContainer"></div>
        <div id="newContainer" style="border-left:3px solid rgba(128, 128, 128, 0.3);">
            <div id="rehValueContainer"></div>
            <div id ='rn1ValueContainer'></div>
        </div>
        <div id ='ptyValueContainer' hidden="hidden"></div>
        <div id="dataContainer" ></div>
    </div>
<div id="insertplant">
    <button type="button" class="smallbutton" onclick="window.location.href='/diagnosis'">질병/해충 진단</button>
    <button type="button" class="smallbutton" onclick="window.location.href='/myplants/form'">추가하기</button>
</div>
<div style="width: 1200px;">
    <c:forEach var="list" items="${plantList}">
        <div class="card" style="width: 30%;">
            <c:set var="images" value="${list.myplantImage}" />
            <div class="card-header" style="background-image: url(${images});">
                <c:if test="${list.represent==1}">
                    <div class = "card-header-is_closed">

                    </div >
                </c:if>

            </div>

            <div class="card-body">
                <div class="card-body-header" style="display: flex;">
                    <div style="width: 150px">
                    <h1 style="width:150px">${list.myplantNick}</h1>
                    <p class = "card-body-nickname" style="width: 150px">분양일 : ${list.firstDate}</p>
                    </div>
                    <div style="width: 150px; display: flex; justify-content: flex-end;">
                        <c:if test="${(endDate-list.scheduleDate)-1>=10}">
                            <img src="images/siren.png" style="width: 50px; height: 50px;">
                        </c:if>
                    </div>
                </div>

                <p class="card-body-description">
                    <a class="inbox" href="/myplants/${list.myplantId}/${list.plantId}">상세페이지</a>
                </p>

                <div class="card-body-footer">
                    <hr style="margin-bottom: 8px; opacity: 0.5; border-color: #EF5A31">
                    <div>
                        <a class="inbox" href="/myplants/${list.myplantId}/schedule">관리페이지</a>
                        <a class="inbox2" onclick="deleteMyPlant(${list.myplantId})" class="deleteLink">삭제하기</a>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;"></div>
    <div class="hAddr">
        <span class="title">지도중심기준 행정동 주소정보</span>
        <span id="centerAddr"></span>
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMap}&libraries=services"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/fuse.js/6.4.6/fuse.min.js"></script>
<script>
    navigator.geolocation.getCurrentPosition(function(position) {
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도


        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
                level: 1 // 지도의 확대 레벨


            };

        // 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
            infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

        // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
        searchAddrFromCoords(map.getCenter(), displayCenterInfo);

        // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
            searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
                    detailAddr += '<div>지번 주소 : ' + result[0].address.address_name + '</div>';

                    var content = '<div class="bAddr">' +
                        '<span class="title">법정동 주소정보</span>' +
                        detailAddr +
                        '</div>';

                    // 마커를 클릭한 위치에 표시합니다
                    marker.setPosition(mouseEvent.latLng);
                    marker.setMap(map);

                    // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
                    infowindow.setContent(content);
                    infowindow.open(map, marker);
                }
            });
        });

        // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
        kakao.maps.event.addListener(map, 'idle', function() {
            searchAddrFromCoords(map.getCenter(), displayCenterInfo);
        });

        function searchAddrFromCoords(coords, callback) {
            // 좌표로 행정동 주소 정보를 요청합니다
            geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
        }

        function searchDetailAddrFromCoords(coords, callback) {
            // 좌표로 법정동 상세 주소 정보를 요청합니다
            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
        }







        function clickCenter() {
            // 클릭 이벤트를 트리거합니다.
            kakao.maps.event.trigger(map, 'click', {
                latLng: map.getCenter()
            });
        }
        window.onload = clickCenter;



    });

</script>
</div>
</div>
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 150px; background-repeat: no-repeat; background-size: cover;">
    <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>
</body>
</div>
</html>