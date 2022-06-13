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
	
	$("#attach").on('change',function(){
	  var fileName = $("#attach").val();
	  $(".upload-name02").val(fileName);
	});
	$("#banner").on('change',function(){
		  var fileName = $("#banner").val();
		  $(".upload-name").val(fileName);
		});
		$("#m_banner").on('change',function(){
		  var fileName = $("#m_banner").val();
		  $(".upload-name01").val(fileName);
		});
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
	$("#selBranch").val('${data.STORE}');
	$("#news_category").val('${data.CATEGORY}');
	$(".news_category").html('${data.CATEGORY}');
	$("#news_title").val('${data.TITLE}');
	$("#start_ymd").val('${data.START_YMD}');
	$("#end_ymd").val('${data.END_YMD}');
	
	$("input:radio[name='is_show']:radio[value='${data.IS_SHOW}']").prop('checked', true);
	$(".upload-name").val('${data.BANNER}');
	$(".upload-name").attr('onclick', 'javascript:window.open("/upload/news/${data.BANNER}");');
	$(".upload-name01").val('${data.M_BANNER}');
	$(".upload-name01").attr('onclick', 'javascript:window.open("/upload/news/${data.M_BANNER}");');
	$(".upload-name02").val('${data.FILENAME}');
	$(".upload-name02").attr('onclick', 'javascript:window.open("/upload/news/${data.FILENAME}");');
	
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
			alert(this.dataset.name+"을(를) 입력해주세요.");
			$(this).focus();
			validationFlag = "N";
			return false;
		}
	});
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
	<h2>아카데미 뉴스</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>

<div class="table-wr">
	<div class="table-list banner-list">
		<form id="fncForm" name="fncForm" action="./academy_upload_proc" method="POST" enctype="multipart/form-data">
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table ">
						<div class="sear-tit sear-tit_120">지점</div>
						<div>							
							<c:if test="${isBonbu eq 'T'}">
								<select de-data="전체" id="selBranch" name="selBranch">
										<option value="00">전체</option>
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
			</div>
			
			<div class="top-row sear-wr">
				<div class="wid-10">
					<div class="table">
						<div class="sear-tit sear-tit_120">카테고리/제목</div>
						<div class="ban-inp02 ban-inp03">
							<select class="wid-10" id="news_category" name="news_category" de-data="EVENT">
								<option value="EVENT">EVENT</option>
								<option value="NOTICE">NOTICE</option>
							</select>
							<input type="text" id="news_title" name="news_title" value="" placeholder="제목을 입력해주새요." class="notEmpty" data-name="제목">
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
					<div class="table ">
						<div class="sear-tit sear-tit_120">노출 여부</div>
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
			<div class="top-row sear-wr up-file-wr">
				<div class="wid-10">
					<div class="table">
						<div class="sear-tit sear-tit_120">메인배너 등록</div>
						<div>
							<div class="filebox"> 
								<label for="banner"><img src="/img/img-file.png" /> 이미지 첨부</label> 
								<input type="file" id="banner" name="banner"> 
								
								<input class="upload-name" value="이미지를 첨부해주세요.">
								<span>* 최대 5MB의 이미지 파일을 등록할 수 있습니다. (이미지 사이즈 1066*880 권장)</span>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			<div class="top-row sear-wr up-file-wr">
				<div class="wid-10">
					<div class="table">
						<div class="sear-tit sear-tit_120">모바일배너 등록</div>
						<div>
							<div class="filebox"> 
								<label for="m_banner"><img src="/img/img-file.png" /> 이미지 첨부</label> 
								<input type="file" id="m_banner" name="m_banner"> 
								
								<input class="upload-name01" value="이미지를 첨부해주세요.">
								<span>* 최대 5MB의 이미지 파일을 등록할 수 있습니다. (이미지 사이즈 640*800 권장)</span>
							</div>
						</div>
						
					</div>
				</div>
			</div>
			
			<div class="top-row sear-wr">
				<div class="wid-10">			
					<textarea name="contents" id="contents" class="notEmpty" data-name="내용">${data.CONTENTS}</textarea>
				</div>
			</div>
			
			<div class="top-row sear-wr up-file-wr">
				<div class="wid-10">
					<div class="table">
						<div>
							<div class="filebox"> 
								<label for="attach"><img src="/img/img-file.png" /> 파일 첨부</label>  
								<input type="file" id="attach" name="attach"> 
								
								<input class="upload-name02" value="이미지를 첨부해주세요.">
								<span>* 최대 5MB의 이미지 파일을 등록할 수 있습니다.(이미지 사이즈 1284x238 권장)</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="btn-wr text-center">
				<a class="btn btn01" href="/web/academy">목록으로</a>
				<a class="btn btn02" onclick="javascript:fncSubmit();">등록</a>						
			</div>
			<input type="hidden" id="seq" name="seq" value="">
		</form>
	</div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>
