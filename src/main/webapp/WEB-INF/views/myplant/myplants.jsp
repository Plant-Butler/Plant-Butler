<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<head>
<%@ include file="../main/header.jsp" %>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <link href="https://fonts.cdnfonts.com/css/sf-ui-text-2" rel="stylesheet">
    <link rel="stylesheet"href="../css/myplant.css">
    <link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">
    <script>
        function deleteMyPlant(myplantId) {
            const url = '/myplants/form/' + myplantId;
            fetch(url, {
                method: 'DELETE',
            }).then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    alert('Error: ' + response.statusText);
                }
            }).catch(error => {
                console.error('Error:', error);
            });
        }
    </script>
    <style>
        .map_wrap {position:relative;width:30%;height:350px; border-radius: 50px; margin-top: 30px; }
        .title {font-weight:bold;display:block;}
        .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
        #centerAddr {display:block;margin-top:2px;font-weight: normal;}
        .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
    </style>
    <title>myplants</title>
</head>
<body>
<h1>내 식물 </h1>
<div id="insertplant">
    <a href="/myplants/form">추가하기</a>
</div>
<div>
<table>
    <tbody>
    <c:forEach var="list" items="${plantList}" >
        <tr>
            <td ><a href="/myplants/${list.myplantId}&${list.plantId}">${list.myplantId}</a> </td>
            <td hidden="hidden">${list.plantId}</td>
            <td hidden="hidden">${list.userId}</td>
            <td>${list.myplantNick}</td>
            <td hidden="hidden">${list.myplantImage}</td>
            <td hidden="hidden">${list.myplantPot}</td>
            <td hidden="hidden">${list.myplantLength}</td>
            <td hidden="hidden">${list.myplantRadius1}</td>
            <td>${list.firstDate}</td>
            <c:choose>
                <c:when test="${(endDate-list.scheduleDate)-1>=10}">
                    <td>경고</td>
                </c:when>
                <c:otherwise>
                    <td></td>
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${list.represent==1}">
                    <td>대표식물</td>
                </c:when>
                <c:otherwise>
                    <td></td>
                </c:otherwise>
            </c:choose>
            </td>
            <td><a href="/myplants/${list.myplantId}/schedule">${list.myplantNick}의 관리페이지</a></td>
            <td><button class="deleteBtn" onclick="deleteMyPlant(${list.myplantId})">삭제하기</button></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>

<div id="dataContainer" ></div>
<div id="t1hValueContainer"></div><div id="skyValueContainer"></div>
<div id="newContainer">
    <div id="rehValueContainer"></div>
    <div id ='rn1ValueContainer'></div>
</div>
<div id ='ptyValueContainer' hidden="hidden"></div>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
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

        async function displayCenterInfo(result, status) {
            if (status === kakao.maps.services.Status.OK) {
                var infoDiv = document.getElementById('centerAddr');

                for (var i = 0; i < result.length; i++) {
                    // 행정동의 region_type 값은 'H' 이므로
                    if (result[i].region_type === 'H') {
                        infoDiv.innerHTML = result[i].address_name;

                        // "시" 이름을 추출하고 데이터를 가져옵니다.
                        var cityName = result[i].region_1depth_name;
                        var address = result[i].address_name;
                        var x = result[i].x;
                        var y = result[i].y;
                        var list = ['서울', '부산', '대구', '인천', '광주', '대전', '울산', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주', '세종'];
                        console.log(result[i].address_name);
                        console.log((result[i].x));
                        console.log((result[i].y));
                        var fuzzyresult = fuzzySearch(list,cityName);
                        console.log("Calling fetchDataFromServer with cityName:", fuzzyresult[0].item);
                        var fetchedData = await fetchDataFromServer(fuzzyresult[0].item);
                        var fetchedWeatherData = await fetchWeatherDataFromServer(x,y);
                        console.log(fetchedWeatherData);
                        displayData(fetchedData);
                        displayWeatherData(fetchedWeatherData);
                        break;
                    }
                }
            }
        }

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
        function displayData(fetchedData) {
            var dataContainer = document.getElementById('dataContainer');
            var items = fetchedData.response.body.items;
            var airvalue;
            switch (items[0].khaiGrade) {
                case '1':
                    airvalue = '오늘의 통합대기환경등급은 "좋음"입니다 환기하기 좋은 환경입니다!';
                    break;
                case '2':
                    airvalue = '오늘의 통합대기환경등급은 "보통"입니다 환기를 하시되 너무 오래는 하지마세요';
                    break;
                case '3':
                    var airvalue = '오늘의 통합대기환경등급은 "나쁨"입니다 창문을 열지 않는걸 추천해요';
                    break;
                default:
                    airvalue = '오늘의 통합대기환경등급은 "매우 나쁨"입니다 문을 꼭 닫아 놓으세요';
                    break;
            }


            dataContainer.innerText = airvalue;
        }
        function displayWeatherData(fetchedData) {
            var items = fetchedData.response.body.items.item;

            var t1hValue, skyValue, rehValue, ptyValue, rn1Value;
            var foundCategories = {};
            var skyElement = document.getElementById('t1hValueContainer');

            for (var i = 0; i < items.length; i++) {
                var category = items[i].category;

                // 이미 찾은 카테고리는 무시합니다.
                if (foundCategories[category]) continue;

                if (category === 'T1H') {
                    t1hValue = items[i].fcstValue + '°C';
                    foundCategories[category] = true;
                } else if (category === 'SKY') {
                    switch (items[i].fcstValue) {
                        case '1':
                            skyValue = "맑음";
                            skyElement.className = "clear";
                            break;
                        case '3':
                            skyValue = "구름많음";
                            skyElement.className = "cloudy";
                            break;
                        default:
                            skyValue = "흐림";
                            skyElement.className = "overcast";
                            break;
                    }
                    foundCategories[category] = true;
                } else if (category === 'REH') {
                    rehValue = '습도 : ' + items[i].fcstValue + '%';
                    foundCategories[category] = true;
                } else if (category === 'PTY') {
                    switch (items[i].fcstValue) {
                        case '0':
                            ptyValue = "비안옴";
                            break;
                        case '1':
                            ptyValue = "비";
                            break;
                        case '2':
                            ptyValue = "비/눈";
                            break;
                        case '3':
                            ptyValue = "눈";
                            break;
                        case '5':
                        case '6':
                            ptyValue = "빗방울";
                            break;
                        default:
                            ptyValue = "진눈깨비";
                    }
                    foundCategories[category] = true;
                } else if (category === 'RN1') {
                    rn1Value = '강수량 : ' + items[i].fcstValue;
                    foundCategories[category] = true;
                }

                // 모든 카테고리를 찾았다면 루프를 종료합니다.
                if (Object.keys(foundCategories).length === 5) {
                    break;
                }
            }

            document.getElementById('t1hValueContainer').innerText = t1hValue;
            document.getElementById('skyValueContainer').innerText = skyValue;
            document.getElementById('rehValueContainer').innerText = rehValue;
            document.getElementById('ptyValueContainer').innerText = ptyValue;
            document.getElementById('rn1ValueContainer').innerText = rn1Value;
        }





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


        function clickCenter() {
            // 클릭 이벤트를 트리거합니다.
            kakao.maps.event.trigger(map, 'click', {
                latLng: map.getCenter()
            });
        }
        window.onload = clickCenter;



    });



</script>

<script language="javascript">
    //<!--
    //
    // LCC DFS 좌표변환을 위한 기초 자료
    //
    var RE = 6371.00877; // 지구 반경(km)
    var GRID = 5.0; // 격자 간격(km)
    var SLAT1 = 30.0; // 투영 위도1(degree)
    var SLAT2 = 60.0; // 투영 위도2(degree)
    var OLON = 126.0; // 기준점 경도(degree)
    var OLAT = 38.0; // 기준점 위도(degree)
    var XO = 43; // 기준점 X좌표(GRID)
    var YO = 136; // 기1준점 Y좌표(GRID)
    //
    // LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
    //


    function dfs_xy_conv(code, v1, v2) {
        var DEGRAD = Math.PI / 180.0;
        var RADDEG = 180.0 / Math.PI;

        var re = RE / GRID;
        var slat1 = SLAT1 * DEGRAD;
        var slat2 = SLAT2 * DEGRAD;
        var olon = OLON * DEGRAD;
        var olat = OLAT * DEGRAD;

        var sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
        var sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
        sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
        var ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
        ro = re * sf / Math.pow(ro, sn);
        var rs = {};
        if (code == "toXY") {
            rs['lat'] = v1;
            rs['lng'] = v2;
            var ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
            ra = re * sf / Math.pow(ra, sn);
            var theta = v2 * DEGRAD - olon;
            if (theta > Math.PI) theta -= 2.0 * Math.PI;
            if (theta < -Math.PI) theta += 2.0 * Math.PI;
            theta *= sn;
            rs['x'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
            rs['y'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
        }
        else {
            rs['x'] = v1;
            rs['y'] = v2;
            var xn = v1 - XO;
            var yn = ro - v2 + YO;
            ra = Math.sqrt(xn * xn + yn * yn);
            if (sn < 0.0) - ra;
            var alat = Math.pow((re * sf / ra), (1.0 / sn));
            alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

            if (Math.abs(xn) <= 0.0) {
                theta = 0.0;
            }
            else {
                if (Math.abs(yn) <= 0.0) {
                    theta = Math.PI * 0.5;
                    if (xn < 0.0) - theta;
                }
                else theta = Math.atan2(xn, yn);
            }
            var alon = theta / sn + olon;
            rs['lat'] = alat * RADDEG;
            rs['lng'] = alon * RADDEG;
        }
        return rs;
    }
    //-->
</script>
<script>
    function fuzzySearch(list, searchTerm) {
        // Fuse.js 설정.
        const options = {
            includeScore: true,
            threshold: 1,  // 값 조정
            minMatchCharLength: 2,
        };

        // Fuse.js 객체 생성.
        const fuse = new Fuse(list, options);

        // 검색 실행.
        const result = fuse.search(searchTerm);

        // 결과 반환.
        return result;
    }
</script>

</body>
</html>