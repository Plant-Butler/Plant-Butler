<%@ page import="com.plant.vo.UserVo" %><%--
  Created by IntelliJ IDEA.
  User: BIT
  Date: 2023-05-01
  Time: 오후 7:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
    UserVo userVo = (UserVo) session.getAttribute("user");
    String userId = userVo.getUserId();
%>
<html>
<head>
    <title>Title</title>
    <script type="module" src="../mainscript.js"></script>
</head>
<body>
<h1>스케쥴 등록하기 폼</h1>
</body>

<form action="/myplants/${myplantId}/schedule/form" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <table>
    <tr><td></td><td><input type="hidden" name = "myplantId" value="${myplantId}"></td><td></td></tr>
    <tr><td></td><td><input type="text" name = "userId" value="<%=userId%>"></td><td></td></tr>
    <tr><td>물주기</td><td><input type="checkbox" name ="watering" value="1"></td><td></td></tr>
        <tr><td>가지치기</td><td><input type="checkbox" name ="prun" value="1"></td><td></td></tr>
        <tr><td>영양제</td><td><input type="checkbox" name ="nutri" value="1"></td><td></td></tr>
        <tr><td>분갈이</td><td><input type="checkbox" name ="soil" value="1"></td><td></td></tr>
        <tr><td>환기</td><td><input type="checkbox" name ="ventilation" value="1"></td><td></td></tr>
        <tr><td><button type="submit">제출하기</button></td></tr>
    </table>

</form>



</html>
