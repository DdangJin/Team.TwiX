<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Make</title>
<!-- 부트스트랩, css 링크 -->
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<link rel="stylesheet" href="../css/mystyle.css">
<link rel="stylesheet" href="../css/SolveAnswerMakeForm.css">


<style>

	#questionList {
		margin-top: 60px;
	}
	
	#button-remove {
		position: absolute;
		margin-top: -176px;
		margin-left: 770px;
	}
	
	#button-add {
		margin-top: 30px;
		width: 800px;
	}
	
	#button-add-button {
		margin-left: 357px;
	}
	
	#button-submit {
	margin: 0 auto;
	margin-top: 50px;
	margin-bottom: 50px;
	width: 800px;
	}
	
	#button-back-button {
		float: left;
	}
	
	#button-submit-button {
		clear: right;
		float: right;
		margin-bottom: 50px;
	}
	
	
	
	
	
	/* modal */
	.modal-content {
	  position: relative;
	  background-color: #fff;
	  -webkit-background-clip: padding-box;
	          background-clip: padding-box;
	  border: 1px solid #999;
	  border: 1px solid rgba(0, 0, 0, .2);
	  border-radius: 6px;
	  outline: 0;
	  -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
	          box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
	  width: 830px;
	  margin: 0 auto;
	  left: -120px;
	}
	
	.question-div-Modal {
		display: block;
		margin: 0 auto;
		margin-bottom: 30px;
		width: 800px;
		height: 200px;
		background-color: white;
	}
	
	#question-question-Modal {
	margin: 25px;
	padding-top: 10px;
	width: 730px;
	height: 105px;
	font-size: 18px;
	}
	
	.question-answer-Modal {
		float: right;
		margin-top: 20px;
		margin-right: 20px;
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
		<c:when test="${empty questionList}">				<!-- quiz가 등록 안된상태(5개) -->
		
			<div id="container">
				<div id="gfheader">
					<div id="header">
						<div id="userName">
							<span>${loginInfo.name}'s Quiz</span>
						</div>
					</div>
				</div>
		
				<div id="content">
					<div id="center-content">
						<div id="questionList">
							<form action="./insertQuestion.wkmb" method="post" onsubmit="return isFull();">
								<div id="question1" class="question-div">
									<div id="question-question">
										<span style="font-weight:bold;">[1번]&nbsp;&nbsp;</span>
										<textarea class="form-control" style="margin-top: 10px" cols="80" rows="3" name="question" placeholder="문제를 적으시오."></textarea>
									</div>
									<input type="text" class="question-answer input-form-control1" name="answer" placeholder="답을 적으시오."><br>
								</div>
								<div id="question2" class="question-div">
									<div id="question-question">
										<span style="font-weight:bold;">[2번]&nbsp;&nbsp;</span>
										<textarea class="form-control" style="margin-top: 10px" cols="80" rows="3" name="question" placeholder="문제를 적으시오."></textarea>
									</div>
									<input type="text" class="question-answer input-form-control1" name="answer" placeholder="답을 적으시오."><br>
								</div>
								<div id="question3" class="question-div">
									<div id="question-question">
										<span style="font-weight:bold;">[3번]&nbsp;&nbsp;</span>
										<textarea class="form-control" style="margin-top: 10px" cols="80" rows="3" name="question" placeholder="문제를 적으시오."></textarea>
									</div>
									<input type="text" class="question-answer input-form-control1" name="answer" placeholder="답을 적으시오."><br>
								</div>
								<div id="question4" class="question-div">
									<div id="question-question">
										<span style="font-weight:bold;">[4번]&nbsp;&nbsp;</span>
										<textarea class="form-control" style="margin-top: 10px" cols="80" rows="3" name="question" placeholder="문제를 적으시오."></textarea>
									</div>
									<input type="text" class="question-answer input-form-control1" name="answer" placeholder="답을 적으시오."><br>
								</div>
								<div id="question5" class="question-div">
									<div id="question-question">
										<span style="font-weight:bold;">[5번]&nbsp;&nbsp;</span>
										<textarea class="form-control" style="margin-top: 10px" cols="80" rows="3" name="question" placeholder="문제를 적으시오."></textarea>
									</div>
									<input type="text" class="question-answer input-form-control1" name="answer" placeholder="답을 적으시오."><br>
								</div>
								<div id="button-submit">
									<button id="button-submit-button" class="btn btn-default" type="submit">문제 출제</button>
								</div>
								<button type="button" onclick="location.href='./myPage.wkmb'">돌아가기</button>
							</form>
						</div>
					</div>
				</div>
			</div>
			
			</c:when>
			<c:otherwise>
			<div id="container">
				<div id="gfheader">
					<div id="header">
						<div id="userName">
							<span>${loginInfo.name}'s Quiz</span>
						</div>
					</div>
				</div>
	
				<div id="content">
					<div id="center-content">
						<div id="questionList">
							<form action="./updateQuestion.wkmb" method="post" onsubmit="return isFull();">
								<c:forEach var="question" items="${questionList}" varStatus="vs">
								<div id="question${questionNo}" class="question-div">
									<input type="hidden" name="qid" value="${question.qid}">
									<div id="question-question">
										<span style="font-weight:bold;">[${vs.index + 1}번]&nbsp;&nbsp;</span>
										<textarea class="form-control" style="margin-top: 10px" cols="80" rows="3" name="question" placeholder="문제를 적으시오.">${question.question}</textarea>
									</div>
									<input type="text" class="question-answer input-form-control1" name="answer" value="${question.answer}" placeholder="답을 적으시오."><br>
									<button id="button-remove" type="button" onclick="deleteQuestion(${question.qid}, ${questionListSize})">X</button>
								</div>
								</c:forEach>
								<div id="button-add">
									<button id="button-add-button" class="btn btn-default" type="button" data-toggle="modal" data-target="#myModal">문제 추가</button>
								</div>
								<div id="button-submit">
									<button id="button-back-button" class="btn btn-default" type="button" onclick="location.href='./myPage.wkmb'">돌아가기</button>
									<button id="button-submit-button" class="btn btn-default" type="submit">문제 출제</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				
			</div>
			
			
			<!-- MODAL -->
			
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h4 class="modal-title" id="myModalLabel">문제 추가</h4>
				      </div>
				      <form action="./insertQuestion.wkmb" method="post" onsubmit="return isFull();">
					      <div class="modal-body">
					        <div id="question" class="question-div-Modal">
								<div id="question-question-Modal">
									<span style="font-weight:bold;">[새문제]&nbsp;&nbsp;</span>
									<textarea class="form-control" style="margin-top: 10px" cols="80" rows="3" name="question" placeholder="문제를 적으시오."></textarea>
								</div>
								<input type="text" class="question-answer-Modal input-form-control1" name="answer" placeholder="답을 적으시오."><br>
							</div>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					        <button type="submit" class="btn btn-primary">Save changes</button>
					      </div>
					  </form>
				    </div>
				  </div>
				</div>
			
			
		</c:otherwise>
	</c:choose>
	
	
	
<!-- script -->
<script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script>

	function deleteQuestion(questionId, questionListSize)
	{
	  if(questionListSize<= 5)
	    alert("문제는 최소 5개가 있어야 합니다.");
	  else
	  {
	    var formData = new FormData();
	    formData.append("qid", questionId);

	    var xhr = new XMLHttpRequest();
	    xhr.open("POST", "./deleteQuestion.wkmb", false);
	    xhr.send(formData);
	    
	    // make.jsp의 questionList 태그 부분만을 가져와 로드 시킴.("#center-content"안의 내용을 "./make.wkmb #questionList"로 바꾼다)
	  	$("#center-content").load("./make.wkmb #questionList");
	  }
	}
	
	function isFull()
	{
	  var isFull = true;
	  $("#questionList").find("textarea").each(function(index, element){
    	if($(this).html() == "")
    	  isFull = false;
   	  });
   	  $("#questionList").find("input").each(function(index, element){
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


<!-- 
<div>
	문제를 내시면 그 문제 중 랜덤으로 5문제의 문제가 출제되게 됩니다.<br>
	하루에 3번씩만 문제를 풀 수 있습니다.<br>
	최소 5문제 이상의 문제를 등록하셔야합니다.
</div>
 -->