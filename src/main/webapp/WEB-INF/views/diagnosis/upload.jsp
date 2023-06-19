<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>식물병 진단</title>
<%@ include file="../main/header.jsp" %>
</head>
<style type="text/css">
   .form_table, h1 {
      text-align: center;
      max-width: 500px;
      margin: 0 auto;
   }
</style>
<body>
<section class="page-section cta">
    <div class="container" style="margin-top: 150px">
        <h1>Upload File</h1>

    <form action = "/diagnosis/result" method="post" enctype="multipart/form-data">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	<div class = "form_table">
                <input class="upload_img" type="file" value= "image" name="image" id="postMultiImage">
                <br>
	<br>
	<div class="submit">
        <input type="submit" value="진단">
    </div>
    </div>
    </form>
    </div>
</section>
<br>
<br>
</body>
</html>