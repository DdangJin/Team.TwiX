<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Main</title>
<!-- 부트스트랩 -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap-theme.min.css">
<link rel="stylesheet" href="../css/common.css">
<script src="../js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/jquery-1.11.2.js"></script>
<script>
	function searchFriends()
	{
		$("#friendList").load("./searchFriends.wkmb?name=" + $("#searchFriend").val());
	}
</script>
</head>
<body>
	<c:choose>
		<c:when test="${empty loginInfo}">
			<!-- if(empty loginInfo) -->
			<meta http-equiv="Refresh" content="0; url=../" />
			<!-- 로그인을 안한상태에서 들어오면 index.html페이지로 이동(0초) -->
		</c:when>
		<c:otherwise>


			<nav class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<a href="./main.wkmb"><img src="../files/logo" width="50"
					height="50" /></a> MAIN
				<button type="button">${loginInfo.name}</button>
				<button type="button">친구 요청</button>
				<button type="button" onclick="location.href = './logout.wkmb'">로그아웃</button>
				<!-- './logout.wkmb'로 이동 -->
			</div>
			</nav>
			
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			
			<div> <!-- 내프로필과 친구 목록 -->
			
				<div id="myProfile">
				<c:choose>
				<c:when test="${empty loginInfo.photo}">
				<img src="../files/non-photo.png" style="width: 100px; height: 110px;">
				</c:when>
				<c:otherwise>
				<img src="../files/${loginInfo.photo}" style="width: 100px; height: 110px;">
				</c:otherwise>
				</c:choose>
				${loginInfo.name}
				(${loginInfo.id})
				${solvedFriend}명
				</div>
				
				<p>
				
				<div>
				친구(총 ${friendCount}명)
				<form>
					<input type="text" id="searchFriend" placeholder="검색할 친구의 이름 입력" onkeyup="searchFriends()">
				</form>
				</div>
				
				<p>
				
				<div id="friendList">
					<c:forEach var="friend" items="${friendList}">
					    <c:choose>
					    	<c:when test="${friend.mode == 0}">
					    		<div id="${friend.uid}">
					    		<c:choose>
								<c:when test="${empty loginInfo.photo}">
								<img src="../files/non-photo.png" style="width: 100px; height: 110px;">
								</c:when>
								<c:otherwise>
								<img src="../files/${loginInfo.photo}" style="width: 100px; height: 110px;">
								</c:otherwise>
								</c:choose>
								${friend.name}
								(${friend.id})
								${friend.score}%
					    		</div>
					    		<p>
				    		</c:when>
				    	</c:choose>
				    </c:forEach>
				</div>
			
			</div>
			
			<div>
			<h3>친구 창</h3>		<!-- 모드가 0이면 친구, 1이면 친구신청목록, 2이면 친구요청목록 -->
			<div>
			<h4>친구 목록</h4>
			
			<form>
			<c:set var="friendId" value=""/> <!-- 친구 목록 id만 받아오기 위해서 -->
			<c:set var="friendMode" value=""/> <!-- 친구 목록 mode만 받아오기 위해서 -->
			<c:forEach var="friend" items="${friendList}">
			<c:if test="${friend.mode == 0}">
				<span id="${friend.name}">${friend.name}(${friend.id})</span><br>
			</c:if>
			<c:set var="friendId" value="${friendId},${friend.id}"/> <!-- 친구id 저장 -->
			<c:set var="friendMode" value="${friendMode},${friend.mode}"/> <!-- 친구mode 저장 -->
			</c:forEach>
			
			<input type="text" id="searchId" placeholder="이름 검색" onkeyup="NameSearch()"/>
			</form>
			</div>
			
			<div>
			
			<h4>친구 신청 목록</h4>
			<!-- 신청을 누르는순간 비동기식으로 DB에 등록을 하고! DB에 변경된 점이 있다면! 친구요청에 뜨고 신청목록에도 뜬다! -->
			<form>
			
			<c:forEach var="friend" items="${friendList}">
			<c:if test="${friend.mode == 1}">
				<span id="${friend.name}">${friend.name}(${friend.id})</span><br>
			</c:if>
			</c:forEach>
			<h1>${friends}</h1>
			<input type="text" id="applyId" placeholder="ID 입력"/>
			<button type="button" onclick="ApplyFriend()">신청</button>
			</form>
			</div>
			
			<script>
			var friendId = new Array();
			var friendMode = new Array();
			<c:forTokens var="friendId" items="${friendId}" delims=",">
				friendId.push("${friendId}");
			</c:forTokens>
			<c:forTokens var="friendMode" items="${friendMode}" delims=",">
				friendMode.push("${friendMode}");
			</c:forTokens>
			
			
			// 이름을 검색해서 그 이름의 id의 span만 보이게 할것
			function NameSearch()
			{
				
			}
			
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
						alert("친구 추가 성공!");
					}
			  	  });
			  }
			  
			}
			</script>
			
			</div>
			
			
		</c:otherwise>
	</c:choose>
</body>
</html>