<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="ak_culture.classes.*" %>
<%
ArrayList<String> noneAuthArr = (ArrayList)session.getAttribute("noneAuthArr");


%>
<script>
var noneAuthString = '<%=noneAuthArr%>';
noneAuthString = noneAuthString.replace("[", "");
noneAuthString = noneAuthString.replace("]", "");
noneAuthString = noneAuthString.replace(/\//gi, "_"); 
var noneAuthArr = noneAuthString.split(", ");

var login_id = "<%=session.getAttribute("login_id")%>";

$(function(){
	if(login_id != 'admin')
	{
		for(var i = 0; i < noneAuthArr.length; i++)
		{
			$("#"+noneAuthArr[i]).remove(); //권한없는 메뉴 삭제
		}
		$('.lnb-dep3').each(function () {  //모두삭제된경우 상위 까지 삭제
			console.log($(this).html());
			if(trim($(this).html()) == "")
			{
				$(this).parents("li").remove();
			}
		});
		if(trim($(".lnb_basic_manage").html()) == "")
		{
			$(".lnb_basic_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_lecr_manage").html()) == "")
		{
			$(".lnb_lecr_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_lect_manage").html()) == "")
		{
			$(".lnb_lect_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_member_manage").html()) == "")
		{
			$(".lnb_member_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_trms_manage").html()) == "")
		{
			$(".lnb_trms_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_it_manage").html()) == "")
		{
			$(".lnb_it_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_stat_manage").html()) == "")
		{
			$(".lnb_stat_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_web_manage").html()) == "")
		{
			$(".lnb_web_manage").parents("div").parents("div").parents("li").remove();
		}

	}
	$(".menu-i").click(function(){
		var chk = $(".lnb_2depth").css("display");
		//console.log(chk)
		if(chk == "none"){
			$("body").removeClass("menu-on");
		}else{
			$("body").addClass("menu-on");
		}
		setTimeout(function(){
			thSize();
		},500)
	})
	
	$(window).resize(function() {
		var windowWidth = $(window).width();
		/*
		if(windowWidth < 1600) {
			$("body").addClass("menu-on");
		} else {
			$("body").removeClass("menu-on");
		}
		*/
		setTimeout(function(){
			thSize();
		},500)
		
	});
	/*$("body").addClass("rnb-on");*/
	$(".rnb-menu").click(function(){
		var chk = $(".rnb-cont").css("display");
		//console.log(chk)
		
		if(chk == "none"){
			$("body").addClass("rnb-on");
			$(".bell").addClass("on");
		}else{
			$("body").removeClass("rnb-on");
			$(".bell").removeClass("on");
		}
		$(".rnb-cont").slideToggle();
	})
});
function goLocation(url)
{
	resetCookie();
	location.href=url;
}
function show_2depth(val)
{
	$(".lnb_1depth").removeClass("act");
	$("."+val).addClass("act");
	
	$(".lnb_"+val+"_manage").show();
}
/*  
$( document ).ready(function() {
	var link = location.href;
	if(link.indexOf("/basic/") > -1)
	{
		show_2depth('basic');
		if(link.indexOf("/user/list") > -1)
		{
			$(".user_list").addClass("act");
		}
		if(link.indexOf("/ip/list") > -1 || link.indexOf("/pos/list") > -1)
		{
			$(".ip_list").addClass("act");
		}
		if(link.indexOf("/code/list") > -1)
		{
			$(".code_list").addClass("act");
		}
		if(link.indexOf("/park/list") > -1)
		{
			$(".park_list").addClass("act");		
		}
		if(link.indexOf("/peri/list") > -1)
		{
			$(".peri_list").addClass("act");		
		}
		if(link.indexOf("/gift/list") > -1)
		{
			$(".gift_list").addClass("act");		
		}
	}
	
});
*/
$(function() {
  //$('#breadcrumbs').breadcrumbsGenerator();
//   var tit = $('.sub-tit h2').text().replace(/ /gi, '');
//   $('.lnb_2depth a').not('.dis-no a').each(function(){
// 	var $txt =$(this).text().replace(/ /gi, '');
// 	if($txt.indexOf(tit) != -1){
// 		var Bigtit = $(this).parents('.lab-ulwr').find('.lnb-tit').text();
// 		$('#breadcrumbs').append('<li>'+Bigtit+'</li><li>'+$txt+'</li>');
// 	}
	
//   })
});
/*
jQuery.fn.autolink = function () {

	return this.each( function(){
	var re = /((http|https|ftp):\/\/[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>))/g;
	$(this).html( $(this).html().replace(re, '<a href="$1">$1</a> ') );
	});

}*/

$(function() {
	 $(".lnb_1depth .lnb-ul > li").eq(0).addClass("act");
	 $(".lnb_2depth > div").eq(0).addClass("act");
	 var path = location.pathname;
	 //console.log(path)
	 $("a").each(function(){
		var $this = $(this);
		var href = $(this).attr("href");
		if(path == href){
			 $(".lnb_1depth .lnb-ul > li").removeClass("act");
			 $(".lnb_2depth > div").removeClass("act");
			$this.addClass("act");
			$this.parents("li, div").addClass("act");
		}
	 })
	 var ind = $(".lnb_2depth > div.act").index();
	 $(".lnb_1depth .lnb-ul > li").eq(ind).addClass("act");
	 
	 $(".lnb_2depth > div > ul > li").each(function(){
		 var $this = $(this);
		 var dep3 = $(this).find(".lnb-dep3").not(".dis-no");
		 //console.log(dep3)

	 	if(dep3.length > 0){
	 		$this.addClass('dep3-onli');
	 		$this.children('a').append('<span class="material-icons">arrow_right</span>')
	 	}
	 	$this.click(function(){
	 		if(dep3.css("display") == "none"){
	 			dep3.slideDown();
			}else{
				/*dep3.slideUp();*/
			}
	 		
	 	})
	 	
	 })
	 
	$(".lnb_2depth > div").each(function(){
		var ind = $(this).index();
		var html = $(this).html();
		$(".lnb_1depth > ul > li").eq(ind).append('<div class="ab-dep"><div>'+html+'</div></div>');
		//console.log(html)

		
	})
	
	if(login_id != 'admin')
	{
		if(trim($(".lnb_basic_manage").html()) == "")
		{
			$(".lnb_basic_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_lecr_manage").html()) == "")
		{
			$(".lnb_lecr_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_lect_manage").html()) == "")
		{
			$(".lnb_lect_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_member_manage").html()) == "")
		{
			$(".lnb_member_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_trms_manage").html()) == "")
		{
			$(".lnb_trms_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_it_manage").html()) == "")
		{
			$(".lnb_it_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_stat_manage").html()) == "")
		{
			$(".lnb_stat_manage").parents("div").parents("div").parents("li").remove();
		}
		if(trim($(".lnb_web_manage").html()) == "")
		{
			$(".lnb_web_manage").parents("div").parents("div").parents("li").remove();
		}

	}

	$('.lnb_2depth a.act').each(function(){
		var size = $(this).parents("li").size(),
			box = $(this).parents('.lab-ulwr'),
			Bigtit = $(this).parents('.lab-ulwr').find('.lnb-tit').text(),
			txt = $(this).text().replace(/\arrow_right/g,"");
		$('#breadcrumbs').append('<li>'+Bigtit+'</li>');
		$(this).parents("li").each(function(){
			var stit = $(this).children("a").text().replace(/\arrow_right/g,"");
			if(stit !== txt){
				$('#breadcrumbs').append('<li>'+stit+'</li>');
			};	
		});
		$('#breadcrumbs').append('<li>'+txt+'</li>');
	})
});
</script>
<div id="lnb">
	<div class="lnb-wr">
		<div class="menu-i">
			<i class="material-icons open material-icons-round">menu_open</i>
			
			
			<i class="material-icons close material-icons-round">menu</i>
		</div>
		<div class="lnb-dep lnb_1depth">
			<ul class="lnb-ul">
				<li class="basic" onclick="show_2depth('basic')"><span>기본관리</span><i class="i02-s material-icons material-icons-round">border_all</i></li>
				<li><span>강사관리</span><i class="far fa-user"></i></li>
				<li><span>강좌관리</span><i class="far fa-file-alt"></i></li>
				<li><span>수강/회원관리</span><i class="far fa-address-book"></i></li>
				<li><span>매출/마감관리</span><i class="fas fa-cog"></i></li>
				<li><span>정산관리</span><i class="fas fa-calculator"></i></li>
				<li><span>통계관리</span><i class="fas fa-chart-bar"></i></li>
				<li><span>WEB관리</span><i class="fas fa-desktop"></i></li>
			</ul>
		</div>
		<div class="lnb-dep lnb_2depth" id="sitemaps">
			<div class="lab-ulwr">
				<p class="lnb-tit">기본관리</p>
				<ul class="lnb_basic_manage lnb_3depth">
					<li class="user_list lnb-tit02"><a>운영자 관리</a>
						<ul class="lnb-dep3">
							<li id="_basic_user_list"><a href="/basic/user/list" onclick="goLocation('/basic/user/list')">운영자 리스트</a>
								<ul class="lnb-dep3 dis-no">
									<li><a href="/basic/user/log">운영자 로그관리</a></li>
									<li><a href="/basic/user/level">등급별 권한 설정</a></li>
									<li class="dis-no"><a href="/basic/user/view">운영자 상세</a></li>
									
								</ul>
							</li>
							<li id="_basic_ip_list"><a href="/basic/ip/list" onclick="goLocation('/basic/ip/list')">IP 관리</a></li>
							<li id="_basic_pos_list"><a href="/basic/pos/list" onclick="goLocation('/basic/pos/list')">POS 관리</a></li>
						</ul>
					</li>
					<li id="_basic_peri_list" class="peri_list lnb-tit02"><a href="/basic/peri/list">기수 관리</a></li>
					<li id="_basic_park_list" class="park_list lnb-tit02"><a href="/basic/park/list" onclick="goLocation('/basic/park/list')">주차 관리</a></li>
					<li class="gift_list lnb-tit02"><a>사은품 관리</a>
						<ul class="lnb-dep3">
							<li id="_basic_gift_listed"><a href="/basic/gift/listed" onclick="goLocation('/basic/gift/listed')">사은품 리스트</a></li>							
							<li id="_basic_gift_list"><a href="/basic/gift/list" onclick="goLocation('/basic/gift/list')">사은품 지급내역</a></li>
							<li class="dis-no"><a href="/basic/gift/write">사은품 등록</a></li>
						</ul>
					</li>
					<li class="encd_list lnb-tit02"><a>할인 관리</a>
						<ul class="lnb-dep3">
							<li id="_basic_encd_listed"><a href="/basic/encd/listed" onclick="goLocation('/basic/encd/listed')">할인코드 리스트</a></li>
							<li id="_basic_encd_list"><a href="/basic/encd/list" onclick="goLocation('/basic/encd/list')">할인 내역</a></li>
							<li class="dis-no"><a href="/basic/encd/write">할인코드 등록</a></li>	
						</ul>
					</li>
					
				</ul>
			</div>
			<div class="lab-ulwr">
				<p class="lnb-tit">강사관리</p>
				<ul class="lnb_lecr_manage">
					<li id="_lecture_lecr_write"><a href="/lecture/lecr/write">강사 등록</a></li>
					<li><a>강사 정보</a>
						<ul class="lnb-dep3">
							<li id="_lecture_lecr_list"><a href="/lecture/lecr/list" onclick="goLocation('/lecture/lecr/list')">강사 조회</a></li>
							<li id="_lecture_lecr_list_new"><a href="/lecture/lecr/list_new" onclick="goLocation('/lecture/lecr/list_new')">신규강사 평가리스트</a></li>
							<li id="_lecture_lecr_lecr_join"><a href="/lecture/lecr/lecr_join">강사통합</a></li>
							<li class="dis-no"><a href="/lecture/lecr/listed">강사상세</a></li>
						</ul>
					</li>					
					<li id="_lecture_lecr_transaction"><a href="/lecture/lecr/transaction" onclick="goLocation('/lecture/lecr/transaction')">거래선 상신</a></li>					
					<li id="_lecture_lecr_contract"><a onclick="goLocation('/lecture/lecr/contract')">강사 계약서</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/lecture/lecr/contract_write">강사계약서</a></li>
							<li><a href="/lecture/lecr/contract">강사 계약서</a></li>
						</ul>
					</li>
					<li id="_lecture_lecr_status"><a href="/lecture/lecr/status" onclick="goLocation('/lecture/lecr/status')">강사 지원서 관리</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/lecture/lecr/detail">강사상세</a></li>
						</ul>
					</li>					
					<li><a>증명서 관리</a>
						<ul class="lnb-dep3">
							<li id="_lecture_lecr_certificate_list"><a href="/lecture/lecr/certificate_list" onclick="goLocation('/lecture/lecr/certificate_list')">증명서 발급리스트</a></li>
							<li id="_lecture_lecr_certificate"><a href="/lecture/lecr/certificate" onclick="goLocation('/lecture/lecr/certificate')">출강증명서</a></li>
							<li id="_lecture_lecr_certificate_tax"><a href="/lecture/lecr/certificate_tax">원천징수영수증</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="lab-ulwr">
				<p class="lnb-tit">강좌 관리</p>
				<ul class="lnb_lect_manage">
					<li id="_lecture_lect_list_cate"><a href="/lecture/lect/list_cate">강좌분류관리</a></li>
					<li id="_lecture_lect_main"><a href="/lecture/lect/main" onclick="goLocation('/lecture/lect/main');">개설강좌 등록</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/lecture/lect/write">강좌코드추가</a></li>
						</ul>
					</li>
					<li id="_lecture_lect_list"><a href="/lecture/lect/list" onclick="goLocation('/lecture/lect/list');">강좌 리스트</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/lecture/lect/list_detail">강좌상세</a></li>
						</ul>
					</li>
					<li id="_lecture_lect_room"><a onclick="goLocation('/lecture/lect/room');">강의실 관리</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/lecture/lect/room_view">강의실 관리</a></li>
							<li><a href="/lecture/lect/room">강의실 관리</a></li>
						</ul>
						
					</li>
					<li id="_lecture_lect_attend"><a href="/lecture/lect/attend" onclick="goLocation('/lecture/lect/attend');">출석부 관리</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/lecture/lect/attend_detail">출석부 관리</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="lab-ulwr">
				<p class="lnb-tit">수강/회원 관리</p>
				<ul class="lnb_member_manage">
				<!--<li id="_member_cust_list_mem" class="cust_write"><a href="/member/cust/list_mem">회원등록관리</a></li>-->
					<li class="user_list"><a>회원 정보</a>
						<ul class="lnb-dep3">
							<li id="_member_cust_list"><a href="/member/cust/list">회원리스트</a></li>
							<li id="_member_cust_list_mem"><a href="/member/cust/list_mem">회원관리</a></li>
							<li id="_member_cust_cust_join"><a href="/member/cust/cust_join">회원통합</a></li>
						</ul>
					</li>						
					<li id="_member_lect_view" class="lecr_list"><a href="/member/lect/view">수강 관리</a></li>
					<li id="_member_wait_list" class="wait_list"><a href="/member/wait/list" onclick="goLocation('/member/wait/list');">대기자 관리</a></li>
					<li id="_member_relo_write" class="relo_list"><a href="/member/relo/write">이강 관리</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/member/relo/list">이강리스트</a></li>
						</ul>
					</li>
					
					<li class="sms_tm_list"><a>SMS/TM</a>
						<ul class="lnb-dep3">
							<li id="_member_sms_list"><a href="/member/sms/list">SMS 리스트</a></li>
							<li id="_member_sms_list_tm"><a href="/member/sms/list_tm">TM 리스트</a></li>
							<li class="dis-no"><a href="/member/sms/tm_cust">TM 리스트</a></li>
							<li class="dis-no"><a href="/member/sms/write">SMS/TM 발송</a></li>
						</ul>
					</li>
					
				</ul>
			</div>
			<div class="lab-ulwr">
				<p class="lnb-tit">매출/마감 관리</p>
				<ul class="lnb_trms_manage">
					<li id="_trms_trms_trms_write"><a href="/trms/trms/trms_write">준비금 등록</a></li>
					<li id="_trms_trms_close_write"><a href="/trms/trms/close_write">마감 등록</a></li>
					<li id="_trms_trms_check"><a href="/trms/trms/check">일일 정산</a></li>
					<li id="_trms_trms_print"><a href="/trms/trms/print">정산지 출력</a></li>
					<li id="_trms_trms_list"><a href="/trms/trms/list">매출유형별 조회</a></li>
					<li id="_trms_trms_detail"><a href="/trms/trms/detail">매출 상세 현황</a></li>
					<li id="_trms_trms_send"><a href="/trms/trms/send">매출분개 전송</a></li>		
				</ul>
			</div>
			<div class="lab-ulwr">
				<p class="lnb-tit">정산 관리</p>
				<ul class="lnb_it_manage">
					<%
					String isLeader = Utils.checkNullString(session.getAttribute("isLeader"));
					if("T".equals(isLeader))
					{
						%>
						<li id="_it_change"><a href="/it/change_master">강사료 기준변경</a></li>
						<li class="dis-no"><a href="/it/change">강사료 기준변경</a></li>
						<%
					}
					else
					{
						%>
						<li id="_it_change"><a href="/it/change">강사료 기준변경</a></li>
						<li class="dis-no"><a href="/it/change_master">강사료 기준변경</a></li>
						<%
					}
					%>
					<li><a>강사료 정산관리</a>
						<ul class="lnb-dep3" >
							<li id="_it_list"><a href="/it/list">지급기준 점검</a></li>
							<li id="_it_regisEnd"><a href="/it/regisEnd">강사료 마감내역</a></li>
							<li id="_it_end"><a href="/it/end">강사료 분개/전송</a></li>
							<li id="_it_status"><a href="/it/status">강사료 현황</a></li>
							<li id="_it_elect"><a href="/it/elect">법인강사료 전자증빙</a></li>
							<li id="_it_statusByPeri"><a href="/it/statusByPeri">기수별 강사료 지급현황</a></li>
						</ul>
					</li>
					<li><a>재료비 정산관리</a>
						<ul class="lnb-dep3">
							<li id="_it_check"><a href="/it/check">재료비 점검</a></li>
							<li id="_it_foodList"><a href="/it/foodEnd">재료비 마감내역</a></li>
							<li id="_it_deadline"><a href="/it/deadline">재료비 분개/전송</a></li>
							<li id="_it_material"><a href="/it/material">기수별 재료비 지급 현황</a></li>
						</ul>
					</li>
					<li id="_it_tally"><a href="/it/tally">계정별 집계표</a></li>
					<li id="_it_payment"><a href="/it/payment">대금지불 의뢰서</a></li>
				</ul>
			</div>
			<div class="lab-ulwr">
				<p class="lnb-tit">통계관리</p>
				<ul class="lnb_stat_manage">
					<li id="_stat_target"><a href="/stat/target">목표입력</a></li>
					<li><a>매출통계</a>
						<ul class="lnb-dep3">
							<li id="_stat_perfor"><a href="/stat/perfor">점별 실적</a></li>
							<li id="_stat_list"><a href="/stat/list">강좌군별 실적 분석</a></li>
							<li id="_stat_receipt"><a href="/stat/receipt">강좌별 접수 현황</a></li>
							<li id="_stat_receipt_day"><a href="/stat/receipt_day">일별 접수 현황</a></li>
							<li id="_lecture_lect_detail"><a href="/lecture/lect/detail">강좌별 매출 상세 현황</a></li>			
						</ul>
					</li>
					<li><a>회원통계</a>
						<ul class="lnb-dep3">
							<li id="_stat_member_list"><a href="/stat/member_list">전체 회원 통계</a></li>
							<li id="_stat_member_lecture"><a href="/stat/member_lecture">강좌별 회원 구분</a></li>
							<li id="_stat_member_receipt"><a href="/stat/member_receipt">강의실별 접수현황</a></li>
							<li id="_stat_receipt_detail"><a href="/stat/receipt_detail">강좌별 회원 상세 현황</a></li>
						</ul>
					</li>
					<li><a>강사통계</a>
						<ul class="lnb-dep3">
							<li id="_stat_payment"><a href="/stat/payment">강사료 지급 현황</a></li>
							<li id="_stat_attend"><a href="/stat/attend">강사별 출강점 현황</a></li>
						</ul>
					</li>
				</ul>
			</div>
			<div class="lab-ulwr">
				<p class="lnb-tit">웹관리</p>
				<ul class="lnb_web_manage">
					<li><a>메인 디자인 관리</a>
						<ul class="lnb-dep3">
							<li id="_web_list"><a href="/web/list">메인 배너 관리</a></li>
							<li id="_web_sublist"><a href="/web/sublist">중간 배너 관리</a></li>
							<li class="dis-no"><a href="/web/sublist_upload">중간 배너 관리</a></li>
							<li class="dis-no"><a href="/web/list_upload">메인 배너 관리</a></li>
						</ul>
					</li>
					<li id="_web_academy"><a href="/web/academy">아카데미 뉴스</a>
						<ul class="dis-no">
							<li><a href="/web/academy_upload">아카데미 뉴스</a></li>
						</ul>
					</li>
					<li id="_web_lecture"><a href="/web/lecture">추천 강좌</a></li>
					<li id="_web_plan"><a onclick="goLocation('/web/plan');">강의계획서</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/web/plan_write">강의계획서 등록</a>
							<li><a href="/web/plan">강의계획서</a>
						</ul>
					</li>
					<li id="_web_popup"><a href="/web/popup">팝업 관리</a>
						<ul class="lnb-dep3 dis-no">
							<li><a href="/web/popup_upload">팝업 등록</a>
						</ul>
					</li>
					<li id="_web_review"><a href="/web/review">후기 관리</a></li>
				</ul>
			</div>
		</div>
		
	</div>
</div>

<div id="rnb">
	<div class="rab-wr">
		<%
		if("T".equals(isLeader))
		{
			%>
			<div id="alert_div">
				
			</div>
			
			<script>
			$.ajax({
				type : "POST", 
				url : "/common/getChangeByLeader",
				dataType : "text",
				async:false,
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					console.log(data);
					var result = JSON.parse(data);
					if(result.length > 0)
					{
						

						var inner = "";
						inner += '<div class="rnb-top table">';
						inner += '	<div class="rnb-bellwr">';
						inner += '		<div class="bell"><i class="material-icons">notifications</i><span class="bellcount">'+result.length+'</span></div>';
						inner += '		<div class="bell-txt">새 알림 '+result.length+'개</div>';
						inner += '	</div>';
						inner += '	<div class="text-right">';
						inner += '		<div class="rnb-menu">';
						inner += '			<div class="rnbm-open">알림열기 <i class="material-icons">add_box</i></div>';
						inner += '			<div class="rnbm-close">알림닫기 <i class="material-icons">indeterminate_check_box</i></div>';
						inner += '		</div>';
						inner += '	</div>';
						inner += '</div>';
						inner += '<div class="rnb-cont">';
						for(var i = 0; i < result.length; i++)
						{
							var t_now = getNow()+""+getTime();
							var t_cre = result[i].CREATE_DATE;
							var tmp1 = t_now.substring(0,4)+"-"+t_now.substring(4,6)+"-"+t_now.substring(6,8)+"T"+t_now.substring(8,10)+":"+t_now.substring(10,12)+":"+t_now.substring(12,14);
							var tmp2 = t_cre.substring(0,4)+"-"+t_cre.substring(4,6)+"-"+t_cre.substring(6,8)+"T"+t_cre.substring(8,10)+":"+t_cre.substring(10,12)+":"+t_cre.substring(12,14);
							var t1 = new Date(tmp1);
							var t2 = new Date(tmp2);
							var diff = t2 - t1;
							diff = Math.abs(diff/(1000*60));
							var si = Math.floor(diff / 60);
							var bun = Math.floor(diff % 60);
							
							inner += '	<div class="rnb-div">';
							inner += '		<div>';
							inner += '			<div class="rdiv-clo"></div>';
							inner += '			<p class="rnb-time">'+si+'시간 '+bun+'분 전</p>';
							inner += '			<p class="rnb-tit">강사료 기준변경 신청</p>';
							inner += '			<p class="rnb-des">'+result[i].STORE_NM+' '+result[i].PERIOD+'기<br>['+result[i].SUBJECT_NM+'('+result[i].SUBJECT_CD+')]강좌의 강사료 기준변경이 신청되었습니다.</p>';
							inner += '			<div class="rnb-morewr">';
							inner += '				<a class="rnb-more" onclick="goLocation(\'/it/change_master?store='+result[i].STORE+'&period='+result[i].PERIOD+'&subject_cd='+result[i].SUBJECT_CD+'\')" style="cursor:pointer;">더보기<i class="material-icons" >add</i></a>';
							inner += '			</div>';
							inner += '		</div>';
							inner += '	</div>';
							
						}
						inner += '</div>';
						
						$("#alert_div").html(inner);
						
					}
				}
			});	
			</script>
			
			<%
		}
		%>
	</div>
</div>



<!--  body  -->
	<div class="container">
		<div class="contain">