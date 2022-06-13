<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
$(document).ready(function(){

	var f = document.saveInfo;
	
	
	if (nullChk("${DAY_FLAG}")!="") {
		$('#yoil').val(cutYoil("${DAY_FLAG}"));
	}
	
	

	if (nullChk("${CONTRACT_START}")!="") {
		f.contract_start.value="${CONTRACT_START}";
	}
	
	if (nullChk("${CONTRACT_END}")!="") {
		f.contract_end.value="${CONTRACT_END}";
	}
	
	if (nullChk("${AUTO_TERM}")!="") {
		f.auto_term.value="${AUTO_TERM}";
	}
	
	$('#store').val(nullChk("${STORE_NM}"));
	$('#kor_nm').val(nullChk("${CUS_PN}"));
	$('#lec_nm').val(nullChk("${SUBJECT_NM}"));
	$('#subject_fg').val(nullChk("${SUBJECT_FG}"));
	$('#main_cd').val(nullChk("${MAIN_NM}"));
	$('#pay_method').val(nullChk("${FIX_PAY_YN}"));
	$('#yoil').val(cutYoil(nullChk("${DAY_FLAG}")));
	$('#lect_start_ymd').val(nullChk("${START_YMD}"));
	$('#lect_end_ymd').val(nullChk("${END_YMD}"));
	$('#lect_fee').val("${LECT_FEE}");				
	$('#lect_hour').val(cutLectHour(nullChk("${LECT_HOUR}")));
	$('#contract_start').val(nullChk("${CONTRACT_START}"));
	$('#contract_end').val(nullChk("${CONTRACT_END}"));
	$('#auto_term').val(nullChk("${AUTO_TERM}"));
	
	
	$('#target_day').text(cutYoil(nullChk("${DAY_FLAG}")));
	$('#target_hour').text(cutLectHour(nullChk("${LECT_HOUR}")));
	
	if ("${NAVER_YN}"=='Y') {
		$("#naver_chk").prop("checked",true);		
	}
   
	
});


function saveContent(){
	var f = document.saveInfo;
	
	if(f.contract_start.value == ""){
    	alert("계약 시작일을 입력하세요");
    	 f.contract_start.focus();
    	return;
    }
	
	if(f.contract_end.value == ""){
    	alert("계약 종료을 입력하세요");
    	 f.contract_end.focus();
    	return;
    }
	
	if(f.auto_term.value == ""){
    	alert("자동 연장기간을 입력하세요");
    	 f.auto_term.focus();
    	return;
    }
	
	
	var naver_yn='';
	if($("#naver_chk").is(":checked"))
	{
		naver_yn = "Y";
	}else{
		naver_yn='N';
	}
	
	
	
	$.ajax({
		type : "POST", 
		url : "./saveInfo",
		dataType : "text",
		async : false,
		data : {
			store : '${STORE}',
			period : '${PERIOD}',
			subject_cd : '${SUBJECT_CD}',
			cus_no : '${CUS_NO}',
			contract_start : f.contract_start.value,
			contract_end : f.contract_end.value,
			auto_term : f.auto_term.value,
			naver_yn : naver_yn
			
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

function changeBtn()
{
	$('#change_layer').fadeIn(200);	
}

function lastSumibt(way)
{
	if(!confirm("정말 승인하시겠습니까?"))
	{
		return;
	}	
	
	$.ajax({
		type : "POST", 
		url : "./confirm",
		dataType : "text",
		async : false,
		data : 
		{
			store : "${STORE}",
			period : "${PERIOD}",
			subject_cd : "${SUBJECT_CD}",
			cus_no : "${CUS_NO}",
			way : way
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
			location.href="./contract";
		}
	});	
	
}

	
// function goPrint()
// {
// 	var temp =  document.getElementById('print').innerHTML;
// 	$('#result').val(temp);	 
// 	document.getElementById("printForm").target = "printFrame";
// 	document.getElementById("printForm").submit();
// }
function goPrint()
{
	Popup($("#print").html(),$(".css-box").text());
}

var mywindow = "";
function Popup(data,css)
{
	mywindow = window.open('', 'AK 문화 아카데미', 'height=700,width="1400",scrollbars=yes');
	mywindow.document.write('<html><head><title>AK 문화 아카데미</title>');
	mywindow.document.write('<link href="/inc/css/admin.css" rel="stylesheet">');
// 	mywindow.document.write('<link href="/inc/css/contract/contractPrint.css" rel="stylesheet" >');
	mywindow.document.write('<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">');
	mywindow.document.write('<style type="text/css">@page {  size:210mm 297mm;  margin:10mm 5mm } @media print { #hideBtn{display:none !important; } .contract-cont *{font-size:12px !important;}');
	mywindow.document.write(' .contract-cont, .contract-cover{page-break-inside:avoid; page-break-after: auto; } .contract-box .ct-kor{font-size:20px !important;}');
	mywindow.document.write('}');
	mywindow.document.write('.contract-box{ height: auto; overflow: hidden; padding: 190px 0 0; } html, body, .header{min-width:500px}');
	mywindow.document.write('</style>');
	mywindow.document.write('</head><body >');
	//인쇄 분리
	mywindow.document.write('<a id="hideBtn" class="bor-btn btn01 print-btn" onclick="javascript:opener.goPrint2();"><i class="material-icons">print</i></a>');
	//인쇄 분리
	mywindow.document.write(data);
	mywindow.document.write('</body></html>');
	mywindow.document.close(); // IE >= 10에 필요
	mywindow.focus(); // necessary for IE >= 10
	// mywindow.print();
	// mywindow.close();
	return true;
}

function goPrint2()
{
	var h = mywindow.document.getElementById("hideBtn");
	h.parentNode.removeChild(h);
	mywindow.print();
	mywindow.close();
}
</script>

<form id="printForm" name="printForm" method="post" action="./print_proc">
	<input type="hidden" id="result" name="result">
	<input type="hidden" id="day_chk" name="day_chk">
</form>
<iframe id="printFrame" name="printFrame" style="display:none;"></iframe>



<div class="sub-tit">
	<h2>강사 계약서</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb">
		
	</ul>
	
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="lecr-title">
			<div>
				<div class="top-row">
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit">강좌</div>
							<div>
								<input type="text" id="subject_nm" value="${SUBJECT_NM}" class="inp-80 inputDisabled">
								<a class="btn btn02 mrg-l6" onclick="javascript:changeBtn();"><i class="material-icons">add</i> 변동값 확인하기</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		</div>
		
	</div>
	
	
</div>
<div class="table-cap table">
	<div class="cap-r text-right">
		<a class="bor-btn btn01 print-btn" onclick="javascript:goPrint();"><i class="material-icons">print</i></a> 
	</div>
</div>
<div id="change_layer" class="list-edit-wrap">
<form id="saveInfo" name ="saveInfo" action='/saveInfo' method='post'>
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#change_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3>변동값 확인하기</h3>        			
        			<div class="table-top bg01 lec-contwr lec-contwr02">
        			
        				<div class="table">
        					<div class="">	        						
								<div class="table">
									<div class="sear-tit">점명</div>
									<div>
										<input type="text" id="store" class="inp-100 notEmpty inputDisabled" readonly="readonly">
									</div>
								</div>									
        					</div>
        					
        					<div class="wid-35">	        						
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">강사명</div>
									<div>
										<input type="text" id="kor_nm" class="inp-100 notEmpty inputDisabled" readonly="readonly">
									</div>
								</div>									
        					</div>
        					<div class="wid-35">	        						
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">강의명</div>
									<div>
										<input type="text" id="lec_nm" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
									</div>
								</div>									
        					</div>
        				</div>
        			
        			
        				<div class="table">
							<div class="">
								<div class="table">
									<div class="sear-tit">유형</div>
									<div>
										<input type="text" id="subject_fg" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
									</div>
								</div>
							</div>		
							
							<div class="wid-35">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">대상</div>
									<div>
										<input type="text" id="main_cd" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
									</div>
								</div>
							</div>	
        				
        					<div class="wid-35">	        						
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">강사료 지급 <br> 방법</div>
									<div>
										<input type="text" id="pay_method" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
									</div>
								</div>									
        					</div>
        				</div>
        				
        				
       					<div class="table">
       					
							<div class="wid-10 ">
								<div class="table">
									<div class="sear-tit">강의요일</div>
									<div>
										<input type="text" id="yoil" value="" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
									</div>
								</div>
							</div>

						</div>
        				
       					<div class="table">
       					
							<div class="">
								<div class="table">
									<div class="sear-tit">강의기간</div>
									<div>
										<div class="cal-row">
											<div class="cal-input wid-45">
												<input type="text" id="lect_start_ymd" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
											</div>
											<div class="cal-dash wid-1">-</div>
											<div class="cal-input wid-45">
												<input type="text" id="lect_end_ymd" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="wid-35">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">강사료</div>
									<div>
										<input type="text" id="lect_fee" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
									</div>
								</div>
							</div>
							
							
							
						</div>
						
       					<div class="table">
       						<div>
								<div class="table">
									<div class="sear-tit">강의시간</div>
									<div>
										<div class="time-row">
											<div>
												<div class="time-input time-input180 sel-scr">
													<input type="text" id="lect_hour" class="inp-100 notEmpty inputDisabled" readonly="readonly" placeholder="">
												</div>
											</div>
										</div>
									</div>		
								</div>
							</div>
						</div>
						
						
						
       					<div class="table">
       					
							<div>
								<div class="table table-auto">
									<div class="sear-tit">계약기간</div>
									<div>
										<div class="cal-row">
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="contract_start" value="1" name="contract_start">
												<i class="material-icons">event_available</i>
											</div>
											<div class="cal-dash wid-1">-</div>
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="contract_end" name="contract_end">
												<i class="material-icons">event_available</i>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="wid-35">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">자동연장기간</div>
									<div>
										<input type="text" style="width:80%;" id="auto_term" name="auto_term" value="2"> 개월
									</div>
								</div>
							</div>
						</div>
						<div class="table">
							<div class="">
								<div class="table">
									<div class="sear-tit">네이버</div>
									<div>
										<div class="time-row">
											<div>
												<div class="time-input time-input180 sel-scr">
													<input type="checkbox" id="naver_chk" name="naver_chk">										
													<label for="naver_chk"></label>
												</div>
											</div>
										</div>
									</div>		
								</div>
							</div>

							
						</div>
        			</div>
        			
        			<div class=" text-center">
        				<c:if test="${CONFIRM_YN eq 'N'}">
								<a class="btn btn02 ok-btn" onclick="javascript:saveContent()">수정하기</a>
						</c:if>
					</div>
        		</div>
        	</div>
        </div>
    </div>
</form>
</div>




<div id="print" class="cours-sec cours-sec01 bg-gray ct_wra contract_sroll">
	<div class="mu-grid">
		<div class="contract-wr">
			<div class="cont-label">
				<dl>
					<dt>점포명</dt>
					<dd>${STORE_NM}</dd>
					<dt>강사명</dt>
					<dd>${CUS_PN}</dd>
				</dl>
			</div>
			<div class="contract-box">
				<div class="contract-cover">
					<h1>강사 계약서</h1>
					<div class="ct-logo">
						<img src="/img/ak_contract_logo.png" alt="로고">
					</div>
					<p class="cp-name ct-kor">에이케이에스앤디(주)</p>
				</div>
				<div class="contract-cont cont01">
					<p class="desc-g">
						<strong>에이케이에스앤디㈜</strong>(이하 “AK”라 한다)와 <strong>${CUS_PN}</strong>(이하 “강사”라 한다)는 “AK”가 운영하는 AK PLAZA <strong>${STORE_NM}</strong> 문화아카데미의 교육∙문화 강의 운영과 관련하여 아래와 같이 계약을 체결한다.
					</p>
					<strong class="tit-subject">제1조 (위탁 업무)</strong>
					<p class="desc-g">“AK”는 “강사”에 대하여, “AK”가 개설ㆍ운영하는 강의(이하 “강의”라 한다)의 담당 강사로 하여, 수강생에 대하여 강의할 것과 이와 관련된 업무를 행할 것을 위탁하고, “강사”는 이를 승낙하기로 한다.</p>
					<strong class="tit-subject">
						제2조 (강의 내용)
					</strong>
					<p class="desc-g">강의 계획(일정) 등은 다음과 같으며 이외의 강의와 관련한 세부 사항은 “AK”와 "강사"의 별도 협의에 의하여 정한다.</p>
					<div class="clause-table">
						<table class="cl-table cl-table01">
						  <tr>
							<td class="table-bg">강의명</td>
							<td class="table-bg">강의 기간</td>
							<td class="table-bg">강의 시간</td>
						  </tr>
						  <tr>
							<td>${SUBJECT_NM}</td>
							<td>${START_YMD} ~ <br> 
							${END_YMD }
							</td>
							<td>
								<p id="target_day"></p>
								<p id="target_hour"></p>
							</td>
						  </tr>
						</table>
						<table class="cl-table cl-table02">
						   <thead>
							  <tr>
								<th class="table-bg">강사료[정액제 時 기입]</th>
							  </tr>
							</thead>
							<tbody>
							  <tr>
								<td>${LECT_FEE}</td>
							  </tr>
							</tbody>
						</table>
						<ul class="list_2depth">
							<li>※ 정액제: 강의 1회당 정액으로 지급하는 것으로 해당 학기별 강의 횟수를 기준으로 강의료를 “강사”에게 지급한다.</li>
							<li>※ 비율제: "강사"가 학기 중 담당하는 강의의 수강생들로부터 수납한 수강료 총액의 일정 비율을 
							“강사”에게 지급한다. </li>
						</ul>
					</div>
					<strong class="tit-subject">
						제3조 (계약기간)
					</strong>
					<p class="desc-g">본 계약의 계약기간은 ${START_YMD}부터 ${END_YMD} 까지로 하며, 계약만료일자의 45일 전까지 일방의 서면 계약해지통보가 없는 경우, 본 계약은 동일 조건으로 ${AUTO_TERM}개월씩 자동 연장되는 것으로 한다.</p>
					<p class="desc-g">단, 계약기간 중 차학기 미개설 혹은 전 강좌 폐강의 경우 본 계약은 즉시 종료된다.</p>
					<strong class="tit-subject">
						제4조 (교육과정의 진행)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>강의에 필요한 설비 중 “AK”의 강의실 시설에 부속된 설비는 “AK”가 제공토록 한다. 단, “AK”가 별도의 시간과 비용을 지출 하여야만 제공이 가능한 설비는 “AK”와 “강사”가 별도 협의를 통하여 해결하도록 하되, 합리적으로 예상되는 범위를 넘어서서 “AK”에게 비용 부담이 예상되는 설비 등에 대해서 “AK”는 제공 의무가 없다.
                        </li>
                        <li><span class="txt_num">②</span>강의에 필요한 교재는 ”강사”의 부담으로 수강생들에게 무상으로 제공함을 원칙으로 한다. 단, 강의 진행을 위해 부가적으로 수강생이 구입해야 할 교재 및 수업 기자재는 "AK"와 "강사"가 사전 협의하여 정하도록 하며, 이를 강의계획서에 명시하여 강의 시작 전 “AK”에 제출한다. 
                        </li>
                        <li><span class="txt_num">③</span>“강사”는 수강생들에게 강의 계획서에 명시되어 있지 않은 교구(재)는 절대 판매 및 구입을 강요할 수 없다.
                        </li>
                        <li><span class="txt_num">④</span>“강사”가 정규 수업 외에 행사를 계획하거나 야외 수업을 진행할 경우에는 반드시 사전에 “AK”의 사전 승인을 얻어야 한다.
                        </li>
                        <li><span class="txt_num">⑤</span>“강사”는 수업에 사용하는 교구 또는 증정품이 관련 법령에 따라 위생 및 안전(내용물의 유해성, 포장재질의 안전도)기준을 충족하였음을 보증하고, 사용 교구 또는 증정품으로 인한 사고 발생시 즉시 피해자에게 손해를 배상하고 “AK”를 면책시켜야 한다.
                        </li>
                        <li><span class="txt_num">⑥</span>“강사”는 수강생에게 별도의 개별 학습을 권하거나 또는 타 학습기관으로의 이동을 유도하는 등 본 계약 취지에 어긋나는 행위를 하여서는 아니 된다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제5조 ("강사"의 의무)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>"강사"는 제2 조에 따른 강의 시작시간 및 종료시간을 준수한다. 
                        </li>
                        <li><span class="txt_num">②</span>"강사"는 강의 시간 중 사적인 용무 등으로 강의에 지장을 초래하지 않도록 한다.
                        </li>
                        <li><span class="txt_num">③</span>"강사"는 부득이한 사유로 강의를 휴강하거나 강의 일정을 변경하고자 할 경우에는 원칙적으로 최소 [7]일전 "AK"에게 사유서를 제출하여 “AK”의 승인을 받고, 수강생에 대한 공지방법 및 보강일정을 “AK”와 협의하여야 한다.
                        </li>
                        <li><span class="txt_num">④</span>"강사"는 전항에 의한 휴강 또는 강의 일정 변경 등으로 인한 수강생, 제3자 및 “AK”의 손해에 대하여 “강사”의 비용과 책임으로 이를 해결한다.
                        </li>
                        <li><span class="txt_num">⑤</span>"강사"는 자신과 관련하여 중요한 변경사항이 발생한 경우에는 이를 지체 없이 "AK"에게 통지하여야 한다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제6조 (폐강 등)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>“AK”와 “강사”가 협의하여 개설한 강의의 수강생이 모집정원의 [50%]에 미달될 경우 상호 합의를 통해 강의를 폐강하거나 강의 범위를 조정할 수 있다.
                        </li>
                        <li><span class="txt_num">②</span>전항에 의하여 “강사”가 본 계약에 의해 담당하는 강의 전부가 폐강된 경우 제14조 이외의 경우일지라도 본 계약은 즉시 해지되며, “AK”는 제7조의 의무를 부담하지 아니한다.
                        </li>
                        <li><span class="txt_num">③</span>“AK”와 “강사”는 상호 합의에 의하여 강의의 폐강여부를 정할 수 있다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제7조 (강사료 지급)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>“AK”는 “강사”의 강의 업무 수행에 대한 대가로 강사료를 지급하며, 당사자간의 별도 협의가 없는 본 강사료에는 강의와 관련한 일체의 제반 비용이 모두 포함된 것으로 한다. 
                        </li>
                        <li><span class="txt_num">②</span>“AK”는 본 계약 제 2조의 강사료 지급 기준에 의거하여 강의별 강사료 산출 후 3개월 단위로 운영되는 특강은 학기 중간 달, 정규강의는 학기 마지막 달에 “강사”가 지정한 은행 계좌로 학기별 1회, 해당월 20일까지 강사료를 지급한다.
                        </li>
                        <li><span class="txt_num">③</span>강사료 지급 금액에 대해 대한민국 정부에서 부과하는 제세 공과금(원천징수 포함)은 “강사”가 부담한다.
                        </li>
                        <li><span class="txt_num">④</span>“강사”의 사유로 휴강한 경우(“AK”의 사전동의를 득한 경우도 포함)에는 그 휴강 분에 해당하는 강사료는 지불하지 않는 것으로 한다. 단, 보강을 행한 경우는 예외로 한다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제8조 (권리)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>"강사"는 자신이 제공하는 자료와 관련하여 지적소유권 등 제반 권리와 관련된 소송제기, 손해배상청구 등 분쟁이 발생하지 않도록 적절한 조치를 취하여야 하며, 자료를 구성하는 모든 정보는 정확한 것임을 보증한다.
                        </li>
                        <li><span class="txt_num">②</span>"강사"가 전항의 의무를 위반하여 "AK"가 수강생 또는 기타 제3자로부터 손해배상청구, 소송제기가 발생하는 경우 “강사”는 이로부터 “AK”를 면책시키고 “강사”의 책임과 비용으로 이를 해결한다.
                        </li>
                        <li><span class="txt_num">③</span>“강사”는 “AK”가 제공하는 자료에 대하여 "AK"의 사전 승인 없이 계약상의 정보제공 목적 이외의 용도로 사용하거나 이를 재가공하여 활용할 수 없다. 
                        </li>
                    </ul>
					<strong class="tit-subject">
						제9조 (신용 보호 등)
					</strong>
					<p class="desc-g">“AK”와 “강사”는 상대방의 명예, 신용 및 이미지가 훼손되지 아니하도록 하여야 하고, 만일 상대방의 명예, 신용 및 이미지가 훼손되는 행위를 하였을 때에는 이와 관련한 민ㆍ형사상의 책임을 부담한다.</p>
					<strong class="tit-subject">
						제10조 (권리ㆍ의무 양도 제한) 
					</strong>
					<p class="desc-g">“AK”와 “강사”는 본 계약서상 쌍방간의 권리 또는 의무의 전부 또는 일부를 상대방의 사전 서면 동의 없이 제3자에게 양도, 이전, 담보제공 등의 행위를 할 수 없다.</p>
					<strong class="tit-subject">
						제11조 (대리권 등) 
					</strong>
					<p class="desc-g">본 계약으로 인하여 “강사”가 “AK”를 법적ㆍ사실적으로 대표하거나 대리하지 못하며, “AK”를 대표 혹은 대리하여 어떠한 종류의 권리나 의무 및 책임도 발생시킬 권한이 있는 것으로 해석되어서는 안되며, “AK”의 사전 서면 동의 없이 “AK” 또는 “AK”의 계열사 등 관계회사를 상징하는 로고, 상호 등 상징물을 사용하거나 이용할 수 없다.</p>
					<strong class="tit-subject">
						제 12조 (초상권 및 지재권 제공 동의)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>“강사”는 “AK”가 홍보자료, 기록자료 등 컨텐츠를 제작하여 배포, 활용하는 과정에서, “AK”가 필요한 강의 정보 등 지식재산권을 사용함과, “강사”의 초상사진을 무료로 활용하는 것에 동의한다.
                        </li>
                        <li><span class="txt_num">②</span>“AK”가 활용하는 전 항의 “강사”의 ‘강의정보’는 “강사”가 적합하게 취득하여 소유한 것임을 보증하여야 하며, 이에 관하여 제3자간의 권리분쟁이 발생할 경우 “강사”의 책임과 비용으로 “AK”를 면책시켜야 한다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제13조 (기밀유지 등)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>“AK”와 “강사”는 본 계약의 내용을 포함하여 계약기간 내에 인지 또는 취득한 상대방의 기밀 또는 정보 그리고 보유한 수강생 관련 정보를 외부에 유출해서는 안되며 이를 위반했을 시에는 민ㆍ형사상 일체의 책임을 위반당사자가 진다. 만약 이로 인해 상대방에게 손해가 발생하는 경우 이를 즉시 배상하여야 하며 수강생을 포함한 제3자가 제기하는 모든 분쟁, 소송, 청구 등으로부터 상대방을 면책시켜야 한다.
                        </li>
                        <li><span class="txt_num">②</span>본 조에 규정된 사항은 계약 종료 후에도 적용된다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제14조 (계약의 해제, 해지)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>“AK”와 “강사”는 다음 각 호의 하나에 해당하는 사항이 발생한 경우 본 계약을 즉시 해제 또는 해지할 수 있다.
							<ul class="list_2depth">
								<li><span class="num02">1.</span>일방이 스스로 회사정리, 회생절차, 파산절차를 신청하였거나, 채권자의 신청에 의해 그 절차가 개시되는 경우</li>
								<li><span class="num02">2.</span>일방의 주요 재산에 대해 압류, 강제집행이 실행되는 경우</li>
								<li><span class="num02">3.</span>강의의 수강생이 모집 정원의 50%에 미달되어 강의가 폐강되는 경우</li>
								<li><span class="num02">4.</span>강사가 자신의 귀책을 불문하여 자신에 대한 사회적, 도덕적 명예를 훼손하는 경우</li>
							</ul>
                        </li>
                        <li><span class="txt_num">②</span>"AK”와 “강사”는 다음 각 호의 하나에 해당하는 사항이 발생한 경우, 7일 이상의 기간을 정하여 서면으로 그 사유와 함께 시정할 것을 최고할 수 있으며, 그럼에도 불구하고 기간 내 시정이 이뤄지지 않는 경우, 서면 통보에 의해 계약을 해제 또는 해지할 수 있다.
							<ul class="list_2depth">
								<li><span class="num02">1.</span>일방의 채권자에 의해 회사정리, 회생절차, 파산절차의 신청이 있는 경우</li>	
								<li><span class="num02">2.</span>주요 재산에 대해 가압류, 가처분이 집행되는 경우</li>	
								<li><span class="num02">3.</span>등록 수강생 50% 이상으로부터 “강사”의 교체요구가 있거나 불만제기가 있는 경우</li>	
								<li><span class="num02">4.</span>“강사”의 수강생과의 상거래, 금품거래사실이나 개별 학습 권유사실이 발생한 경우</li>
								<li><span class="num02">5.</span>“AK”가 강의와 관련하여 합리적으로 요청하는 사항을 “강사”가 이행하지 않는 경우</li>
								<li><span class="num02">6.</span>기타 계약상의 의무를 위반하는 경우</li>
							</ul>
                        </li>
						 <li><span class="txt_num">③</span>"AK"의 경영상 판단 등 부득이한 사유로 본 계약의 유지가 곤란한 경우, 계약기간 중 1개월(30일)이상의 기간을 정하여 서면 통지로 본 계약의 전부 또는 일부를 해지 할 수 있다. 이 경우, “강사”는 이로 인한 어떠한 손해배상도 “AK”에게 청구할 수 없다. 
						 </li>
						 <li><span class="txt_num">④</span>본 조에 의하여 계약이 해제 또는 해지되더라도 일방의 상대방에 대한 손해 배상청구에 영향을 미치지 아니한다.
						 </li>
                    </ul>
					<strong class="tit-subject">
						제15조 (위약벌)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>제14조 제1항 제4호에 따라 계약이 해제, 해지되는 경우, 이와는 별개로 이미지, 브랜드 실추에 대한 위약벌로써 “강사”는 “AK”에게 강사료를 지급받는 경우 “AK”가 기지급한 강사료의 2배의 금액 및 강사료의 20%에 상응하는 금액, 강사료를 지급받기 전인 경우 “AK”가 지급할 예정이었던 강사료와 동일 금액 및 강사료의 20%에 상응하는 금액을 30일 이내에 “AK”에게 현금으로 배상하여야 한다.
                        </li>
                        <li><span class="txt_num">②</span>제5조 제1항에도 불구하고, “강사”가 신변이나 교통, 기타 불가항력의 사유로 강의 일정에 응하지 아니하거나 강의 일정을 준수하지 못하게 된 경우, “강사”가 “AK”에게 사전에 그 사유를 통보하였는지의 여부와 관계 없이, 이에 대한 위약벌로써 “강사”는 강사료가 정액제인 경우 해당 회차 강사료의 20%에 상응하는 금액, 강사료가 비율제인 경우 총 강사료를 총 회차로 나눈 후 해당 회차의 수를 곱한 금액의 20%에 상응하는 금액을 30일 이내에 “AK”에게 현금으로 지급하여야 한다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제16조 (손해배상) 
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>“AK” 또는 “강사”가 계약 위반이나 의무 이행의 태만, 기타 귀책으로 인하여 상대방 또는 제3자에게 유, 무형의 손해를 초래한 경우 귀책사유가 있는 일방이 이로 인한 민∙형사상의 책임을 지고 상대방 또는 제3자에게 손해금액을 배상한다. 단 천재지변, 법령의 변경, 기타 계약당사자가 통상적인 주의력 및 예방수단으로 저지할 수 없는 불가항력으로 인한 경우에는 그러하지 아니하다. 
                        </li>
                        <li><span class="txt_num">②</span>“강사”는 본 계약에 따른 “강의” 중 수강생 또는 제3자의 권리를 침해하여 신체상 또는 재산상의 손해가 발생하여 “AK”에게 손해배상청구, 소송제기가 발생하는 경우 “강사”는 이로부터 “AK”를 면책시키고 “강사”의 책임과 비용으로 이를 해결한다. 만약, 수강생 또는 제3자가 “AK”를 상대로 위와 같은 권리주장, 이의제기 또는 소송제기를 하여 “AK”에게 손실, 손해 또는 기타 비용지출이 발생하는 경우에는 “강사”는 그 손실, 손해 또는 비용지출을 배상 또는 보상하여야 한다. 
                        </li>
                        <li><span class="txt_num">③</span>"강사"는 본 계약이 이루진 후 "AK"의 동의 없이 강의를 중단, 폐지 할 수 없으며 만약 이를 위반했을 경우는 "강사"의 비용과 책임으로 “AK” 및 수강생 등의 손해액을 배상하여야 한다.
                        </li>
                    </ul>
					<strong class="tit-subject">
						제 17조 (개인정보의 보호 및 처리)
					</strong>
					<ul class="list_1depth">
                        <li><span class="txt_num">①</span>“강사”는 “AK”의 동의없이 본 계약의 이행과정에서 취득하는 수강생에 대한 개인정보를 수집 목적 범위를 넘어 사용하거나, 제 3자에게 제공하여서는 안되며, 강의교육과정 종료 이후에는 수강생의 개인정보를 즉시 폐기한다.
                        </li>
                        <li><span class="txt_num">②</span>“강사”는 신상 이력과 강의 이력, 학력, 자격 사항 등을 사전에 “AK”에 제출하여야 하며, “AK”는 제출된 자료의 진위여부 검증을 위한 목적으로 제 3자에게 제공할 수 있다.
                        </li>
                        <li><span class="txt_num">③</span>“AK”는 본 계약 종료 시점부터 5년 후, 강의 관련 이력을 제외한 개인 정보(연락처, 주소, 계좌정보 등)는 파기함을 원칙으로 한다. 
                        </li>
						<li><span class="txt_num">④</span>본 조에 규정된 사항은 계약 종료 후에도 적용된다. 
                        </li>
                    </ul>
					<strong class="tit-subject">
						제18조 (계약의 변경)
					</strong>
					<p class="desc-g">본 계약의 변경은 “AK”와 “강사”의 별도의 서면 합의에 의한다.</p>
					<strong class="tit-subject">
						제 19조 (관할 법원)
					</strong>
					<p class="desc-g">본 계약에 관한 일체의 분쟁 발생시 법률적인 해결은 서울중앙지방법원을 합의관할 법원으로 한다.</p>
					<strong class="tit-subject">
						제 20조 (효력 및 해석)
					</strong>
					<p class="desc-g">본 계약서에 정한 사항 이외의 것에 대해서는 일반적인 상관례에 준한다.</p>
					<p class="desc-g desc-align">위와 같이 계약을 체결하고 본 계약을 체결하고 본 계약을 입증하기 위하여 서명 날인한 후 "AK"와 "강사"가 각 1부씩 보관한다.</p>


	


					<div class="date-align">
						<p class="desc-date"> 
							${CONT_YEAR} 년    ${CONT_MON} 월   ${CONT_DAY} 일
						</p>
					</div>

					<div class="ct-info">
						<ul class="ct-info-wra">
							<li>"AK"</li>
							<li>에이케이에스앤디㈜</li>
							<li>경기도 평택시 평택로51, 지하2층(평택동)</li>
							<li>대표이사 김재천 (인)</li>
						</ul>
						<div class="tutor-sign">
							<p class="top">"강사"</p>
							<p>${CUS_PN}(인)</p>
						</div>
					</div>
				</div>
		
			<c:if test="${INFO_YN eq 'Y'  && INFO_YN eq 'Y'}">
				<div class="contract-cont cont02">
					<h1 class="ct-kor">윤리규정 및 정보보안 서약서</h1>
					<div class="cp-align">
						<p class="desc-g">
							본 서약은 [${CONT_YEAR}]년 [${CONT_MON}]월 [${CONT_DAY}]일자 <strong>에이케이에스엔디㈜</strong>(이하 “AK”라 한다)와  <strong>${CUS_PN}</strong>(이하 “본인”이라 함)간 체결한 문화아카데미 강좌 계약(이하 ‘본 계약’이라 함)에 부수하여 서약하는 것으로서, 본인은 AK PLAZA 문화아카데미에 출강함에 있어 개인정보보호법, 정보통신이용촉진 및 정보보호 등에 관한 법률, 기타 관련 제법령을 위반하지 않을 것이며 아래의 사항을 준수할 것을 서약합니다.
						</p>
						<strong class="tit-subject">
							[기본 윤리 및 수강생 존중]
						</strong>
						<ul class="list_1depth">
							<li><span class="txt_num">1.</span>AK PLAZA문화아카데미 강사로서 정직하고 공정한 자세로 교육에 임하여 건전하고 깨끗한 교육 문화를 조성 및 AK 문화아카데미의 신뢰를 유지하고 발전시킬 수 있도록 노력한다.
							</li>
							<li><span class="txt_num">2.</span>계약 및 출강을 통하여 인지한 경영비밀, 정보 등을 누설하거나 부당하게 이용하지 않는다.
							</li>
							<li><span class="txt_num">3.</span>수강생을 공정하고 평등하게 대우하며 정당한 요구와 제안을 존중하며 수강생과 문화아카데미 구성원간의 상호신뢰와 협력관계를 구축하여 공동발전을 도모한다. 
							</li>
							<li><span class="txt_num">4.</span>수강생과의 약속은 철저히 준수하고, 수강생이 알아야 하거나 수강생에게 알려야 하는 사실은 적극 공개 하도록 한다.
							</li>
						</ul>

						<!-- 표 -->
						<strong class="tit-subject">
							[부당행위금지]
						</strong>
						<div class="article-wra">
							<ul class="list_1depth">
								<li><span class="txt_num">1.</span><span class="empha">우월적 지위를 남용하여 수강회원에게 부당행위를 강요</span>하지 않는다.
								</li>
								<li><span class="txt_num">2.</span><span class="empha">수강회원으로부터 일체의 금품, 향응, 편의 등을 상호 제공</span> 받지 않는다.
								</li>
								<li><span class="txt_num">3.</span><span class="empha">수강회원을 선동, 동원하는 등으로 문화아카데미 업무를 방행하지 않으며 현행법령 위반 행위</span>를 하지 않는다.
								</li>
								<li><span class="txt_num">4.</span><span class="empha">수강회원에게 별도의 개별 학습을 권하거나, 타 학습기관으로의 이동을 유도</span>하지 않는다.
								<li><span class="txt_num">5.</span><span class="empha">성희롱, 성추행, 성적발언 등으로 민원이 접수</span>되지 않도록 한다.
								</li>
							</ul>
						</div>

						<strong class="tit-subject">
							[초상권 및 지재권 사용 동의]
						</strong>
						
						<div class="article-wra">
							<p>강의정보, 강의 장면, 기타 강의 관련 지식재산권 등은 홍보자료, 기록자료 등 각종 콘텐츠의 제작, 배포, 활용에 사용될 수 있음에 동의 한다.</p>
						</div>

						<strong class="tit-subject">
							[정보보안 서약 동의]
						</strong>
						<div class="article-wra">
							<ul class="list_1depth">
								<li><span class="txt_num">1.</span>본인은 AK PLAZA 문화아카데미 강좌 업무와 관련하여 획득한 모든 정보를 본 계약기간 중 또는 종료 후에도 AK PLAZA 문화아카데미 및 정보주체의 사전 허락 없이 누설하거나 배포하지 않겠습니다.
								</li>
								<li><span class="txt_num">2.</span>본인은 AK PLAZA 문화아카데미로부터 제공받은 수강생의 개인정보가 있을 경우 강좌 제공 외의 목적으로 이용하거나 제3자에게 유출하지 않으며, 교육과정 종료 이후에는 수강생의 개인정보를 즉시 폐기하겠습니다.
								</li>
								<li><span class="txt_num">3.</span>본인은 AK PLAZA 문화아카데미 명의로 개인정보를 수집, 이용하거나 AK PLAZA 문화아카데미가 수집, 이용하는 것으로 오인하게 하지 않겠습니다.
								</li>
								<li><span class="txt_num">4.</span>본인의 고의 또는 과실로 개인 정보 유출 사고가 발생한 경우, 정보주체의 손해를 배상하고 AK PLAZA 문화아카데미를 면책시키겠습니다.
								</li>
							</ul>
							<p class="promise">본인은 상기 사항 위반 시에는 관련법에 의거한 민•형사상의 책임과 함께 귀사의 모든 조치에 이의를 제기하지 않겠습니다.</p>
							<p class="promise last">본인은 AK PLAZA 문화아카데미에 출강함에 있어 상기 윤리규정 및 정보보안을 준수할 것을 서약하며, 상기 사항 위반 시에는 법적인 책임과 함께 귀사의 모든 조치에 이의를 제기하지 않겠습니다.</p>
							<div class="ct-info">
								<ul class="ct-info-wra prom">
									<li>${CONT_YEAR}년 ${CONT_MON}월 ${CONT_DAY}일</li>
									<li>에이케이에스앤디㈜ 귀중</li>
								</ul>
								<div class="tutor-sign">
									<p>서약자(강사): ${CUS_PN} (서명)</p>
								</div>
							</div>
						</div>
					</div><!--//cont02 -->
				</div><!-- //contract-cont 끝-->
			</c:if>
			
		<c:if test="${NAVER_YN eq 'Y'  && CONFIRM_YN eq 'Y'}">
			<div class="contract-cover">
				<h1 class="ct-kor">네이버 eXpert 서비스 이용 합의서</h1>
			</div>
			<div class="contract-cont cont04">
				<p class="desc-g">
					<strong>에이케이에스앤디㈜AK ${STORE_NM}</strong>(이하 “AK”라 한다)와 <strong>${WEB_LECTURER_NM}</strong>(이하 “강사”라 한다)는  당사자간 체결한 강사계약서(이하 “강사계약”)에 부속하여 다음과 같이 합의하고 이를 성실하게 이행하기로 한다. 
				</p>
				<strong class="tit-subject">
					제1조 목적
				</strong>
				<p class="desc-g">본 합의서는 “AK”가 네이버주식회사(이하 “네이버”라 한다.)가 운영하는 지식iN eXpert 사이트(PC, 모바일 어플리케이션, 모바일웹 등을 모두 포함하여 이하 “eXpert 사이트”라 한다.), eXpert 센터를 통해 제공하는 인터넷 전문가 상담 등 전자상거래 중개 서비스(이하 “eXpert 서비스”라 한다.)에 eXpert 서비스 전문가로 가입∙입점하고, “강사”를 “AK”의 소속전문가로 하여 eXpert 서비스를 통해 강의를 개설∙운영키로 함에 있어 당사자간의 권리, 의무, 책임 제반 절차 및 기타 필요한 사항을 규정함을 목적으로 한다.</p>
			
				<strong class="tit-subject">
					제2조 eXpert 서비스 이용			
				</strong>
					<ul class="list_1depth">
						<li><span class="txt_num">①</span>“AK”는 네이버와 eXpert 서비스에 대한 이용계약을 체결하여 eXpert 서비스에 입점하여 강의를 등록∙관리하며, “강사”는 “AK”와 체결한 강사계약을 바탕으로 하여 “AK”의 소속전문가로 eXpert 서비스에 가입하여 강의를 제공한다.
                        </li>
                        <li><span class="txt_num">②</span>“AK”와 “강사”는 eXpert 서비스를 이용함에 있어 eXpert 사이트, eXpert센터에 게시된 네이버의 이용약관 및 이용정책을 확인하고, 이를 준수할 의무를 부담한다. 
                        </li>
                        <li><span class="txt_num">③</span>“강사”는 자신의 eXpert 계정 아이디(ID)와 비밀번호가 유출되지 않도록 관리하여야 하며, 이를 제3자가 이용하도록 허락할 수 없다. 계정 아이디 및 비밀번호가 도용되었거나 유출된 것을 인지한 경우에는 즉시 “AK” 및 “네이버”에 이를 통지하고 필요한 조치를 취하여야 한다.
                        </li>
                        <li><span class="txt_num">④</span>“강사”는 eXpert 서비스에 등록된 강의를 본인이 직접 제공하여야 하며, 강의 제공을 위해 제3자의 지식재산권을 사용하게 되는 경우, 당해 권리자로부터 사용에 대한 허가를 취득한 후에 사용해야하며, 제3자의 상표권, 특허권, 저작권, 성명권, 초상권 등 제반 권리를 침해하지 않아야 한다.
                        </li>
                        <li><span class="txt_num">⑤</span>“강사”는 구매회원의 문의에 정확하고 성실하게 답변해야 하며, “AK”의 사전 서면동의가 없는 한 eXpert 서비스를 통하지 않는 직거래 유도행위 및 구매회원의 직거래 요청을 수락하는 행위를 하여서는 아니된다.
                        </li>
                        <li><span class="txt_num">⑥</span>“AK”와 “강사”가 체결한 강사계약이 종료되어 더 이상 “강사”가 “AK”의 강의를 운영하지 않는 경우, “강사”는 즉시 eXpert 서비스에 탈퇴하여야 한다. 이를 이행하지 않을 경우, “AK”는 직접 또는 “네이버”로 하여금 “강사”의 eXpert 계정에 대한 노출 제한, 이용정지, 강제 탈퇴 등 필요한 조치를 취할 수 있으며 “강사”는 이에 대해 이의를 제기하지 않기로 한다.
                        </li>
					</ul>
			
				<strong class="tit-subject">
					제3조 개인 정보	
				</strong>
					<ul class="list_1depth">
						<li><span class="txt_num">①</span>“강사”는 eXpert 서비스의 이용에 따라 취득한 구매회원 등 타인의 개인정보 및 전달받은 의뢰 내용 및 상담 등 채팅내용 등에 대해 강의 제공의 목적 이외의 용도로 사용하거나 제3자에게 제공하는 등 외부에 유출할 수 없으며, 관련 법령 및 네이버 이용약관, 운영정책 등에 따라 철저히 보호하고, 비밀로 유지하여야 한다.
                        </li>
                        <li><span class="txt_num">②</span>“강사”는 “AK”의 소속전문가로 eXpert 서비스에 가입하기 위하여 필요한 정보를 네이버에 제공하여야 하며, “강사”가 이를 거부할 경우 eXpert 서비스 가입 및 이용이 불가할 수 있음을 확인한다.
                        </li>
					</ul>
			
				<strong class="tit-subject">
					제4조 대금 정산	
				</strong>
					<ul class="list_1depth">
						<li><span class="txt_num">①</span>eXpert 서비스를 통해 제공된 강의에 대한 거래확정이 이루어지는 경우, “AK”는 강사계약서 에 명시된 강사료 지급일 까지 전월 1일부터 말일까지 확정된 거래의 강사료에서 eXpert 서비스 이용료(결제수수료 및 부가세 포함 0.00%)를 공제한 나머지 금액을 강사에게 지급한다. 단, 서비스 이용료는 네이버의 이용약관 및 이용정책의 변경 등에 따라 변경될 수 있다.
                        </li>
                        <li><span class="txt_num">②</span>강사계약 또는 본 합의서에 따른 eXpert 서비스 이용의 종료 시, “AK”는 수강료의 일정 비율에 해당하는 금액을 계약종료일로부터 일정기간 동안 예치하여 동기간 동안 구매회원으로부터의 환불, 민원제기 시 관련 비용의 지급에 사용할 수 있다. 
                        </li>
                        <li><span class="txt_num">③</span>“강사”가 “AK”에게 지급할 금원이 있는 경우에는 “AK”가 “강사”에게 지급할 대금과 상계할 수 있다.
                        </li>
					</ul>
					
				<strong class="tit-subject">
					제5조 계약의 효력 및 손해배상
				</strong>
					<ul class="list_1depth">
						<li><span class="txt_num">①</span>본 합의서는 당사자간 체결한 강사계약에 부속하는 효력을 가지며 본 합의서에서 명시되지 아니한 사항은 상호 별도로 합의하여 정하거나 강사계약의 내용을 준용한다. 
                        </li>
                        
                        <li><span class="txt_num">②</span>“AK” 또는 “강사”는 다음 각 호의 사유가 발생하였을 경우 즉시 본 합의서를 해지할 수 있다.
                        	<ul class="list_2depth">
								<li><span class="num02">1.</span>“AK” 또는 “강사”간 체결한 강사계약이 종료 또는 해지되는 경우</li>
								<li><span class="num02">2.</span>“AK” 또는 “강사”가 영업 또는 자격의 정지∙취소 등의 판정을 받은 경우</li>
								<li><span class="num02">3.</span>기타 본 합의서를 이행할 수 없는 것이 사정이 확정된 경우</li>
							</ul>
                        </li>
                        <li><span class="txt_num">③</span>“AK” 또는 “강사”는 다음 각 호의 사유가 발생한 때에는 상대방에게 서면으로 상당 기간을 정하여 그 이행을 최고하고 그 기간 내에 이행하지 아니하는 때에는 본 합의서를 해지할 수 있다.
                        	<ul class="list_2depth">
								<li><span class="num02">1.</span>“AK” 또는 “강사”가 본 합의서의 중요한 내용을 위반한 경우</li>
								<li><span class="num02">2.</span>“AK” 또는 “강사”가 정당한 이유 없이 본 합의서의 이행을 거부하거나 상당기간 동안 이행을 지체한 경우</li>
								<li><span class="num02">3.</span>“AK” 또는 “강사”가 상대방에 대한 비방을 하거나 상대방의 이미지 손상에 직간접적으로 관여한 경우</li>
							</ul>
                        </li>
                        <li><span class="txt_num">④</span>일방 당사자가 본 합의서에서 정한 사항을 위반하여, 상대방 또는 제3자에게 손해가 발생한 경우, 귀책당사자는 상대방을 면책시키고 자신의 책임으로 손해를 배상하여야 한다.
                        </li>
					</ul>


					<div class="date-align">
						<p class="desc-date"> 
							${CONT_YEAR} 년   ${CONT_MON} 월  ${CONT_DAY} 일
						</p>
					</div>

					<div class="ct-info">
						<ul class="ct-info-wra">
							<li>"AK"</li>
							<li>에이케이에스앤디㈜</li>
							<li>경기도 평택시 평택로51, 지하2층(평택동)</li>
							<li>대표이사 김재천 (인)</li>
						</ul>
						<div class="tutor-sign">
							<p class="top">"강사"</p>
							<p>${CUS_PN}(인)</p>
						</div>
					</div>
			</div>
		</c:if>
				
				
				
				
			<c:if test="${CONFIRM_YN eq 'Y'}">
				<div class="contract-cont cont05">		
					<div class="cont03 article-wra">
						<p>본 계약서는 상기 계약 당사자 간에 본인인증을 득하여 체결한 전자계약서입니다.</p>
					</div>
				</div>
			</c:if>	
		</div>
		
	</div>


	</div>
</div>

<div class="btn-wr text-center">

	
	<a class="btn btn01 ok-btn" href="/lecture/lecr/contract">목록으로</a>
	<c:if test="${CONFIRM_YN eq 'N'}">
		<a class="btn btn02 ok-btn" onclick="javascript:lastSumibt('Y')">발송</a>
		<a class="btn btn01 ok-btn" onclick="javascript:lastSumibt('R')">회수</a>
	</c:if>					
</div>

<div class="css-box">
			#hideBtn {
				font-family: 'Material Icons';
				min-width: 34px;
			    text-align: Center;
			    display: inline-block;
			    height: 34px;
			    line-height: 34px;
			    border-radius: 100%;
			    vertical-align: middle;
			    cursor: pointer;
			    border: solid 1px #000;
			}
			#hideBtn > i {
				line-height: inherit;
			}
			</div>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>