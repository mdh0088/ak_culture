<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<style>
.redFont > td
{
color:red;
}
</style>
<script>
function excelDown()
{
	var filename = "강좌별 회원 상세 현황";
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
// var tot_pay = 0;
// var tot_food = 0;
// var tot_enuri = 0;
function getList(paging_type) 
{
	getListStart();
	tot_enuri = 0;
	$.ajax({
		type : "POST", 
		url : "./getDetailList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val(),
			subject_fg : $("#subject_fg").val(),
			end_fg : $("#end_fg").val(),
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val(),
			isPerformance : $("#isPerformance").is(":checked")
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
					if(result.list[i].END_YN == "Y") //폐강강좌는 빨갛게!
					{
						inner += '<tr class="redFont">';
					}
					else
					{
						inner += '<tr>';
					}
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].SALE_YMD))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POS_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].RECPT_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].KOR_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUS_NO)+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].BIRTH_YMD))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].GRADE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
// 					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
// 					inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';		
					inner += '	<td>'+comma(nullChkZero(result.list[i].UPRICE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].FOOD_AMT))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].ENURI_AMT))+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].START_YMD))+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].END_YMD))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ISPLAY)+'</td>';
					inner += '</tr>';
					
// 					tot_pay += Number(nullChkZero(result.list[i].UPRICE));
// 					tot_enuri += Number(nullChkZero(result.list[i].ENURI_AMT));
// 					tot_food += Number(nullChkZero(result.list[i].FOOD_AMT));
				}
// 				alert(tot_enuri);
// 				$("#tot_pay").html(comma(nullChkZero(tot_pay)));
// 				$("#tot_enuri").html(comma(nullChkZero(tot_enuri)));
// 				$("#tot_food").html(comma(nullChkZero(tot_food)));
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
	<h2>강좌별 회원 상세 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<div class="oddn-sel02 sel-scr">
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
		</div>
		<div class="wid-1 mag-l4">
			<ul class="chk-ul">
				<li>
					<input type="checkbox" id="isPerformance" name="isPerformance">
					<label for="isPerformance">임시 중분류 포함</label>
				</li>
			</ul>
		</div>
	</div>
	<div class="top-row">	
		<div class="wid-4">
			<div class="table table-input">
				<div>
					<div class="cal-row table table-90">
						<div class="cal-input cal-input02">
							<input type="text" class="date-i start-i" id="search_start" name="search_start"/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input cal-input02">
							<input type="text" class="date-i ready-i" id="search_end" name="search_end"/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-15 mag-l2">
			<div class="table">
				<div class="sear-tit">강좌 유형</div>
				<div>
					<select id="subject_fg" name="subject_fg" de-data="전체">
						<option value="">전체</option>
						<option value="1">정규</option>
						<option value="2">단기</option>
						<option value="3">특강</option>
					</select>
				</div>
			</div>
		</div>
		<div class="wid-15 mag-l2">
			<div class="table">
				<div class="sear-tit">상태</div>
				<div>
					<select id="end_fg" name="end_fg" de-data="전체">
						<option value="">전체</option>
						<option value="Y">폐강</option>
						<option value="N">폐강제외</option>
					</select>
				</div>
			</div>
		</div>
		
		<div class="wid-25 mag-l2">
			<div class="table">
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_70">강좌 분류</div>
						<div>
							<select de-data="전체" id="main_cd" name="main_cd" data-name="대분류" onchange="selMaincd(this)">
								<option value="">전체</option>
								<c:forEach var="j" items="${maincdList}" varStatus="loop">
									<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
								</c:forEach>
							</select>
							<select de-data="전체" id="sect_cd" name="sect_cd" onchange="">
								<option value="">전체</option>
							</select>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	
	</div>
<!-- 	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:tot_pay = 0; tot_food = 0; tot_enuri = 0; getList();"> -->
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getList();">
</div>	



<div class="table-cap table">
	<div class="cap-l cap-bwr">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
<!-- 				<select id="listSize" name="listSize" onchange="javascript:tot_pay = 0; tot_food = 0; tot_enuri = 0; getList();" de-data="10개 보기"> -->
				<select id="listSize" name="listSize" onchange="javascript:getList();" de-data="10개 보기">
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
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
<%-- 				<col> --%>
<%-- 				<col> --%>
				<col>
				<col width="300px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_sale_ymd')">매출일<img src="/img/th_up.png" id="sort_sale_ymd"></th>
					<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
					<th onclick="reSortAjax('sort_recpt_no')">영수증 번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_grade')">회원등급<img src="/img/th_up.png" id="sort_grade"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
<!-- 					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th> -->
<!-- 					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					 -->
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_uprice')">매출 <img src="/img/th_up.png" id="sort_uprice"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비 <img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_enuri_amt')">할인 <img src="/img/th_up.png" id="sort_enuri_amt"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일 <img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일 <img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_end_yn')">상태 <img src="/img/th_up.png" id="sort_end_yn"></th>
				</tr>
			</thead>
		</table>
	</div>
<!-- 	<div class="table-list table-stlist table-horiz" > -->
	<div class="table-list table-stlist" >
		<table id="excelTable">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
<%-- 				<col> --%>
<%-- 				<col> --%>
				<col>
				<col width="300px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_sale_ymd')">매출일<img src="/img/th_up.png" id="sort_sale_ymd"></th>
					<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
					<th onclick="reSortAjax('sort_recpt_no')">영수증 번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_grade')">회원등급<img src="/img/th_up.png" id="sort_grade"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
<!-- 					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th> -->
<!-- 					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					 -->
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_uprice')">매출 <img src="/img/th_up.png" id="sort_uprice"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비 <img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_enuri_amt')">할인 <img src="/img/th_up.png" id="sort_enuri_amt"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일 <img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일 <img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_end_yn')">상태 <img src="/img/th_up.png" id="sort_end_yn"></th>
				</tr>	
			</thead>
			
			<tbody id="list_target">

			</tbody>
		</table>
	</div>
</div>
			
<script>
$(document).ready(function() {
	setPeri();
	fncPeri();
	selPeri();
	getList();
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

<!-- <div class="sta-botfix sta-botfix08"> -->
<!-- 	<ul> -->
<!-- 		<li class="li01">총 계</li> -->
<!-- 		<li id="tot_pay" class="li02">0</li> -->
<!-- 		<li id="tot_food" class="li02">0</li> -->
<!-- 		<li id="tot_enuri" class="li02">0</li> -->
<!-- 		<li class="li03"></li> -->
<!-- 		<li class="li03"></li> -->
<!-- 	</ul> -->
<!-- </div> -->























<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>