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
   .box {
        width: 100px;
        height: 100px;
        border-radius: 70%;
        overflow: hidden;
        margin-left:auto;
        margin-right:auto
   }
   .plantImg {
        width: 100%;
        height: 100%;
        object-fit: cover;
   }

   table, tbody, td {
        width:800px;
        margin-left:auto;
        margin-right:auto;
   }
</style>
</head>
<body>
<body style="text-align: center"><br>

        <section class="page-section clearfix">
            <div class="container">
                <div class="intro">
                    <img class="intro-img img-fluid mb-3 mb-lg-0 rounded" src="assets/img/close-up-picture-hand-watering-sapling-plant.jpg" alt="..." />
                    <div class="intro-text left-0 text-center bg-faded p-5 rounded">
                            <h2 class="section-heading mb-4">
                                <span class="section-heading-upper">당신만을 위한</span>
                                <span class="section-heading-lower">나에게 맞는 반려식물 찾기</span>
                            </h2>
                            <p class="mb-3">나의 성향 & 취향 & 환경을 모두 고려한 최적의 반려 식물은 무엇일까요?</p>
                            <div class="intro-button mx-auto"><a class="btn btn-primary btn-xl" onclick="location.href='/suggestions'">GO!</a></div>

                    </div>
                </div>
            </div>
        </section>



<section class="page-section cta">
    <div class="container">
         <div class="row">
               <div class="col-xl-9 mx-auto">
                   <div class="cta-inner bg-faded text-center rounded">
                         <h2 class="section-heading mb-4"> 이번달 우수회원 </h2>
                                <table id="best-user-table">
                                    <tbody></tbody>
                                </table>
                   </div>
               </div>
         </div>
    </div>
</section>

        <footer class="footer text-faded text-center py-5">
            <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
        </footer>


<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="/js/main.js"></script>


</body>
</html>