<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker_month.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>
function excelDown()
{
	var filename = "강사료 지급현황";
	var table = "excelTable";
    exportExcel(filename, table);
}
$(document).ready(function(){
	setPeri();
	fncPeri();
});
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
function periInit()
{
	getPayMonth('regis');
}
function comIncome(val)
{
	var income = Math.floor((Number(val) * 0.03) * 0.1) * 10;
	if(income < 1000)
	{
		income = 0;
	}
	return Number(income);
}
function comResi(val)
{
	var resi = Math.floor(((Number(val) * 0.03) * 0.1) * 0.1) * 10;
	if(comIncome(val) < 1000)
	{
		resi = 0;
	}
	return Number(resi);
}
function comVat(val)
{
	var vat = 0;
	if(vat_fg == "YC")
	{
		vat = Math.floor((Number(val) / 1.1) * 0.1);
	}
	
	return Number(vat);
}
var vat_fg = "";
function getList()
{
	getListStart();
// 	var type = "";
// 	if($("#corp_fg").val() == "1")
// 	{
// 		//법인
// 		if($("#detail_fg").val() == "lect_sort") 
// 		{
//             //강좌별
// 			type = "1";
//         } 
// 		else 
//         {
//             //강사별
// 			type = "2";
//         }
// 	}
// 	else
// 	{
// 		//개인
// 		if($("#detail_fg").val() == "lect_sort") 
// 		{
//             //강좌별
// 			type = "3";
//         } 
// 		else 
//         {
//             //강사별
// 			type = "4";
//         }
// 	}
	$.ajax({
		type : "POST", 
		url : "./getStatusList",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			corp_fg : $("#corp_fg").val(),
			journal_yn : $("#journal_yn").val(),
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
			var inner = "";
			if($("#corp_fg").val() == "1")
			{
				var trInner = "";
				trInner += '<th class="td-no">업체명</th>';
				trInner += '<th class="td-no">사업자번호</th>';
				trInner += '<th class="td-no">강사명</th>';
				trInner += '<th class="td-no">강좌명</th>';
				trInner += '<th class="td-no">현원</th>';
				trInner += '<th class="td-no">총수강료</th>';
				trInner += '<th class="td-no">지급기준</th>'; 
				trInner += '<th class="td-no">총지급액</th>'; 
				trInner += '<th class="td-no">공급가액</th>'; 
				trInner += '<th class="td-no">부가세</th>';
				trInner += '<th class="td-no">지급일</th>';
				trInner += '<th class="td-no">은행명</th>';
				trInner += '<th class="td-no">계좌번호</th>';
				trInner += '<th class="td-no">분개여부</th>';
				$("#tr_target").html(trInner);
				if(result.list.length > 0)
				{
					$("#print_payday").html(cutDate(result.list[0].PAY_DAY));
					var tot_regis_no = 0;
					var tot_regis_fee = 0;
					var tot_lect_pay = 0;
// 					var tot_net_lect_pay = 0;
// 					var tot_vat = 0;
					
					//총계에 쓸것
					var fin_regis_no = 0;
					var fin_regis_fee = 0;
					var fin_lect_pay = 0;
					var fin_net_lect_pay = 0;
					var fin_vat = 0;
					
					var print_lecture = ""; //소계를 구분하기위해
					for(var i = 0; i < result.list.length; i++)
					{
						if(print_lecture != result.list[i].BIZ_NO && i != 0)
						{
							vat_fg = result.list[i-1].VAT_FG;
							//소계 뿌리기
							inner += '<tr class="tr-tfoot">';
							inner += '	<td colspan="4" class="bold">합계</td>';	
							inner += '	<td>'+comma(tot_regis_no)+'</td>';
							inner += '	<td>'+comma(tot_regis_fee)+'</td>';
							inner += '	<td></td>';
							inner += '	<td>'+comma(tot_lect_pay)+'</td>';
							inner += '	<td>'+comma(tot_lect_pay - comVat(tot_lect_pay))+'</td>';
							inner += '	<td>'+comma(comVat(tot_lect_pay))+'</td>';
							inner += '	<td colspan="4"></td>';
							inner += '</tr>';
							fin_net_lect_pay += Number(tot_lect_pay) - comVat(tot_lect_pay);
							fin_vat += comVat(tot_lect_pay);
							tot_regis_no = 0;
							tot_regis_fee = 0;
							tot_lect_pay = 0;
// 							tot_net_lect_pay = 0;
// 							tot_vat = 0;
							//소계 뿌리기
							
							inner += '<tr>';
							inner += '	<td>'+nullChk(result.list[i].BIZ_NM)+'</td>';
							inner += '	<td>'+result.list[i].BIZ_NO+'</td>';
							inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
							inner += '	<td class="print-tit">'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].TOT_REGIS_NO+'</td>';
							inner += '	<td>'+comma(result.list[i].TOT_REGIS_FEE)+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							inner += '	<td class="print-pay">'+comma(result.list[i].LECT_PAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td>'+cutDate(result.list[i].PAY_DAY)+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].JOURNAL_YN+'</td>';
							inner += '</tr>';
						}
						else if(i == 0)
						{
							inner += '<tr>';
							inner += '	<td>'+nullChk(result.list[i].BIZ_NM)+'</td>';
							inner += '	<td>'+result.list[i].BIZ_NO+'</td>';
							inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
							inner += '	<td class="print-tit">'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].TOT_REGIS_NO+'</td>';
							inner += '	<td>'+comma(result.list[i].TOT_REGIS_FEE)+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							inner += '	<td class="print-pay">'+comma(result.list[i].LECT_PAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td>'+cutDate(result.list[i].PAY_DAY)+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].JOURNAL_YN+'</td>';
							inner += '</tr>';
						}
						else
						{
							inner += '<tr>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
							inner += '	<td class="print-tit">'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].TOT_REGIS_NO+'</td>';
							inner += '	<td class="print-pay">'+comma(result.list[i].TOT_REGIS_FEE)+'</td>';
							inner += '	<td class="print-pay">'+result.list[i].FIX_PAY_YN+'</td>';
							inner += '	<td class="print-pay">'+comma(result.list[i].LECT_PAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td>'+cutDate(result.list[i].PAY_DAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '</tr>';
						}
						
						tot_regis_no += Number(result.list[i].TOT_REGIS_NO);
						tot_regis_fee += Number(result.list[i].TOT_REGIS_FEE);
						tot_lect_pay += Number(result.list[i].LECT_PAY);
// 						tot_net_lect_pay += Number(result.list[i].NET_LECT_PAY);
// 						tot_vat += Number(result.list[i].VAT);
						fin_regis_no += Number(result.list[i].TOT_REGIS_NO);
						fin_regis_fee += Number(result.list[i].TOT_REGIS_FEE);
						fin_lect_pay += Number(result.list[i].LECT_PAY);
						
						print_lecture = result.list[i].BIZ_NO;
						
						if(i == result.list.length-1)
						{
							vat_fg = result.list[i].VAT_FG;
							inner += '<tr class="tr-tfoot">';
							inner += '	<td colspan="4" class="bold">합계</td>';	
							inner += '	<td>'+comma(tot_regis_no)+'</td>';
							inner += '	<td>'+comma(tot_regis_fee)+'</td>';
							inner += '	<td></td>';
							inner += '	<td class="print-pay">'+comma(tot_lect_pay)+'</td>';
							inner += '	<td class="print-pay">'+comma(tot_lect_pay - comVat(tot_lect_pay))+'</td>';
							inner += '	<td class="print-pay">'+comma(comVat(tot_lect_pay))+'</td>';
							inner += '	<td colspan="4"></td>';
							inner += '</tr>';
							fin_net_lect_pay += Number(tot_lect_pay) - comVat(tot_lect_pay);
							fin_vat += comVat(tot_lect_pay);
						}
					
					}
					var fin_inner = "";
					fin_inner += '<ul>';
					fin_inner += '	<li class="first">총 '+result.list.length+'건</li>';
					fin_inner += '	<li class="li02">계</li>';
					fin_inner += '	<li class="li03">'+comma(fin_regis_no)+'</li>';
					fin_inner += '	<li class="li04">'+comma(fin_regis_fee)+'</li>';
					fin_inner += '	<li class="li05"></li>';
					fin_inner += '	<li class="li06">'+comma(fin_lect_pay)+'</li>';
					fin_inner += '	<li class="li07">'+comma(fin_net_lect_pay)+'</li>';
					fin_inner += '	<li class="li08">'+comma(fin_vat)+'</li>';
					fin_inner += '	<li class="li09"></li>';
					fin_inner += '	<li class="li09"></li>';
					fin_inner += '</ul>';
					$("#final_div").html(fin_inner);
					
					var fin_inner2 = "";
					fin_inner2 += '<tr class="tr-tfoot">';
					fin_inner2 += '	<td colspan="3">총 '+result.list.length+'건</td>';
					fin_inner2 += '	<td>계</td>';
					fin_inner2 += '	<td>'+comma(fin_regis_no)+'</td>';
					fin_inner2 += '	<td>'+comma(fin_regis_fee)+'</td>';
					fin_inner2 += '	<td></td>';
					fin_inner2 += '	<td class="print-pay">'+comma(fin_lect_pay)+'</td>';
					fin_inner2 += '	<td class="print-pay">'+comma(fin_net_lect_pay)+'</td>';
					fin_inner2 += '	<td class="print-pay">'+comma(fin_vat)+'</td>';
					fin_inner2 += '	<td colspan="4"></td>';
					fin_inner2 += '</tr>';
					$("#list_target2").html(fin_inner2);
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="14"><div class="no-data">검색결과가 없습니다.</div></td>';
					inner += '</tr>';
				}
			}
			else if($("#corp_fg").val() == "2")
			{
				var trInner = "";
				trInner += '<th class="td-no">강사명</th>';
				trInner += '<th class="td-no">고유번호(주민번호)</th>';
				trInner += '<th class="td-no">강좌명</th>';
				trInner += '<th class="td-no">현원</th>';
				trInner += '<th class="td-no">총수강료</th>';
				trInner += '<th class="td-no">지급기준</th>'; 
				trInner += '<th class="td-no">총지급액</th>'; 
				trInner += '<th class="td-no">소득세</th>';
				trInner += '<th class="td-no">주민세</th>';
				trInner += '<th class="td-no">실지급액</th>';
				trInner += '<th class="td-no">지급일</th>';
				trInner += '<th class="td-no">은행명</th>';
				trInner += '<th class="td-no">계좌번호</th>';
				trInner += '<th class="td-no">분개여부</th>';
				$("#tr_target").html(trInner);
				if(result.list.length > 0)
				{
					var tot_regis_no = 0;
					var tot_regis_fee = 0;
					var tot_lect_pay = 0;
					var tot_income_tax = 0;
					var tot_resi_tax = 0;
					var tot_net_lect_pay = 0;
					var fin_regis_no = 0;
					var fin_regis_fee = 0;
					var fin_lect_pay = 0;
					var fin_income_tax = 0;
					var fin_resi_tax = 0;
					var fin_net_lect_pay = 0;
					var print_lecture = ""; //소계를 구분하기위해
					for(var i = 0; i < result.list.length; i++)
					{
						var lecturer_cd = result.list[i].LECTURER_CD.substring(0,6) + "-" + result.list[i].LECTURER_CD.substring(6,7)+"******";
						if(print_lecture != result.list[i].LECTURER_KOR_NM && i != 0)
						{
							//소계 뿌리기
							inner += '<tr class="tr-tfoot">';
							inner += '	<td colspan="3" class="bold">합계</td>';	
							inner += '	<td>'+comma(tot_regis_no)+'</td>';
							inner += '	<td>'+comma(tot_regis_fee)+'</td>';
							inner += '	<td></td>';
							inner += '	<td>'+comma(tot_lect_pay)+'</td>';
							inner += '	<td>'+comma(comIncome(tot_lect_pay))+'</td>';
							inner += '	<td>'+comma(comResi(tot_lect_pay))+'</td>';
							inner += '	<td>'+comma(Number(tot_lect_pay) - comIncome(tot_lect_pay) - comResi(tot_lect_pay))+'</td>';
							inner += '	<td colspan="4"></td>';
							inner += '</tr>';
							fin_income_tax += comIncome(tot_lect_pay);
							fin_resi_tax += comResi(tot_lect_pay);
							fin_net_lect_pay += Number(tot_lect_pay) - comIncome(tot_lect_pay) - comResi(tot_lect_pay);
							tot_regis_no = 0;
							tot_regis_fee = 0;
							tot_lect_pay = 0;
							tot_income_tax = 0;
							tot_resi_tax = 0;
							tot_net_lect_pay = 0;
							
							//소계 뿌리기
							
							inner += '<tr>';
							inner += '	<td>'+result.list[i].LECTURER_KOR_NM+'</td>';
							inner += '	<td>'+lecturer_cd+'</td>';
							inner += '	<td class="print-tit">'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].TOT_REGIS_NO+'</td>';
							inner += '	<td>'+comma(result.list[i].TOT_REGIS_FEE)+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							inner += '	<td>'+comma(result.list[i].LECT_PAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td>'+cutDate(result.list[i].LECT_YM+""+result.list[i].PAY_DAY)+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].JOURNAL_YN+'</td>';
							inner += '</tr>';
						}
						else if(i == 0)
						{
							inner += '<tr>';
							inner += '	<td>'+result.list[i].LECTURER_KOR_NM+'</td>';
							inner += '	<td>'+lecturer_cd+'</td>';
							inner += '	<td class="print-tit">'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].TOT_REGIS_NO+'</td>';
							inner += '	<td>'+comma(result.list[i].TOT_REGIS_FEE)+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							inner += '	<td>'+comma(result.list[i].LECT_PAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td>'+cutDate(result.list[i].LECT_YM+""+result.list[i].PAY_DAY)+'</td>';
							inner += '	<td>'+result.list[i].BANK_NM+'</td>';
							inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
							inner += '	<td>'+result.list[i].JOURNAL_YN+'</td>';
							inner += '</tr>';
						}
						else
						{
							inner += '<tr>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td class="print-tit">'+result.list[i].SUBJECT_NM+'</td>';
							inner += '	<td>'+result.list[i].TOT_REGIS_NO+'</td>';
							inner += '	<td>'+comma(result.list[i].TOT_REGIS_FEE)+'</td>';
							inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
							inner += '	<td>'+comma(result.list[i].LECT_PAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td>'+cutDate(result.list[i].LECT_YM+""+result.list[i].PAY_DAY)+'</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							inner += '</tr>';
						}
						
						tot_regis_no += Number(result.list[i].TOT_REGIS_NO);
						tot_regis_fee += Number(result.list[i].TOT_REGIS_FEE);
						tot_lect_pay += Number(result.list[i].LECT_PAY);
						tot_income_tax += Number(result.list[i].INCOME_TAX);
						tot_resi_tax += Number(result.list[i].RESI_TAX);
						tot_net_lect_pay += Number(result.list[i].NET_LECT_PAY);
						
						fin_regis_no += Number(result.list[i].TOT_REGIS_NO);
						fin_regis_fee += Number(result.list[i].TOT_REGIS_FEE);
						fin_lect_pay += Number(result.list[i].LECT_PAY);
						
						
						print_lecture = result.list[i].LECTURER_KOR_NM;
						
						if(i == result.list.length-1)
						{
							inner += '<tr class="tr-tfoot">';
							inner += '	<td colspan="3" class="bold">합계</td>';	
							inner += '	<td>'+comma(tot_regis_no)+'</td>';
							inner += '	<td>'+comma(tot_regis_fee)+'</td>';
							inner += '	<td></td>';
							inner += '	<td>'+comma(tot_lect_pay)+'</td>';
							inner += '	<td>'+comma(comIncome(tot_lect_pay))+'</td>';
							inner += '	<td>'+comma(comResi(tot_lect_pay))+'</td>';
							inner += '	<td>'+comma(Number(tot_lect_pay) - comIncome(tot_lect_pay) - comResi(tot_lect_pay))+'</td>';
							inner += '	<td colspan="4"></td>';
							inner += '</tr>';
							fin_income_tax += comIncome(tot_lect_pay);
							fin_resi_tax += comResi(tot_lect_pay);
							fin_net_lect_pay += Number(tot_lect_pay) - comIncome(tot_lect_pay) - comResi(tot_lect_pay);
						}
					}
					
					var fin_inner = "";
					fin_inner += '<ul>';
					fin_inner += '	<li class="first">총 '+result.list.length+'건</li>';
					fin_inner += '	<li class="li02">계</li>';
					fin_inner += '	<li class="li03">'+comma(fin_regis_no)+'</li>';
					fin_inner += '	<li class="li04">'+comma(fin_regis_fee)+'</li>';
					fin_inner += '	<li class="li05"></li>';
					fin_inner += '	<li class="li06">'+comma(fin_lect_pay)+'</li>';
					fin_inner += '	<li class="li07">'+comma(fin_income_tax)+'</li>';
					fin_inner += '	<li class="li08">'+comma(fin_resi_tax)+'</li>';
					fin_inner += '	<li class="li09">'+comma(fin_net_lect_pay)+'</li>';
					fin_inner += '	<li class="li10"></li>';
					fin_inner += '	<li class="li10"></li>';
					fin_inner += '</ul>';
					$("#final_div").html(fin_inner);
					
					var fin_inner2 = "";
					fin_inner2 += '<tr class="tr-tfoot">';
					fin_inner2 += '	<td colspan="2">총 '+result.list.length+'건</td>';
					fin_inner2 += '	<td>계</td>';
					fin_inner2 += '	<td>'+comma(fin_regis_no)+'</td>';
					fin_inner2 += '	<td>'+comma(fin_regis_fee)+'</td>';
					fin_inner2 += '	<td></td>';
					fin_inner2 += '	<td class="print-pay">'+comma(fin_lect_pay)+'</td>';
					fin_inner2 += '	<td class="print-pay">'+comma(fin_income_tax)+'</td>';
					fin_inner2 += '	<td class="print-pay">'+comma(fin_resi_tax)+'</td>';
					fin_inner2 += '	<td class="print-pay">'+comma(fin_net_lect_pay)+'</td>';
					fin_inner2 += '	<td colspan="4"></td>';
					fin_inner2 += '</tr>';
					$("#list_target2").html(fin_inner2);
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="14"><div class="no-data">검색결과가 없습니다.</div></td>';
					inner += '</tr>';
				}
			}
			$("#list_target").html(inner);
			getListEnd();
		}
	});	
}
function goPrint()
{

	$("#search_area").html(cutDate($("#start_ymd").val())+"~"+cutDate($("#end_ymd").val()));
	//프린트 시간넣기
	var today = new Date();  
	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes();  // 분
	$(function(){
		$(".print-date").text(year + '/' + month + '/' + date +" "+ hours + ':' + minutes);
		
	});
	Popup($(".table-csplist").html(),$(".css-box").text());
}
var mywindow = "";
function Popup(data,css)
{
	var corp_fg = $("#corp_fg").val();
	if(corp_fg == "1") {$("#print_h1").html('법인강사료 지급');}
	else {$("#print_h1").html('개인강사료 지급');}
	
	mywindow = window.open('', 'AK 문화 아카데미', 'height=700,width=1200,scrollbars=yes');
	var pritop = $(".trms-pritop").html();
	mywindow.document.write('<html><head><title>AK 문화 아카데미</title>');
	mywindow.document.write('<style type="text/css">@page {  size:210mm 297mm;  margin:10mm 5mm } @media print {');
	mywindow.document.write(css);
	mywindow.document.write('}');
	mywindow.document.write(css);
	mywindow.document.write('</style>');
	mywindow.document.write('<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">');
	mywindow.document.write('</head><body >');
	//인쇄 분리
	mywindow.document.write('<a id="hideBtn" class="bor-btn btn01 print-btn" onclick="javascript:opener.goPrint2();"><i class="material-icons">print</i></a>');
	//인쇄 분리
	mywindow.document.write('<div class="trms-pritop">'+ pritop + '</div>');
	mywindow.document.write(data);
	mywindow.document.write('</body></html>');
	mywindow.document.close(); // IE >= 10에 필요
	mywindow.focus(); // necessary for IE >= 10
// 	mywindow.print();
// 	mywindow.close();
	return true;
}
function goPrint2()
{
	var h = mywindow.document.getElementById("hideBtn");
	h.parentNode.removeChild(h);
	mywindow.print();
	mywindow.close();
}
</script>
<div class="sub-tit">
	<h2>강사료 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>


<div class="table-top">
	<div class="top-row">
		<div class="">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<div class="oddn-sel sel-scr">
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
		</div>
		<div class="">
			<div class="table table-auto">
				<div class="sear-tit sear-tit_left">대상연월</div>
				<div>
					<ul class="chk-ul" id="ul_radio">
							
					</ul>
				</div>
			</div>
		</div>
		<div class="">
			<div class="table table-auto">
				<div class="sear-tit sear-tit_70 sear-tit_left">구분</div>
				<div>
					<select id="corp_fg" name="corp_fg" de-data="법인">
						<option value="1">법인</option>
						<option value="2">개인</option>
					</select>
				</div>
			</div>
		</div>
		<div class="">
			<div class="table table-auto">
				<div class="sear-tit  sear-tit_left">분개여부</div>
				<div>
					<select id="journal_yn" name="journal_yn" de-data="전체">
						<option value="">전체</option>
						<option value="Y">분개완료</option>
						<option value="N">미분개</option>
					</select>
				</div>
			</div>
		</div>
		
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getList();">
</div>
<div class="css-box">
	#hideBtn {
				font-family: 'Material Icons';
				min-width: 34px;
			    text-align: Center;
			    display: inline-block;
			    height: 34px;
			    line-height: 34px;
			    border-radius: 100%;
			    vertical-align: middle;
			    cursor: pointer;
			    border: solid 1px #000;
			}
			#hideBtn > i {
				line-height: inherit;
			}
	*{
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
		font-size:10px;
		line-height:1.6;
		padding:0;
		margin:0;
		box-sizing:border-box;
		
	}
	table { page-break-after:auto }
	tr    { page-break-inside:avoid; page-break-after:auto }
	td    { page-break-inside:avoid; page-break-after:auto }
	thead { display:table-header-group }
	tfoot { display:table-footer-group }
	table td, table th {
		border:0;
		border: 1px solid #000;
		padding:2px;
		font-size:10px;
		text-align:Center;
		
	}
	table {
	    border-collapse: collapse;
	    border-spacing: 0;
	    width: 100%;
	}
	body {
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
	}
	table td{
		border-left: 1px solid #000;
	}
	table  {
	    border:1px solid #000;
	}
	table thead tr > th:first-child{
		border-left:2px solid #000;
	}
	table thead tr > th:last-child{
		border-right:2px solid #000;
	}
	table thead tr th{
		border-top:2px solid #000;
		border-bottom:2px solid #000;
	}
	ul, li{
		margin:0;
		list-style:none;
	}
	table tbody .pri-tr01 {
		background-color:#edf1f6 !important; -webkit-print-color-adjust:exact;
		font-weight:700;
	}
	table tbody .pri-tr04 {
		background-color:#edf6f6 !important; -webkit-print-color-adjust:exact;
		font-weight:700;
	}
	table tbody .pri-tr02 > td:nth-child(2){
		padding-left:30px;
	}
	table tbody .pri-tr03 > td:nth-child(2){
		padding-left:60px;
	}
	table td{
		word-break:break-all;
	}
	.table-stype01 th{
		white-space:nowrap;
	}
	table th i{
		display:none;
	}
	.trms-pritop{
		margin-bottom:5px;
	}
	.trms-prir ul, .trms-prit01{
		margin-bottom:15px;
	}
	.trms-pritop *{
		font-size:10px;
	}
	.trms-pritop h1{
		font-size:30px;
		text-align:center;
	}
	.trms-pritop ul li{
		list-style:none;
		margin:0;
		
	}
	.trms-pritop ul li span{
		display:inline-block;
	}
	.trms-pril ul li span{
		width:60px;
	}
	.trms-pril li span + span{
		width:15px;
	}
	.trms-prir ul li span{
		width:40px;
	}
	.trms-pritable td{
		height:50px;
	}
	.print-date{
		font-style:normal;
	}
	.table{
		display:Table;
		width:100%;
		table-layout:fixed;
	}
	.table > div{
		display:Table-cell;
	/*	vertical-align:middle;*/
	}
	.trms-prit01 > div{
		width:33%;
	}
	.trms-prir table td{
		text-align:center !important;
	}
	.double-line{ 
	    border-bottom: 1px double #000;
	    display:table;
	    margin:0 auto;
	}
	.double-line h1{
	    border-bottom: 1px solid #000;
	    margin:0 0 2px;
	}
	.trms-pritop table{
		width:auto;
	}
	.trms-prit01 td {
	    width: 20px;
	}
	.trms-prit01 .trms-pritable td {
	    width: 50px;
	}
	.table > div{
		vertical-align: middle;
	}
	.trms-prir{			
	    display: table;
	    float: right;
	}
	.trms-prir ul{
		min-width:200px;
	}
	table .tr-tfoot td{
		background-color:#edf1f6 !important; -webkit-print-color-adjust:exact;
		font-weight:700;
	}
	table td.print-tit{
		text-align:left;
	}
	table td.print-pay{
		text-align:right;
	}
</div>
<div class="trms-pritop" style="display:none;">
	<div class="table trms-prit01">
		<div>
		</div>
		<div><div class="double-line"><h1 id="print_h1"></h1></div></div>
		<div>
			<div class="trms-prir">
				<ul>
					<li><span>인쇄일 : </span><em class="print-date"></em></li>
					<li><span>인쇄자 : </span>문화아카데미 ${login_name}</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="table">
		<div>그룹 : 애경 유통</div>
		<div>점 : ${login_rep_store_nm }</div>
		<div>지급일 : <span id="print_payday"></span> </div>
	</div>
</div>

<div class="table-cap table">
	<div class="cap-r text-right">
		<div class="table float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 print-btn" onclick="javascript:goPrint();"><i class="material-icons">print</i></a> 
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
			</div>
		</div>
	</div>
</div>
<div class="table-wr ">
	<div class="table-list  table-csplist">
		<table id="excelTable">
			<colgroup>
				<col>
				<col>
				<col width="5%">
				<col width="25%">
				<col>
				<col width="7%">
				<col>
				<col width="7%">
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr id="tr_target">
				</tr>
				
			</thead>
			<tbody id="list_target">

				
			
			</tbody>
			<tfoot id="list_target2" class="dis-no">				
			</tfoot>
		</table>
	</div>
	<div class="total-fix total-fix02 total-fix05" id="final_div">
		<ul>
			<li class="first">총 725건</li>
			<li class="li02">계</li>
			<li class="li03">374,550,000</li>
			<li class="li04"></li>
			<li class="li05">187,225,000</li>
			<li class="li06">154,211</li>
			<li class="li07">243,154</li>
			<li class="li08">243,154</li>
			<li class="li09"></li>
			<li class="last"><img src="/img/excel-i.png" /></li>
		</ul>
	</div>
</div>



<div id="write_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg itend-edit">
        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200); close_act();">
        			닫기<i class="far fa-window-close"></i>
        		</div>
				<div>
				<!-- 여기 -->
					<form id="fncFormIp" name="fncFormIp" method="POST">
						<h3 class="status_now">작업 현황</h3>
						<div class="top-row change-wrap">
							<div class="wid10">
								<div class="table-list table-list_end">
									<table>
										<thead>
											<tr>
												<th>NO<i class="material-icons">import_export</i></th>
												<th>분개일시<i class="material-icons">import_export</i></th>
												<th>분개여부<i class="material-icons">import_export</i></th>
												<th>담당자<i class="material-icons">import_export</i></th>
												<th>전송건<i class="material-icons">import_export</i></th>
											</tr>
											
										</thead>
										<tbody>
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
										</tbody>
									</table>
								</div>
							</div>
							
						</div>
					</form>
					<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitIp();">확인</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<script>
$(document).ready(function(){
	getPayMonth('regis');
	getList();
});
</script>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>