<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    //치환 변수 선언
    pageContext.setAttribute("crcn", "\r\n"); 
    pageContext.setAttribute("br", "<br>"); 
%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
$(document).ready(function() {
	if(Number('${list_size}') > 0)
	{
// 		if(nullChk('${list[0].IMAGE_PIC}') != "")
// 		{
// 			$(".upload-name").val('${list[0].IMAGE_PIC}');
// 		}
		$(".upload-name").val('${data.THUMBNAIL_IMG}');
		$(".upload-name").attr('onclick', 'javascript:window.open("/upload/wlect/${data.THUMBNAIL_IMG}");');
		$(".upload-name02").val('${data.DETAIL_IMG }');
		$(".upload-name02").attr('onclick', 'javascript:window.open("/upload/wlect/${data.DETAIL_IMG}");');
		var etc_arr = '${list[0].ETC}'.split("|");
		
		for(var i = 0; i < etc_arr.length-1; i++)
		{
			var lect_cnt = etc_arr[i].split('회차 : ')[0];
			var lect_contents = etc_arr[i].split('회차 : ')[1];
			add_contents_init(lect_cnt);
			$("#lect_cnt"+lect_cnt).val(lect_cnt);
			$("#lect_contents"+lect_cnt).val(repWord(lect_contents));
		}
	}
	if($("#lecturer_nm").val() == "")
	{
		$("#lecturer_nm").val('${data.WEB_LECTURER_NM}');
	}
	changeStatus();
	$("#description").val(repWord('${data.DESCRIPTION}'));
	
	document.getElementById("lecturer_career").value = repWord(document.getElementById("lecturer_career").value);
	document.getElementById("lecture_content").value = repWord(document.getElementById("lecture_content").value);
});
function changeStatus()
{
	if($("#isChange").hasClass("btn03"))
	{
		$("#isChange").removeClass("btn03");
		$("#isChange").addClass("btn04");
		$("#isChange").html("OFF");
		
		$("#lecturer_nm").addClass("inputDisabled"); $("#lecturer_nm").attr("readOnly", true);
		$("#lecturer_career").addClass("inputDisabled"); $("#lecturer_career").attr("readOnly", true);
		$("#lecture_content").addClass("inputDisabled"); $("#lecture_content").attr("readOnly", true);
		
		$("input[name=lect_cnt]").addClass("inputDisabled"); $("input[name=lect_cnt]").attr("readOnly", true);
		$("input[name=lect_contents]").addClass("inputDisabled"); $("input[name=lect_contents]").attr("readOnly", true);
	}
	else if($("#isChange").hasClass("btn04"))
	{
		$("#isChange").removeClass("btn04");
		$("#isChange").addClass("btn03");
		$("#isChange").html("ON");
		
		$("#lecturer_nm").removeClass("inputDisabled"); $("#lecturer_nm").attr("readOnly", false);
		$("#lecturer_career").removeClass("inputDisabled"); $("#lecturer_career").attr("readOnly", false);
		$("#lecture_content").removeClass("inputDisabled"); $("#lecture_content").attr("readOnly", false);
		
		$("input[name=lect_cnt]").removeClass("inputDisabled"); $("input[name=lect_cnt]").attr("readOnly", false);
		$("input[name=lect_contents]").removeClass("inputDisabled"); $("input[name=lect_contents]").attr("readOnly", false);
	}
}
var lect_cnt = Number('${data.LECT_CNT}')
function add_contents()
{
	if($("#isChange").hasClass("btn03"))
	{
		var empty_cnt = 0;
		for(var i = 1; i <= lect_cnt; i++)
		{
			if(!document.getElementById("contents_tr_"+i))
			{
				empty_cnt = i;
				break;
			}
		}
		if(document.getElementsByName("lect_cnt").length < Number('${data.LECT_CNT}'))
		{
			var inner = "";
			inner += '<tr class="add-row" id="contents_tr_'+empty_cnt+'">';
			inner += '	<td><input type="number" id="lect_cnt'+empty_cnt+'" name="lect_cnt" value="'+empty_cnt+'" style="width: 60px;" class="notEmpty" data-name="회차">회차</td>';
			inner += '	<td><input type="text" id="lect_contents'+empty_cnt+'" name="lect_contents" placeholder="내용을 작성해주세요." class="notEmpty" data-name="내용"></td>';
			inner += '	<td class="tog-tit"><div><i class="material-icons remove" onclick="remove_contents('+empty_cnt+')">remove_circle_outline</i></div></td>';
			inner += '</tr>';
			$("#target_contents").append(inner);
		}
		else
		{
			alert("강좌횟수를 초과하였습니다.");
		}
	}
}
function add_contents_init(val)
{
	var inner = "";
	inner += '<tr id="contents_tr_'+val+'">';
	inner += '	<td><input type="number" id="lect_cnt'+val+'" name="lect_cnt" value="0" style="width: 60px;" class="notEmpty inputDisabled" data-name="회차" readOnly>회차</td>';
	inner += '	<td><input type="text" id="lect_contents'+val+'" name="lect_contents" placeholder="내용을 작성해주세요." style="width: 100%;" class="notEmpty inputDisabled" data-name="내용" readOnly></td>';
	inner += '	<td class="tog-tit"><div><i class="material-icons remove" onclick="remove_contents('+val+')">remove_circle_outline</i></div></td>';
	inner += '</tr>';
	$("#target_contents").append(inner);
}
function remove_contents(idx)
{
	if($("#isChange").hasClass("btn03"))
	{
		$("#contents_tr_"+idx).remove();
	}
}
function fncSubmit()
{
	if($("#isChange").hasClass("btn03"))
	{
		var validationFlag = "Y";
		$(".notEmpty").each(function() 
		{
			if ($(this).val() == "" || $(this).val() == "0") 
			{
				alert(this.dataset.name+"을(를) 입력해주세요.");
				$(this).focus();
				validationFlag = "N";
				return false;
			}
		});
		if(validationFlag == "Y")
		{
			var lect_cnt_list = "";
			$("[name='lect_cnt']").each(function() 
			{
				lect_cnt_list += $(this).val()+"|";
			});
			$("#lect_cnt_list").val(lect_cnt_list);
			
			
			var lect_contents_list = "";
			$("[name='lect_contents']").each(function() 
			{
				lect_contents_list += $(this).val()+"|";
			});
			$("#lect_contents_list").val(lect_contents_list);
			
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
	}
}

$(window).ready(function(){
	$("#thumbnail").on('change',function(){
		  var thumbnailName = $("#thumbnail").val();
		  $(".upload-name").val(thumbnailName);
		});
		$("#detail").on('change',function(){
		  var detailName = $("#detail").val();
		  $(".upload-name02").val(detailName);
		});
})
function getPrevPlan()
{
	$.ajax({
		type : "POST", 
		url : "./getPrevPlan",
		dataType : "text",
		data : 
		{
			store : $("#store").val(),
			period : $("#period").val(),
			subject_cd : $("#subject_cd").val()
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
</script>
<div class="sub-tit">
	<h2>강의계획서</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<div class="btn-inline plan-onof">
			<span>수정모드</span>
			<a onclick="javascript:changeStatus('')" id="isChange" class="btn04 bor-btn btn-inline">OFF</a>
		</div>
		<a class="btn btn01 btn-inline" onclick="javascript:getPrevPlan()">전기 강의계획서 불러오기</a>
	</div>
</div>

<div class="lect-top table-top first wid-10">
<p class="lect-st">${data.MAIN_NM}<i class="material-icons">keyboard_arrow_right</i><span class="color-pink">${data.SECT_NM}</span></p>
	<div class="table table-auto">
		<div class="lect-titwr">
			<p class="lect-tit">${data.SUBJECT_NM}(${data.SUBJECT_CD})</p>
			<p class="lect-tit2">${data.WEB_LECTURER_NM} 강사</p>
			<p class="btn btn08">${data.STORE_NAME}</p>
		</div>
		<div class="plan-grp">
			<div class="plan-gtit">전체 작성상황</div>
			<div class="plan-grpd"><div class="plg-wr"><span style="width:${data.PLAN_CNT}%"></span></div></div>
			<div class="plan-per color-pink">${data.PLAN_CNT}%</div>
		</div>
		<div>
			<div class="">강의횟수 ${data.LECT_CNT}회</div>
		</div>
	</div>
</div>
<form id="fncForm" name="fncForm" method="POST" action="./plan_write_proc" enctype="multipart/form-data">
	<div class="white-bg plan-wrap">
											<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">썸네일 이미지</div>
												<div>
													<div class="filebox"> 
														<label for="thumbnail"><img src="/img/img-file.png" /> 이미지 첨부</label> 
														<input type="file" id="thumbnail" name="thumbnail"> 
														<input class="upload-name" value="이미지를 첨부해주세요.">
														<input type="hidden" id="thumbnail_del" name="thumbnail_del">
										        		<i class="far fa-window-close" onclick="javascript:$('#thumbnail_del').val('on'); $('.upload-name').val('')"></i>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">상세 이미지</div>
												<div>
													<div class="filebox"> 
														<label for="detail"><img src="/img/img-file.png" /> 이미지 첨부</label> 
														<input type="file" id="detail" name="detail"> 
														<input class="upload-name02" value="이미지를 첨부해주세요.">
														<input type="hidden" id="detail_del" name="detail_del">
														<i class="far fa-window-close" onclick="javascript:$('#detail_del').val('on'); $('.upload-name02').val('')"></i>
													</div>
												</div>
											</div>
										</div>
									</div>
	</div> <br>
	<div class="plan-top">
		<div class="top-row table-input">
			<div class="wid-33">
				<div class="table table-90">
					<div class="sear-tit">강사명</div><c:out value="${list[0].LECTURER_NM}"/>
					<div>
						<input type="text" id="lecturer_nm" name="lecturer_nm" placeholder="" class="inputDisabled notEmpty" data-name="강사명" value="${list[0].LECTURER_NM}" readOnly>
					</div>
				</div>
			</div>
		</div>
		<div class="plan-wrr plan-wrrt bg-blue">
			대표약력
		</div>
		<div class="plan-pad">
			<textarea id="lecturer_career" name="lecturer_career" style="height: 200px; margin-top: 15px;"  class="inputDisabled" readOnly>${list[0].LECTURER_CAREER}</textarea>
		</div>
		<div class="plan-wrr plan-wrrt bg-blue" style="margin-top:15px;">
			강의 개요
		</div>
		<div class="plan-pad">
			<textarea id="lecture_content" name="lecture_content" style="height: 200px; margin-top: 15px;"  class="inputDisabled" readOnly>${list[0].LECTURE_CONTENT}</textarea>
		</div>
		
	</div>
	
	
	<div class="white-bg plan-wrap">
		<h3 class="h3-tit">커리큘럼
			<div class="float-right">
				<a class="btn btn01 btn01_1" onclick="javascript:add_contents();"><i class="material-icons">add</i>회차 추가</a>
			</div>
		</h3>
		
		<div class="table-wr">
			<div class="table-list table-list02 table-plan">
				<table>
					<colgroup>
						<col width="10%" />
						<col width="80%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>회차</th>
							<th>내용</th>
							<th class="tog-th"></th>
						</tr>
					</thead>
					<tbody id="target_contents">
					</tbody>
				</table>
			</div>
		</div>
		<div class="btn-wr text-center">
			<input class="search-btn02 btn btn01" type="button" value="목록으로" onclick="javascript:location.href='/web/plan'" style="margin-left:-200px;">
			<input class="search-btn02 btn btn02" type="button" value="저장" onclick="fncSubmit()">
		</div>
	</div>
	<input type="hidden" id="lect_cnt_list" name="lect_cnt_list">
	<input type="hidden" id="lect_contents_list" name="lect_contents_list">
	<input type="hidden" id="store" name="store" value="${store}">
	<input type="hidden" id="period" name="period" value="${period}">
	<input type="hidden" id="subject_cd" name="subject_cd" value="${subject_cd}">
	<input type="hidden" id="subject_nm" name="subject_nm" value="${data.SUBJECT_NM}">
</form>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>