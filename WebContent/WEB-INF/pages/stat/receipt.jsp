<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
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
var tot_pay = 0;
var tot_enuri = 0;
var tot_part = 0;
var tot_food = 0;
var tot_regis = 0;
var tot_new = 0;
function getList(paging_type) 
{
	getListStart();
	
	tot_pay = 0;
	tot_enuri = 0;
	tot_part = 0;
	tot_food = 0;
	tot_regis = 0;
	tot_new = 0;
	$.ajax({
		type : "POST", 
		url : "./getPeltList",
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
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PERIOD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';		
					inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_FEE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].UPRICE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].ENURI_AMT))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].PART_REGIS_AMT))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].FOOD_AMT))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_NO))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].NEW))+'</td>';
					inner += '</tr>';
					
					tot_pay += Number(nullChkZero(result.list[i].UPRICE));
					tot_enuri += Number(nullChkZero(result.list[i].ENURI_AMT));
					tot_part += Number(nullChkZero(result.list[i].PART_REGIS_AMT));
					tot_food += Number(nullChkZero(result.list[i].FOOD_AMT));
					tot_regis += Number(nullChkZero(result.list[i].REGIS_NO));
					tot_new += Number(nullChkZero(result.list[i].NEW));
				}
				if(result.list_pay_top.length > 0)
				{
					$("#pay_top").html("<span>매출 상위 강좌</span>"+result.list_pay_top[0].SUBJECT_NM);
				}
				if(result.list_person_top.length > 0)
				{
					$("#person_top").html("<span>회원수 상위 강좌</span>"+result.list_person_top[0].SUBJECT_NM);
				}
				if(result.list_new_top.length > 0)
				{
					$("#new_top").html("<span>신규유입 상위 강좌</span>"+result.list_new_top[0].SUBJECT_NM);
				}
				
				$("#tot_pay").html(comma(nullChkZero(tot_pay)));
				$("#tot_enuri").html(comma(nullChkZero(tot_enuri)));
				$("#tot_part").html(comma(nullChkZero(tot_part)));
				$("#tot_food").html(comma(nullChkZero(tot_food)));
				$("#tot_regis").html(comma(nullChkZero(tot_regis)));
				$("#tot_new").html(comma(nullChkZero(tot_new)));
			}
			else
			{
				$("#pay_top").html("<span>매출 상위 강좌</span>검색결과가 없습니다.");
				$("#person_top").html("<span>회원수 상위 강좌</span>검색결과가 없습니다.");
				$("#new_top").html("<span>신규유입 상위 강좌</span>검색결과가 없습니다.");
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
	<h2>강좌별 접수 현황</h2>
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
		<div class="wid-25">
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
		
		<div class="wid-35 mag-l2">
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
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>	


<div class="receipt-wrap">
	<div class="rec-box">
	
		<div id="pay_top">
			<span>매출 상위 강좌</span>
		</div>
		
		<div id="person_top">
			<span>회원수 상위 강좌</span>
		</div>
		
		<div id="new_top">
			<span>신규유입 상위 강좌</span>
		</div>		
		
	</div>	
</div> <!-- // receipt-wrap end -->

<div class="table-cap table">
	<div class="cap-r text-right">
		
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
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
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col width="450px">
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
					<th onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_period')">기수 <img src="/img/th_up.png" id="sort_period"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th class="td-140" onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_uprice')">총 매출 <img src="/img/th_up.png" id="sort_uprice"></th>
					<th onclick="reSortAjax('sort_enuri_amt')">할인 <img src="/img/th_up.png" id="sort_enuri_amt"></th>
					<th onclick="reSortAjax('sort_part_regis_amt')">부분 입금 <img src="/img/th_up.png" id="sort_part_regis_amt"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비 <img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_new')">신규 <img src="/img/th_up.png" id="sort_new"></th>
<!-- 					<th>개폐강<img src="/img/th_down.png"></th> -->
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-stlist" >
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col width="450px">
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
					<th onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_period')">기수 <img src="/img/th_up.png" id="sort_period"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_uprice')">총 매출 <img src="/img/th_up.png" id="sort_uprice"></th>
					<th onclick="reSortAjax('sort_enuri_amt')">할인 <img src="/img/th_up.png" id="sort_enuri_amt"></th>
					<th onclick="reSortAjax('sort_part_regis_amt')">부분 입금 <img src="/img/th_up.png" id="sort_part_regis_amt"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비 <img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_new')">신규 <img src="/img/th_up.png" id="sort_new"></th>
<!-- 					<th>개폐강<img src="/img/th_down.png"></th> -->
				</tr>	
			</thead>
			
			<tbody id="list_target">
<!-- 				<tr> -->
<!-- 					<td>수원점</td> -->
<!-- 					<td>052</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101052</td> -->
<!-- 					<td>수채화 캘리그라피</td>					 -->
<!-- 					<td>125,000</td> -->
<!-- 					<td>1,200,000</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>수원점</td> -->
<!-- 					<td>052</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101052</td> -->
<!-- 					<td>수채화 캘리그라피</td>					 -->
<!-- 					<td>125,000</td> -->
<!-- 					<td>1,200,000</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>수원점</td> -->
<!-- 					<td>052</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101052</td> -->
<!-- 					<td>수채화 캘리그라피</td>					 -->
<!-- 					<td>125,000</td> -->
<!-- 					<td>1,200,000</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>수원점</td> -->
<!-- 					<td>052</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101052</td> -->
<!-- 					<td>수채화 캘리그라피</td>					 -->
<!-- 					<td>125,000</td> -->
<!-- 					<td>1,200,000</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>수원점</td> -->
<!-- 					<td>052</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101052</td> -->
<!-- 					<td>수채화 캘리그라피</td>					 -->
<!-- 					<td>125,000</td> -->
<!-- 					<td>1,200,000</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 				</tr> -->
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
			


<div class="sta-botfix sta-botfix02">
	<ul>
		<li class="li01">총 계</li>
		<li id="tot_pay" class="li03">374,550,000</li>
		<li id="tot_enuri" class="li03">1,225,000</li>
		<li id="tot_part" class="li03">0</li>
		<li id="tot_food" class="li03">0</li>
		<li id="tot_regis" class="li03">0</li>
		<li id="tot_new" class="li03">0</li>
		<li class="li04"></li>
	</ul>
</div>























<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>