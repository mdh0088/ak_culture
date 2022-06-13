<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="/inc/js/sort.js"></script>
<script>
var cust_no ="${cust_no}";
var order_by="";
var sort_type = "";
var listSize ="";


function enterkey() {
    if (window.event.keyCode == 13) {
    	userSearch();
    }
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
	
	/* 알림톡 팝업 */
	$(".billing-history .table-list > table > tbody > tr").each(function(){
		var mult = $(this).find(".multi");
		var mpop = $(this).find(".multi-pop");
		
		mult.click(function(){
			if(mpop.css("display") == "none"){
				mpop.css("display","block");
			}else{
				mpop.css("display","none");
			}
			
		})
		
	});
	
	/* 복합 팝업02 */
	$(".tm-consulting .table-list > table > tbody > tr").each(function(){
		var mult02 = $(this).find(".multi02");
		var mpop02 = $(this).find(".multi-pop02");
		var exit = $(this).find(".multi-pop02 .close");
		
		mult02.click(function(){
			if(mpop02.css("display") == "none"){
				mpop02.css("display","block");
			}else{
				mpop02.css("display","none");
			}
			
		})
		
	});
});

window.onload = function(){

	if (cust_no!='') {
		choose_confirm(cust_no);
	}

}

function userSearch()
{
	if ($("#search_name").val() =="") {
		alert('검색어를 입력해주세요.');
		return;
	}
	
	getListStart();
	$.ajax({
		type : "POST", 
		url : "/member/lect/userSearch",
		dataType : "text",
		data : 
		{
			search_name : $("#search_name").val(),
			birth : $("#birth").val(),
			order_by : searcth_order,
			sort_type : searcth_sort
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$("#searchResult").html("");
			$(".searchResult").html("");
			$(".searchResult_ul").html("");
			if(result.length > 0)
			{
				$(".searchResult").append(result[0].KOR_NM);
				for(var i = 0; i < result.length; i++)
				{
					$("#searchResult").append("<option value='"+result[i].CUST_NO+"'>"+result[i].KOR_NM+"|"+result[i].CUST_NO+"</option>");
					$(".searchResult_ul").append("<li>"+result[i].KOR_NM+"|"+result[i].CUST_NO+"</li>");
				}
			}
			else
			{
				$(".searchResult").append("검색결과가 없습니다.");
			}
			getListEnd();
		}
	});
	$('#search_layer').fadeIn(200);	
}

function choose_confirm(idx)
{
	if (idx>0) {
		cust_no = idx;
	}else{
		cust_no = $("#searchResult").val();		
	}
	
	$('#search_layer').fadeOut(200);
	$.ajax({
		type : "POST", 
		url : "/common/getUserByCust",
		dataType : "text",
		data : 
		{
			cust_no : cust_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			console.log(data);
			var result = JSON.parse(data);
		 	$("#big_name").html(result.list.KOR_NM+'<span>('+nullChk(result.list.PTL_ID)+')</span>');
		 	$("#kor_nm").val(result.list.KOR_NM);
		 	
		 	$(".rank-txt").text(result.list.CLASS);
		 	
		 	if (nullChk(result.list.STORE)!="") 
		 	{
				if (result.list.STORE=="02") {
					$('#store_nm').text("수원점");
				}
				else if (result.list.STORE=="03") 
				{
					$('#store_nm').text("분당점");				
				}
				else if (result.list.STORE=="04") 
				{
					$('#store_nm').text("평택점");				
				}
				else
				{
					$('#store_nm').text("원주점");				
				}
			}
		 	
		 	$('#total_amt').html(comma(result.lect_sum)+'<span>원</span>');
		 	$('#lect_cnt').html(result.lect_cnt+'<span>강</span>');
		 
		 	
		 	if (result.list.PHONE_NO1!='' && result.list.PHONE_NO1!=null) {
			 	$("#h_phone_no").val(trim(result.list.PHONE_NO1)+"-"+result.list.PHONE_NO2+"-"+result.list.PHONE_NO3);
			}
		 	
		 	if (result.list.H_PHONE_NO_1!='' && result.list.H_PHONE_NO_1!=null) {
		 		$("#phone_no").val(result.list.H_PHONE_NO_1+"-"+result.list.H_PHONE_NO_2+"-"+result.list.H_PHONE_NO_3);
		 	}
		 	
		 	if (result.list.BIRTH_YMD!='' && result.list.BIRTH_YMD!=null) {
		 		$("#birth_ymd").val(cutDate(result.list.BIRTH_YMD));
		 	}
		 	
		 	if (result.list.EMAIL_ADDR!='' && result.list.EMAIL_ADDR!=null) {
		 		$("#email_addr").val(result.list.EMAIL_ADDR);
		 	}
		 	
		 	if (result.list.CUS_NO!='' && result.list.CUS_NO!=null) {
		 		$("#cus_no").val(result.list.CUS_NO);
		 	}
		 	
		 	if (result.list.CAR_NO!='' && result.list.CAR_NO!=null) {
		 		$("#car_no").val(result.list.CAR_NO);
		 	}
		 	
		 	if (result.list.CARD_NO!='' && result.list.CARD_NO!=null) {
		 		$("#card_no").val(result.list.CARD_NO);
		 	}
		 	
		 	if (result.list.POST_NO1!='' && result.list.POST_NO1!=null) {
		 		$("#post_no").val(result.list.POST_NO1+result.list.POST_NO2);
		 	}
		 	
		 	if (result.list.ADDR_TX1!='' && result.list.ADDR_TX1!=null) {
			 	$("#addr_tx1").val(result.list.ADDR_TX1);
			 	$("#addr_tx2").val(result.list.ADDR_TX2);
		 	}
		 	
		 	if (result.list.PTL_ID!='' && result.list.PTL_ID!=null) {
		 		$("#ptl_id").val(result.list.PTL_ID);
		 	}
		 	
		 	if (result.list.CREATE_DATE!='' && result.list.CREATE_DATE!=null) {
		 		$("#create_date").val(cutDate(result.list.CREATE_DATE));
		 	}
		 	
		 	if (result.list.SEX_FG=='M') {
				$('#cus_male').prop('checked',true);
			}else{
				$('#cus_female').prop('checked',true);
			}
		 	
			if (result.list.MARRY_FG=='1') {
				$('#cus_married').prop('checked',true);
			}else{
				$('#cus_single').prop('checked',true);
			}

		 	if (result.list.MARRY_YMD!='' && result.list.MARRY_YMD!=null) {
				$('#marry_ymd').val(result.list.MARRY_YMD);
		 	}
		 	
			if (result.list.EMAIL_YN=='Y') {
				$('#cus_email_check').prop('checked',true);
			}else{
				$('#cus_email_check').prop('checked',false);
			}
	
			if (result.list.SMS_YN=='Y') {
				$('#cus_sms_check').prop('checked',true);
			}else{
				$('#cus_sms_check').prop('checked',false);
			}
			
		 	$("#bigMEM").html(result.list.CUS_NO);
		 	$(".table-top_member").show();
			
		 	getChild(cust_no);
	
		}
	});
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
	search_memo();		// 관리자 메모
	getLastYearSeason();
	search_lect();	
	search_message(); 	// 알림톡,sms 발송내역
	//search_tm();		// tm상담내역
	//search_history();
}

function getLastYearSeason()
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
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
			var season = result[0].WEB_TEXT.substring(7,result[0].WEB_TEXT.length);
			season = season.replace("학기", ""); //계절만추출
			$("#selYear1").val(result[0].WEB_TEXT.substring(0,4));
			$(".selYear1").html(result[0].WEB_TEXT.substring(0,4));
			$("#selYear2").val(result[0].WEB_TEXT.substring(0,4));
			$(".selYear2").html(result[0].WEB_TEXT.substring(0,4));
			
			$("#selSeason1").val(season);
			$(".selSeason1").html(season);
			$("#selSeason2").val(season);
			$(".selSeason2").html(season);
			
			
		}
	});	
}


function getChild(idx)
{
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/getChildByCust",
		dataType : "text",
		data : 
		{
			cust_no : idx
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			$('.useChild').remove();
			if(result.length > 0)
			{
				var gender="";
				$('.enmpty_area').remove();
		
				for(var i = 0; i < result.length; i++)
				{
					if (trim(result[i].GENDER)=="M") {
						gender="남";
					}
					else
					{
						gender="여";
					}
					
					inner += '<div class="useChild">';
					inner += '	<div class="child01">';
					inner += '		<input type="text" class="cus_child inp-100" value="'+result[i].CHILD_NM+'" readonly>';
					inner += '	</div>';
					
					inner += '	<div class="wid-15">';
					inner += '		<input type="text" class="cus_child inp-100" value="'+gender+'" readonly>';
					inner += '	</div>';
					
					inner += '	<div class="child02">';
					inner += '		<input type="text" class="cus_child inp-100" value="'+result[i].BIRTH+'" readonly>';
					inner += '	</div>';
						
					inner += '	<div class="child04">';
					inner += '		<a class="bor-btn btn03 mrg-l6" onclick="delChild(\''+cust_no+'_'+nullChk(result[i].CHILD_NO)+'\');">삭제</a>';
					inner += '	</div>';
	
					
					inner += '</div>';
					
				}
				$(".table-mem02").append(inner);
			}
			
		}
	});	
}

function delChild(idx){
	if(!confirm("삭제 하시겠습니까?")){
		return;
	}
	
	var arr = idx.split('_');
	
	$.ajax({
		type : "POST", 
		url : "./getPereByChild",
		dataType : "text",
		async : false,
		data : 
		{
			cust_no : arr[0],
			child_no : arr[1]
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			if(Number(data) > 0)
			{
				var isCon = false;
				if(confirm("수강한 강좌가 있습니다. 그래도 삭제하시겠습니까?"))
				{
					delChild2(idx);
				}
			}
			else
			{
				delChild2(idx);
			}
		}
	});	
}
function delChild2(idx)
{
	var arr = idx.split('_');
	$.ajax({
		type : "POST", 
		url : "./delChild",
		dataType : "text",
		async : false,
		data : 
		{
			cust_no : arr[0],
			child_no : arr[1]
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data2) 
		{
			var result = JSON.parse(data2);
			alert(result.msg);
			//location.reload();
			getChild(cust_no);
			
		}
	});	
}
var child_cnt = 1;
function add_child(){
	
	var class_cnt = $('.child01').length;
	/*
	if (class_cnt>=3) {
		alert('자녀는 3명만 등록할 수 있습니다.');
		return;
	}
	*/
	
	var inner = "";
	inner += '<div id="child_div_'+child_cnt+'" class="enmpty_area">';
	inner += '	<div class="child01">';
	inner += '		<input type="text"  name="child_nm" class="cus_child inp-100" placeholder="이름을 입력하세요.">';
	inner += '	</div>';
	
	inner +='	<div class="wid-15">';
	inner +='		<div class="select-box">';
	inner +='			<div class="selectedOption ">남</div>';
	inner +='			<ul class="select-ul _ul" style="display: none; overflow: hidden;">';
	inner +='				<li>남</li>';
	inner +='				<li>여</li>';
	inner +='			</ul>';
	inner +='			<select  name="child_gender" de-data="남" style="display: none;">';
	inner +='				<option value="M">남</option>';
	inner +='				<option value="F">여</option>';
	inner +='			</select>';
	inner +='		</div>';
	inner +='	</div>';
	
	inner += '	<div class="child02">';
	inner += '		<div class="cal-input cal-input02">';
	inner += '			<input type="text" placeholder="생년월일"  name="child_birth" class="child_birth date-i" readonly="readonly" />';
	inner += '			<i class="material-icons">event_available</i>';
	inner += '		</div>';
	inner += '	</div>';
		
	inner += '	<div class="child04">';
	inner += '		<div class="btn-row"><i class="material-icons remove" onclick="remove_child('+child_cnt+')">remove_circle_outline</i></div>';
	inner += '	</div>';
	
	inner += '</div>';
	$(".table-mem02").append(inner);
	
	child_cnt ++;
	dateInit();
}

function remove_child(idx)
{
	$("#child_div_"+idx).remove();
}

function search_message(){
	

	var send_type="";
	if ($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")!=1 && $('#chk_lms').prop("checked")!=1) {
		send_type="1";
	}else if($('#chk_alarm').prop("checked")!=1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")!=1){
		send_type="2";
	}else if($('#chk_alarm').prop("checked")!=1 && $('#chk_sms').prop("checked")!=1 && $('#chk_lms').prop("checked")==1){
		send_type="3";
	}else if($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")!=1){
		send_type="1|2";
	}else if($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")!=1 && $('#chk_lms').prop("checked")==1){
		send_type="1|3";
	}else if($('#chk_alarm').prop("checked")!=1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")==1){
		send_type="2|3";
	}else if($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")==1){
		send_type="1|2|3";
	}
 	
	console.log(cust_no);
	console.log($('#send_kor').val());
	console.log($('#send_start').val());
	console.log($('#send_end').val());
	console.log(send_type);
	console.log($('#send_state').val());
	console.log($('#listSize').val());
	
	$.ajax({
		type : "POST", 
		url : "./getMessageList",
		dataType : "text",
		async : false,
		data : 
		{
			cust_no : cust_no,
			kor_nm : $('#send_kor').val(),
			start_day : $('#send_start').val(),
			end_day : $('#send_end').val(),
			send_type : send_type,
			send_state : $('#send_state').val(),
			order_by : order_by,
			sort_type : sort_type,
			listSize : $('#listSize').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			console.log(data);
			$('.message_area').empty();
			var inner ="";
			var result = JSON.parse(data);
			if (result.list.length > 0) {
				for(var i = 0; i < result.list.length; i++)
				{
					inner +='<tr>';
					inner +='	<td class="td-chk">';
					inner +='		<input type="checkbox" id="message_'+i+'" name="message_'+i+'" value=""><label for="message_'+i+'"></label>';
					inner +='	</td>';
					inner +='	<td>'+nullChk(result.list[i].SEND_TYPE)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].TITLE)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].MANAGER_NM)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].RESERVE_TIME)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].SEND_RESULT)+'</td>';
					inner +='</tr>';
					
				}
			}
			else
			{
				inner +='<tr>';
				inner +='	<td colspan="6">발송 내역이 없습니다.</td>';
				inner +='</tr>';
			}
			$('.message_area').html(inner);
			//alert('저장 되었습니다.');
			//location.reload();
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
		}
		
	});	
}

function search_tm(){

	var chk_myself="";
	var recall_yn ="";
	
	if ($('#chk_myself_a').prop("checked")==1 && $('#chk_myself_b').prop("checked")!=1) {
		chk_myself="1";
	}else if($('#chk_myself_a').prop("checked")!=1 && $('#chk_myself_b').prop("checked")==1){
		chk_myself="2|3|4";
	}else if($('#chk_myself_a').prop("checked")==1 && $('#chk_myself_b').prop("checked")==1){
		chk_myself="1|2|3|4";
	}
	
	if ($('#chk_recall_a').prop("checked")==1 && $('#chk_recall_b').prop("checked")!=1) {
		recall_yn="Y";
	}else if($('#chk_recall_a').prop("checked")!=1 && $('#chk_recall_b').prop("checked")==1){
		recall_yn="N";
	}else if($('#chk_recall_a').prop("checked")==1 && $('#chk_recall_b').prop("checked")==1){
		recall_yn="Y|N";
	}
 	
	$.ajax({
		type : "POST", 
		url : "./getTmList",
		dataType : "text",
		async : false,
		data : 
		{
			cust_no : cust_no,
			kor_nm:$('#send_kor_tm').val(),
			start_day : $('#send_start_tm').val(),
			end_day : $('#send_end_tm').val(),
			chk_myself : chk_myself,
			recall_yn : recall_yn,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $('#listSize').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			console.log(data);
			$('.tm_area').empty();
			var inner ="";
			var result = JSON.parse(data);
			if (result.list.length > 0) 
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner +='<tr>';
					inner +='	<td class="td-chk">';
					inner +='		<input type="checkbox" id="tm_'+i+'" name="tm_'+i+'" value=""><label for="tm_'+i+'"></label>';
					inner +='	</td>';
					inner +='	<td>'+nullChk(result.list[i].PHONE)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].TITLE)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].RECEIVER)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].TM_DATE)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].MANAGER_NM)+'</td>';
					inner +='	<td>'+nullChk(result.list[i].RECALL_YN)+'</td>';
					inner +='</tr>';
					
				}
			}
			else
			{
				inner +='<tr>';
				inner +='	<td colspan="7">발송 내역이 없습니다.</td>';
				inner +='</tr>';
			}
			$('.tm_area').html(inner);
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
		}
	});	
}

function add_memo(){
	
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
	inner +='	<td><input type="text" id="memo_id_'+memo_cnt+'" class="new_memo memo_input inp-100 bor-no" placeholder="내용을 입력하세요."></td>';
	inner +='	<td>'+now_day+'</td>';
	inner +='	<td>'+now_manager_name+'</td>';
	inner +='	<td><i class="material-icons remove" onclick="remove_cust_memo('+memo_cnt+')">remove_circle_outline</i></td>';
	inner +='</tr>';
	
	$('.cust_memo_area').append(inner);
	
	if (memo_cnt!='') {
		$('.cust_memo_list_'+memo_cnt).insertBefore('.cust_memo_list_'+((memo_cnt*1)-1));	
	}
	
}

function remove_cust_memo(idx){
	$(".cust_memo_list_"+idx).remove();
}


function save_cust_info(){
	
	
	if (cust_no=="") {
		alert("고객을 선택해주세요.");
		return;
	}
	

	var nm = "";
	var chk_flag="";
	$("[name='child_nm']").each(function() 
	{
		if($(this).val() != "")
		{
			nm += $(this).val()+"|";
		}
		else
		{
			alert('자녀의 이름을 입력해주세요.');
			chk_flag="Y";
			return;
		}

	});
	
	if (chk_flag=="Y") {
		return;
	}
	
	var gender="";
	$("[name='child_gender']").each(function() 
	{
		if($(this).val() != "")
		{
			gender += $(this).val()+"|";
		}
	});
	
	var birth = "";
	$("[name='child_birth']").each(function() 
	{
		if($(this).val() != "")
		{
			birth += $(this).val()+"|";
		}
		else
		{
			alert('자녀의 생년월일을 입력해주세요.');
			chk_flag="Y";
			return false;
		}

	});
	if (chk_flag=="Y") {
		return;
	}
	

	
	var memo_list="";
	$('.new_memo').each(function(){
		if($(this).val() != '')
		{
			memo_list=memo_list+$(this).val()+'|';
			
		}
	})
	
	$.ajax({
		type : "POST", 
		url : "./cust_update",
		dataType : "text",
		async : false,
		data : 
		{
			child_nm : nm,
			child_gender : gender,
			child_birth : birth,
			memo_list : memo_list,
			car_no: $('#car_no').val(),
			cust_no : cust_no
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);
			
			//location.reload();
			choose_confirm(cust_no);
			getChild(cust_no);
			search_memo();
		}
	});	
}


function search_lect(){
	
	$.ajax({
		type : "POST", 
		url : "./getLectInfo",
		dataType : "text",
		data : 
		{
			order_by : order_by,
			sort_type : sort_type,
			cust_no : cust_no,
			selBranch : $('#selBranch').val(),
			selYear1 : $("#selYear1").val(),
			selYear2 : $("#selYear2").val(),
			selSeason1 : $("#selSeason1").val(),
			selSeason2 : $("#selSeason2").val(),
			listener : $('#listener').val(),
			listSize : $('#listSize').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			$('#lect_info_area').empty();
			var result = JSON.parse(data);
			var multi_nm="";
			var inner ="";
			if (result.list.length > 0) 
			{
				for (var i = 0; i < result.list.length; i++) {
					
					var pay_type = "";
					if(nullChk(result.list[i].CARD_AMT) != '') { pay_type += "/카드"; }
					if(nullChk(result.list[i].CASH_AMT) != '') { pay_type += "/현금"; }
					if(nullChk(result.list[i].POINT_AMT) != '0') { pay_type += "/마일리지"; }
					if(result.list[i].MY_FACE_AMT != '0' && result.list[i].YOUR_FACE_AMT != '0') { pay_type += "/상품권"; }
					pay_type = pay_type.substring(1, pay_type.length);
	
					inner +='<tr>';
					inner +='	<td>'+result.list[i].STORE_NM+'</td>';
					inner +='	<td>'+result.list[i].PERIOD+'</td>';
					inner +='	<td>'+result.list[i].SALE_YMD+'</td>';
					inner +='	<td>'+result.list[i].SALE_FG+'</td>';
					inner +='	<td>'+result.list[i].POS_NO+'</td>';
					inner +='	<td>'+result.list[i].RECPT_NO+'</td>';
	
					inner +='	<td>'+pay_type+'</td>';
					
					inner +='	<td>'+result.list[i].SUBJECT_CD+'</td>';
					inner +='	<td>'+result.list[i].SUBJECT_NM+'</td>';
					inner +='	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
					
					var child_nm = result.list[i].CUST_NM; //수강자
					if(nullChk(result.list[i].CHILD1_NM) != '') { child_nm += "/"+result.list[i].CHILD1_NM; }
					if(nullChk(result.list[i].CHILD2_NM) != '') { child_nm += "/"+result.list[i].CHILD2_NM; }
					
					inner +='	<td>'+child_nm+'</td>';					
	
					
					inner +='	<td style="background-color: #f8f8f8;">'+comma(result.list[i].FOOD_FEE)+'</td>';
					inner +='	<td>'+comma(result.list[i].ENURI_AMT)+'</td>';
					inner +='	<td style="background-color: #fff5f5;">'+comma(result.list[i].REGIS_FEE)+'</td>';
					inner +='</tr>';
				}
			}
			else
			{
				inner +='<tr>';
				inner +='	<td colspan="14">수강/결제내역이 없습니다.</td>';
				inner +='</tr>';
			}
			$('#lect_info_area').html(inner);

			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
		}
	});
}

function search_memo(){

	
	$.ajax({
		type : "POST", 
		url : "./getMemo",
		dataType : "text",
		async : false,
		data : 
		{
			cust_no : cust_no,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $('#listSize').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			console.log(data);
			$('.cust_memo_area').empty();
			var result = JSON.parse(data);
			var inner ="";
			for (var i = 0; i < result.list.length; i++) {
				inner +='<tr class="memo cursor cust_memo_list_'+(result.list.length-i)+'">';
				inner +='	<td>'+nullChk(result.list[i].CONTENTS)+'</td>';
				inner +='	<td>'+result.list[i].MEMO_CREATE_DATE+'</td>';
				inner +='	<td>'+result.list[i].MEMO_MANAGER_NM+'</td>';
				inner +='	<td><a class="bor-btn btn03 mrg-l6" onclick="delMemo(\''+result.list[i].CREATE_DATE+'\',\''+result.list[i].CONTENTS+'\');">삭제</a></td>';
				inner +='</tr>';
				
			}
			$('.cust_memo_area').append(inner);
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
		}
		
	});	
}


function delMemo(idx1,idx2){
	if(!confirm("삭제 하시겠습니까?")){
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./delMemo",
		dataType : "text",
		async : false,
		data : 
		{
			memo : idx2,
			memo_date : idx1
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			alert(result.msg);
			search_memo();
		}
	});	
}

function reSortAjax_custInfo(act,way)
{
	sort_type = act.replace("sort_", "");
	console.log(sort_type);
	console.log(order_by);
	if(order_by == "")
	{
		order_by = "desc";
		$("#"+act).attr("src", "/img/th_down.png");
	}
	else if(order_by == "desc")
	{
		order_by = "asc";
		$("#"+act).attr("src", "/img/th_up.png");
	}
	else if(order_by == "asc")
	{
		order_by = "desc";
		$("#"+act).attr("src", "/img/th_down.png");
	}
	
	if(way=='tm'){
		search_tm();
	}else if(way=='lect'){
		search_lect();
	}else if(way=='sms'){
		search_message();
	}
	/*
	else if(way=='history'){
		search_history();
	}else if(way=='memo'){
		search_memo();
	}
	*/
}

function sortTD(index,act)
{
	var myTable = document.getElementById("managerTable"); 
	var replace = replacement( myTable ); 
	sort_type = act.replace("sort_", "");
	
	if(order_by == "")
	{
		order_by = "desc";
		replace.descending( index );    
		$("#"+act).attr("src", "/img/th_down.png");
	}
	else if(order_by == "desc")
	{
		order_by = "asc";
		replace.ascending( index );  
		$("#"+act).attr("src", "/img/th_up.png");
	}
	else if(order_by == "asc")
	{
		order_by = "desc";
		replace.descending( index );    
		$("#"+act).attr("src", "/img/th_down.png");
	}
}

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

function clear_order(){
	order_by="";
	sort_type="";
}


var searcth_order ="";
var searcth_sort ="";
function reSortKor(act,way)
{
	if(!isLoading)
	{
		searcth_sort = act.replace("sort_", "");
		console.log(searcth_sort);
		console.log(searcth_order);
		
		if(searcth_order == "")
		{
			searcth_order = "desc";
			$("#"+act+"_"+way).attr("src", "/img/th_down.png");
		}
		else if(searcth_order == "desc")
		{
			searcth_order = "asc";
			$("#"+act+"_"+way).attr("src", "/img/th_up.png");
		}
		else if(searcth_order == "asc")
		{
			searcth_order = "desc";
			$("#"+act+"_"+way).attr("src", "/img/th_down.png");
		}
		
		userSearch();	
	}
}


</script>
<!-- 스크롤 기능 에러방지용 -->
<input type="hidden" id="listSize" value="10">
<div class="sub-tit">
	<h2>회원관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
<div class="table-top">
	<div class="top-row">
		<!-- 
		<div class="wid-25">
			<div class="table">
				<div>
					<div class="table">
						<div class="sear-tit">회원명</div>
						<div>
							<input type="text" id="user_name" name="user_name" onkeypress="excuteEnter(userSearch)" />
						</div>
					</div>
				</div>
				
			</div>
		</div>
		 -->
		<div class="wid-5 mag-lr2">
			<div class="table">
				<div class="search-wr">
				<!-- 
					<select id="searchType" name="searchType" de-data="휴대폰(뒷자리 4자리)">
						<option value="phone">휴대폰(뒷자리 4자리)</option>
						<option value="card">카드번호</option>
						<option value="members">멤버스번호</option>
					</select>
				 -->
					<input type="text" id="search_name" name="search_name" style="width:96% !important" onkeypress="excuteEnter(userSearch)" placeholder="휴대폰 뒷자리 / 카드번호 / 멤버스번호 / 회원명 / 생년월일이 검색됩니다.">
				</div>
			</div>
		</div>	
		<div class="wid-2">
			<div class="table table-input">
				<div class="sear-tit sear-tit_left">생년월일</div>
				<div>
					<input type="text" id="birth" name="birth" placeholder="YY/MM/DD" onkeypress="excuteEnter(userSearch)" />
				</div>
			</div>
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="userSearch()">
</div>

<div id="search_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg memb-eidt">
        		<div class="close" onclick="javascript:$('#search_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">고객 조회</h3>
        			<div class="table table-auto margin-auto">
						<div>
							<select de-data="" id="searchResult">
							
							</select>
						</div>
						<div>
							<a class="btn btn02" onclick="reSortKor('sort_kor_nm')" style="max-width:100px; min-width:auto; margin:0 0 0 10px">정렬<img src="/img/th_up.png" id="sort_store"></a>
							<a class="btn btn02" onclick="choose_confirm(0);">선택완료</a>
						</div>
					</div>	
	        	</div>
        	</div>
        </div>
    </div>	
</div>

<div class="table-top table-top_member" style="display:none;">
	<div class="top-row sear-wr">
		<div class="wid-5">
			<div class="member-infoWarp">
				<div class="rank-txt"></div>
				<div>
					<div class="name" id="big_name">이호걸<span>(musign)</span></div>
					<ul>
					<!-- 
						<li><i class="material-icons">settings_phone</i></li>
						<li><i class="material-icons">textsms</i></li> -->
						<li class="txt"><i class="material-icons">favorite</i><span id="store_nm">${store_nm}</span></li>
					</ul>
				</div>
				<div class="number">MEMNO. <span id="bigMEM">123456789</span></div>
			</div>
		
		</div>
		<div class="wid-5">
			<div class="member-infoWarp02">
				<div class="wid-6">
					<div><i class="material-icons">attach_money</i></div>
					<div class="memin-pri">
						<span>결제총액</span>
						<p id="total_amt">${lect_sum}<span>원</span></p> 
					</div>
				</div>
				<div class="wid-4">
					<div><i class="material-icons">event_note</i></div>
					<div class="memin-pri">
						<span>수강 강좌수</span>
						<p id="lect_cnt">>${lect_cnt}<span>강</span></p> 
					</div>
					
				</div>
				
			</div>
			
		</div>
	</div>

</div>




<div class="table-wr">

	<div class="tab-wrap tab-wrap_mem">		
		<div class="tab-title">
			<ul>
				<li class="active">회원정보</li>
				<li onclick="search_lect(); clear_order();">수강/결제내역</li>
				<li onclick="search_message(); clear_order();">SMS발송내역</li>
				<li onclick="search_tm(); clear_order();">TM상담내역</li>
				<!-- <li>변경이력</li>  -->
			</ul>
		</div> <!-- tab-title end -->
		
		
		
		<div class="tab-content mem-manage">
		
			<div class="member-profile member-profile02 active">
				<div class="table-list">
					<div class="row">
						<div class="wid-5">
							<div class="bor-div">
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit">회원명</div>
										<div>
											<input type="text" id="kor_nm" name="kor_nm" class="inputDisabled inp-100" placeholder="" readOnly>
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">생년월일</div>
													<div>
														<input type="text" id="birth_ymd" name="birth_ymd" class="inputDisabled inp-100" >
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">전화번호</div>
													<div>
														<input type="text" id="h_phone_no" name="h_phone_no" class="inputDisabled inp-100" readonly="readonly">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit-top">이메일</div>
													<div>
														<input type="text" id="email_addr" name="email_addr" class="inputDisabled inp-100" readonly="readonly">
														
														<div class="sear-smtit wid-10">
															<input type="checkbox" id="cus_email_check" name="cus_email_check">
															<label for="all-c">수신동의</label>
															
														</div>
														<p>정보/이벤트 SMS 수신에 동의합니다.</p>		
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit-top">휴대폰</div>
													<div>
														<input type="text" id="phone_no" name="phone_no" class="inputDisabled inp-100"  readonly="readonly">
														
														<div class="sear-smtit wid-10">
															<input type="checkbox" id="cus_sms_check">
															<label for="all-c">수신동의</label>
														</div>
														<p>정보/이벤트 SMS 수신에 동의합니다.</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							
							<div class="bor-div">
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit">멤버스번호</div>
										<div>
											<input type="text" id="cus_no" name="cus_no" class="inputDisabled inp-100" readonly="readonly" >
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">포털ID</div>
													<div>
														<input type="text" id="ptl_id" name="ptl_id" class="inputDisabled inp-100" disabled="disabled">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">가입일자</div>
													<div>
														<!-- inp-100 클래쓰 지움 필요시 추가 -->
														<input type="text" id="create_date" name="create_date inp-100" class="inputDisabled" disabled="disabled">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit-top">멤버스카드NO</div>
													<div>
														<input type="text" id="card_no" name="card_no" class="inputDisabled inp-100" >
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit-top">베키맘여부</div>
													<div>
														<input type="text" id="cus_baking_mom" name="cus_baking_mom" class="inputDisabled inp-100" disabled="disabled">
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="bor-div">
								<div class="wid-10">
									<div class="table">
									
										<div class="sear-tit">성별</div>
										<div>
											<ul class="chk-ul">
												<li>
													<input type="radio" id="cus_male" class="chkDisabled" name="rad-1">
													<label for="rad-c">남</label>
												</li>
												<li class="chk-li">
													<input type="radio" id="cus_female" class="chkDisabled" name="rad-2">
													<label for="rad-c">여</label>
												</li>
											</ul>
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">결혼여부</div>
													<div>
														<ul class="chk-ul">
															<li>
																<input type="radio" id="cus_single" class="chkDisabled" name="rad-11" checked="">
																<label for="rad-c">미혼</label>
															</li>
															<li>
																<input type="radio" id="cus_married" class="chkDisabled" name="rad-22">
																<label for="rad-c">기혼</label>
															</li>
														</ul>
														
													</div>
												</div>
											</div>
											
											<div class="wid-5">
												<div class="table">
																					
													<div class="sear-tit">결혼기념일</div>
													<div>
														<input type="text" id="marry_ymd" name="marry_ymd" class="inputDisabled inp-100" disabled="disabled">
													</div>
												</div>
											</div>
									
										</div>
									
									</div>
									
								</div>
								
								
							</div>
							
							
						</div>
						
						
						<div class="wid-5 wid-5_last">
						
							<div class="bor-div">
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit-top">주소</div>
										<div class="table-mem">
											<div class="input-wid2">
												<input type="text" id="post_no" name="post_no" class="inputDisabled inp-30">
												<input type="text" id="addr_tx1" name="addr_tx1" class="inputDisabled inp-70">
											</div>
											<div>
												<input type="text" id="addr_tx2" name="addr_tx2" class="inputDisabled inp-100" >
											</div>
										</div>
									</div>
								</div>
						
							</div>
							
							<div class="bor-div">
							
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit-top">자녀</div>
										<div>
											<div class="table">
												<div class="wid-3 verti-top">
													<a class="btn btn03" onclick="javascript:add_child();"><i class="material-icons">add</i>자녀회원 추가</a>
												</div>
												<div>
													<div class="table-mem02 table-mem_child"></div>		
												</div>
											</div>																
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit">차량번호</div>
										<div>
											<input type="text" id="car_no" name="car_no">
										</div>
									</div>
								</div>
							
							</div>
							
							<!-- 
							<div class="bor-div dis-no">
							
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit-top">관리자메모</div>
										<div>
											<textarea id="" name="" class="inp-100"></textarea>								
											
											<div class="top-row">
												<div class="wid-5">
													<div class="table">
														<div class="sear-tit">수정일시</div>
														<div>
															<input type="text" id="" name="" class="inputDisabled inp-100" placeholder="2019-12-02" disabled="disabled">
														</div>
													</div>
												</div>
												<div class="wid-5">
													<div class="table">
														<div class="sear-tit">수정자</div>
														<div>
															<input type="text" id="" name="" class="inputDisabled inp-100" placeholder="미수정" disabled="disabled">
														</div>
													</div>
												</div>
											</div>
										</div>
									
									</div>
								</div>
							
							</div>
							 -->
							<div class="bor-div">
							
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit-top">관리자메모</div>
										<div>
											<div class="table-scr">
												<div class="table-list table-list02">
													<table id="managerTable">
														<thead>
															<tr>
																<th onclick="sortTD(0,'sort_contents')">내용<img src="/img/th_up.png" id="sort_contents"></th>
																<th onclick="sortTD(1,'sort_memo_create_date')">작성일시<img src="/img/th_up.png" id="sort_memo_create_date"></th>
																<th onclick="sortTD(2,'sort_memo_manager_nm')">작성자<img src="/img/th_up.png" id="sort_memo_manager_nm"></th>
																<th><i class="material-icons add" onclick="add_memo();">add_circle_outline</i></th>
															</tr>
														</thead>
														<tbody class="cust_memo_area">
															
															
														</tbody>
													</table>
												</div>
												
											</div>
										</div>
									
									</div>
								</div>
							
							</div>
						
						</div>
						
					</div>
				</div>
				
				<div class="btn-wr text-center">
					<a class="btn btn02 ok-btn" onclick="javascript:save_cust_info();">저장</a>
				</div>
				
			</div> <!-- member-profile end -->
			
			<div class="billing-history">
				<div class="table-list">
					<div class="table-listin">
						<div class="top-row sear-wr">
							<div class="">
								<div class="table table-auto">
								
									<div>
										<select de-data="${year}" id="selYear1" name="selYear1" onchange="">
											<option value="">전체</option>
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
										<select de-data="전체" id="selSeason1" name="selSeason1">
											<option value="">전체</option>
											<option value="봄">봄</option>
											<option value="여름">여름</option>
											<option value="가을">가을</option>
											<option value="겨울">겨울</option>									
										</select>
									</div>
									<div class="dash"> ~ </div>
									<div>
										<select de-data="${year}" id="selYear2" name="selYear2" onchange="">
											<option value="">전체</option>
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
										<select de-data="전체" id="selSeason2" name="selSeason2">
											<option value="">전체</option>
											<option value="봄">봄</option>
											<option value="여름">여름</option>
											<option value="가을">가을</option>
											<option value="겨울">겨울</option>									
										</select>
									</div>
								</div>
							</div>
<!-- 							<div class="wid-35 mag-lr2"> -->
<!-- 								<div class="table table-input"> -->
<!-- 									<div class="sear-tit sear-tit_left">조회기간</div> -->
<!-- 									<div> -->
<!-- 										<div class="cal-row table"> -->
<!-- 											<div class="cal-input cal-input02"> -->
<!-- 												<input type="text" id="lect_start_day" class="date-i" /> -->
<!-- 												<i class="material-icons">event_available</i> -->
<!-- 											</div> -->
<!-- 											<div class="cal-dash">-</div> -->
<!-- 											<div class="cal-input cal-input02"> -->
<!-- 												<input type="text" id="lect_end_day" class="date-i" /> -->
<!-- 												<i class="material-icons">event_available</i> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
							
							<div class="wid-15">
								<div class="table">
									<div class="sear-tit sear-tit_left">수강자</div>
									<div>
										<select id="listener" de-data="전체">
											<option value="">전체</option>
											<option value="1">본인</option>
											<option value="2">자녀</option>
										</select>
									</div>
								</div>
							</div>
							
						</div>
					</div>
					<input class="search-btn02 btn btn02" type="button" value="Search" onclick="search_lect()">
				</div>
				
				
				<div class="table-wr">
					<div class="table-cap table">
						<div class="cap-l">
							<p class="cap-numb"></p>
						</div>
					</div>
					<div class="thead-box on">
						<table>
							<colgroup>
								<col width="60px">
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col width="250px">
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th class="td-80">지점</th>
									<th class="td-80">기수</th>
									<th onclick="reSortAjax_custInfo('sort_sale_date','lect')">결제일자<img src="/img/th_up.png" id="sort_sale_date"></th>
									<th onclick="reSortAjax_custInfo('sort_sale_fg','lect')">결제구분<img src="/img/th_up.png" id="sort_sale_fg"></th>
									<th onclick="reSortAjax_custInfo('sort_pos_no','lect')">포스번호<img src="/img/th_up.png" id="sort_pos_no"></th>
									<th onclick="reSortAjax_custInfo('sort_recpt_no','lect')">영수증번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
									<!--<th onclick="reSortAjax_custInfo('sort_gubun','lect')">결제수단<img src="/img/th_up.png" id="sort_gubun"></th>-->
									<th>결제수단</th>
									<th onclick="reSortAjax_custInfo('sort_subject_cd','lect')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
									<th onclick="reSortAjax_custInfo('sort_subject_nm','lect')" class="td-170">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_web_lecturer_nm','lect')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_cust_nm','lect')">수강자<img src="/img/th_up.png" id="sort_cust_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_food_fee','lect')">재료비<img src="/img/th_up.png" id="sort_food_fee"></th>
									<th onclick="reSortAjax_custInfo('sort_enuri_val','lect')">할인<img src="/img/th_up.png" id="sort_enuri_val"></th>
									<th onclick="reSortAjax_custInfo('sort_regis_fee','lect')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="table-list scr-staton">
						<table>
							<colgroup>
								<col width="60px">
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
								<col width="250px">
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th class="td-80">지점</th>
									<th class="td-80">기수</th>
									<th onclick="reSortAjax_custInfo('sort_sale_date','lect')">결제일자<img src="/img/th_up.png" id="sort_sale_date"></th>
									<th onclick="reSortAjax_custInfo('sort_sale_fg','lect')">결제구분<img src="/img/th_up.png" id="sort_sale_fg"></th>
									<th onclick="reSortAjax_custInfo('sort_pos_no','lect')">포스번호<img src="/img/th_up.png" id="sort_pos_no"></th>
									<th onclick="reSortAjax_custInfo('sort_recpt_no','lect')">영수증번호<img src="/img/th_up.png" id="sort_recpt_no"></th>
									<!--<th onclick="reSortAjax_custInfo('sort_gubun','lect')">결제수단<img src="/img/th_up.png" id="sort_gubun"></th>-->
									<th>결제수단</th>
									<th onclick="reSortAjax_custInfo('sort_subject_cd','lect')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
									<th onclick="reSortAjax_custInfo('sort_subject_nm','lect')" class="td-170">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_web_lecturer_nm','lect')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_cust_nm','lect')">수강자<img src="/img/th_up.png" id="sort_cust_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_food_fee','lect')">재료비<img src="/img/th_up.png" id="sort_food_fee"></th>
									<th onclick="reSortAjax_custInfo('sort_enuri_val','lect')">할인<img src="/img/th_up.png" id="sort_enuri_val"></th>
									<th onclick="reSortAjax_custInfo('sort_regis_fee','lect')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
								</tr>
							</thead>
							<tbody id="lect_info_area">
							
							</tbody>
						</table>
					</div>
					
				</div>
			
			</div> <!-- billing-history end -->
			
			
			<div class="sms-send">			
				<div class="table-list">
					<div class="table-listin">
						<div class="top-row sear-wr">
							<div class="wid-2">
								<div class="table">
									<div class="sear-tit sear-tit-70">발송자</div>
									<div>
										<input type="text" id="send_kor" name="send_kor" value="" placeholder="입력하세요." onkeypress="excuteEnter(search_message)">
									</div>
								</div>
							</div>
							<div class="wid-4 mag-l2">
								<div class="table table-input">
									<div class="sear-tit sear-tit-70">조회기간</div>
									<div>
										<div class="cal-row">
											<div class="cal-input cal-input02">
												<input type="text" id="send_start" class="date-i" />
												<i class="material-icons">event_available</i>
											</div>
											<div class="cal-dash">-</div>
											<div class="cal-input cal-input02">
												<input type="text" id="send_end" class="date-i" />
												<i class="material-icons">event_available</i>
											</div>
										</div>
									</div>
								</div>					
							</div>
							<div class="wid-2">
								<div class="table">	
									<div class="sear-tit">발송상태</div>
									<div>
										<select de-data="전체" id="send_state">
											<option value="">전체</option>
											<option value="S">발송성공</option>
											<option value="F">발송실패</option>
										</select>
									
									</div>		
								</div>					
							</div>
						</div>
						

						<input class="search-btn02 btn btn02" type="button" value="Search" onclick="search_message()">
					</div>
				</div>		
				
				<div class="table-wr">
					<div class="table-cap table">
						<div class="cap-l">
							<p class="cap-numb"></p>
						</div>
					</div>
					
					<div class="thead-box on">
						<table>
							<colgroup>
								<col width="60px">
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
									</th>
									<th onclick="reSortAjax_custInfo('sort_send_type','sms')">구분<img src="/img/th_up.png" id="sort_send_type"></th>
									<th onclick="reSortAjax_custInfo('sort_sms_title','sms')">제목<img src="/img/th_up.png" id="sort_sms_title"></th>
									<th onclick="reSortAjax_custInfo('sort_manager_nm','sms')">발송자<img src="/img/th_up.png" id="sort_manager_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_create_date','sms')">발송일시<img src="/img/th_up.png" id="sort_create_date"></th>
									<th onclick="reSortAjax_custInfo('sort_send_result','sms')">발송상태<img src="/img/th_up.png" id="sort_send_result"></th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="table-list scr-staton">
						<table>
							<colgroup>
								<col width="60px">
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
									</th>
									<th onclick="reSortAjax_custInfo('sort_send_type','sms')">구분<img src="/img/th_up.png" id="sort_send_type"></th>
									<th onclick="reSortAjax_custInfo('sort_sms_title','sms')">제목<img src="/img/th_up.png" id="sort_sms_title"></th>
									<th onclick="reSortAjax_custInfo('sort_manager_nm','sms')">발송자<img src="/img/th_up.png" id="sort_manager_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_create_date','sms')">발송일시<img src="/img/th_up.png" id="sort_create_date"></th>
									<th onclick="reSortAjax_custInfo('sort_send_result','sms')">발송상태<img src="/img/th_up.png" id="sort_send_result"></th>
								</tr>
							</thead>
							<tbody class="message_area">

								
								
								
							</tbody>
						</table>
					</div>					
				</div>
				
			</div> <!-- sms-send end -->
			
			<div class="tm-consulting">
			
				<div class="table-list">
					<div class="table-listin">
						<div class="top-row sear-wr">
							<div class="wid-2">
								<div class="table table-auto">
									<div class="sear-tit sear-tit-70">TM 담당자</div>
									<div>
										<input type="text" id="send_kor_tm" name="send_kor_tm" value="" placeholder="입력하세요.">
									</div>
								</div>
							</div>
							<div class="wid-4 mag-l2">
								<div class="table table-input">
									<div class="sear-tit sear-tit-70">조회기간</div>
									<div>
										<div class="cal-row">
											<div class="cal-input cal-input02">
												<input type="text" id="send_start_tm" class="date-i" />
												<i class="material-icons">event_available</i>
											</div>
											<div class="cal-dash">-</div>
											<div class="cal-input cal-input02">
												<input type="text" id="send_end_tm" class="date-i" />
												<i class="material-icons">event_available</i>
											</div>
										</div>
									</div>
								</div>
							</div>							
							<div class="wid-2">
								<div class="table">								
									<div class="sear-tit sear-tit-70">수신자</div>
									<div>
										<ul class="chk-ul">
											<li>
												<input type="checkbox" id="chk_myself_a" name="chk_myself_a">
												<label for="chk_myself_a">본인</label>
											</li>
											<li>
												<input type="checkbox" id="chk_myself_b" name="chk_myself_b">
												<label for="chk_myself_b">본인 외</label>
											</li>
										</ul>
									</div>
								</div>
							</div>
							
							<div class="wid-2">
								<div class="table">	
									<div class="sear-tit ">재통화 필요</div>
									<div>
										<ul class="chk-ul">
											<li>
												<input type="checkbox" id="chk_recall_a" name="chk_recall_a">
												<label for="chk_recall_a">Y</label>
											</li>
											<li>
												<input type="checkbox" id="chk_recall_b" name="chk_recall_b">
												<label for="chk_recall_b">N</label>
											</li>
										</ul>
									</div>		
								</div>					
							</div>
							
						</div>
						<input class="search-btn02 btn btn02" type="button" value="Search" onclick="search_tm()">
					</div>
				</div>		
				
				<div class="table-wr">
					<div class="table-cap table">
						<div class="cap-l">
							<p class="cap-numb"></p>
						</div>
					</div>
					<div class="thead-box on">
						<table>
							<colgroup>
								<col width="60px">
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
									</th>
									
									<th onclick="reSortAjax_custInfo('sort_phone','tm')">발신번호<img src="/img/th_up.png" id="sort_phone"></th>
									<th onclick="reSortAjax_custInfo('sort_title','tm')" class="td-300">내용요약<img src="/img/th_up.png" id="sort_title"></th>
									<th onclick="reSortAjax_custInfo('sort_receiver','tm')">수신자<img src="/img/th_up.png" id="sort_receiver"></th>
									<th onclick="reSortAjax_custInfo('sort_tm_date','tm')">통화일시<img src="/img/th_up.png" id="sort_tm_date"></th>
									<th onclick="reSortAjax_custInfo('sort_manager_nm','tm')">TM담당자<img src="/img/th_up.png" id="sort_manager_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_recall_yn','tm')">재통화필요<img src="/img/th_up.png" id="sort_recall_yn"></th>
								</tr>
							</thead>
						</table>
					</div>
					<div class="table-list scr-staton">
						<table>
							<colgroup>
								<col width="60px">
								<col>
								<col>
								<col>
								<col>
								<col>
								<col>
							</colgroup>
							<thead>
							
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
									</th>
									
									<th onclick="reSortAjax_custInfo('sort_sender_num','tm')">발신번호<img src="/img/th_up.png" id="sort_sender_num"></th>
									<th onclick="reSortAjax_custInfo('sort_subject_nm','tm')" class="td-300">내용요약<img src="/img/th_up.png" id="sort_subject_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_receiver','tm')">수신자<img src="/img/th_up.png" id="sort_receiver"></th>
									<th onclick="reSortAjax_custInfo('sort_tm_date','tm')">통화일시<img src="/img/th_up.png" id="sort_tm_date"></th>
									<th onclick="reSortAjax_custInfo('sort_manager_nm','tm')">TM담당자<img src="/img/th_up.png" id="sort_manager_nm"></th>
									<th onclick="reSortAjax_custInfo('sort_recall_yn','tm')">재통화필요<img src="/img/th_up.png" id="sort_recall_yn"></th>
								</tr>
								
							</thead>
							<tbody class="tm_area">
							<!-- 
								<tr>
								   	<td class="td-chk">
										<input type="checkbox" id="tm_1" name="tm_1" value=""><label for="tm_1"></label>
									</td>
								   	<td>070-7763-6740</td>
								   	<td class="multi02">
								   		<div class="txt">통화완료-이강을 희망한다고 하여 2019-11-26 오후 2시에 DESK로... </div><i class="material-icons">message</i>
								   		<div class="multi-pop02">
								   			<div class="close"><i class="far fa-window-close"></i></div>
								   			통화완료-이강을 희망한다고 하여 2019-11-26
											오후 2시에 DESK로 방문 예약하기로 통화완료 되었습니다.
											특이사항은 없습니다.
										</div>
								   	</td>
								   	<td>본인</td>
								   	<td>2019-09-02</td>
								   	<td>임수진</td>
								   	<td>N</td>				  						   
								</tr>
							-->
								
							</tbody>
						</table>
					</div>					
				</div>	
			
			</div> <!-- tm-consulting end -->

			
		
		
		</div> <!-- tab-content end -->
		
		

	</div> <!-- tab-wrap end -->
	
</div>

<!-- <div id="give_layer" class="list-edit-wrap"> -->
<!-- 	<div class="le-cell"> -->
<!-- 		<div class="le-inner"> -->
<!--         	<div class="list-edit white-bg"> -->
<!--         		<div class="close" onclick="javascript:$('#give_layer').fadeOut(200);"> -->
<!--         			닫기<i class="far fa-window-close"></i> -->
<!--         		</div> -->
<%-- 	        	<c:import url="./search_num.jsp"/> --%>
<!--         	</div> -->
<!--         </div> -->
<!--     </div>	 -->
<!-- </div> -->


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>