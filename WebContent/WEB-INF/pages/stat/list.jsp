<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown()
{
	var excelTableHtml = $("#excelTable").html();
	$("#excelTableTmp").html(excelTableHtml);
	$("#excelTableTmp").find(".material-icons").remove();
	
	var filename = "강좌군별 실적 분석";
	var table = "excelTableTmp";
    exportExcel(filename, table);
}
function selPeri1()
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
	 			$("#start_ymd1").val(cutDate(result.ADULT_S_BGN_YMD));
			}
		});	
	}
}
function selPeri2()
{
	if($(".target_selPeri").html().indexOf("검색된") > -1)
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
				selPeri : $("#target_selPeri").val(),
				selBranch : $("#target_selBranch").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				$("#start_ymd2").val(cutDate(result.ADULT_S_BGN_YMD));
			}
		});	
	}
}
function setDateFnc1()
{
	$.ajax({
		type : "POST", 
		url : "./getStartYmdPeri",
		dataType : "text",
		async : false,
		data : 
		{
			period : $("#selPeri").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			if(data != "")
			{
				$("#start_ymd1").val(cutDate(nullChk(data)));
			}
		}
	});	
}
function setDateFnc2()
{
	$.ajax({
		type : "POST", 
		url : "./getStartYmdPeri",
		dataType : "text",
		async : false,
		data : 
		{
			period : $("#target_selPeri").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			if(data != "")
			{
				$("#start_ymd2").val(cutDate(nullChk(data)));
			}
		}
	});	
}
function trAct1(main_nm, subject_fg)
{
	$("."+main_nm+"_"+subject_fg).hide();
	$("#cut_"+main_nm+"_"+subject_fg).html('펼치기');
}
function trAct2(main_nm, subject_fg)
{
	$("."+main_nm+"_"+subject_fg).show();
	$("#cut_"+main_nm+"_"+subject_fg).html('접기');
}
function trAct(main_nm, subject_fg)
{
	if($("#cut_"+main_nm+"_"+subject_fg).html() == "접기")
	{
		$("."+main_nm+"_"+subject_fg).hide();
		$("#cut_"+main_nm+"_"+subject_fg).html('펼치기');
	}
	else
	{
		$("."+main_nm+"_"+subject_fg).show();
		$("#cut_"+main_nm+"_"+subject_fg).html('접기');
	}
}
function allTrAct(val)
{
	if(val == '1')
	{
		trAct1('Adult','1');
		trAct1('Adult','2');
		trAct1('Adult','3');
		trAct1('Baby','1');
		trAct1('Baby','2');
		trAct1('Baby','3');
		trAct1('Kids','1');
		trAct1('Kids','2');
		trAct1('Kids','3');
		trAct1('Family','1');
		trAct1('Family','2');
		trAct1('Family','3');
	}
	if(val == '2')
	{
		trAct2('Adult','1');
		trAct2('Adult','2');
		trAct2('Adult','3');
		trAct2('Baby','1');
		trAct2('Baby','2');
		trAct2('Baby','3');
		trAct2('Kids','1');
		trAct2('Kids','2');
		trAct2('Kids','3');
		trAct2('Family','1');
		trAct2('Family','2');
		trAct2('Family','3');
	}
}
function getList()
{
	var tot_lect_cnt = 0;
	var tot_person = 0;
	var tot_sinjang_person = 0.00;
	var tot_diff_person = 0.00;
	var tot_regis_fee = 0;
	var tot_sinjang_regis_fee = 0.00;
	var tot_diff_regis_fee = 0;
	var tot_target_lect_cnt = 0;
	var tot_target_person = 0;
	var tot_target_regis_fee = 0;
	
	var main_lect_cnt = 0;
	var main_person = 0;
	var main_regis_fee = 0;
	var fg_lect_cnt = 0;
	var fg_person = 0;
	var fg_regis_fee = 0;
	var main_sinjang_person = 0.00;
	var main_sinjang_regis_fee = 0.00;
	var fg_sinjang_person = 0.00;
	var fg_sinjang_regis_fee = 0.00;
	var main_diff_person = 0;
	var main_diff_regis_fee = 0;
	var fg_diff_person = 0;
	var fg_diff_regis_fee = 0;
	
	
	var target_main_lect_cnt = 0;
	var target_main_person = 0;
	var target_main_regis_fee = 0;
	var target_fg_lect_cnt = 0;
	var target_fg_person = 0;
	var target_fg_regis_fee = 0;
	$.ajax({
		type : "POST", 
		url : "./getPerforLect",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			target_store : $("#target_selBranch").val(),
			target_period : $("#target_selPeri").val(),
			start_ymd1 : $("#start_ymd1").val(),
			end_ymd1 : $("#end_ymd1").val(),
			start_ymd2 : $("#start_ymd2").val(),
			end_ymd2 : $("#end_ymd2").val(),
			isPerformance : $("#isPerformance").is(":checked")
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
			
			for(var i = 0; i < result.list.length; i++)
			{
				if(i != 0)
				{
					if(result.list[i].MAIN_CD != result.list[i-1].MAIN_CD)
					{
						if( Number(nullChkZero(target_main_person)) != 0)
						{
							main_sinjang_person = (Number(nullChkZero(main_person)) -  Number(nullChkZero(target_main_person))) /  Number(nullChkZero(target_main_person));
						}
						else
						{
							main_sinjang_person = (Number(nullChkZero(main_person)) -  Number(nullChkZero(target_main_person))) /  1;
						}
						if( Number(nullChkZero(target_main_regis_fee)) != 0)
						{
							main_sinjang_regis_fee = (Number(nullChkZero(main_regis_fee)) -  Number(nullChkZero(target_main_regis_fee))) /  Number(nullChkZero(target_main_regis_fee));
						}
						else
						{
							main_sinjang_regis_fee = (Number(nullChkZero(main_regis_fee)) -  Number(nullChkZero(target_main_regis_fee))) / 1;
						}
						inner += '<tr class="bg-red">';
						inner += '	<td class="sum" style="color:#f5bebd !important;" id="cut_'+result.list[i-1].MAIN_NM+'_'+result.list[i-1].SUBJECT_FG+'" onclick="trAct(\''+result.list[i-1].MAIN_NM+'\',\''+result.list[i-1].SUBJECT_FG+'\')">접기</td>';
						inner += '	<td class="sum">'+result.list[i-1].MAIN_NM+' 계</td>';
						inner += '	<td class="sum"></td>';
						inner += '	<td>'+comma(nullChkZero(main_lect_cnt))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_person))+'</td>';
						inner += '	<td>'+(parseFloat(main_sinjang_person*100).toFixed(2))+'%<i class="material-icons">'+((main_sinjang_person.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';							
						inner += '	<td>'+comma(nullChkZero(main_diff_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_regis_fee))+'</td>';
						inner += '	<td>'+(parseFloat(main_sinjang_regis_fee*100).toFixed(2))+'%<i class="material-icons">'+((main_sinjang_regis_fee.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';
						inner += '	<td>'+comma(nullChkZero(main_diff_regis_fee))+'</td>';
						inner += '	<td>'+comma(nullChkZero(target_main_lect_cnt))+'</td>';
						inner += '	<td>'+comma(nullChkZero(target_main_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(target_main_regis_fee))+'</td>';
						inner += '</tr>';
						
						main_lect_cnt = 0;
						main_person = 0;
						main_regis_fee = 0;
						main_sinjang_person = 0.00;
						main_sinjang_regis_fee = 0.00;
						main_diff_person = 0;
						main_diff_regis_fee = 0;
						
						target_main_lect_cnt = 0;
						target_main_person = 0;
						target_main_regis_fee = 0;
					}
					if(result.list[i].SUBJECT_FG != result.list[i-1].SUBJECT_FG)
					{
						if( Number(nullChkZero(target_fg_person)) != 0)
						{
							fg_sinjang_person = (Number(nullChkZero(fg_person)) -  Number(nullChkZero(target_fg_person))) /  Number(nullChkZero(target_fg_person));
						}
						else
						{
							fg_sinjang_person = (Number(nullChkZero(fg_person)) -  Number(nullChkZero(target_fg_person))) /  1;
						}
						if( Number(nullChkZero(target_fg_regis_fee)) != 0)
						{
							fg_sinjang_regis_fee = (Number(nullChkZero(fg_regis_fee)) -  Number(nullChkZero(target_fg_regis_fee))) /  Number(nullChkZero(target_fg_regis_fee));
						}
						else
						{
							fg_sinjang_regis_fee = (Number(nullChkZero(fg_regis_fee)) -  Number(nullChkZero(target_fg_regis_fee))) / 1;
						}
						inner += '<tr class="bg-red">';
						inner += '	<td class="sum">'+result.list[i-1].SUBJECT_FG_NM+' 계</td>';
						inner += '	<td class="sum"></td>';
						inner += '	<td class="sum"></td>';
						inner += '	<td>'+comma(nullChkZero(fg_lect_cnt))+'</td>';
						inner += '	<td>'+comma(nullChkZero(fg_person))+'</td>';
						inner += '	<td>'+(parseFloat(fg_sinjang_person*100).toFixed(2))+'%<i class="material-icons">'+((fg_sinjang_person.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';
						inner += '	<td>'+comma(nullChkZero(fg_diff_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(fg_regis_fee))+'</td>';
						inner += '	<td>'+(parseFloat(fg_sinjang_regis_fee*100).toFixed(2))+'%<i class="material-icons">'+((fg_sinjang_regis_fee.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';
						inner += '	<td>'+comma(nullChkZero(fg_diff_regis_fee))+'</td>';
						inner += '	<td>'+comma(nullChkZero(target_fg_lect_cnt))+'</td>';
						inner += '	<td>'+comma(nullChkZero(target_fg_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(target_fg_regis_fee))+'</td>';
						inner += '</tr>';
						
						fg_lect_cnt = 0;
						fg_person = 0;
						fg_regis_fee = 0;
						fg_sinjang_person = 0.00;
						fg_sinjang_regis_fee = 0.00;
						fg_diff_person = 0;
						fg_diff_regis_fee = 0;
						
						target_fg_lect_cnt = 0;
						target_fg_person = 0;
						target_fg_regis_fee = 0;
					}
				}
				var sinjang_person = 0.00;
				if(Number(nullChkZero(result.list[i].TARGET_PERSON)) != 0)
				{
					sinjang_person = (Number(nullChkZero(result.list[i].NOW_PERSON)) -  Number(nullChkZero(result.list[i].TARGET_PERSON))) /  Number(nullChkZero(result.list[i].TARGET_PERSON));
				}
				else
				{
					sinjang_person = (Number(nullChkZero(result.list[i].NOW_PERSON)) -  Number(nullChkZero(result.list[i].TARGET_PERSON))) /  1;
				}
				var sinjang_regis_fee = 0.00;
				if(Number(nullChkZero(result.list[i].TARGET_UPRICE)) != 0)
				{
					sinjang_regis_fee = (Number(nullChkZero(result.list[i].NOW_UPRICE)) -  Number(nullChkZero(result.list[i].TARGET_UPRICE))) /  Number(nullChkZero(result.list[i].TARGET_UPRICE));
				}
				else
				{
					sinjang_regis_fee = (Number(nullChkZero(result.list[i].NOW_UPRICE)) -  Number(nullChkZero(result.list[i].TARGET_UPRICE))) / 1;
				}
				
				var diff_person = Number(nullChkZero(result.list[i].NOW_PERSON)) -  Number(nullChkZero(result.list[i].TARGET_PERSON));
				var diff_regis_fee = Number(nullChkZero(result.list[i].NOW_UPRICE)) -  Number(nullChkZero(result.list[i].TARGET_UPRICE));
				inner += '<tr class="'+result.list[i].MAIN_NM+'_'+result.list[i].SUBJECT_FG+'">';
				inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
				inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
				inner += '	<td>'+result.list[i].SECT_NM+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list[i].NOW_LECT_CNT))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list[i].NOW_PERSON))+'</td>';
				inner += '	<td class="color-blue">'+(parseFloat(sinjang_person*100).toFixed(2))+'%<i class="material-icons">'+((sinjang_person <0) ? "arrow_drop_down" : "" )+'</i></td>';
				inner += '	<td>'+comma(diff_person)+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list[i].NOW_UPRICE))+'</td>';
				inner += '	<td class="color-blue">'+(parseFloat(sinjang_regis_fee*100).toFixed(2))+'%<i class="material-icons">'+((sinjang_regis_fee <0) ? "arrow_drop_down" : "" )+'</i></td>';
				inner += '	<td>'+comma(diff_regis_fee)+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list[i].TARGET_LECT_CNT))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list[i].TARGET_PERSON))+'</td>';
				inner += '	<td>'+comma(nullChkZero(result.list[i].TARGET_UPRICE))+'</td>';
				inner += '</tr>';
				
				
				
				tot_lect_cnt += Number(result.list[i].NOW_LECT_CNT);
				tot_person += Number(result.list[i].NOW_PERSON);
				tot_sinjang_person += parseFloat(sinjang_person);
				tot_diff_person += Number(diff_person);
				tot_regis_fee += Number(result.list[i].NOW_UPRICE);
				tot_sinjang_regis_fee += parseFloat(sinjang_regis_fee);
				tot_diff_regis_fee += Number(diff_regis_fee);
				tot_target_lect_cnt += Number(result.list[i].TARGET_LECT_CNT);
				tot_target_person += Number(result.list[i].TARGET_PERSON);
				tot_target_regis_fee += Number(result.list[i].TARGET_UPRICE);
				
				main_lect_cnt += Number(result.list[i].NOW_LECT_CNT);
				main_person += Number(result.list[i].NOW_PERSON);
				main_regis_fee += Number(result.list[i].NOW_UPRICE);
				fg_lect_cnt += Number(result.list[i].NOW_LECT_CNT);
				fg_person  += Number(result.list[i].NOW_PERSON);
				fg_regis_fee += Number(result.list[i].NOW_UPRICE);
				
				main_sinjang_person += parseFloat(sinjang_person);
				main_sinjang_regis_fee += parseFloat(sinjang_regis_fee);
				console.log(main_sinjang_regis_fee.toFixed(2));
				fg_sinjang_person += parseFloat(sinjang_person);
				fg_sinjang_regis_fee += parseFloat(sinjang_regis_fee);
				main_diff_person += Number(diff_person);
				main_diff_regis_fee += Number(diff_regis_fee);
				fg_diff_person += Number(diff_person);
				fg_diff_regis_fee += Number(diff_regis_fee);
				
				target_main_lect_cnt += Number(result.list[i].TARGET_LECT_CNT);
				target_main_person += Number(result.list[i].TARGET_PERSON);
				target_main_regis_fee += Number(result.list[i].TARGET_UPRICE);
				target_fg_lect_cnt += Number(result.list[i].TARGET_LECT_CNT);
				target_fg_person  += Number(result.list[i].TARGET_PERSON);
				target_fg_regis_fee += Number(result.list[i].TARGET_UPRICE);
				
				if(i == result.list.length-1)
				{
					if( Number(nullChkZero(target_main_person)) != 0)
					{
						main_sinjang_person = (Number(nullChkZero(main_person)) -  Number(nullChkZero(target_main_person))) /  Number(nullChkZero(target_main_person));
					}
					else
					{
						main_sinjang_person = (Number(nullChkZero(main_person)) -  Number(nullChkZero(target_main_person))) /  1;
					}
					if( Number(nullChkZero(target_main_regis_fee)) != 0)
					{
						main_sinjang_regis_fee = (Number(nullChkZero(main_regis_fee)) -  Number(nullChkZero(target_main_regis_fee))) /  Number(nullChkZero(target_main_regis_fee));
					}
					else
					{
						main_sinjang_regis_fee = (Number(nullChkZero(main_regis_fee)) -  Number(nullChkZero(target_main_regis_fee))) / 1;
					}
					inner += '<tr class="bg-red">';
					inner += '	<td class="sum" style="color:#f5bebd !important;" id="cut_'+result.list[i-1].MAIN_NM+'_'+result.list[i-1].SUBJECT_FG+'" onclick="trAct(\''+result.list[i-1].MAIN_NM+'\',\''+result.list[i-1].SUBJECT_FG+'\')">접기</td>';
					inner += '	<td class="sum">'+result.list[i-1].MAIN_NM+' 계</td>';
					inner += '	<td class="sum"></td>';
					inner += '	<td>'+comma(nullChkZero(main_lect_cnt))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_person))+'</td>';
					inner += '	<td>'+(parseFloat(main_sinjang_person*100).toFixed(2))+'%<i class="material-icons">'+((main_sinjang_person.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';
					inner += '	<td>'+comma(nullChkZero(main_diff_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_regis_fee))+'</td>';
					inner += '	<td>'+(parseFloat(main_sinjang_regis_fee*100).toFixed(2))+'%<i class="material-icons">'+((main_sinjang_regis_fee.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';
					inner += '	<td>'+comma(nullChkZero(main_diff_regis_fee))+'</td>';
					inner += '	<td>'+comma(nullChkZero(target_main_lect_cnt))+'</td>';
					inner += '	<td>'+comma(nullChkZero(target_main_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(target_main_regis_fee))+'</td>';
					inner += '</tr>';
					
					if( Number(nullChkZero(target_fg_person)) != 0)
					{
						fg_sinjang_person = (Number(nullChkZero(fg_person)) -  Number(nullChkZero(target_fg_person))) /  Number(nullChkZero(target_fg_person));
					}
					else
					{
						fg_sinjang_person = (Number(nullChkZero(fg_person)) -  Number(nullChkZero(target_fg_person))) /  1;
					}
					if( Number(nullChkZero(target_fg_regis_fee)) != 0)
					{
						fg_sinjang_regis_fee = (Number(nullChkZero(fg_regis_fee)) -  Number(nullChkZero(target_fg_regis_fee))) /  Number(nullChkZero(target_fg_regis_fee));
					}
					else
					{
						fg_sinjang_regis_fee = (Number(nullChkZero(fg_regis_fee)) -  Number(nullChkZero(target_fg_regis_fee))) / 1;
					}
					
					inner += '<tr class="bg-red">';
					inner += '	<td class="sum">'+result.list[i-1].SUBJECT_FG_NM+' 계</td>';
					inner += '	<td class="sum"></td>';
					inner += '	<td class="sum"></td>';
					inner += '	<td>'+comma(nullChkZero(fg_lect_cnt))+'</td>';
					inner += '	<td>'+comma(nullChkZero(fg_person))+'</td>';
					inner += '	<td>'+(parseFloat(fg_sinjang_person*100).toFixed(2))+'%<i class="material-icons">'+((fg_sinjang_person.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';
					inner += '	<td>'+comma(nullChkZero(fg_diff_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(fg_regis_fee))+'</td>';
					inner += '	<td>'+(parseFloat(fg_sinjang_regis_fee*100).toFixed(2))+'%<i class="material-icons">'+((fg_sinjang_regis_fee.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></td>';
					inner += '	<td>'+comma(nullChkZero(fg_diff_regis_fee))+'</td>';
					inner += '	<td>'+comma(nullChkZero(target_fg_lect_cnt))+'</td>';
					inner += '	<td>'+comma(nullChkZero(target_fg_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(target_fg_regis_fee))+'</td>';
					inner += '</tr>';
				}
				
			}
			
			$("#target").html(inner);
		}
	});	
	
	if( Number(nullChkZero(tot_target_person)) != 0)
	{
		tot_sinjang_person = (Number(nullChkZero(tot_person)) -  Number(nullChkZero(tot_target_person))) /  Number(nullChkZero(tot_target_person));
	}
	else
	{
		tot_sinjang_person = (Number(nullChkZero(tot_person)) -  Number(nullChkZero(tot_target_person))) / 1;
	}
	if( Number(nullChkZero(tot_target_regis_fee)) != 0)
	{
		tot_sinjang_regis_fee = (Number(nullChkZero(tot_regis_fee)) -  Number(nullChkZero(tot_target_regis_fee))) /  Number(nullChkZero(tot_target_regis_fee));
	}
	else
	{
		tot_sinjang_regis_fee = (Number(nullChkZero(tot_regis_fee)) -  Number(nullChkZero(tot_target_regis_fee))) / 1;
	}
	
	$("#tot_lect_cnt").html(comma(tot_lect_cnt));
	
	$("#tot_person").html(comma(tot_person));
	$("#top_tot_person").html(comma(tot_person)+'<span>명</span>'); //20210521 동동이추가
	
	
	$("#tot_sinjang_person").html((tot_sinjang_person*100).toFixed(2)+'%<i class="material-icons">'+((tot_sinjang_person.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i>');
	$("#top_tot_sinjang_person").html((tot_sinjang_person*100).toFixed(2)+'<span>%<i class="material-icons">'+((tot_sinjang_person.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></span>');
	
	
	$("#tot_diff_person").html(comma(tot_diff_person));
	
	$("#tot_regis_fee").html(comma(tot_regis_fee));
	$("#top_tot_regis_fee").html(comma(tot_regis_fee)+'<span>원</span>');
	
	
	$("#tot_sinjang_regis_fee").html((tot_sinjang_regis_fee*100).toFixed(2)+'%<i class="material-icons">'+((tot_sinjang_regis_fee.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i>');
	$("#top_tot_sinjang_regis_fee").html((tot_sinjang_regis_fee*100).toFixed(2)+'<span>%<i class="material-icons">'+((tot_sinjang_regis_fee.toFixed(2) <0) ? "arrow_drop_down" : "" )+'</i></span>');
	
	
	$("#tot_diff_regis_fee").html(comma(tot_diff_regis_fee));
	$("#tot_target_lect_cnt").html(comma(tot_target_lect_cnt));
	$("#tot_target_person").html(comma(tot_target_person));
	$("#tot_target_regis_fee").html(comma(tot_target_regis_fee));
	
	var selSeason1 = "";
	var selSeason2 = "";
	if($("#selSeason").val() == "봄학기") {selSeason1 = "1";}
	else if($("#selSeason").val() == "여름학기") {selSeason1 = "2";}
	else if($("#selSeason").val() == "가을학기") {selSeason1 = "3";}
	else if($("#selSeason").val() == "겨울학기") {selSeason1 = "4";}
	
	if($("#target_selSeason").val() == "봄학기") {selSeason2 = "1";}
	else if($("#target_selSeason").val() == "여름학기") {selSeason2 = "2";}
	else if($("#target_selSeason").val() == "가을학기") {selSeason2 = "3";}
	else if($("#target_selSeason").val() == "겨울학기") {selSeason2 = "4";}
	
	$.ajax({
		type : "POST", 
		url : "./getTargetLong",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			selYear1 : $("#selYear").val(),
// 			selYear2 : $("#target_selYear").val(),
			selSeason1 : selSeason1,
// 			selSeason2 : selSeason2
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			var tmp = 0;
			$("#person_target").html(comma(nullChkZero(result[0].REGIS_NO))+"<span>명</span>");
			$("#regis_fee_target").html(comma(nullChkZero(result[0].PAY))+"<span>원</span>");
			
			tmp = Number(tot_person) / Number(nullChkZero(result[0].REGIS_NO)) * 100;
			$("#person_percent").html(tmp.toFixed(2) + "<span>%</span>");
			tmp = Number(tot_regis_fee) / Number(nullChkZero(result[0].PAY)) * 100;
			$("#regis_fee_percent").html(tmp.toFixed(2) + "<span>%</span>");
		}
	});	
	
	
	
	
// 	var type_arr = ['1', '2', '3'];
// 	var type_arr_nm = ['정규', '단기', '특강'];
// 	$("#target").html('');
// 	$.ajax({
// 		type : "POST", 
// 		url : "/common/get1Depth",
// 		dataType : "text",
// 		async : false,
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			console.log(data);
// 			var result = JSON.parse(data);
			
// 					for(var i = 0; i < type_arr.length; i++)
// 					{
// 						for(var z = 0; z < result.length; z++)
// 						{
// 							$.ajax({
// 								type : "POST", 
// 								url : "/common/getSecCd",
// 								dataType : "text",
// 								async : false,
// 								data : 
// 								{
// 									selBranch : $("#selBranch").val(),
// 									maincd : result[z].SUB_CODE
// 								},
// 								error : function() 
// 								{
// 									console.log("AJAX ERROR");
// 								},
// 								success : function(data1) 
// 								{
// 									console.log(data1);
// 									var result1 = JSON.parse(data1);
// 									for(var x = 0; x < result1.length; x++)
// 									{
// 										$.ajax({
// 											type : "POST", 
// 											url : "./getPerforLect",
// 											dataType : "text",
// 											async : false,
// 											data : 
// 											{
// 												store : $("#selBranch").val(),
// 												period : $("#selPeri").val(),
// 												target_store : $("#target_selBranch").val(),
// 												target_period : $("#target_selPeri").val(),
// 												subject_fg : type_arr[i],
// 												main_cd : result[z].SUB_CODE,
// 												sect_cd : result1[x].SECT_CD
// 											},
// 											error : function() 
// 											{
// 												console.log("AJAX ERROR");
// 											},
// 											success : function(data2) 
// 											{
// 												console.log(data2);
// 												var result2 = JSON.parse(data2);
// 												var inner = "";
												
// 												inner += '<tr>';
// 												inner += '	<td>'+type_arr_nm[i]+'</td>';
// 												inner += '	<td>'+result[z].SHORT_NAME+'</td>';
// 												inner += '	<td>'+result1[x].SECT_NM+'</td>';
// 												inner += '	<td>'+comma(nullChkZero(result2.lect_cnt))+'</td>';
// 												inner += '	<td>'+comma(nullChkZero(result2.person))+'</td>';
// 												inner += '	<td class="color-blue">0%<i class="material-icons"></i></td>';
// 												inner += '	<td>0</td>';
// 												inner += '	<td>'+comma(nullChkZero(result2.regis_fee))+'</td>';
// 												inner += '	<td class="color-blue">0%<i class="material-icons"></i></td>';
// 												inner += '	<td>0</td>';
// 												inner += '	<td>'+comma(nullChkZero(result2.target_lect_cnt))+'</td>';
// 												inner += '	<td>'+comma(nullChkZero(result2.target_person))+'</td>';
// 												inner += '	<td>'+comma(nullChkZero(result2.target_regis_fee))+'</td>';
// 												inner += '</tr>';
												
												
// 												$("#target").append(inner);
// 											}
// 										});	
// 									}
// 								}
// 							});	
							
							
// 						}
// 					}
// 		}
// 	});	
}
</script>

	
<div class="sub-tit">
	<h2>강좌군별 실적 분석</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row">	
		<div class="wid-35">
			<div class="table">
				<div class="sear-tit ">현재 기수</div>
				<div class="">
					<div class="table table-auto">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-35 mag-l2">
			<div class="cal-row cal-row_inline cal-row02 table">
				<div class="cal-input wid-4">
					<input type="text" class="date-i" id="start_ymd1" name="start_ymd1"/>
					<i class="material-icons">event_available</i>
				</div>
				<div class="cal-dash">-</div>
				<div class="cal-input wid-4">
					<input type="text" class="date-i ready-i" id="end_ymd1" name="end_ymd1"/>
					<i class="material-icons">event_available</i>
				</div>
			</div>
		</div>
		<div class="wid-11 mag-l2">
			<ul class="chk-ul">
				<li>
					<input type="checkbox" id="isPerformance" name="isPerformance">
					<label for="isPerformance">임시 중분류 포함</label>
				</li>
			</ul>
		</div>
	</div>
	<div class="top-row top-row_red">	
		<div class="wid-35">
			<div class="table">
				<div class="sear-tit ">비교 기수</div>
				<div class="">
					<div class="table table-auto">
						<jsp:include page="/WEB-INF/pages/common/peri1_for_target.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2_for_target.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-35 mag-l2">
			<div class="cal-row cal-row_inline cal-row02 table">
				<div class="cal-input wid-4">
					<input type="text" class="date-i" id="start_ymd2" name="start_ymd2"/>
					<i class="material-icons">event_available</i>
				</div>
				<div class="cal-dash">-</div>
				<div class="cal-input wid-4">
					<input type="text" class="date-i ready-i" id="end_ymd2" name="end_ymd2"/>
					<i class="material-icons">event_available</i>
				</div>
			</div>
		</div>
		<div class="wid-11 mag-l2">
			
		</div>
	
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>	


<div class="stat-wrap">
	<div class="stat-wid5">
		<div class="tit">회원 수</div>
		<div class="cont">
		
			<div class="stat-cont">
				<p>목표</p>
				<div id="person_target"><span>명</span></div>
			</div>
			
			<div class="stat-cont">
				<p>현재실적</p>
				<div id="top_tot_person"></div>
			</div>
		</div>
		<div class="cont">			
			<div class="stat-cont">
				<p>달성률</p>
				<div id="person_percent"><span>%</span></div>
			</div>
			
			<div class="stat-cont">
				<p>신장률</p>
				<div id="top_tot_sinjang_person"><span>%</span></div>
			</div>
			
		</div>
	</div>
	
	<div class="stat-wid5_last">
		<div class="tit">수강료 매출</div>
		<div class="cont">
			<div class="stat-cont">
				<p>목표</p>
				<div id="regis_fee_target"><span>명</span></div>
			</div>
			
			<div class="stat-cont">
				<p>현재실적</p>
				<div id="top_tot_regis_fee"></div>
			</div>
		</div>
		
		<div class="cont">
			<div class="stat-cont">
				<p>달성률</p>
				<div id="regis_fee_percent"><span>%</span></div>
			</div>
			
			<div class="stat-cont">
				<p>신장률</p>
				<div id="top_tot_sinjang_regis_fee"><span>%</span></div>
			</div>
			
		</div>
	</div>
	
</div> <!-- // stat-wrap end -->

<!-- <div class="table-cap table"> -->
<!-- 	<div class="cap-r text-right"> -->
<!-- 		<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a> -->
<!-- 		<div class="table table02 table-auto float-right"> -->
<!-- 			<div class=""> -->
<!-- 				<select id="listSize" name="listSize" onchange="getLectList(1)" de-data="대분류별 계"> -->
<!-- 					<option value="">대분류별 계</option> -->
<!-- 					<option value="">강좌유형별 계</option> -->
<!-- 				</select> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->

<span style="font-size: 20px;font-weight: bold;color: #ee908e;" id="all_contr" onclick="allTrAct('1')">
▲
</span>
<span style="font-size: 20px;font-weight: bold;color: #ee908e;" id="all_contr" onclick="allTrAct('2')">
▼
</span>
<div class="table-wr ip-list">
	
	<div class="table-list table-stlist" >
		<table id="excelTable">
			<thead>
				<tr class="table-stptr01">
					<th colspan="3">구분</th>
					<th class="col01" colspan="7">현재 기수</th>
					<th colspan="3">비교 기수</th>
				</tr>				
				<tr class="table-stptr02">
<!-- 					<th rowspan="2">지점</th> -->
					<th rowspan="2">강좌구분</th>
					<th rowspan="2">대분류</th>
					<th rowspan="2">중분류</th>
					<th class="col02" rowspan="2">강좌수</th>
					<th class="col03" colspan="3">회원수</th>
					<th class="col05" colspan="3">수강료</th>
					<th rowspan="2">강좌수</th>
					<th rowspan="2">회원수</th>
					<th rowspan="2">수강료</th>					
				</tr>
				
				<tr class="table-stptr03">
					<th class="col04">실적</th>
					<th class="col04">신장률</th>
					<th class="col04">증감</th>
					<th class="col01">실적</th>
					<th class="col01">신장률</th>
					<th class="col01">증감</th>
				</tr>
			</thead>
			
			<tbody id="target">
			</tbody>
		</table>
	</div>
</div>
			


<div class="sta-botfix sta-botfix01">
	<ul>
		<li class="li01" style="width:94% !important">총 계</li>
		<li class="li03" id="tot_lect_cnt"></li>
		<li class="li03" id="tot_person"></li>
		<li class="li03" id="tot_sinjang_person"></li>
		<li class="li03" id="tot_diff_person"></li>
		<li class="li03" id="tot_regis_fee"></li>
		<li class="li03" id="tot_sinjang_regis_fee"></li>
		<li class="li03" id="tot_diff_regis_fee"></li>
		<li class="li03" id="tot_target_lect_cnt"></li>
		<li class="li03" id="tot_target_person"></li>
		<li class="li03" id="tot_target_regis_fee"></li>
	</ul>
</div>

<script>
$(document).ready(function(){
	var targetYear = Number($("#selYear").val())-1;
	$("#target_selYear").val(targetYear.toString());
	$(".target_selYear").html(targetYear.toString());
	target_fncPeri();
	
	var targetSeason = $("#selSeason").val();
	$("#target_selSeason").val(targetSeason);
	target_fncPeri2();
	var targetPeri = $("#target_selPeri").val();
	$(".target_selSeason").html(targetSeason + " / "+targetPeri);
	
	
	
// 	var targetPeri = Number($("#selPeri").val())-4;
// 	$("#target_selPeri").val('0'+targetPeri.toString());
// 	alert($("#target_selPeri").val());
// 	$(".target_selPeri").html('0'+targetPeri.toString());
// 	target_fncPeri2();
	
	setDateFnc1();
	//setDateFnc2(); //20210521 동동이가 주석처리 기수값 변경 시 start_ymd2 값 상이
	getList();
});
</script>




















<table id="excelTableTmp" style="display:none;"></table>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>