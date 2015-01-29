<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Solve</title>
<!-- 부트스트랩, css 링크 -->
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<link rel="stylesheet" href="../css/mystyle.css">
<link rel="stylesheet" href="../css/SolveAnswerMakeForm.css">

<style>
	
	#nav {
		width: 502px;
		border-top:2px solid #2c3e50;
		border-left:2px solid #2c3e50;
		margin:50px auto 50px auto;
		height:30px;
		text-align: center;
		font-size: 20px;
	}
	
	.section {
		display: inline;
		float:left;
		width: 100px;
		height: 30px;
		line-height: 20px;
		border-right: 2px solid #2c3e50;
		border-bottom: 2px solid #2c3e50;
		padding-top: 2px;
	}
	
	.section:hover {
		background-color: #E0E92E;
		cursor: pointer;
		font-weight: bold;
	}
	
	.selected {
		background-color: #E0E92E;
	}
	
	#button-move {
		width: 800px;
	}
	
	#button-previous-button {
		float: left;
	}
	
	#button-next-button {
		float: right;
	}
	
	#button-submit {
	margin: 0 auto;
	margin-top: 50px;
	margin-bottom: 50px;
	width: 800px;
	}
	
	#button-submit-button {
		clear: right;
		float: right;
		margin-top: 50px;
	}
	
	
	


</style>


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
			<!-- 자신의 문제 풀기 사이트로 들어오면 make.wkmb 페이지로 이동(0초) -->
		</c:when>
		<c:when test="${empty questionList}">
			<script>
				alert("${questionUser.name}님이 아직 문제를 내지 않으셨습니다.");
				location.href = "./myPage.wkmb?id=${questionUser.id}";
			</script>
		</c:when>
		<c:otherwise>
			
			<div id="container">
				<div id="gfheader">
					<div id="header">
						<div id="userName">
							<span>${questionUser.name}'s Quiz</span>
						</div>
					</div>
				</div>
				
				<div id="content">
					<div id="center-content">
						<div id="nav">
							<div id="section1" class="section selected" onclick="changeQuestion(1)">1번</div>
							<div id="section2" class="section" onclick="changeQuestion(2)">2번</div>
							<div id="section3" class="section" onclick="changeQuestion(3)">3번</div>
							<div id="section4" class="section" onclick="changeQuestion(4)">4번</div>
							<div id="section5" class="section" onclick="changeQuestion(5)">5번</div>
						</div>
						<form action="./answer.wkmb" method="post" onsubmit="return submitAnswer();">
							<c:forEach var="question" items="${questionList}" varStatus="vs">
							<div id="question${vs.index + 1}" class="question-div">
								<div id="question-question">
									<span style="font-weight:bold;">[${vs.index + 1}번]&nbsp;&nbsp;</span>
									<span>${question.question}</span>
								</div>
								<input type="text" id="answer${vs.index}" class="question-answer input-form-control1" name="answer" placeholder="답을 적으시오."><br>
							</div>
							</c:forEach>
							<div id="button-move">
								<button id="button-previous-button" class="btn btn-default" type="button" onclick="previous()">이전</button>
								<button id="button-next-button" class="btn btn-default" type="button" onclick="next()">다음</button>
							</div>
							<div id="button-submit">
								<button id="button-submit-button" class="btn btn-default" type="submit">제출</button>
							</div>
						</form>
					</div>
				</div>
				
			</div>
			
			
		</c:otherwise>
	</c:choose>
	
	
	
<!-- script -->
<script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
<script type="text/javascript">

	var currentQuestion = 1;

	for(var i = 2; i<= 5; i++)
	  $("#question" + i).css("display", "none");

	function submitAnswer()
	{
		for(var i = 0; i< 5; i++)
			if($("#answer" + i).val() == "")
			{
				if(!confirm("입력 안한 답이 있습니다.\n제출하시겠습니까?"))
					return false;
				
				break;
			}
		
		return true;
	}
	
	function changeQuestion(questionNo)
	{
		for(var i = 1; i<= 5; i++)
		{
			if(i == questionNo) {
				$("#question" + questionNo).css("display", "");
				$("#section" + questionNo).css("background-color", "#E0E92E");
			}
			else {
				$("#question" + i).css("display", "none");
				$("#section" + i).css("background-color", "#FFF9EC");
			}
		}
	}
	
	function previous()
	{
	  currentQuestion = ((currentQuestion - 1) - 1 + 5) % 5 + 1;
	  
	  changeQuestion(currentQuestion);
	}
	
	function next()
	{
	  currentQuestion = ((currentQuestion - 1) + 1) % 5 + 1;
	  
	  changeQuestion(currentQuestion);
	}

</script>
	
	
	
</body>
</html>