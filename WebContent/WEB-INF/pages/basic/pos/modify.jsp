<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<meta charset="utf-8">
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/function.js"></script>
<link rel="stylesheet" href="/inc/css/admin.css">
<script>
$(document).ready(function(){
	var open_yn = "${data.OPEN_YN}";
	var sale_end_yn = "${data.SALE_END_YN}";
	var ad_end_yn = "${data.AD_END_YN}";
	var delete_yn = "${data.DELETE_YN}";
	var send_yn = "${data.SEND_YN}";
	var pos_type = "${data.POS_TYPE}";
	$("#modify_open_yn option").filter(function(){
		return this.text == open_yn;
	}).attr("selected", "selected");
	$("#modify_sale_end_yn option").filter(function(){
		return this.text == sale_end_yn;
	}).attr("selected", "selected");
	$("#modify_ad_end_yn option").filter(function(){
		return this.text == ad_end_yn;
	}).attr("selected", "selected");
	$("#modify_delete_yn option").filter(function(){
		return this.text == delete_yn;
	}).attr("selected", "selected");
	$("#modify_send_yn option").filter(function(){
		return this.text == send_yn;
	}).attr("selected", "selected");
	$("#modify_pos_type option").filter(function(){
		return this.text == pos_type;
	}).attr("selected", "selected");
});
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
		$("#fncForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	    			location.href="./list";
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}
function check_value(e){
	var now_len;
}
</script>
<div>
	<div>
		<img src="/img/logo.png">
	</div>
	<form id="fncForm" name="fncForm" method="POST" action="./modify_proc">
	<input type="hidden" id="get_hq" name="get_hq" value="${param.get_hq}">
	<input type="hidden" id="get_store" name="get_store" value="${param.get_store}">
	<input type="hidden" id="get_pos_no" name="get_pos_no" value="${param.get_pos_no}">
		<div class="dis-no">
			<span class="inputTitle">그룹</span>
			<input type="text" data-name="그룹" id="modify_hq" name="modify_hq" class="notEmpty" value="${data.HQ}">
			
			<span class="inputTitle">지점</span>
			<input type="text" data-name="지점" id="modify_store" name="modify_store" class="notEmpty" value="${data.STORE}">
			
			<span class="inputTitle">삭제여부</span>
			<select id="modify_delete_yn" name="modify_delete_yn" class="notEmpty">
				<option value="N">X</option>
				<option value="Y">O</option>
			</select>
			
			<span class="inputTitle">전송여부</span>
			<select id="modify_send_yn" name="modify_send_yn" class="notEmpty">
				<option value="N">미전송</option>
				<option value="Y">전송</option>
			</select>
			
			<span class="inputTitle">POS타입</span>
			<select id="modify_pos_type" name="modify_pos_type" class="notEmpty">
				<option value="D">DESK</option>
				<option value="W">WEB</option>
				<option value="M">MOBILE</option>
			</select>
		</div>
		<h3>POS 수정</h3>
		<div class="top-row">
			<div class="wid-5 bor-r">
				<div class="table">
					<div class="sear-tit">POS번호</div>
					<div>
						<input type="text" data-name="POS번호" id="modify_pos_no" name="modify_pos_no" class="notEmpty" value="${data.POS_NO}">
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">영업일자</div>
					<div>
						<input type="text" data-name="영업일자" id="modify_sale_ymd" name="modify_sale_ymd" class="notEmpty" value="${data.SALE_YMD}">
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">개설여부</div>
					<div>
						<select id="modify_open_yn" name="modify_open_yn" class="notEmpty" de-data="개설">
							<option value="Y">개설</option>
							<option value="N">비개설</option>
						</select>
						
					</div>
				</div>
			</div>
			<div class="wid-5">
				<div class="table">
					<div class="sear-tit">마감여부</div>
					<div>
						<select id="modify_sale_end_yn" name="modify_sale_end_yn" class="notEmpty" de-data="마감여부">
							<option value="Y">마감</option>
							<option value="N">미마감</option>
						</select>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">정산여부</div>
					<div>
						<select id="modify_ad_end_yn" name="modify_ad_end_yn" class="notEmpty" de-data="정산여부">
							<option value="Y">정산</option>
							<option value="N">미정산</option>
						</select>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">POS타입</div>
					<div>
						<select id="modify_pos_type" name="modify_pos_type" class="notEmpty" de-data="POS타입">
							<option value="D">DESK</option>
							<option value="W">WEB</option>
							<option value="M">MOBILE</option>
						</select>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="btn-wr text-center">
		<a class="btn btn01 ok-btn" onclick="javascript:location.href='./list';">취소</a>
		<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();"><i class="material-icons">vertical_align_bottom</i>수정</a>
	</div>
</div>