<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
$(function(){

	$(".certi-table > table > tbody > tr").each(function(){
		var certi = $(this).find(".certi");
		var cpop = $(this).find(".certi-pop");
		var exit = $(this).find(".certi-pop .close");
		
		certi.click(function(){
			if(cpop.css("display") == "none"){
				cpop.css("display","block");
			}else{
				cpop.css("display","none");
			}
			
		})
		
	});
});
$(document).ready(function(){
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
});
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
// 	setCookie("page", page, 9999);
// 	setCookie("order_by", order_by, 9999);
// 	setCookie("sort_type", sort_type, 9999);
// 	setCookie("listSize", $("#listSize").val(), 9999);
// 	setCookie("search_name", $("#search_name").val(), 9999);
// 	setCookie("corp_fg", $("#corp_fg").val(), 9999);
// 	setCookie("store", $("#selBranch").val(), 9999);
// 	setCookie("selYear1", $("#selYear1").val(), 9999);
// 	setCookie("selYear2", $("#selYear2").val(), 9999);
// 	setCookie("selSeason1", $("#selSeason1").val(), 9999);
// 	setCookie("selSeason2", $("#selSeason2").val(), 9999);
	
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
			corp_fg : $('#corp_fg').val(),
			
			store : $("#selBranch").val(),
			selYear1 : $("#selYear1").val(),
			selYear2 : $("#selYear2").val(),
			selSeason1 : $("#selSeason1").val(),
			selSeason2 : $("#selSeason2").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			var result = JSON.parse(data);
			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+result.list[i].RNUM+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].WEB_TEXT)+'</td>';
					inner += '	<td class="td-b2">'+nullChk(result.list[i].CUS_NO)+'</td>';
					inner += '	<td class="td-b2">'+nullChk(result.list[i].PTL_ID)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td class="text-left">'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="lectSearch(\''+result.list[i].CUS_NO+'\')" style="cursor:pointer;">'+nullChk(result.list[i].CUS_PN)+'</td>';
					inner += '	<td class="bold">'+nullChk(result.list[i].AGE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].LECR_PHONE)+'</td>';
					if(result.list[i].FIX_PAY_YN == "Y")
					{
						inner += '	<td>정액 '+nullChk(result.list[i].FIX_AMT)+'</td>';
					}
					else
					{
						inner += '	<td>정률 '+nullChk(result.list[i].FIX_RATE)+'</td>';
					}
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="12"><div class="no-data">검색결과가 없습니다.</div></td>';
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
var lecturer_cd = "";
var lecturer_nm = "";
var cus_addr = "";
var cus_no = "";
function lectSearch(idx)
{
	$('#sear_layer').fadeIn(200);	
	thSize();
	$.ajax({
		type : "POST", 
		url : "./getLectListByLecr2",
		dataType : "text",
		async : false,
		data : 
		{
			cus_no : idx,
			store : $("#selBranch").val(),
			selYear1 : $("#selYear1").val(),
			selYear2 : $("#selYear2").val(),
			selSeason1 : $("#selSeason1").val(),
			selSeason2 : $("#selSeason2").val()
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
			$(".cap-numb2").html("결과 "+result.length+"개");
			if(result.length > 0)
			{
				lecturer_cd = result[0].LECTURER_CD;
				lecturer_nm = result[0].LECTURER_NM;
				cus_addr = result[0].CUS_ADDR;
				cus_no = result[0].CUS_NO;
				for(var i = 0; i < result.length; i++)
				{
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="val_'+result[i].SUBJECT_NM+'_'+i+'_'+result[i].START_YMD+'_'+result[i].END_YMD+'" name="chk_val"><label for="val_'+result[i].SUBJECT_NM+'_'+i+'_'+result[i].START_YMD+'_'+result[i].END_YMD+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+result[i].WEB_TEXT+'</td>';
					inner += '	<td>'+result[i].STORE_NM+'</td>';
					inner += '	<td>'+result[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+cutYoil(result[i].DAY_FLAG)+'('+cutLectHour(result[i].LECT_HOUR)+')</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="5"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target2").html(inner);
		}
	});	
}
function fncSubmit()
{
	var subject_list = "";
	var start_ymd = 0;
	var end_ymd = 0;
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
	    	subject_list += $(this).attr("id").split("_")[1]+"|";
	    	if(start_ymd == 0 || Number(start_ymd) > Number($(this).attr("id").split("_")[3]))
	    	{
	    		start_ymd = $(this).attr("id").split("_")[3];
	    	}
	    	if(end_ymd == 0 || Number(end_ymd) < Number($(this).attr("id").split("_")[4]))
	    	{
	    		end_ymd = $(this).attr("id").split("_")[4];
	    	}
    	}
	});
	if(subject_list == "")
	{
		alert("강좌를 선택해주세요.");
		return;
	}
	
	if($("#isJuminChk").is(":checked"))
	{
		$("#isJumin").val("Y");	
	}
	else
	{
		$("#isJumin").val("N");
	}
	
	$("#subject_list").val(subject_list);
	$("#lecturer_cd").val(lecturer_cd);
	$("#lecturer_nm").val(lecturer_nm);
	$("#cus_addr").val(cus_addr);
	$("#cus_no").val(cus_no);
	$("#start_ymd").val(start_ymd);
	$("#end_ymd").val(end_ymd);
	var tmp = $("#selBranch").val();
	$("#printStore").val(tmp);
	
	
	var gsWin = window.open("about:blank", "winName");
	var frm = document.getElementById("fncForm");
	frm.target = "winName";
	frm.submit();
	
// 	$("#fncForm").submit();
}
</script>
<div class="sub-tit">
	<h2>출강증명서 발급</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>

<div class="table-top table-top02">
	<div class="table sear-wr">
		<div class="wid-35">
			<div class="search-wr sear-36 sel100">
			    <input class="inp-100" type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="강사명 / 강좌명 / 연락처 / 멤버스번호가 검색됩니다.">
			    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
			</div>
		</div>
		<div class="wid-25">
			<div class="table margin-auto">
				<div class="sear-tit sear-tit_70">법인/개인</div>
				<div>
					<select id="corp_fg" name="corp_fg" de-data="전체">
						<option value="">전체</option>
						<option value="1">법인</option>
						<option value="2">개인</option>
					</select>
				</div>
			
			</div>
		</div>
		<div class="wid-5 certi-res">
			<div class="table table-auto margin-auto">
				<div>
					<select de-data="전체" id="selBranch" name="selBranch" onchange="getLastYearSeason()">
						<option value="">전체</option>
						<c:forEach var="i" items="${branchList}" varStatus="loop">
							<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
						</c:forEach>
					</select>
				</div>
				<div>
					<div class="table table-auto">
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
						</div>
						<div>
							<select de-data="전체" id="selSeason1" name="selSeason1">
								<option value="">전체</option>
								<option value="봄">봄</option>
								<option value="여름">여름</option>
								<option value="가을">가을</option>
								<option value="겨울">겨울</option>									
							</select>
						</div>
					</div>			
				</div>			
				<div class="dash"> ~ </div>
				<div>
					<div class="table table-auto">
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
						</div>
						<div>
							<select de-data="전체" id="selSeason2" name="selSeason2">
								<option value="">전체</option>
								<option value="봄">봄</option>
								<option value="여름">여름</option>
								<option value="가을">가을</option>
								<option value="겨울">겨울</option>									
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
		<div class="float-right">
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
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col width="60px">
				<col>
				<col width="400px">
				<col>
				<col width="60px">
				<col>
				<col width="120px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_bapelttb.store')">출강점<img src="/img/th_up.png" id="sort_bapelttb.store"></th>
					<th>연도/학기</th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th>유형</th>
					<th>대분류</th>
					<th>강좌명</th>
					<th onclick="reSortAjax('sort_bapelttb.web_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_bapelttb.web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_age')">연령<img src="/img/th_up.png" id="sort_age"></th>
					<th onclick="reSortAjax('sort_mmt_ex_no')" >연락처<img src="/img/th_up.png" id="sort_mmt_ex_no"></th>
					<th>강사료 지급 조건</th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list certi-table">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col width="60px">
				<col>
				<col width="400px">
				<col>
				<col width="60px">
				<col>
				<col width="120px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_bapelttb.store')">출강점<img src="/img/th_up.png" id="sort_bapelttb.store"></th>
					<th>연도/학기</th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th>유형</th>
					<th>대분류</th>
					<th>강좌명</th>
					<th onclick="reSortAjax('sort_bapelttb.web_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_bapelttb.web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_age')">연령<img src="/img/th_up.png" id="sort_age"></th>
					<th onclick="reSortAjax('sort_mmt_ex_no')" >연락처<img src="/img/th_up.png" id="sort_mmt_ex_no"></th>
					<th>강사료 지급 조건</th>
				</tr>
			</thead>
			<tbody id="list_target">
				<!-- 
				<tr>
					<td>13</td>
					<td>분당점</td>
					<td>19/봄</td>
					<td class="td-b2">123456789</td>
					<td class="td-b2">ak4p_003</td>
					<td class="td-b2">musign@musign.net</td>
					<td>정규</td>
					<td>성인</td>
					<td class="text-left">회화를 위한 기초 영문법</td>
					<td class="color-blue line-blue" onclick="lectSearch()" style="cursor:pointer;">김태연</td>
					<td class="bold">32</td>
					<td>16</td>	
					<td>010-2345-6985</td>	
					<td>정액 60,000</td>					
				</tr>
				 -->
			
			</tbody>
			
		</table>
	</div>
</div>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
<div id="sear_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg gift-edit edit-scroll">
        		<div class="close" onclick="javascript:$('#sear_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<div class="certi-wrap">
        				<h3 class="text-center">출강증명서 발급 강좌검색</h3>
        				
        				<div class="table-top bg01">
        					<div class="top-row">
        						
        						<div class="table">
       								<div class="sear-tit">주민번호숨김</div>
       								<div>
       									<input type="checkbox" id="isJuminChk" name="isJuminChk" value="Y">
										<label for="isJuminChk">Y</label>
       								</div>
       							</div>
        						
        					</div>
        					
        					
        				</div>
        				
						<div class="table-cap table">
							<div class="cap-l">
								<p class="cap-numb2"></p>
							</div>
						</div>
        				<div class="table-wr ip-list">
        					<div class="thead-box">
								<table>
									<colgroup>
										<col width="40px">
										<col>
										<col>
										<col width="450px">
										<col>
									</colgroup>
									<thead>
										<tr>
											<th class="td-chk">
												<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
											</th>
											<th>연도/학기</th>
											<th>출강점</th>
											<th>강좌명</th>
											<th>강의 시간</th>
										</tr>
									</thead>
								</table>
							</div>
							
							<div class="table-list certi-table">
								<table>
									<colgroup>
										<col width="40px">
										<col>
										<col>
										<col width="450px">
										<col>
									</colgroup>
									<thead>
										<tr>
											<th class="td-chk">
												<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
											</th>
											<th>연도/학기</th>
											<th>출강점</th>
											<th>강좌명</th>
											<th>강의 시간</th>
										</tr>
									</thead>
									<tbody id="list_target2">
									<!--  
										<tr>
											<td class="td-chk">		
												<input type="checkbox" id=" " name="chk_val1"><label for=" "></label>
											</td>
											<td>19/봄</td>
											<td>분당점</td>
											<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">회화를 위한 기초 영문법</td>
											<td>목(11:00-12:00)</td>					
										</tr>
										<tr>
											<td class="td-chk">		
												<input type="checkbox" id=" " name="chk_val1"><label for=" "></label>
											</td>
											<td>19/봄</td>
											<td>분당점</td>
											<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">회화를 위한 기초 영문법</td>
											<td>목(11:00-12:00)</td>					
										</tr>
										<tr>
											<td class="td-chk">		
												<input type="checkbox" id=" " name="chk_val1"><label for=" "></label>
											</td>
											<td>19/봄</td>
											<td>분당점</td>
											<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">회화를 위한 기초 영문법</td>
											<td>목(11:00-12:00)</td>					
										</tr>
									-->
									</tbody>
									
								</table>
							</div>
						</div>
        				
        				<div class="btn-wr text-center">
							<a class="btn btn02" onclick="javascript:fncSubmit();">발급하기</a>
						</div>
        				
        				
        			</div>
        		</div>
        	</div>
        </div>
    </div>	
</div>

<form id="fncForm" name="fncForm" method="POST" action="./attend">
	<input type="hidden" id="subject_list" name="subject_list">
	<input type="hidden" id="lecturer_cd" name="lecturer_cd">
	<input type="hidden" id="lecturer_nm" name="lecturer_nm">
	<input type="hidden" id="cus_addr" name="cus_addr">
	<input type="hidden" id="cus_no" name="cus_no">
	<input type="hidden" id="isJumin" name="isJumin">
	<input type="hidden" id="start_ymd" name="start_ymd">
	<input type="hidden" id="end_ymd" name="end_ymd">
	<input type="hidden" id="printStore" name="printStore">
</form>
<script>
$(document).ready(function(){
	
	getLastYearSeason();
// 	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
// 	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
// 	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
// 	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
// 	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
// 	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
// 	if(nullChk(getCookie("selYear1")) != "") { $("#selYear1").val(nullChk(getCookie("selYear1"))); $(".selYear1").html($("#selYear1 option:checked").text());}
// 	if(nullChk(getCookie("selYear2")) != "") { $("#selYear2").val(nullChk(getCookie("selYear2"))); $(".selYear2").html($("#selYear2 option:checked").text());}
// 	if(nullChk(getCookie("selSeason1")) != "") { $("#selSeason1").val(nullChk(getCookie("selSeason1"))); $(".selSeason1").html($("#selSeason1 option:checked").text());}
// 	if(nullChk(getCookie("selSeason2")) != "") { $("#selSeason2").val(nullChk(getCookie("selSeason2"))); $(".selSeason2").html($("#selSeason2 option:checked").text());}
// 	if(nullChk(getCookie("corp_fg")) != "") { $("#corp_fg").val(nullChk(getCookie("corp_fg"))); $(".corp_fg").html($("#corp_fg option:checked").text());}
	
	getList();
});
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>