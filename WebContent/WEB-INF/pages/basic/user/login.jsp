<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=11">
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/function.js"></script>
<link rel="stylesheet" href="/inc/css/admin.css">
<script>

var isLogin = "<%=session.getAttribute("login_id")%>";
var link = location.href;
if (isLogin != null && isLogin != "null" && link.indexOf("admin/basic/user/login") > -1) {
	location.href="/main";
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
		$("#fncForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			location.href=result.first_uri;
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}

$(document).ready(function(){
	var he = $(window).outerHeight();
	
	$(".login-r").css("height",he);
	
	if(nullChk('${userId}') != "")
	{
		$("#userId").val('${userId}');
		$("#fncForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			location.href=result.first_uri;
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
		
});
</script>
<div class="login-wrap table">
	<div class="login-l">
		<div class="lol-txt">
			<img src="/img/left-logo.png" alt="ak문화센터"/>
			<p>우리는 앞서가는 사고, 앞서가는 기술, 앞서가는 경영으로 <br>
				풍요롭고 행복한 삶을 창조하는  <br>
				기업이 되고자하는 경영이념을 바탕으로  <br> 
				고객과 국가사회에 공헌하는 존경받는 기업을 지향합니다.</p>
		</div>
	</div>
	<div class="login-r">
		<div class="div-auto">
			<img src="/img/logo.png">
			<form id="fncForm" name="fncForm" method="POST" action="./login_proc">
				<input type="hidden" id="userId" name="userId">
				<div class="login-inwr">
					<div class="login-intop">
						<input type="text" data-name="아이디" id="login_id" name="login_id" class="notEmpty" placeholder="아이디" />
						
						<input type="password" data-name="비밀번호" id="login_pw" name="login_pw" class="notEmpty" onkeypress="excuteEnter(fncSubmit)" placeholder="비밀번호" />
					</div>
					<div class="login-inbot">
						<div><input type='checkbox' id="saveId" name='saveId' value='saveId' /><label for='saveId'>아이디 저장</label></div>
						<div><input type='checkbox' id="saveLogin" name='saveLogin' value='saveLogin' /><label for='saveLogin'>로그인 상태 유지</label></div>
					</div>
					<div class="log-btnwr">
						<a onclick="javascript:fncSubmit();">Login</a>
					</div>
					<div class="log-btnbot">
						<p class="en-txt">Forget Password?<a href="#">Click Here</a></p>
						<p class="dis-no">관리자 회원가입<a href="./join">Click Here</a></p>
					</div>
				</div>
				
				<div>
					
				</div>
			</form>
		</div>
	</div>
</div>

