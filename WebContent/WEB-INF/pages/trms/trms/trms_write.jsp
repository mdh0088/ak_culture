<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>
$(document).ready(function(){
	setBundang();
	$("#sale_ymd").val(cutDate(getNow()));
	$("#sod_date").val(cutDate(getNow()+""+getTime()));
});
function fncSubmit()
{
	if($("#pos").val() == "070020")
	{
		alert("070020포스는 준비금 등록을 할 수 없습니다.");
		return;
	}
	else
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
function itCancle()
{
	if($("#pos").val() == "070020")
	{
		alert("070020포스는 준비금 등록을 할 수 없습니다.");
		return;
	}
	else
	{
		if(confirm("준비금을 취소하시겠습니까?"))
		{
			$.ajax({
				type : "POST", 
				url : "./itCancle",
				dataType : "text",
				async : false,
				data : 
				{
					selBranch : $("#selBranch").val(),
					pos : $("#pos").val(),
					adjust_item : '074',
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
	}
} 
function getIt()
{
	$.ajax({
		type : "POST", 
		url : "./getIt",
		dataType : "text",
		async : false,
		data : 
		{
			selBranch : $("#selBranch").val(),
			pos : $("#pos").val(),
			adjust_item : '074',
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if(result.length > 0)
			{
				$("#sale_ymd").val(cutDate(result[0].SALE_YMD));
				$("#sod_date").val(cutDate(result[0].SOD_DATE));
				$("#tot_amt").val(comma(result[0].TOT_AMT));
			}
			else
			{
				alert("준비금이 등록되지 않았습니다.");
			}
		}
	});
}
</script>

<div class="sub-tit">
	<h2>준비금 등록</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>

<div class="row view-page">
	<div class="wid-centW">
		<div class="white-bg">
			<h3 class="h3-tit">준비금 등록</h3>
			<form id="fncForm" name="fncForm" method="POST" action="./write_proc">
				<input type="hidden" id="auth_chk" name="auth_chk" value="Y">
				<div class="bor-div">
<!-- 					<div class="top-row tavle-input"> -->
<!-- 						<div class="wid-10"> -->
<!-- 							<div class="table"> -->
<!-- 								<div class="sear-tit">그룹</div> -->
<!-- 								<div> -->
<!-- 									<select id="hq" name="hq" de-data="[00] 애경유통"> -->
<!-- 										<option value="00">[00] 애경유통</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
					<div class="top-row tavle-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">지점</div>
								<div>
									<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch">
										<c:forEach var="i" items="${branchList}" varStatus="loop">
											<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row tavle-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">POS</div>
								<div>
									<input type="text" id="pos" name="pos" value="${pos_no}" class="inp-100 inputDisabled" placeholder="" readOnly>
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row tavle-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">영업일자</div>
								<div>
									<input type="text" id="sale_ymd" name="sale_ymd" value="" class="inp-100 inputDisabled" placeholder="" readOnly>
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row tavle-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">개설시간</div>
								<div>
									<input type="text" id="sod_date" name="sod_date" value="" class="inp-100 inputDisabled" placeholder="" readOnly>
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row tavle-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">정산시간</div>
								<div>
									<input type="text" id="" name="" value="" class="inp-100 inputDisabled" placeholder="" readOnly>
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row tavle-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">준비금</div>
								<div>
									<input type="text" id="tot_amt" name="tot_amt" value="0" class="inp-82 text-right notEmpty comma" data-name="준비금" placeholder="">
									<a class="bor-btn btn03 mrg-l6" onclick="javascript:getIt();">조회</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row tavle-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">담당자</div>
								<div>
									<input type="text" value="${login_name}" class="inp-100 inputDisabled" placeholder="" readOnly>
								</div>
							</div>
						</div>
					</div>
				</div>			
			</form>
		</div>
		
		<div class="btn-wr text-center">
			<a class="btn btn01 ok-btn" onclick="javascript:itCancle();">취소</a>
			<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();">준비금 등록/수정</a>
		</div>

	</div>
</div>




<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>