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
	var filename = "운영자 로그관리";
	var table = "excelTable";
    exportExcel(filename, table);
}
function getList(paging_type)
{
	getListStart();
	if(sort_type == "" && order_by == "")
	{
		sort_type = "create_date";
		order_by = "desc";
	}
	$.ajax({
		type : "POST", 
		url : "./getManagerLogList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			search_name : $("#search_name").val(),
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
					inner += '<tr>';
					inner += '	<td>'+nullChk(result.list[i].CREATE_RESI_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CREATE_RESI_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].DETAIL)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].TARGET)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].CREATE_DATE)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="5"><div class="no-data">검색결과가 없습니다.</div></td>';
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
			getListEnd();
		}
	});	
}



</script>
<div class="sub-tit">
	<h2>운영자 로그 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>

<div class="table-top">
	<div class="top-row sear-wr">
		<div class="">
			<div class="table table-90">
				<div class="search-wr sel100">
				    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="작업내용 / 작업대상이 검색됩니다.">
				    <input class="search-btn" style="right:160px !important" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
				</div>
			</div>
		</div>
		
		<div class="wid-5 park-borno">
			<div class="table table-input">
				<div class="sear-tit sear-tit sear-tit_120 sear-tit_left">조회기간</div>
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
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
</div>


<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="table float-right">
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
				</select>
			</div>
		</div>
		
		
	</div>
</div>
<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_create_resi_no')">사번<img src="/img/th_up.png" id="sort_create_resi_no"></th>
					<th onclick="reSortAjax('sort_create_resi_nm')">작업자<img src="/img/th_up.png" id="sort_create_resi_nm"></th>
					<th onclick="reSortAjax('sort_detail')">작업내용<img src="/img/th_up.png" id="sort_detail"></th>
					<th onclick="reSortAjax('sort_target')">작업대상<img src="/img/th_up.png" id="sort_target"></th>
					<th onclick="reSortAjax('sort_create_date')">작업일시<img src="/img/th_up.png" id="sort_create_date"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_create_resi_no')">사번<img src="/img/th_up.png" id="sort_create_resi_no"></th>
					<th onclick="reSortAjax('sort_create_resi_nm')">작업자<img src="/img/th_up.png" id="sort_create_resi_nm"></th>
					<th onclick="reSortAjax('sort_detail')">작업내용<img src="/img/th_up.png" id="sort_detail"></th>
					<th onclick="reSortAjax('sort_target')">작업대상<img src="/img/th_up.png" id="sort_target"></th>
					<th onclick="reSortAjax('sort_create_date')">작업일시<img src="/img/th_up.png" id="sort_create_date"></th>
				</tr>
			</thead>
			<tbody id="list_target">
				
			</tbody>
		</table>
	</div>
	
</div>
<script>
$(document).ready(function() {
	getList();
});

</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>