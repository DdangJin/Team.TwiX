<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Make</title>
</head>
<body>
			<div>
				문제를 내시면 그 문제 중 랜덤으로 5문제의 문제가 출제되게 됩니다.<br>
				하루에 3번씩만 문제를 풀 수 있습니다.<br>
				최소 5문제 이상의 문제를 등록하셔야합니다.
			</div>
	<c:choose>
		<c:when test="${empty loginInfo}">
			<!-- if(empty loginInfo) -->
			<meta http-equiv="Refresh" content="0; url=../" />
			<!-- 로그인을 안한상태에서 들어오면 index.html 페이지로 이동(0초) -->
		</c:when>
		<c:otherwise>
		
			<div id="questionList">
			<form action="./insertQuestion.wkmb" method="post" onsubmit="return isFull();">
				<div id="question" class="question-div">
					<div id="question-question">
						<span style="font-weight:bold;">[새문제]&nbsp;&nbsp;</span>
						<input type="text" name="question" placeholder="문제를 적으시오.">
					</div>
					<input type="text" class="question-answer input-form-control1" name="answer" placeholder="답을 적으시오."><br>
				</div>
				<div id="button-submit">
					<button id="button-submit-button" class="btn btn-default" type="submit">문제 출제</button>
				</div>
				<button type="button" onclick="location.href='./make.wkmb'">돌아가기</button>
			</form>
			</div>
			
		</c:otherwise>
	</c:choose>
	<script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
	<script>
		function isFull()
		{
		  var isFull = true;
    	  $("input").each(function(index, element){
	    	if($(this).val() == "")
	    	  isFull = false;
    	  });
    	  
    	  if(!isFull)
    	    alert("모든 문항을 채우십시오!");
		  
		  return isFull;
		}
	</script>
</body>
</html>