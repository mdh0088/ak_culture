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

function endAction()
{
	var chkList = "";
	var send_tm ="N";
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

function getList(paging_type) 
{
	$.ajax({
		type : "POST", 
		url : "./getEndPeltList",
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
					inner += '	<td>'+nullChk(result.list[i].STORE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].END_SUBJECT_FG)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+result.list[i].WEB_LECTURER_NM+'</td>';
					inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].END_SUBJECT_NM+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CAPACITY_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].REGIS_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].END_STATE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].REGIS_FEE)+'</td>';
					inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
					inner += '	<td>'+cutLectHour(result.list[i].LECT_HOUR)+'</td>';
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
				}
			}
			else
			{
				$("#list_target").html(inner);
			}
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
}
</script>

<div class="sub-tit">
	<h2>폐강리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	
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
		<div class="wid-35 mag-lr2">
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
		<div class="wid-15">
			<div class="table margin-auto">
				<div class="sear-tit sear-tit-70">접수상태</div>
				<div class="oddn-sel">
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
	<div class="top-row">
		<div class="wid-1">
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
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			
			<div class="table table02 table-auto float-right">
				<div>
					<p class="ip-ritit">선택한 강좌를</p>
				</div>
				<div>
					<select de-data="선택" id="end_act" name="end_act">
						<option value="N">폐강취소</option>
						<!--  <option value="N">SMS/TM리스트 이동</option>--> <!-- 폐강 리스트로 이전시 자동으로 TM리스트로 이동 -->
					</select>
					<a class="bor-btn btn03 btn-mar6" onclick="javascript:endAction();">반영</a>
				</div>
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
<div class="table-wr ip-list">
	
	<div class="table-list">
		<table>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_store')">지점 <img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>	
					<th onclick="reSortAjax('sort_end_subject_fg')">유형 <img src="/img/th_up.png" id="sort_end_subject_fg"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_end_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_end_subject_nm"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원 <img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_end_state')">상태 <img src="/img/th_up.png" id="sort_end_state"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>				
				</tr>
			</thead>
			<tbody id="list_target">
				<c:forEach var="i" items="${list}" varStatus="loop">
					<tr>
						<td class="td-chk">
							<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label>
						</td>
						<td>${i.STORE_NAME}</td>
						<td>${i.BIG_CATE}</td>
						<td>${i.SECT_NM}</td>	
						<td>${i.SUBJECT_FG}</td>
						<td>${i.SUBJECT_CD}</td>
						<td class="color-blue line-blue" onclick="location.href='/lecture/lect/closed?cn=${i.SUBJECT_CD}&store=${i.STORE }'" style="cursor:pointer;">${i.WEB_LECTURER_NM}</td>
						<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/closed?cn=${i.SUBJECT_CD}&store=${i.STORE }'" style="cursor:pointer;">${i.SUBJECT_NM}</td>
						<td>${i.CAPACITY_NO}</td>
						<td class="color-blue line-blue" onclick="location.href='/lecture/lect/closed?cn=${i.SUBJECT_CD}&store=${i.STORE }'" style="cursor:pointer;">${i.REGIS_NO}</td>
						<td>추후개발</td>
						<td><fmt:formatNumber value="${i.REGIS_FEE}" pattern="#,###"/></td>
						<td>${i.DAY_FLAG}</td>
						<td>${fn:substring(i.LECT_HOUR,0,2)}:${fn:substring(i.LECT_HOUR,2,4)}~${fn:substring(i.LECT_HOUR,4,6)}:${fn:substring(i.LECT_HOUR,6,8)}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>


<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>