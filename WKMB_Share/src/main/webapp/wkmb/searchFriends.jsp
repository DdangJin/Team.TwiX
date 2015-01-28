<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<script>
/* 하루에 세번의 기회를 표시하는 신호등 표시하는 스크립트 구현 */
$('.profile-three-form-control').each(function(index, element){
  var count = $(element).attr('data-threeTime');
  $(this).find('span').each(function(i, e){
    if (i < count) {
    	$(this).addClass('profile-three-form-control-selected-' + (i + 1));
    }
  });
});
</script>