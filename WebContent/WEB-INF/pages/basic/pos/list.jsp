<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>
var listSize = '${listSize}';
var page = '${page}';
var search_name = '${search_name}';
var order_by = '${order_by}';
var sort_type = '${sort_type}';
var search_store = '${search_store}';
var act = 'write';
var get_hq = "";
var get_store = "";
var get_pos = "";

function getList(paging_type)
{
	getListStart();
	var search_name = document.getElementById("search_name").value;
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#search_sel").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	$.ajax({
		type : "POST", 
		url : "./list_pos",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			search_store : $("#search_sel").val(),
			search_name: search_name
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			var resultText = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					var con = result.list[i];

					var listCnt = (sort_type == "ROWID" && order_by == "asc") ? i+1+((result.page-1)*result.listSize) : result.listCount-((result.page-1)*result.listSize)-i;
					var	hq = nullChk(con.HQ),
						store = nullChk(con.STORE),
						short_name = nullChk(con.SHORT_NAME),
						pos_no = nullChk(con.POS_NO),
						sale_ymd = nullChk(con.SALE_YMD),
						open_yn = nullChk(con.OPEN_YN),
						sale_end_yn = nullChk(con.SALE_END_YN),
						ad_end_yn = nullChk(con.AD_END_YN),
						create_resi_no = nullChk(con.CREATE_RESI_NO),
						send_yn = nullChk(con.SEND_YN),
						delete_yn = nullChk(con.DELETE_YN),
						create_date = nullChk(con.CREATE_DATE)
						;
					inner += '<tr>';
					inner += '	<td class="td-chk"><input type="checkbox" name="idx1" data-hq="'+hq+'" data-store="'+store+'" data-pos_no="'+pos_no+'"><label onclick="checked_one(this);"></label></td>';
					inner += '  <td>'+listCnt+'</td>';
					inner += '	<td>'+short_name+'</td>';
					inner += '	<td>'+pos_no+'</td>';
					inner += '	<td>'+sale_ymd+'</td>';
					inner += '  <td>'+open_yn+'</td>';
					inner += '  <td>'+sale_end_yn+'</td>';
					inner += '  <td>'+ad_end_yn+'</td>';
					inner += '  <td>'+create_resi_no+'</td>';
					inner += '	<td>'+create_date+'</td>';
					inner += '</tr>';
				}
				resultText = "결과 "+result.listCount+"개 / 전체 "+result.allCount+"개";
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="10"><div class="no-data">검색결과가 없습니다.</div></td>';
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
function delete_ready(){
	var cont = document.querySelectorAll(".table-list input[type=checkbox]:checked");
	if(confirm("선택한 항목들을 삭제하시겠습니까?")){
		if(cont.length < 1){
			alert("선택된 항목이 없습니다.");
			return false;
		}else{
			for(var i = 0; i < cont.length; i++){
				var get_hq = cont[i].dataset.hq;
				var get_store = cont[i].dataset.store;
				var get_pos_no = cont[i].dataset.pos_no;
				$.ajax({
					type: "POST",
					data:{
						get_hq: get_hq,
						get_store: get_store,
						get_pos_no: get_pos_no
					},
					url: "./delete_proc",
					success: function(data){
						alert(data.msg);
						if(data.isSuc == "success"){
							location.reload();
						}
					}
				});
			}
		}
	}
}
function close_act(){
	$(".status_now").text("POS추가");
	console.log($("#fncFormPos")[0]);
	$("#fncFormPos")[0].reset();
	console.log($("#fncFormPos")[0]);
	$("#fncFormPos").children('select').defaultSelected;
	$(".selectedOption:eq(1)").html("선택");
	$(".selectedOption:eq(2)").html("선택");
	$(".selectedOption:eq(4)").html("선택");
	act = "write";
}
function reSort(act)
{
	var sort_type = act.replace("sort_", "");
	var order_by = "";
	if($("#"+act).html() == '<img src="/img/icon_down.png">')
	{
		order_by = "desc";
	}
	else if($("#"+act).html() == '<img src="/img/icon_up.png">')
	{
		order_by = "asc";
	}
	$("#sort_type").val(sort_type);
	$("#order_by").val(order_by);
	$("#page").val(1);
	$("#fncForm").submit();
}
function enter_check()
{
	if(event.keyCode == 13){
		reSelect('search');
		return;
	}
}
function search_store_sel(option)
{	
	$("#search_store").val(option.value);
	console.log($("#search_store").val());
}
function pageMove(page)
{
	$("#page").val(page);
	$("#fncForm").submit();
}
function writePos(){
	if($("#selBranch").val() == "")
	{
		alert("지점을 선택해주세요.");
		return;
	}
	$('#write_layer').fadeIn(200);
}

function fncSubmitPos()
{
	var validationFlag = "Y";
	var regex= /[^0-9]/g;
	if(document.getElementById("write_pos_no").value.length != 6 || (regex.test(document.getElementById("write_pos_no").value))){
		alert("POS번호의 형식이 바르지 않습니다.");
		document.getElementById("write_pos_no").focus();
		validationFlag = "N";
		return false;
	}
	var write_store = $("#search_sel").val();
	if(write_store == "")
	{
		alert("지점을 선택해주세요.");
		validationFlag = "N";
		return false;
	}
	if(validationFlag == "Y")
	{
		$("#write_store").val(write_store);
		if(act == "write")
		{
			$("#fncFormPos").ajaxSubmit({
				url: "./write_proc",
				success: function(data)
				{
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
	}
}
//체크박스
function checked_all(data){
	if(data.previousSibling.checked){
		data.previousSibling.checked = false;
	}else if(!data.previousSibling.checked){
		data.previousSibling.checked = true;
	}
	var chk_checked = data.previousSibling.checked;
	var idx_arr = document.querySelectorAll("input[name*='idx']");
	if(chk_checked == true){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = true;
		}
	}else if(chk_checked == false){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = false;
		}
	}
}
function checked_one(data){
	var $this = data.previousSibling;
	var chk_checked = $this.checked;
	if(chk_checked == true){
		$this.checked = false;
	}else if(chk_checked == false){
		$this.checked = true;
	}
}
</script>

<div class="sub-tit sub-tit02">
	<h2>POS 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<ul id="breadcrumbs" class="breadcrumb">
		<li>기본관리</li>
		<li>운영자 관리</li>
		<li>POS 관리</li>
	</ul>
	<div class="btn-right">
				
		<div class="fl-in">
			<div class="table table02">
				
				<div>
					<c:if test="${isBonbu eq 'T'}">
						<select de-data="전체" id="search_sel" name="search_sel" onchange="javascript:search_store_sel(this); getList();">
								<option value="">전체</option>
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</c:if>
					<c:if test="${isBonbu eq 'F'}">
						<select de-data="${login_rep_store_nm}" id="search_sel" name="search_sel" onchange="search_store_sel(this);">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</c:if>
				</div>
				<div class="search-wr search-wr02 sear-6" style="min-width: 230px; ">
				    <input type="hidden" id="page" name="page" value="${page}">
				    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="POS번호">
				    <input class="search-btn" type="button" value="검색" onclick="getList();">
					<input type="hidden" id="order_by" name="order_by" value="${order_by}">
				    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
				    <input type="hidden" id="search_store" name="search_store" value="${search_store }">
				</div>
			
				<div>
					<a class="btn btn01 btn01_1" onclick="javascript:writePos();"><i class="material-icons">add</i>POS추가</a>
					<a class="btn btn01 btn01_1" onclick="javascript:delete_ready();">삭제</a>
				</div>
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
				<col>
				<col>
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="checked_all(this);"><label for="idxAll"></label>
					</th>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_STORE')">지점 <img src="/img/th_down.png" id="sort_STORE"/></th>
					<th onclick="reSortAjax('sort_POS_NO')">POS번호 <img src="/img/th_down.png" id="sort_POS_NO"/></th>
					<th onclick="reSortAjax('sort_SALE_YMD')">영업일자 <img src="/img/th_down.png" id="sort_SALE_YMD"/></th>
					<th onclick="reSortAjax('sort_OPEN_YN')">개설여부 <img src="/img/th_down.png" id="sort_OPEN_YN"/></th> 
					<th onclick="reSortAjax('sort_SALE_END_YN')">영업여부 <img src="/img/th_down.png" id="sort_SALE_END_YN"/></th>
					<th onclick="reSortAjax('sort_AD_END_YN')">정산여부 <img src="/img/th_down.png" id="sort_AD_END_YN"/></th>
					<th onclick="reSortAjax('sort_CREATE_RESI_NO')">등록자 <img src="/img/th_down.png" id="sort_CREATE_RESI_NO"/></th>
					<th onclick="reSortAjax('sort_CREATE_DATE')">등록일자 <img src="/img/th_down.png" id="sort_CREATE_DATE"/></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="checked_all(this);"><label for="idxAll"></label>
					</th>
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_STORE')">지점 <img src="/img/th_down.png" id="sort_STORE"/></th>
					<th onclick="reSortAjax('sort_POS_NO')">POS번호 <img src="/img/th_down.png" id="sort_POS_NO"/></th>
					<th onclick="reSortAjax('sort_SALE_YMD')">영업일자 <img src="/img/th_down.png" id="sort_SALE_YMD"/></th>
					<th onclick="reSortAjax('sort_OPEN_YN')">개설여부 <img src="/img/th_down.png" id="sort_OPEN_YN"/></th> 
					<th onclick="reSortAjax('sort_SALE_END_YN')">영업여부 <img src="/img/th_down.png" id="sort_SALE_END_YN"/></th>
					<th onclick="reSortAjax('sort_AD_END_YN')">정산여부 <img src="/img/th_down.png" id="sort_AD_END_YN"/></th>
					<th onclick="reSortAjax('sort_CREATE_RESI_NO')">등록자 <img src="/img/th_down.png" id="sort_CREATE_RESI_NO"/></th>
					<th onclick="reSortAjax('sort_CREATE_DATE')">등록일자 <img src="/img/th_down.png" id="sort_CREATE_DATE"/></th>
				</tr>
			</thead>
			<tbody id="list_target">
				<!-- <c:forEach var="i" items="${list}" varStatus="loop">
				<c:set var="readCnt" value="${listCount - (page - 1) * listSize - loop.index }"/>
					<tr>
						<td class="td-chk">
							<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label>
						</td>
					   	<td>${readCnt }</td>
					   	<td>${i.SHORT_NAME}</td>
					   	<td>${i.POS_NO}</td>
						<td>${i.SALE_YMD}</td>
					   	<td>${i.OPEN_YN}</td> 
					   	<td>${i.SALE_END_YN}</td>
					   	<td>${i.AD_END_YN}</td>
					   	<td>${i.CREATE_RESI_NO}</td>
					   	<td>${i.CREATE_DATE}</td>
					</tr>
				</c:forEach> -->
<!--				<tr class="add">
					<td class="td-chk">
						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label>
					</td>
				   	<td>${readCnt }</td>
				   	<td>${i.STORE}</td>
				   	<td><a href="./modify?get_hq=${i.HQ}&get_store=${i.STORE}&get_pos_no=${i.POS_NO}">${i.POS_NO}</a></td>
				   	<td>${i.SALE_YMD}</td>
				   	<td>${i.OPEN_YN}</td>
				   	<td>${i.SALE_END_YN}</td>
				   	<td>${i.AD_END_YN}</td>
				   	<td>${i.CREATE_RESI_NO}</td>
				   	<td>${i.CREATE_DATE}</td>
				</tr> -->
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>

<div id="write_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg code-edit">
        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200); close_act();">
        			닫기<i class="far fa-window-close"></i>
        		</div>
				<div>
					<form id="fncFormPos" name="fncFormPos" method="POST" action="./write_proc" onSubmit="return false;">
						<input type="hidden" name="write_create_resi_no" value="${login_id }">
						<input type="hidden" id="write_store" name="write_store" value="">
						<h3 class="status_now">POS 추가</h3>
						<div class="top-row inp-bgno inp-bgno02">
							<div class="ak-wrap_new">
								<div class="wid-5">
									<!-- 
									<div class="table">
										<div class="sear-tit">영업일자</div>
										<div>
											<select id="write_sale_ymd" name="write_sale_ymd" class="notEmpty" de-data="선택">
												<option value="20190831">2019-08-31</option>
												<option value="20190725">2019-07-25</option>
											</select>
										</div>
									</div>
									
									<div class="table">
										<div class="sear-tit">영업여부</div>
										<div>
											<ul class="radio-ul">
												<li><input type="radio" id="write_sale_end_yn-1" name="write_sale_end_yn" value="Y"><label for="write_sale_end_yn-1">O</label></li>
												<li><input type="radio" id="write_sale_end_yn-2" name="write_sale_end_yn" value="N"><label for="write_sale_end_yn-2">X</label></li>
											</ul>
										</div>
									</div>
									 -->
								</div>
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit_120">POS 번호</div>
										<div>
											<input id="write_pos_no" name="write_pos_no" class="notEmpty" value="" onkeypress="excuteEnter(fncSubmitPos);">
										</div>
									</div>
									<!-- 
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">개설여부</div>
										<div>
											<ul class="radio-ul">
												<li><input type="radio" id="write_open_yn-1" name="write_open_yn" value="Y"><label for="write_open_yn-1">O</label></li>
												<li><input type="radio" id="write_open_yn-2" name="write_open_yn" value="N"><label for="write_open_yn-2">X</label></li>
											</ul>
										</div>
									</div>
									
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">정산여부</div>
										<div>
											<ul class="radio-ul">
												<li><input type="radio" id="write_ad_end_yn-1" name="write_ad_end_yn" value="Y"><label for="write_ad_end_yn-1">O</label></li>
												<li><input type="radio" id="write_ad_end_yn-2" name="write_ad_end_yn" value="N"><label for="write_ad_end_yn-2">X</label></li>
											</ul>
										</div>
									</div>
									 -->
								</div>
							</div>
						</div>
					</form>
					<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitPos();">저장</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<script>
$(document).ready(function(){
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#search_sel").val(nullChk(getCookie("store"))); $(".search_sel").html($("#search_sel option:checked").text());} else {$("#search_sel").val(login_rep_store);$(".search_sel").html(login_rep_store_nm);}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	
	
	getList();
	document.getElementById("write_layer").addEventListener('click', function(e){
		if(e.toElement.className == "pop-bg"){
			close_act();
		}
	});
	$(".posNow").css({"background":"#ff004d","color":"#fff"});
	$("#p_"+page).css({"background":"#ff004d","color":"#fff"});
	
// 	var load_store = $("#search_sel option[value="+search_store+"]");
// 	$(".selectedOption:eq(0)").html(load_store[0].text);
// 	load_store.attr("selected", "selected");
	if(order_by == "desc")
	{
		$("#sort_"+sort_type).html('<img src="/img/icon_up.png">');
	}
	else if(order_by == "asc")
	{
		$("#sort_"+sort_type).html('<img src="/img/icon_down.png">');
	}
	if(listSize != "")
	{
		$("#listSize").val(listSize);
	}
})
</script>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>