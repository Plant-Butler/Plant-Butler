<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 찾기</title>
<%@ include file="../main/header.jsp" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<style>
    .section-heading, .row, p {
        font-family: 'Yeon Sung', cursive;
    }
</style>
</head>
<body>
<body style="text-align: center">
<section class="page-section cta">
    <div class="container" style="margin-top: 130px">
        <h1 class="section-heading mb-4"> 나에게 맞는 식물 찾기 <h1>
        <p>아홉가지 질문을 통해 당신의 성향 & 취향 & 환경을 고려하여 <br> 당신만을 위한 식물을 알려드릴게요.<p>

        <div class="row">
               <div class="col-xl-9 mx-auto">
                   <div class="cta-inner bg-faded text-center rounded">
                    <form action="/suggestions/result" method="get">
                        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                          <div class="carousel-inner">
                            <div class="carousel-item active">
                              <h1 class="section-heading mb-4">하나. 식물을 키워본 경험이 있으신가요?</h1><br>
                              <label><input type="radio" id="managelevelCodeNm" name="managelevelCodeNm" value="초보자">초보자</label><br>
                              <label><input type="radio" id="managelevelCodeNm" name="managelevelCodeNm" value="">경험자</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">둘. 외출을 선호하시나요?</h1><br>
                              <label><input type="radio" id="watercycleSprngCode" name="watercycleSprngCodeNm" value=" ">집이 최고다</label><br>
                              <label><input type="radio" id="watercycleSprngCode" name="watercycleSprngCodeNm" value="말랐">밖이 최고다</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">셋. 세심하고 꼼꼼한 성격인가요?</h1><br>
                              <label><input type="radio" id="managedemanddoCodeNm" name="managedemanddoCodeNm" value=" ">네</label><br>
                              <label><input type="radio" id="managedemanddoCodeNm" name="managedemanddoCodeNm" value="요">아니오</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">넷. 반려동물을 키우고 있나요?</h1><br>
                              <label><input type="radio" id="toxctyInfo" name="toxctyInfo" value="애완동물">네</label><br>
                              <label><input type="radio" id="toxctyInfo" name="toxctyInfo" value=" ">아니오</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">다섯. 식물을 키우려는 곳의 빛은 어느정도 인가요?</h1><br>
                              <label><input type="radio" id="lighttdemanddoCodeNm" name="lighttdemanddoCodeNm" value="낮은">어둡다</label><br>
                              <label><input type="radio" id="lighttdemanddoCodeNm" name="lighttdemanddoCodeNm" value="중간">보통이다</label><br>
                              <label><input type="radio" id="lighttdemanddoCodeNm" name="lighttdemanddoCodeNm" value="높은">밝다</label><br>
                              <label><input type="radio" id="lighttdemanddoCodeNm" name="lighttdemanddoCodeNm" value=" ">잘 모르겠어요</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">여섯. 잎보기 식물과 꽃보기 식물 중 어느 것을 더 선호하나요?</h1><br>
                              <label><input type="radio" id="" name="clCodeNm" value="잎보기식물">잎보기 식물</label><br>
                              <label><input type="radio" id="" name="clCodeNm" value="꽃보기식물">꽃보기 식물</label><br>
                              <label><input type="radio" id="" name="clCodeNm" value="잎&꽃보기식물">잎&꽃보기 식물</label><br>
                              <label><input type="radio" id="" name="clCodeNm" value="열매보기식물">열매보기 식물</label><br>
                              <label><input type="radio" id="" name="clCodeNm" value="">상관없어요</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">일곱. 식물을 키우려는 곳의 평상시 온도는 어느 정도 인가요?</h1><br>
                              <label><input type="radio" id="grwhTpCodeNm" name="grwhTpCodeNm" value="10">10~15℃</label><br>
                              <label><input type="radio" id="grwhTpCodeNm" name="grwhTpCodeNm" value="16">16~20℃</label><br>
                              <label><input type="radio" id="grwhTpCodeNm" name="grwhTpCodeNm" value="21">21~25℃</label><br>
                              <label><input type="radio" id="grwhTpCodeNm" name="grwhTpCodeNm" value="">잘 모르겠어요</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">여덟. 식물을 키우려는 곳의 겨울 최저 온도는 어느 정도 인가요?</h1><br>
                              <label><input type="radio" id="winterLwetTpCodeNm" name="winterLwetTpCodeNm" value="0">0℃ 이하</label><br>
                              <label><input type="radio" id="winterLwetTpCodeNm" name="winterLwetTpCodeNm" value="5">약 5℃</label><br>
                              <label><input type="radio" id="winterLwetTpCodeNm" name="winterLwetTpCodeNm" value="7">약 7℃</label><br>
                              <label><input type="radio" id="winterLwetTpCodeNm" name="winterLwetTpCodeNm" value="10">약 10℃</label><br>
                              <label><input type="radio" id="winterLwetTpCodeNm" name="winterLwetTpCodeNm" value="13">13℃ 이상</label><br>
                              <label><input type="radio" id="winterLwetTpCodeNm" name="winterLwetTpCodeNm" value="">잘 모르겠어요</label>
                            </div>
                            <div class="carousel-item">
                              <h1 class="section-heading mb-4">아홉. 식물을 키우려는 곳의 습도는 어느 정도 인가요?</h1><br>
                              <label><input type="radio" id="hdCodeNm" name="hdCodeNm" value="40% 미만">건조하다</label><br>
                              <label><input type="radio" id="hdCodeNm" name="hdCodeNm" value="40 ~ 70%">쾌적하다</label><br>
                              <label><input type="radio" id="hdCodeNm" name="hdCodeNm" value="70% 이상">습하다</label><br>
                              <label><input type="radio" id="hdCodeNm" name="hdCodeNm" value=" ">잘 모르겠어요</label>
                            </div>
                            <div class="carousel-item">
                              <label><input type="submit" value="결과 보기"  onclick="return validateForm()"  class="btn btn-outline-success"></label>
                            </div>
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
                    </form>
                   </div>
               </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="footer text-faded text-center py-5" style="background-image: url('/images/footer.jpg'); height: 200px;">
  <div class="container"><p class="m-0 small">Copyright &copy; Plantery 2023</p></div>
</footer>

<script>
    function validateForm() {
        const radioGroups = document.querySelectorAll('input[type="radio"][name]');
        for (let i = 0; i < radioGroups.length; i++) {
            const group = radioGroups[i].name;
            const radios = document.querySelectorAll('input[type="radio"][name="' + group + '"]');
            let checked = false;
            for (let j = 0; j < radios.length; j++) {
                if (radios[j].checked) {
                    checked = true;
                    break;
                }
            }
            if (!checked) {
                alert('모든 질문에 답해주세요');
                return false;
            }
        }
        return true;
    }
</script>
</body>
</html>