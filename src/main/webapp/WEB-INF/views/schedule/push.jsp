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
    <%@ include file="../main/header.jsp" %>
    <%
        String userId = userVo.getUserId();
    %>
    <script>
        var csrfToken = "${_csrf.token}";
        var csrfHeader="${_csrf.headerName}";
    </script>
    <script>
        function deletePush(myplantId) {
            const url = '/myplants/'+${myplantId} +"/schedule/push/delete";
            var csrfToken = '${_csrf.token}';
            var csrfHeader = '${_csrf.headerName}';

            fetch(url,{
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

    </script>
    <script type="module" src="/js/tokenscript.js"></script>
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
