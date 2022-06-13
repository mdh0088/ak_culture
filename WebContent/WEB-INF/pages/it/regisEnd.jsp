<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker_month.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>
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
	var filename = "강사료 마감내역";
	var table = "excelTable";
    exportExcel(filename, table);
}

var order_by = "";
var sort_type = "";

function reSortAjax(act)
{
	if(!isLoading)
	{
		sort_type = act.replace("sort_", "");
		if(order_by == "")
		{
			order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		else if(order_by == "desc")
		{
			order_by = "asc";
			$("#"+act).attr("src", "/img/th_up.png");
		}
		else if(order_by == "asc")
		{
			order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		getList();
	}
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
	 			$("#search_start").val(cutDate(result.START_YMD));
	 			$("#search_end").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}
function periInit()
{
	getPayMonth('regis');
}
var tot_regis_no = 0;
var tot_enuri_amt = 0;
var tot_lect_pay = 0;
function getList() 
{
	tot_regis_no = 0;
	tot_enuri_amt = 0;
	tot_lect_pay = 0;
	
	getListStart();
	
	$.ajax({
		type : "POST", 
		url : "./getRegisEnd",
		dataType : "text",
		data : 
		{
			order_by : order_by,
			sort_type : sort_type,
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			lect_ym : $("input[name='lect_ym']:checked").val(),
			corp_fg : $("#corp_fg").val(),
			subject_fg : $("#subject_fg").val(),
			search_name : $("#search_name").val()
			
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
					tot_regis_no += Number(nullChkZero(result.list[i].REGIS_NO));
					tot_enuri_amt += Number(nullChkZero(result.list[i].ENURI_AMT));
					tot_lect_pay += Number(nullChkZero(result.list[i].LECT_PAY));
					inner += '<tr>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].WEB_LECTURER_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].BMD)+'</td>';
					if(result.list[i].SUBJECT_FG == "1")
					{
						inner += '	<td>정규</td>';
					}
					else if(result.list[i].SUBJECT_FG == "2")
					{
						inner += '	<td>단기</td>';
					}
					else if(result.list[i].SUBJECT_FG == "3")
					{
						inner += '	<td>특강</td>';
					}
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
					if(result.list[i].FIX_PAY_YN == "Y")
					{
						inner += '	<td>정액</td>';
						inner += '	<td>'+comma(nullChkZero(result.list[i].FIX_AMT))+'</td>';
					}
					else if(result.list[i].FIX_PAY_YN == "N")
					{
						inner += '	<td>정률</td>';
						inner += '	<td>'+comma(nullChkZero(result.list[i].FIX_RATE))+'</td>';
					}
					inner += '	<td>'+nullChk(result.list[i].LECT_CNT)+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].ENURI_AMT))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].LECT_PAY))+'</td>';
// 					inner += '	<td>'+comma(nullChkZero(result.list[i].NET_LECT_PAY))+'</td>';
					var tmp = result.list[i].JR_PAY_DAY;
					inner += '	<td>'+cutDate(tmp.slice(-2, tmp.length))+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="13"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target").html(inner);
			$("#tot_regis_no").html(comma(tot_regis_no));
			$("#tot_enuri_amt").html(comma(tot_enuri_amt));
			$("#tot_lect_pay").html(comma(tot_lect_pay));
			getListEnd();
		}
	});	
}


</script>

<div class="sub-tit">
	<h2>강사료 마감내역</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
<!-- 	<div class="btn-right"> -->
<!-- 		<a class="btn btn01 btn01_1" href="/lecture/lect/attend">출석부 관리 </a> -->
<!-- 	</div> -->
</div>
<div class="table-top table-top02">
	<div class="table sear-wr">
		<div class="wid-3">
			<div class="table table02 table-input wid-contop">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
		</div>
		<div class="wid-4">
			<div class="search-wr sel100">
			    <input type="text" id="search_name" class="inp-100" name="search_name" onkeypress="excuteEnter(getList)" placeholder="강좌명 / 강사명 / 코드번호가 검색됩니다.">
			    <input class="search-btn" type="button" value="검색" onclick="getList()">
			</div>
		</div>
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit-70 sear-tit_left">유형</div>
				<div class="oddn-sel">
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
				<div class="sear-tit sear-tit-70">강사구분</div>
				<div class="oddn-sel">
					<select id="corp_fg" name="corp_fg" de-data="전체">
						<option value="">전체</option>
						<option value="1">법인</option>
						<option value="2">개인</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="table table-auto">
		<div class="sear-tit sear-tit-70">대상연월</div>
		<div class="oddn-sel">
			<ul class="chk-ul" id="ul_radio">
					
			</ul>
		</div>
	</div>
<!-- 		<div class="wid-15"> -->
<!-- 			<div class="table table-90"> -->
<!-- 				<div class="sear-tit sear-tit-70">대분류</div> -->
<!-- 				<div class="oddn-sel"> -->
<!-- 					<select de-data="전체" id="main_cd" name="main_cd" data-name="대분류" onchange="selMaincd(this)"> -->
<!-- 						<option value="">전체</option> -->
<%-- 						<c:forEach var="j" items="${maincdList}" varStatus="loop"> --%>
<%-- 							<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option> --%>
<%-- 						</c:forEach> --%>
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-15"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">중분류</div> -->
<!-- 				<div class="oddn-sel"> -->
<!-- 					<select de-data="전체" id="sect_cd" name="sect_cd" onchange=""> -->
<!-- 						<option value="">전체</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->

<!-- 	<div class="table"> -->
<!-- 		<div class="wid-4"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-50">요일</div> -->
<!-- 				<div> -->
<!-- 					<ul class="chk-ul"> -->
<!-- 						<li style="margin-left:10px;"> -->
<!-- 							<input type="checkbox" id="yoil_mon" name="yoil_mon" checked> -->
<!-- 							<label for="yoil_mon">월</label> -->
<!-- 						</li> -->
<!-- 						<li style="margin-left:10px;"> -->
<!-- 							<input type="checkbox" id="yoil_tue" name="yoil_tue" checked> -->
<!-- 							<label for="yoil_tue">화</label> -->
<!-- 						</li> -->
<!-- 						<li style="margin-left:10px;"> -->
<!-- 							<input type="checkbox" id="yoil_wed" name="yoil_wed" checked> -->
<!-- 							<label for="yoil_wed">수</label> -->
<!-- 						</li> -->
<!-- 						<li style="margin-left:10px;"> -->
<!-- 							<input type="checkbox" id="yoil_thu" name="yoil_thu" checked> -->
<!-- 							<label for="yoil_thu">목</label> -->
<!-- 						</li> -->
<!-- 						<li style="margin-left:10px;"> -->
<!-- 							<input type="checkbox" id="yoil_fri" name="yoil_fri" checked> -->
<!-- 							<label for="yoil_fri">금</label> -->
<!-- 						</li> -->
<!-- 						<li style="margin-left:10px;"> -->
<!-- 							<input type="checkbox" id="yoil_sat" name="yoil_sat" checked> -->
<!-- 							<label for="yoil_sat">토</label> -->
<!-- 						</li> -->
<!-- 						<li style="margin-left:10px;"> -->
<!-- 							<input type="checkbox" id="yoil_sun" name="yoil_sun" checked> -->
<!-- 							<label for="yoil_sun">일</label> -->
<!-- 						</li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class=""> -->
<!-- 			<div class="table table-90"> -->
<!-- 				<div class="sear-tit sear-tit-120">강좌시작일</div> -->
<!-- 				<div> -->
<!-- 					<div class="cal-row cal-row02 table"> -->
<!-- 						<div class="cal-input wid-4"> -->
<!-- 							<input type="text" class="date-i start-i" id="search_start" name="search_start"/> -->
<!-- 							<i class="material-icons">event_available</i> -->
<!-- 						</div> -->
<!-- 						<div class="cal-dash">-</div> -->
<!-- 						<div class="cal-input wid-4"> -->
<!-- 							<input type="text" class="date-i ready-i" id="search_end" name="search_end"/> -->
<!-- 							<i class="material-icons">event_available</i> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div>			 -->
<!-- 		</div> -->
<!-- 		<div class="wid-15"> -->
<!-- 			<div class="table "> -->
<!-- 				<div class="sear-tit sear-tit-70">접수상태</div> -->
<!-- 				<div class="oddn-sel"> -->
<!-- 					<select id="pelt_status" name="pelt_status" de-data="전체"> -->
<!-- 						<option value="">전체</option> -->
<!-- 						<option value="finish">마감</option> -->
<!-- 						<option value="end">폐강</option> -->
<!-- 						<option value="notEnd">폐강제외</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div>		 -->
<!-- 	</div> -->
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>
<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
	</div>
</div>
<div class="table-wr ip-list">
	
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="40px">
				<col>
				<col>
				<col>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
<%-- 				<col> --%>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>순번</th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th>생년월일</th>
					<th onclick="reSortAjax('sort_subject_fg')">강좌유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_bapelttb.subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_regis_no')">등록인원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_bapelttb.fix_pay_yn')">지급구분 <img src="/img/th_up.png" id="sort_bapelttb.fix_pay_yn"></th>
					<th>지급기준</th>
					<th onclick="reSortAjax('sort_lect_cnt')">횟수 <img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_')">할인금액 <img src="/img/th_up.png" id="sort_"></th>
					<th onclick="reSortAjax('sort_lect_pay')">총강사료 <img src="/img/th_up.png" id="sort_lect_pay"></th>
<!-- 					<th onclick="reSortAjax('sort_net_lect_pay')">실지급강사료 <img src="/img/th_up.png" id="sort_net_lect_pay"></th> -->
					<th onclick="reSortAjax('sort_bapelttb.pay_day')">지급일 <img src="/img/th_up.png" id="sort_bapelttb.pay_day"></th>
				</tr>
			</thead>
			<tbody id="list_target">
			</tbody>
		</table>
	</div>
</div>
<div class="sta-botfix sta-botfix06">
	<ul>
		<li style="width:58%"class="li01">총 계</li>
		<li style="width:7%" id="tot_regis_no" class="li03">0</li>
		<li style="width:7%" id="" class="li03"></li>
		<li style="width:7%" id="" class="li03"></li>
		<li style="width:7%" id="" class="li03"></li>
		<li style="width:7%" id="tot_enuri_amt" class="li02">0</li>
		<li style="width:7%" id="tot_lect_pay" class="li02">0</li>
		<li style="width:7%" id="" class="li02"></li>
	</ul>
</div>

<script>
$(document).ready(function() {
	getPayMonth('regis');
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
	selPeri();
	getList();
});

</script>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>