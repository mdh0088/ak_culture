<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDownAll()
{
	excelDown1();
	excelDown2();
	excelDown3();
}
function excelDown1()
{
	var filename = "카드사별 매출현황";
	var table = "excelTable1";
    exportExcel(filename, table);
}
function excelDown2()
{
	var filename = "접수일자별 카드 사용현황";
	var table = "excelTable2";
    exportExcel(filename, table);
}
function excelDown3()
{
	var filename = "마일리지 매출 현황";
	var table = "excelTable3";
    exportExcel(filename, table);
}
function goPrint()
{
	Popup($(".pri-table"+selCate).html());
}
function Popup(data)
{
var mywindow = window.open('', 'AK 문화 아카데미', 'height=700,width=1200');
mywindow.document.write('<html><head><title>AK 문화 아카데미</title>');
mywindow.document.write('</head><body >');
mywindow.document.write(data);
mywindow.document.write('</body></html>');
mywindow.document.close(); // IE >= 10에 필요
mywindow.focus(); // necessary for IE >= 10
mywindow.print();
mywindow.close();
return true;
}
var selCate = 1;
function selCategory(val)
{
	selCate = val;
}
$(document).ready(function(){
	
	var re_store = '${store}';
	var re_pos = '${pos}';
	var re_store_name = '${store_name}';
	var re_start_ymd = '${start_ymd}';
	var re_end_ymd = '${end_ymd}';
	
	if(re_store != '')
	{
		$("#selBranch").val(re_store);
		$(".selBranch").html(re_store_name);
// 		selStore();
		$("#start_ymd").val(cutDate(re_start_ymd));
		$("#end_ymd").val(cutDate(re_end_ymd));
	}
	if(re_pos != '')
	{
		$("#selPos").val(re_pos);
// 		$(".selPos").html(re_pos);
	}
	if(re_store != '' && re_pos != '' && re_store_name != '')
	{
		
	}
	else
	{
		setBundang();
// 		selStore();
	}
	
});
// function selStore()
// {
// 	var store = $("#selBranch").val();
	
// 	$.ajax({
// 		type : "POST", 
// 		url : "/common/getPosList",
// 		dataType : "text",
// 		async : false,
// 		data : 
// 		{
// 			store : store
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			console.log(data);
// 			var result = JSON.parse(data);
// 			$("#selPos").html("");
// 			$(".selPos_ul").html("");
// 			$("#selPos").append('<option value="">전체</option>');
// 			$(".selPos_ul").append('<li>전체</li>');
// 			if(result.length > 0)
// 			{
// 				for(var i = 0; i < result.length; i++)
// 				{
// 					$("#selPos").append('<option value="'+result[i].POS_NO+'">'+result[i].POS_NO+'</option>');
// 					$(".selPos_ul").append('<li>'+result[i].POS_NO+'</li>');
// 				}
// 				$(".selPos").html("전체");
// 				$("#selPos").val("");
// 			}
// 			else
// 			{
// 				$(".selPos").html("검색된 POS 번호가 없습니다.");
// 			}
			
// 		}
// 	});
// }
function excelDown()
{
	var store = $("#selBranch").val();
	var pos = $("#selPos").val();
	var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
	var end_ymd = $("#end_ymd").val().replace(/-/gi, "");
	
	$.ajax({
		type : "POST", 
		url : "./excelDown3",
		dataType : "text",
		async : false,
		data : 
		{
			store : store,
			pos : pos,
			start_ymd : start_ymd,
			end_ymd : end_ymd,
			ind : ind+1
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			location.href="/excel/"+result.filename;
		}
	});
}
function getProcList()
{
	var store = $("#selBranch").val();
	var pos = $("#selPos").val();
	var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
	var end_ymd = $("#end_ymd").val().replace(/-/gi, "");
	location.href="detail?store="+store+"&pos="+pos+"&start_ymd="+start_ymd+"&end_ymd="+end_ymd;
}

var ind = 0;
$(function(){
	/* 탭 */
	$(".tab-wrap").each(function(){
		var tab = $(this).find(".tab-title ul > li");
		var cont = $(this).find(".tab-content > div");

		tab.click(function(){
			ind = $(this).index();
			tab.removeClass("active");
			$(this).addClass("active");
			cont.removeClass("active");
			cont.eq(ind).addClass("active");
			cont.hide();
			cont.eq(ind).show();
		});
	});
});
</script>

<div class="sub-tit">
	<h2>매출 상세 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="bor-btn btn01 print-btn" onclick="javascript:goPrint();"><i class="material-icons">print</i></a>
		<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDownAll();"><i class="fas fa-file-download"></i></a>
	</div>
</div>

<div class="table-top first">
	<div class="top-row">
		<div class="">
			<div class="table table-auto">
				<div>
					<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch">
						<c:forEach var="i" items="${branchList}" varStatus="loop">
							<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		
		<div class="wid-35 mag-lr2">
			<div class="table ">
				<div class="sear-tit sear-tit-70">매출일자</div>
				<div>
					<div class="cal-row cal-row02 table">
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
			</div>			
		</div>
		
		
		<div class="">
			<div class="table table-auto">
				<div class="sear-tit sear-tit-70">POS NO</div>
				<div>
					<input type="text" id="selPos" name="selPos" value="0700">
					<a class="btn btn02 mrg-l6" onclick="javascript:getProcList();">선택완료</a>
				</div>
			</div>
		</div>
	</div>

</div>



<div class="table-wr">

	<div class="tab-wrap tab-wrap_mem">		
		<div class="tab-title tab-title02 ">
			<ul>
				<li class="active" onclick="selCategory(1);">카드사별 매출현황</li>
				<li onclick="selCategory(2);">접수일자별 카드 사용 현황</li>
				<li onclick="selCategory(3);">마일리지 매출 현황</li>
			</ul>
		</div> <!-- tab-title end -->
		
		<div class="tab-content mem-manage trms-divWrap">
		
			<div class="trms-div01 active">
				<div class="table-list pri-table1" style="height:800px; overflow-y:scroll;">
					<style>
					@page {
						size:a4; /*A4*/
						margin: 10mm 5mm; 
					 }
					@media print {
						*{
							font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
							font-size:7px;
							line-height:1.6;
							padding:0;
							margin:0;
							box-sizing:border-box;
							
						}
						table td, table th {
							border:0;
							border: 1px solid #e0e0e0;
							padding:2px;
							font-size:7px;
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
							border-left: 1px solid #e8e8e8;
						}
						table  {
						    border:1px solid #e8e8e8;
						}
						ul, li{
							margin:0;
							list-style:none;
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
						.color-red, .bg-red td{
							color:#ee908e;
						}
					}
					</style>
					<table id="excelTable1">
						<thead>
							<tr>
								<th>NO.</th>
								<th>일자 </th>
								<th>POS </th>
								<th>카드회사코드 </th>
								<th>카드회사명 </th>
								<th>금액 </th>
								<th>전표서명갯수 </th>
								<th>전자서명갯수 </th>
								<th>전표갯수 </th> 
							</tr>
						</thead>
						<tbody>		
							<c:set var="totAmt" value="0"/>	
							<c:set var="totNSign" value="0"/>	
							<c:set var="totSign" value="0"/>	
							<c:set var="totCust" value="0"/>	
							<c:set var="finAmt" value="0"/>	
							<c:set var="finNSign" value="0"/>	
							<c:set var="finSign" value="0"/>	
							<c:set var="finCust" value="0"/>	
							<c:forEach var="i" items="${pmgList1}" varStatus="loop">
								<!-- 날짜를 계속 넣고, 바뀌지않으면 합계를더한다. 날짜가바뀌면 합계를 노출하고 초기화한다. -->
								
								<!-- 최초니까 그냥 넣음. -->
								<c:if test="${loop.index eq '0'}">
									<c:set var="forDate" value="${i.SALE_YMD}"/>
								</c:if>
								<c:if test="${forDate eq i.SALE_YMD}">
									<c:set var="totAmt" value="${totAmt + i.TOT_AMT }"/>
									<c:set var="totNSign" value="${totNSign + i.NSIGN_CNT }"/>	
									<c:set var="totSign" value="${totSign + i.SIGN_CNT }"/>	
									<c:set var="totCust" value="${totCust + i.CUST_TOT }"/>	
									<c:set var="finAmt" value="${finAmt + i.TOT_AMT }"/>
									<c:set var="finNSign" value="${finNSign + i.NSIGN_CNT }"/>	
									<c:set var="finSign" value="${finSign + i.SIGN_CNT }"/>	
									<c:set var="finCust" value="${finCust + i.CUST_TOT }"/>	
								</c:if>
								<c:if test="${forDate ne i.SALE_YMD}">
									<tr class="bg-red">
										<td></td>
									   	<td>
									   		<fmt:parseDate value="${forDate}" var="forDate" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${forDate}" pattern="yyyy-MM-dd"/>
									   	</td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td><fmt:formatNumber value="${totAmt}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totNSign}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totSign}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totCust}" pattern="#,###"/></td>							   	
									</tr>
									<c:set var="totAmt" value="${i.TOT_AMT}"/>
									<c:set var="totNSign" value="${i.NSIGN_CNT}"/>
									<c:set var="totSign" value="${i.SIGN_CNT}"/>
									<c:set var="totCust" value="${i.CUST_TOT}"/>
									<c:set var="finAmt" value="${finAmt + i.TOT_AMT }"/>
									<c:set var="finNSign" value="${finNSign + i.NSIGN_CNT }"/>	
									<c:set var="finSign" value="${finSign + i.SIGN_CNT }"/>	
									<c:set var="finCust" value="${finCust + i.CUST_TOT }"/>	
								</c:if>
								<tr>					
									<td>${loop.index+1}</td>
									<td>
										<fmt:parseDate value="${i.SALE_YMD}" var="SALE_YMD" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${SALE_YMD}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${i.POS_NO}</td>
									<td>${i.CARD_CORP_NO}</td>
									<td>${i.CARD_NM}</td>
									<td><fmt:formatNumber value="${i.TOT_AMT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.NSIGN_CNT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.SIGN_CNT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.CUST_TOT}" pattern="#,###"/></td>
								</tr>
								<c:if test="${loop.index+1 eq pmgList1_size}">
									<tr class="bg-red">
										<td></td>
									   	<td>
											<fmt:parseDate value="${forDate}" var="forDate" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${forDate}" pattern="yyyy-MM-dd"/>
									   	</td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td><fmt:formatNumber value="${totAmt}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totNSign}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totSign}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totCust}" pattern="#,###"/></td>							   	
									</tr>
									<tr class="bg-red">
										<td></td>
									   	<td>
									   		총계
									   	</td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td><fmt:formatNumber value="${finAmt}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${finNSign}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${finSign}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${finCust}" pattern="#,###"/></td>							   	
									</tr>
								</c:if>
								<c:set var="forDate" value="${i.SALE_YMD}"/> <!-- 날짜를 바꿔치기한다. -->
							</c:forEach>					
						</tbody>
					</table>
				</div>
			
			</div> <!-- trms-div01 end -->
			
			<div class="trms-div02">
				<div class="table-list pri-table2" style="height:800px; overflow-y:scroll;">
					<style>
					@page {
						size:a4; /*A4*/
						margin: 10mm 5mm; 
					 }
					@media print {
						*{
							font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
							font-size:7px;
							line-height:1.6;
							padding:0;
							margin:0;
							box-sizing:border-box;
							
						}
						table td, table th {
							border:0;
							border: 1px solid #e0e0e0;
							padding:2px;
							font-size:7px;
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
							border-left: 1px solid #e8e8e8;
						}
						table  {
						    border:1px solid #e8e8e8;
						}
						ul, li{
							margin:0;
							list-style:none;
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
						.color-red, .bg-red td{
							color:#ee908e;
						}
					}
					</style>
					<table id="excelTable2">
						<thead>
							<tr>
								<th>NO.</th>
								<th>일자 </th>
								<th>POS </th>
								<th>멤버스번호 </th>
								<th>회원명 </th>
								<th>카드회사명 </th>
								<th>카드번호 </th>
								<th>금액 </th>
							</tr>
						</thead>
						<tbody>		
							<c:set var="totAmt" value="0"/>	
							<c:set var="finAmt" value="0"/>	
							<c:forEach var="i" items="${pmgList2}" varStatus="loop">
								<!-- 날짜를 계속 넣고, 바뀌지않으면 합계를더한다. 날짜가바뀌면 합계를 노출하고 초기화한다. -->
								
								<!-- 최초니까 그냥 넣음. -->
								<c:if test="${loop.index eq '0'}">
									<c:set var="forDate" value="${i.SALE_YMD}"/>
								</c:if>
								<c:if test="${forDate eq i.SALE_YMD}">
									<c:set var="totAmt" value="${totAmt + i.CARD_AMT }"/>
									<c:set var="finAmt" value="${finAmt + i.CARD_AMT }"/>
								</c:if>
								<c:if test="${forDate ne i.SALE_YMD}">
									 <tr class="bg-red">
										<td></td>
									   	<td>
									   		<fmt:parseDate value="${forDate}" var="forDate" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${forDate}" pattern="yyyy-MM-dd"/>
									   	</td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td><fmt:formatNumber value="${totAmt}" pattern="#,###"/></td>
									</tr> 
									
									<tr class="bg-red">
									   	<td colspan="7" class="bold">소계</td>
									   	<td><fmt:formatNumber value="${totAmt}" pattern="#,###"/></td>
									</tr>
									<c:set var="totAmt" value="${i.CARD_AMT}"/>
									<c:set var="finAmt" value="${finAmt + i.CARD_AMT }"/>
								</c:if>
								<tr>					
									<td>${loop.index+1}</td>
									<td>
										<fmt:parseDate value="${i.SALE_YMD}" var="SALE_YMD" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${SALE_YMD}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${i.POS_NO}</td>
									<td>${i.CUS_NO}</td>
									<td>${i.KOR_NM}</td>
									<td>${i.CARD_NM}</td>
									<td>${i.CARD_NO}</td>
									<td><fmt:formatNumber value="${i.CARD_AMT}" pattern="#,###"/></td>
								</tr>
								<c:if test="${loop.index+1 eq pmgList2_size}">
									<tr class="bg-red">
										<td></td>
									   	<td>
											<fmt:parseDate value="${i.SALE_YMD}" var="SALE_YMD" pattern="yyyyMMdd"/>
											<fmt:formatDate value="${SALE_YMD}" pattern="yyyy-MM-dd"/>
									   	</td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td><fmt:formatNumber value="${totAmt}" pattern="#,###"/></td>
									</tr> 
									<tr class="bg-red">
									   	<td colspan="7" class="bold">소계</td>
									   	<td><fmt:formatNumber value="${totAmt}" pattern="#,###"/></td>
									</tr>
									<tr class="bg-red">
									   	<td colspan="7" class="bold">총계</td>
									   	<td><fmt:formatNumber value="${finAmt}" pattern="#,###"/></td>
									</tr>
									<tr class="bg-red">
										<td></td>
									   	<td>
									   	</td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td></td>
									   	<td><fmt:formatNumber value="${finAmt}" pattern="#,###"/></td>
									</tr>
								</c:if>
								<c:set var="forDate" value="${i.SALE_YMD}"/> <!-- 날짜를 바꿔치기한다. -->
							</c:forEach>					
						</tbody>
					</table>
				</div>
			</div> <!-- trms-div02 end -->
			
			<div class="trms-div03">
				<div class="table-list pri-table3" style="height:800px; overflow-y:scroll;">
					<style>
					@page {
						size:a4; /*A4*/
						margin: 10mm 5mm; 
					 }
					@media print {
						*{
							font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
							font-size:7px;
							line-height:1.6;
							padding:0;
							margin:0;
							box-sizing:border-box;
							
						}
						table td, table th {
							border:0;
							border: 1px solid #e0e0e0;
							padding:2px;
							font-size:7px;
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
							border-left: 1px solid #e8e8e8;
						}
						table  {
						    border:1px solid #e8e8e8;
						}
						ul, li{
							margin:0;
							list-style:none;
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
						.color-red, .bg-red td{
							color:#ee908e;
						}
					}
					</style>
					<table id="excelTable3">
						<thead>
							<tr>
								<th>NO.</th>
								<th>일자 </th>
								<th>POS </th>
								<th>멤버스번호 </th>
								<th>회원명 </th>
								<th>강좌명 </th>
								<th>적립포인트 </th>
								<th>사용포인트 </th>
							</tr>
						</thead>
						<tbody>
							<c:set var="totRecptAmt" value="0"/>	
							<c:set var="totUseAmt" value="0"/>	
							<c:set var="finRecptAmt" value="0"/>	
							<c:set var="finUseAmt" value="0"/>	
							<c:forEach var="i" items="${pmgList3}" varStatus="loop">
								<!-- 날짜를 계속 넣고, 바뀌지않으면 합계를더한다. 날짜가바뀌면 합계를 노출하고 초기화한다. -->
								
								<!-- 최초니까 그냥 넣음. -->
								<c:if test="${loop.index eq '0'}">
									<c:set var="forDate" value="${i.SALE_YMD}"/>
								</c:if>
								<c:if test="${forDate eq i.SALE_YMD}">
									<c:set var="totRecptAmt" value="${totRecptAmt + i.AKMEM_RECPT_POINT }"/>
									<c:set var="totUseAmt" value="${totUseAmt + i.AKMEM_USE_POINT }"/>
									<c:set var="finRecptAmt" value="${finRecptAmt + i.AKMEM_RECPT_POINT }"/>
									<c:set var="finUseAmt" value="${finUseAmt + i.AKMEM_USE_POINT }"/>
								</c:if>
								<c:if test="${forDate ne i.SALE_YMD}">
									<tr class="bg-red">
									   	<td colspan="6" class="bold">소계</td>
									   	<td><fmt:formatNumber value="${totRecptAmt}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totUseAmt}" pattern="#,###"/></td>
									</tr>
									<c:set var="totRecptAmt" value="${i.AKMEM_RECPT_POINT}"/>
									<c:set var="totUseAmt" value="${i.AKMEM_USE_POINT}"/>
									<c:set var="finRecptAmt" value="${finAmt + i.AKMEM_RECPT_POINT }"/>
									<c:set var="finUseAmt" value="${finAmt + i.AKMEM_USE_POINT }"/>
								</c:if>
								<tr>					
									<td>${loop.index+1}</td>
									<td>
										<fmt:parseDate value="${i.SALE_YMD}" var="SALE_YMD" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${SALE_YMD}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${i.POS_NO}</td>
								   	<td>${i.CUS_NO}</td>
								   	<td>${i.KOR_NM}</td>
								   	<td>${i.SUBJECT_NM}</td>
									<td><fmt:formatNumber value="${i.AKMEM_RECPT_POINT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.AKMEM_USE_POINT}" pattern="#,###"/></td>
								</tr>
								<c:if test="${loop.index+1 eq pmgList3_size}">
									<tr class="bg-red">
									   	<td colspan="6" class="bold">소계</td>
									   	<td><fmt:formatNumber value="${totRecptAmt}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${totUseAmt}" pattern="#,###"/></td>
									</tr>
									<tr class="bg-red">
									   	<td colspan="6" class="bold">총계</td>
									   	<td><fmt:formatNumber value="${finRecptAmt}" pattern="#,###"/></td>
									   	<td><fmt:formatNumber value="${finUseAmt}" pattern="#,###"/></td>
									</tr>
								</c:if>
								<c:set var="forDate" value="${i.SALE_YMD}"/> <!-- 날짜를 바꿔치기한다. -->
							</c:forEach>		

						</tbody>
					</table>
				</div>
			</div> <!-- trms-div03 end -->
			
		</div>
	</div>
</div>







<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>