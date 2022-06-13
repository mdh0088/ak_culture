<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<style>
.sampay, .m_coupon, .ak_gift {
	display:none;
}
.th-last {
	border-radius: 0 30px 30px 0;
}
.excelNumber {
    text-align:right !important;
    mso-number-format:General !important;
    white-space:nowrap !important;
}

</style>
<script>
function excelDownAll()
{
	excelDown1();
	excelDown2();
	excelDown3();
}
function excelDown1()
{
	var filename = "POS별 매출현황";
	var table = "excelTable1";
    exportExcel(filename, table);
}
function excelDown2()
{
	var filename = "재료비 입금 내역";
	var table = "excelTable2";
    exportExcel(filename, table);
}
function excelDown3()
{
	var filename = "상품권 종별 조회";
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
		selStore();
		$("#start_ymd").val(cutDate(re_start_ymd));
		$("#end_ymd").val(cutDate(re_end_ymd));
	}
	if(re_store != '' && re_pos != '' && re_store_name != '')
	{
		
	}
	else
	{
		setBundang();
		selStore();
	}
	if(location.href.indexOf("?") > 0)
	{
		$("#selPos").val(re_pos);
		if(re_pos == "")
		{
			$(".selPos").html('전체');
		}
		else
		{
			$(".selPos").html(re_pos);
		}
	}
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
				if(nullChk('${pos_init}') == "")
				{
					$(".selPos").html('전체');
					$("#selPos").val('');
				}
				else
				{
					$(".selPos").html('${pos_init}');
					$("#selPos").val('${pos_init}');
				}
			}
			else
			{
				$(".selPos").html("검색된 POS 번호가 없습니다.");
			}
		}
	});
}
function excelDown()
{
	var store = $("#selBranch").val();
	var pos = $("#selPos").val();
	var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
	var end_ymd = $("#end_ymd").val().replace(/-/gi, "");
	
	$.ajax({
		type : "POST", 
		url : "./excelDown2",
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

function chkClick(val)
{
	if($("#"+val).is(":checked") == true)
	{
		if($("."+val).css("display") == "none")
		{
			$("."+val).show();
		}
	}
	else
	{
		if($("."+val).css("display") != "none")
		{
			$("."+val).hide();
		}
	}
	
	//라운드때문에 추가
	if($("#ak_gift").is(":checked") == true)
	{
		$(".th-last").css("border-radius", "0 0 0 0");
		$(".m_coupon").css("border-radius", "0 0 0 0")
		$(".sampay").css("border-radius", "0 0 0 0")
		$(".ak_gift").css("border-radius", "0 30px 30px 0")
	}
	else if($("#m_coupon").is(":checked") == true)
	{
		$(".th-last").css("border-radius", "0 0 0 0");
		$(".ak_gift").css("border-radius", "0 0 0 0")
		$(".sampay").css("border-radius", "0 0 0 0")
		$(".m_coupon").css("border-radius", "0 30px 30px 0")
	}
	else if($("#sampay").is(":checked") == true)
	{
		$(".th-last").css("border-radius", "0 0 0 0");
		$(".ak_gift").css("border-radius", "0 0 0 0")
		$(".m_coupon").css("border-radius", "0 0 0 0")
		$(".sampay").css("border-radius", "0 30px 30px 0")
	}
	else
	{
		$(".th-last").css("border-radius", "0 30px 30px 0");
	}
}
function getProcList()
{
	var store = $("#selBranch").val();
	var pos = $(".selPos").html();
	if(pos == '전체')
	{
		pos = '';
	}
	var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
	var end_ymd = $("#end_ymd").val().replace(/-/gi, "");
	location.href="list?store="+store+"&pos="+pos+"&start_ymd="+start_ymd+"&end_ymd="+end_ymd;
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
var selCate = 1;
function selCategory(val)
{
	selCate = val;
}
</script>

<div class="sub-tit">
	<h2>매출 유형별 조회</h2>
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
						<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch" onchange="selStore()">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<div class="wid-35 mag-lr2">
				<div class="table">
					<div class="sear-tit sear-tit-70">매출일자</div>
					<div>
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" class="date-i ready-i" id="start_ymd" name="start_ymd"/>  
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
			
			
			
			<div class="wid-45 mag-l2">
				<div class="table" >
					<div class="sear-tit sear-tit-70">POS NO</div>
					<div class="sel100">
						<select id="selPos" name="selPos">
						</select>				
					</div>
					<div class="wid-65">
						<ul class="chk-ul mag-l2">
								<li>
									<input type="checkbox" id="sampay" name="sampay" onclick="chkClick('sampay')">
									<label for="sampay">삼성페이</label>
								</li>
								<li>
									<input type="checkbox" id="m_coupon" name="m_coupon" onclick="chkClick('m_coupon')">
									<label for="m_coupon">M.상품권</label>
								</li>							
								
							</ul>
						<a class="btn btn02 mag-l4" onclick="javascript:getProcList();">조회</a>
					</div>
				</div>
			</div>
		</div>	
	</div>
<!-- <div class="table-top first"> -->
<!-- 	<div class="top-row"> -->
<!-- 		<div class="wid-3"> -->
<!-- 			<div class="table table02 table-input wid-contop"> -->
<!-- 				<div> -->
<!-- 					<select de-data="그룹"> -->
<!-- 						<option>분당점</option> -->
<!-- 						<option>ㅁㅁ점</option> -->
<!-- 						<option>ㅇㅇ점</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<select de-data="분당점"> -->
<!-- 						<option>분당점</option> -->
<!-- 						<option>ㅁㅁ점</option> -->
<!-- 						<option>ㅇㅇ점</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
<!-- 		<div class="wid-35 mag-lr2"> -->
<!-- 			<div class="table margin-auto"> -->
<!-- 				<div class="sear-tit sear-tit-70">매출일자</div> -->
<!-- 				<div> -->
<!-- 					<div class="cal-row cal-row02 table"> -->
<!-- 						<div class="cal-input wid-4"> -->
<!-- 							<input type="text" class="date-i" id="start_ymd" name="start_ymd"/> -->
<!-- 							<i class="material-icons">event_available</i> -->
<!-- 						</div> -->
<!-- 						<div class="cal-dash">-</div> -->
<!-- 						<div class="cal-input wid-4"> -->
<!-- 							<input type="text" class="date-i" id="end_ymd" name="end_ymd"/> -->
<!-- 							<i class="material-icons">event_available</i> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div>			 -->
<!-- 		</div> -->
		
		
<!-- 		<div class="wid-35"> -->
<!-- 			<div class="table margin-auto"> -->
<!-- 				<div class="sear-tit sear-tit-70">POS NO</div> -->
<!-- 				<div> -->
<!-- 					<select de-data="070002"> -->
<!-- 						<option>070002</option> -->
<!-- 						<option>070002</option> -->
<!-- 						<option>070002</option> -->
<!-- 					</select> -->
<!-- 					<a class="btn btn02 mrg-l6">선택완료</a> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->

<!-- </div> -->



<div class="table-wr">

	<div class="tab-wrap tab-wrap_mem">		
		<div class="tab-title tab-title02 ">
			<ul>
				<li class="active" onclick="selCategory(1);">POS별 매출 현황</li>
				<li onclick="selCategory(2);">재료비 입금 내역</li>
				<li onclick="selCategory(3);">상품권 종별 조회</li>
			</ul>
		</div> <!-- tab-title end -->
		
		<div class="tab-content mem-manage trms-divWrap">
		
			<div class="trms-div01 active">
				<div class="table-list pri-table1">
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
					}
					</style>
					<table id="excelTable1">
						<thead>
							<tr>
								<th>NO.</th>
								<th>일자 </th>
								<th>POS </th>
								<th>영수증 </th>
								<th>멤버스번호 </th>
								<th>매출구분 </th>
								<th>구분 </th>
								<th>현금 </th>
								<th>거스름돈 </th>
								<th>상품권(자사) </th>
								<th>상품권 (타사) </th>
								<th>카드 </th>
								<th>카드구분 </th> 
 
								<th>마일리지 </th> 
								<th>할인 </th> 
								<th class="th-last">합계 </th> 
								<th class="sampay">삼성페이 </th> 
								<th class="m_coupon">M.상품권 </th> 
								<th class="ak_gift">AK GIFT </th> 
							</tr>
						</thead>
						<tbody>					
							<c:forEach var="i" items="${pmgList1}" varStatus="loop">
								<tr>					
									<td>${loop.index+1}</td>
									<td>
										<fmt:parseDate value="${i.SALE_YMD}" var="SALE_YMD" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${SALE_YMD}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${i.POS_NO}</td>
									<td>${i.RECPT_NO}</td>
									<td>${i.CUS_NO}</td>
									<td>${i.IN_TYPE_TXT}</td>
									<td>${i.PAY_FG_TXT}</td>
									<td><fmt:formatNumber value="${i.CASH_AMT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.REPAY_AMT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.JASA_COUPON_AMT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.TASA_COUPON_AMT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.SHIN_AMT+i.KB_AMT+i.WB_AMT+i.TASA_AMT}" pattern="#,###"/></td>
									<td>
										<c:if test="${i.SHIN_AMT > 0}">신한</c:if>
										<c:if test="${i.KB_AMT > 0}">국민</c:if>
										<c:if test="${i.WB_AMT > 0}">우리</c:if>
										<c:if test="${i.TASA_AMT > 0}">타사</c:if>
									</td>
									<td><fmt:formatNumber value="${i.POINT_AMT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.ENURI_AMT}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.SALE_AMT}" pattern="#,###"/></td>
									<td class="sampay">${i.SAMPAY_FG}</td>
									<td class="m_coupon"><fmt:formatNumber value="${i.MC_AMT}" pattern="#,###"/></td>
									<td class="ak_gift"><fmt:formatNumber value="${i.AKGIFT_AMT}" pattern="#,###"/></td>
								</tr>
							</c:forEach>			
							
							<tr class="bg-red total">
								<td colspan="7">합계</td>
							   	<td><fmt:formatNumber value="${cash_tot}" pattern="#,###"/></td>
							   	<td><fmt:formatNumber value="${repay_tot}" pattern="#,###"/></td>
							   	<td><fmt:formatNumber value="${jasa_coupon_tot}" pattern="#,###"/></td>
							   	<td><fmt:formatNumber value="${tasa_coupon_tot}" pattern="#,###"/></td>
							   	<td><fmt:formatNumber value="${card_tot}" pattern="#,###"/></td>
							   	<td></td>
							   	<td><fmt:formatNumber value="${point_tot}" pattern="#,###"/></td>
							   	<td><fmt:formatNumber value="${enuri_tot}" pattern="#,###"/></td>
							   	<td><fmt:formatNumber value="${sale_tot}" pattern="#,###"/></td>
							   	<td class="sampay"></td>
								<td class="m_coupon"><fmt:formatNumber value="${mc_tot}" pattern="#,###"/></td>
								<td class="ak_gift"><fmt:formatNumber value="${akgift_tot}" pattern="#,###"/></td>
							</tr>
														
						</tbody>
					</table>
				</div>
			
			</div> <!-- trms-div01 end -->
			
			<div class="trms-div02">
				<div class="table-list  pri-table2">
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
					}
					</style>
					<table id="excelTable2">
						<thead>
							<tr>
								<th>NO.</th>
								<th>일자 </th>
								<th>POS </th>
								<th>영수증 </th>
								<th>멤버스번호 </th>
								<th>중분류 </th>
								<th>강좌명 </th>
								<th>현금액 </th>
								<th>카드금액 </th>
							</tr>
						</thead>
						<tbody>		
							<c:forEach var="i" items="${pmgList2}" varStatus="loop">
								<tr>					
									<td>${loop.index+1}</td>
									<td>
										<fmt:parseDate value="${i.SALE_YMD}" var="SALE_YMD" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${SALE_YMD}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${i.POS_NO}</td>
									<td>${i.RECPT_NO}</td>
									<td>${i.CUS_NO}</td>
									<td>${i.SECT_NM}</td>
									<td>${i.SUBJECT_NM}</td>
									<td><fmt:formatNumber value="${i.AMT1}" pattern="#,###"/></td>
									<td><fmt:formatNumber value="${i.AMT2}" pattern="#,###"/></td>
								</tr>
							</c:forEach>							
							<tr class="bg-red total">
								<td colspan="7">합계</td>
							   	<td><fmt:formatNumber value="${amt1_tot}" pattern="#,###"/></td>
							   	<td><fmt:formatNumber value="${amt2_tot}" pattern="#,###"/></td>
							</tr>
							
						</tbody>
					</table>
				</div>
			</div> <!-- trms-div02 end -->
			
			<div class="trms-div03">
				<div class="table-list  pri-table3">
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
					}
					</style>
					<table id="excelTable3">
						<thead>
							<tr>
								<th>NO.</th>
								<th>일자 </th>
								<th>POS </th>
								<th>영수증 </th>
								<th>멤버스번호 </th>
								<th>회원명 </th>
								<th>구분 </th>
								<th>상품권종 </th>
								<th>일련번호 </th>
								<th>금액 </th>
								<th>상품권번호</th>
							</tr>
						</thead>
						<tbody>	
							<c:forEach var="i" items="${pmgList3}" varStatus="loop">
								<tr>					
									<td>${loop.index+1}</td>
									<td>
										<fmt:parseDate value="${i.SALE_YMD}" var="SALE_YMD" pattern="yyyyMMdd"/>
										<fmt:formatDate value="${SALE_YMD}" pattern="yyyy-MM-dd"/>
									</td>
									<td>${i.POS_NO}</td>
									<td>${i.RECPT_NO}</td>
									<td>${i.CUS_NO}</td>
									<td>${i.KOR_NM}</td>
									<td>${i.COUPON_FG}</td>
									<td>${i.COUPON_NM}</td>
									<td>${i.SEQ_NO}</td>
									<td><fmt:formatNumber value="${i.FACE_AMT}" pattern="#,###"/></td>
									<td class="excelNumber">${i.COUPON_NO}</td>
								</tr>
							</c:forEach>				
							<tr class="bg-red total">
								<td colspan="9">합계</td>
							   	<td><fmt:formatNumber value="${face_tot}" pattern="#,###"/></td>
							   	<td></td>							   	
							</tr>						
						</tbody>
					</table>
				</div>
			</div> <!-- trms-div03 end -->
			
		</div>
	</div>
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>