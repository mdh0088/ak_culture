<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/function.js"></script>
<script>
$(document).ready(function(){
	var attend_value ="${attend_value}".split('|');
	var period = attend_value[0].split('_');
	var cnt=0;
	$('.page').empty();
	var inner ="";
	for (var i = 0; i < attend_value.length-1; i++) 
	{
		inner ="";
		inner +='<div style="page-break-after:always">';
		inner +='<div class="table start-div" >';
		inner +='	<div>기수 : <span class="period_'+cnt+'">'+period[1]+'</span></div>';
		inner +='	<div>강좌 : <strong class="subject_nm subject_nm_'+cnt+'"></strong> (<span class="subject_cd_'+cnt+'"></span>)</div>';
		inner +='</div>';
		
		inner +='<div class="table">';
		inner +='	<div>강의기간 : <span class="lect_ymd_'+cnt+'"></span></div><br>';
		inner +='	<div>강의시간 : <span class="lect_hour_'+cnt+'"></span></div><br>';
		inner +='	<div>강사 : <span class="lecr_nm_'+cnt+'"></span></div>';
		inner +='</div>';
		
		inner +='<table class="excelTable_+'+cnt+'">';
		inner +='	<colgroup class="list_colgroup_'+cnt+'">';
		inner +='	</colgroup>';
		inner +='	<thead class="list_head_target_'+cnt+'">';
		inner +='	</thead>';
		inner +='	<tbody class="list_target_'+cnt+'">';
		inner +='	</tbody>';
		inner +='</table>';
		inner +='<div>';
		
		$('.page').append(inner);
		getData(cnt,attend_value[i]);
		cnt++;
	}
	window.print();
	setTimeout("window.close();", 500);
});


function getData(idx,attend_value){
	var arr = attend_value.split('_');
	$.ajax({
		type : "POST", 
		url : "./getCustAttendList",
		dataType : "text",
		async: false,
		data : 
		{
			listSize : 100,
			store : arr[0],
			period : arr[1],
			subject_cd : arr[2]
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			var inner="";
			
			$('.subject_nm_'+idx).text(result.subject_nm);
			$('.subject_cd_'+idx).text(result.subject_cd);
			$('.lect_ymd_'+idx).text(cutDate(result.start_ymd)+ '~' +cutDate(result.end_ymd));
			$('.lect_hour_'+idx).text(cutLectHour(result.lect_hour));
			$('.lecr_nm_'+idx).text(result.web_lecturer_nm);
			var day_chk_arr =result.day_chk.split('|');
			
			inner +='		<tr>';
			inner +='			<th class="td-chk">NO. </th>';
			inner +='			<th>회원명 </th>';
			inner +='			<th>자녀명 </th>';
			inner +='			<th>구분</th>';
			inner +='			<th>회원번호 </th>';
			inner +='			<th>전화번호 </th>';
			inner +='			<th>차량번호 </th>';
			
			for (var i = 0; i < day_chk_arr.length-1; i++) 
			{
				inner +='		<th class="chk-date">';
				inner +='			'+day_chk_arr[i].substr(4,2)+'/<br>'+day_chk_arr[i].substr(6,2)+'';
				inner +='		</th>'
			}
			
			inner +='		</tr>';
			$('.list_head_target_'+idx).html(inner);
			
			var col_inner ="";
			col_inner += '		<col width="20px">';
			col_inner += '		<col width="50px">';
			col_inner += '		<col width="50px">';
			col_inner += '		<col width="50px">';
			col_inner += '		<col width="60px">';
			col_inner += '		<col width="60px">';
			col_inner += '		<col width="60px">';
			for (var i = 0; i < day_chk_arr.length-1; i++) 
			{
				col_inner +='<col>';
			}
			//col_inner += '		<col width="40px">';
			$('.list_colgroup_'+idx).html(col_inner);
			
			inner="";
			if (result.list.length > 0 ) 
			{
				/*
				//TEST AREA
				var test1 ="";
				var test2 ="";
				var test3 ="";
				var test4 ="";
				var test5 ="";
				var test6 ="";
				var test7 ="";
				//TEST AREA
				*/
				for(var i = 0; i < result.list.length; i++)
				{
					/*
					//TEST AREA
					if (i==0) 
					{
						test1 =nullChk(result.list[i].PARENT_NM);
						test2 =nullChk(result.list[i].KIDS_NM);
						test3 =nullChk(result.list[i].CUST_FG);
						test4 =nullChk(result.list[i].CUST_NO);
						test5 =phone_masking(nullChk(result.list[i].PHONE_NO));
						test6 =nullChk(result.list[i].CAR_NO);
					}
					//TEST AREA
					*/
					dayChk = result.list[i].DAY_CHK.split('|');
					inner += '<tr>';
					inner += '	<td class="td-chk">'+(i+1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PARENT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].KIDS_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUST_NO)+'</td>';
					inner += '	<td>'+phone_masking(nullChk(result.list[i].PHONE_NO))+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CAR_NO)+'</td>';
					for (var j = 0; j < day_chk_arr.length-1; j++)  //임시 설정
					{
						
						if (dayChk[j]=="O") 
						{
							inner += '	<td>'+dayChk[j]+'</td>';
						}
						else
						{
							inner += '	<td></td>';
						}
					}
					//inner += '	<td>'+nullChk(result.list[i].CONTENT)+'</td>';
					inner += '</tr>';
				}
				/*
				//TEST AREA
				for (var i = 0; i < 10; i++) {
					inner += '<tr>';
					inner += '	<td class="td-chk">'+(i+1)+'</td>';
					inner += '	<td>'+test1+'</td>';
					inner += '	<td>'+test2+'</td>';
					inner += '	<td>'+test3+'</td>';
					inner += '	<td>'+test4+'</td>';
					inner += '	<td>'+test5+'</td>';
					inner += '	<td>'+test6+'</td>';
					inner += '	<td>06/19</td>';
					inner += '</tr>';
				}
				//TEST AREA
				*/
				
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="'+(6+day_chk_arr.length)+'"><div class="no-data">수강생이 없습니다.</div></td>';
				inner += '</tr>';
			}
			
		
			
			$(".list_target_"+idx).html(inner);
		}
	});	
}

</script>
<style type="text/css">
@page { 
	size: a4;
	margin: 6mm 6mm 5mm 4mm; 
	
}
@media print {
	html, body { height: auto; }
	
  table { page-break-after:auto }
  tr    { page-break-inside:avoid; page-break-after:auto }
  td    { page-break-inside:avoid; page-break-after:auto }
  thead { display:table-header-group }
  tfoot { display:table-footer-group }
	*{
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
		font-size:10px;
		line-height:1.6;
		padding:0;
		margin:0;
		box-sizing:border-box;
		word-break:normal;
		
	}
	table td, table th {
		border:0;
		border: 1px solid #e0e0e0;
		padding:2px;
		font-size:11px;
		text-align:Center;
		
	}
	table {
	    border-collapse: collapse;
	    border-spacing: 0;
	    width: 100%;
	    table-layout:fixed;
	}
	body {
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
	}
	
	.start-div{
		padding-top: 50px;
	}
	.table{
		display:Table;
	}
	.table > div{
		display:Table-cell;
	/*	vertical-align:middle;*/
		font-size:15px;
		padding-right:15px;
		white-space:nowrap;
	}
	.table span{
		font-size:100%;
	}
	table td.chk-date{
		font-size:10px; 
		padding:0;
	}
	.subject_nm{
		font-size: inherit;
	}
	
}
</style>
<div class="page">

</div>




<script>
function comma(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
var per_cnt=0;
function guessSchedule(start_ymd, type)
{
	
	
   //console.log(start_ymd.substring(0, 4));
   //console.log(start_ymd.substring(4,6)-1);
   //console.log(start_ymd.substring(6,8));
   //console.log(start_ymd.substring(0,8));
   
   var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8),00,00);
   //var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8) ,11 ,59 );
   var current_date = new Date();
 
   //console.log("DATE START : "+date_start);
   //console.log("CURRENT START : "+current_date);
   
   var typex = type;	
   if(current_date < date_start || start_ymd=="X")
   {
      typex = "";
   }
   else
   {
	   per_cnt++;
   }
   
   return typex; 
}

function phone_masking(str){
	var arr = str.split('-');
	var middle_str = "";
	for (var i = 0; i < arr[1].length; i++) {
		middle_str+="*";
	}
	return arr[0]+"-"+middle_str+"-"+arr[2];
}

</script>