<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
$(document).ready(function(){

});
function lecrNew() //강사평가
{
	if($("#kor_nm").val() == "")
	{
		alert("먼저 휴대폰번호를 검색하세요.");
		$("#searchPhone").focus();
	}
	else
	{
		$('#lecr_layer').fadeIn(200);
		comPoint();
	}
}

function getUserList() //강사 정보 조회
{
	if($("#searchPhone").val() == "")
	{
		alert("휴대폰번호를 입력해주세요.");
		$("#searchPhone").focus();
		return;
	}
	else
	{
		if(!isLoading)
		{
			getListStart();
			$.ajax({				
				type : "POST", 
				url : "./getAmsList",
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
					var result = JSON.parse(data);
					var inner = "";
					if(result.length > 1)
					{
						for(var i = 0; i < result.length; i++)
						{
							inner += '<tr onclick="selUser(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
								inner += '	<td>'+result[i].CUS_PN+" | "+result[i].MTEL_IDENT_NO+"-"+result[i].MMT_EX_NO+"-"+result[i].MTEL_UNIQ_NO+'</td>';
							inner += '</tr>';
						}
						$("#tb_target").html(inner);
						$("#search_layer").fadeIn(200);
					}
					else if(result.length == 1)
					{
						selUser(encodeURI(JSON.stringify(result[0])));
					}
					else
					{
						alert("검색결과가 없습니다.");
					}
					getListEnd();
				}
			});
		}
	}
}
function getLecrList() //강사 정보 조회
{
	if($("#searchLecr").val() == "")
	{
		alert("강사관리번호를 입력해주세요.");
		$("#searchLecr").focus();
		return;
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "./getLecrList",
			dataType : "text",
			data : 
			{
				searchLecr : $("#searchLecr").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				var inner = "";
				if(result.length > 1)
				{
					for(var i = 0; i < result.length; i++)
					{
						inner += '<tr onclick="selLecr(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
						
						var corp_fg_nm = "";
						var isLine = "";
						if(result[i].STATUS_FG == "Y")
						{
							isLine = "(상신)";
						}
						else
						{
							isLine = "(미상신)";
						}
						if(result[i].CORP_FG == "1")
						{
							corp_fg_nm = "법인";
							inner += '	<td>'+isLine+' | '+result[i].LECTURER_CD.substring(0,6)+"-"+result[i].LECTURER_CD.substring(6,13)+" | "+result[i].LECTURER_KOR_NM+" | "+corp_fg_nm+" | "+nullChk(result[i].BIZ_NM)+'</td>';
						}
						else if(result[i].CORP_FG == "2")
						{
							corp_fg_nm = "개인";
							inner += '	<td>'+isLine+' | '+result[i].LECTURER_CD.substring(0,6)+"-"+result[i].LECTURER_CD.substring(6,13)+" | "+result[i].LECTURER_KOR_NM+" | "+corp_fg_nm+'</td>';
						}
						inner += '</tr>';
						
						
					}
					$("#tb_target_lecr").html(inner);
					$("#search_layer_lecr").fadeIn(200);
				}
				else if(result.length == 1)
				{
					selLecr(encodeURI(JSON.stringify(result[0])));
				}
				else
				{
					alert("검색결과가 없습니다.");
				}
			}
		});
	}
}
function selUser(ret)
{
	$('#search_layer').fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
 	$("#kor_nm").val(result.CUS_PN);
 	$("#phone_no").val(result.MTEL_IDENT_NO+"-"+result.MMT_EX_NO+"-"+result.MTEL_UNIQ_NO);
 	$("#birth_ymd").val(cutDate(result.BMD));
 	$("#email_addr").val(result.EMAIL_ADDR);
 	$("#cus_no").val(result.CUS_NO); //폼이 2개여가지고 2개만든다.
 	$("#ptl_id").val(result.PTL_ID);
 	$("#card_no").val(result.CARD_NO);
 	$("#create_date").val(result.RG_DTM);
 	$("#cus_address_1").val(result.PSNO);
 	$("#cus_address_2").val(result.PNADD);
 	$("#cus_address_3").val(result.DTS_ADDR);
 	
 	if(result.CNT != "0")
	{
 		$.ajax({
			type : "POST", 
			url : "./getLectureDetail",
			dataType : "text",
			async : false,
			data : 
			{
				cus_no : result.CUS_NO
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result2 = JSON.parse(data);
				$("#lecturer_cd").addClass("inputDisabled");
		 		$("#lecturer_cd").attr("readOnly", true);	
		 		$("#lecturer_cd").val(result2.LECTURER_CD);
		 		$("#lecturer_cd_connect").val(result2.LECTURER_CD_CONNECT);
		 		$("#status_fg_connect").val(result2.STATUS_FG);
		 		$("#lecturer_cd_ori").val(result2.LECTURER_CD_CONNECT);
		 		$("#isIn").val('기존강사');
		 		$("#car_no").val(result2.CAR_NO);
		 		$('.lect-co').html('평가 완료');
		 		
		 		//강좌평가 셋팅
		 		$("#school").val(result2.SCHOOL);
				$("#school_cate").val(result2.SCHOOL_CATE);
				
				var grade = "F";
				var point = Number(result2.POINT);
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
				$("input:radio[name='1_point']:radio[value="+result2.POINT_1+"]").prop('checked', true); 
				$("input:radio[name='2_point']:radio[value="+result2.POINT_2+"]").prop('checked', true); 
				$("input:radio[name='3_point']:radio[value="+result2.POINT_3+"]").prop('checked', true); 
				$("input:radio[name='4_point']:radio[value="+result2.POINT_4+"]").prop('checked', true);
				
				if(nullChk(result2.POINT_5) != "")
				{
					var point_5_arr = result2.POINT_5.split("|");
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
				}
				if(nullChk(result2.START_YMD) != "" && nullChk(result2.END_YMD) != "" && nullChk(result2.HISTORY) != "")
				{
					var start_ymd_arr = result2.START_YMD.split("|");
					var end_ymd_arr = result2.END_YMD.split("|");
					var history_arr = result2.HISTORY.split("|");
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
				}
				
				if(nullChk(result2.OTHER) != "")
				{
					$("#other").val(repWord(result2.OTHER));
				}
		 		//강좌평가 셋팅
				settingLecr();
		 		
			}
		});
	}
 	else
	{
 		$("#lecturer_cd").removeClass("inputDisabled");
 		$("#lecturer_cd").attr("readOnly", false);	
 		$("#lecturer_cd").val('');
 		$("#isIn").val('신규강사');
 		$("#car_no").val('');
 		$('.lect-co').html('')
	}

	//여기부턴 강사평가
	var age = ck_age(result.BMD);
	$("#lecr_title").html(result.CUS_PN+"("+result.PTL_ID+") "+age+"/"+result.NTR_DC);
	//여기부턴 강사평가
			
}
function selLecr(ret)
{
	$('#search_layer_lecr').fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
	$("#lecturer_cd_connect").val(result.LECTURER_CD);
	$("#status_fg_connect").val(result.STATUS_FG);
	
	settingLecr();
}
function settingLecr()
{
	if($("#lecturer_cd_connect").val() != '')
	{
		$.ajax({
			type : "POST", 
			url : "./getLecrList",
			dataType : "text",
			data : 
			{
				searchLecr : $("#lecturer_cd_connect").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				var inner = "";
				if(result.length > 1)
				{
					alert("중복된 거래선이 조회되었습니다.");
				}
				else if(result.length == 1)
				{
					$("#lecturer_cd_lecr").val($("#lecturer_cd_connect").val())
					$("input:radio[name='corp_fg']:radio[value='"+result[0].CORP_FG+"']").prop('checked', true);
					if(result[0].CORP_FG == "1")
					{
						$(".corpfg02").css("display","inline-block");
						$(".lec-none").show();		
					}
					else
					{
						$(".corpfg02").hide();
						$(".lec-none").hide();	
					}
					
					$("#biz_no").val(result[0].BIZ_NO);
					$("#bank_cd").val(result[0].BANK_CD);
					$(".bank_cd").html(result[0].BANK_NM);
					$("#account_nm").val(result[0].ACCOUNT_NM);
					$("#account_no").val(trim(result[0].ACCOUNT_NO));
					$("#biz_nm").val(result[0].BIZ_NM);
					$("#president_nm").val(result[0].PRESIDENT_NM);
					$("#industry_c").val(result[0].INDUSTRY_C);
					$("#industry_s").val(result[0].INDUSTRY_S);
					$("#biz_post_no").val(result[0].BIZ_POST_NO);
					$("#biz_addr_tx1").val(result[0].BIZ_ADDR_TX1);
					$("#biz_addr_tx2").val(result[0].BIZ_ADDR_TX2);
				}
				else
				{
					alert("거래선 데이터가 없습니다.");
				}
			}
		});
		
	}
}
function fncSubmit(idx)
{
	var validationFlag = "Y";
// 	$("#fncForm"+idx+" .notEmpty").each(function() 
// 	{
// 		if ($(this).val() == "") 
// 		{
// 			alert(this.dataset.name+"을(를) 입력해주세요.");
// 			$(this).focus();
// 			validationFlag = "N";
// 			return false;
// 		}
// 	});
	
// 	if(idx == 1 && $("#lecturer_cd").val() == '')
// 	{
// 		alert("주민번호를 입력해주세요.");
// 		validationFlag = "N";
// 		return false;
// 	}
	if(idx == 1 && $(".lect-co").html() == '')
	{
		alert("강사평가가 완료되지않았습니다.");
		validationFlag = "N";
		return;
	}
	if(idx == 1 && $("#status_fg_connect").val() != "Y" && $("#lecturer_cd_connect").val() != "")
	{
		alert("상신되지않은 거래선은 연결할 수 없습니다.");
		validationFlag = "N";
		return;
	}
	if(idx == 2 && $("#lecturer_cd_lecr").val() == "")
	{
		alert("주민번호를 입력해주세요.");
		validationFlag = "N";
		return;
	}
	if(validationFlag == "Y")
	{
		if(idx == 1) //채용
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
		}
		$("#fncForm"+idx).ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
// 	    			location.reload();
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}
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
var point = 0;
var chk_point = 0;
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
/* //uid생성
function generateUID() {
    // I generate the UID from two parts here 
    // to ensure the random number provide enough bits.
    var firstPart = (Math.random() * 46656) | 0;
    var secondPart = (Math.random() * 46656) | 0;
    firstPart = ("000" + firstPart.toString(36)).slice(-3);
    secondPart = ("000" + secondPart.toString(36)).slice(-3);
    return firstPart + secondPart;
}
//계좌실명조회
function coocon_api(bank_cd, search_acct_no, acnm_no){
   	const SECR_KEY = "26ITwrC3lVJCeh3XeBYr";
	const KEY = "ACCTNM_RCMS_WAPI";
    var REQ_DATA = new Object();
        REQ_DATA.BANK_CD = bank_cd;		//은행코드
        REQ_DATA.SEARCH_ACCT_NO = search_acct_no;	//계좌번호
        REQ_DATA.ACNM_NO = acnm_no;		//증명번호 ex)사업자번호 10자리 or 생년월일 6자리
        REQ_DATA.TRSC_SEQ_NO = "8"+generateUID();

    var JSONData = new Object();
    JSONData.SECR_KEY = SECR_KEY;
    JSONData.KEY = KEY;
    JSONData.REQ_DATA = [];
    JSONData.REQ_DATA.push(REQ_DATA);
    
    $.ajax({
        type: "POST",
        url: "/lecture/lecr/coocon_api",
        async: false,
        data:{
            JSONData: JSON.stringify(JSONData)
        },
        success: function(data){
        	var result = JSON.parse(data.res);
        	if(result.RSLT_CD != "000"){	//000을 제외하면 오류
        		alert(result.RSLT_MSG+"\n"+result.RSLT_CD);
        	}else{
        		var acct_nm = result.RESP_DATA.ACCT_NM; //예금주명(최대 20byte)
        	}
        }
    })
} */
function call_nice_api()
{
	var biz_no = $("#biz_no").val();
	biz_no = biz_no.replace(/-/gi, "");
	if(biz_no == "" || biz_no.length != 10)
	{
		alert("사업자번호를 확인해주세요.");
		$("#biz_no").focus();
		return;
	}
	$.ajax({				
		type : "POST", 
		url : "/common/sendComplus",
		dataType : "text",
		data : 
		{
			biz_no : biz_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			if(result.RESULT_CODE == "0")
			{
				//{"RESULT_CODE":0,"RETURN_CODE":"01","STATUS_CODE":"1","RETURN_COMPNAME":"에이케이에스앤디 (주) AK분당점","RETURN_REPNAME":"김진태"}
				$("#president_nm").val(result.RETURN_REPNAME);
				$("#biz_nm").val(result.RETURN_COMPNAME);
				var nice_suc = "";
				if(result.STATUS_CODE == 0) {nice_suc = "정보없음";}
				else if(result.STATUS_CODE == 1) {nice_suc = "정상";}
				else if(result.STATUS_CODE == 6) {nice_suc = "부도";}
				else if(result.STATUS_CODE == 7) {nice_suc = "휴업";}
				else if(result.STATUS_CODE == 8) {nice_suc = "폐업";}
				else if(result.STATUS_CODE == 9) {nice_suc = "기타";}
				$("#nice_suc").show();
				$("#nice_suc").html('<i class="material-icons">done</i>'+nice_suc);
			}
			else
			{
				alert("조회 실패");
			}
		}
	});
	
}
function call_coocon_api()
{
	var bank_cd = $("#bank_cd").val();
	bank_cd = bank_cd.substring(1, bank_cd.length);
	var account_no = $("#account_no").val();
	account_no = account_no.replace(/-/gi, ""); 
	if(account_no == "")
	{
		alert("계좌번호를 확인해주세요.");
		$("#account_no").focus();
		return;
	}
	$.ajax({				
		type : "POST", 
		url : "/common/sendCooconApi",
		dataType : "text",
		data : 
		{
			bank_cd : bank_cd,
			search_acct_no : account_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			if(result.RSLT_CD == "000")
			{
				var acc_nm = result.RESP_DATA[0].ACCT_NM;
				$("#account_nm").val(acc_nm);
				$("#acc_suc").show();
			}
			else
			{
				$("#acc_suc").hide();
				alert("조회 실패");
				alert(result.RSLT_MSG);
			}
		}
	});
}
</script>
<div class="sub-tit">
	<h2>강사 등록</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<div>
			<!-- <A class="btn btn02" href="#">정보수정</A>  -->
<!-- 			<A class="btn btn01 btn01_1" onclick="javascript:lecrNew()"><i class="material-icons">add</i>강사 평가</A> -->
		</div>		
	</div>
</div>
<div class="row view-page peri-list">
	<div class="wid-5">
		<form id="fncForm1" name="fncForm1" method="POST" action="./write_proc1">
			<div class="white-bg ak-wrap_new">
				<h3 class="h3-tit">기본정보</h3>
				
				<div class="bor-div first">
					<div class="top-row">
						<div class="wid-10">
							<div class="table lecr-searwr">
								<div class="lecr-sear lecr-sear-snm" style="width:49%;">
									<div class="table table02 table-searnum">
										<div class="wid-10">
											<input type="text" data-name="휴대폰 뒷자리" id="searchPhone" name="searchPhone" class="inp-100" placeholder="(멤버스 회원) 휴대폰 번호를 입력하세요." onkeypress="excuteEnter(getUserList)">
										</div>
						        	</div>
									<div>
										<a class="btn btn02" onclick="javascript:getUserList()">검색</a>
									</div>
								</div>
								<div class="lecr-sear lecr-sear-snm" style="width:49%; margin-left:10px;">
									<div class="table table02 table-searnum">
										<div class="wid-10">
											<input type="text" data-name="사업자번호 혹은 주민번호를 입력하세요." id="searchLecr" name="searchLecr" class="inp-100" placeholder="(거래선) 강사 관리번호를 입력해주세요." onkeypress="excuteEnter(getLecrList)">
										</div>
						        	</div>
									<div>
										<a class="btn btn02" onclick="javascript:getLecrList()">검색</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				
					<div class="top-row table-input">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit">등록여부</div>
								<div>
									<input type="text" class="inputDisabled" id="isIn" name="isIn" readOnly/>
								</div>
							</div>
						</div>
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_120 sear-tit_left">연결된 거래선 강사번호</div>
								<div>
									<input type="text" class="inputDisabled" id="lecturer_cd_connect" name="lecturer_cd_connect" readOnly/>
									<input type="hidden" id="lecturer_cd_ori" name="lecturer_cd_ori" />
									<input type="hidden" id="status_fg_connect" name="status_fg_connect" readOnly/>
								</div>
							</div>
						</div>
					</div>
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
				<!-- 
				<div class="bor-div">
					<div class="top-row table-input">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">회원형태<em>*</em></div>
								<div>
									<ul class="chk-ul">
										<li>
											<input type="radio" id="rad-c" class="chkDisabled" checked name="rad-1" />
											<label for="rad-c">개인</label>
										</li>
										<li>
											<input type="radio" id="rad-c" class="chkDisabled"  name="rad-1" />
											<label for="rad-c">법인</label>
										</li>
									</ul>
								</div>
							</div>
						</div>
						
					</div>
					
				</div> --> 
				
				
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
									<input type="text" class="" id="car_no" name="car_no" onkeypress="fnChkByte(this, 8);"/>
								</div>
							</div>
						</div>
<!-- 						<div class="wid-5"> -->
<!-- 							<div class="table"> -->
<!-- 								<div class="sear-tit sear-tit_120 sear-tit_left">주민번호</div> -->
<!-- 								<div> -->
<!-- 									<input type="text" class="notEmpty" id="lecturer_cd" name="lecturer_cd" data-name="주민번호"/> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
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
					<div class="top-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">강사평가<em>*</em></div>
								<div class="table-mem">
									<div class="input-wid2">
										<a class="btn btn01 btn140" onclick="javascript:lecrNew();">강사평가</a>
										<span class="lect-co"></span>
									</div>
								</div>
							</div>
						</div>						
					</div>
				</div>
				
				
				
			</div>
			<div class="btn-wr text-center">
				<a class="btn btn01 ok-btn" onclick="pageReset()">초기화</a>
				<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit(1);">저장</a>
			</div>
			
			
			
			<input type="hidden" id="history_list" name="history_list">
			<input type="hidden" id="start_ymd_list" name="start_ymd_list">
			<input type="hidden" id="end_ymd_list" name="end_ymd_list">
			<div id="lecr_layer" class="list-edit-wrap">
				<div class="le-cell">
					<div class="le-inner">
			        	<div class="list-edit02 white-bg white-bg03">
							<div>
								<div class="lecr-newWrap">
									<h3 class="text-center">신규 강사 채용 평가표</h3>
									<div>
										<div class="lecr-mem">	
											<div class="wid5">
												<p id="lecr_title">이호걸(hong 1004) <span>42/M</span></p>
											</div>
										</div>		
										
										<div class="lecr-table">
										
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
											
											<div class="lecr-total">
												총점/등급
												<div id="t_point_div">00 / C</div>
												<input type="hidden" id="t_point" name="t_point"> 
											</div>
										
										</div>
									
									
									</div>
								</div>
								<div class="text-center">
									<a class="btn btn01 ok-btn"onclick="javascript:$('#lecr_layer').fadeOut(200);">취소</a>
									<a class="btn btn02 ok-btn" onclick="javascript:$('#lecr_layer').fadeOut(200); $('.lect-co').html('평가 완료')">확인</a>
								</div>
								
							</div>
			        	</div>
			        </div>
			    </div>	
			</div>
		</form>
		</div>
		<div class="wid-5">
			<form id="fncForm2" name="fncForm2" method="POST" action="./write_proc2">
				<div class="white-bg ak-wrap_new">
					<h3 class="h3-tit">거래선 등록</h3>
					<div class="bor-div first">
					
						<div class="top-row table-input">
							<div class="wid-5">
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
							<div class="wid-5 corpfg01">
								<div class="table">
									<div class="sear-tit sear-tit-top">주민등록번호<em>*</em></div> 
								
									<div>
										<input type="text" data-name="주민번호" class="inp-100" id="lecturer_cd_lecr" name="lecturer_cd_lecr"/>
										
									</div>
								</div>
							</div>
							<div class="wid-5 corpfg02">
								<div class="table">
									<div class="sear-tit sear-tit-top sear-tit_120 sear-tit_left">사업자 번호</div>
									<div>
										<input type="text" data-name="사업자 번호" class="inp-70" id="biz_no" name="biz_no" />
										<a class="btn btn03 inp-btn " onclick="call_nice_api()" style="width:Auto;">조회</a>
										<a class="btn btn-done inp-auto btn-mar" id="nice_suc" style="display:none;"><i class="material-icons">done</i>과세 사업자</a>
									</div>
								</div>
							</div>								
						</div>
						
						<div class="top-row table-input">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">은행코드</div>
									<div>
										<select de-data="${bank_list[0].BANK_NM}" id="bank_cd" name="bank_cd">
											<c:forEach var="i" items="${bank_list}" varStatus="loop">
												<option value="${i.BANK_CD}">(${i.BANK_CD})${i.BANK_NM}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">예금주</div>
									<div>
										<input type="text" data-name="예금주" class="notEmpty" id="account_nm" name="account_nm"/>
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit sear-tit-top">계좌번호</div>
									<div>
										<input type="text" data-name="계좌번호" class="notEmpty inp-70" id="account_no" name="account_no" />
										<a class="btn btn03 inp-btn btn110" onclick="call_coocon_api()">조회</a>
										<a class="btn btn-done btn-mar" id="acc_suc" style="display:none;"><i class="material-icons">done</i>계좌 확인 완료</a>
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
										<input type="text" data-name="상호" class="notEmpty" id="biz_nm" name="biz_nm"/>
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">대표자명</div>
									<div>
										<input type="text" data-name="대표자명" class="notEmpty" id="president_nm" name="president_nm"/>
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row table-input">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">업태</div>
									<div>
										<input type="text" data-name="업태" class="notEmpty" id="industry_c" name="industry_c"/>
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">업종</div>
									<div>
										<input type="text" data-name="업종" class="notEmpty" id="industry_s" name="industry_s"/>
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
											<input type="text" id="biz_post_no" name="biz_post_no" class="inputDisabled inp-50" placeholder="" onclick="show_address('biz_post_no', 'biz_addr_tx1');">
										</div>
										<div>
											<input type="text" id="biz_addr_tx1" name="biz_addr_tx1" class="inputDisabled inp-100" placeholder="" >
											<input type="text" id="biz_addr_tx2" name="biz_addr_tx2" class="inp-100" placeholder="" >
											<a class="btn btn03 inp-btn btn-mar">거래선 등록</a>
											<a class="btn btn-done btn-mar"><i class="material-icons">done</i>거래선 등록완료</a>
										</div>
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="btn-wr text-center">
					<a class="btn btn01 ok-btn" onclick="pageReset()">초기화</a>
					<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit(2);">저장</a>
				</div>
			</form>
		</div>
	</div>


<div id="search_layer" class="list-edit-wrap popwid-500">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#search_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">휴대폰번호 조회</h3>
        			<div class="lecr-scroll">
	       				<table class="table-cursor">
							<tbody id="tb_target">									
							</tbody>
						</table>
        			</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>
<div id="search_layer_lecr" class="list-edit-wrap popwid-500">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg edit-scroll">
        		<div class="close" onclick="javascript:$('#search_layer_lecr').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">거래선 조회</h3>
       				<table class="table-cursor">
						<tbody id="tb_target_lecr">									
						</tbody>
					</table>
	        	</div>
        	</div>
        </div>
    </div>	
</div>





<jsp:include page="/WEB-INF/pages/common/footer.jsp"/> 