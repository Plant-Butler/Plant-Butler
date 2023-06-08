<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-05-16
  Time: 오전 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Title</title>
    <%@ include file="../main/header.jsp" %>
    <script>
        var csrfToken = "${_csrf.token}";
        var csrfHeader = "${_csrf.headerName}";
    </script>
    <script>
        function deletePush(myplantId,alarmType) {
            const url = '/myplants/' + myplantId + '/schedule/push/delete/'+ alarmType;
            fetch(url, {
                method: 'DELETE',
                headers: {
                    [csrfHeader]: csrfToken // CSRF 토큰을 요청 헤더에 추가
                }
            }).then(response => {
                if (response.ok) {
                    console.log(url);
                    location.reload();
                } else {
                    alert('Error: ' + response.statusText);
                }
            }).catch(error => {
                console.error('Error:', error);
            });
        }

    </script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <script type="module" src="/js/tokenscript.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/myplantDetail.css">
</head>
<body style="margin-top: 200px; display:flex; flex-direction: column;" data-user-id="${userId}">
<h1 style="font-family: 'LINESeedKR-Bd', sans-serif; text-align: center;">알람 설정하기</h1>
<div style="width : 1500px; text-align: right">
<button class="btn btn-primary" style="width: 120px; margin-left: 10px;  font-size : 15px; background-color: #198754 !important;"
        id="button1">물주기
</button>
<button style="width: 120px; margin-left: 10px; font-size : 15px;  background-color: #198754 !important;" class="btn btn-primary"
        id="button2">영양제주기
</button>
<button style="width: 120px; margin-left: 10px; font-size : 15px; background-color: #198754 !important;" class="btn btn-primary"
        id="button3">가지치기
</button>
</div>

<div id="waterdiv" class="pushdiv"
     style="width:1000px; height: 600px;  margin: 0 auto;  border-radius: 30px;  border: 3px solid #157347;">
    <form action="/myplants/${myplantId}/schedule/push" method="post">
        <p style="text-align: center">물주기</p>
        <p style="text-align: center;">이 식물의 물주기 알람 설정 주기는 ${myplantvo.webPushDate}일 간격으로 ${myplantvo.webPushTime}시에 울립니다</p>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><br>
        <h4 style="font-family: 'LINESeedKR-Bd', sans-serif; text-align: center;"><fmt:formatDate value="${now}"
                                                                                                  type="both"
                                                                                                  pattern="yyyy-MM-dd "/>
            부터 </h4><br>
        <div style="text-align: center;">
            <input type="text" id="dayInput" name="dayInput" required>
            일 간격으로
            <input type="time" id="timeInput" name="timeInput" required> 시에
            <button class="btn btn-primary" style="margin-left: 50px; background-color: #198754 !important;"
                    type="submit">알림 설정하기
            </button>
            <input hidden="hidden" name="water" value="water">
            <button class="btn btn-primary"
                    style="width: 120px; margin-left: 30px;  background-color: #198754 !important;" type="button"
                    onclick="deletePush(${myplantId},'water')">알람 초기화
            </button>
            <input type="hidden" name="userId" value="${userId}">
            <p>화분에 손가락을 2~3cm 찔러 넣었을 때 흙이 말라있다면 물을 줄 시기에요.<br>
                처음에는 주기를 1~2일로 짧게 설정한 후, 흙의 상태를 봐가며 주기를 조정하세요.<br>
                상세페이지의 '계절별 물 주는 시기' 정보를 참고하여 상황에 맞게 주기를 고르시면 되요.
            </p>

        </div>
    </form>
</div>
<div id="drugdiv" class="pushdiv"
     style="width:1000px; height: 600px;  margin: 0 auto;  border-radius: 30px;  border: 3px solid #157347;">
    <form action="/myplants/${myplantId}/schedule/push2" method="post">
        <p style="text-align: center">영양제주기</p>
        <p style="text-align: center;">이 식물의 영양제 주기 알람 설정 주기는 ${myplantvo.webPushDate2}일 간격으로 ${myplantvo.webPushTime2}시에 울립니다</p>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><br>
        <h4 style="font-family: 'LINESeedKR-Bd', sans-serif; text-align: center;"><fmt:formatDate value="${now}"
                                                                                                  type="both"
                                                                                                  pattern="yyyy-MM-dd "/>
            부터 </h4><br>
        <div style="text-align: center;">
            <input type="text" id="dayInput2" name="dayInput" required>
            일 간격으로
            <input type="time" id="timeInput2" name="timeInput" required> 시에
            <button class="btn btn-primary" style="margin-left: 50px; background-color: #198754 !important;"
                    type="submit">알림 설정하기
            </button>
            <input hidden="hidden" name="drug" value="drug">
            <button class="btn btn-primary"
                    style="width: 120px; margin-left: 30px;  background-color: #198754 !important;" type="button"
                    onclick="deletePush(${myplantId},'drug')">알람 초기화
            </button>
            <input type="hidden" name="userId" value="${userId}">
            <p>화분에 손가락을 2~3cm 찔러 넣었을 때 흙이 말라있다면 물을 줄 시기에요.<br>
                처음에는 주기를 1~2일로 짧게 설정한 후, 흙의 상태를 봐가며 주기를 조정하세요.<br>
                상세페이지의 '계절별 물 주는 시기' 정보를 참고하여 상황에 맞게 주기를 고르시면 되요.
            </p>

        </div>
    </form>
</div>

<div id="cutdiv" class="pushdiv"
     style="width:1000px; height: 600px;  margin: 0 auto;  border-radius: 30px;  border: 3px solid #157347;">
    <form action="/myplants/${myplantId}/schedule/push3" method="post">
        <p style="text-align: center">가지치기</p>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/><br>
        <h4 style="font-family: 'LINESeedKR-Bd', sans-serif; text-align: center;"><fmt:formatDate value="${now}"
                                                                                                  type="both"
                                                                                                  pattern="yyyy-MM-dd "/>
            부터 </h4><br>
        <div style="text-align: center;">
            <input type="text" id="dayInput3" name="dayInput" required>
            일 간격으로
            <input type="time" id="timeInput3" name="timeInput" required> 시에
            <button class="btn btn-primary" style="margin-left: 50px; background-color: #198754 !important;"
                    type="submit">알림 설정하기
            </button>
            <button class="btn btn-primary"
                    style="width: 120px; margin-left: 30px;  background-color: #198754 !important;" type="button"
                    onclick="deletePush(${myplantId})">알람 초기화
            </button>
            <input type="hidden" name="userId" value="${userId}">
            <p>화분에 손가락을 2~3cm 찔러 넣었을 때 흙이 말라있다면 물을 줄 시기에요.<br>
                처음에는 주기를 1~2일로 짧게 설정한 후, 흙의 상태를 봐가며 주기를 조정하세요.<br>
                상세페이지의 '계절별 물 주는 시기' 정보를 참고하여 상황에 맞게 주기를 고르시면 되요.
            </p>

        </div>
    </form>
</div>
<script>
    $(document).ready(function () {
        $(".pushdiv").hide(); // hide all contents
        $("#waterdiv").fadeIn(); // fade in the first content

        $("#button1").click(function () {
            $(".pushdiv").hide(); // hide all contents
            $("#waterdiv").fadeIn(); // fade in the first content
        });
        $("#button2").click(function () {
            $(".pushdiv").hide(); // hide all contents
            $("#drugdiv").fadeIn(); // fade in the second content
        });
        $("#button3").click(function () {
            $(".pushdiv").hide(); // hide all contents
            $("#cutdiv").fadeIn(); // fade in the third content
        });
    });
</script>
</body>
</html>
