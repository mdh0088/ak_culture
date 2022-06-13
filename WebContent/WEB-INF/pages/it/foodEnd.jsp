<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker_month.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>
var isLoading = false;
function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".search-btn02").addClass("loading-sear");
	$(".search-btn02").prop("disabled", true);
	$(".search-btn").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".search-btn02").removeClass("loading-sear");		
	$(".search-btn02").prop("disabled", false);
	$(".search-btn").prop("disabled", false);
	isLoading = false;
}
function excelDown()
{
	var filename = "재료비 마감내역";
	var table = "excelTable";
    exportExcel(filename, table);
}

var order_by = "";
var sort_type = "";

function reSortAjax(act)
{
	if(!isLoading)
	{
		sort_type = act.replace("sort_", "");
		if(order_by == "")
		{
			order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		else if(order_by == "desc")
		{
			order_by = "asc";
			$("#"+act).attr("src", "/img/th_up.png");
		}
		else if(order_by == "asc")
		{
			order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		getList();
	}
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
	 			$("#search_start").val(cutDate(result.START_YMD));
	 			$("#search_end").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}
function periInit()
{
	getPayMonth('food');
}
var tot_payment = 0;
var tot_part = 0;
var tot_lect_pay1 = 0;
var tot_lect_pay2 = 0;
var tot_lect_pay3 = 0;
var tot_lect_pay4 = 0;
var tot_lect_pay5 = 0;

function getList() 
{
	tot_food_amt = 0;
	tot_regis_no = 0;
	tot_payment = 0;
	tot_part = 0;
	tot_lect_pay1 = 0;
	tot_lect_pay2 = 0;
	tot_lect_pay3 = 0;
	tot_lect_pay4 = 0;
	tot_lect_pay5 = 0;
	getListStart();
	
	$.ajax({
		type : "POST", 
		url : "./getFoodEnd",
		dataType : "text",
		data : 
		{
			order_by : order_by,
			sort_type : sort_type,
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			food_ym : $("input[name='food_ym']:checked").val().substring(0,6),
			search_name : $("#search_name").val()
			
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
					var sum_pay = nullChkZero(result.list[i].SUM_PAY);
					var tot_pay = nullChkZero(result.list[i].TOT_PAY);
					var remain_pay = sum_pay - tot_pay;
					
					tot_payment += nullChkZero(result.list[i].NORMAL_PAY);
					tot_part += nullChkZero(result.list[i].PART_PAY);
					tot_lect_pay1 += nullChkZero(result.list[i].SUM_PAY);
					tot_lect_pay2 += nullChkZero(result.list[i].PRE_PAY);
					tot_lect_pay3 += nullChkZero(result.list[i].NOW_PAY);
					tot_lect_pay4 += nullChkZero(result.list[i].TOT_PAY);
					tot_lect_pay5 += nullChkZero(remain_pay);
					
					inner += '<tr>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].LECTURER_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].BMD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].FOOD_AMT))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].JUNGWON))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].NORMAL_PAY))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].PART_PAY))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].SUM_PAY))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].PRE_PAY))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].NOW_PAY))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_PAY))+'</td>';
					inner += '	<td>'+comma(nullChkZero(remain_pay))+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].FOOD_YMD))+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="13"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target").html(inner);
			getListEnd();
			$("#tot_payment").html(comma(tot_payment));
			$("#tot_part").html(comma(tot_part));
			$("#tot_lect_pay1").html(comma(tot_lect_pay1));
			$("#tot_lect_pay2").html(comma(tot_lect_pay2));
			$("#tot_lect_pay3").html(comma(tot_lect_pay3));
			$("#tot_lect_pay4").html(comma(tot_lect_pay4));
			$("#tot_lect_pay5").html(comma(tot_lect_pay5));
		}
	});	
}


</script>

<div class="sub-tit">
	<h2>재료비 마감내역</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
<!-- 	<div class="btn-right"> -->
<!-- 		<a class="btn btn01 btn01_1" href="/lecture/lect/attend">출석부 관리 </a> -->
<!-- 	</div> -->
</div>
<div class="table-top table-top02">
	<div class="table sear-wr">
		<div class="wid-3">
			<div class="table">
				<div class="wid-35" style="width:100% !important">
					<div class="table table02 table-input wid-contop">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-4">
			<div class="table">
				<div class="search-wr sel100">
				    <input type="text" class="inp-100" id="search_name" name="search_name" onkeypress="excuteEnter(getList)" placeholder="강좌명 / 강사명 / 코드번호가 검색됩니다.">
				    <input class="search-btn" type="button" value="검색" onclick="getList()">
				</div>
			</div>
		</div>
<!-- 		<div class="wid-15"> -->
<!-- 			<div class="table table-90"> -->
<!-- 				<div class="sear-tit sear-tit-70">대분류</div> -->
<!-- 				<div class="oddn-sel"> -->
<!-- 					<select de-data="전체" id="main_cd" name="main_cd" data-name="대분류" onchange="selMaincd(this)"> -->
<!-- 						<option value="">전체</option> -->
<%-- 						<c:forEach var="j" items="${maincdList}" varStatus="loop"> --%>
<%-- 							<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-15"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">중분류</div> -->
<!-- 				<div class="oddn-sel"> -->
<!-- 					<select de-data="전체" id="sect_cd" name="sect_cd" onchange=""> -->
<!-- 						<option value="">전체</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
		<div class="">
			<div class="table">
				<div class="sear-tit sear-tit_left">대상연월</div>
				<div class="oddn-sel">
					<ul class="chk-ul" id="ul_radio">
							
					</ul>
				</div>
			</div>
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>
<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
	</div>
</div>
<div class="table-wr ip-list">
	
	<div class="table-list">
		<table id="excelTable">			
			<colgroup>
				<col width="40px">
				<col />
				<col />
				<col />
				<col  width="250px">
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th>생년월일</th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비 <img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_jungwon')">회원수 <img src="/img/th_up.png" id="sort_jungwon"></th>
					<th onclick="reSortAjax('sort_normal_pay')">정상입금 <img src="/img/th_up.png" id="sort_normal_pay"></th>
					<th onclick="reSortAjax('sort_part_pay')">부분입금 <img src="/img/th_up.png" id="sort_part_pay"></th>
					<th onclick="reSortAjax('sort_sum_pay')">총지급예정액 <img src="/img/th_up.png" id="sort_sum_pay"></th>
					<th onclick="reSortAjax('sort_pre_pay')">기지급액 <img src="/img/th_up.png" id="sort_pre_pay"></th>
					<th onclick="reSortAjax('sort_now_pay')">현지급액 <img src="/img/th_up.png" id="sort_now_pay"></th>
					<th onclick="reSortAjax('sort_tot_pay')">총지급액 <img src="/img/th_up.png" id="sort_tot_pay"></th>
					<th onclick="reSortAjax('sort_remain_pay')">잔고 <img src="/img/th_up.png" id="sort_remain_pay"></th>
					<th onclick="reSortAjax('sort_food_ymd')">지급일 <img src="/img/th_up.png" id="sort_food_ymd"></th>
				</tr>
			</thead>
			<tbody id="list_target">
			</tbody>
		</table>
	</div>
</div>

<div class="sta-botfix sta-botfix06">
	<ul>
		<li style="width:48%"class="li01">총 계</li>
		<li style="width:6%" id="tot_payment" class="li03">0</li>
		<li style="width:6%" id="tot_part" class="li03">0</li>
		<li style="width:6%" id="tot_lect_pay1" class="li02">0</li>
		<li style="width:6%" id="tot_lect_pay2" class="li02">0</li>
		<li style="width:6%" id="tot_lect_pay3" class="li02">0</li>
		<li style="width:6%" id="tot_lect_pay4" class="li02">0</li>
		<li style="width:6%" id="tot_lect_pay5" class="li02">0</li>
		<li style="width:6%" id="" class="li02"></li>
	</ul>
</div>

<script>
$(document).ready(function() {
	getPayMonth('food');
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
	setPeri();
	fncPeri();
	selPeri();
	getList();
});

</script>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>