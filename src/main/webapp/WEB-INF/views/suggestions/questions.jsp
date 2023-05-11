<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식물 찾기</title>
<%@ include file="../main/header.jsp" %>
</head>
<body>
<body style="text-align: center">
<h1> 나에게 맞는 식물 찾기 <h1>
아홉가지 질문을 통해 당신의 성향 & 취향 & 환경을 고려하여 당신만을 위한 식물을 알려드릴게요.

<div class="outer">
  <div class="inner-list">
    <div class="inner">
      <h3>하나. 식물을 키워본 경험이 있으신가요?</h3>
      <label><input type="radio" id="" name="experience" value="초보자">초보자</label>
      <label><input type="radio" id="" name="experience" value="경험자">경험자</label>
    </div>
    <div class="inner">
      <h3>둘. 외출을 선호하시나요?</h3>
      <label><input type="radio" id="" name="home" value="집이 최고다">집이 최고다</label>
      <label><input type="radio" id="" name="home" value="밖이 최고다">밖이 최고다</label>
    </div>
    <div class="inner">
      <h3>셋. 세심하고 꼼꼼한 성격인가요?</h3>
      <label><input type="radio" id="" name="careful" value="네">네</label>
      <label><input type="radio" id="" name="careful" value="아니오">아니오</label>
    </div>
    <div class="inner">
      <h3>넷. 반려동물을 키우고 있나요?</h3>
      <label><input type="radio" id="" name="pet" value="네">네</label>
      <label><input type="radio" id="" name="pet" value="아니오">아니오</label>
    </div>
    <div class="inner">
      <h3>다섯. 식물을 키우려는 곳의 빛은 어느정도 인가요?</h3>
      <label><input type="radio" id="" name="light" value="어둡다">어둡다</label>
      <label><input type="radio" id="" name="light" value="보통이다">보통이다</label>
      <label><input type="radio" id="" name="light" value="밝다">밝다</label>
      <label><input type="radio" id="" name="light" value="잘 모르겠어요">잘 모르겠어요</label>
    </div>
    <div class="inner">
      <h3>여섯. 잎보기 식물과 꽃보기 식물 중 어느 것을 더 선호하나요?</h3>
      <label><input type="radio" id="" name="leaf-flower" value="잎보기 식물">잎보기 식물</label>
      <label><input type="radio" id="" name="leaf-flower" value="꽃보기 식물">꽃보기 식물</label>
      <label><input type="radio" id="" name="leaf-flower" value="잎&꽃보기 식물">잎&꽃보기 식물</label>
      <label><input type="radio" id="" name="leaf-flower" value="열매보기 식물">열매보기 식물</label>
      <label><input type="radio" id="" name="leaf-flower" value="상관없어요">상관없어요</label>
    </div>
    <div class="inner">
      <h3>일곱. 식물을 키우려는 곳의 평상시 온도는 어느 정도 인가요?</h3>
      <label><input type="radio" id="" name="temperature" value="10~15℃">10~15℃</label>
      <label><input type="radio" id="" name="temperature" value="16~20℃">16~20℃</label>
      <label><input type="radio" id="" name="temperature" value="21~25℃">21~25℃</label>
      <label><input type="radio" id="" name="temperature" value="잘 모르겠어요">잘 모르겠어요</label>
    </div>
    <div class="inner">
      <h3>여덟. 식물을 키우려는 곳의 겨울 최저 온도는 어느 정도 인가요?</h3>
      <label><input type="radio" id="" name="winter" value="0℃ 이하">0℃ 이하</label>
      <label><input type="radio" id="" name="winter" value="약 5℃">약 5℃</label>
      <label><input type="radio" id="" name="winter" value="약 7℃">약 7℃</label>
      <label><input type="radio" id="" name="winter" value="약 10℃">약 10℃</label>
      <label><input type="radio" id="" name="winter" value="13℃ 이상">13℃ 이상</label>
      <label><input type="radio" id="" name="winter" value="잘 모르겠어요">잘 모르겠어요</label>
    </div>
    <div class="inner">
      <h3>아홉. 식물을 키우려는 곳의 습도는 어느 정도 인가요?</h3>
      <label><input type="radio" id="" name="humid" value="건조하다">건조하다</label>
      <label><input type="radio" id="" name="humid" value="쾌적하다">쾌적하다</label>
      <label><input type="radio" id="" name="humid" value="습하다">습하다</label>
      <label><input type="radio" id="" name="humid" value="잘 모르겠어요">잘 모르겠어요</label>
    </div>
  </div>
</div>

</body>
</html>