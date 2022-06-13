<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<style>
.chk-ul > li
{
	width:100px;
}
</style>
<script>

function changeStatus(seq)
{
	if($("#delete_yn_"+seq).hasClass("btn03"))
	{
		$("#delete_yn_"+seq).removeClass("btn03");
		$("#delete_yn_"+seq).removeClass("btn03");
		$("#delete_yn_"+seq).addClass("btn04");
		$("#delete_yn_"+seq).html("N");
		$("#delete_yn_"+seq+"_status").val("N");
	}
	else if($("#delete_yn_"+seq).hasClass("btn04"))
	{
		$("#delete_yn_"+seq).removeClass("btn04");
		$("#delete_yn_"+seq).addClass("btn03");
		$("#delete_yn_"+seq).html("Y");
		$("#delete_yn_"+seq+"_status").val("Y");
	}
	
	if(seq != "new")
	{
		$.ajax({
			type : "POST", 
			url : "./changeDelete",
			dataType : "text",
			data : 
			{
				seq : seq,
				delete_yn : $("#delete_yn_"+seq+"_status").val()
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
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}
function changeRoom()
{
	location.href="/lecture/lect/room_view?seq="+$("#selRoom").val();
}
$(document).ready(function(){
	getWeekCnt();
})
function getWeekCnt()
{
	$.ajax({
		type : "POST", 
		url : "./getWeekCnt",
		dataType : "text",
		async : false,
		data : 
		{
			store : '${data.STORE}'
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var selInner = "";
			
			selInner += '<select id="weekCnt" name="weekCnt" onchange="getPeltBySchedule()" de-data="1회차">';
			for(var i = 1; i <= Number(result.weekCnt); i++)
			{
				if(i == 1)
				{
					selInner += '	<option value="'+i+'" selected>'+i+'회차</option>';
				}
				else
				{
					selInner += '	<option value="'+i+'">'+i+'회차</option>';
				}
			}
			selInner += '</select>';
			
			$("#weekDiv").html(selInner);
			selectInit_one('weekDiv');
			$(".weekDiv").html("1회차");
			
			getPeltBySchedule();
		}
	});	
}
function getPeltBySchedule()
{
	$.ajax({
		type : "POST", 
		url : "./getPeltBySchedule",
		dataType : "text",
		async : false,
		data : 
		{
			store : '${data.STORE}',
			weekCnt : $("#weekCnt").val(),
			seq : '${seq}'
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
			
			inner += '<tr class="lect-sched">';
			inner += '	<td>10시 전</td>';
			inner += '	<td id="mon_10_before"><div class="lect-schediv"></div></td>';
			inner += '	<td id="tue_10_before"><div class="lect-schediv"></div></td>';
			inner += '	<td id="wed_10_before"><div class="lect-schediv"></div></td>';
			inner += '	<td id="thu_10_before"><div class="lect-schediv"></div></td>';
			inner += '	<td id="fri_10_before"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sat_10_before"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sun_10_before"><div class="lect-schediv"></div></td>';
			inner += '</tr>';
			inner += '<br>';
			inner += '<tr class="chk-tr">';
			inner += '	<td>10시 ~ 12시</td>';
			inner += '	<td id="mon_10"><div class="lect-schediv"></div></td>';
			inner += '	<td id="tue_10"><div class="lect-schediv"></div></td>';
			inner += '	<td id="wed_10"><div class="lect-schediv"></div></td>';
			inner += '	<td id="thu_10"><div class="lect-schediv"></div></td>';
			inner += '	<td id="fri_10"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sat_10"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sun_10"><div class="lect-schediv"></div></td>';
			inner += '</tr>';
			inner += '<br>';
			inner += '<tr class="chk-tr">';
			inner += '	<td>12시 ~ 14시</td>';
			inner += '	<td id="mon_12"><div class="lect-schediv"></div></td>';
			inner += '	<td id="tue_12"><div class="lect-schediv"></div></td>';
			inner += '	<td id="wed_12"><div class="lect-schediv"></div></td>';
			inner += '	<td id="thu_12"><div class="lect-schediv"></div></td>';
			inner += '	<td id="fri_12"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sat_12"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sun_12"><div class="lect-schediv"></div></td>';
			inner += '</tr>';
			inner += '<br>';
			inner += '<tr class="chk-tr">';
			inner += '	<td>14시 ~ 16시</td>';
			inner += '	<td id="mon_14"><div class="lect-schediv"></div></td>';
			inner += '	<td id="tue_14"><div class="lect-schediv"></div></td>';
			inner += '	<td id="wed_14"><div class="lect-schediv"></div></td>';
			inner += '	<td id="thu_14"><div class="lect-schediv"></div></td>';
			inner += '	<td id="fri_14"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sat_14"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sun_14"><div class="lect-schediv"></div></td>';
			inner += '</tr>';
			inner += '<br>';
			inner += '<tr class="chk-tr">';
			inner += '	<td>16시 ~ 18시</td>';
			inner += '	<td id="mon_16"><div class="lect-schediv"></div></td>';
			inner += '	<td id="tue_16"><div class="lect-schediv"></div></td>';
			inner += '	<td id="wed_16"><div class="lect-schediv"></div></td>';
			inner += '	<td id="thu_16"><div class="lect-schediv"></div></td>';
			inner += '	<td id="fri_16"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sat_16"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sun_16"><div class="lect-schediv"></div></td>';
			inner += '</tr>';
			inner += '<br>';
			inner += '<tr class="chk-tr">';
			inner += '	<td>18시 이후</td>';
			inner += '	<td id="mon_18"><div class="lect-schediv"></div></td>';
			inner += '	<td id="tue_18"><div class="lect-schediv"></div></td>';
			inner += '	<td id="wed_18"><div class="lect-schediv"></div></td>';
			inner += '	<td id="thu_18"><div class="lect-schediv"></div></td>';
			inner += '	<td id="fri_18"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sat_18"><div class="lect-schediv"></div></td>';
			inner += '	<td id="sun_18"><div class="lect-schediv"></div></td>';
			inner += '</tr>';
			
			$(".table-list tbody").html(inner);
			
			for(var i = 0; i < result.length; i++)
			{
				var lect_hour = Number(result[i].LECT_HOUR.substring(0,2));
				var lect_txt = "<div class='sche-box'>" + result[i].SUBJECT_NM +  "<span>(" + cutLectHour(result[i].LECT_HOUR) + ")</span><div class='sche-clo'><i class='far fa-window-close'></i></div></div>";
				if(result[i].IS_MON == 'Y' && lect_hour < 10) {$("#mon_10_before .lect-schediv").append(lect_txt);}
				if(result[i].IS_TUE == 'Y' && lect_hour < 10) {$("#tue_10_before .lect-schediv").append(lect_txt);}
				if(result[i].IS_WED == 'Y' && lect_hour < 10) {$("#wed_10_before .lect-schediv").append(lect_txt);}
				if(result[i].IS_THU == 'Y' && lect_hour < 10) {$("#thu_10_before .lect-schediv").append(lect_txt);}
				if(result[i].IS_FRI == 'Y' && lect_hour < 10) {$("#fri_10_before .lect-schediv").append(lect_txt);}
				if(result[i].IS_SAT == 'Y' && lect_hour < 10) {$("#sat_10_before .lect-schediv").append(lect_txt);}
				if(result[i].IS_SUN == 'Y' && lect_hour < 10) {$("#sun_10_before .lect-schediv").append(lect_txt);}

				if(result[i].IS_MON == 'Y' && lect_hour >= 10 && lect_hour < 12) {$("#mon_10 .lect-schediv").append(lect_txt);}
				if(result[i].IS_TUE == 'Y' && lect_hour >= 10 && lect_hour < 12) {$("#tue_10 .lect-schediv").append(lect_txt);}
				if(result[i].IS_WED == 'Y' && lect_hour >= 10 && lect_hour < 12) {$("#wed_10 .lect-schediv").append(lect_txt);}
				if(result[i].IS_THU == 'Y' && lect_hour >= 10 && lect_hour < 12) {$("#thu_10 .lect-schediv").append(lect_txt);}
				if(result[i].IS_FRI == 'Y' && lect_hour >= 10 && lect_hour < 12) {$("#fri_10 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SAT == 'Y' && lect_hour >= 10 && lect_hour < 12) {$("#sat_10 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SUN == 'Y' && lect_hour >= 10 && lect_hour < 12) {$("#sun_10 .lect-schediv").append(lect_txt);}

				if(result[i].IS_MON == 'Y' && lect_hour >= 12 && lect_hour < 14) {$("#mon_12 .lect-schediv").append(lect_txt);}
				if(result[i].IS_TUE == 'Y' && lect_hour >= 12 && lect_hour < 14) {$("#tue_12 .lect-schediv").append(lect_txt);}
				if(result[i].IS_WED == 'Y' && lect_hour >= 12 && lect_hour < 14) {$("#wed_12 .lect-schediv").append(lect_txt);}
				if(result[i].IS_THU == 'Y' && lect_hour >= 12 && lect_hour < 14) {$("#thu_12 .lect-schediv").append(lect_txt);}
				if(result[i].IS_FRI == 'Y' && lect_hour >= 12 && lect_hour < 14) {$("#fri_12 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SAT == 'Y' && lect_hour >= 12 && lect_hour < 14) {$("#sat_12 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SUN == 'Y' && lect_hour >= 12 && lect_hour < 14) {$("#sun_12 .lect-schediv").append(lect_txt);}

				if(result[i].IS_MON == 'Y' && lect_hour >= 14 && lect_hour < 16) {$("#mon_14 .lect-schediv").append(lect_txt);}
				if(result[i].IS_TUE == 'Y' && lect_hour >= 14 && lect_hour < 16) {$("#tue_14 .lect-schediv").append(lect_txt);}
				if(result[i].IS_WED == 'Y' && lect_hour >= 14 && lect_hour < 16) {$("#wed_14 .lect-schediv").append(lect_txt);}
				if(result[i].IS_THU == 'Y' && lect_hour >= 14 && lect_hour < 16) {$("#thu_14 .lect-schediv").append(lect_txt);}
				if(result[i].IS_FRI == 'Y' && lect_hour >= 14 && lect_hour < 16) {$("#fri_14 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SAT == 'Y' && lect_hour >= 14 && lect_hour < 16) {$("#sat_14 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SUN == 'Y' && lect_hour >= 14 && lect_hour < 16) {$("#sun_14 .lect-schediv").append(lect_txt);}

				if(result[i].IS_MON == 'Y' && lect_hour >= 16 && lect_hour < 18) {$("#mon_16 .lect-schediv").append(lect_txt);}
				if(result[i].IS_TUE == 'Y' && lect_hour >= 16 && lect_hour < 18) {$("#tue_16 .lect-schediv").append(lect_txt);}
				if(result[i].IS_WED == 'Y' && lect_hour >= 16 && lect_hour < 18) {$("#wed_16 .lect-schediv").append(lect_txt);}
				if(result[i].IS_THU == 'Y' && lect_hour >= 16 && lect_hour < 18) {$("#thu_16 .lect-schediv").append(lect_txt);}
				if(result[i].IS_FRI == 'Y' && lect_hour >= 16 && lect_hour < 18) {$("#fri_16 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SAT == 'Y' && lect_hour >= 16 && lect_hour < 18) {$("#sat_16 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SUN == 'Y' && lect_hour >= 16 && lect_hour < 18) {$("#sun_16 .lect-schediv").append(lect_txt);}
				
				if(result[i].IS_MON == 'Y' && lect_hour >= 18) {$("#mon_18 .lect-schediv").append(lect_txt);}
				if(result[i].IS_TUE == 'Y' && lect_hour >= 18) {$("#tue_18 .lect-schediv").append(lect_txt);}
				if(result[i].IS_WED == 'Y' && lect_hour >= 18) {$("#wed_18 .lect-schediv").append(lect_txt);}
				if(result[i].IS_THU == 'Y' && lect_hour >= 18) {$("#thu_18 .lect-schediv").append(lect_txt);}
				if(result[i].IS_FRI == 'Y' && lect_hour >= 18) {$("#fri_18 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SAT == 'Y' && lect_hour >= 18) {$("#sat_18 .lect-schediv").append(lect_txt);}
				if(result[i].IS_SUN == 'Y' && lect_hour >= 18) {$("#sun_18 .lect-schediv").append(lect_txt);}
			}
			
		}
	});	
}
</script>


<div class="sub-tit">
	<h2>강의실 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<div class="plan-grp plan-grp02">
			<div class="plan-onof">
				<span>사용여부</span>
				<c:if test="${data.DELETE_YN eq 'Y'}">
					<a onclick="javascript:changeStatus('${data.SEQ_NO}')" id="delete_yn_${data.SEQ_NO}" name="delete_yn" class="btn04 bor-btn btn-inline">N</a>
					<input type="hidden" id="delete_yn_${data.SEQ_NO}_status" name="delete_yn_status" value="N">
				</c:if>
				<c:if test="${data.DELETE_YN eq 'N'}">
					<a onclick="javascript:changeStatus('${data.SEQ_NO}')" id="delete_yn_${data.SEQ_NO}" name="delete_yn" class="btn03 bor-btn btn-inline">Y</a>
					<input type="hidden" id="delete_yn_${data.SEQ_NO}_status" name="delete_yn_status" value="Y">
				</c:if>
			</div>
		</div>
	</div>
</div>

<div class="lect-top lect-room-top table-top first">
	<div class="">
		<p class="lect-st"><span class="color-pink">${data.ROOM_NM}</span></p>
		<div class="lect-titwr">
			<p class="lect-tit">${data.LOCATION}</p>
			<p class="lect-tit2">${data.USAGE}</p>
			<p class="btn btn08">${data.STORE_NM}</p>
		</div>
		<div class="other-room">
			<p>타 강의실 보기</p>
			<div class="sel-scr">
				<select de-data="선택" id="selRoom" name="selRoom" onchange="changeRoom()">
					<c:forEach var="i" items="${room_list}" varStatus="loop">
						<option value="${i.SEQ_NO}">${i.ROOM_NM}(${i.LOCATION})</option>
					</c:forEach>
				</select>
			</div>
		</div>
		
	</div>
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-6">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
		</div>
		<div class="wid-3">
			<div class="table table-input">
				<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
				<div class="oddn-sel sel-scr">
					<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
				</div>
			</div>
		</div>
		<div class="wid-1">
			<div class="table table-input">
				<div><input class="search-btn03 btn btn02" type="button" value="선택완료" onclick="reSelect()"></div>
			</div>
		</div>
	</div>
</div>
<div class="table-wr ip-list">
	<div class="table-cap table">
		<div class="cap-r text-right">
			
			<div class="float-right">
				<div class="sel-scr" id="weekDiv">
					
				</div>
			</div>
		</div>
	</div>
	
	<div class="table-list schedule-list">
		<table>
			<thead>
				<tr>
					<th></th>
					<th>월</th>
					<th>화</th>
					<th>수</th>
					<th>목</th>
					<th>금</th>
					<th>토</th>
					<th>일</th>
				</tr>
			</thead>
			</thead>
			<tbody>
			
			</tbody>
		</table>
	</div>
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>