<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
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
function getList(paging_type) 
{
	getListStart();
	
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("print_type", $("#print_type").val(), 9999);
	
	$.ajax({
		type : "POST", 
		url : "./getPrintList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			search_name : $("#search_name").val(),
			print_type : $("#print_type").val()
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
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+result.list[i].CUS_PN+'</td>';
					inner += '	<td>'+nullChk(result.list[i].TYPE)+'</td>';
					if(result.list[i].CUS_NO == result.list[i].CREATE_RESI_NO)
					{
						inner += '	<td>본인</td>';
					}
					else
					{
						inner += '	<td>'+nullChk(result.list[i].CREATE_RESI_NM)+'</td>';
					}
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="4"><div class="no-data">검색결과가 없습니다.</div></td>';
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
	<h2>증명서 발급 리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn02" href="/lecture/lecr/certificate">출강증명서 발급하기</a>
		<a class="btn btn02" href="/lecture/lecr/certificate_tax">원천징수영수증 발급</a>
	</div>
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
<!-- 		<div class="wid-35"> -->
<!-- 			<div class="table table02 table-input wid-contop"> -->
<!-- 				<div> -->
<!-- 					<select id="hq" name="hq" de-data="[00] 애경유통"> -->
<!-- 						<option value="00">[00] 애경유통</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<select id="hq" name="hq" de-data="[00] 애경유통"> -->
<!-- 						<option value="00">[00] 애경유통</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 				<div> -->
<!-- 					<select id="hq" name="hq" de-data="[00] 애경유통"> -->
<!-- 						<option value="00">[00] 애경유통</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="wid-4 mag-lr2">
			<div class="table">
				<div class="search-wr sel100">
					<form id="fncForm" name="fncForm" method="get" action="./list">
					    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="강사명 / 멤버스번호가 검색됩니다.">
				    	<input class="search-btn" style="right:160px !important" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
					</form>
				</div>
			</div>
		</div>
		
		<div class="wid-25">
			<div class="table">
				<div class="sear-tit">증명서 종류</div>
				<div>
					<select id="print_type" name="print_type" de-data="전체">
						<option value="">전체</option>
						<option value="원천징수영수증">원천징수영수증</option>
						<option value="출강증명서">출강증명서</option>
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
		<div class="float-right">
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
			<colgroup>
				<col width="60px">
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-220">NO.</th>
					<th class="td-140" onclick="reSortAjax('sort_cus_pn')">강사명 <img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_type')">증명서 종류<img src="/img/th_up.png" id="sort_type"></th>
					<th onclick="reSortAjax('sort_create_resi_no')">발급자<img src="/img/th_up.png" id="sort_create_resi_no"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list certi-table">
		<table>
			<colgroup>
				<col width="60px">
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-220">NO.</th>
					<th class="td-140" onclick="reSortAjax('sort_cus_pn')">강사명 <img src="/img/th_up.png" id="sort_cus_pn"></th>
					<th onclick="reSortAjax('sort_type')">증명서 종류<img src="/img/th_up.png" id="sort_type"></th>
					<th onclick="reSortAjax('sort_create_resi_no')">발급자<img src="/img/th_up.png" id="sort_create_resi_no"></th>
				</tr>
			</thead>
			<tbody id="list_target">
			</tbody>
			
		</table>
	</div>
</div>


<script>
$(document).ready(function() {
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("print_type")) != "") { $("#print_type").val(nullChk(getCookie("print_type"))); $(".print_type").html($("#print_type option:checked").text());}
	getList();
});

</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>