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
	var filename = "주차관리";
	var table = "excelTable";
    exportExcel(filename, table);
}
function getList(paging_type)
{
	getListStart();
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	
	setCookie("date_start", $("#date_start").val(), 9999);
	setCookie("date_end", $("#date_end").val(), 9999);
	setCookie("car_num", $("#car_num").val(), 9999);
	setCookie("mgmt_num", $("#mgmt_num").val(), 9999);
	setCookie("park_info", $("#park_info").val(), 9999);
	setCookie("del_yn", $("#del_yn").val(), 9999);
	$.ajax({
		type : "POST", 
		url : "./getParkList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			date_start : $("#date_start").val(),
			date_end : $("#date_end").val(),
			car_num : $("#car_num").val(),
			mgmt_num : $("#mgmt_num").val(),
			park_info : $("#park_info").val(),
			del_yn : $("#del_yn").val()
			
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
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PERIOD)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].SALE_YMD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MGMT_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CAR_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PARK_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].DC_TIME)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POS_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].RECPT_NO)+'</td>';
					inner += '	<td>'+comma(nullChk(result.list[i].SALE_AMT))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].DELETE_YN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					
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
			getListEnd();
		}
	});	
}



</script>
<div class="sub-tit">
	<h2>주차 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>

<div class="table-top">
	<div class="top-row sear-wr">
		<div class="wid-5 ">
			<div class="table table02 table-input">
				<div class="sear-tit">지점</div>
				<div>
					<c:if test="${isBonbu eq 'T'}">
						<select de-data="전체" id="selBranch" name="selBranch">
							<option value="">전체</option>
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${isBonbu eq 'F'}">
						<select de-data="${login_rep_store_nm}" id="selBranch" name="selBranch">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</c:if>
				</div>
				
			</div>
		</div>
		
		<div class="wid-5 park-borno">
			<div class="table table-input">
				<div class="sear-tit sear-tit sear-tit_120 sear-tit_left">조회기간</div>
				<div>
					<div class="cal-row">
						<div class="cal-input cal-input02 cal-input_park">
							<input type="text" id="date_start" name="date_start" class="date-i ready-i" value="${date_start }"/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input cal-input02 cal-input_park">
							<input type="text" id="date_end" name="date_end" class="date-i ready-i" value="${date_end }"/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="top-row" style="margin-top:10px;">
		<div class="wid-5">
			<div class="table table-auto">
				<div class="wid-45">
					<div class="table">
						<div class="sear-tit">차량번호 입력</div>
						<div>
							<input type="text" id="car_num" name="car_num" value="${car_num}" onkeypress="javascript:pagingReset(); excuteEnter(getList);"/>
						</div>
					</div>
				</div>
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_120 sear-tit_left">멤버스 번호</div>
						<div>
							<input type="text" id="mgmt_num" name="mgmt_num" value="${mgmt_num }" onkeypress="javascript:pagingReset(); excuteEnter(getList);"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-5 ">
			<div class="table">
				<div class="wid-45">
					<div class="table">
						<div class="sear-tit sear-tit sear-tit_120 sear-tit_left wid-4">주차구분</div>
						<div>
							<select id="park_info" name="park_info" de-data="전체">
								<option value="">전체</option>
								<option value="01">매출</option>
								<option value="02">취소</option>
								<option value="03">수강</option>
								<option value="04">강사</option>
							</select>
						</div>
					</div>
				</div>
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_left">삭제구분</div>
						<div>
							<select id="del_yn" name="del_yn" de-data="전체">
								<option value="">전체</option>
								<option value="N">사용</option>
								<option value="Y">미사용</option>
							</select>
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
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col width="30%">
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_store')">지점<img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_period')">기수<img src="/img/th_up.png" id="sort_period"></th>
					<th onclick="reSortAjax('sort_sale_ymd')">영업일자<img src="/img/th_up.png" id="sort_sale_ymd"></th>
					<th onclick="reSortAjax('sort_mgmt_no')">멤버스번호<img src="/img/th_up.png" id="sort_mgmt_no"></th>
					<th onclick="reSortAjax('sort_car_no')">차량번호<img src="/img/th_up.png" id="sort_car_no"></th>
					<th onclick="reSortAjax('sort_park_fg')">주차구분<img src="/img/th_up.png" id="sort_park_fg"></th>
					<th onclick="reSortAjax('sort_TO_NUMBER(dc_time)')">할인시간(분)<img src="/img/th_up.png" id="sort_TO_NUMBER(dc_time)"></th>
					<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
					<th onclick="reSortAjax('sort_recpt_no')">영수증번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
					<th onclick="reSortAjax('sort_TO_NUMBER(sale_amt)')">매출금액<img src="/img/th_up.png" id="sort_TO_NUMBER(sale_amt)"></th>
					<th onclick="reSortAjax('sort_delete_yn')">삭제<img src="/img/th_up.png" id="sort_delete_yn"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
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
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col width="30%">
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_store')">지점<img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_period')">기수<img src="/img/th_up.png" id="sort_period"></th>
					<th onclick="reSortAjax('sort_sale_ymd')">영업일자<img src="/img/th_up.png" id="sort_sale_ymd"></th>
					<th onclick="reSortAjax('sort_mgmt_no')">멤버스번호<img src="/img/th_up.png" id="sort_mgmt_no"></th>
					<th onclick="reSortAjax('sort_car_no')">차량번호<img src="/img/th_up.png" id="sort_car_no"></th>
					<th onclick="reSortAjax('sort_park_fg')">주차구분<img src="/img/th_up.png" id="sort_park_fg"></th>
					<th onclick="reSortAjax('sort_dc_time')">할인시간(분)<img src="/img/th_up.png" id="sort_dc_time"></th>
					<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
					<th onclick="reSortAjax('sort_recpt_no')">영수증번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
					<th onclick="reSortAjax('sort_sale_amt')">매출금액<img src="/img/th_up.png" id="sort_sale_amt"></th>
					<th onclick="reSortAjax('sort_delete_yn')">삭제<img src="/img/th_up.png" id="sort_delete_yn"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
				</tr>
			</thead>
			<tbody id="list_target">
				
			</tbody>
		</table>
	</div>
	
</div>

<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

<script>

$(document).ready(function(){
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	if(nullChk(getCookie("date_start")) != "") { $("#date_start").val(nullChk(getCookie("date_start")));}
	if(nullChk(getCookie("date_start")) != "") { $("#date_start").val(nullChk(getCookie("date_start")));}
	if(nullChk(getCookie("date_end")) != "") { $("#date_end").val(nullChk(getCookie("date_end")));}
	if(nullChk(getCookie("car_num")) != "") { $("#car_num").val(nullChk(getCookie("car_num")));}
	if(nullChk(getCookie("mgmt_num")) != "") { $("#mgmt_num").val(nullChk(getCookie("mgmt_num")));}
	if(nullChk(getCookie("park_info")) != "") { $("#park_info").val(nullChk(getCookie("park_info"))); $(".park_info").html($("#park_info option:checked").text());} 
	if(nullChk(getCookie("del_yn")) != "") { $("#del_yn").val(nullChk(getCookie("del_yn"))); $(".del_yn").html($("#del_yn option:checked").text());}
	
	getList();
})

</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>