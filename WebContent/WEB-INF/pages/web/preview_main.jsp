<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<!-- <div id="header" class="header"> -->
<!-- 			<div class="header-wr table"> -->
<!-- 				<div class="logo"> -->
<!-- 					<div class="logo-wr"> -->
<!-- 						<a href="/"><img src="/preview/img/logo.png" alt="ak문화아카데미"/></a> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="nav-wr"> -->
<!-- 					<ul class="nav-ul nav-ul01"> -->
<!-- 						<li><a href="../academy/news">AK아카데미</a></li> -->
<!-- 						<li><a href="../course/course01">수강신청</a></li> -->
<!-- 						<li class="dis-no"><a>MY아카데미</a></li> -->
<!-- 						<li><a href="../cs/contact">고객서비스</a></li> -->
<!-- 						<li class="not-li"><a href="#">AK멤버스</a></li> -->
<!-- 					</ul> -->
<!-- 					<ul class="nav-ul nav-ul02"> -->
<!-- 						<li><a href="../academy/academy04"><img src="/preview/img/gnb-icon01.png" alt="ak문화아카데미 아이콘"/><span class="cart-count">3</span></a></li> -->
<!-- 						<li><a href="#"><img src="/preview/img/gnb-icon02.png" alt="ak문화아카데미 아이콘"/><span class="log-on"></span></a></li> -->
<!-- 						<li><a href="../academy/catalog"><img src="/preview/img/gnb-icon03.png" alt="ak문화아카데미 아이콘"/><span class="catal-i">E카탈로그</span></a></li> -->
<!-- 					</ul> -->
<!-- 				</div>	 -->
<!-- 				<div class="nav-r"> -->
<!-- 					<ul class="nav-ul nav-ul03"> -->
<!-- 						<li><a href="#" class="acad-btn"><img src="/preview/img/gnb-icon04.png" alt="ak문화아카데미 아이콘"/><span class="en-txt03">MY</span> 아카데미 바로가기</a></li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->

<!-- 			<div class="gnb-depth"> -->
<!-- 				<div class="gnb-depwr"></div> -->
<!-- 			</div> -->

<!-- 			<div class="menu-ham"> -->
<!-- 				<div class="hambtn"> -->
<!-- 					<span></span> -->
<!-- 					<span></span> -->
<!-- 					<span class="ham-txt">Menu</span> -->
<!-- 				</div> -->
<!-- 				<div class="menu-wrap"> -->
<!-- 					<div class="menu-wr"> -->
<!-- 						<div> -->
<!-- 							<ul class="menu-ul" id="sitemaps"> -->
<!-- 								<li class="menu-li menu-li01"><A href="#">AK아카데미</a> -->
<!-- 									<ul class="dep02"> -->
<!-- 										<li><a href="../academy/news">아카데미 뉴스</a></li> -->
<!-- 										<li><a href="../academy/recommend">추천 강좌</a></li> -->
<!-- 										<li><a href="../academy/catalog">E-카탈로그</a></li> -->
<!-- 										<li><a href="../academy/store01">지점 안내</a> -->
<!-- 											<ul class="dep03 dis-no"> -->
<!-- 												<li><a href="/academy/store01">분당점</a></li> -->
<!-- 												<li><a href="/academy/store02">수원점</a></li> -->
<!-- 												<li><a href="/academy/store03">평택점</a></li> -->
<!-- 												<li><a href="/academy/store04">원주점</a></li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 										<li><a href="../academy/lector01">강사 전용</a> -->
<!-- 											<ul class="dep03"> -->
<!-- 												<li><a href="../academy/lector01">강사 지원</a></li> -->
<!-- 												<li><a href="../academy/result01">지원서 수정/결과</a></li> -->
<!-- 												<li><a href="../academy/contract01">강사 계약</a></li> -->
<!-- 												<li><a href="../academy/plan01">강의 계획서 등록/수정</a></li> -->
<!-- 												<li><a href="../academy/attendance01">출석부 관리</a></li> -->
<!-- 												<li><a href="../academy/certificate01">증명서 발급<span>- 신청 내역</span></a></li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</li> -->
<!-- 								<li class="menu-li menu-li02"><A href="#">수강신청</a> -->
<!-- 									<ul class="dep02"> -->
<!-- 										<li><a href="../course/list01">강좌검색</a></li> -->
<!-- 										<li><a href="../course/course01">수강신청 가이드</a> -->
<!-- 											<ul class="dep03"> -->
<!-- 												<li><a href="../course/course01">수강안내</a></li> -->
<!-- 												<li><a href="../course/course05">온라인 신청 안내</a></li> -->
<!-- 												<li><a href="../course/course06">자녀회원 등록 안내</a></li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</li> -->
<!-- 								<li class="menu-li menu-li03"><A href="#">MY아카데미</a> -->
<!-- 									<ul class="dep02"> -->
<!-- 										<li><a href="../academy/academy01">회원정보 수정</a></li> -->
<!-- 										<li><a href="../academy/academy06">자녀회원 등록</a></li> -->
<!-- 										<li><a href="../academy/academy02">수강 정보</a> -->
<!-- 											<ul class="dep03"> -->
<!-- 												<li><a href="../academy/academy04">나의 책가방</a> -->
<!-- 													<ul class="dep04"> -->
<!-- 														<li><a href="../academy/order">결제하기</a></li> -->
<!-- 														<li><a href="../academy/order_end">결제완료</a></li> -->
<!-- 													</ul> -->
<!-- 												</li> -->
<!-- 												<li><a href="../academy/academy03">대기강좌 내역</a></li> -->
<!-- 												<li><a href="../academy/academy05">할인쿠폰 내역</a></li> -->
<!-- 											</ul> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</li> -->
<!-- 								<li class="menu-li menu-li04"><A href="#">고객서비스</a> -->
<!-- 									<ul class="dep02"> -->
<!-- 										<li><a href="../cs/contact">고객의 소리</a></li> -->
<!-- 										<li><a href="../cs/faq">FAQ</a></li> -->
<!-- 									</ul> -->
<!-- 								</li> -->
<!-- 								<li class="menu-li menu-li05"><A href="#">AK멤버스</a></li> -->
<!-- 							</ul> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="menu-img"> -->
<!-- 						<img src="/preview/img/menu-img.jpg" alt="메뉴이미지"/> -->
<!-- 						<a href="../academy/recommend" class="rec-btn">추천강좌 페이지 바로가기<img src="/preview/img/rec-bg.png" alt="추천강좌 바로가기 아이콘"/></a> -->
<!-- 					</div> -->
<!-- 					<div class="bg-line"> -->
<!-- 						<span></span> -->
<!-- 						<span></span> -->
<!-- 						<span></span> -->
<!-- 						<span></span> -->
<!-- 						<span></span> -->
<!-- 					</div> -->
<!-- 					<div class="msli-sns"> -->
<!-- 						<p class="msli-p">Share</p> -->
<!-- 						<ul> -->
<!-- 							<li><A href="https://www.facebook.com/AKplazaM" target="_blank"><img src="/preview/img/sns-icon02.png" alt="페이스북"></a></li> -->
<!-- 							<li><A href="https://twitter.com/AKPlaza_HQ" target="_blank"><img src="/preview/img/sns-icon01.png" alt="트위터"></a></li> -->
<!-- 						</ul> -->
<!-- 					</div> -->
<!-- 				</div>//menu-wrap -->
<!-- 			</div>//menu-ham -->

<!-- 			<div class="myaca-wrap"> -->
<!-- 				<div class="aca-clo"><img src="/preview/img/x-btn.png" alt="닫기"/></div> -->
<!-- 				<div class="aca-wr"> -->
<!-- 					<div class="aca-cont"> -->
<!-- 						<p class="aca-tit"><span class="name">홍길동</span> 고객님 안녕하세요.</p> -->
<!-- 						<div class="mile-wr mile-wr01"> -->
<!-- 							<p class="myac-tit"><span><img src="/preview/img/my-aca02.png" alt="ak아이콘"/>총 마일리지</span></p> -->
<!-- 							<p class="mile-pri">653,500<span class="won">원</span></p> -->
<!-- 							<a class="bor-btn mile-btn" href="#">마일리지 내역 보기</a> -->
<!-- 							<div class="myin-btnwr"> -->
<!-- 								<a class="btn btn03" href="../academy/academy01">회원정보 수정 <img src="/preview/img/my-aca01.png" alt="ak아이콘"/></a> -->
<!-- 								<a class="btn btn03" href="../academy/academy06">자녀회원 등록 <img src="/preview/img/my-aca01.png" alt="ak아이콘"/></a> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="mile-wr mile-wr02"> -->
<!-- 							<p class="myac-tit"><span><img src="/preview/img/my-aca03.png" alt="ak아이콘"/>수강내역</span></p> -->
<!-- 							<div class="myin-ta"> -->
<!-- 								<table class="myin-head"> -->
<!-- 									<colgroup> -->
<!-- 										<col width="5%"> -->
<!-- 										<col width="15%"> -->
<!-- 										<col width="15%"> -->
<!-- 										<col width="15%"> -->
<!-- 										<col/> -->
<!-- 										<col width="15%"> -->
<!-- 									</colgroup> -->
<!-- 									<tr> -->
<!-- 										<td></td> -->
<!-- 										<td>학기</td> -->
<!-- 										<td>수강자</td> -->
<!-- 										<td>시작일</td> -->
<!-- 										<td>강좌명</td> -->
<!-- 										<td>강사명</td> -->
<!-- 									</tr> -->
<!-- 								</table> -->
<!-- 								<div class="myin-scr"> -->
<!-- 									<table class="myin-body"> -->
<!-- 										<colgroup> -->
<!-- 											<col width="5%"> -->
<!-- 											<col width="15%"> -->
<!-- 											<col width="15%"> -->
<!-- 											<col width="15%"> -->
<!-- 											<col/> -->
<!-- 											<col width="15%"> -->
<!-- 										</colgroup> -->
<!-- 										<tr> -->
<!-- 											<td><span class="chk-d"></span></td> -->
<!-- 											<td>082</td> -->
<!-- 											<td>홍길동</td> -->
<!-- 											<td>20-03-24</td> -->
<!-- 											<td>사진촬영 고급기법 클래스</td> -->
<!-- 											<td>이지영</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td><span class="chk-d"></span></td> -->
<!-- 											<td>082</td> -->
<!-- 											<td>홍길동</td> -->
<!-- 											<td>20-03-24</td> -->
<!-- 											<td>사진촬영 고급기법 클래스</td> -->
<!-- 											<td>이지영</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td><span class="chk-d"></span></td> -->
<!-- 											<td>082</td> -->
<!-- 											<td>홍길동</td> -->
<!-- 											<td>20-03-24</td> -->
<!-- 											<td>사진촬영 고급기법 클래스</td> -->
<!-- 											<td>이지영</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td><span class="chk-d"></span></td> -->
<!-- 											<td>082</td> -->
<!-- 											<td>홍길동</td> -->
<!-- 											<td>20-03-24</td> -->
<!-- 											<td>사진촬영 고급기법 클래스</td> -->
<!-- 											<td>이지영</td> -->
<!-- 										</tr> -->
<!-- 										<tr> -->
<!-- 											<td><span class="chk-d"></span></td> -->
<!-- 											<td>082</td> -->
<!-- 											<td>홍길동</td> -->
<!-- 											<td>20-03-24</td> -->
<!-- 											<td>사진촬영 고급기법 클래스</td> -->
<!-- 											<td>이지영</td> -->
<!-- 										</tr> -->
<!-- 									</table> -->
<!-- 								</div> -->
<!-- 								<div class="myin-btnwr"> -->
<!-- 									<a class="btn btn03" href="r/academy/academy02">자세히 보기 <img src="/preview/img/my-aca01.png" alt="ak아이콘"/></a> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="mile-wr mile-wr03"> -->
<!-- 							<p class="myac-tit"><span><img src="/preview/img/my-aca04.png" alt="ak아이콘"/>수강정보</span></p> -->
<!-- 							<div class="myin-info"> -->
<!-- 								<a href="../academy/academy04"><img src="/preview/img/my-aca05.png" alt="ak아이콘"/>나의 책가방</a> -->
<!-- 								<a href="../academy/academy03"><img src="/preview/img/my-aca06.png" alt="ak아이콘"/>대기강좌 내역</a> -->
<!-- 								<a href="../academy/academy05"><img src="/preview/img/my-aca07.png" alt="ak아이콘"/>할인권 내역</a> -->
<!-- 							</div> -->
<!-- 						</div> -->
						
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
<!-- 		<div class="bg-line"> -->
<!-- 			<span></span> -->
<!-- 			<span></span> -->
<!-- 			<span></span> -->
<!-- 			<span></span> -->
<!-- 			<span></span> -->
<!-- 		</div> -->
		
		
		<div class="all-wrap">
		<div class="right-line">
			<span class="rline-h"></span>
		</div>

		<div class="container main" id="container-scroll">
			<div class="contain">				
				<div class="main-slidewr">
					<div class="main-slide swiper-container">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<div class="slide-cot">
									<span></span>
									<span></span>
									<span></span>
									<span></span>
									<span></span>
								</div>
								<div class="slide-img">
									<img src="/preview/img/slide-img01.png" alt="슬라이드이미지"/>
								</div>
								<div class="slide-text">
									<h1>Life, Atelier</h1>
									<p class="h1-stit">어느 봄날의 아틀리에</p>
									<p>2020년에는 삶이 더욱 풍성해지도록 당신의 삶에 리듬을 더해보세요. <br>
									생애 가장 젊은 날인 오늘도, <br>
									AK 문화아카데미가 당신의 리드미컬 라이프를 응원합니다.
									</p>
									<div class="more-wr">
										<a class="more-btn" href="#"><span class="line"></span><span class="text">VIEW MORE</span></a>
									</div>
								</div>
							</div>
							<div class="swiper-slide">
								<div class="slide-cot">
									<span></span>
									<span></span>
									<span></span>
									<span></span>
									<span></span>
								</div>
								<div class="slide-img">
									<img src="/preview/img/slide-img01-1.png" alt="슬라이드이미지"/>
								</div>
								<div class="slide-text">
									<h1>Life, Atelier</h1>
									<p class="h1-stit">어느 봄날의 아틀리에</p>
									<p>2020년에는 삶이 더욱 풍성해지도록 당신의 삶에 리듬을 더해보세요. <br>
									생애 가장 젊은 날인 오늘도, <br>
									AK 문화아카데미가 당신의 리드미컬 라이프를 응원합니다.
									</p>
									<div class="more-wr">
										<a class="more-btn" href="#"><span class="line"></span><span class="text">VIEW MORE</span></a>
									</div>
								</div>
							</div>
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
					<div class="main-search">
						<div class="main-sein">
								<div class="msear-dwr msear-dwr01">
									<div class="msear-bar table">
										<div>
											<p class="msear-tit">Step 01</p>
											<div class="search-box">
												<p><b>수강 대상</b>을 선택해주세요.</p>
												<select de-data="수강 대상을 선택해주세요.">
													<option value="">성인</option>
													<option value="">영유아</option>
													<option value="">유아</option>
													<option value="">어린이</option>
													<option value="">ALL</option>
												</select>
											</div>
										</div>
										<div>
											<p class="msear-tit">Step 02</p>
											<div class="search-box search-box-two">
												<p><b>강좌 분야</b>를 선택해주세요.</p>
												<div class="li-dep">
													<select de-data="강좌 분야를 선택해주세요.">
														<option value="2dep-1">성인</option>
														<option value="2dep-2">영유아</option>
														<option value="">유아</option>
														<option value="">어린이</option>
														<option value="">ALL</option>
													</select>
												</div>
												<div class="sear-2dep">
													<select de-data="강좌 분야를 선택해주세요.">
														<option value="">피트니스</option>
														<option value="">공예</option>
														<option value="">플라워</option>
														<option value="">인문학</option>
														<option value="">재테크</option>
														<option value="">피트니스</option>
													</select>
													<select de-data="강좌 분야를 선택해주세요.">
														<option value="">공예</option>
														<option value="">플라워</option>
														<option value="">플라워</option>
														<option value="">인문학</option>
														<option value="">재테크</option>
														<option value="">피트니스</option>
													</select>
												</div>
											</div>
										</div>
										<div class="stepbox03">
											<p class="msear-tit">Step 03</p>
											<div class="search-box">
												<p><b>원하는 요일</b>을선택해주세요.</p>
												<select de-data="원하는 요일을 선택해주세요.">
													<option value="">월요일</option>
													<option value="">화요일</option>
													<option value="">수요일</option>
													<option value="">목요일</option>
													<option value="">금요일</option>
													<option value="">토요일</option>
													<option value="">일요일</option>
												</select>
											</div>
										</div>
										<div class="stepbox03">
											<p class="msear-tit">Step 04</p>
											<div class="search-box">
												<p><b>강좌 유형</b>을 선택해주세요. </p>
												<select de-data="강좌 유형을 선택해주세요.">
													<option value="">성인</option>
													<option value="">영유아</option>
													<option value="">유아</option>
													<option value="">어린이</option>
													<option value="">ALL</option>
												</select>
											</div>
										</div>
									</div>
								</div>
								<div class="msear-dwr msear-dwr02">
									<div class="msear-bar table">
										<div class="msear-div05">
											<div class="search-box">
												<p><b>강좌명/강사명/유아 개월</b>을 검색해주세요.</p>
												<div class="input-sear">
													<input type="text" id="search_val" name="search_val" placeholder="#봄 제철재료 브런치 플래터">
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="search-btn">
								SEARCH
							</div>
						</div>
					</div>
				</div>
				<!-- main-sec01 -->
				<div class="main-sec main-sec01">
					<div class="quick-mn mu-grid ani-eff text">
						<div>
							<a class="quick-href" href="/academy/catalog"></a>
							<img src="/preview/img/quick-i01.png" alt="ak문화아카데미 버튼이미지"/>
							<h4>E-카탈로그</h4>
							<p>한 눈에 보는 다양한 강좌정보</p>
						</div>
						<div>
							<a class="quick-href" href="/course/course01"></a>
							<img src="/preview/img/quick-i02.png" alt="ak문화아카데미 버튼이미지"/>
							<h4>수강신청</h4>
							<p>원하는 수업 바로 신청하기</p>
						</div>
						<div>
							<a class="quick-href" href="/academy/academy04"></a>
							<img src="/preview/img/quick-i03.png" alt="ak문화아카데미 버튼이미지"/>
							<h4>나의 책가방</h4>
							<p>내가 관심 있었던 강좌 확인하기</p>
						</div>
						<div>
							<a class="quick-href" href="/academy/store01"></a>
							<img src="/preview/img/quick-i04.png" alt="ak문화아카데미 버튼이미지"/>
							<h4>지점안내</h4>
							<p>한 눈에 보는 <br>AK 문화아카데미 지점 </p>
						</div>
						<div>
							<a class="quick-href" href="/academy/lector01"></a>
							<img src="/preview/img/quick-i05.png" alt="ak문화아카데미 버튼이미지"/>
							<h4>강사지원</h4>
							<p>열정 가득 실력있는 강사님 모집</p>
						</div>
					</div>
				</div>
				<!-- //main-sec01 -->

				<!-- main-sec02 -->
				<div class="main-sec main-sec02 ani-eff text">
					<div class="rec-top mu-grid">
						<div class="rec-tabwr">
							<h1 class="en-txt eff-t">Recomendation</h1>
							<ul class="rec-tab">
								<li class="active"><a href="#">#성인취미</a></li>
								<li><a href="#">#요리</a></li>
								<li><a href="#">#어학</a></li>
								<li><a href="#">#다이어트</a></li>
								<li><a href="#">#그림</a></li>
							</ul>
							<a class="more-btn" href="/academy/recommend.php"><span class="line"></span><span class="text">VIEW MORE</span></a>
						</div>
					</div>
					<div class="rec-bot">
						<div class="swiper-container">
							<div class="swiper-scrollbar"></div>
							<div class="swiper-wrapper">
								<!-- rec-box -->
								<div class="rec-box swiper-slide">
									<div class="qui-cart"><img src="/preview/img/cart-icon.png" alt="장바구니담기"/></div>
									<P class="rec-data">
										<span class="open">03.02</span>
										<span class="close">-05.25</span>
										<span class="year">2020</span>
									</p>
									<div class="ani-eff image">
										<img src="/preview/img/rec-img01.png" alt="이미지"/>
									</div>
									<p class="rec-stit">Watercolor Starter Class</p>
									<p class="rec-tit">수채화 풍경그리기 초보 클래스</p>
									<ul class="rec-ul">
										<li><span>분당점</span>특강 성인</li>
										<li><span>권영주</span>금 15:00 -17:10</li>
										<li><span>12회</span>100,000원 (재료비 70,000원)</li>
									</ul>
								</div>	
								<!-- //rec-box -->
								<!-- rec-box -->
								<div class="rec-box swiper-slide">
									<div class="qui-cart"><img src="/preview/img/cart-icon.png" alt="장바구니담기"/></div>
									<P class="rec-data">
										<span class="open">03.02</span>
										<span class="close">-05.25</span>
										<span class="year">2020</span>
									</p>
									<div class="ani-eff image">
										<img src="/preview/img/rec-img01.png" alt="이미지"/>
									</div>
									<p class="rec-stit">Watercolor Starter Class</p>
									<p class="rec-tit">수채화 풍경그리기 초보 클래스</p>
									<ul class="rec-ul">
										<li><span>분당점</span>특강 성인</li>
										<li><span>권영주</span>금 15:00 -17:10</li>
										<li><span>12회</span>100,000원 (재료비 70,000원)</li>
									</ul>
								</div>	
								<!-- //rec-box -->
								<!-- rec-box -->
								<div class="rec-box swiper-slide">
									<div class="qui-cart"><img src="/preview/img/cart-icon.png" alt="장바구니담기"/></div>
									<P class="rec-data">
										<span class="open">03.02</span>
										<span class="close">-05.25</span>
										<span class="year">2020</span>
									</p>
									<div class="ani-eff image">
										<img src="/preview/img/rec-img01.png" alt="이미지"/>
									</div>
									<p class="rec-stit">Watercolor Starter Class</p>
									<p class="rec-tit">수채화 풍경그리기 초보 클래스</p>
									<ul class="rec-ul">
										<li><span>분당점</span>특강 성인</li>
										<li><span>권영주</span>금 15:00 -17:10</li>
										<li><span>12회</span>100,000원 (재료비 70,000원)</li>
									</ul>
								</div>	
								<!-- //rec-box -->
								<!-- rec-box -->
								<div class="rec-box swiper-slide">
									<div class="qui-cart"><img src="/preview/img/cart-icon.png" alt="장바구니담기"/></div>
									<P class="rec-data">
										<span class="open">03.02</span>
										<span class="close">-05.25</span>
										<span class="year">2020</span>
									</p>
									<div class="ani-eff image">
										<img src="/preview/img/rec-img01.png" alt="이미지"/>
									</div>
									<p class="rec-stit">Watercolor Starter Class</p>
									<p class="rec-tit">수채화 풍경그리기 초보 클래스</p>
									<ul class="rec-ul">
										<li><span>분당점</span>특강 성인</li>
										<li><span>권영주</span>금 15:00 -17:10</li>
										<li><span>12회</span>100,000원 (재료비 70,000원)</li>
									</ul>
								</div>	
								<!-- //rec-box -->
								<!-- rec-box -->
								<div class="rec-box swiper-slide">
									<div class="qui-cart"><img src="/preview/img/cart-icon.png" alt="장바구니담기"/></div>
									<P class="rec-data">
										<span class="open">03.02</span>
										<span class="close">-05.25</span>
										<span class="year">2020</span>
									</p>
									<div class="ani-eff image">
										<img src="/preview/img/rec-img01.png" alt="이미지"/>
									</div>
									<p class="rec-stit">Watercolor Starter Class</p>
									<p class="rec-tit">수채화 풍경그리기 초보 클래스</p>
									<ul class="rec-ul">
										<li><span>분당점</span>특강 성인</li>
										<li><span>권영주</span>금 15:00 -17:10</li>
										<li><span>12회</span>100,000원 (재료비 70,000원)</li>
									</ul>
								</div>	
								<!-- //rec-box -->
								<!-- rec-box -->
								<div class="rec-box swiper-slide">
									<div class="qui-cart"><img src="/preview/img/cart-icon.png" alt="장바구니담기"/></div>
									<P class="rec-data">
										<span class="open">03.02</span>
										<span class="close">-05.25</span>
										<span class="year">2020</span>
									</p>
									<div class="ani-eff image">
										<img src="/preview/img/rec-img01.png" alt="이미지"/>
									</div>
									<p class="rec-stit">Watercolor Starter Class</p>
									<p class="rec-tit">수채화 풍경그리기 초보 클래스</p>
									<ul class="rec-ul">
										<li><span>분당점</span>특강 성인</li>
										<li><span>권영주</span>금 15:00 -17:10</li>
										<li><span>12회</span>100,000원 (재료비 70,000원)</li>
									</ul>
								</div>	
								<!-- //rec-box -->
								
							</div>
						</div>
					</div>
				</div>
				<!-- //main-sec02 -->

				<!-- main-sec03 -->
				<div id="main-sec03" >
					<div class="main-sec03 ani-eff text">
						<div class="eve-txtwr">
							<p class="eve-ban"><span class="en-txt">AK Members Card</span> 그 특별한 혜택</p>
							<p>쇼핑부터 할인까지 최고의서비스 당신이 꿈꾸던 카드를 지금 만나보세요! </p>
						</div>
						<div class="ani-eff image">
							<img src="/preview/img/event-banner.png" alt="혜택배너"/>
						</div>
					</div>
				</div>
				<!-- //main-sec03 -->

				<!-- main-sec04 -->
				<div id="main-sec04" class="main-sec04 ani-eff text">
					<div class="text-center">
						<h1 class="en-txt eff-t">AK Culture Now</h1>
						<p class="h1-sp eff-t">AK 문화아카데미의 새로운 소식들을 함께 만나보세요!</p>
					</div>
					<div class="main-noti mu-grid">
						<div>
							<div class="noti-info">
								<span class="noti-t">NOTICE</span>
								<span>2020.03.20</span>
							</div>
							<p class="subject">모바일 수강신청 가이드</p>
							<p class="contents">
								AK문화아카데미 모바일(http://m.akplaza.com) 또는 앱 다운 받으시고 회원가입 하시면 수강신청을 편리하게 이용하실 수 있습니다. 
							</p>
						</div>
						<div>
							<div class="noti-info">
								<span class="noti-t">NOTICE</span>
								<span>2020.03.20</span>
							</div>
							<p class="subject">모바일 수강신청 가이드</p>
							<p class="contents">
								AK문화아카데미 모바일(http://m.akplaza.com) 또는 앱 다운 받으시고 회원가입 하시면 수강신청을 편리하게 이용하실 수 있습니다. 
							</p>
						</div>
						<div>
							<div class="noti-info">
								<span class="noti-t">NOTICE</span>
								<span>2020.03.20</span>
							</div>
							<p class="subject">모바일 수강신청 가이드</p>
							<p class="contents">
								AK문화아카데미 모바일(http://m.akplaza.com) 또는 앱 다운 받으시고 회원가입 하시면 수강신청을 편리하게 이용하실 수 있습니다. 
							</p>
						</div>
					</div>
					<div class="more-wr">
						<a class="more-btn" href="/academy/news.php"><span class="line"></span><span class="text">VIEW MORE</span></a>
					</div>
				</div>
				<!-- //main-sec04 -->
<!-- 				<div id="footer" class="footer"> -->
<!-- 					<div> -->
<!-- 						<div class="footer-top"> -->
<!-- 							<div class="foo-top"> -->
<!-- 								<div class="fo-logo"><img src="/preview/img/fo-logo.png" alt="ak문화아카데미"/></div> -->
<!-- 							</div> -->
<!-- 							<div class="foo-bo mu-grid"> -->
<!-- 								<div class="family-wr"> -->
								
<!-- 									<p class="family-tit">Family Site</p> -->
<!-- 									<ul class="fam-ul"> -->
<!-- 									  <li><a href="http://www.akplaza.com" target="_blank" title="새창 열림">AK PLAZA</a></li> -->
<!-- 									  <li><a href="http://www.akmembers.com" target="_blank" title="새창 열림">AK MEMBERS</a></li> -->
<!-- 									  <li><a href="http://www.akmall.com" target="_blank" title="새창 열림">AK MALL</a></li> -->
<!-- 									  <li><a href="http://culture.akplaza.com/" target="_blank" title="새창 열림">문화아카데미</a></li> -->
<!-- 									  <li><a href="http://www.aekyung.co.kr/" target="_blank" title="새창 열림">애경산업주식회사</a></li> -->
<!-- 									  <li><a href="http://www.akc.co.kr/" target="_blank" title="새창 열림">애경화학주식회사</a></li> -->
<!-- 									  <li><a href="http://www.atecltd.com/" target="_blank" title="새창 열림">주식회사에이텍</a></li> -->
<!-- 									  <li><a href="http://www.akp.co.kr/" target="_blank" title="새창 열림">애경유화주식회사</a></li> -->
<!-- 									  <li><a href="http://www.kospa.co.kr/" target="_blank" title="새창 열림">코스파주식회사</a></li> -->
<!-- 									  <li><a href="http://www.akdjbcc.co.kr/" target="_blank" title="새창 열림">애경개발주식회사</a></li> -->
<!-- 									  <li><a href="http://www.akchemtech.co.kr/" target="_blank" title="새창 열림">에이케이컴텍</a></li> -->
<!-- 									  <li><a href="http://www.jejuair.net/" target="_blank" title="새창 열림">제주항공</a></li> -->
<!-- 									</ul> -->
									
<!-- 								</div> -->
<!-- 								<div class="table"> -->
<!-- 									<div class="fbox fbox01"> -->
<!-- 										<ul class="foo-ul foo-ul01"> -->
<!-- 											<li><a href="http://www.akmembers.com/home/commonjsp.do?pageskin=common.customer.stipulation&nav=7_4_0_0" target="_blank">이용약관</a></li> -->
<!-- 											<li><a href="http://www.akmembers.com/home/commonjsp.do?pageskin=common.customer.individual&nav=7_5_0_0" target="_blank">개인정보처리방침</a></li> -->
<!-- 											<li><a href="http://www.akmembers.com/home/commonjsp.do?pageskin=common.customer.email&nav=7_6_0_0" target="_blank">이메일무단수집거부</a></li> -->
<!-- 											<li><a href="http://akethics.akplaza.com/noauth/akethics/board/commonjsp.do?pageskin=common.morality.charter&nav=8_1_0_0" target="_blank">윤리경영</a></li> -->
<!-- 										</ul> -->
<!-- 									</div> -->
<!-- 									<div class="fbox fbox02"> -->
<!-- 										<ul class="foo-ul foo-ul02"> -->
<!-- 											<li><a href="https://www.facebook.com/AKplazaM" target="_blank"><img src="/preview/img/facebook-icon.png" alt="페이스북">Facebook</a></li> -->
<!-- 											<li><a href="https://twitter.com/AKPlaza_HQ" target="_blank"><img src="/preview/img/twitter-icon.png" alt="페이스북">Twitter</a></li> -->
<!-- 										</ul> -->
<!-- 									</div> -->
<!-- 									<div class="fbox fbox03"> -->
<!-- 										<ul class="foo-ul foo-ul03"> -->
<!-- 											<li><b>CEO</b>김진태</li> -->
<!-- 											<li><b>ADDRESS</b>경기도 평택시 평택로 51</li> -->
<!-- 											<li><b>개인정보관리책임자</b>이한나</li> -->
<!-- 										</ul> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="footer-wr table"> -->
<!-- 							<div class="foo-div"> -->
<!-- 								<a href="#"> -->
<!-- 									<img src="/preview/img/ak-members.png" alt="ak문화아카데미"/> -->
<!-- 									<span class="fo-tit">AK MEMBERS<img src="/preview/img/foo-icon01.png" alt="ak문화아카데미"/></span> -->
<!-- 									<span class="fo-stit">다양한 혜택과 서비스를 만나다</span> -->
<!-- 								</a> -->
<!-- 							</div> -->
<!-- 							<div class="foo-div foo-div02"> -->
<!-- 								<a href="#"> -->
<!-- 									<img src="/preview/img/ak-mall.png" alt="ak문화아카데미"/> -->
<!-- 									<span class="fo-tit">AK MALL<img src="/preview/img/foo-icon01.png" alt="ak문화아카데미"/></span> -->
<!-- 									<span class="fo-stit">백화점을 클릭하다</span> -->
<!-- 								</a> -->
<!-- 							</div> -->
<!-- 							<div class="foo-div foo-div03"> -->
<!-- 								<a href="#"> -->
<!-- 									<img src="/preview/img/ak-members.png" alt="ak문화아카데미"/> -->
<!-- 									<span class="fo-tit">AK PLAZA<img src="/preview/img/foo-icon01.png" alt="ak문화아카데미"/></span> -->
<!-- 									<span class="fo-stit">새로운 생활의 즐거움</span> -->
<!-- 								</a> -->
<!-- 							</div>					 -->
<!-- 						</div> -->
<!-- 						<p class="copyright"> -->
<!-- 							Copyrightⓒ2020 AK PLAZA Department Store All Right Reserved. -->
<!-- 						</p> -->
<!-- 					</div> -->
<!-- 				</div>footer -->
			</div>

				
		</div><!-- //container -->

</body>
</html>