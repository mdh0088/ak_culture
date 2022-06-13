<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
$(document).ready(function() {
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
	
	//지점변경하면 쿠키 남기도록.
	var room_store = getCookie("room_store");
	var room_store_nm = getCookie("room_store_nm");
	
	if(room_store != '')
	{
		$("#selBranch").val(room_store);
		$(".selBranch").html(room_store_nm);
	}
	else
	{
		$("#selBranch").val(login_rep_store);
		$(".selBranch").html(login_rep_store_nm);
	}
	getList();
});
function changeStore()
{
	$.ajax({
		type : "POST", 
		url : "./getStoreNm",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			setCookie("room_store_nm", data, 9999);
			setCookie("room_store", $("#selBranch").val(), 9999);
		}
	});
	
}
function delRoom()
{
	var isIn = false;
	var chkList = "";
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).attr("id").replace("chk_", "")+"|";
    		$.ajax({
    			type : "POST", 
    			url : "./searchUseRoom",
    			dataType : "text",
    			async : false,
    			data : 
    			{
    				seq_no : $(this).attr("id").replace("chk_", "")
    			},
    			error : function() 
    			{
    				console.log("AJAX ERROR");
    			},
    			success : function(data) 
    			{
    				if(Number(data) > 0)
    				{
    					isIn = true;
    				}
    			}
    		});
    	}
	});
	if(isIn)
	{
		alert("이 강의실을 사용하고있는 강좌가 있습니다.");
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "./delRoom",
			dataType : "text",
			async : false,
			data : 
			{
				chkList : chkList
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
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
}



function getList(paging_type) 
{
	getListStart();
	
	$.ajax({
		type : "POST", 
		url : "./getRoomList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),			
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
					inner += '<tr id="roomList_'+i+'">';
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="chk_'+result.list[i].SEQ_NO+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].SEQ_NO+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].GOSTORE)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lect/room_view?seq='+result.list[i].SEQ_NO+'\'" style="cursor:pointer;">'+nullChk(result.list[i].ROOM_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CONTENTS)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].LOCATION)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CAPACITY_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].AREA_SIZE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].USAGE)+'</td>';
					inner += '	<td class="plan-onof">';
					if (result.list[i].DELETE_YN=='Y') {
						inner += '<a onclick="javascript:changeStatus(\''+result.list[i].SEQ_NO+'\')" id="delete_yn_'+result.list[i].SEQ_NO+'" name="delete_yn" class="btn04 bor-btn btn-inline">N</a>';						
						inner += '<input type="hidden" id="delete_yn_'+result.list[i].SEQ_NO+'_status" name="delete_yn_status" value="N">';
					}else{
						inner += '<a onclick="javascript:changeStatus(\''+result.list[i].SEQ_NO+'\')" id="delete_yn_'+result.list[i].SEQ_NO+'" name="delete_yn" class="btn03 bor-btn btn-inline">Y</a>';						
						inner += '<input type="hidden" id="delete_yn_'+result.list[i].SEQ_NO+'_status" name="delete_yn_status" value="Y">';
					
					}
					inner += '	</td>';
					inner += '	<td class="plan-save"><a class="btn s-btn btn03" onclick="javascript:editRoom(\''+escape(JSON.stringify(result.list[i]))+'\', '+i+');">수정</a></td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="9"><div class="no-data">검색결과가 없습니다.</div></td>';
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
var tmphtml = "";
function editRoom(ret, idx)
{
	if(!document.getElementById("store"))
	{
		tmphtml = $("#roomList_"+idx).html();
		var result = JSON.parse(unescape(ret));
		var inner = "";
		inner += '<td></td>';
		inner += '<td>';
		inner += 	result.GOSTORE;
		inner += 	'<input type="hidden" id="store" name="store" value="'+result.STORE+'">';
		inner += '</td>';
		inner += '	<td><input type="text" id="room_nm" name="room_nm" placeholder="강의실 명" class="notEmpty" data-name="강의실명"/></td>';
		inner += '	<td><input type="text" id="contents" name="contents" placeholder="설명을 입력하세요." class="notEmpty" data-name="설명"/></td>';
		inner += '	<td><input type="text" id="location" name="location" placeholder="위치" class="notEmpty" data-name="위치"/></td>';
		inner += '	<td><input type="text" id="capacity_no" name="capacity_no" placeholder="인원" class="notEmpty" data-name="인원"/></td>';
		inner += '	<td><input type="text" id="area_size" name="area_size" placeholder="평수" class="notEmpty" data-name="평수"/></td>';
		inner += '	<td><input type="text" id="usage" name="usage" placeholder="용도" class="notEmpty" data-name="용도"/></td>';
		inner += '	<td class="plan-onof">';
		if (result.DELETE_YN=='Y') {
			inner += '<a onclick="javascript:changeStatus(\''+result.SEQ_NO+'\')" id="delete_yn_'+result.SEQ_NO+'" name="delete_yn" class="btn04 bor-btn btn-inline">N</a>';						
			inner += '<input type="hidden" id="delete_yn_'+result.SEQ_NO+'_status" name="delete_yn_status" value="N">';
		}else{
			inner += '<a onclick="javascript:changeStatus(\''+result.SEQ_NO+'\')" id="delete_yn_'+result.SEQ_NO+'" name="delete_yn" class="btn03 bor-btn btn-inline">Y</a>';						
			inner += '<input type="hidden" id="delete_yn_'+result.SEQ_NO+'_status" name="delete_yn_status" value="Y">';
		
		}
		inner += '	</td>';
		inner += '	<td class="plan-save">';
		inner += '		<a class="btn s-btn btn03" onclick="javascript:fncSubmit('+result.SEQ_NO+');">저장</a>';
		inner += '		<a class="btn s-btn btn02" onclick="javascript:editCancle('+idx+');">취소</a>';
		inner += '	</td>';
		$("#roomList_"+idx).html(inner);
		
		$("#store").val(result.STORE);
		$(".store").html(result.GOSTORE);
		$("#room_nm").val(result.ROOM_NM);
		$("#contents").val(result.CONTENTS);
		$("#location").val(result.LOCATION);
		$("#capacity_no").val(result.CAPACITY_NO);
		$("#area_size").val(result.AREA_SIZE);
		$("#usage").val(result.USAGE);
	}
}
function editCancle(idx)
{
	console.log(tmphtml);
	$("#roomList_"+idx).html(tmphtml);
}


function changeStatus(seq)
{
	if($("#delete_yn_"+seq).hasClass("btn03"))
	{
		$("#delete_yn_"+seq).removeClass("btn03");
		$("#delete_yn_"+seq).removeClass("btn03");
		$("#delete_yn_"+seq).addClass("btn04");
		$("#delete_yn_"+seq).html("N");
		$("#delete_yn_"+seq+"_status").val("N");
	}
	else if($("#delete_yn_"+seq).hasClass("btn04"))
	{
		$("#delete_yn_"+seq).removeClass("btn04");
		$("#delete_yn_"+seq).addClass("btn03");
		$("#delete_yn_"+seq).html("Y");
		$("#delete_yn_"+seq+"_status").val("Y");
	}
	
	if(seq != "new")
	{
		$.ajax({
			type : "POST", 
			url : "./changeDelete",
			dataType : "text",
			data : 
			{
				seq : seq,
				delete_yn : $("#delete_yn_"+seq+"_status").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				if(result.isSuc == "success")
	    		{
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}
function addRoom()
{
	if($("#selBranch").val() == '')
	{
		alert("지점을 선택해주세요.");
		return;
	}
	if(!document.getElementById("store"))
	{
		var inner = "";
		inner += '<tr class="add-row" id="new_tr">';
		inner += '<td></td>';
		inner += '<td>';
		inner += 	$(".selBranch").html();
		inner += 	'<input type="hidden" id="store" name="store" value="'+$("#selBranch").val()+'">';
		inner += '</td>';
		inner += '	<td><input type="text" id="room_nm" name="room_nm" placeholder="강의실 명" class="notEmpty" data-name="강의실명"/></td>';
		inner += '	<td><input type="text" id="contents" name="contents" placeholder="설명을 입력하세요." class="notEmpty" data-name="설명"/></td>';
		inner += '	<td><input type="text" id="location" name="location" placeholder="위치" class="notEmpty" data-name="위치"/></td>';
		inner += '	<td><input type="text" id="capacity_no" name="capacity_no" placeholder="인원" class="notEmpty" data-name="인원"/></td>';
		inner += '	<td><input type="text" id="area_size" name="area_size" placeholder="평수" class="notEmpty" data-name="평수"/></td>';
		inner += '	<td><input type="text" id="usage" name="usage" placeholder="용도" class="notEmpty" data-name="용도"/></td>';
		inner += '	<td class="plan-onof">';
		inner += '		<a onclick="javascript:changeStatus(\'new\')" id="delete_yn_new" name="delete_yn_new" class="btn04 bor-btn btn-inline">N</a>';
		inner += '		<input type="hidden" id="delete_yn_new_status" name="delete_yn_new_status" value="N">';
		inner += '	</td>';
		inner += '	<td class="plan-save">';
		inner += '		<a class="btn s-btn btn03" onclick="javascript:fncSubmit(\'new\');">저장</a>';
		inner += '		<a class="btn s-btn btn03" onclick="javascript:newCancle();">취소</a>';
		inner += '	</td>';
		inner += '</tr>';
		
		$("#list_target").prepend(inner);
	}
}
function newCancle()
{
	$("#new_tr").remove();
}
	
function fncSubmit(act)
{
	$("#seq").val(act); //새로 등록인경우 new 이고 수정인경우 seq 번호가 넘어온다.
	var validationFlag = "Y";
	$(".notEmpty").each(function() 
	{
		if ($(this).val() == "") 
		{
			alert(this.dataset.name+"을(를) 입력해주세요.");
			$(this).focus();
			validationFlag = "N";
			return false;
		}
	});
	if(validationFlag == "Y")
	{
		if(isNaN($("#capacity_no").val()) || $("#capacity_no").val().indexOf(".") > -1)
		{
			alert("최대 수용인원은 정수만 입력해주세요.");
			validationFlag = "N";
			return false;
		}
	}
	if(validationFlag == "Y")
	{
		if(isNaN($("#area_size").val()))
		{
			alert("평수는 숫자만 입력해주세요.");
			validationFlag = "N";
			return false;
		}
	}
	if(validationFlag == "Y")
	{
		$("#roomForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
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
</script>

<div class="sub-tit">
	<h2>강의실 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<a class="btn btn01 btn-inline btn01_1" onclick="javascript:addRoom()">강의실 신규등록</a>
	</div>
</div>

	<div class="table-top table-top02">
		<div class="top-row sear-wr">
			<div class="mag-r4">
				<div class="table table-auto">
					<div class="sear-tit sear-tit-50">지점</div>
					<div>
						<c:if test="${isBonbu eq 'T'}">
							<select de-data="전체" id="selBranch" name="selBranch" onchange="changeStore()">
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
			<div class="wid-2">
				<div class="table table-input">
					<div class="sear-tit sear-tit-70">사용구분</div>
					<div>
						<select id="del_yn" de-data="선택">
							<option value="">전체</option>
							<option value="N">Y</option>
							<option value="Y">N</option>
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
			
			<div class="table table02 table-auto float-right">
				<div>
					<a class="bor-btn btn03 btn-mar6" onclick="javascript:delRoom();">삭제</a>
				</div>
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

<div class="table-wr room-list">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col width="200px">
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
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_store')">지점<img src="/img/th_up.png" id="sort_store"></th>
					<th onclick="reSortAjax('sort_room_nm')">강의실 명 <img src="/img/th_up.png" id="sort_room_nm"></th>
					<th onclick="reSortAjax('sort_contents')">강의실 설명<img src="/img/th_up.png" id="sort_contents"></th>
					<th onclick="reSortAjax('sort_location')">위치<img src="/img/th_up.png" id="sort_location"></th>
					<th onclick="reSortAjax('sort_capacity_no')">최대 수용인원<img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_area_size')">평수 <img src="/img/th_up.png" id="sort_area_size"></th>
					<th onclick="reSortAjax('sort_usage')">용도<img src="/img/th_up.png" id="sort_usage"></th>
					<th onclick="reSortAjax('sort_delete_yn')">사용여부<img src="/img/th_up.png" id="sort_delete_yn"></th>
					<th></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-list_plan">
		<form id="roomForm" name="roomForm" method="POST" action="./room_proc">
			<table>
				<colgroup>
					<col width="60px">
					<col width="60px">
					<col>
					<col width="200px">
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
							<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
						</th>
						<th onclick="reSortAjax('sort_store')">지점<img src="/img/th_up.png" id="sort_store"></th>
						<th onclick="reSortAjax('sort_room_nm')">강의실 명 <img src="/img/th_up.png" id="sort_room_nm"></th>
						<th onclick="reSortAjax('sort_contents')">강의실 설명<img src="/img/th_up.png" id="sort_contents"></th>
						<th onclick="reSortAjax('sort_location')">위치<img src="/img/th_up.png" id="sort_location"></th>
						<th onclick="reSortAjax('sort_capacity_no')">최대 수용인원<img src="/img/th_up.png" id="sort_capacity_no"></th>
						<th onclick="reSortAjax('sort_area_size')">평수 <img src="/img/th_up.png" id="sort_area_size"></th>
						<th onclick="reSortAjax('sort_usage')">용도<img src="/img/th_up.png" id="sort_usage"></th>
						<th onclick="reSortAjax('sort_delete_yn')">사용여부<img src="/img/th_up.png" id="sort_delete_yn"></th>
						<th></th>
					</tr>
				</thead>
				<tbody id="list_target">
				  
				
				
				
	<!-- 				<tr class="add-row"> -->
	<!-- 					<td class="td-chk"> -->
	<!-- 					</td> -->
	<!-- 					<td><input type="text" id="" name="" placeholder="지점" /></td> -->
	<!-- 					<td><input type="text" id="" name="" placeholder="강의실 명" /></td> -->
	<!-- 					<td><input type="text" id="" name="" placeholder="설명을 입력하세요." /></td> -->
	<!-- 					<td><input type="text" id="" name="" placeholder="위치" /></td> -->
	<!-- 					<td><input type="text" id="" name="" placeholder="인원" /></td> -->
	<!-- 					<td><input type="text" id="" name="" placeholder="평수" /></td> -->
	<!-- 					<td><input type="text" id="" name="" placeholder="용도" /></td> -->
	<!-- 					<td class="plan-onof"> -->
	<!-- 						<a onclick="javascript:changeStatus('tech', 1)" id="tech_1" name="tech_1" class="btn04 bor-btn btn-inline">N</a> -->
	<!-- 						<input type="hidden" id="tech_1_status" name="tech_1_status" value="N"> -->
	<!-- 					</td> -->
	<!-- 					<td class="plan-save"><a class="btn s-btn btn03">저장</a></td> -->
	<!-- 				</tr> -->
	<!-- 				<tr> -->
	<!-- 					<td class="td-chk"> -->
	<!-- 					</td> -->
	<!-- 					<td>분당점</td> -->
	<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lect/room_new'" style="cursor:pointer;">10강의실</td> -->
	<!-- 					<td>커뮤니케이션 룸</td> -->
	<!-- 					<td>7층 11호</td> -->
	<!-- 					<td>100</td> -->
	<!-- 					<td>50</td> -->
	<!-- 					<td>컨퍼런스, 대규모 특강 등</td> -->
	<!-- 					<td class="plan-onof"> -->
	<!-- 						<a onclick="javascript:changeStatus('tech', 1)" id="tech_1" name="tech_1" class="btn03 bor-btn btn-inline">Y</a> -->
	<!-- 						<input type="hidden" id="tech_1_status" name="tech_1_status" value="Y"> -->
	<!-- 					</td> -->
	<!-- 					<td></td> -->
	<!-- 				</tr> -->
				</tbody>
			</table>
			<input type="hidden" id="seq" name="seq">
		</form>
	</div>
</div>


<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>