<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>

function foodStar()
{
	if($("input:checkbox[name=food_star]").is(":checked"))
	{
		$("#food_amt").val('0');
		$("#food_amt").addClass("inputDisabled");
		$("#food_amt").attr("readonly", true);
	}
	else
	{
		$("#food_amt").removeClass("inputDisabled");
		$("#food_amt").attr("readonly", false);
	}
}
function excelDown()
{
	var filename = "출석부";
	var table = "excelTable";
	
	var inner ="";
	
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강좌 : '+excel_subject_nm+'('+excel_subject_cd+')</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강사 : '+excel_web_lecturer_nm+'</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강의 기간 : '+excel_start_ymd+' ~ '+excel_end_ymd+'</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강의 시간 :'+cutLectHour(excel_lect_hour)+'</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='</tr>';
	
	$('#list_head_target').prepend(inner);
    exportExcel(filename, table);
    $('.addTarget').remove();
}


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
		});
	});
});
var lecr="";
var day_value ='';
function searchLecr(idx)
{
	lecr = idx;
	$('#give_layer').fadeIn(200);	
	$(".lecr_check").prop("checked",false);
}


$(document).ready(function() {
	if(Number('${plan_list_size}') > 0)
	{
// 		if(nullChk('${list[0].IMAGE_PIC}') != "")
// 		{
// 			$(".upload-name").val('${list[0].IMAGE_PIC}');
// 		}
		$(".upload-name").val('${plan_data.THUMBNAIL_IMG}');
		$(".upload-name").attr('onclick', 'javascript:window.open("/upload/wlect/${plan_data.THUMBNAIL_IMG}");');
		$(".upload-name02").val('${plan_data.DETAIL_IMG }');
		$(".upload-name02").attr('onclick', 'javascript:window.open("/upload/wlect/${plan_data.DETAIL_IMG}");');
		var etc_arr = '${plan_list[0].ETC}'.split("|");
		
		for(var i = 0; i < etc_arr.length-1; i++)
		{
			if(etc_arr[i].indexOf("회차 : ") > -1)
			{
				var lect_cnt = etc_arr[i].split('회차 : ')[0];
				var lect_contents = etc_arr[i].split('회차 : ')[1];
				add_contents_init(lect_cnt);
				$("#lect_cnt"+lect_cnt).val(lect_cnt);
				$("#lect_contents"+lect_cnt).val(repWord(lect_contents));
			}
		}
	}
	if($("#lecturer_nm").val() == "")
	{
		$("#lecturer_nm").val('${plan_data.WEB_LECTURER_NM}');
	}
	document.getElementById("lecturer_career").value = repWord(document.getElementById("lecturer_career").value);
	document.getElementById("lecture_content").value = repWord(document.getElementById("lecture_content").value);
});
var lect_cnt = Number('${data.LECT_CNT}')
function add_contents()
{
	if($("#isChange").hasClass("btn03"))
	{
		var empty_cnt = 0;
		for(var i = 1; i <= lect_cnt; i++)
		{
			if(!document.getElementById("contents_tr_"+i))
			{
				empty_cnt = i;
				break;
			}
		}
		if(document.getElementsByName("lect_cnt").length < Number('${data.LECT_CNT}'))
		{
			var inner = "";
			inner += '<tr class="add-row" id="contents_tr_'+empty_cnt+'">';
			inner += '	<td><input type="number" id="lect_cnt'+empty_cnt+'" name="lect_cnt" value="'+empty_cnt+'" style="width: 60px;" class="notEmpty" data-name="회차">회차</td>';
			inner += '	<td><input type="text" id="lect_contents'+empty_cnt+'" name="lect_contents" placeholder="내용을 작성해주세요." class="" data-name="내용"></td>';
			inner += '	<td class="tog-tit"><div></div></td>';
			inner += '</tr>';
			$("#target_contents").append(inner);
		}
		else
		{
			alert("강좌횟수를 초과하였습니다.");
		}
	}
}
function add_contents_init(val)
{
	var inner = "";
	inner += '<tr id="contents_tr_'+val+'">';
	inner += '	<td><input type="number" id="lect_cnt'+val+'" name="lect_cnt" value="0" style="width: 60px;" class="notEmpty inputDisabled" data-name="회차" readOnly>회차</td>';
	inner += '	<td><input type="text" id="lect_contents'+val+'" name="lect_contents" placeholder="내용을 작성해주세요." style="width: 100%;" class=" inputDisabled" data-name="내용" readOnly></td>';
	inner += '	<td class="tog-tit"><div></div></td>';
	inner += '</tr>';
	$("#target_contents").append(inner);
}
function remove_contents(idx)
{
	if($("#isChange").hasClass("btn03"))
	{
		$("#contents_tr_"+idx).remove();
	}
}

$(document).ready(function(){
		
	$('.withBaby').hide();
	$("#lect_cnt").val('${data.LECT_CNT}');
	$(".lect_cnt").html('${data.LECT_CNT}');
	lect_cnt_change();
	
	$("#subject_nm").val('${data.SUBJECT_NM}');
	
	$("#start_ymd").val(cutDate('${data.START_YMD}'));
	$("#end_ymd").val(cutDate('${data.END_YMD}'));
	
	$("#main_cd").val('${data.MAIN_CD}');
	$(".main_cd").html('${data.MAIN_NM}');
	selMaincd('${data.MAIN_CD}', '2');
	sect_cd = '${data.SECT_CD}';
	sect_text = '${data.SECT_NM}';
	sect_choose('${data.SECT_CD}', '2');
	
	$("#lect_cd").val('${data.SUBJECT_CD}');
	
	if('${data.IS_TWO}' == "Y")
	{
		$("#is_two").prop("checked",true);
		$("#month_no").val('${data.MONTH_NO}');
// 		$(".month_no").html('${data.MONTH_NO}');
		$("#month_no1").val('${data.MONTH_NO1}');
// 		$(".month_no1").html('${data.MONTH_NO1}');
	}
	
	$("#web_lecture_nm1").val('${data.WEB_LECTURER_NM}');
	$("#web_lecture_nm2").val('${data.WEB_LECTURER_NM1}');
	$("#lecturer_cd").val('${data.LECTURER_CD}');
	$("#cus_no").val('${data.CUS_NO}');
	$("#lecturer_cd1").val('${data.LECTURER_CD1}');
	$("#cus_no1").val('${data.CUS_NO1}');
	
	$("#capacity_no").val('${data.CAPACITY_NO}');
	
	var day_arr = '${data.DAY_FLAG}'.split('');
	if(day_arr[0] == "1")
	{
		$("#yoil_mon").prop("checked",true);
	}
	if(day_arr[1] == "1")
	{
		$("#yoil_tue").prop("checked",true);
	}
	if(day_arr[2] == "1")
	{
		$("#yoil_wed").prop("checked",true);
	}
	if(day_arr[3] == "1")
	{
		$("#yoil_thu").prop("checked",true);
	}
	if(day_arr[4] == "1")
	{
		$("#yoil_fri").prop("checked",true);
	}
	if(day_arr[5] == "1")
	{
		$("#yoil_sat").prop("checked",true);
	}
	if(day_arr[6] == "1")
	{
		$("#yoil_sun").prop("checked",true);
	}
	
	if('${data.CORP_FG}' == "Y")
	{
		$("#corp_fg_1").prop('checked', true);
	}
	else
	{
		$("#corp_fg_2").prop('checked', true);
	}
	
	$("#lect_hour1").val('${data.LECT_HOUR}'.substring(0,2));
	$("#lect_hour2").val('${data.LECT_HOUR}'.substring(2,4));
	$("#lect_hour3").val('${data.LECT_HOUR}'.substring(4,6));
	$("#lect_hour4").val('${data.LECT_HOUR}'.substring(6,8));
	$(".lect_hour1").html('${data.LECT_HOUR}'.substring(0,2));
	$(".lect_hour2").html('${data.LECT_HOUR}'.substring(2,4));
	$(".lect_hour3").html('${data.LECT_HOUR}'.substring(4,6));
	$(".lect_hour4").html('${data.LECT_HOUR}'.substring(6,8));
	
	
	var can_arr = '${data.CANCLED_LIST}'.split('|');
	for(var i = 0; i < can_arr.length-1; i++)
	{
		if(i != 0)
		{
			add_rest_day();
		}
		$("#closed"+(i+1)).val(can_arr[i]);
	}
	
	if('${data.FIX_PAY_YN}' == "Y")
	{
		$("#fix_pay_yn2").prop('checked', true);
		$("#fix_amt").val(comma('${data.FIX_AMT}'));
	}
	else
	{
		$("#fix_pay_yn1").prop('checked', true);
		$("#fix_rate").val('${data.FIX_RATE}');
	}
	$("#web_cancle_ymd").val(cutDate('${data.WEB_CANCEL_YMD}'));
	$("#regis_fee").val(comma('${data.REGIS_FEE}'));
	$("#food_amt").val(comma('${data.FOOD_AMT}'));
	$("#lect_period").val('${data.PERIOD}');
// 	$("#lect_end_yn").val('${data.END_YN}');
	if('${data.FOOD_YN}' == "R")
	{
		$("#food_star").prop('checked', true);
	}
	if('${data.REGIS_FEE_CNT}' == "1")
	{
		$("#regis_fee_cnt1").prop('checked', true);
	}
	else if('${data.REGIS_FEE_CNT}' == "2")
	{
		$("#regis_fee_cnt2").prop('checked', true);
	}
	else if('${data.REGIS_FEE_CNT}' == "3")
	{
		$("#regis_fee_cnt3").prop('checked', true);
	}
	var food_amt_arr = '${data.FOOD_AMT_CNT}'.split("|");
	for(var i = 0; i < food_amt_arr.length-1; i++)
	{
		$("#food_amt_cnt"+food_amt_arr[i]).attr("checked", true);
	}
	
	
	
	getList();
	
	$("#chk_all").change(function() {
		if($("input:checkbox[name='chk_all']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", false);
		}
	});
	
});

function getList(paging_type) 
{
	$.ajax({
		type : "POST", 
		url : "./getRegisByLect",
		dataType : "text",
		data : 
		{
			order_by : order_by,
			sort_type : sort_type,
			store : '${store}',
			period : '${period}',
			subject_cd : '${subject_cd}'
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
				$(".cap-numb1").html("전체"+result.list_cnt+"개");
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+result.list[i].CUS_NO+'</td>';
					inner += '	<td>'+result.list[i].PTL_ID+'</td>';
					inner += '	<td>'+result.list[i].KOR_NM+'</td>';
					inner += '	<td>'+result.list[i].SEX_FG+'</td>';
					inner += '	<td>'+cutDate(result.list[i].BIRTH_YMD)+'</td>';
					inner += '	<td>'+result.list[i].ACCEPT_TYPE+'</td>';
					
					/*
					if(result.list[i].WEB_ACCEPT_FG == "C")
					{
						inner += 'DESC';
					}
					else
					{
						inner += 'WEB';
					}
					inner += '	</td>';
					*/
					
					inner += '	<td>';
					if(Number(result.list[i].CARD_AMT) > 0 && Number(result.list[i].CASH_AMT) > 0)
					{
						inner += '카드/현금';
					}
					else if(Number(result.list[i].CARD_AMT) > 0)
					{
						inner += '카드';
					}
					else if(Number(result.list[i].CASH_AMT) > 0)
					{
						inner += '현금';
					}
					inner += '	</td>';
					inner += '	<td>'+cutDate(result.list[i].SALE_YMD)+'</td>';
					inner += '	<td>';
					if(Number(result.list[i].IS_CUST_NEW) > 1)
					{
						inner += '기존';
					}
					else
					{
						inner += '신규';
					}
					inner += '	</td>';
					inner += '	<td>';
					if(Number(result.list[i].IS_LECT_NEW) > 1)
					{
						inner += '기존';
					}
					else
					{
						inner += '신규';
					}
					
					if (result.list[i].REGIS_CANCEL_FG =="1") 
					{
						inner += '	</td>';
						inner += '	<td>등록</td>';
						inner += '</tr>';
					}
					else if(result.list[i].REGIS_CANCEL_FG =="2")
					{
						inner += '	</td>';
						inner += '	<td>취소</td>';
						inner += '</tr>';
					}
					else 
					{
						inner += '	</td>';
						inner += '	<td>중도</td>';
						inner += '</tr>';
					}
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="12"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target").html(inner);
		}
	});	
}

window.onload = function(){
	selPeri();
}

function selPeri()
{
	$.ajax({
		type : "POST", 
		url : "/basic/peri/getPeriOne",
		dataType : "text",
		async : false,
		data : 
		{
			selPeri : '${data.PERIOD}',
			selBranch : '${data.STORE}'
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
//  			$("#start_ymd").val(cutDate(result.START_YMD));
//  			$("#end_ymd").val(cutDate(result.END_YMD));
 			
 			
 			if(result.TECH_1_S != "Y")
				{
					$("#regis_fee_cnt1").attr("disabled", true);
				}
 			else
				{
 				$("#regis_fee_cnt1").attr("disabled", false);
//  				$("#regis_fee_cnt1").attr("checked", true);
				}
 			if(result.TECH_2_S != "Y")
				{
					$("#regis_fee_cnt2").attr("disabled", true);
				}
 			else
				{
 				$("#regis_fee_cnt2").attr("disabled", false);
//  				$("#regis_fee_cnt2").attr("checked", true);
				}
 			if(result.TECH_3_S != "Y")
				{
					$("#regis_fee_cnt3").attr("disabled", true);
				}
 			else
				{
 				$("#regis_fee_cnt3").attr("disabled", false);
//  				$("#regis_fee_cnt3").attr("checked", true);
				}
 			
 			
 			if(result.MATE_1_S != "Y")
				{
					$("#food_amt_cnt1").attr("disabled", true);
				}
 			else
				{
 				$("#food_amt_cnt1").attr("disabled", false);
//  				$("#food_amt_cnt1").attr("checked", true);
				}
 			if(result.MATE_2_S != "Y")
				{
					$("#food_amt_cnt2").attr("disabled", true);
				}
 			else
				{
 				$("#food_amt_cnt2").attr("disabled", false);
//  				$("#food_amt_cnt2").attr("checked", true);
				}
 			if(result.MATE_3_S != "Y")
				{
					$("#food_amt_cnt3").attr("disabled", true);
				}
 			else
				{
 				$("#food_amt_cnt3").attr("disabled", false);
//  				$("#food_amt_cnt3").attr("checked", true);
				}
		}
	});	
	$("#confirmPeri").val('${period}'); //중간에 바뀌는거 무시하기위하여.
	$("#confirmStore").val('${store}'); //중간에 바뀌는거 무시하기위하여.
	$(".hidden_area").show();
	$.ajax({
		type : "POST", 
		url : "./getClassroom",
		dataType : "text",
		async : false,
		data : 
		{
			selBranch : '${store}'
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			for(var i = 0; i < result.length; i++)
			{
				if(i == 0)
				{
					$(".classroom").html(result[i].ROOM_NM);
				}
				$("#classroom").append('<option value="'+result[i].SEQ_NO+'">'+result[i].ROOM_NM+'</option>');
				$(".classroom_ul").append('<li>'+result[i].ROOM_NM+'</li>');
			}
			$("#classroom").val('${data.CLASSROOM}');
			$(".classroom").html('${data.ROOM_NM}');
		}
	});	
	dateInit();
	getScheduleByPeri();
}

function getScheduleByPeri()
{
	$.ajax({
		type : "POST", 
		url : "./getScheduleByPeri",
		dataType : "text",
		async : false,
		data : 
		{
			store : '${store}',
			period : '${period}'
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			$("#regis_fee_cnt1_schedule").html(cutDate(result.TECH_1_YMD));
			$("#regis_fee_cnt2_schedule").html(cutDate(result.TECH_2_YMD));
			$("#regis_fee_cnt3_schedule").html(cutDate(result.TECH_3_YMD));
			
			$("#food_amt_cnt1_schedule").html(cutDate(result.MATE_1_YMD));
			$("#food_amt_cnt2_schedule").html(cutDate(result.MATE_2_YMD));
			$("#food_amt_cnt3_schedule").html(cutDate(result.MATE_3_YMD));
			for(var i = 0; i < result.length; i++)
			{
				if(i == 0)
				{
					$(".classroom").html(result[i].ROOM_NM);
				}
				$("#classroom").append('<option value="'+result[i].SEQ_NO+'">'+result[i].ROOM_NM+'</option>');
				$(".classroom_ul").append('<li>'+result[i].ROOM_NM+'</li>');
			}
		}
	});	
}

function setSchedule(val)
{
	isCompute = true;
	var mon = 0;
	var tue = 0;
	var wed = 0;
	var thu = 0;
	var fri = 0;
	var sat = 0;
	var sun = 0;
	if($("#yoil_mon").is(":checked"))
	{
		mon = "1";
	}
	if($("#yoil_tue").is(":checked"))
	{
		tue = "1";
	}
	if($("#yoil_wed").is(":checked"))
	{
		wed = "1";
	}
	if($("#yoil_thu").is(":checked"))
	{
		thu = "1";
	}
	if($("#yoil_fri").is(":checked"))
	{
		fri = "1";
	}
	if($("#yoil_sat").is(":checked"))
	{
		sat = "1";
	}
	if($("#yoil_sun").is(":checked"))
	{
		sun = "1";
	}
	var day_flag = mon+""+tue+""+wed+""+thu+""+fri+""+sat+""+sun;
	
	var cl = "";
	$("[name='closed']").each(function() 
	{
		if($(this).val() != "")
		{
			cl += $(this).val()+"|";
		}
	});
	$.ajax({
		type : "POST", 
		url : "./setSchedule",
		dataType : "text",
		async : false,
		data : 
		{
			selPeri : $("#lect_period").val(),
			selBranch : $("#selBranch").val(),
			day_flag : day_flag,
			cancled_list : cl,
			lect_cnt : $("#lect_cnt").val(),
			start_ymd : $("#start_ymd").val(),
			act : val
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log("zzz"+data);
			var result = JSON.parse(data);
			if(val == "init") //시작일은 처음 시작시에만 돌도록
			{
				$("#start_ymd").val(cutDate(result.START_YMD));
			}
			$("#end_ymd").val(cutDate(result.END_YMD));
		}
	});		
	set_web_cancle_ymd();
}
function set_web_cancle_ymd()
{
	$.ajax({
		type : "POST", 
		url : "/basic/peri/getCancled",
		dataType : "text",
		async : false,
		data : 
		{
			selPeri : $("#selPeri").val(),
			selStore : $("#selBranch").val(),
			selMainCd : $("#main_cd").val(),
			selSectCd : $("#sect_cd").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if(result.length != 0)
			{
				$("#web_cancle_ymd").val( comDate($("#start_ymd").val(), result[0].CANCLED, 'minus') );
			}
			else
			{
				$("#web_cancle_ymd").val( comDate($("#start_ymd").val(), 1, 'minus') );
			}
		}
	});	
}
var main_cd ="";
function selMaincd(idx, val){	
	if(val == "1")
	{
		main_cd = $(idx).val();
	}
	else
	{
		main_cd = idx;
	}
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
		if(main_cd == 2)
		{
			$(".babyMonth").show();
		}
		else
		{
			$(".babyMonth").hide();
		}
	}else{
		$('.withBaby').hide();
	}
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		async:false,
		data : 
		{
			maincd : main_cd,
			selBranch : '${store}'
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
			$("#sect_cd").empty();
			$(".sect_cd_ul").html("");
			if(result.length > 0)
			{
				inner="";
				for (var i = 0; i < result.length; i++) 
				{
					$(".sect_cd_ul").append('<li>'+result[i].SECT_NM+'</li>');
					$("#sect_cd").append('<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>');
				}
			}
			else
			{
				
			}
			$("#sect_cd").val("");
			$(".sect_cd").html("선택하세요.");
		}
	});	
}

var sect_cd="";
var sect_text ="";
var main_cd = "";
function sect_choose(idx, val){
	if(val == "1")
	{
		sect_value = $(idx).val();
		sect_text = $(idx).text();
	}
	else
	{
		sect_value = idx;
	}
	$("#sect_cd").val(sect_value);
	$(".sect_cd").html(sect_text);
	
	$('.select-ul').css('display','none');
	
	main_cd =$("#main_cd").val();

	$.ajax({
		type : "POST", 
		url : "./getlectcode",
		dataType : "text",
		async : false,
		data : 
		{
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			$("#lect_cd").val(data);
		}
	});	
// 	$.ajax({
// 		type : "POST", 
// 		url : "/basic/peri/getCancled",
// 		dataType : "text",
// 		async : false,
// 		data : 
// 		{
// 			selPeri : '${period}',
// 			selStore : '${store}'
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			console.log(data);
// 			var result = JSON.parse(data);
// 			if(result.length > 0)
// 			{
// 				for(var i = 0; i < result.length; i++)
// 				{
// 					if(result[i].MAIN_CD == main_cd && result[i].SECT_CD == sect_value)
// 					{
// 						$("#web_cancle_ymd").val( comDate($("#start_ymd").val(), result[i].CANCLED, 'minus') );
// 					}
// 				}
// 				if($("#web_cancle_ymd").val() == "")
// 				{
// 					for(var i = 0; i < result.length; i++)
// 					{
// 						if(result[i].MAIN_CD == "0" && result[i].SECT_CD == "0")
// 						{
// 							$("#web_cancle_ymd").val( comDate($("#start_ymd").val(), result[i].CANCLED, 'minus') );
// 						}
// 					}
// 				}
// 			}
// 		}
// 	});	
	
}

function comDate(strDate, comday, act)
{
	var arr = strDate.split('-');
	var today = new Date(Number(arr[0]), Number(arr[1])-1, Number(arr[2]));
	if(act == "plus")
	{
		today.setDate(today.getDate() + Number(comday));
	}
	else
	{
		today.setDate(today.getDate() - Number(comday));
	}
	var y = String(today.getFullYear());
	var m = String(today.getMonth()+1);
	var d = String(today.getDate());
	if(m.length == 1) { m = "0"+m;} 
	if(d.length == 1) { d = "0"+d;} 
	return y+"-"+m+"-"+d;
}

var subject_cd='';
var main_cd='';
var sub_cd='';
var lect_cd='';
function add_lect(){
	main_cd=$('#main_cd').val();
	sub_cd=$('#sect_cd').val();

	
	subject_cd = main_cd+sub_cd+lect_cd;
	
}

var rest_cnt=2;
var chk_cnt=0;
function add_rest_day(){
	var rest_inner =""; //이게 왜 전역변수에 잇는지 파악불가해서 기영이가 지역변수로 수정! 필요한거라면 따로 말해주세용
	if (rest_cnt>3) {
		alert('제한 수를 초과했습니다.');
		return;
	}
	
	rest_inner+='<div class="wid-4 addArea rest_sub_area_'+rest_cnt+'">';
	rest_inner+='	<div class="cal-row cal-row_inline02 table">';
	rest_inner+='		<div class="cal-input">';
	rest_inner+='			<input type="text" class="date-i" id="closed'+rest_cnt+'" name="closed"/>';
	rest_inner+='			<i class="material-icons">event_available</i>';
	rest_inner+='		</div>';
	rest_inner+='	</div>';
	rest_inner+='</div>';
	$(".rest_day_area").append(rest_inner);
	rest_cnt++; //이게 왜 위에있는지 모르겠어서 기영이가 아래로 내림.. 
	dateInit();
}
function remove_rest_day(){
// 	var rmArea = document.getElementsByClassName("addArea");
// 	if(rmArea.length > 0)
// 	{
// 		rmArea[rmArea.length-1].remove();
// 		rmArea[rmArea.length-1].parentNode.removeChild(rmArea[rmArea.length-1]);
// 		rest_cnt --;
// 	}
var rmArea = document.getElementsByClassName("addArea");
	if(rmArea.length > 0)
	{
		rmArea[rmArea.length-1].parentNode.removeChild(rmArea[rmArea.length-1]);
		rest_cnt --;
	}
	else
	{
		$('input[name=closed]').val('');
	}
}
function lect_cnt_change()
{
	var lect_cnt = Number($("#lect_cnt").val());
	if(lect_cnt == 1)
	{
		$("#subject_fg").val("특강");
		$("input:radio[name='corp_fg']:radio[value='N']").prop('checked', true);
		$("input:radio[name='regis_fee_cnt']:radio[value='2']").prop('checked', true);
// 		$("input:checkbox[id='food_amt_cnt1']").prop("checked", true);
// 		$("input:checkbox[id='food_amt_cnt2']").prop("checked", false);
// 		$("input:checkbox[id='food_amt_cnt3']").prop("checked", false);
	}
	else if(lect_cnt >= 2 && lect_cnt <= 7)
	{
		$("#subject_fg").val("단기");
		$("input:radio[name='corp_fg']:radio[value='N']").prop('checked', true); 
		$("input:radio[name='regis_fee_cnt']:radio[value='3']").prop('checked', true);
// 		$("input:checkbox[id='food_amt_cnt1']").prop("checked", true);
// 		$("input:checkbox[id='food_amt_cnt2']").prop("checked", true);
// 		$("input:checkbox[id='food_amt_cnt3']").prop("checked", true);
	}
	else
	{
		$("#subject_fg").val("정규");
		$("input:radio[name='corp_fg']:radio[value='Y']").prop('checked', true); 
		$("input:radio[name='regis_fee_cnt']:radio[value='3']").prop('checked', true);
// 		$("input:checkbox[id='food_amt_cnt1']").prop("checked", true);
// 		$("input:checkbox[id='food_amt_cnt2']").prop("checked", true);
// 		$("input:checkbox[id='food_amt_cnt3']").prop("checked", true);
	}
}
function getLecrList()
{
	if($("#lecr_name").val() == "" && $("#lecr_phone").val() == "")
	{
		alert("검색어를 입력해주세요.");
		return;
	}
	$.ajax({
		type : "POST", 
		url : "./getLecrList",
		dataType : "text",
		data : 
		{
			lecr_name : $("#lecr_name").val(),
			lecr_phone : $("#lecr_phone").val()
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
			if(result.length == 0)
			{
				inner += '<tr>';
				inner += '	<td colspan="7">';
				inner += '		검색결과가 없습니다.';
				inner += '	</td>';
				inner += '</tr>';
			}
			else
			{
				for(var i = 0; i < result.length; i++)
				{
					inner += '<tr onclick="insLecr(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
					inner += '	<td>';
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+(i+1);
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+nullChk(result[i].CORP_FG);
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+nullChk(result[i].BIZ_NM);
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+nullChk(result[i].CUS_NO);
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+nullChk(result[i].PTL_ID);
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+cutDate(nullChk(result[i].BMD));
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+nullChk(result[i].CUS_PN);
					inner += '	</td>';
					inner += '	<td>';
					inner += '		'+nullChk(result[i].MTEL_IDENT_NO)+'-'+nullChk(result[i].MMT_EX_NO)+'-'+nullChk(result[i].MTEL_UNIQ_NO);
					inner += '	</td>';
					inner += '</tr>';
				}
			}
			$("#lecr_area").empty();
			$("#lecr_area").append(inner);
		}
	});	
}
function insLecr(ret)
{
	$('#give_layer').fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
	$("#web_lecture_nm"+lecr).val(result.CUS_PN);
	if(lecr == 1)
	{
		$("#lecturer_cd").val(result.LECTURER_CD);
		$("#cus_no").val(result.CUS_NO);
	}
	else
	{
		$("#lecturer_cd1").val(result.LECTURER_CD);
		$("#cus_no1").val(result.CUS_NO);
	}
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
		if($("#fix_pay_yn1").is(":checked") && $("#fix_rate").val() == "")
		{
			alert("정률을 입력해주세요.");
			$("#fix_amt").focus();
			validationFlag = "N";
			return false;
		}
	}
	if(validationFlag == "Y")
	{
		if($("#fix_pay_yn2").is(":checked") && $("#fix_amt").val() == "")
		{
			alert("정액을 입력해주세요.");
			$("#fix_rate").focus();
			validationFlag = "N";
			return false;
		}
	}
	if(validationFlag == "Y")
	{
		if($("#lect_hour1").val().length != 2 || $("#lect_hour2").val().length != 2 || $("#lect_hour3").val().length != 2 || $("#lect_hour4").val().length != 2)
		{
			alert("강의시간을 확인해주세요.");
			validationFlag = "N";
			return false;
		}
	}
	if(validationFlag == "Y")
	{
		var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
		var web_cancle_ymd = $("#web_cancle_ymd").val().replace(/-/gi, "");
		if(Number(start_ymd) < Number(web_cancle_ymd))
		{
			alert("웹결제 취소 마감일이 시작일보다 이후일 수 없습니다.");
			validationFlag = "N";
			return;
		}
	}
	
	var isCanc = false;
	$("[name='closed']").each(function() 
	{
		if($(this).val() != "")
		{
			if(
					$(this).val().replace(/#/gi, "") <= $("#start_ymd").val().replace(/#/gi, "") || 
					$(this).val().replace(/#/gi, "") >= $("#end_ymd").val().replace(/#/gi, ""))
			{
				alert(2);
				isCanc = true;
			}
		}
	});
	if(isCanc)
	{
		alert("휴강일을 확인해주세요.");
		validationFlag = "N";
		return;
	}
	
	
	if(validationFlag == "Y")
	{
		$.ajax({
			type : "POST", 
			url : "./getRoomCapacity",
			dataType : "text",
			async : false,
			data : 
			{
				seq_no : $("#classroom").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				if(Number($("#capacity_no").val()) > Number(data))
				{
					alert("정원이 강의실의 최대수용인원보다 많습니다.");
					validationFlag = "N";
					return false;
				}
			}
		});
	}
	if(validationFlag == "Y")
	{
		if($("#food_amt").val() != 0)
		{
			if(!$("#food_amt_cnt1").is(":checked") && !$("#food_amt_cnt2").is(":checked") && !$("#food_amt_cnt3").is(":checked"))
			{
				alert("재료비가 있는경우, 재료비 일정관리를 선택하셔야합니다.");
				validationFlag = "N";
				return false;
			}
		}
	}
	if(validationFlag == "Y")
	{
		var mon = 0;
		var tue = 0;
		var wed = 0;
		var thu = 0;
		var fri = 0;
		var sat = 0;
		var sun = 0;
		if($("#yoil_mon").is(":checked"))
		{
			mon = "1";
		}
		if($("#yoil_tue").is(":checked"))
		{
			tue = "1";
		}
		if($("#yoil_wed").is(":checked"))
		{
			wed = "1";
		}
		if($("#yoil_thu").is(":checked"))
		{
			thu = "1";
		}
		if($("#yoil_fri").is(":checked"))
		{
			fri = "1";
		}
		if($("#yoil_sat").is(":checked"))
		{
			sat = "1";
		}
		if($("#yoil_sun").is(":checked"))
		{
			sun = "1";
		}
		var day_flag = mon+""+tue+""+wed+""+thu+""+fri+""+sat+""+sun;
		$("#day_flag").val(day_flag);
		
		var cl = "";
		$("[name='closed']").each(function() 
		{
			if($(this).val() != "")
			{
				cl += $(this).val()+"|";
			}
		});
		$("#cancled_list").val(cl);
		

		$("#fncForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	    			uptAttendDay();
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


function endAction()
{
	
	
	var chkList = "${store}_${period}_${subject_cd}|";
	var send_tm ="Y";
	
	var isEnd = confirm("폐강을 하시겠습니까?.");
	if(isEnd == true){
		$.ajax({
			type : "POST", 
			url : "./endAction",
			dataType : "text",
			async : false,
			data : 
			{
				chkList : chkList,
				act : 'Y',
				send_tm : send_tm
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
	    			location.href="/lecture/lect/list_close";
	    		}
	    		else
	    		{
		    		alert(result.msg);
	    		}
			}
		});	
	}
	else if(isEnd == false){
	  return;
	}
	
	
}
function changeStatus(store, period, subject_cd)
{
	if($("#delete_yn_"+store+"_"+period+"_"+subject_cd).hasClass("btn03"))
	{
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd).removeClass("btn03");
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd).removeClass("btn03");
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd).addClass("btn04");
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd).html("N");
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd+"_status").val("N");
	}
	else if($("#delete_yn_"+store+"_"+period+"_"+subject_cd).hasClass("btn04"))
	{
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd).removeClass("btn04");
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd).addClass("btn03");
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd).html("Y");
		$("#delete_yn_"+store+"_"+period+"_"+subject_cd+"_status").val("Y");
	}
	
	$.ajax({
		type : "POST", 
		url : "./changeDelete_pelt",
		dataType : "text",
		data : 
		{
			store : store,
			period : period,
			subject_cd : subject_cd,
			delete_yn : $("#delete_yn_"+store+"_"+period+"_"+subject_cd+"_status").val()
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
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});
}


function guessSchedule(start_ymd, type)
{
	

   //console.log(start_ymd.substring(0, 4));
   //console.log(start_ymd.substring(4,6)-1);
   //console.log(start_ymd.substring(6,8));
   //console.log(start_ymd.substring(0,8));
   console.log(start_ymd);
   var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8) ,00 ,00 );
   //var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8) ,11 ,59 );
   var current_date = new Date();
 
   console.log("DATE START : "+date_start);
   console.log("CURRENT START : "+current_date);
   
   var typex = type;	
   if(current_date < date_start || start_ymd=="X")
   {
      typex = "";
   }
 

   
   return typex; 
}

var per_cnt=0;
function cntForGraph(start_ymd)
{
   var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8) ,00 ,00 );
   var current_date = new Date();
   if(current_date > date_start)
   {
      typex = "";
	  per_cnt++;
   }
}


var excel_subject_nm='';
var excel_subject_cd='';
var excel_web_lecturer_nm='';
var excel_start_ymd='';
var excel_end_ymd='';
var excel_subject_nm='';

var order_by2 = "";
var sort_type2 = "";

function reSortAjax2(act)
{
	if(!isLoading)
	{
		sort_type2 = act.replace("sort_", "");
		if(order_by2 == "")
		{
			order_by2 = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		else if(order_by2 == "desc")
		{
			order_by2 = "asc";
			$("#"+act).attr("src", "/img/th_up.png");
		}
		else if(order_by2 == "asc")
		{
			order_by2 = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		getAttend();
	}
}

function getAttend() 
{
	$.ajax({
		type : "POST", 
		url : "./getCustAttendList",
		dataType : "text",
		data : 
		{
			order_by : order_by2,
			sort_type : sort_type2,
			
			store : $('#selBranch').val(),
			period : $('#selPeri').val(),
			subject_cd : "${data.SUBJECT_CD}"
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			$("#result").val(data);
			var result = JSON.parse(data);
			if (result.isSuc=="success") 
			{
				$(".cap-numb2").html("전체"+result.list_cnt+"개");
				excel_subject_nm = result.subject_nm;
				excel_subject_cd =  result.subject_cd;
				excel_web_lecturer_nm =  result.web_lecturer_nm;
				excel_start_ymd =  result.start_ymd;
				excel_end_ymd =  result.end_ymd;
				excel_lect_hour =  result.lect_hour;
				
				var inner = "";
				var day_chk_arr = result.day_chk.split('|');
				///////////List head세팅 start//////////////////
				inner ="";
				inner +='<tr>';
				inner +='	<th class="td-chk"> <input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label> </th>';
				inner +='	<th>No.</th>';
				inner +='	<th onclick="reSortAjax2(\'sort_parent_nm\')">회원명<img src="/img/th_up.png" id="sort_parent_nm"></th>';
				inner +='	<th onclick="reSortAjax2(\'sort_kids_nm\')"> 자녀명 <img src="/img/th_up.png" id="sort_kids_nm"></th> ';
				inner +='	<th onclick="reSortAjax2(\'sort_cust_no\')">회원번호 <img src="/img/th_up.png" id="sort_cust_no"></th> ';
				inner +='	<th onclick="reSortAjax2(\'sort_phone_no\')">전화번호 <img src="/img/th_up.png" id="sort_phone_no"></th>';
				inner +='	<th onclick="reSortAjax2(\'sort_car_no\')">차량번호<img src="/img/th_up.png" id="sort_car_no"></th>';
				for (var i = 0; i < day_chk_arr.length-1; i++) 
				{
					inner +='<th class="chk-date">';
					inner +='	['+day_chk_arr[i].substr(4,2)+'/'+day_chk_arr[i].substr(6,2)+']';
					inner +='</th>'	
				}
	
				
				inner +='<th>비고</th>';
				inner +='</tr>';
				$('#list_head_target').html(inner);
				inner=""; //inner 초기화
				
				var inner2 = "";
				
				
				inner2 += '<table>';
				inner2 += '	<colgroup>';
				inner2 += '		<col width="40px">';
				inner2 += '		<col width="60px">';
				inner2 += '		<col width="300px">';
				inner2 += '		<col>';
				inner2 += '		<col>';
				inner2 += '		<col>';
				inner2 += '		<col>';
				for (var i = 0; i < day_chk_arr.length-1; i++) {
					inner2 += '		<col />';
				}
				inner2 += '	</colgroup>';
				inner2 += '	<thead>';
				inner2 += inner;
				inner2 += '	</thead>';
				inner2 += '</table>';
				
				$('#list_head_target_head').html(inner2);
				
				var inner3 = "";			

				inner3 += '		<col width="40px">';
				inner3 += '		<col width="60px">';
				inner3 += '		<col width="300px">';
				inner3 += '		<col>';
				inner3 += '		<col>';
				inner3 += '		<col>';
				inner3 += '		<col>';
				for (var i = 0; i < day_chk_arr.length-1; i++) {
					inner3 += '		<col />';
				}
				$('#list_colgroup').html(inner3);
				
				///////////List head세팅 end//////////////////
				
				var dayChk = ""; //출석체크 값 세팅			
				if(result.list.length > 0)
				{
					
					
							
							
					inner="";
					for(var i = 0; i < result.list.length; i++)
					{
						dayChk = result.list[i].DAY_CHK.split('|');
						console.log('dayChk : '+dayChk);
						inner += '<tr>';
						inner += '	<td class="td-chk">';
						inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" name="chk_val" value="">';
						inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'"></label>';
						inner += '	</td>';
						inner += '  <td>'+(i+1)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].PARENT_NM)+'</td>';						
						inner += '	<td>'+nullChk(result.list[i].KIDS_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CUST_NO)+'</td>';
						inner += '	<td><span style="display:none;">\'</span>'+nullChk(result.list[i].PHONE_NO)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CAR_NO)+'</td>';
						
						console.log("len : "+dayChk.length);
						for (var j = 0; j < dayChk.length-1; j++) 
						{
							if (nullChk(day_chk_arr[j])!="") 
							{
								//inner += '	<td>'+guessSchedule(day_chk_arr[j],nullChk(dayChk[j]))+'</td>';
								inner += '	<td></td>';
							}
						}
						inner += '	<td>'+nullChk(result.list[i].CONTENT)+'</td>';
						//inner += '	<td>'+guessSchedule("${DAY2}",nullChk(result.list[i].DAY2))+'</td>';
						inner += '</tr>';
					
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="'+(7+day_chk_arr.length)+'"><div class="no-data">수강생이 없습니다.</div></td>';
					inner += '</tr>';
				}
	
				$("#list_attend").html(inner);
			}else{
				
				inner += '<tr>';
				inner += '	<td><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
				$('#list_colgroup').empty();
				$('#list_head_target').empty();
				$("#list_attend").html(inner);
			}
		}
	});	
}

window.onload = function(){
	
	$('#selBranch').val("${store}");
	$('#selPeri').val("${period}");
	setPeri();
	$("#selYear").val("${WEB_TEXT}".substring(0,4));
	$(".selYear").html("${WEB_TEXT}".substring(0,4));
	fncPeri();
	$('#selBranch').val("${store}");
	$('#selPeri').val("${period}");
	var season = "${WEB_TEXT}".substring(7,"${WEB_TEXT}".length);
	$("#selSeason").val(season);
	$(".selSeason").html(season + " / "+"${period}");
	getAttend();
}


function uptAttendDay()
{
	$.ajax({
		type : "POST", 
		url : "./uptAttendDay",
		dataType : "text",
		async : false,
		data : 
		{
			store : '${store}',
			period : '${period}',
			subject_cd : '${subject_cd}'
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			
		}
	});	
}

</script>

<div class="sub-tit">
	<h2>강좌 상세</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn02" onclick="javascript:endAction();">폐강처리</a>
		<a class="btn btn01 btn01_1" href="/member/wait/list">대기자 관리 </a>
	</div>
	
</div>


<div class="lect-top table-top first wid-10">
<p class="lect-st">${data.MAIN_NM}<i class="material-icons">keyboard_arrow_right</i><span class="color-pink">${data.SECT_NM}</span></p>
	<div class="table table-auto">
		<div class="lect-titwr">
			<p class="lect-tit">${data.SUBJECT_NM}(${data.SUBJECT_CD})</p>
			<p class="lect-tit2">${data.WEB_LECTURER_NM} 강사</p>
			<p class="btn btn08">${data.STORE_NAME}</p>
		</div>
		<div class="plan-grp">
			<div class="plan-gtit">강의진행도</div>
			<div class="plan-grpd"><div class="plg-wr"><span style="width:${percent}%"></span></div></div>
			<div class="plan-per color-pink">${percent}%</div>
		</div>
	</div>
</div>


<div class="table-wr tab-wrap_mem lect-li_tablewr">
	<div class="tab-wrap tab-wrap_mem">		
		<div class="tab-title">
			<ul>
				<li class="active">강좌정보</li>
				<li>강좌별 수강현황</li>
				<li>강의계획서</li>
				<li>출석부</li>
			</ul>
		</div> <!-- tab-title end -->
		
		
		
		<div class="tab-content">
			<div class="member-profile lect-li_tab member-profile02 active">
				<div class="table-list table-list-no">
					<form id="fncForm" name="fncForm" method="post" action="./modify_proc" enctype="multipart/form-data">
						<input type="hidden" id="confirmPeri" name="confirmPeri">
						<input type="hidden" id="confirmStore" name="confirmStore">
						<input type="hidden" id="day_flag" name="day_flag">
						<input type="hidden" id="cancled_list" name="cancled_list">
						<input type="hidden" id="lecturer_cd" name="lecturer_cd">
						<input type="hidden" id="lecturer_cd1" name="lecturer_cd1">
						<input type="hidden" id="cus_no" name="cus_no">
						<input type="hidden" id="cus_no1" name="cus_no1">
						<input type="hidden" id="prev_subject_cd" name="prev_subject_cd" value="${subject_cd}">
						<div class="row">
							<div class="wid-5">
								<div class="bor-div">
									<div class="top-row table-input">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit">기수</div>
												<div>
													<input type="text" id="lect_period" name="lect_period" value="" class="inp-100 inputDisabled" readOnly>
												</div>
												<div class="sel-txt10">기</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">폐강유무</div>
												<div>
													<c:if test="${data.END_YN ne 'Y'}">
											   			<a onclick="javascript:changeStatus('${data.STORE}', '${data.PERIOD}', '${data.SUBJECT_CD}')" id="delete_yn_${data.STORE}_${data.PERIOD}_${data.SUBJECT_CD}" name="delete_yn" class="btn04 bor-btn btn-inline">N</a>
											   			<input type="hidden" id="delete_yn_${data.STORE}_${data.PERIOD}_${data.SUBJECT_CD}_status" name="delete_yn_status" value="N">
											   		</c:if>
											   		<c:if test="${data.END_YN eq 'Y'}">
											   			<a onclick="javascript:changeStatus('${data.STORE}', '${data.PERIOD}', '${data.SUBJECT_CD}')" id="delete_yn_${data.STORE}_${data.PERIOD}_${data.SUBJECT_CD}" name="delete_yn" class="btn03 bor-btn btn-inline">Y</a>
											   			<input type="hidden" id="delete_yn_${data.STORE}_${data.PERIOD}_${data.SUBJECT_CD}_status" name="delete_yn_status" value="Y">
											   		</c:if>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="bor-div">
									<div class="top-row table-input">
										<div class="wid-33">
											<div class="table">
												<div class="sear-tit">강의횟수</div>
												<div>
													<select de-data="1" id="lect_cnt" name="lect_cnt" onchange="lect_cnt_change()">
														<c:forEach var="i" begin="1" end="36">
															<option value="${i}">${i}</option>
														</c:forEach>
													</select>
												</div>
												<div class="sel-txt10">강</div>
											</div>
										</div>
										<div class="wid-33">
											<div class="table">
												<div class="sear-tit sear-tit_left">강좌유형</div>
												<div>
													<input type="text" id="subject_fg" name="subject_fg" value="특강" class="inp-100 inputDisabled" readOnly>
												</div>
											</div>
										</div>
										<div class="wid-33">
											<div class="table">
												<div class="sear-tit sear-tit_left">코드명</div>
												<div>
													<input type="text" id="lect_cd" name="lect_cd" data-name="코드명" class="notEmpty inputDisabled" placeholder="입력하세요." readOnly>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="bor-div">
									<div class="top-row table-input">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">강좌명</div>
												<div>
													<input type="text" id="subject_nm" name="subject_nm" data-name="강좌명" class="notEmpty" placeholder="입력하세요." onkeypress="fnChkByte(this, 60);">
												</div>
											</div>
										</div>
									</div>
									<div class="top-row table-input">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit">대분류</div>
												<div>
													<select de-data="선택하세요." id="main_cd" name="main_cd" data-name="대분류" class="notEmpty" onchange="selMaincd(this, '1')">
														<c:forEach var="j" items="${maincdList}" varStatus="loop">
															<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
														</c:forEach>
													</select>
												</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">중분류</div>
												<div>
													<select de-data="선택하세요." id="sect_cd" name="sect_cd" data-name="중분류" class="notEmpty" onchange="">
					
													</select>
												</div>
											</div>
										</div>
									</div>
									
									<div class="top-row table-input withBaby">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">수강조건</div>
												<div class="wid-15">
													<ul class="chk-ul">
														<li>
															<input type="checkbox" id="is_two" name="is_two">
															<label for="is_two">2인 수강</label>
														</li>
													</ul>
												</div>
												<div class="wid-21 wid-inline babyMonth">
													<div class="sel-wid sel-scr">
														<input type="text" id="month_no" name="month_no">
														<span class="sel-sp">개월 이상</span>
													</div>
													
													<div class="sel-wid sel-scr">
														<input type="text" id="month_no1" name="month_no1">
														<span class="sel-sp">개월 이하</span>
													</div>
												</div>
												
											</div>
										</div>
										
									</div>
								</div>
								
									
								<div class="bor-div">
									<div class="top-row">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit">강사명1</div>
												<div>
													<div class="search-wr search-wr03" onclick="searchLecr('1')">
					<!-- 									<form id="fncForm" name="fncForm" method="get" action="./write"> -->
					<!-- 									    <input type="hidden" id="page" name="page" value="1"> -->
														    <input type="text" id="web_lecture_nm1" class="inp-100 notEmpty inputDisabled" name="web_lecture_nm1" data-name="강사명" placeholder="조회하기" readOnly>
															<input class="search-btn" type="button" value="검색" onclick="reSelect()">
					<!-- 									    <input class="search-btn" type="button" value="검색"> -->
					<!-- 										<input type="hidden" id="order_by" name="order_by" value=""> -->
					<!-- 									    <input type="hidden" id="sort_type" name="sort_type" value=""> -->
					<!-- 									</form> -->
													</div>			
												</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">강사명2</div>
												<div>
													<div class="search-wr search-wr03" onclick="searchLecr('2')">
					<!-- 									<form id="fncForm" name="fncForm" method="get" action="./write"> -->
					<!-- 									    <input type="hidden" id="page" name="page" value="1"> -->
														    <input type="text" id="web_lecture_nm2" class="inp-100" name="web_lecture_nm2" placeholder="조회하기">
															<input class="search-btn" type="button" value="검색" onclick="reSelect()">
					<!-- 									    <input class="search-btn" type="button" value="검색"> -->
					<!-- 										<input type="hidden" id="order_by" name="order_by" value=""> -->
					<!-- 									    <input type="hidden" id="sort_type" name="sort_type" value=""> -->
					<!-- 									</form> -->
													</div>			
												</div>
											</div>
										</div>
									</div>
									<div class="top-row table-input">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit">정원</div>
												<div>
													<input type="text" id="capacity_no" name="capacity_no" data-name="정원" class="text-center notEmpty" value="10">
												</div>
												<div class="sel-txt10">명</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">강의실</div>
												<div>
													<select de-data="선택하세요." id="classroom" name="classroom" data-name="강의실">
														
													</select>
												</div>
											</div>
										</div>
									</div>
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">강의요일</div>
												<div>
													<ul class="chk-ul">
														<li>
															<input type="checkbox" id="yoil_mon" name="yoil_mon">
															<label for="yoil_mon">월</label>
														</li>
														<li>
															<input type="checkbox" id="yoil_tue" name="yoil_tue">
															<label for="yoil_tue">화</label>
														</li>
														<li>
															<input type="checkbox" id="yoil_wed" name="yoil_wed">
															<label for="yoil_wed">수</label>
														</li>
														<li>
															<input type="checkbox" id="yoil_thu" name="yoil_thu">
															<label for="yoil_thu">목</label>
														</li>
														<li>
															<input type="checkbox" id="yoil_fri"  name="yoil_fri">
															<label for="yoil_fri">금</label>
														</li>
														<li>
															<input type="checkbox" id="yoil_sat" name="yoil_sat">
															<label for="yoil_sat">토</label>
														</li>
														<li>
															<input type="checkbox" id="yoil_sun" name="yoil_sun">
															<label for="yoil_sun">일</label>
														</li>
													</ul>
												</div>
											</div>
										</div>
									</div>
									
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">강좌일정</div>
												<div>
													<div class="table table-auto">
														<div>
															<div class="cal-row table table-90">
																<div class="cal-input cal-input02">
																	<input type="text" class="date-i" id="start_ymd" name="start_ymd"/>
																	<i class="material-icons">event_available</i>
																</div>
																<div class="cal-dash">-</div>
																<div class="cal-input cal-input02">
																	<input type="text" class="date-i" id="end_ymd" name="end_ymd"/>
																	<i class="material-icons">event_available</i>
																</div>
																
															</div>		
														</div>
														<div>
															<a class="btn btn02" onclick="setSchedule();">일정계산</a>
														</div>			
													</div>			
												</div>
											</div>
										</div>
										
									</div>
									
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">할인여부</div>
												<div>
													<ul class="chk-ul">
														<li>
															<input type="radio" id="corp_fg_1" name="corp_fg" value="Y">
															<label for="corp_fg_1">Y</label>
														</li>
														<li>
															<input type="radio" id="corp_fg_2" name="corp_fg" value="N">
															<label for="corp_fg_2">N</label>
														</li>
														
													</ul>
													
												</div>
											</div>
										</div>
									</div>
<!-- 									<div class="top-row"> -->
<!-- 										<div class="wid-10"> -->
<!-- 											<div class="table"> -->
<!-- 												<div class="sear-tit">썸네일 이미지</div> -->
<!-- 												<div> -->
<!-- 													<div class="filebox">  -->
<!-- 														<label for="thumbnail"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
<!-- 														<input type="file" id="thumbnail" name="thumbnail">  -->
														
<!-- 														<input class="upload-name" value="이미지를 첨부해주세요."> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="top-row"> -->
<!-- 										<div class="wid-10"> -->
<!-- 											<div class="table"> -->
<!-- 												<div class="sear-tit">상세 이미지</div> -->
<!-- 												<div> -->
<!-- 													<div class="filebox">  -->
<!-- 														<label for="detail"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
<!-- 														<input type="file" id="detail" name="detail">  -->
														
<!-- 														<input class="upload-name02" value="이미지를 첨부해주세요."> -->
<!-- 													</div> -->
<!-- 												</div> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
									
									
								</div>
							
							
							</div>
							
							<div class="wid-5 wid-5_last lect-lidewr gift-wrap">
								<div class="bor-div">
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit sear-tit03">강의시간</div>
												<div>
													<div class="time-row">
														<div>
															<div class="time-input time-input180 sel-scr">
				<!-- 												<select de-data="0" id="lect_hour1" name="lect_hour1"> -->
				<%-- 													<c:forEach var="i" begin="0" end="23" varStatus="loop"> --%>
				<%-- 														<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" /> --%>
				<%-- 														<c:if test="${fn:length(loop_index) eq 1}"> --%>
				<%-- 															<option value="0${loop_index}">${loop_index}</option> --%>
				<%-- 														</c:if> --%>
				<%-- 														<c:if test="${fn:length(loop_index) ne 1}"> --%>
				<%-- 															<option value="${loop_index}">${loop_index}</option> --%>
				<%-- 														</c:if> --%>
				<%-- 													</c:forEach> --%>
				<!-- 												</select> -->
																<input type="text" id="lect_hour1" name="lect_hour1" class="onlyNumber" maxlength="2" style="width:50px;">
															</div>
															<div class="time-dash">:</div>
															<div class="time-input time-input180">
				<!-- 												<select de-data="0" id="lect_hour2" name="lect_hour2"> -->
				<!-- 													<option value="00">0</option> -->
				<!-- 													<option value="10">10</option> -->
				<!-- 													<option value="20">20</option> -->
				<!-- 													<option value="30">30</option> -->
				<!-- 													<option value="40">40</option> -->
				<!-- 													<option value="50">50</option> -->
				<!-- 												</select> -->
																<input type="text" id="lect_hour2" name="lect_hour2" class="onlyNumber" maxlength="2" style="width:50px;">
															</div>
														</div>
														<div class="time-two">ㅡ</div>
														<div>
															<div class="time-input time-input180 sel-scr">
				<!-- 												<select de-data="0" id="lect_hour3" name="lect_hour3"> -->
				<%-- 													<c:forEach var="i" begin="0" end="23" varStatus="loop"> --%>
				<%-- 														<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" /> --%>
				<%-- 														<c:if test="${fn:length(loop_index) == 1}"> --%>
				<%-- 															<c:set var="loop_val" value="0${loop.index}"/> --%>
				<%-- 														</c:if> --%>
				<%-- 														<c:if test="${fn:length(loop_index) != 1}"> --%>
				<%-- 															<c:set var="loop_val" value="${loop.index}"/> --%>
				<%-- 														</c:if> --%>
				<%-- 														<option value="${loop_val}">${loop.index}</option> --%>
				<%-- 													</c:forEach> --%>
				<!-- 												</select> -->
																<input type="text" id="lect_hour3" name="lect_hour3" class="onlyNumber" maxlength="2" style="width:50px;">
															</div>
															<div class="time-dash">:</div>
															<div class="time-input time-input180">
				<!-- 												<select de-data="0" id="lect_hour4" name="lect_hour4"> -->
				<!-- 													<option value="00">0</option> -->
				<!-- 													<option value="10">10</option> -->
				<!-- 													<option value="20">20</option> -->
				<!-- 													<option value="30">30</option> -->
				<!-- 													<option value="40">40</option> -->
				<!-- 													<option value="50">50</option> -->
				<!-- 												</select> -->
																<input type="text" id="lect_hour4" name="lect_hour4" class="onlyNumber" maxlength="2" style="width:50px;">
															</div>
														</div>
													</div>						
												</div>
											</div>
										</div>
									</div>
									<div class="top-row">
										<div class="wid-10">
											<div class="table table-input">
												<div class="sear-tit sear-tit03">웹결제 취소 마감일</div>
												<div>
													<div class="cal-row">
														<div class="cal-input cal-input100">
															<input type="text" class="date-i" id="web_cancle_ymd" name="web_cancle_ymd"/>
															<i class="material-icons">event_available</i>
														</div>
													</div>
													
												</div>
											</div>
										</div>
									</div>
									<div class="top-row">
										<div class="wid-10">
											<div class="table table-input vertical-top table-hu02">
												<div class="sear-tit sear-tit03">휴강일</div>
												<div>
													<div class="table" id="target_closed">
														<div class="wid-45">
															<div class="cal-row cal-row_inline02 table">
															
					<!-- 											<ul class="chk-ul chk-cal"> -->
					<!-- 												<li> -->
					<!-- 													<input type="checkbox" id="all-c" name="all-c"> -->
					<!-- 													<label for="all-c"></label> -->
					<!-- 												</li> -->
					<!-- 											</ul> -->
																<div class="cal-input ">
																	<input type="text" class="date-i" id="closed1" name="closed"/>
																	<i class="material-icons">event_available</i>
																</div>
															</div>
														</div>
														<div class="wid-5 btn-div">
															<a class="btn btn02" onclick="add_rest_day();">추가하기</a>
															<a class="btn btn03" onclick="remove_rest_day();">삭제하기</a>
														</div>
													</div>
													<div class="table table-input bor-div pad5 table-hu rest_day_area">
													
														
														
														
													</div>
												</div>
												
											</div>
										</div>
									</div>
									
								</div>
								
								<div class="bor-div">
									<div class="top-row">
										<div class="wid-10">
											<div class="table vertical-top">
												<div class="sear-tit sear-tit03">강사료 지급방법</div>
												<div>
													<div class="top-row table-input">
														<div class="wid-5">
															<div class="table table-90 margin-auto">
																<div class="sear-tit sear-tit_70">
																	<input type="radio" id="fix_pay_yn1" name="fix_pay_yn" value="N" checked/>
																	<label for="fix_pay_yn1">정률</label>
																</div>
																<div>
																	<input type="text" id="fix_rate" class="text-center" name="fix_rate" value="" placeholder="60">
																</div>
																<div class="sel-txt10">%</div>
															</div>
														</div>
														<div class="wid-5">
															<div class="table table-90 margin-auto">
																<div class="sear-tit sear-tit_70">
																	<input type="radio" id="fix_pay_yn2" name="fix_pay_yn" value="Y"/>
																	<label for="fix_pay_yn2">정액</label>
																</div>
																<div>
																	<input type="text" id="fix_amt" class="text-center comma" name="fix_amt" value="" placeholder="60">
																</div>
																<div class="sel-txt10">원</div>
															</div>
														</div>
													</div>									
												</div>
											</div>
										</div>
									</div>
									<div class="top-row table-input">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit">수강료</div>
												<div>
													<input type="text" id="regis_fee" name="regis_fee" class="text-right notEmpty comma" placeholder="0" data-name="수강료">
												</div>
												<div class="sel-txt10">원</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit_120 sear-tit_left">재료비</div>
												<div>
													<input type="text" id="food_amt" name="food_amt" class="text-right notEmpty comma" placeholder="0" data-name="재료비">
												</div>
												<div class="sel-txt10">원</div>
												<div style="padding-left:15px;">
													<input type="checkbox" id="food_star" name="food_star" onclick="foodStar()">
													<label for="food_star">재료비 별도</label>
												</div>
											</div>
										</div>
									</div>					
								</div>
								
								<div class="bor-div">
									<div class="top-row table-input">
										<div class="wid-5 ">
											<div class="table-90 bor-r">
												<div class="sear-tit bor-div sear-tit_120">강사료 일정 관리</div>
												<div>
													<input type="radio" id="regis_fee_cnt1" name="regis_fee_cnt" value="1"/>
													<label for="regis_fee_cnt1">1차</label>
													<span id="regis_fee_cnt1_schedule"></span><br>
													<input type="radio" id="regis_fee_cnt2" name="regis_fee_cnt" value="2"/>
													<label for="regis_fee_cnt2">2차</label>
													<span id="regis_fee_cnt2_schedule"></span><br>
													<input type="radio" id="regis_fee_cnt3" name="regis_fee_cnt" value="3"/>
													<label for="regis_fee_cnt3">3차</label>
													<span id="regis_fee_cnt3_schedule"></span>	
				<!-- 									<ul class="chk-ul"> -->
				<!-- 										<li> -->
				<!-- 											<input type="checkbox" id="regis_fee1" name="regis_fee1"> -->
				<!-- 											<label for="regis_fee1">1차</label> -->
				<!-- 										</li> -->
				<!-- 										<li> -->
				<!-- 											<input type="checkbox" id="regis_fee2" name="regis_fee2"> -->
				<!-- 											<label for="regis_fee2">2차</label> -->
				<!-- 										</li> -->
				<!-- 										<li> -->
				<!-- 											<input type="checkbox" id="regis_fee3" name="regis_fee3"> -->
				<!-- 											<label for="regis_fee3">3차</label> -->
				<!-- 										</li> -->
				<!-- 									</ul> -->
												</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="">
												<div class="sear-tit bor-div sear-tit_120">재료비 일정 관리</div>
												<div>
													<input type="checkbox" id="food_amt_cnt1" name="food_amt_cnt1">
													<label for="food_amt_cnt1">1차</label>
													<span id="food_amt_cnt1_schedule"></span><br>
													<input type="checkbox" id="food_amt_cnt2" name="food_amt_cnt2">
													<label for="food_amt_cnt2">2차</label>
													<span id="food_amt_cnt2_schedule"></span><br>
													<input type="checkbox" id="food_amt_cnt3" name="food_amt_cnt3">
													<label for="food_amt_cnt3">3차</label>
													<span id="food_amt_cnt3_schedule"></span>
												</div>
											</div>
										</div>
									</div>	
								</div>
								
								
							</div>
							
							
						</div>
					</form>
				</div>
				<div class="btn-wr text-center">
					<a class="btn btn02 ok-btn hidden_area" id="initPage3" style="" onclick="javascript:fncSubmit();">저장</a>
				</div>
			</div>
			<div class="">
<!-- 				<div class="table-top table-top02"> -->
<!-- 					<div class="top-row sear-wr"> -->
<!-- 						<div class="wid-5"> -->
<!-- 							<div class="table"> -->
<!-- 								<div class="search-wr sel100"> -->
<!-- 									<select id="" name="" onchange="" de-data="검색항목"> -->
<!-- 										<option value="20">멤버스번호</option> -->
<!-- 										<option value="50">포털ID</option> -->
<!-- 										<option value="50">휴대폰번호</option> -->
<!-- 										<option value="50">회원명</option> -->
<!-- 									</select> -->
<%-- 								    <input type="hidden" id="page" name="page" value="${page}"> --%>
<!-- 								    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요."> -->
<!-- 								    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();"> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="wid-5"> -->
<!-- 							<div class="table table-input"> -->
<!-- 								<div> -->
<!-- 									<div class="cal-row table cal-row_auto"> -->
<!-- 										<div class="cal-input cal-input02"> -->
<!-- 											<input type="text" class="date-i"> -->
<!-- 											<i class="material-icons">event_available</i> -->
<!-- 										</div> -->
<!-- 										<div class="cal-dash">-</div> -->
<!-- 										<div class="cal-input cal-input02"> -->
<!-- 											<input type="text" class="date-i"> -->
<!-- 											<i class="material-icons">event_available</i> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<div class="top-row"> -->
<!-- 						<div class=""> -->
<!-- 							<div class="table table-auto"> -->
<!-- 								<div class="sear-tit">신청구분</div> -->
<!-- 								<div> -->
<!-- 									<select de-data="선택"> -->
<!-- 										<option>MOBILE</option> -->
<!-- 										<option>DESK</option> -->
<!-- 										<option>WEB</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="mag-lr2"> -->
<!-- 							<div class="table table-auto"> -->
<!-- 								<div class="sear-tit">회원구분</div> -->
<!-- 								<div> -->
<!-- 									<select de-data="선택"> -->
<!-- 										<option>전체</option> -->
<!-- 										<option>신규</option> -->
<!-- 										<option>기존</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class=""> -->
<!-- 							<div class="table table-auto"> -->
<!-- 								<div class="sear-tit sear-tit_70">상태</div> -->
<!-- 								<div> -->
<!-- 									<select id="regis_cancel_fg" de-data="선택"> -->
<!-- 										<option value="1">등록</option> -->
<!-- 										<option value="2">취소</option> -->
<!-- 										<option value="3">대기</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 					<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();"> -->
<!-- 				</div> -->
				<div class="table-wr ip-list">
					<div class="table-cap table">
						<div class="cap-l">
							<p class="cap-numb1"></p>
						</div>
					</div>
<!-- 					<div class="table-cap table"> -->
<!-- 						<div class="cap-l"> -->
<!-- 							<p class="cap-numb"></p> -->
<!-- 						</div> -->
<!-- 						<div class="cap-r text-right"> -->
							
<!-- 							<div class="table table02 table-auto float-right"> -->
<!-- 								<div> -->
<!-- 									<p class="ip-ritit">선택한 항목을</p> -->
<!-- 								</div> -->
<!-- 								<div> -->
<!-- 									<a class="bor-btn btn01 btn-mar6" href="#"><i class="material-icons">settings_phone</i></a> -->
<!-- 									<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a> -->
<!-- 									<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기"> -->
<!-- 										<option value="10">10개 보기</option> -->
<!-- 										<option value="20">20개 보기</option> -->
<!-- 										<option value="50">50개 보기</option> -->
<!-- 										<option value="100">100개 보기</option> -->
<!-- 										<option value="300">300개 보기</option> -->
<!-- 										<option value="500">500개 보기</option> -->
<!-- 										<option value="1000">1000개 보기</option> -->
<!-- 									</select> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
					<div class="table-list table-list-no">
						<table>
							<thead>
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
									</th>
									<th onclick="reSortAjax('sort_cust_no')">멤버스번호<img src="/img/th_up.png" id="sort_cust_no"></th>
									<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th>
									<th onclick="reSortAjax('sort_kor_nm')">회원병<img src="/img/th_up.png" id="sort_kor_nm"></th>
									<th onclick="reSortAjax('sort_sex_fg')">성별<img src="/img/th_up.png" id="sort_sex_fg"></th>
									<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
									<th onclick="reSortAjax('sort_accept_type')">신청구분<img src="/img/th_up.png" id="sort_accept_type"></th>
									<th onclick="reSortAjax('sort_card_amt')">결제수단<img src="/img/th_up.png" id="sort_card_amt"></th>
									<th onclick="reSortAjax('sort_sale_ymd')">결제일<img src="/img/th_up.png" id="sort_sale_ymd"></th>
									<th onclick="reSortAjax('sort_is_cust_new')">회원구분<img src="/img/th_up.png" id="sort_is_cust_new"></th>
									<th onclick="reSortAjax('sort_is_lect_new')">수강구분<img src="/img/th_up.png" id="sort_is_lect_new"></th>
									<th onclick="reSortAjax('sort_regis_cancel_fg')">상태<img src="/img/th_up.png" id="sort_regis_cancel_fg"></th>
								</tr>
							</thead>
							<tbody id="list_target">
<!-- 								<tr> -->
<!-- 									<td class="td-chk"> -->
<%-- 										<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 									</td> -->
<!-- 									<td>1</td> -->
<!-- 									<td>12345689</td> -->
<!-- 									<td>musign</td> -->
<!-- 									<td class="color-blue line-blue" onclick="location.href='/member/cust/list_mem'" style="cursor:pointer;">김태연</td> -->
<!-- 									<td>F</td> -->
<!-- 									<td>1984-01-18</td> -->
<!-- 									<td>WEB</td> -->
<!-- 									<td>신용카드</td> -->
<!-- 									<td>2019-09-02</td> -->
<!-- 									<td>신규</td> -->
<!-- 									<td>신규</td> -->
<!-- 									<td class="color-blue line-blue">대기</td> -->
<!-- 								</tr> -->
<!-- 								<tr class="cancel-row"> -->
<!-- 									<td class="td-chk"> -->
<%-- 										<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 									</td> -->
<!-- 									<td>1</td> -->
<!-- 									<td>12345689</td> -->
<!-- 									<td>musign</td> -->
<!-- 									<td class="color-blue line-blue">김태연</td> -->
<!-- 									<td>F</td> -->
<!-- 									<td>1984-01-18</td> -->
<!-- 									<td>WEB</td> -->
<!-- 									<td>신용카드</td> -->
<!-- 									<td>2019-09-02</td> -->
<!-- 									<td>신규</td> -->
<!-- 									<td>신규</td> -->
<!-- 									<td>취소</td> -->
<!-- 								</tr> -->
							</tbody>
						</table>
					</div>
					<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
				</div>
			</div>
		<div class="">
			<div class="white-bg plan-wrap">
											<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">썸네일 이미지</div>
												<div>
													<div class="filebox"> 
<!-- 														<label for="thumbnail"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
<!-- 														<input type="file" id="thumbnail" name="thumbnail">  -->
														
														<input class="upload-name" value="이미지를 첨부해주세요.">
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="top-row">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">상세 이미지</div>
												<div>
													<div class="filebox"> 
<!-- 														<label for="detail"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
<!-- 														<input type="file" id="detail" name="detail">  -->
														
														<input class="upload-name02" value="이미지를 첨부해주세요.">
													</div>
												</div>
											</div>
										</div>
									</div>
	</div> <br>
	<div class="plan-top">
		<div class="top-row table-input">
			<div class="wid-33">
				<div class="table table-90">
					<div class="sear-tit">강사명</div>
					<div>
						<input type="text" id="lecturer_nm" name="lecturer_nm" placeholder="" class="inputDisabled notEmpty" data-name="강사명" value="${plan_list[0].LECTURER_NM}" readOnly>
					</div>
				</div>
			</div>
		</div>
		<div class="plan-wrr plan-wrrt bg-blue">
			대표약력
		</div>
		<div class="plan-pad">
			<textarea id="lecturer_career" name="lecturer_career" style="height: 200px; margin-top: 15px;"  class="inputDisabled" readOnly>${plan_list[0].LECTURER_CAREER}</textarea>
		</div>
		<div class="plan-wrr plan-wrrt bg-blue" style="margin-top:15px;">
			강의 개요
		</div>
		<div class="plan-pad">
			<textarea id="lecture_content" name="lecture_content" style="height: 200px; margin-top: 15px;"  class="inputDisabled" readOnly>${plan_list[0].LECTURE_CONTENT}</textarea>
		</div>
		
	</div>
	
	
	<div class="white-bg plan-wrap">
		<h3 class="h3-tit">커리큘럼
			<div class="float-right">
			</div>
		</h3>
		
		<div class="table-wr">
			<div class="table-list table-list02 table-plan">
				<table>
					<colgroup>
						<col width="10%" />
						<col width="80%" />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>회차</th>
							<th>내용</th>
						</tr>
					</thead>
					<tbody id="target_contents">
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>	
			<div class="">
				<div class="table-top table-top02">
					<div class="top-row sear-wr">
						<div class="wid-3">
							<div class="table table02 table-input wid-contop">
								<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
							</div>
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
						<div class="wid-1">
							<div class="table table-input">
								<div><input class="search-btn03 btn btn02" type="button" value="선택완료" onclick="javascript:pagingReset(); getAttend();"></div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="table-wr ip-list">
					<div class="table-cap table">
						<div class="cap-l">
							<p class="cap-numb2"></p>
						</div>
					</div>
					<div class="table-wr ip-list attend-table">
						<div class="thead-box" id="list_head_target_head">
							
						</div>
						<div class="table-list">
							<table id="excelTable">
								<colgroup id="list_colgroup">
								
								</colgroup>
								<thead id="list_head_target">
									<!-- 
									<tr>
										<th class="td-chk">
											<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
										</th>
										
										<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th> 
										<th onclick="reSortAjax('sort_ptl_id')">포털ID <img src="/img/th_up.png" id="sort_ptl_id"></th> 
										<th onclick="reSortAjax('sort_phone_no')">전화번호 <img src="/img/th_up.png" id="sort_phone_no"></th> 
										<th onclick="reSortAjax('sort_sex_fg')">성별 <img src="/img/th_up.png" id="sort_sex_fg"></th> 
										<th onclick="reSortAjax('sort_cust_date')">가입일<img src="/img/th_up.png" id="sort_cust_date"></th> 
										<th onclick="reSortAjax('sort_cust_fg')">수강형태 <img src="/img/th_up.png" id="sort_cust_fg"></th>
					
										<th class="chk-date"><c:if test="${DAY1 ne 'X'}" >${fn:substring(DAY1,4,6)}/${fn:substring(DAY1,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY2 ne 'X'}" >${fn:substring(DAY2,4,6)}/${fn:substring(DAY2,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY3 ne 'X'}" >${fn:substring(DAY3,4,6)}/${fn:substring(DAY3,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY4 ne 'X'}" >${fn:substring(DAY4,4,6)}/${fn:substring(DAY4,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY5 ne 'X'}" >${fn:substring(DAY5,4,6)}/${fn:substring(DAY5,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY6 ne 'X'}" >${fn:substring(DAY6,4,6)}/${fn:substring(DAY6,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY7 ne 'X'}" >${fn:substring(DAY7,4,6)}/${fn:substring(DAY7,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY8 ne 'X'}" >${fn:substring(DAY8,4,6)}/${fn:substring(DAY8,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY9 ne 'X'}" >${fn:substring(DAY9,4,6)}/${fn:substring(DAY9,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY10 ne 'X'}" >${fn:substring(DAY10,4,6)}/${fn:substring(DAY10,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY11 ne 'X'}" >${fn:substring(DAY11,4,6)}/${fn:substring(DAY11,6,8)}</c:if></th>
										<th class="chk-date"><c:if test="${DAY12 ne 'X'}" >${fn:substring(DAY12,4,6)}/${fn:substring(DAY12,6,8)}</c:if></th>
										<th>비고</th>
									</tr>
									 -->
								</thead>
								<tbody id="list_attend">
									
								</tbody>
							</table>
						</div>
					</div>

				</div>
			
			</div>
		</div>
		
		
		
		
	</div> <!-- // tab-wrap -->
</div> <!-- // table-wr -->


<div id="give_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#give_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="give-wrap">
					<h3 class="text-center">전점 등록 강사 조회</h3>
					<div class="table btn-wr">
<!-- 						<div class="wid-3"> -->
<!-- 							<ul class="chk-ul"> -->
<!-- 								<li> -->
<!-- 									<input type="radio" id="rad-c" name="rad-1" checked/> -->
<!-- 									<label for="rad-c">기존</label> -->
<!-- 								</li> -->
<!-- 								<li> -->
<!-- 									<input type="radio" id="rad-c" name="rad-2"/> -->
<!-- 									<label for="rad-c">신규</label> -->
<!-- 								</li> -->
<!-- 							</ul>							 -->
<!-- 						</div> -->
						<div>
							<div class="table table-input table02">
								<div class="wid-3"><input type="text" id="lecr_name" name="lecr_name" placeholder="강사명" onkeypress="excuteEnter(getLecrList)"></div>
								<div class="wid-tec">
									<input type="text" id="lecr_phone" name="lecr_phone" placeholder="휴대폰 뒷번호 네자리" onkeypress="excuteEnter(getLecrList)">
								</div>
								<div>
									<a class="btn btn03 text-center" href="#" onclick="getLecrList()">검색</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="table-wr">
						<div class="table-cap table">
							<div class="table-list table-list02">
								<table>
									<thead>
										<tr>
											<th class="td-chk">
												<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
											</th>
											<th>NO.</th>
											<th>구분<i class="material-icons">import_export</i></th> 
											<th>사업자명<i class="material-icons">import_export</i></th> <!--볍인일경우에만 노출 --> 
											<th>멤버스번호<i class="material-icons">import_export</i></th> 
											<th>포털ID<i class="material-icons">import_export</i></th> 
											<th>생년월일<i class="material-icons">import_export</i></th> 
											<th>강사명<i class="material-icons">import_export</i></th> 
											<th>핸드폰번호<i class="material-icons">import_export</i></th> 
										</tr>
									</thead>
									<tbody id="lecr_area">
									
									</tbody>
								</table>
							</div>
							
						</div>
					</div>
					
					
					<div class="btn-wr text-center">
						<!-- <a class="btn btn02 ok-btn" onclick="javascript:fncSubmitPos();">선택완료</a> -->
<!-- 						<a class="btn btn02 ok-btn" onclick="choose_lecr();">선택완료</a> -->
					</div>
					
				</div>
        	</div>
        </div>
    </div>	
</div>


















<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>