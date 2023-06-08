<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물일기</title>
 <%@ include file="../main/header.jsp" %>
 <meta name="_csrf" content="${_csrf.token}"/>
 <meta name="_csrf_header" content="${_csrf.headerName}"/>
 <link rel="preconnect" href="https://fonts.googleapis.com">
 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
 <link href="https://fonts.googleapis.com/css2?family=Hahmlet&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/diaryDetail.css">
</head>
<body>
<body style="text-align: center"><br>

<section class="page-section cta">
        <!-- 첨부된 내 식물 -->
        <c:if test="${not empty myPlantList}">
            <c:forEach var="myPlant" items="${myPlantList}">
                <table class="table">
                    <tr>
                        <c:if test="${not empty myPlant.myplantImage}">
                            <td><div class="box" style="background: #BDBDBD;">
                                <img class="plantImg" src="/uploads/${myPlant.myplantImage}">
                            </div></td>
                        </c:if>
                        <c:if test="${empty myPlant.myplantImage}">
                            <td>사진이 없어요</td>
                        </c:if>
                        <td>${myPlant.myplantNick}</td>
                        <td>${myPlant.distbNm}</td>
                        <td><fmt:formatDate value="${myPlant.firstDate}" type="date"/></td>
                    </tr>

                        <!-- 첨부된 내 식물 내 식물의 오늘 관리기록 -->
                        <c:set var="hasSchedule" value="false" />
                        <c:forEach var="schedule" items="${scheduleList}">
                            <c:if test="${myPlant.myplantId eq schedule.myplantId}">
                                <c:set var="hasSchedule" value="true" />
                                <tr>
                                    <td colspan="4">
                                        물주기 ${schedule.watering}회 <span class="spacing"></span>
                                        영양제 ${schedule.nutri}회 <span class="spacing"></span>
                                        가지치기 ${schedule.prun}회 <span class="spacing"></span>
                                        분갈이 ${schedule.soil}회 <span class="spacing"></span>
                                        환기 ${schedule.ventilation}회
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>

                        <c:if test="${not hasSchedule}">
                            <tr>
                                <td colspan="5">관리기록이 비어있어요</td>
                            </tr>
                        </c:if>
                </table>
            </c:forEach>
        </c:if>
<br>
<br>
<br>
<br>
        <table class="diary-tbl">
            <tr>
                <td colspan="2" id="diary-ttl">${diary.diaryTitle}</td>
            </tr>
            <tr>
                <td colspan="2"><fmt:formatDate value="${diary.diaryDate}" type="date"/></td>
            </tr>
            <tr>
                <th>오늘 식물관리의 칭찬 혹은 반성</th>
                <th>식물을 보며 느낀 나의 감정</th>
             </tr>
             <tr>
                <td class="diary-td">${diary.diaryPraiseRegret}</td>
                <td class="diary-td">${diary.diaryEmotion}</td>
            </tr>
            <tr>
                <th>당신의 식물은 오늘 얼마나 성장했나요?</th>
                <th>자유</th>
            </tr>
            <tr>
                <td class="diary-td">${diary.diaryGrowth}</td>
                <td class="diary-td">${diary.diaryContent}</td>
            </tr>
        </table>
<br>
<br>
<br>
<br>
        <c:if test="${not empty diary.diaryImage}">
            <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                <ol class="carousel-indicators">
                    <c:forEach var="image" items="${fn:split(diary.diaryImage, ',')}" varStatus="status">
                        <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${status.index}" class="${status.index == 0 ? 'active' : ''}"></li>
                    </c:forEach>
                </ol>
                <div class="carousel-inner">
                    <c:forEach var="image" items="${fn:split(diary.diaryImage, ',')}" varStatus="status">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                            <p><img class="img-thumbnail" src="/uploads/${image}"></p>
                        </div>
                    </c:forEach>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </c:if>


<br>
<br>
        <button class="btn btn-success" onclick='location.href="/diaries/form/${diary.diaryId}"'>수정</button>
        <button class="btn btn-success" onclick="deleteCheck(${diary.diaryId})">삭제</button>
        <button class="btn btn-success" onclick='location.href="/diaries"'>목록</button>

</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5">
    <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>

    // 식물일기 삭제 확인창
    function deleteCheck(diaryId) {

         var csrfHeader = $("meta[name='_csrf_header']").attr("content");
         var csrfToken = $("meta[name='_csrf']").attr("content");

         let say = '삭제하시겠습니까?';

         if (confirm(say) == true){
             deleteDiary(diaryId, csrfHeader, csrfToken);
         } else {
             return false;
         }
    }

    // 식물일기 삭제
    function deleteDiary(diaryId, csrfHeader, csrfToken) {

        $.ajaxSetup({
            headers: {
                [csrfHeader] : csrfToken
            }
        });

        $.ajax({
            url: "/diaries/" + diaryId,
            type: "DELETE",
            data: { diaryId : diaryId },
            success: function(response) {
                if(response) {
                    alert('삭제되었습니다');
                    window.location.href = "/diaries";
                } else {
                    alert('삭제에 실패하였습니다.');
                }
            },
            error: function(request, status, error) {
                alert('오류가 발생하였습니다.');
                console.log("code: " + request.status)
                console.log("message: " + request.responseText)
                console.log("error: " + error);
            }
        });
    }

</script>

</body>
</html>