<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(document).ready(function(){
	
	
	var car_inner="";
	if (nullChk("${CAR1_DETAIL}")!="") {
		car_inner+='<div class="cal-row">';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="start_ymd" value="${CAR1_FROM}"/>';
		car_inner+='	</div>';
		car_inner+='	<div class="cal-dash">-</div>';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="end_ymd" value="${CAR1_TO}"/>';
		car_inner+='	</div>';
		car_inner+='	<div>';
		car_inner+='		<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" value="${CAR1_DETAIL}" placeholder="" readOnly>';
		car_inner+='	</div>';
		car_inner+='</div>';
	}
	
	
	if (nullChk("${CAR2_DETAIL}")!="") {
		car_inner+='<div class="cal-row">';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="start_ymd" value="${CAR2_FROM}"/>';
		car_inner+='	</div>';
		car_inner+='	<div class="cal-dash">-</div>';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="end_ymd" value="${CAR2_TO}"/>';
		car_inner+='	</div>';
		car_inner+='	<div>';
		car_inner+='		<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" value="${CAR2_DETAIL}" placeholder="" readOnly>';
		car_inner+='	</div>';
		car_inner+='</div>';
	}
	
	if (nullChk("${CAR3_DETAIL}")!="") {
		car_inner+='<div class="cal-row">';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="start_ymd" value="${CAR3_FROM}"/>';
		car_inner+='	</div>';
		car_inner+='	<div class="cal-dash">-</div>';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="end_ymd" value="${CAR3_TO}"/>';
		car_inner+='	</div>';
		car_inner+='	<div>';
		car_inner+='		<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" value="${CAR3_DETAIL}" placeholder="" readOnly>';
		car_inner+='	</div>';
		car_inner+='</div>';
	}
	
	if (nullChk("${CAR4_DETAIL}")!="") {
		car_inner+='<div class="cal-row">';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="start_ymd" value="${CAR4_FROM}"/>';
		car_inner+='	</div>';
		car_inner+='	<div class="cal-dash">-</div>';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="end_ymd" value="${CAR4_TO}"/>';
		car_inner+='	</div>';
		car_inner+='	<div>';
		car_inner+='		<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" value="${CAR4_DETAIL}" placeholder="" readOnly>';
		car_inner+='	</div>';
		car_inner+='</div>';
	}
	
	if (nullChk("${CAR5_DETAIL}")!="") {
		car_inner+='<div class="cal-row">';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="start_ymd" value="${CAR5_FROM}"/>';
		car_inner+='	</div>';
		car_inner+='	<div class="cal-dash">-</div>';
		car_inner+='	<div class="cal-input cal-input02 cal-input_rec">';
		car_inner+='		<input type="text" class="inputDisabled" id="end_ymd" value="${CAR5_TO}"/>';
		car_inner+='	</div>';
		car_inner+='	<div>';
		car_inner+='		<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" value="${CAR5_DETAIL}" placeholder="" readOnly>';
		car_inner+='	</div>';
		car_inner+='</div>';
	}
	$('#car_target').html(car_inner);
	
	
	var awad_inner ="";
	if (nullChk("${AWAD1_DETAIL}")!="") {
		
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD1_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD1_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD1_DETAIL}">';
		awad_inner+='</div>';
	}
	
	
	if (nullChk("${AWAD2_DETAIL}")!="") {
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD2_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD2_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD2_DETAIL}">';
		awad_inner+='</div>';
	}
	
	if (nullChk("${AWAD3_DETAIL}")!="") {
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD3_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD3_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD3_DETAIL}">';
		awad_inner+='</div>';
	}
	
	if (nullChk("${AWAD4_DETAIL}")!="") {
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD4_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD4_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD4_DETAIL}">';
		awad_inner+='</div>';
	}
	
	if (nullChk("${AWAD5_DETAIL}")!="") {
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD5_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD5_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${AWAD5_DETAIL}">';
		awad_inner+='</div>';
	}
	
	$('#awad_target').html(awad_inner);
	
	
	
	var awad_inner ="";
	if (nullChk("${CERT1_DETAIL}")!="") {
		
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT1_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT1_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT1_DETAIL}">';
		awad_inner+='</div>';
	}
	
	if (nullChk("${CERT2_DETAIL}")!="") {
				
				awad_inner+='<div>';
				awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT2_DATE}">';
				awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT2_FROM}">';
				awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT2_DETAIL}">';
				awad_inner+='</div>';
	}
			
	if (nullChk("${CERT3_DETAIL}")!="") {
		
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT3_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT3_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT3_DETAIL}">';
		awad_inner+='</div>';
	}
	
	if (nullChk("${CERT4_DETAIL}")!="") {
		
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT4_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT4_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT4_DETAIL}">';
		awad_inner+='</div>';
	}
	
	if (nullChk("${CERT5_DETAIL}")!="") {
		
		awad_inner+='<div>';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT5_DATE}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT5_FROM}">';
		awad_inner+='	<input type="text" class="inputDisabled inp-30" placeholder="" value="${CERT5_DETAIL}">';
		awad_inner+='</div>';
	}
	
	$('#cert_target').html(awad_inner);
	
	
	
	if (nullChk("${APLY_STORE}")!="") {
		var store ="${APLY_STORE}";
		store=store.replace(/\|/g,",");
		store = store.replace('01','?????????');
		store = store.replace('02','?????????');
		store = store.replace('03','?????????');
		store = store.replace('04','?????????');
		store = store.replace('05','?????????');
		store = store.slice(0,-1);
		$('#store_target').html(store);		
	}
	
	if (nullChk("${APLY_DAY}")!="") {
		var day_flag = "${APLY_DAY}";
		day_flag = cutYoil(day_flag);
		$('#day_target').html(day_flag);		
	}
	
	
	if (nullChk("${APLY_LECT_HOUR}")!="") {
		var lect_hour = "${APLY_LECT_HOUR}";
		lect_hour=cutLectHour(lect_hour);
		$('#lect_hour_target').html(lect_hour);
	}	
	
	if (nullChk("${LEC_MAIN_CD}")!="") {
		var main_cd ="${LEC_MAIN_CD}";
		main_cd = main_cd.replace(/\|/g,",");
		main_cd = main_cd.replace('1','??????');
		main_cd = main_cd.replace('2','????????? ??????');
		main_cd = main_cd.replace('3','??????');
		main_cd = main_cd.replace('4','??????');
		main_cd = main_cd.slice(0,-1);
		$('#main_target').html(main_cd);		
	}
	
	if (nullChk("${SUBJECT_FG}")!="") {
		var subject_fg ="${SUBJECT_FG}";
		subject_fg = subject_fg.replace(/\|/g,",");
		subject_fg = subject_fg.replace('1','??????');
		subject_fg = subject_fg.replace('2','??????');
		subject_fg = subject_fg.replace('3','??????');
		subject_fg = subject_fg.slice(0,-1);
		$('#subject_target').html(subject_fg);		
	}
	
	
});

function pass_process(way){
	
	if(!confirm("?????? ?????????????????????????"))
	{
		return;
	}

	$.ajax({
		type : "POST", 
		url : "./doPass",
		dataType : "text",
		async : false,
		data : 
		{
			passValue : way,
			chk_list : "${CUST_NO}_${REG_NO}"
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			alert("?????????????????????.");
			location.href="/lecture/lecr/status";
		}
	});
}

</script>

<div class="sub-tit">
	<h2>????????????</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>


<div class="table-wr">
	<div class="tab-wrap tab-wrap_mem">		
		
		<div class="tab-content lecr-manage">
		
			<div class="member-profile lecture-profile active">
				<div class="table-list ak-wrap_new">
					<div class="row">
						<div class="wid-5">
							<h3>????????????</h3>
							<div class="bor-div">
								<div class="top-row table-input">
								
									<div class="wid-10">
										<div class="table">
											
											<div>
												<img style="width:168px; height:224px; display:table; margin:0 auto;"src="https://culture.akplaza.com/upload/recruit/${PHOTO_NM}">
											</div>
										</div>
									</div>
								</div>
							</div>
								
							<div class="bor-div">
								<div class="top-row table-input">	
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">??????</div>
											<div>
												<input type="text" class="inputDisabled" id="kor_nm" name="kor_nm" value="${KOR_NM}" readOnly/>
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_120 sear-tit_left">?????????</div>
											<div>
												<input type="text" class="inputDisabled" id="phone_no" name="phone_no" value="${PHONE_NO}" readOnly/>
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">????????????</div>
											<div>
												<input type="text" class="inputDisabled" id="birth_ymd" name="birth_ymd" value="${BIRTH_YMD}" readOnly/>
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_120 sear-tit_left">?????????</div>
											<div>
												<input type="text" class="inputDisabled" id="email_addr" name="email_addr" value="${EMAIL_ADDR}" readOnly/>
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row table-input">
									<div class="wid-10">
										<div class="table ">
											<div class="sear-tit">????????????</div>
											<div>
												<c:if test="${MARRY_FG eq '1'}">
												    ??????
												</c:if>
												
												<c:if test="${MARRY_FG eq '2'}">
												   ??????
												</c:if>
											</div>
										</div>
									</div>
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">?????????/SNS URL</div>
											<div>
												<input type="text" class="inputDisabled" id="sns_url" value="${SNS_URL}" readOnly/>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="bor-div">
								<h3>????????????</h3> <br>
								<div class="top-row table-input">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">????????????</div>
											<div >
												<input type="text" class="inputDisabled inp-30" placeholder="" value="${SCH_NM}">${SCH_LEVEL}
												<input type="text" class="inputDisabled inp-30" placeholder="" value="${SCH_MAJOR}"> ??????
											</div>
										</div>
									</div>
								</div>
								<div class="top-row table-input">	
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">???????????????</div>
											<div>
												<input type="text" class="inputDisabled" id="" name="" value="${SCH_PLACE}" readOnly/>
											</div>
										</div>
									</div>
								</div>
								<div class="top-row table-input">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">????????????</div>
											<div>
												<div class="cal-row">
													<div class="cal-input cal-input02 cal-input_rec">
														<input type="text" class="inputDisabled" id="start_ymd" value="${SCH_START_YY}"/>
													</div>
													<div class="cal-dash">-</div>
													<div class="cal-input cal-input02 cal-input_rec">
														<input type="text" class="inputDisabled" id="end_ymd" value="${SCH_END_YY}"/>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="wid-10">
									<div class="table ">
										<div class="sear-tit">????????????</div>
										<div>
											<c:if test="${fn:trim(SCH_STATE) eq '1'}">??????</c:if>
											<c:if test="${fn:trim(SCH_STATE) eq '2'}">??????</c:if>
											<c:if test="${fn:trim(SCH_STATE) eq '3'}">??????</c:if>
											<c:if test="${fn:trim(SCH_STATE) eq '4'}">??????</c:if>
										</div>
									</div>
								</div>
							</div>

							<div class="bor-div">
								<h3>????????????</h3> <br>
								<div class="top-row table-input">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit sear-tit-top">????????????</div>
											
											<div id="car_target" class="imp-row">
											
	
												
												
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row table-input imp-row02">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit sear-tit-top">????????????</div>
											<div id="awad_target" class="imp-row_inp">
												
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row table-input imp-row02">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit sear-tit-top">?????????</div>
											<div id="cert_target" class="imp-row_inp">
											
												
											</div>
										</div>
									</div>
								</div>
								
								
							</div>
							<div class="bor-div">
								<h3>?????? ??????</h3> <br>
								<div class="wid-10">
									<div class="table ">
										<div class="sear-tit">????????????</div>
										<div>
											<c:if test="${fn:trim(APLY_TYPE) eq 'C'}">?????? ?????????</c:if>
											<c:if test="${fn:trim(APLY_TYPE) eq 'S'}">AK???????????? ?????????</c:if>
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table ">
										<div class="sear-tit">????????????</div>
										<div id="store_target">
					

										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table ">
										<div class="sear-tit">?????? ??????</div>
										<div id="day_target">
											
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit">?????? ?????????</div>
										<div id="lect_hour_target">
										
										</div>
									</div>
								</div>
								
							
							</div>
						</div> <!-- wid-5 end -->
						
						<div class="wid-5 wid-5_last">
							<div class="lect-detwr">
			        			<h3>???????????????</h3>
			        			
			        			<div class="tr-content">
			        				<div class="tr-div01">
			        					<div class="wid-10">								
											<div class="sear-tit">?????? ??????</div>
											<div>
												<input type="text" class="inputDisabled bg_blue"  value="${LEC_NM}" readonly>
											</div>								
										</div>
										
										<div class="wid-10">								
											<div class="sear-tit">???????????? ??? ?????? ??????</div>
											<div>
												<textarea class="bg_blue" readonly >${LEC_INFO}</textarea>
											</div>								
										</div>
										<c:if test="${fn:trim(APLY_TYPE) eq 'S'}">
											<div class="wid-10">								
												<div class="sear-tit">???????????? ???????????? ????????? ??????</div>
												<div>
													<textarea class="bg_blue" readonly>${SIG_INFO}</textarea>
												</div>								
											</div>
										</c:if>
									</div>
									<div class="tr-div02">
				        				<div class="wid-10">
											<div class="table">
												<div class="sear-tit">?????? ??????</div>
												<div id="main_target">

												</div>
											</div>
										</div>
										
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">?????? ??????</div>
												<div id="subject_target">
													<ul class="chk-ul">
														<li>
															<input type="checkbox" id="all-auto" name="all-auto">
															<label for="all-auto">??????</label>
														</li>
														<li>
															<input type="checkbox" id="all-indi" name="all-indi">
															<label for="all-indi">??????</label>
														</li>
														<li>
															<input type="checkbox" id="all-indi" name="all-indi">
															<label for="all-indi">??????</label>
														</li>
													</ul>
												</div>
											</div>
										</div>
										
										<div class="wid-10 tran-file">
											<div class="table">
												<div class="sear-tit">????????????</div>
												<div>
													<div class="filebox"> 
														<span style="cursor:pointer;">
															<a href="https://culture.akplaza.com/upload/recruit/attach/${FILE_NM}">${FILE_NM}</a>
														</span>
													</div>
												</div>
											</div>
										</div>
									</div>
			        			
			        			</div>
			        			
			        		</div>
						</div> <!-- wid-5_last end -->
					</div>
					
					<div class="btn-center">
						<a class="btn btn01 btn01" onclick="javascript:pass_process('S')">??????</a>
						<a class="btn btn01 btn02" onclick="javascript:pass_process('F')">?????????</a>
					</div>
						
				</div>
				
				
			</div> <!-- lecture-profile end -->
			
		
		</div>
		
	</div> <!-- tab-wrap end -->
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>	