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

    td {
        width: 40%
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
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
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


    // 마이페이지에 저장
    function savePlants() {
        let idxList = "";

        $( "input[name='plant_id']" ).each (function (){
             idxList = idxList + $(this).val() + "," ;
        });

        idxList = idxList.substring(0, idxList.lastIndexOf(","));
        console.log(idxList);

        $.ajax({
             url:  "/suggestions/result",
             type: "POST",
             data: { idxList: idxList },
             success: function(response) {
                   if(response) {
                        alert('저장되었습니다.');
                   } else {
                        alert('저장에 실패하였습니다.');
                   }
             },
             error: function(request, status, error) {
                   alert('오류가 발생했습니다.');
                   console.log("code: " + request.status)
                   console.log("message: " + request.responseText)
                   console.log("error: " + error);
             }
        });
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
    <input type="hidden" name="plant_id" value="${plant.plant_id}">
</c:forEach>
<button onclick="savePlants()">저장하기</button>



<div class="background">
    <div class="window">
        <div class="popup">
             <button id="close" onclick="closePop()">창 닫기</button><br><br>
                 <table>
                    <tr><td colspan="4" id="distbNm"></td></tr>
                    <tr><td colspan="4" id="sentence"></td></tr>
                    <tr>
                        <th>비료</th><td id="frtlzrInfo"></td>
                        <th>토양</th><td id="soilInfo"></td>
                    </tr>
                    <tr>
                        <th>생육온도</th><td id="grwhTpCodeNm"></td>
                        <th>겨울최저온도</th><td id="winterLwetTpCodeNm"></td>
                    </tr>
                    <tr>
                        <th>물주기 봄</th><td id="watercycleSprngCodeNm"></td>
                        <th>물주기 여름</th><td id="watercycleSummerCodeNm"></td>
                    </tr>
                    <tr>
                        <th>물주기 가을</th><td id="watercycleAutumnCodeNm"></td>
                        <th>물주기 겨울</th><td id="watercycleWinterCodeNm"></td>
                    </tr>
                    <tr>
                        <th>습도</th><td id="hdCodeNm"></td>
                        <th>배치 장소</th><td id="postngplaceCodeNm"></td>
                    </tr>
                 </table>
        </div>
    </div>
</div>
</body>
</html>