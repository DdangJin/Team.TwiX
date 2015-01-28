<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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