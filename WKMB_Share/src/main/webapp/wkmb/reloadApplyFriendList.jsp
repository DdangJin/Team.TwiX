<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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