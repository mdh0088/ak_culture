<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
$(document).ready(function() {
	$("#target").val(repWord('${list[0].TARGET}'));
	$("#food_amt").val(repWord('${list[0].FOOD_AMT}'));
	$("#food_contents").val(repWord('${list[0].FOOD_CONTENTS}'));
	$("#lect_intro").val(repWord('${list[0].LECT_INTRO}'));
	
	var lect_cnt = repWord('${list[0].LECT_CNT}').split("|");
	var lect_contents = repWord('${list[0].LECT_CONTENTS}').split("|");
	var lect_food = repWord('${list[0].LECT_FOOD}').split("|");
	
	for(var i = 0; i < lect_cnt.length-1; i++)
	{
		add_contents_init();
		$("#lect_cnt"+(i+1)).val(lect_cnt[i]);
		$("#lect_contents"+(i+1)).val(lect_contents[i]);
		$("#lect_food"+(i+1)).val(lect_food[i]);
	}
});
function changeStatus()
{
	if($("#isChange").hasClass("btn03"))
	{
		$("#isChange").removeClass("btn03");
		$("#isChange").addClass("btn04");
		$("#isChange").html("OFF");
		
		$("#target").addClass("inputDisabled"); $("#target").attr("readOnly", true);
		$("#food_amt").addClass("inputDisabled"); $("#food_amt").attr("readOnly", true);
		$("#food_contents").addClass("inputDisabled"); $("#food_contents").attr("readOnly", true);
		$("#lect_intro").addClass("inputDisabled"); $("#lect_intro").attr("readOnly", true);
		
		$("input[name=lect_cnt]").addClass("inputDisabled"); $("input[name=lect_cnt]").attr("readOnly", true);
		$("input[name=lect_contents]").addClass("inputDisabled"); $("input[name=lect_contents]").attr("readOnly", true);
		$("input[name=lect_food]").addClass("inputDisabled"); $("input[name=lect_food]").attr("readOnly", true);
	}
	else if($("#isChange").hasClass("btn04"))
	{
		$("#isChange").removeClass("btn04");
		$("#isChange").addClass("btn03");
		$("#isChange").html("ON");
		
		$("#target").removeClass("inputDisabled"); $("#target").attr("readOnly", false);
		$("#food_amt").removeClass("inputDisabled"); $("#food_amt").attr("readOnly", false);
		$("#food_contents").removeClass("inputDisabled"); $("#food_contents").attr("readOnly", false);
		$("#lect_intro").removeClass("inputDisabled"); $("#lect_intro").attr("readOnly", false);
		
		$("input[name=lect_cnt]").removeClass("inputDisabled"); $("input[name=lect_cnt]").attr("readOnly", false);
		$("input[name=lect_contents]").removeClass("inputDisabled"); $("input[name=lect_contents]").attr("readOnly", false);
		$("input[name=lect_food]").removeClass("inputDisabled"); $("input[name=lect_food]").attr("readOnly", false);
	}
}
var contents_cnt = 1;
function add_contents()
{
	if($("#isChange").hasClass("btn03"))
	{
		var inner = "";
		inner += '<tr class="add-row" id="contents_tr_'+contents_cnt+'">';
		inner += '	<td><input type="number" id="lect_cnt'+contents_cnt+'" name="lect_cnt" value="0" style="width: 60px;" class="notEmpty" data-name="회차">회차</td>';
		inner += '	<td><input type="text" id="lect_contents'+contents_cnt+'" name="lect_contents" placeholder="내용을 작성해주세요." class="notEmpty" data-name="내용"></td>';
		inner += '	<td><input type="text" id="lect_food'+contents_cnt+'" name="lect_food" placeholder="준비물"></td>';
		inner += '	<td class="tog-tit"><div><i class="material-icons remove" onclick="remove_contents('+contents_cnt+')">remove_circle_outline</i></div></td>';
		inner += '</tr>';
		$("#target_contents").prepend(inner);
		contents_cnt ++;
	}
}
function add_contents_init()
{
	var inner = "";
	inner += '<tr id="contents_tr_'+contents_cnt+'">';
	inner += '	<td><input type="number" id="lect_cnt'+contents_cnt+'" name="lect_cnt" value="0" style="width: 60px;" class="notEmpty inputDisabled" data-name="회차" readOnly>회차</td>';
	inner += '	<td><input type="text" id="lect_contents'+contents_cnt+'" name="lect_contents" placeholder="내용을 작성해주세요." style="width: 100%;" class="notEmpty inputDisabled" data-name="내용" readOnly></td>';
	inner += '	<td><input type="text" id="lect_food'+contents_cnt+'" name="lect_food" placeholder="준비물" style="width: 100%;" class="inputDisabled" readOnly></td>';
	inner += '	<td class="tog-tit"><div><i class="material-icons remove" onclick="remove_contents('+contents_cnt+')">remove_circle_outline</i></div></td>';
	inner += '</tr>';
	$("#target_contents").prepend(inner);
	contents_cnt ++;
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
			
			
			var lect_food_list = "";
			$("[name='lect_food']").each(function() 
			{
				lect_food_list += $(this).val()+"|";
			});
			$("#lect_food_list").val(lect_food_list);
			
			
			
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
	$("#file").on('change',function(){
	  var fileName = $("#file").val();
	  $(".upload-name").val(fileName);
	});
	
})
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
		<a class="btn btn01 btn-inline" href="#">강의계획서 작성요청</a>
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
			<div class="plan-grpd"><div class="plg-wr"><span style="width:${percent}%"></span></div></div>
			<div class="plan-per color-pink">${percent}%</div>
		</div>
	</div>
</div>
<form id="fncForm" name="fncForm" method="POST" action="./plan_write_proc">
	<div class="plan-top">
		<div class="top-row table-input">
			<div class="wid-33">
				<div class="table table-90">
					<div class="sear-tit">수강대상</div>
					<div>
						<input type="text" id="target" name="target" placeholder="4세~12세" class="inputDisabled" readOnly>
					</div>
				</div>
			</div>
			<div class="wid-33">
				<div class="table table-90">
					<div class="sear-tit sear-tit_120">재료비(1인1회)</div>
					<div>
						<input type="text" id="food_amt" name="food_amt" placeholder="50,000원" class="inputDisabled" readOnly>
					</div>
				</div>
			</div>
			<div class="wid-33">
				<div class="table table-90">
					<div class="sear-tit">재료비 내용</div>
					<div>
						<input type="text" id="food_contents" name="food_contents" placeholder="발레슈즈, 발레복 준비" class="inputDisabled" readOnly>
					</div>
				</div>
			</div>
		</div>
		<div class="plan-wrr plan-wrrt bg-blue">
			강의 개요
		</div>
		<div class="plan-pad">
			<textarea id="lect_intro" name="lect_intro" style="height: 200px; margin-top: 15px;"  class="inputDisabled" readOnly></textarea>
		</div>
		
		<div class="top-row sear-wr up-file-wr">
			<div class="wid-10">
				<div class="table">
					<div>
						<div class="filebox"> 
							<label for="file"><img src="/img/img-file.png" /> 이미지 첨부</label> 
							<input type="file" id="file"> 
							
							<input class="upload-name" value="이미지를 첨부해주세요.">
							<span>* 최대 5MB의 이미지 파일을 등록할 수 있습니다.(이미지 사이즈 1284x238 권장)</span>
						</div>
					</div>
					<div>
						<a class="btn btn01" href="/web/plan">목록으로</a>
						<a class="btn btn02" href="#">등록</a>
					</div>
				</div>
			</div>
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
						<col width="70%" />
						<col width="10%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>회차</th>
							<th>내용</th>
							<th>준비물</th>
							<th class="tog-th"></th>
						</tr>
					</thead>
					<tbody id="target_contents">
	<!-- 					<tr> -->
	<!-- 						<td>1회차</td> -->
	<!-- 						<td>바른자세와 몸가짐을 가져요. - 아름다운 발레인사법/발끝펴고 올리기 (point, flex, relate..</td> -->
	<!-- 						<td>발레슈즈, 발레복</td> -->
	<!-- 						<td class="tog-tit"> -->
	<!-- 							<div> -->
	<!-- 								<i class="material-icons remove">remove_circle_outline</i> -->
	<!-- 							</div>  -->
	<!-- 						</td> -->
	<!-- 					</tr> -->
	<!-- 					<tr> -->
	<!-- 						<td>2회차</td> -->
	<!-- 						<td>바른자세와 몸가짐을 가져요. - 아름다운 발레인사법/발끝펴고 올리기 (point, flex, relate..</td> -->
	<!-- 						<td>발레슈즈, 발레복</td> -->
	<!-- 						<td class="tog-tit"> -->
	<!-- 							<div> -->
	<!-- 								<i class="material-icons remove">remove_circle_outline</i> -->
	<!-- 							</div>  -->
	<!-- 						</td> -->
	<!-- 					</tr> -->
<!-- 						<tr> -->
<!-- 							<td>3회차</td> -->
<!-- 							<td>바른자세와 몸가짐을 가져요. - 아름다운 발레인사법/발끝펴고 올리기 (point, flex, relate..</td> -->
<!-- 							<td>발레슈즈, 발레복</td> -->
<!-- 							<td class="tog-tit"> -->
<!-- 								<div> -->
<!-- 									<i class="material-icons remove">remove_circle_outline</i> -->
<!-- 								</div>  -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>
				<input class="search-btn02 btn btn02" type="button" value="저장" onclick="fncSubmit()">
			</div>
		</div>
	</div>
	<input type="hidden" id="lect_cnt_list" name="lect_cnt_list">
	<input type="hidden" id="lect_contents_list" name="lect_contents_list">
	<input type="hidden" id="lect_food_list" name="lect_food_list">
	<input type="hidden" id="store" name="store" value="${store}">
	<input type="hidden" id="period" name="period" value="${period}">
	<input type="hidden" id="subject_cd" name="subject_cd" value="${subject_cd}">
</form>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>