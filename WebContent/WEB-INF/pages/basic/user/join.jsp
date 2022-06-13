<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta charset="utf-8">
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/function.js"></script>
<link rel="stylesheet" href="/inc/css/admin.css">
<script>
function fncSubmit()
{
	$("#fncForm").submit();
}
</script>

<form id="fncForm" name="fncForm" method="POST" action="./login">
	<input type="text" id="userId" name="userId" value="JclcjeEeP8hw6nPgqiKx8CsjDUFZNBFL">
</form>
<a onclick="javascript:fncSubmit();">가입하기</a>

