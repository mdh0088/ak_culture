<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>




<script>


var lecr="";
var day_value ='';
function searchLecr(idx)
{
	lecr = idx;
	$('#give_layer').fadeIn(200);	
	$(".lecr_check").prop("checked",false);
}

var initPage1 = "";
var initPage2 = "";
var initPage3 = "";
$(document).ready(function(){
	$('.withBaby').hide();
	initPage1 = $("#initPage1").html();
	initPage2 = $("#initPage2").html();
	initPage3 = $("#initPage3").html();
	
});


function selPeri()
{
	if($(".selPeri").html().indexOf("검색된") > -1)
	{
		alert("기수 정보가 없습니다.");
		$(".hidden_area").hide();
	}
	else
	{
		
		$.ajax({
			type : "POST", 
			url : "/basic/peri/getPeriOne",
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
				var result = JSON.parse(data);
	 			$("#start_ymd").val(cutDate(result.START_YMD));
	 			$("#end_ymd").val(cutDate(result.END_YMD));
	 			
	 			
	 			if(result.TECH_1_S != "Y")
 				{
 					$("#regis_fee_cnt1").attr("disabled", true);
 				}
	 			else
 				{
	 				$("#regis_fee_cnt1").attr("disabled", false);
	 				$("#regis_fee_cnt1").attr("checked", true);
 				}
	 			if(result.TECH_2_S != "Y")
 				{
 					$("#regis_fee_cnt2").attr("disabled", true);
 				}
	 			else
 				{
	 				$("#regis_fee_cnt2").attr("disabled", false);
	 				$("#regis_fee_cnt2").attr("checked", true);
 				}
	 			if(result.TECH_3_S != "Y")
 				{
 					$("#regis_fee_cnt3").attr("disabled", true);
 				}
	 			else
 				{
	 				$("#regis_fee_cnt3").attr("disabled", false);
	 				$("#regis_fee_cnt3").attr("checked", true);
 				}
	 			
	 			
	 			if(result.MATE_1_S != "Y")
 				{
 					$("#food_amt_cnt1").attr("disabled", true);
 				}
	 			else
 				{
	 				$("#food_amt_cnt1").attr("disabled", false);
	 				$("#food_amt_cnt1").attr("checked", true);
 				}
	 			if(result.MATE_2_S != "Y")
 				{
 					$("#food_amt_cnt2").attr("disabled", true);
 				}
	 			else
 				{
	 				$("#food_amt_cnt2").attr("disabled", false);
	 				$("#food_amt_cnt2").attr("checked", true);
 				}
	 			if(result.MATE_3_S != "Y")
 				{
 					$("#food_amt_cnt3").attr("disabled", true);
 				}
	 			else
 				{
	 				$("#food_amt_cnt3").attr("disabled", false);
	 				$("#food_amt_cnt3").attr("checked", true);
 				}
			}
		});	
		$("#confirmPeri").val($("#selPeri").val()); //중간에 바뀌는거 무시하기위하여.
		$("#confirmStore").val($("#selBranch").val()); //중간에 바뀌는거 무시하기위하여.
		$(".hidden_area").show();
		$.ajax({
			type : "POST", 
			url : "./getClassroom",
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
			store : $("#selBranch").val(),
			period : $("#selPeri").val()
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
var isCompute = false; //일정계산
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
			selPeri : $("#selPeri").val(),
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
function periInit()
{
	$("#initPage1").html(initPage1);
	$("#initPage1").hide();
	$("#initPage2").html(initPage2);
	$("#initPage2").hide();
	$("#initPage3").html(initPage3);
	$("#initPage3").hide();
	rest_cnt = 2;
	dateInit();
}
var main_cd ="";
function selMaincd(idx){	
// 	var x = document.getElementById("selPeri").selectedIndex;
// 	var y = document.getElementById("selPeri").options;
// 	var z = document.getElementById("selPeri").options[y[x].index];

	main_cd = $(idx).val();
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
		if(main_cd == 2)
		{
			$(".babyMonth").show();
			$("input:checkbox[name='is_two']").prop("checked", true);
		}
		else
		{
			$(".babyMonth").hide();
			$("input:checkbox[name='is_two']").prop("checked", false);
		}
	}else{
		$('.withBaby').hide();
		$("input:checkbox[name='is_two']").prop("checked", false);
	}
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		async : false,
		dataType : "text",
		data : 
		{
			maincd : main_cd,
// 			selBranch : z.getAttribute("store")
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
function sect_choose(){
	
	$('.select-ul').css('display','none');
	
// 	main_cd =$("#main_cd").val();

	$.ajax({
		type : "POST", 
		url : "./getlectcode",
		async : false,
		dataType : "text",
		data : 
		{
// 			main_cd : main_cd,
// 			sect_cd : $("#sect_cd").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
// 			console.log(data);
			$("#lect_cd").val(data);
// 			var result = JSON.parse(data);
// 			var lect_cd = 0;
// 			if (result.length==0) {
// 				lect_cd = '0001';
// 			}else{
// 				lect_cd = (result[0].LECT_CD*1)+1;				
// 			}
// 			if(String(lect_cd).length == 1)
// 			{
// 				lect_cd = "000"+lect_cd;
// 			}
// 			if(String(lect_cd).length == 2)
// 			{
// 				lect_cd = "00"+lect_cd;
// 			}
// 			if(String(lect_cd).length == 3)
// 			{
// 				lect_cd = "0"+lect_cd;
// 			}
			
// 			$("#lect_cd").val(lect_cd);
		}
	});	
	
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

// function checkAll(){
//     if(document.getElementById("idxAll").checked == true)
//    	{
//     	$(".lecr_check").prop("checked",true);
  
//    	}
//     else
//    	{
//     	$(".lecr_check").prop("checked",false);

//    	}    	
// }

// function check_this(idx){
//     if(document.getElementById("idx_"+idx).checked == true)
//    	{
//     	$("#idx_"+idx).prop("checked",false);
  
//    	}
//     else
//    	{
//     	$("#idx_"+idx).prop("checked",true);

//    	}       	
// }



// var lecr_kor_nm="";
// function choose_lecr(){
// 	$('.lecr_check').each(function(){
// 		if ( $(this).prop("checked")) {
// 			lecr_kor_nm= $(this).parent().parent().find('.lecr_kor_nm').text();
// 		}
// 	})
// 	$('#give_layer').fadeOut(200);
	
// 	if (lecr=='main') {
// 		$("#search_name1").val(lecr_kor_nm);
// 	}else{
// 		$("#search_name2").val(lecr_kor_nm);
// 	}
// }

var subject_cd='';
var main_cd='';
var sub_cd='';
var lect_cd='';
function add_lect(){
	main_cd=$('#main_cd').val();
	sub_cd=$('#sect_cd').val();

	
	subject_cd = main_cd+sub_cd+lect_cd;
	
	/*
	$.ajax({
		type : "POST", 
		url : "/addLect",
		dataType : "text",
		data : 
		{
			maincd : main_cd,
			selBranch : z.getAttribute("store")
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{

		}
	});
	*/
}

var rest_cnt=2;
var chk_cnt=0;
function add_rest_day(){
// 	$('.rest_sub_area').each(function(){ //이게 왜있는지 파악불가해서 기영이가 삭제!!! 필요한거라면 따로 말해주세용
// 		chk_cnt++;
// 	})
	var rest_inner =""; //이게 왜 전역변수에 잇는지 파악불가해서 기영이가 지역변수로 수정! 필요한거라면 따로 말해주세용
	if (rest_cnt>3) {
		alert('제한 수를 초과했습니다.');
		return;
	}
	
// 	$(".rest_day_area").empty(); //이게 왜있는지 파악불가해서 기영이가 삭제!!! 필요한거라면 따로 말해주세용
	rest_inner+='<div class="wid-4 addArea rest_sub_area_'+rest_cnt+'">';
	rest_inner+='	<div class="cal-row cal-row_inline02 table">';
// 	rest_inner+='		<ul class="chk-ul chk-cal">';
// 	rest_inner+='			<li>';
// 	rest_inner+='				<input type="checkbox" id="all-'+rest_cnt+'" value="123" name="all-c">';
// 	rest_inner+='				<label for="all-'+rest_cnt+'"></label>';
// 	rest_inner+='			</li>';
// 	rest_inner+='		</ul>';
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
// 	$('.wid-4').each(function(){ //이게 왜있는지 파악불가해서 기영이가 삭제!!! 필요한거라면 따로 말해주세용
// 		  if ($(this).children().find('input').prop("checked")) {
// 			  $(this).remove();
// 		}
// 	})
	var rmArea = document.getElementsByClassName("addArea");
	if(rmArea.length > 0)
	{
		rmArea[rmArea.length-1].parentNode.removeChild(rmArea[rmArea.length-1]);
		rest_cnt --;
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
		$("input:checkbox[id='food_amt_cnt1']").prop("checked", true);
		$("input:checkbox[id='food_amt_cnt2']").prop("checked", false);
		$("input:checkbox[id='food_amt_cnt3']").prop("checked", false);
	}
	else if(lect_cnt >= 2 && lect_cnt <= 7)
	{
		$("#subject_fg").val("단기");
		$("input:radio[name='corp_fg']:radio[value='N']").prop('checked', true); 
		$("input:radio[name='regis_fee_cnt']:radio[value='3']").prop('checked', true);
		$("input:checkbox[id='food_amt_cnt1']").prop("checked", true);
		$("input:checkbox[id='food_amt_cnt2']").prop("checked", true);
		$("input:checkbox[id='food_amt_cnt3']").prop("checked", true);
	}
	else
	{
		$("#subject_fg").val("정규");
		$("input:radio[name='corp_fg']:radio[value='Y']").prop('checked', true); 
		$("input:radio[name='regis_fee_cnt']:radio[value='3']").prop('checked', true);
		$("input:checkbox[id='food_amt_cnt1']").prop("checked", true);
		$("input:checkbox[id='food_amt_cnt2']").prop("checked", true);
		$("input:checkbox[id='food_amt_cnt3']").prop("checked", true);
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
			return;
		}
	}
	if(validationFlag == "Y")
	{
		if($("#fix_pay_yn2").is(":checked") && $("#fix_amt").val() == "")
		{
			alert("정액을 입력해주세요.");
			$("#fix_rate").focus();
			validationFlag = "N";
			return;
		}
	}
	if(validationFlag == "Y")
	{
		if($("#lect_hour1").val().length != 2 || $("#lect_hour2").val().length != 2 || $("#lect_hour3").val().length != 2 || $("#lect_hour4").val().length != 2)
		{
			alert("강의시간을 확인해주세요.");
			validationFlag = "N";
			return;
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
	if(validationFlag == "Y")
	{
		if(!isCompute && $("#subject_fg").val() == "정규")
		{
			alert("일정계산 버튼을 눌러주세요.");
			validationFlag = "N";
			return;
		}
	}
	var isCanc = false;
	$("[name='closed']").each(function() 
	{
		if($(this).val() != "")
		{
			if($(this).val().replace(/#/gi, "") <= $("#start_ymd").val().replace(/#/gi, "") || $(this).val().replace(/#/gi, "") >= $("#end_ymd").val().replace(/#/gi, ""))
			{
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
 	    			//location.reload();
	    			location.href ='./main';
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}
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
</script>
<div class="sub-tit">
	<h2>강좌코드추가</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>
<div class="table-list table-list-no">
	<form id="fncForm" name="fncForm" method="post" action="./write_proc" enctype="multipart/form-data">
		<input type="hidden" id="confirmPeri" name="confirmPeri">
		<input type="hidden" id="confirmStore" name="confirmStore">
		<input type="hidden" id="day_flag" name="day_flag">
		<input type="hidden" id="cancled_list" name="cancled_list">
		<input type="hidden" id="lecturer_cd" name="lecturer_cd">
		<input type="hidden" id="lecturer_cd1" name="lecturer_cd1">
		<input type="hidden" id="cus_no" name="cus_no">
		<input type="hidden" id="cus_no1" name="cus_no1">
		<div class="row view-page gift-wrap ledt-wrap">
			<div class="wid-5">
				<div class="top-row">
					<div class="wid-10">
						<div class="table table-auto">
							<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
							
							<a class="btn btn02 btn-inline" style="" onclick="selPeri()">선택완료</a>
						</div>
						<div class="sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
				
				<div class="white-bg ak-wrap_new hidden_area" id="initPage3" style="display:none;">
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
										<input type="text" id="lect_cd" name="lect_cd" data-name="코드명" class="notEmpty inputDisabled"  readOnly>
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
										<select de-data="선택하세요." id="main_cd" name="main_cd" data-name="대분류" class="notEmpty" onchange="selMaincd(this)">
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
										<select de-data="선택하세요." id="sect_cd" name="sect_cd" data-name="중분류" class="notEmpty" onchange="sect_choose()">
		
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
											<input type="text" id="month_no" name="month_no" value="1">
											<span class="sel-sp">개월 이상</span>
										</div>
										
										<div class="sel-wid sel-scr">
											<input type="text" id="month_no1" name="month_no1" value="1">
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
										<div class="search-wr" onclick="searchLecr('1')">
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
										<div class="search-wr" onclick="searchLecr('2')">
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
										<input type="text" id="capacity_no" name="capacity_no" data-name="정원" class="text-center notEmpty" value="20">
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
												<input type="checkbox" id="yoil_mon" name="yoil_mon" checked>
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
												<div class="cal-row table">
													<div class="cal-input cal-input180">
														<input type="text" class="date-i" id="start_ymd" name="start_ymd"/>
														<i class="material-icons">event_available</i>
													</div>
													<div class="cal-dash">-</div>
													<div class="cal-input cal-input180">
														<input type="text" class="date-i" id="end_ymd" name="end_ymd"/>
														<i class="material-icons">event_available</i>
													</div>
												</div>	
											</div>
											<div>
												<a class="btn btn02 mrg-l6" onclick="setSchedule();">일정계산</a>
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
												<input type="radio" id="corp_fg_2" name="corp_fg" value="N" checked="checked">
												<label for="corp_fg_2">N</label>
											</li>
											
										</ul>
										
									</div>
								</div>
							</div>
						</div>
<!-- 						<div class="top-row"> -->
<!-- 							<div class="wid-10"> -->
<!-- 								<div class="table"> -->
<!-- 									<div class="sear-tit">썸네일 이미지</div> -->
<!-- 									<div> -->
<!-- 										<div class="filebox">  -->
<!-- 											<label for="thumbnail"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
<!-- 											<input type="file" id="thumbnail" name="thumbnail">  -->
											
<!-- 											<input class="upload-name" value="이미지를 첨부해주세요."> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="top-row"> -->
<!-- 							<div class="wid-10"> -->
<!-- 								<div class="table"> -->
<!-- 									<div class="sear-tit">상세 이미지</div> -->
<!-- 									<div> -->
<!-- 										<div class="filebox">  -->
<!-- 											<label for="detail"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
<!-- 											<input type="file" id="detail" name="detail">  -->
											
<!-- 											<input class="upload-name02" value="이미지를 첨부해주세요."> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
						
						
					</div>
					
				</div>
			</div>
			<div class="wid-5 wid-5_last hidden_area" id="initPage2" style="display:none;">
				<div class="white-bg bg-pad">
				
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
														<input type="text" id="fix_rate" class="text-center" name="fix_rate" value="40" placeholder="40">
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
														<input type="text" id="fix_amt" class="text-center comma" name="fix_amt" value="0" placeholder="0">
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
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit sear-tit03">수강료</div>
									<div>
										<input type="text" id="regis_fee" name="regis_fee" class="text-right notEmpty comma" placeholder="0" data-name="수강료" value="0" >
									</div>
									<div class="sel-txt10">원</div>
								</div>
							</div>
						</div>	
						<div class="top-row table-input">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit sear-tit03">재료비</div>
									<div>
										<input type="text" id="food_amt" name="food_amt" class="text-right notEmpty comma" placeholder="0" data-name="재료비" value="0">
									</div>
									<div class="sel-txt10">원</div>
									<div style="padding-left:20px;">
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
			
		
		</div>
	</form>
</div>
<div class="btn-wr text-center">
	<a class="btn btn01 list-btn" onclick="javascript:back();">목록보기</a>
	<a class="btn btn02 ok-btn hidden_area" id="initPage3" style="display:none;" onclick="javascript:fncSubmit();">저장</a>
</div>

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
<script>
$(document).ready(function(){
	selPeri();
	getScheduleByPeri();
	setSchedule("init");
	lect_cnt_change();
});
</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>