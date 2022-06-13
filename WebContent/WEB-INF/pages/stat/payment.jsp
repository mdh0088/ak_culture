<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
function getList()
{
	var now_uprice = 0;
	var now_lect_pay = 0;
	var target_uprice = 0;
	var target_lect_pay = 0;
	
	var tmp_now_uprice = 0;
	var tmp_now_lect_pay = 0;
	var tmp_target_uprice = 0;
	var tmp_target_lect_pay = 0;
	$.ajax({
		type : "POST", 
		url : "./getPayment",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			target_store : $("#target_selBranch").val(),
			target_period : $("#target_selPeri").val()
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
			
			for(var i = 0; i < result.list_1.length; i++)
			{
				var tmp1 = 0;
				var tmp2 = 0;
				if( nullChkZero(result.list_1[i].NOW_UPRICE) != 0)
				{
					tmp1 = nullChkZero(result.list_1[i].NOW_LECT_PAY) / nullChkZero(result.list_1[i].NOW_UPRICE) * 100;
				}
				if( nullChkZero(result.list_1[i].TARGET_UPRICE) != 0)
				{
					tmp2 = nullChkZero(result.list_1[i].TARGET_LECT_PAY) / nullChkZero(result.list_1[i].TARGET_UPRICE) * 100;
				}
				inner += '<tr>';
				inner += '	<td>1차</td>';
				inner += '	<td>'+result.list_1[i].MAIN_NM+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_1[i].NOW_UPRICE))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_1[i].NOW_LECT_PAY))+'</td>';
				inner += '	<td>'+(nullChkZero(result.list_1[i].NOW_LECT_PAY) / nullChkZero(result.list_1[i].NOW_UPRICE) * 100).toFixed(2)+'%</td>';
				inner += '	<td>'+(tmp1 - tmp2).toFixed(2)+'%</td>';
				
				inner += '	<td>'+comma(nullChkZero(result.list_1[i].TARGET_UPRICE))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_1[i].TARGET_LECT_PAY))+'</td>';
				inner += '	<td>'+(nullChkZero(result.list_1[i].TARGET_LECT_PAY) / nullChkZero(result.list_1[i].TARGET_UPRICE) * 100).toFixed(2)+'%</td>';
				inner += '</tr>';
				
				now_uprice += Number(result.list_1[i].NOW_UPRICE);
				now_lect_pay += Number(result.list_1[i].NOW_LECT_PAY);
				target_uprice += Number(result.list_1[i].TARGET_UPRICE);
				target_lect_pay += Number(result.list_1[i].TARGET_LECT_PAY);
				
				if(i == 0)
				{
					tmp_now_uprice = 0;
					tmp_now_lect_pay = 0;
					tmp_target_uprice = 0;
					tmp_target_lect_pay = 0;
				}
				tmp_now_uprice += Number(result.list_1[i].NOW_UPRICE);
				tmp_now_lect_pay += Number(result.list_1[i].NOW_LECT_PAY);
				tmp_target_uprice += Number(result.list_1[i].TARGET_UPRICE);
				tmp_target_lect_pay += Number(result.list_1[i].TARGET_LECT_PAY);
				if(i == result.list_1.length-1)
				{
					if( nullChkZero(tmp_now_uprice) != 0)
					{
						tmp1 = nullChkZero(tmp_now_lect_pay) / nullChkZero(tmp_now_uprice) * 100;
					}
					if( nullChkZero(tmp_target_uprice) != 0)
					{
						tmp2 = nullChkZero(tmp_target_lect_pay) / nullChkZero(tmp_target_uprice) * 100;
					}
					
					inner += '<tr class="bg-red" style="font-weight:bold;">';
					inner += '	<td>1차 합계</td>';
					inner += '	<td></td>';
					inner += '	<td>'+comma(nullChkZero(tmp_now_uprice))+'</td>';
					inner += '	<td>'+comma(nullChkZero(tmp_now_lect_pay))+'</td>';
					inner += '	<td>'+(nullChkZero(tmp_now_lect_pay) / nullChkZero(tmp_now_uprice) * 100).toFixed(2)+'%</td>';
					inner += '	<td>'+(tmp1 - tmp2).toFixed(2)+'%</td>';
					
					inner += '	<td>'+comma(nullChkZero(tmp_target_uprice))+'</td>';
					inner += '	<td>'+comma(nullChkZero(tmp_target_lect_pay))+'</td>';
					inner += '	<td>'+(nullChkZero(tmp_target_lect_pay) / nullChkZero(tmp_target_uprice) * 100).toFixed(2)+'%</td>';
					inner += '</tr>';
				}
				
				
			}
			for(var i = 0; i < result.list_2.length; i++)
			{
				var tmp1 = 0;
				var tmp2 = 0;
				if( nullChkZero(result.list_2[i].NOW_UPRICE) != 0)
				{
					tmp1 = nullChkZero(result.list_2[i].NOW_LECT_PAY) / nullChkZero(result.list_2[i].NOW_UPRICE) * 100;
				}
				if( nullChkZero(result.list_2[i].TARGET_UPRICE) != 0)
				{
					tmp2 = nullChkZero(result.list_2[i].TARGET_LECT_PAY) / nullChkZero(result.list_2[i].TARGET_UPRICE) * 100;
				}
				inner += '<tr>';
				inner += '	<td>2차</td>';
				inner += '	<td>'+result.list_2[i].MAIN_NM+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_2[i].NOW_UPRICE))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_2[i].NOW_LECT_PAY))+'</td>';
				inner += '	<td>'+(nullChkZero(result.list_2[i].NOW_LECT_PAY) / nullChkZero(result.list_2[i].NOW_UPRICE) * 100).toFixed(2)+'%</td>';
				inner += '	<td>'+(tmp1 - tmp2).toFixed(2)+'%</td>';
				
				inner += '	<td>'+comma(nullChkZero(result.list_2[i].TARGET_UPRICE))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_2[i].TARGET_LECT_PAY))+'</td>';
				inner += '	<td>'+(nullChkZero(result.list_2[i].TARGET_LECT_PAY) / nullChkZero(result.list_2[i].TARGET_UPRICE) * 100).toFixed(2)+'%</td>';
				inner += '</tr>';
				
				now_lect_pay += Number(result.list_2[i].NOW_LECT_PAY);
				target_lect_pay += Number(result.list_2[i].TARGET_LECT_PAY);
				
				if(i == 0)
				{
					tmp_now_lect_pay = 0;
					tmp_target_lect_pay = 0;
				}
				tmp_now_lect_pay += Number(result.list_2[i].NOW_LECT_PAY);
				tmp_target_lect_pay += Number(result.list_2[i].TARGET_LECT_PAY);
				if(i == result.list_2.length-1)
				{
					if( nullChkZero(tmp_now_uprice) != 0)
					{
						tmp1 = nullChkZero(tmp_now_lect_pay) / nullChkZero(tmp_now_uprice) * 100;
					}
					if( nullChkZero(tmp_target_uprice) != 0)
					{
						tmp2 = nullChkZero(tmp_target_lect_pay) / nullChkZero(tmp_target_uprice) * 100;
					}
					
					inner += '<tr class="bg-red" style="font-weight:bold;">';
					inner += '	<td>2차 합계</td>';
					inner += '	<td></td>';
					inner += '	<td>'+comma(nullChkZero(tmp_now_uprice))+'</td>';
					inner += '	<td>'+comma(nullChkZero(tmp_now_lect_pay))+'</td>';
					inner += '	<td>'+(nullChkZero(tmp_now_lect_pay) / nullChkZero(tmp_now_uprice) * 100).toFixed(2)+'%</td>';
					inner += '	<td>'+(tmp1 - tmp2).toFixed(2)+'%</td>';
					
					inner += '	<td>'+comma(nullChkZero(tmp_target_uprice))+'</td>';
					inner += '	<td>'+comma(nullChkZero(tmp_target_lect_pay))+'</td>';
					inner += '	<td>'+(nullChkZero(tmp_target_lect_pay) / nullChkZero(tmp_target_uprice) * 100).toFixed(2)+'%</td>';
					inner += '</tr>';
				}
				
			}
			for(var i = 0; i < result.list_3.length; i++)
			{
				var tmp1 = 0;
				var tmp2 = 0;
				if( nullChkZero(result.list_3[i].NOW_UPRICE) != 0)
				{
					tmp1 = nullChkZero(result.list_3[i].NOW_LECT_PAY) / nullChkZero(result.list_3[i].NOW_UPRICE) * 100;
				}
				if( nullChkZero(result.list_3[i].TARGET_UPRICE) != 0)
				{
					tmp2 = nullChkZero(result.list_3[i].TARGET_LECT_PAY) / nullChkZero(result.list_3[i].TARGET_UPRICE) * 100;
				}
				inner += '<tr>';
				inner += '	<td>3차</td>';
				inner += '	<td>'+result.list_3[i].MAIN_NM+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_3[i].NOW_UPRICE))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_3[i].NOW_LECT_PAY))+'</td>';
				inner += '	<td>'+(nullChkZero(result.list_3[i].NOW_LECT_PAY) / nullChkZero(result.list_3[i].NOW_UPRICE) * 100).toFixed(2)+'%</td>';
				inner += '	<td>'+(tmp1 - tmp2).toFixed(2)+'%</td>';
				
				inner += '	<td>'+comma(nullChkZero(result.list_3[i].TARGET_UPRICE))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list_3[i].TARGET_LECT_PAY))+'</td>';
				inner += '	<td>'+(nullChkZero(result.list_3[i].TARGET_LECT_PAY) / nullChkZero(result.list_3[i].TARGET_UPRICE) * 100).toFixed(2)+'%</td>';
				inner += '</tr>';
				
				now_lect_pay += Number(result.list_3[i].NOW_LECT_PAY);
				target_lect_pay += Number(result.list_3[i].TARGET_LECT_PAY);
				
				if(i == 0)
				{
					tmp_now_lect_pay = 0;
					tmp_target_lect_pay = 0;
				}
				tmp_now_lect_pay += Number(result.list_3[i].NOW_LECT_PAY);
				tmp_target_lect_pay += Number(result.list_3[i].TARGET_LECT_PAY);
				if(i == result.list_3.length-1)
				{
					if( nullChkZero(tmp_now_uprice) != 0)
					{
						tmp1 = nullChkZero(tmp_now_lect_pay) / nullChkZero(tmp_now_uprice) * 100;
					}
					if( nullChkZero(tmp_target_uprice) != 0)
					{
						tmp2 = nullChkZero(tmp_target_lect_pay) / nullChkZero(tmp_target_uprice) * 100;
					}
					
					inner += '<tr class="bg-red" style="font-weight:bold;">';
					inner += '	<td>3차 합계</td>';
					inner += '	<td></td>';
					inner += '	<td>'+comma(nullChkZero(tmp_now_uprice))+'</td>';
					inner += '	<td>'+comma(nullChkZero(tmp_now_lect_pay))+'</td>';
					inner += '	<td>'+(nullChkZero(tmp_now_lect_pay) / nullChkZero(tmp_now_uprice) * 100).toFixed(2)+'%</td>';
					inner += '	<td>'+(tmp1 - tmp2).toFixed(2)+'%</td>';
					
					inner += '	<td>'+comma(nullChkZero(tmp_target_uprice))+'</td>';
					inner += '	<td>'+comma(nullChkZero(tmp_target_lect_pay))+'</td>';
					inner += '	<td>'+(nullChkZero(tmp_target_lect_pay) / nullChkZero(tmp_target_uprice) * 100).toFixed(2)+'%</td>';
					inner += '</tr>';
				}
				
			}
			
			$("#target").html(inner);
			$("#now_uprice").html(comma(now_uprice));
			$("#now_lect_pay").html(comma(now_lect_pay));
			
			$("#target_uprice").html(comma(target_uprice));
			$("#target_lect_pay").html(comma(target_lect_pay));
			
			var per1 = nullChkZero(now_lect_pay) / nullChkZero(now_uprice) * 100;
			var per2 = nullChkZero(target_lect_pay) / nullChkZero(target_uprice) * 100;
			$("#now_lect_pay_per").html(per1.toFixed(2)+"%");
			$("#target_lect_pay_per").html(per2.toFixed(2)+"%");
			$("#daebee_per").html((per1 - per2).toFixed(2)+"%");
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>강사료 지급 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row">	
		<div class="wid-5">
			<div class="table">
				<div class="sear-tit ">현재 기수</div>
				<div class="">
					<div class="table table-auto">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table table-auto">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- 		<div class="wid-35 mag-l2"> -->
<!-- 			<div class="cal-row cal-row_inline cal-row02 table"> -->
<!-- 				<div class="cal-input wid-4"> -->
<!-- 					<input type="text" class="date-i" id="start_ymd" name="start_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 				<div class="cal-dash">-</div> -->
<!-- 				<div class="cal-input wid-4"> -->
<!-- 					<input type="text" class="date-i" id="end_ymd" name="end_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-11 mag-l2"> -->
<!-- 			<ul class="chk-ul"> -->
<!-- 				<li> -->
<!-- 					<input type="checkbox" id="isPerformance" name="isPerformance"> -->
<!-- 					<label for="isPerformance">임시 중분류 포함</label> -->
<!-- 				</li> -->
<!-- 			</ul> -->
<!-- 		</div> -->
	</div>
	<div class="top-row top-row_red">	
		<div class="wid-5">
			<div class="table">
				<div class="sear-tit ">비교 기수</div>
				<div class="">
					<div class="table table-auto">
						<jsp:include page="/WEB-INF/pages/common/peri1_for_target.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2_for_target.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
<!-- 		<div class="wid-35 mag-l2"> -->
<!-- 			<div class="cal-row cal-row_inline cal-row02 table"> -->
<!-- 				<div class="cal-input wid-4"> -->
<!-- 					<input type="text" class="date-i" id="start_ymd" name="start_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 				<div class="cal-dash">-</div> -->
<!-- 				<div class="cal-input wid-4"> -->
<!-- 					<input type="text" class="date-i" id="end_ymd" name="end_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="wid-11 mag-l2">
			
		</div>
	
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>	


<!-- <div class="table-cap table"> -->
<!-- 	<div class="cap-r text-right"> -->
		
<!-- 		<div class="table table02 table-auto float-right"> -->
<!-- 			<div class="sel-scr"> -->
<!-- 				<select id="listSize" name="listSize" onchange="getLectList(1)" de-data="10개씩 보기"> -->
<!-- 					<option value="10">10개 보기</option> -->
<!-- 					<option value="20">20개 보기</option> -->
<!-- 					<option value="50">50개 보기</option> -->
<!-- 					<option value="100">100개 보기</option> -->
<!-- 					<option value="300">300개 보기</option> -->
<!-- 					<option value="500">500개 보기</option> -->
<!-- 					<option value="1000">1000개 보기</option> -->
<!-- 				</select> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->


<div class="table-wr ip-list">
	
	<div class="table-list table-stlist" >
		<table>
			<thead>
				<tr class="table-stptr01">
					<th>차수</th>
					<th>대분류</th>
					<th class="col01" colspan="4">현재 기수</th>
					<th colspan="3">비교 기수</th>
				</tr>	
				<tr  class="table-stptr02">
					<th></th>
					<th></th>
					<th class="col02">총 매출</th>
					<th class="col02">총 강사료</th>
					<th class="col02">지급율</th>
					<th class="col02">대비율</th>
					<th>총 매출</th>
					<th>총 강사료</th>
					<th>지급율</th>
				</tr>			
				
			</thead>
			
			<tbody id="target">
				
			</tbody>
		</table>
	</div>
</div>
			


<div class="sta-botfix sta-botfix06">
	<ul>
		<li class="li01">총 계</li>
		<li id="now_uprice" class="li03">0</li>
		<li id="now_lect_pay" class="li03">0</li>
		<li id="now_lect_pay_per" class="li03"></li>
		<li id="daebee_per" class="li03"></li>
		<li id="target_uprice" class="li02">0</li>
		<li id="target_lect_pay" class="li02">0</li>
		<li id="target_lect_pay_per" class="li02"></li>
	</ul>
</div>










<script>
$(document).ready(function(){
	getList();
});
</script>












<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>