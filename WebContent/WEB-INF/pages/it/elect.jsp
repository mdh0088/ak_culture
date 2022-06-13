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
	var filename = "법인강사료 전자증빙";
	var table = "excelTable";
    exportExcel(filename, table);
}
$(document).ready(function(){
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
});
function periInit()
{
	getPayMonth('regis');
}
function selChange(idx)
{
	var val = idx.replace("vat_fg_", "");
	var lect_pay = $("#lect_pay_"+val).html().replace(/,/gi, "");
	var net_lect_pay = 0;
	var vat = 0;
	if($("#"+idx).val() == "YC")
	{
		vat = Math.floor((Number(lect_pay) / 1.1) * 0.1);
		net_lect_pay = Number(lect_pay) - vat;
	}
	else
	{
		net_lect_pay = lect_pay;
		vat = 0;
	}
	$("#vat_"+val).html(comma(vat));
	$("#net_lect_pay_"+val).html(comma(net_lect_pay));
}
function getList()
{
	getListStart();
	$.ajax({
		type : "POST", 
		url : "./getElectList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			lect_ym : $("input[name='lect_ym']:checked").val(),
			journal_yn : $("#journal_yn").val(),
			store : $("#selBranch").val(),
			period : $("#selPeri").val()
			
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
			$("#list_target").html('');
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					var inner = "";
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'"></label>';
					inner += '	</td>';
					inner += '	<td onclick="getDetailLecr(\''+encodeURI(JSON.stringify(result.list[i]))+'\')">'+result.list[i].CO_NM+'</td>';
					inner += '	<td id="lect_pay_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'">'+comma(result.list[i].LECT_PAY)+'</td>';
					inner += '	<td id="net_lect_pay_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'">'+comma(result.list[i].EX_AMT)+'</td>';
					inner += '	<td id="vat_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'">'+comma(result.list[i].VAT)+'</td>';
					inner += '	<td>'+result.list[i].PHONE_NO+'</td>';
					inner += '	<td>'+result.list[i].BIZ_NO+'</td>';
					inner += '	<td>'+result.list[i].PRESIDENT_NM+'</td>';
					inner += '	<td>'+cutDate(result.list[i].CREATE_DATE)+'</td>';
					inner += '	<td class="select-100"><select id="vat_fg_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'" onchange="selChange(\'vat_fg_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'\')">';
					inner += '			<option value="">선택해주세요.</option>';
					inner += '			<option value="YC">세금계산서</option>';
					inner += '			<option value="X4">계산서</option>';
					inner += '	</select></td>';
					inner += '	<td><input type="text" class="date-i" id="pay_day_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'" value="'+cutDate(trim(result.list[i].PAY_DAY))+'"></td>';
					inner += '	<td><input type="text" class="date-i" id="accept_ymd_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)+'" value="'+cutDate(result.list[i].ACCEPT_YMD)+'"></td>';
					inner += '	<td>'+result.list[i].ACCEPT_YN+'</td>';
					inner += '	<td>'+result.list[i].JOURNAL_YN+'</td>';
					inner += '</tr>';
					$("#list_target").append(inner);
					$('#vat_fg_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ)).val(nullChk(result.list[i].VAT_FG));
					selChange('vat_fg_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].LECT_YM+'_'+result.list[i].LECTURER_CD+'_'+result.list[i].ACCEPT_YN+'_'+result.list[i].JOURNAL_YN+'_'+trim(result.list[i].SEQ));
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="14"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});	
}
function saveElect()
{
	var chkList = "";
	var chkArr = document.getElementsByName("chk_val");
	for(var i = 0; i < chkArr.length; i++)
	{
		if(chkArr[i].checked == true)
		{
			var chk = chkArr[i].id.replace("chk_", "");
			var vat_fg = $("#vat_fg_"+chk).val();
			var pay_day = $("#pay_day_"+chk).val().replace(/-/gi, "");
			var accept_ymd = $("#accept_ymd_"+chk).val().replace(/-/gi, "");
			var accept_yn = nullChk(chk.split("_")[4]);
			var journal_yn = nullChk(chk.split("_")[5]);
			var seq = nullChk(chk.split("_")[6]);
			if(seq == "")
			{
				seq = "undefined";
				chk += "undefined";
			}
			
			chkList += chk;
			chkList += "_"+vat_fg;
			chkList += "_"+pay_day;
			chkList += "_"+accept_ymd;
			chkList += "|";
			if(vat_fg == '')
			{
				alert("구분에 [세금계산서/계산서]중 한가지를 선택해 주십시요.");
				return;
			}
			if(accept_yn == 'Y')
			{
				alert("세금계산서/계산서 발행된 법인업체는 수취수동 등록이 불가능합니다.");
				return;
			}
			if(journal_yn == "Y") {
				alert("분개된 법인업체는 수취수동 등록이 불가능합니다.");
				return;
			}
			if(pay_day.length < 8) {
				alert("지급일자를 선택해주세요.");
				return;
			}
			
			if(accept_ymd == "") {
				alert("수취일자를 입력해주세요.");
				return;
			}
			
			if(accept_ymd.length < 8) {
				alert("수취일자를 선택해주세요.");
				return;
			}
			
			if(seq != "undefined") {
				alert("일련번호가 존재합니다. 수취 수동 등록 불가!");
				return;
			}
			
		}
	}
	if(chkList != "")
	{
		$.ajax({
			type : "POST", 
			url : "./saveElect",
			dataType : "text",
			async : false,
			data : 
			{
				chkList : chkList
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
	    			alert(result.msg);
 	    			location.reload();
	    		}
	    		else
	    		{
		    		alert(result.msg);
	    		}
			}
		});	
	}
	else
	{
		alert("저장할 데이터를 선택해주세요.");
	}
	
}
function getDetailLecr(ret)
{
	var r = JSON.parse(decodeURI(ret));
	$.ajax({
		type : "POST", 
		url : "./getElectDetailList",
		dataType : "text",
		async : false,
		data : 
		{
			store : r.STORE,
			period : r.PERIOD,
			lecturer_cd : r.LECTURER_CD,
			lect_ym : r.LECT_YM
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
				for(var i = 0; i < result.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+result[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+cutYoil(result[i].DAY_FLAG)+'</td>';
					inner += '	<td>'+result[i].WEB_LECTURER_NM+'</td>';
					inner += '	<td>'+result[i].FIX_PAY_YN+'</td>';
					if(result[i].FIX_PAY_YN == "정액")
					{
						inner += '	<td>'+comma(result[i].FIX_AMT)+'</td>';
					}
					else
					{
						inner += '	<td>'+result[i].FIX_RATE+'</td>';
					}
					inner += '	<td>'+comma(result[i].LECT_PAY)+'</td>';
					inner += '	<td>'+comma(result[i].TOT_REGIS_NO)+'</td>';
					inner += '</tr>';
				}
				$("#detail_target").html(inner);
				$("#detail_layer").fadeIn(200);
			}
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>법인강사료 전자증빙</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn01" onclick="javascript:saveElect();">저장</a>
	</div>
</div>


<div class="table-top">
	<div class="top-row sear-wr">
		<div>
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<div class=" sel-scr">
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>			
		</div>		
		<div class="mag-l4">
			<div class="table table-auto">
				<div class="sear-tit">대상연월</div>
				<div>
					<ul class="chk-ul" id="ul_radio">
							
					</ul>
				</div>
			</div>
		</div>
		<div class="wid-2 mag-l2">
			<div class="table">
				<div class="sear-tit sear-tit_120 sear-tit_left">분개여부</div>
				<div>
					<select de-data="전체" id="journal_yn" name="journal_yn">
						<option value="">전체</option>
						<option value="Y">분개</option>
						<option value="N">미분개</option>
					</select>
				</div>
			</div>
		</div>	
		
	</div>
	
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getList();">
</div>


<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="table table02 table-auto float-right sel-scr">
			<div>			
				<a class="bor-btn btn01" href="#"><i class="material-icons">local_printshop</i></a>
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
				<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
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
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="100px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="140px">
				<col width="100px">
				<col width="100px">
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_co_nm')">법인명<img src="/img/th_up.png" id="sort_co_nm"></th>
					<th onclick="reSortAjax('sort_lect_pay')">강사료<img src="/img/th_up.png" id="sort_lect_pay"></th>
					<th onclick="reSortAjax('sort_ex_amt')">공급가액<img src="/img/th_up.png" id="sort_ex_amt"></th>
					<th onclick="reSortAjax('sort_vat')">부가세<img src="/img/th_up.png" id="sort_vat"></th>
					<th onclick="reSortAjax('sort_phone_no')">전화번호<img src="/img/th_up.png" id="sort_phone_no"></th>
					<th onclick="reSortAjax('sort_biz_no')">사업자번호<img src="/img/th_up.png" id="sort_biz_no"></th>
					<th onclick="reSortAjax('sort_president_nm')">대표자명<img src="/img/th_up.png" id="sort_president_nm"></th>
					<th onclick="reSortAjax('sort_create_date')">작성일<img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_vat_fg')">구분<img src="/img/th_up.png" id="sort_vat_fg"></th>
					<th onclick="reSortAjax('sort_pay_day')">지급일자<img src="/img/th_up.png" id="sort_pay_day"></th>
					<th onclick="reSortAjax('sort_accept_ymd')">수취일시<img src="/img/th_up.png" id="sort_accept_ymd"></th>
					<th onclick="reSortAjax('sort_accept_yn')">발행여부<img src="/img/th_up.png" id="sort_accept_yn"></th>
					<th onclick="reSortAjax('sort_journal_yn')">분개여부<img src="/img/th_up.png" id="sort_journal_yn"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list  table-csplist">
		<table id="excelTable">
			<colgroup>
				<col width="40px">
				<col width="100px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="140px">
				<col width="100px">
				<col width="100px">
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_co_nm')">법인명<img src="/img/th_up.png" id="sort_co_nm"></th>
					<th onclick="reSortAjax('sort_lect_pay')">강사료<img src="/img/th_up.png" id="sort_lect_pay"></th>
					<th onclick="reSortAjax('sort_ex_amt')">공급가액<img src="/img/th_up.png" id="sort_ex_amt"></th>
					<th onclick="reSortAjax('sort_vat')">부가세<img src="/img/th_up.png" id="sort_vat"></th>
					<th onclick="reSortAjax('sort_phone_no')">전화번호<img src="/img/th_up.png" id="sort_phone_no"></th>
					<th onclick="reSortAjax('sort_biz_no')">사업자번호<img src="/img/th_up.png" id="sort_biz_no"></th>
					<th onclick="reSortAjax('sort_president_nm')">대표자명<img src="/img/th_up.png" id="sort_president_nm"></th>
					<th onclick="reSortAjax('sort_create_date')">작성일<img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_vat_fg')">구분<img src="/img/th_up.png" id="sort_vat_fg"></th>
					<th onclick="reSortAjax('sort_pay_day')">지급일자<img src="/img/th_up.png" id="sort_pay_day"></th>
					<th onclick="reSortAjax('sort_accept_ymd')">수취일시<img src="/img/th_up.png" id="sort_accept_ymd"></th>
					<th onclick="reSortAjax('sort_accept_yn')">발행여부<img src="/img/th_up.png" id="sort_accept_yn"></th>
					<th onclick="reSortAjax('sort_journal_yn')">분개여부<img src="/img/th_up.png" id="sort_journal_yn"></th>
				</tr>
				
			</thead>
			<tbody id="list_target">
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td class="tdbtn_cal"> -->
<!-- 						<span> -->
<!-- 							<input type="text" class="date-i" value="2019-09-06" /> -->
<!-- 							<i class="material-icons">event_available</i></td> -->
<!-- 						</span> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr class="hide-tr"> -->
<!-- 					<td colspan="14"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								<col width="7%;" /> --%>
<%-- 								<col width="15%;" /> --%>
<%-- 								<col width="5%;" /> --%>
<%-- 								<col width="8.3%;" /> --%>
<%-- 								<col width="7%;" /> --%>
<%-- 								<col width="7.2%;" /> --%>
<%-- 								<col width="7.2%;" /> --%>
<%-- 								<col /> --%>
<%-- 							</colgroup> --%>
<!-- 							<thead> -->
<!-- 								<tr> -->
<!-- 									<th>NO.</th> -->
<!-- 									<th>강좌명</th> -->
<!-- 									<th>요일</th> -->
<!-- 									<th>지급기준</th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 								</tr> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>트니트니 율동체조</td> -->
<!-- 									<td>금</td> -->
<!-- 									<td>정률</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>트니트니 율동체조</td> -->
<!-- 									<td>금</td> -->
<!-- 									<td>정률</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>트니트니 율동체조</td> -->
<!-- 									<td>금</td> -->
<!-- 									<td>정률</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</td> -->
				
<!-- 				</tr> -->
				
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td class="tdbtn_red"><span>입력</span></td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
	
</div>
<div id="detail_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#detail_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">상세 강좌내용</h3>
        			
        			<div class="table-list table-csplist table-wid10" style="display:block !important;">
						<table>
							<thead>
								<tr>
									<th>강좌명</th>
									<th>요일</th>
									<th>강사명</th>
									<th>지급구분</th>
									<th>지급기준</th>
									<th>지급액</th>
									<th>현원</th>
								</tr>
							</thead>
							<tbody id="detail_target">
							</tbody>
						</table>
					</div>
        			
	        	</div>
        	</div>
        </div>
    </div>	
</div>

<div id="detail_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#detail_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">상세 강좌내용</h3>
        			<div class="table table02 table-searnum">
						<div class="wid-5 sel-scr">
						</div>
	        		</div>
	        		<div class="top-row">
						<div class="table-list table-csplist table-wid10" style="display:block !important;">
							<table>
								<thead>
									<tr>
										<th>강좌명</th>
										<th>요일</th>
										<th>강사명</th>
										<th>지급구분</th>
										<th>지급기준</th>
										<th>지급액</th>
										<th>현원</th>
									</tr>
								</thead>
								<tbody id="detail_target">
								</tbody>
							</table>
						</div>
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