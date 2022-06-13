<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>
$(document).ready(function(){
	getLastYearSeason();
	
	getTarget();
});
function getLastYearSeason()
{
	$("#selYear").val('${year}');
}
function fncSubmit()
{
	$("#fncForm").ajaxSubmit({
		success: function(data)
		{
			console.log(data);
			var result = JSON.parse(data);
			if(result.isSuc == "success")
			{
				alert(result.msg);
			}
			else
			{
				alert(result.msg);
			}
		}
	});
}
function getTarget()
{
	$.ajax({
		type : "POST", 
		url : "./getTarget",
		dataType : "text",
		async:false,
		data : 
		{
			year : $("#selYear").val(),
			season : $("#selSeason").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var isB = false;
			var isS = false;
			var isP = false;
			var isW = false;
			for(var i = 0; i < result.length; i++)
			{
				if(result[i].STORE == "03")
				{
					$("#b_regis").val(comma(nullChk(result[i].REGIS_NO)));
					$("#b_pay").val(comma(nullChk(result[i].PAY)));
// 					$("#b_regis").addClass("blue-bg");
// 					$("#b_pay").addClass("red-bg");
// 					$("#b_regis").attr("readonly",true);
// 					$("#b_pay").attr("readonly",true);
					isB = true;
				}
				if(result[i].STORE == "02")
				{
					$("#s_regis").val(comma(nullChk(result[i].REGIS_NO)));
					$("#s_pay").val(comma(nullChk(result[i].PAY)));
// 					$("#s_regis").addClass("blue-bg");
// 					$("#s_pay").addClass("red-bg");
// 					$("#s_regis").attr("readonly",true);
// 					$("#s_pay").attr("readonly",true);
					isS = true;
				}
				if(result[i].STORE == "04")
				{
					$("#p_regis").val(comma(nullChk(result[i].REGIS_NO)));
					$("#p_pay").val(comma(nullChk(result[i].PAY)));
// 					$("#p_regis").addClass("blue-bg");
// 					$("#p_pay").addClass("red-bg");
// 					$("#p_regis").attr("readonly",true);
// 					$("#p_pay").attr("readonly",true);
					isP = true;
				}
				if(result[i].STORE == "05")
				{
					$("#w_regis").val(comma(nullChk(result[i].REGIS_NO)));
					$("#w_pay").val(comma(nullChk(result[i].PAY)));
// 					$("#w_regis").addClass("blue-bg");
// 					$("#w_pay").removeClass("red-line");
// 					$("#w_pay").addClass("red-bg");
// 					$("#w_regis").attr("readonly",true);
// 					$("#w_pay").attr("readonly",true);
					isW = true;
				}
			}
			if(!isB)
			{
				$("#b_regis").val('');
				$("#b_pay").val('');
// 				$("#b_regis").removeClass("blue-bg");
// 				$("#b_pay").addClass("red-line");
// 				$("#b_pay").removeClass("red-bg");
// 				$("#b_regis").attr("readonly",false);
// 				$("#b_pay").attr("readonly",false);
			}
			if(!isS)
			{
				$("#s_regis").val('');
				$("#s_pay").val('');
// 				$("#s_regis").removeClass("blue-bg");
// 				$("#s_pay").addClass("red-line");
// 				$("#s_pay").removeClass("red-bg");
// 				$("#s_regis").attr("readonly",false);
// 				$("#s_pay").attr("readonly",false);
			}
			if(!isP)
			{
				$("#p_regis").val('');
				$("#p_pay").val('');
// 				$("#p_regis").removeClass("blue-bg");
// 				$("#p_pay").addClass("red-line");
// 				$("#p_pay").removeClass("red-bg");
// 				$("#p_regis").attr("readonly",false);
// 				$("#p_pay").attr("readonly",false);
			}
			if(!isW)
			{
				$("#w_regis").val('');
				$("#w_pay").val('');
// 				$("#w_regis").removeClass("blue-bg");
// 				$("#w_pay").addClass("red-line");
// 				$("#w_pay").removeClass("red-bg");
// 				$("#w_regis").attr("readonly",false);
// 				$("#w_pay").attr("readonly",false);
			}
		}
	});	
}
</script>


<div class="sub-tit">
	<h2>목표입력</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>

<div class="row view-page">
	<div class="wid-centW_target">
		<div class="white-bg">
			<h3 class="h3-tit">목표입력</h3>
			<form id="fncForm" name="fncForm" method="POST" action="./target_proc">
				<div class="top-row tavle-input">
					<div class="wid-10">
						<div class="table">
							<div>
								<select de-data="${year}" id="selYear" name="selYear" onchange="getTarget()">
									<%
									int year = Utils.checkNullInt(request.getAttribute("year"));
									for(int i = year+1; i > 1980; i--)
									{
										if(i == year)
										{
											%>
											<option value="<%=i%>" selected><%=i%></option>
											<%
										}
										else
										{
											%>
											<option value="<%=i%>"><%=i%></option>
											<%
										}
									}
									%>
								</select>
								<select de-data="봄" id="selSeason" name="selSeason" onchange="getTarget()">
									<option value="1">봄</option>
									<option value="2">여름</option>
									<option value="3">가을</option>
									<option value="4">겨울</option>									
								</select>
							</div>
						</div>
					</div>
					
				</div>
				
				<div class="bor-div">
					<div class="top-row targ-row_tit">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit"></div>
								<div>
									<p>회원수</p>
									<p>매출</p>								
								</div>
							</div>
						</div>
					</div>
					<div class="top-row targ-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">분당점</div>
								<div>
									<input type="text" id="b_regis" name="b_regis" class="inp-50 comma" value="" placeholder="">
									<input type="text" id="b_pay" name="b_pay" class="inp-50 red-line comma" value="" placeholder="">
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row targ-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">수원점</div>
								<div>
									<input type="text" id="s_regis" name="s_regis" class="inp-50 comma" value="" placeholder="">
									<input type="text" id="s_pay" name="s_pay" class="inp-50 red-line comma" value="" placeholder="">
	<!-- 								<input type="text" class="inp-50 blue-bg"  value="30" placeholder="" readOnly> -->
	<!-- 								<input type="text" class="inp-50 red-bg" value="200,000,000" placeholder="" readOnly> -->
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row targ-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">평택점</div>
								<div>
									<input type="text" id="p_regis" name="p_regis" class="inp-50 comma" value="" placeholder="">
									<input type="text" id="p_pay" name="p_pay" class="inp-50 red-line comma" value="" placeholder="">
								</div>
							</div>
						</div>
					</div>
					
					<div class="top-row targ-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">원주점</div>
								<div>
									<input type="text" id="w_regis" name="w_regis" class="inp-50 comma" value="" placeholder="">
									<input type="text" id="w_pay" name="w_pay" class="inp-50 red-line comma" value="" placeholder="">
								</div>
							</div>
						</div>
					</div>
					
					
				</div>
			</form>			
			
		</div>
		
		<div class="btn-wr text-center">
			<a class="btn btn01 ok-btn" onclick="javascript:location.reload();">취소</a>
			<a class="btn btn02 ok-btn" onclick="fncSubmit()">저장</a>
		</div>

	</div>
</div>




<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>