<%--
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
<html>
<head>
    <title>myplants</title>
</head>
<body>

<h1>myplants</h1>
<h2>Plant List Size: ${fn:length(plantList)}</h2>
<table>
    <tbody>
    <c:forEach var="list" items="${plantList}">
        <tr>
            <td>${list.myplantNick}</td>
            <td>${list.myplantId}</td>
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
