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
	var filename = "계정별 집계표";
	var table = "excelTable";
    exportExcel(filename, table);
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
	var tmp = $("#doc_type option:checked").text();
	$("#doc_area").html(tmp);
	
	tmp = "["+$("#status_fg").val()+"]"+$("#status_fg option:checked").text();
	$("#type_area").html(tmp);
	Popup($(".pri-table").html(),$(".css-box").text());
}
var mywindow = "";
function Popup(data,css)
{
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
// mywindow.print();
// mywindow.close();
return true;
}
function goPrint2()
{
	var h = mywindow.document.getElementById("hideBtn");
	h.parentNode.removeChild(h);
	mywindow.print();
	mywindow.close();
}
$(document).ready(function(){
	getDoc();
	setBundang();
// 	getProcList();
});
function getDoc()
{
	if($("#doc_type").val() == '')
	{
		$(".status_fg").html("전체");
		$("#status_fg").val('');
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "./getDoc",
			dataType : "text",
			async : false,
			data : 
			{
				type_l : $("#doc_type").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				if(result.length > 0)
				{
					$(".status_fg").html('전체');
					$("#status_fg").val('');
					for(var i = 0; i < result.length; i++)
					{
						$("#status_fg").append('<option value="'+result[i].TYPE_S+'">'+result[i].KOR_NM+'</option>');
						$(".status_fg_ul").append('<li>'+result[i].KOR_NM+'</li>');
					}
				}
			}
		});
	}
}
function getProcList()
{
	getListStart();
	$.ajax({
		type : "POST", 
		url : "./getTally",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			start_ymd : $("#start_ymd").val(),
			end_ymd : $("#end_ymd").val(),
			doc_type : $("#doc_type").val(),
			status_fg : $("#status_fg").val()
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
			if(result.length > 0)
			{
				var fin_amt_dr = 0;
				var fin_amt_cr = 0;
				for(var i = 0; i < result.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+nullChk(result[i].BA)+'</td>';
					inner += '	<td>'+nullChk(result[i].BA_NM)+'</td>';
					inner += '	<td>'+nullChk(result[i].ACCT_CODE)+'</td>';
					inner += '	<td>'+nullChk(result[i].ACCT_NM)+'</td>';
					inner += '	<td class="print-pay">'+comma(nullChkZero(result[i].AMT_DR))+'</td>';
					inner += '	<td class="print-pay">'+comma(nullChkZero(result[i].AMT_CR))+'</td>';
					inner += '</tr>';
					
					fin_amt_dr += Number(result[i].AMT_DR);
					fin_amt_cr += Number(result[i].AMT_CR);
					
					if(result.length-1 == i)
					{
						inner += '<tr class="tr-tfoot">';
						inner += '	<td colspan="4" class="bold">합계</td>';	
						inner += '	<td class="print-pay">'+comma(fin_amt_dr)+'</td>';
						inner += '	<td class="print-pay">'+comma(fin_amt_cr)+'</td>';
						inner += '</tr>';
					}
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="6"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target").html(inner);
			getListEnd();
		}
	});
}
</script>
<div class="sub-tit">
	<h2>계정별 집계표</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>


<div class="table-top">
	<div class="top-row">
		<div class="wid-15">
			<div class="table table-auto">
				<div>
					<select id="hq" name="hq" de-data="[00] 애경유통">
						<option value="00">[00] 애경유통</option>
					</select>
				</div>
				<div>
					<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch" onchange="">
						<c:forEach var="i" items="${branchList}" varStatus="loop">
							<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		
		<div class="wid-4">
			<div class="table table-90 margin-auto">
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
		
		
		<div class="wid-15">
			<div class="table margin-auto">
				<div class="sear-tit sear-tit_left">DocType</div>
				<div>
					<select id="doc_type" de-data="전체" name="doc_type" onchange="getDoc()">
						<option value="">전체</option>
						<option value="VB">[VB]매입</option>
						<option value="VC">[VC]카드</option>
						<option value="VD">[VD]COD</option>
						<option value="VE">[VE]저장품</option>
						<option value="VG">[VG]상품권</option>
						<option value="VJ">[VJ]상품권자가소비</option>
						<option value="VM">[VM]사용매출</option>
						<option value="VN">[VN]매매익</option>
						<option value="VO">[VO]특정매출조정</option>
						<option value="VS">[VS]매출정산</option>
						<option value="VT">[VT]임대관리</option>
						<option value="VU">[VU]특판</option>
						<option value="VV">[VV]문화아카데미</option>
						<option value="VY">[VY]대금지불</option>
					</select>
					<!--  <a class="btn btn02 mrg-l6" onclick="javascript:getProcList();">조회</a>  -->
				</div>
				
			</div>
		</div>
		
		<div class="status_fgwr">
			<div class="table margin-auto">
				
				<div class="sear-tit sear-tit_left">업무구분</div>
				<div>
					<select id="status_fg" name="status_fg" de-data="전체">
						<option value="">전체</option>
					</select>
					<!--  <a class="btn btn02 mrg-l6" onclick="javascript:getProcList();">조회</a>  -->
				</div>
			</div>
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getProcList();">
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
		margin:0;
		padding:0;
		box-sizing:border-box;
	}
	table td, table th {
		border:0;
		border: 1px solid #000;
		padding:2px;
		font-size:10px;
		text-align:Center;
		
	}
	table { page-break-after:auto }
	tr    { page-break-inside:avoid; page-break-after:auto }
	td    { page-break-inside:avoid; page-break-after:auto }
	thead { display:table-header-group }
	tfoot { display:table-footer-group }
	table {
	    border-collapse: collapse;
	    border-spacing: 0;
	    width: 100%;
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
	body {
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
	}
	.contract-box .ct-kor{
		margin-bottom:60px;
	}
	table.cl-table td{
		border-left: 1px solid #000;
	}
	table.cl-table  {
	    border:1px solid #000;
	}
	table.cl-table th.table-bg{
    	background: #fafafa;
	}
	table.cl-table01 {
	    border-top: 2px solid #cfb6a4;
    	margin-top: 30px;
	}
	ul, li{
		margin:0;
		list-style:none;
	}
	.trms-pritop{
		margin-bottom:5px;
	}
	.trms-prit01 ul, .trms-prit01{
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
		width:60px;
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
	/*	table-layout:fixed;*/
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
	
	table tbody .tr-tfoot td {
		background-color:#edf1f6 !important; -webkit-print-color-adjust:exact;
		font-weight:700;
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
	.trms-prit01 ul{
		min-height:50px;
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
			<div class="trms-pril">
				<ul>
					<li><span>보안등급</span><span>:</span>대외비</li>
					<li><span>보안년한</span><span>:</span>3년</li>
					<li><span>Report_ID</span><span>:</span>APClose0201</li>
				</ul>
				<table>
					<tr>
						<td rowspan="2">발<br>생<br>부<br>서</td>
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
		<div><div class="double-line"><h1>계정별 집계표</h1></div></div>
		<div>
			<div class="trms-prir">
				<ul>
					<li><span>인쇄일 : </span><em class="print-date"></em></li>
					<li><span>인쇄자 : </span>문화아카데미 ${login_name}</li>
				</ul>
				<table>
					<tr>
						<td rowspan="2">재<br>무<br>부<br>서</td>
						<td>담 당</td>
						<td>입 안</td>
						<td>심 사</td>
						<td>결 정</td>
					</tr>
					<tr class="trms-pritable">
						<td></td>
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
<%-- 		<div>POS ${pos_no }번</div> --%>
		<div>조회기간 : <span id="search_area"></span></div>
		<div>Doc Type : <span id="doc_area"></span></div>
		<div>업무구분 : <span id="type_area"></span></div>
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
	<div class="table-list pri-table payment-table">
		<table id="excelTable">
			<thead>
				<tr>
					<th>회계단위</th>
					<th>회계단위명</th>
					<th>계정코드</th>
					<th>계정명</th>
					<th>차변금액</th>
					<th>대변금액</th>
				</tr>
				
			</thead>
			<tbody id="list_target">
			
				
			</tbody>
		</table>
	</div>

	
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>