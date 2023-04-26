<%@page import="com.plant.service.MemberService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>IdCheckProc</title>
</head>
<body>
	<div style="text-align: center"></div>
	<h3>* 아이디 중복 확인 결과 *</h3>
	<%
		System.out.println("Don't Worry, Be Happy!");
		String id = (String) request.getAttribute("id");
		System.out.println(id);
		int cnt = (Integer) request.getAttribute("cnt");

		System.out.println(cnt);
		System.out.println("Number" + cnt);
		System.out.println("idCheckProc id = " + id);
		// DB에서 member_id 값과 입력된 값이 중복됐는지 아닌지 검사할 때 사용한다.
		out.println("입력 ID : <strong>" + id + "</strong>");
		
		if (cnt == 0) {
			out.println("<p>사용 가능한 아이디입니다.</p>");
			out.println("<a href='javascript:apply(\"" + id + "\")'>[적용]</a>");
	%>

	<script>
		function apply(id) {
			// 중복확인 id를 부모창에 적용하는 방법.
			// 부모창 opener
			opener.document.joinform.userId.value = id;
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