<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>

function excelDown()
{
	var filename = "출석부";
	var table = "excelTable";
    exportExcel(filename, table);
}


$(document).ready(function() {
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
	
	
	//지점 바꾸면 대분류,중분류 초기화
	$(".selBranch_ul > li").click( function() {
		$("#sect_cd").empty();
		$(".sect_cd_ul").html("");
		$(".sect_cd_ul").append('<li>전체</li>');
		$("#sect_cd").append('<option value="">전체</option>');
		
		$("#main_cd").val("");
		$(".main_cd").html("전체");
		$("#sect_cd").val("");
		$(".sect_cd").html("전체");
	});
});

function selMaincd(idx){
	var main_cd = $(idx).val();
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		data : 
		{
			maincd : main_cd,
			selBranch : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner ="";
			var inner_li="";
			$("#sect_cd").empty();
			$(".sect_cd_ul").empty();
			if(result.length > 0)
			{
				inner="";
				inner+='<option value="">전체</option>';
				inner_li+='<li>전체</li>';
				for (var i = 0; i < result.length; i++) {
					inner+='<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>';
					inner_li+='<li>'+result[i].SECT_NM+'</li>';
				}
				$("#sect_cd").append(inner);
				$(".sect_cd_ul").append(inner_li);
			}
			else
			{
				
			}
		}
	});	
	
	$("#sect_cd").val("");
	$(".sect_cd").html("선택하세요.");
}

function selMaincd2(idx){	
// 	var x = document.getElementById("selPeri").selectedIndex;
// 	var y = document.getElementById("selPeri").options;
// 	var z = document.getElementById("selPeri").options[y[x].index];

	main_cd = idx;
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
	}else{
		$('.withBaby').hide();
	}
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		async:false,
		data : 
		{
			maincd : main_cd,
// 			selBranch : z.getAttribute("store")
			selBranch : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner ="";
			$("#sect_cd").empty();
			$(".sect_cd_ul").html("");
			
			$(".sect_cd_ul").append('<li>전체</li>');
			$("#sect_cd").append('<option value="">전체</option>');
			if(result.length > 0)
			{
				
				inner=""; 
				for (var i = 0; i < result.length; i++) 
				{
					$(".sect_cd_ul").append('<li>'+result[i].SECT_NM+'</li>');
					$("#sect_cd").append('<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>');
				}
			}
			else
			{
				
			}
			$("#sect_cd").val("");
			$(".sect_cd").html("전체");
		}
	});	
}
function getList(paging_type) 
{
	getListStart();
	var mon = 0;
	var tue = 0;
	var wed = 0;
	var thu = 0;
	var fri = 0;
	var sat = 0;
	var sun = 0;
	
	if($("#yoil_mon").is(":checked"))
	{
		mon = "1";
	}
	if($("#yoil_tue").is(":checked"))
	{
		tue = "1";
	}
	if($("#yoil_wed").is(":checked"))
	{
		wed = "1";
	}
	if($("#yoil_thu").is(":checked"))
	{
		thu = "1";
	}
	if($("#yoil_fri").is(":checked"))
	{
		fri = "1";
	}
	if($("#yoil_sat").is(":checked"))
	{
		sat = "1";
	}
	if($("#yoil_sun").is(":checked"))
	{
		sun = "1";
	}
	var day_flag = mon+""+tue+""+wed+""+thu+""+fri+""+sat+""+sun;
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("search_type", $("#search_type").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("search_start", $("#search_start").val(), 9999);
	setCookie("search_end", $("#search_end").val(), 9999);
	
	setCookie("lect_cnt_start", $("#lect_cnt_start").val(), 9999);
	setCookie("lect_cnt_end", $("#lect_cnt_end").val(), 9999);
	setCookie("lect_nm", $("#lect_nm").val(), 9999);
	setCookie("main_cd", $("#main_cd").val(), 9999);
	setCookie("sect_cd", $("#sect_cd").val(), 9999);
	setCookie("day_flag", day_flag, 9999);
	setCookie("search_subject_fg", $("#search_subject_fg").val(), 9999);

	
	$.ajax({
		type : "POST", 
		url : "./getAttendList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val(),
			lect_cnt_start : $("#lect_cnt_start").val(),
			lect_cnt_end : $("#lect_cnt_end").val(),
			lect_nm : $("#lect_nm").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val(),
			subject_fg : $('#search_subject_fg').val(),
			
			day_flag : day_flag
			
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
				var tot_regis_no=0;
				for(var i = 0; i < result.list.length; i++)
				{
					
					tot_regis_no = (result.list[i].REGIS_NO*1) + (result.list[i].WEB_REGIS_NO*1);
					//inner += '<tr onclick="location.href=\'attend_detail?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+result.list[i].SUBJECT_CD+'\'">';
					//inner += '<tr onclick="gotoDetail(\''+result.list[i].STORE+'\',\''+result.list[i].PERIOD+'\',\''+trim(result.list[i].SUBJECT_CD)+'\')">';
					inner += '<tr>';
					
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" class="chk_val" name="chk_val" value="'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'">';
					inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].LECT_CNT)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+result.list[i].WEB_LECTURER_NM+'</td>';
					//inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="javascript:location.href=\'/lecture/lect/attend_detail?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+result.list[i].SUBJECT_CD+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
					
					inner += '	<td>'+nullChk(result.list[i].CAPACITY_NO)+'</td>';
					//inner += '	<td class="color-blue line-blue">'+nullChk(result.list[i].ATTEND_LECT_CNT)+'</td>';
					inner += '	<td class="color-blue line-blue">'+result.list[i].TOT_RESI_NO+'</td>';
					inner += '	<td>'+nullChk(comma(result.list[i].REGIS_FEE))+'</td>';
					inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
					inner += '	<td>'+cutLectHour(result.list[i].LECT_HOUR)+'</td>';
					inner += '</tr>';
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
			getListEnd();
		}
	});	
}


function gotoDetail(store,period,subject_cd){
	var f = document.recruit;
	f.store.value=store;
	f.period.value=period;
	f.subject_cd.value=subject_cd;
	f.submit();
}


function goPrint()
{
	getData ="";
	$('input[name="chk_val"]:checked').each(function(i){//체크된 리스트 저장
		getData += $(this).val()+"|";
	});
	
  	if (getData=="") 
  	{
		alert("프린트할 강좌를 선택해주세요.");
		return;
	}
  	$('#attend_value').val(getData);
	window.open('', 'AK', 'height=700,width=1200');
	var frm = document.getElementById("printForm");
	frm.target ="AK";
	frm.submit();
 		
	
}
</script>

<form id="printForm" name="printForm" method="post" action="./attend_print_proc" >
	<input type="hidden" id="attend_value" name="attend_value" value="">
</form>

<form name ="recruit" action='./attend_detail' method='post'>
	<input type="hidden" name="store">
	<input type="hidden" name="period">
	<input type="hidden" name="subject_cd">

</form>

<div class="sub-tit">
	<h2>출석부관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="table">
			<div class="wid-3">
				<div class="table">
					<div class="wid-35">
						<div class="table table02 table-input wid-contop">
							<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
						</div>
					</div>
					<div style="width:0%;">
						<div class="table">
							<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
							<div class=" sel-scr">
								<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			 <div>
				<div class="tabl table-90">
					<div class="search-wr sear-22 sel100">
						<select id="search_type" name="search_type" de-data="강좌명">
							<option value="subject_nm">강좌명</option>
							<option value="subject_cd">코드번호</option>
						</select>
					    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
					    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
					</div>
				</div>
			</div>
			<div class="wid-15">
				<div class="table table-input table-90">
					<div class="sear-tit sear-tit-50">대분류</div>
					<div class="sel-scr">
						<select id="main_cd" de-data="선택" onchange="selMaincd(this)">
							<option value="">전체</option>
							<c:forEach var="i" items="${maincdList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="wid-15">
				<div class="table table-input">
					<div class="sear-tit sear-tit-50">중분류</div>
					<div class="sel-scr">
						<select id="sect_cd" de-data="선택">
							<option value="">대분류를 선택해주세요.</option>
						</select>
					</div>
				</div>
			</div>
			
		</div>
		
	</div>
	<div class="top-row">
		<div class="table">
			<div class="wid-15">
				<div class="table table-input">
					<div class="sear-tit sear-tit-50">강사명</div>
					<div>
						<input type="text" id="lect_nm" name="lect_nm" />
					</div>
				</div>
			</div>
			<div class="wid-2">
				<div class="table">
					<div class="sear-tit sear-tit_120  text-center">강좌 유형 선택</div>
					<div>
						<select id="search_subject_fg" de-data="전체">
							<option value="">전체</option>
							<option value="1">정규</option>
							<option value="2">단기</option>
							<option value="3">특강</option>
						</select>
						
					</div>
				</div>
			</div>
			<div class="wid-3">
				<div class="table table-90">
					<div class="sear-tit sear-tit-70">강의횟수</div>
					<div>
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" id="lect_cnt_start" name="lect_cnt_start"/>
							</div>
							<div class="cal-dash">-</div>
							<div class="cal-input wid-4">
								<input type="text" id="lect_cnt_end" name="lect_cnt_end"/>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="">
				<div class="table">
					<div class="sear-tit sear-tit-50">요일</div>
					<div>
						<ul class="chk-ul">
							<li style="margin-left:10px;">
								<input type="checkbox" id="yoil_mon" name="yoil_mon" checked>
								<label for="yoil_mon">월</label>
							</li>
							<li style="margin-left:10px;">
								<input type="checkbox" id="yoil_tue" name="yoil_tue" checked>
								<label for="yoil_tue">화</label>
							</li>
							<li style="margin-left:10px;">
								<input type="checkbox" id="yoil_wed" name="yoil_wed" checked>
								<label for="yoil_wed">수</label>
							</li>
							<li style="margin-left:10px;">
								<input type="checkbox" id="yoil_thu" name="yoil_thu" checked>
								<label for="yoil_thu">목</label>
							</li>
							<li style="margin-left:10px;">
								<input type="checkbox" id="yoil_fri" name="yoil_fri" checked>
								<label for="yoil_fri">금</label>
							</li>
							<li style="margin-left:10px;">
								<input type="checkbox" id="yoil_sat" name="yoil_sat" checked>
								<label for="yoil_sat">토</label>
							</li>
							<li style="margin-left:10px;">
								<input type="checkbox" id="yoil_sun" name="yoil_sun" checked>
								<label for="yoil_sun">일</label>
							</li>
						</ul>
					</div>
				</div>
			</div>		
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
</div>
<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 print-btn" onclick="javascript:goPrint();"><i class="material-icons">print</i></a> 
				<select id="listSize" name="listSize" onchange="getList()" de-data="100개 보기">
		<!-- 			<option value="10">10개 보기</option>
					<option value="20">20개 보기</option>
					<option value="50">50개 보기</option> -->
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
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
				<col width="60px">
				<col width="8%">
				<col>
				<col>
				<col>
				<col width="8%">
				<col width="15%">
				<col>
				<col>
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th>지점</th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg_nm')">유형 <img src="/img/th_up.png" id="sort_subject_fg_nm"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">횟수 <img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_subject_nm')" >강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원 <img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
				<col width="60px">
				<col width="8%">
				<col>
				<col>
				<col>
				<col width="8%">
				<col width="15%">
				<col>
				<col>
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th>지점</th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg_nm')">유형 <img src="/img/th_up.png" id="sort_subject_fg_nm"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">횟수 <img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_bb.subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_bb.subject_cd"></th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원 <img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
				</tr>
			</thead>
			<tbody id="list_target">
		
			</tbody>
		</table>
	</div>
</div>


<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
<script>

$(document).ready(function(){
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	fncPeri();
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type"))); $(".search_type").html($("#search_type option:checked").text());}
	if(nullChk(getCookie("search_start")) != "") { $("#search_start").val(nullChk(getCookie("search_start")));}
	if(nullChk(getCookie("search_end")) != "") { $("#search_end").val(nullChk(getCookie("search_end")));}
	if(nullChk(getCookie("lect_cnt_start")) != "") { $("#lect_cnt_start").val(nullChk(getCookie("lect_cnt_start")));}
	if(nullChk(getCookie("lect_cnt_end")) != "") { $("#lect_cnt_end").val(nullChk(getCookie("lect_cnt_end")));}
	if(nullChk(getCookie("lect_nm")) != "") { $("#lect_nm").val(nullChk(getCookie("lect_nm")));}
	
	if(nullChk(getCookie("search_subject_fg")) != "") { $("#search_subject_fg").val(nullChk(getCookie("search_subject_fg"))); $(".search_subject_fg").html($("#search_subject_fg option:checked").text());}
	if(nullChk(getCookie("main_cd")) != "") { $("#main_cd").val(nullChk(getCookie("main_cd"))); $(".main_cd").html($("#main_cd option:checked").text());}
	selMaincd2(getCookie("main_cd"));
	if(nullChk(getCookie("sect_cd")) != "") { $("#sect_cd").val(nullChk(getCookie("sect_cd"))); $(".sect_cd").html($("#sect_cd option:checked").text());}
	if(nullChk(getCookie("day_flag")) != "") 
	{
		var mon = getCookie("day_flag").substring(0,1);
		if(mon == "1")
		{
			$("input:checkbox[id='yoil_mon']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_mon']").prop("checked", false);
		}
		var tue = getCookie("day_flag").substring(1,2);
		if(tue == "1")
		{
			$("input:checkbox[id='yoil_tue']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_tue']").prop("checked", false);
		}
		var wed = getCookie("day_flag").substring(2,3);
		if(wed == "1")
		{
			$("input:checkbox[id='yoil_wed']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_wed']").prop("checked", false);
		}
		var thu = getCookie("day_flag").substring(3,4);
		if(thu == "1")
		{
			$("input:checkbox[id='yoil_thu']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_thu']").prop("checked", false);
		}
		var fri = getCookie("day_flag").substring(4,5);
		if(fri == "1")
		{
			$("input:checkbox[id='yoil_fri']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_fri']").prop("checked", false);
		}
		var sat = getCookie("day_flag").substring(5,6);
		if(sat == "1")
		{
			$("input:checkbox[id='yoil_sat']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_sat']").prop("checked", false);
		}
		var sun = getCookie("day_flag").substring(6,7);
		if(sun == "1")
		{
			$("input:checkbox[id='yoil_sun']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_sun']").prop("checked", false);
		}
	}
	getList();
})

</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>