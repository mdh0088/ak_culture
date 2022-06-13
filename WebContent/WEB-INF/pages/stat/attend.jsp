<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
$(document).ready(function(){
	getLastYearSeason();
});
function getLastYearSeason()
{
	$("#selYear").val('${year}');
}
var tot_store = 0;
var tot_s_store = 0;
var tot_b_store = 0;
var tot_p_store = 0;
var tot_w_store = 0;
function getList(paging_type)
{
	getListStart();
	$.ajax({
		type : "POST", 
		url : "./getAttend",
		dataType : "text",
		async : false,
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			selYear : $("#selYear").val(),
			selSeason : $("#selSeason").val(),
			subject_fg : $("#subject_fg").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val(),
			search_name : $("#search_name").val()
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
					var tmp = Number(nullChkZero(result.list[i].S_STORE)) + Number(nullChkZero(result.list[i].B_STORE)) + Number(nullChkZero(result.list[i].P_STORE)) + Number(nullChkZero(result.list[i].W_STORE));
					inner += '<tr>';
					inner += '	<td>'+nullChk(result.list[i].RNUM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUS_PN)+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].BMD))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].LECR_POINT)+'/'+nullChk(result.list[i].GRADE)+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].LECT_CNT))+'</td>';
					inner += '	<td>'+comma(tmp)+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].S_STORE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].B_STORE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].P_STORE))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result.list[i].W_STORE))+'</td>';
					inner += '</tr>';
					
					tot_store += Number(tmp);
					tot_s_store += Number(nullChkZero(result.list[i].S_STORE));
					tot_b_store += Number(nullChkZero(result.list[i].B_STORE));
					tot_p_store += Number(nullChkZero(result.list[i].P_STORE));
					tot_w_store += Number(nullChkZero(result.list[i].W_STORE));
				}
				$("#tot_store").html(comma(nullChkZero(tot_store)));
				$("#tot_s_store").html(comma(nullChkZero(tot_s_store)));
				$("#tot_b_store").html(comma(nullChkZero(tot_b_store)));
				$("#tot_p_store").html(comma(nullChkZero(tot_p_store)));
				$("#tot_w_store").html(comma(nullChkZero(tot_w_store)));
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
function selMaincd(idx){	
// 	var x = document.getElementById("selPeri").selectedIndex;
// 	var y = document.getElementById("selPeri").options;
// 	var z = document.getElementById("selPeri").options[y[x].index];

	main_cd = $(idx).val();
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
	}else{
		$('.withBaby').hide();
	}
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		data : 
		{
			maincd : main_cd,
// 			selBranch : z.getAttribute("store")
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
			var inner ="";
			$("#sect_cd").empty();
			$(".sect_cd_ul").html("");
			
			$(".sect_cd_ul").append('<li>전체</li>');
			$("#sect_cd").append('<option value="">전체</option>');
			if(result.length > 0)
			{
				
				inner="";
				for (var i = 0; i < result.length; i++) 
				{
					$(".sect_cd_ul").append('<li>'+result[i].SECT_NM+'</li>');
					$("#sect_cd").append('<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>');
				}
			}
			else
			{
				
			}
			$("#sect_cd").val("");
			$(".sect_cd").html("전체");
		}
	});	
}
</script>	
<div class="sub-tit">
	<h2>강사별 출강점 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row">	
		<div class="">
			<div class="table table-auto">
				<div>
					<select de-data="${year}" id="selYear" name="selYear" onchange="">
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
					<select de-data="봄" id="selSeason" name="selSeason">
						<option value="1">봄</option>
						<option value="2">여름</option>
						<option value="3">가을</option>
						<option value="4">겨울</option>									
					</select>
				</div>
			</div>
		</div>		
		<div class="wid-25 mag-l2">
			<div class="search-wr search-wr_div">				
<!-- 					<select class="wid-10" id="search_type" name="search_type" de-data="출강점 현황"> -->
<!-- 						<option value="">출강점</option> -->
<!-- 						<option value=""></option> -->
<!-- 						<option value=""></option> -->
<!-- 						<option value=""></option> -->
<!-- 					</select> -->
				<input type="text" class="inp-100" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="강사명 / 강좌명이 검색됩니다.">
				<input class="search-btn" type="button" value="검색" onclick="getList">
			</div>
		</div>
		<div class="wid-25">
			<div class="table margin-auto">
				<div class="sear-tit">강좌 유형</div>
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
		
		<div class="wid-25">
			<div class="table">
				<div class="sear-tit sear-tit_70">강좌 분류</div>
				<div class="">
					<div class="table table-auto">
						<div>
							<select de-data="전체" id="main_cd" name="main_cd" data-name="대분류" onchange="selMaincd(this)">
								<option value="">전체</option>
								<c:forEach var="j" items="${maincdList}" varStatus="loop">
									<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
								</c:forEach>
							</select>					
						</div>
						<div>
							<select de-data="전체" id="sect_cd" name="sect_cd" onchange="">
								<option value="">전체</option>
							</select>					
						</div>
					</div>
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
<%-- 			<colgroup> --%>
<%-- 				<col width="40px"> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 			</colgroup> --%>
			<thead>
				<tr>
					<th>No.</th>
					<th onclick="reSortAjax('sort_cus_pn')">강사명<img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_bmd')">생년월일<img src="/img/th_up.png" id="sort_bmd"></th>
					<th onclick="reSortAjax('sort_lecr_point')">평가등급<img src="/img/th_up.png" id="sort_lecr_point"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">진행강좌수<img src="/img/th_up.png" id="sort_lect_cnd"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">출강점 계<img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_s_store')">수원점<img src="/img/th_up.png" id="sort_s_store"></th>
					<th onclick="reSortAjax('sort_b_store')">분당점<img src="/img/th_up.png" id="sort_b_store"></th>
					<th onclick="reSortAjax('sort_p_store')">평택점<img src="/img/th_up.png" id="sort_p_store"></th>
					<th onclick="reSortAjax('sort_w_store')">원주점<img src="/img/th_up.png" id="sort_w_store"></th>
				</tr>	
			</thead>
		</table>
	</div>
	<div class="table-list table-stlist" >
		<table>
<%-- 			<colgroup> --%>
<%-- 				<col width="40px"> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 				<col/> --%>
<%-- 			</colgroup> --%>
			<thead>
				<tr>
					<th>No.</th>
					<th onclick="reSortAjax('sort_cus_pn')">강사명<img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_bmd')">생년월일<img src="/img/th_up.png" id="sort_bmd"></th>
					<th onclick="reSortAjax('sort_lecr_point')">평가등급<img src="/img/th_up.png" id="sort_lecr_point"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">진행강좌수<img src="/img/th_up.png" id="sort_lect_cnd"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">출강점 계<img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_s_store')">수원점<img src="/img/th_up.png" id="sort_s_store"></th>
					<th onclick="reSortAjax('sort_b_store')">분당점<img src="/img/th_up.png" id="sort_b_store"></th>
					<th onclick="reSortAjax('sort_p_store')">평택점<img src="/img/th_up.png" id="sort_p_store"></th>
					<th onclick="reSortAjax('sort_w_store')">원주점<img src="/img/th_up.png" id="sort_w_store"></th>
				</tr>	
			</thead>
			
			<tbody id="list_target">
				
			</tbody>
		</table>
	</div>
</div>
			
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

<div class="sta-botfix sta-botfix07">
	<ul>
		<li class="li01">총 계</li>
		<li id="tot_store" class="li02">0</li>
		<li id="tot_s_store" class="li02">0</li>
		<li id="tot_b_store" class="li02">0</li>
		<li id="tot_p_store" class="li02">0</li>
		<li id="tot_w_store" class="li02">0</li>
		<li class="li03"></li>
	</ul>
</div>











<script>
$(document).ready(function(){
	getLastYearSeason();
	
	getList();
});
</script>












<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>