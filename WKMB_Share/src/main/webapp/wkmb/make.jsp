<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Solve</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty loginInfo}">
			<!-- if(empty loginInfo) -->
			<meta http-equiv="Refresh" content="0; url=../" />
			<!-- 로그인을 안한상태에서 들어오면 index.html 페이지로 이동(0초) -->
		</c:when>
		<c:otherwise>
			
			<div>
				문제를 내시면 그 문제 중 랜덤으로 5문제의 문제가 출제되게 됩니다.<br>
				하루에 3번씩만 문제를 풀 수 있습니다.<br>
				최소 5문제 이상의 문제를 등록하셔야합니다.
			</div>
			
			<div>
				<c:forEach var="question" items="${questionList}" varStatus="vs">
					<pre>${vs.index + 1}. ${question.question}</pre>
					<input type="text" id="${vs.index}" readonly="readonly">
					<span id="correct"></span><br>
				</c:forEach>
				<button type="button" onclick="location.href='./myPage.wkmb?id=${loginInfo.id}'">문제 수정</button>
			</div>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
	<script>
	</script>
</body>
</html>