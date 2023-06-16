<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.plant.vo.UserVo"%>
<%@ page import="com.plant.vo.PostVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>식물병 진단</title>
   <%@ include file="../main/header.jsp" %>
</head>

<style type="text/css">
   button, h1, p {
      text-align: center;
      max-width: 500px;
      margin: 0 auto;
   }

   .button-container {
      text-align: center;
   }

   .button {
      display: inline-block;
      text-align: center;
      max-width: 500px;
      margin: 0 auto;
      text-decoration: none;
      color: inherit;
      background-color: inherit;
      transition: background-color 0.7s;
   }

   .button:hover {
      background-color: #96c37f;
   }
</style>
<body>
<section class="page-section cta">
   <div class="container" style="margin-top: 150px">
      <h1>Show Result</h1>

      <br>
      <br>
      <p>${pclass}</p>
      <p>${confidence}</p>
      <br>
      <div class="button-container">
         <button type="button" class="button" onclick="window.location.href='/home'">메인화면</button>
         <button type="button" class="button" onclick="window.location.href='/diagnosis'">다시하기</button>
      </div>
      <br>
      <div style="text-align: center;">
         <img src="${pageContext.request.contextPath}/diseases/bacterial_spot.jpg" alt="Image">
      </div>
      <br>
      <p>${disease.detail}</p>
      <br>
      <p>${disease.solution}</p>
   </div>
</section>
</body>

</html>