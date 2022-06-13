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
	var pos_yn = "${data.POS_PRINT_YN}";
	var ppcard_yn = "${data.PPCARD_PRINT_YN}";
	var delete_yn = "${data.DELETE_YN}";
	$("#modify_pos_print_yn option").filter(function(){
		return this.text == pos_yn;
	}).attr("selected", "selected");
	$("#modify_ppcard_print_yn option").filter(function(){
		return this.text == ppcard_yn;
	}).attr("selected", "selected");
	$("#modify_delete_yn option").filter(function(){
		return this.text == delete_yn;
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
	<input type="hidden" id="get_ip" name="get_ip" value="${param.get_ip}">
		<div class="dis-no">
			<span class="inputTitle">그룹</span>
			<input type="text" data-name="그룹" id="modify_hq" name="modify_hq" class="notEmpty" value="${data.HQ}">
			
			<span class="inputTitle">지점</span>
			<input type="text" data-name="지점" id="modify_store" name="modify_store" class="notEmpty" value="${data.STORE}">
			
			<span class="inputTitle">전자서명포트번호</span>
			<input type="text" data-name="전자서명포트번호" id="modify_autosign_port" name="modify_autosign_port" class="notEmpty" value="${data.AUTOSIGN_PORT}">
			
			<span class="inputTitle">등록자</span>
			<input type="text" data-name="등록자" id="modify_create_resi_no" name="modify_create_resi_no" class="notEmpty" disabled="disabled" value="${data.CREATE_RESI_NO}">
			
			<span class="inputTitle">수정자</span>
			<input type="text" data-name="수정자" id="modify_update_resi_no" name="modify_update_resi_no" class="notEmpty" value="${login_name }">

			<span class="inputTitle">상태</span>
			<select id="modify_delete_yn" name="modify_delete_yn" class="notEmpty">
				<option value="Y">사용중</option>
				<option value="N">비활성화</option>
			</select>
		</div>
		<h3>IP 수정</h3>
		<div class="top-row">
			<div class="wid-5 bor-r">
				<div class="table">
					<div class="wid-7">
						<input type="text" data-name="IP주소" id="modify_ip" name="modify_ip" class="notEmpty" value="${data.IP_ADDR}">
					</div>
					<div class="wid-3">
						<a class="btn btn03">직접입력</a>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">단말기 종류</div>
					<div>
						<select id="modify_tml_type" name="modify_tml_type" class="notEmpty" de-data="POS">
							<option value="P">POS</option>
							<option value="C">CAT</option>
						</select>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">POS 프린터</div>
					<div>
						<select id="modify_pos_print_yn" name="modify_pos_print_yn" class="notEmpty" de-data="POS">
							<option value="Y">있음</option>
							<option value="N">없음</option>
						</select>
					</div>
				</div>
				
			</div>
			<div class="wid-5">
				<div class="table">
					<div class="sear-tit">포트번호</div>
					<div>
						<div class="table table02">
							<div>발급기</div>
							<div>
								<input type="text" data-name="카드포트번호" id="modify_ppcard_port" name="modify_ppcard_port" class="notEmpty" value="${data.PPCARD_PORT}">
							</div>
						</div>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">POS 번호</div>
					<div>
						<input type="text" data-name="POS번호" id="modify_pos_no" name="modify_pos_no" class="notEmpty" value="${data.POS_NO}">
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">카드발급기</div>
					<div>
						<select id="modify_ppcard_print_yn" name="modify_ppcard_print_yn" class="notEmpty" de-data="카드발급기">
							<option value="Y">ID-2000ZP(RW)</option>
							<option value="W">ZP-2000(W)</option>
							<option value="N">없음</option>
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