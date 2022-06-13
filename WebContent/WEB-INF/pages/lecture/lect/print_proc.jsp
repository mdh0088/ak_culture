<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/function.js"></script>
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

$(document).ready(function(){
	var day_chk_arr ="${day_chk}".split('|');
	var inner ="";
// 	inner +='<tr>';
// 	inner +='	<th>강좌 : ${subject_nm}(subject_cd)</th>';
// 	inner +='</tr>';
	
// 	inner +='<tr>';
// 	inner +='	<th>강사 : ${lecr_nm}</th>';
// 	inner +='</tr>';
	
	inner +='<tr>';
	inner +='	<th class="td-chk">No.</th>';
	inner +='	<th>회원명</th>';
	inner +='	<th>자녀명</th> ';
	inner +='	<th>구분</th> ';
	inner +='	<th>회원번호</th> ';
	inner +='	<th class="phone_area">전화번호</th>';
	inner +='	<th>차량번호</th> ';
//	inner +='	<th>가입일</th>';
//	inner +='	<th>형태</th>';
	for (var i = 0; i < day_chk_arr.length-1; i++) {
		inner +='<th class="chk-date">';
		inner +='	'+day_chk_arr[i].substr(4,2)+'/<br>'+day_chk_arr[i].substr(6,2)+'';
		inner +='</th>'
	}
	//inner +='<th>비고</th>';
	inner +='</tr>';
	$('#list_head_target').html(inner);
	
	var inner3 = "";			

	inner3 += '		<col width="20px">';
	inner3 += '		<col width="50px">';
	inner3 += '		<col width="50px">';
	inner3 += '		<col width="50px">';
	inner3 += '		<col width="60px">';
	inner3 += '		<col width="60px">';
	inner3 += '		<col width="60px">';
	for (var i = 0; i < day_chk_arr.length-1; i++) {
		inner3 +='<col>';
	}
	inner3 += '		<col width="40px">';
	$('#list_colgroup').html(inner3);

	
	var s = JSON.stringify(${result});
	var result = JSON.parse(s);
	console.log(result);
	inner = "";
	var day_chk_arr = "${day_chk}".split('|');
	var dayChk = ""; //출석체크 값 세팅
	
	if(result.list.length > 0)
	{
		$("#period").text(result.period);
		$('#lect_ymd').text(cutDate(result.start_ymd)+ '~' +cutDate(result.end_ymd));
		$('#lect_hour').text(cutLectHour(result.lect_hour));
		for(var i = 0; i < result.list.length; i++)
		{
			dayChk = result.list[i].DAY_CHK.split('|');
			inner += '<tr>';
			inner += '	<td class="td-chk">'+(i+1)+'</td>';
			inner += '	<td>'+nullChk(result.list[i].PARENT_NM)+'</td>';
			inner += '	<td>'+nullChk(result.list[i].KIDS_NM)+'</td>';
			inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
			inner += '	<td>'+nullChk(result.list[i].CUST_NO)+'</td>';
			inner += '	<td class="phone_area">'+phone_masking(nullChk(result.list[i].PHONE_NO))+'</td>';
		//	inner += '	<td>'+nullChk(result.list[i].PHONE_NO)+'</td>';
			inner += '	<td>'+nullChk(result.list[i].CAR_NO)+'</td>';
			//inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
			
			
			console.log("len : "+dayChk.length);
			//for (var j = 0; j < dayChk.length-1; j++) 	//원래 맞츰 
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
			//inner += '	<td>'+guessSchedule("${DAY2}",nullChk(result.list[i].DAY2))+'</td>';
			inner += '</tr>';
			if (i % 22 == 0 && i!=0)
            {
                    inner+="<tr style='opacity:0;'><td></td></tr>";
            }
		}
	}
	else
	{
		inner += '<tr>';
		//inner += '	<td colspan="'+(7+day_chk_arr.length)+'"><div class="no-data">수강생이 없습니다.</div></td>';
		inner += '	<td colspan="'+(6+day_chk_arr.length)+'"><div class="no-data">수강생이 없습니다.</div></td>';
		inner += '</tr>';
	}
	
	$("#list_target").html(inner);
	
	if ("${phone_chk}"=="hide") 
	{
		$('.phone_area').hide();
	}
	
	
	window.print();
	setTimeout("window.close();", 500);
	
});
</script>
<style type="text/css">
html, body { height: auto; }
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
@page { 
	size: a4;
	margin: 6mm 6mm 5mm 4mm; 
	
}
@media print {
	html, body { height: auto; }
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
	<div class='table start-div'>
		<div>기수 : <span id="period">094</span></div>
		<div>강좌 : <strong class="subject_nm">${subject_nm}</strong> (${subject_cd})</div>
	</div>
	<div class='table'>
		<div>강의기간 : <span id="lect_ymd">2021-04-06 ~ 2021-04-06</span></div><br>
		<div>강의시간 : <span id="lect_hour">11:50 ~ 12:30</span></div><br>
		<div>강사 : ${lecr_nm}</div>
	</div>
	<table id="excelTable">
		<colgroup id="list_colgroup">
			
		</colgroup>
		<thead id="list_head_target">
			<tr>
				<th width="50px">NO. </th>
				<th width="100px">회원명 </th>
				<th width="50px">자녀명 </th>
				<th width="50px">회원번호 </th>
				<th width="100px">전화번호 </th>
				<th width="100px">차량번호 </th>
			</tr>
		</thead>
		<tbody id="list_target">
		</tbody>
	</table>
</div>