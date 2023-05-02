<%@page import="com.plant.vo.UserVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.plant.vo.PostVo"%>
<%@ include file="../main/header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>상세페이지</title>
<script type="text/javascript">
	function goURL(type){
		let form = document.getElementById("frm");
		form.action = "./form?postId=${post.postId}";
		if(type==1){
			form.action = "./deletePost?postId=${post.postId}";
		}
		form.submit();
	}
</script>
</head>

<body>
<div class="about-section">
  <h1>Post Detail</h1>
  <p style="text-align:right;"><a class = "submit_detail" href='<c:url value='./list?page=${page}'/>'>목록으로</a><p>
</div>

<br><br>
	<%
	PostVo temp = (PostVo) request.getAttribute("postId");
	UserVo user = (UserVo) session.getAttribute("user");
	%>
	<form action="./cmain" method="post" id="frm">
		<input type="hidden" name="postId" value="<%=temp%>">
		<div class = "form_table">
		 <div>
                <h4 class = "title">제목</h4>
                <td>${post.postTitle}</td>
            </div>
            <br>
            <div>
                <h4 class = "title">내용</h4>
                <td>${post.postContent}</textarea></td>
            </div>
            <br>
            <div>
                <h4 class = "title">작성자</h4>
                <td>${post.userId}</td>
            </div>
            <br>
			<div>
                <h4 class = "title">조회수</h4>
                <td>${post.readCount}</td>
            </div>
            <div>
            <c:if test="${not empty post.postFile}">
                <h4 class = "title">데이터첨부</h4>
                <a
						href='./download.do?fileName=<%=URLEncoder.encode(temp.getPostFile(), "UTF-8")%>'>${post.dataAttachment}</a>
            </div>   	  
            </c:if> 	
		</div>
		<table>
			<c:if test="${not empty post.postImage}">
			  <tr>
			    <h4 class = "title">이미지첨부</h4>
			  </tr>
			  <tr>
			    <td><img src="/images/${post.postImage}" /></td>
			    <td></td>
			  </tr>
			</c:if>
		</table>
		<table>
			<tr>
				<h4 class = "title">작성일자</h4>
				<td><fmt:formatDate value="${post.postDate}" type="both"
						pattern="yyyy-MM-dd hh:mm:ss" /></td>
			</tr>
		</table>

		<table>
			<tr>
				<c:if test="${post.userId eq sessionScope.user.userId}">
				<td><input class="submit_little" type="submit" value="수정" onclick="goURL(0)"></td>
				<td><input class="submit_little" type="submit" value="삭제" onclick="goURL(1)"></td>
				</c:if>
			</tr>
		</table>

<hr>
		
	</form>
</body>
</html>