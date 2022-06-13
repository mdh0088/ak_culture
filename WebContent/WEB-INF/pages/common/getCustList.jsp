<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script src="/inc/js/sort.js"></script>

<script>

function excelDown()
{
	var filename = "회원리스트";
	var table = "left_area";
	
    exportExcel(filename, table);
    
}


var order_by = "";
var sort_type = "";
var target_cnt=0;
var is_lec="N";
$(window).ready(function(){
	$(".searto-btn").click(function(){
		if($(".target-toggle").css("display")=="none")
		{
			$(".target-toggle").slideDown();
			$(".gift-table").addClass("on");
			$(".give-wrap").addClass("on");
			$(".searto-btn").find("span").text("상세검색 닫힘");
			$(".searto-btn").addClass("on");
		}
		else if($(".target-toggle").css("display")=="block")
		{
			$(".target-toggle").slideUp();
			$(".gift-table").removeClass("on");
			$(".give-wrap").removeClass("on");
			$(".searto-btn").find("span").text("상세검색 펼침");
			$(".searto-btn").addClass("on");
		}
	})
	
	$("#taget_selBranch").val(login_rep_store);
	$(".taget_selBranch").html(login_rep_store_nm);
	$("#lecr_selBranch").val(login_rep_store);
	$(".lecr_selBranch").html(login_rep_store_nm);
	getLastYearSeason();
	
	$('#start_month').val('01');
	$('#start_day').val('01');
	
	$('#end_month').val('12');
	$('#end_day').val('31');
	
})

function selMaincd(idx,way){
	
	var main_cd = $('#lect_main_cd').val();
	if (nullChk(idx)!="") {
		main_cd = $(idx).val();		
	}
	
	var store=$('#selBranch').val();
	if (nullChk(way)!="") {
		store = $('#target_selBranch').val();
	}
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		async:false,
		data : 
		{
			maincd : main_cd,
			selBranch : store
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			console.log(data);
			var result = JSON.parse(data);
			var inner ="";
			var inner_li="";
			$('#'+way+'_sect_cd').empty();
			$('.'+way+'_sect_cd_ul').empty();
			if(result.length > 0)
			{
				inner="";
				inner+='<option value="">전체</option>';
				inner_li+='<li>전체</li>';
				for (var i = 0; i < result.length; i++) {
					inner+='<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>';
					inner_li+='<li>'+result[i].SECT_NM+'</li>';
				}
				$('#'+way+'_sect_cd').append(inner);
				$('.'+way+'_sect_cd_ul').append(inner_li);
			}
			else
			{
				
			}
		}
	});	
	
	$('#'+way+'_sect_cd').val("");
	$('.'+way+'_sect_cd').html("선택하세요.");
	
}

function all_chker(way){
	if ( $('#'+way+'_all_chk').prop("checked")==true )  {
		$('.'+way+'_chk').prop("checked",false);			
	}else{
		$('.'+way+'_chk').prop("checked",true);
	}
}

function choose_cust(){
	custList = "";
	var cust_cnt =0;
    $('input[name="idx"]:checked').each(function(i){//체크된 리스트 저장
    	//custList=custList+$(this).parent().next().next().next().text()+'@'; //멤버스 번호
    	custList =custList+$(this).val()+'|';	//고객번호
    	cust_cnt++;
    });
    custList = custList.slice(0,-1);
    $('#cust_cnt').val(cust_cnt+'명');
    
    if (custList=="") {
		alert('회원을 선택해주세요.');
		return;
	}
    $('#cust_list').val(custList);
    $('#give_layer').fadeOut(200);	
    
}

function choose_cancle(){
	custList = "";
	$('#give_layer').fadeOut(200);
}


function chooseAddr(start,end,val){
	
	var addr = $(val).val();
	
	if (start=="gun") {
		$("#choose_ri").html('<option value="">동,면,리를 선택해주세요.</option>');
		$(".choose_ri_ul").html('<li>동,면,리를 선택해주세요.</li>');
		$(".choose_ri").text("동,면,리");
	}
	
	$.ajax({
		type : "POST", 
		url : "/member/cust/getAddr",
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
				
			}
		}
	});	
}

function getList(){ //Seach버튼 클릭
	target_cnt=0;
	var lect_time_a="";
	var lect_time_b="";
	var lect_time_c="";
	var lect_time_d="";
	var lect_time_e="";
	var lect_time_f="";
	var lect_chk="";
	var end_yn="N";
	var continue_chk="";
	
	
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
	
	if($('#end_yn').prop("checked")==1)
	{
		end_yn="Y";
	}
	else
	{
		end_yn="N";
	}
	
	if($('#continue_chk').prop("checked")==1)
	{
		continue_chk="Y";
	}
	else
	{
		continue_chk="";
	}
	
 	var f = document.fncTargetForm;
 
 	/*
 	if (f.continue_cnt.value > 0 && f.taget_selBranch.value=="") {
		alert('연속수강 검색을 위해 지점을 선택해주세요.');
		return;
	}
 	*/
 	
 	/*
 	if (f.continue_cnt.value > 0 && f.selYear1.value!=f.selYear2.value && f.selSeason1.value != f.selSeason2.value) {
 		alert('연속수강 검색을 위해 기간을 맞춰주세요.');
		return;
	}
 	*/
 	
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
	

	//var queryString = $("form[name=fncTargetForm]").serialize() ;
	
	var marry_chk="";
	if ($('#marriage_chk_b').prop("checked")) 
	{
		marry_chk="1";
	}
	else if ($('#marriage_chk_c').prop("checked")) 
	{
		marry_chk="2";
	}
	
	var car_chk="";
	if ($('#car_chk_b').prop("checked")) 
	{
		car_chk="1";
	}
	else if ($('#car_chk_c').prop("checked")) 
	{
		car_chk="2";
	}
	
	
	var subejct_fg_chk="";
	if ($('#subejct_fg_b').prop("checked")) 
	{
		subejct_fg_chk="1";
	}
	else if ($('#subejct_fg_c').prop("checked")) 
	{
		subejct_fg_chk="2";
	}
	else if ($('#subejct_fg_d').prop("checked")) 
	{
		subejct_fg_chk="3";
	}
	
	
	getListStart();
	$.ajax({
		type : "POST", 
		url : "/member/cust/getCustList",
		dataType : "text",
		data : {
			order_by : order_by,
			sort_type : sort_type,
			
			yoil : f.yoil.value,
			birth_md : f.birth_md.value,
			lect_chk :f.lect_chk.value,
			page : f.page.value,
			
			selBranch : f.taget_selBranch.value,
			selYear1 : f.selYear1.value,
			selSeason1 : f.selSeason1.value,
			selYear2 : f.selYear2.value,
			selSeason2 : f.selSeason2.value,
			
			main_cd : f.target_main_cd.value,
			sect_cd : f.target_sect_cd.value,
			subject_cd : f.target_subject_cd.value,
			sign_start_ymd : f.sign_start_ymd.value,
			sign_end_ymd : f.sign_end_ymd.value,
			si : f.si.value,
			gun : f.gun.value,
			ri : f.ri.value,
			
			//marriage_chk : nullChk(f.marriage_chk.value),
			marriage_chk : marry_chk,
			
			cust_age_start : f.cust_age_start.value,
			cust_age_end : f.cust_age_end.value,
			start_month : f.start_month.value,
			start_day : f.start_day.value,
			end_month : f.end_month.value,
			end_day : f.end_day.value,
			amt_start : f.amt_start.value,
			amt_end : f.amt_end.value,
			//car_chk : nullChk(f.car_chk.value),
			car_chk : car_chk,
			
			lect_cnt : f.lect_cnt.value,
			lect_way : f.lect_way.value,
			continue_chk : continue_chk,
			//continue_way : f.continue_way.value,
			//subejct_fg : nullChk(f.subejct_fg.value),
			subejct_fg : subejct_fg_chk,
			
			lect_time_a : f.lect_time_a.value,
			lect_time_b : f.lect_time_b.value,
			lect_time_c : f.lect_time_c.value,
			lect_time_d : f.lect_time_d.value,
			lect_time_e : f.lect_time_e.value,
			lect_time_f : f.lect_time_f.value,
			end_yn : end_yn,
			sms_chk : sms_chk
			//dupl_cus_no : dupl_cus_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
			
		},
		success : function(data) 
		{
			console.log(data);
			var encd_cust_cnt =1;
			var result = JSON.parse(data);
			var inner="";
			
			if (result.isSuc=="fail") {
				alert(result.msg);
				getListEnd();
				return;
			}
			
			
			$('#cust_area_left').empty();
			if (result.list.length>0) {
				
				
				
				
				for(var i = 0; i < result.list.length; i++)
				{
					/*
					if (i==0) 
					{
						inner='';
						inner+='<tr id="cust_tr_00" class="left isOk">';
						inner+='	<td>';
						inner+='		<input type="checkbox" id="cust_list00" class="cust_list_chk left_chk chk_input" name="idx" value="113989518 "><label for="cust_list00"></label>';
						inner+='	</td>';
						
						inner+='	<td class="chk_num sort_num">00</td>';
						inner+='	<td class="sort_kor_nm">테스트용회원</td>';
						inner+='	<td class="sort_cus_no" id="cus_no">'+nullChk('113989518 ')+'</td>';
						inner+='	<td class="sort_grade">TEST</td>';
						inner+='	<td class="sort_sms_yn sms_Y">Y</td>';
						inner+='	<td class="sort_lect_cnt">0</td>';
						inner+='</tr>';
						$('#cust_area_left').append(inner);
					}
					*/
					
					inner='';
					inner+='<tr id="cust_tr_'+target_cnt+'" class="left isOk">';
					inner+='	<td>';
					inner+='		<input type="checkbox" id="cust_list'+target_cnt+'" class="cust_list_chk left_chk chk_input" name="idx" value="'+result.list[i].CUST_NO+'"><label for="cust_list'+target_cnt+'"></label>';
					inner+='	</td>';
					
					inner+='	<td class="chk_num sort_num">'+(i+1)+'</td>';
					inner+='	<td class="sort_kor_nm">'+result.list[i].KOR_NM+'</td>';
					inner+='	<td class="sort_cus_no" id="cus_no">'+nullChk(result.list[i].CUST_NO)+'</td>';
					inner+='	<td class="sort_cus_no" id="cus_no">'+nullChk(result.list[i].PHONE_NO).replace(/-/gi,'－')+'</td>';
					inner+='	<td class="sort_grade">'+result.list[i].GRADE+'</td>';
					inner+='	<td class="sort_sms_yn sms_'+result.list[i].SMS_YN+'">'+result.list[i].SMS_YN+'</td>';
					inner+='	<td class="sort_lect_cnt">'+result.list[i].SUB_CNT+'</td>';
					inner+='</tr>';
					$('#cust_area_left').append(inner);
					target_cnt++;
				}
			}else{
				inner+='<tr>';
				inner+='	<td colspan="7">검색된 회원이 없습니다.</td>';
				inner+='</tr>';
				$('#cust_area_left').append(inner);
				
			}
			getListEnd();
		}
	});	
	
}

function getLecrList()
{
	getListStart();

	$.ajax({
		type : "POST", 
		url : "/member/cust/getLecrDetail",
		dataType : "text",
		data : 
		{
			order_by : order_by,
			sort_type : sort_type,
			
			search_name : $("#lecr_search_name").val(),
			store : $("#lecr_selBranch").val(),
			grade : $("#lecr_grade").val(),
			selYear1 : $("#lecr_selYear1").val(),
			selYear2 : $("#lecr_selYear2").val(),
			selSeason1 : $("#lecr_selSeason1").val(),
			selSeason2 : $("#lecr_selSeason2").val(),
			subject_fg : $("#lecr_subject_fg").val()
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var encd_cust_cnt =1;
			var result = JSON.parse(data);
			var inner="";
			
			if (result.isSuc=="fail") {
				alert(result.msg);
				getListEnd();
				return;
			}
			
			
			$('#cust_area_left').empty();
			if (result.list.length>0) {
				for(var i = 0; i < result.list.length; i++)
				{
					if (i==0) 
					{
						inner+='<tr id="cust_tr_00" class="left isOk">';
						inner+='	<td>';
						inner+='		<input type="checkbox" id="cust_list00" class="cust_list_chk left_chk chk_input" name="idx" value="113989518"><label for="cust_list00"></label>';
						inner+='	</td>';
						
						inner+='	<td class="chk_num sort_num">00</td>';
						inner+='	<td class="sort_kor_nm">테스트용강사</td>';
						inner+='	<td class="sort_cus_no" id="cus_no">113989518</td>';
						inner+='	<td class="sort_grade">TEST</td>';
						inner+='	<td class="sort_sms_yn sms_Y">Y</td>';
						inner+=' 	<td></td>';
						inner+='</tr>';
						$('#cust_area_left').append(inner);
					}
					
					inner='';
					inner+='<tr id="cust_tr_'+target_cnt+'" class="left isOk">';
					inner+='	<td>';
					inner+='		<input type="checkbox" id="cust_list'+target_cnt+'" class="cust_list_chk left_chk chk_input" name="idx" value="'+result.list[i].CUS_NO+'"><label for="cust_list'+target_cnt+'"></label>';
					inner+='	</td>';
					
					inner+='	<td class="chk_num sort_num">'+(i+1)+'</td>';
					inner+='	<td class="sort_kor_nm">'+result.list[i].CUS_PN+'</td>';
					inner+='	<td class="sort_cus_no" id="cus_no">'+result.list[i].CUS_NO+'</td>';
					inner+='	<td class="sort_grade">'+result.list[i].GRADE+'</td>';
					inner+='	<td class="sort_sms_yn sms_'+nullChk(result.list[i].SMS_YN)+' ">'+nullChk(result.list[i].SMS_YN)+'</td>';
					inner+=' 	<td></td>';
					inner+='</tr>';
					$('#cust_area_left').append(inner);
					target_cnt++;
				}
			}else{
				inner+='<tr>';
				inner+='	<td colspan="6">검색된 회원이 없습니다.</td>';
				inner+='</tr>';
				$('#cust_area_left').append(inner);
				
			}
			getListEnd();
		}
	});	
	
}


function getLastYearSeason()
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : login_rep_store
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var season = result[0].WEB_TEXT.substring(7,result[0].WEB_TEXT.length);
			season = season.replace("학기", ""); //계절만추출
			$('.selSeason1').text(season);
			$('#selSeason1').val(season);
			$('.lecr_selSeason1').text(season);
			$('#lecr_selSeason1').val(season);
			
			$('.selSeason2').text(season);
			$('#selSeason2').val(season);
			
		}
	});	
}


//수신거부 제외를 위한 함수
var sms_chk="";
function sort_sms(){
	//getListStart();
	var len = $('.left').length;
	
	if (len == 0 ) 
	{
		alert('검색된 회원이 없습니다.');
		getListEnd();
		return
	}

	  if($('.sms-btn02').hasClass("on")){
          $('.sms-btn02').removeClass("on");
		  $('.sms-btn02').css('background','#111a3b');
		  $('.sms-btn02').css('border','solid 1px #111a3b');
		  sms_chk = "";
		  /*
		  $('.left').each(function()
		  { 
			  if ($(this).children().hasClass("sms_N")) 
			  {
				  $(this).addClass("isOk");
				  $(this).show();					
			  }
		  })
		  */

      }
	  else
      {
          $('.sms-btn02').addClass("on");
          $('.sms-btn02').css('background','#ee908e');
		  $('.sms-btn02').css('border','solid 1px #ee908e');
		  sms_chk = "Y";
      }
	  getList();
	 // getListEnd();
	  
	
	
}


</script>
<div class="give-wrap give-wrap-tm">
	<h3>대상자 지정</h3>
	<div class="tab">
		<ul class="tab-ul">
			<li id="chk_cus" class="on">회원검색</li>
			<li id="chk_lecr">강사검색</li>
		</ul>
		<div class="tab-cont">
			<div class="on">
				<form id="fncTargetForm" name="fncTargetForm">
					<input type="hidden" name="yoil">
					<input type="hidden" name="birth_md">
					<input type="hidden" name="lect_chk">
					
					<input type="hidden" name="page">
					<input type="hidden" id="order_by" name="order_by" value="${order_by}">
				    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
					
					<div class="table-top bg01">
						<div class="top-row">
							<div class="wid-5">
								<div class="table table-input gift-tsl">
									<div class="wid-2">
										<c:if test="${isBonbu eq 'T'}">
											<select de-data="${login_rep_store_nm}" id="taget_selBranch" name="taget_selBranch">
												<c:forEach var="i" items="${branchList}" varStatus="loop">
													<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
												</c:forEach>
											</select>
										</c:if>
										<c:if test="${isBonbu eq 'F'}">
											<select de-data="${login_rep_store_nm}" id="taget_selBranch" name="taget_selBranch">
												<c:forEach var="i" items="${branchList}" varStatus="loop">
													<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
												</c:forEach>
											</select>
										</c:if>
									</div>
									<div>
										<div class="table">
											<div>
												<div class="table table-auto">
													<div class="wid-2">
														<div class="table">
															<div>
																<select de-data="${year}" id="selYear1" name="selYear1" onchange="">
																	<%
																	int year = Utils.checkNullInt(request.getAttribute("year"));
																	for(int i = year+1; i > 1980; i--)
																	{
																		if(i == year)
																		{
																			%>
																			<option value="<%=i%>" selected><%=i%></option>
																			<%
																		}
																		else
																		{
																			%>
																			<option value="<%=i%>"><%=i%></option>
																			<%
																		}
																	}
																	%>
																</select>
															</div>
															<div>
																<select de-data="봄" id="selSeason1" name="selSeason1">
																	<option value="봄">봄</option>
																	<option value="여름">여름</option>
																	<option value="가을">가을</option>
																	<option value="겨울">겨울</option>									
																</select>
															</div>
														</div>
													</div>
												</div>
											</div>
											<div>
											~
											</div>
											<div>
												<div class="table table-auto">
													<div class="wid-2">
														<div class="table">
															<div>
																<select de-data="${year}" id="selYear2" name="selYear2" onchange="">
																	<%
																	year = Utils.checkNullInt(request.getAttribute("year"));
																	for(int i = year+1; i > 1980; i--)
																	{
																		if(i == year)
																		{
																			%>
																			<option value="<%=i%>" selected><%=i%></option>
																			<%
																		}
																		else
																		{
																			%>
																			<option value="<%=i%>"><%=i%></option>
																			<%
																		}
																	}
																	%>
																</select>
															</div>
															<div>
																<select de-data="봄" id="selSeason2" name="selSeason2">
																	<option value="봄">봄</option>
																	<option value="여름">여름</option>
																	<option value="가을">가을</option>
																	<option value="겨울">겨울</option>									
																</select>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										
										
									</div>
								</div>
								
							</div>
							
							<div class="wid-5">
								<div class="table table02 table-input wid-contop">
									<div class="wid-2">
										<select de-data="대분류" id="target_main_cd" name="target_main_cd" data-name="대분류" class="notEmpty" onchange="selMaincd(this,'target')">
												<option value="">전체</option>
											<c:forEach var="j" items="${maincdList}" varStatus="loop">
												<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
											</c:forEach>
										</select>
									</div>	
									<div class="sel-scr wid-2">
										<select de-data="중분류" id="target_sect_cd" name="target_sect_cd" data-name="중분류" class="notEmpty">
				
										</select>
									</div>
									
									<div class="wid-35 gift-code">
										<div class="sear-tit">강좌코드</div>
										<div>
											<input type="text" id="target_subject_cd" name="target_subject_cd" value="" >
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="target-toggle">
							
							<div class="row top-memrow top-memrow02">
								<div class="wid-5">
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
								</div> <!-- // wid-5 -->
								
								<div class="wid-5 wid-5_last">
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
													<div class="time-row table">
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
															<input class="wid-8" id="amt_start" name="amt_start" type="text" placeholder="0"/>
															원
														</div>
														<div class="cal-dash wid-1">-</div>
														<div class="wid-45 mem-smtit">
															<input class="wid-8" id="amt_end" name="amt_end" type="text" placeholder="0"/>
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
								</div>
							</div>
							
							<div class="row top-memrow top-memrow02">
								<div class="wid-5">
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">수강건수</div>
												<div>
													<div class="table">
														<div class="wid-4 mem-smtit">
															<input class="wid-8 text-center" id="lect_cnt" name="lect_cnt" type="text" placeholder="0"/>
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
												<div class="sear-tit">연속수강 여부</div>
												<div>
												
												
													<div class="table">
														<div>
															<ul class="chk-ul">
																<li>
																	<input type="checkbox" id="continue_chk" name="continue_chk">
																	<label for="continue_chk"></label>
																</li>
															</ul>
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
								</div><!-- // wid-5 -->
								
								<div class="wid-5 wid-5_last">		
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
															<input type="checkbox" id="lect_time_a" name="lect_time_a">
															<label for="lect_time_a">10시 전</label>
														</li>
														<li>
															<input type="checkbox" id="lect_time_b" name="lect_time_b">
															<label for="lect_time_b">10시~12시</label>
														</li>
														<li>
															<input type="checkbox" id="lect_time_c" name="lect_time_c">
															<label for="lect_time_c">12시~14시</label>
														</li>
														<li>
															<input type="checkbox" id="lect_time_d" name="lect_time_d">
															<label for="lect_time_d">14시~16시</label>
														</li>
														<li>
															<input type="checkbox" id="lect_time_e" name="lect_time_e">
															<label for="lect_time_e">16시~18시</label>
														</li>
														<li>
															<input type="checkbox" id="lect_time_f" name="lect_time_f">
															<label for="lect_time_f">18시 이후</label>
														</li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">폐강여부</div>
												<div>
													<ul class="chk-ul">
														<li>
															<input type="checkbox" id="end_yn" name="end_yn">
															<label for="end_yn"></label>
														</li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									
								</div> <!-- // wid-5_last -->
							</div>
							
						</div>
						<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">			
						<a class="line-btn btn05 icon-r searto-btn"><span>상세검색 펼침</span><i class="material-icons">arrow_drop_down</i></a>	
					</div>
				</form>	
			</div><!-- //tabbox -->
			
			
			<div>
				<div class="table-top bg01">				
					<div class="ak_lecrwrap">
						<div class="top-row">
							<div class="wid-10">
								<table id="">
									<tr>
										<th class="th01">검색</th>
										<td>	
											<div class="table table-auto">
												<div>
													<c:if test="${isBonbu eq 'T'}">
														<select de-data="${login_rep_store_nm}" id="lecr_selBranch" name="lecr_selBranch">
															<c:forEach var="i" items="${branchList}" varStatus="loop">
																<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
															</c:forEach>
														</select>
													</c:if>
													<c:if test="${isBonbu eq 'F'}">
														<select de-data="${login_rep_store_nm}" id="lecr_selBranch" name="lecr_selBranch">
															<c:forEach var="i" items="${branchList}" varStatus="loop">
																<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
															</c:forEach>
														</select>
													</c:if>
										
													
												</div>
												<div class="search-wr search-wr02 sel100">
												    <input type="text" id="lecr_search_name" class="inp-100" name="lecr_search_name" onkeypress="javascript:excuteEnter(getLecrList);" placeholder="강사명 / 강좌명 / 연락처 / 멤버스번호가 검색됩니다.">
												    <input class="search-btn" type="button" value="검색" onclick="javascript:getLecrList();">
												</div>								
											</div>
										
										</td>
									</tr>
									<tr>
										<th class="th02">세부검색</th>
										<td>	
											<div class="table table-auto">
												<div class="wid-6">
													<div class="table">
														<div>
															<div class="table table-auto">
																<div>
																	<select de-data="${year}" id="lecr_selYear1" name="lecr_selYear1" onchange="">
																		<%
																		year = Utils.checkNullInt(request.getAttribute("year"));
																		for(int i = year+1; i > 1980; i--)
																		{
																			if(i == year)
																			{
																				%>
																				<option value="<%=i%>" selected><%=i%></option>
																				<%
																			}
																			else
																			{
																				%>
																				<option value="<%=i%>"><%=i%></option>
																				<%
																			}
																		}
																		%>															
																	</select>																
																</div>
																<div>
																	<select de-data="전체" id="lecr_selSeason1" name="lecr_selSeason1">
																		<option value="봄">봄</option>
																		<option value="여름">여름</option>
																		<option value="가을">가을</option>
																		<option value="겨울">겨울</option>									
																	</select>																
																</div>
															</div>
														</div>
														<!-- 
														<div class="dash"> ~ </div>
														<div>
															<div class="table table-auto">
																<div>
																	<select de-data="${year}" id="lecr_selYear2" name="lecr_selYear2" onchange="">
																		<option value="">전체</option>
																		<%
																		for(int i = year+1; i > 1980; i--)
																		{
																			if(i == year)
																			{
																				%>
																				<option value="<%=i%>" selected><%=i%></option>
																				<%
																			}
																			else
																			{
																				%>
																				<option value="<%=i%>"><%=i%></option>
																				<%
																			}
																		}
																		%>
																	</select>
																</div>																
																<div>
																	<select de-data="전체" id="lecr_selSeason2" name="lecr_selSeason2">
																		<option value="">전체</option>
																		<option value="봄">봄</option>
																		<option value="여름">여름</option>
																		<option value="가을">가을</option>
																		<option value="겨울">겨울</option>									
																	</select>
																</div>
															</div>
														</div>
														 -->
													</div>
												</div>
												<div class="wid-15">
													<div class="table">
														<div class="sear-tit sear-tit-70">유형</div>
														<div class="oddn-sel">
															<select id="lecr_subject_fg" name="lecr_subject_fg" de-data="전체">
																<option value="">전체</option>
																<option value="1">정규</option>
																<option value="2">단기</option>
																<option value="3">특강</option>
															</select>
														</div>
													</div>
												</div>
												
												<div class="wid-25">
													<select id="lecr_grade" onchange="getLecrList();" de-data="평가결과" >
														<option value="">전체</option>
														<option value="A">A</option>
														<option value="B">B</option>
														<option value="C">C</option>
														<option value="D">D</option>
														<option value="E">E</option>											
													</select>
												</div>
											</div>
										
										</td>
									</tr>
								</table>
							</div>
						
						</div>
					</div>
					<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getLecrList();">
				</div>
								
			</div><!-- //tabbox -->
		</div>
	</div>

	<div class="top-row">
<!-- 		<div class="wid-5"> -->
			<div class="gift-table_02">
				<div class="table-cap table">
					<div class="cap-l">
						<div class="table table-auto">
							<div><h3>필터 값 적용 대상자</h3></div>
							<div><input class="sms-btn02 btn btn02" type="button" value="수신거부 제외" onclick="javascript:sort_sms();"></div></div>
						</div>
					<div class="cap-r text-right">
						<div class="float-right">
							<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
						</div>
					</div>
				</div>
				<div class="table-wr">
					<div class="thead-box on">
						<table id="excelTable">
							<colgroup>
								<col width="40px">
								<col width="80px">
								<col />
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th onclick="sortTD(0,'0','left')" class="td-chk">
										<input type="checkbox" id="left_all_chk" class="chk_input" name="left_all_chk" value="idxAll"><label for="left_all_chk" onclick="all_chker('left');"></label>
									</th>
									
									<th onclick="sortTD(1,'0','left')">NO.</th>
									<th onclick="sortTD(2,'sort_kor_nm','left')">회원명<img src="/img/th_up.png" id="sort_kor_nm_left"></th>
									<th onclick="sortTD(3,'sort_cus_no','left')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no_left"></th>
									<th onclick="sortTD(4,'sort_phone_no','left')">전화번호<img src="/img/th_up.png" id="sort_phone_no_left"></th>
									<th onclick="sortTD(5,'sort_grade','left')">회원등급<img src="/img/th_up.png" id="sort_grade_left"></th>
									<th onclick="sortTD(6,'sort_sms_yn','left')">SMS 수신여부<img src="/img/th_up.png" id="sort_sms_yn_left"></th>
									<th onclick="sortTD(7,'sort_lect_cnt','left')">수강강좌수<img src="/img/th_up.png" id="sort_lect_cnt_left"></th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="table-list table-list-shot scr-staton">
						<table id="left_area">
							<colgroup>
								<col width="40px">
								<col width="80px">
								<col />
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th onclick="sortTD(0,'0','left')" class="td-chk">
										<input type="checkbox" id="left_all_chk" class="chk_input" name="left_all_chk" value="idxAll"><label for="left_all_chk" onclick="all_chker('left');"></label>
									</th>
									
									<th onclick="sortTD(1,'0','left')">NO.</th>
									<th onclick="sortTD(2,'sort_kor_nm','left')">회원명<img src="/img/th_up.png" id="sort_kor_nm_left"></th>
									<th onclick="sortTD(3,'sort_cus_no','left')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no_left"></th>
									<th onclick="sortTD(4,'sort_phone_no','left')">전화번호<img src="/img/th_up.png" id="sort_phone_no_left"></th>
									<th onclick="sortTD(5,'sort_grade','left')">회원등급<img src="/img/th_up.png" id="sort_grade_left"></th>
									<th onclick="sortTD(6,'sort_sms_yn','left')">SMS 수신여부<img src="/img/th_up.png" id="sort_sms_yn_left"></th>
									<th onclick="sortTD(7,'sort_lect_cnt','left')">수강강좌수<img src="/img/th_up.png" id="sort_lect_cnt_left"></th>
								
								</tr>
							</thead>
							<tbody id="cust_area_left">
					
							</tbody>
						</table>
					</div>
				</div>
			
			</div>
	
	</div>

	<div class="btn-wr text-center">
		<a class="btn btn01 ok-btn" onclick="javascript:choose_cancle();">취소</a>
		<a class="btn btn02 ok-btn" onclick="javascript:choose_cust();">선택완료</a>
	</div>
	
</div>

<script>

function sortTD(index,act,way )
{   
	
	var myTable = document.getElementById("left_area"); 
	
	var replace = replacement( myTable ); 
	sort_type = act.replace("sort_", "");
	
	
	if(order_by == "")
	{
		order_by = "desc";
		replace.descending( index );    
		$("#"+act+'_'+way).attr("src", "/img/th_down.png");
	}
	else if(order_by == "desc")
	{
		order_by = "asc";
		replace.ascending( index );  
		$("#"+act+'_'+way).attr("src", "/img/th_up.png");
	}
	else if(order_by == "asc")
	{
		order_by = "desc";
		replace.descending( index );    
		$("#"+act+'_'+way).attr("src", "/img/th_down.png");
	}
	
	$("#order_by").val(order_by);
	$("#sort_type").val(sort_type);
} 

var isLoading = false;
function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".btn02").addClass("loading-sear");
	$(".btn02").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".btn02").removeClass("loading-sear");		
	$(".btn02").prop("disabled", false);
	isLoading = false;
}


function reSortAjax(act,way)
{
	if(!isLoading)
	{
		
		sort_type = act.replace("sort_", "");
		console.log(sort_type);
		console.log(order_by);
		
		if(order_by == "")
		{
			order_by = "desc";
			$("#"+act+"_"+way).attr("src", "/img/th_down.png");
		}
		else if(order_by == "desc")
		{
			order_by = "asc";
			$("#"+act+"_"+way).attr("src", "/img/th_up.png");
		}
		else if(order_by == "asc")
		{
			order_by = "desc";
			$("#"+act+"_"+way).attr("src", "/img/th_down.png");
		}
		
		
		page = 1;
		$("#order_by").val(order_by);
		$("#sort_type").val(sort_type);
		
	
		getList();			
	}
}


$(function(){
	$(".tab").each(function(){
		var ul = $(this).find(".tab-ul li"),
			div = $(this).find(".tab-cont > div");
		ul.click(function(){
			var idx = $(this).index();
			$('#cust_area_left').empty();
			if (idx=="0") 
			{
				is_lec="N";
			}
			else
			{
				is_lec="Y";
			}
			
			div.removeClass("on");
			ul.removeClass("on");
			div.eq(idx).addClass("on");
			ul.eq(idx).addClass("on");
		})
	})
	
})


</script>