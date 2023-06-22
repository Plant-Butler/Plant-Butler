<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.regex.Pattern" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Registration</title>
<%@ include file="../main/header.jsp" %>
<link rel="stylesheet" type="text/css" href="/css/regist.css">
</head>
<div class="header-background">
<body style="text-align: center">
   <div class="about-section">
  <h1>회원가입</h1>
   </div>
<br>
   <form id = "myform" action="./registPage" method="post" name="joinform" onsubmit="return finalCheck(event);">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      <table style="margin-left:auto;margin-right:auto;" width="900" length="100">
          <section class="registsection">
                  <div class="form-value">
                      <tr style="height:10px">
                          <br>
                          <h2 class="loginh2">회원가입</h2>
                          <br><br>
                          <th class="registtitle">아이디</th>
                          <td>
                          <div class="inputbox">
                              <input type="text" name="userId" id="userId" readonly="readonly">
                          </div>
                          </td>
                          <td>
                              <input class="checkduplicate" type="button" value="중복확인" onclick="IdCheck()" required="required">
                          </td>
                      </tr>
                      <tr style="height:100px">
                          <th class="registtitle">닉네임</th>
                          <td>
                          <div class="inputbox">
                              <input type="text" name="nickname" id="nickname" readonly="readonly">
                              </div>
                          </td>
                          <td>
                              <input class="checkduplicate"  type="button" value="중복확인" onclick="NickCheck()" required="required">
                          </td>
                      </tr>
                      <tr style="height:100px">
                          <th class="registtitle">비밀번호</th>
                          <td>
                          <div class="inputbox">
                              <input type="password" name="password" id="password" required="required" onkeyup="pwdCheck()">
                              </div>
                              <td><div id="password-message"></div></td>
                          </td>
                      </tr>
                      <tr style="height:100px">
                          <th class="registtitle">비밀번호 확인</th>
                          <td>
                          <div class="inputbox">
                              <input type="password" name="checkPwd" id="checkPwd" onkeyup="checkerPwd()" required="required">
                              </div>
                              <td><div id="checkerPwd" class="error-text">  동일한 암호를 입력하세요.</div></td>
                         </td>
                      </tr>
                      <tr style="height:100px">
                          <th class="registtitle">이메일</th>
                          <td>
                          <div class="inputbox">
                              <input type="email" name="email" id="email" required="required" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$">
                              </div>
                         </td>
                      </tr>
                               <div>
                               <tr style="height:100px">
                                 <th class = "registtitle">쿠키 수집 동의 약관</th>
                                 <td><p class = "registtitle" style="font-size: 12px; display:inline-block;">이 사이트는 쿠키를 사용합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 쿠키 사용에 동의하십니까?</p></td>
                                 <td><input type="checkbox" name="cookie" value="cookie" id="cookie" style="display:inline-block; margin-left: 10px;" required></td>
                               </tr>
                              <tr style="height:100px">
                                  <th class = "registtitle">웹푸시 동의 약관</th>
                                  <td><p class = "registtitle" style="font-size: 12px; display:inline-block;">이 사이트에서는 웹 푸시 알림을 제공합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 웹 푸시 알림 사용에 동의하십니까?</p></td>
                                 <td><input type="checkbox" name="webpush" value="webpush" id="webpush" style="display:inline-block; margin-left: 10px;" required><input type="hidden" name="tokenValue" id="tokenValueInput"><!-- 토큰 값을 전송하기 위한 숨겨진 입력 필드 --></td>
                              </tr>

                              <tr style="height:100px">
                                 <th class = "registtitle">위치 정보 수집 동의 약관</th>
                                 <td><p class = "registtitle" style="font-size: 12px; display:inline-block;">이 사이트는 사용자의 위치 정보를 사용합니다.<br>이용 약관 및 개인정보 취급 방침에 따라 위치 정보 사용에 동의하십니까?</p></td>
                                 <td><input type="checkbox" name="location" value="location" id="location" style="display:inline-block; margin-left: 10px;" required></td>
                               </tr>

                          <tr style="height:100px">
                                 <td></td><td colspan="1"><input class="registbutton" type="submit" value="가입하기"></td><td></td>
                          </tr>
                                                   </div>

                     </div>
             </section>
             </table>
         </form>
   <script type="module" src="/js/obfuscate/registTokenObfus.js"></script>
      <script src="./js/regist.js"></script>

</body>
</div>
</html>