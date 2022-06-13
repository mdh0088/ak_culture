<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>
$(document).ready(function(){
	
// 	var re_store = '${store}';
// 	var re_pos = '${pos}';
// 	var re_store_name = '${store_name}';
// 	var re_start_ymd = '${start_ymd}';
// 	var re_end_ymd = '${end_ymd}';
	
// 	if(re_store != '' && re_pos != '' && re_store_name != '')
// 	{
// 		$("#selBranch").val(re_store);
// 		$(".selBranch").html(re_store_name);
// 		selStore();
// 		$("#selPos").val(re_pos);
// 		$(".selPos").html(re_pos);
// 		$("#start_ymd").val(cutDate(re_start_ymd));
// 		$("#end_ymd").val(cutDate(re_end_ymd));
// 	}
// 	else
// 	{
		setBundang();
		selStore();
		getProcList();
// 	}
	
});
function selStore()
{
	var store = $("#selBranch").val();
	
	$.ajax({
		type : "POST", 
		url : "/common/getPosList",
		dataType : "text",
		async : false,
		data : 
		{
			store : store
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$("#selPos").html("");
			$(".selPos_ul").html("");
			$("#selPos").append('<option value="">전체</option>');
			$(".selPos_ul").append('<li>전체</li>');
			if(result.length > 0)
			{
				for(var i = 0; i < result.length; i++)
				{
					$("#selPos").append('<option value="'+result[i].POS_NO+'">'+result[i].POS_NO+'</option>');
					$(".selPos_ul").append('<li>'+result[i].POS_NO+'</li>');
				}
				$(".selPos").html("전체");
				$("#selPos").val("");
			}
			else
			{
				$(".selPos").html("검색된 POS 번호가 없습니다.");
			}
			
		}
	});
}
function getProcList()
{
	var store = $("#selBranch").val();
	var pos = $("#selPos").val();
	var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
	var end_ymd = $("#end_ymd").val().replace(/-/gi, "");
// 	location.href="print?store="+store+"&pos="+pos+"&start_ymd="+start_ymd+"&end_ymd="+end_ymd;
	
	if(!isLoading)
	{
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getPrint",
			dataType : "text",
			data : 
			{
				store : store,
				pos : pos,
				start_ymd : start_ymd,
				end_ymd : end_ymd
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				$("#result").val(data);
				document.getElementById("printForm").target = "printFrame";
				document.getElementById("printForm").submit();
				var result = JSON.parse(data);
				
				var inner = "";
				
				if(result.list.length > 10)
				{
					var arrAmt = new Array();
					var arrCnt = new Array();
					
					for(var i = 0; i < result.list.length; i++)
					{
						arrAmt[i] = result.list[i].ADJUST_AMT;
						arrCnt[i] = result.list[i].ADJUST_CNT;
					}
					inner += '<tr class="pri-tr01">';
					inner += '	<td></td>';
					inner += '	<td>총 등록액</td>';
					inner += '	<td>'+comma(arrAmt[0])+'</td>';
					inner += '	<td>'+comma(arrCnt[0])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>순매출</td>';
					inner += '	<td>'+comma(arrAmt[7])+'</td>';
					inner += '	<td>'+comma(arrCnt[7])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>총매출</td>';
					inner += '	<td>'+comma(arrAmt[5])+'</td>';
					inner += '	<td>'+comma(arrCnt[5])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>에누리</td>';
					inner += '	<td>'+comma(arrAmt[6])+'</td>';
					inner += '	<td>'+comma(arrCnt[6])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>취소매출</td>';
					inner += '	<td>'+comma(Number(arrAmt[1])+Number(arrAmt[2]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[1])+Number(arrCnt[2]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>재료비(예수금)</td>';
					inner += '	<td>'+comma(Number(arrAmt[3])+Number(arrAmt[4]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[3])+Number(arrCnt[4]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr01">';
					inner += '	<td></td>';
					inner += '	<td>대체계</td>';
					inner += '	<td>'+comma(arrAmt[25])+'</td>';
					inner += '	<td>'+comma(arrCnt[25])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>카드</td>';
					inner += '	<td>'+comma(Number(arrAmt[8])+Number(arrAmt[9])+Number(arrAmt[10])+Number(arrAmt[11])+Number(arrAmt[12])+Number(arrAmt[13]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[8])+Number(arrCnt[9])+Number(arrCnt[10])+Number(arrCnt[11])+Number(arrCnt[12])+Number(arrCnt[13]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>KB국민 제휴카드</td>';
					inner += '	<td>'+comma(Number(arrAmt[8])+Number(arrAmt[9]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[8])+Number(arrCnt[9]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>신한 제휴카드 </td>';
					inner += '	<td>'+comma(Number(arrAmt[10])+Number(arrAmt[11]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[10])+Number(arrCnt[11]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>우리 제휴카드 </td>';
					inner += '	<td>'+comma(arrAmt[12])+'</td>';
					inner += '	<td>'+comma(arrCnt[12])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>타사카드</td>';
					inner += '	<td>'+comma(arrAmt[13])+'</td>';
					inner += '	<td>'+comma(arrCnt[13])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>상품권</td>';
					inner += '	<td>'+comma(Number(arrAmt[14])+Number(arrAmt[15])+Number(arrAmt[16])+Number(arrAmt[20]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[14])+Number(arrCnt[15])+Number(arrCnt[16])+Number(arrCnt[20]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>자사상품권</td>';
					inner += '	<td>'+comma(Number(arrAmt[14])+Number(arrAmt[15]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[14])+Number(arrCnt[15]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>타사상품권</td>';
					inner += '	<td>'+comma(arrAmt[16])+'</td>';
					inner += '	<td>'+comma(arrCnt[16])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr03">';
					inner += '	<td></td>';
					inner += '	<td>모바일상품권</td>';
					inner += '	<td>'+comma(arrAmt[20])+'</td>';
					inner += '	<td>'+comma(arrCnt[20])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>AK 마일리지</td>';
					inner += '	<td>'+comma(arrAmt[17])+'</td>';
					inner += '	<td>'+comma(arrCnt[17])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr01 pri-tr04">';
					inner += '	<td></td>';
					inner += '	<td>대체소계</td>';
					inner += '	<td>'+comma(arrAmt[23])+'</td>';
					inner += '	<td>'+comma(arrCnt[23])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>재료비(대체)</td>';
					inner += '	<td>'+comma(arrAmt[3])+'</td>';
					inner += '	<td>'+comma(arrCnt[3])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr01">';
					inner += '	<td></td>';
					inner += '	<td>총현금 입금계</td>';
					inner += '	<td>'+comma(arrAmt[33])+'</td>';
					inner += '	<td>'+comma(arrCnt[33])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>현금매출</td>';
					inner += '	<td>'+comma(arrAmt[28])+'</td>';
					inner += '	<td>'+comma(arrCnt[28])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>재료비(현금)</td>';
					inner += '	<td>'+comma(arrAmt[4])+'</td>';
					inner += '	<td>'+comma(arrCnt[4])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>매출외 현금입금(준비금)</td>';
					inner += '	<td>'+comma(arrAmt[29])+'</td>';
					inner += '	<td>'+comma(arrCnt[29])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>외상 현금매출</td>';
					inner += '	<td>'+comma(arrAmt[42])+'</td>';
					inner += '	<td>'+comma(arrCnt[42])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr01">';
					inner += '	<td></td>';
					inner += '	<td>총현금 출금계</td>';
					inner += '	<td>'+comma(arrAmt[38])+'</td>';
					inner += '	<td>'+comma(arrCnt[38])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>자사상품권환불금액</td>';
					inner += '	<td>'+comma(Number(arrAmt[34])+Number(arrAmt[35]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[34])+Number(arrCnt[35]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>타사상품권환불금액</td>';
					inner += '	<td>'+comma(arrAmt[36])+'</td>';
					inner += '	<td>'+comma(arrCnt[36])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>재료비(현금)</td>';
					inner += '	<td>'+comma(arrAmt[37])+'</td>';
					inner += '	<td>'+comma(arrCnt[37])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr01">';
					inner += '	<td></td>';
					inner += '	<td>현금과부족금액</td>';
					inner += '	<td>'+comma(arrAmt[41])+'</td>';
					inner += '	<td>'+comma(arrCnt[41])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>오픈시재금액</td>';
					inner += '	<td>'+comma(arrAmt[39])+'</td>';
					inner += '	<td>'+comma(arrCnt[39])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>마감시재금액</td>';
					inner += '	<td>'+comma(arrAmt[40])+'</td>';
					inner += '	<td>'+comma(arrCnt[40])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr01">';
					inner += '	<td></td>';
					inner += '	<td>과세제외</td>';
					inner += '	<td>'+comma(Number(arrAmt[43])+Number(arrAmt[44]))+'</td>';
					inner += '	<td>'+comma(Number(arrCnt[43])+Number(arrCnt[44]))+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>상품권 과세제외</td>';
					inner += '	<td>'+comma(arrAmt[43])+'</td>';
					inner += '	<td>'+comma(arrCnt[43])+'</td>';
					inner += '</tr>';
					inner += '<tr class="pri-tr02">';
					inner += '	<td></td>';
					inner += '	<td>적립금 과세제외</td>';
					inner += '	<td>'+comma(arrAmt[44])+'</td>';
					inner += '	<td>'+comma(arrCnt[44])+'</td>';
					inner += '</tr>';
				}
				else
				{
					inner += '	<tr>';					
					inner += '		<td colspan="4">검색결과가 없습니다.</td>';
					inner += '	</tr>';
				}
				$("#list_target").html(inner);
				getListEnd();
			}
		});
	}
	
}
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
	var filename = "정산지출력";
	var table = "excelTable";
    exportExcel(filename, table);
}
// function goPrint()
// {
// 	var frm = document.getElementById('printFrame').contentWindow;
// 	frm.focus();
// 	frm.print();
// }
function goPrint()
{

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
	$("#search_area").html(cutDate($("#start_ymd").val())+"~"+cutDate($("#end_ymd").val()));
	Popup($(".pri-table").html(),$(".css-box").text());
}
function Popup(data,css)
{
var mywindow = window.open('', 'AK 문화 아카데미', 'height=700,width=1200');
var pritop = $(".trms-pritop").html();
mywindow.document.write('<html><head><title>AK 문화 아카데미</title>');
mywindow.document.write('<style type="text/css">@page {  size:210mm 297mm;  margin:10mm 5mm } @media print {');
mywindow.document.write(css);
mywindow.document.write('}');
mywindow.document.write(css);
mywindow.document.write('</style>');
mywindow.document.write('</head><body >');
mywindow.document.write('<div class="trms-pritop">'+ pritop + '</div>');
mywindow.document.write(data);
mywindow.document.write('</body></html>');
mywindow.document.close(); // IE >= 10에 필요
mywindow.focus(); // necessary for IE >= 10
mywindow.print();
mywindow.close();
return true;
}


</script>
<style>
/* @page { } */
/* @media print { */
/* 	.pri-tr01{ */
/* 		background:#edf1f6; */
/* 	} */
/* 	.pri-tr04{ */
/* 		background:#edf6f6;	 */
/* 	} */
/* 	.pri-table tbody tr > td:nth-child(2){ */
/* 		text-align:left; */
/* 	} */
/* 	.pri-table tbody .pri-tr02 > td:nth-child(2){ */
/* 		padding-left:30px; */
/* 	} */
/* 	.pri-table tbody .pri-tr03 > td:nth-child(2){ */
/* 		padding-left:60px; */
/* 	} */
/* 	.table-list td{ */
/* 		word-break:break-all; */
/* 	} */
/* 	.table-stype01 th{ */
/* 		white-space:nowrap; */
/* 	} */
/* } */

</style>

<form id="printForm" name="printForm" method="post" action="./print_proc">
	<input type="hidden" id="result" name="result">
</form>
<iframe id="printFrame" name="printFrame" style="display:none;"></iframe>
<div class="sub-tit">
	<h2>정산지 출력</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>
<div class="css-box">
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
	table tbody tr > td:nth-child(2){
		text-align:left;
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
		vertical-align:top;
	}
	.trms-prir{			
	    display: table;
	    float: right;
	}
</div>
<div class="trms-pritop" style="display:none;">
	<div class="table trms-prit01">
		<div>
			<div class="trms-pril">
				<ul>
					<li><span>보안등급</span><span>:</span>대외비</li>
					<li><span>보안년한</span><span>:</span>3년</li>
					<li><span>Report_ID</span><span>:</span>BASale07</li>
				</ul>
			</div>
		</div>
		<div><div class="double-line"><h1>정산 LIST</h1></div></div>
		<div>
			<div class="trms-prir">
				<ul>
					<li><span>인쇄일 : </span><em class="print-date"></em></li>
					<li><span>인쇄자 : </span>문화아카데미 ${login_name}</li>
				</ul>
				<table>
					<tr>
						<td rowspan="2">결<br><br>재</td>
						<td>입 안</td>
						<td>심 사</td>
						<td>결 정</td>
					</tr>
					<tr class="trms-pritable">
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="table">
		<div>그룹 : 애경 유통</div>
		<div>점 : ${login_rep_store_nm }</div>
		<div>POS : ${pos_no }번</div>
		<div>조회기간 : <span id="search_area"></span></div>
	</div>
</div>

<form id="fncForm" name="fncForm" method="POST" action="./check_proc">
	<div class="table-top">
		<div class="top-row">
			<div class="">
				<div class="table table-auto">
					<div>
						<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch" onchange="selStore()">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<div class="wid-35 mag-lr2">
				<div class="table margin-auto">
					<div class="sear-tit sear-tit-70">매출일자</div>
					<div>
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" class="date-i one-i" id="start_ymd" name="start_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
							<div class="cal-dash">-</div>
							<div class="cal-input wid-4">
								<input type="text" class="date-i one-i" id="end_ymd" name="end_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>			
			</div>
			
			
			<div class="">
				<div class="table table-auto">
					<div class="sear-tit sear-tit-70">POS NO</div>
					<div>
						<select id="selPos" name="selPos">
						</select>
						<!--  <a class="btn btn02 mrg-l6" onclick="javascript:getProcList();">조회</a>  -->
					</div>
				</div>
			</div>
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getProcList();">
	</div>
</form>


<div class="table-cap table">
	<div class="cap-r text-right">
		<div class="table float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 print-btn" onclick="javascript:goPrint();"><i class="material-icons">print</i></a> 
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

<div class="table-wr ip-list">	

	<div class="table-list pri-table">
		<table id="excelTable">
			<colgroup>
				<col width="12%" />
				<col width="40%" />
				<col />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th>NO.</th>
					<th>정산항목 </th>
					<th>정산금액 </th>
					<th>정산건수 </th>
				</tr>
			</thead>
			<tbody id="list_target">
<!-- 				<tr class="bg-red">					 -->
<!-- 					<td></td> -->
<!-- 					<td>총 등록액</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
				<c:forEach var="i" items="${pmgList}" varStatus="loop">
					<tr>					
						<td>${loop.index+1}</td>
						<td>${i.ADJUST_NM}</td>
						<td><fmt:formatNumber value="${i.ADJUST_AMT}" pattern="#,###"/></td>
						<td>${i.ADJUST_CNT}</td>
					</tr>
				</c:forEach>
			</tbody>
<!-- 			<tbody>				 -->
<!-- 				<tr class="pri-tr01"> -->
<!-- 					<td></td> -->
<!-- 					<td>총 등록액</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>순매출</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>총매출</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>에누리</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>취소매출</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>재료비(예수금)</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr01"> -->
<!-- 					<td></td> -->
<!-- 					<td>대체소계</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>카드</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>KB국민 제휴카드</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>신한 제휴카드 </td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>타사카드</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>상품권</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>자사상품권</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>타사상품권</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr03"> -->
<!-- 					<td></td> -->
<!-- 					<td>모바일상품권</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>AK 마일리지</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr01 pri-tr04"> -->
<!-- 					<td></td> -->
<!-- 					<td>대체계</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>재료비(예수금)</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr01"> -->
<!-- 					<td></td> -->
<!-- 					<td>총현금 입금계</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>현금매출</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>재료비(현금)</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>매출외 현금입금(준비금)</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>외상 현금매출</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr01"> -->
<!-- 					<td></td> -->
<!-- 					<td>총현금 출금계</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>자사상품권환불금액</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>타사상품권환불금액</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>재료비(현금)</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr01"> -->
<!-- 					<td></td> -->
<!-- 					<td>현금과부족금액</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>오픈시재금액</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>마감시재금액</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr01"> -->
<!-- 					<td></td> -->
<!-- 					<td>과세제외</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>상품권 과세제외</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr class="pri-tr02"> -->
<!-- 					<td></td> -->
<!-- 					<td>적립금 과세제외</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 			</tbody> -->
		</table>
	</div>
	
</div>








<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>