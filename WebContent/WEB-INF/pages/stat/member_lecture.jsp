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
	var filename = "강좌별 회원 구분";
	var table = "excelTable";
    exportExcel(filename, table);
}
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
	 			$("#search_start").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#search_end").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}
var tot_regis_no = 0;
var tot_new = 0;
var tot_diamond = 0;
var tot_platinum = 0;
var tot_crystal = 0;
var tot_gold = 0;
var tot_aclass = 0;
function getList(paging_type) 
{
	if(paging_type != "scroll")
	{
		tot_regis_no = 0;
		tot_new = 0;
		tot_diamond = 0;
		tot_platinum = 0;
		tot_crystal = 0;
		tot_gold = 0;
		tot_aclass = 0;
	}
	getListStart();
	
	
	$.ajax({
		type : "POST", 
		url : "./getMemberLecture",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val(),
			subject_fg : $("#subject_fg").val(),
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val(),
			isPerformance : $("#isPerformance").is(":checked")
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
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';	
					inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_NO))+'</td>';
					inner += '	<td>'+(nullChkZero(result.list[i].NEW) / nullChkZero(result.list[i].REGIS_NO) * 100).toFixed(2)+'%</td>';
					inner += '	<td>'+(nullChkZero(result.list[i].ACLASS) / nullChkZero(result.list[i].REGIS_NO) * 100).toFixed(2)+'%</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].NEW))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].DIAMOND))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].PLATINUM))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].CRYSTAL))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].GOLD))+'</td>';
					inner += '</tr>';
					
					tot_regis_no += Number(nullChkZero(result.list[i].REGIS_NO));
					tot_new += Number(nullChkZero(result.list[i].NEW));
					tot_diamond += Number(nullChkZero(result.list[i].DIAMOND));
					tot_platinum += Number(nullChkZero(result.list[i].PLATINUM));
					tot_crystal += Number(nullChkZero(result.list[i].CRYSTAL));
					tot_gold += Number(nullChkZero(result.list[i].GOLD));
					tot_aclass += Number(nullChkZero(result.list[i].ACLASS));
					
				}
				$("#tot_regis_no").html(comma(nullChkZero(tot_regis_no)));
				$("#tot_new_per").html((nullChkZero(tot_new) / nullChkZero(tot_regis_no) * 100).toFixed(2)+"%");
				$("#tot_aclass_per").html((nullChkZero(tot_aclass) / nullChkZero(tot_regis_no) * 100).toFixed(2)+"%");
				$("#tot_new").html(comma(nullChkZero(tot_new)));
				$("#tot_diamond").html(comma(nullChkZero(tot_diamond)));
				$("#tot_platinum").html(comma(nullChkZero(tot_platinum)));
				$("#tot_crystal").html(comma(nullChkZero(tot_crystal)));
				$("#tot_gold").html(comma(nullChkZero(tot_gold)));
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
function selMaincd(idx){	
// 	var x = document.getElementById("selPeri").selectedIndex;
// 	var y = document.getElementById("selPeri").options;
// 	var z = document.getElementById("selPeri").options[y[x].index];

	main_cd = $(idx).val();
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
	}else{
		$('.withBaby').hide();
	}
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		data : 
		{
			maincd : main_cd,
// 			selBranch : z.getAttribute("store")
			selBranch : $("#selBranch").val()
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
			$("#sect_cd").empty();
			$(".sect_cd_ul").html("");
			
			$(".sect_cd_ul").append('<li>전체</li>');
			$("#sect_cd").append('<option value="">전체</option>');
			if(result.length > 0)
			{
				
				inner="";
				for (var i = 0; i < result.length; i++) 
				{
					$(".sect_cd_ul").append('<li>'+result[i].SECT_NM+'</li>');
					$("#sect_cd").append('<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>');
				}
			}
			else
			{
				
			}
			$("#sect_cd").val("");
			$(".sect_cd").html("전체");
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>강좌별 회원 구분</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<div class="oddn-sel02 sel-scr">
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
		</div>
		<div class="wid-15 mag-l2">
			<ul class="chk-ul">
				<li>
					<input type="checkbox" id="isPerformance" name="isPerformance">
					<label for="isPerformance">임시 중분류 포함</label>
				</li>
			</ul>
		</div>
	</div>
	<div class="top-row">	
		<div class="wid-4">
			<div class="table table-input">
				<div>
					<div class="cal-row table table-90">
						<div class="cal-input cal-input02">
							<input type="text" class="date-i start-i" id="search_start" name="search_start"/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input cal-input02">
							<input type="text" class="date-i ready-i" id="search_end" name="search_end"/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-25">
			<div class="table">
				<div class="sear-tit">강좌 유형</div>
				<div>
					<select id="subject_fg" name="subject_fg" de-data="전체">
						<option value="">전체</option>
						<option value="1">정규</option>
						<option value="2">단기</option>
						<option value="3">특강</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="wid-35 mag-l2">
			<div class="table">
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_70">강좌 분류</div>
						<div>
							<select de-data="전체" id="main_cd" name="main_cd" data-name="대분류" onchange="selMaincd(this)">
								<option value="">전체</option>
								<c:forEach var="j" items="${maincdList}" varStatus="loop">
									<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
								</c:forEach>
							</select>
							<select de-data="전체" id="sect_cd" name="sect_cd" onchange="">
								<option value="">전체</option>
							</select>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>	


<div class="table-cap table">
	<div class="cap-r text-right">
		
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
				<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
					<option value="10">10개 보기</option>
					<option value="20">20개 보기</option>
					<option value="50">50개 보기</option>
					<option value="100">100개 보기</option>
					<option value="300">300개 보기</option>
					<option value="500">500개 보기</option>
					<option value="1000">1000개 보기</option>
					<option value="5000">5000개 보기</option>
				</select>
			</div>
		</div>
	</div>
</div>


<div class="table-wr ip-list table-twobor">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col width="250px">
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
				<tr class="melec-wrap01">
					<th rowspan="2" onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th rowspan="2" onclick="reSortAjax('sort_subject_fg')">강좌유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th rowspan="2" onclick="reSortAjax('sort_main_cd')">대분류 <img src="/img/th_up.png" id="sort_main_cd"></th>
					<th rowspan="2" onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th rowspan="2" onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm" class="td-140"></th>
					<th rowspan="2" onclick="reSortAjax('sort_regis_no')">총 현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th rowspan="2">신규 비중</th>
					<th rowspan="2">A-CLASS 비중</th>
					<th colspan="5">세부현황</th>
				</tr>	
				<tr class="melec-wrap02">
					<th onclick="reSortAjax('sort_new')">신규 <img src="/img/th_up.png" id="sort_new"></th>
					<th onclick="reSortAjax('sort_diamond')">다이아 <img src="/img/th_up.png" id="sort_diamond"></th>
					<th onclick="reSortAjax('sort_platinum')">플래티넘 <img src="/img/th_up.png" id="sort_platinum"></th>
					<th onclick="reSortAjax('sort_crystal')">크리스탈 <img src="/img/th_up.png" id="sort_crystal"></th>
					<th onclick="reSortAjax('sort_gold')">골드 <img src="/img/th_up.png" id="sort_gold"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-stlist" >
		<table id="excelTable">
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col width="250px">
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
				<tr class="melec-wrap01">
					<th rowspan="2" onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th rowspan="2" onclick="reSortAjax('sort_subject_fg')">강좌유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th rowspan="2" onclick="reSortAjax('sort_main_cd')">대분류 <img src="/img/th_up.png" id="sort_main_cd"></th>
					<th rowspan="2" onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th rowspan="2" onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm" class="td-140"></th>
					<th rowspan="2" onclick="reSortAjax('sort_regis_no')">총 현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th rowspan="2">신규 비중</th>
					<th rowspan="2">A-CLASS 비중</th>
					<th colspan="5">세부현황</th>
				</tr>	
				<tr class="melec-wrap02">
					<th onclick="reSortAjax('sort_new')">신규 <img src="/img/th_up.png" id="sort_new"></th>
					<th onclick="reSortAjax('sort_diamond')">다이아 <img src="/img/th_up.png" id="sort_diamond"></th>
					<th onclick="reSortAjax('sort_platinum')">플래티넘 <img src="/img/th_up.png" id="sort_platinum"></th>
					<th onclick="reSortAjax('sort_crystal')">크리스탈 <img src="/img/th_up.png" id="sort_crystal"></th>
					<th onclick="reSortAjax('sort_gold')">골드 <img src="/img/th_up.png" id="sort_gold"></th>
				</tr>
			</thead>
			
			<tbody id="list_target">
			
			</tbody>
		</table>
	</div>
</div>
			

<script>
$(document).ready(function() {
	setPeri();
	fncPeri();
	selPeri();
	getList();
	//지점 바꾸면 대분류,중분류 초기화
	$(".selBranch_ul > li").click( function() {
		$("#sect_cd").empty();
		$(".sect_cd_ul").html("");
		$(".sect_cd_ul").append('<li>전체</li>');
		$("#sect_cd").append('<option value="">전체</option>');
		
		$("#main_cd").val("");
		$(".main_cd").html("전체");
		$("#sect_cd").val("");
		$(".sect_cd").html("전체");
	});
});

</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
<div class="sta-botfix sta-botfix04">
	<ul>
		<li class="li01">총 계</li>
		<li id="tot_regis_no" class="li02">0</li>
		<li id="tot_new_per" class="li02">0</li>
		<li id="tot_aclass_per" class="li02">0</li>
		<li id="tot_new" class="li02">0</li>
		<li id="tot_diamond" class="li02">0</li>
		<li id="tot_platinum" class="li02">0</li>
		<li id="tot_crystal" class="li02">0</li>
		<li id="tot_gold" class="li02">0</li>
		<li class="li03"></li>
	</ul>
</div>























<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>