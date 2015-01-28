<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="myProfile" class="profile-form-control" onclick="location.href='./myPage.wkmb?id=${loginInfo.id}'">
	<img class="profile-photo-form-control" src="../files/${loginInfo.photo}" style="width: 80px; height: 85px;">
	<div class="profile-text-form-control">
		<div class="profile-nameId-form-control">
			<span class="profile-name-form-control">${loginInfo.name}</span>
			<br>
			<span class="profile-id-form-control">(${loginInfo.id})</span>
		</div>
		<span class="profile-message-form-control">${loginInfo.message}</span>
		<span class="profile-count-form-control">${solvedFriend}명</span>
	</div>
</div>

<div id="profile-search">
	<span id="profile-search-count">친구(총 ${friendCount}명)</span> <br>
	<input type="text" id="profile-search-name" class="input-form-control1" placeholder="검색할 친구의 이름 입력" onkeyup="searchFriends()">
</div>

<p>
<div id="friendProfile">
	<c:forEach var="friend" items="${friendProfile}">
		<c:if test="${friend.mode == 0}">
			<div id="${friend.uid}" class="profile-form-control" onclick="location.href='./myPage.wkmb?id=${friend.id}'">
				<img class="profile-photo-form-control" src="../files/${friend.photo}" style="width: 80px; height: 85px;">
				<div class="profile-text-form-control">
					<div class="profile-nameId-form-control">
						<span class="profile-name-form-control">${friend.name}</span>
						<br>
						<span class="profile-id-form-control">(${friend.id})</span>
					</div>
					<span class="profile-message-form-control">${friend.message}</span>
					<div class="profile-three-form-control" data-threeTime="${friend.threeTime}">
					  	<span class="profile-three-form-control-circle">　</span>
					  	<span class="profile-three-form-control-circle">　</span>
						<span class="profile-three-form-control-circle">　</span>
					</div>
					<span class="profile-count-form-control">${friend.score}%</span>
					<span class="profile-lastDate-form-control"><fmt:formatDate pattern='yy-MM-dd HH:mm:ss' value="${friend.lastDate}" /></span>
				</div>
			</div>
			<p>
		</c:if>
	</c:forEach>
</div>