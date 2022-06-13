<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown()
{
	var filename = "운영자리스트";
	var table = "excelTable";
    exportExcel(filename, table);
}
function search_store(data){
	var store_arr = new Array();
	var target = document.getElementById("store_data");
	var store_data = Array.prototype.slice.call(document.querySelectorAll("input[name='store']:checked"));
	for(var i = 0; i < store_data.length; i++){
		store_arr.push(store_data[i].value);
	}
	target.value = store_arr.join('|');
}
function search_auth(data){
	var auth_arr = new Array();
	var target = document.getElementById("auth_data");
	var auth_data = Array.prototype.slice.call(document.querySelectorAll("input[name='auth']:checked"));
	for(var i = 0; i < auth_data.length; i++){
		auth_arr.push(auth_data[i].value);
	}
	target.value = auth_arr.join('|');
}
//전체 체크박스
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
//단일 체크박스
function checked_one(data){
	var $this = data.previousSibling;
	var chk_checked = $this.checked;
	if(chk_checked == true){
		$this.checked = false;
	}else if(chk_checked == false){
		$this.checked = true;
	}
}

function getList(paging_type)
{
	getListStart();
	var search_name = document.getElementById("search_name").value;
	var search_type = document.getElementById("search_type").value;
	var search_status = document.getElementById("search_status").value;
	var store_data = document.getElementById("store_data").value;
	var auth_data = document.getElementById("auth_data").value;

	if(order_by == "" && sort_type == "")
	{
		order_by = "desc";
		sort_type = "status";
		$("#sort_status").attr("src", "/img/th_up.png");
	}
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("search_name", document.getElementById("search_name").value, 9999);
	setCookie("search_type", document.getElementById("search_type").value, 9999);
	setCookie("search_status", document.getElementById("search_status").value, 9999);
	setCookie("store_data", document.getElementById("store_data").value, 9999);
	setCookie("auth_data", document.getElementById("auth_data").value, 9999);
	
	var ajax_data = {
		page : page,
		order_by : order_by,
		sort_type : sort_type,
		listSize : $("#listSize").val(),
		
		search_name: search_name,
		search_type: search_type,
		search_status: search_status,
		store_data: store_data,
		auth_data: auth_data
	};
	$.ajax({
		type : "GET", 
		url : "./list_user",
		dataType : "text",
		data : ajax_data,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data, textStatus, jqXHR) 
		{
			console.log(jqXHR);
			var result = JSON.parse(data);
			
			var inner = "";
			var resultText = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					var con = result.list[i];
					var listCnt = (sort_type == "seq_no" && order_by == "asc") ? i+1+((result.page-1)*result.listSize) : result.listCount-((result.page-1)*result.listSize)-i;
					var	seq_no = nullChk(con.SEQ_NO),
						company = nullChk(con.COMPANY),
						store = nullChk(con.STORE),
						store_nm = nullChk(con.STORE_NM),
						tim = nullChk(con.TIM),
						auth_name = nullChk(con.AUTH_NAME),
						name = nullChk(con.NAME),
						submit_date = nullChk(con.SUBMIT_DATE),
						status = nullChk(con.STATUS),
						bizno = nullChk(con.ID),
						email = nullChk(con.EMAIL),
						phone = nullChk(con.PHONE),
						id = nullChk(con.ID),
						pw = nullChk(con.PW)
						;
					
					inner += '<tr>';
					inner += '	<td class="td-chk"><input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label></td>';
// 					inner += '  <td class="bold"><a onclick="javascript:movePage(\''+seq_no+'\', \''+status+'\');">'+seq_no+'</a></td>';
					inner += '	<td name="store_nm">'+store_nm+'<p name="store" style="display:none;">'+store+'</p></td>';
					inner += '	<td name="tim">'+tim+'</td>';
					inner += '	<td>'+auth_name+'</td>';
					inner += '  <td name="bizno">'+bizno+'</td>';
					inner += '	<td name="name" class="bold"><a onclick="javascript:movePage(\''+seq_no+'\', \''+status+'\');">'+name+'</a></td>';
					inner += '	<td>'+submit_date+'</td>';
					if(status == "2")
					{
						//inner += '	<td><a onclick="javascript:;" onclick="javascript:approFunc(this, 1, \''+seq_no+'\');">승인</a></td>';
						inner += '	<td class="bold"><a onclick="javascript:movePage(\''+seq_no+'\', \''+status+'\');">승인</a></td>';	//승인 클릭시 상세페이지 이동 20.06.17
					}
					else
					{
						inner += '	<td><a onclick="javascript:approFunc(this, 2, \''+seq_no+'\', \''+email+'\', \''+phone+'\', \''+id+'\', \''+pw+'\');" class="color-red">미승인</a></td>';
					}
					inner += '</tr>';
				}
				resultText = "결과 "+result.listCount+"개 / 전체 "+result.allCount+"개";
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="8"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
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
			document.getElementsByClassName("cap-numb")[0].textContent = resultText;
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});
	//document.location.hash = JSON.stringify(ajax_data);
}


function movePage(seq_no, status){
	if(status != ""){
		window.open('about:blank').location.href = "./view?seq_no="+seq_no;
	}else{
		alert("최초 1회는 승인이 필요합니다.");
		return false;
	}
}

function approFunc(el, val, seq_no, email, phone, id, pw){
	var ajax_data = {};
	var ajax_url = "";
	var container = el.parentElement.parentElement;
	var getJoinData = function(name){
		return container.querySelector("td[name="+name+"]").textContent;
	}
	var getJoinData2 = function(name){
		return container.querySelector("p[name="+name+"]").innerHTML;
	}
	if(val == 1){ //1로 오는경우는 없다.
		if(!confirm("미승인상태로 전환하시겠습니까?")){
			return false;
		}
		ajax_data.modify_seq_no = seq_no;
		ajax_data.modify_status = val;
		ajax_url = "./appro_proc";
		console.log(ajax_data.modify_status);
	}else{ //미승인 상태의 사람을 누르면 일로 와진다.
		ajax_data.join_bizno = getJoinData("bizno");
		ajax_data.join_store = getJoinData2("store");
		ajax_data.join_tim = getJoinData("tim");
		ajax_data.join_name = getJoinData("name");
		ajax_data.join_status = val;
		ajax_data.join_seq_no = seq_no;
		ajax_data.join_email = email;
		ajax_data.join_phone = phone;
		ajax_data.join_id = id;
		ajax_data.join_pw = pw;
		ajax_url = "./join_proc";
	}
	ajax_data.auth_chk = "Y";
	$.ajax({
		async: false,
		data: ajax_data,
		url: ajax_url,
		type: "POST",
		success: function(data){
			getList();
		}
	});
}
</script>
<div class="sub-tit">
	<h2>운영자 리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<A class="btn btn01 btn01_1" href="../user/log">운영자 로그관리</A>
	</div>
</div>
<!-- <form id="fncForm" name="fncForm" method="get" action="./list"> -->
	<div class="table-top infi-fix">
		<div class="infi-btn">
			<div class='infi-b infi-open act'>검색 펼침<i class='material-icons'>arrow_drop_down</i></div>
			<div class='infi-b infi-close'>검색 닫기<i class='material-icons'>arrow_drop_up</i></div>
		</div>
		<div class="top-row sear-wr">
			<div class="wid-5">
				<div class="table">
					<div class="sear-tit">검색</div>				
					
					<div class="search-wr search-wr_div">				
						<select class="wid-10" id="search_type" name="search_type" de-data="담당자명">
							<option value="USER_NM">담당자명</option>
							<option value="USER_ID">아이디</option>
							<option value="TIM">팀</option>
<!-- 							<option value="HP_NO">휴대전화번호</option> -->
<!-- 							<option value="EMAIL">이메일</option> -->
							<option value="BIZNO">사번</option>
						</select>
						<div class="search-wr_div02 sear-6">					
						    <input type="text" class="inp-100" id="search_name" name="search_name" onkeypress="page = 1; excuteEnter(getList)" placeholder="검색어를 입력하세요.">
						    <input class="search-btn" type="button" value="검색" onclick="page = 1; getList();">
						</div>
					</div>
				</div>
			</div>
			<div class="wid-5">
				<div class="table">
					<div class="sear-tit">상태</div>
					<div>
						<div class="select">
							<select class="wid-10" id="search_status" name="search_status" de-data="전체">
								<option value="1">전체</option>
								<option value="2">승인</option>
								<option value="null">미승인</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="top-row">
			<div class="wid-5">
				<div class="table">
					<div class="sear-tit">권한별 검색</div>
					<div>
						<ul class="chk-ul">
							<c:forEach var="item" items="${cate}" varStatus="vs">
								<li>
									<input type="checkbox" id="cate-${vs.index}" name="auth" value="${item.NAME}" onclick="search_auth(this);">
									<label for="cate-${vs.index}">${item.NAME }</label>
								</li>
							</c:forEach>
						</ul>
						<a href="../user/level" class="level-btn">등급별 권한설정<i class="fas fa-cog"></i></a>
					</div>
				</div>
			</div>
			<div class="wid-5">
				<div class="table">
					<div class="sear-tit">지점별 검색</div>
					<div>
						<ul class="chk-ul">
							<c:forEach var="item" items="${branchList}" varStatus="vs">
							<li>
								<input type="checkbox" id="all-${vs.index}" name="store" value="${item.SUB_CODE}" onclick="search_store(this);">
								<label for="all-${vs.index}">${item.SHORT_NAME }</label>
							</li>
							</c:forEach>
						</ul>
						
					</div>
				</div>
			</div>
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="page = 1; getList();">
		
	</div>
	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb">결과 0개 / 전체 0개</p>
		</div>
		<div class="cap-r text-right">
			<div class="table float-right">
				<div class="sel-scr">
<!-- 					<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a> -->
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
    <input type="hidden" id="store_data" name="store_data" value=""> 
    <input type="hidden" id="auth_data" name="auth_data" value=""> 
	<!--
	<input type="hidden" id="page" name="page" value="${page}">
	<input type="hidden" id="order_by" name="order_by" value="${order_by}">
    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
	 </form> 
	-->
<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col width="120px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="checkAll"><label onclick="checked_all(this);"></label>
					</th>
<!-- 					<th class="td-no" onclick="reSortAjax('sort_seq_no')">NO. <img src="/img/th_down.png" id="sort_seq_no"/></th> -->
					<th onclick="reSortAjax('sort_store')">지점 <img src="/img/th_down.png" id="sort_store"/></th>
					<th onclick="reSortAjax('sort_tim')">팀 <img src="/img/th_down.png" id="sort_tim"/></th>
					<th onclick="reSortAjax('sort_auth_name')">구분 <img src="/img/th_down.png" id="sort_auth_name"/></th>
					<th onclick="reSortAjax('sort_id')">사번 <img src="/img/th_down.png" id="sort_id"/></th>
					<th onclick="reSortAjax('sort_name')">담당자명 <img src="/img/th_down.png" id="sort_name"/></th>
					<th onclick="reSortAjax('sort_submit_date')">등록일 <img src="/img/th_down.png" id="sort_submit_date"/></th>
					<th onclick="reSortAjax('sort_status')">승인상태 <img src="/img/th_up.png" id="sort_status"/></th>
					<!-- 
					<th onclick="reSort('sort_')">POS번호 <i class="material-icons">import_export</i></th>
					-->
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup>
				<col width="60px">
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col width="120px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="checkAll"><label onclick="checked_all(this);"></label>
					</th>
<!-- 					<th class="td-no" onclick="reSortAjax('sort_seq_no')">NO. <img src="/img/th_down.png" id="sort_seq_no"/></th> -->
					<th onclick="reSortAjax('sort_store')">지점 <img src="/img/th_down.png" id="sort_store"/></th>
					<th onclick="reSortAjax('sort_tim')">팀 <img src="/img/th_down.png" id="sort_tim"/></th>
					<th onclick="reSortAjax('sort_auth_name')">구분 <img src="/img/th_down.png" id="sort_auth_name"/></th>
					<th onclick="reSortAjax('sort_id')">사번 <img src="/img/th_down.png" id="sort_id"/></th>
					<th onclick="reSortAjax('sort_name')">담당자명 <img src="/img/th_down.png" id="sort_name"/></th>
					<th onclick="reSortAjax('sort_submit_date')">등록일 <img src="/img/th_down.png" id="sort_submit_date"/></th>
					<th onclick="reSortAjax('sort_status')">승인상태 <img src="/img/th_up.png" id="sort_status"/></th>
					<!-- 
					<th onclick="reSort('sort_')">POS번호 <i class="material-icons">import_export</i></th>
					-->
				</tr>
			</thead>
			<tbody id="list_target">
				<!-- <c:forEach var="i" items="${list}" varStatus="loop">
				<c:set var="readCnt" value="${listCount - (page - 1) * listSize - loop.index}"/>
				<tr>
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
					</td>
					<td class="bold"><a href="./view?seq_no=${i.SEQ_NO}">${readCnt}</a></td>
				   	<td>${i.COMPANY}</td>
				   	<td>${i.STORE}</td>
				   	<td>${i.TIM}</td>
					<td>${i.AUTH_NAME}</td>
				   	<td class="bold"><a href="./view?seq_no=${i.SEQ_NO}">${i.BIZNO}</a></td>
				   	<td>${i.NAME}</td>
				   	<td>${i.SUBMIT_DATE}</td>
				<c:choose>
				<c:when test="${i.STATUS == '2'}">
				   	<td ><span>승인</span></td>
				</c:when>
				<c:otherwise>
					<td class="color-red"><span>미승인</span></td>
				</c:otherwise>
				</c:choose>
				</tr>
				</c:forEach> 
				-->
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>

<script>

$(document).ready(function(){
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type")));}
	if(nullChk(getCookie("search_status")) != "") { $("#search_status").val(nullChk(getCookie("search_status")));}
	if(nullChk(getCookie("store_data")) != "") { $("#search_name").val(nullChk(getCookie("store_data")));}
	if(nullChk(getCookie("auth_data")) != "") { $("#search_name").val(nullChk(getCookie("auth_data")));}
	getList();
})


</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>