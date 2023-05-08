<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<%@ include file="../main/header.jsp" %>
<style>
   .plantImg {
       width: auto; height: auto;
       max-width: 100px;
       max-height: 100px;
   }
</style>
</head>
<body>
<body style="text-align: center">

<br>
<div id="sugNdMy" data-isLoggedIn="<%= isLoggedIn %>" >
    <!-- 나에게 맞는 식물 찾기 -->
    <a onclick="serviceSug()" >
        나에게 맞는 식물 찾기<img class="" src=""/>
    </a>

    <!-- 내 식물 -->
    <a onclick="serviceMy()" >
        내 식물<img class="" src=""/>
    </a>
</div>
<br>
<h2> 이번달 우수회원 </h2>
    <table id="best-user-table" style="margin-left:auto;margin-right:auto;" width="1000">
        <tbody></tbody>
    </table>


<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
    $(document).ready(function() {
        $.ajax({
            url: "/manager/best-list",
            type: "GET",
            success: function(response) {
                var users = response;
                var tableBody = $("#best-user-table tbody");
                var row = "<tr>";
                                for(var i = 0; i < 3; i++) {
                                    var user = users[i];
                                    if(user.myplantImage != null) {
                                        row += "<td><img class='plantImg' src='/uploads/" + user.myplantImage + "'></td>";
                                    } else {
                                        row += "<td>사진이 없습니다.</td>";
                                    }
                                }
                                row += "</tr><tr>";
                                for(var i = 0; i < 3; i++) {
                                    var user = users[i];
                                    row += "<td>" + user.nickname + "</td>";
                                }
                                row += "</tr><tr>";
                                for(var i = 0; i < 3; i++) {
                                     var user = users[i];
                                     row += "<td>" + user.distbNm + "</td>";
                                 }
                                 row += "</tr><tr>";
                                for(var i = 0; i < 3; i++) {
                                    var user = users[i];
                                    row += "<td>" + user.myplantNick + "</td>";
                                }
                                tableBody.append(row);
                                console.log(row);
            },
            error: function(xhr, status, error) {
                alert('오류가 발생했습니다.');
            }
        });
    });

        let isLoggedIn = document.getElementById("sugNdMy").getAttribute("data-isLoggedIn");
        function serviceSug() {
            if (isLoggedIn == "true") {
                location.href = "/suggestions"
            } else {
                alert('로그인 후 이용해주세요')
                location.href = "/loginPage"
            }
        }

        function serviceMy() {
            if (isLoggedIn == "true") {
                location.href = "/myplants"
            } else {
                alert('로그인 후 이용해주세요')
                location.href = "/loginPage"
            }
        }
</script>
</body>
</html>