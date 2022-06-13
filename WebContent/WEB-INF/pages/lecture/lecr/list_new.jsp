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
	var filename = "신규강사";
	var table = "excelTable";
    exportExcel(filename, table);
}

function init()
{
	$(".std-popbtn").each(function(){
		var close = $(this).find(".fa-window-close");
		var pop = $(this).find(".std-newpop");
		$(this).find("span").click(function(){
			pop.show();
		})
		close.click(function(){
			pop.hide();
		})
	})
}
function getList(paging_type)
{
	getListStart();
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("grade", $("#grade").val(), 9999);
	setCookie("subject_fg", $("#subject_fg").val(), 9999);
	setCookie("start_ymd", $("#start_ymd").val(), 9999);
	setCookie("end_ymd", $("#end_ymd").val(), 9999);
	$.ajax({
		type : "POST", 
		url : "./getNewLecrDetail",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			search_name : $("#search_name").val(),
			store : $("#selBranch").val(),
			grade : $("#grade").val(),
			subject_fg : $("#subject_fg").val(),
			
			start_ymd : $("#start_ymd").val(),
			end_ymd : $("#end_ymd").val()
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
					var tmp = String(nullChk(result.list[i].HISTORY));
					inner += '<tr>';
					inner += '	<td>'+result.list[i].RNUM+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+nullChk(result.list[i].CUS_NO)+'\'" style="cursor:pointer;">'+result.list[i].CUS_PN+'</td>';
					inner += '	<td>'+nullChk(result.list[i].NTR_DC)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].AGE)+'</td>';
					inner += '	<td class="std-popbtn">';
					inner += '		<span>'+tmp.replace(/\|/gi, "<br>")+'</span>';
					inner += '		<div class="std-newpop">'+tmp.replace(/\|/gi, "<br>");
					inner += '			<a class="color-111 line-111">총 '+(tmp.split("|").length-1)+'건</a><i class="far fa-window-close"></i>';
					inner += '		</div>';
					inner += '	</td>';
					if(result.list[i].FIX_PAY_YN == "Y")
					{
						inner += '	<td>정액 '+result.list[i].FIX_AMT+'</td>';
					}
					else if(result.list[i].FIX_PAY_YN == "N")
					{
						inner += '	<td>정률 '+result.list[i].FIX_RATE+'</td>';
					}
					else
					{
						inner += '	<td></td>';
					}
					inner += '	<td class="text-left">'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POINT_1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SCHOOL)+'/'+nullChk(result.list[i].SCHOOL_CATE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POINT_3)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POINT_5)+'</td>';
					inner += '	<td class="color-red">'+result.list[i].LECR_POINT+'/'+result.list[i].GRADE+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CREATE_RESI_NM)+'</td>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="14"><div class="no-data">검색결과가 없습니다.</div></td>';
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
			init(); //클릭시 팝업뜨는거
			getListEnd();
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>신규강사 평가리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
<div class="table-top table-top02">
	<div class="top-row sear-wr">
		
	</div>
	<div class="ak_lecrwrap">
		<div class="top-row">
			<div class="wid-10">
				<table>
					<tr>
						<th class="th01">검색</th>
						<td>	
							<div class="table">
								<div>
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
									<div class="wid-6 search-wr sel100">
									    <input type="text" id="search_name" class="inp-100" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="강사명 / 강좌명 / 연락처 / 멤버스번호가 검색됩니다.">
									    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
									</div>
								</div>
								
							</div>
						
						</td>
					</tr>
					<tr>
						<th class="th02">세부검색</th>
						<td>	
							<div class="table table-auto">
								<div>
									<div class="table table-auto">
										<div class="cal-input cal-input180">
											<input type="text" class="date-i start-i" id="start_ymd" name="start_ymd"/>
											<i class="material-icons">event_available</i>
										</div>
										<div class="dash"> ~ </div> 
										<div class="cal-input cal-input180">
											<input type="text" class="date-i ready-i" id="end_ymd" name="end_ymd"/>
											<i class="material-icons">event_available</i>
										</div>
									</div>
								</div>
								<div>
									<div class="table">
										<div class="sear-tit sear-tit_left">유형</div>
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
								
								<div>
									<select id="grade" onchange="getList();" de-data="평가결과" >
										<option value="">전체</option>
										<option value="A">A</option>
										<option value="B">B</option>
										<option value="C">C</option>
										<option value="D">D</option>
										<option value="E">E</option>											
									</select>
								</div>
							</div>
						
						</td>
					</tr>
				</table>
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
<div class="table-wr ip-list">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="80px">
				<col width="80px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_store_nm')">지점<img src="/img/th_up.png" id="sort_store_nm"></th>
					<th onclick="reSortAjax('sort_cus_pn')">강사명<img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_ntr_dc')">성별<img src="/img/th_up.png" id="sort_ntr_dc"></th>
					<th onclick="reSortAjax('sort_age')">연령<img src="/img/th_up.png" id="sort_age"></th>
					<th onclick="reSortAjax('sort_history')">주요약력<img src="/img/th_up.png" id="sort_history"></th>
					<th>강사료 지급 기준 </th>	
					<th>유형 </th>		
					<th>대분류 </th>	
					<th onclick="reSortAjax('sort_point_1')">최종학력<img src="/img/th_up.png" id="sort_point_1"></th>
					<th onclick="reSortAjax('sort_school')">학력상세<img src="/img/th_up.png" id="sort_school"></th>
					<th onclick="reSortAjax('sort_point_3')">분야 경력<img src="/img/th_up.png" id="sort_point_3"></th>					
					<th onclick="reSortAjax('sort_point_5')">기타경력<img src="/img/th_up.png" id="sort_point_5"></th>
					<th onclick="reSortAjax('sort_point')">평가 결과<img src="/img/th_up.png" id="sort_point"></th>
					<th>평가자</th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="60px">
				<col width="80px">
				<col width="80px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_store_nm')">지점<img src="/img/th_up.png" id="sort_store_nm"></th>
					<th onclick="reSortAjax('sort_cus_pn')">강사명<img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_ntr_dc')">성별<img src="/img/th_up.png" id="sort_ntr_dc"></th>
					<th onclick="reSortAjax('sort_age')">연령<img src="/img/th_up.png" id="sort_age"></th>
					<th onclick="reSortAjax('sort_history')">주요약력<img src="/img/th_up.png" id="sort_history"></th>
					<th>강사료 지급 기준 </th>	
					<th>유형 </th>		
					<th>대분류 </th>	
					<th onclick="reSortAjax('sort_point_1')">최종학력<img src="/img/th_up.png" id="sort_point_1"></th>
					<th onclick="reSortAjax('sort_school')">학력상세<img src="/img/th_up.png" id="sort_school"></th>
					<th onclick="reSortAjax('sort_point_3')">분야 경력<img src="/img/th_up.png" id="sort_point_3"></th>					
					<th onclick="reSortAjax('sort_point_5')">기타경력<img src="/img/th_up.png" id="sort_point_5"></th>
					<th onclick="reSortAjax('sort_point')">평가 결과<img src="/img/th_up.png" id="sort_point"></th>
					<th>평가자</th>
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
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	if(nullChk(getCookie("grade")) != "") { $("#grade").val(nullChk(getCookie("grade"))); $(".grade").html($("#grade option:checked").text());}
	if(nullChk(getCookie("subject_fg")) != "") { $("#subject_fg").val(nullChk(getCookie("subject_fg"))); $(".subject_fg").html($("#subject_fg option:checked").text());}
	if(nullChk(getCookie("start_ymd")) != "") { $("#start_ymd").val(nullChk(getCookie("start_ymd")));}
	if(nullChk(getCookie("end_ymd")) != "") { $("#end_ymd").val(nullChk(getCookie("end_ymd")));}
	
	
	getList();
	init();
});
</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>