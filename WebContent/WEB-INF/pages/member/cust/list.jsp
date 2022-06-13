<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown()
{
	var filename = "회원리스트";
	var table = "excelTable";
    exportExcel(filename, table);
}
 $(function(){
	 /*
	 var head = $('.table-list thead').html();
	 $('.table-top').append('<table class="fix-head"><thead>'+head+'</thead></div>');
	
	$(window).scroll(function(){
		var winTop = $(window).scrollTop();
		var tableTop = $(".table-list tbody").offset().top;
		

		if(winTop >= 78){
			$('.infi-fix').addClass('fix');
			$('.contain').addClass('fix');
			
		}else{
			$('.infi-fix').removeClass('fix');
			$('.contain').removeClass('fix');
		}
	
		
	});
	 */
	
	$("#chk_all").change(function() {
		if($("input:checkbox[name='chk_all']").is(":checked"))
		{
			$("input:checkbox[name='chk_val']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='chk_val']").prop("checked", false);
		}
	});
	 
	$('#start_month').val('01');
	$('#start_day').val('01');
	
	$('#end_month').val('12');
	$('#end_day').val('31');
	
	
}); 


 function selPeri()
 {
 	if($(".selPeri").html().indexOf("검색된") > -1)
 	{
 		alert("기수 정보가 없습니다.");
 		$(".hidden_area").hide();
 	}
 	else
 	{
 		$.ajax({
 			type : "POST", 
 			url : "/basic/peri/getPeriOne",
 			dataType : "text",
 			async : false,
 			data : 
 			{
 				selPeri : $("#selPeri").val(),
 				selBranch : $("#selBranch").val()
 			},
 			error : function() 
 			{
 				console.log("AJAX ERROR");
 			},
 			success : function(data) 
 			{
 				var result = JSON.parse(data);
 	 			$("#last_amt_start").val(cutDate(result.ADULT_S_BGN_YMD));
 	 			$("#last_amt_end").val(cutDate(result.END_YMD));
 	 			
 			}
 		});	
 	}
 }


 $(document).ready(function(){
	$(window).scroll(function(){
		var winTop = $(window).scrollTop();
		if(winTop >= 1000){
			$(".top-btn").show(300)
		}else{
			$(".top-btn").hide(300)
		}
	});
});
 function all_chker(){
		if ( $('#idxAll').prop("checked")==true )  {
			$('.cust_chk').prop("checked",true);
		}else{
			$('.cust_chk').prop("checked",false);			
		}
	}
 
 function getList(paging_type){
	 getListStart();
	 $("#page").val(page);
	 $("#order_by").val(order_by);
	 $("#sort_type").val(sort_type);
		var lect_time_a="";
		var lect_time_b="";
		var lect_time_c="";
		var lect_time_d="";
		var lect_time_e="";
		var lect_time_f="";
		var lect_chk="";
		
		if ($('#lect_time_a').prop("checked")==1) {
			lect_time_a="1";
		}
		if($('#lect_time_b').prop("checked")==1){
			lect_time_b="1";
		}
		if($('#lect_time_c').prop("checked")==1){
			lect_time_c="1";
		} 
		if($('#lect_time_d').prop("checked")==1){
			lect_time_d="1";
		}
		if($('#lect_time_e').prop("checked")==1){
			lect_time_e="1";
		}
		if($('#lect_time_f').prop("checked")==1){
			lect_time_f="1";
		}
		
	 var f = document.fncForm;
	 
	 f.yoil.value="";
	 for(i=0;i<f.yoil_chk.length;i++){
		(f.yoil_chk[i].checked==true) ? f.yoil.value+=""+1 : f.yoil.value+=""+0;
	 }	
	 f.birth_md.value = f.start_month.value+""+f.start_day.value+""+f.end_month.value+""+f.end_day.value;	
	 
		
		
		(f.lect_time_a.checked==true) ? f.lect_time_a.value=1 :  f.lect_time_a.value="";
		(f.lect_time_b.checked==true) ? f.lect_time_b.value=1 :  f.lect_time_b.value="";
		(f.lect_time_c.checked==true) ? f.lect_time_c.value=1 :  f.lect_time_c.value="";
		(f.lect_time_d.checked==true) ? f.lect_time_d.value=1 :  f.lect_time_d.value="";
		(f.lect_time_e.checked==true) ? f.lect_time_e.value=1 :  f.lect_time_e.value="";
		(f.lect_time_f.checked==true) ? f.lect_time_f.value=1 :  f.lect_time_f.value="";
		
		f.lect_chk.value= f.lect_time_a.value+
						  f.lect_time_b.value+
						  f.lect_time_c.value+
						  f.lect_time_d.value+
						  f.lect_time_e.value+
						  f.lect_time_f.value;
		

		var queryString = $("form[name=fncForm]").serialize() ;
		$.ajax({
			type : "POST", 
			url : "./getCustList02",
			dataType : "text",
			data : queryString,
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
				var inner = "";
				
				if(result.list.length > 0)
				{
					for(var i = 0; i < result.list.length; i++)
					{
						inner += '<tr>';
						inner += '	<td>';
						inner += '		<input type="checkbox" id="cust_list_'+i+'" class="cust_chk" name="cust_chk" value="'+result.list[i].CUST_NO+'"><label for="cust_list_'+i+'"></label>';
						inner += '	</td>';
						inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CUST_NO)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].PTL_ID)+'</td>';
						inner += '	<td><a href="/member/cust/list_mem?cust_no='+result.list[i].CUST_NO+'&store='+result.list[i].STORE+'">'+nullChk(result.list[i].KOR_NM)+'</a></td>';
						inner += '	<td>'+nullChk(result.list[i].GRADE)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SEX_FG)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].BIRTH_YMD)+'</td>';
						inner += '	<td>'+cutDate(result.list[i].CREATE_DATE.substring(0,8))+'</td>';
						inner += '	<td>'+nullChk(result.list[i].LECT_CNT)+'</td>';
						inner += '	<td>'+comma(nullChk(result.list[i].SUM_AMT))+'</td>';
						inner += '	<td>'+nullChk(result.list[i].LAST_SALE_YMD)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
						inner += '</tr>';
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="13"><div class="no-data">검색결과가 없습니다.</div></td>';
					inner += '</tr>';
				}
				
				order_by = result.order_by;
				sort_type = result.sort_type;
				listSize = result.listSize;
				if(paging_type == "scroll")
				{
					if(result.list.length > 0)
					{
						$("#list_target").append(inner);
					}
				}
				else
				{
					$("#list_target").html(inner);
				}
				$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
				getListEnd();
				
			}
		});

	}


function chooseAddr(start,end,val){
	
	var addr = $(val).val();
	if(end == "addr_s")
	{
		$("#choose_addr_m").val('');
		$(".choose_addr_m").html('전체');
		$("#choose_addr_s").val('');
		$(".choose_addr_s").html('전체');
	}
	else if(end == 'addr_m')
	{
		$("#choose_addr_s").val('');
		$(".choose_addr_s").html('전체');
	}
	
	$.ajax({
		type : "POST", 
		url : "./getAddr",
		dataType : "text",
		async : false,
		data : 
		{	
			start: start,
			end:end,
			addr : addr
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			var inner_li ="";
			
			if(result.list.length > 0)
			{
				inner += '<option value="">전체</option>';
				inner_li +='<li>전체</li>';
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<option value="'+result.list[i].ADDR+'">'+result.list[i].ADDR+'</option>';
					inner_li +='<li>'+result.list[i].ADDR+'</li>';
				}
				$("#choose_"+start).html(inner);
				$(".choose_"+start+"_ul").html(inner_li);
				
				
			}else{
				inner += '<option value="">상위 주소를 선택해주세요.</option>';
				inner_li +='<li>상위 주소를 선택해주세요.</li>';
				if (start=='addr_s') 
				{
					$(".choose_"+start).text("동,면,리");
				}
				else if(start=='addr_m')
				{
					$(".choose_"+start).text("구,군");
				}
				
				$("#choose_"+start).html(inner);
				$(".choose_"+start+"_ul").html(inner_li);
			}
		}
	});	
}
</script>

<a class="top-btn" href="#">TOP</a>
<div class="sub-tit">
	<h2>회원리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	
</div>
<form id="fncForm" name="fncForm">
	<input type="hidden" name="yoil">
	<input type="hidden" name="birth_md">
	<input type="hidden" name="lect_chk">
	
	<div class="table-top mem-top">
		<div class="top-row sear-wr bor-div">
			<div class="wid-45">
				<div class="table">
					<div class="wid-35">
						<div class="table table02 table-input wid-contop">
							<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
						</div>
					</div>
					<div class="wid-15">
						<div class="table">
							<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
							<div class="oddn-sel">
								<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
							</div>
						</div>
					</div>
				
				</div>
			</div>
			<div class="wid-35 mag-lr2">
				<div class="table">
					<div class="sear-tit sear-tit03">최종결제일</div>
					<div class="wid-8">
						<div class="cal-row cal-row_inline cal-row02 table">
							<div class="cal-input">
								<input type="text" class="date-i start-i" id="last_amt_start" name="last_amt_start">
								<i class="material-icons">event_available</i>
							</div>
							<div class="cal-dash wid-1">-</div>
							<div class="cal-input">
								<input type="text" class="date-i ready-i" id="last_amt_end" name="last_amt_end">
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="wid-15">
				<div class="table">
					<div class="sear-tit sear-tit03">회원구분</div>
					<div class="wid-5">
						<select de-data="전체" id="cust_fg" name="cust_fg">
							<option value="">전체</option>
							<option value="1">신규</option>
							<option value="2">기존</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		
		<div class="sear-toggle member-profile member-profile02">
			<div class="row">
				<div class="wid-5">
					<div class="bor-div">
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">가입일</div>
									<div>
										<div class="cal-row">
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="sign_start_ymd" name="sign_start_ymd"/>
												<i class="material-icons">event_available</i>
											</div>
											<div class="cal-dash wid-1">-</div>
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="sign_end_ymd" name="sign_end_ymd"/>
												<i class="material-icons">event_available</i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit ">지역별</div>
									<div>
										<div class="table table02 table-input sel-scr">
											<div>
												<select de-data="시,도" id="choose_addr_l" name="si" onchange="chooseAddr('addr_m','addr_l',this);">
													<option value="">전체</option>
													<c:forEach var="i" items="${si_list}" varStatus="loop">
														<option value="${i.ADDR_L}">${i.ADDR_L}</option>
													</c:forEach>
												</select>
											</div>
											<div class="sel-center">
												<select de-data="구,군" id="choose_addr_m" name="gun" onchange="chooseAddr('addr_s','addr_m',this);">
													<option value="">구,군을 선택해주세요.</option>
												</select>
											</div>
											<div>
												<select de-data="동,면,리" id="choose_addr_s" name="ri">
													<option value="">동,면,리를 선택해주세요.</option>
												</select>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">결혼여부</div>
									<div>
										<ul class="chk-ul">
											<li>
												<input type="radio" id="marriage_chk_a" value="" name="marriage_chk" checked/>
												<label for="marriage_chk_a">전체</label>
											</li>
											<li>
												<input type="radio" id="marriage_chk_b" value="1" name="marriage_chk"/>
												<label for="marriage_chk_b">기혼</label>
											</li>
											<li>
												<input type="radio" id="marriage_chk_c" value="2" name="marriage_chk"/>
												<label for="marriage_chk_c">미혼</label>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</div> <!-- // bor-div -->
				</div> <!-- // wid-5 -->
				
				
				<div class="wid-5 wid-5_last">
				
					<div class="bor-div">
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">연령대</div>
									<div>
										<div class="table">
											<div class="wid-45 mem-smtit">
												<input class="wid-8" id="cust_age_start" name="cust_age_start" type="text" placeholder="입력하세요."/>
												이상
											</div>
											<div class="cal-dash wid-1">-</div>
											<div class="wid-45 mem-smtit">
												<input class="wid-8" id="cust_age_end" name="cust_age_end" type="text" placeholder="입력하세요."/>
												이하
											</div>
										</div>
									</div>						
								
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">생일</div>
									<div>
										<div class="time-row">
											<div>
												<div class="time-input time-input180 sel-scr">
													<select de-data="01" id="start_month" name="start_month">
														<c:forEach var="i" begin="1" end="12" varStatus="loop">
															<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
															<c:if test="${fn:length(loop_index) eq 1}">
																<option value="0${loop_index}">0${loop_index}</option>
															</c:if>
															<c:if test="${fn:length(loop_index) ne 1}">
																<option value="${loop_index}">${loop_index}</option>
															</c:if>
														</c:forEach>
													</select>
												</div>
												<div class="time-dash">월</div> &nbsp;&nbsp;
												<div class="time-input time-input180 sel-scr">
													<select de-data="01" id="start_day" name="start_day">
														<c:forEach var="i" begin="1" end="31" varStatus="loop">
															<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
															<c:if test="${fn:length(loop_index) eq 1}">
																<option value="0${loop_index}">0${loop_index}</option>
															</c:if>
															<c:if test="${fn:length(loop_index) ne 1}">
																<option value="${loop_index}">${loop_index}</option>
															</c:if>
														</c:forEach>
													</select>
												</div>
												<div class="time-dash">일</div>
											</div>
											<div class="time-two">ㅡ</div>
											<div>
												<div class="time-input time-input180 sel-scr">
											
													<select de-data="12" id="end_month" name="end_month">
														<c:forEach var="i" begin="1" end="12" varStatus="loop">
															<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
															<c:if test="${fn:length(loop_index) eq 1}">
																<option value="0${loop_index}">0${loop_index}</option>
															</c:if>
															<c:if test="${fn:length(loop_index) ne 1}">
																<option value="${loop_index}">${loop_index}</option>
															</c:if>
														</c:forEach>
													</select>
												</div>
												<div class="time-dash">월</div>&nbsp;&nbsp;
												<div class="time-input time-input180 sel-scr">
													<select de-data="31" id="end_day" name="end_day">
														<c:forEach var="i" begin="1" end="31" varStatus="loop">
															<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
															<c:if test="${fn:length(loop_index) eq 1}">
																<option value="0${loop_index}">0${loop_index}</option>
															</c:if>
															<c:if test="${fn:length(loop_index) ne 1}">
																<option value="${loop_index}">${loop_index}</option>
															</c:if>
														</c:forEach>
													</select>
												</div>
												<div class="time-dash">일</div>
												
											</div>
										</div>
										
										
									</div>					
								
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">결제금액</div>
									<div>
										<div class="table">
											<div class="wid-45 mem-smtit">
												<input class="wid-8" id="amt_start" name="amt_start" type="text" placeholder=""/>
												원
											</div>
											<div class="cal-dash wid-1">-</div>
											<div class="wid-45 mem-smtit">
												<input class="wid-8" id="amt_end" name="amt_end" type="text" placeholder=""/>
												원
											</div>
										</div>
									</div>				
								
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">차량 보유 여부</div>
									<div>
										<ul class="chk-ul">
											<li>
												<input type="radio" id="car_chk_a" value="" name="car_chk" checked/>
												<label for="car_chk_a">전체</label>
											</li>
											<li>
												<input type="radio" id="car_chk_b" value="1" name="car_chk"/>
												<label for="car_chk_b">보유</label>
											</li>
											<li>
												<input type="radio" id="car_chk_c" value="2" name="car_chk"/>
												<label for="car_chk_c">미보유</label>
											</li>
										</ul>
									</div>		
								
								</div>
							</div>
						</div>				
						
					</div> <!-- // bor-div -->
					
				</div>
			</div>
			
			
			<div class="row top-memrow02">
				<div class="wid-5">
					<div class="bor-div">
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">수강건수</div>
									<div>
										<div class="table">
											<div class="wid-4 mem-smtit">
												<input class="wid-8 text-center" id="lect_cnt" name="lect_cnt"  type="text" placeholder="0"/>
												건
											</div>
											<div class="wid-6 mem-smtit">
												<div class="wid-8 dis-inline" >
													<select id="lect_way" name="lect_way" de-data="이상">
														<option value="up">이상</option>
														<option value="down">이하</option>
													</select>
												</div>
												인 회원
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">연속수강</div>
									<div>
										<div class="table">
											<div class="wid-4 mem-smtit">
												<input class="wid-8 text-center" id="continue_cnt" name="continue_cnt" type="text" placeholder="0"/>
												강좌
											</div>
											<div class="wid-6 mem-smtit">
												<div class="wid-8 dis-inline" >
													<select id="continue_way" name="continue_way"  de-data="이상">
														<option value="up">이상</option>
														<option value="down">이하</option>
													</select>
												</div>
												인 회원
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row mar-top15">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">요일</div>
									<div>
										<ul class="chk-ul ">
											<li><input type="checkbox" id="yoil_mon" name="yoil_chk"><label for="yoil_mon">월</label></li>
											<li><input type="checkbox" id="yoil_tue" name="yoil_chk"><label for="yoil_tue">화</label></li>
											<li><input type="checkbox" id="yoil_wed" name="yoil_chk"><label for="yoil_wed">수</label></li>
											<li><input type="checkbox" id="yoil_thu" name="yoil_chk"><label for="yoil_thu">목</label></li>
											<li><input type="checkbox" id="yoil_fri" name="yoil_chk"><label for="yoil_fri">금</label></li>
											<li><input type="checkbox" id="yoil_sat" name="yoil_chk"><label for="yoil_sat">토</label></li>
											<li><input type="checkbox" id="yoil_sun" name="yoil_chk"><label for="yoil_sun">일</label></li>
										</ul>
									</div>
								</div>
							</div>
						</div> 
						
					</div> <!-- // bor-div -->
				</div><!-- // wid-5 -->
				
				<div class="wid-5 wid-5_last">				
					<div class="bor-div">

						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">수강형태</div>
									<div>
										<ul class="chk-ul">
											<li>
												<input type="radio" id="subejct_fg_a" value="" name="subejct_fg" checked/>
												<label for="subejct_fg_a">전체</label>
											</li>
											<li>
												<input type="radio" id="subejct_fg_b" value="1" name="subejct_fg"/>
												<label for="subejct_fg_b">정규</label>
											</li>
											<li>
												<input type="radio" id="subejct_fg_c" value="2" name="subejct_fg"/>
												<label for="subejct_fg_c">단기</label>
											</li>
											<li>
												<input type="radio" id="subejct_fg_d" value="3" name="subejct_fg"/>
												<label for="subejct_fg_d">특강</label>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row mar-top15">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">시간대</div>
									<div>
										<ul class="chk-ul chk-ul-3">
											<li>
												<input type="checkbox" id="lect_time_a" value="" name="lect_time_a">
												<label for="lect_time_a">10시 전</label>
											</li>
											<li>
												<input type="checkbox" id="lect_time_b" value="" name="lect_time_b">
												<label for="lect_time_b">10시~12시</label>
											</li>
											<li>
												<input type="checkbox" id="lect_time_c" value="" name="lect_time_c">
												<label for="lect_time_c">12시~14시</label>
											</li>
											<li>
												<input type="checkbox" id="lect_time_d" value="" name="lect_time_d">
												<label for="lect_time_d">14시~16시</label>
											</li>
											<li>
												<input type="checkbox" id="lect_time_e" value="" name="lect_time_e">
												<label for="lect_time_e">16시~18시</label>
											</li>
											<li>
												<input type="checkbox" id="lect_time_f" value="" name="lect_time_f">
												<label for="lect_time_f">18시 이후</label>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						
					</div> <!-- // bor-div -->
					
				</div> <!-- // wid-5_last -->
					
						
				
			</div>
		</div> <!-- // sear-toggle  -->
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
		<a class="line-btn btn05 icon-r searto-btn"><span>상세검색 펼침</span><i class="material-icons">arrow_drop_down</i></a>
	</div>
	<input type="hidden" id="page" name="page" value="${page}">
	<input type="hidden" id="order_by" name="order_by" value="${order_by}">
    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">

<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			<div class="table float-right">
				<div class="sel-scr">
					<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
					<a href="/member/sms/list" class="btn btn02 mrg-lr6">SMS</a>
					<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
						<option value="10">10개 보기</option>
						<option value="20">20개 보기</option>
						<option value="50">50개 보기</option>
						<option value="100">100개 보기</option>
						<option value="300">300개 보기</option>
						<option value="500">500개 보기</option>
						<option value="1000">1000개 보기</option>
					</select>
				</div>
			</div>
			
			
		</div>
	</div>
<div class="table-wr">	
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" onclick="all_chker()"><label for="idxAll"></label>
					</th>
					<th onclick="reSortAjax('sort_store')" class="td-80">지점<img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_cust_no')">멤버스번호 <img src="/img/th_up.png" id="sort_cust_no"></th>
					<th onclick="reSortAjax('sort_ptl_id')">포털ID <img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_grade')">회원등급 <img src="/img/th_up.png" id="sort_grade"></th>
					<th onclick="reSortAjax('sort_sex_fg')">성별<img src="/img/th_up.png" id="sort_sex_fg"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일 <img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_create_date')">가입일 <img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">수강 강좌수<img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_sum_amt')">결제총액<img src="/img/th_up.png" id="sort_sum_amt"></th>
					<th onclick="reSortAjax('sort_last_sale_ymd')">최종결제일 <img src="/img/th_up.png" id="sort_last_sale_ymd"></th>
					<th onclick="reSortAjax('sort_cust_fg')">수강형태 <img src="/img/th_up.png" id="sort_cust_fg"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" onclick="all_chker()"><label for="idxAll"></label>
					</th>
					<th onclick="reSortAjax('sort_store')" class="td-80">지점<img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_cust_no')">멤버스번호 <img src="/img/th_up.png" id="sort_cust_no"></th>
					<th onclick="reSortAjax('sort_ptl_id')">포털ID <img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_grade')">회원등급 <img src="/img/th_up.png" id="sort_grade"></th>
					<th onclick="reSortAjax('sort_sex_fg')">성별<img src="/img/th_up.png" id="sort_sex_fg"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일 <img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_create_date')">가입일 <img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">수강 강좌수<img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_sum_amt')">결제총액<img src="/img/th_up.png" id="sort_sum_amt"></th>
					<th onclick="reSortAjax('sort_last_sale_ymd')">최종결제일 <img src="/img/th_up.png" id="sort_last_sale_ymd"></th>
					<th onclick="reSortAjax('sort_cust_fg')">수강형태 <img src="/img/th_up.png" id="sort_cust_fg"></th>
				</tr>
			</thead>
			<tbody id="list_target">


			</tbody>
		</table>
	</div>
	
</div>

<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</form>
<script>
window.onload = function(){
	getList();
}
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>