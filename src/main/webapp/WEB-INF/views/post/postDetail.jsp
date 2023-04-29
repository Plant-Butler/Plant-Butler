<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.plant.vo.UserVo"%>
<%@page import="com.plant.vo.PostVo"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티</title>
<%@ include file="../main/header.jsp" %>
</head>
<body>
	<%
	PostVo post = (PostVo) request.getAttribute("post");
	//UserVo user = (UserVo) session.getAttribute("user");
	%>

[제목] ${post.postTitle}  [닉네임] ${post.nickname}  [조회수] ${post.readCount} [댓글] [신고] ${post.flag} [날짜] <fmt:formatDate value="${post.postDate}" type="date"/>
<hr>
[분류] ${post.postTag}
<br><br>
${post.postContent}

<c:if test="${not empty post.postImage}">
이미지
	<img src="/images/${post.postImage}" />
</c:if>

<c:if test="${not empty post.postFile}">
[첨부파일]
     <a href='./download.do?fileName=<%=URLEncoder.encode(post.getPostFile(), "UTF-8")%>'>${post.postFile}</a>
</c:if>

<hr>

</body>
</html>