<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker_month.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown1()
{
	var filename = "지급리스트";
	var table = "excelTable1";
    exportExcel(filename, table);
}
function excelDown2()
{
	var filename = "지급제외 리스트";
	var table = "excelTable2";
    exportExcel(filename, table);
}
$(function(){
	$(".listSize").parent().addClass("listSize-box");
	$(".listSize2").parent().addClass("listSize-box");
})

var scr_stat = getCookie("scr_stat");
var page = 1;
var order_by = "";
var sort_type = "";
var m_page = 1;
var m_order_by = "";
var m_sort_type = "";
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
	checkInit();
}
$(document).ready(function(){
	setPeri();
	fncPeri();
});
function checkInit()
{
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
	$("#chk_all2").change(function() {
		if($("input:checkbox[name='chk_all2']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all2").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all2").val()+"']").prop("checked", false);
		}
	});
}
function getPaymentCheckAll()
{
	page = 1;
	order_by = "";
	sort_type = "";
	m_page = 1;
	m_order_by = "";
	m_sort_type = "";
	getPaymentCheck(1);
	getPaymentCheck(2);
}
function periInit()
{
	getPayMonth('regis');
}
var corp_fg = "";
function getPaymentCheck(val, paging_type)
{
	if(val == 1)
	{
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getPaymentCheck",
			dataType : "text",
			data : 
			{
				page : page,
				order_by : order_by,
				sort_type : sort_type,
				listSize : $("#listSize").val(),
				
				lect_ym : $("input[name='lect_ym']:checked").val(),
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				corp_fg : $("#corp_fg").val(),
				subject_fg : $("#subject_fg").val(),
				submit_yn : $("#submit_yn").val(),
// 				end_yn : $("#end_yn").val(),
// 				journal_yn : $('input[name="journal_yn"]:checked').val(),
				act : 'Y' //지급제외여부
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				$(".cap-numb").eq(0).html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
				if(result.isSuc != "success")
				{
					alert(result.msg);
					getListEnd();
					return;
				}
				var inner = "";
				
				corp_fg = $("#corp_fg").val();
				if($("#corp_fg").val() == "1") //법인강사
				{
					var trInner = "";
					trInner += '<th><input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label></th>';
					trInner += '<th>No</th>';
					trInner += '<th onclick="reSortAjax(\'sort_main_nm\')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_subject_fg\')">강좌<br>유형<img src="/img/th_up.png" id="sort_subject_fg"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_lect_cnt\')">횟수<img src="/img/th_up.png" id="sort_lect_cnt"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_start_ymd\')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_end_ymd\')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_subject_cd\')">강좌<br>코드<img src="/img/th_up.png" id="sort_subject_cd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_subject_nm\')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_co_nm\')">법인명<img src="/img/th_up.png" id="sort_co_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_web_lecturer_nm\')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_bmd\')">생년<br>월일<img src="/img/th_up.png" id="sort_bmd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_bank_nm\')">거래<br>은행<img src="/img/th_up.png" id="sort_bank_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_account_no\')">계좌<br>번호<img src="/img/th_up.png" id="sort_account_no"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_fix_pay_yn\')">지급<br>구분<img src="/img/th_up.png" id="sort_fix_pay_yn"></th>';
					trInner += '<th>지급기준</th>';
					trInner += '<th onclick="reSortAjax(\'sort_regis_fee\')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_regis_no\')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_part_regis_amt\')">부분<br>입금액<img src="/img/th_up.png" id="sort_part_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_tot_enuri_amt\')">총<br>할인금액<img src="/img/th_up.png" id="sort_tot_enuri_amt"></th>';
					trInner += '<th>비보존<br>할인</th>';
					trInner += '<th onclick="reSortAjax(\'sort_tot_regis_amt\')">총<br>수강료<img src="/img/th_up.png" id="sort_tot_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_pay_day\')">지급일<img src="/img/th_up.png" id="sort_pay_day"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_submit_yn\')">마감<br>여부<img src="/img/th_up.png" id="sort_submit_yn"></th>';
					$(".tr_target1").html(trInner);
					
					
					var colInner = "";
					for(var i = 0; i < 24; i++)
					{
						if(i < 2){
							colInner += '		<col width="30px">';							
						}else if(i == 5){
							colInner += '		<col width="80px">';							
						}else if(i == 6){
							colInner += '		<col width="80px">';							
						}else if(i == 8){
							colInner += '		<col width="250px">';			
						}else if(i == 23){
							colInner += '		<col width="80px">';			
						}else{
							colInner += '		<col />';							
						}
					}
					$("#col_target1").html(colInner);
					
					var divInner = "";
					divInner += '<table>';
					divInner += '	<colgroup>';
					divInner += colInner;
					divInner += '	</colgroup>';
					divInner += '	<thead>';
					divInner += '		<tr>';
					divInner += trInner;
					divInner += '		</tr>';
					divInner += '	</thead>';
					divInner += '</table>';
					$("#div_target1").html(divInner);
					
					if(result.list.length > 0)
					{
						for(var i = 0; i < result.list.length; i++)
						{
							if(result.list[i].END_YN == "Y")
							{
								inner += '<tr class="bg-red" id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'">';
							}
							else
							{
								inner += '<tr id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'">';
							}
							console.log(result.list[i].BMD);
							inner += '	<td><input type="checkbox" id="chk_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'" name="chk_val" value=""><label for="chk_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'"></label></td>';
							inner += '	<td>'+result.list[i].RNUM+'</td>';
							inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
							inner += '	<td>'+result.list[i].LECT_CNT+'</td>';
							inner += '	<td>'+cutDate(result.list[i].START_YMD)+'</td>';
							inner += '	<td>'+cutDate(result.list[i].END_YMD)+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].CO_NM+'</td>';
							inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
							inner += '	<td>'+cutDate(nullChk(result.list[i].BMD))+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							if(result.list[i].FIX_PAY_YN == "정액")
							{
								inner += '	<td>'+comma(result.list[i].FIX_AMT)+'</td>';
							}
							else
							{
								inner += '	<td>'+result.list[i].FIX_RATE+'</td>';
							}
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE))+'</td>';
							inner += '	<td>'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].PART_REGIS_AMT))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_ENURI_AMT))+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE) * Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)) - nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>'; 
// 								inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT) + )+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>'; //봄학기 우선처리 20210512 뮤자인
							inner += '	<td>'+cutDate(nullChk(result.pay_day2))+'</td>';
							inner += '	<td>'+result.list[i].SUBMIT_YN+'</td>';
							inner += '</tr>';
						}
					}
					else
					{
// 						inner += '<tr>';
// 						inner += '	<td colspan="22"><div class="no-data">검색결과가 없습니다.</div></td>';
// 						inner += '</tr>';
					}
				}
				else //개인강사
				{
					var trInner = "";
					trInner += '<th><input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label></th>';
					trInner += '<th>No</th>';
					trInner += '<th onclick="reSortAjax(\'sort_main_nm\')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_subject_fg\')">강좌<br>유형<img src="/img/th_up.png" id="sort_subject_fg"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_lect_cnt\')">횟수<img src="/img/th_up.png" id="sort_lect_cnt"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_start_ymd\')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_end_ymd\')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_subject_cd\')">강좌<br>코드<img src="/img/th_up.png" id="sort_subject_cd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_subject_nm\')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_web_lecturer_nm\')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_bmd\')">생년<br>월일<img src="/img/th_up.png" id="sort_bmd"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_bank_nm\')">거<br>래은행<img src="/img/th_up.png" id="sort_bank_nm"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_account_no\')">계좌<br>번호<img src="/img/th_up.png" id="sort_account_no"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_fix_pay_yn\')">지급<br>구분<img src="/img/th_up.png" id="sort_fix_pay_yn"></th>';
					trInner += '<th>지급<br>기준</th>';
					trInner += '<th onclick="reSortAjax(\'sort_regis_fee\')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_regis_no\')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_part_regis_amt\')">부분<br>입금액<img src="/img/th_up.png" id="sort_part_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_tot_enuri_amt\')">총<br>할인금액<img src="/img/th_up.png" id="sort_tot_enuri_amt"></th>';
					trInner += '<th>비보존할인</th>';
					trInner += '<th onclick="reSortAjax(\'sort_tot_regis_amt\')">총<br>수강료<img src="/img/th_up.png" id="sort_tot_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_pay_day\')">지급일<img src="/img/th_up.png" id="sort_pay_day"></th>';
					trInner += '<th onclick="reSortAjax(\'sort_journal_yn\')">마감<br>여부<img src="/img/th_up.png" id="sort_journal_yn"></th>';
					$(".tr_target1").html(trInner);
					
					var colInner = "";
					for(var i = 0; i < 23; i++)
					{
						if(i < 2){
							colInner += '		<col width="30px">';							
						}else if(i == 5){
							colInner += '		<col width="80px">';							
						}else if(i == 6){
							colInner += '		<col width="80px">';							
						}else if(i == 8){
							colInner += '		<col width="250px">';			
						}else if(i == 23){
							colInner += '		<col width="80px">';			
						}else{
							colInner += '		<col />';							
						}
					}
					$("#col_target1").html(colInner);
					
					
					var divInner = "";
					divInner += '<table>';
					divInner += '	<colgroup>';
					divInner += colInner;
					divInner += '	</colgroup>';
					divInner += '	<thead>';
					divInner += '		<tr>';
					divInner += trInner;
					divInner += '		</tr>';
					divInner += '	</thead>';
					divInner += '</table>';
					$("#div_target1").html(divInner);
					
					if(result.list.length > 0)
					{
						for(var i = 0; i < result.list.length; i++)
						{
							if(result.list[i].END_YN == "Y")
							{
								inner += '<tr class="bg-red" id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
							}
							else
							{
								inner += '<tr id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
							}	
							inner += '	<td><input type="checkbox" id="chk_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'" name="chk_val" value=""><label for="chk_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'"></label></td>';
							inner += '	<td>'+result.list[i].RNUM+'</td>';
							inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
							inner += '	<td>'+result.list[i].LECT_CNT+'</td>';
							inner += '	<td>'+cutDate(result.list[i].START_YMD)+'</td>';
							inner += '	<td>'+cutDate(result.list[i].END_YMD)+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
							inner += '	<td>'+result.list[i].BIRTH_YMD+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							if(result.list[i].FIX_PAY_YN == "정액")
							{
								inner += '	<td>'+comma(result.list[i].FIX_AMT)+'</td>';
							}
							else
							{
								inner += '	<td>'+result.list[i].FIX_RATE+'</td>';
							}
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE))+'</td>';
							inner += '	<td>'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].PART_REGIS_AMT))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_ENURI_AMT))+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE) * Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)) - nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>';
// 								inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT) + )+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>'; //봄학기 우선처리 20210512 뮤자인
							inner += '	<td>'+cutDate(nullChk(result.pay_day2))+'</td>';
							inner += '	<td>'+result.list[i].SUBMIT_YN+'</td>';
							inner += '</tr>';
						}
					}
					else
					{
// 						inner += '<tr>';
// 						inner += '	<td colspan="21"><div class="no-data">검색결과가 없습니다.</div></td>';
// 						inner += '</tr>';
					}
				}
				order_by = result.order_by;
				sort_type = result.sort_type;
				search_name = result.search_name;
				if(paging_type == "scroll")
				{
					if(result.list.length > 0)
					{
						$(".list1").append(inner);
					}
				}
				else
				{
					$(".list1").html(inner);
				}
				$(".paging1").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
				getListEnd();
			}
		});	
	}
	else
	{
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getPaymentCheck",
			dataType : "text",
			data : 
			{
				page : m_page,
				order_by : m_order_by,
				sort_type : m_sort_type,
				listSize : $("#listSize2").val(),
				
				lect_ym : $("input[name='lect_ym']:checked").val(),
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				corp_fg : $("#corp_fg").val(),
				subject_fg : $("#subject_fg").val(),
				submit_yn : $("#submit_yn").val(),
// 				end_yn : $("#end_yn").val(),
// 				journal_yn : $('input[name="journal_yn"]:checked').val(),
				act : 'N' //지급제외여부
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				$(".cap-numb").eq(1).html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
				if(result.isSuc != "success")
				{
					getListEnd();
					return;
				}
				var inner = "";
				
				if($("#corp_fg").val() == "1") //법인강사
				{
					var trInner = "";
					trInner += '<th><input type="checkbox" id="chk_all2" name="chk_all2" value="chk_val2"><label for="chk_all2"></label></th>';
					trInner += '<th>No</th>';
					trInner += '<th onclick="reSortAjax2(\'sort_main_nm\')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_subject_fg\')">강좌<br>유형<img src="/img/th_up.png" id="sort_subject_fg"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_lect_cnt\')">횟수<img src="/img/th_up.png" id="sort_lect_cnt"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_start_ymd\')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_end_ymd\')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_subject_cd\')">강좌<br>코드<img src="/img/th_up.png" id="sort_subject_cd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_subject_nm\')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_co_nm\')">법인명<img src="/img/th_up.png" id="sort_co_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_web_lecturer_nm\')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_bmd\')">생년<br>월일<img src="/img/th_up.png" id="sort_bmd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_bank_nm\')">거래<br>은행<img src="/img/th_up.png" id="sort_bank_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_account_no\')">계좌<br>번호<img src="/img/th_up.png" id="sort_account_no"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_fix_pay_yn\')">지급<br>구분<img src="/img/th_up.png" id="sort_fix_pay_yn"></th>';
					trInner += '<th>지급<br>기준</th>';
					trInner += '<th onclick="reSortAjax2(\'sort_regis_fee\')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_regis_no\')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_part_regis_amt\')">부분<br>입금액<img src="/img/th_up.png" id="sort_part_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_tot_enuri_amt\')">총<br>할인금액<img src="/img/th_up.png" id="sort_tot_enuri_amt"></th>';
					trInner += '<th>비보존<br>할인</th>';
					trInner += '<th onclick="reSortAjax2(\'sort_tot_regis_amt\')">총<br>수강료<img src="/img/th_up.png" id="sort_tot_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_pay_day\')">지급일<img src="/img/th_up.png" id="sort_pay_day"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_submit_yn\')">마감<br>여부<img src="/img/th_up.png" id="sort_submit_yn"></th>';
					$(".tr_target2").html(trInner);
					
					var colInner = "";
					for(var i = 0; i < 24; i++)
					{
						if(i < 2){
							colInner += '		<col width="30px">';							
						}else if(i == 5){
							colInner += '		<col width="80px">';							
						}else if(i == 6){
							colInner += '		<col width="80px">';							
						}else if(i == 8){
							colInner += '		<col width="250px">';			
						}else if(i == 23){
							colInner += '		<col width="80px">';			
						}else{
							colInner += '		<col />';							
						}
					}
					$("#col_target2").html(colInner);
					
					var divInner = "";
					divInner += '<table>';
					divInner += '	<colgroup>';
					divInner += colInner;
					divInner += '	</colgroup>';
					divInner += '	<thead>';
					divInner += '		<tr>';
					divInner += trInner;
					divInner += '		</tr>';
					divInner += '	</thead>';
					divInner += '</table>';
					$("#div_target2").html(divInner);
					if(result.list.length > 0)
					{
						for(var i = 0; i < result.list.length; i++)
						{
							if(result.list[i].END_YN == "Y")
							{
								inner += '<tr class="bg-red" id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'">';
							}
							else
							{
								inner += '<tr id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'">';
							}
							inner += '	<td><input type="checkbox" id="chk2_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'" name="chk_val2" value=""><label for="chk2_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].ACCEPT_YN+'"></label></td>';
							inner += '	<td>'+result.list[i].RNUM+'</td>';
							inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
							inner += '	<td>'+result.list[i].LECT_CNT+'</td>';
							inner += '	<td>'+cutDate(result.list[i].START_YMD)+'</td>';
							inner += '	<td>'+cutDate(result.list[i].END_YMD)+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].CO_NM+'</td>';
							inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
							inner += '	<td>'+cutDate(nullChk(result.list[i].BMD))+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							if(result.list[i].FIX_PAY_YN == "정액")
							{
								inner += '	<td>'+comma(result.list[i].FIX_AMT)+'</td>';
							}
							else
							{
								inner += '	<td>'+result.list[i].FIX_RATE+'</td>';
							}
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE))+'</td>';
							inner += '	<td>'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].PART_REGIS_AMT))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_ENURI_AMT))+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE) * Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)) - nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>';
// 								inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT) + )+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>'; //봄학기 우선처리 20210512 뮤자인
							inner += '	<td>'+cutDate(nullChk(result.pay_day2))+'</td>';
							inner += '	<td>'+result.list[i].SUBMIT_YN+'</td>';
							inner += '</tr>';
						}
					}
					else
					{
// 						inner += '<tr>';
// 						inner += '	<td colspan="22"><div class="no-data">검색결과가 없습니다.</div></td>';
// 						inner += '</tr>';
					}
				}
				else //개인강사
				{
					var trInner = "";
					trInner += '<th><input type="checkbox" id="chk_all2" name="chk_all2" value="chk_val2"><label for="chk_all2"></label></th>';
					trInner += '<th>No</th>';
					trInner += '<th onclick="reSortAjax2(\'sort_main_nm\')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_subject_fg\')">강좌<br>유형<img src="/img/th_up.png" id="sort_subject_fg"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_lect_cnt\')">횟수<img src="/img/th_up.png" id="sort_lect_cnt"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_start_ymd\')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_end_ymd\')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_subject_cd\')">강좌<br>코드<img src="/img/th_up.png" id="sort_subject_cd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_subject_nm\')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_web_lecturer_nm\')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_bmd\')">생년<br>월일<img src="/img/th_up.png" id="sort_bmd"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_bank_nm\')">거래<br>은행<img src="/img/th_up.png" id="sort_bank_nm"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_account_no\')">계좌<br>번호<img src="/img/th_up.png" id="sort_account_no"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_fix_pay_yn\')">지급<br>구분<img src="/img/th_up.png" id="sort_fix_pay_yn"></th>';
					trInner += '<th>지급<br>기준</th>';
					trInner += '<th onclick="reSortAjax2(\'sort_regis_fee\')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_regis_no\')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_part_regis_amt\')">부분<br>입금액<img src="/img/th_up.png" id="sort_part_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_tot_enuri_amt\')">총<br>할인금액<img src="/img/th_up.png" id="sort_tot_enuri_amt"></th>';
					trInner += '<th>비보존<br>할인</th>';
					trInner += '<th onclick="reSortAjax2(\'sort_tot_regis_amt\')">총<br>수강료<img src="/img/th_up.png" id="sort_tot_regis_amt"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_pay_day\')">지급일<img src="/img/th_up.png" id="sort_pay_day"></th>';
					trInner += '<th onclick="reSortAjax2(\'sort_journal_yn\')">마감<br>여부<img src="/img/th_up.png" id="sort_journal_yn"></th>';
					$(".tr_target2").html(trInner);
					
					var colInner = "";
					for(var i = 0; i < 23; i++)
					{
						if(i < 2){
							colInner += '		<col width="30px">';							
						}else if(i == 5){
							colInner += '		<col width="80px">';							
						}else if(i == 6){
							colInner += '		<col width="80px">';							
						}else if(i == 8){
							colInner += '		<col width="250px">';			
						}else if(i == 23){
							colInner += '		<col width="80px">';			
						}else{
							colInner += '		<col />';							
						}
					}
					$("#col_target2").html(colInner);
					
					var divInner = "";
					divInner += '<table>';
					divInner += '	<colgroup>';
					divInner += colInner;
					divInner += '	</colgroup>';
					divInner += '	<thead>';
					divInner += '		<tr>';
					divInner += trInner;
					divInner += '		</tr>';
					divInner += '	</thead>';
					divInner += '</table>';
					$("#div_target2").html(divInner);
					if(result.list.length > 0)
					{
						for(var i = 0; i < result.list.length; i++)
						{
							if(result.list[i].END_YN == "Y")
							{
								inner += '<tr class="bg-red" id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
							}
							else
							{
								inner += '<tr id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
							}
							
							inner += '	<td><input type="checkbox" id="chk2_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'" name="chk_val2" value=""><label for="chk2_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'"></label></td>';
							inner += '	<td>'+result.list[i].RNUM+'</td>';
							inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
							inner += '	<td>'+result.list[i].LECT_CNT+'</td>';
							inner += '	<td>'+cutDate(result.list[i].START_YMD)+'</td>';
							inner += '	<td>'+cutDate(result.list[i].END_YMD)+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
							inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
							inner += '	<td>'+result.list[i].BIRTH_YMD+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							if(result.list[i].FIX_PAY_YN == "정액")
							{
								inner += '	<td>'+comma(result.list[i].FIX_AMT)+'</td>';
							}
							else
							{
								inner += '	<td>'+result.list[i].FIX_RATE+'</td>';
							}
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE))+'</td>';
							inner += '	<td>'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].PART_REGIS_AMT))+'</td>';
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_ENURI_AMT))+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE) * Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)) - nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>';
// 								inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT) + )+'</td>'; 
							inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_REGIS_AMT))+'</td>'; //봄학기 우선처리 20210512 뮤자인
							inner += '	<td>'+cutDate(nullChk(result.pay_day2))+'</td>';
							inner += '	<td>'+result.list[i].SUBMIT_YN+'</td>';
							inner += '</tr>';
						}
					}
					else
					{
// 						inner += '<tr>';
// 						inner += '	<td colspan="21"><div class="no-data">검색결과가 없습니다.</div></td>';
// 						inner += '</tr>';
					}
				}
				m_order_by = result.order_by;
				m_sort_type = result.sort_type;
				m_search_name = result.search_name;
				if(paging_type == "scroll")
				{
					if(result.list.length > 0)
					{
						$(".list2").append(inner);
					}
				}
				else
				{
					$(".list2").html(inner);
				}
				$(".paging2").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 2));
				getListEnd();
			}
		});	
	}
}
function makePaging(nowPage, s_page, e_page, pageNum, val)
{
	if(val == 1)
	{
		page = nowPage;
		var inner = "";
		if(scr_stat == "ON")
		{
			inner += '<div class="page_num" style="display:none;">';
		}
		else
		{
			inner += '<div class="page_num" style="display:block;">';
		}
		if(Number(page) > 5)
		{
			inner += '		<a onclick="javascript:pageMoveAjax(1);"> ◀◀ </a>';
			inner += '    	<a onclick="javascript:pageMoveAjax('+(Number(s_page)-1)+');"> ◀ </a>';
		}
		var pagingCnt = 0;
		if(e_page != '0')
		{
			for(var i = Number(s_page); i <= Number(e_page); i++)
			{
				pagingCnt ++;
				if(i == page)
				{
					inner += '			<a onclick="javascript:pageMoveAjax('+i+');" id="p_'+i+'" class="p_btn active">'+i+'</a>';
				}
				else
				{
					inner += '			<a onclick="javascript:pageMoveAjax('+i+');" id="p_'+i+'" class="p_btn">'+i+'</a>';
				}
			}
		}
		if(e_page == '0')
		{
			inner += '		 <a onclick="javascript:pageMoveAjax(1);">1</a>';
		}
		if(pageNum != page)
		{
			if(Number(pageNum) > 5)
			{
				if(pagingCnt > 4)
				{
					if(Number(e_page)+1 > Number(pageNum))
					{
						inner += '            		<a onclick="javascript:pageMoveAjax('+pageNum+');"> ▶ </a>'; 
						inner += '            		<a onclick="javascript:pageMoveAjax('+pageNum+');"> ▶▶ </a>'; 
					}
					else
					{
						inner += '					<a onclick="javascript:pageMoveAjax('+(Number(e_page)+1)+');"> ▶ </a>';
						inner += '            		<a onclick="javascript:pageMoveAjax('+pageNum+');"> ▶▶ </a>'; 
					}
				}
			}
		}
		inner += '</div>';
		return inner;
	}
	else
	{
		m_page = nowPage;
		var inner = "";
		if(scr_stat == "ON")
		{
			inner += '<div class="page_num" style="display:none;">';
		}
		else
		{
			inner += '<div class="page_num" style="display:block;">';
		}
		if(Number(m_page) > 5)
		{
			inner += '		<a onclick="javascript:pageMoveAjax2(1);"> ◀◀ </a>';
			inner += '    	<a onclick="javascript:pageMoveAjax2('+(Number(s_page)-1)+');"> ◀ </a>';
		}
		var pagingCnt = 0;
		if(e_page != '0')
		{
			for(var i = Number(s_page); i <= Number(e_page); i++)
			{
				pagingCnt ++;
				if(i == m_page)
				{
					inner += '			<a onclick="javascript:pageMoveAjax2('+i+');" id="p_'+i+'" class="p_btn active">'+i+'</a>';
				}
				else
				{
					inner += '			<a onclick="javascript:pageMoveAjax2('+i+');" id="p_'+i+'" class="p_btn">'+i+'</a>';
				}
			}
		}
		if(e_page == '0')
		{
			inner += '		 <a onclick="javascript:pageMoveAjax2(1);">1</a>';
		}
		if(pageNum != m_page)
		{
			if(Number(pageNum) > 5)
			{
				if(pagingCnt > 4)
				{
					if(Number(e_page)+1 > Number(pageNum))
					{
						inner += '            		<a onclick="javascript:pageMoveAjax2('+pageNum+');"> ▶ </a>'; 
						inner += '            		<a onclick="javascript:pageMoveAjax2('+pageNum+');"> ▶▶ </a>'; 
					}
					else
					{
						inner += '					<a onclick="javascript:pageMoveAjax2('+(Number(e_page)+1)+');"> ▶ </a>';
						inner += '            		<a onclick="javascript:pageMoveAjax2('+pageNum+');"> ▶▶ </a>'; 
					}
				}
			}
		}
		inner += '</div>';
		return inner;
	}
	thSize();
	isLoading = false;
}
function reSortAjax(act)
{
	if(!isLoading)
	{
		sort_type = act.replace("sort_", "");
		if(order_by == "")
		{
			order_by = "desc";
		}
		else if(order_by == "desc")
		{
			order_by = "asc";
		}
		else if(order_by == "asc")
		{
			order_by = "desc";
		}
		page = 1;
		getPaymentCheck(1);
	}
}
function pageMoveAjax(nowPage)
{
	if(!isLoading)
	{
		page = nowPage;
		getPaymentCheck(1);
	}
}
function reSortAjax2(act)
{
	if(!isLoading)
	{
		m_sort_type = act.replace("sort_", "");
		if(m_order_by == "")
		{
			m_order_by = "desc";
		}
		else if(m_order_by == "desc")
		{
			m_order_by = "asc";
		}
		else if(m_order_by == "asc")
		{
			m_order_by = "desc";
		}
		m_page = 1;
		getPaymentCheck(2);
	}
}
function pageMoveAjax2(nowPage)
{
	if(!isLoading)
	{
		m_page = nowPage;
		getPaymentCheck(2);
	}
}
function pageMoveScroll(nowPage)
{
	page = nowPage;
	getPaymentCheck(1, 'scroll');
}
function pageMoveScroll2(nowPage)
{
	m_page = nowPage;
	getPaymentCheck(2, 'scroll');
}
function jr_action()
{
	var chkList = "";
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).attr("id").replace("chk_", "")+"|";
    	}
	});
	
	$.ajax({
		type : "POST", 
		url : "./saveJr",
		dataType : "text",
		async : false,
		data : 
		{
			chkList : chkList,
			act : $("#jr_act").val(),
			corp_fg : corp_fg,
			lect_ym : $("input[name='lect_ym']:checked").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if(result.isSuc == "success")
			{
				alert("저장되었습니다.");
			}
			else
			{
				alert(result.msg);
			}
		}
	});	
}
function setExcept(act)
{
	var chkList = "";
	if(act == "N")
	{
		$("input:checkbox[name='chk_val']").each(function(){
		    if($(this).is(":checked"))
	    	{
		    	var tr = $(this).attr("id").replace("chk_", "tr_");
		    	var tr_html = '<tr id="'+tr+'">'+$("#"+tr).html().replace(/chk_0/gi, "chk2_0").replace(/chk_val/gi, "chk_val2")+'</tr>';
		    	$("#"+tr).remove();
		    	$(".list2").append(tr_html);
	    	}
		});
	}
	else
	{
		$("input:checkbox[name='chk_val2']").each(function(){
		    if($(this).is(":checked"))
	    	{
		    	var tr = $(this).attr("id").replace("chk2_", "tr_");
		    	var tr_html = '<tr id="'+tr+'">'+$("#"+tr).html().replace(/chk2_0/gi, "chk_0").replace(/chk_val2/gi, "chk_val")+'</tr>';
		    	$("#"+tr).remove();
		    	$(".list1").append(tr_html);
	    	}
		});
	}
	checkInit();
}

</script>

<div class="sub-tit">
	<h2>지급기준 점검</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>


<div class="table-top">
	<div class="top-row sear-wr">
		<div class="table">
			<div class="wid-15">
				<div class="table table-auto">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<div class="oddn-sel sel-scr">
					<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
				</div>
			</div>
			<div class="wid-3">
				<div class="table">
					<div class="sear-tit sear-tit_left">대상연월</div>
					<div>
						<ul class="chk-ul" id="ul_radio">
							
						</ul>
					</div>
				</div>
			</div>
			<div class="wid-15">
				<div class="table">
					<div class="sear-tit sear-tit_left">강사구분</div>
					<div>
						<select id="corp_fg" name="corp_fg" de-data="법인">
							<option value="1">법인</option>
							<option value="2">개인</option>
						</select>
					</div>
				</div>
			</div>
			<div class="wid-15">
				<div class="table">
					<div class="sear-tit sear-tit_left">강좌유형</div>
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
			<div class="wid-15">
				<div class="table">
					<div class="sear-tit sear-tit_left">마감여부</div>
					<div>
						<select id="submit_yn" name="submit_yn" de-data="전체">
							<option value="">전체</option>
							<option value="Y">Y</option>
							<option value="N">N</option>
						</select>
					</div>
				</div>
			</div>
<!-- 			<div class="wid-25"> -->
<!-- 				<div class="table"> -->
<!-- 					<div class="sear-tit  sear-tit_left">상태</div> -->
<!-- 					<div> -->
<!-- 						<select de-data="전체" id="end_yn" name="end_yn"> -->
<!-- 							<option value="">전체</option> -->
<!-- 							<option value="Y">폐강</option> -->
<!-- 							<option value="N">정상</option> -->
<!-- 						</select> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="wid-25"> -->
<!-- 				<div class="table"> -->
<!-- 					<div class="sear-tit">회계전송여부</div> -->
<!-- 					<div> -->
<!-- 						<ul class="chk-ul"> -->
<!-- 							<li> -->
<!-- 								<input type="radio" id="journal_yn1" name="journal_yn" checked="checked" value=""> -->
<!-- 								<label for="journal_yn1">전체</label> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<input type="radio" id="journal_yn2" name="journal_yn" value="Y"> -->
<!-- 								<label for="journal_yn2">전송</label> -->
<!-- 							</li> -->
<!-- 							<li> -->
<!-- 								<input type="radio" id="journal_yn3" name="journal_yn" value="N"> -->
<!-- 								<label for="journal_yn3">미전송</label> -->
<!-- 							</li> -->
<!-- 						</ul> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getPaymentCheckAll()">
</div>


<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="table table02 table-auto float-right sel-scr">
			<div>
				<p class="ip-ritit">선택한 강좌를</p>
			</div>
			<div>
				<select de-data="마감" id="jr_act" name="jr_act">
					<option value="Y">마감</option>
					<option value="N">마감취소</option>
				</select>
				<a class="bor-btn btn03 btn-mar6" onclick="javascript:jr_action();">반영</a>
			</div>
			<div>			
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown1();"><i class="fas fa-file-download"></i></a>
				<select id="listSize" name="listSize" onchange="getPaymentCheck(1)" de-data="10개 보기">
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
<div class="table-wr ">	
	<div class="thead-box" id="div_target1">
	</div>
	<div class="table-list table-csplist table-list-shot scroll1 table-stype01">
		<table id="excelTable1">
			<colgroup id="col_target1">
			</colgroup>
			<thead>
				<tr class="tr_target1">
<!-- 					<th>NO.<i class="material-icons">import_export</i></th> -->
<!-- 					<th>대분류<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강좌유형<i class="material-icons">import_export</i></th> -->
<!-- 					<th>횟수<i class="material-icons">import_export</i></th> -->
<!-- 					<th>시작일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>종료일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강좌코드<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강좌명<i class="material-icons">import_export</i></th> -->
<!-- 					<th>구분<i class="material-icons">import_export</i></th> -->
<!-- 					<th>법인명<i class="material-icons">import_export</i></th> -->
<!-- 					<th>사업자번호<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강사명<i class="material-icons">import_export</i></th> -->
<!-- 					<th>생년월일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>거래은행<i class="material-icons">import_export</i></th> -->
<!-- 					<th>계좌번호<i class="material-icons">import_export</i></th> -->
<!-- 					<th>지급구분<i class="material-icons">import_export</i></th> -->
<!-- 					<th>지급기준<i class="material-icons">import_export</i></th> -->
<!-- 					<th>수장료<i class="material-icons">import_export</i></th> -->
<!-- 					<th>등록인원<i class="material-icons">import_export</i></th> -->
<!-- 					<th>부분입금<i class="material-icons">import_export</i></th> -->
<!-- 					<th>부분입금액<i class="material-icons">import_export</i></th> -->
<!-- 					<th>할인금액<i class="material-icons">import_export</i></th> -->
<!-- 					<th>총수강료<i class="material-icons">import_export</i></th> -->
<!-- 					<th>지급일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>승인일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>결재자<i class="material-icons">import_export</i></th>		 -->
				</tr>
				
			</thead>
			<tbody class="list1">
<!-- 				<tr>					 -->
<!-- 					<td>1</td>	 -->
<!-- 					<td>성인</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김화영</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>921637-01-526312</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>2,500,000</td> -->
<!-- 					<td>2019-11-11</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td>2</td>	 -->
<!-- 					<td>성인</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>주식회사 트니트니</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">안정아</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>921637-01-526312</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>1</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>2,500,000</td> -->
<!-- 					<td>2019-11-11</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
	<div class="paging1">
	</div>
</div>
<div class="text-center move-updo give-wrap">
	<div class="move-arrow">
		<div class="next-btn bor-btn btn01"><i class="material-icons" onclick="setExcept('N')">keyboard_arrow_down</i></div>
		<div class="prev-btn bor-btn btn01"><i class="material-icons" onclick="setExcept('Y')">keyboard_arrow_up</i></div>
	</div>
</div>

<div class="table-cap table">
	<div class="cap-l">
		<h2>지급제외 리스트</h2>
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="table table02 table-auto float-right sel-scr">
			<div>			
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown2();"><i class="fas fa-file-download"></i></a>
				<select id="listSize2" name="listSize2" onchange="getPaymentCheck(2)" de-data="10개 보기">
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
	<div class="thead-box" id="div_target2">
	</div>
	<div class="table-list table-csplist table-list-shot scroll2 table-stype01">
		<table id="excelTable2">
			<colgroup id="col_target2">
			</colgroup>
			<thead>
				<tr class="tr_target2">
<!-- 					<th>NO.<i class="material-icons">import_export</i></th> -->
<!-- 					<th>대분류<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강좌유형<i class="material-icons">import_export</i></th> -->
<!-- 					<th>횟수<i class="material-icons">import_export</i></th> -->
<!-- 					<th>시작일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>종료일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강좌코드<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강좌명<i class="material-icons">import_export</i></th> -->
<!-- 					<th>구분<i class="material-icons">import_export</i></th> -->
<!-- 					<th>법인명<i class="material-icons">import_export</i></th> -->
<!-- 					<th>사업자번호<i class="material-icons">import_export</i></th> -->
<!-- 					<th>강사명<i class="material-icons">import_export</i></th> -->
<!-- 					<th>생년월일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>거래은행<i class="material-icons">import_export</i></th> -->
<!-- 					<th>계좌번호<i class="material-icons">import_export</i></th> -->
<!-- 					<th>지급구분<i class="material-icons">import_export</i></th> -->
<!-- 					<th>지급기준<i class="material-icons">import_export</i></th> -->
<!-- 					<th>수장료<i class="material-icons">import_export</i></th> -->
<!-- 					<th>등록인원<i class="material-icons">import_export</i></th> -->
<!-- 					<th>부분입금<i class="material-icons">import_export</i></th> -->
<!-- 					<th>부분입금액<i class="material-icons">import_export</i></th> -->
<!-- 					<th>할인금액<i class="material-icons">import_export</i></th> -->
<!-- 					<th>총수강료<i class="material-icons">import_export</i></th> -->
<!-- 					<th>지급일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>승인일<i class="material-icons">import_export</i></th> -->
<!-- 					<th>결재자<i class="material-icons">import_export</i></th>		 -->
				</tr>
				
			</thead>
			<tbody class="list2">
<!-- 				<tr>					 -->
<!-- 					<td>1</td>	 -->
<!-- 					<td>성인</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김화영</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>921637-01-526312</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>2,500,000</td> -->
<!-- 					<td>2019-11-11</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td>2</td>	 -->
<!-- 					<td>성인</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>주식회사 트니트니</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">안정아</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>921637-01-526312</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>1</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>2,500,000</td> -->
<!-- 					<td>2019-11-11</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
	<div class="paging2">
	</div>
</div>
<script>
$(document).ready(function(){
	getPayMonth('regis');
	getPaymentCheckAll();
});
$(document).ready(function(){
	if(scr_stat == "ON")
	{
		$(".listSize-box").hide();
		$(".table-list").scroll(function() {
			var scrollTop = $(this).scrollTop();
	        var innerHeight = $(this).innerHeight();
	        var scrollHeight = $(this).prop('scrollHeight');

	        if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)
	        {
	        	if(!isLoading)
	        	{
	        		isLoading = true;
	        		if($(this).hasClass("scroll1"))
	        		{
			        	page = page + 1;
			        	pageMoveScroll(page);
	        		}
	        		else if($(this).hasClass("scroll2"))
	        		{
			        	m_page = m_page + 1;
			        	pageMoveScroll2(m_page);
	        		}
	        	}
	        }
		});
	}
	else
	{
		$(".listSize-box").show();
	}
})
</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>