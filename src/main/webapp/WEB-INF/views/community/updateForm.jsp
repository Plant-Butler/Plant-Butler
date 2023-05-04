<%@page import="com.plant.vo.UserVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com"> 
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin> 
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>Update Item</title>
</head>
<body>
<div class="about-section">
<h1>Update Post</h1>
</div>
<br>
<%
    UserVo userVo = (UserVo) session.getAttribute("user");
    String userId = userVo.getUserId();

%>


	<form action="./update" method="put" enctype="multipart/form-data">
	<div class = "form_table">
		 <div>
		 <br>
                <h4 class = "title">작성자</h4>
             <input class="upload_writer" type="text" name="userId" id="userId" value="<%=userId %>" readonly>
            </div>
            <br>
            <div>
                <h4 class = "title">제목</h4>
                <input  class="upload_title" type="text" name="postTitle" id = "postTitle" value="${post.postTitle}">
            </div>
            <br>
            <div>
                <h4 class = "title">내용</h4>
                  <textarea cols="80" rows="5" name="postContent" id="postContent">${post.postContent}</textarea>
            </div>
            <br>
            <br>           
            <div>
                <h4 class="title">이미지 첨부</h4>

                <c:if test="${not empty post.postImage}">
                <td>
                    <c:forEach var="image" items="${fn:split(post.postImage, ',')}">
                        <p><a href="/uploads/${image}"><img src="/uploads/${image}"></a></p>
                    </c:forEach>

                    </td>
                </c:if>
                <input class="upload_img" type="file" name="postImage">
                <br>
                <p class="form_note">(JPEG, PNG, GIF 파일만 등록 가능합니다.)</p>
                <br>
                <br>
            </div>

            <br>
			<div>
                <c:if test="${not empty post.postFile}">
                [첨부파일]
                    <a>${post.postFile}</a>
                </c:if><br><br>
                <input class="upload_data" type="file" name="postFile" value="${post.postFile}" >
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