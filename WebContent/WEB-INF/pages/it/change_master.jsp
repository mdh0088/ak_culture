<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown()
{
	var filename = "강사료 기준 변경";
	var table = "excelTable";
    exportExcel(filename, table);
}
var store = "";
var period = "";
var subject_cd = "";
function getList(paging_type) 
{
	$.ajax({
		type : "POST", 
		url : "./getChange",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			
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
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					var regis_no = Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO));
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner += '		<input type="radio" id="radio_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" value="'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" name="radio_change">';
					inner += '		<label for="radio_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'"></label>';
					inner += '	</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+result.list[i].WEB_LECTURER_NM+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].BMD))+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td class="color-blue">'+regis_no+'</td>';
					inner += '	<td class="color-red">'+result.list[i].A_CNT+'</td>';
					inner += '	<td>'+comma(Number(result.list[i].REGIS_FEE) * Number(regis_no))+'</td>';
					
					var tot_regis_fee = 0; //강사료 지급액
					var tot_sale = Number(result.list[i].REGIS_FEE) * Number(regis_no); //총 매출액
					if(result.list[i].CONFIRM_YN == "2")
					{
						if(result.list[i].PREV_FIX_PAY_YN == 'Y')
						{
							tot_regis_fee = Number(result.list[i].PREV_FIX_AMT) * Number(result.list[i].LECT_CNT);
							inner += '	<td class="bg-gray">정액</td>';
							inner += '	<td class="bg-gray">'+comma(result.list[i].PREV_FIX_AMT)+'</td>'
						}
						else
						{
							tot_regis_fee = Number(result.list[i].REGIS_FEE) * Number(regis_no) * (Number(result.list[i].PREV_FIX_RATE) / 100);
							inner += '	<td class="bg-gray">정률</td>';
							inner += '	<td class="bg-gray">'+result.list[i].PREV_FIX_RATE+'</td>'
						}
						inner += '	<td class="bg-gray">'+comma(tot_regis_fee)+'</td>';
					}
					else
					{
						if(result.list[i].FIX_PAY_YN == 'Y')
						{
							tot_regis_fee = Number(result.list[i].FIX_AMT) * Number(result.list[i].LECT_CNT);
							inner += '	<td class="bg-gray">정액</td>';
							inner += '	<td class="bg-gray">'+comma(result.list[i].FIX_AMT)+'</td>'
						}
						else
						{
							tot_regis_fee = Number(result.list[i].REGIS_FEE) * Number(regis_no) * (Number(result.list[i].FIX_RATE) / 100);
							inner += '	<td class="bg-gray">정률</td>';
							inner += '	<td class="bg-gray">'+result.list[i].FIX_RATE+'</td>'
						}
						inner += '	<td class="bg-gray">'+comma(tot_regis_fee)+'</td>';
					}
					if(tot_sale != 0)
					{
						inner += '	<td class="bg-gray">'+(1-(tot_regis_fee/tot_sale)).toFixed(2)+'</td>';
					}
					else
					{
						inner += '	<td class="bg-gray"></td>';
					}
					if(result.list[i].NEXT_FIX_PAY_YN == 'Y')
					{
						tot_regis_fee = Number(result.list[i].NEXT_FIX_AMT) * Number(result.list[i].LECT_CNT);
						inner += '	<td class="bg-blue">정액</td>';
						inner += '	<td class="bg-blue">'+comma(result.list[i].NEXT_FIX_AMT)+'</td>'
						inner += '	<td class="bg-blue">'+comma(tot_regis_fee)+'</td>';
					}
					else if(result.list[i].NEXT_FIX_PAY_YN == 'N')
					{
						tot_regis_fee = Number(result.list[i].REGIS_FEE) * Number(regis_no) * (Number(result.list[i].NEXT_FIX_RATE) / 100);
						inner += '	<td class="bg-blue">정률</td>';
						inner += '	<td class="bg-blue">'+result.list[i].NEXT_FIX_RATE+'</td>'
						inner += '	<td class="bg-blue">'+comma(tot_regis_fee)+'</td>';
					}
					else
					{
						inner += '	<td class="bg-blue"></td>';
						inner += '	<td class="bg-blue"></td>';
						inner += '	<td class="bg-blue"></td>';
					}
					if(tot_sale != 0)
					{
						inner += '	<td class="bg-blue">'+(1-(tot_regis_fee/tot_sale)).toFixed(2)+'</td>';
					}
					else
					{
						inner += '	<td class="bg-blue"></td>';
					}
					if(nullChk(result.list[i].NEXT_FIX_PAY_YN) == "")
					{
						inner += '	<td></td>';
						inner += '	<td></td>';
						inner += '	<td></td>';
						inner += '	<td></td>';
						inner += '	<td></td>';
					}
					else
					{
						inner += '	<td>'+cutDate(result.list[i].NEXT_CREATE_DATE) +'</td>';
						inner += '	<td>'+result.list[i].NEXT_CREATE_NAME +'</td>';
						if(result.list[i].CONFIRM_YN == "1")
						{
							inner += '	<td>신청</td>';
							inner += '	<td></td>';
							inner += '	<td></td>';
							
						}
						else if(result.list[i].CONFIRM_YN == "2")
						{
							inner += '	<td>승인</td>';
							inner += '	<td>'+cutDate(result.list[i].NEXT_UPDATE_DATE)+'</td>';
							inner += '	<td>'+result.list[i].NEXT_UPDATE_NAME +'</td>';
						}
						else if(result.list[i].CONFIRM_YN == "3")
						{
							inner += '	<td>반려</td>';
							inner += '	<td>'+cutDate(result.list[i].NEXT_UPDATE_DATE)+'</td>';
							inner += '	<td>'+result.list[i].NEXT_UPDATE_NAME +'</td>';
						}
					}
					
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="23"><div class="no-data">검색결과가 없습니다.</div></td>';
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
		}
	});	
}
function change()
{
	if(typeof $('input[name="radio_change"]:checked').val() == undefined)
	{
		alert("변경할 강좌를 선택해주세요.");
		return;
	}
	else
	{
		$('#change_layer').fadeIn(200);	
		store = $('input[name="radio_change"]:checked').val().split("_")[0];
		period = $('input[name="radio_change"]:checked').val().split("_")[1];
		subject_cd = $('input[name="radio_change"]:checked').val().split("_")[2];
		$.ajax({
			type : "POST", 
			url : "./getChangeOne",
			dataType : "text",
			async : false,
			data : 
			{
				store : store,
				period : period,
				subject_cd : subject_cd
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
				inner += '<tr>';
				inner += '	<td style="cursor:pointer;">'+result[0].WEB_LECTURER_NM+'</td>';
				inner += '	<td>'+cutDate(result[0].BMD)+'</td>';
				inner += '	<td>'+result[0].SUBJECT_NM+'</td>';
				inner += '</tr>';
				
				$("#change_target").html(inner);
				
				var tot_sale = Number(result[0].REGIS_FEE) * (Number(result[0].REGIS_NO) + Number(result[0].WEB_REGIS_NO)); //총 매출액
				var tot_regis_fee = 0; //강사료 지급액
				if(result[0].PREV_FIX_PAY_YN == "Y")
				{
					tot_regis_fee = Number(result[0].PREV_FIX_AMT) * (Number(result[0].LECT_CNT));
					$("#prev_fix_pay_yn").val("정액");
					$("#prev_fix_data").val(comma(result[0].PREV_FIX_AMT));
				}
				if(result[0].PREV_FIX_PAY_YN == "N")
				{
					tot_regis_fee = Number(result[0].REGIS_FEE) * (Number(result[0].REGIS_NO) + Number(result[0].WEB_REGIS_NO)) * (Number(result[0].PREV_FIX_RATE) / 100);
					$("#prev_fix_pay_yn").val("정률");
					$("#prev_fix_data").val(result[0].PREV_FIX_RATE);
				}
				$("#prev_total_pay").val(comma(tot_regis_fee));
				$("#prev_sonic_pay").val((1-(tot_regis_fee/tot_sale)).toFixed(2));
				if(result[0].NEXT_FIX_PAY_YN == "Y")
				{
					tot_regis_fee = Number(result[0].NEXT_FIX_AMT) * (Number(result[0].LECT_CNT));
					$("#next_fix_pay_yn").val("정액");
					$("#next_fix_data").val(comma(result[0].NEXT_FIX_AMT));
				}
				if(result[0].NEXT_FIX_PAY_YN == "N")
				{
					tot_regis_fee = Number(result[0].REGIS_FEE) * (Number(result[0].REGIS_NO) + Number(result[0].WEB_REGIS_NO)) * (Number(result[0].NEXT_FIX_RATE) / 100);
					$("#next_fix_pay_yn").val("정률");
					$("#next_fix_data").val(result[0].NEXT_FIX_RATE);
				}
				$("#next_total_pay").val(comma(tot_regis_fee));
				$("#next_sonic_pay").val((1-(tot_regis_fee/tot_sale)).toFixed(2));
				$("#change_reason").val(repWord(result[0].CHANGE_REASON));
				
			}
		});	
	}
}
function changeApprove(val)
{
	$.ajax({
		type : "POST", 
		url : "./changeApprove",
		dataType : "text",
		async : false,
		data : 
		{
			act : val,
			store : store,
			period : period,
			subject_cd : subject_cd,
			no_reason : $("#no_reason").val()
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
    		}
    		else
    		{
	    		alert(result.msg);
    		}
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>강사료 기준 변경(팀장권한)</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>

	<div class="table-top">
		<div class="top-row sear-wr">
			<div class="wid-3">
				<div class="table table-auto">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<div class="oddn-sel02">
					<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
				</div>
			</div>
			<div class="wid-10">
				<div class="search-wr">
					<select id="search_type" name="search_type" de-data="검색항목">
						<option value="lecr_name">강사명</option>
						<option value="subject_nm">강좌명</option>
						<option value="subject_cd">강좌코드</option>
					</select>
					<input type="hidden" id="page" name="page" value="${page}">
				    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
				    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
					<input type="hidden" id="order_by" name="order_by" value="${order_by}">
				    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
				</div>
			</div>
<!-- 			<div class=""> -->
<!-- 				<div class="table table-auto"> -->
<!-- 					<div class="sear-tit sear-tit_left">대상연월</div> -->
<!-- 					<div> -->
<!-- 						<div> -->
<!-- 							<input type="text" class="date-i ready-i" id="" name=""> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class=""> -->
<!-- 				<div class="table table-auto"> -->
<!-- 					<div class="sear-tit sear-tit_left">법인/개인</div> -->
<!-- 					<div> -->
<!-- 						<select de-data="전체"> -->
<!-- 							<option>법인</option> -->
<!-- 							<option>개인</option> -->
<!-- 						</select> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
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
					<a class="btn mrg-lr6 btn03" onclick="javascript:change();">변경승인</a>				
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
	<input type="hidden" id="page" name="page" value="${page}">
	<input type="hidden" id="order_by" name="order_by" value="${order_by}">
    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">

<div class="table-wr color-table">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
				<col width="100px">
				<col>
				<col>
				<col width="250px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th rowspan="2" class="td-chk">
					</th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')" rowspan="2">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_bmd')" rowspan="2">생년월일<img src="/img/th_up.png" id="sort_bmd"></th>
					<th onclick="reSortAjax('sort_subject_fg')" rowspan="2">강좌<br>유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_subject_cd')" rowspan="2">강좌<br>코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')" rowspan="2">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_tot_regis_no')" colspan="2">회원<br>현황<img src="/img/th_up.png" id="sort_tot_regis_no"></th>
					<th onclick="reSortAjax('sort_tot_regis_fee')" rowspan="2">총 <br>수강료<img src="/img/th_up.png" id="sort_tot_regis_fee"></th>
					<th colspan="4">변경 전</th>
					<th colspan="4">변경 후</th>
					<th onclick="reSortAjax('sort_next_create_date')" rowspan="2">신청일<img src="/img/th_up.png" id="sort_next_create_date"></th>
					<th onclick="reSortAjax('sort_next_create_name')" rowspan="2">신청자<img src="/img/th_up.png" id="sort_next_create_name"></th>
					<th onclick="reSortAjax('sort_confirm_yn')" rowspan="2">처리현황<img src="/img/th_up.png" id="sort_confirm_yn"></th>
					<th onclick="reSortAjax('sort_next_update_date')" rowspan="2">승인일<img src="/img/th_up.png" id="sort_next_update_date"></th>
					<th onclick="reSortAjax('sort_next_update_name')" rowspan="2">결재자<img src="/img/th_up.png" id="sort_next_update_name"></th>				
				</tr>
				<tr class="table-csptr">
					<th>총 현원</th>
					<th>A-CLASS</th>
					<th onclick="reSortAjax('sort_fix_pay_yn')">지급구분<img src="/img/th_up.png" id="sort_fix_pay_yn"></th>
					<th>지급기준</th>
					<th>총강사료</th>
					<th>손익률</th>	
					<th onclick="reSortAjax('sort_next_fix_pay_yn')">지급구분<img src="/img/th_up.png" id="sort_next_fix_pay_yn"></th>
					<th>지급기준</th>
					<th>총강사료</th>
					<th>손익률</th>	
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-csplist">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
				<col width="100px">
				<col>
				<col>
				<col width="250px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th rowspan="2" class="td-chk">
					</th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')" rowspan="2">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_bmd')" rowspan="2">생년월일<img src="/img/th_up.png" id="sort_bmd"></th>
					<th onclick="reSortAjax('sort_subject_fg')" rowspan="2">강좌<br>유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_subject_cd')" rowspan="2">강좌<br>코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')" rowspan="2">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_tot_regis_no')" colspan="2">회원<br>현황<img src="/img/th_up.png" id="sort_tot_regis_no"></th>
					<th onclick="reSortAjax('sort_tot_regis_fee')" rowspan="2">총 <br>수강료<img src="/img/th_up.png" id="sort_tot_regis_fee"></th>
					<th colspan="4">변경 전</th>
					<th colspan="4">변경 후</th>
					<th onclick="reSortAjax('sort_next_create_date')" rowspan="2">신청일<img src="/img/th_up.png" id="sort_next_create_date"></th>
					<th onclick="reSortAjax('sort_next_create_name')" rowspan="2">신청자<img src="/img/th_up.png" id="sort_next_create_name"></th>
					<th onclick="reSortAjax('sort_confirm_yn')" rowspan="2">처리현황<img src="/img/th_up.png" id="sort_confirm_yn"></th>
					<th onclick="reSortAjax('sort_next_update_date')" rowspan="2">승인일<img src="/img/th_up.png" id="sort_next_update_date"></th>
					<th onclick="reSortAjax('sort_next_update_name')" rowspan="2">결재자<img src="/img/th_up.png" id="sort_next_update_name"></th>				
				</tr>
				<tr class="table-csptr">
					<th>총 현원</th>
					<th>A-CLASS</th>
					<th onclick="reSortAjax('sort_fix_pay_yn')">지급구분<img src="/img/th_up.png" id="sort_fix_pay_yn"></th>
					<th>지급기준</th>
					<th>총강사료</th>
					<th>손익률</th>	
					<th onclick="reSortAjax('sort_next_fix_pay_yn')">지급구분<img src="/img/th_up.png" id="sort_next_fix_pay_yn"></th>
					<th>지급기준</th>
					<th>총강사료</th>
					<th>손익률</th>	
				</tr>
				
			</thead>
			<tbody id="list_target">
<%-- 				<c:forEach var="i" items="${list}" varStatus="loop"> --%>
<!-- 					<tr> -->
<!-- 						<td class="td-chk"> -->
<%-- 							<input type="radio" id="radio_${i.STORE}_${i.PERIOD}_${fn:trim(i.SUBJECT_CD)}" value="${i.STORE}_${i.PERIOD}_${fn:trim(i.SUBJECT_CD)}" name="radio_change"> --%>
<%-- 							<label for="radio_${i.STORE}_${i.PERIOD}_${fn:trim(i.SUBJECT_CD)}"></label> --%>
<!-- 						</td> -->
<%-- 						<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">${i.WEB_LECTURER_NM}</td> --%>
<%-- 						<td>${i.ISPLAY}</td> --%>
<%-- 						<td>${fn:substring(i.BMD, 0, 4)}-${fn:substring(i.BMD, 4, 6)}-${fn:substring(i.BMD, 6, 8)}</td> --%>
<%-- 						<td>${i.SUBJECT_FG_NM}</td> --%>
<%-- 						<td>${i.SUBJECT_CD}</td> --%>
<%-- 						<td>${i.SUBJECT_NM}</td> --%>
<%-- 						<td class="color-blue">${i.REGIS_NO}</td> --%>
<%-- 						<td class="color-red">${i.A_CNT}</td> --%>
<%-- 						<td>${i.REGIS_FEE }</td> --%>
<!-- 						<td class="bg-gray"> -->
<%-- 							<c:if test="${i.FIX_PAY_YN eq 'Y'}">정액</c:if> --%>
<%-- 							<c:if test="${i.FIX_PAY_YN eq 'N'}">정률</c:if> --%>
<!-- 						</td> -->
<!-- 						<td class="bg-gray"> -->
<%-- 							<c:if test="${i.FIX_PAY_YN eq 'Y'}">${i.FIX_AMT}</c:if> --%>
<%-- 							<c:if test="${i.FIX_PAY_YN eq 'N'}">${i.FIX_RATE}</c:if> --%>
<!-- 						</td> -->
<%-- 						<td class="bg-gray">${i.REGIS_FEE * i.REGIS_NO}</td> --%>
<!-- 						<td class="bg-gray">?</td> -->
<!-- 						<td class="bg-blue"> -->
<%-- 							<c:if test="${i.NEXT_FIX_PAY_YN eq 'Y'}">정액</c:if> --%>
<%-- 							<c:if test="${i.NEXT_FIX_PAY_YN eq 'N'}">정률</c:if> --%>
<!-- 						</td> -->
<!-- 						<td class="bg-blue"> -->
<%-- 							<c:if test="${i.NEXT_FIX_PAY_YN eq 'Y'}">${i.NEXT_FIX_AMT}</c:if> --%>
<%-- 							<c:if test="${i.NEXT_FIX_PAY_YN eq 'N'}">${i.NEXT_FIX_RATE}</c:if> --%>
<!-- 						</td> -->
<%-- 						<td class="bg-blue">${i.REGIS_FEE * i.REGIS_NO}</td> --%>
<!-- 						<td class="bg-blue">?</td> -->
<%-- 						<td>${i.NEXT_CREATE_DATE }</td> --%>
<%-- 						<td>${i.NEXT_NAME }</td> --%>
<!-- 					</tr> -->
<%-- 				</c:forEach> --%>
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>진행</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>왕초보 줌마 영어반Ⅰ</td> -->
<!-- 					<td class="color-blue">47</td> -->
<!-- 					<td class="color-red">4</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td class="bg-gray">정률</td> -->
<!-- 					<td class="bg-gray">50</td> -->
<!-- 					<td class="bg-gray">3,600,000</td> -->
<!-- 					<td class="bg-gray">50</td> -->
<!-- 					<td class="bg-blue">정률</td> -->
<!-- 					<td class="bg-blue">50</td> -->
<!-- 					<td class="bg-blue">3,600,000</td> -->
<!-- 					<td class="bg-blue">50</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>이해선</td> -->
<!-- 					<td class="color-red line-blue">N</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td></td>					 -->
<!-- 				</tr> -->
<!-- 				<tr class="bg-red"> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>진행</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>왕초보 줌마 영어반Ⅰ</td> -->
<!-- 					<td class="color-blue">47</td> -->
<!-- 					<td class="color-red">4</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td class="bg-gray">정률</td> -->
<!-- 					<td class="bg-gray">50</td> -->
<!-- 					<td class="bg-gray">3,600,000</td> -->
<!-- 					<td class="bg-gray">50</td> -->
<!-- 					<td class="bg-blue">정률</td> -->
<!-- 					<td class="bg-blue">50</td> -->
<!-- 					<td class="bg-blue">3,600,000</td> -->
<!-- 					<td class="bg-blue">50</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>이해선</td> -->
<!-- 					<td>N</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>					 -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>진행</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>왕초보 줌마 영어반Ⅰ</td> -->
<!-- 					<td class="color-blue">47</td> -->
<!-- 					<td class="color-red">4</td> -->
<!-- 					<td>100,000</td> -->
<!-- 					<td class="bg-gray">정률</td> -->
<!-- 					<td class="bg-gray">50</td> -->
<!-- 					<td class="bg-gray">3,600,000</td> -->
<!-- 					<td class="bg-gray">50</td> -->
<!-- 					<td class="bg-blue">정률</td> -->
<!-- 					<td class="bg-blue">50</td> -->
<!-- 					<td class="bg-blue">3,600,000</td> -->
<!-- 					<td class="bg-blue">50</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>이해선</td> -->
<!-- 					<td>N</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>					 -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
</div>

<div id="change_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg ip-edit ">
        		<div class="close" onclick="javascript:$('#change_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
				<div>
				<!-- 여기 -->
						<h3 class="status_now">강사료 기준변경 신청</h3>
						<div class="top-row change-wrap">
							<div class="wid5">
								<div class="table-list">
									<table>
										<thead>
											<tr>
												<th>강사명</th>
												<th>생년월일</th>
												<th>강좌명</th>
											</tr>
											
										</thead>
										<tbody id="change_target">
											
										</tbody>
									
									</table>
								</div>
							</div>
							<div class="wid5-last">
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit"></div>
											<div class="wid5-inp">
												<div class="txt text-center">기존</div>
											</div>
											<div class="wid5-sel">
												<div class="txt text-center">신규</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">지급구분</div>
											<div class="wid5-inp">
												<input type="text" id="prev_fix_pay_yn" name="prev_fix_pay_yn" class="inputDisabled text-center inptxt" value="정률">
											</div>
											<div class="wid5-sel text-center ok-red">
												<input type="text" id="next_fix_pay_yn" name="next_fix_pay_yn" class="inputDisabled text-center ok-red inptxt" value="정률">
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">지급기준</div>
											<div class="wid5-inp">
												<input type="text" id="prev_fix_data" name="prev_fix_data" class="inputDisabled text-right inptxt" value="50">
											</div>
											<div class="wid5-inp">
												<input type="text" id="next_fix_data" name="next_fix_data" class="inputDisabled text-right inptxt ok-red" value="50">
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">총강사료</div>
											<div class="wid5-inp">
												<input type="text" id="prev_total_pay" name="prev_total_pay" class="inputDisabled text-right inptxt" value="?">
											</div>
											<div class="wid5-inp">
												<input type="text" id="next_total_pay" name="next_total_pay" class="inputDisabled text-right ok-red" value="">
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">손익률</div>
											<div class="wid5-inp">
												<input type="text" id="prev_sonic_pay" name="prev_total_pay" class="inputDisabled text-right inptxt" value="">
											</div>
											<div class="wid5-inp">
												<input type="text" id="next_sonic_pay" name="next_total_pay" class="inputDisabled text-right ok-red" value="">
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row">
									<div class="wid-10">
										<div class="table table-area">
											<div class="sear-tit">변경사유</div>
											<div class="ok-red">
												<textarea type="text" id="change_reason" name="change_reason" class="inputDisabled" value="구두 협의에 따른 정률 5% 인상요청 수렴" placeholder="내용을 입력해주세요."></textarea>
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit sear-tit_70">반려사유</div>
											<div class="">
												<input type="text" id="no_reason" name="no_reason" class="text-right" value="">
											</div>
										</div>
									</div>
								</div>
								
<!-- 								<div class="top-row table-input"> -->
<!-- 									<div class="wid-5"> -->
<!-- 										<div class="table"> -->
<!-- 											<div class="sear-tit sear-tit_70">수정자</div> -->
<!-- 											<div> -->
<%-- 												<input type="text" class="inputDisabled inptxt" value="${login_name}" > --%>
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="wid-5 wid-5_last"> -->
<!-- 										<div class="table"> -->
<!-- 											<div class="sear-tit  sear-tit_left">수정일시</div> -->
<!-- 											<div> -->
<%-- 												<input type="text" class="inputDisabled inptxt" value="${today}" > --%>
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
								
								
							</div> <!-- wid5-last -->
							
						</div>
					<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:changeApprove('2');">승인</a>
						<a class="btn btn01 ok-btn" onclick="javascript:changeApprove('3');">반려</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<script>
$(document).ready(function(){
	var r_store = '${r_store}';
	var r_store_nm = '${r_store_nm}';
	var r_period = '${r_period}';
	var r_subject_cd = '${r_subject_cd}';
	var r_webtext = '${r_webtext}';
	
	if(r_store != "")
	{
		$("#selBranch").val(r_store);
		$(".selBranch").html(r_store_nm);
		fncPeri();
		$("#selSeason").val(r_webtext.split(" ")[1]);
		$(".selSeason").html(r_webtext.split(" ")[1] + " / " + r_period);
		fncPeri2();
		$("#selPeri").val(r_period);
		
		$("#search_type").val("subject_cd");
		$(".search_type").html("강좌코드");
		$("#search_name").val(r_subject_cd);
	}
	
	getList();
});
</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>