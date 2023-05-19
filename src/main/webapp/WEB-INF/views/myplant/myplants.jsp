<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-04-25
  Time: 오후 3:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<%@ include file="../main/header.jsp" %>
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
    <title>myplants</title>
</head>
<body>

<h1>myplants</h1>
<h2>Plant List Size: ${fn:length(plantList)}</h2>
<table>
    <tbody>
    <c:forEach var="list" items="${plantList}" >
        <tr>
            <td><a href="/myplants/${list.myplantId}&${list.plantId}">${list.myplantId}</a> </td>
            <td>${list.plantId}</td>
            <td>${list.userId}</td>
            <td>${list.myplantNick}</td>
            <td>${list.myplantImage}</td>
            <td>${list.myplantWeight}</td>
            <td>${list.myplantLength}</td>
            <td>${list.myplantDepth}</td>
            <td>${list.myplantRadius1}</td>
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
<div>
</div>
<div>
    <a href="/myplants/form">추가하기</a>

</div>

</body>
</html>