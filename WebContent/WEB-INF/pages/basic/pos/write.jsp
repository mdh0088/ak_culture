<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function fncSubmitPos()
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
		$("#fncFormPos").ajaxSubmit({
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
function check_value(e){
	var now_len;
}
</script>
<div>
	<form id="fncFormPos" name="fncFormPos" method="POST" action="./write_proc">
		<h3>POS 추가</h3>
		<div class="top-row inp-bgno inp-bgno02">
			<div class="ak-wrap_new">
				<div class="wid-5">
					<div class="table">
						<div class="sear-tit">지점</div>
						<div>
							<select id="write_sale_end_yn" name="write_sale_end_yn" class="notEmpty" de-data="03">
								<option value="Y">04</option>
								<option value="N">05</option>
							</select>
						</div>
					</div>
					<div class="table">
						<div class="sear-tit">영업일자</div>
						<div>
							<select id="write_sale_end_yn" name="write_sale_end_yn" class="notEmpty" de-data="2019-08-31">
								<option value="Y">2019-08-31</option>
								<option value="N">2019-08-31</option>
							</select>
						</div>
					</div>
					<div class="table">
						<div class="sear-tit">영업여부</div>
						<div>
							<ul class="radio-ul">
								<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">O</label></li>
								<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">X</label></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="wid-5 wid-5_last">
					<div class="table">
						<div class="sear-tit sear-tit_120 sear-tit_left">POS 번호</div>
						<div>
							<select id="write_sale_end_yn" name="write_sale_end_yn" class="notEmpty" de-data="070001">
								<option value="Y">070001</option>
								<option value="N">070001</option>
							</select>
						</div>
					</div>
					<div class="table">
						<div class="sear-tit sear-tit_120 sear-tit_left">개설여부</div>
						<div>
							<ul class="radio-ul">
								<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">O</label></li>
								<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">X</label></li>
							</ul>
						</div>
					</div>
					<div class="table">
						<div class="sear-tit sear-tit_120 sear-tit_left">정산여부</div>
						<div>
							<ul class="radio-ul">
								<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">O</label></li>
								<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">X</label></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="btn-wr text-center">
		<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitPos();">저장</a>
	</div>
	</form>
</div>