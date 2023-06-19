var csrfHeader = $("meta[name='_csrf_header']").attr("content");
var csrfToken = $("meta[name='_csrf']").attr("content");




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
                document.getElementById('cityName').textContent = result[i].address_name;
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
function displayData(fetchedData) {
    var dataContainer = document.getElementById('dataContainer');
    var items = fetchedData.response.body.items;
    var airvalue;
    switch (items[0].khaiGrade) {
        case '1':
            airvalue = '오늘의 통합대기환경등급은 "좋음"입니다\n환기하기 좋은 환경입니다!';
            break;
        case '2':
            airvalue = '오늘의 통합대기환경등급은 "보통"입니다\n환기를 하시되 너무 오래는 하지마세요';
            break;
        case '3':
            var airvalue = '오늘의 통합대기환경등급은 "나쁨"입니다\n창문을 열지 않는걸 추천해요';
            break;
        default:
            airvalue = '오늘의 통합대기환경등급은 "매우 나쁨"입니다\n문을 꼭 닫아 놓으세요';
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




var RE = 6371.00877; // 지구 반경(km)
var GRID = 5.0; // 격자 간격(km)
var SLAT1 = 30.0; // 투영 위도1(degree)
var SLAT2 = 60.0; // 투영 위도2(degree)
var OLON = 126.0; // 기준점 경도(degree)
var OLAT = 38.0; // 기준점 위도(degree)
var XO = 43; // 기준점 X좌표(GRID)
var YO = 136; // 기1준점 Y좌표(GRID)


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
    } else {
        rs['x'] = v1;
        rs['y'] = v2;
        var xn = v1 - XO;
        var yn = ro - v2 + YO;
        ra = Math.sqrt(xn * xn + yn * yn);
        if (sn < 0.0) -ra;
        var alat = Math.pow((re * sf / ra), (1.0 / sn));
        alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

        if (Math.abs(xn) <= 0.0) {
            theta = 0.0;
        } else {
            if (Math.abs(yn) <= 0.0) {
                theta = Math.PI * 0.5;
                if (xn < 0.0) -theta;
            } else theta = Math.atan2(xn, yn);
        }
        var alon = theta / sn + olon;
        rs['lat'] = alat * RADDEG;
        rs['lng'] = alon * RADDEG;
    }
    return rs;
}


function deleteMyPlant(myplantId) {
    const url = '/myplants/form/' + myplantId;
    fetch(url, {
        method: 'DELETE',
        headers: {
            [csrfHeader]: csrfToken // CSRF 토큰을 요청 헤더에 추가
        }
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









