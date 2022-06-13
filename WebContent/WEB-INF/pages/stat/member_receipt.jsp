<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>
function getList(paging_type) 
{
	var tot_lect_cnt = 0;
	var tot_open_lect_cnt = 0;
	var tot_end_lect_cnt = 0;
	var tot_capacity_no = 0;
	var tot_regis_no = 0;
	$.ajax({
		type : "POST", 
		url : "./getRoomList",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			subject_fg : $("#subject_fg").val()
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
					var open_lect_cnt = Number(nullChkZero(result.list[i].LECT_CNT)) - Number(nullChkZero(result.list[i].END_CNT));
					var open_percent = (Number(open_lect_cnt) / Number(nullChkZero(result.list[i].LECT_CNT)) * 100).toFixed(2);
					var join_percent = (Number(nullChkZero(result.list[i].REGIS_NO)) / Number(nullChkZero(result.list[i].CAPACITY_NO)) * 100).toFixed(2); 
					inner += '<tr>';
					inner += '	<td>'+nullChk(result.list[i].ROOM_NM)+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].LECT_CNT))+'</td>';
					inner += '	<td>'+comma(open_lect_cnt)+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].END_CNT))+'</td>';
					inner += '	<td>'+open_percent+'%</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].CAPACITY_NO))+'</td>';										
					inner += '	<td>'+comma(nullChkZero(result.list[i].REGIS_NO))+'</td>';
					inner += '	<td>'+join_percent+'%</td>';
					inner += '</tr>';
					
					tot_lect_cnt += Number(nullChkZero(result.list[i].LECT_CNT));
					tot_open_lect_cnt += Number(open_lect_cnt);
					tot_end_lect_cnt += Number(nullChkZero(result.list[i].END_CNT));
					tot_capacity_no += Number(nullChkZero(result.list[i].CAPACITY_NO));
					tot_regis_no += Number(nullChkZero(result.list[i].REGIS_NO));
					
				}
				
				$("#tot_lect_cnt").html(comma(nullChkZero(tot_lect_cnt)));
				$("#tot_open_lect_cnt").html(comma(nullChkZero(tot_open_lect_cnt)));
				$("#tot_end_lect_cnt").html(comma(nullChkZero(tot_end_lect_cnt)));
				$("#tot_capacity_no").html(comma(nullChkZero(tot_capacity_no)));
				$("#tot_regis_no").html(comma(nullChkZero(tot_regis_no)));
				$("#tot_per").html((nullChkZero(tot_open_lect_cnt) / (nullChkZero(tot_open_lect_cnt)+nullChkZero(tot_end_lect_cnt)) * 100).toFixed(2)+"%");
				$("#tot_join_per").html((nullChkZero(tot_regis_no) / nullChkZero(tot_capacity_no) * 100).toFixed(2)+"%");
			}
			$("#list_target").html(inner);
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>강의실별 접수 현황</h2>
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
<!-- 		<div class="mag-lr2"> -->
<!-- 			<div class="cal-row table table-auto"> -->
<!-- 				<div class="cal-input wid-4"> -->
<%-- 					<input type="text" id="search_start" name="search_start" value="${search_start}" class="date-i" /> --%>
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 				<div class="cal-dash">-</div> -->
<!-- 				<div class="cal-input wid-4"> -->
<%-- 					<input type="text" id="search_end" name="search_end" value="${search_end}" class="date-i" /> --%>
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="">
			<div class="table table-auto">
				<div class="sear-tit sear-tit_left">강좌 유형</div>
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
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>	


<div class="table-cap table">
	<div class="cap-r text-right">
		
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
				<select id="listSize" name="listSize" onchange="getLectList(1)" de-data="10개씩 보기">
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


<div class="table-wr ip-list">
	
	<div class="table-list table-stlist" >
		<table>
			<thead>
				<tr>
<!-- 					<th>요일</th>	 -->
					<th class="td-170">강의실</th>	
					<th>총 강좌 수</th>	
					<th>개설강좌 수</th>	
					<th>폐강강좌 수</th>	
					<th>개강률</th>	
					<th>정원</th>	
					<th>현원</th>	
					<th>접수율</th>	
				</tr>	
				
			</thead>
			
			<tbody id="list_target">
<!-- 				<tr> -->
<!-- 					<td>9강의실(7층 12호)</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0%</td>										 -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0%</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>월요일</td> -->
<!-- 					<td>9강의실(7층 12호)</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0%</td>										 -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0%</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>월요일</td> -->
<!-- 					<td>9강의실(7층 12호)</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0%</td>										 -->
<!-- 					<td>0</td> -->
<!-- 					<td>0</td> -->
<!-- 					<td>0%</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr class="bg-red"> -->
<!-- 					<td class="sum">월요일 계</td> -->
<!-- 					<td></td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr> -->
<!-- 					<td>:</td> -->
<!-- 					<td colspan="2"></td> -->
<!-- 					<td colspan="2">:</td> -->
<!-- 					<td colspan="2"></td> -->
<!-- 					<td>:</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr class="bg-red"> -->
<!-- 					<td class="sum">화요일 계</td> -->
<!-- 					<td></td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr> -->
<!-- 					<td>:</td> -->
<!-- 					<td colspan="2"></td> -->
<!-- 					<td colspan="2">:</td> -->
<!-- 					<td colspan="2"></td> -->
<!-- 					<td>:</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr class="bg-red"> -->
<!-- 					<td class="sum">수요일 계</td> -->
<!-- 					<td></td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr> -->
<!-- 					<td>:</td> -->
<!-- 					<td colspan="2"></td> -->
<!-- 					<td colspan="2">:</td> -->
<!-- 					<td colspan="2"></td> -->
<!-- 					<td>:</td> -->
<!-- 				</tr> -->
<!-- 				<tr class="bg-red"> -->
<!-- 					<td class="sum">일요일 계</td> -->
<!-- 					<td></td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 					<td>80</td> -->
<!-- 				</tr> -->
			
			</tbody>
		</table>
	</div>
</div>
			


<div class="sta-botfix sta-botfix05">
	<ul>
		<li class="li01">총 계</li>
		<li id="tot_lect_cnt" class="li02">0</li>
		<li id="tot_open_lect_cnt" class="li02">0</li>
		<li id="tot_end_lect_cnt" class="li02">0</li>
		<li id="tot_per"class="li02"></li>
		<li id="tot_capacity_no" class="li02">0</li>
		<li id="tot_regis_no" class="li02">0</li>
		<li id="tot_join_per" class="li02"></li>
		<li class="li03"></li>
	</ul>
</div>




<script>
$(document).ready(function() {
	getList();
});

</script>


















<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>