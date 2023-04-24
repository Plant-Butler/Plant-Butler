<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test</title>
</head>
<body>
<a href="/test">글 쓰기</a>
	<h1>Test Data:</h1>
	<table>
			<tbody>
			<c:forEach var="list" items="${testList}">
			<tr>	
				<td> ${list.idx}</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>