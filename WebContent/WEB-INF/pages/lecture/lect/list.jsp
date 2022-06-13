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
	var filename = "강좌리스트";
	var table = "excelTable";
    exportExcel(filename, table);
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
	 			$("#search_start").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#search_end").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}

function endAction()
{
	var chkList = "";
	var send_tm ="Y";
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).attr("id").replace("chk_", "")+"|";
    	}
	});
	
	$.ajax({
		type : "POST", 
		url : "./endAction",
		dataType : "text",
		async : false,
		data : 
		{
			chkList : chkList,
			act : $("#end_act").val(),
			send_tm : send_tm
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
    			getList();
    		}
    		else
    		{
	    		alert(result.msg);
    		}
		}
	});	
}
$(document).ready(function(){
	
	$(".tab-phbtn").click(function(){
			
			if($(".tab-ph").css("display")=="none"){
				$("tbody .tab-ph").css("display","table-cell");
				$("thead .tab-ph").css("display","table-cell");
				$("colgroup .tab-ph").css("display","table-column");
				$(".tab-ph").css("width","100px");
			}else{
				$(".tab-ph").css("display","none");
				$(".tab-ph").css("width","");
			}
			thSize();
			
		})
	})
function tabBtn()
{
		if($(".tab-ph").css("display")=="none"){
			$(".tab-ph").css("display","none");
			$(".tab-ph").css("width","");
		}else{
			$("tbody .tab-ph").css("display","table-cell");
			$("thead .tab-ph").css("display","table-cell");
			$("colgroup .tab-ph").css("display","table-column");
			$(".tab-ph").css("width","100px");
		}
}
function getList(paging_type) 
{
	getListStart();
	var mon = '0'
	var tue = '0'
	var wed = '0'
	var thu = '0'
	var fri = '0'
	var sat = '0'
	var sun = '0'
	
	if($("#yoil_mon").is(":checked"))
	{
		mon = '1';
	}
	if($("#yoil_tue").is(":checked"))
	{
		tue = '1';
	}
	if($("#yoil_wed").is(":checked"))
	{
		wed = '1';
	}
	if($("#yoil_thu").is(":checked"))
	{
		thu = '1';
	}
	if($("#yoil_fri").is(":checked"))
	{
		fri = '1';
	}
	if($("#yoil_sat").is(":checked"))
	{
		sat = '1';
	}
	if($("#yoil_sun").is(":checked"))
	{
		sun = '1';
	}
	var day_flag = mon+""+tue+""+wed+""+thu+""+fri+""+sat+""+sun;
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("pelt_status", $("#pelt_status").val(), 9999);
	setCookie("subject_fg", $("#subject_fg").val(), 9999);
	setCookie("main_cd", $("#main_cd").val(), 9999);
	setCookie("sect_cd", $("#sect_cd").val(), 9999);
	setCookie("day_flag", day_flag, 9999);
	setCookie("search_start", $("#search_start").val(), 9999);
	setCookie("search_end", $("#search_end").val(), 9999);
	
	
	$.ajax({
		type : "POST", 
		url : "./getPeltList2",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			search_name : $("#search_name").val(),
			pelt_status : $("#pelt_status").val(),
			subject_fg : $("#subject_fg").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val(),
			day_flag : day_flag,
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val()
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
					if(result.list[i].ISPLAY == '폐강')
					{
						inner += '<tr class="bg-red">';
					}
					else if(result.list[i].ISPLAY == '마감')
					{
						inner += '<tr class="bg-blue">';
					}
					else
					{
						inner += '<tr>';
					}
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+nullChk(result.list[i].LECTURER_NM)+'</td>';
					inner += '	<td class="tab-ph">'+cutPhone2(nullChk(result.list[i].PHONE_NO))+'</td>';
					inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+nullChkZero(result.list[i].CAPACITY_NO)+'</td>';
					inner += '	<td>'+nullChkZero(result.list[i].TOT_REGIS_NO)+'</td>';
					inner += '	<td>'+nullChkZero(result.list[i].WAIT_CNT)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ISPLAY)+'</td>';
					inner += '	<td>'+comma(result.list[i].REGIS_FEE)+'</td>';
					if(result.list[i].FOOD_YN == 'Y')
					{
						inner += '	<td>'+comma(result.list[i].FOOD_AMT)+'</td>';
					}
					else if(result.list[i].FOOD_YN == 'R')
					{
						inner += '	<td>별도</td>';
					}
					else
					{
						inner += '	<td>0</td>';
					}
					if(result.list[i].FIX_PAY_YN == "Y")
					{
						inner += '	<td>정액 '+comma(result.list[i].FIX_AMT)+'</td>';
					}
					else if(result.list[i].FIX_PAY_YN == "N")
					{
						inner += '	<td>정률 '+comma(result.list[i].FIX_RATE)+'</td>';
					}
					else
					{
						inner += '	<td></td>';
					}
					inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
					inner += '	<td>'+cutLectHour(result.list[i].LECT_HOUR)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].LECT_CNT)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].START_YMD)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].END_YMD)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="19"><div class="no-data">검색결과가 없습니다.</div></td>';
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
					tabBtn();
				}
			}
			else
			{
				$("#list_target").html(inner);
				tabBtn();
			}
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});	
}
function cutPhone2(dd)
{
	if(dd == "" || dd == null || dd == 'null' || dd == undefined)
	{
		return "";
	}
	else
	{
		if(trim(dd).length == 11)
		{
			var phone1 = dd.substring(0,3);
			var phone2 = dd.substring(3,7);
			var phone3 = dd.substring(7,11);
			return phone1 + "－" + phone2 + "－" + phone3;
		}
		else if(trim(dd).length == 10)
		{
			var phone1 = dd.substring(0,3);
			var phone2 = dd.substring(3,6);
			var phone3 = dd.substring(6,10);
			return phone1 + "－" + phone2 + "－" + phone3;
		}
		else
		{
			return dd;
		}
	}
}
function selMaincd(idx){	
// 	var x = document.getElementById("selPeri").selectedIndex;
// 	var y = document.getElementById("selPeri").options;
// 	var z = document.getElementById("selPeri").options[y[x].index];

	main_cd = $(idx).val();
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
	}else{
		$('.withBaby').hide();
	}
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
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
</script>

<div class="sub-tit">
	<h2>강좌리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn01 btn01_1" href="/lecture/lect/attend">출석부 관리 </a>
	</div>
</div>
<div class="table-top table-top02">
	<div class="table sear-wr">
		<div class="wid-3">
			<div class="table">
				<div class="wid-35" style="width:100% !important">
					<div class="table table02 table-input wid-contop">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="">
			<div class="table table-90">
				<div class="search-wr sel100">
				    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="강좌명 / 강사명 / 코드번호가 검색됩니다.">
				    <input class="search-btn" style="right:160px !important" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
				</div>
			</div>
		</div>
		<div class="wid-15">
			<div class="table table-90">
				<div class="sear-tit sear-tit-70">대분류</div>
				<div class="oddn-sel">
					<select de-data="전체" id="main_cd" name="main_cd" data-name="대분류" onchange="selMaincd(this)">
						<option value="">전체</option>
						<c:forEach var="j" items="${maincdList}" varStatus="loop">
							<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit-70">중분류</div>
				<div class="oddn-sel">
					<select de-data="전체" id="sect_cd" name="sect_cd" onchange="">
						<option value="">전체</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="table">
		<div class="wid-4">
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
		<div class="">
			<div class="table table-90">
				<div class="sear-tit sear-tit-120">강좌시작일</div>
				<div>
					<div class="cal-row cal-row02 table">
						<div class="cal-input wid-4">
							<input type="text" class="date-i start-i" id="search_start" name="search_start"/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input wid-4">
							<input type="text" class="date-i ready-i" id="search_end" name="search_end"/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>			
		</div>
		<div class="wid-15">
			<div class="table ">
				<div class="sear-tit sear-tit-70">접수상태</div>
				<div class="oddn-sel">
					<select id="pelt_status" name="pelt_status" de-data="전체">
						<option value="">전체</option>
						<option value="finish">마감</option>
						<option value="end">폐강</option>
						<option value="notEnd">폐강제외</option>
					</select>
				</div>
			</div>
		</div>		
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit-70">유형</div>
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
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
</div>
<div class="table-cap table">
	<div class="cap-l cap-bwr">
		<p class="cap-numb"></p>
		<div class="tab-phbtn btn03">연락처보기</div>
	</div>
	<div class="cap-r text-right">
		
		<div class="table table02 table-auto float-right">
			<div>
				<p class="ip-ritit">선택한 강좌를</p>
			</div>
			<div>
				<select de-data="폐강" id="end_act" name="end_act">
					<option value="Y">폐강</option>
					<option value="O">개강</option>
					<option value="N">폐강취소</option>
				</select>
				<a class="bor-btn btn03 btn-mar6" onclick="javascript:endAction();">반영</a>
			</div>
			<div class="sel-scr">
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
				<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
					<option value="10">10개 보기</option>
					<option value="20">20개 보기</option>
					<option value="50">50개 보기</option>
					<option value="100">100개 보기</option>
					<option value="300">300개 보기</option>
					<option value="500">500개 보기</option>
					<option value="1000">1000개 보기</option>
					<option value="5000">5000개 보기</option>
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
				<col width="40px">
				<col width="60px">
				<col width="6%">
				<col width="60px">
				<col class="tab-ph">
				<col width="100px">
				<col>
				<col width="40px">
				<col width="40px">
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col width="70px">
				<col width="60px">
				<col width="5%">
				<col width="40px">
				<col width="70px">
				<col width="70px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_subject_fg')">유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					
					<th onclick="reSortAjax('sort_bapelttb.subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th class="tab-ph">연락처</th>
					<th onclick="reSortAjax('sort_bapelttb.subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원 <img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_regis_no+web_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no+web_regis_no"></th>
					<th onclick="reSortAjax('sort_wait_cnt')">대기자 <img src="/img/th_up.png" id="sort_wait_cnt"></th>
					<th onclick="reSortAjax('sort_isplay')">진행여부 <img src="/img/th_up.png" id="sort_isplay"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비 <img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_fix_pay_yn')">강사료기준 <img src="/img/th_up.png" id="sort_fix_pay_yn"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>	
					<th onclick="reSortAjax('sort_lect_cnt')">횟수 <img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일 <img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일 <img src="/img/th_up.png" id="sort_end_ymd"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="40px">
				<col width="40px">
				<col width="60px">
				<col width="6%">
				<col width="60px">
				<col class="tab-ph">
				<col width="100px">
				<col>
				<col width="40px">
				<col width="40px">
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col width="70px">
				<col width="60px">
				<col width="5%">
				<col width="40px">
				<col width="70px">
				<col width="70px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_subject_fg')">유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					
					<th onclick="reSortAjax('sort_bapelttb.subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th class="tab-ph">연락처</th>
					<th onclick="reSortAjax('sort_bapelttb.subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원 <img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_regis_no+web_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no+web_regis_no"></th>
					<th onclick="reSortAjax('sort_wait_cnt')">대기자 <img src="/img/th_up.png" id="sort_wait_cnt"></th>
					<th onclick="reSortAjax('sort_isplay')">진행여부 <img src="/img/th_up.png" id="sort_isplay"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비 <img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_fix_pay_yn')">강사료기준 <img src="/img/th_up.png" id="sort_fix_pay_yn"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>	
					<th onclick="reSortAjax('sort_lect_cnt')">횟수 <img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일 <img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일 <img src="/img/th_up.png" id="sort_end_ymd"></th>
				</tr>
			</thead>
			<tbody id="list_target">
			</tbody>
		</table>
	</div>
</div>


<script>
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

</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>


<script>
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
$(document).ready(function(){
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("pelt_status")) != "") { $("#pelt_status").val(nullChk(getCookie("pelt_status"))); $(".pelt_status").html($("#pelt_status option:checked").text());}
	if(nullChk(getCookie("subject_fg")) != "") { $("#subject_fg").val(nullChk(getCookie("subject_fg"))); $(".subject_fg").html($("#subject_fg option:checked").text());}
	if(nullChk(getCookie("main_cd")) != "") { $("#main_cd").val(nullChk(getCookie("main_cd"))); $(".main_cd").html($("#main_cd option:checked").text());}
	selMaincd2(getCookie("main_cd"));
	if(nullChk(getCookie("sect_cd")) != "") { $("#sect_cd").val(nullChk(getCookie("sect_cd"))); $(".sect_cd").html($("#sect_cd option:checked").text());}
	selPeri();
	if(nullChk(getCookie("search_start")) != "") { $("#search_start").val(nullChk(getCookie("search_start")));}
	if(nullChk(getCookie("search_end")) != "") { $("#search_end").val(nullChk(getCookie("search_end")));}
	fncPeri();
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