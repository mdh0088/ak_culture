<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.7.7/xlsx.core.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xls/0.7.4-a/xls.core.min.js"></script>
<script src="/inc/js/findNotEuc.js"></script>
<script>
var state_val="1";
var custList="";
var excel_list="";
var rbyte = 0;
//var getCustNo ="${getCustNo}";

//alert("${login_rep_store}");

function fncPeri(){
	
}

$( document ).ready(function() {
	/*
	if (getCustNo!="") {
		custList=getCustNo;
		$('#cust_list').val(custList)
		$('#cust_cnt').val('1명');
	}
	*/
	$('.time_area ').hide();
	choose_sendType();
	choose_sms_store('${login_rep_store}');
	choose_contType('1');
	
});
function addCust()
{
	$('#give_layer').fadeIn(200);	
}

function choose_state(idx){
	
	if (idx=='imi') 
	{
		state_val=1;
		$('#imi_area').addClass('active');
		$('#auto_area').removeClass('active');
		
	}
	else if(idx=='auto')
	{
		state_val=2;
		$('#auto_area').addClass('active');
		$('#imi_area').removeClass('active');
	}
}

function save_sms()
{
	
	var str = "";
    str = findNotEuc($("#message_area").val().replace(/(\n|\r\n)/g, ''));
    if(str != "")
    {
       alert("부적절한 문자가 포함되어있습니다 ("+str+")");
       return false;
    }
   
	   
	var store_value="";
	if ($('#store_b').prop("checked")) 
	{
		store_value="03";
	}
	else if($('#store_s').prop("checked"))
	{
		store_value="02";
	}
	else if($('#store_w').prop("checked"))
	{
		store_value="05";
	}
	else if($('#store_p').prop("checked"))
	{
		store_value="04";
	}
	
	var cont_type_value="";
	if ($('#cont_type_a').prop("checked")) 
	{
		cont_type_value="1";
	}
	else if($('#cont_type_b').prop("checked"))
	{
		cont_type_value="2";
	}
	else if($('#cont_type_c').prop("checked"))
	{
		cont_type_value="3";
	}
	else if($('#cont_type_d').prop("checked"))
	{
		cont_type_value="4";
	}
	else if($('#cont_type_e').prop("checked"))
	{
		cont_type_value="5";
	}
	
	
	var is_lec="N"
	if ($('#chk_cus').hasClass('on'))
	{
		is_lec="N";
	}
	else
	{
		is_lec="Y";
	}
	
	
	/*
	if ($('#send_type_a').prop("checked")!=1 && $('#send_type_b').prop("checked")!=1) 
	{
		alert('발송수단을 선택해주세요.');
		return;
	}
	*/

	if (custList=="" && excel_list=="") 
	{
		alert('발송 대상을 지정해주세요.');
		return;	
	}	
	
	
	if ($('#message_title').val()=="")
	{
		alert("제목을 입력해주세요.");
		return;
	}
	
	if ($('#message_area').text()=="")
	{
		alert("발송 내용을 입력해주세요.");
		return;
	}
	
	var f = document.fncForm;
	//(f.send_type_a.checked==true) ? f.send_type_a.value="on" : f.send_type_a.value="off";
	//(f.send_type_b.checked==true) ? f.send_type_b.value="on" : f.send_type_b.value="off";
	
	/*
	if (f.send_type_a.checked==true) 
	{
		alert('알림톡 기능은 준비중입니다.');
		return;
	}
	*/
	
	
	var cnt = $('#cust_cnt').val().replace('명','');
	/*
	if (cnt>=200) 
	{
		alert('전송 제한 인원을 초과하였습니다.(최대 200명) ');
		return;
	}
	*/
	console.log("custList : "+custList);
	console.log("excel_list : "+excel_list);
	
	if (excel_list!="") 
	{
		var excel_chk=excel_list.split('|');	
		var chk_arr = new Array();
		var chk=true;

		
		for (var i = 0; i < excel_chk.length; i++) {
			
			chk=true;
			if (nullChk(excel_chk[i])!="") 
			{
				for (var j = 0; j < chk_arr.length; j++) {
					if (excel_chk[i] == chk_arr[j]) 
					{
						chk=false;
						break;
					}
				}
				
				if (chk) 
				{
					chk_arr.push(excel_chk[i]);
				}
				else if (chk==false) 
				{
					chk_phone_no=excel_chk[i];
					break;
				}
			}
		}
		if (chk==false) 
		{
			alert("엑셀 파일에 중복된 전화번호가 있습니다.");
			return;
		}
	
	}
	
	if (custList!="" && excel_list !="") 
	{
		if(!confirm("엑셀 전송 대상이 있습니다. 전송 하시겠습니까?"))
		{
			return;
		}
	}
	
	if (custList!="" && excel_list !="") 
	{
		if(!confirm("엑셀 전송 대상이 있습니다. 전송 하시겠습니까?"))
		{
			return;
		}
	}
	
	
	
	$.ajax({
		type : "POST", 
		url : "./sms_send",
		dataType : "text",
		data : 
		{
			//store : f.store.value,
			store : store_value,
			cust_list : custList,
			excel_list : excel_list,
			cont_type : cont_type_value,
			message_title : f.message_title.value,
			message_area : f.message_area.value,
			lms_flag : lms_flag,
			is_lec : is_lec
			
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
			if (result.isSuc=="success") 
			{
				location.reload();
			}
			
			
		},
		beforeSend: function () {
			$('.waitForLoad').show();
		},
		complete: function () {
			$('.waitForLoad').hide();
		}
	});
	

}

var sms_chk_flag=0;
var lms_flag=false;
function choose_sendType(){
	lms_flag=false;
	sms_chk_flag=1;
	
	if (sms_chk_flag==1 && rbyte>=90) 
	{
		$('#chk_sms').removeClass('btn03');
		$('#chk_sms').addClass('sms-txtn');
		$('#chk_lms').removeClass('sms-txtn');
		$('#chk_lms').addClass('btn03');
		lms_flag = true;
	}
	else if(sms_chk_flag==1 && rbyte<=90)
	{
		$('#chk_lms').removeClass('btn03');
		$('#chk_lms').addClass('sms-txtn');
		$('#chk_sms').removeClass('sms-txtn');
		$('#chk_sms').addClass('btn03');
	}

}

function fnChkByte(maxByte){
	var str = $('#message_area').val();
	var str_len = str.length;

	rbyte = 0;
	var rlen = 0;
	var one_char = "";
	var str2 = "";
	
	for(var i=0; i<str_len; i++){
		one_char = str.charAt(i);
		
	
		if(escape(one_char).length > 4)
		{
		    rbyte += 2;                                         //한글2Byte
		}
		else if(one_char=="<" || one_char==">" || one_char=="\n")
		{
			rbyte += 4; 
		}
		else if(one_char=="'")
		{
			rbyte += 5;
		}
		else if(one_char=='"')
		{
			rbyte += 6;
		}
		else
		{
		    rbyte++;                                            //영문 등 나머지 1Byte
		}

		if(rbyte <= maxByte)
		{
		    rlen = i+1;                                          //return할 문자열 갯수
		}
	}
	lms_flag=false;
	if (sms_chk_flag==1 && rbyte>=90) 
	{
		$('#chk_sms').removeClass('btn03');
		$('#chk_sms').addClass('sms-txtn');
		
		$('#chk_lms').removeClass('sms-txtn');
		$('#chk_lms').addClass('btn03');
		$('#message_type').val('lms');
		lms_flag =true;
	}
	else if(sms_chk_flag==1 && rbyte<=90)
	{
		lms_flag=false;
		$('#chk_lms').removeClass('btn03');
		$('#chk_lms').addClass('sms-txtn');
		
		$('#chk_sms').removeClass('sms-txtn');
		$('#chk_sms').addClass('btn03');
		$('#message_type').val('sms');
	}
	
	console.log(rbyte+"byte");
	
	if(rbyte > maxByte)
	{
	    //alert('한글 '+(maxByte/2)+'자 / 영문 '+maxByte+'자를 초과 입력할 수 없습니다.');
	    alert('허용 데이터 용량을 초과했습니다. (최대 2000Byte)');
	    str2 = str.substr(0,rlen);  //문자열 자르기                                
	    $('#message_area').val(str2);
	    fnChkByte(maxByte);
	}
	else
	{
	    //document.getElementById('byteInfo').innerText = rbyte;
	    $('#text_num').text(rbyte);
	}
}



function addCode(idx){
	 var txtArea = document.getElementById('message_area');
	 var txtValue = txtArea.value;
	 var selectPos = txtArea.selectionStart; // 커서 위치 지정

	 if (selectPos==0 && txtValue!="") {
		alert('삽입 영역을 지정해주세요.');
		return;
	 }
	 
	 var beforeTxt = txtValue.substring(0, selectPos);  // 기존텍스트 ~ 커서시작점 까지의 문자
	 var afterTxt = txtValue.substring(txtArea.selectionEnd, txtValue.length);   // 커서끝지점 ~ 기존텍스트 까지의 문자
	 //var addTxt = document.getElementById('addInput').value; // 추가 입력 할 텍스트
	 var addTxt = '{'+idx+'}'; // 추가 입력 할 텍스트

	 txtArea.value = beforeTxt + addTxt + afterTxt;

	 selectPos = selectPos + addTxt.length;
	 txtArea.selectionStart = selectPos; // 커서 시작점을 추가 삽입된 텍스트 이후로 지정
	 txtArea.selectionEnd = selectPos; // 커서 끝지점을 추가 삽입된 텍스트 이후로 지정
	 txtArea.focus();
	 fnChkByte('2000');
}

function choose_message(idx){
	var sms_seq="";
	var chk_cnt=0;
	/*
    $('input[name="message_idx"]:checked').each(function(i){//체크된 리스트 저장
    	sms_seq= $(this).val();
    	if (chk_cnt>=1) {
			alert('2개이상 선택을 하셨습니다.');
			return false;
		}
    	chk_cnt++;
    });
	*/
	
	//sms_seq=$('input[name="message_idx"]:checked').val();
	sms_seq = idx;
	
	if (sms_seq==null) {
		sms_seq="";
		alert('발송내용을 선택해주세요.');
		return;
	}
	

	$.ajax({
		type : "POST", 
		url : "./choose_message",
		dataType : "text",
		data : 
		{
			sms_seq : sms_seq
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if (result.length!=0) {
				/*
				if (nullChk(result[0].SEND_TYPE).indexOf('1')!=-1 || nullChk(result[0].SEND_TYPE).indexOf('1|')!=-1) {
					$('#send_type_a').prop('checked',true);	
				}else{
					$('#send_type_a').prop('checked',false);
				}
				
				if (nullChk(result[0].SEND_TYPE).indexOf('2')!=-1 || nullChk(result[0].SEND_TYPE).indexOf('|2')!=-1) {
					$('#  ').prop('checked',true);
				}else{
					$('#send_type_b').prop('checked',false);
				}
				*/

				
				if (result[0].STORE!='' && result[0].STORE!=null) { //고객구분
					if (result[0].STORE == '03') {
						$('#store_b').prop('checked',true);	
					}else if(result[0].STORE == '02'){
						$('#store_s').prop('checked',true);			
					}else if(result[0].STORE == '04'){
						$('#store_p').prop('checked',true);			
					}else if(result[0].STORE == '05'){
						$('#store_w').prop('checked',true);				
					}
				}
				
				
				
				if (result[0].CONT_TYPE=='1') {
					$('#cont_type_a').prop('checked',true);	
				}else if(result[0].CONT_TYPE=='2'){
					$('#cont_type_b').prop('checked',true);	
				}else if(result[0].CONT_TYPE=='3'){
					$('#cont_type_c').prop('checked',true);	
				}else if(result[0].CONT_TYPE=='4'){
					$('#cont_type_d').prop('checked',true);	
				}else if(result[0].CONT_TYPE=='5'){
					$('#cont_type_e').prop('checked',true);	
				}
				
				if (result[0].CONT_TITLE!=null && result[0].CONT_TITLE!="") {
					$('#message_title').val(result[0].CONT_TITLE);
				}
				
				if (result[0].MESSAGE!=null && result[0].MESSAGE!="") {
					var message_text = repWord(result[0].MESSAGE);
					$('#message_area').val(message_text);

						var maxByte=2000;
						var str = message_text;
						var str_len = str.length;

						rbyte = 0;
						var rlen = 0;
						var one_char = "";
						var str2 = "";

						for(var i=0; i<str_len; i++){
							one_char = str.charAt(i);
							if(escape(one_char).length > 4){
							    rbyte += 2;                                         //한글2Byte
							}else{
							    rbyte++;                                            //영문 등 나머지 1Byte
							}

							if(rbyte <= maxByte){
							    rlen = i+1;                                          //return할 문자열 갯수
							}
						}
					$('#text_num').text(rlen);
				}
				choose_sendType();
			}
		}
	});	
}

function choose_custList(idx){
	var sms_seq = $(idx).val();

	$.ajax({
		type : "POST", 
		url : "./choose_custList",
		dataType : "text",
		data : 
		{
			sms_seq : sms_seq
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);	
			var getList="";
			if (result.length!=0) {
				$('#cust_cnt').val(result.length+'명');
			}
			for (var i = 0; i < result.length; i++) {
				getList += result[i].CUST_NO+'|';
			}
			
			$('#cust_list').val(getList);
			custList=getList;
			custList = custList.slice(0,-1);
		}
	});	
}

function show_timeZone(){
	if ($('#send_set_a').prop("checked")) {
		$('#send_set_day').val("");
		$('#set_hour').val(00);
		$('.set_hour').text("0");
		$('#set_min').val(00);
		$('.set_min').text("0");
		
		$('.time_area ').hide();
	}
	
	if ($('#send_set_b').prop("checked")) {
		$('.time_area ').show();
	}
}

function messageList(store){
	
	//var f = document.fncForm;
	//var send_state="";
	//if(f.choouse_imi.checked==true){send_state="1,"};
	//if(f.choose_auto.checked==true){send_state+="2,"};
	//send_state = send_state.slice(0,-1);
	
	$.ajax({
		type : "POST", 
		url : "./getSendList",
		dataType : "text",
		data : 
		{
			store : store
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
			if (result.list.length!=0) 
			{
				for (var i = 0; i < result.list.length; i++) {
					inner +='<tr>';
					inner +='	<td class="wid-3">'+result.list[i].CREATE_DATE+'</td>';
					inner +='	<td>'+result.list[i].CONT_TITLE+'</td>';
					inner +='	<td class="scode-03 wid-3"><a onclick="javascript:choose_message('+result.list[i].SMS_SEQ+');" class="btn btn01">자세히보기</a></td>';
					inner +='</tr>';
				}
			}
			else
			{
				inner +='<tr>';
				inner +='	<td>발송된 내용이 없습니다.</td>';
				inner +='</tr>';
			}
			
			$('#sendList_target').html(inner);
		}
	});	
	
	
}




function readExcel() 
{
	var input = event.target;
    var reader = new FileReader();	
    
    var xls_chk = input.files[0].name.split('.');
    if (xls_chk[1].toLowerCase() != "xlsx" && xls_chk[1].toLowerCase() !="xls" ) 
    {
    	alert('엑셀 파일만 업로드할 수 있습니다.');
    	return;
    }


    // File Reader객체의 onload Event Handler를 구현합니다.
    reader.onload = function(oFile) 
    {
	    var binary = "";
	    var bytes = new Uint8Array(oFile.target.result);
	    var length = bytes.byteLength;
	    for (var i = 0; i < length; i++) 
	    {
	      binary += String.fromCharCode(bytes[i]);
	    }
	    var workbook = XLSX.read(binary, { type: 'binary' });
	    
	    // Excel화일에는 1개 이상의 Sheet가 존재할 수 있으므로 Sheet 수만큼 반복합니다..
	    workbook.SheetNames.forEach(function(sheetName) 
	    {
            // Parsing된 Excel 자료를 JSON모델에 Sheet명으로 저장합니다.
            console.log('SheetName: ' + sheetName);
        	var rows = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName]);
            console.log(JSON.stringify(rows));
            var result = JSON.parse(JSON.stringify(rows));
            
           	if (result.length==0)
			{
           		alert("전송할 전화번호가 없습니다 엑셀 파일의 내용을 확인해 주세요.");
				return false;
			}
           	
            if (nullChk(result[0].PHONE_NO)=="")
            {
				alert("정확한 양식의 파일을 올려주세요.");
				return false;
			}
            
            excel_list="";
            var temp="";
            for (var i = 0; i < result.length; i++)
            {
            	if (trim(result[i].PHONE_NO)!="") 
            	{					
	            	excel_list+=isCellPhone(result[i].PHONE_NO)+"|";			
				}
			}
	    });
    };
    reader.readAsArrayBuffer(input.files[0]);
    
    
	var fileTarget = $('#excel_file'); 
	
	if(window.FileReader) // modern browser
	{ 
		var filename = input.files[0].name;
	} 
	else // old IE  
	{ 
		var filename = input.val().split('/').pop().split('\\').pop(); // 파일명만 추출 
	} 
	// 추출한 파일명 삽입 ;
	$('#file_nm').val(filename);
}



function choose_sms_store(store){
	$.ajax({
		type : "POST", 
		url : "./recentCustList",
		dataType : "text",
		data : 
		{
			store : store
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
			var li_inner ="";
			var cust_len=0;
			if (result.length > 0) 
			{
				
				for (var i = 0; i < result.length; i++) 
				{
				    cust_len = (result[i].CNT*1)-1;
					if (cust_len > 1) 
					{
						inner +='<option value="'+result[i].SMS_SEQ+'">'+result[i].KOR_NM+' 외 '+cust_len+'명</option>';
						li_inner +='<li>'+result[i].KOR_NM+' 외 '+cust_len+'명</li>';						
					}
					else
					{
						inner +='<option value="'+result[i].SMS_SEQ+'">'+result[i].KOR_NM+'</option>';
						li_inner +='<li>'+result[i].KOR_NM+'</li>';	
					}
				}
						
			}
			else
			{
				inner +='<option value="">발송 내역이 없습니다.</option>';
				li_inner +='<li>발송 내역이 없습니다.</li>';	
				
			}
			$('.recentList_ul').html(li_inner);
			$('#recentList').html(inner);	
		}
	});
	
	messageList(store);
}

function choose_contType(typeVal){
	$('#message_title').val('');
	$('#message_area').empty();
	
	var store_nm="";
	if ($('#store_b').prop("checked")) 
	{
		store_nm="분당";
	}
	else if($('#store_s').prop("checked"))
	{
		store_nm="수원";
	}
	else if($('#store_w').prop("checked"))
	{
		store_nm="원주";
	}
	else if($('#store_p').prop("checked"))
	{
		store_nm="평택";
	}
	
	
	
	var inner="";	
	if (typeVal=="1") //휴강안내 
	{
		inner="(휴강안내)AK플라자 "+store_nm+"점 문화아카데미\n[강좌명]강좌 [00월 00일 0요일]수업은 강사님 개인사유로 휴강입니다.\n보강 일정은 추후 안내드리겠습니다.\n양해 부탁드립니다."
	}
	else if(typeVal=="2") //이강안내
	{
		inner="AK플라자 "+store_nm+"점 문화아카데미 [강좌명] 이강완료.";
	}
	else if(typeVal=="3")	//폐강안내
	{
		inner="AK플라자 "+store_nm+"점 문화아카데미 [강좌명] 강좌 인원미달로 폐강되었습니다.\n환불 취소 관련 안내는 데스크로 연락 부탁드립니다.\문의 [문화아카데미 대표번호]";
	}
	else if(typeVal=="4")	//개강안내
	{
		inner="AK플라자 "+store_nm+"점 문화아카데미\n[강좌명]개강 안내드립니다.\n[시작일] [요일] [시간]0층 [강의실]\n주차안내\n무료 주차시간 :  수업시간 + 1시간\n무인정산을 원하실 경우 사전 차량등록을 하셔야 하며, 차량등록은 전화 또는 데스크 방문 부탁드립니다.\n데스크 운영시간 : 10:00~19:50";
	}
	$('#message_area').text(inner);
	fnChkByte(2000);
}

$(window).load(function(){
	$(".submit-type input[type=checkbox]").click(function(){
		var $chk = $(this).attr("name"),
			state = $(this).is(':checked');
		console.log(state )
		
		/*
		if($chk == "send_type_a" && state == true){
			$("#message_title").attr("disabled", true);	
			$("#message_area").attr("disabled", true);	
		}else{
			$("#message_title").attr("disabled", false);	
			$("#message_area").attr("disabled", false);	
			
		}
		*/
		
	})
})

</script>



<form id="fncForm" name="fncForm" method="post" action="./sms_send">
	<input type="hidden" id="cust_list" name="cust_list" value="">
	<div class="sub-tit">
		<div class="btn-wr btn-style">
			<a class="btn btn02" class="ipNow" href="list">SMS </a>
			<a class="btn btn01" href="list_tm">TM</a>
		</div>
	</div>
	<div class="sub-tit">
		<h2>SMS/TM</h2>
		<ul id="breadcrumbs" class="breadcrumb"></ul>
		<div class="btn-right">
			<a class="btn btn01" href="#">SMS 발송</a>
		</div>
	</div>
	
	<div class="row view-page mem-manage sms-manage ak-wrap_new">
		<div class="wid-5">
			
			<div class="white-bg sms-bg">			
				<div class="row">
					<div class="bor-div">					
						<div class="wid-10">
							<div class="table table02">
								<div class="sear-tit">SMS발신번호<em>*</em></div>
								<div>
									<ul class="chk-ul">
										<li>
											<input type="radio" id="store_b" name="store" value="03" <c:if test="${ '03' eq login_rep_store }">checked</c:if> onchange="choose_sms_store('03')" />
											<label for="store_b">분당점</label>
										</li>
										<li>
											<input type="radio" id="store_s" name="store" value="02" <c:if test="${ '02' eq login_rep_store }">checked</c:if> onchange="choose_sms_store('02')"/>
											<label for="store_s">수원점</label>
										</li>
										<li>
											<input type="radio" id="store_w" name="store" value="05" <c:if test="${ '05' eq login_rep_store }">checked</c:if> onchange="choose_sms_store('05')"/>
											<label for="store_w">원주점</label>
										</li>
										<li>
											<input type="radio" id="store_p" name="store" value="04" <c:if test="${ '04' eq login_rep_store }">checked</c:if> onchange="choose_sms_store('04')"/>
											<label for="store_p">평택점</label>
										</li>
									</ul>
									
								</div>
								<!-- 
								<div>
									<div class="table sms-table table-input">
										<div class="wid-55">
											<input type="text" id="sms_sender" name="sms_sender" class="sms-chin inputDisabled" value="031-456-1422" >
										</div>
										<div class="wid-45">
											<a class="btn btn02 btn-inline sms-chbtn" >변경하기</a>
										</div>
									</div>
								</div>
								 -->
							</div>
						</div>
						<div class="wid-10">
							<div class="table table02">
								<div class="sear-tit">발송대상</div>
								<div>
									<div class="table sms-table table-input">
										<div class="wid-55">
											<input type="text" id="cust_cnt" name="cust_cnt" class="sms-chin inputDisabled" value="" readonly="readonly">
										</div>
										<div class="wid-45">
											<a class="btn btn02 btn-inline sms-chbtn" onclick="javascript:addCust()">불러오기</a>
										</div>
									</div>
								</div>
								<div>
									<div class="btn-inline">
									
									
										<select id="recentList" name="recentList" onchange="choose_custList(this);" de-data="최근 발송대상 불러오기" >
											<c:forEach var="i" items="${recentCustList}" varStatus="loop">
												<c:if test="${i.CNT eq 1}">
													<option value="${i.SMS_SEQ}">${i.KOR_NM}</option>	
												</c:if>
												<c:if test="${i.CNT ne 1}">
													<option value="${i.SMS_SEQ}">${i.KOR_NM} 외 ${i.CNT-1}명 </option>
												</c:if>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="wid-10">
							<div class="table table02 sms-file">
								<div class="sear-tit">엑셀업로드</div>
									<div>
										<div class="filebox table table-auto">
											<div><label for="excel_file">첨부파일</label>
											<input type="file" id="excel_file" name="excel_file" onchange="readExcel();"></div> 
											<div><input id="file_nm" class="upload-name inp-100" disabled value="파일을 첨부해주세요." ></div>
											<a class="btn btn02 btn-inline" href="http://112.106.55.70:8088/upload/sms/sms_sample.xlsx">양식 다운로드</a>
										</div>
									</div>
							</div>
						</div>
						 <!-- 
						<div class="wid-10 ">
							<div class="table">
								<div class="sear-tit">발송설정</div>
								<div class="wid-3">
									<ul class="chk-ul">
										<li>
											<input type="radio" id="send_set_a" name="send_set" value="1" onclick="show_timeZone();" checked="checked">
											<label for="send_set_a">즉시</label>
										</li>
										<li>
											<input type="radio" id="send_set_b" name="send_set" value="2" onclick="show_timeZone();">
											<label for="send_set_b">예약</label>
										</li>
									</ul>
								</div>
								<div>
									<div class="time-row">
										<div class="cal-input cal-input_165">
											<input type="text" class="date-i inputDisabled hasDatepicker" id="send_set_day" name="send_set_day">
											<i class="material-icons">event_available</i>
										</div>
										<div class="cal-dash wid-1"></div>
										
											<div class="time-input time-input180 sel-scr">
												<select de-data="0" id="set_hour" name="set_hour">
													<c:forEach var="i" begin="00" end="23" varStatus="loop">
														<fmt:formatNumber value="${loop.index}" type="number" var="loop_index" />
														<c:if test="${fn:length(loop_index) eq 1}">
															<option value="0${loop_index}">0${loop_index}</option>
														</c:if>
														<c:if test="${fn:length(loop_index) ne 1}">
															<option value="${loop_index}">${loop_index}</option>
														</c:if>
													</c:forEach>
												</select>
											</div>
											<div class="time-dash">:</div>
											<div class="time-input time-input180">
												<select de-data="00" id="set_min" name="set_min">
													<option value="00">00</option>
													<option value="10">10</option>
													<option value="20">20</option>
													<option value="30">30</option>
													<option value="40">40</option>
													<option value="50">50</option>
												</select>
											</div>
										
									</div>
								</div>
							</div>
						</div>
						-->
						
					</div>
					
					
					<div class="bor-div">
						<div class="wid-10">
							<div class="table">
								<div class="sear-tit">발송내용</div>
								<div>
									<ul class="chk-ul chk-ul_sms">
										<li>
											<input type="radio" id="cont_type_a" name="cont_type" value="1" onchange="choose_contType('1')" checked>
											<label for="cont_type_a">휴강안내</label>
										</li>
										<li>
											<input type="radio" id="cont_type_b" name="cont_type" value="2" onchange="choose_contType('2')">
											<label for="cont_type_b">이강안내</label>
										</li>
										<li>
											<input type="radio" id="cont_type_c" name="cont_type" value="3" onchange="choose_contType('3')">
											<label for="cont_type_c">폐강안내</label>
										</li>
										<li>
											<input type="radio" id="cont_type_d" name="cont_type" value="4" onchange="choose_contType('4')">
											<label for="cont_type_d">개강안내</label>
										</li>
										<li>
											<input type="radio" id="cont_type_e" name="cont_type" value="5" onchange="choose_contType('5')">
											<label for="cont_type_e">기타</label>
										</li>
									</ul>
								</div>
							</div>
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit"></div>
									<div>
										<div class="table table-input">
											<div class="wid-7">
												<input type="text" id="message_title" class="notEmpty" name="message_title" placeholder="제목을 입력해주세요." maxlength="25">
			
											</div>
	
										</div>
										
										<div class="wid-10">
											<textarea id="message_area" name="message_area" class="notEmpty inp-100 sms-textarea" onkeyup="javascript:fnChkByte('2000')"></textarea>
										</div>
										<div class="wid-10">
											<div class="table table-input">
												<div>
													<div class="sms-btn sms-txtn"><b id="text_num">0</b>/2000Byte</div>
												</div>
												<div class="text-right">
													<a id="chk_sms" class="sms-btn sms-txtn">SMS<span>(90Bytes)</span></a>
													<a id="chk_lms" class="sms-btn sms-txtn">LMS<span>(2,000Bytes)</span></a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				
			</div>
		</div>
	
		<div class="wid-5 sms-5last">
			<div class="white-bg">
				<!--  
				<div class="sms-top">
					<div class="sms-topw table">
						<div class="sms-topd">
							<p class="sms-ttit">알림톡</p>
							<ul>
								<li>잔여<span class="color-pink">42,358</span><span>80,000</span></li>
							</ul>
						</div>
						<div class="sms-topd">
							<p class="sms-ttit">SMS</p>
							<ul>
								<li>잔여<span class="color-pink">35,000</span><span>80,000</span></li>
							</ul>
						</div>
						<div class="sms-topd">
							<p class="sms-ttit">LMS</p>
							<ul>
								<li>잔여<span class="color-pink">21,452</span><span>80,000</span></li>
							</ul>
						</div>
					</div>
				</div>
				-->
				<div class="bor-div ">
					<div class="sear-tit">치환코드 목록</div>
					<div class="table-wr smsc-table">

					
						<table>
							<colgroup>
								<col width="28%">
								<col>
								<col width="120px">
							</colgroup>
							<tbody>
								<tr>
									<td>{memNm}</td>
									<td>고객명</td>
									<td class="scode-03"><a class="btn btn01" onclick="javascript:addCode('memNm');">내용에 삽입</a></td>
								</tr>
							
								<tr>
									<td>{groupNm}</td>
									<td>회원등급</td>
									<td class="scode-03"><a class="btn btn01" onclick="javascript:addCode('groupNm');">내용에 삽입</a></td>
								</tr>
								<tr>
									<td>{carNb}</td>
									<td>차량번호</td>
									<td class="scode-03"><a class="btn btn01" onclick="javascript:addCode('carNb');">내용에 삽입</a></td>
								</tr>
							</tbody>
						</table>					
					</div>
					
					<div class="smsc-mar70">
						<div class="table">
							<div class="sear-tit">발송내용</div>
							<!--  
							<div style="float:right;">
								<ul class="chk-ul">
									<li>
										<input type="checkbox" id="choouse_imi" name="choouse_imi">
										<label for="choouse_imi">자동발송내역</label>
									</li>
									<li>
										<input type="checkbox" id="choose_auto" name="choose_auto">
										<label for="choose_auto">직접발송내역</label>
									</li>
								</ul>
								<div class="btn-inline">
									<a onclick="javascript:messageList();" class="btn btn03 ">선택한 내용으로 채우기</a>
								</div>
							</div>
							-->
						</div>
					</div>				
					<div class="wid-10">
						<div class="table-wr smsc-table smsc-table02">
							<table>
								<tbody id="sendList_target">
									
								</tbody>
							</table>				
						</div>
					</div>
				</div>
			</div>	
		</div>
	</div>
	<div class="btn-wr text-center">
		<a class="btn btn02 ok-btn" onclick="javascript:save_sms();">저장 후 발송</a>
	</div>
</form>

<div id="give_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg gift-edit">
        		<div class="close" onclick="javascript:$('#give_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<jsp:include page="/WEB-INF/pages/common/getCustList.jsp"/>
        	</div>
        </div>
    </div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>