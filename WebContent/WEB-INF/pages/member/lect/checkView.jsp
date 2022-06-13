<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="/inc/js/checkCardx.js"></script>
<OBJECT id="cardX" style="display:none;" classid="clsid:93137A73-7A61-4911-8018-C758BBE73F53"></OBJECT>
<script>
$(document).ready(function(){
	
	var re_store = '${store}';
	var re_pos = '${pos}';
	var re_store_name = '${store_name}';
	var re_sale_ymd = '${sale_ymd}';
	
	if(re_store != '' && re_pos != '' && re_store_name != '')
	{
		$("#selBranch").val(re_store);
		$(".selBranch").html(re_store_name);
		selStore();
		$("#selPos").val(re_pos);
		$(".selPos").html(re_pos);
		$("#sale_ymd").val(cutDate(re_sale_ymd));
	}
	else
	{
		setPeri();
		selStore();
	}
	
});
function selStore()
{
	var store = $("#selBranch").val();
	
	$.ajax({
		type : "POST", 
		url : "/common/getPosList",
		dataType : "text",
		async : false,
		data : 
		{
			store : store
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$("#selPos").html("");
			$(".selPos_ul").html("");
			if(result.length > 0)
			{
				for(var i = 0; i < result.length; i++)
				{
					$("#selPos").append('<option value="'+result[i].POS_NO+'">'+result[i].POS_NO+'</option>');
					$(".selPos_ul").append('<li>'+result[i].POS_NO+'</li>');
				}
				$(".selPos").html(result[0].POS_NO);
				$("#selPos").val(result[0].POS_NO);
			}
			else
			{
				$(".selPos").html("검색된 POS 번호가 없습니다.");
			}
			
		}
	});
}
function getProcList()
{
	var store = $("#selBranch").val();
	var pos = $("#selPos").val();
	var sale_ymd = $("#sale_ymd").val().replace(/-/gi, "");
	location.href="checkView?store="+store+"&pos="+pos+"&sale_ymd="+sale_ymd;
}
function fncSubmit(act)
{
	$("#act").val(act);
	$("#fncForm").ajaxSubmit({
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
</script>

<div class="sub-tit">
	<h2>무결성 검증내역</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
<!-- 	<div class="btn-right"> -->
<!-- 		<a class="btn btn01 btn01_1">작업 현황 </a> -->
<!-- 	</div> -->
</div>


<form id="fncForm" name="fncForm" method="POST" action="./check_proc">
	<div class="table-top first">
		<div class="top-row">
			<div class="wid-35">
				<div class="table">
					<div>
						<ul class="chk-ul">
							<li>
								<input type="radio" id="selectFlag1" name="selectFlag" value="1" checked>
								<label for="selectFlag1">국민</label>
							</li>
							<li>
								<input type="radio" id="selectFlag2" name="selectFlag" value="2" checked>
								<label for="selectFlag2">비씨</label>
							</li>
							<li>
								<input type="radio" id="selectFlag3" name="selectFlag" value="3" checked>
								<label for="selectFlag3">신한</label>
							</li>
						</ul>
					</div>
					<div>
						&nbsp;&nbsp;&nbsp;<input class="btn btn02" type="button" value="검증" onclick="javascript:goAction();">
					</div>
				</div>
			</div>
			<div class="wid-25 ">
				<div class="table table02 table-input wid-contop">
					<div>
						<select id="hq" name="hq" de-data="[00] 애경유통">
							<option value="00">[00] 애경유통</option>
						</select>
					</div>
					<div>
						<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch" onchange="selStore()">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			
			<div class="wid-15 mag-lr2">
				<div class="table ">
					<div class="sear-tit " style="width:70px;">매출일자</div>
					<div>
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" class="date-i" id="sale_ymd" name="sale_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>			
			</div>
			
			
			<div class="wid-2">
				<div class="table">
					<div class="sear-tit sear-tit-70">POS NO</div>
					<div>
						<select id="selPos" name="selPos">
						</select>
					</div>
				</div>
			</div>
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getProcList();">
	</div>
</form>


<div class="table-wr ip-list" style="margin-top:50px;">	
	<div class="table-list">
		<table>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th>검증일자 <i class="material-icons">import_export</i></th>
					<th>검증시간 <i class="material-icons">import_export</i></th>
					<th>POS번호<i class="material-icons">import_export</i></th>
					<th>H/W식별번호 <i class="material-icons">import_export</i></th>
					<th>S/W식별번호<i class="material-icons">import_export</i></th>
					<th>결과<i class="material-icons">import_export</i></th>
					<th>성공여부 <i class="material-icons">import_export</i></th>
					<th>등록자<i class="material-icons">import_export</i></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" items="${list}" varStatus="loop">
					<tr>					
						<td>${loop.index+1}</td>
						<td>${i.SYSTEM_YMD}</td>
						<td>${i.SYSTEM_TIME }</td>
						<td>${i.POS_NO }</td>
						<td>${i.HW_SERIAL }</td>
						<td>${i.SW_SERIAL }</td>
						<td>${i.RETURN }</td>
						<td>${i.SUCC_YN }</td>
						<td>${i.NAME }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>




<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>