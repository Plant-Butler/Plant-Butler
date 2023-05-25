<%@ page import="com.plant.vo.UserVo" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.temporal.ChronoUnit" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.plant.vo.PlantVo" %>
<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
    UserVo userVo = (UserVo) session.getAttribute("user");
    String userId = userVo.getUserId();
%>
<script>
    var csrfToken = '${_csrf.token}';
    var csrfHeader = '${_csrf.headerName}';
</script>
<html>
<head>
    <style>
        .bi-tree {
            font-size: 25px;
            color: darkgreen;
        }
        .bi-capsule{
            font-size: 25px;
            color: darkgreen;
        }
        .bi-droplet{
            font-size: 25px;
            color: darkgreen;
        }
        .bi-flower1{
            font-size: 25px;
            color: darkgreen;
        }
        .bi-wind{
            font-size: 25px;
            color: darkgreen;
        }
        .fc-event {
            background-color: transparent !important;
            border: none !important;
        }
        .fc-event-title {
            display: none !important;
        }
        #container {
            width: 1200px;
        }
        #waterAmount {
            position: absolute;
            top: 0;
            right: 100px;
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="${pageContext.request.contextPath}/static/css/cal.css" rel="stylesheet" />
    <script src="https://kit.fontawesome.com/e84e54149f.js" crossorigin="anonymous"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.6/index.global.min.js'></script>
    <link href="https://fonts.cdnfonts.com/css/sf-ui-text-2" rel="stylesheet">

    <script>
        function showForm() {
            var form = document.getElementById("schedule-form");
            form.style.display = "block";
        }
    </script>
    <script>
        function submitForm() {
            var form = document.getElementById("scheduleForm");
            var formData = new FormData(form);
            var data = {};
            formData.forEach(function(value, key) {
                data[key] = value;
            });

            fetch('/myplants/${myplantId}/schedule/form', {
                method: 'POST',
                body: formData,
                beforeSend: function(xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
            })
                .then(response => {
                    if (response.ok) {
                        var formContainer = document.getElementById("schedule-form");
                        formContainer.style.display = "none";
                        form.reset();
                        window.location.reload();
                    } else {
                        alert("Error: " + response.statusText);
                    }
                })
                .catch(error => {
                    alert("Error: " + error.message);
                });
        }
    </script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                customButtons: {
                    myCustomButton: {
                        text: '삭제버튼 활성화',
                        click: function() {
                            var deleteBtns = document.querySelectorAll('.deleteBtn');
                            deleteBtns.forEach(function (btn) {
                                if (btn.style.display == 'none') {
                                    btn.style.display = 'inline-block';
                                } else {
                                    btn.style.display = 'none';

                                }
                            });
                        }
                    }
                },
                headerToolbar: {
                    left: 'myCustomButton',
                    center: 'title',
                },
                initialView: 'dayGridMonth',
                events : [
                    <c:forEach var="schedule" items="${schedulelist}">
                    {
                        title: '<i class="bi bi-tree"></i><i class="bi bi-tree"></i><i class="bi bi-tree"></i><i class="bi bi-tree"></i><i class="bi bi-tree"></i>',
                        start: '<fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.scheduleDate}"/>',
                        end: '<fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.scheduleDate}"/>',
                        watering : ${schedule.watering},
                        nutri : ${schedule.nutri},
                        prun : ${schedule.prun},
                        soil : ${schedule.soil},
                        ventilation : ${schedule.ventilation},
                        scheduleId : ${schedule.scheduleId}
                    },
                    </c:forEach>
                ],
                eventContent: function(arg) {
                    var titleEl = document.createElement('div');
                    var icons = '';
                    var deleteBtn = document.createElement('button');
                    deleteBtn.className = 'btn btn-danger btn-sm deleteBtn';
                    deleteBtn.style.display = 'none';
                    deleteBtn.innerHTML = 'X';
                    deleteBtn.addEventListener('click', function() {
                        var scheduleId = arg.event.extendedProps.scheduleId;
                        fetch('/myplants/${myplantId}/schedule/'+ scheduleId , {
                            method: 'DELETE',
                            headers: {
                                [csrfHeader]: csrfToken
                            }
                        })
                            .then(response => {
                                if (response.ok) {
                                    window.location.reload();
                                } else {
                                    alert("Error: " + response.statusText);
                                }
                            })
                            .catch(error => {
                                alert("Error: " + error.message);
                            });
                    });
                    if (arg.event.extendedProps.watering == 1) {
                        icons += '<i class="bi bi-droplet"></i>';
                    }
                    if (arg.event.extendedProps.nutri == 1) {
                        icons += '<i class="bi bi-capsule"></i>';
                    }
                    if (arg.event.extendedProps.prun == 1) {
                        icons += '<i class="bi bi-tree"></i>';
                    }
                    if (arg.event.extendedProps.soil == 1) {
                        icons += '<i class="bi bi-flower1"></i>';
                    }
                    if (arg.event.extendedProps.ventilation == 1) {
                        icons += '<i class="bi bi-wind"></i>';
                    }
                    titleEl.innerHTML = icons;
                    titleEl.appendChild(deleteBtn);
                    return { domNodes: [titleEl] };
                }
            });
            calendar.render();
        });
    </script>
    <title>Title</title>
</head>
<body>
<div id="fourSeasonContainer"></div>
<h1>${myplant1.myplantNick}의 관리페이지</h1>
<button class="btn btn-primary" type="button" onclick="location.href='/myplants/${myplantId}/schedule/push'">물주기 알람 설정</button>
<button class="btn btn-primary" onclick="showForm()">오늘기록 추가하기</button>
<div id="schedule-form" style="display:none;">
    <form id="scheduleForm">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <div>
            <input type="hidden" name = "myplantId" value="${myplantId}">
            <input type="hidden" name = "userId" value="<%=userId%>">
            <label for="watering">물주기</label>
        </div>
        <div>
            <input type="checkbox" id="watering" name="watering" value="1">
            <label for="watering">물주기</label>
        </div>
        <div>
            <input type="checkbox" id="nutri" name="nutri" value="1">
            <label for="nutri">영양제주기</label>
        </div>
        <div>
            <input type="checkbox" id="prun" name="prun" value="1">
            <label for="prun">가지치기</label>
        </div>
        <div>
            <input type="checkbox" id="soil" name="soil" value="1">
            <label for="soil">분갈이</label>
        </div>
        <div>
            <input type="checkbox" id="ventilation" name="ventilation" value="1">
            <label for="ventilation">환기</label>
        </div>
        <button type="button" class="btn btn-primary" onclick="submitForm()">제출하기</button>
    </form>
</div>
<div id="container">
<div id='calendar'></div>
</div>
<div id="waterAmount">
    <h1>물의 양</h1>
    ${myplant1.myplantNick}의 화분에 맞는 물의 양은 ${water}L 입니다

    최근에 물을 준 날짜 : <fmt:formatDate pattern="yyyy-MM-dd" value="${date}"></fmt:formatDate>

    <%
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH);
        String text = "";
        PlantVo plantVo =(PlantVo)request.getAttribute("plantVo");

        switch(month){
            case Calendar.JANUARY:
            case Calendar.FEBRUARY:
            case Calendar.DECEMBER:
                text=plantVo.getWatercycleWinterCodeNm();
                break;

            case Calendar.MARCH:
            case Calendar.APRIL:
            case Calendar.MAY:
                text=plantVo.getWatercycleSprngCodeNm();
                break;
            case Calendar.JUNE:
            case Calendar.JULY:
            case Calendar.AUGUST:
                text=plantVo.getWatercycleSummerCodeNm();
                break;
            case Calendar.SEPTEMBER:
            case Calendar.OCTOBER:
            case Calendar.NOVEMBER:
                text=plantVo.getWatercycleAutumnCodeNm();
                break;
        }
    %>

    <%=text%>

    <%
        long diffInDays = 0;
        if(request.getAttribute("date")!=null) {
            java.sql.Timestamp timestamp = (java.sql.Timestamp) request.getAttribute("date");


            Date printedDate = new Date(timestamp.getTime());


            Date currentDate = new Date();


            long diffInMillies = Math.abs(currentDate.getTime() - printedDate.getTime());
            diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
        }
    %>
    오늘로부터 물을 <%=diffInDays%> 일 동안 주지 않았습니다!

    <%

        long diffInDays2 = 0;
        if(request.getAttribute("date2")!=null) {
            java.sql.Timestamp timestamp = (java.sql.Timestamp) request.getAttribute("date2");


            Date printedDate2 = new Date(timestamp.getTime());
            Long printedDate3 = new Long(printedDate2.getTime());
            long currentDate = new Long(new Date().getTime());
            long diffInMillies = currentDate - printedDate3;
            diffInDays2 = diffInMillies / (24 * 60 * 60 * 1000);
        }
    %>

    마지막 관리기록 작성일 : <%=diffInDays2%> 일 전


</div>
<i class="fi fi-rr-Search"></i>

<div>
    <a href="/myplants/${myplantId}/schedule/push" class="button">물주기 알람 설정</a>
</div>
</body>
</html>
