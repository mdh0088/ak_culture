<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(function(){
	/* 탭 */
	$(".tab-wrap").each(function(){
		var tab = $(this).find(".tab-title ul > li");
		var cont = $(this).find(".tab-content > div");

		tab.click(function(){
			var ind=$(this).index();
			tab.removeClass("active");
			$(this).addClass("active");
			cont.removeClass("active");
			cont.eq(ind).addClass("active");
			cont.hide();
			cont.eq(ind).show();
			thSize();
		});
	});
});
$(function(){
	$(".chk-ul-fg > li").click(function(){
		var chk = $(this).find("input").attr("id");
		console.log(chk)
		if(chk == "corp_fg_1"){
			$(".corpfg02").css("display","inline-block");
		}else{
			$(".corpfg02").hide();
		}
	})
})
$(window).ready(function(){
	$(".lec-none").hide();	
	$(".lec-de").click(function(){
		$(".lec-none").hide();		
	})
	$(".lec-de02").click(function(){
		$(".lec-none").show();		
	})
	
	
})
$(document).ready(function(){
	$("#kor_nm").val('${lecr.CUS_PN}');
	$("#phone_no").val('${lecr.MTEL_IDENT_NO}-${lecr.MMT_EX_NO}-${lecr.MTEL_UNIQ_NO}');
	$("#birth_ymd").val('${lecr.BMD}');
	$("#email_addr").val('${lecr.EMAIL_ADDR}');
	$("#cus_no").val('${lecr.LECTURE_CUS_NO}');
	$("#cus_no2").val('${lecr.LECTURE_CUS_NO}');
	$("#lecturer_cd").val('${lecr.LECTURER_CD}');
	$("#ptl_id").val('${lecr.PTL_ID}');
	$("#card_no").val('${lecr.CARD_NO}');
	$("#create_date").val('${lecr.RG_DTM}');
	$("#biz_post_no").val('${lecr.BIZ_POST_NO}');
	$("#biz_addr_tx1").val('${lecr.BIZ_ADDR_TX1}');
	$("#biz_addr_tx2").val('${lecr.BIZ_ADDR_TX2}');
	$("#prev_car_no").val('${lecr.LECTURE_CAR_NO}');
	
	$("input:radio[name='corp_fg']:radio[value='${lecr.CORP_FG}']").prop('checked', true);
	if('${lecr.CORP_FG}' == "1")
	{
		$(".corpfg02").css("display","inline-block");
		$(".lec-none").show();		
	}
	else
	{
		$(".corpfg02").hide();
		$(".lec-none").hide();	
	}
	$("#biz_no").val('${lecr.BIZ_NO}');
	$("#bank_cd").val('${lecr.BANK_CD}');
	$("#account_nm").val('${lecr.ACCOUNT_NM}');
	$("#account_no").val('${lecr.ACCOUNT_NO}');
	$("#biz_nm").val('${lecr.BIZ_NM}');
	$("#president_nm").val('${lecr.PRESIDENT_NM}');
	$("#industry_c").val('${lecr.INDUSTRY_C}');
	$("#industry_s").val('${lecr.INDUSTRY_S}');
	$("#cus_address_1").val('${lecr.PSNO}');
	$("#cus_address_2").val('${lecr.PNADD}');
	$("#cus_address_3").val('${lecr.DTS_ADDR}');
	
	
	$("#school").val('${lecr_point[0].SCHOOL}');
	$("#school_cate").val('${lecr_point[0].SCHOOL_CATE}');
	
	var grade = "F";
	var point = Number('${lecr_point[0].POINT}');
	if(point >= 90)
	{
		grade = "A";
	}
	else if(point >= 80)
	{
		grade = "B";
	}
	else if(point >= 70)
	{
		grade = "C";
	}
	else if(point >= 60)
	{
		grade = "D";
	}
	else if(point >= 50)
	{
		grade = "E";
	}
	$("#t_point_div").html(point+" / "+grade);
	$("input:radio[name='1_point']:radio[value='${lecr_point[0].POINT_1}']").prop('checked', true); 
	$("input:radio[name='2_point']:radio[value='${lecr_point[0].POINT_2}']").prop('checked', true); 
	$("input:radio[name='3_point']:radio[value='${lecr_point[0].POINT_3}']").prop('checked', true); 
	$("input:radio[name='4_point']:radio[value='${lecr_point[0].POINT_4}']").prop('checked', true); 
	
	var point_5_arr = '${lecr_point[0].POINT_5}'.split("|");
	for(var i = 0; i < point_5_arr.length; i++)
	{
		if(point_5_arr[i] == "언론매체 출연")
		{
			$("#5_point_1").prop('checked', true); 
		}
		if(point_5_arr[i] == "관련 저서")
		{
			$("#5_point_2").prop('checked', true); 
		}
		if(point_5_arr[i] == "입상 및 자격증")
		{
			$("#5_point_3").prop('checked', true); 
		}
		if(point_5_arr[i] == "기타")
		{
			$("#5_point_4").prop('checked', true); 
		}
	}
	
	var start_ymd_arr = '${lecr_point[0].START_YMD}'.split("|");
	var end_ymd_arr = '${lecr_point[0].END_YMD}'.split("|");
	var history_arr = '${lecr_point[0].HISTORY}'.split("|");
	for(var i = 0; i < start_ymd_arr.length-1; i++)
	{
		if(i > 0)
		{
			add_history();
		}
		$("#start_ymd"+(i+1)).val(start_ymd_arr[i]);
		$("#end_ymd"+(i+1)).val(end_ymd_arr[i]);
		$("#history"+(i+1)).val(history_arr[i]);
	}
	
	$("#point_writer").html('${lecr.CREATE_NAME}');
	$("#point_date").html(cutDate('${lecr.CREATE_DATE}'));
	$("#other").val('${lecr_point[0].OTHER}');
	comPoint();
	getMemoList();
	getList();
});
var history_cnt = 2;
function add_history()
{
	var inner = "";
	inner += '<div class="lecr-cal" id="history_div_'+history_cnt+'">';
	inner += '	<div class="cal-row cal-row_inline cal-row02">';
	inner += '		<div class="cal-input cal-input140 wid-4">';
	inner += '			<input type="text" class="date-i" id="start_ymd'+history_cnt+'" name="start_ymd">';
	inner += '			<i class="material-icons">event_available</i>';
	inner += '		</div>';
	inner += '		<div class="cal-dash">-</div>';
	inner += '		<div class="cal-input cal-input140 wid-4">';
	inner += '			<input type="text" class="date-i" id="end_ymd'+history_cnt+'" name="end_ymd">';
	inner += '			<i class="material-icons">event_available</i>';
	inner += '		</div>';
	inner += '	</div>';
	inner += '	<div>';
	inner += '		<input type="text" class="inp-50" id="history'+history_cnt+'" name="history" placeholder="내용을 입력해주세요." />';
	inner += '		<i class="material-icons remove" onclick="remove_history('+history_cnt+')">remove_circle_outline</i>';
	inner += '	</div>';
	inner += '</div>';
	$("#target_history").append(inner);
	dateInit();
	history_cnt ++;
}
function remove_history(idx)
{
	$("#history_div_"+idx).remove();
}
$(function(){
	$("input:radio").click(function() {
		if($(this).attr("id").indexOf("point") > -1)
		{
			comPoint();
		}
	});
	$("input:checkbox").change(function() {
		if($(this).attr("id").indexOf("point") > -1)
		{
			comPoint();
		}
	});
});
function comPoint()
{
	chk_point = 0;
	var point_1 = $('input[name="1_point"]:checked').val();
	var point_2 = $('input[name="2_point"]:checked').val();
	var point_3 = $('input[name="3_point"]:checked').val();
	var point_4 = $('input[name="4_point"]:checked').val();
	
	if($("input:checkbox[id='5_point_1']").is(":checked"))
	{
		chk_point += 4;
	}
	if($("input:checkbox[id='5_point_2']").is(":checked"))
	{
		chk_point += 4;
	}
	if($("input:checkbox[id='5_point_3']").is(":checked"))
	{
		chk_point += 4;
	}
	if($("input:checkbox[id='5_point_4']").is(":checked"))
	{
		chk_point += 4;
	}
	
	point = Number(point_1) + Number(point_2) + Number(point_3) + Number(point_4);
	point += chk_point;
	
	var grade = "F";
	if(point >= 90)
	{
		grade = "A";
	}
	else if(point >= 80)
	{
		grade = "B";
	}
	else if(point >= 70)
	{
		grade = "C";
	}
	else if(point >= 60)
	{
		grade = "D";
	}
	else if(point >= 50)
	{
		grade = "E";
	}
	
	$("#t_point").val(point);
	$("#t_point_div").html(point+" / "+grade);
}

function getMemoList()
{
	
	$('.cust_memo_area').empty();
	$.ajax({
		type : "POST", 
		url : "./getMemo",
		dataType : "text",
		data : 
		{
			cus_no : $("#cus_no").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner ="";
			inner ='<tr class="cursor memo cust_memo_list_">';
			inner +='	<td><input type="text" id="memo_id_" class="new_memo memo_input inputDisabled inp-100 bor-no" onkeypress="excuteEnter(fncSubmit)" placeholder="내용을 입력하세요."></td>';
			inner +='	<td></td>';
			inner +='	<td></td>';
			inner +='	<td></td>';
			inner +='</tr>';
			
			for (var i = 0; i < result.length; i++) {
				inner +='<tr class="memo cursor cust_memo_list_'+(result.length-i)+'">';
				inner +='	<td>'+result[i].CONTENTS+'</td>';
				inner +='	<td>'+result[i].CREATE_DATE+'</td>';
				inner +='	<td>'+result[i].REGISTER+'</td>';
				inner +='	<td><i class="material-icons remove" onclick="remove_cust_memo(\''+result[i].CUS_NO+'_'+result[i].REG_NO+'\')">remove_circle_outline</i></td>';
				inner +='</tr>';
				
			}
			$('.cust_memo_area').html(inner);
		}
	});
}

function fncSubmit()
{
	var memo_list="";

	$('.new_memo').each(function(){
		if($(this).val() != '')
		{
			memo_list=memo_list+$(this).val()+'|';
		}
	})
	$.ajax({
		type : "POST", 
		url : "./ins_memo",
		dataType : "text",
		async : false,
		data : 
		{
			cus_no : $("#cus_no").val(),
			memo_list : memo_list
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
//     			location.reload();
				getMemoList();
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});	
}
function pointSubmit()
{
	var hl = "";
	$("[name='history']").each(function() 
	{
		if($(this).val() != "")
		{
			hl += $(this).val()+"|";
		}
	});
	$("#history_list").val(hl);
	hl = "";
	$("[name='start_ymd']").each(function() 
	{
		if($(this).val() != "")
		{
			hl += $(this).val()+"|";
		}
	});
	$("#start_ymd_list").val(hl);
	hl = "";
	$("[name='end_ymd']").each(function() 
	{
		if($(this).val() != "")
		{
			hl += $(this).val()+"|";
		}
	});
	$("#end_ymd_list").val(hl);
	$("#pointForm").ajaxSubmit({
		success: function(data)
		{
			console.log(data);
			var result = JSON.parse(data);
    		if(result.isSuc == "success")
    		{
    			alert(result.msg);
//	    			location.reload();
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});
}


function getList(paging_type) 
{
	$.ajax({
		type : "POST", 
		url : "./getLectListByLecr",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cus_no : $("#cus_no").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			var inner = "";
			
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+result.list[i].STORE_NM+'</td>';
					inner += '	<td>'+result.list[i].WEB_TEXT+'</td>';
					inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
					inner += '	<td>'+result.list[i].SECT_NM+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
					if(result.list[i].FIX_PAY_YN == "Y")
					{
						inner += '	<td>정률</td>';
					}
					else
					{
						inner += '	<td>정액</td>';
					}
					inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+result.list[i].REGIS_FEE+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
					inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
					inner += '	<td>'+result.list[i].START_YMD+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="12"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			if(paging_type == "scroll")
			{
				if(result.list.length > 0)
				{
					$("#list_target").append(inner);
				}
			}
			else
			{
				$("#list_target").html(inner);
			}
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
}
function add_memo(){
	
	if ($('.new_memo').length > 0) {
		return;
	}
	
	var now_manager_name = '${login_name}';
	
	var memo_cnt ="";
	$('.memo').each(function(){
		memo_cnt = $(this).attr('class');
		return false;
	})
		
	
	if (memo_cnt!='') {
		memo_cnt = memo_cnt.split("_");
		memo_cnt = (memo_cnt[3]*1)+1;
	}else{
		memo_cnt=1;
	}
	
	var now_day= cutDate(getNow());
	
	var inner ="";
	inner ='<tr class="cursor memo cust_memo_list_'+memo_cnt+'">';
	inner +='	<td><input type="text" id="memo_id_'+memo_cnt+'" class="new_memo memo_input inputDisabled inp-100 bor-no" onkeypress="excuteEnter(fncSubmit)" placeholder="내용을 입력하세요."></td>';
	inner +='	<td>'+now_day+'</td>';
	inner +='	<td>'+now_manager_name+'</td>';
	inner +='	<td><i class="material-icons remove" onclick="remove_cust_memo('+memo_cnt+')">remove_circle_outline</i></td>';
	inner +='</tr>';
	
	$('.cust_memo_area').append(inner);
	
	if (memo_cnt!='') {
		$('.cust_memo_list_'+memo_cnt).insertBefore('.cust_memo_list_'+((memo_cnt*1)-1));	
	}
// 	$("#review_layer").fadeIn(200);
	
}
function remove_cust_memo(idx){
	
	if(!confirm("정말 삭제하시겠습니까?")){
		return;
	}
	
	var arr = idx.split('_');
	$.ajax({
		type : "POST", 
		url : "./del_memo",
		dataType : "text",
		async : false,
		data : 
		{
			cus_no : arr[0],
			reg_no : arr[1]
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
				getMemoList();
    		}
    		else
    		{
    			alert(result.msg);
    		}
    		
		}
	});	
	
}
function saveReview()
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
function viewPhone()
{
	$(".sms-pop").show();
}
function openSms(){
	$("#sms_phone_no").html('${lecr.MTEL_IDENT_NO}-${lecr.MMT_EX_NO}-${lecr.MTEL_UNIQ_NO}');
	sms_phone_no = '${lecr.MTEL_IDENT_NO}-${lecr.MMT_EX_NO}-${lecr.MTEL_UNIQ_NO}';
	$("#sms_kor_nm").html('${lecr.CUS_PN}');
	$("#sms_layer").fadeIn(200);
}
function sendSms()
{
	$.ajax({
		type : "POST", 
		url : "/common/single_send_sms",
		dataType : "text",
		data : 
		{
			store : '${lecr.STORE}',
			phone_no : '${lecr.MTEL_IDENT_NO}${lecr.MMT_EX_NO}${lecr.MTEL_UNIQ_NO}',
			title : '문화아카데미',
			msg : $("#sms_contents").val()
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
</script>
<div class="sub-tit">
	<h2>강사상세</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>

<div class="table-top table-top_member">
	<div class="top-row sear-wr">
		<div class="wid-5">
			<div class="member-infoWarp">
				<div class="rank-txt">${lecr.CUS_CLASS}</div>
				<div>
					<div class="name">${lecr.CUS_PN}
						<span>
							<c:if test="${lecr.CORP_FG ne '' && lecr.CORP_FG ne null}">
								<c:if test="${lecr.BIZ_NM ne '' && lecr.BIZ_NM ne null}">(${lecr.BIZ_NM})</c:if>
								<c:if test="${lecr.BIZ_NM eq '' || lecr.BIZ_NM eq null}">(전문강사)</c:if>
							</c:if>
							<c:if test="${lecr.CORP_FG eq '' || lecr.CORP_FG eq null}">
								(거래선미등록)
							</c:if>
						</span>
					</div>
					<ul>
						<li onclick="viewPhone()"><i class="material-icons">settings_phone</i>
							<div class="sms-pop" style="display: none;"><div class="sms-con01">${lecr.MTEL_IDENT_NO}-${lecr.MMT_EX_NO}-${lecr.MTEL_UNIQ_NO}</div>		</div>
						</li>
						<li onclick="openSms()"><i class="material-icons">textsms</i></li>
						<li class="txt"><i class="material-icons">favorite</i>${lecr.STORE_NM}</li>
					</ul>
					
				</div>
				<div class="number">MEMNO. <span>${lecr.CUS_NO}</span></div>
			</div>
		
		</div>
		<div class="wid-5">
			<div class="member-infoWarp02">
				<div class="wid-6">
					<div><i class="material-icons">how_to_reg</i></div>
					<div class="memin-pri">
						<span>강사 승인일</span>
						<p><fmt:parseDate value="${fn:trim(fn:substring(lecr.CREATE_DATE, 0, 8))}" var="CREATE_DATE" pattern="yyyyMMdd"/><fmt:formatDate value="${CREATE_DATE}" pattern="yyyy-MM-dd"/></p> 
					</div>
				</div>
				<div class="wid-4">
					<div><i class="material-icons">event_note</i></div>
					<div class="memin-pri">
						<span>누적 강좌수</span>
						<p>${total_lect_cnt}<span>강</span></p> 
					</div>
				</div>
				
			</div>
			
		</div>
	</div>

</div>



<div class="table-wr">
	<div class="tab-wrap tab-wrap_mem">		
		<div class="tab-title tab-title_lecr">
			<ul>
				<li class="active">강사정보</li>
				<li>출강내역</li>
				<li>강사평가</li>
			</ul>
		</div> <!-- tab-title end -->
		
		
		<div class="tab-content lecr-manage">
		
			<div class="member-profile lecture-profile active">
				<div class="table-list ak-wrap_new table-list-no">
					<div class="row">
						<div class="wid-5">
							<div class="bor-div">
							
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">강사명</div>
											<div>
												<input type="text" class="inputDisabled" id="kor_nm" name="kor_nm" readOnly/>
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_120 sear-tit_left">휴대폰</div>
											<div>
												<input type="text" class="inputDisabled" id="phone_no" name="phone_no" readOnly/>
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">생년월일</div>
											<div>
												<input type="text" class="inputDisabled" id="birth_ymd" name="birth_ymd" readOnly/>
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_120 sear-tit_left">이메일</div>
											<div>
												<input type="text" class="inputDisabled" id="email_addr" name="email_addr" readOnly/>
											</div>
										</div>
									</div>
								</div>
								
							</div>
<!-- 								<div class="bor-div"> -->
<!-- 									<div class="top-row table-input"> -->
<!-- 										<div class="wid-10"> -->
<!-- 											<div class="table"> -->
<!-- 												<div class="sear-tit">회원형태<em>*</em></div> -->
<!-- 												<div> -->
<!-- 													<ul class="chk-ul"> -->
<!-- 														<li> -->
<!-- 															<input type="radio" id="rad-c" class="chkDisabled " name="rad-1" checked /> -->
<!-- 															<label for="rad-c">개인</label> -->
<!-- 														</li> -->
<!-- 														<li> -->
<!-- 															<input type="radio" id="rad-c" class="chkDisabled"  name="rad-1" /> -->
<!-- 															<label for="rad-c">법인</label> -->
<!-- 														</li> -->
<!-- 													</ul> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div>									 -->
<!-- 									</div>								 -->
<!-- 								</div>						 -->
							
							<div class="bor-div">
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">멤버스번호<em>*</em></div>
											<div>
												<input type="text" class="inputDisabled" id="cus_no" name="cus_no" readOnly/>
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_120 sear-tit_left">포털ID<em>*</em></div>
											<div>
												<input type="text" class="inputDisabled" id="ptl_id" name="ptl_id" readOnly/>
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">멤버스카드NO<em>*</em></div>
											<div>
												<input type="text" class="inputDisabled" id="card_no" name="card_no" readOnly/>
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_120 sear-tit_left">가입일자</div>
											<div>
												<input type="text" class="inputDisabled" id="create_date" name="create_date" readOnly/>
											</div>
										</div>
									</div>
								</div>
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">차량번호</div>
											<div>
												<input type="text" id="prev_car_no" name="prev_car_no"  class="inputDisabled"  readOnly/>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="bor-div">
								<div class="top-row table-input">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit sear-tit-top">주소</div>
											<div class="table-mem">
												<div class="input-wid2">
													<input type="text" id="cus_address_1" name="cus_address_1" class="inputDisabled inp-30" placeholder="" readOnly>
													<input type="text" id="cus_address_2" name="cus_address_2" class="inputDisabled inp-70" placeholder="" >
												</div>
												<div>
													<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" placeholder="" readOnly>
												</div>
											</div>
										</div>
									</div>
									
								</div>
							</div>
							<div class="bor-div">
							
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit-top">관리자메모</div>
										<div>
											<div class="table-scr">
												<div class="table-wr cust-memowr">
													<div class="table-list table-list02 ">
														<table>
															<thead>
																<tr>
																	<th>내용<i class="material-icons">import_export</i></th>
																	<th>수정일시<i class="material-icons">import_export</i></th>
																	<th>수정자<i class="material-icons">import_export</i></th>
																	<th></th>
																</tr>
															</thead>
															<tbody class="cust_memo_area">
															<!-- 
																<tr class="memo cursor cust_memo_list_3" >
																	<td>이강을 희망한다고 하여 1/26 방문했음</td>
																	<td>2020-01-25</td>
																   	<td>이수정</td>
																   	<td></td>
																</tr>
																<tr class="memo cursor cust_memo_list_2" >
																	<td>이강을 희망한다고 하여 1/26 방문했음</td>
																	<td>2020-01-25</td>
																   	<td>이수정</td>
																   	<td></td>
																</tr>
																<tr class="memo cursor cust_memo_list_1" >
																	<td>이강을 희망한다고 하여 1/26 방문했음</td>
																	<td>2020-01-25</td>
																   	<td>이수정</td>
																   	<td></td>
																</tr>
															  -->
															</tbody>
														</table>													
													</div>
												</div>
											</div>
										</div>
									
									</div>
								</div>
							
							</div>
						</div> <!-- wid-5 end -->
						
						<div class="wid-5 wid-5_last">
							<div class="white-bg ak-wrap_new">
								<h3 class="h3-tit">거래선 등록</h3>
								<div class="bor-div first">
								
									<div class="top-row table-input">
										<div class="wid-10">
											<div class="table ">
												<div class="sear-tit">개인/법인</div> <!-- 1은 법인 2는 개인 -->
												<div>
													<ul class="chk-ul chk-ul-fg">
														<li>
															<input type="radio" id="corp_fg_2" class="lec-de" name="corp_fg" value="2" checked>
															<label for="corp_fg_2">개인</label>
														</li>
														<li>
															<input type="radio" id="corp_fg_1" class="lec-de02" name="corp_fg" value="1">
															<label for="corp_fg_1">법인</label>
														</li>
														
													</ul>
													<!-- <input type="text" data-name="개인/법인여부" class="notEmpty" id="corp_fg" name="corp_fg" class="inputDisabled inp-40" /> -->
												</div>
											</div>
										</div>
			<!-- 							<div class="wid-5"> -->
			<!-- 								<div class="table"> -->
			<!-- 									<div class="sear-tit sear-tit_120 sear-tit_left">법인</div> -->
			<!-- 									<div> -->
			<!-- 										<input type="text" data-name="개인/법인여부" class="notEmpty" id="corp_fg" name="corp_fg" class="inputDisabled inp-40" /> -->
			<!-- 									</div> -->
			<!-- 								</div> -->
			<!-- 							</div> -->
									</div>
									<!--  
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">개인/법인</div> <!-- 1은 법인 2는 개인 -->
											<!--  <div>
												<input type="radio" id="corp_fg" name="corp_fg" value="1">법인
												<input type="radio" id="corp_fg" name="corp_fg" value="2">개인
											</div>  -->
											
										<!--	<div>
												<input type="text" data-name="개인/법인여부" class="notEmpty" id="corp_fg" name="corp_fg" class="inputDisabled inp-40" />
												
											</div>
										</div>
									</div>-->
									
									<div class="top-row table-input table-corpfg table-myinf">								
										<div class="wid-10 corpfg01">
											<div class="table">
												<div class="sear-tit sear-tit-top">주민등록번호<em>*</em></div> 
											
												<div>
													<input type="text" data-name="주민번호" class="inp-100 inputDisabled" id="lecturer_cd" name="lecturer_cd" readOnly/>
													
												</div>
											</div>
										</div>
									</div>
									<div class="top-row table-input table-corpfg table-myinf">
										<div class="wid-10 corpfg02">
											<div class="table">
												<div class="sear-tit sear-tit-top">사업자 번호</div>
												<div>
													<input type="text" data-name="사업자 번호" class="inp-100 inputDisabled" id="biz_no" name="biz_no" readOnly/>
													<a class="btn btn03 inp-btn btn110 btn-mar" style="width:Auto;">조회</a>
													<a class="btn btn-done inp-auto btn-mar"><i class="material-icons">done</i>과세 사업자</a>
												</div>
											</div>
										</div>								
									</div>
									
									<div class="top-row table-input">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit">은행코드</div>
												<div>
													<input type="text" data-name="은행코드" class="notEmpty inputDisabled" id="bank_cd" name="bank_cd" readOnly/>
												</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">예금주</div>
												<div>
													<input type="text" data-name="예금주" class="notEmpty inputDisabled" id="account_nm" name="account_nm" readOnly/>
												</div>
											</div>
										</div>
									</div>
									
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit sear-tit-top">계좌번호</div>
												<div>
													<input type="text" data-name="계좌번호" class="notEmpty inp-100 inputDisabled" id="account_no" name="account_no" readOnly/>
													<a class="btn btn03 inp-btn btn110 btn-mar">조회</a>
													<a class="btn btn-done btn-mar"><i class="material-icons">done</i>계좌 확인 완료</a>
												</div>
											</div>
										</div>
									</div>
									
								</div>
								
								
								<div class="bor-div lec-none">
									<div class="top-row table-input">
										<div class="wid-5">
											<div class="table ">
												<div class="sear-tit">상호</div>
												<div>
													<input type="text" data-name="상호" class="notEmpty inputDisabled" id="biz_nm" name="biz_nm" readOnly/>
												</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">대표자명</div>
												<div>
													<input type="text" data-name="대표자명" class="notEmpty inputDisabled" id="president_nm" name="president_nm" readOnly/>
												</div>
											</div>
										</div>
									</div>
									
									<div class="top-row table-input">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit">업태</div>
												<div>
													<input type="text" data-name="업태" class="notEmpty inputDisabled" id="industry_c" name="industry_c" readOnly/>
												</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">업종</div>
												<div>
													<input type="text" data-name="업종" class="notEmpty inputDisabled" id="industry_s" name="industry_s" readOnly/>
												</div>
											</div>
										</div>
									</div>
									
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit sear-tit-top">사업장주소</div>
												
												<div class="table-mem">
													<div class="input-wid2">
														<input type="text" id="biz_post_no" name="biz_post_no" class="inputDisabled inp-50" placeholder="" readOnly>
													</div>
													<div>
														<input type="text" id="biz_addr_tx1" name="biz_addr_tx1" class="inputDisabled inp-100" placeholder="" readOnly>
														<input type="text" id="biz_addr_tx2" name="biz_addr_tx2" class="inp-100 inputDisabled" placeholder="" readOnly>
														<a class="btn btn03 inp-btn btn-mar">거래선 등록</a>
														<a class="btn btn-done btn-mar"><i class="material-icons">done</i>거래선 등록완료</a>
													</div>
													
												</div>
												
											
											</div>
										</div>
									</div>
									
								</div>			
							</div>	
						</div> <!-- wid-5_last end -->
					</div>
				</div>
				
				<div class="btn-wr text-center">
					<a class="btn btn01 ok-btn" onclick="pageReset()">초기화</a>
					
					<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();">저장</a>
				</div>
				
			</div> <!-- lecture-profile end -->
			<div class="lecture-leave">
				<div class="table-top table-top02">
					<div class="top-row sear-wr">
						<div class="wid-10">
							<div class="table">
								<div class="wid-45">
									<div class="table table-auto">
										<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
									</div>
								</div>
								<div class="wid-15">
									<div class="table">
										<div class="sear-tit sear-tit_oddn"><i class="material-icons">insert_link</i></div>
										<div class="oddn-sel02">
											<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				
					<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
				</div>
				<div class="table-cap table">
					<div class="cap-l">
						<p class="cap-numb"></p>
					</div>
					<div class="cap-r text-right">
						
						<div class="table table02 table-auto float-right">
							<div class="sel-scr">
								<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a>
								<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
									<option value="10">10개 보기</option>
									<option value="20">20개 보기</option>
									<option value="50">50개 보기</option>
									<option value="100">100개 보기</option>
									<option value="300">300개 보기</option>
									<option value="500">500개 보기</option>
									<option value="1000">1000개 보기</option>
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="table-wr ip-list">
					<div class="thead-box">
						<table>
							<colgroup>
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
								<col />
							</colgroup>
							<thead>
								<tr>
									<th>NO.</th>
									<th>출강점 </th>
									<th>연도/학기 </th>
									<th>대분류 </th>
									<th>중분류 </th>
									<th>강좌코드 </th>
									<th>강사료 지급 기준 </th>		
									<th>강좌명 </th>
									<th>수강료 </th>
									<th>현원</th>
									<th>요일 </th>
									<th>개강일 </th>	
								</tr>
							</thead>
						</table>
					</div>
					<div class="table-list">
						<table>
							<thead>
								<tr>
									<th>NO.</th>
									<th>출강점 </th>
									<th>연도/학기 </th>
									<th>대분류 </th>
									<th>중분류 </th>
									<th>강좌코드 </th>
									<th>강사료 지급 기준 </th>		
									<th>강좌명 </th>
									<th>수강료 </th>
									<th>현원</th>
									<th>요일 </th>
									<th>개강일 </th>			
								</tr>
							</thead>
							<tbody id="list_target">
							</tbody>
						</table>
						
					</div>
					<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
				</div>
			</div> <!-- lecture-leave end -->
			<div class="lecture-rating">
				<div class="lecr-newWrap">
					<div>					
						<div class="lecr-mem">	
							<div class="wid4">
								<p>신규 강사 채용 평가표</p>
							</div>
						</div>		
						
						<div class="lecr-table">
						<form id="pointForm" name="pointForm" method="POST" action="./modify_point">
							<input type="hidden" id="history_list" name="history_list">
							<input type="hidden" id="start_ymd_list" name="start_ymd_list">
							<input type="hidden" id="end_ymd_list" name="end_ymd_list">
							<input type="hidden" id="point_cus_no" name="point_cus_no" value="${lecr.LECTURE_CUS_NO}">
							<table>
												<colgroup>
													<col width="15%" />
													<col width="70%" />
													<col width="15%" />
												</colgroup>					
												<thead>
													<tr>
														<th>구분</th>
														<th>점수</th>
														<th>비고</th>
													</tr>
												</thead>					
												<tbody>
													<tr>
														<td>최종학력</td>
														<td>
															<ul class="chk-ul">
																<li>
																	<input type="radio" id="1_point_1" name="1_point" value="10" checked>
																	<label for="1_point_1">고졸 : 10</label>
																</li>
																<li>
																	<input type="radio" id="1_point_2" name="1_point" value="15">
																	<label for="1_point_2"> 초대졸(2~3년제) : 15</label>
																</li>
																<li>
																	<input type="radio" id="1_point_3" name="1_point" value="20">
																	<label for="1_point_3">대졸(4년제) : 20</label>
																</li>
																<li>
																	<input type="radio" id="1_point_4" name="1_point" value="25">
																	<label for="1_point_4">대학원졸(석,박사) : 25</label>
																</li>
															</ul>
														</td>
														<td></td>
													</tr>
													<tr>
														<td>관련전공</td>
														<td>
															<ul class="chk-ul">
																<li>
																	<input type="radio" id="2_point_1" name="2_point" value="4" checked>
																	<label for="2_point_1">Y : 4</label>
																</li>
																<li>
																	<input type="radio" id="2_point_2" name="2_point" value="0">
																	<label for="2_point_2"> N : 0</label>
																</li>
															</ul>
														</td>
														<td></td>
													</tr>
													<tr>
														<td>학력 상세</td>
														<td>
															<input type="text" id="school" name="school" class="inp-50" placeholder="학교명을 입력하세요." />
															<input type="text" id="school_cate" name="school_cate" class="inp-50 mrg-l6" placeholder="전공을 입력하세요." />								
														</td>
														<td></td>
													</tr>
													<tr>
														<td>분야 경력</td>
														<td>
															<ul class="chk-ul">
																<li>
																	<input type="radio" id="3_point_1" name="3_point" value="30" checked>
																	<label for="3_point_1">2년 미만 : 30</label>
																</li>
																<li>
																	<input type="radio" id="3_point_2" name="3_point" value="35">
																	<label for="3_point_2"> 2~5년 미만 : 35</label>
																</li>
																<li>
																	<input type="radio" id="3_point_3" name="3_point" value="40">
																	<label for="3_point_3">5~10년 미만 : 40</label>
																</li>
																<li>
																	<input type="radio" id="3_point_4" name="3_point" value="45">
																	<label for="3_point_4">10년 이상 : 45</label>
																</li>
															</ul>
														</td>
														<td></td>
													</tr>
													<tr>
														<td>기타 경력</td>
														<td>
															<ul class="chk-ul">
																<li>
																	<input type="checkbox" id="5_point_1" name="5_point_1">
																	<label for="5_point_1">언론매체 출연(인지도) : 4</label>
																</li>
																<li>
																	<input type="checkbox" id="5_point_2" name="5_point_2">
																	<label for="5_point_2"> 관련 저서 : 4</label>
																</li>
																<li>
																	<input type="checkbox" id="5_point_3" name="5_point_3">
																	<label for="5_point_3"> 입상 및 자격증 : 4</label>
																</li>
																<li>
																	<input type="checkbox" id="5_point_4" name="5_point_4">
																	<label for="5_point_4">기타 : 4</label>
																</li>
															</ul>
														</td>
														<td></td>
													</tr>
													<tr>
														<td>주요 약력</td>
														<td id="target_history">
															<div class="lecr-cal">
																<div class="cal-row cal-row_inline cal-row02">
																	<div class="cal-input cal-input140 wid-4">
																		<input type="text" class="date-i" id="start_ymd1" name="start_ymd">
																		<i class="material-icons">event_available</i>
																	</div>
																	<div class="cal-dash">-</div>
																	<div class="cal-input cal-input140 wid-4">
																		<input type="text" class="date-i" id="end_ymd1" name="end_ymd">
																		<i class="material-icons">event_available</i>
																	</div>
																</div>
																<div>
																	<input type="text" class="inp-50" id="history1" name="history" placeholder="내용을 입력해주세요." />
																	<i class="material-icons add" onclick="add_history()">add_circle_outline</i>
																</div>
															</div>
														</td>
														<td></td>
													</tr>
													<tr>
														<td>태도/용모</td>
														<td>
															<ul class="chk-ul">
																<li>
																	<input type="radio" id="4_point_1" name="4_point" value="8" checked>
																	<label for="4_point_1">보통 : 8</label>
																</li>
																<li>
																	<input type="radio" id="4_point_2" name="4_point" value="10">
																	<label for="4_point_2"> 우수 : 10</label>
																</li>
															</ul>
														</td>
														<td></td>
													</tr>
													<tr>
														<td>기타</td>
														<td colspan="2">
															<textarea id="other" name="other" placeholder="내용을 입력해주세요."></textarea>
														</td>
														
													</tr>
												</tbody>
												
											
											</table>
										
							<div class="lecr-last_wrap">
								<div class="lecr-sign">
									<div>
										평가자
										<span id="point_writer"></span>
									</div>
									<div>
										평가일
										<span id="point_date"></span>
									</div>
								</div>
								<div class="lecr-total">
									총점/등급
									<div id="t_point_div">00 / C</div>
									<input type="hidden" id="t_point" name="t_point"> 
								</div>
							</div>
							</form>
						</div>
						<div class="btn-wr text-center">
							<a class="btn btn01 ok-btn" onclick="pageReset()">초기화</a>
							
							<a class="btn btn02 ok-btn" onclick="javascript:pointSubmit();">저장</a>
						</div>
					
					
					</div>
				</div> <!-- lecr-newWrap end -->
			</div> <!-- lecture-rating end -->
		</div>
	</div> <!-- tab-wrap end -->
</div>

<div id="review_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#review_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">관리자 메모</h3>
        			<form id="fncForm" name="fncForm" method="POST" action="./saveReview">
	        			<input type="hidden" id="reg_no" name="reg_no">
	        			<textarea style="height:333px;" id="review" name="review"></textarea>
        			</form>
        			<div class=" text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:saveReview();" style="margin-top:30px;">저장</a>
					</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>

<div id="sms_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg sms-edit">
        		<div class="close" onclick="$('#sms_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="smspop-wrap">
					<div class="sms-pop sms-pop-sms">
						<div class="sms-con02">
							<p id="sms_kor_nm">akadmin(이호걸)</p>
							<div class="sms-con01 text-center" id="sms_phone_no">010-2334-6740</div>
							<textarea id="sms_contents" name="sms_contents" placeholder="내용을 입력해주세요."></textarea>
						</div>
					</div>
				</div>
				<div class=" text-center" style="margin-top: 30px;">
					<a class="btn btn02 ok-btn" onclick="javascript:sendSms()">전송</a>
				</div>
        	</div>
        </div>
    </div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>