<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				${friend.name} (${friend.id}) ${friend.score}%
			</div>
			<p>
		</c:when>
	</c:choose>
</c:forEach>