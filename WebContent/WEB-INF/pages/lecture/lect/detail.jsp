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
	var filename = "강좌별 매출 상세 현황";
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
	 			$("#start_ymd").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#end_ymd").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}
var tot_uprice = 0;
var tot_regis_fee = 0;
var tot_enuri_amt = 0;
var tot_food_fee = 0;
function getList(paging_type) 
{
	getListStart();
	tot_uprice = 0;
	tot_regis_fee = 0;
	tot_enuri_amt = 0;
	tot_food_fee = 0;
	subject_fg = "";
	if($("#subject_fg1").is(":checked"))
	{
		subject_fg += ',\'1\'';
	}
	if($("#subject_fg2").is(":checked"))
	{
		subject_fg += ',\'2\'';
	}
	if($("#subject_fg3").is(":checked"))
	{
		subject_fg += ',\'3\'';
	}
	if(subject_fg != "")
	{
		subject_fg = subject_fg.substring(1, subject_fg.length);
	}
	
	$.ajax({
		type : "POST", 
		url : "./getLectPay",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			search_name : $("#search_name").val(),
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			start_ymd : $("#start_ymd").val(),
			end_ymd : $("#end_ymd").val(),
			
			subject_fg : subject_fg,
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
			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
			var inner = "";
			
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					if(result.list[i].IS_PART == "Y")
					{
						inner += '<tr class="bg-blue">'
					}
					else
					{
						inner += '<tr>';
					}
					inner += '	<td>'+cutDate(result.list[i].SALE_YMD)+'</td>';
					inner += '	<td>'+result.list[i].POS_NO+'</td>';
					inner += '	<td>'+result.list[i].RECPT_NO+'</td>';
					inner += '	<td>'+cutDate(result.list[i].BIRTH_YMD)+'</td>';
					inner += '	<td>'+result.list[i].CUS_NO+'</td>';
					inner += '	<td>'+result.list[i].PERIOD+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
// 					inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
// 					inner += '	<td>'+result.list[i].SECT_NM+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
					if(result.list[i].IS_PART == "Y")
					{
						inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">(부분입금)'+result.list[i].SUBJECT_NM+'</td>';
					}
					else
					{
						inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
					}
					inner += '	<td>'+cutDate(result.list[i].START_YMD)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].END_YMD)+'</td>';
					inner += '	<td>'+comma(result.list[i].UPRICE)+'</td>';
					inner += '	<td>'+comma(result.list[i].REGIS_FEE)+'</td>';
// 					inner += '	<td>'+nullChk(result.list[i].ENURI_NM1)+' '+nullChk(result.list[i].ENURI_NM2)+'</td>';
					inner += '	<td>'+comma(result.list[i].ENURI_AMT)+'</td>';
					inner += '	<td>'+comma(result.list[i].FOOD_FEE)+'</td>';
					inner += '</tr>';
					tot_uprice += Number(nullChkZero(result.list[i].UPRICE));
					tot_regis_fee += Number(nullChkZero(result.list[i].REGIS_FEE));
					tot_enuri_amt += Number(nullChkZero(result.list[i].ENURI_AMT));
					tot_food_fee += Number(nullChkZero(result.list[i].FOOD_FEE));
				}
// 				inner += '<tr>';
// 				inner += '	<td colspan="13">합계</td>';
// 				inner += '	<td>'+comma(tot_uprice)+'</td>';
// 				inner += '	<td>'+comma(tot_regis_fee)+'</td>';
// 				inner += '	<td>'+comma(tot_enuri_amt)+'</td>';
// 				inner += '	<td>'+comma(tot_food_fee)+'</td>';
// 				inner += '</tr>';
				$("#tot_uprice").html(comma(nullChkZero(tot_uprice)));
				$("#tot_regis_fee").html(comma(nullChkZero(tot_regis_fee)));
				$("#tot_enuri_amt").html(comma(nullChkZero(tot_enuri_amt)));
				$("#tot_food_fee").html(comma(nullChkZero(tot_food_fee)));
				
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="17"><div class="no-data">검색결과가 없습니다.</div></td>';
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
</script>
<div class="sub-tit">
	<h2>강좌별 매출 상세 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-10">
			<div class="table">
				<div class="wid-45">
					<div class="table table-auto">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel02">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
	</div>
	<div class="top-row">
		<div class="wid-4">
			<div class="cal-row cal-row_inline cal-row02 table">
				<div class="cal-input wid-4">
					<input type="text" class="date-i start-i" id="start_ymd" name="start_ymd"/>
					<i class="material-icons">event_available</i>
				</div>
				<div class="cal-dash">-</div>
				<div class="cal-input wid-4">
					<input type="text" class="date-i ready-i" id="end_ymd" name="end_ymd"/>
					<i class="material-icons">event_available</i>
				</div>
			</div>
		</div>
		
		<div class="wid-3 mag-lr2">
			<div class="table">
				<div class="sear-tit">강의유형</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="subject_fg1" name="subject_fg1" checked>
							<label for="subject_fg1">정규</label>
						</li>
						<li>
							<input type="checkbox" id="subject_fg2" name="subject_fg2" checked>
							<label for="subject_fg2">단기</label>
						</li>
						<li>
							<input type="checkbox" id="subject_fg3" name="subject_fg3" checked>
							<label for="subject_fg3">특강</label>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="wid-3 wid-rt02">
			<div class="table">
				<div class="sear-tit sear-tit-150">임시 중분류 포함</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="isPerformance" name="isPerformance">
							<label for="isPerformance"></label>
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
					<option value="7000">7000개 보기</option>
					<option value="15000">15000개 보기</option>
				</select>
			</div>
		</div>
	</div>
</div>
<div class="table-wr ip-list">
	<div class="thead-box">
		<table>
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="40px">
				<col width="40px">
<%-- 				<col width=""> --%>
<%-- 				<col width="8%"> --%>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_sale_ymd')">매출일<img src="/img/th_up.png" id="sort_sale_ymd"></th>
					<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
					<th onclick="reSortAjax('sort_recpt_no')">일련번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_period')">기수<img src="/img/th_up.png" id="sort_period"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
<!-- 					<th onclick="reSortAjax('sort_main_nm')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th> -->
<!-- 					<th onclick="reSortAjax('sort_sect_nm')">중분류<img src="/img/th_up.png" id="sort_sect_nm"></th> -->
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ym')">종료일<img src="/img/th_up.png" id="sort_end_ym"></th>
					<th onclick="reSortAjax('sort_uprice')">순매출금액<img src="/img/th_up.png" id="sort_uprice"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_enuri_amt')">할인금액<img src="/img/th_up.png" id="sort_enuri_amt"></th>
					<th onclick="reSortAjax('sort_food_fee')">재료비<img src="/img/th_up.png" id="sort_food_fee"></th>		
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="40px">
				<col width="40px">
<%-- 				<col width=""> --%>
<%-- 				<col width="8%"> --%>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_sale_ymd')">매출일<img src="/img/th_up.png" id="sort_sale_ymd"></th>
					<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
					<th onclick="reSortAjax('sort_recpt_no')">일련번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_period')">기수<img src="/img/th_up.png" id="sort_period"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
<!-- 					<th onclick="reSortAjax('sort_main_nm')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th> -->
<!-- 					<th onclick="reSortAjax('sort_sect_nm')">중분류<img src="/img/th_up.png" id="sort_sect_nm"></th> -->
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ym')">종료일<img src="/img/th_up.png" id="sort_end_ym"></th>
					<th onclick="reSortAjax('sort_uprice')">순매출금액<img src="/img/th_up.png" id="sort_uprice"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_enuri_amt')">할인금액<img src="/img/th_up.png" id="sort_enuri_amt"></th>
					<th onclick="reSortAjax('sort_food_fee')">재료비<img src="/img/th_up.png" id="sort_food_fee"></th>		
				</tr>
			</thead>
			<tbody id="list_target">
<!-- 				<tr> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>070001</td> -->
<!-- 					<td>87544301</td> -->
<!-- 					<td>12345689</td> -->
<!-- 					<td>052</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/listed" style="cursor:pointer;">일요 밸런스 요가</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>95,500</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td>기간할인(5%)</td> -->
<!-- 					<td>4,500</td> -->
<!-- 					<td>30,000</td> -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>
<div class="sta-botfix sta-botfix08">
	<ul>
		<li class="li01">총 계</li>
		<li id="tot_uprice" class="li02">374,550,000</li>
		<li id="tot_regis_fee" class="li02">1,225,000</li>
		<li id="tot_enuri_amt" class="li02">0</li>
		<li id="tot_food_fee" class="li02">0</li>
	</ul>
</div>
<script>


$(document).ready(function() {
	setPeri();
	fncPeri();
	selPeri();
	getList();
});
</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>