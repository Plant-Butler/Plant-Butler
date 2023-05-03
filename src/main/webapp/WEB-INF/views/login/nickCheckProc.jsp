<%@page import="com.plant.service.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NickCheckProc</title>
</head>
<body>
	<div style="text-align: center"></div>
	<h3>* 닉네임 중복 확인 결과 *</h3>
	<%
		String nickname = (String) request.getAttribute("nickname");
		int cnt = (Integer) request.getAttribute("cnt");

		System.out.println("Number" + cnt);
		System.out.println("nickCheckProc nickname = " + nickname);
		// DB에서 member_id 값과 입력된 값이 중복됐는지 아닌지 검사할 때 사용한다.
		out.println("입력 ID : <strong>" + nickname + "</strong>");
		
		if (cnt == 0) {
			out.println("<p>사용 가능한 닉네임입니다.</p>");
			out.println("<a href='javascript:apply(\"" + nickname + "\")'>[적용]</a>");
	%>

	<script>
		function apply(nickname) {
			// 중복확인 id를 부모창에 적용하는 방법.
			// 부모창 opener
			opener.document.joinform.nickname.value = nickname;
			// 창닫기
			window.close(); 
		}
	</script>
	
	<%
	} else {
	out.println("<p style='color: red'>해당 아이디는 사용하실 수 없습니다.</p>");
	} 
	%>
	<hr>
	<a href="javascript:history.back()">[다시시도]</a> &nbsp; &nbsp;
	<a href="javascript:window.close()">[창닫기]</a>

</body>
</html>