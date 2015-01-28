<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="changeMyProfile-info">
	<img src="../files/${loginInfo.photo}" id="myPhoto" class="profile-photo-form-control" style="float:left;"/>

    <div id="changeMyProfile-text" class="profile-nameId-form-control">
		<span class="profile-name-form-control">${loginInfo.name}</span><br>
		<span id="changeMyProfile-id" class="profile-id-form-control">(${loginInfo.id})</span>
	</div>
</div>

<div id="changeMyProfile-ButtonMessage">
	<span class="btn btn-default btn-sm btn-file" style="float:left;">
	    Browse <input type="file" id="changeMyPhoto" onchange="changeMyPhoto()">
	</span>
	<button type="button" id="deleteMyPhoto" class="btn btn-default btn-sm" style="float:right;" onclick="deleteMyPhoto()">프로필 사진 삭제</button>
</div>

<div id="changeMyProfile-ButtonMessage">
	<input type="text" id="myMessage" placeholder="상태말 입력" class="input-form-control1" onblur="changeMyMessage()" value="${loginInfo.message}">
</div>