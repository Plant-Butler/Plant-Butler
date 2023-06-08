<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="../main/header.jsp" %> --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload File</title>
</head>
<style type="text/css">
   .form_table, h1 {
      text-align: center;
      max-width: 500px;
      margin: 0 auto;
   }
</style>
<body>
<div class="about-section">
<h1>Upload File</h1>
<br>
</div>
    <form action = "/transferImage" method="post" enctype="multipart/form-data">
	<div class = "form_table">
                <input class="upload_img" type="file" value= "image" name="image" id="postMultiImage">
                <br>
	<br>
	<div class="submit">
        <input type="submit" value="진단">
    </div>
    </div>
    </form>
<br>
<br>
</body>
</html>