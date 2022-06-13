<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AK문화아카데미</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- <script src="/preview/js/jquery.nicescroll.min.js"></script> -->
<script src="/preview/js/animation.js"></script>
<script src="/preview/js/musign.js"></script>

<!-- 추가플러그인 -->
<script src="/preview/js/swiper.js"></script>
<link rel="stylesheet" href="/preview/css/swiper.css">

<!-- 뮤자인 -->
<link rel="stylesheet" href="/preview/css/mu_layout.css">
<!-- <script src="/preview/js/TweenMax.min.js"></script> -->
<!-- <script src="/preview/js/smooth-scrollbar.js"></script> -->
<!-- <script src="/preview/js/ScrollMagic.js"></script> -->
<!-- <script src="/preview/js/animation.gsap.js"></script> -->


<!-- 뮤자인 -->

<link rel="stylesheet" href="/preview/css/main_in.css">
<!-- <script src="/preview/js/main.js"></script> -->


<script>

</script>
</head>
<body>
		
<c:forEach var="i" items="${list}" varStatus="loop">
	<c:if test="${i.IS_CENTER eq 'N' }">
		<div id="main_popup" class="main_popup pop_idx${i.SEQ}" style="position: absolute; z-index: 10000; top: ${i.MARGIN_TOP}px; left: ${i.MARGIN_LEFT}px; ">
			<c:if test="${i.POPUP_POP eq 'now'}">		
				<div class="" onclick="javascript:location.href='${i.POPUP_LINK}'">
					<img src="${image_dir}popup/${i.POPUP_IMG}" alt="" onerror="this.src='/img/noimg.png'" />
				</div>
			</c:if>
			<c:if test="${i.POPUP_POP eq 'new'}">		
				<div class="" onclick="javascript:window.open('${i.POPUP_LINK}');" >
					<img src="${image_dir}popup/${i.POPUP_IMG}" alt="" onerror="this.src='/img/noimg.png'" />
				</div>
			</c:if>
			<div class="popup_bottom">
				<c:if test="${i.NOT_TODAY eq 'Y' }">
					<span class="close_popup_day" onclick="pop_todayclose('${i.SEQ}')">오늘하루 열지않기</span>
				</c:if>
				<div class="event-pop" onclick="pop_close('${i.SEQ}')"">닫기</div>
			</div>
		</div>
	</c:if>
	<c:if test="${i.IS_CENTER eq 'Y' }">
		<div id="main_popup" class="main_popup pop_idx${i.SEQ}" style="position: absolute; z-index: 10000; top: 50%; left:50%; ">
			<c:if test="${i.POPUP_POP eq 'now'}">		
				<div class="" onclick="javascript:location.href='${i.POPUP_LINK}'">
					<img src="${image_dir}popup/${i.POPUP_IMG}" alt="" onerror="this.src='/img/noimg.png'"/>
				</div>
			</c:if>
			<c:if test="${i.POPUP_POP eq 'new'}">		
				<div class="" onclick="javascript:window.open('${i.POPUP_LINK}');" >
					<img src="${image_dir}popup/${i.POPUP_IMG}" alt="" onerror="this.src='/img/noimg.png'"/>
				</div>
			</c:if>
			<div class="popup_bottom">
				<c:if test="${i.NOT_TODAY eq 'Y' }">
					<span class="close_popup_day" onclick="pop_todayclose('${i.SEQ}')">오늘하루 열지않기</span>
				</c:if>
				<div class="event-pop" onclick="pop_close('${i.SEQ}')">닫기</div>
			</div>
		</div>
	</c:if>
</c:forEach>

<script>
var openPopCnt = 0;
$(window).ready(function(){
	var pop_idx='';
	var pop_idx_arry=[];
	$('.main_popup').each(function(){ 
		pop_idx = $(this).attr('class').replace('main_popup','').trim();
		pop_idx_arry.push(pop_idx);
	})

	for (var i = 0; i < $('.main_popup').length+1; i++) {
		if(getCookie(pop_idx_arry[i])!="Y"){
			$("."+pop_idx_arry[i]).show('fade');
			if(pop_idx_arry[i] != undefined)
			{
    			openPopCnt ++;	
			}
		}
	}
	if(openPopCnt > 0)
	{
		$("#main_popup_bg").show();
	}
});
function pop_todayclose(idx){
	alert("미리보기에서는 해당 기능을 지원하지 않습니다.");
}
function pop_close(idx){
	$(".pop_idx"+idx).hide('fade');
	openPopCnt --;
	if(openPopCnt == 0)
	{
		$("#main_popup_bg").hide();
	}
}
</script>
				
</body>
</html>
