<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="/inc/ckeditor/ckeditor.js"></script>
<script>
$(window).ready(function(){
	$("#banner").on('change',function(){
	  var fileName = $("#banner").val();
	  $(".upload-name").val(fileName);
	});
	$("#m_banner").on('change',function(){
	  var fileName = $("#m_banner").val();
	  $(".upload-name01").val(fileName);
	});
	
	$("#attach").on('change',function(){
	  var fileName = $("#attach").val();
	  $(".upload-name02").val(fileName);
	});
	
	$(".up_div01").each(function(){
		var li = $(this).find(".chk-ul_upwr > ul > li");
		var hid = $(this).find(".hide > div");
		
		li.click(function(){
			var ind = $(this).index();
			li.removeClass("act");
			$(this).addClass("act");
			hid.removeClass("active");
			hid.eq(ind).addClass("active");
			hid.hide();
			hid.eq(ind).show();
			
		})
		
	})
	
	CKEDITOR.replace('contents', {
		height:'500px',
		filebrowserUploadUrl : '/common/ckeditor_upload'
	});
	
	if(nullChk('${seq}') != "")
	{
		init();
	}
})
function init()
{
	$("#main_title").val('${data.MAIN_TITLE}');
	$("#sub_title").val('${data.SUB_TITLE}');
	$("#description").val(repWord('${data.DESCRIPTION}'));
	$("input:radio[name='is_show']:radio[value='${data.IS_SHOW}']").prop('checked', true);
	$("#start_ymd").val('${data.START_YMD}');
	$("#end_ymd").val('${data.END_YMD}');
	$(".upload-name").val('${data.BANNER}');
	$(".upload-name").attr('onclick', 'javascript:window.open("/upload/main_banner/${data.BANNER}");');
	$(".upload-name01").val('${data.M_BANNER}');
	$(".upload-name01").attr('onclick', 'javascript:window.open("/upload/main_banner/${data.M_BANNER}");');
// 	$("input:radio[name='con_type']:radio[value='${data.CON_TYPE}']").prop('checked', true);
// 	if($("input:radio[name='con_type']:checked").val() == "file")
// 	{
// 		$(".up_url").hide();
// 		$(".up_file").show();
// 		$(".upload-name02").val('${data.ATTACH}');
// 		$(".upload-name02").attr('onclick', 'javascript:window.open("/upload/main_banner/${data.ATTACH}");');
// 	}
// 	else if($("input:radio[name='con_type']:checked").val() == "url")
// 	{
// 		$(".up_url").show();
// 		$(".up_file").hide();
// 		$("#banner_link").val('${data.BANNER_LINK}');
// 	}
	
	
	
// 	$("input:radio[name='is_btn_show']:radio[value='${data.IS_BTN_SHOW}']").prop('checked', true);
// 	if($("input:radio[name='is_btn_show']:checked").val() == "Y")
// 	{
// 		$("#btn_nm").val('${data.BTN_NM}');
// 	}
// 	if($("input:radio[name='is_btn_show']:checked").val() == "N")
// 	{
// 		isBtn('N');
// 	}
// 	else if($("input:radio[name='is_btn_show']:checked").val() == "Y")
// 	{
// 		isBtn('Y');
// 	}
	$("#seq").val(nullChk('${seq}'));
}
function fncSubmit()
{
	CKEDITOR.instances.contents.updateElement();
	var validationFlag = "Y";
	$(".notEmpty").each(function() 
	{
		if ($(this).val() == "") 
		{
			alert(this.dataset.name+"???(???) ??????????????????.");
			$(this).focus();
			validationFlag = "N";
			return false;
		}
	});
	if(validationFlag == "Y")
	{
		if($("#banner").val() == "" && $(".upload-name").html() == "" && $("#seq").val() == "")
		{
			alert("??????????????? ??????????????????.");
			validationFlag = "N";
			return;
		}
	}
	if(validationFlag == "Y")
	{
		if($("#m_banner").val() == "" && $(".upload-name01").html() == "" && $("#seq").val() == "")
		{
			alert("?????????????????? ??????????????????.");
			validationFlag = "N";
			return;
		}
	}
// 	if(validationFlag == "Y")
// 	{
// 		if($("input:radio[name='con_type']:checked").val() == "file")
// 		{
// 			if($("#attach").val() == "" && $(".upload-name02").html() == "" && $("#seq").val() == "")
// 			{
// 				alert("????????? ?????????????????????.");
// 				validationFlag = "N";
// 				return;
// 			}
// 		}
// 		else if($("input:radio[name='con_type']:checked").val() == "url")
// 		{
// 			if($("#banner_link").val() == "")
// 			{
// 				alert("?????? ????????? ??????????????????.");
// 				validationFlag = "N";
// 				return
// 			}
// 		}
// 	}
// 	if(validationFlag == "Y")
// 	{
// 		if($("input:radio[name='is_btn_show']:checked").val() == "Y")
// 		{
// 			if($("#btn_nm").val() == "")
// 			{
// 				alert("???????????? ??????????????????.");
// 				validationFlag = "N";
// 				return;
// 			}
// 			if($("#btn_link").val() == "")
// 			{
// 				alert("??????????????? ??????????????????.");
// 				validationFlag = "N";
// 				return;
// 			}
// 		}
// 	}
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
// function isBtn(val)
// {
// 	if(val == "N")
// 	{
// 		$(".up_div01").hide();
// 		$(".btn_nm").hide();
// 	}
// 	else
// 	{
// 		$(".up_div01").show();
// 		$(".btn_nm").show();
// 	}
// }
</script>
<div class="sub-tit">
	<h2>?????? ?????? ??????</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>


<div class="table-wr">
	<form id="fncForm" name="fncForm" action="./list_upload_proc" method="POST" enctype="multipart/form-data">
		<div class="table-list banner-list">
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_120">Main Title</div>
						<div class="ban-inp">							
							<input type="text" class="inp-100 notEmpty" id="main_title" name="main_title" data-name="?????? ?????????" placeholder="?????? ???????????? ??????????????????." onkeypress="javascript:lengthCheck('main_title', 30);">
							<div class="txt-count" id="main_title_length"><Span>0</Span> / 30???</div>
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_120">Sub Title</div>
						<div class="ban-inp">							
							<input type="text" class="inp-100 notEmpty" id="sub_title" name="sub_title" data-name="?????? ?????????" placeholder="?????? ???????????? ??????????????????." onkeypress="javascript:lengthCheck('sub_title', 30);">
							<div class="txt-count" id="sub_title_length"><Span>0</Span> / 30???</div>
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ban-tarea">
						<div class="sear-tit sear-tit_120">Description</div>
						<div class="ban-inp">							
							<textarea placeholder="????????? ??????????????????." class="" data-name="??????" id="description" name="description" onkeypress="javascript:lengthCheck('description', 30);"></textarea>
							<div class="txt-count" id="description_length"><Span>0</Span> / 30???</div>
						</div>
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_120">????????? ??????</div>
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
						<div class="sear-tit sear-tit_120">??????</div>
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
			
			<div class="top-row sear-wr up-file-wr">
				<div class="wid-10">
					<div class="table">
						<div class="sear-tit sear-tit_120">???????????? ??????</div>
						<div>
							<div class="filebox"> 
								<label for="banner"><img src="/img/img-file.png" /> ????????? ??????</label> 
								<input type="file" id="banner" name="banner"> 
								
								<input class="upload-name" value="???????????? ??????????????????.">
								<span>* ?????? 5MB??? ????????? ????????? ????????? ??? ????????????. (????????? ????????? 4500*3600 ??????)</span>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="top-row sear-wr up-file-wr">
				<div class="wid-10">
					<div class="table">
						<div class="sear-tit sear-tit_120">??????????????? ??????</div>
						<div>
							<div class="filebox"> 
								<label for="m_banner"><img src="/img/img-file.png" /> ????????? ??????</label> 
								<input type="file" id="m_banner" name="m_banner"> 
								
								<input class="upload-name01" value="???????????? ??????????????????.">
								<span>* ?????? 5MB??? ????????? ????????? ????????? ??? ????????????. (????????? ????????? 2600*1800 ??????)</span>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="top-row sear-wr">
				<div class="wid-10">			
					<textarea name="contents" id="contents" class="notEmpty" data-name="??????">${data.CONTENTS}</textarea>
				</div>
			</div>
			<br>
<!-- 			<div class="top-row sear-wr"> -->
<!-- 				<div class="wid-10"> -->
<!-- 					<div class="table up_detailwr"> -->
<!-- 						<div class="sear-tit sear-tit_120">????????????</div> -->
<!-- 						<div class="up_topwrap"> -->
<!-- 							<div class="up_div02"> -->
<!-- 								<div> -->
<!-- 									<div class="sear-tit_sm">?????? ?????? ??????</div> -->
<!-- 									<div> -->
<!-- 										<ul class="chk-ul"> -->
<!-- 											<li> -->
<!-- 												<input type="radio" id="is_btn_show1" name="is_btn_show" value="Y" checked onclick="isBtn('Y');"/> -->
<!-- 												<label for="is_btn_show1">Y</label> -->
<!-- 											</li> -->
<!-- 											<li> -->
<!-- 												<input type="radio" id="is_btn_show2" name="is_btn_show" value="N" onclick="isBtn('N');"/> -->
<!-- 												<label for="is_btn_show2">N</label> -->
<!-- 											</li> -->
<!-- 										</ul> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
<!-- 								<div class="btn_nm"> -->
<!-- 									<div class="sear-tit_sm">????????? ??????</div> -->
<!-- 									<div> -->
<!-- 										<input type="text" id="btn_nm" name="btn_nm" value=""> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
								
<!-- 							</div> -->
<!-- 							<div class="up_div01" id=""> -->
<!-- 								<div class="chk-ul_upwr"> -->
<!-- 									<ul class="chk-ul"> -->
<!-- 										<li> -->
<!-- 											<input type="radio" id="con_type1" name="con_type" value="file" checked> -->
<!-- 											<label for="con_type1">?????? ?????????</label> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<input type="radio" id="con_type2" name="con_type" value="url"> -->
<!-- 											<label for="con_type2">?????? URL</label> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</div> -->
								
<!-- 								<div class="hide"> -->
<!-- 									<div class="up_file"> -->
<!-- 										<div class="filebox">  -->
<!-- 											<label for="attach"><img src="/img/img-file02.png" /> ????????????</label>  -->
<!-- 											<input type="file" id="attach" name="attach">  -->
											
<!-- 											<input class="upload-name02" value="????????? ??????????????????."> -->
<!-- 											<span>* ?????? 5MB??? ????????? ????????? ????????? ??? ????????????. (????????? ????????? ?????? 640 ??????)</span> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="up_url"> -->
<!-- 										<div class="sear-tit_sm">?????? ??????</div> -->
<!-- 										<div class="ban-inp02">							 -->
<!-- 											<input type="text" id="banner_link" name="banner_link" value=""> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
											
<!-- 							</div> -->
							
							
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			<div class="btn-wr text-center">
				<a class="btn btn01" href="/web/list">????????????</a>
				<a class="btn btn02" onclick="javascript:fncSubmit();">??????</a>
			</div>
			
			
			
		</div>
		<input type="hidden" id="seq" name="seq" value="">	
	</form>
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>