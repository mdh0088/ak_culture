<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

var eng_nm="";
var ptl_pw="";
var di="";
var ci="";

function phoneSearch()
{
	$('#search_layer').fadeIn(200);	
	$('#searchPhone').focus();	
}
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


function getUserList()
{
	if($("#searchPhone").val() == "")
	{
		alert("휴대폰번호를 윕력해주세요.");
		$("#searchPhone").focus();
		return;
	}
	else
	{
		$('.searchResult').empty();
		
		if(!isLoading)
		{
			getListStart();
			$.ajax({
				type : "POST", 
				url : "./getUserListByMembers",
				dataType : "text",
				data : 
				{
					searchPhone : $("#searchPhone").val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					console.log(data);
					var result = JSON.parse(data);
					
					$("#searchResult").html("");
					$(".searchResult").append(result[0].CUS_PN+" | "+result[0].MTEL_IDENT_NO+"-"+result[0].MMT_EX_NO+"-"+result[0].MTEL_UNIQ_NO);
					for(var i = 0; i < result.length; i++)
					{
						$("#searchResult").append("<option value='"+result[i].CUS_NO+"'>"+result[i].CUS_PN+" | "+result[i].MTEL_IDENT_NO+"-"+result[i].MMT_EX_NO+"-"+result[i].MTEL_UNIQ_NO+"</option>");
						$(".searchResult_ul").append("<li>"+result[i].CUS_PN+" | "+result[i].MTEL_IDENT_NO+"-"+result[i].MMT_EX_NO+"-"+result[i].MTEL_UNIQ_NO+"</li>");
					}
					getListEnd();
				}
			});
		}
	}
}
function choose_confirm()
{
	$('#search_layer').fadeOut(200);
	$.ajax({
		type : "POST", 
		url : "./getUserByMembers",
		dataType : "text",
		async : false,
		data : 
		{
			cus_no : $("#searchResult").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if (result.length!=0) {
				
				if (result.CUS_PN!="" && result.CUS_PN!=null) {
				 	$("#kor_nm").val(result.CUS_PN);				
				}
				
				if (result.ENG_PN!="" && result.ENG_PN!=null) {
					//$("#eng_nm").val(result.ENG_PN);
					eng_nm=result.ENG_PN;
				}
				
			 	if (result.BMD!="" && result.BMD!=null) {
			 		$("#birth_ymd").val(result.BMD);
			 	}
			 	
			 	if (result.EMAIL_ADDR!="" && result.EMAIL_ADDR!=null) {
			 		$("#email_addr").val(result.EMAIL_ADDR);
			 	}
			 	
			 	if (result.PHONE_NO!="" && result.PHONE_NO!=null) {
			 		$("#phone_no").val(result.PHONE_NO);
			 	}
			 	
			 	if (result.CUS_NO!="" && result.CUS_NO!=null) {
			 		$("#cus_no").val(result.CUS_NO);
			 	}
			 	
			 	if (result.PTL_ID!="" && result.PTL_ID!=null) {
			 		$("#ptl_id").val(result.PTL_ID);
			 	}
			 	
			 	if (result.PTL_PW!="" && result.PTL_PW!=null) {
			 		//$("#ptl_pw").val(result.PTL_PW);
			 		ptl_pw = result.PTL_PW;
			 	}
			 	
			 	if (result.DI!="" && result.DI!=null) {
			 		di = result.DI;
			 		//$("#di").val(result.DI);
			 	}
			 	
			 	if (result.CI!="" && result.CI!=null) {
			 		ci = result.CI;
			 		//$("#ci").val(result.CI);
			 	}
			 	
			 	if (result.RG_DTM!="" && result.RG_DTM!=null) {
			 		$("#create_date").val(result.RG_DTM);
			 	}
			 	
			 	if (result.MEM_CARD_NO!="" && result.MEM_CARD_NO!=null) {
			 		$("#card_no").val(result.MEM_CARD_NO);
			 	}
			 	
			 	if (result.NTR_DC!="" && result.NTR_DC!=null) {
			 		if (result.NTR_DC=='M') {
						$('#rad-male').prop("checked",true);
					}else{
						$('#rad-female').prop("checked",true);
					}
			 	}
			 	
			 	if (result.PSNO!="" && result.PSNO!=null) {
			 		$('#postcode').val(result.PSNO);
			 	}
			 	
			 	if (result.PNADD!="" && result.PNADD!=null) {
			 		$('#addr_tx1').val(result.PNADD);	
			 	}
			 	
			 	if (result.DTS_ADDR!="" && result.DTS_ADDR!=null) {
			 		$('#addr_tx2').val(result.DTS_ADDR);
			 	}
			 	
			 	
			}
			
		}
	});
	
	/*
	$.ajax({
		type : "POST", 
		url : "/common/getUserByMembersCard",
		dataType : "text",
		async : false,
		data : 
		{
			cus_no : $("#searchResult").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
		 	$("#card_no").val(result.CARD_NO);
			
		}
	});
	*/
	
}

var closed_cnt = 2;
function add_closed(){

	if ($('.child').length>=2) { //최대 3명
		return;
	}
	
	var inner = "";
	inner += '<div id="closed_div_'+closed_cnt+'" class="child">';
	
	inner += '	<div class="wid-4">';
	inner += '		<input type="text" id="" name="" class="child_name inp-100" placeholder="이름을 입력하세요.">';
	inner += '	</div>';
	
	inner +='	<div class="wid-15">';
	inner +='		<select id="" class="child_gender_'+closed_cnt+'" name="child_gender_'+closed_cnt+'" de-data="남">';
	inner +='			<option value="M">남</option>';
	inner +='			<option value="F">여</option>';
	inner +='		</select>';
	inner +='	</div>';
	
	
	inner += '	<div class="wid-3">';
	inner += '		<div class="cal-input cal-input02">';
	inner += '			<input type="text" placeholder="생년월일" id="child_ymd_'+closed_cnt+'" class="child_ymd child_ymd_'+closed_cnt+' date-i" readonly="readonly" />';
	inner += '			<i class="material-icons">event_available</i>';
	inner += '		</div>';
	inner += '	</div>';
		
	inner += '	<div class="wid-1">';
	inner += '		<div class="btn-row"><i class="material-icons remove" onclick="remove_closed('+closed_cnt+')">remove_circle_outline</i></div>';
	inner += '	</div>';
	
	inner += '</div>';
	$(".table-mem02").append(inner);
	closed_cnt ++;
	
}

function remove_closed(idx)
{
	$("#closed_div_"+idx).remove();
}


function save_cus_info()
{
	
		var sex_fg="";
		var marry_fg="";
		var email_yn="";
		var sms_yn="";
		
		var child_name="";
		var child_gender="";
		var child_ymd="";
		var child_age="";
		
		$('.child_name').each(function(){
			child_name = child_name+$(this).val()+'|';
			child_gender = child_gender+$(this).parent().next().find('select').val()+'|';
			child_ymd  = child_ymd+$(this).parent().next().next().find('input').val()+'|';
			child_age  = child_age+calcAge($(this).parent().next().next().find('input').val())+'|';
		})
		
		
		
		var post_value=$('#postcode').val();
		var post1_val = post_value.substr(0,3);
		var post2_val = post_value.substr(3);
		 
		 if($('#rad-male').prop("checked")==1) {
			 sex_fg="M";
		 }else if($('#rad-female').prop("checked")==1){
			 sex_fg="F";
		 }
		 
		 if($('#married_a').prop("checked")==1) {
			 marry_fg="1";
		 }else if($('#married_b').prop("checked")==1){
			 marry_fg="2";
		 }
		 
		 
		 if($('#email_chk').prop("checked")==1) {
			 email_yn="Y";
		 }else{
			 email_yn="N";
		 }
		 
		 if($('#sms_chk').prop("checked")==1) {
			 sms_yn="Y";
		 }else{
			 sms_yn="N";
		 }
		 

		 
		 $.ajax({
				type : "POST", 
				url : "./write_proc",
				dataType : "text",
				async : false,
				data : 
				{
					
					kor_nm:$('#kor_nm').val(),
					eng_nm:eng_nm,
					birth_ymd:$('#birth_ymd').val(),
					sex_fg:sex_fg,
					marry_fg:marry_fg,
					marry_ymd:$('#marry_ymd').val(),
					
					post_no1:post1_val,
					post_no2:post2_val,
					addr_tx1:$('#addr_tx1').val(),
					addr_tx2:$('#addr_tx2').val(),
					
					phone_no:$('#phone_no').val(),
					h_phone_no_1:$('#h_phone_no_1').val(),
					h_phone_no_2:$('#h_phone_no_2').val(),
					h_phone_no_3:$('#h_phone_no_3').val(),
					
					email_addr:$('#email_addr').val(),
					email_yn:email_yn,
					sms_yn:sms_yn,
					point_no:$('#card_no').val(),
					ptl_id:$('#ptl_id').val(),
					cus_no:$("#searchResult").val(),
					ptl_pw:ptl_pw,
					di:di,
					ci:ci,
					car_no: $('#car_no').val(),
					memo_cont : $('#memo_cont').val(),
					child_name: child_name,
					child_gender : child_gender,
					child_ymd : child_ymd,
					child_age : child_age,
					auth_chk:"Y"
					
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					console.log(data);
					var result = JSON.parse(data);
					
					alert(result.msg);
	    			location.reload();
				}
			});
	
}


</script>
<div class="sub-tit">
	<h2>회원등록</h2>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn01" href="/member/lect/view"><i class="material-icons">add</i>수강신청</a>
	</div>
</div>


<form id="fncForm" name="fncForm" method="post" action="./write_proc">
	<input type="hidden" id="eng_nm" name="eng_nm" value="">
	<input type="hidden" id="email_yn" name="email_yn" value="">
	<input type="hidden" id="sms_yn" name="sms_yn" value="">
	<input type="hidden" id="sex_fg" name="sex_fg" value="">
	<input type="hidden" id="marry_fg" name="marry_fg" value="">
	<input type="hidden" id="post_no1" name="post_no1" value="">
	<input type="hidden" id="post_no2" name="post_no2" value="">
	
	<input type="hidden" id="ptl_pw" name="ptl_pw" value="">
	<input type="hidden" id="di" name="di" value="">
	<input type="hidden" id="ci" name="ci" value="">
	
	<div class="row view-page mem-manage men-join">
		<div class="wid-5">
			<div class="white-bg bg-pad">
				<div class="bor-div">
					<h3 class="h3-tit">기본정보</h3>
					<div class="table-top bg-gray lecr-sear lecr-sear-snm">
						
						<p class="mem-mtit">먼저 멤버스 회원을 검색하세요.</p>
						<input onclick="phoneSearch()" class="search-btn02 btn btn02" type="button" value="Search">
					
					</div>
				</div>
				
				<div class="row">
					<div class="bor-div">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">회원명</div>
								<div>
									<input type="text" id="kor_nm" name="kor_nm" data-name="회원명" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
								</div>
							</div>
						</div>
						
						<div class="wid-10">
							<div class="table">
								<div class="top-row">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">생년월일</div>
											<div>
												<input type="text" id="birth_ymd" name="birth_ymd" data-name="생년월일" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">전화번호</div>
											<div>
												<input type="text" id="h_phone_no_1" name="h_phone_no_1" class="inp-30"  placeholder="" >-
												<input type="text" id="h_phone_no_2" name="h_phone_no_2" class="inp-30"  placeholder="" >-
												<input type="text" id="h_phone_no_3" name="h_phone_no_3" class="inp-30"  placeholder="" >
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="wid-10">
							<div class="table">
								<div class="top-row">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit-top">이메일</div>
											<div>
												<input type="text" id="email_addr" name="email_addr" data-name="이메일" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
												
												<div class="sear-smtit wid-10">
													<input type="checkbox" id="email_chk">
													<label for="email_chk">수신동의</label>
													
												</div>
												<p>정보/이벤트 E-MAIL 수신에 동의합니다.</p>		
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit-top">휴대폰</div>
											<div>
												<input type="text" id="phone_no" name="phone_no" data-name="전화번호" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
												
												<div class="sear-smtit wid-10">
													<input type="checkbox" id="sms_chk">
													<label for="sms_chk">수신동의</label>
												</div>
												<p>정보/이벤트 SMS 수신에 동의합니다.</p>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					
					<div class="bor-div">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">멤버스번호</div>
								<div>
									<input type="text" id="cus_no" name="cus_no" data-name="멤버스번호" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
								</div>
							</div>
						</div>
						
						<div class="wid-10">
							<div class="table">
								<div class="top-row">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">포털ID</div>
											<div>
												<input type="text" id="ptl_id" name="ptl_id" data-name="포털ID" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">가입일자</div>
											<div>
												<input type="text" id="create_date" name="create_date" data-name="가입일자" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						<div class="wid-10">
							<div class="table">
								<div class="top-row">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit-top">멤버스카드NO</div>
											<div>
												<input type="text" id="card_no" name="card_no" data-name="가입일자" class="inp-100 notEmpty inputDisabled" readOnly placeholder="" >
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit-top">베키맘여부</div>
											<div>
												<input type="text" id="" name="" class="inp-100" >
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<div class="wid-5">
			<div class="white-bg bg-pad">
				<div class="bor-div">
					<div class="wid-10">
						<div class="table">
						
							<div class="sear-tit">성별</div>
							<div>
								<ul class="chk-ul">
									<li>
										<input type="radio" id="rad-male" name="rad-gender" value="">
										<label for="rad-male">남</label>
									</li>
									<li>
										<input type="radio" id="rad-female" name="rad-gender">
										<label for="rad-female">여</label>
									</li>
								</ul>
								
							</div>
						
						</div>
						
					</div>
					
					<div class="wid-10">
						<div class="table">
							<div class="top-row">
								<div class="wid-5">
									<div class="table">
										<div class="sear-tit">결혼여부</div>
										<div>
											<ul class="chk-ul">
												<li>
													<input type="radio" id="married_a" name="married_chk">
													<label for="married_a">미혼</label>
												</li>
												<li>
													<input type="radio" id="married_b" name="married_chk">
													<label for="married_b">기혼</label>
												</li>
											</ul>
											
										</div>
									</div>
								</div>
								
								<div class="wid-5">
									<div class="table">
										<div class="sear-tit">결혼기념일</div>
										<div class="cal-input cal-input02">
											<input type="text" id="marry_ymd" name="marry_ymd" class="inp-100 date-i hasDatepicker" readonly="readonly" />
											<i class="material-icons">event_available</i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>				
				</div>
				<div class="bor-div">
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit sear-tit-top">주소</div>
							<div class="table-mem">
								<div class="input-wid2">
									<input type="text" id="postcode" class="inp-30" onclick="show_address('postcode', 'addr_tx1');" placeholder="" >
									<input type="text" id="addr_tx1" name="addr_tx1" class="inp-70" onclick="show_address();" placeholder="" >
								</div>
								<div>
									<input type="text" id="addr_tx2" name="addr_tx2" class="inp-100" placeholder="" >
								</div>
							</div>
						</div>
					</div>
			
				</div>
				
				<div class="bor-div">
				
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit sear-tit-top" id="target_closed">자녀회원</div>
							<div class="table-mem02">										
								<div>
									<div class="wid-4">
										<input type="text" id="" name="child_name_1" class="child_name inp-100" placeholder="이름을 입력하세요.">
									</div>
									<div class="wid-15">
										<select id="" class="child_gender_1" name="child_gender_1" de-data="남">
											<option value="M">남</option>
											<option value="F">여</option>
										</select>
									</div>
									<div class="wid-3">
										<div class="cal-input cal-input02">
											<input type="text" id="child_ymd_1" class="child_ymd child_ymd_1 date-i" placeholder="생년월일" />
											<i class="material-icons">event_available</i>
										</div>
									</div>

									<div class="wid-1">
										<div class="btn-row"><i class="material-icons add" onclick="add_closed()">add_circle_outline</i></div>
										
									</div>			
								</div>	
								<!-- 
								<div>
									<div class="wid-3">
										<input type="text" id="" name="" class="inp-100" placeholder="이름을 입력하세요.">
									</div>
									<div class="wid-3">
										<div class="cal-input cal-input02">
											<input type="text" placeholder="생년월일" class="date-i" />
											<i class="material-icons">event_available</i>
										</div>
									</div>
									<div class="wid-3">										
										<select id="listSize" name="listSize" onchange="reSelect()" de-data="관계">
											<option value="20">사은품명</option>
											<option value="50">멤버스번호</option>
											<option value="100">회원명</option>
										</select>
									</div>
									<div class="wid-1">
										<div class="btn-row"><i class="material-icons remove">remove_circle_outline</i></div>
										
									</div>			
								</div>	
								 -->
							</div>							
						
						</div>
					</div>
					
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit">차량번호</div>
							<div>
								<input type="text" id="car_no" name="car_no" class="inp-25">
							</div>
						</div>
					</div>
				
				</div>
				
				
				<div class="bor-div">
				
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit sear-tit-top">관리자메모</div>
							<div>
								<textarea id="memo_cont" name="memo_cont" class="inp-100"></textarea>								
								

							</div>
						
						</div>
					</div>
				
				</div>
			</div>	
		</div>
		
		
	
	</div>
</form>

<div class="btn-wr text-center">
	<a class="btn btn01 ok-btn" onclick="javascript:fncSubmitPos();">저장하지 않음</a>
	<a class="btn btn02 ok-btn" onclick="javascript:save_cus_info();">저장</a>
</div>

<div id="search_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg phone-edit">
        		<div class="close" onclick="javascript:$('#search_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">휴대폰번호 조회</h3>
					<div class="table table02">
						<div class="wid-5">
							<div class="table table-auto">
								<div><input type="text" data-name="휴대폰 뒷자리" id="searchPhone" name="searchPhone" class="" placeholder="휴대폰 뒷번호 네자리 입력" onkeypress="excuteEnter(getUserList)"></div>
								<div><a class="btn btn02" onclick="javascript:getUserList()">검색</a></div>
							</div>		
						</div>
						<div class="wid-5 sel-scr">
							<div class="table">
								<div>
									<select de-data="" id="searchResult"></select>
								</div>
								<div><a class="btn btn02" onclick="choose_confirm();">선택완료</a></div>
							</div>		
						</div>
	        		</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>