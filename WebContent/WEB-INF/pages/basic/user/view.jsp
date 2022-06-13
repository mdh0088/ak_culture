<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>
var isLoading = false;
function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".btn02").addClass("loading-sear");
	$(".btn02").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".btn02").removeClass("loading-sear");		
	$(".btn02").prop("disabled", false);
	isLoading = false;
}
//closest polyfill START
if (!Element.prototype.matches) {
	  Element.prototype.matches = Element.prototype.msMatchesSelector || 
	                              Element.prototype.webkitMatchesSelector;
	}
if (!Element.prototype.closest) {
  Element.prototype.closest = function(s) {
    var el = this;

    do {
      if (Element.prototype.matches.call(el, s)) return el;
      el = el.parentElement || el.parentNode;
    } while (el !== null && el.nodeType === 1);
    return null;
  };
}
//closest polyfill END
$(function(){
	$(".permi-cont").show();
	$(".permi-a").css("display","inline-block");
})
console.log("${data}");
var auth_name = "${data.AUTH_NAME}";
$( document ).ready(function() {
	$(".permi-cont .select-box").click(function(){
		$(".auth_level_name")[0].textContent = auth_name + "(사용자 정의)";
	});
	$(".permi-cont .td-chk label").click(function(){
		$(".auth_level_name")[0].textContent = auth_name + "(사용자 정의)";
	});
	
	/* 201113 추가!!! */
	if('${data.AUTH_CUSTOM}' == "N"){
		getCheck('${data.AUTH_NAME}');
	}
	/* 추가끝 */
	
	if('${data.STATUS}' != ""){
		Array.prototype.slice.call(document.getElementsByName("view_status")).filter(function(el){
			return el.value == '${data.STATUS}';
		})[0].setAttribute("checked", "checked");
		getAuth();
	}
	if('${data.LEADER}' == '1'){
		document.getElementById("view_leader").checked = true;
	}
	if('${data.AUTH_NAME}' != ""){
		document.getElementById("auth_level_name").parentElement.querySelector(".selectedOption").textContent = '${data.AUTH_NAME}';
		Array.prototype.slice.call(document.getElementById("auth_level_name").options).filter(function(option){
			return option.textContent == '${data.AUTH_NAME}';
		})[0].setAttribute("selected", "selected");
	}
	if('${data.STORE}' != ""){
		$("#rep_store").val('${data.STORE}');
		$(".rep_store").html('${data.STORE_NM}');
// 		var rep_store_el = Array.prototype.slice.call(document.getElementById("rep_store").options).filter(function(option){
// 			return option.value == '${data.REP_STORE}';
// 		})[0];
// 		rep_store_el.setAttribute("selected", "selected");
// 		document.getElementById("rep_store").parentElement.querySelector(".selectedOption").textContent = rep_store_el.textContent;
	}
	if('${data.AUTH_CUSTOM}' == "Y"){
		document.getElementsByClassName("auth_level_name")[0].textContent = auth_name + "(사용자 정의)";
	}
	
	


});
function getAuth(val){
	resetAuth();
	var seq_no = "";
	if(nullChk(val) != ""){
		seq_no = val;
	}else{
		seq_no = document.getElementById("seq_no").value;
	}
	$.ajax({
		data:{
			seq_no: seq_no
		},
		type: "POST",
		url: "/auth/getAuth",
		success: function(data){
			for(var i = 0; i < data.length; i++){
				var item = data[i];
				var container = document.querySelector("[data-addr='"+item.AUTH_URI+"']");
				if(nullChk(item.AUTH_KEY) != ""){
					container.value = item.AUTH_KEY;
					var text = container.querySelector("option[value='"+item.AUTH_KEY+"']").innerText;
				}else{
					container.value = "";
					var text = "접근불가";
				}
				Array.prototype.slice.call(container).filter(function(el){
					return el.textContent === text;
				})[0].setAttribute("selected", "selected");
				container.parentElement.querySelector(".selectedOption").innerText = text;
			}
			chk_color();
		}
	});
}
function getBizno(){
	var bizno = document.getElementById("bizno");
	if(bizno.value == ""){
		alert("사번을 입력해주세요");
		bizno.focus();
		return false;
	}
	$.ajax({
		data: {
			bizno: bizno.value
		},
		type: "POST",
		url: "./getUser_bizno",
		success: function(data){
			if(data != ""){
				document.getElementById("name").value = nullChk(data.NAME);
				document.getElementById("company").value = nullChk(data.COMPANY);
				document.getElementById("tim").value = nullChk(data.TIM);
				document.getElementById("store").value = nullChk(data.STORE);
				document.getElementById("last_login").value = nullChk(cutDate(data.LAST_LOGIN));
				
				Array.prototype.slice.call(document.getElementsByName("view_status")).filter(function(el){
					return el.value == nullChk(data.STATUS);
				})[0].setAttribute("checked", "checked");
				if(data.LEADER == '1'){
					document.getElementById("view_leader").checked = true;
				}else{
					document.getElementById("view_leader").checked = false;
				}
				if(nullChk(data.AUTH_NAME) != ""){
					auth_name = data.AUTH_NAME;
					document.getElementById("auth_level_name").parentElement.querySelector(".selectedOption").textContent = data.AUTH_NAME;
					Array.prototype.slice.call(document.getElementById("auth_level_name").options).filter(function(option){
						return option.textContent == data.AUTH_NAME;
					})[0].setAttribute("selected", "selected");
				}
				
				var rep_store_el = Array.prototype.slice.call(document.getElementById("rep_store").options).filter(function(option){
					return option.value == nullChk(data.REP_STORE);
				})[0];
				rep_store_el.setAttribute("selected", "selected");
				document.getElementById("rep_store").parentElement.querySelector(".selectedOption").textContent = rep_store_el.textContent;

				if(nullChk(data.AUTH_CUSTOM) != "" && data.AUTH_CUSTOM == "Y"){
					document.getElementsByClassName("auth_level_name")[0].textContent = auth_name + "(사용자 정의)";
				}
				document.getElementById("seq_no").value = data.SEQ_NO;
				getAuth(data.SEQ_NO);
			}else{
				alert("일치하는 데이터가 없습니다.");
				return false;
			}
		}		
	})
}
//저장 버튼
function fncSubmit()
{
	if(!isLoading)
	{
		getListStart();
		if(nullChk(document.getElementById("seq_no").value) == ""){
			alert("조회된 데이터가 없습니다.");
			return false;
		}
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
				data:{
					auth_chk: "Y"	
				},
				success: function(data)
				{
					var result = JSON.parse(data);
		    		if(result.isSuc == "success")
		    		{
		    			var data_length = document.getElementById("auth_tb").querySelectorAll("tbody input[type=checkbox]:checked").length;
		    			if(data_length > 0){
			    			fncSubmitAuth();	//반영
		    			}else{
			    			alert(result.msg);
		    			}
		    			location.reload();
		    		}
		    		else
		    		{
		    			alert(result.msg);
		    		}
					getListEnd();
				}
			});
		}
	}
	
}
//반영 버튼
function fncSubmitAuth()
{
	if(nullChk(document.getElementById("seq_no").value) == ""){
		alert("조회된 데이터가 없습니다.");
		return false;
	}
	var cont = document.getElementById("auth_tb").querySelectorAll("select[data-addr*='/']");
	var fnc_data = Array.prototype.slice.call(cont).filter(function(el){
		if(el.parentElement.parentElement.parentElement.querySelector("input[type=checkbox]:checked")){
			return el;
		}
	});
	if(fnc_data.length < 1 ){
		alert("선택된 자료가 없습니다");
		return false;
	}
	var seq_no = document.getElementById("seq_no").value;
	if(!isLoading)
	{
		getListStart();
		$(fnc_data).each(function(currentIndex, currentValue){
			$(".btn02").addClass("loading-sear");
			$(".btn02").prop("disabled", true);
			if(!loopStat){
				return false;
			}
			var auth_uri = currentValue.dataset.addr;
			var auth_key = currentValue.value;
			if(nullChk(auth_uri) != ""){
				
		 		$("#authFncForm").ajaxSubmit({
		 			async: false,	/*	기책님 요기에 넣었습니다!!!!	*/
					data: {
						seq_no: seq_no,
						auth_uri: auth_uri,
						auth_key: auth_key,
						auth_chk: "Y"
					},
					url: "/auth/proc",
					success: function(data)
					{
			    		if(data.isSuc == "success")
			    		{
			    			if(currentIndex == fnc_data.length-1){
			    				customChk();	//사용자정의 체크
			    				alert(data.msg);
			    			}
			    		}
			    		else
			    		{
			    			alert("저장중 오류가 발생하였습니다.");
			    			return false;
			    		}
					}
				});
			}
		});
	}
	getListEnd();
}
function customChk(){
	var seq_no = document.getElementById("seq_no").value;
	if($(".auth_level_name")[0].textContent.indexOf("(사용자 정의)") > -1){
		$.ajax({
			data: {
				seq_no: seq_no
			},
			url: "/basic/user/auth_custom"
		});
	}
}
//체크한 부분만 변환
function checked_option(el){
	var fnc_data = document.getElementById("auth_tb").querySelectorAll("tbody select");
	var data_length = document.getElementById("auth_tb").querySelectorAll("tbody input[type=checkbox]:checked").length ;
	if(data_length == 0 ){
		alert("선택된 자료가 없습니다");
		return false;
	}
	$(fnc_data).each(function(currentIndex, currentValue){
		var chk_checked = currentValue.parentElement.parentElement.parentElement.querySelector("input[type=checkbox]").checked;
		if(chk_checked){
			currentValue.value = el.value;
			Array.prototype.slice.call(currentValue.options).filter(function(option){
				return option.value == el.value;
			})[0].setAttribute("selected", "selected");
			currentValue.parentElement.querySelector(".selectedOption").textContent = el.options[el.selectedIndex].text;
		}
	});
	el.parentElement.querySelector(".selectedOption").textContent = "권한선택";
	document.getElementById("auth_level_name").selectedIndex = 0;
	chk_color();
}

//셀렉트박스
function chk_part_option(data){
	var select_arr = data.closest("tbody").querySelectorAll(".toggle-o select");
	for(var i = 0; i < select_arr.length; i++){
		var text;
		if(data.value == ""){
			text = "접근불가";
		}else{
			text = select_arr[i].querySelector("option[value="+data.value+"]").textContent;
		}
		var b = data.closest("tbody").querySelectorAll(".toggle-o .selectedOption");
		b[i].textContent = text;
		select_arr[i].value = data.value;
	}
	chk_color();
}
function chk_one_option(data){
	chk_color();
}
</script>

<div class="sub-tit">
	<h2>운영자 상세</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
<div class="row gift-wrap view-page">
	<div class="wid-5">
		<div class="btn-wrap btn-right">
			<A class="btn btn01 btn01_1" href="../user/list"><i class="material-icons">menu</i>목록</A>
			<A class="btn btn02" onclick="javascript:fncSubmit();">저장</A>
		</div>
		<div class="white-bg table-view ak-wrap_new">
			<form id="fncForm" name="fncForm" method="POST" action="./modify">
				<input type="hidden" id="seq_no" name="seq_no" value="${seq_no}">
				<h3>승인상태</h3>
				<div class="bor-div">
					<ul class="radio-ul">
						<li><input type="radio" id="view_status2" name="view_status" value="2"><label for="view_status2">승인</label></li>
						<li><input type="radio" id="view_status1" name="view_status" value="1"><label for="view_status1">미승인</label></li>
					</ul>
				</div> 
				<div class="bor-div ad-info">
					<div class="top-row top-row01">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">사번</div>
								<div>
									<div class="table">
										<div class="wid-66">
											<input type="text" id="bizno" name="bizno" class="" onkeypress="excuteEnter(getBizno);" value="${data.BIZNO}">
										</div>
										<div>
											<a class="btn btn02" onclick="javascript:getBizno();">불러오기</a>										
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="top-row top-row02 table-input">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit">이름</div>
								<div>
									<input type="text" id="name" name="name" value="${data.NAME}" class="inputDisabled" >
								</div>
							</div>
						</div>
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_120 sear-tit_left">소속</div>
								<div>
									<input type="text" id="company" name="company" value="${data.COMPANY}" class="inputDisabled" >
								</div>
							</div>
						</div>
					</div>
					<div class="top-row top-row02 table-input">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit">팀</div>
								<div>
									<input type="text" id="tim" name="tim" value="${data.TIM}" class="inputDisabled" >
								</div>
							</div>
						</div>
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_120 sear-tit_left">지점</div>
								<div>
									<input type="text" id="store" name="store" value="${data.STORE }" class="inputDisabled" >
								</div>
							</div>
						</div>
					</div>
					<div class="top-row top-row02 table-input">
						<div class="table">
							<div class="sear-tit">권한</div>
							<div>
								<ul class="chk-ul">
									<!-- <li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">팀장</label></li> -->
									<li>
										<input type="checkbox" id="view_leader" name="view_leader" value="1">
										<label for="view_leader">팀장</label>
									</li>
								</ul>

							</div>
						</div>
					</div>
					
								
				</div>
				<div class="bor-div">
					<div class="top-row top-row01">
						<div class="wid-10 wid-10mar">
							<div class="table">
								<div class="sear-tit sear-tit_120">최종로그인</div>
								<div>
									<div class="table">
										<div><input type="text" id="last_login" name="last_login" value="${data.LAST_LOGIN}" class="inputDisabled input-text txt100" ><a class="bnt-l btn btn03" href="log"><i class="material-icons">menu</i>활동로그 확인</a></div>
									</div>					
								</div>
							</div>
						</div>
					</div>
					<div class="top-row">
						<div class="wid-10 wid-10mar">
							<div class="table">
								<div class="sear-tit sear-tit_120">운영자 권한설정</div>
								<div>
									<div class="table">
										<div class="select sel-245">
											<select class="wid-10" id="auth_level_name" name="auth_level_name" de-data="선택하세요." onchange="getCheck(this.value);">
													<option value="">선택하세요.</option>
												<c:forEach var="i" items="${cate }"> 
													<option value="${i.NAME}">${i.NAME}</option>
												</c:forEach>
											</select>
										</div>
									</div>								
								</div>
							</div>
						</div>
					</div>
					<div class="top-row top-row01">
						<div class="wid-10 wid-10mar">
							<div class="table">
								<div class="sear-tit sear-tit_120">대표지점 선택</div>
								<div>
									<div class="select sel-245">
										<select data-name="지점" id="rep_store" name="rep_store" de-data="선택">
											
											<c:forEach var="item" items="${branchList}">
												<option value="${item.SUB_CODE}">${item.SHORT_NAME}</option>
											</c:forEach>
											<option value="00">본부</option>
										</select>
									</div>
								</div>
							</div>
						</div>
					</div>	
				</div>
			</form>
			
		</div> <!-- //white-bg -->
	</div> <!-- //wid-5 -->
	
	<div class="wid-5">

		<div class="btn-wrap btn-right">
			<A class="btn btn02 permi-a" href="../user/level">운영자 권한 추가/편집하기</A>
			<A class="btn btn01 btn01_1" href="../user/log">운영자 로그 관리</A>
			
		</div>
		<div class="white-bg table-view permi-cont">
			<h3>권한설정
				<div class="sel-arr sel-scrno float-right">
					<select de-data="권한선택" onchange="checked_option(this);">
						<option value="RW">전체</option>
						<option value="R">보기</option>
						<option value="">접근불가</option>
					</select>
			
				</div>
			</h3>
	
		
			<form id="authFncForm">
			</form>
			<div class="table-wr">
				<div class="table-cap table">
					<div class="table-list table-list02 table-ak">
						<jsp:include page="./authTB.jsp"/>
					</div>
				</div>
			</div><!-- //table-wr -->
			<div class="btn-wr text-center">
				<a class="btn btn02 ok-btn icon-r" onclick="fncSubmitAuth();">반영</a>
			</div>
			
		</div> <!-- //white-bg -->
	</div> <!-- //wid-5 -->
</div><!-- //row -->
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>