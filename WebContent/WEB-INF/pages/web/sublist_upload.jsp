<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
$(window).ready(function(){
	$("#banner").on('change',function(){
	  var bannerName = $("#banner").val();
	  $(".upload-name").val(bannerName);
	});
	$("#detail").on('change',function(){
	  var detailName = $("#detail").val();
	  $(".upload-name02").val(detailName);
	});
	if(nullChk('${seq}') != "")
	{
		init();
	}
})
function init()
{
	$("#banner_name").val('${data.BANNER_NAME}');
	$("#banner_desc").val('${data.BANNER_DESC}');
	$("input:radio[name='is_show']:radio[value='${data.IS_SHOW}']").prop('checked', true);
	$("#start_ymd").val('${data.START_YMD}');
	$("#end_ymd").val('${data.END_YMD}');
	$("#banner_pop").val('${data.BANNER_POP}');
	$(".banner_pop").html('${data.BANNER_POP_NM}');
	$(".upload-name").val('${data.BANNER}');
	$(".upload-name").attr('onclick', 'javascript:window.open("/upload/sub_banner/${data.BANNER}");');
	$(".upload-name02").val('${data.DETAIL}');
	$(".upload-name02").attr('onclick', 'javascript:window.open("/upload/sub_banner/${data.DETAIL}");');
	
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
		if($("#banner").val() == "" && $(".upload-name").html() == "" && $("#seq").val() == "")
		{
			alert("배너를 등록해주세요.");
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
	<h2>중간 배너 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>


<div class="table-wr">
	<form id="fncForm" name="fncForm" action="./sublist_upload_proc" method="POST" enctype="multipart/form-data">
		<div class="table-list banner-list">
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_120">배너명</div>
						<div class="ban-inp">							
							<input type="text" class="inp-100 notEmpty" id="banner_name" name="banner_name" data-name="배너명" placeholder="배너명을 입력해주세요.">
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_120">배너 이미지 설명</div>
						<div class="ban-inp">							
							<input type="text" class="inp-100 notEmpty" id="banner_desc" name="banner_desc" data-name="배너이미지 설명" placeholder="배너 이미지의 속성에 대한 내용을 입력해주세요." onkeypress="javascript:lengthCheck('banner_desc', 30);">
							<div class="txt-count" id="banner_desc_length"><Span>10</Span> / 30자</div>
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_120">출력 여부</div>
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
					<div class="table">
						<div class="sear-tit sear-tit_120">기간</div>
						<div class="cal-row">
							<div class="cal-input  ">
								<input type="text" id="start_ymd" name="start_ymd" value="" class="date-i ready-i" />
								<i class="material-icons">event_available</i>
							</div>
							<div class="cal-dash">-</div>
							<div class="cal-input ">
								<input type="text" id="end_ymd" name="end_ymd" value="" class="date-i ready-i" />
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table">
						<div class="sear-tit sear-tit_120">배너 링크</div>
						<div class="ban-inp02">							
<!-- 							<input type="text" value="AK 문화센터 강사계약서"> -->
							<select class="wid-10" id="banner_pop" name="banner_pop" de-data="현재창">
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
					<div class="table">
						<div class="wid-6">
							<div class="filebox"> 
								<label for="banner"><img src="/img/img-file.png" /> 이미지 첨부</label> 
								<input type="file" id="banner" name="banner"> 
								
								<input class="upload-name" value="이미지를 첨부해주세요.">
								<span>* 최대 5MB의 이미지 파일을 등록할 수 있습니다.(이미지 사이즈 1284x238 권장)</span>
							</div>
						</div>
						<div>
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr up-file-wr02">
				<div class="wid-10">
					<div class="table">
						<div class="wid-6">
							<div class="filebox"> 
								<label for="detail"><img src="/img/img-file.png" /> 이미지 첨부</label> 
								<input type="file" id="detail" name="detail"> 
								
								<input class="upload-name02" value="이미지를 첨부해주세요.">
								<span>* 최대 5MB의 이미지 파일을 등록할 수 있습니다.(이미지 사이즈 1284x238 권장)</span>
							</div>
						</div>
						<div>
							<a class="btn btn01" href="/web/sublist">목록으로</a>
							<a class="btn btn02" onclick="javascript:fncSubmit();">등록</a>
						</div>
					</div>
				</div>
			</div>
			
		</div>	
		<input type="hidden" id="seq" name="seq" value="">	
	</form>
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>