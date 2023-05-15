<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 찾기</title>
<%@ include file="../main/header.jsp" %>
<style>
    table, td {
        text-align: center;
        margin-left:auto;
        margin-right:auto;
        border: 1px solid;
    }
    .background {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100vh;
        background-color: rgba(0, 0, 0, 0.3);
        z-index: 1000;

        z-index: -1;
        opacity: 0;
    }

    .show {
        opacity: 1;
        z-index: 1200;
        transition: all 0.5s;
    }

    .window {
        position: relative;
        width: 100%;
        height: 100%;
    }

    .popup {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: #ffffff;
        box-shadow: 0 2px 7px rgba(0, 0, 0, 0.3);

        width: 1200px;
        height: 800px;

    }

    .show .popup {
        transform: translate(-50%, -50%);
        transition: all 0.5s;
    }
</style>
<script>

    // 쿼리스트링 제외
    history.replaceState({}, null, location.pathname);

    // 팝업창 열기
    function show(distbNm, sentence, frtlzrInfo, soilInfo, grwhTpCodeNm, winterLwetTpCodeNm, hdCodeNm,
                    watercycleSprngCodeNm, watercycleSummerCodeNm, watercycleAutumnCodeNm, watercycleWinterCodeNm,
                    postngplaceCodeNm) {
      let distbNmBox = document.getElementById("distbNm");              let winterLwetTpCodeNmBox = document.getElementById("winterLwetTpCodeNm");
      let sentenceBox = document.getElementById("sentence");            let watercycleSprngCodeNmBox = document.getElementById("watercycleSprngCodeNm");
      let frtlzrInfoBox = document.getElementById("frtlzrInfo");        let watercycleSummerCodeNmBox = document.getElementById("watercycleSummerCodeNm");
      let soilInfoBox = document.getElementById("soilInfo");            let watercycleAutumnCodeNmBox = document.getElementById("watercycleAutumnCodeNm");
      let grwhTpCodeNmBox = document.getElementById("grwhTpCodeNm");    let watercycleWinterCodeNmBox = document.getElementById("watercycleWinterCodeNm");
      let hdCodeNmBox = document.getElementById("hdCodeNm");            let postngplaceCodeNmBox = document.getElementById("postngplaceCodeNm");

      distbNmBox.innerText = distbNm;           winterLwetTpCodeNmBox.innerText = winterLwetTpCodeNm;
      sentenceBox.innerText = sentence;         watercycleSprngCodeNmBox.innerText = watercycleSprngCodeNm;
      frtlzrInfoBox.innerText = frtlzrInfo;     watercycleSummerCodeNmBox.innerText = watercycleSummerCodeNm;
      soilInfoBox.innerText = soilInfo;         watercycleAutumnCodeNmBox.innerText = watercycleAutumnCodeNm;
      grwhTpCodeNmBox.innerText = grwhTpCodeNm; watercycleWinterCodeNmBox.innerText = watercycleWinterCodeNm;
      hdCodeNmBox.innerText = hdCodeNm;         postngplaceCodeNmBox.innerText = postngplaceCodeNm;

      document.querySelector(".background").className = "background show";
    }

    // 팝업창 닫기
    function closePop() {
      document.querySelector(".background").className = "background";
    }

</script>
</head>
<body>
<body style="text-align: center">
${user.nickname}님에게 어울리는 식물이에요. <br><br>

    <c:forEach var="plant" items="${resultList}">
        <table width="1500" height="250">
            <tr>
                <!-- <th colspan="2"><img class="plantImg" src="/uploads/${plant.image}"></th> -->
            </tr>
            <tr>
                <th colspan="2">${plant.plntzrNm} ${plant.distbNm}</th>
            </tr>
            <tr>
                <td colspan="2"><button id="show" onclick='show("${fn:escapeXml(plant.distbNm)}", "${plant.sentence}", "${plant.frtlzrInfo}", "${plant.soilInfo}",
                                                                "${plant.grwhTpCodeNm}", "${plant.winterLwetTpCodeNm}", "${plant.hdCodeNm}", "${plant.watercycleSprngCodeNm}",
                                                                "${plant.watercycleSummerCodeNm}", "${plant.watercycleAutumnCodeNm}", "${plant.watercycleWinterCodeNm}",
                                                                "${plant.postngplaceCodeNm}")'>이 식물 분양 준비하기</button></td>
            </tr>
        </table>
    </c:forEach>

<div class="background">
    <div class="window">
        <div class="popup">
             <button id="close" onclick="closePop()">창 닫기</button>
                 <table>
                    <tr><td colspan="4" id="distbNm"></td></tr>
                    <tr><td colspan="4" id="sentence"></td></tr>
                    <tr>
                        <td>비료</td><td id="frtlzrInfo"></td>
                        <td>토양</td><td id="soilInfo"></td>
                    </tr>
                    <tr>
                        <td>생육온도</td><td id="grwhTpCodeNm"></td>
                        <td>겨울최저온도</td><td id="winterLwetTpCodeNm"></td>
                    </tr>
                    <tr>
                        <td>물주기 봄</td><td id="watercycleSprngCodeNm"></td>
                        <td>물주기 여름</td><td id="watercycleSummerCodeNm"></td>
                    </tr>
                    <tr>
                        <td>물주기 가을</td><td id="watercycleAutumnCodeNm"></td>
                        <td>물주기 겨울</td><td id="watercycleWinterCodeNm"></td>
                    </tr>
                    <tr>
                        <td>습도</td><td id="hdCodeNm"></td>
                        <td>배치 장소</td><td id="postngplaceCodeNm"></td>
                    </tr>
                 </table>
        </div>
    </div>
</div>
</body>
</html>