<%@page import="com.plant.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../main/header.jsp" %> --%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Write Item</title>
</head>
<body>
<div class="about-section">
<h1>New Post</h1>
</div>
<br>
<%
    UserVo userVo = (UserVo) session.getAttribute("user");
    String userId = userVo.getUserId();

%>


	<form action="./update" method="post" enctype="multipart/form-data">
	<div class = "form_table">
		 <div>
		 <br>
                <h4 class = "title">작성자</h4>
             <input class="upload_writer" type="text" name="userId" id="userId" value="<%=userId %>" readonly>
            </div>
            <br>
            <div>
                <h4 class = "title">제목</h4>
                <input  class="upload_title" type="text" name="postTitle" id = "postTitle" value=<%=userId %>>
            </div>
            <br>
            <div>
                <h4 class = "title">내용</h4>
                <textarea cols="80" rows="5" name="postContent"></textarea>
            </div>
            <br>
            <br>           
			<div>
                <h4 class = "title">이미지첨부</h4>
                <input class="upload_img" type="file" name=postImage>
            </div>
            <br>           
			<div>
                <h4 class = "title">데이터첨부</h4>
                <input class="upload_data" type="file" name="postFile">
            </div>    	
	<br>
	<div class="submit">
	    <input type="submit" value="수정">
	</div>
	<br>
	<br>
</form>
</body>
</html>