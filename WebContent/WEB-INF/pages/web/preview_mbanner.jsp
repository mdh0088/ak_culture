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
	$(function(){
		var swiper1 = new Swiper('.main-slide', {
			slidesPerView: 1,
			loop: true,
			autoplay: {
				delay: 3000,
				disableOnInteraction: false,
			},
			effect: 'fade',
			pagination: {
				el: '.swiper-pagination',
			},
		});
	})
	$(function(){
		var swiper2 = new Swiper('.rec-bot .swiper-container', {
			slidesPerView: 3,
			scrollbar: {
				el: '.swiper-scrollbar',
				draggable: true,
			},
		});
	})
	

</script>
</head>
<body>
		
		
		<div class="all-wrap">
		<div class="right-line">
			<span class="rline-h"></span>
		</div>

		<div class="container main" id="container-scroll">
			<div class="contain">				
				<div class="main-slidewr">
					<div class="main-slide swiper-container">
						<div class="swiper-wrapper">
							<c:forEach var="i" items="${list}" varStatus="loop">
								<div class="swiper-slide">
									<div class="slide-cot">
										<span></span>
										<span></span>
										<span></span>
										<span></span>
										<span></span>
									</div>
									<c:if test="${i.CON_TYPE eq 'file'}">
										<div class="slide-img" onclick="javascript:location.href='${image_dir}main_banner/${i.ATTACH}'" >
											<img src="${image_dir}main_banner/${i.BANNER}" alt="슬라이드이미지" onerror="this.src='/img/noimg.png'" style="width:1066px; height:880px;"/>
										</div>
									</c:if>
									<c:if test="${i.CON_TYPE eq 'url'}">
										<c:if test="${i.BANNER_POP eq 'now'}">		
											<div class="slide-img" onclick="javascript:location.href='${i.BANNER_LINK}'" >
												<img src="${image_dir}main_banner/${i.BANNER}" alt="슬라이드이미지" onerror="this.src='/img/noimg.png'" style="width:1066px; height:880px;"/>
											</div>
										</c:if>
										<c:if test="${i.BANNER_POP eq 'new'}">		
											<div class="slide-img" onclick="javascript:window.open('${i.BANNER_LINK}');" >
												<img src="${image_dir}main_banner/${i.BANNER}" alt="슬라이드이미지" onerror="this.src='/img/noimg.png'" style="width:1066px; height:880px;"/>
											</div>
										</c:if>
										
									</c:if>
									<div class="slide-text">
										<h1>${i.MAIN_TITLE}</h1>
										<p class="h1-stit">${i.SUB_TITLE}</p>
										<p>${i.DESCRIPTION }</p>
										<c:if test="${i.IS_BTN_SHOW eq 'Y'}">
											<div class="more-wr">
												<c:if test="${i.BTN_POP eq 'now'}">		
													<a class="more-btn" href="${i.BTN_LINK}"><span class="line"></span><span class="text">${i.BTN_NM }</span></a>
												</c:if>
												<c:if test="${i.BTN_POP eq 'new'}">		
													<a class="more-btn" onclick="javascript:window.open('${i.BTN_LINK}');"><span class="line"></span><span class="text">${i.BTN_NM }</span></a>
												</c:if>
											</div>
										</c:if>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="swiper-pagination"></div>
						<div class="msli-sns">
							<p class="msli-p">Share</p>
							<ul>
								<li><A href="https://www.facebook.com/AKplazaM" target="_blank"><img src="/preview/img/sns-icon02.png" alt="페이스북"></a></li>
								<li><A href="https://twitter.com/AKPlaza_HQ" target="_blank"><img src="/preview/img/sns-icon01.png" alt="트위터"></a></li>
							</ul>
						</div>
					</div>
					</div>
				</div>
				<!-- main-sec01 -->

				<!-- main-sec02 -->

				<!-- main-sec04 -->
				<!-- //main-sec04 -->
			</div>
				
		</div><!-- //container -->

</body>
</html>