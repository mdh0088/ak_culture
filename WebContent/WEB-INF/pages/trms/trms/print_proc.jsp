<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script>
function comma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
$(document).ready(function(){
	var result = JSON.parse('${result}');
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
// 	window.print();
});
</script>
<style type="text/css">
@media print {
	table td, table th {
		border:0;
		border: 1px solid #e0e0e0;
		padding:5px;
		font-size:12px;
		
		
	}
	table {
	    border-collapse: collapse;
	    border-spacing: 0;
	    width: 100%;
	}
	body {
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
	}
	.pri-tr01{
		background:#edf1f6;
	}
	.pri-tr04{
		background:#edf6f6;	
	}
	.pri-table tbody tr > td:nth-child(2){
		text-align:left;
	}
	.pri-table tbody .pri-tr02 > td:nth-child(2){
		padding-left:30px;
	}
	.pri-table tbody .pri-tr03 > td:nth-child(2){
		padding-left:60px;
	}
	.table-list td{
		word-break:break-all;
	}
	.table-stype01 th{
		white-space:nowrap;
	}
	
}
</style>
<table id="excelTable" class="pri-table">
	<colgroup>
		<col width="10%" />
		<col width="40%" />
		<col width="30%" />
		<col width="20%" />
	</colgroup>
	<thead>
		<tr>
			<th>NO. </th>
			<th>정산항목 </th>
			<th>정산금액 </th>
			<th>정산건수 </th>
		</tr>
	</thead>
	<tbody id="list_target">
	</tbody>
</table>