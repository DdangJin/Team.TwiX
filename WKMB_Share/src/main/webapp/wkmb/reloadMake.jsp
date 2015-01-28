<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<form action="./updateQuestion.wkmb" method="post">
	<c:forEach var="question" items="${questionList}" varStatus="vs">
	<div id="question${questionNo}" class="question-div">
		<input type="hidden" name="qid" value="${question.qid}">
		<div id="question-question">
			<span style="font-weight:bold;">[${vs.index + 1}번]&nbsp;&nbsp;</span>
			<input type="text" name="question" value="${question.question}" placeholder="문제를 적으시오.">
		</div>
		<input type="text" class="question-answer input-form-control1" name="answer" value="${question.answer}" placeholder="답을 적으시오."><br>
		<button type="button" onclick="deleteQuestion(${question.qid})">X</button>
	</div>
	</c:forEach>
	<button type="button" onclick="location.href='makeOne.wkmb'">문제 추가</button>
	<div id="button-submit">
		<button id="button-submit-button" class="btn btn-default" type="submit">문제 출제</button>
	</div>
	<button type="button" onclick="location.href='./myPage.wkmb'">돌아가기</button>
</form>