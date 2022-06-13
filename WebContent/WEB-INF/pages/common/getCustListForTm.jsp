<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<script src="/inc/js/sort.js"></script>

<script>
var order_by = "";
var sort_type = "";
var target_cnt=0;
var is_lec="N";

$(window).ready(function(){	
	$("#taget_selBranch").val(login_rep_store);
	$(".taget_selBranch").html(login_rep_store_nm);
	getLastYearSeason();
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

function switch_cust(from,to){
	
	var move_area="";
	$('.cust_list_chk').each(function()
	{
		if( $(this).prop("checked")==true)
		{
			if ($(this).parent().parent().hasClass("isOk")) 
			{
				$(this).parent().parent().removeClass(from);
				$(this).removeClass(from+'_chk');
				$(this).addClass(to+'_chk');
				$(this).parent().parent().addClass(to);
				$(this).prop("checked",false);
				move_area +='<tr class="'+to+' isOk">'+$(this).parent().parent().html()+'</tr>';
				$(this).parent().parent().remove();
			}
		}
	})

	$('#cust_area_'+to).append(move_area);
	$('.chk_input').prop("checked",false);
	
    var cnt =1;
    $('.right_chk').each(function(){
  	 	 $(this).parent().next().text(cnt);
  	 	cnt++;
    })
    
    cnt=1;
    $('.left_chk').each(function(){
    	$(this).parent().next().text(cnt);
    	cnt++;
    })
}

function all_chker(way){
	if ( $('#'+way+'_all_chk').prop("checked")==true )  
	{
		$('.'+way+'_chk').prop("checked",false);			
	}
	else
	{
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

function getCustList(){ //Seach버튼 클릭
	var target_cnt=0;
	var f = document.fncTargetForm;
	

	
	var dupl_cus_no ="";	//오른쪽 영역에 있는 회원 멤버스 번호 체크 -> 중복 방지
	$('#cust_area_right').find('#cus_no').each(function(){
		dupl_cus_no += $(this).text()+',';
    })	
    dupl_cus_no = dupl_cus_no.slice(0,-1);
	var sect_cd = f.sel_sect.value.split('_');
	
	getListStart();
	$.ajax({
		type : "POST", 
		url : "/member/cust/getTmCustList",
		dataType : "text",
		data : {
			page : f.page.value,
			order_by : f.order_by.value,
			sort_type : f.sort_type.value,
			
			selBranch : f.taget_selBranch.value,
			selYear1 : f.selYear1.value,
			selSeason1 : f.selSeason1.value,
			
			main_cd : f.sel_main.value,
			sect_cd : sect_cd[1],
			subject_cd : f.sel_pelt.value,

			dupl_cus_no : dupl_cus_no,
			is_lec : is_lec
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
					inner='';
					inner+='<tr id="encd_cust_tr_'+target_cnt+'" class="left isOk">';
					inner+='	<td>';
					inner+='		<input type="checkbox" id="cust_list'+target_cnt+'" class="cust_list_chk left_chk chk_input" name="idx" value="'+result.list[i].CUST_NO+'"><label for="cust_list'+target_cnt+'"></label>';
					inner+='	</td>';
					
					inner+='	<td class="chk_num sort_num">'+(i+1)+'</td>';
					inner+='	<td class="sort_kor_nm">'+result.list[i].KOR_NM+'</td>';
					inner+='	<td class="sort_cus_no" id="cus_no">'+result.list[i].CUST_NO+'</td>';
					inner+='	<td class="sort_grade">'+result.list[i].GRADE+'</td>';
					inner+='	<td class="sort_sms_yn sms_'+result.list[i].SMS_YN+'">'+result.list[i].SMS_YN+'</td>';
					inner+='	<td class="sort_lect_cnt">'+result.list[i].LECT_CNT+'</td>';
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

function selMainCd2(idx)
{
	$("#sel_sect").html('');
	$(".sel_sect_ul").html('');
	$('.sel_sect').text('중분류');
	
	var code = $(idx).val();
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		data : 
		{
			maincd : code,
			selBranch : $("#selBranch").val(),
			selYear : $("#selYear1").val(),
			selSeason : $("#selSeason1").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner ="";
			var inner_li="";
			if(result.length > 0)
			{
				inner="";
				
				for (var i = 0; i < result.length; i++) 
				{
					inner += '<option value=\''+trim(result[i].MAIN_CD)+'_'+result[i].SECT_CD+'\'>'+result[i].SECT_NM+'</option>';
					inner_li += '<li>'+result[i].SECT_NM+'</li>';
				}
			}
			else
			{
				
			}
			$("#sel_sect").html(inner);
			$(".sel_sect_ul").html(inner_li);
		}
	});	
}

function cleanPelt(){
	$("#sel_pelt").html('');
	$(".sel_pelt_ul").html('');
	$('.sel_pelt').text('강좌를 선택해주세요.');
}

function selSectCd2(idx)
{
	cleanPelt();

	var arr=$(idx).val().split('_');
	getListStart();
	$.ajax({
		type : "POST", 
		url : "/common/getPeltBySectForTm",
		dataType : "text",
		data : 
		{
			maincd : arr[0],
			sectcd : arr[1],
			store : $("#taget_selBranch").val(),
			year : $('#selYear1').val(),
			season : $('#selSeason1').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			var inner = "";
			var inner_li="";
			if(result.length > 0)
			{
					
				inner += '<option value="">전체</option>';
				inner_li += '<li>전체</li>';
				for(var i = 0; i< result.length; i++)
				{
					inner += '<option value="'+result[i].SUBJECT_CD+'">'+result[i].SUBJECT_NM+'</option>';
					inner_li += '<li>'+result[i].SUBJECT_NM+'</li>';
				}
			}
			else
			{
				inner +='<option>검색결과가 없습니다.</option>';
				inner_li +='<li>검색 결과가 없습니다.</li>';
			}
			
			$("#sel_pelt").html(inner);
			$(".sel_pelt_ul").html(inner_li);
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
					inner+='	<td class="sort_lect_cnt">'+nullChk(result.list[i].LECT_CNT)+'</td>';
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

function sort_sms(){
	
	var len = $('.left').length;
	
	if (len == 0 ) 
	{
		alert('검색된 회원이 없습니다.');
		return
	}

	  if($('.sms-btn02').hasClass("on")){
          $('.sms-btn02').removeClass("on");
		  $('.sms-btn02').css('background','#111a3b');
		  $('.sms-btn02').css('border','solid 1px #111a3b');
		  $('.left').each(function()
		  { 
			  if ($(this).children().hasClass("sms_N")) 
			  {
				  $(this).addClass("isOk");
				  $(this).show();					
			  }
		  })

      }
	  else
      {
          $('.sms-btn02').addClass("on");
          $('.sms-btn02').css('background','#ee908e');
		  $('.sms-btn02').css('border','solid 1px #ee908e');
		  $('.left').each(function()
		  { 
			if ($(this).children().hasClass("sms_N")) 
			{
				$(this).removeClass("isOk");
				$(this).hide();					
			}	
		})
      }	
}



function submitTm(){
	custList = "";
	var cust_cnt =0;
    $('input[name="idx"]:checked').each(function(i)//체크된 리스트 저장
    {
    	custList =custList+$(this).val()+'|';	//고객번호
    	cust_cnt++;
    });
    custList = custList.slice(0,-1);
    
    if (custList=="") 
    {
		alert('회원을 선택해주세요.');
		return;
	}
    
    
    if ($('#title').val()=="") 
    {
		alert('제목을 입력해주세요.');
		$('#title').focus();
		return;
	}
    
    if ($('.purpose').text()=="선택하세요") 
    {
		alert('목적을 선택해주세요.');
		return;
	}
    
    
    
    getListStart();
	$.ajax({
		type : "POST", 
		url : "/member/sms/writeTm",
		dataType : "text",
		data : {
			store : $('#selBranch').val(),
			period : $('#selPeri').val(),
			lect_cd :$('#sel_pelt').val(),
			custlist : custList,
			title : $('#title').val(),
			purpose : $('#purpose').val(),
			dead_ymd : $('#dead_ymd').val(),
			is_lec : is_lec
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
			alert(result.msg);
			getListEnd();
			location.reload();
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

</script>
<div class="give-wrap give-wrap-tm">
	<h3>TM 등록</h3>
	<div class="tab">
		<ul class="tab-ul">
			<li id="chk_cus" class="on">회원검색</li>
			<li id="chk_lecr">강사검색</li>
		</ul>
	
				<form id="fncTargetForm" name="fncTargetForm">
				
					<input type="hidden" name="page">
					<input type="hidden" id="order_by" name="order_by" value="${order_by}">
				    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
				    
					<div class="table-top bg01">
						<div class="top-row">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">제목</div>
									<div>
										 <input type="text" id="title" value="">
									</div>
								</div>
							</div>
							<div class="wid-25">
								<div class="table">
									<div class="sear-tit sear-tit_left">목적</div>
									<div>
										 <select id="purpose" name="purpose" de-data="선택하세요">
											 <option value="1">강좌폐강</option>
											 <option value="2">폐강취소</option>
											 <option value="3">회원연락</option>
											<!-- <option value="4">휴강</option> -->
											 <option value="5">강사연락</option>
											 <option value="6">기타</option>
										 </select>
									</div>
								</div>
							</div>
							<div class="wid-25">
								<div class="table">
									<div class="sear-tit">완료 예정일</div>
									<div>
										<div class="cal-input">
											<input type="text" class="date-i start-i hasDatepicker" id="dead_ymd" name="dead_ymd">
											<i class="material-icons">event_available</i>
										</div>
									</div>
								</div>
							</div>
						</div>
					
						<div class="tab-cont">
							<div class="on">
								<div class="top-row">
									<div class="wid-4">
										<div class="table table-auto ">
											<div class="">
												<c:if test="${isBonbu eq 'T'}">
													<select de-data="${login_rep_store_nm}" id="taget_selBranch" name="taget_selBranch" onchange="cleanPelt();">
														<c:forEach var="i" items="${branchList}" varStatus="loop">
															<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
														</c:forEach>
													</select>
												</c:if>
												<c:if test="${isBonbu eq 'F'}">
													<select de-data="${login_rep_store_nm}" id="taget_selBranch" name="taget_selBranch" onchange="cleanPelt();">
														<c:forEach var="i" items="${branchList}" varStatus="loop">
															<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
														</c:forEach>
													</select>
												</c:if>
											</div>
											<div>
												<select de-data="${year}" id="selYear1" name="selYear1" onchange="cleanPelt();">
													<option value="">전체</option>
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
												<select de-data="봄" id="selSeason1" name="selSeason1" onchange="cleanPelt();">
													<option value="봄">봄</option>
													<option value="여름">여름</option>
													<option value="가을">가을</option>
													<option value="겨울">겨울</option>									
												</select>
											</div>
										</div>
									</div>	
									
									<div class="wid-45">
										<div class="table table-auto">
											<div>
												 <select id="sel_main" name="sel_main" de-data="대분류" onchange="selMainCd2(this);">
													<option value="">전체</option>
												 <c:forEach var="j" items="${maincdList}" varStatus="loop">
													 <option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
												</c:forEach>
												 </select>
											</div>
											<div>
												 <select id="sel_sect" name="sel_sect" de-data="중분류" onchange="selSectCd2(this)">
													
												 </select>
											</div>
											<div>
												 <select id="sel_pelt" name="sel_pelt" de-data="강좌를 선택해주세요.">
							
												 </select>
											</div>
										</div>
									</div>
									<div class="wid-15">
										<div class="table">
											<div>
												<input type="text" class="date-i ready-i hasDatepicker" id="send_end_tm" name="send_end_tm">
											</div>
										</div>
									</div>
									
								</div>
							</div>
							<div>
								<div class="ak_lecrwrap">
								<div class="top-row">
									<div class="wid-10">
										<table id="">
											<tr>
												<th class="th01">검색</th>
												<td>	
													<div class="table table-auto">
														<div>
															<select de-data="전체" id="lecr_selBranch" name="lecr_selBranch" onchange="getLastYearSeason(); cleanPelt();">
																	<option value="">전체</option>
																<c:forEach var="i" items="${branchList}" varStatus="loop">
																	<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
																</c:forEach>
															</select>
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
																			<select de-data="${year}" id="lecr_selYear1" name="lecr_selYear1" onchange="cleanPelt();">
																				<option value="">전체</option>			
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
																			<select de-data="전체" id="lecr_selSeason1" name="lecr_selSeason1" onchange="cleanPelt();">
																				<option value="">전체</option>
																				<option value="봄">봄</option>
																				<option value="여름">여름</option>
																				<option value="가을">가을</option>
																				<option value="겨울">겨울</option>									
																			</select>																
																		</div>
																	</div>
																</div>
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
							</div><!-- //tabcont > div -->
						</div><!-- //tabcont  -->
						<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getCustList()">			
					</div>
				</form>	
								
			</div><!-- //tabbox -->

	<div class="top-row">
<!-- 		<div class="wid-5"> -->
			<div class="gift-table_02">
				<div class="table-cap table table-auto">
					<div><h3>필터 값 적용 대상자</h3></div>
					<div><input class="sms-btn02 btn btn02" type="button" value="수신거부 제외" onclick="javascript:sort_sms();"></div>
				</div>
				<div class="table-wr">
					<div class="thead-box on">
						<table>
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
									<th onclick="sortTD(4,'sort_grade','left')">회원등급<img src="/img/th_up.png" id="sort_grade_left"></th>
									<th onclick="sortTD(5,'sort_sms_yn','left')">SMS 수신여부<img src="/img/th_up.png" id="sort_sms_yn_left"></th>
									<th onclick="sortTD(6,'sort_lect_cnt','left')">수강강좌수<img src="/img/th_up.png" id="sort_lect_cnt_left"></th>
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
									<th onclick="sortTD(4,'sort_grade','left')">회원등급<img src="/img/th_up.png" id="sort_grade_left"></th>
									<th onclick="sortTD(5,'sort_sms_yn','left')">SMS 수신여부<img src="/img/th_up.png" id="sort_sms_yn_left"></th>
									<th onclick="sortTD(6,'sort_lect_cnt','left')">수강강좌수<img src="/img/th_up.png" id="sort_lect_cnt_left"></th>
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
		<a class="btn btn02 ok-btn" onclick="javascript:submitTm();">작성</a>
	</div>
	
</div>

<script>

function sortTD(index,act,way )
{
	
	var myTable = document.getElementById("left_area"); 
	if (way=="right") {
		myTable = document.getElementById("right_area"); 
	}
	
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
$(function(){
	$(".tab").each(function(){
		var ul = $(this).find(".tab-ul li"),
			div = $(this).find(".tab-cont > div");
		ul.click(function(){
			var idx = $(this).index();
			$('#cust_area_left').empty();
			$('#cust_area_right').empty();
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


</script>