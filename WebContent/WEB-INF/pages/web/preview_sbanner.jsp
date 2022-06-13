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


</head>
<body>
		
		
		<div class="all-wrap">
		<div class="right-line">
			<span class="rline-h"></span>
		</div>

		<div class="container main" id="container-scroll">
			<c:forEach var="i" items="${list}" varStatus="loop">
				<!-- main-sec03 -->
				<div class="main-sec03 ani-eff text">
					<div class="eve-txtwr">
						<p class="eve-ban"><span class="en-txt">${i.BANNER_NAME}</span></p>
						<p>${i.BANNER_DESC}</p>
					</div>
					<div class="ani-eff image">
						<c:if test="${i.BANNER_POP eq 'now'}">
							<img src="${image_dir}sub_banner/${i.BANNER}" alt="혜택배너" onerror="this.src='/img/noimg.png'" onclick="javascript:location.href='${image_dir}sub_banner/${i.DETAIL}'" style="width:1284px; height:238px;"/>
						</c:if>
						<c:if test="${i.BANNER_POP eq 'new'}">
							<img src="${image_dir}sub_banner/${i.BANNER}" alt="혜택배너" onerror="this.src='/img/noimg.png'" onclick="javascript:window.open('${image_dir}sub_banner/${i.DETAIL}');" style="width:1284px; height:238px;"/>
						</c:if>
					</div>
				</div>
			</c:forEach>
				<!-- //main-sec03 -->

				<!-- main-sec04 -->
				<!-- //main-sec04 -->
			</div>

				
		</div><!-- //container -->

</body>
</html>