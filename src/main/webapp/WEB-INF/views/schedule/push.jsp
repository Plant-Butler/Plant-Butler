<%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-05-16
  Time: 오전 10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<html>
<head>
    <title>Title</title>
    <script type="module" src="/js/mainscript.js"></script>
    <%@ include file="../main/header.jsp" %>
    <%
        String userId = userVo.getUserId();
    %>

    <script>
        function deletePush(myplantId) {
            const url = '/myplants/'+${myplantId} +"/schedule/push/delete";
            fetch(url,{
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
    <script type="module">
        import { initializeApp } from 'https://www.gstatic.com/firebasejs/9.22.0/firebase-app.js';
        import { getMessaging, getToken } from 'https://www.gstatic.com/firebasejs/9.22.0/firebase-messaging.js';
        const firebaseConfig = {
            apiKey: "AIzaSyCKyFlG1N4vK5l0OyAjgDbO1pGuxLaiOt4",
            authDomain: "plant-butler-c4fd9.firebaseapp.com",
            projectId: "plant-butler-c4fd9",
            storageBucket: "plant-butler-c4fd9.appspot.com",
            messagingSenderId: "451724146100",
            appId: "1:451724146100:web:153ea324ff6f8c0ec12ee1",
            measurementId: "G-CKME0S96GE"
        };

        const app = initializeApp(firebaseConfig);
        const messaging = getMessaging(app);
        console.log(app);


        getToken(messaging)
            .then((currentToken) => {
                if (currentToken) {
                    console.log('Token: ', currentToken);
                    localStorage.setItem("token",currentToken);
                    // Send the token to your server and update the UI if necessary
                    // ...
                } else {
                    console.log('No registration token available. Request permission to generate one.');
                    // Show permission request UI
                    // ...
                }
            })
            .catch((err) => {
                console.log('An error occurred while retrieving token. ', err);
                // Show a message explaining the error and asking the user to check the console
                // ...
            });

    </script>
</head>
<body>
<h1>푸시페이지</h1>

<form action="/myplants/${myplantId}/schedule/push" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <h3>물주기 <fmt:formatDate value="${now}" type="both" pattern="yyyy-MM-dd "/> 부터 </h3>
    <input type="text" id="dayInput" name="dayInput">
    일 간격으로
    <input type="time" id="timeInput" name="timeInput">
    에 알림받기
    <input type="hidden" id="userId" name="userId" value="<%=userId%>">
    <br>
    <input type="submit" value="설정하기">
</form>
    <input type="button" onclick="deletePush(${myplantId})" value="알람 초기화">

<p>이 식물의 알람 설정 주기는 ${myplantvo.webPushDate}일 간격으로 ${myplantvo.webPushTime}시에 울립니다</p>
</body>
</html>
