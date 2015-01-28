<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Page</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<link rel="stylesheet" href="../css/mystyle.css">
<link rel="stylesheet" href="../css/MainMypageForm.css">

<style>

	#header-title {
		position: absolute;
		width: 300px;
		height: 50px;
		font-family: 'Hanna';
		font-size: 30px;
		font-weight: bold;
		margin: 5px 500px 5px 300px;
	}

	#myQuiz {
		width: 670px;
		min-height: 750px;
		margin: 30px 40px;
	}
	
	#myQuiz-button {
		display: block;
		width: 100px;
		margin-bottom: -10px;
	}
	
	#ranking {
		border: 8px double black;
		padding-left: 20px;
		padding-right: 20px;
	}
	
	#myRanking {
		font-size: 50px;
		text-align: center;
		margin-top: 10px;
		font-family: 'Nanum Pen Script';
		font-weight: bold;
		height: 70px;
	}
	
	#rank-table-rank {
		width: 70px;
		margin: 0 auto;
		text-align: center;
		vertical-align: center;
		font-size: 30px;
	}
	
	#rank-table-profile {
		width: 43px;
	}
	
	
	
	
	
	
	
	

</style>



</head>


<body>
	<c:choose>
		<c:when test="${empty loginInfo}">
			<!-- if(empty loginInfo) -->
			<meta http-equiv="Refresh" content="0; url=../" />
			<!-- 로그인을 안한상태에서 들어오면 index.html페이지로 이동(0초) -->
		</c:when>
		
		<c:when test="${empty pageUser}">
			<!-- if(empty pageUser) -->
			<meta http-equiv="Refresh" content="0; url=./main.wkmb" />
			<!-- 없는 유저의 페이지로 들어오면 main.wkmb페이지로 이동(0초) -->
		</c:when>
		
		<c:otherwise>

			<div id="container">
				<div id="gfheader">
					<div id="header">
						<div id=header-image>
							<a href="./main.wkmb"><img src="../files/logo.png" width="50" height="40" /></a>
						</div>
						<div id="header-title">${pageUser.name}'s Page</div>
						<div id="header-button">
							<ul>
                				<li id="header-button-myname" onclick="boxVisibilityName()"><span id="header-button-text">${loginInfo.name}</span>
                  					<ul onclick="event.stopPropagation()">	<!-- 부모로의 버블링을 막는다 -->
			                    		<div id="header-button-myname-box">
			                      			<div id="header-button-myname-box-inner">
			                      				<div id="changeMyProfile">	<!-- 내 상태 수정 -->
			                      					<div id="changeMyProfile-info">
														<img src="../files/${loginInfo.photo}" id="myPhoto" class="profile-photo-form-control"
																 style="float:left;"/>
	
				                      					<div id="changeMyProfile-text" class="profile-nameId-form-control">
															<span class="profile-name-form-control">${loginInfo.name}</span><br>
															<span id="changeMyProfile-id" class="profile-id-form-control">(${loginInfo.id})</span>
														</div>
													</div>
													
													<div id="changeMyProfile-ButtonMessage">
														<span class="btn btn-default btn-sm btn-file" style="float:left;">
														    Browse <input type="file" id="changeMyPhoto" onchange="changeMyPhoto()">
														</span>
														<button type="button" id="deleteMyPhoto" class="btn btn-default btn-sm" style="float:right;"
															onclick="deleteMyPhoto()">프로필 사진 삭제</button>
													</div>
													
													<div id="changeMyProfile-ButtonMessage">
														<input type="text" id="myMessage" placeholder="상태말 입력" class="input-form-control1"
																onblur="changeMyMessage()" value="${loginInfo.message}">
													</div>
												</div>
												
												
												
			                      			</div>
			                    		</div>
                 					</ul>
                				</li>
                				<li id="header-button-friend" onclick="boxVisibilityFriend()"><span id="header-button-text">친구 요청</span>
                  					<ul onclick="event.stopPropagation()">
                    					<div id="header-button-friend-box">
					                    	<div id="header-button-friend-box-inner">
					                        	<div id="requestFriendList"> <!-- 친구 요청 목록 -->
													<c:forEach var="friend" items="${friendList}">
														<c:if test="${friend.mode == 2}">
					                        				<div id="requestFriendList-div">
																<div id="requestFriendList-info">
																	<img src="../files/${friend.photo}" width="40" height="44">
																	<span id="${friend.name}">${friend.name}(${friend.id})</span>
																</div>
																<div id="requestFriendList-buttons">
																	<span class="glyphicon glyphicon-ok" id="requestFriendList-ok" onclick="requestAccept(${friend.fuid})"></span>
																	<span class="glyphicon glyphicon-remove" id="requestFriendList-remove" onclick="requestDeny(${friend.fuid})"></span><br>
																</div>
															</div>
														</c:if>
													</c:forEach>
													
												</div>
                      						</div>
                    					</div>
                  					</ul>
                				</li>
                				<li id="header-button-logout" onclick="location.href = './logout.wkmb'"><span id="header-button-text">로그아웃</span></li><!-- './logout.wkmb'로 이동 -->
              				</ul>
						</div>
					</div>
					
				</div>
			
				
				<div id="gfcontent">			
					<div id="content"> <!-- 내 퀴즈 바로가기(친구의 퀴즈 바로가기)와 친구 랭킹 -->
						<div id="left-content">
							<div id="myQuiz">
								<div id=quiz"> <!-- 퀴즈 바로가기 -->
									<c:choose>
									<c:when test="${loginInfo.id == pageUser.id}">
										<span id="myQuiz-button" class="btn btn-default btn-sm btn-file" onclick="location.href='./make.wkmb'">내 문제 가기</span>
									</c:when>
									<c:otherwise>
										<span id="myQuiz-button" class="btn btn-default btn-sm btn-file" onclick="location.href='./solve.wkmb?id=${pageUser.id}'">문제 풀러 가기</span>
									</c:otherwise>
									</c:choose>
								</div>
								
								<p>
								
								<div id="ranking"> <!-- 랭킹 -->
									<div id="myRanking">${pageUser.name}'s ranking</div>
									<table id="rank-table" class="table table-striped">
										<thead>
											<th></th><th>Profile</<th><th>Name</th><th>Score</th>
										</thead>
										<c:forEach var="pageFriend" items="${pageFriendList}" varStatus="vs">
											<tr>
												<td id="rank-table-rank">${vs.index + 1}</td><td id="rank-table-profile"><img src="../files/${pageFriend.photo}" width="40" height="44" /></td><td id="rank-table-name">${pageFriend.name}</td><td id="rank-table-score">${pageFriend.score}%</td>
											</tr>
										</c:forEach>
									</table>
								
								</div>
							</div>
						</div>
						
						
						<div id="friendBar">
							<!-- 모드가 0이면 친구, 1이면 친구신청목록, 2이면 친구요청목록 -->
							<div id="friendBar-mode0">
								<div class="friendBar-subTitle">
									<span>FriendList</span>
								</div>
			
								<form>
									<c:set var="friendId" value="" />
									<!-- 친구 목록 id만 받아오기 위해서 -->
									<c:set var="friendMode" value="" />
									<!-- 친구 목록 mode만 받아오기 위해서 -->
									<c:forEach var="friend" items="${friendList}">
										<c:if test="${friend.mode == 0}">
											<div class="friendsName">
												<span id="${friend.name}">${friend.name}(${friend.id})</span>
											</div>
											<br>
										</c:if>
										<c:set var="friendId" value="${friendId},${friend.id}" />
										<!-- 친구id 저장 -->
										<c:set var="friendMode" value="${friendMode},${friend.mode}" />
										<!-- 친구mode 저장 -->
									</c:forEach>
			
									<input type="text" id="searchId" class="input-form-control1" placeholder="이름 검색" onkeyup="NameSearch()" />
									<br>
									<br>
								</form>
							</div>
			
							<div id="friendBar-mode1">
								<div class="friendBar-subTitle">
									<span>ApplyFriendList</span>
								</div>
								<!-- 신청을 누르는순간 비동기식으로 DB에 등록을 하고! DB에 변경된 점이 있다면! 친구요청에 뜨고 신청목록에도 뜬다! -->
								<form>
			
									<c:forEach var="friend" items="${friendList}">
										<c:if test="${friend.mode == 1}">
											<div class="friendsName">
												<span id="${friend.name}">${friend.name}(${friend.id})</span>
											</div>
											<br>
										</c:if>
									</c:forEach>
									<input type="text" id="applyId" class="input-form-control2" placeholder="ID 입력" />
									<button type="button" onclick="ApplyFriend()">신청</button>
								</form>
							</div>
						</div>
						
						
					</div>
				</div>
			</div>
			
		</c:otherwise>
	</c:choose>
	
	

<!-- script -->	
<script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
<script type="text/javascript">
	var friendId = new Array();
	var friendMode = new Array();
	<c:forTokens var="friendId" items="${friendId}" delims=",">
		friendId.push("${friendId}");
	</c:forTokens>
	<c:forTokens var="friendMode" items="${friendMode}" delims=",">
		friendMode.push("${friendMode}");
	</c:forTokens>
	
	
	//이름을 검색해서 그 이름의 id의 span만 보이게 할것
	function NameSearch() {
	  var name = $("#searchId").val();
	  $("#friendBar-mode0").find("div").find("span").each(function(index, element){
	    // 여기서 찾아서
        if(($(this).html()).indexOf(name)> -1 && name != "")
	    	$(this).addClass("searchedFriend");
	    else
	    	$(this).removeClass("searchedFriend");
	  });
	}
	  
	
	// 친구 id로 친구 요청
	function ApplyFriend()
	{
	  var fid = $('#applyId').val();
	  var mode = -1;
	  var over = false;
	  
	  if(fid == "")
		  return;
	  
	  for(var i in friendId)
	  {
	  	if(friendId[i] == fid)
			{
	  		mode = friendMode[i];
				over = true;
				break;
			}
	  		
	  }
	  
	  if(over)
	  {
	  	if(mode == 0)
			{
				alert("이미 친구입니다.");
			}else if(mode == 1)
			{
				alert("이미 친구를 신청하셨습니다.");
			}else
			{
				alert("친구 신청을 보내온 친구입니다.\n친구 요청 목록을 보십시오.");
			}
	  }else{
		  $.getJSON("./addFriend.wkmb?fid=" + fid, function(obj) {
			if (obj.result == "") {
				alert("없는 사용자입니다!"); 
			} else {
				$("#friendBar-mode1").find("form").load("./reloadApplyFriendList.wkmb");
				
				alert("친구 추가 성공!");
			}
	  	  });
	  }
	  
	}
	
	
	/* header-buttom부분을 처리하기 위한 함수들 */
	function boxVisibilityName(){
		var tmp = document.getElementById("header-button-myname-box");
		var tmp2 = document.getElementById("header-button-friend-box");
		if(tmp.style.visibility == "visible"){
			tmp.style.visibility="hidden";
		}else{
			tmp.style.visibility="visible";
	    	tmp2.style.visibility="hidden";
	  	}
 
	}
	
	
	function boxVisibilityFriend(){
		var tmp = document.getElementById("header-button-friend-box");
		var tmp2 = document.getElementById("header-button-myname-box");
		if(tmp.style.visibility == "visible") {
			tmp.style.visibility="hidden";
	  	}else{
			tmp.style.visibility="visible";
			tmp2.style.visibility="hidden";
		}
	}
	
	
	function requestAccept(fuid)	// 친구 요청 수락
	{
		$("#requestFriendList").load("./requestAccept.wkmb?fuid=" + fuid);
		
		$("#friendBar-mode0").load("./reloadFriendList.wkmb");
	}
	
	function requestDeny(fuid)		// 친구 요청 거절
	{
		$("#requestFriendList").load("./requestDeny.wkmb?fuid=" + fuid);
	}
	
	// 내 사진 수정
	function changeMyPhoto()
	{
		var fileInput = document.getElementById("changeMyPhoto");
	    var file = fileInput.files[0];	// 파일을 저장
	    var formData = new FormData();
	    formData.append("photo", file);	// 저장한 파일을 photo라는 파라미터 이름으로 폼데이터에 저장

	    var xhr = new XMLHttpRequest();	// 서버에 보내기 위해 만들고
	    xhr.open("POST", "./changeMyPhoto.wkmb", false);	// post방식의 동기화 방식으로 서버에게 요청을 열음
	    xhr.send(formData);	// 서버에게 폼데이터 전송
	    
	    // 내 정보 부분을 ajax로 리프레쉬
	    $("#changeMyProfile").load("./changeMyProfile.wkmb");
	    
	    $("#myProfile").load("./reloadMyProfile.wkmb");
    }
	
	// 내 사진 삭제 => 기본 사진으로
	function deleteMyPhoto()
	{
		// 서버에게 사진을 제거해달라고 요청을 하고 false를 이용하여 동기화 방식으로 요청한 것이
		// 다 수행 되고 나서 리프레쉬을 하게 함.
		// send를 써야만 서버에게 요청을 하므로 이 send 요청이 끝나야 리프레쉬
		var xhr = new XMLHttpRequest();
	    xhr.open("POST", "./deleteMyPhoto.wkmb", false);
	    xhr.send();
	    
		// 내 정보 부분을 ajax로 리프레쉬
	    $("#changeMyProfile").load("./changeMyProfile.wkmb");
		
	    $("#myProfile").load("./reloadMyProfile.wkmb");
	}
	
	function changeMyMessage()
	{
		var formData = new FormData();
		formData.append("message", $("#myMessage").val());	// message라는 파라미터 이름으로 메세지말 저장
		
		var xhr = new XMLHttpRequest();
	    xhr.open("POST", "./changeMyMessage.wkmb", false);	// 비동기화 방식으로 처리
	    xhr.send(formData);
	    
	    $("#myProfile").load("./reloadMyProfile.wkmb");
	}
	
</script>
	
	
	
</body>
</html>