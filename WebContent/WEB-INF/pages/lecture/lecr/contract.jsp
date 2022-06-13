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
	var filename = "강사계약서";
	var table = "excelTable";
    exportExcel(filename, table);
}
$(document).ready(function(){
	$("#chk_all").change(function() {
		if($("input:checkbox[name='chk_all']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", false);
		}
	});
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
	 			$("#start_ymd").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#end_ymd").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}


function getList(paging_type)
{
	getListStart();
	
	var contract_type="";

	var contract_type01="";
	var contract_type02="";
	var contract_type03="";
	var contract_type04="";
	
    if($("input:checkbox[name='contract_type01']").is(":checked")){
    	contract_type01= $("#contract_type01").val();
    }
    if($("input:checkbox[name='contract_type02']").is(":checked")){
    	contract_type02= $("#contract_type02").val();
    }
    if($("input:checkbox[name='contract_type03']").is(":checked")){
    	contract_type03= $("#contract_type03").val();
    }
    if($("input:checkbox[name='contract_type04']").is(":checked")){
    	contract_type04= $("#contract_type04").val();
    }
    
    setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("year", $("#selYear").val(), 9999);
	setCookie("season", $("#selSeason").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("search_type", $("#search_type").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("search_start", $("#start_ymd").val(), 9999);
	setCookie("search_end", $("#end_ymd").val(), 9999);
	setCookie("subject_fg", $("#search_subject_fg").val(), 9999);
	setCookie("contract_type01", contract_type01, 9999);
	setCookie("contract_type02", contract_type02, 9999);
	setCookie("contract_type03", contract_type03, 9999);
	setCookie("contract_type04", contract_type04, 9999);
    
	$.ajax({
		type : "POST", 
		url : "./getcontlist",
		dataType : "text",
		data : 
			
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			period : $('#selPeri').val(),
			
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			subject_fg : $('#search_subject_fg').val(),
			contract_type01 : contract_type01,
			contract_type02 : contract_type02,
			contract_type03 : contract_type03,
			contract_type04 : contract_type04
		},
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
					if ((result.list[i].IS_TWO =='N' && result.list[i].MAIN_CHK =='main') || result.list[i].IS_TWO =='Y') 
					{
						inner += '<tr>';
						inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CUS_PN)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].FIX_PAY_YN)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].START_YMD)+' ~ '+nullChk(result.list[i].END_YMD)+'</td>';
						inner += '	<td>'+cutYoil(nullChk(result.list[i].DAY_FLAG))+'</td>';
						inner += '	<td>'+cutLectHour(nullChk(result.list[i].LECT_HOUR))+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CONTRACT_DAY)+'</td>';
						
						if (nullChk(result.list[i].CONFIRM_YN)=="N" && nullChk(result.list[i].SUBMIT_FG)=='N')
						{
							inner += '	<td class="red-line" onclick="javascript:writePage(\''+nullChk(result.list[i].SUBJECT_CD)+'_'+nullChk(result.list[i].CUS_NO)+'\');" style="cursor:pointer;">미작성</td>';
							inner += '	<td class="close" onclick="javascript:writePage(\''+nullChk(result.list[i].SUBJECT_CD)+'_'+nullChk(result.list[i].CUS_NO)+'\',\'W\');"><span>작성 전</span></td>';
						}
						else if(nullChk(result.list[i].CONFIRM_YN)=="N" && nullChk(result.list[i].SUBMIT_FG)=='W')
						{
							inner += '	<td onclick="javascript:writePage(\''+nullChk(result.list[i].SUBJECT_CD)+'_'+nullChk(result.list[i].CUS_NO)+'\',\'R\');"></td>';
							inner += '	<td class="open" onclick="location.href=\'./contract_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+result.list[i].SUBJECT_CD+'&cus_no='+result.list[i].CUS_NO+' \'"><span>계약서 보기</span></td>';
						}
						else if(nullChk(result.list[i].CONFIRM_YN)=="N" && nullChk(result.list[i].SUBMIT_FG)=='Y')
						{
							inner += '	<td onclick="javascript:writePage(\''+nullChk(result.list[i].SUBJECT_CD)+'_'+nullChk(result.list[i].CUS_NO)+'\',\'R\');">대기</td>';
							inner += '	<td class="open" onclick="location.href=\'./contract_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+result.list[i].SUBJECT_CD+'&cus_no='+result.list[i].CUS_NO+' \'"><span>계약서 보기</span></td>';
						}
						else if(nullChk(result.list[i].CONFIRM_YN)=="N" && nullChk(result.list[i].SUBMIT_FG)=='R') //원래는 회수
						{
							inner += '	<td onclick="javascript:writePage(\''+nullChk(result.list[i].SUBJECT_CD)+'_'+nullChk(result.list[i].CUS_NO)+'\',\'R\');">미작성</td>';
							inner += '	<td class="open" onclick="location.href=\'./contract_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+result.list[i].SUBJECT_CD+'&cus_no='+result.list[i].CUS_NO+' \'"><span>계약서 보기</span></td>';
						}
						else if(nullChk(result.list[i].CONFIRM_YN)=="Y" && nullChk(result.list[i].SUBMIT_FG)=='Y')
						{
							inner += '	<td onclick="javascript:writePage(\''+nullChk(result.list[i].SUBJECT_CD)+'_'+nullChk(result.list[i].CUS_NO)+'\',\'R\');">완료</td>';
							inner += '	<td class="open02" onclick="location.href=\'./contract_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+result.list[i].SUBJECT_CD+'&cus_no='+result.list[i].CUS_NO+' \'"><span>계약서 보기</span></td>';
						}
						
						inner += '</tr>';
					}
					
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="12"><div class="no-data">검색결과가 없습니다.</div></td>';
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



var subject_cd = "";
var cus_no ="";
function writePage(idx,auth)
{
	$('#write_layer').fadeIn(200);	
	var arr = idx.split('_');
	subject_cd = arr[0];
	cus_no = arr[1];
	
	$.ajax({
		type : "POST", 
		url : "./getapplicntInfo",
		dataType : "text",
		async : false,
		data : 
		{

			store : $("#selBranch").val(),
			period : $('#selPeri').val(),
			subject_cd : subject_cd,
			cus_no : cus_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$('#store').val(nullChk(result.STORE_NM));
			$('#kor_nm').val(nullChk(result.CUS_PN));
			$('#lec_nm').val(nullChk(result.SUBJECT_NM));
			$('#subject_fg').val(nullChk(result.SUBJECT_FG));
			$('#main_cd').val(nullChk(result.MAIN_NM));
			$('#pay_method').val(nullChk(result.FIX_PAY_YN));
			$('#yoil').val(cutYoil(nullChk(result.DAY_FLAG)));
			$('#lect_start_ymd').val(nullChk(result.START_YMD));
			$('#lect_end_ymd').val(nullChk(result.END_YMD));
			
			
			$('#lect_fee').val(result.LECT_FEE);
						
			$('#lect_hour').val(cutLectHour(nullChk(result.LECT_HOUR)));
			$('#contract_start').val(nullChk(result.CONTRACT_START));
			$('#contract_end').val(nullChk(result.CONTRACT_END));
			$('#auto_term').val(nullChk(result.AUTO_TERM));
			$('#contract_start').val(nullChk(result.START_YMD));
			$('#contract_end').val(nullChk(result.END_YMD));

			if (auth=="R") 
			{
				$('#saveBtn').hide();
			}
			else
			{
				$('#saveBtn').show();
			}
		}
	});	
}

function sendinfo(){
	var f = document.saveInfo;
	
	if(f.contract_start.value == ""){
    	alert("계약 시작일을 입력하세요");
    	 f.contract_start.focus();
    	return;
    }
	
	if(f.contract_end.value == ""){
    	alert("계약 종료을 입력하세요");
    	 f.contract_end.focus();
    	return;
    }
	
	if(f.auto_term.value == ""){
    	alert("자동 연장기간을 입력하세요");
    	 f.auto_term.focus();
    	return;
    }

	var naver_yn='N';
	if($("#naver_chk").is(":checked"))
	{
		naver_yn = "Y";
	}
	
	
	$.ajax({
		type : "POST", 
		url : "./saveInfo",
		dataType : "text",
		async : false,
		data : {
			store : $("#selBranch").val(),
			period : $('#selPeri').val(),
			subject_cd : subject_cd,
			cus_no : cus_no,
			contract_start : f.contract_start.value,
			contract_end : f.contract_end.value,
			auto_term : f.auto_term.value,
			naver_yn : naver_yn
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			$('#write_layer').fadeOut(200);
			getList();
		}
	});	
}

</script>

<div class="sub-tit">
	<h2>강사 계약서</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	
</div>
<form id="fncForm" name="fncForm" method="get" action="./contract">
	<div class="table-top table-top02">
		<div class="top-row sear-wr table">
			<div class="wid-3">
				<div class="table table-auto">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<div class="oddn-sel">
					<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
				</div>
			</div>
			
			<div class="wid-25">
				<div class="search-wr">
					<!-- 
					<select id="search_type" name="search_type" de-data="검색항목">
						<option value="kor_nm">이름</option>
						<option value="email_addr">이메일</option>
					<option value="phone_no">휴대폰번호</option>
					</select>
			   		 -->
			   		<input type="text" class="inp-100" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="강좌명 / 강사명 / 휴대폰번호가 검색됩니다.">
			   		<input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
				</div>
			</div>
			<div class="wid-2">
				<div class="table table-auto margin-auto">
					<div class="sear-tit text-left sear-tit_120">강좌 유형 선택</div>
					<div>
						<select id="search_subject_fg" de-data="전체">
							<option value="">전체</option>
							<option value="1">정규</option>
							<option value="2">단기</option>
							<option value="3">특강</option>
						</select>
						
					</div>
				</div>
			</div>
			
			<div class="wid-25">
				<div class="table">
					<div class="sear-tit text-left sear-tit_120">계약 상태 선택</div>
					<div>
						<ul class="chk-ul chk-ul02">
							<li>
								<input type="checkbox" id="contract_type01" value="NN" name="contract_type01">
								<label for="contract_type01">미작성</label>
							</li>
							<li>
								<input type="checkbox" id="contract_type02" value="YN" name="contract_type02">
								<label for="contract_type02">대기</label>
							</li>
							<li>
								<input type="checkbox" id="contract_type04" value="YY" name="contract_type04">
								<label for="contract_type04">완료</label>
							</li>
						
						</ul>
					</div>
				</div>
			</div>
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
	</div>
		

	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			<div class="float-right">
				<div class="sel-scr">
					<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
					<select id="listSize" name="listSize" onchange="reSelect()" de-data="10개 보기">
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
	<input type="hidden" id="page" name="page" value="${page}">
	<input type="hidden" id="order_by" name="order_by" value="${order_by}">
    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
    <input type="hidden" id="listSize" name="listSize" value="${sort_type}">
</form>
<div class="table-wr ip-list">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th>지점</th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_cus_pn')">강사명 <img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_fix_pay_yn')">강사료 지급조건 <img src="/img/th_up.png" id="sort_fix_pay_yn"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">강의기간 <img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
					<th onclick="reSortAjax('sort_contract_day')">계약일 <img src="/img/th_up.png" id="sort_contract_day"></th>
					<th onclick="reSortAjax('sort_con_state')">계약상태 <img src="/img/th_up.png" id="sort_con_state"></th>
					<th></th>
					
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th>지점</th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_cus_pn')">강사명 <img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_fix_pay_yn')">강사료 지급조건 <img src="/img/th_up.png" id="sort_fix_pay_yn"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">강의기간 <img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
					<th onclick="reSortAjax('sort_contract_day')">계약일 <img src="/img/th_up.png" id="sort_contract_day"></th>
					<th onclick="reSortAjax('sort_con_state')">계약상태 <img src="/img/th_up.png" id="sort_con_state"></th>
					<th></th>
				</tr>
			</thead>
			<tbody id="list_target">
			
			</tbody>
		</table>
	</div>
</div>

<form id="saveInfo" name ="saveInfo" action='/saveInfo' method='post'>
	<div id="write_layer" class="write-contwrap list-edit-wrap">
		<div class="le-cell">
			<div class="le-inner">
	        	<div class="list-edit white-bg">
	        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200);">
	        			닫기<i class="far fa-window-close"></i>
	        		</div>
	        		<div>
	        			<h3>계약조건 및 계약서</h3>        			
	        			<div class="table-top bg01 lec-contwr">
	        			
	        				<div class="table">
	        					<div class="">	        						
									<div class="table">
										<div class="sear-tit">점명</div>
										<div>
											<input type="text" id="store" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
										</div>
									</div>									
	        					</div>
	        					
	        					<div class="wid-35">	        						
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">강사명</div>
										<div>
											<input type="text" id="kor_nm" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
										</div>
									</div>									
	        					</div>
	        					<div class="wid-35">	        						
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">강의명</div>
										<div>
											<input type="text" id="lec_nm" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
										</div>
									</div>									
	        					</div>
	        				</div>
	        			
	        			
	        				<div class="table">
								<div class="">
									<div class="table">
										<div class="sear-tit">유형</div>
										<div>
											<div class="cal-row">
												<div class="cal-input">
													<input type="text" id="subject_fg" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
												</div>
											</div>
										</div>
									</div>
								</div>		
								
								<div class="wid-35">
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">대상</div>
										<div>
											<div class="cal-row">
												<div class="cal-input">
													<input type="text" id="main_cd" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
												</div>
											</div>
										</div>
									</div>
								</div>	
	        				
	        					<div class="wid-35">	        						
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">강사료 지급 <br> 방법</div>
										<div>
											<input type="text" id="pay_method" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
										</div>
									</div>									
	        					</div>
	        				</div>
	        				
	        				
	       					<div class="table">
	       					
								<div class="wid-10 ">
									<div class="table">
										<div class="sear-tit">강의요일</div>
										<div>
											<div class="cal-row">
												<div class=" ">
													<input type="text" id="yoil" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
												</div>
											</div>
										</div>
									</div>
								</div>
	
							</div>
	        				
	       					<div class="table">
	       					
								<div class="">
									<div class="table">
										<div class="sear-tit">강의기간</div>
										<div>
											<div class="cal-row">
												<div class="cal-input wid-45">
													<input type="text" id="lect_start_ymd" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
												</div>
												<div class="cal-dash wid-1">-</div>
												<div class="cal-input wid-45">
													<input type="text" id="lect_end_ymd" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="wid-35">
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">강사료</div>
										<div>
											<input type="text" id="lect_fee" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
										</div>
									</div>
								</div>
								
								
								
							</div>
							
	       					<div class="table">
	       					
	       						<div class="">
									<div class="table">
										<div class="sear-tit">강의시간</div>
										<div>
											<div class="time-row">
												<div>
													<div class="time-input time-input180 sel-scr">
														<input type="text" id="lect_hour" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
													</div>
												</div>
											</div>
										</div>		
									</div>
								</div>
							</div>
							
							
							
	       					<div class="table">
	       					
								<div class="">
									<div class="table">
										<div class="sear-tit">계약기간</div>
										<div>
											<div class="cal-row">
												<div class="cal-input wid-45">
													<input type="text" class="date-i" id="contract_start" name="contract_start">
													<i class="material-icons">event_available</i>
												</div>
												<div class="cal-dash wid-1">-</div>
												<div class="cal-input wid-45">
													<input type="text" class="date-i" id="contract_end" name="contract_end">
													<i class="material-icons">event_available</i>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="wid-35">
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">자동연장기간</div>
										<div>
											<input type="text" style="width:80%;" id="auto_term" value="2" name="auto_term"> 개월
										</div>
									</div>
								</div>

								
							</div>
							
							
							
						<div class="table">
	       					
	       						<div class="">
									<div class="table">
										<div class="sear-tit">네이버</div>
										<div>
											<div class="time-row">
												<div>
													<div class="time-input time-input180 sel-scr">
														<input type="checkbox" id="naver_chk" name="naver_chk">										
														<label for="naver_chk"></label>
													</div>
												</div>
											</div>
										</div>		
									</div>
								</div>
							</div>
							
							
							
							
	        			</div>
	        			
	        			<div id="saveBtn" class="text-center">
							<a class="btn btn02 ok-btn" onclick="javascript:sendinfo();">작성하기</a>
						</div>
	        		</div>
	        	</div>
	        </div>
	    </div>
	</div>
</form>
<script>
$(document).ready(function() {
	if(getCookie("contract_type01") == "NN")
	{
		$("input:checkbox[id='contract_type01']").prop("checked", true); 
	}
	else
	{
		$("input:checkbox[id='contract_type01']").prop("checked", false);
	}
	if(getCookie("contract_type02") == "YN")
	{
		$("input:checkbox[id='contract_type02']").prop("checked", true); 
	}
	else
	{
		$("input:checkbox[id='contract_type02']").prop("checked", false);
	}
	if(getCookie("contract_type04") == "YY")
	{
		$("input:checkbox[id='contract_type04']").prop("checked", true); 
	}
	else
	{
		$("input:checkbox[id='contract_type04']").prop("checked", false);
	}
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("year")) != "") { $("#selYear").val(nullChk(getCookie("year"))); $(".selYear").html($("#selYear option:checked").text());}
	fncPeri();
	if(nullChk(getCookie("season")) != "") { $("#selSeason").val(nullChk(getCookie("season"))); $(".selSeason").html($("#selSeason").val() + " / "+nullChk(getCookie("period")))}
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type"))); $(".search_type").html($("#search_type option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("search_start")) != "") { $("#start_ymd").val(nullChk(getCookie("search_start")));}
	if(nullChk(getCookie("search_end")) != "") { $("#end_ymd").val(nullChk(getCookie("search_end")));}
	if(nullChk(getCookie("subject_fg")) != "") { $("#search_subject_fg").val(nullChk(getCookie("subject_fg"))); $(".search_subject_fg").html($("#search_subject_fg option:checked").text());}
	setPeri();
	getList();
});
</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>