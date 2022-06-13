<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
$(window).ready(function(){
	$("#popup_img").on('change',function(){
	  var fileName = $("#popup_img").val();
	  $(".upload-name").val(fileName);
	});
	init();
})
function init()
{
	$("#popup_title").val('${data.POPUP_TITLE}');
	$("input:radio[name='open_type']:radio[value='${data.OPEN_TYPE}']").prop('checked', true);
	$("#start_ymd").val('${data.START_YMD}');
	$("#end_ymd").val('${data.END_YMD}');
	$("input:radio[name='is_show']:radio[value='${data.IS_SHOW}']").prop('checked', true);
	$("#margin_left").val('${data.MARGIN_LEFT}');
	$("#margin_top").val('${data.MARGIN_TOP}');
	$(".upload-name").val('${data.POPUP_IMG}');
	if('${data.IS_CENTER}' == 'Y')
	{
		$("input:checkbox[id='is_center']").prop("checked", true);
	}
	else if('${data.IS_CENTER}' == 'N')
	{
		$("input:checkbox[id='is_center']").prop("checked", false);
	}
	if('${data.NOT_TODAY}' == 'Y')
	{
		$("input:checkbox[id='not_today']").prop("checked", true);
	}
	else if('${data.NOT_TODAY}' == 'N')
	{
		$("input:checkbox[id='not_today']").prop("checked", false);
	}
	$("#popup_link").val('${data.POPUP_LINK}');
	$("#popup_pop").val('${data.POPUP_POP}');
	$(".popup_pop").html('${data.POPUP_POP_NM}');
	$("#seq").val(nullChk('${seq}'));
}
function fncSubmit()
{
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
		if($("input:radio[name='open_type']:checked").val() == "someday" && $("#start_ymd").val() == "")
		{
			alert("팝업 시작일을 입력해주세요");
			validationFlag = "N";
			return;
		}
	}
	if(validationFlag == "Y")
	{
		if($("input:radio[name='open_type']:checked").val() == "someday" && $("#end_ymd").val() == "")
		{
			alert("팝업 종료일을 입력해주세요");
			validationFlag = "N";
			return;
		}
	}
	if(validationFlag == "Y")
	{
		if(!$("input:checkbox[name='is_center']").is(":checked") && ($("#margin_top").val() == "" || isNaN($("#margin_top").val())))
		{
			alert("상단 위치값을 확인해주세요.");
			validationFlag = "N";
			return;
		}
	}
	if(validationFlag == "Y")
	{
		if(!$("input:checkbox[name='is_center']").is(":checked") && ($("#margin_left").val() == "" || isNaN($("#margin_left").val())))
		{
			alert("좌측 위치값을 확인해주세요.");
			validationFlag = "N";
			return;
		}
	}
	if(validationFlag == "Y")
	{
		if($("#popup_img").val() == "" && $(".upload-name").html() == "" && $("#seq").val() == "")
		{
			alert("팝업이미지를 등록해주세요.");
			validationFlag = "N";
			return;
		}
	}
	if(validationFlag == "Y")
	{
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
</script>
<div class="sub-tit">
	<h2>팝업 등록</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>


<div class="table-wr">
	<form id="fncForm" name="fncForm" action="./popup_upload_proc" method="POST" enctype="multipart/form-data">
		<div class="table-list banner-list banner-list_popup">
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_140">팝업 제목</div>
						<div class="ban-inp">							
							<input type="text" class="inp-100 notEmpty" id="popup_title" name="popup_title" data-name="제목" placeholder="제목을 입력해주세요.">
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_140">기간별 노출 설정</div>
						<div class="rad-cal">	
							<ul class="chk-ul">
								<li>
									<input type="radio" id="open_type1" name="open_type" value="always" checked/>
									<label for="open_type1">항상 열림</label>
								</li>
								<li>
									<input type="radio" id="open_type2" name="open_type" value="someday"/>
									<label for="open_type2">특정 기간동안 열림</label>
								</li>
							</ul>	
							<div class="cal-row">
								<div class="cal-input  cal-input_170">
									<input type="text" id="start_ymd" name="start_ymd" value="" class="date-i" />
									<i class="material-icons">event_available</i>
								</div>
								<div class="cal-dash">-</div>
								<div class="cal-input cal-input_170">
									<input type="text" id="end_ymd" name="end_ymd" value="" class="date-i" />
									<i class="material-icons">event_available</i>
								</div>
							</div>					
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_140">출력 여부</div>
						<div class="">	
							<ul class="chk-ul">
								<li>
									<input type="radio" id="is_show1" name="is_show" value="Y" checked/>
									<label for="is_show1">Y</label>
								</li>
								<li>
									<input type="radio" id="is_show2" name="is_show" value="N"/>
									<label for="is_show2">N</label>
								</li>
							</ul>						
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_140">위치값</div>
						<div class="pop-position">
							<div>
								<span>상단에서</span>
								<input type="text" id="margin_top" name="margin_top" class="">
								<span class="px-t">pixel</span>
							</div>
							<div class="inp-ri">
								<span>좌측에서</span>
								<input type="text" id="margin_left" name="margin_left" class="" >
								<span class="px-t">pixel</span>
							</div>
							<div class="">	
								<ul class="chk-ul">
									<li>
										<input type="checkbox" id="is_center" name="is_center" value="Y" checked />
										<label for="is_center">중앙에 배치하기</label>
									</li>
								</ul>						
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_140">오늘 하루 열지 않기</div>
						<div class="">	
							<ul class="chk-ul">
								<li>
									<input type="checkbox" id="not_today" name="not_today" value="Y" checked/>
									<label for="not_today">'오늘 하루 열지 않기' 기능을 사용함</label>
								</li>
							</ul>						
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table">
						<div class="sear-tit sear-tit_140">링크</div>
						<div class="ban-inp02">							
							<input type="text" id="popup_link" name="popup_link"  value="">
							<select class="wid-10" id="popup_pop" name="popup_pop" de-data="현재창">
								<option value="now">현재창</option>
								<option value="new">새창</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			
	<!-- 		<div class="top-row sear-wr"> -->
	<!-- 			<div class="wid-10"> -->
	<!-- 				<div class="table"> -->
	<!-- 					<textarea class="ban-cont"></textarea> -->
	<!-- 				</div> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
			
			<div class="top-row sear-wr up-file-wr02">
				<div class="wid-10">
					<div class="filebox"> 
						<label for="popup_img"><img src="/img/img-file.png" /> 이미지 첨부</label> 
						<input type="file" id="popup_img" name="popup_img"> 
						
						<input class="upload-name" value="이미지를 첨부해주세요.">
						<span>* 최대 5MB의 이미지 파일을 등록할 수 있습니다.(이미지 사이즈 1284x238 권장)</span>
					</div>
				</div>
			</div>
			<div class="btn-wr text-center">
				<a class="btn btn01" href="/web/popup">목록으로</a>
				<a class="btn btn02" onclick="javascript:fncSubmit();">등록</a>				
			</div>
		</div>	
		<input type="hidden" id="seq" name="seq" value="">	
	</form>
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>