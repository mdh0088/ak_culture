<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
var act = "";

function getList(paging_type)
{
	getListStart();
	if(order_by == "" && sort_type == "")
	{
		order_by = "desc";
		sort_type = "delete_yn";
	}
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	$.ajax({
		type : "POST", 
		url : "./list_ip",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			search_name : $("#search_name").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					if(result.list[i].DELETE_YN == "Y"){
						inner += '<tr>';
					}else{
						inner += '<tr class="Disabled">';
					}
					inner += '	<td class="td-chk"><input type="checkbox" name="idx1" data-hq="00" data-store="'+result.list[i].STORE+'" data-ip_addr="'+result.list[i].IP_ADDR+'"><label onclick="checked_one(this);"></label></td>';
					inner += '  <td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STATUS)+'</td>';
					inner += '	<td class="bold"><a onclick="modify_ready(\'00\',\''+result.list[i].STORE+'\',\''+result.list[i].IP_ADDR+'\'); return false;">'+result.list[i].IP_ADDR+'</a></td>';
					inner += '	<td>'+nullChk(result.list[i].POS_TYPE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POS_NO)+'</td>';
					inner += '  <td>'+nullChk(result.list[i].AUTOSIGN_PORT)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].CREATE_DATE)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="8"><div class="no-data">검색결과가 없습니다.</div></td>';
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
function modify_ready(hq, store, ip){
	act = "modify";
	get_hq = hq;
	get_store = store;
	get_ip = ip;
	$(".status_now").text("IP수정");
	$.ajax({
		type: "POST",
		data:{
			get_hq: get_hq,
			get_store: get_store,
			get_ip: get_ip
		},
		url: "./modify",
		async:false,
		error: function(){
			alert("통신 중 오류가 발생하였습니다.");
		},
		success: function(data){
			if(data.isSuc == "fail"){
				alert(data.msg);
			}else{
					$("#write_ip").val(data.IP_ADDR);
					$("#write_create_resi_no").val(data.CREATE_RESI_NO);
					$("#write_update_resi_no").val(data.UPDATE_RESI_NO);

					getPosList(data.STORE, data.POS_NO);
					var store = $("#write_store option[value='"+data.STORE+"']");
					store.attr("selected", "selected");
// 					$(".selectedOption:eq(2)").html(store[0].text);
					
					var ppcard_print_yn = $("#write_ppcard_print_yn option[value='"+data.PPCARD_PRINT_YN+"']");
// 					if(ppcard_print_yn[0] != undefined){
// 						ppcard_print_yn.attr("selected", "selected");
// 						$(".selectedOption:eq(4)").html(ppcard_print_yn[0].text);
// 					}
					var status = $("#write_status option[value='"+data.STATUS+"']");
					if(status[0] != undefined){
						status.attr("selected", "selected");
						$(".write_status").html(status[0].text);
					}

// 					if(data.POS_PRINT_YN == "Y"){
// 						$("#write_pos_print_yn1").prop("checked", true);
// 					}else{
// 						$("#write_pos_print_yn2").prop("checked", true);
// 					}
					
// 					var ppcard_port = $("#write_ppcard_port option[value='"+data.PPCARD_PORT+"']");
// 					if(ppcard_port[0] != undefined){
// 						ppcard_port.attr("selected", "selected");
// 						$(".selectedOption:eq(6)").html(ppcard_port[0].text);
// 					}
					
					var autosign_port = $("#write_autosign_port option[value='"+data.AUTOSIGN_PORT+"']");
					if(autosign_port[0] != undefined){
						autosign_port.attr("selected", "selected");
						$(".write_autosign_port").html(autosign_port[0].text);
					}
					writeIp();
					$("#write_pos_no").val(data.POS_NO);
					$(".write_pos_no").html(data.POS_NO);
			}
		}
	});
}
//수정 취소시 값 초기화
function close_act(){
	$(".status_now").text("IP추가");
	$("#fncFormIp")[0].reset();
	$("#fncFormIp").children('select').defaultSelected;
	var container = document.querySelectorAll(".selectedOption");
	for(var i = 2, length = container.length; i < length; i++){
		var text = "운영";
		if(container[i].nextSibling.nextSibling.dataset.name == "POS번호"){
			text = "지점을 선택하세요";
			container[i].nextSibling.innerHtml = '<li>지점을 선택하세요<li>';
		}
		container[i].textContent = text;
	}
	act = "write";
}
function writeIp(){
	if($("#selBranch").val() == "")
	{
		alert("지점을 선택해주세요.");
		return;
	}
	getPosList2();
	$('#write_layer').fadeIn(200);
}
function fncSubmitIp()
{
	var tmp = $(".write_pos_no").html();
	$("#write_pos_no").val(tmp);
	var validationFlag = "Y";
	var ipv4Checker = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
	var ipv6Checker = /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]).){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/;
	$(".notEmpty").each(function()
	{
		if(ipv4Checker.test(document.getElementById("write_ip").value) || ipv6Checker.test(document.getElementById("write_ip").value)){
			validationFlag == "Y";
		}else{
			alert("IP주소 형식이 올바르지 않습니다.");
			document.getElementById("write_ip").focus();
			validationFlag = "N";
			return false;
		}
// 		if(document.querySelector("input[name='write_pos_print_yn']:checked") == null){
// 			alert("POS프린터 유무를 선택해주세요.");
// 			document.querySelector("input[name='write_pos_print_yn']").focus();
// 			validationFlag = "N";
// 			return false;
// 		}
		if ($(this).val() == "") 
		{
			alert(this.dataset.name+"을(를) 입력해주세요.");
			$("#" + this.id).focus();
			validationFlag = "N";
			return false;
		}
	});
	if(validationFlag == "Y")
	{
		var write_store = $("#selBranch").val();
		$("#write_store").val(write_store);
		if(act == "modify")
		{
			$("#fncFormIp").ajaxSubmit({
				url: "./modify_proc",
				data: {
					get_hq: get_hq,
					get_store: get_store,
					get_ip: get_ip,
					auth_chk: "Y"
				},
				success: function(data)
				{
					var result = JSON.parse(data);
					if(result.isSuc == "success")
					{
						alert(result.msg);
						getList();
					}
					else
					{
						alert(result.msg);		
					}
				}
			});
		}
		else
		{
			$("#fncFormIp").ajaxSubmit({
				url: "./write_proc",
				data:{
					auth_chk: "Y"
				},
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
function deleteYn(){
	var cont = document.querySelectorAll('input[name*="idx"]:checked');
	var delete_yn = document.getElementById("modify_delete_yn").value;
	if(confirm("선택한 항목들을 반영 하시겠습니까?")){
		if(cont.length < 1){
			alert("선택된 항목이 없습니다.");
			return false;
		}else{
			for(var i = 0; i < cont.length; i++){
				var get_hq = cont[i].dataset.hq;
				var get_store = cont[i].dataset.store;
				var get_ip = cont[i].dataset.ip_addr;
				$.ajax({
					url: "./delete_yn",
					type: "POST",
					data: {
						get_hq: get_hq,
						get_store: get_store,
						get_ip: get_ip,
						delete_yn: delete_yn,
						auth_chk: "Y"
					}
				});
			}
			getList();
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
function getPosList(el, modify){
	$.ajax({
		data:{
			store: el
		},
		url: "./getPosList",
		success: function(data){
			var inner = "";
			var inner_li = "";
			
			for(var i = 0; i < data.length; i++)
			{
				console.log(data[i].POS_NO);
				inner += '<option value="'+data[i].POS_NO+'">'+data[i].POS_NO+'</option>';
				inner_li += '<li>'+data[i].POS_NO+'</li>';
			}
			$("#write_pos_no").html(inner);
			$(".write_pos_no_ul").html(inner_li);
// 			var container = document.getElementById("write_pos_no");
// 			var innertext = "선택";
// 			if(el == ""){
// 				innertext = "지점을 선택하세요";
// 			}
// 			if(typeof modify != "undefined"){
// 				$(".selectedOption:eq(3)").html(modify);
// 				document.querySelector("#write_pos_no").value = modify;
// 			}else{
// 				container.previousSibling.previousSibling.innerText = innertext;
// 				container.previousSibling.innerHTML = "<li>"+innertext+"</li>";
// 				container.innerHTML = "<option value=''>"+innertext+"</option>";
// 				for(var i = 0; i < data.length; i++){
// 					var option = document.createElement("option");
// 					option.text = data[i].POS_NO;
// 					option.value = data[i].POS_NO;
// 					var li = document.createElement("li");
// 					li.innerText = data[i].POS_NO;
// 					container.previousSibling.appendChild(li);
// 					container.appendChild(option);
// 				}
// 			}
		}
	});
}
function getPosList2(el, modify){ //기영이가 다시만듬
	$.ajax({
		data:{
			store: $("#selBranch").val()
		},
		url: "./getPosList",
		async : false,
		success: function(data){
			$("#write_pos_no").html('');
			$(".write_pos_no_ul").html('');
			for(var i = 0; i < data.length; i++)
			{
				$("#write_pos_no").append('<option value="'+data[i].POS_NO+'">'+data[i].POS_NO+'</option>');
				$(".write_pos_no_ul").append('<li>'+data[i].POS_NO+'</li>');
				if(i == 0)
				{
					$("#write_pos_no").val(data[i].POS_NO);
					$(".write_pos_no").html(data[i].POS_NO);
				}
			}
// 			var container = document.getElementById("write_pos_no");
// 			var innertext = "선택";
// 			if(el == ""){
// 				innertext = "지점을 선택하세요";
// 			}
// 			if(typeof modify != "undefined"){
// 				$(".selectedOption:eq(3)").html(modify);
// 				document.querySelector("#write_pos_no").value = modify;
// 			}else{
// 				container.previousSibling.previousSibling.innerText = innertext;
// 				container.previousSibling.innerHTML = "<li>"+innertext+"</li>";
// 				container.innerHTML = "<option value=''>"+innertext+"</option>";
// 				for(var i = 0; i < data.length; i++){
// 					var option = document.createElement("option");
// 					option.text = data[i].POS_NO;
// 					option.value = data[i].POS_NO;
// 					var li = document.createElement("li");
// 					li.innerText = data[i].POS_NO;
// 					container.previousSibling.appendChild(li);
// 					container.appendChild(option);
// 				}
// 			}
		}
	});
}
</script>

<div class="sub-tit">
	<h2>IP 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
<div class="table-top table-top02">
	<div class="top-row">
<!-- 		<div class="wid-45"> -->
<!-- 			<div class="table card-top"> -->
<!-- 				<div class="sear-tit">카드사 선택</div> -->
<!-- 				<div> -->
<!-- 					<ul class="chk-ul"> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="rad-c" name="rad-1" checked/> -->
<!-- 							<label for="rad-c">국민</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="rad-c" name="rad-2"/> -->
<!-- 							<label for="rad-c">비씨</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="rad-c" name="rad-3"/> -->
<!-- 							<label for="rad-c">신한</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="rad-c" name="rad-3"/> -->
<!-- 							<label for="rad-c">우리</label> -->
<!-- 						</li> -->
<!-- 					</ul> -->
<!-- 					<a class="btn btn01 btn-inline" href="#">검증하기</a> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
		<div>
			<div class="table card-top table-auto">
				<div class="sear-tit">지점별 검색</div>
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
		
		<div class="wid-3 ml-3">
			<div>
				<div class="" style="position:relative;">					
				    <input type="text" class="inp-100" id="search_name" name="search_name" onkeypress="excuteEnter(getList);" placeholder="IP를 입력하세요.">
				    <input class="search-btn s-b0" type="button" value="검색" onclick="getList();">
				</div>
			</div>
		</div>
	</div>	
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList();">
</div>
<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
			<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
				<option value="10">10개 보기</option>
				<option value="20">20개 보기</option>
				<option value="50">50개 보기</option>
				<option value="100">100개 보기</option>
				<option value="300">300개 보기</option>
				<option value="500">500개 보기</option>
				<option value="1000">1000개 보기</option>
			</select>
		<div class="table table02 table-auto float-right">
			<div>
				<p class="ip-ritit">선택한 항목을</p>
			</div>
			<div>
				<select id="modify_delete_yn" name="modify_delete_yn" de-data="사용">
					<option value="Y">사용</option>
					<option value="N">사용안함</option>
				</select>
				
				<a class="bor-btn btn03 btn-mar6" onclick="javascript:deleteYn();">반영</a> 
			</div>
			<div> 
				<a class="btn btn01 btn01_1" onclick="javascript:writeIp();"><i class="material-icons">add</i>IP추가</a>
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
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="checked_all(this);"><label for="idxAll"></label>
					</th>
					<th class="td-50" onclick="reSortAjax('sort_STORE')">지점 <img src="/img/th_down.png" id="sort_ROWID"/></th>
					<th class="td-80" onclick="reSortAjax('sort_STATUS')">운영여부 <img src="/img/th_down.png" id="sort_STATUS"/></th>
					<th onclick="reSortAjax('sort_IP_ADDR')">IP <img src="/img/th_down.png" id="sort_IP_ADDR"/></th>
					<th onclick="reSortAjax('sort_POS_TYPE')">단말기 종류 <img src="/img/th_down.png" id="sort_POS_TYPE"/></th>
					<th onclick="reSortAjax('sort_POS_NO')">POS번호 <img src="/img/th_down.png" id="sort_POS_NO"/></th>
					<th onclick="reSortAjax('sort_AUTOSIGN_PORT')">전자서명 포트번호<img src="/img/th_down.png" id="sort_AUTOSIGN_PORT"/></th>
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
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="checked_all(this);"><label for="idxAll"></label>
					</th>
					<th class="td-50" onclick="reSortAjax('sort_STORE')">지점 <img src="/img/th_down.png" id="sort_ROWID"/></th>
					<th class="td-80" onclick="reSortAjax('sort_STATUS')">운영여부 <img src="/img/th_down.png" id="sort_STATUS"/></th>
					<th onclick="reSortAjax('sort_IP_ADDR')">IP <img src="/img/th_down.png" id="sort_IP_ADDR"/></th>
					<th onclick="reSortAjax('sort_POS_TYPE')">단말기 종류 <img src="/img/th_down.png" id="sort_POS_TYPE"/></th>
					<th onclick="reSortAjax('sort_POS_NO')">POS번호 <img src="/img/th_down.png" id="sort_POS_NO"/></th>
					<th onclick="reSortAjax('sort_AUTOSIGN_PORT')">전자서명 포트번호<img src="/img/th_down.png" id="sort_AUTOSIGN_PORT"/></th>
					<th onclick="reSortAjax('sort_CREATE_DATE')">등록일자 <img src="/img/th_down.png" id="sort_CREATE_DATE"/></th>
				</tr>
			</thead>
			<tbody id="list_target">
			<!-- 
				<c:forEach var="i" items="${list}" varStatus="loop">
				<c:set var="readCnt" value="${listCount - (page - 1) * listSize - loop.index}"/>
				<c:choose>
					<c:when test="${i.DELETE_YN eq '비활성화' }">
					<tr class="Disabled">
					</c:when><c:otherwise>
					<tr>
					</c:otherwise>
				</c:choose>
						<td>
							<input type="checkbox" id="idx${readCnt }" name="idx" data-hq="${i.HQ}" data-store="${i.STORE }" data-ip_addr="${i.IP_ADDR }"><label for="idx${readCnt }"></label>
						</td>
						<td>${readCnt}</td>
						<td>${i.STATUS}</td>
						<td><a onclick="javascript:void(0);" onclick="modify_ready('${i.HQ}', '${i.STORE}', '${i.IP_ADDR}')">${i.IP_ADDR }</a></td>
						<td>${i.POS_TYPE }</td>
						<td>${i.POS_NO}</td>
						<td>${i.PPCARD_PRINT_YN}</td>
						<td>${i.POS_PRINT_YN}</td>
						<td>${i.PPCARD_PORT}</td>
						<td>${i.AUTOSIGN_PORT}</td>
						<td>${i.CREATE_DATE}</td>
						<td>${i.DELETE_YN}</td>
					</tr> 
				</c:forEach>
			 -->
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>





<div id="write_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg ip-edit ">
        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200); close_act();">
        			닫기<i class="far fa-window-close"></i>
        		</div>
				<div>
				<!-- 여기 -->
					<form id="fncFormIp" name="fncFormIp" method="POST">
						<h3 class="status_now">IP 추가</h3>
						<div class="top-row inp-bgno inp-bgno02">
							<div class="wid-10">
								<div class="table">
									<div class="wid-10">
										<input data-name="IP주소" type="text" id="write_ip" name="write_ip" class="notEmpty" placeholder="IP입력">
									</div>
									<!-- 
									<div class="wid-15">
										<a class="btn btn03">직접입력</a>
									</div>
									 -->
								</div>
							</div>
							<div class="table ak-wrap_new">
								<div class="">
									<input type="hidden" id="write_store" name="write_store" value="">
									<div class="table">
										<div class="sear-tit">POS 번호</div>
										<div>
											<select data-name="POS번호" id="write_pos_no" name="write_pos_no" class="notEmpty" de-data="지점을 선택하세요">
												<option value="">지점을 선택하세요</option>
											</select>
										</div>
									</div>
<!-- 									<div class="table"> -->
<!-- 										<div class="sear-tit">카드발급기</div> -->
<!-- 										<div> -->
<!-- 											<select data-name="카드발급기" id="write_ppcard_print_yn" name="write_ppcard_print_yn" de-data="선택"> -->
<!-- 												<option value="">선택</option> -->
<!-- 												<option value="Y">ID-2000ZP(RW)</option> -->
<!-- 												<option value="W">ZP-2000(W)</option> -->
<!-- 												<option value="N">없음</option> -->
<!-- 											</select> -->
<!-- 										</div> -->
<!-- 									</div> -->
																	
								</div>
								<div class="">
									<div class="table">
										<div class="sear-tit ">운영여부</div>
										<div>
											<select data-name="운영여부" id="write_status" name="write_status" de-data="운영">
												<option value="U">운영</option>
												<option value="T">테스트</option>
											</select>
										</div>
									</div>
<!-- 									<div class="table"> -->
<!-- 										<div class="sear-tit sear-tit_120">POS 프린터</div> -->
<!-- 										<div> -->
<!-- 											<ul class="radio-ul"> -->
<!-- 												<li><input type="radio" id="write_pos_print_yn1" name="write_pos_print_yn" value="Y"><label for="write_pos_print_yn1">O</label></li> -->
<!-- 												<li><input type="radio" id="write_pos_print_yn2" name="write_pos_print_yn" value="N"><label for="write_pos_print_yn2">X</label></li> -->
<!-- 											</ul> -->
<!-- 										</div> -->
<!-- 									</div> -->
								
<!-- 									<div class="table"> -->
<!-- 										<div class="sear-tit sear-tit_120">발급기 포트번호</div> -->
<!-- 										<div> -->
<!-- 											<div class="table table02"> -->
<!-- 												<div>발급기</div> -->
<!-- 												<div> -->
<!-- 													<select data-name="발급기 포트번호" id="write_ppcard_port" name="write_ppcard_port" de-data="선택"> -->
<!-- 														<option value="">선택</option> -->
<!-- 														<option value="1">1</option> -->
<!-- 														<option value="2">2</option> -->
<!-- 														<option value="3">3</option> -->
<!-- 														<option value="4">4</option> -->
<!-- 														<option value="5">5</option> -->
<!-- 														<option value="6">6</option> -->
<!-- 														<option value="7">7</option> -->
<!-- 														<option value="8">8</option> -->
<!-- 														<option value="9">9</option> -->
<!-- 													</select> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
								</div>
								<div>
									<div class="table">
										<div class="sear-tit sear-tit_120">전사서명 포트번호</div>
										<div>
											<div class="table table02">
												<!-- <div>발급기</div> -->
												<div>
													<select data-name="전자서명 포트번호" id="write_autosign_port" name="write_autosign_port" de-data="9">
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>
														<option value="6">6</option>
														<option value="7">7</option>
														<option value="8">8</option>
														<option value="9" selected>9</option>
													</select>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitIp();">저장</a>
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
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	
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
	
	getList();
})

</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>