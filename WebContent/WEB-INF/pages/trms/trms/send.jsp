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
	var filename = "매출분개전송";
	var table = "excelTable";
    exportExcel(filename, table);
}
$(document).ready(function(){
	setBundang();
});
function getList()
{
	$.ajax({
		type : "POST", 
		url : "./getCheckList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			corp_fg : $("#corp_fg").val(),
			store : $("#selBranch").val(),
			pos : $("#selPos").val(),
			sale_ymd : $("#sale_ymd").val(),
			pmg : 'bab0050b'
			
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
					inner += '	<td>'+result.list[i].RNUM+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PGM_NM)+'</td>';
					inner += '	<td>'+nullChk(cutDate(result.list[i].REQ_START_TM))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STATUS)+'</td>';
					inner += '	<td>'+nullChk(cutDate(result.list[i].JOB_START_TM))+'</td>';
					inner += '	<td>'+nullChk(cutDate(result.list[i].JOB_END_TM))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ERROR_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ERROR_MSG)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].USER_NM)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="9"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			$("#list_target").html(inner);
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
}
function fncSubmit(act)
{
	$("#act").val(act);
	$("#fncForm").ajaxSubmit({
		success: function(data)
		{
			console.log(data);
			var result = JSON.parse(data);
    		if(result.isSuc == "success")
    		{
    			alert(result.msg);
    			location.reload();
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});
}
</script>

<div class="sub-tit">
	<h2>매출분개 전송</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
<!-- 	<div class="btn-right"> -->
<!-- 		<a class="btn btn01 btn01_1">작업 현황 </a> -->
<!-- 	</div> -->
</div>

<form id="fncForm" name="fncForm" method="POST" action="./send_proc">
	<div class="table-top first">
		<div class="top-row">
			<div class="">
				<div class="table table-auto">
					<div>
						<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<div class="wid-35 mag-l2">
				<div class="table ">
					<div class="sear-tit sear-tit-70">매출일자</div>
					<div>
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" class="date-i ready-i" id="sale_ymd" name="sale_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
	<!-- 						<div class="cal-dash">-</div> -->
	<!-- 						<div class="cal-input wid-4"> -->
	<!-- 							<input type="text" class="date-i" id="end_ymd" name="end_ymd"/> -->
	<!-- 							<i class="material-icons">event_available</i> -->
	<!-- 						</div> -->
						</div>
					</div>
				</div>			
			</div>
			
			
			<div class="">
				<div class="table margin-auto">
					<div>
						<a class="btn btn02 mrg-l6" onclick="javascript:getList();">선택완료</a>
					</div>
				</div>
			</div>
		</div>
	<input type="hidden" id="act" name="act">
	</div>
</form>
<div class="table-cap table">
	<div class="cap-r text-right">
		<div class="table float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
			</div>
		</div>
	</div>
</div>
<div class="table-wr ip-list">	
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="80px">
				<col>
				<col>
				<col width="80px">
				<col>
				<col>
				<col>
				<col width="150px">
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_store_nm')">점<img src="/img/th_up.png" id="sort_store_nm"></th>
					<th onclick="reSortAjax('sort_pgm_nm')">프로그램명<img src="/img/th_up.png" id="sort_pgm_nm"></th>
					<th onclick="reSortAjax('sort_req_start_tm')">작업의뢰시간<img src="/img/th_up.png" id="sort_req_start_tm"></th>
					<th onclick="reSortAjax('sort_status')">상태<img src="/img/th_up.png" id="sort_status"></th>
					<th onclick="reSortAjax('sort_job_start_tm')">작업시작시간<img src="/img/th_up.png" id="sort_job_start_tm"></th>
					<th onclick="reSortAjax('sort_job_end_tm')">작업종료시간<img src="/img/th_up.png" id="sort_job_end_tm"></th>
					<th onclick="reSortAjax('sort_error_cd')">오류코드<img src="/img/th_up.png" id="sort_error_cd"></th>
					<th onclick="reSortAjax('sort_error_msg')">메세지<img src="/img/th_up.png" id="sort_error_msg"></th>
					<th onclick="reSortAjax('sort_user_nm')">작업자<img src="/img/th_up.png" id="sort_user_nm"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="60px">
				<col width="80px">
				<col>
				<col>
				<col width="80px">
				<col>
				<col>
				<col>
				<col width="150px">
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_store_nm')">점<img src="/img/th_up.png" id="sort_store_nm"></th>
					<th onclick="reSortAjax('sort_pgm_nm')">프로그램명<img src="/img/th_up.png" id="sort_pgm_nm"></th>
					<th onclick="reSortAjax('sort_req_start_tm')">작업의뢰시간<img src="/img/th_up.png" id="sort_req_start_tm"></th>
					<th onclick="reSortAjax('sort_status')">상태<img src="/img/th_up.png" id="sort_status"></th>
					<th onclick="reSortAjax('sort_job_start_tm')">작업시작시간<img src="/img/th_up.png" id="sort_job_start_tm"></th>
					<th onclick="reSortAjax('sort_job_end_tm')">작업종료시간<img src="/img/th_up.png" id="sort_job_end_tm"></th>
					<th onclick="reSortAjax('sort_error_cd')">오류코드<img src="/img/th_up.png" id="sort_error_cd"></th>
					<th onclick="reSortAjax('sort_error_msg')">메세지<img src="/img/th_up.png" id="sort_error_msg"></th>
					<th onclick="reSortAjax('sort_user_nm')">작업자<img src="/img/th_up.png" id="sort_user_nm"></th>
				</tr>
			</thead>
			<tbody id="list_target">
<%-- 				<c:forEach var="i" items="${pmgList}" varStatus="loop"> --%>
<!-- 					<tr>					 -->
<%-- 						<td>${loop.index+1}</td> --%>
<%-- 						<td>${i.STORE_NM}</td> --%>
<%-- 						<td>${i.PGM_NM}</td> --%>
<!-- 						<td> -->
<%-- 							<fmt:parseDate value="${i.REQ_START_TM}" var="REQ_START_TM" pattern="yyyyMMddHHmmss"/> --%>
<%-- 							<fmt:formatDate value="${REQ_START_TM}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
<!-- 						</td> -->
<%-- 						<td>${i.STATUS }</td> --%>
<!-- 						<td> -->
<%-- 							<fmt:parseDate value="${i.JOB_START_TM}" var="JOB_START_TM" pattern="yyyyMMddHHmmss"/> --%>
<%-- 							<fmt:formatDate value="${JOB_START_TM}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
<!-- 						</td> -->
<!-- 						<td> -->
<%-- 							<fmt:parseDate value="${i.JOB_END_TM}" var="JOB_END_TM" pattern="yyyyMMddHHmmss"/> --%>
<%-- 							<fmt:formatDate value="${JOB_END_TM}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
<!-- 						</td> -->
<%-- 						<td>${i.ERROR_CD }</td> --%>
<%-- 						<td>${i.ERROR_MSG }</td> --%>
<%-- 						<td>${i.NAME }</td> --%>
<!-- 					</tr> -->
<%-- 				</c:forEach> --%>
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
	<div class="btn-wr text-center">
		<a class="btn btn01 ok-btn" onclick="javascript:fncSubmit('cancle');">분개 취소</a>
		<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit('send');">분개 작업</a>
		<a class="btn btn01 ok-btn" onclick="javascript:fncSubmit('send_cancle');">전송 취소</a>
		<a class="btn btn03 ok-btn" onclick="javascript:fncSubmit('submit');">분개 전송하기</a>
	</div>
	
</div>







<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>