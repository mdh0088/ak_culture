<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>
$(document).ready(function(){
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
})
function chkAll()
{
	$("input:checkbox[name='chk_val']").prop("checked", true);
}
function changeAction(val)
{
	var chkList = "";
	var selAction = $("#selAction").val();
	if(val == "del")
	{
		selAction = "del";
	}
	var chkArr = document.getElementsByName("chk_val");
	for(var i = 0; i < chkArr.length; i++)
	{
		if(chkArr[i].checked == true)
		{
			chkList += chkArr[i].id+"|";
		}
	}
	if(chkList == "")
	{
		alert("선택된 중분류가 없습니다.");
		return;
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "./sectAction",
			dataType : "text",
			async : false,
			data : 
			{
				selBranch : $("#selBranch").val(),
				chkList : chkList,
				selAction : selAction
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
	    			sel1dep(main_cd);
// 	    			location.reload();
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});	
	}
}
function selStore()
{
	$(".main_body").children("tr").removeClass("active");
	$(".sect_table").hide();
}
function addCode()
{
	$('#write_layer').fadeIn(200);	
}

function changeStatus_perfor(idx)
{
	if($("#performance"+idx).hasClass("btn03"))
	{
		$("#performance"+idx).removeClass("btn03");
		$("#performance"+idx).removeClass("btn03");
		$("#performance"+idx).addClass("btn04");
		$("#performance"+idx).html("OFF");
		$("#performance"+idx+"_status").val("OFF");
	}
	else if($("#performance"+idx).hasClass("btn04"))
	{
		$("#performance"+idx).removeClass("btn04");
		$("#performance"+idx).addClass("btn03");
		$("#performance"+idx).html("ON");
		$("#performance"+idx+"_status").val("ON");
	}
}
function addMain()
{
	if(!document.getElementById("insShortName"))
	{
		var inner = "";
		inner += '<tr class="add-row" >';
		inner += '	<td></td>';
		inner += '	<td><input type="text" id="insShortName" name="insShortName" placeholder="대분류명" class="notEmpty" data-name="대분류명"></td>';
		inner += '  <td><input type="text" id="insLongName" name="insLongName" placeholder="설명을 입력하세요." class="notEmpty" data-name="설명"></td>';
		inner += '  <td></td>';
		inner += '</tr>';
		
		$(".main_body").append(inner);
	}
}

var sect_cnt = 1;
function addSect()
{
	if($(".sect_table").css("display") != "none")
	{
		var inner = "";
		inner += '<tr class="add-row" id="sect_div'+sect_cnt+'">';
		inner += '	<td class="td-chk"></td>';
		inner += '	<td></td>';
		inner += '	<td><input type="text" id="insSectNm'+sect_cnt+'" name="insSectNm" placeholder="중분류명" class="notEmpty" data-name="중분류명"></td>';
		inner += '	<td><input type="text" id="insContents'+sect_cnt+'" name="insContents" placeholder="내용" class="notEmpty" data-name="내용"></td>';
		inner += '  <td class="plan-onof">실적포함';
		inner += '		<a onclick="javascript:changeStatus_perfor('+sect_cnt+')" id="performance'+sect_cnt+'" name="performance" class="btn03 bor-btn btn-inline">ON</a>';
		inner += '		<input type="hidden" id="performance'+sect_cnt+'_status" name="performance_status" value="ON">';
		inner += '	</td>';
		inner += '	<td onclick="delSect('+sect_cnt+')"><span class="del-btn"><i class="material-icons remove">remove_circle_outline</i></span></td>';
		inner += '</tr>';
		
		$(".sect_body").append(inner);
		
		sect_cnt ++;
	}
	else
	{
		alert("대분류를 먼저 선택해주세요.");
		return;
	}
		
}
function delSect(idx)
{
	$("#sect_div"+idx).remove();	
}
var main_cd = 0; 
function sel1dep(idx)
{
	$(".main_body").children("tr").removeClass("active");
	$("#tr_"+idx).addClass("active");
	main_cd = idx;
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		async : false,
		data : 
		{
			maincd : idx,
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
			var inner = "";
			for(var i = 0; i < result.length; i++)
			{
				inner += '<tr>';
				inner += '	<td class="td-chk"><input type="checkbox" id="chk_'+result[i].MAIN_CD+'_'+result[i].SECT_CD+'" name="chk_val" value=""><label for="chk_'+result[i].MAIN_CD+'_'+result[i].SECT_CD+'"></label></td>';
				inner += '	<td>'+result[i].SECT_CD+'</td>';
				inner += '	<td>'+result[i].SECT_NM+'</td>';
				inner += '	<td>'+result[i].CONTENTS+'</td>';
				if(result[i].PERFORMANCE != "OFF")
				{
					inner += '	<td>실적포함</td>';
				}
				else
				{
					inner += '	<td>실적제외</td>';
				}
				inner += '	<td></td>';
				inner += '</tr>';
			}
			$(".sect_body").html(inner);
			$(".sect_table").show();
		}
	});	
}
function delMain()
{
	if($(".sect_table").css("display") != "none")
	{
		$.ajax({
			type : "POST", 
			url : "/common/getSecCd",
			dataType : "text",
			async : false,
			data : 
			{
				maincd : main_cd,
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
				if(result.length > 0)
				{
					alert("중분류를 먼저 삭제해주세요.");
				}
				else
				{
					$.ajax({
						type : "POST", 
						url : "/common/delMainCd",
						dataType : "text",
						async : false,
						data : 
						{
							maincd : main_cd
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
		});	
	}
	else
	{
		alert("대분류를 먼저 선택해주세요.");
		return;
	}
	
}
function fncSubmit(idx)
{
	var validationFlag = "Y";
	$("#fncForm"+idx+" .notEmpty").each(function() 
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
		if(idx == 2)
		{
			var sl = "";
			$("[name='insSectNm']").each(function() 
			{
				if($(this).val() != "")
				{
					sl += $(this).val()+"|";
				}
			});
			
			var cl = "";
			$("[name='insContents']").each(function() 
			{
				if($(this).val() != "")
				{
					cl += $(this).val()+"|";
				}
			});
			var pl = "";
			$("[name='performance_status']").each(function() 
			{
				if($(this).val() != "")
				{
					pl += $(this).val()+"|";
				}
			});
			
			$("#sect_nm_list").val(sl);
			$("#sect_contents_list").val(cl);
			$("#sect_performance_list").val(pl);
			
			$("#fncForm"+idx).append("<input type='hidden' id='store' name='store'/>");
			$("#fncForm"+idx).append("<input type='hidden' id='main_cd' name='main_cd'/>");
			
			$("#store").val($("#selBranch").val());
			$("#main_cd").val(main_cd);
		}
		$("#fncForm"+idx).ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	    			sel1dep(main_cd);
	    			if(idx != 2)
	    			{
		    			location.reload();
	    			}
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}
function changeStatus(maincd)
{
	if($("#delete_yn_"+maincd).hasClass("btn03"))
	{
		$("#delete_yn_"+maincd).removeClass("btn03");
		$("#delete_yn_"+maincd).removeClass("btn03");
		$("#delete_yn_"+maincd).addClass("btn04");
		$("#delete_yn_"+maincd).html("N");
		$("#delete_yn_"+maincd+"_status").val("N");
	}
	else if($("#delete_yn_"+maincd).hasClass("btn04"))
	{
		$("#delete_yn_"+maincd).removeClass("btn04");
		$("#delete_yn_"+maincd).addClass("btn03");
		$("#delete_yn_"+maincd).html("Y");
		$("#delete_yn_"+maincd+"_status").val("Y");
	}
	
	$.ajax({
		type : "POST", 
		url : "./changeDelete_cate",
		dataType : "text",
		data : 
		{
			maincd : maincd,
			delete_yn : $("#delete_yn_"+maincd+"_status").val()
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
</script>

<div class="sub-tit">
	<h2>강좌분류관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>


<div class="row view-page cate-page">

	<div class="wid-5 cate-page1">
		<div style="margin-bottom:7px;">
			<c:if test="${isBonbu eq 'T'}">
				<select de-data="전체" id="selBranch" name="selBranch" onchange="selStore()">
						<option value="">전체</option>
					<c:forEach var="i" items="${branchList}" varStatus="loop">
						<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
					</c:forEach>
				</select>
			</c:if>
			<c:if test="${isBonbu eq 'F'}">
				<select de-data="${login_rep_store_nm}" id="selBranch" name="selBranch" onchange="selStore()">
					<c:forEach var="i" items="${branchList}" varStatus="loop">
						<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
					</c:forEach>
				</select>
			</c:if>
		</div>
		<div class="white-bg">
			<h3 class="h3-tit">대분류
				<div class="float-right">
					<a class="btn btn01 btn01_1" onclick="javascript:addMain();"><i class="material-icons">add</i>대분류 추가</a>
					<a class="btn btn01 btn01_1" onclick="javascript:delMain();"><i class="material-icons">remove</i>대분류 삭제</a>
				</div>
			</h3>			
			<div class="table-wr">
				<div class="table-list table-list02 table-left">
					<form id="fncForm1" name="fncForm1" method="POST" action="./cate_proc1">
						<table>
							<colgroup>
								<col width="70px" />
								<col width="25%" />
								<col />
								<col width="70px" />
								<col width="70px" />
							</colgroup>
							<tbody class="main_body">
								<c:forEach var="i" items="${depth1List}" varStatus="loop">
									<tr id="tr_${i.SUB_CODE}" class="cursor" onclick="sel1dep('${i.SUB_CODE}')">
										<td>${i.SUB_CODE}</td>
										<td>${i.SHORT_NAME}</td>
									   	<td>${i.LONG_NAME}</td>
									   	<td>
									   		<c:if test="${i.DELETE_YN eq 'Y'}">
									   			<a onclick="javascript:changeStatus(${i.SUB_CODE})" id="delete_yn_${i.SUB_CODE}" name="delete_yn" class="btn04 bor-btn btn-inline">N</a>
									   			<input type="hidden" id="delete_yn_${i.SUB_CODE}_status" name="delete_yn_status" value="N">
									   		</c:if>
									   		<c:if test="${i.DELETE_YN eq 'N'}">
									   			<a onclick="javascript:changeStatus(${i.SUB_CODE})" id="delete_yn_${i.SUB_CODE}" name="delete_yn" class="btn03 bor-btn btn-inline">Y</a>
									   			<input type="hidden" id="delete_yn_${i.SUB_CODE}_status" name="delete_yn_status" value="Y">
									   		</c:if>
									   	</td>
									   	<td><i class="material-icons">arrow_right</i></td>
									</tr>	
								</c:forEach>
	<!-- 							<tr class="add-row" > -->
	<!-- 								<td><input type="text" id="" name="" value="6" disabled ></td> -->
	<!-- 								<td><input type="text" id="" name="" placeholder="대분류명"></td> -->
	<!-- 							   	<td><input type="text" id="" name="" placeholder="설명을 입력하세요."></td> -->
	<!-- 							   	<td></td> -->
	<!-- 							</tr>	 -->
	<!-- 							<tr class="cursor active" onclick="javascript:getSub();"> -->
	<!-- 								<td>5</td> -->
	<!-- 								<td>성인</td> -->
	<!-- 							   	<td>15세 이상</td> -->
	<!-- 							   	<td><i class="material-icons">arrow_right</i></td> -->
	<!-- 							</tr>	 -->
	<!-- 							<tr class="cursor"> -->
	<!-- 								<td>4</td> -->
	<!-- 								<td>영유아</td> -->
	<!-- 							   	<td>5세 이하(2인 1팀)</td> -->
	<!-- 							   	<td><i class="material-icons">arrow_right</i></td> -->
	<!-- 							</tr>	 -->
	<!-- 							<tr class="cursor"> -->
	<!-- 								<td>3</td> -->
	<!-- 								<td>유아</td> -->
	<!-- 							   	<td>4세 ~ 7세</td> -->
	<!-- 							   	<td><i class="material-icons">arrow_right</i></td> -->
	<!-- 							</tr> -->
	<!-- 							<tr class="cursor"> -->
	<!-- 								<td>2</td> -->
	<!-- 								<td>어린이</td> -->
	<!-- 							   	<td>8세 ~ 14세</td> -->
	<!-- 							   	<td><i class="material-icons">arrow_right</i></td> -->
	<!-- 							</tr>	 -->
	<!-- 							<tr class="cursor"> -->
	<!-- 								<td>1</td> -->
	<!-- 								<td>All</td> -->
	<!-- 							   	<td>전 연령</td> -->
	<!-- 							   	<td><i class="material-icons">arrow_right</i></td> -->
	<!-- 							</tr>		 -->
							</tbody>
						</table>
					</form>
				</div>
				
			</div>
			
			<div class="btn-wr text-center">
				<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit(1);">대분류 저장</a>
			</div>
		</div>
	</div>
	<div class="wid-5">
		<div class="btn-right">
			<div class="table table-auto float-right table02" style="margin-bottom:7px;">
				<div>
					<p class="ip-ritit">선택한 항목을</p>
				</div>
				<div>
					<div>
						<select de-data="실적포함" id="selAction" name="selAction">
							<option value="ON">실적포함</option>
							<option value="OFF">실적제외</option>
						</select>
						<a class="bor-btn btn03 btn-mar6" onclick="javascript:changeAction();">반영</a>
						<a class="btn btn01 ok-btn" href="/lecture/lect/list">강좌리스트</a>
					</div>
				</div>
			</div>
			
		</div>
		<div class="white-bg table-view cate-page2" style="clear:both;">
			<h3 class="h3-tit">중분류
				<div class="float-right">
					<a class="btn btn01" onclick="javascript:chkAll();">전체선택</a>
					<a class="btn btn01 btn01_1" onclick="javascript:addSect();"><i class="material-icons">add</i>중분류 추가</a>
					<a class="btn btn01 btn01_1" onclick="javascript:changeAction('del');"><i class="material-icons">remove</i>중분류 삭제</a>
				</div>
			</h3>
			<div class="table-wr">
				<div class="table-list table-list02 table-left table-lasttd">
					<form id="fncForm2" name="fncForm2" method="POST" action="./cate_proc2">
						<table class="sect_table" style="display:none;">
							<colgroup>
								<col width="70px" />
								<col width="50px" />
								<col />
								<col />
								<col />
								<col width="50px" />
							</colgroup>
							<tbody class="sect_body">
<!-- 								<tr class="add-row">	 -->
<!-- 									<td class="td-chk"> -->
<%-- 										<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 									</td> -->
<!-- 									<td>16</td> -->
<!-- 									<td><input type="text" id="" name="" placeholder="중분류명"></td> -->
<!-- 								   	<td class="plan-onof">실적포함 -->
<!-- 										<a onclick="javascript:changeStatus('tech', 1)" id="tech_1" name="tech_1" class="btn04 bor-btn btn-inline">OFF</a> -->
<!-- 										<input type="hidden" id="tech_1_status" name="tech_1_status" value="ON"> -->
<!-- 									</td> -->
<!-- 								</tr> -->
	<!-- 							<tr class="active">	 -->
	<!-- 								<td class="td-chk"> -->
	<%-- 									<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }" checked><label for="idx${readCnt }"></label> --%>
	<!-- 								</td> -->
	<!-- 								<td>16</td> -->
	<!-- 								<td>피트니스/뷰티</td> -->
	<!-- 							   	<td>실적포함</td> -->
	<!-- 							</tr> -->
	<!-- 							<tr>	 -->
	<!-- 								<td class="td-chk"> -->
	<%-- 									<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
	<!-- 								</td> -->
	<!-- 								<td>16</td> -->
	<!-- 								<td>피트니스/뷰티</td> -->
	<!-- 							   	<td>실적포함</td> -->
	<!-- 							</tr> -->
	<!-- 							<tr>	 -->
	<!-- 								<td class="td-chk"> -->
	<%-- 									<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
	<!-- 								</td> -->
	<!-- 								<td>16</td> -->
	<!-- 								<td>피트니스/뷰티</td> -->
	<!-- 							   	<td>실적포함</td> -->
	<!-- 							</tr> -->
	<!-- 							<tr>	 -->
	<!-- 								<td class="td-chk"> -->
	<%-- 									<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
	<!-- 								</td> -->
	<!-- 								<td>16</td> -->
	<!-- 								<td>피트니스/뷰티</td> -->
	<!-- 							   	<td>실적포함</td> -->
	<!-- 							</tr> -->
							</tbody>
						</table>
						<input type="hidden" id="sect_nm_list" name="sect_nm_list">
						<input type="hidden" id="sect_contents_list" name="sect_contents_list">
						<input type="hidden" id="sect_performance_list" name="sect_performance_list">
					</form>
				</div>				
			</div>
			
			<div class="btn-wr text-center">
				<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit(2);">중분류 저장</a>
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
	        	<%-- /<c:import url="./write.jsp"/> --%>
        	</div>
        </div>
    </div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>