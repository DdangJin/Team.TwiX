<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="friendBar-subTitle"> <!-- 글자간 간격을 주기 위해서 -->
	<span>FriendList</span>
</div>

<c:set var="friendId" value="" />
<!-- 친구 목록 id만 받아오기 위해서 -->
<c:set var="friendMode" value="" />
<!-- 친구 목록 mode만 받아오기 위해서 -->
<c:forEach var="friend" items="${friendList}">
	<c:if test="${friend.mode == 0}">
		<div class="friendsName">
			<a href="./myPage.wkmb?id=${friend.id}" class="friend-link"><span id="${friend.name}">${friend.name}(${friend.id})</span></a>
		</div>
		<br>
	</c:if>
	<c:set var="friendId" value="${friendId},${friend.id}" />
	<!-- 친구id 저장 -->
	<c:set var="friendMode" value="${friendMode},${friend.mode}" />
	<!-- 친구mode 저장 -->
</c:forEach>
<!-- TODO -->
<input type="text" id="searchId" class="input-form-control1" placeholder="이름 검색" onkeyup="NameSearch()" />
<br>
<br>