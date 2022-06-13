<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function fncSubmitIp()
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
		$("#fncFormIp").ajaxSubmit({
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
<div>
	<form id="fncFormIp" name="fncFormIp" method="POST" action="./write_proc">
		<div class="dis-no">
			<span class="inputTitle">그룹</span>
			<input type="text" data-name="그룹" id="write_hq" name="write_hq" class="notEmpty">
			
			<span class="inputTitle">지점</span>
			<input type="text" data-name="지점" id="write_store" name="write_store" class="notEmpty">
			
			<span class="inputTitle">전자서명포트번호</span>
			<input type="text" data-name="전자서명포트번호" id="write_autosign_port" name="write_autosign_port" class="notEmpty">
			
			<span class="inputTitle">등록자</span>
			<input type="text" data-name="등록자" id="write_create_resi_no" name="write_create_resi_no" class="notEmpty" readonly="readonly" value="${login_name }">
			
			<span class="inputTitle">수정자</span>
			<input type="text" data-name="수정자" id="write_update_resi_no" name="write_update_resi_no" class="notEmpty" value="${login_name }">
	
			<span class="inputTitle">상태</span>
			<select id="write_delete_yn" name="write_delete_yn" class="notEmpty">
				<option value="Y">사용중</option>
				<option value="N">비활성화</option>
			</select>
		</div>
		<h3>IP 추가</h3>
		<div class="top-row">
			<div class="wid-5 bor-r">
				<div class="table">
					<div class="wid-7">
						<input type="text" data-name="IP주소" id="write_ip" name="write_ip" class="notEmpty" value="${now_ip }">
					</div>
					<div class="wid-3">
						<a class="btn btn03">직접입력</a>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">단말기 종류</div>
					<div>
						<select id="write_tml_type" name="write_tml_type" class="notEmpty" de-data="POS">
							<option value="P">POS</option>
							<option value="C">CAT</option>
						</select>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">POS 프린터</div>
					<div>
						<select id="write_pos_pritn_yn" name="write_pos_print_yn" class="notEmpty" de-data="POS프린트">
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
								<input type="text" data-name="카드포트번호" id="write_ppcard_port" name="write_ppcard_port" class="notEmpty">
							</div>
						</div>
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">POS 번호</div>
					<div>
						<input type="text" data-name="POS번호" id="write_pos_no" name="write_pos_no" class="notEmpty">
					</div>
				</div>
				<div class="table">
					<div class="sear-tit">카드발급기</div>
					<div>
						<select id="write_ppcard_print_yn" name="write_ppcard_print_yn" class="notEmpty" de-data="카드발급기">
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
		<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitIp();"><i class="material-icons">vertical_align_bottom</i>저장</a>
	</div>
</div>