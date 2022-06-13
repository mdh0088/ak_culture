<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

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

var initPage = "";

$(document).ready(function() {
	initPage = $("#initPage").html();
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
	selWebPeri();
});
function selPeri()
{
	if($(".selPeri").html().indexOf("검색된") > -1)
	{
		alert("기수 정보가 없습니다.");
		$(".hidden_area").hide();
		$(".no-data").show();
	}
	else
	{
		$("#fncForm").attr("action", "./modify_proc");
		console.log($("#selPeri").val());
		$.ajax({
			type : "POST", 
			url : "./getPeriOne",
			dataType : "text",
			async : false,
			data : 
			{
				selPeri : $("#selPeri").val(),
				selBranch : $("#selBranch").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				$(".peri-list").show();
				$(".no-data").hide();
				var result = JSON.parse(data);
				
				$("#period").val(result.PERIOD);
				$("#start_ymd").val(cutDate(result.START_YMD));
				$("#end_ymd").val(cutDate(result.END_YMD));
				$("#web_open_ymd").val(cutDate(result.WEB_OPEN_YMD));
				$("#adult_s_bgn_ymd").val(cutDate(result.ADULT_S_BGN_YMD));
				$("#adult_f_bgn_ymd").val(cutDate(result.ADULT_F_BGN_YMD));
				$("#tech_1_ymd").val(cutDate(result.TECH_1_YMD));
				$("#tech_2_ymd").val(cutDate(result.TECH_2_YMD));
				$("#tech_3_ymd").val(cutDate(result.TECH_3_YMD));
				$("#mate_1_ymd").val(cutDate(result.MATE_1_YMD));
				$("#mate_2_ymd").val(cutDate(result.MATE_2_YMD));
				$("#mate_3_ymd").val(cutDate(result.MATE_3_YMD));
				$("#tech_1_status").val(result.TECH_1_S);
				$("#tech_2_status").val(result.TECH_2_S);
				$("#tech_3_status").val(result.TECH_3_S);
				$("#mate_1_status").val(result.MATE_1_S);
				$("#mate_2_status").val(result.MATE_2_S);
				$("#mate_3_status").val(result.MATE_3_S);
				$("#lect_hour1").val(result.TIME.substring(0,2));
				$("#lect_hour2").val(result.TIME.substring(2,4));
				
				if(result.IS_CANCEL == "N")
				{
					$("#is_cancel").removeClass("btn03");
					$("#is_cancel").addClass("btn04");
					$("#is_cancel").html("N");
					$("#is_cancel_status").val("N");
				}
				else
				{
					$("#is_cancel").removeClass("btn04");
					$("#is_cancel").addClass("btn03");
					$("#is_cancel").html("Y");
					$("#is_cancel_status").val("Y");
				}
				
				if(result.TECH_1_S == "Y")
				{
					$("#tech_1").removeClass("btn04");
					$("#tech_1").addClass("btn03");
					$("#tech_1").html("사용");
				}
				else if(result.TECH_1_S == "N")
				{
					$("#tech_1").removeClass("btn03");
					$("#tech_1").addClass("btn04");
					$("#tech_1").html("미사용");
				}
				if(result.TECH_2_S == "Y")
				{
					$("#tech_2").removeClass("btn04");
					$("#tech_2").addClass("btn03");
					$("#tech_2").html("사용");
				}
				else if(result.TECH_2_S == "N")
				{
					$("#tech_2").removeClass("btn03");
					$("#tech_2").addClass("btn04");
					$("#tech_2").html("미사용");
				}
				if(result.TECH_3_S == "Y")
				{
					$("#tech_3").removeClass("btn04");
					$("#tech_3").addClass("btn03");
					$("#tech_3").html("사용");
				}
				else if(result.TECH_3_S == "N")
				{
					$("#tech_3").removeClass("btn03");
					$("#tech_3").addClass("btn04");
					$("#tech_3").html("미사용");
				}
				if(result.MATE_1_S == "Y")
				{
					$("#mate_1").removeClass("btn04");
					$("#mate_1").addClass("btn03");
					$("#mate_1").html("사용");
				}
				else if(result.MATE_1_S == "N")
				{
					$("#mate_1").removeClass("btn03");
					$("#mate_1").addClass("btn04");
					$("#mate_1").html("미사용");
				}
				if(result.MATE_2_S == "Y")
				{
					$("#mate_2").removeClass("btn04");
					$("#mate_2").addClass("btn03");
					$("#mate_2").html("사용");
				}
				else if(result.MATE_2_S == "N")
				{
					$("#mate_2").removeClass("btn03");
					$("#mate_2").addClass("btn04");
					$("#mate_2").html("미사용");
				}
				if(result.MATE_3_S == "Y")
				{
					$("#mate_3").removeClass("btn04");
					$("#mate_3").addClass("btn03");
					$("#mate_3").html("사용");
				}
				else if(result.MATE_3_S == "N")
				{
					$("#mate_3").removeClass("btn03");
					$("#mate_3").addClass("btn04");
					$("#mate_3").html("미사용");
				}
				
				
				if(result.CANCLED_LIST != null && result.CANCLED_LIST != '')
				{
					//초기화
					closed_cnt = 2;
					var inner = "";
					inner += '<div class="cal-input">';
					inner += '	<input type="text" data-name="휴강일" class="date-i hasDatepicker holiday" id="closed1" name="closed" onchange="selDate(1)">';
					inner += '	<i class="material-icons">event_available</i>';
					inner += '</div>';
					inner += '<div class="cal-btn btn-inline">';
					inner += '	<input type="text" class="date-day inputDisabled" value="" id="weekday1">';
					inner += '</div>';
					inner += '<div class="cal-btn btn-inline">';
					inner += '	<i class="material-icons add" onclick="add_closed()">add_circle_outline</i>';
					inner += '</div>';
					$("#target_closed").html(inner);
					
					var closed_arr = result.CANCLED_LIST.split("|");
					for(var i = 0; i < closed_arr.length-1; i++)
					{
						if(i != 0)
						{
							add_closed();
						}
						$("#closed"+(i+1)).val(cutDate(closed_arr[i]));
						selDate(i+1);
					}
				}
			}
		});	
	}
}
function changeCancel()
{
	if($("#is_cancel").hasClass("btn03"))
	{
		$("#is_cancel").removeClass("btn03");
		$("#is_cancel").addClass("btn04");
		$("#is_cancel").html("N");
		$("#is_cancel_status").val("N");
	}
	else if($("#is_cancel").hasClass("btn04"))
	{
		$("#is_cancel").removeClass("btn04");
		$("#is_cancel").addClass("btn03");
		$("#is_cancel").html("Y");
		$("#is_cancel_status").val("Y");
	}
}
function addCode()
{
	if($(".selPeri").html().indexOf("검색된") == -1)
	{
		alert("이미 기수가 등록되어있습니다.");
		return;
	}
	
	
	$("#fncForm").attr("action", "./write_proc");
	$(".peri-list").show();
	$(".no-data").hide();
	$.ajax({
		type : "POST", 
		url : "./getLastPeri",
		dataType : "text",
		async : false,
		data : 
		{
			selBranch : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if(result.length > 0)
			{
				var val = (Number(result[0].PERIOD)+1).toString();
				if(val.length == 1)
				{
					val = "00"+val;
				}
				if(val.length == 2)
				{
					val = "0"+val;
				}
				$("#period").val(val);
			}
			else
			{
				$("#period").val("001");
			}
		}
	});	
	cancled_init();
// 	$("#start_ymd").val('');
// 	$("#end_ymd").val('');
	$("#web_open_ymd").val('');
	$("#adult_s_bgn_ymd").val('');
	$("#adult_f_bgn_ymd").val('');
	$("#tech_1_ymd").val('');
	$("#tech_2_ymd").val('');
	$("#tech_3_ymd").val('');
	$("#mate_1_ymd").val('');
	$("#mate_2_ymd").val('');
	$("#mate_3_ymd").val('');
	setDate();
}


function cancled_init()
{
	closed_cnt = 2;
	var closed_arr = document.getElementsByName("closed");
	var c_idx = "";
	for(var i = 0; i < closed_arr.length; i++)
	{
		c_idx += closed_arr[i].id.replace("closed","")+"|";
	}
	
	var c_idx_arr = c_idx.split("|");
	for(var i = 0; i < c_idx_arr.length-1; i++)
	{
		if(c_idx_arr[i] == 1)
		{
			document.getElementById("closed"+c_idx_arr[i]).value = "";
			document.getElementById("weekday"+c_idx_arr[i]).value = "";
		}
		else
		{
			remove_closed(c_idx_arr[i]);
		}
	}	
}
function cancleDate()
{
	if($("#initPage").css("display") == "none")
	{
		alert("기수를 선택해주세요.");
	}
	else
	{
		$('#cancle_layer').fadeIn(200);	
	}
}
var closed_cnt = 2;
function add_closed()
{
	var inner = "";
	inner += '<div class="cal-row" id="closed_div_'+closed_cnt+'" style="margin-top:10px;">';
	inner += '	<div class="cal-input">';
	inner += '		<input type="text" data-name="휴강일" class="date-i holiday" id="closed'+closed_cnt+'" name="closed" onchange="selDate('+closed_cnt+')"/>';
	inner += '		<i class="material-icons">event_available</i>';
	inner += '	</div>';
	inner += '	<div class="cal-btn btn-inline">';
	inner += '		<input type="text" class="date-day inputDisabled" value="" id="weekday'+closed_cnt+'"/>';
	inner += '	</div>';
	inner += '	<div class="cal-btn btn-inline">';
	inner += '		<i class="material-icons remove" onclick="remove_closed('+closed_cnt+')">remove_circle_outline</i>';
	inner += '	</div>';
	inner += '</div>';
	$("#target_closed").append(inner);
	closed_cnt ++;
	
	// 	dateInit();
	//다른 날짜들에 영향안주기위해 얘는 함수안쓰고 따로돌림.
	$(".date-i").removeClass("hasDatepicker");
	$(".date-i").each(function(){
		var $this = dp(this);
		$this.datepicker()
	});
}
function remove_closed(idx)
{
	$("#closed_div_"+idx).remove();
}
function selDate(idx)
{
	var dd = $("#closed"+idx).val();
	var weekday = getInputDayLabel(dd);
	$("#weekday"+idx).val(weekday);
}
function changeStatus(cate, idx)
{
	if($("#"+cate+"_"+idx).hasClass("btn03"))
	{
		$("#"+cate+"_"+idx).removeClass("btn03");
		$("#"+cate+"_"+idx).addClass("btn04");
		$("#"+cate+"_"+idx).html("미사용");
		$("#"+cate+"_"+idx+"_status").val("N");
	}
	else if($("#"+cate+"_"+idx).hasClass("btn04"))
	{
		$("#"+cate+"_"+idx).removeClass("btn04");
		$("#"+cate+"_"+idx).addClass("btn03");
		$("#"+cate+"_"+idx).html("사용");
		$("#"+cate+"_"+idx+"_status").val("Y");
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
		var cl = "";
		$("[name='closed']").each(function() 
		{
			if($(this).val() != "")
			{
				cl += $(this).val()+"|";
			}
		});
		$("#cancled_list").val(cl);
		
		var start_ymd= $('#start_ymd').val().replace(/-/gi,"");
		var end_ymd= $('#end_ymd').val().replace(/-/gi,"");
		
		var web_open_ymd = $('#web_open_ymd').val().replace(/-/gi,"");
		var adult_s_bgn_ymd = $('#adult_s_bgn_ymd').val().replace(/-/gi,"");
		var adult_f_bgn_ymd = $('#adult_f_bgn_ymd').val().replace(/-/gi,"");
		
		if (start_ymd > end_ymd) {
			alert("진행기간을 확인해주세요.");
			$("#start_ymd").focus();
			return;
		}else if(web_open_ymd > start_ymd || web_open_ymd > end_ymd){
			alert("온라인 오픈일을 확인해주세요.");
			$('#web_open_ymd').focus();
			return;
		}else if((adult_s_bgn_ymd > start_ymd || adult_s_bgn_ymd > end_ymd) && adult_s_bgn_ymd != ""){
			alert("기존 접수일을 확인해주세요.");
			$('#adult_s_bgn_ymd').focus();
			return;
		}else if((adult_f_bgn_ymd > start_ymd || adult_f_bgn_ymd > end_ymd) && adult_f_bgn_ymd != ""){
			alert("신규 접수일을 확인해주세요.");
			$('#adult_f_bgn_ymd').focus();
			return;
		}
		if(adult_f_bgn_ymd == "" && adult_s_bgn_ymd == "")
		{
			alert("기존 접수일과 신규 접수일중에 한가지는 입력해야합니다.");
			$('#adult_s_bgn_ymd').focus();
			return;
		}
		
		
		var tech1_arr = $("#tech_1_ymd").val().split("-");
		var tech2_arr = $("#tech_2_ymd").val().split("-");
		var tech3_arr = $("#tech_3_ymd").val().split("-");
		var mate1_arr = $("#mate_1_ymd").val().split("-");
		var mate2_arr = $("#mate_2_ymd").val().split("-");
		var mate3_arr = $("#mate_3_ymd").val().split("-");
		
		if(Number(tech1_arr[1]) > 12 || Number(tech2_arr[1]) > 12 || Number(tech3_arr[1]) > 12 
				|| Number(tech1_arr[2]) > 31 || Number(tech2_arr[2]) > 31 || Number(tech3_arr[2]) > 31 )
			{
				alert("강사료 일정을 확인해주세요.");
				return;
			}
		if(Number(mate1_arr[1]) > 12 || Number(mate2_arr[1]) > 12 || Number(mate3_arr[1]) > 12 
				|| Number(mate1_arr[2]) > 31 || Number(mate2_arr[2]) > 31 || Number(mate3_arr[2]) > 31 )
			{
				alert("재료비 일정을 확인해주세요.");
				return;
			}
		
		
		
		
		
		
		
		var holiday_ymd="";
		var holiday_flag=0;
		$(".holiday").each(function(){
			holiday_ymd = $(this).val().replace(/-/gi,"");
			if (holiday_ymd < start_ymd || holiday_ymd > end_ymd) {
// 				alert("휴강일을 확인해주세요.");
// 				holiday_flag=1;
// 				$(this).focus();
// 				return false;
			}
		});
		
		if (holiday_flag==1) {
			return;
		}
		else
		{
			$("#fncForm").ajaxSubmit({
				success: function(data)
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
	}
}
function setDateReady()
{
	if($("#start_ymd").val() != "" && $("#end_ymd").val() != "")
	{
		var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
		var end_ymd = $("#end_ymd").val().replace(/-/gi, "");
		console.log(start_ymd.length);
		console.log(end_ymd.length);
		if(start_ymd.length == 8 && end_ymd.length == 8)
		{
			setDate();
		}
	}
}
function setDate()
{
	if($("#start_ymd").val() != "" && $("#end_ymd").val() != "")
	{
		var start_ymd = $("#start_ymd").val().replace(/-/gi, "");
		var end_ymd = $("#end_ymd").val().replace(/-/gi, "");
		console.log(start_ymd.length);
		console.log(end_ymd.length);
		if(start_ymd.length == 8 && end_ymd.length == 8)
		{
			var y = start_ymd.substring(0,4);
			var m = start_ymd.substring(4,6);
			//마지막일로 셋팅이었으나 2021-07-19 혜민대리님 요청으로 정기영 수정
// 			$("#tech_1_ymd").val(y + "-" + m + "-"+getLastDay(y, m));
// 			m = Number(m) + 1;
// 			if(m.toString().length == 1){ m = "0" + m.toString();}
// 			if(Number(m) > 12) {y = Number(y) + 1; m = '01';}
// 			$("#tech_2_ymd").val(y + "-" + m + "-"+getLastDay(y, m));
// 			m = Number(m) + 1;
// 			if(m.toString().length == 1){ m = "0" + m.toString();}
// 			if(Number(m) > 12) {y = Number(y) + 1; m = '01';}
// 			$("#tech_3_ymd").val(y + "-" + m + "-"+getLastDay(y, m));

			$("#tech_1_ymd").val(y + "-" + m + "-20");
			m = Number(m) + 1;
			if(m.toString().length == 1){ m = "0" + m.toString();}
			if(Number(m) > 12) {y = Number(y) + 1; m = '01';}
			$("#tech_2_ymd").val(y + "-" + m + "-20");
			m = Number(m) + 1;
			if(m.toString().length == 1){ m = "0" + m.toString();}
			if(Number(m) > 12) {y = Number(y) + 1; m = '01';}
			$("#tech_3_ymd").val(y + "-" + m + "-20");
			
// 			var y = end_ymd.substring(0,4);
// 			var m = end_ymd.substring(4,6);
			var y = start_ymd.substring(0,4);
			var m = start_ymd.substring(4,6);
			$("#mate_1_ymd").val(y + "-" + m + "-25");
			m = Number(m) + 1;
			if(m.toString().length == 1){ m = "0" + m.toString();}
			if(Number(m) > 12) {y = Number(y) + 1; m = '01';}
			$("#mate_2_ymd").val(y + "-" + m + "-25");
			m = Number(m) + 1;
			if(m.toString().length == 1){ m = "0" + m.toString();}
			if(Number(m) > 12) {y = Number(y) + 1; m = '01';}
			$("#mate_3_ymd").val(y + "-" + m + "-25");
			
			$.ajax({
				type : "POST", 
				url : "/common/getHoliday_byDate",
				dataType : "json",
				data : 
				{
					s_date : $("#start_ymd").val(),
					e_date : $("#end_ymd").val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					cancled_init();
					for(var i = 0; i < data.length; i++)
					{
						if(i > 0) //하나는 만들어져있으니께 
						{
							add_closed();
						}
						$("#closed"+(i+1)).val(cutDate(data[i]));
						selDate((i+1));//요일 설정
					}
				}
			});
		}
	}
}

function periInit()
{
	$("#initPage").html("");
	$("#initPage").append(initPage);
	$("#initPage").hide();
	closed_cnt = 2;
	dateInit();
	
	$(".peri-ul").children("li").removeClass("active");
	$("#sect-ul").hide();
}
function sel1dep(idx)
{
	$("input:checkbox[name='chk_all']").prop("checked", false);
	$(".peri-ul").children("li").removeClass("active");
	$("#li_"+idx).addClass("active");
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		async : false,
		data : 
		{
			maincd : idx,
			selBranch : $("#selBranch").val()
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
			for(var i = 0; i < result.length; i++)
			{
				inner += '<li><div class="td-chk"><input type="checkbox" id="chk_'+trim(result[i].MAIN_CD)+'_'+result[i].SECT_CD+'" name="chk_val" value=""><label for="chk_'+trim(result[i].MAIN_CD)+'_'+result[i].SECT_CD+'"></label></div>'+result[i].SECT_NM;
				inner += '	<div class="peri-ulsel sel-arr sel-scr sel_'+trim(result[i].MAIN_CD)+'_'+result[i].SECT_CD+'">';
				inner += '		<select de-data="1일 전" id="sel_'+trim(result[i].MAIN_CD)+'_'+result[i].SECT_CD+'">';
				inner += '		<option value="1">1일 전</option>';
				inner += '		<option value="2">2일 전</option>';
				inner += '		<option value="3">3일 전</option>';
				inner += '		<option value="4">4일 전</option>';
				inner += '		<option value="5">5일 전</option>';
				inner += '		<option value="6">6일 전</option>';
				inner += '		<option value="7">7일 전</option>';
				inner += '	</select> ';
				inner += '	</div>';
				inner += '</li>';
			}
			$("#sect-ul").html(inner);
			$("#sect-ul").show();
			$.ajax({
				type : "POST", 
				url : "./getCancled",
				dataType : "text",
				async : false,
				data : 
				{
					selPeri : $("#selPeri").val(),
					selStore : $("#selBranch").val(),
					selMainCd : idx
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
						if(result[i].MAIN_CD == "0" && result[i].SECT_CD == "0")
						{
							
						}
						else
						{
							$("#sel_"+result[i].MAIN_CD+"_"+result[i].SECT_CD).val(result[i].CANCLED);
						}
					}
				}
			});	
		}
	});	
}
function changeTotal()
{
	var chkArr = document.getElementsByName("chk_val");
	var total_val = $("#sel_total").val();
	if(total_val != "")
	{
		for(var i = 0; i < chkArr.length; i++)
		{
			if(chkArr[i].checked == true)
			{
				$("#"+chkArr[i].id.replace("chk","sel")).val(total_val);
			}
		}
	}
	
}
function fncSubmitCancle()
{
	if(!isLoading)
	{
		var chkArr = document.getElementsByName("chk_val");
		var chkList = "";
		var selList = "";
		for(var i = 0; i < chkArr.length; i++)
		{
			if(chkArr[i].checked == true)
			{
				chkList += chkArr[i].id+"|";
				selList += $("#"+chkArr[i].id.replace("chk","sel")).val()+"|";
			}
		}
		if(chkList == "")
		{
			alert("선택된 항목이 없습니다.");
			return;
		}
		getListStart();
		$("#selList").val(selList);
		$("#chkList").val(chkList);
		$("#canPeriod").val($("#selPeri").val());
		$("#canStore").val($("#selBranch").val());
		
		
		
		$("#cancleForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	//     			location.reload();
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
function selWebPeri()
{
	$.ajax({
		type : "POST", 
		url : "./getLastPeri",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#web_store").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$(".web_period_ul").html("");
			$("#web_period").html("");
			for(var i = 0; i < result.length; i++)
	 		{
				if(i == 0) 
				{
					$(".web_period").html(result[i].PERIOD+"기");
				}
				$(".web_period_ul").append('<li>'+result[i].PERIOD+'기</li>');
				$("#web_period").append('<option value="'+result[i].PERIOD+'">'+result[i].PERIOD+'기</option>');
			}
			
			
		}
	});	
}
function getWebPeri()
{
	$.ajax({
		type : "POST", 
		url : "./getWebPeri",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#web_store").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			$("#web_period").val(data);
			$(".web_period").html(data+"기");
		}
	});	
}
function setWebPeri()
{
	$.ajax({
		type : "POST", 
		url : "./setWebPeri",
		dataType : "text",
		async:false,
		data : 
		{
			store : $("#web_store").val(),
			period : $("#web_period").val()
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
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});	
}
function setSchedule_all(val)
{
	if(confirm("변경된 공휴일은 저장 후 실행하셔야 적용됩니다.\n10분이상 소요될 수 있습니다.\n그래도 진행하시겠습니까?"))
	{
		$.ajax({
			type : "POST", 
			url : "/lecture/lect/setSchedule_all",
			dataType : "text",
			async : false,
			data : 
			{
				store : $("#selBranch").val(),
				period : $("#selPeri").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log("zzz"+data);
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
}
</script>
<div class="sub-tit">
	<h2>기수관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<div>
<!-- 			<A class="btn btn01 icon-r btn01_1" onclick="javascript:$('#web_layer').fadeIn(200);">Web 노출기수</A> -->
			<A class="btn btn01 icon-r btn01_1" onclick="javascript:cancleDate()">취소일 관리<i class="material-icons">event_available</i></A>
			<A class="btn btn01 btn01_1" onclick="javascript:addCode()"><i class="material-icons">add</i>신규 등록</A>
		</div>		
	</div>
</div>
<form id="fncForm" name="fncForm" method="POST">
	<div class="table-top view-top">
		<div class="top-row sear-wr">
			<div class="wid-10">
				<div class="table table-auto">
					<div>
						<div class="table table02 table-100 wid-contop">
							<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
						</div>
					</div>
					<div>
						<div class="table table-auto">
							<div class="table-input sel-scr">
								<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
							</div>
							<a class="btn btn02 btn-inline" onclick="selPeri()">선택완료</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	<div class="row view-page peri-list" style="display:none;" id="initPage">
		<div class="wid-5">
			<div class="white-bg">
				<h3 class="h3-tit">기수일정관리</h3>
				<div class="bor-div">
					<div class="top-row">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit">선택한 기수</div>
								<div>
									<input type="text" data-name="기수" id="period" name="period" class="notEmpty inputDisabled" readOnly>
								</div>
							</div>
						</div>
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_120 sear-tit_left" style="width:130px !important;">부분 환불 (정상)</div>
								<div>
						   			<a onclick="javascript:changeCancel()" id="is_cancel" name="is_cancel" class="btn03 bor-btn btn-inline">Y</a>
						   			<input type="hidden" id="is_cancel_status" name="is_cancel_status">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bor-div">
					<div class="top-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">진행기간</div>
								<div>
									<div class="cal-row">
										<div class="cal-input">
											<input type="text" data-name="진행기간" class="date-i notEmpty start-i" id="start_ymd" name="start_ymd" onchange="setDate()" onkeypress="setDateReady()"/>
											<i class="material-icons">event_available</i>
										</div>
										<div class="cal-dash">-</div>
										<div class="cal-input">
											<input type="text" data-name="진행기간" class="date-i notEmpty ready-i" id="end_ymd" name="end_ymd" onchange="setDate()" onkeypress="setDateReady()"/>
											<i class="material-icons">event_available</i>
										</div>
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
								<div class="sear-tit sear-tit-top">공휴일</div>
								<div>
									<div class="cal-row" id="target_closed">
										<div class="cal-input">
											<input type="text" class="date-i" id="closed1" name="closed" onchange="selDate(1)"/>
											<i class="material-icons">event_available</i>
										</div>
										<div class="cal-btn btn-inline">
											<input type="text" class="date-day inputDisabled" value="" id="weekday1"/>
										</div>
										<div class="cal-btn btn-inline">
											<i class="material-icons add" onclick="add_closed()">add_circle_outline</i>
										</div>
									</div>
									<div style="margin-top:10px;">
										<div class="cal-row"><a class="btn btn02 mrg-l6" onclick="setSchedule_all();">강좌일정 일괄적용</a></div>
									</div>
	<!-- 								<div class="cal-row"> -->
	<!-- 									<div class="cal-input"> -->
	<!-- 										<input type="text" class="date-i" /> -->
	<!-- 										<i class="material-icons">event_available</i> -->
	<!-- 									</div> -->
	<!-- 									<div class="cal-btn btn-inline"> -->
	<!-- 										<input type="text" class="date-day" value="목요일" disabled="disabled" /> -->
											
	<!-- 									</div> -->
	<!-- 									<div class="cal-btn btn-inline"> -->
	<!-- 										<i class="material-icons remove">remove_circle_outline</i> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
	<!-- 								<div class="cal-row"> -->
	<!-- 									<div class="cal-input"> -->
	<!-- 										<input type="text" class="date-i" /> -->
	<!-- 										<i class="material-icons">event_available</i> -->
	<!-- 									</div> -->
	<!-- 									<div class="cal-btn btn-inline"> -->
	<!-- 										<input type="text" class="date-day" value="목요일" disabled="disabled" /> -->
											
	<!-- 									</div> -->
	<!-- 									<div class="cal-btn btn-inline"> -->
	<!-- 										<i class="material-icons remove">remove_circle_outline</i> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<div class="wid-5">
			<div class="white-bg">
				<h3 class="h3-tit">접수일정관리</h3>
				<div class="bor-div">
					<div class="top-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit sear-tit_120">온라인 오픈일</div>
								<div>
									<div class="cal-row">
										<div class="cal-input">
											<input type="text" data-name="온라인 오픈일" class="date-i" id="web_open_ymd" name="web_open_ymd"/>
											<i class="material-icons">event_available</i>
										</div>
										<div class="cal-dash cal-dash02"></div>
										<div class="cal-input">
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
														<input type="text" id="lect_hour1" name="lect_hour1" class="onlyNumber" maxlength="2" style="width:50px;padding-right:0px;">
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
														<input type="text" id="lect_hour2" name="lect_hour2" class="onlyNumber" maxlength="2" style="width:50px;padding-right:0px;">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="top-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit sear-tit_120">기존 접수일</div>
								<div>
									<div class="cal-row">
										<div class="cal-input">
											<input type="text" data-name="기존 접수일" class="date-i" id="adult_s_bgn_ymd" name="adult_s_bgn_ymd"/>
											<i class="material-icons">event_available</i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="top-row">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit sear-tit_120">신규 접수일</div>
								<div>
									<div class="cal-row">
										<div class="cal-input">
											<input type="text" data-name="신규 접수일" class="date-i" id="adult_f_bgn_ymd" name="adult_f_bgn_ymd"/>
											<i class="material-icons">event_available</i>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="bor-div bor-div02 row cal-wrap">
				 	<div class="wid-5">
				 		<p class="h3-stit">강사료 일정 관리</p>
				 		<div class="cal-row table">
				 			<div>
								1차
							</div>
							<div class="cal-input">
								<input type="text" class="date-i" id="tech_1_ymd" name="tech_1_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
							<div>
								<a onclick="javascript:changeStatus('tech', 1)" id="tech_1" name="tech_1" class="btn03 bor-btn btn-inline">사용</a>
								<input type="hidden" id="tech_1_status" name="tech_1_status" value="Y">
							</div>
						</div>
						<div class="cal-row table">
				 			<div>
								2차
							</div>
							<div class="cal-input">
								<input type="text" class="date-i" id="tech_2_ymd" name="tech_2_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
							<div>
								<a onclick="javascript:changeStatus('tech', 2)" id="tech_2" name="tech_2" class="btn03 bor-btn btn-inline">사용</a>
								<input type="hidden" id="tech_2_status" name="tech_2_status" value="Y">
							</div>
						</div>
						<div class="cal-row table">
				 			<div>
								3차
							</div>
							<div class="cal-input">
								<input type="text" class="date-i" id="tech_3_ymd" name="tech_3_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
							<div>
								<a onclick="javascript:changeStatus('tech', 3)" id="tech_3" name="tech_3" class="btn03 bor-btn btn-inline">사용</a>
								<input type="hidden" id="tech_3_status" name="tech_3_status" value="Y">
							</div>
						</div>
					</div>
					<div class="wid-5">
				 		<p class="h3-stit">재료비 일정 관리</p>
				 		<div class="cal-row table">
							<div class="cal-input">
								<input type="text" class="date-i" id="mate_1_ymd" name="mate_1_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
							<div>
								<a onclick="javascript:changeStatus('mate', 1)" id="mate_1" name="mate_1" class="btn03 bor-btn btn-inline">사용</a>
								<input type="hidden" id="mate_1_status" name="mate_1_status" value="Y">
							</div>
						</div>
						<div class="cal-row table">
							<div class="cal-input">
								<input type="text" class="date-i" id="mate_2_ymd" name="mate_2_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
							<div>
								<a onclick="javascript:changeStatus('mate', 2)" id="mate_2" name="mate_2" class="btn03 bor-btn btn-inline">사용</a>
								<input type="hidden" id="mate_2_status" name="mate_2_status" value="Y">
							</div>
						</div>
						<div class="cal-row table">
							<div class="cal-input">
								<input type="text" class="date-i" id="mate_3_ymd" name="mate_3_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
							<div>
								<a onclick="javascript:changeStatus('mate', 3)" id="mate_3" name="mate_3" class="btn03 bor-btn btn-inline">사용</a>
								<input type="hidden" id="mate_3_status" name="mate_3_status" value="Y">
							</div>
						</div>
				 	</div>				
				</div>			
			</div>		
		</div>
	</div>
	<div class="no-data">
		<div class="white-bg">
			지점을 선택하세요.
		</div>
	</div>
	<input type="hidden" id="cancled_list" name="cancled_list">
</form>
<div class="btn-wr text-center">
	<a class="btn btn01 ok-btn" onclick="pageReset()">초기화</a>
	<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();">수정/저장</a>
</div>

<div id="cancle_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg peri-edit">
        		<div class="close" onclick="javascript:$('#cancle_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div>
					<form id="cancleForm" name="cancleForm" action="./cancle_proc">
						<input type="hidden" id="chkList" name="chkList">
						<input type="hidden" id="selList" name="selList">
						<input type="hidden" id="canPeriod" name="canPeriod">
						<input type="hidden" id="canStore" name="canStore">
						<div class="top-row ">
							<h3>취소일 관리</h3>
							<div class="table-top bg01">
								<div class="top-row ">
									<div class="sear-tit">취소일 공통관리</div>
									<div class="sear-tit sear-tit02">강좌 시작일 기준</div>
									<div class="sel-scr sel-arr">
										<select de-data="선택" id="sel_total" name="sel_total" onchange="changeTotal()">
											<option value="">선택</option>
											<option value="1">1일 전</option>
											<option value="2">2일 전</option>
											<option value="3">3일 전</option>
											<option value="4">4일 전</option>
											<option value="5">5일 전</option>
											<option value="6">6일 전</option>
											<option value="7">7일 전</option>
										</select> 
									</div>
								</div>
							</div>
							<div class="row wid-10 vertical-top">
							 	<div class="wid-5 peri-1dep">
							 		<p class="h3-stit">대분류</p>
							 		<div class="scr-over">
								 		<ul class="peri-ul">
								 			<c:forEach var="i" items="${depth1List}" varStatus="loop">
												<li id="li_${i.SUB_CODE}" onclick="sel1dep('${i.SUB_CODE}')" class="cursor">${i.SHORT_NAME}</li>
											</c:forEach>
								 		</ul>
							 		</div>						 		
							 	</div>
							 	<div class="wid-5 peri-2dep">
							 		<div class="h3-stit"><div class="td-chk"><input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label></div>전체선택 / 해제</div>
							 		<span>※ 체크되지 않은 항목은 저장되지 않습니다.</span>
							 		<div class="scr-over">
								 		<ul class="peri-ul" id="sect-ul">
								 			
								 		</ul>
							 		</div>
							 	</div>
							</div>
						</div>
					</form>
					<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitCancle();">저장</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>

<div id="web_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg web-edit">
        		<div class="close" onclick="javascript:$('#web_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	
	        	<div class="web-wrap">
	        		<div class="top-row">
						
						<h3 style="text-align: center;">WEB 노출 기수 등록</h3>
						<div class="table-top bg01">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">점</div>
									<div>
										<select de-data="${branchList[0].SHORT_NAME}" id="web_store" name="web_store" onchange="selWebPeri()">
											<c:forEach var="i" items="${branchList}" varStatus="loop">
												<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">기수</div>
									<div>
										<select id="web_period" name="web_period" de-data="">
										</select>
									</div>
								</div>
							</div>
						</div>
						
					</div>
	        	
	        	</div>
	        	
	        	<div class="btn-wr text-center">
					<a class="btn btn01 ok-btn" onclick="javascript:getWebPeri();">조회</a>
					<a class="btn btn02 ok-btn" onclick="javascript:setWebPeri();">등록</a>
				</div>
	        	
        	</div>
        </div>
    </div>	
</div>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/> 