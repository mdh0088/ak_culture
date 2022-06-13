<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
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
	setPeri();
	fncPeri();
	getList();
});
function getList(paging_type) 
{
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
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			pelt_status : $("#pelt_status").val(),
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
			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+result.list[i].WEB_LECTURER_NM+'</td>';
					inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+nullChk(result.list[i].REGIS_FEE)+'</td>';
					inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
					inner += '	<td>'+cutLectHour(result.list[i].LECT_HOUR)+'</td>';
					if(nullChk(result.list[i].PLAN_CNT) != "")
					{
						inner += '	<td>'+result.list[i].PLAN_CNT+'%</td>';
						if(result.list[i].PLAN_CNT == "100")
						{
							inner += '	<td class="color-red line-blue" onclick="location.href=\'/lecture/lect/plan_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">완료</td>';
						}
						else
						{
							inner += '	<td class="color-red line-blue" onclick="location.href=\'/lecture/lect/plan_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">미완료</td>';
						}
					}
					else
					{
						inner += '	<td>0%</td>';
						inner += '	<td class="color-red line-blue" onclick="location.href=\'/lecture/lect/plan_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">미완료</td>';
					}
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="13"><div class="no-data">검색결과가 없습니다.</div></td>';
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
			$("#per_span").css("width", result.percent+"%");
			$("#per_div").html(result.percent+"%");
		}
	});	
}
</script>

<div class="sub-tit">
	<h2>강의계획서 작성리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<div class="plan-grp plan-grp02">
			<div class="plan-gtit">전체 작성상황</div>
			<div class="plan-grpd"><div class="plg-wr"><span id="per_span"></span></div></div>
			<div class="plan-per color-pink" id="per_div"></div>
		</div>
		<a class="btn btn02 btn-inline" href="#">취소/환불 규정</a>
		<a class="btn btn01  btn01_1" href="#">일괄 강의계획서 작성요청</a>
		
	</div>
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-45">
			<div class="table">
				<div class="wid-35">
					<div class="table table02 table-input wid-contop">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-45 mag-lr2">
			<div class="table">
				<div class="search-wr sel100">
					<select id="search_type" name="search_type" de-data="강좌명">
						<option value="subject_nm">강좌명</option>
						<option value="subject_cd">코드번호</option>
					</select>
				    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
				    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
				</div>
			</div>
		</div>
		
	</div>
	<div class="top-row">
<!-- 		<div class="wid-35_2"> -->
<!-- 			<div class="cal-row cal-row_inline cal-row02 table"> -->
<!-- 				<div class="cal-input cal-input180 wid-4"> -->
<!-- 					<input type="text" class="date-i" id="start_ymd" name="start_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 				<div class="cal-dash">-</div> -->
<!-- 				<div class="cal-input cal-input180 wid-4"> -->
<!-- 					<input type="text" class="date-i" id="end_ymd" name="end_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-2"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">대분류</div> -->
<!-- 				<div> -->
<!-- 					<select de-data="선택"> -->
<!-- 						<option>분류1</option> -->
<!-- 						<option>분류2</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-3 mag-l2 wid-rt02"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">중분류</div> -->
<!-- 				<div> -->
<!-- 					<select de-data="선택"> -->
<!-- 						<option>분류1</option> -->
<!-- 						<option>분류2</option> -->
<!-- 					</select> -->
<!-- 					<ul class="chk-ul"> -->
<!-- 						<li> -->
<!-- 							<input type="checkbox" id="all-c" name="all-c"> -->
<!-- 							<label for="all-c">폐강제외</label> -->
<!-- 						</li>							 -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
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
		<div class="wid-2">
			<div class="table margin-auto">
				<div class="sear-tit sear-tit-70">접수상태</div>
				<div class="oddn-sel"s>
					<select id="pelt_status" name="pelt_status" de-data="전체">
						<option value="">전체</option>
						<option value="play">모집중</option>
						<option value="finish">마감</option>
						<option value="end">폐강</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
</div>
<div class="table-wr ip-list">
	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			
			<div class="table table02 table-auto float-right">
				<div class="sel-scr">
					<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a>
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
	
	<div class="table-list">
		<table>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th class="td-60" onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th class="td-50" onclick="reSortAjax('sort_subject_fg')">유형 <img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th class="td-100" onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					
					<th class="td-90" onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th class="td-170" onclick="reSortAjax('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th class="td-90" onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th class="td-90" onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
					<th onclick="reSortAjax('sort_plan_cnt')">작성률 <img src="/img/th_up.png" id="sort_plan_cnt"></th>
					<th >강의계획서 </th>
				</tr>
			</thead>
			<tbody id="list_target">
				<tr>
					<td class="td-chk">
						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label>
					</td>
					<td>분당점</td>
					<td>성인</td>
					<td>건강/웰빙</td>
					<td>정규</td>
					<td>101076</td>
					<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">이호걸</td>
					<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">일요 밸런스 요가</td>
					<td>80,000</td>
					<td>목</td>
					<td>10:30~11:50</td>
					<td>50%</td>
					<td class="color-red line-blue" onclick="location.href='/lecture/lect/plan_write'" style="cursor:pointer;">미완료</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>