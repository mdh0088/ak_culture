<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['Year', '정규 강좌', '단기강좌', '특별강좌'],
    ['남자', 2, 1, 4],
    ['여자', 4, 3, 1]
  ]);

  var options = {
    chart: {
      
    }
  };

  var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

  chart.draw(data, google.charts.Bar.convertOptions(options));
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
	 			$("#search_start").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#search_end").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}
function getList(paging_type) 
{
	var age_0_tot = 0;
	var age_0_web = 0;
	var age_0_mob = 0;
	var age_0_a = 0;
	var age_0_b = 0;
	var age_0_c = 0;
	var age_0_new = 0;
	
	var age_10_tot = 0;
	var age_10_web = 0;
	var age_10_mob = 0;
	var age_10_a = 0;
	var age_10_b = 0;
	var age_10_c = 0;
	var age_10_new = 0;
	
	var age_20_tot = 0;
	var age_20_web = 0;
	var age_20_mob = 0;
	var age_20_a = 0;
	var age_20_b = 0;
	var age_20_c = 0;
	var age_20_new = 0;
	
	var age_30_tot = 0;
	var age_30_web = 0;
	var age_30_mob = 0;
	var age_30_a = 0;
	var age_30_b = 0;
	var age_30_c = 0;
	var age_30_new = 0;
	
	var age_40_tot = 0;
	var age_40_web = 0;
	var age_40_mob = 0;
	var age_40_a = 0;
	var age_40_b = 0;
	var age_40_c = 0;
	var age_40_new = 0;
	
	var age_50_tot = 0;
	var age_50_web = 0;
	var age_50_mob = 0;
	var age_50_a = 0;
	var age_50_b = 0;
	var age_50_c = 0;
	var age_50_new = 0;
	
	var age_60_tot = 0;
	var age_60_web = 0;
	var age_60_mob = 0;
	var age_60_a = 0;
	var age_60_b = 0;
	var age_60_c = 0;
	var age_60_new = 0;
	
	var age_70_tot = 0;
	var age_70_web = 0;
	var age_70_mob = 0;
	var age_70_a = 0;
	var age_70_b = 0;
	var age_70_c = 0;
	var age_70_new = 0;
	
	
	var age_0_best = "";
	var age_10_best = "";
	var age_20_best = "";
	var age_30_best = "";
	var age_40_best = "";
	var age_50_best = "";
	var age_60_best = "";
	var age_70_best = "";
	
	$.ajax({
		type : "POST", 
		url : "./getMemberList",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val(),
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
			if(result.best_list.length > 0)
			{
				$("#list_target").html('');
				for(var i = 0; i < result.best_list.length; i++)
				{
					if(result.best_list[i].AGE == '0' && age_0_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>10대 미만</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_0_best = "Y";
					}
					else if(result.best_list[i].AGE == '10' && age_10_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>10대</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_10_best = "Y";
					}
					else if(result.best_list[i].AGE == '20' && age_20_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>20대</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_20_best = "Y";
					}
					else if(result.best_list[i].AGE == '30' && age_30_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>30대</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_30_best = "Y";
					}
					else if(result.best_list[i].AGE == '40' && age_40_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>40대</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_40_best = "Y";
					}
					else if(result.best_list[i].AGE == '50' && age_50_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>50대</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_50_best = "Y";
					}
					else if(result.best_list[i].AGE == '60' && age_60_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>60대</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_60_best = "Y";
					}
					else if(result.best_list[i].AGE == '70' && age_70_best == "")
					{
						inner = "";
						inner += '<tr>';
						inner += '	<td>70대</td>';
						inner += '	<td>'+nullChk(result.best_list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.best_list[i].WEB_LECTURER_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+nullChk(result.best_list[i].SUBJECT_NM)+'</td>';
						inner += '	<td class="color-blue line-blue">'+comma(nullChkZero(result.best_list[i].REGIS_NO))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.best_list[i].UPRICE))+'</td>';
						inner += '</tr>';
						$("#list_target").append(inner);
						age_70_best = "Y";
					}
				}
			}
			else
			{
				$("#list_target").html('');
			}
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					if(result.list[i].AGE == '0')
					{
						age_0_tot += Number(result.list[i].TOT_CUST);
						age_0_web += Number(result.list[i].WEB_CUST);
						age_0_mob += Number(result.list[i].MOBILE_CUST);
						age_0_a += Number(result.list[i].A_CUST);
						age_0_b += Number(result.list[i].B_CUST);
						age_0_c += Number(result.list[i].C_CUST);
						age_0_new += Number(result.list[i].NEW);
					}
					else if(result.list[i].AGE == '10')
					{
						age_10_tot += Number(result.list[i].TOT_CUST);
						age_10_web += Number(result.list[i].WEB_CUST);
						age_10_mob += Number(result.list[i].MOBILE_CUST);
						age_10_a += Number(result.list[i].A_CUST);
						age_10_b += Number(result.list[i].B_CUST);
						age_10_c += Number(result.list[i].C_CUST);
						age_10_new += Number(result.list[i].NEW);
					}
					else if(result.list[i].AGE == '20')
					{
						age_20_tot += Number(result.list[i].TOT_CUST);
						age_20_web += Number(result.list[i].WEB_CUST);
						age_20_mob += Number(result.list[i].MOBILE_CUST);
						age_20_a += Number(result.list[i].A_CUST);
						age_20_b += Number(result.list[i].B_CUST);
						age_20_c += Number(result.list[i].C_CUST);
						age_20_new += Number(result.list[i].NEW);
					}
					else if(result.list[i].AGE == '30')
					{
						age_30_tot += Number(result.list[i].TOT_CUST);
						age_30_web += Number(result.list[i].WEB_CUST);
						age_30_mob += Number(result.list[i].MOBILE_CUST);
						age_30_a += Number(result.list[i].A_CUST);
						age_30_b += Number(result.list[i].B_CUST);
						age_30_c += Number(result.list[i].C_CUST);
						age_30_new += Number(result.list[i].NEW);
					}
					else if(result.list[i].AGE == '40')
					{
						age_40_tot += Number(result.list[i].TOT_CUST);
						age_40_web += Number(result.list[i].WEB_CUST);
						age_40_mob += Number(result.list[i].MOBILE_CUST);
						age_40_a += Number(result.list[i].A_CUST);
						age_40_b += Number(result.list[i].B_CUST);
						age_40_c += Number(result.list[i].C_CUST);
						age_40_new += Number(result.list[i].NEW);
					}
					else if(result.list[i].AGE == '50')
					{
						age_50_tot += Number(result.list[i].TOT_CUST);
						age_50_web += Number(result.list[i].WEB_CUST);
						age_50_mob += Number(result.list[i].MOBILE_CUST);
						age_50_a += Number(result.list[i].A_CUST);
						age_50_b += Number(result.list[i].B_CUST);
						age_50_c += Number(result.list[i].C_CUST);
						age_50_new += Number(result.list[i].NEW);
					}
					else if(result.list[i].AGE == '60')
					{
						age_60_tot += Number(result.list[i].TOT_CUST);
						age_60_web += Number(result.list[i].WEB_CUST);
						age_60_mob += Number(result.list[i].MOBILE_CUST);
						age_60_a += Number(result.list[i].A_CUST);
						age_60_b += Number(result.list[i].B_CUST);
						age_60_c += Number(result.list[i].C_CUST);
						age_60_new += Number(result.list[i].NEW);
					}
					else if(Number(result.list[i].AGE) >= '70')
					{
						age_70_tot += Number(result.list[i].TOT_CUST);
						age_70_web += Number(result.list[i].WEB_CUST);
						age_70_mob += Number(result.list[i].MOBILE_CUST);
						age_70_a += Number(result.list[i].A_CUST);
						age_70_b += Number(result.list[i].B_CUST);
						age_70_c += Number(result.list[i].C_CUST);
						age_70_new += Number(result.list[i].NEW);
					}
				}
				var tmp = Number(age_0_tot)+Number(age_10_tot)+Number(age_20_tot)+Number(age_30_tot)+Number(age_40_tot)+Number(age_50_tot)+Number(age_60_tot)+Number(age_70_tot);
				$("#tot_cust_all").html(comma(nullChkZero(tmp)));
				var per = Number(age_0_tot) / Number(tmp) * 100;
				$("#tot_cust_0").html(comma(nullChkZero(age_0_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_10_tot) / Number(tmp) * 100;
				$("#tot_cust_10").html(comma(nullChkZero(age_10_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_20_tot) / Number(tmp) * 100;
				$("#tot_cust_20").html(comma(nullChkZero(age_20_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_30_tot) / Number(tmp) * 100;
				$("#tot_cust_30").html(comma(nullChkZero(age_30_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_40_tot) / Number(tmp) * 100;
				$("#tot_cust_40").html(comma(nullChkZero(age_40_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_50_tot) / Number(tmp) * 100;
				$("#tot_cust_50").html(comma(nullChkZero(age_50_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_60_tot) / Number(tmp) * 100;
				$("#tot_cust_60").html(comma(nullChkZero(age_60_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_70_tot) / Number(tmp) * 100;
				$("#tot_cust_70").html(comma(nullChkZero(age_70_tot)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				
				
				tmp = Number(age_0_new)+Number(age_10_new)+Number(age_20_new)+Number(age_30_new)+Number(age_40_new)+Number(age_50_new)+Number(age_60_new)+Number(age_70_new);
				$("#new_cust_all").html(comma(nullChkZero(tmp)));
				per = Number(age_0_new) / Number(tmp) * 100;
				$("#new_cust_0").html(comma(nullChkZero(age_0_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_10_new) / Number(tmp) * 100;
				$("#new_cust_10").html(comma(nullChkZero(age_10_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_20_new) / Number(tmp) * 100;
				$("#new_cust_20").html(comma(nullChkZero(age_20_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_30_new) / Number(tmp) * 100;
				$("#new_cust_30").html(comma(nullChkZero(age_30_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_40_new) / Number(tmp) * 100;
				$("#new_cust_40").html(comma(nullChkZero(age_40_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_50_new) / Number(tmp) * 100;
				$("#new_cust_50").html(comma(nullChkZero(age_50_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_60_new) / Number(tmp) * 100;
				$("#new_cust_60").html(comma(nullChkZero(age_60_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = Number(age_70_new) / Number(tmp) * 100;
				$("#new_cust_70").html(comma(nullChkZero(age_70_new)) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				
				
				tmp = Number(age_0_a)+Number(age_0_b)+Number(age_0_c);
				if(tmp == 0)
				{
					$("#a_0_per").css("height", "0%");
					$("#b_0_per").css("height", "0%");
					$("#c_0_per").css("height", "0%");
					
					$("#a_numb_0").html("0%");
					$("#b_numb_0").html("0%");
					$("#c_numb_0").html("0%");
				}
				else
				{
					per = Number(age_0_a) / Number(tmp) * 100;
					$("#a_0_per").css("height", per+"%");
					$("#a_numb_0").html(per.toFixed(0)+"%");
					per = Number(age_0_b) / Number(tmp) * 100;
					$("#b_0_per").css("height", per+"%");
					$("#b_numb_0").html(per.toFixed(0)+"%");
					per = Number(age_0_c) / Number(tmp) * 100;
					$("#c_0_per").css("height", per+"%");
					$("#c_numb_0").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(age_10_a)+Number(age_10_b)+Number(age_10_c);
				if(tmp == 0)
				{
					$("#a_10_per").css("height", "0%");
					$("#b_10_per").css("height", "0%");
					$("#c_10_per").css("height", "0%");
					
					$("#a_numb_10").html("0%");
					$("#b_numb_10").html("0%");
					$("#c_numb_10").html("0%");
				}
				else
				{
					per = Number(age_10_a) / Number(tmp) * 100;
					$("#a_10_per").css("height", per+"%");
					$("#a_numb_10").html(per.toFixed(0)+"%");
					per = Number(age_10_b) / Number(tmp) * 100;
					$("#b_10_per").css("height", per+"%");
					$("#b_numb_10").html(per.toFixed(0)+"%");
					per = Number(age_10_c) / Number(tmp) * 100;
					$("#c_10_per").css("height", per+"%");
					$("#c_numb_10").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(age_20_a)+Number(age_20_b)+Number(age_20_c);
				if(tmp == 0)
				{
					$("#a_20_per").css("height", "0%");
					$("#b_20_per").css("height", "0%");
					$("#c_20_per").css("height", "0%");
					
					$("#a_numb_20").html("0%");
					$("#b_numb_20").html("0%");
					$("#c_numb_20").html("0%");
				}
				else
				{
					per = Number(age_20_a) / Number(tmp) * 100;
					$("#a_20_per").css("height", per+"%");
					$("#a_numb_20").html(per.toFixed(0)+"%");
					per = Number(age_20_b) / Number(tmp) * 100;
					$("#b_20_per").css("height", per+"%");
					$("#b_numb_20").html(per.toFixed(0)+"%");
					per = Number(age_20_c) / Number(tmp) * 100;
					$("#c_20_per").css("height", per+"%");
					$("#c_numb_20").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(age_30_a)+Number(age_30_b)+Number(age_30_c);
				if(tmp == 0)
				{
					$("#a_30_per").css("height", "0%");
					$("#b_30_per").css("height", "0%");
					$("#c_30_per").css("height", "0%");
					
					$("#a_numb_30").html("0%");
					$("#b_numb_30").html("0%");
					$("#c_numb_30").html("0%");
				}
				else
				{
					per = Number(age_30_a) / Number(tmp) * 100;
					$("#a_30_per").css("height", per+"%");
					$("#a_numb_30").html(per.toFixed(0)+"%");
					per = Number(age_30_b) / Number(tmp) * 100;
					$("#b_30_per").css("height", per+"%");
					$("#b_numb_30").html(per.toFixed(0)+"%");
					per = Number(age_30_c) / Number(tmp) * 100;
					$("#c_30_per").css("height", per+"%");
					$("#c_numb_30").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(age_40_a)+Number(age_40_b)+Number(age_40_c);
				if(tmp == 0)
				{
					$("#a_40_per").css("height", "0%");
					$("#b_40_per").css("height", "0%");
					$("#c_40_per").css("height", "0%");
					
					$("#a_numb_40").html("0%");
					$("#b_numb_40").html("0%");
					$("#c_numb_40").html("0%");
				}
				else
				{
					per = Number(age_40_a) / Number(tmp) * 100;
					$("#a_40_per").css("height", per+"%");
					$("#a_numb_40").html(per.toFixed(0)+"%");
					per = Number(age_40_b) / Number(tmp) * 100;
					$("#b_40_per").css("height", per+"%");
					$("#b_numb_40").html(per.toFixed(0)+"%");
					per = Number(age_40_c) / Number(tmp) * 100;
					$("#c_40_per").css("height", per+"%");
					$("#c_numb_40").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(age_50_a)+Number(age_50_b)+Number(age_50_c);
				if(tmp == 0)
				{
					$("#a_50_per").css("height", "0%");
					$("#b_50_per").css("height", "0%");
					$("#c_50_per").css("height", "0%");
					
					$("#a_numb_50").html("0%");
					$("#b_numb_50").html("0%");
					$("#c_numb_50").html("0%");
				}
				else
				{
					per = Number(age_50_a) / Number(tmp) * 100;
					$("#a_50_per").css("height", per+"%");
					$("#a_numb_50").html(per.toFixed(0)+"%");
					per = Number(age_50_b) / Number(tmp) * 100;
					$("#b_50_per").css("height", per+"%");
					$("#b_numb_50").html(per.toFixed(0)+"%");
					per = Number(age_50_c) / Number(tmp) * 100;
					$("#c_50_per").css("height", per+"%");
					$("#c_numb_50").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(age_60_a)+Number(age_60_b)+Number(age_60_c);
				if(tmp == 0)
				{
					$("#a_60_per").css("height", "0%");
					$("#b_60_per").css("height", "0%");
					$("#c_60_per").css("height", "0%");
					
					$("#a_numb_60").html("0%");
					$("#b_numb_60").html("0%");
					$("#c_numb_60").html("0%");
				}
				else
				{
					per = Number(age_60_a) / Number(tmp) * 100;
					$("#a_60_per").css("height", per+"%");
					$("#a_numb_60").html(per.toFixed(0)+"%");
					per = Number(age_60_b) / Number(tmp) * 100;
					$("#b_60_per").css("height", per+"%");
					$("#b_numb_60").html(per.toFixed(0)+"%");
					per = Number(age_60_c) / Number(tmp) * 100;
					$("#c_60_per").css("height", per+"%");
					$("#c_numb_60").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(age_70_a)+Number(age_70_b)+Number(age_70_c);
				if(tmp == 0)
				{
					$("#a_70_per").css("height", "0%");
					$("#b_70_per").css("height", "0%");
					$("#c_70_per").css("height", "0%");
					
					$("#a_numb_70").html("0%");
					$("#b_numb_70").html("0%");
					$("#c_numb_70").html("0%");
				}
				else
				{
					per = Number(age_70_a) / Number(tmp) * 100;
					$("#a_70_per").css("height", per+"%");
					$("#a_numb_70").html(per.toFixed(0)+"%");
					per = Number(age_70_b) / Number(tmp) * 100;
					$("#b_70_per").css("height", per+"%");
					$("#b_numb_70").html(per.toFixed(0)+"%");
					per = Number(age_70_c) / Number(tmp) * 100;
					$("#c_70_per").css("height", per+"%");
					$("#c_numb_70").html(per.toFixed(0)+"%");
				}
				
				
				var tot = Number(age_0_tot)+Number(age_10_tot)+Number(age_20_tot)+Number(age_30_tot)+Number(age_40_tot)+Number(age_50_tot)+Number(age_60_tot)+Number(age_70_tot);
				var web = Number(age_0_web)+Number(age_10_web)+Number(age_20_web)+Number(age_30_web)+Number(age_40_web)+Number(age_50_web)+Number(age_60_web)+Number(age_70_web);
				var mob = Number(age_0_mob)+Number(age_10_mob)+Number(age_20_mob)+Number(age_30_mob)+Number(age_40_mob)+Number(age_50_mob)+Number(age_60_mob)+Number(age_70_mob);
				var desk = Number(tot) - Number(web) - Number(mob);
				
				tmp = mob / tot * 100;
				$("#mob_per").html(tmp.toFixed(2) + "%");
				tmp = web / tot * 100;
				$("#web_per").html(tmp.toFixed(2) + "%");
				tmp = desk / tot * 100;
				$("#desk_per").html(tmp.toFixed(2) + "%");
				
			}
			else
			{
				$("#tot_cust_all").html(0);
				$("#tot_cust_0").html(0);
				$("#tot_cust_10").html(0);
				$("#tot_cust_20").html(0);
				$("#tot_cust_30").html(0);
				$("#tot_cust_40").html(0);
				$("#tot_cust_50").html(0);
				$("#tot_cust_60").html(0);
				$("#tot_cust_70").html(0);
				$("#new_cust_all").html(0);
				$("#new_cust_0").html(0);
				$("#new_cust_10").html(0);
				$("#new_cust_20").html(0);
				$("#new_cust_30").html(0);
				$("#new_cust_40").html(0);
				$("#new_cust_50").html(0);
				$("#new_cust_60").html(0);
				$("#new_cust_70").html(0);
				$("#a_0_per").css("height", "0%");
				$("#b_0_per").css("height", "0%");
				$("#c_0_per").css("height", "0%");
				$("#a_10_per").css("height", "0%");
				$("#b_10_per").css("height", "0%");
				$("#c_10_per").css("height", "0%");
				$("#a_20_per").css("height", "0%");
				$("#b_20_per").css("height", "0%");
				$("#c_20_per").css("height", "0%");
				$("#a_30_per").css("height", "0%");
				$("#b_30_per").css("height", "0%");
				$("#c_30_per").css("height", "0%");
				$("#a_40_per").css("height", "0%");
				$("#b_40_per").css("height", "0%");
				$("#c_40_per").css("height", "0%");
				$("#a_50_per").css("height", "0%");
				$("#b_50_per").css("height", "0%");
				$("#c_50_per").css("height", "0%");
				$("#a_60_per").css("height", "0%");
				$("#b_60_per").css("height", "0%");
				$("#c_60_per").css("height", "0%");
				$("#a_70_per").css("height", "0%");
				$("#b_70_per").css("height", "0%");
				$("#c_70_per").css("height", "0%");
				$("#mob_per").html('0%');
				$("#web_per").html('0%');
				$("#desk_per").html('0%');
			}
			var a_m_cust = 0;
			var a_f_cust = 0;
			var a_x_cust = 0;
			var b_m_cust = 0;
			var b_f_cust = 0;
			var b_x_cust = 0;
			var c_m_cust = 0;
			var c_f_cust = 0;
			var c_x_cust = 0;
			
			if(result.gender_list.length > 0)
			{
				for(var i = 0; i < result.gender_list.length; i++)
				{
					if(result.gender_list[i].SEX_FG == 'M')
					{
						a_m_cust += Number(result.gender_list[i].A_CUST);
						b_m_cust += Number(result.gender_list[i].B_CUST);
						c_m_cust += Number(result.gender_list[i].C_CUST);
					}
					else if(result.gender_list[i].SEX_FG == 'F')
					{
						a_f_cust += Number(result.gender_list[i].A_CUST);
						b_f_cust += Number(result.gender_list[i].B_CUST);
						c_f_cust += Number(result.gender_list[i].C_CUST);
					}
					else
					{
						a_x_cust += Number(result.gender_list[i].A_CUST);
						b_x_cust += Number(result.gender_list[i].B_CUST);
						c_x_cust += Number(result.gender_list[i].C_CUST);
					}
				}
				tmp = Number(a_m_cust)+Number(a_f_cust)+Number(a_x_cust)+Number(b_m_cust)+Number(b_f_cust)+Number(b_x_cust)+Number(c_m_cust)+Number(c_f_cust)+Number(c_x_cust);
				$("#tot_gender_all").html(comma(nullChkZero(tmp)));
				per = (Number(a_m_cust)+Number(b_m_cust)+Number(c_m_cust)) / Number(tmp) * 100;
				$("#tot_gender_m").html(comma(nullChkZero((Number(a_m_cust)+Number(b_m_cust)+Number(c_m_cust)))) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = (Number(a_f_cust)+Number(b_f_cust)+Number(c_f_cust)) / Number(tmp) * 100;
				$("#tot_gender_f").html(comma(nullChkZero((Number(a_f_cust)+Number(b_f_cust)+Number(c_f_cust)))) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				per = (Number(a_x_cust)+Number(b_x_cust)+Number(c_x_cust)) / Number(tmp) * 100;
				$("#tot_gender_x").html(comma(nullChkZero((Number(a_x_cust)+Number(b_x_cust)+Number(c_x_cust)))) + ' <span class="per blue">'+per.toFixed(0)+'%</span>');
				
				
				tmp = Number(a_m_cust)+Number(b_m_cust)+Number(c_m_cust);
				
				if(tmp == 0)
				{
					$("#a_m_per").css("height", "0%");
					$("#b_m_per").css("height", "0%");
					$("#c_m_per").css("height", "0%");
					
					$("#a_numb_m").html("0%");
					$("#b_numb_m").html("0%");
					$("#c_numb_m").html("0%");
				}
				else
				{
					per = Number(a_m_cust) / Number(tmp) * 100;
					$("#a_m_per").css("height", per+"%");
					$("#a_numb_m").html(per.toFixed(0)+"%");
					per = Number(b_m_cust) / Number(tmp) * 100;
					$("#b_m_per").css("height", per+"%");
					$("#b_numb_m").html(per.toFixed(0)+"%");
					per = Number(c_m_cust) / Number(tmp) * 100;
					$("#c_m_per").css("height", per+"%");
					$("#c_numb_m").html(per.toFixed(0)+"%");
				}
				
				tmp = Number(a_f_cust)+Number(b_f_cust)+Number(c_f_cust);
				
				if(tmp == 0)
				{
					$("#a_f_per").css("height", "0%");
					$("#b_f_per").css("height", "0%");
					$("#c_f_per").css("height", "0%");
					
					$("#a_numb_f").html("0%");
					$("#b_numb_f").html("0%");
					$("#c_numb_f").html("0%");
				}
				else
				{
					per = Number(a_f_cust) / Number(tmp) * 100;
					$("#a_f_per").css("height", per+"%");
					$("#a_numb_f").html(per.toFixed(0)+"%");
					per = Number(b_f_cust) / Number(tmp) * 100;
					$("#b_f_per").css("height", per+"%");
					$("#b_numb_f").html(per.toFixed(0)+"%");
					per = Number(c_f_cust) / Number(tmp) * 100;
					$("#c_f_per").css("height", per+"%");
					$("#c_numb_f").html(per.toFixed(0)+"%");
				}
			}
			else
			{
				$("#tot_gender_all").html(0);
				$("#tot_gender_m").html('0 <span class="per blue">0%</span>');
				$("#tot_gender_f").html('0 <span class="per blue">0%</span>');
				$("#tot_gender_x").html('0 <span class="per blue">0%</span>');
				$("#a_m_per").css("height", "0%");
				$("#b_m_per").css("height", "0%");
				$("#c_m_per").css("height", "0%");
				$("#a_f_per").css("height", "0%");
				$("#b_f_per").css("height", "0%");
				$("#c_f_per").css("height", "0%");
			}
		}
	});	
		
}
</script>
<div class="sub-tit">
	<h2>전체 회원 통계</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	
<div class="table-top table-top02">
	<div class="top-row">	
		<div class="">
				<div class="table table-auto">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<div class="sel-scr oddn-sel">
					<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
				</div>
			</div>		
			<div class="mag-lr2">
				<div class="table table-auto">
					<div class="cal-row">
						<div class="cal-input cal-input02 cal-input_rec">
							<input type="text" class="date-i start-i" id="search_start" name="search_start"/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input cal-input02 cal-input_rec">
							<input type="text" class="date-i ready-i" id="search_end" name="search_end"/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
<!-- 		<div class=""> -->
<!-- 			<div class="table table-auto"> -->
<!-- 				<div> -->
<!-- 					<select id="gubun" name="gubun" de-data="2019"> -->
<!-- 						<option value="">전체</option> -->
<!-- 						<option value="1">진행</option> -->
<!-- 						<option value="2">종료</option> -->
<!-- 						<option value="3">대기중</option> -->
<!-- 					</select> -->
<!-- 					<select id="gubun" name="gubun" de-data="봄학기"> -->
<!-- 						<option value="">전체</option> -->
<!-- 						<option value="1">진행</option> -->
<!-- 						<option value="2">종료</option> -->
<!-- 						<option value="3">대기중</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
<!-- 		<div class="mag-lr2"> -->
<!-- 			<div class="table table-auto"> -->
<!-- 				<div class="cal-row"> -->
<!-- 					<div class="cal-input cal-input02 cal-input_170"> -->
<%-- 						<input type="text" id="search_start" name="search_start" value="${search_start}" class="date-i" /> --%>
<!-- 						<i class="material-icons">event_available</i> -->
<!-- 					</div> -->
<!-- 					<div class="cal-dash">-</div> -->
<!-- 					<div class="cal-input cal-input02 cal-input_170"> -->
<%-- 						<input type="text" id="search_end" name="search_end" value="${search_end}" class="date-i" /> --%>
<!-- 						<i class="material-icons">event_available</i> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-4"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit_left">지점</div> -->
<!-- 				<div> -->
<!-- 					<ul class="chk-ul"> -->
<!-- 						<li> -->
<!-- 							<input type="checkbox" id="code_fg_b"  onclick="fg_change();"/> -->
<!-- 							<label for="code_fg_b">분당점</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="checkbox" id="code_fg_b"  onclick="fg_change();"/> -->
<!-- 							<label for="code_fg_b">수원점</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="checkbox" id="code_fg_b"  onclick="fg_change();"/> -->
<!-- 							<label for="code_fg_b">평택점</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="checkbox" id="code_fg_b"  onclick="fg_change();"/> -->
<!-- 							<label for="code_fg_b">원주점</label> -->
<!-- 						</li> -->
<!-- 					</ul> -->
					
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
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




<div class="table-wr">

	<div class="tab-wrap tab-wrap_stat">		
		<div class="tab-title">
			<ul>
				<li class="active">회원 연령별 현황</li>
				<li>회원 성별 현황</li>
			</ul>
		</div> <!-- tab-title end -->
		
		<div class="tab-content">
		
			<div class="stage_cont active">
				<div class="stat-top stat-top_total stat-top_total01">
					<div class="total">
						<span>총 회원수</span>
						<p id="tot_cust_all"></p>
					</div>
					<div>
						<span>10대 미만</span>
						<p id="tot_cust_0"><span class="per blue"></span></p>
					</div>
					<div>
						<span>10대</span>
						<p id="tot_cust_10"><span class="per blue"></span></p>
					</div>
					<div>
						<span>20대</span>
						<p id="tot_cust_20"><span class="per blue"></span></p>
					</div>
					<div>
						<span>30대</span>
						<p id="tot_cust_30"><span class="per blue"></span></p>
					</div>
					<div>
						<span>40대</span>
						<p id="tot_cust_40"><span class="per blue"></span></p>
					</div>
					<div>
						<span>50대</span>
						<p id="tot_cust_50"><span class="per blue"></span></p>
					</div>
					<div>
						<span>60대</span>
						<p id="tot_cust_60"><span class="per blue"></span></p>
					</div>
					<div>
						<span>70대 이상</span>
						<p id="tot_cust_70"><span class="per blue"></span></p>
					</div>
				</div>
				
				<div class="stat-top stat-top_total stat-top_total02">
					<div class="total total02">
						<span>신규 회원수</span>
						<p id="new_cust_all"></p>
					</div>
					<div>
						<span>10대 미만</span>
						<p id="new_cust_0"><span class="per blue"></span></p>
					</div>
					<div>
						<span>10대</span>
						<p id="new_cust_10"><span class="per blue"></span></p>
					</div>
					<div>
						<span>20대</span>
						<p id="new_cust_20"><span class="per blue"></span></p>
					</div>
					<div>
						<span>30대</span>
						<p id="new_cust_30"><span class="per blue"></span></p>
					</div>
					<div>
						<span>40대</span>
						<p id="new_cust_40"><span class="per blue"></span></p>
					</div>
					<div>
						<span>50대</span>
						<p id="new_cust_50"><span class="per blue"></span></p>
					</div>
					<div>
						<span>60대</span>
						<p id="new_cust_60"><span class="per blue"></span></p>
					</div>
					<div>
						<span>70대 이상</span>
						<p id="new_cust_70"><span class="per blue"></span></p>
					</div>
				</div>
				
				<div class="stat-gender_barwrap">
					<h3>회원 성별 현황 그래프</h3>
					<ul>
						<li><span class="col01"></span> 정규 강좌</li>
						<li><span class="col02"></span> 단기 강좌</li>
						<li><span class="col03"></span> 특별 강좌</li>
					</ul>
					
					<div class="chart-wrap" id="bar-chart">
						<div class="line">
							<ul>
								<li><span>100</span></li>	
								<li><span>75</span></li>
								<li><span>50</span></li>
								<li><span>25</span></li>
								<li><span>0</span></li>
							</ul>
						</div>	
						<div class="data-wrap">
							<div>
								<p id="a_numb_0" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_0" class="data-numb"></p>
								<p id="c_numb_0" class="data-numb" style="margin-left:27px"></p>
								<div id="a_0_per" class="col01" style="height:0%;"></div>
								<div id="b_0_per" class="col02" style="height:0%;"></div>
								<div id="c_0_per" class="col03" style="height:0%;"></div>
								<p class="txt">10대 미만</p>
							</div>
							
							<div>
								<p id="a_numb_10" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_10" class="data-numb"></p>
								<p id="c_numb_10" class="data-numb" style="margin-left:27px"></p>
								<div id="a_10_per" class="col01" style="height:0%;"></div>
								<div id="b_10_per" class="col02" style="height:0%;"></div>
								<div id="c_10_per" class="col03" style="height:0%;"></div>
								<p class="txt">10대</p>
							</div>
							
							<div>
								<p id="a_numb_20" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_20" class="data-numb"></p>
								<p id="c_numb_20" class="data-numb" style="margin-left:27px"></p>
								<div id="a_20_per" class="col01" style="height:0%;"></div>
								<div id="b_20_per" class="col02" style="height:0%;"></div>
								<div id="c_20_per" class="col03" style="height:0%;"></div>
								<p class="txt">20대</p>
							</div>
							
							<div>
								<p id="a_numb_30" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_30" class="data-numb"></p>
								<p id="c_numb_30" class="data-numb" style="margin-left:27px"></p>
								<div id="a_30_per" class="col01" style="height:0%;"></div>
								<div id="b_30_per" class="col02" style="height:0%;"></div>
								<div id="c_30_per" class="col03" style="height:0%;"></div>
								<p class="txt">30대</p>
							</div>
							
							<div>
								<p id="a_numb_40" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_40" class="data-numb"></p>
								<p id="c_numb_40" class="data-numb" style="margin-left:27px"></p>
								<div id="a_40_per" class="col01" style="height:0%;"></div>
								<div id="b_40_per" class="col02" style="height:0%;"></div>
								<div id="c_40_per" class="col03" style="height:0%;"></div>
								<p class="txt">40대</p>
							</div>
							
							<div>
								<p id="a_numb_50" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_50" class="data-numb"></p>
								<p id="c_numb_50" class="data-numb" style="margin-left:27px"></p>
								<div id="a_50_per" class="col01" style="height:0%;"></div>
								<div id="b_50_per" class="col02" style="height:0%;"></div>
								<div id="c_50_per" class="col03" style="height:0%;"></div>
								<p class="txt">50대</p>
							</div>
							
							<div>
								<p id="a_numb_60" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_60" class="data-numb"></p>
								<p id="c_numb_60" class="data-numb" style="margin-left:27px"></p>
								<div id="a_60_per" class="col01" style="height:0%;"></div>
								<div id="b_60_per" class="col02" style="height:0%;"></div>
								<div id="c_60_per" class="col03" style="height:0%;"></div>
								<p class="txt">60대</p>
							</div>
							
							<div>
								<p id="a_numb_70" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_70" class="data-numb"></p>
								<p id="c_numb_70" class="data-numb" style="margin-left:27px"></p>
								<div id="a_70_per" class="col01" style="height:0%;"></div>
								<div id="b_70_per" class="col02" style="height:0%;"></div>
								<div id="c_70_per" class="col03" style="height:0%;"></div>
								<p class="txt">70대 이상</p>
							</div>
							
						</div>
						
					</div>
				</div>
				
				<div class="statmem-wrap">
					<div class="smem-box">
					
						<div>
							모바일 회원현황
							<span id="mob_per"></span>
						</div>
						
						<div>
							웹 회원현황
							<span id="web_per"></span>
						</div>
						
						<div>
							오프라인 회원현황
							<span id="desk_per"></span>
						</div>		
						
					</div>	
				</div> <!-- // statmem-wrap end -->
				
				
				<div class="table-wr">
					<div class="cap-l">
						<h2>연령별 인기 강좌</h2>
					</div>
					<div class="table-list" >
						<table>
							<colgroup>
								<col width="80px">
								<col>
								<col>
								<col>
								<col width="50%">
								<col>
								<col>
							</colgroup>
							<thead>
								<tr class="table-stptr01">
									<th>연령<img src="/img/th_up.png"></th>
									<th>대분류<img src="/img/th_up.png"></th>
									<th>중분류<img src="/img/th_up.png"></th>
									<th>강사명<img src="/img/th_up.png"></th>
									<th>강좌명<img src="/img/th_up.png"></th>
									<th>현원<img src="/img/th_up.png"></th>
									<th>매출<img src="/img/th_up.png"></th>
								</tr>				
								
							</thead>
							
							<tbody id="list_target">
<!-- 								<tr> -->
<!-- 									<td>10대 미만</td> -->
<!-- 									<td></td> -->
<!-- 									<td>건강/웰빙</td> -->
<!-- 									<td class="color-blue line-blue">이호걸</td> -->
<!-- 									<td class="color-blue line-blue">일요 밸런스 요가</td> -->
<!-- 									<td class="color-blue line-blue">24</td> -->
<!-- 									<td>120,000,000</td> -->
<!-- 								</tr> -->
								
<!-- 								<tr> -->
<!-- 									<td>10대 미만</td> -->
<!-- 									<td>건강/웰빙</td> -->
<!-- 									<td class="color-blue line-blue">이호걸</td> -->
<!-- 									<td class="color-blue line-blue">일요 밸런스 요가</td> -->
<!-- 									<td class="color-blue line-blue">24</td> -->
<!-- 									<td>120,000,000</td> -->
<!-- 								</tr> -->
								
<!-- 								<tr> -->
<!-- 									<td>10대 미만</td> -->
<!-- 									<td>건강/웰빙</td> -->
<!-- 									<td class="color-blue line-blue">이호걸</td> -->
<!-- 									<td class="color-blue line-blue">일요 밸런스 요가</td> -->
<!-- 									<td class="color-blue line-blue">24</td> -->
<!-- 									<td>120,000,000</td> -->
<!-- 								</tr> -->
								
<!-- 								<tr> -->
<!-- 									<td>10대 미만</td> -->
<!-- 									<td>건강/웰빙</td> -->
<!-- 									<td class="color-blue line-blue">이호걸</td> -->
<!-- 									<td class="color-blue line-blue">일요 밸런스 요가</td> -->
<!-- 									<td class="color-blue line-blue">24</td> -->
<!-- 									<td>120,000,000</td> -->
<!-- 								</tr> -->
								
<!-- 								<tr> -->
<!-- 									<td>10대 미만</td> -->
<!-- 									<td>건강/웰빙</td> -->
<!-- 									<td class="color-blue line-blue">이호걸</td> -->
<!-- 									<td class="color-blue line-blue">일요 밸런스 요가</td> -->
<!-- 									<td class="color-blue line-blue">24</td> -->
<!-- 									<td>120,000,000</td> -->
<!-- 								</tr> -->
								
<!-- 								<tr> -->
<!-- 									<td>10대 미만</td> -->
<!-- 									<td>건강/웰빙</td> -->
<!-- 									<td class="color-blue line-blue">이호걸</td> -->
<!-- 									<td class="color-blue line-blue">일요 밸런스 요가</td> -->
<!-- 									<td class="color-blue line-blue">24</td> -->
<!-- 									<td>120,000,000</td> -->
<!-- 								</tr> -->
								
							</tbody>
						</table>
					</div>
				</div>
				
				
			</div> <!-- //stage_cont 회원 연령별 현황 -->
			
			
			
			
			
			<div class="stgender_cont">
				<div class="stat-top">
<!-- 					<div class="total"> -->
<!-- 						<span>총 회원수</span> -->
<!-- 						<p id="tot_cust_all">100</p> -->
<!-- 					</div> -->
<!-- 					<div> -->
<!-- 						<span>10대 미만</span> -->
<!-- 						<p id="tot_cust_0">10 <span class="per blue">50%</span></p> -->
<!-- 					</div> -->
					<div class="total">
						<span>총 회원수</span>
						<p id="tot_gender_all"></p>
					</div>
					<div>
						<span>남자 회원수</span>
						<p id="tot_gender_m"><span class="per blue"></span></p>
					</div>
					<div>
						<span>여자 회원수</span>
						<p id="tot_gender_f"><span class="per blue"></span></p>
					</div>
					<div>
						<span>성별 미확인 회원수</span>
						<p id="tot_gender_x"><span class="per blue"></span></p>
					</div>
				</div>
				
				<div class="stat-gender_barwrap">
					<h3>회원 성별 현황 그래프</h3>
					<ul>
						<li><span class="col01"></span> 정규 강좌</li>
						<li><span class="col02"></span> 단기 강좌</li>
						<li><span class="col03"></span> 특별 강좌</li>
					</ul>
					
					
					
<!-- 					<ul> -->
<!-- 								<li><span>100</span></li>	 -->
<!-- 								<li><span>75</span></li> -->
<!-- 								<li><span>50</span></li> -->
<!-- 								<li><span>25</span></li> -->
<!-- 								<li><span>0</span></li> -->
<!-- 							</ul> -->
<!-- 						</div>	 -->
<!-- 						<div class="data-wrap"> -->
<!-- 							<div> -->
<!-- 								<div id="a_0_per" class="col01" style="height:100%;"></div> -->
<!-- 								<div id="b_0_per" class="col02" style="height:50%;"></div> -->
<!-- 								<div id="c_0_per" class="col03" style="height:10%;"></div> -->
<!-- 								<p class="txt">10대 미만</p> -->
<!-- 							</div> -->
					
					<div class="chart-wrap" id="bar-chart">
						<div class="line">
							<ul>
								<li><span>100</span></li>	
								<li><span>75</span></li>
								<li><span>50</span></li>
								<li><span>25</span></li>
								<li><span>0</span></li>
							</ul>
						</div>	
						<div class="data-wrap">
							<div>
								<p id="a_numb_m" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_m" class="data-numb"></p>
								<p id="c_numb_m" class="data-numb" style="margin-left:27px"></p>
								<div id="a_m_per" class="col01" style="height:0%;"></div>
								<div id="b_m_per" class="col02" style="height:0%;"></div>
								<div id="c_m_per" class="col03" style="height:0%;"></div>
								<p class="txt">남자</p>
							</div>
							
							<div>
								<p id="a_numb_f" class="data-numb" style="margin-left:-27px"></p>
								<p id="b_numb_f" class="data-numb"></p>
								<p id="c_numb_f" class="data-numb" style="margin-left:27px"></p>
								<div id="a_f_per" class="col01" style="height:0%;"></div>
								<div id="b_f_per" class="col02" style="height:0%;"></div>
								<div id="c_f_per" class="col03" style="height:0%;"></div>
								<p class="txt">여자</p>
							</div>
							
						</div>
						
						
					
					</div>
				</div>
				
			</div> <!-- //stgender_cont 회원 성별 현황 -->
		</div>
	</div>
</div>




<script>
$(document).ready(function() {
	setPeri();
	fncPeri();
	selPeri();
	getList();
});

</script>












<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>