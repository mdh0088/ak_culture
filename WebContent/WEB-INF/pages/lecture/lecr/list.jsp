<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>
function excelDown()
{
	var filename = "강사관리";
	var table = "excelTable";
    exportExcel(filename, table);
}
$(document).ready(function(){
	
$(".tab-phbtn").click(function(){
		
		if($(".tab-ph").css("display")=="none"){
			$(".tab-ph").css("display","table-cell");
			$(".tab-ph").css("width","100px");
		}else if($(".tab-ph").css("display")=="table-cell"){
			$(".tab-ph").css("display","none");
			$(".tab-ph").css("width","");
		}
		thSize();
		
	})
})

function tabBtn()
{
		if($(".tab-ph").css("display")=="none"){
			$(".tab-ph").css("display","none");
			$(".tab-ph").css("width","");
		}else if($(".tab-ph").css("display")=="table-cell"){
			$(".tab-ph").css("display","table-cell");
			$(".tab-ph").css("width","100px");
		}
}



function getLastYearSeason()
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var season = result[0].WEB_TEXT.substring(7,result[0].WEB_TEXT.length);
			season = season.replace("학기", ""); //계절만추출
			$("#selYear1").val(result[0].WEB_TEXT.substring(0,4));
			$(".selYear1").html(result[0].WEB_TEXT.substring(0,4));
			$("#selYear2").val(result[0].WEB_TEXT.substring(0,4));
			$(".selYear2").html(result[0].WEB_TEXT.substring(0,4));
			
			$("#selSeason1").val(season);
			$(".selSeason1").html(season);
			$("#selSeason2").val(season);
			$(".selSeason2").html(season);
			
			
		}
	});	
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
	setCookie("selYear1", $("#selYear1").val(), 9999);
	setCookie("selYear2", $("#selYear2").val(), 9999);
	setCookie("selSeason1", $("#selSeason1").val(), 9999);
	setCookie("selSeason2", $("#selSeason2").val(), 9999);
	setCookie("subject_fg", $("#subject_fg").val(), 9999);
	setCookie("status_fg", $("#status_fg").val(), 9999);
	
	$.ajax({
		type : "POST", 
		url : "./getLecrDetail",
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
			selYear1 : $("#selYear1").val(),
			selYear2 : $("#selYear2").val(),
			selSeason1 : $("#selSeason1").val(),
			selSeason2 : $("#selSeason2").val(),
			subject_fg : $("#subject_fg").val(),
			status_fg : $("#status_fg").val()
			
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
					inner += '	<td>'+result.list[i].RNUM+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+nullChk(result.list[i].CUS_NO)+'\'" style="cursor:pointer;">'+result.list[i].CUS_PN+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].WEB_TEXT)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUS_NO)+'</td>';
// 					inner += '	<td>'+nullChk(result.list[i].PTL_ID)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td class="text-left">'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					
					inner += '	<td class="bold">'+nullChk(result.list[i].AGE)+'</td>';
					inner += '	<td class="bold">'+nullChk(result.list[i].NTR_DC)+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
					inner += '	<td class="tab-ph">'+nullChk(result.list[i].LECR_PHONE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CAR_NO)+'</td>';
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
					//inner += '	<td>'+nullChk(result.list[i].POINT)+'</td>';
					inner += '	<td class="color-red">'+result.list[i].LECR_POINT+'/'+result.list[i].GRADE+'</td>';
					var status_fg = result.list[i].STATUS_FG == "Y" ? "O" : "X";
					inner += '	<td>'+status_fg+'</td>';
					inner += '</tr>';
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
					tabBtn();
				}
			}
			else
			{
				$("#list_target").html(inner);
				tabBtn();
			}
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>강사조회</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
<div class="table-top table-top02">
	<div class="top-row sear-wr">
<!-- 		<div class="wid-10"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="wid-45"> -->
<!-- 					<div class="table table02 table-input wid-contop"> -->
<%-- 						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/> --%>
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 				<div class="wid-15"> -->
<!-- 					<div class="table"> -->
<!-- 						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div> -->
<!-- 						<div class="oddn-sel02"> -->
<%-- 							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/> --%>
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
		
	</div>
	<div class="ak_lecrwrap">
		<div class="top-row">
			<div class="wid-10">
				<table id="">
					<tr>
						<th class="th01">검색</th>
						<td>	
							<div class="table table-auto">
								<div>
									<select de-data="전체" id="selBranch" name="selBranch" onchange="getLastYearSeason()">
										<option value="">전체</option>
										<c:forEach var="i" items="${branchList}" varStatus="loop">
											<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
										</c:forEach>
									</select>
								</div>
								<div class="search-wr search-wr02 sel100">
								    <input type="text" id="search_name" class="inp-100" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="강사명 / 강좌명 / 연락처 / 멤버스번호가 검색됩니다.">
								    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
								</div>								
							</div>
						
						</td>
					</tr>
					<tr>
						<th class="th02">세부검색</th>
						<td>	
							<div class="table table-auto">
								<div class="wid-6">
									<div>
										<select de-data="${year}" id="selYear1" name="selYear1" onchange="">
											<option value="">전체</option>
											<%
											int year = Utils.checkNullInt(request.getAttribute("year"));
											for(int i = year+1; i > 1980; i--)
											{
												if(i == year)
												{
													%>
													<option value="<%=i%>" selected><%=i%></option>
													<%
												}
												else
												{
													%>
													<option value="<%=i%>"><%=i%></option>
													<%
												}
											}
											%>
										</select>
										<select de-data="전체" id="selSeason1" name="selSeason1">
											<option value="">전체</option>
											<option value="봄">봄</option>
											<option value="여름">여름</option>
											<option value="가을">가을</option>
											<option value="겨울">겨울</option>									
										</select>
									</div>
									<div class="dash"> ~ </div>
									<div>
										<select de-data="${year}" id="selYear2" name="selYear2" onchange="">
											<option value="">전체</option>
											<%
											for(int i = year+1; i > 1980; i--)
											{
												if(i == year)
												{
													%>
													<option value="<%=i%>" selected><%=i%></option>
													<%
												}
												else
												{
													%>
													<option value="<%=i%>"><%=i%></option>
													<%
												}
											}
											%>
										</select>
										<select de-data="전체" id="selSeason2" name="selSeason2">
											<option value="">전체</option>
											<option value="봄">봄</option>
											<option value="여름">여름</option>
											<option value="가을">가을</option>
											<option value="겨울">겨울</option>									
										</select>
									</div>
								</div>
								<div class="wid-3">
									<div class="table">
										<div class="sear-tit sear-tit-70">거래선</div>
										<div class="oddn-sel">
											<select id="status_fg" name="status_fg" de-data="전체">
												<option value="">전체</option>
												<option value="Y">상신</option>
												<option value="N">미상신</option>
											</select>
										</div>
									</div>
								</div>
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
								
								<div class="wid-25">
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
	<div class="cap-l cap-bwr">
		<p class="cap-numb"></p>
		<div class="tab-phbtn btn03">연락처보기</div>
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
				<col width="120px">
				<col>
				<col width="120px">
				<col>
				<col>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col width="100px">
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_bapelttb.store')" >출강점<img src="/img/th_up.png" id="sort_bapelttb.store"></th>
					<th>연도/학기 </th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"> </th>
<!-- 					<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th> -->
					<th>유형 </th>
					<th>대분류 </th>
					<th>강좌명 </th>					
					<th onclick="reSortAjax('sort_age')">연령<img src="/img/th_up.png" id="sort_age"></th>
					<th onclick="reSortAjax('sort_ntr_dc')">성별<img src="/img/th_up.png" id="sort_ntr_dc"></th>
					<th>현원</th>
					<!-- <th onclick="reSortAjax('sort_mmt_ex_no')" class="td-90 tab-ph">연락처<img src="/img/th_up.png" id="sort_mmt_ex_no"></th>	 -->
					<th class="tab-ph">연락처</th>					
					<th>차량번호 </th>					
					<th>강사료 지급 기준 </th>	
					<th>평가 결과</th>
					<th>거래선</th>		
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="60px">
				<col width="120px">
				<col>
				<col width="120px">
				<col>
				<col>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col width="100px">
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_bapelttb.store')" >출강점<img src="/img/th_up.png" id="sort_bapelttb.store"></th>
					<th>연도/학기 </th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"> </th>
<!-- 					<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th> -->
					<th>유형 </th>
					<th>대분류 </th>
					<th>강좌명 </th>					
					<th onclick="reSortAjax('sort_age')">연령<img src="/img/th_up.png" id="sort_age"></th>
					<th onclick="reSortAjax('sort_ntr_dc')">성별<img src="/img/th_up.png" id="sort_ntr_dc"></th>
					<th>현원</th>
					<!-- <th onclick="reSortAjax('sort_mmt_ex_no')" class="td-90 tab-ph">연락처<img src="/img/th_up.png" id="sort_mmt_ex_no"></th>	 -->
					<th class="tab-ph">연락처</th>					
					<th>차량번호 </th>					
					<th>강사료 지급 기준 </th>	
					<th>평가 결과</th>
					<th>거래선</th>		
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
	
	getLastYearSeason();
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	
	if(nullChk(getCookie("grade")) != "") { $("#grade").val(nullChk(getCookie("grade"))); $(".grade").html($("#grade option:checked").text());}
	if(nullChk(getCookie("selYear1")) != "") { $("#selYear1").val(nullChk(getCookie("selYear1"))); $(".selYear1").html($("#selYear1 option:checked").text());}
	if(nullChk(getCookie("selYear2")) != "") { $("#selYear2").val(nullChk(getCookie("selYear2"))); $(".selYear2").html($("#selYear2 option:checked").text());}
	if(nullChk(getCookie("selSeason1")) != "") { $("#selSeason1").val(nullChk(getCookie("selSeason1"))); $(".selSeason1").html($("#selSeason1 option:checked").text());}
	if(nullChk(getCookie("selSeason2")) != "") { $("#selSeason2").val(nullChk(getCookie("selSeason2"))); $(".selSeason2").html($("#selSeason2 option:checked").text());}
	if(nullChk(getCookie("subject_fg")) != "") { $("#subject_fg").val(nullChk(getCookie("subject_fg"))); $(".subject_fg").html($("#subject_fg option:checked").text());}
	if(nullChk(getCookie("status_fg")) != "") { $("#status_fg").val(nullChk(getCookie("status_fg"))); $(".status_fg").html($("#status_fg option:checked").text());}
	
	getList();
});
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>