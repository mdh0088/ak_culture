<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
// function getLastYearSeason()
// {
// 	$("#selYear1").val('${year}');
// 	$("#selYear2").val('${year}');
// }
function getLastYearSeason()
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : "03"
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var season = result[0].WEB_TEXT.substring(7,result[0].WEB_TEXT.length);
			console.log(season);
			season = season.replace("학기", ""); //계절만추출
		 	$("#selYear1").val('${year}');
		 	$("#selYear2").val('${year}');
		 	
			
		 	if(season == "봄")
		 	{
				$("#selSeason1").val(1);
				$("#selSeason2").val(1);
		 	}
		 	else if(season == "여름")
		 	{
				$("#selSeason1").val(2);
				$("#selSeason2").val(2);
		 	}
		 	else if(season == "가을")
		 	{
				$("#selSeason1").val(3);
				$("#selSeason2").val(3);
		 	}
		 	else if(season == "겨울")
		 	{
				$("#selSeason1").val(4);
				$("#selSeason2").val(4);
		 	}
			$(".selSeason1").html(season);
			$(".selSeason2").html(season);
			
			
		}
	});	
}
function setDateFnc()
{
	$.ajax({
		type : "POST", 
		url : "./getStartYmd",
		dataType : "text",
		async : false,
		data : 
		{
			selYear : $("#selYear1").val(),
			selSeason : $("#selSeason1").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			if(data != "")
			{
				$("#start_ymd").val(cutDate(nullChk(data)));
			}
		}
	});	
}
function getList()
{
	var all_tot_person = 0;
	var all_tot_regis_fee = 0;
	var s_tot_person = 0;
	var s_tot_regis_fee = 0;
	var s_web = 0;
	var s_mobile = 0;
	var b_tot_person = 0;
	var b_tot_regis_fee = 0;
	var b_web = 0;
	var b_mobile = 0;
	var p_tot_person = 0;
	var p_tot_regis_fee = 0;
	var p_web = 0;
	var p_mobile = 0;
	var w_tot_person = 0;
	var w_tot_regis_fee = 0;
	var w_web = 0;
	var w_mobile = 0;
	
	var s_web_person = 0;
	var s_mobile_person = 0;
	var b_web_person = 0;
	var b_mobile_person = 0;
	var p_web_person = 0;
	var p_mobile_person = 0;
	var w_web_person = 0;
	var w_mobile_person = 0;
	
	var main_s_person = 0;
	var main_s_regis_fee = 0;
	var main_b_person = 0;
	var main_b_regis_fee = 0;
	var main_p_person = 0;
	var main_p_regis_fee = 0;
	var main_w_person = 0;
	var main_w_regis_fee = 0;
	$.ajax({
		type : "POST", 
		url : "./getPerfor",
		dataType : "text",
		async : false,
		data : 
		{
			selYear1 : $("#selYear1").val(),
			selYear2 : $("#selYear2").val(),
			selSeason1 : $("#selSeason1").val(),
			selSeason2 : $("#selSeason2").val(),
			start_ymd : $("#start_ymd").val(),
			end_ymd : $("#end_ymd").val(),
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
						inner += '<tr class="bg-red">';
						inner += '	<td class="sum">'+result.list[i-1].MAIN_NM+' 계</td>';
						inner += '	<td class="sum"></td>';
						inner += '	<td>'+comma(Number(nullChkZero(main_s_person)) + Number(nullChkZero(main_b_person)) + Number(nullChkZero(main_p_person)) +Number(nullChkZero(main_w_person)))+'</td>';
						inner += '	<td>'+comma(Number(nullChkZero(main_s_regis_fee)) + Number(nullChkZero(main_b_regis_fee)) + Number(nullChkZero(main_p_regis_fee)) + Number(nullChkZero(main_w_regis_fee)))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_s_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_s_regis_fee))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_b_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_b_regis_fee))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_p_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_p_regis_fee))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_w_person))+'</td>';
						inner += '	<td>'+comma(nullChkZero(main_w_regis_fee))+'</td>';
						inner += '	<td></td>';
						inner += '</tr>';
						
						main_s_person = 0;
						main_s_regis_fee = 0;
						main_b_person = 0;
						main_b_regis_fee = 0;
						main_p_person = 0;
						main_p_regis_fee = 0;
						main_w_person = 0;
						main_w_regis_fee = 0;
					}
				}
				inner += '<tr>';
				inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
				inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
				inner += '	<td class="bg-red">'+comma(Number(result.list[i].B_PERSON)+Number(result.list[i].S_PERSON)+Number(result.list[i].W_PERSON)+Number(result.list[i].P_PERSON))+'</td>';
				inner += '	<td class="bg-red">'+comma(Number(result.list[i].B_UPRICE)+Number(result.list[i].S_UPRICE)+Number(result.list[i].W_UPRICE)+Number(result.list[i].P_UPRICE))+'</td>';
				inner += '	<td>'+comma(result.list[i].S_PERSON)+'</td>';
				inner += '	<td>'+comma(result.list[i].S_UPRICE)+'</td>';
				inner += '	<td>'+comma(result.list[i].B_PERSON)+'</td>';
				inner += '	<td>'+comma(result.list[i].B_UPRICE)+'</td>';
				inner += '	<td>'+comma(result.list[i].P_PERSON)+'</td>';
				inner += '	<td>'+comma(result.list[i].P_UPRICE)+'</td>';
				inner += '	<td>'+comma(result.list[i].W_PERSON)+'</td>';
				inner += '	<td>'+comma(result.list[i].W_UPRICE)+'</td>';
				inner += '	<td></td>';
				inner += '</tr>';
				
				s_tot_person += Number(result.list[i].S_PERSON);
				s_tot_regis_fee += Number(result.list[i].S_UPRICE);
				s_web += Number(result.list[i].S_WEB_UPRICE);
				s_mobile += Number(result.list[i].S_MOBILE_UPRICE);
				b_tot_person += Number(result.list[i].B_PERSON);
				b_tot_regis_fee += Number(result.list[i].B_UPRICE);
				b_web += Number(result.list[i].B_WEB_UPRICE);
				b_mobile += Number(result.list[i].B_MOBILE_UPRICE);
				p_tot_person += Number(result.list[i].P_PERSON);
				p_tot_regis_fee += Number(result.list[i].P_UPRICE);
				p_web += Number(result.list[i].P_WEB_UPRICE);
				p_mobile += Number(result.list[i].P_MOBILE_UPRICE);
				w_tot_person += Number(result.list[i].W_PERSON);
				w_tot_regis_fee += Number(result.list[i].W_UPRICE);
				w_web += Number(result.list[i].W_WEB_UPRICE);
				w_mobile += Number(result.list[i].W_MOBILE_UPRICE);
				
				
				s_web_person += Number(result.list[i].S_WEB_PERSON);
				s_mobile_person += Number(result.list[i].S_MOBILE_PERSON);
				b_web_person += Number(result.list[i].B_WEB_PERSON);
				b_mobile_person += Number(result.list[i].B_MOBILE_PERSON);
				p_web_person += Number(result.list[i].P_WEB_PERSON);
				p_mobile_person += Number(result.list[i].P_MOBILE_PERSON);
				w_web_person += Number(result.list[i].W_WEB_PERSON);
				w_mobile_person += Number(result.list[i].W_MOBILE_PERSON);
				
				main_s_person += Number(result.list[i].S_PERSON);
				main_s_regis_fee += Number(result.list[i].S_UPRICE);
				main_b_person += Number(result.list[i].B_PERSON);
				main_b_regis_fee += Number(result.list[i].B_UPRICE);
				main_p_person += Number(result.list[i].P_PERSON);
				main_p_regis_fee += Number(result.list[i].P_UPRICE);
				main_w_person += Number(result.list[i].W_PERSON);
				main_w_regis_fee += Number(result.list[i].W_UPRICE);
				
				if(i == result.list.length-1)
				{
					inner += '<tr class="bg-red">';
					inner += '	<td class="sum">'+result.list[i-1].MAIN_NM+' 계</td>';
					inner += '	<td class="sum"></td>';
					inner += '	<td>'+comma(Number(nullChkZero(main_s_person)) + Number(nullChkZero(main_b_person)) + Number(nullChkZero(main_p_person)) +Number(nullChkZero(main_w_person)))+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(main_s_regis_fee)) + Number(nullChkZero(main_b_regis_fee)) + Number(nullChkZero(main_p_regis_fee)) + Number(nullChkZero(main_w_regis_fee)))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_s_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_s_regis_fee))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_b_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_b_regis_fee))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_p_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_p_regis_fee))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_w_person))+'</td>';
					inner += '	<td>'+comma(nullChkZero(main_w_regis_fee))+'</td>';
					inner += '	<td></td>';
					inner += '</tr>';
				}
				
			}
			
			
			$("#target").html(inner);
		}
	});	
	
	all_tot_person += Number(s_tot_person) + Number(b_tot_person) + Number(p_tot_person) + Number(w_tot_person);
	all_tot_regis_fee += Number(s_tot_regis_fee) + Number(b_tot_regis_fee) + Number(p_tot_regis_fee) + Number(w_tot_regis_fee);
	
	
	$("#all_tot_person").html(comma(all_tot_person));
	$("#all_tot_regis_fee").html(comma(all_tot_regis_fee));
	$("#s_tot_person").html(comma(s_tot_person));
	$("#s_tot_regis_fee").html(comma(s_tot_regis_fee));
	$("#b_tot_person").html(comma(b_tot_person));
	$("#b_tot_regis_fee").html(comma(b_tot_regis_fee));
	$("#p_tot_person").html(comma(p_tot_person));
	$("#p_tot_regis_fee").html(comma(p_tot_regis_fee));
	$("#w_tot_person").html(comma(w_tot_person));
	$("#w_tot_regis_fee").html(comma(w_tot_regis_fee));
	
	$.ajax({
		type : "POST", 
		url : "./getTargetLong",
		dataType : "text",
		async : false,
		data : 
		{
			selYear1 : $("#selYear1").val(),
			selYear2 : $("#selYear2").val(),
			selSeason1 : $("#selSeason1").val(),
			selSeason2 : $("#selSeason2").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var all_taget_person = 0;
			var all_target_regis_fee = 0;
			var b_taget_person = 0;
			var b_target_regis_fee = 0;
			var s_taget_person = 0;
			var s_target_regis_fee = 0;
			var p_taget_person = 0;
			var p_target_regis_fee = 0;
			var w_taget_person = 0;
			var w_target_regis_fee = 0;
			for(var i = 0; i < result.length; i++)
			{
				if(result[i].STORE == "03")
				{
					b_taget_person += nullChkZero(result[i].REGIS_NO);
					b_target_regis_fee += nullChkZero(result[i].PAY);
				}
				else if(result[i].STORE == "02")
				{
					s_taget_person += nullChkZero(result[i].REGIS_NO);
					s_target_regis_fee += nullChkZero(result[i].PAY);
				}
				else if(result[i].STORE == "04")
				{
					p_taget_person += nullChkZero(result[i].REGIS_NO);
					p_target_regis_fee += nullChkZero(result[i].PAY);
				}
				else if(result[i].STORE == "05")
				{
					w_taget_person += nullChkZero(result[i].REGIS_NO);
					w_target_regis_fee += nullChkZero(result[i].PAY);
				}
			}
			all_taget_person = Number(b_taget_person) + Number(s_taget_person) + Number(p_taget_person) + Number(w_taget_person);
			all_target_regis_fee = Number(b_target_regis_fee) + Number(s_target_regis_fee) + Number(p_target_regis_fee) + Number(w_target_regis_fee);
			
			var tmp = all_tot_person / all_taget_person * 100;
			$("#all_target_person").html(tmp.toFixed(2) + "%");
			
			tmp = all_tot_regis_fee / all_target_regis_fee * 100;
			$("#all_target_regis_fee").html(tmp.toFixed(2) + "%");
			
			var all_web = Number(s_web)+Number(b_web)+Number(p_web)+Number(w_web) ;
			var all_mobile = Number(s_mobile)+Number(b_mobile)+Number(p_mobile)+Number(w_mobile) ;
			var all_pos = Number(all_tot_regis_fee) - Number(all_web) - Number(all_mobile);
			
			var all_web_person = Number(s_web_person)+Number(b_web_person)+Number(p_web_person)+Number(w_web_person) ;
			var all_mobile_person = Number(s_mobile_person)+Number(b_mobile_person)+Number(p_mobile_person)+Number(w_mobile_person) ;
			var all_pos_person = Number(all_tot_person) - Number(all_web_person) - Number(all_mobile_person);
			
			var tmp_person = "";
			tmp = Number(all_web) / Number(all_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(all_web_person) / Number(all_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#all_web").html(tmp_person+"% / "+tmp+"%");
			tmp = Number(all_mobile) / Number(all_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(all_mobile_person) / Number(all_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#all_mobile").html(tmp_person+"% / "+tmp+"%");
			tmp = (Number(all_tot_regis_fee) - Number(all_web) - Number(all_mobile)) / Number(all_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = (Number(all_tot_person) - Number(all_web_person) - Number(all_mobile_person)) / Number(all_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#all_pos").html(tmp_person+"% / "+tmp+"%");
			
			if(b_taget_person != 0)
			{
				tmp = b_tot_person / b_taget_person * 100;
				$("#b_target_person").html(tmp.toFixed(2) + "%");
			}
			if(b_target_regis_fee != 0)
			{
				tmp = b_tot_regis_fee / b_target_regis_fee * 100;
				$("#b_target_regis_fee").html(tmp.toFixed(2) + "%");
			}	
			tmp = Number(b_web) / Number(b_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(b_web_person) / Number(b_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#b_web").html(tmp_person+"% / "+tmp+"%");
			tmp = Number(b_mobile) /Number(b_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(b_mobile_person) / Number(b_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#b_mobile").html(tmp_person+"% / "+tmp+"%");
			tmp = (Number(b_tot_regis_fee) - Number(b_web) - Number(b_mobile)) / Number(b_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = (Number(b_tot_person) - Number(b_web_person) - Number(b_mobile_person)) / Number(b_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#b_pos").html(tmp_person+"% / "+tmp+"%");
			

			if(s_taget_person != 0)
			{
				tmp = s_tot_person / s_taget_person * 100;
				$("#s_target_person").html(tmp.toFixed(2) + "%");
			}
			if(s_target_regis_fee != 0)
			{
				tmp = s_tot_regis_fee / s_target_regis_fee * 100;
				$("#s_target_regis_fee").html(tmp.toFixed(2) + "%");
			}	
			tmp = Number(s_web) / Number(s_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(s_web_person) / Number(s_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#s_web").html(tmp_person+"% / "+tmp+"%");
			tmp = Number(s_mobile) /Number(s_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(s_mobile_person) / Number(s_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#s_mobile").html(tmp_person+"% / "+tmp+"%");
			tmp = (Number(s_tot_regis_fee) - Number(s_web) - Number(s_mobile)) / Number(s_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = (Number(s_tot_person) - Number(s_web_person) - Number(s_mobile_person)) / Number(s_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#s_pos").html(tmp_person+"% / "+tmp+"%");
			

			if(p_taget_person != 0)
			{
				tmp = p_tot_person / p_taget_person * 100;
				$("#p_target_person").html(tmp.toFixed(2) + "%");
			}
			if(p_target_regis_fee != 0)
			{
				tmp = p_tot_regis_fee / p_target_regis_fee * 100;
				$("#p_target_regis_fee").html(tmp.toFixed(2) + "%");
			}	
			tmp = Number(p_web) / Number(p_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(p_web_person) / Number(p_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#p_web").html(tmp_person+"% / "+tmp+"%");
			tmp = Number(p_mobile) /Number(p_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(p_mobile_person) / Number(p_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#p_mobile").html(tmp_person+"% / "+tmp+"%");
			tmp = (Number(p_tot_regis_fee) - Number(p_web) - Number(p_mobile)) / Number(p_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = (Number(p_tot_person) - Number(p_web_person) - Number(p_mobile_person)) / Number(p_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#p_pos").html(tmp_person+"% / "+tmp+"%");
			

			if(w_taget_person != 0)
			{
				tmp = w_tot_person / w_taget_person * 100;
				$("#w_target_person").html(tmp.toFixed(2) + "%");
			}
			if(w_target_regis_fee != 0)
			{
				tmp = w_tot_regis_fee / w_target_regis_fee * 100;
				$("#w_target_regis_fee").html(tmp.toFixed(2) + "%");
			}	
			console.log("웹 : "+w_web);
			console.log("모바일 : "+w_mobile);
			console.log("데스크 : "+(Number(w_tot_regis_fee) - Number(w_web) - Number(w_mobile)));
			console.log("전체 : "+w_tot_regis_fee);
			
			tmp = Number(w_web) / Number(w_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(w_web_person) / Number(w_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#w_web").html(tmp_person+"% / "+tmp+"%");
			tmp = Number(w_mobile) /Number(w_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = Number(w_mobile_person) / Number(w_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#w_mobile").html(tmp_person+"% / "+tmp+"%");
			tmp = (Number(w_tot_regis_fee) - Number(w_web) - Number(w_mobile)) / Number(w_tot_regis_fee) * 100;
			tmp = tmp.toFixed(2);
			tmp_person = (Number(w_tot_person) - Number(w_web_person) - Number(w_mobile_person)) / Number(w_tot_person) * 100;
			tmp_person = tmp_person.toFixed(2);
			$("#w_pos").html(tmp_person+"% / "+tmp+"%");
			
			
		}
	});	
		
}
// function getList()
// {
// 	var type_arr = ['1', '2', '3'];
// 	var type_arr_nm = ['정규', '단기', '특강']; 
	
// 	var all_tot_person = 0;
// 	var all_tot_regis_fee = 0;
// 	var b_tot_person = 0;
// 	var b_tot_regis_fee = 0;
// 	var b_web = 0;
// 	var b_mobile = 0;
// 	var s_tot_person = 0;
// 	var s_tot_regis_fee = 0;
// 	var s_web = 0;
// 	var s_mobile = 0;
// 	var p_tot_person = 0;
// 	var p_tot_regis_fee = 0;
// 	var p_web = 0;
// 	var p_mobile = 0;
// 	var w_tot_person = 0;
// 	var w_tot_regis_fee = 0;
// 	var w_web = 0;
// 	var w_mobile = 0;
	
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
			
// 			$.ajax({
// 				type : "POST", 
// 				url : "./getPeri",
// 				dataType : "text",
// 				async : false,
// 				data : 
// 				{
// 					selYear1 : $("#selYear1").val(),
// 					selYear2 : $("#selYear2").val(),
// 					selSeason1 : $("#selSeason1").val(),
// 					selSeason2 : $("#selSeason2").val()
// 				},
// 				error : function() 
// 				{
// 					console.log("AJAX ERROR");
// 				},
// 				success : function(data1) 
// 				{
// 					console.log(data1);
// 					var result1 = JSON.parse(data1);
// 					for(var i = 0; i < type_arr.length; i++)
// 					{
// 						for(var z = 0; z < result.length; z++)
// 						{
// 							$.ajax({
// 								type : "POST", 
// 								url : "./getPerfor",
// 								dataType : "text",
// 								async : false,
// 								data : 
// 								{
// 									b_start_peri : result1.b_start_peri,
// 									b_end_peri : result1.b_end_peri,
// 									s_start_peri : result1.s_start_peri,
// 									s_end_peri : result1.s_end_peri,
// 									p_start_peri : result1.p_start_peri,
// 									p_end_peri : result1.p_end_peri,
// 									w_start_peri : result1.w_start_peri,
// 									w_end_peri : result1.w_end_peri,
// 									subject_fg : type_arr[i],
// 									main_cd : result[z].SUB_CODE
// 								},
// 								error : function() 
// 								{
// 									console.log("AJAX ERROR");
// 								},
// 								success : function(data2) 
// 								{
// 									console.log(data2);
// 									var result2 = JSON.parse(data2);
									
// 									var inner = "";
									
// 									all_tot_person += Number(result2.b_person)+Number(result2.s_person)+Number(result2.p_person)+Number(result2.w_person);
// 									all_tot_regis_fee += Number(result2.b_regis_fee)+Number(result2.s_regis_fee)+Number(result2.p_regis_fee)+Number(result2.w_regis_fee);
// 									b_tot_person += Number(result2.b_person);
// 									b_tot_regis_fee += Number(result2.b_regis_fee);
// 									b_web += Number(result2.b_web);
// 									b_mobile += Number(result2.b_mobile);
// 									s_tot_person += Number(result2.s_person);
// 									s_tot_regis_fee += Number(result2.s_regis_fee);
// 									s_web += Number(result2.s_web);
// 									s_mobile += Number(result2.s_mobile);
// 									p_tot_person += Number(result2.p_person);
// 									p_tot_regis_fee += Number(result2.p_regis_fee);
// 									p_web += Number(result2.p_web);
// 									p_mobile += Number(result2.p_mobile);
// 									w_tot_person += Number(result2.w_person);
// 									w_tot_regis_fee += Number(result2.w_regis_fee);
// 									w_web += Number(result2.w_web);
// 									w_mobile += Number(result2.w_mobile);
									
// 									inner += '<tr>';
// 									inner += '	<td>'+type_arr_nm[i]+'</td>';
// 									inner += '	<td>'+result[z].SHORT_NAME+'</td>';
// 									inner += '	<td class="bg-red">'+comma(Number(result2.b_person)+Number(result2.s_person)+Number(result2.p_person)+Number(result2.w_person))+'</td>';
// 									inner += '	<td class="bg-red">'+comma(Number(result2.b_regis_fee)+Number(result2.s_regis_fee)+Number(result2.p_regis_fee)+Number(result2.w_regis_fee))+'</td>';
// 									inner += '	<td>'+comma(result2.s_person)+'</td>';
// 									inner += '	<td>'+comma(result2.s_regis_fee)+'</td>';
// 									inner += '	<td>'+comma(result2.b_person)+'</td>';
// 									inner += '	<td>'+comma(result2.b_regis_fee)+'</td>';
// 									inner += '	<td>'+comma(result2.p_person)+'</td>';
// 									inner += '	<td>'+comma(result2.p_regis_fee)+'</td>';
// 									inner += '	<td>'+comma(result2.w_person)+'</td>';
// 									inner += '	<td>'+comma(result2.w_regis_fee)+'</td>';
// 									inner += '	<td></td>';
// 									inner += '</tr>';
									
// 									$("#target").append(inner);
// 								}
// 							});	
// 						}
// 					}
// 				}
// 			});	
// 		}
// 	});	
	
// 	$("#all_tot_person").html(comma(all_tot_person));
// 	$("#all_tot_regis_fee").html(comma(all_tot_regis_fee));
// 	$("#s_tot_person").html(comma(s_tot_person));
// 	$("#s_tot_regis_fee").html(comma(s_tot_regis_fee));
// 	$("#b_tot_person").html(comma(b_tot_person));
// 	$("#b_tot_regis_fee").html(comma(b_tot_regis_fee));
// 	$("#p_tot_person").html(comma(p_tot_person));
// 	$("#p_tot_regis_fee").html(comma(p_tot_regis_fee));
// 	$("#w_tot_person").html(comma(w_tot_person));
// 	$("#w_tot_regis_fee").html(comma(w_tot_regis_fee));
	
// 	$.ajax({
// 		type : "POST", 
// 		url : "./getTargetLong",
// 		dataType : "text",
// 		async : false,
// 		data : 
// 		{
// 			selYear1 : $("#selYear1").val(),
// 			selYear2 : $("#selYear2").val(),
// 			selSeason1 : $("#selSeason1").val(),
// 			selSeason2 : $("#selSeason2").val()
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			console.log(data);
// 			var result = JSON.parse(data);
// 			var all_taget_person = 0;
// 			var all_target_regis_fee = 0;
// 			var b_taget_person = 0;
// 			var b_target_regis_fee = 0;
// 			var s_taget_person = 0;
// 			var s_target_regis_fee = 0;
// 			var p_taget_person = 0;
// 			var p_target_regis_fee = 0;
// 			var w_taget_person = 0;
// 			var w_target_regis_fee = 0;
// 			for(var i = 0; i < result.length; i++)
// 			{
// 				if(result[i].STORE == "분당점")
// 				{
// 					b_taget_person += nullChkZero(result[i].REGIS_NO);
// 					b_target_regis_fee += nullChkZero(result[i].PAY);
// 				}
// 				else if(result[i].STORE == "수원점")
// 				{
// 					s_taget_person += nullChkZero(result[i].REGIS_NO);
// 					s_target_regis_fee += nullChkZero(result[i].PAY);
// 				}
// 				else if(result[i].STORE == "평택점")
// 				{
// 					p_taget_person += nullChkZero(result[i].REGIS_NO);
// 					p_target_regis_fee += nullChkZero(result[i].PAY);
// 				}
// 				else if(result[i].STORE == "원주점")
// 				{
// 					w_taget_person += nullChkZero(result[i].REGIS_NO);
// 					w_target_regis_fee += nullChkZero(result[i].PAY);
// 				}
// 			}
// 			all_taget_person = Number(b_taget_person) + Number(s_taget_person) + Number(p_taget_person) + Number(w_taget_person);
// 			all_target_regis_fee = Number(b_target_regis_fee) + Number(s_target_regis_fee) + Number(p_target_regis_fee) + Number(w_target_regis_fee);
			
// 			var tmp = all_tot_person / all_taget_person * 100;
// 			$("#all_target_person").html(tmp.toFixed(2) + "%");
			
// 			tmp = all_tot_regis_fee / all_target_regis_fee * 100;
// 			$("#all_target_regis_fee").html(tmp.toFixed(2) + "%");
			
// 			var all_web = Number(s_web)+Number(b_web)+Number(p_web)+Number(w_web) ;
// 			var all_mobile = Number(s_mobile)+Number(b_mobile)+Number(p_mobile)+Number(w_mobile) ;
// 			var all_pos = Number(all_tot_person) - Number(all_web) - Number(all_mobile);
			
// 			tmp = Number(all_web) / Number(Number(all_web) + Number(all_mobile) + Number(Number(all_tot_person) - Number(all_web) + Number(all_mobile))) * 100;
// 			tmp = tmp.toFixed(2);
// 			$("#all_web").html(tmp+"%");
// 			tmp = Number(all_mobile) / Number(Number(all_web) + Number(all_mobile) + Number(Number(all_tot_person) - Number(all_web) + Number(all_mobile))) * 100;
// 			tmp = tmp.toFixed(2);
// 			$("#all_mobile").html(tmp+"%");
// 			tmp = Number(Number(all_tot_person) - Number(all_web) + Number(all_mobile)) / Number(Number(all_web) + Number(all_mobile) + Number(Number(all_tot_person) - Number(all_web) + Number(all_mobile))) * 100;
// 			tmp = tmp.toFixed(2);
// 			$("#all_pos").html(tmp+"%");
			
// 			if(b_taget_person != 0)
// 			{
// 				tmp = b_tot_person / b_taget_person * 100;
// 				$("#b_target_person").html(tmp.toFixed(2) + "%");
				
// 				tmp = Number(b_web) / Number(Number(b_web) + Number(b_mobile) + Number(Number(b_tot_person) - Number(b_web) + Number(b_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#b_web").html(tmp+"%");
// 				tmp = Number(b_mobile) / Number(Number(b_web) + Number(b_mobile) + Number(Number(b_tot_person) - Number(b_web) + Number(b_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#b_mobile").html(tmp+"%");
// 				tmp = Number(Number(b_tot_person) - Number(b_web) + Number(b_mobile)) / Number(Number(b_web) + Number(b_mobile) + Number(Number(b_tot_person) - Number(b_web) + Number(b_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#b_pos").html(tmp+"%");
// 			}
// 			if(b_target_regis_fee != 0)
// 			{
// 				tmp = b_tot_regis_fee / b_target_regis_fee * 100;
// 				$("#b_target_regis_fee").html(tmp.toFixed(2) + "%");
// 			}

// 			if(s_taget_person != 0)
// 			{
// 				tmp = s_tot_person / s_taget_person * 100;
// 				$("#s_target_person").html(tmp.toFixed(2) + "%");
				
// 				tmp = Number(s_web) / Number(Number(s_web) + Number(s_mobile) + Number(Number(s_tot_person) - Number(s_web) + Number(s_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#s_web").html(tmp+"%");
// 				tmp = Number(s_mobile) / Number(Number(s_web) + Number(s_mobile) + Number(Number(s_tot_person) - Number(s_web) + Number(s_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#s_mobile").html(tmp+"%");
// 				tmp = Number(Number(s_tot_person) - Number(s_web) + Number(s_mobile)) / Number(Number(s_web) + Number(s_mobile) + Number(Number(s_tot_person) - Number(s_web) + Number(s_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#s_pos").html(tmp+"%");
// 			}
// 			if(s_target_regis_fee != 0)
// 			{
// 				tmp = s_tot_regis_fee / s_target_regis_fee * 100;
// 				$("#s_target_regis_fee").html(tmp.toFixed(2) + "%");
// 			}

// 			if(p_taget_person != 0)
// 			{
// 				tmp = p_tot_person / p_taget_person * 100;
// 				$("#p_target_person").html(tmp.toFixed(2) + "%");
				
// 				tmp = Number(p_web) / Number(Number(p_web) + Number(p_mobile) + Number(Number(p_tot_person) - Number(p_web) + Number(p_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#p_web").html(tmp+"%");
// 				tmp = Number(p_mobile) / Number(Number(p_web) + Number(p_mobile) + Number(Number(p_tot_person) - Number(p_web) + Number(p_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#p_mobile").html(tmp+"%");
// 				tmp = Number(Number(p_tot_person) - Number(p_web) + Number(p_mobile)) / Number(Number(p_web) + Number(p_mobile) + Number(Number(p_tot_person) - Number(p_web) + Number(p_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#p_pos").html(tmp+"%");
// 			}
// 			if(p_target_regis_fee != 0)
// 			{
// 				tmp = p_tot_regis_fee / p_target_regis_fee * 100;
// 				$("#p_target_regis_fee").html(tmp.toFixed(2) + "%");
// 			}

// 			if(w_taget_person != 0)
// 			{
// 				tmp = w_tot_person / w_taget_person * 100;
// 				$("#w_target_person").html(tmp.toFixed(2) + "%");
				
// 				tmp = Number(w_web) / Number(Number(w_web) + Number(w_mobile) + Number(Number(w_tot_person) - Number(w_web) + Number(w_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#w_web").html(tmp+"%");
// 				tmp = Number(w_mobile) / Number(Number(w_web) + Number(w_mobile) + Number(Number(w_tot_person) - Number(w_web) + Number(w_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#w_mobile").html(tmp+"%");
// 				tmp = Number(Number(w_tot_person) - Number(w_web) + Number(w_mobile)) / Number(Number(w_web) + Number(w_mobile) + Number(Number(w_tot_person) - Number(w_web) + Number(w_mobile))) * 100;
// 				tmp = tmp.toFixed(2);
// 				$("#w_pos").html(tmp+"%");
// 			}
// 			if(w_target_regis_fee != 0)
// 			{
// 				tmp = w_tot_regis_fee / w_target_regis_fee * 100;
// 				$("#w_target_regis_fee").html(tmp.toFixed(2) + "%");
// 			}
			
// 		}
// 	});	
// }
</script>
<div class="sub-tit">
	<h2>점별 실적</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row">
			<div class="wid-4">
				<select de-data="${year}" id="selYear1" name="selYear1" onchange="setDateFnc()">
					<%
					int year = Utils.checkNullInt(request.getAttribute("year"));
					for(int i = year+1; i > 1980; i--)
					{
						if(i == year)
						{
							%>
							<option value="<%=i%>" selected><%=i%></option>
							<%
						}
						else
						{
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
						}
					}
					%>
				</select>
				<select de-data="봄" id="selSeason1" name="selSeason1" onchange="setDateFnc()">
					<option value="1">봄</option>
					<option value="2">여름</option>
					<option value="3">가을</option>
					<option value="4">겨울</option>									
				</select>
			<span class="dash"> ~ </span>
				<select de-data="${year}" id="selYear2" name="selYear2">
					<%
					for(int i = year+1; i > 1980; i--)
					{
						if(i == year)
						{
							%>
							<option value="<%=i%>" selected><%=i%></option>
							<%
						}
						else
						{
							%>
							<option value="<%=i%>"><%=i%></option>
							<%
						}
					}
					%>
				</select>
				<select de-data="봄" id="selSeason2" name="selSeason2">
					<option value="1">봄</option>
					<option value="2">여름</option>
					<option value="3">가을</option>
					<option value="4">겨울</option>									
				</select>
		</div>
			
			<div class="wid-35">
				<div class="cal-row table">
					<div class="cal-input cal-input02 cal-input_rec">
						<input type="text" class="date-i start-i" id="start_ymd" name="start_ymd"/>
						<i class="material-icons">event_available</i>
					</div>
					<div class="cal-dash">-</div>
					<div class="cal-input cal-input02 cal-input_rec">
						<input type="text" class="date-i ready-i" id="end_ymd" name="end_ymd"/>
						<i class="material-icons">event_available</i>
					</div>
				</div>
			</div>
			
<!-- 			<div class=""> -->
<!-- 				<div class="table table-auto"> -->
<!-- 					<div class="sear-tit sear-tit_70">POS NO</div> -->
<!-- 					<div> -->
<!-- 						<select id="selPos" name="selPos"> -->
<!-- 						</select> -->
<!-- 						 <a class="btn btn02 mrg-l6" onclick="javascript:getProcList();">조회</a>  -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
			
			<div class="wid-15 mag-l2">
				<ul class="chk-ul">
					<li>
						<input type="checkbox" id="isPerformance" name="isPerformance">
						<label for="isPerformance">임시 중분류 포함</label>
					</li>
				</ul>
			</div>
		</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>	




<!-- <div class="table-cap table"> -->
<!-- 	<div class="cap-r text-right"> -->
		
<!-- 		<div class="table table02 table-auto float-right"> -->
<!-- 			<div class="sel-scr"> -->
<!-- 				<a class="bor-btn btn01" onclick="javascript:excel_down();"><i class="fas fa-file-download"></i></a> -->
<!-- 				<select id="listSize" name="listSize" onchange="getLectList(1)" de-data="10개씩 보기"> -->
<!-- 					<option value="10">10개 보기</option> -->
<!-- 					<option value="20">20개 보기</option> -->
<!-- 					<option value="50">50개 보기</option> -->
<!-- 					<option value="100">100개 보기</option> -->
<!-- 					<option value="300">300개 보기</option> -->
<!-- 					<option value="500">500개 보기</option> -->
<!-- 					<option value="1000">1000개 보기</option> -->
<!-- 				</select> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </div> -->


<div class="table-wr ip-list">
	
	<div class="table-list table-stlist ">
		<table>
			<thead>
			
				<tr class="perfor-tr01">
					<th>대분류</th>
					<th>강좌유형</th>
					<th class="col01" colspan="2">전점</th>
					<th colspan="2">수원점</th>
					<th class="col01" colspan="2">분당점</th>
					<th colspan="2">평택점</th>
					<th class="col01" colspan="2">원주점</th>
					<th style="width:32px;"></th>
				</tr>
				
				<tr class="perfor-tr02">
					<th></th>
					<th></th>
					<th class="col02">회원수</th>
					<th class="col02">매출</th>
					<th>회원수</th>
					<th>매출</th>
					<th class="col02">회원수</th>
					<th class="col02">매출</th>
					<th>회원수</th>
					<th>매출</th>
					<th class="col02">회원수</th>
					<th class="col02">매출</th>
					<th style="width:32x;"></th>
				</tr>
				
			</thead>
			
			<tbody id="target">
<!-- 				<tr> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td class="bg-red">13</td> -->
<!-- 					<td class="bg-red">1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td class="bg-red">13</td> -->
<!-- 					<td class="bg-red">1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td class="bg-red">13</td> -->
<!-- 					<td class="bg-red">1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td>13</td> -->
<!-- 					<td>1,500,200</td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
				
				
			</tbody>
		</table>
	</div>
</div>
			


<div class="sta-botfix perfor-fix">
	<ul class="perf01">
		<li class="li01">총 계</li>
		<li><span id="all_tot_person">0</span> <span id="all_tot_regis_fee">0</span></li>
		<li><span id="s_tot_person">0</span> <span id="s_tot_regis_fee">0</span></li>
		<li><span id="b_tot_person">0</span> <span id="b_tot_regis_fee">0</span></li>
		<li><span id="p_tot_person">0</span> <span id="p_tot_regis_fee">0</span></li>
		<li><span id="w_tot_person">0</span> <span id="w_tot_regis_fee">0</span></li>
		<li class="li-last"></li>
	</ul>
	<ul class="perf02">
		<li class="li01">달성률</li>
		<li><span id="all_target_person">0%</span> <span id="all_target_regis_fee">0%</span></li>
		<li><span id="s_target_person">0%</span> <span id="s_target_regis_fee">0%</span></li>
		<li><span id="b_target_person">0%</span> <span id="b_target_regis_fee">0%</span></li>
		<li><span id="p_target_person">0%</span> <span id="p_target_regis_fee">0%</span></li>
		<li><span id="w_target_person">0%</span> <span id="w_target_regis_fee">0%</span></li>
		<li class="li-last"></li>
	</ul>
	<ul class="perf03">
		<li class="li01">오프라인 계</li>
		<li class="li02"></li>
		<li><span id="all_pos">0%</span></li>
		<li><span id="s_pos">0%</span></li>
		<li><span id="b_pos">0%</span></li>
		<li><span id="p_pos">0%</span></li>
		<li><span id="w_pos">0%</span></li>
		<li class="li-last"></li>
	</ul>
	<ul class="perf03">
		<li class="li01">MOBILE 계</li>
		<li class="li02">비중</li>
		<li><span id="all_mobile">0%</span></li>
		<li><span id="s_mobile">0%</span></li>
		<li><span id="b_mobile">0%</span></li>
		<li><span id="p_mobile">0%</span></li>
		<li><span id="w_mobile">0%</span></li>
		<li class="li-last"></li>
	</ul>
	<ul class="perf03">
		<li class="li01">PC 계</li>
		<li class="li02"></li>
		<li><span id="all_web">0%</span></li>
		<li><span id="s_web">0%</span></li>
		<li><span id="b_web">0%</span></li>
		<li><span id="p_web">0%</span></li>
		<li><span id="w_web">0%</span></li>
		<li class="li-last"></li>
	</ul>
	
	
</div>


<script>
$(document).ready(function(){
	getLastYearSeason();
	setDateFnc();
	
	getList();
	
});
</script>
















<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>