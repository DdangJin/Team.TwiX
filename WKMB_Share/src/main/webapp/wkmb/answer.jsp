<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Answer</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty loginInfo}">
			<!-- if(empty loginInfo) -->
			<meta http-equiv="Refresh" content="0; url=../" />
			<!-- 로그인을 안한상태에서 들어오면 index.html 페이지로 이동(0초) -->
		</c:when>
		<c:when test="${empty questionUser}">
			<!-- if(empty pageUser) -->
			<meta http-equiv="Refresh" content="0; url=./main.wkmb" />
			<!-- 없는 유저의 페이지로 들어오면 main.wkmb 페이지로 이동(0초) -->
		</c:when>
		<c:when test="${loginInfo.id == questionUser.id}">
			<!-- if(loginInfo.id == pageUser.id) -->
			<meta http-equiv="Refresh" content="0; url=./make.wkmb" />
			<!-- 자신의 사이트로 들어오면 make.wkmb 페이지로 이동(0초) -->
		</c:when>
		<c:otherwise>
			
			<div>
				<span>${questionUser.name}의 문제 답</span>
				<span>맞춘 수: ${currectCount}/5</span>
			</div>
			
			<div id="answerReport">
				<c:set var="questionAnswer" value="" />
				<c:forEach var="question" items="${questionList}" varStatus="vs">
					<c:set var="questionAnswer" value="${questionAnswer},${question.answer}" />
					<pre>${vs.index + 1}. ${question.question}</pre>
					<input type="text" class="answer" readonly="readonly">
					<span class="correct"></span><br>
				</c:forEach>
			
				<button type="button" onclick="location.href='./myPage.wkmb?id=${questionUser.id}'">돌아가기</button>
			</div>
		</c:otherwise>
	</c:choose>
	<script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
	<script>
		var questionAnswer = new Array();
		var userAnswer = new Array();
		
		<c:forEach var="answer" items="${answer}">
		userAnswer.push("${answer}");
		</c:forEach>
		
		<c:forTokens var="questionAnswer" items="${questionAnswer}" delims=",">
		questionAnswer.push("${questionAnswer}");
		</c:forTokens>
		
		$("#answerReport").find(".answer").each(function(index, element){					// answerReport id를 가진 객체의 하위객체의 input을 찾아서 각각 function을 실행
			$(element).attr("value", userAnswer[index]);
		});
		
		$("#answerReport").find(".correct").each(function(index, element){
			if(questionAnswer[index] == userAnswer[index])
				$(this).html("O");
			else
				$(this).html("X");
		});
	</script>
</body>
</html>