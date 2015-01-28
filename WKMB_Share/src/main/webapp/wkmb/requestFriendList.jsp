<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:forEach var="friend" items="${friendList}">
	<c:if test="${friend.mode == 2}">
		<div id="requestFriendList-div">
			<div id="requestFriendList-info">
				<img src="../files/${friend.photo}" width="40" height="44">
				<span id="${friend.name}">${friend.name}(${friend.id})</span>																</div>
			<div id="requestFriendList-buttons">
				<span class="glyphicon glyphicon-ok" id="requestFriendList-ok" onclick="requestAccept(${friend.fuid})"></span>
				<span class="glyphicon glyphicon-remove" id="requestFriendList-remove" onclick="requestDeny(${friend.fuid})"></span><br>
			</div>
		</div>
	</c:if>
</c:forEach>