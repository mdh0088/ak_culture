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
function getList(paging_type) 
{
	var a_uprice = 0;
	var a_person = 0;
	var a_new = 0;
	var b_uprice = 0;
	var b_person = 0;
	var b_new = 0;
	var c_uprice = 0;
	var c_person = 0;
	var c_new = 0;
	
	var top_price = 0;
	var low_price = 0;
	var top_ymd = "";
	var low_ymd = "";
	
	var web_price = 0;
	var desk_price = 0;
	$.ajax({
		type : "POST", 
		url : "./getDaylist",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
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
					inner += '	<td>'+cutDate(nullChk(result.list[i].SALE_YMD))+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result.list[i].A_UPRICE))+Number(nullChkZero(result.list[i].B_UPRICE))+Number(nullChkZero(result.list[i].C_UPRICE)))+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result.list[i].A_PERSON))+Number(nullChkZero(result.list[i].B_PERSON))+Number(nullChkZero(result.list[i].C_PERSON)))+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result.list[i].A_NEW))+Number(nullChkZero(result.list[i].B_NEW))+Number(nullChkZero(result.list[i].C_NEW)))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].A_UPRICE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].A_PERSON))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].A_NEW))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].B_UPRICE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].B_PERSON))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].B_NEW))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].C_UPRICE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].C_PERSON))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].C_NEW))+'</td>';
					inner += '</tr>';
					
					
					a_uprice += Number(nullChkZero(result.list[i].A_UPRICE));
					a_person += Number(nullChkZero(result.list[i].A_PERSON));
					a_new += Number(nullChkZero(result.list[i].A_NEW));
					b_uprice += Number(nullChkZero(result.list[i].B_UPRICE));
					b_person += Number(nullChkZero(result.list[i].B_PERSON));
					b_new += Number(nullChkZero(result.list[i].B_NEW));
					c_uprice += Number(nullChkZero(result.list[i].C_UPRICE));
					c_person += Number(nullChkZero(result.list[i].C_PERSON));
					c_new += Number(nullChkZero(result.list[i].C_NEW));
					
					web_price += Number(nullChkZero(result.list[i].A_WEB_UPRICE))+Number(nullChkZero(result.list[i].B_WEB_UPRICE))+Number(nullChkZero(result.list[i].C_WEB_UPRICE));
					web_price += Number(nullChkZero(result.list[i].A_MOBILE_UPRICE))+Number(nullChkZero(result.list[i].B_MOBILE_UPRICE))+Number(nullChkZero(result.list[i].C_MOBILE_UPRICE)); 
					
					var uprice = Number(nullChkZero(result.list[i].A_UPRICE))+Number(nullChkZero(result.list[i].B_UPRICE))+Number(nullChkZero(result.list[i].C_UPRICE));
					if(top_price < uprice)
					{
						top_price = uprice;
						top_ymd = cutDate(nullChk(result.list[i].SALE_YMD));
					}
					if(low_price > uprice)
					{
						low_price = uprice;
						low_ymd = cutDate(nullChk(result.list[i].SALE_YMD));
					}
					
				}
			}
			$("#list_target").html(inner);
			
			$("#tot_uprice").html(comma(Number(a_uprice)+Number(b_uprice)+Number(c_uprice)));
			$("#tot_person").html(comma(Number(a_person)+Number(b_person)+Number(c_person)));
			$("#tot_new").html(comma(Number(a_new)+Number(b_new)+Number(c_new)));
			$("#a_uprice").html(comma(a_uprice));
			$("#a_person").html(comma(a_person));
			$("#a_new").html(comma(a_new));
			$("#b_uprice").html(comma(b_uprice));
			$("#b_person").html(comma(b_person));
			$("#b_new").html(comma(b_new));
			$("#c_uprice").html(comma(c_uprice));
			$("#c_person").html(comma(c_person));
			$("#c_new").html(comma(c_new));
			
			var desk_price = Number(a_uprice)+Number(b_uprice)+Number(c_uprice) - Number(web_price);
			$("#web_price").html(comma(web_price));
			$("#desk_price").html(comma(desk_price));
			
			var tmp = Number(web_price) / (Number(web_price)+Number(desk_price)) * 100;
			$("#web_percent").html("온라인 "+tmp.toFixed(2) + "%");
			
			tmp = Number(desk_price) / (Number(web_price)+Number(desk_price)) * 100;
			$("#desk_percent").html("오프라인 "+tmp.toFixed(2) + "%");
			
			$("#top_uprice").html(comma(top_price)+"<span>원</span>");
			$("#low_uprice").html(comma(low_price)+"<span>원</span>");
			
			$("#top_ymd").html(top_ymd);
			$("#low_ymd").html(low_ymd);
			
		}
	});	
}

</script>

	
<div class="sub-tit">
	<h2>일별 접수 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row">
			<div class="">
				<div class="table table-auto">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<div class="sel-scr oddn-sel">
					<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
				</div>
			</div>		
			<div class="mag-lr2">
				<div class="table table-auto">
					<div class="cal-row">
						<div class="cal-input cal-input02 cal-input_rec">
							<input type="text" class="date-i start-i" id="search_start" name="search_start"/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input cal-input02 cal-input_rec">
							<input type="text" class="date-i ready-i" id="search_end" name="search_end"/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
			
<!-- 			<div class="wid-15"> -->
<!-- 				<div class="table"> -->
<!-- 					<div class="sear-tit sear-tit_70">POS NO</div> -->
<!-- 					<div> -->
<!-- 						<select id="selPos" name="selPos"> -->
<!-- 						</select> -->
<!-- 						 <a class="btn btn02 mrg-l6" onclick="javascript:getProcList();">조회</a>  -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			<div class="wid-1">
				<ul class="chk-ul">
					<li>
						<input type="checkbox" id="isPerformance" name="isPerformance">
						<label for="isPerformance">임시 중분류 포함</label>
					</li>
				</ul>
			</div>
		</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>	



<div class="receipt-wrap receipt-wrap02">
	<div class="rec-box">
	
		<div class="re-day">
			<p>최대 매출금액</p>
			<div id="top_uprice"><span>원</span></div>
			<div id="top_ymd" class="ymd"></div>
		</div>
		
		<div class="re-day">
			<p>최소 매출금액</p>
			<div id="low_uprice"><span>원</span></div>
			<div id="low_ymd" class="ymd"></div>
		</div>
		
		<div class="re-day">
			<p>온라인 매출금액</p>
			<div id="web_price"><span>원</span></div>
			<div id="web_percent" class="ymd"></div>
		</div>
		
		<div class="re-day">
			<p>오프라인 매출금액</p>
			<div id="desk_price"><span>원</span></div>
			<div id="desk_percent" class="ymd"></div>
		</div>
		
		
	</div>	
</div> <!-- // receipt-wrap end -->



<div class="table-wr ip-list">
	
	<div class="table-list table-stlist">
		<table>
			<thead>
				<tr class="table-stdaytr01">
					<th rowspan="2">지점</th>			
					<th rowspan="2">매출일</th>
					<th class="std01" colspan="3">합계</th>
					<th colspan="3">정규</th>
					<th class="std01" colspan="3">단기</th>
					<th colspan="3">특강</th>
				</tr>	
				<tr class="table-stdaytr02">
<!-- 					<th class="std02">강좌수</th> -->
					<th class="std02">총매출</th>
					<th class="std02">회원수</th>
					<th class="std02">신규</th>
					<th>총매출</th>
					<th>회원수</th>
					<th>신규</th>
					<th class="std02">총매출</th>
					<th class="std02">회원수</th>
					<th class="std02">신규</th>
					<th>총매출</th>
					<th>회원수</th>
					<th>신규</th>
				</tr>
			</thead>
			
			<tbody id="list_target">
				
			</tbody>
		</table>
	</div>
</div>
			


<div class="sta-botfix sta-botfix03">
	<ul>
		<li class="li01">총 계</li>
		<li id="tot_uprice" class="li02">0</li>
		<li id="tot_person" class="li02">0</li>
		<li id="tot_new" class="li02">0</li>
		<li id="a_uprice" class="li02">0</li>
		<li id="a_person" class="li02">0</li>
		<li id="a_new" class="li02">0</li>
		<li id="b_uprice" class="li02">0</li>
		<li id="b_person" class="li02">0</li>
		<li id="b_new" class="li02">0</li>
		<li id="c_uprice" class="li02">0</li>
		<li id="c_person" class="li02">0</li>
		<li id="c_new" class="li02">0</li>
		<li class="li03"></li>
	</ul>
</div>






<script>
$(document).ready(function() {
	setPeri();
	fncPeri();
	selPeri();
	getList();
});

</script>
















<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>