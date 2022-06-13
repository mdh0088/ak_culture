<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>
var order_by="";
var sort_type = "";


$(document).ready(function(){
	getMainCode();
})
var code_fg="";
function getSub(code)
{

	code_fg = code;
	$.ajax({
		type : "POST", 
		url : "./getSub",
		dataType : "text",
		data : 
		{
			code_fg : code
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
			
			inner += '<table><thead><tr>';
			inner += '<th>코드번호</th>';
			inner += '<th>코드명</th>';
			inner += '<th>코드내용</th>';
			inner += '<th></th>';
			inner += '</tr></thead><tbody>';
			
			for(var i = 0; i < result.length; i++)
			{
				if (result[i].DELETE_YN=='Y') {
				inner += '<tr class="bg-blue">';
					inner += '<td><input type="text" class=" sub_code sub_code_'+result[i].SUB_CODE+'" value="'+result[i].SUB_CODE+'" readonly="readonly"></td>';
					inner += '<td><input type="text" class=" sub_code sub_code_'+result[i].SUB_CODE+'_short" value="'+result[i].SHORT_NAME+'" readonly="readonly"></td>';
					inner += '<td><input type="text" class=" sub_code sub_code_'+result[i].SUB_CODE+'_long" value="'+result[i].LONG_NAME+'" readonly="readonly"></td>';
					inner += '<td><span class="btn btn03 btn-code" onclick="sub_edit(\'upt\',\''+result[i].SUB_CODE+'\');">삭제취소</span></td>';
				}else{
				inner += '<tr>';
					inner += '<td><input type="text" class=" sub_code_'+result[i].SUB_CODE+'" value="'+result[i].SUB_CODE+'"></td>';
					inner += '<td><input type="text" class=" sub_code_'+result[i].SUB_CODE+'_short" value="'+result[i].SHORT_NAME+'"></td>';
					inner += '<td><input type="text" class=" sub_code_'+result[i].SUB_CODE+'_long" value="'+result[i].LONG_NAME+'"></td>';
					inner += '<td><span class="sp-btn btn01" onclick="sub_edit(\'edit\',\''+result[i].SUB_CODE+'\');">저장</span><span class="sp-btn btn02" onclick="sub_edit(\'del\',\''+result[i].SUB_CODE+'\');">삭제</span></td>';					
				}
				inner += '</tr>';
				
			}
			inner += '</tr></tbody></table>';
			$(".subCode .table-list").html(inner);
			$(".subCode").show();
			
		}
	});
}
function addCode()
{
	$('#write_layer').fadeIn(200);	
}

function sub_edit(way,idx){
	var sub_code="";
	var short_name="";
	var long_name="";
	var chk_flag=0;
	if (way=="edit") {
		
		$('.sub_code').each(function(){ 
			if ($(this).val()==$('.sub_code_'+idx).val()) {
				alert('중복 값이 있습니다.');
				chk_flag=1;
				return;
			}
		})
		if (chk_flag==1) {
			return;
		}
		
		var confirmflag = confirm("정말 저장하시겠습니까?");
		if (confirmflag) {
			sub_code=$('.sub_code_'+idx).val();
			short_name = $('.sub_code_'+idx+'_short').val();
			long_name = $('.sub_code_'+idx+'_long').val();
			
		}else{
			return;
		}
		
	}
	
	$.ajax({
		type : "POST", 
		url : "./sub_edit",
		dataType : "text",
		data : 
		{
			code_fg : code_fg,
			way : way,
			sub_code : idx,
			short_name:short_name,
			long_name:long_name,
			edit_sub_code : sub_code
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			getSub(code_fg);
		}
	});
}



function getMainCode(){

	$.ajax({
		type : "POST", 
		url : "./getMainCd",
		dataType : "text",
		async : false,
		data : 
		{
			order_by : order_by,
			sort_type : sort_type
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			console.log(data);
			$('#main_code_area').empty();
			var result = JSON.parse(data);
			var inner ="";
			for (var i = 0; i < result.list.length; i++) {
				inner +='<tr class="cursor" onclick="javascript:getSub(\''+result.list[i].SUB_CODE+'\');">';
				inner +='	<td>'+result.list[i].SUB_CODE+'</td>';
				inner +='	<td>'+result.list[i].SHORT_NAME+'</td>';
				inner +='	<td class="code-name">'+result.list[i].LONG_NAME+'</td>';
				inner +='</tr>';
				
				/*
				inner +='<a onclick="javascript:getSub(\''+result.list[i].SUB_CODE+'\');">';
				inner +='	<tr>';
				inner +='		<td class="code_num">'+result.list[i].SUB_CODE+'</td>';
				inner +='		<td>'+result.list[i].SHORT_NAME+'</td>';
				inner +='		<td class="code-name">'+result.list[i].LONG_NAME+'</td>';
				inner +='		<td>';
				inner +='			<span> class="sp-btn btn01" onclick="sub_edit(\'edit\',\''+result.list[i].SUB_CODE+'\');">저장</span>';
				inner +='			<span> class="sp-btn btn02" onclick="sub_edit(\'del\',\''+result.list[i].SUB_CODE+'\');">삭제</span>';
				inner +='		</td>';
				inner +='	</tr>';
				inner +='</a>';
				*/
				
			}
			$('#main_code_area').append(inner);
			//alert('저장 되었습니다.');
			//location.reload();
			order_by = result.order_by;
			sort_type = result.sort_type;
		}
		
	});	
}

function reSortAjax_custInfo(act)
{
	sort_type = act.replace("sort_", "");
	console.log(sort_type);
	console.log(order_by);
	if(order_by == "")
	{
		order_by = "desc";
		$("#"+act).attr("src", "/img/th_down.png");
	}
	else if(order_by == "desc")
	{
		order_by = "asc";
		$("#"+act).attr("src", "/img/th_up.png");
	}
	else if(order_by == "asc")
	{
		order_by = "desc";
		$("#"+act).attr("src", "/img/th_down.png");
	}
	
	getMainCode();

}

</script>


<div class="sub-tit">
	<h2>코드관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<div class="table float-right table02">
<!-- 			<div>
				<div class="subCode">
					<p class="ip-ritit">선택한 항목을</p>
				</div>
			</div>
			<div>
				<div class="subCode">
					<select de-data="삭제">
						<option>삭제</option>
						<option>수정</option>
					</select>
					
				</div>
			</div> -->
			<div>
				<A class="btn btn01 btn01_1 mrg-l6" onclick="javascript:addCode()"><i class="material-icons">add</i>코드추가</A>
			</div>
		</div>
		
	</div>

</div>

<div class="row view-page">
	<div class="wid-5">
		<div class="white-bg">
			<h3 class="h3-tit">구분코드</h3>
			<div class="table-wr">
				<div class="table-list table-list02">
					<table>
						<thead>
							<tr>
								<th onclick="reSortAjax_custInfo('sort_sub_code')">코드번호<img src="/img/th_up.png" id="sort_sub_code"></th>
								<th onclick="reSortAjax_custInfo('sort_short_name')">코드명<img src="/img/th_up.png" id="sort_short_name"></th>
								<th onclick="reSortAjax_custInfo('sort_long_name')">코드내용<img src="/img/th_up.png" id="sort_long_name"></th>
							</tr>
						</thead>
						<tbody id="main_code_area">
						<!--  
							<c:forEach var="i" items="${list}" varStatus="loop">
								<tr class="cursor" onclick="javascript:getSub('${i.SUB_CODE}');">
									<td>${i.SUB_CODE}</td>
								   	<td>${i.SHORT_NAME}</td>
								   	<td class="code-name">${i.LONG_NAME}</td>
								</tr>								
							</c:forEach>
						-->
						</tbody>
					</table>
				</div>
				
			</div>
		</div>
	</div>
	<div class="wid-5">
		<div class="white-bg table-view subCode code-table">
			<h3 class="h3-tit">세부코드</h3>
			<div class="table-wr">
				<div class="table-list table-list02">
					<table>
						<thead>
							<tr>
								<th>코드번호<i class="material-icons">import_export</i></th>
								<th>코드명<i class="material-icons">import_export</i></th>
								<th>코드내용<i class="material-icons">import_export</i></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
						<!--  
							<c:forEach var="i" items="${list}" varStatus="loop">
								<a onclick="javascript:getSub('${i.SUB_CODE}');">
									<tr>	
										<td class='code_num' >${i.SUB_CODE}</td>
									   	<td>${i.SHORT_NAME}</td>
									   	<td class="code-name">${i.LONG_NAME}</td>
									   	<td>
									   		<span class="sp-btn btn01" onclick="sub_edit('edit','${i.SUB_CODE}');">저장</span>
									   		<span class="sp-btn btn02" onclick="sub_edit('del','${i.SUB_CODE}');">삭제</span>
									   	</td>
									</tr>
								</a>
							</c:forEach>
						-->
						</tbody>
					</table>
				</div>				
			</div>
		</div>
	</div>
</div>



<div class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit">
        		<div class="close" onclick="javascript:$('.list-edit-wrap').fadeOut(200);"></div>
        	</div>
        </div>
    </div>	
</div>

<div id="write_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<c:import url="./write.jsp"/>
        	</div>
        </div>
    </div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>