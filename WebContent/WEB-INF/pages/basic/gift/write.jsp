<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
var gift_cd ="${gift_cd}";
var custList="";
var isChk="${isChk}"; //기수 바뀔때 초기화를 위한 세팅
if (isChk!="") {
	isChk=true;
}


function periInit()
{
	if (isChk===false) 
	{
		gift_reset();
		gift_cd='';
	}
	gift_change();
}

$( document ).ready(function() {
	
	$('#new_gift_nm_area').hide();
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
	$('.accept_type_y').show();
	$('.cust_area').hide();
	
	/////////////////////////////수량 입력 시 총 수량 세팅 start
	
	$('.accept_cnt').on('keyup',function(){
        var cnt = $(".accept_cnt").length;   
		for( var i=1; i< cnt; i++){
		   var sum = parseInt($(this).val() || 0 );
		   sum++
		}
		
        var sum1 = parseInt($("#gift_cnt_w").val() || 0 ); // input 값을 가져오며 계산하지만 값이 없을경우 0이 대입된다  뒷부분에 ( || 0 ) 없을경우 합계에 오류가 생겨 NaN 값이 떨어진다
        var sum2 = parseInt($("#gift_cnt_m").val() || 0);
        var sum3 = parseInt($("#gift_cnt_d").val() || 0);
        var sum = sum1 + sum2 + sum3;
        $("#gift_cnt_t").val(sum);
   	});
	/////////////////////////////수량 입력 시 총 수량 세팅 end

	$("input:text[numberOnly]").on("keyup", function() {
	    $(this).val($(this).val().replace(/[^0-9]/g,""));
	});
	
});

window.onload = function(){
	if (gift_cd!="") //listed페이지에서 넘어올시 세팅
	{
		$("#selBranch").val('${store}');
		$("#selYear").val('${gift_year}');
		$(".selYear").html('${gift_year}');
		fncPeri();	
		$("#selSeason").val('${season_nm}');
		$(".selSeason").html('${season_nm} / ${period}');
		$("#selPeri").val('${period}');
		$("input:radio[name='gift_fg']:radio[value='${gift_fg}']").prop('checked', true);
		gift_change();
		gift_cd = '${gift_cd}';
		choose_code();
		$('.gift_cd').html('${gift_nm}');	
	}
}

function check_new(){
	if ($('#check_new').prop("checked")) 
	{
		$('#gift_code_area').hide();
		$('#new_gift_nm_area').show();
		
		$('#start_ymd').val('');
		$('#end_ymd').val('');
		$('#gift_cnt_left').val('');
		$('#gift_cnt_t').val('');
		$('#gift_cnt_w').val('');
		$('#gift_cnt_m').val('');
		$('#gift_cnt_d').val('');	
	}
	else
	{
		gift_change();
		$('#new_gift_nm_area').hide();
		$('#gift_code_area').show();	
	}
	gift_cd ="";
}

function choose_area()
{
	
	if ($('#gift_date_y').prop("checked")) 
	{
		$('#dis_period_area').show();		
	}
	else
	{
		$('#dis_period_area').hide();
	}
	
	if ( $('#accept_type_y').prop("checked")) 
	{
		$('.accept_type_y').show();
		
		$('#gift_cnt_t').attr('disabled','disabled');
		$('#gift_cnt_t').removeAttr('placeholder');
		$('#gift_cnt_t').addClass('inputDisabled');
	}
	else if($('#accept_type_n').prop("checked"))
	{

		$('.accept_type_y').hide();
		$('#gift_cnt_t').val('');
		$('#gift_cnt_t').attr('placeholder','수량을 입력해주세요.');
		$('#gift_cnt_t').removeAttr('disabled');
		$('#gift_cnt_t').removeAttr('readonly');
		$('#gift_cnt_t').removeClass('inputDisabled');
	}
	
	if ($('#cust_target').prop("checked")) 
	{
		$('.cust_class').hide();
		$('.give_con').hide();
	}
	else
	{
		$('.cust_class').show();
		$('.give_con').show();
	}
	
}

function addCode()
{
	var give_fg = document.querySelector('input[name="give_fg"]:checked').value;
	if (give_fg!="T") {
		alert('대상자 지정을 선택해주세요.');
		return;
	}
	$('#give_layer').fadeIn(200);	
}

function gift_change() //사은품 유형 변경 시
{	
	var gift_fg = document.querySelector('input[name="gift_fg"]:checked').value;

	$('#gift_cd').val('');
	$('.gift_cd').text('사은품을 선택해주세요.');
	
		$.ajax({
			type : "POST", 
			url : "./changeGift",
			dataType : "text",
			data : 
			{
				store : $('#selBranch').val(),
				period : $('#selPeri').val(),
				gift_fg : gift_fg
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
				var inner_ul="";
				
				$('#gift_cd').empty();
				$('.gift_cd_ul').empty();
				if (result.length > 0) {
					for (var i = 0; i < result.length; i++) {
						inner +='<option class="sub_option" value="'+result[i].GIFT_CD+'">'+result[i].GIFT_NM+'</option>';
						inner_ul +='<li>'+result[i].GIFT_NM+'</li>';
					}
				}else{
					inner +='<option class="sub_option" value="">등록된 사은품이 없습니다.</option>';
					inner_ul +='<li>등록된 사은품이 없습니다.</li>';
				}
				
				$('#gift_cd').append(inner);
				$('.gift_cd_ul').append(inner_ul);
			}
		});
	
}



function class_change(idx) //고객 등급 변경시 등급영역 세팅
{ 
	var class_value="";
	if (nullChk(idx)=="") {
		class_value = $('#cust_level_package').val();
	}else{
		class_value=idx;
	}
	
	if (class_value=='1') 
	{
		$('.cust_level').text('전체');
		$(".chk-select").hide();
		$(".chk-select[cust_numb='1']").show();
	}
	else if(class_value=='2')
	{
		$('.cust_level').text('전체');
		$(".chk-select").hide();
		$(".chk-select[cust_numb='2']").show();
	}
	else if(class_value=='3')
	{
		$('.cust_level').text('전체');
		$(".chk-select").hide();
		$(".chk-select[cust_numb='3']").show();
	}
	else
	{
		$(".chk-select").hide();
	}
}


function choose_code(idx){ //코드 선택 시
	if (nullChk(idx)!="")  //데이터를 받는게 아니라 select 선택이라면 이외의 경우 페이지 들어올 시 세팅됨
	{		
		gift_cd = $(idx).val();	
	}
	
	if (gift_cd > 0) {
		$.ajax({
			type : "POST", 
			url : "./getGiftInfo",
			dataType : "text",
			data : 
			{    
				store 	: $('#selBranch').val(),
				period 	: $('#selPeri').val(),
				gift_cd : gift_cd
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				if (result.length > 0) 
				{
					document.getElementsByName("gift_cnt_w")[0].value="";
					document.getElementsByName("gift_cnt_m")[0].value="";
					document.getElementsByName("gift_cnt_d")[0].value="";
									
					if (trim(result[0].GIFT_FG)=='1') 
					{
						$("input:radio[name='gift_fg']:radio[value='1']").prop('checked', true);
					}
					else
					{
						$("input:radio[name='gift_fg']:radio[value='2']").prop('checked', true);
					}
					 //gift_change();
					
					if (nullChk(result[0].GIFT_PRICE)!="") 
					{
						document.getElementsByName("gift_price")[0].value=result[0].GIFT_PRICE;		
					}
					if (nullChk(result[0].GIVE_PERIOD_START)!="") 
					{
						$("input:radio[name='gift_date_yn']:radio[value='Y']").prop('checked', true);
						document.getElementsByName("start_ymd")[0].value=result[0].GIVE_PERIOD_START;
						document.getElementsByName("end_ymd")[0].value=result[0].GIVE_PERIOD_END;
						$('#dis_period_area').show();
					}
					else
					{
						$("input:radio[name='gift_date_yn']:radio[value='N']").prop('checked', true);
						document.getElementsByName("start_ymd")[0].value="";
						document.getElementsByName("end_ymd")[0].value="";
						$('#dis_period_area').hide();
					}
					
					if (nullChk(result[0].GIFT_CNT_W)!="" || nullChk(result[0].GIFT_CNT_M)!="" || nullChk(result[0].GIFT_CNT_D)!="") 
					{
						$("input:radio[name='accept_type']:radio[value='Y']").prop('checked', true);
						$('.accept_type_y').show();
						$('#gift_cnt_t').val('');
						$('#gift_cnt_t').attr('disabled','disabled');
						$('#gift_cnt_t').removeAttr('placeholder');
						$('#gift_cnt_t').addClass('inputDisabled');
					}
					else
					{
						$("input:radio[name='accept_type']:radio[value='N']").prop('checked', true);
						$('.accept_type_y').hide();
						$('#gift_cnt_t').val('');
						$('#gift_cnt_t').attr('placeholder','수량을 입력해주세요.');
						$('#gift_cnt_t').removeAttr('disabled');
						$('#gift_cnt_t').removeAttr('readonly');
						$('#gift_cnt_t').removeClass('inputDisabled');
					}
					
					if (nullChk(result[0].GIVE_FG)=='G') {
						$('#cust_class').prop('checked', true);
					}else{
						$('#cust_target').prop('checked', true);
					}
					choose_area();
					
					if (nullChk(result[0].GIFT_CNT_T)!="") 
					{
						document.getElementsByName("gift_cnt_t")[0].value=result[0].GIFT_CNT_T;
					}
					
					if (nullChk(result[0].LEFT_CNT)!="")
					{
						document.getElementsByName("gift_cnt_left")[0].value=result[0].LEFT_CNT;
					}
					
					if (nullChk(result[0].GIFT_CNT_W)!="")
					{
						document.getElementsByName("gift_cnt_w")[0].value=result[0].GIFT_CNT_W;
					}
					
					if (nullChk(result[0].GIFT_CNT_M)!="") 
					{
						document.getElementsByName("gift_cnt_m")[0].value=result[0].GIFT_CNT_M;
					}
					
					if (nullChk(result[0].GIFT_CNT_D)!="") 
					{
						document.getElementsByName("gift_cnt_d")[0].value=result[0].GIFT_CNT_D;
					}
					
					$("input:radio[name='return_fg']:radio[value='"+result[0].RETURN_FG+"']").prop('checked', true);
					
					if (nullChk(result[0].CREATE_DATE)!="") 
					{
						document.getElementsByName("create_date")[0].value=result[0].CREATE_DATE;
					}
					
					if (nullChk(result[0].CREATE_RESI_NO)!="") 
					{
						document.getElementsByName("create_regi_no")[0].value=result[0].CREATE_RESI_NO;
					}
					
					if (nullChk(result[0].UPDATE_DATE)!="") 
					{
						document.getElementsByName("update_date")[0].value=result[0].UPDATE_DATE;
					}
					if (nullChk(result[0].UPDATE_RESI_NO)!="")
					{
						document.getElementsByName("update_regi_no")[0].value=result[0].UPDATE_RESI_NO;
					}
					
					/////할인은 아래 파트 필요없음, 사은품만 필요
					
					if (nullChk(result[0].SUBJECT_FG)!="") 
					{
						if (result[0].SUBJECT_FG.indexOf('1')!=-1) 
						{
							$('#subject_fg_a').prop('checked', true);
						}else{
							$('#subject_fg_a').prop('checked', false);
						}
						
						if(result[0].SUBJECT_FG.indexOf('2')!=-1)
						{
							$('#subject_fg_b').prop('checked', true);
						}else{
							$('#subject_fg_b').prop('checked', false);
						}
						
						if(result[0].SUBJECT_FG.indexOf('3')!=-1)
						{
							$('#subject_fg_c').prop('checked', true);
						}else{
							$('#subject_fg_c').prop('checked', false);
						}
					}
					
					
					if (nullChk(result[0].CUST_FG)!="") 
					{
						$('#cust_fg').val(result[0].CUST_FG);
						if (result[0].CUST_FG=='1') 
						{
							$('.cust_fg').text('신규');
						}
						else if(result[0].CUST_FG=='2')
						{
							$('.cust_fg').text('기존');
						}
						else
						{
							$('.cust_fg').text('전체');
						}
					}else{
						$('#cust_fg').val("");
						$('.cust_fg').text('전체');
					}
					
					if (nullChk(result[0].LECT_CNT)!="") {
						$('#lect_cnt').val(result[0].LECT_CNT);
					}else{
						$('#lect_cnt').val(0);
					}
					
					if (nullChk(result[0].SEMESTER_CNT)!="") 
					{
						$('#semester_cnt').val(result[0].SEMESTER_CNT);
					}
					else
					{
						$('#semester_cnt').val(0);
					}
					
					
					if (nullChk(result[0].GRADE)!="") 
					{
						var arr=result[0].GRADE.split(',');
						for (var i = 0; i < arr.length; i++) {
							$("input[name=chk_cust][value="+arr[i]+"]").prop("checked",true);
						}
					}
					else
					{
						$('.cust_level').text('전체');
						$("input[name=chk_cust]").prop("checked",false);
					}
					
				}
			}
		});
	}
	isChk=false; //기수 바뀔때 초기화를 위한 세팅
}



function fncSubmit(){
	
	var choose_val="";
	var chk_new = "";
	var new_gift_nm ="";
	if (document.getElementsByName("check_new")[0].checked==true) {
		chk_new = "on";
		new_gift_nm =document.getElementsByName("new_gift_nm")[0].value;
		if (trim(new_gift_nm)=="") {
			alert('신규 사은품 명을 입력하세요.');
			document.getElementsByName("new_gift_nm")[0].focus();
			document.getElementsByName("new_gift_nm")[0].value="";
			return;
		}
	}else{
		chk_new = "off";
		//gift_cd = document.getElementsByName("gift_cd")[0].value;
	}
	var gift_price = document.getElementsByName("gift_price")[0].value;
	var gift_fg = document.querySelector('input[name="gift_fg"]:checked').value;
	var give_fg = document.querySelector('input[name="give_fg"]:checked').value;
	if (give_fg=='G') {
		var len = document.getElementsByName("chk_cust").length;
		for (var i = 0; i < len; i++) {
			if (document.getElementsByName("chk_cust")[i].checked==true) {
				choose_val += document.getElementsByName("chk_cust")[i].value+',';			
			}
		}
		choose_val = choose_val.slice(0,-1);		
	}
	
	var con1_subject_fg_a="";
	var con1_subject_fg_b="";
	var con1_subject_fg_c="";
	
	var cust_fg="";
	var lect_cnt="";
	var semester_cnt="";
	
	if (give_fg=="G") { //지급대상이 고객등급별이면
		if (document.getElementsByName("subject_fg_a")[0].checked==true) {
			con1_subject_fg_a="1";
		}
		if (document.getElementsByName("subject_fg_b")[0].checked==true) {
			con1_subject_fg_b="2";
		}
		if (document.getElementsByName("subject_fg_c")[0].checked==true) {
			con1_subject_fg_c="3";
		}

	 	cust_fg = document.getElementsByName("cust_fg")[0].value;
	 	lect_cnt = document.getElementsByName("lect_cnt")[0].value;
	 	semester_cnt = document.getElementsByName("semester_cnt")[0].value;
	}
	
	var give_type = document.querySelector('input[name="give_type"]:checked').value;
	var gift_date_yn = document.querySelector('input[name="gift_date_yn"]:checked').value;
	var start_ymd="";
	var end_ymd="";
	if (gift_date_yn=='Y') {
		
		start_ymd=document.getElementsByName("start_ymd")[0].value;
		end_ymd=document.getElementsByName("end_ymd")[0].value;
		
		if (start_ymd=="" || end_ymd=="") {
			alert("지급기간을 설정해주세요.");
			return;
		}
		var datatimeRegexp = /[0-9]{4}-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01])/;
		if ( !datatimeRegexp.test(start_ymd) || !datatimeRegexp.test(end_ymd)) {
	        alert("날짜는 yyyy-mm-dd 형식으로 입력해주세요.");
	        return false;
	    }
		
		if (end_ymd < start_ymd ) {
			 alert("종료일을 다시 선택해주세요.");
		     return false;
		}
		
	}
	
	var accept_type = document.querySelector('input[name="accept_type"]:checked').value;
	var gift_cnt_t =document.getElementsByName("gift_cnt_t")[0].value;
	var gift_cnt_w ="";
	var gift_cnt_m ="";
	var gift_cnt_d ="";
	
	if (accept_type=='Y') {
		gift_cnt_w=document.getElementsByName("gift_cnt_w")[0].value;
		gift_cnt_m=document.getElementsByName("gift_cnt_m")[0].value;
		gift_cnt_d=document.getElementsByName("gift_cnt_d")[0].value;
	}
	
	var return_fg = document.querySelector('input[name="return_fg"]:checked').value;

	
	
	if (chk_new=="off" && gift_cd=="") {
		alert("사은품을 선택하거나 신규 사은품을 등록해주세요.");
		return;
	}
	
	if (gift_cnt_t==0) {
		alert("사은품 지급 수량을 설정해주세요.");
		return;
	}
	
   var start_ymd_arr = start_ymd.split('-');
   var end_ymd_arr = end_ymd.split('-');
   var start_date = new Date(start_ymd_arr[0], start_ymd_arr[1], start_ymd_arr[2] ,11 ,59 );
   var end_date = new Date(end_ymd_arr[0], end_ymd_arr[1], end_ymd_arr[2] ,11 ,59 );
   
   if(gift_date_yn=='Y' && end_date < start_date)
   {
      alert("지급기간을 다시 설정해 주세요.");
      return;
   }
	
	$.ajax({
		type : "POST", 
		url : "./write_proc",
		dataType : "text",
		data : 
		{
			store : $('#selBranch').val(),			//지점
			period : $('#selPeri').val(),			//기수
			chk_new : chk_new,						//신규chker
			gift_cd : gift_cd,						//사은품 코드
			gift_fg : gift_fg,
			new_gift_nm : new_gift_nm,				//신규 사은품묭
			gift_price : gift_price,				//사은품 가격
			give_fg : give_fg,						//지급대상 (고객등급별,대상자지정)
			con1_subject_fg_a : con1_subject_fg_a,	//정규
			con1_subject_fg_b : con1_subject_fg_b,	//단기
			con1_subject_fg_c : con1_subject_fg_c,	//특강
			cust_fg : cust_fg,						//고객유형
			lect_cnt : lect_cnt,					//수강수
			semester_cnt : semester_cnt, 			//헉가슈
			give_type : give_type,					//지급방식
			gift_date_yn : gift_date_yn, 			//사은품 지급기간 여부
			start_ymd : start_ymd, 					//지급기간 start
			end_ymd : end_ymd, 						//지급기간 end
			accept_type : accept_type,				//접수수단별 구분
			gift_cnt_t : gift_cnt_t, 				//총 수량
			gift_cnt_w : gift_cnt_w,				//웹 수량
			gift_cnt_m : gift_cnt_m, 				//모바일 수량
			gift_cnt_d : gift_cnt_d,				//데스크 수량
			return_fg :return_fg,					//취소시 반납 여부
			custList :custList,						//회원 리스트
			choose_val : choose_val,				//등급 리스트
			auth_chk : "Y"
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
			if (result.isSuc=='success') {
				location.href="/basic/gift/listed";
			}
			
			
		}
	});
	
	
}


function all_grade(no){
	if ( $('#custs_all'+no).prop("checked")==true )  {
		$('.chk_cust_'+no).prop("checked",true);
	}else{
		$('.chk_cust_'+no).prop("checked",false);			
	}
	
}

function chk_target(target,idx){
	
	var arr = document.getElementsByClassName('chk_grade');
	var title ="";
	for (var i = 0; i < arr.length; i++) {
		if (arr[i].checked ==true)
		{
			title += arr[i].nextSibling.innerText+',';
						
		}
	}
	if (title=="") {
		title="등급을 선택해주세요.";
	}else{
		title = title.substr(0,title.length-1);
		title = CheckMaxString(title,17);		
	}
		
	$('.sub_target').text(title);
	
}



</script>
<div class="sub-tit">
	<h2>사은품 등록</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>

<div class="row view-page gift-wrap ledt-wrap">
	<div class="wid-5">
		<div class="top-row">
			<div class="wid-10">
				<div class="table table-auto gift-talbe-wr">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>			
				</div>
				<div class="dis-no"><jsp:include page="/WEB-INF/pages/common/peri2.jsp"/></div>
			</div>
		</div>
		<div class="white-bg ak-wrap_new">
			<h3 class="h3-tit">사은품지급설정</h3>
			<div class="bor-div">
				<div class="top-row table-input">
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit">사은품 종류</div>
							<div>
								<ul class="chk-ul">
									<li>
										<input type="radio" id="gift_fg_a" name="gift_fg" onchange="gift_change();" value="1" checked/>
										<label for="gift_fg_a">상품권</label>
									</li>
									<li>
										<input type="radio" id="gift_fg_b" name="gift_fg" onchange="gift_change();" value="2" />
										<label for="gift_fg_b">현물</label>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="wid-5">
						<div id="gift_price_area" class="table">
							<div class="sear-tit sear-tit_120">사은품 가격</div>
							<div>
								<input type="text" id="gift_price" name="gift_price" value=""  numberOnly>
							</div>
						</div>
					</div>
				</div>
				<div class="top-row table-input">
					<div class="wid-5">
						<div class="table gif-sel">
							<div class="sear-tit">사은품명</div>
							<div>
								<ul class="chk-ul">
									<li>
										<input type="checkbox" id="check_new" name="check_new" onclick="check_new();">
										<label for="check_new">신규</label>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="wid-5">
						<div id="new_gift_nm_area">
							<input type="text" id="new_gift_nm" name="new_gift_nm" placeholder="사은품 명을 입력해주세요.">
						</div>
						<div id="gift_code_area" class="sel-98 sel-full">
							<select id="gift_cd" name="gift_cd" de-data="전체" de-data="사은품을 선택해주세요." onchange="choose_code(this);">
			
							</select>
							
						</div>
					</div>
				</div>
			</div>
			
			<div class="bor-div">
				<div class="top-row give_con">
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit">지급조건1</div>
							<div>							
								<ul class="chk-ul">
									<li>
										<input type="checkbox" id="subject_fg_a" name="subject_fg_a">
										<label for="subject_fg_a">정규</label>
									</li>
									<li>
										<input type="checkbox" id="subject_fg_b" name="subject_fg_b">
										<label for="subject_fg_b">단기</label>
									</li>
									<li>
										<input type="checkbox" id="subject_fg_c" name="subject_fg_c">
										<label for="subject_fg_c">특강</label>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="top-row give_con">
					<div class="wid-10">
						<div class="table">
						
							<div class="sear-tit">지급조건2</div>
							<div class="wid-2 ">
								<select id="cust_fg" name="cust_fg" de-data="전체">
									<option value="">전체</option>
									<option value="1">신규</option>									
									<option value="2">기존</option>
								</select>
							</div>
							<div class="wid-inline widinp-75">
								<div class="sel-wid">
									<input type="text" id="lect_cnt" name="lect_cnt" value="0" class="" >
									<span class="sel-sp">강좌 이상</span>
								</div>
								
								<div class="sel-wid">
									<input type="text" id="semester_cnt" name="semester_cnt" value="0" class="" >
									<span class="sel-sp">학기 이상</span>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				<div class="top-row">
					<div class="wid-10">
						<div class="table vertical-top">
							<div class="sear-tit">지급대상</div>
							<div class="sel150">
								<ul class="chk-ul">
									<li>
										<input type="radio" id="cust_class" name="give_fg" value="G" onclick="choose_area();" checked/>
										<label for="cust_class">고객등급별</label>
									</li>
									<li id="cust_class_room" class="grade_area1 cust_class">
										<select de-data="전체" id="cust_level_package" onchange="class_change();">
											<option value="">전체</option>
											<option value="1">A-CLASS</option>
											<option value="2">우수가망</option>
											<option value="3">일반</option>
										</select>
									</li>
								</ul>
								
								<div class="select-box select-box-no chk-select" cust_numb="1" style="display: none;">
									<div class="selectedOption sub_target">전체</div>
									<ul class="select-ul cust_slec">
										<li ><input type="checkbox" id="custs_all1" class="chk_grade" name="chkall1" onclick="all_grade(1); chk_target();" /><label for="custs_all1">A-CLASS 전체</label></li>
										<li ><input type="checkbox" id="custs_01" name="chk_cust" class="chk_cust_1 chk_grade" onclick="chk_target();" value="109"/><label for="custs_01">E-Diamond</label></li>
										<li ><input type="checkbox" id="custs_02" name="chk_cust" class="chk_cust_1 chk_grade" onclick="chk_target();" value="110"/><label for="custs_02">Diamond</label></li>
										<li ><input type="checkbox" id="custs_03" name="chk_cust" class="chk_cust_1 chk_grade" onclick="chk_target();" value="120"/><label for="custs_03">Platinum</label></li>
										<li ><input type="checkbox" id="custs_04" name="chk_cust" class="chk_cust_1 chk_grade" onclick="chk_target();" value="111"/><label for="custs_04">Platinum+</label></li>
										<li ><input type="checkbox" id="custs_05" name="chk_cust" class="chk_cust_1 chk_grade" onclick="chk_target();" value="112"/><label for="custs_05">Crystal</label></li>
										<li ><input type="checkbox" id="custs_06" name="chk_cust" class="chk_cust_1 chk_grade" onclick="chk_target();" value="114" /><label for="custs_06">Gold</label></li>
										<li ><input type="checkbox" id="custs_07" name="chk_cust" class="chk_cust_1 chk_grade" onclick="chk_target();" value="115" /><label for="custs_07">Silver</label></li>
									</ul>
								</div>
								
								<div class="select-box select-box-no chk-select" cust_numb="2" style="display: none;">
									<div class="selectedOption sub_target">전체</div>
									<ul class="select-ul cust_slec">
										<ul class="select-ul cust_level_ul" style="display: block; overflow: hidden;"><li>전체</li><li>Bronze</li><li>Ace</li></ul>
										<li ><input type="checkbox" id="custs_all2" name="chkall2" class="chk_grade" onclick="all_grade(2); chk_target();" /><label for="custs_all2">우수가망 전체</label></li>
										<li ><input type="checkbox" id="custs_08" name="chk_cust" class="chk_cust_2 chk_grade" value="116" onclick="chk_target();" /><label for="custs_08">Bronze</label></li>
										<li ><input type="checkbox" id="custs_09" name="chk_cust" class="chk_cust_2 chk_grade" value="117" onclick="chk_target();" /><label for="custs_09">Ace</label></li>
									</ul>
								</div>
								
								<div class="select-box select-box-no chk-select" cust_numb="3" style="display: none;">
									<div class="selectedOption sub_target">전체</div>
									<ul class="select-ul cust_slec">
										<li ><input type="checkbox" id="custs_all3" name="chkall3" class="chk_grade" onclick="all_grade(3); chk_target();" /><label for="custs_all3">일반 전체</label></li>
										<li ><input type="checkbox" id="custs_10" name="chk_cust" class="chk_cust_3 chk_grade" value="118" onclick="chk_target();" /><label for="custs_10">Friends</label></li>
										<li ><input type="checkbox" id="custs_11" name="chk_cust" class="chk_cust_3 chk_grade" value="119" onclick="chk_target();" /><label for="custs_11">Entry</label></li>
									</ul>
								</div>
								
								<ul class="chk-ul chk-ul02 disc-ul02">
									<li>
										<input type="radio" id="cust_target" name="give_fg" value="T" onclick="choose_area();">
										<label class="chk-red" for="cust_target" ><a id="target_area" href="javascript:addCode()">대상자 지정</a></label>
									</li>
									
								</ul>
								
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="bor-div">
				<div class="top-row">
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit">지급방식</div>
							<div>
								<ul class="chk-ul">
									<li>
										<input type="radio" id="give_type_auto" name="give_type" value="1" checked/>
										<label for="give_type_auto">자동선착순</label>
									</li>
									<li>
										<input type="radio" id="give_type_random" name="give_type" value="2"/>
										<label for="give_type_random">무작위</label>
									</li>
								</ul>
								
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	<div class="wid-5">
		<div class="white-bg bg-pad ak-wrap_new">
		
			<div class="bor-div">
				<div class="top-row">
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit sear-tit03">사은품 지급기간 <br>설정여부</div>
							<div>
								<ul class="chk-ul">
									<li>
										<input type="radio" id="gift_date_y" name="gift_date_yn" value="Y"  onclick="choose_area();" checked/>
										<label for="gift_date_y">Y</label>
									</li>
									<li>
										<input type="radio" id="gift_date_n" name="gift_date_yn" value="N" onclick="choose_area();"/>
										<label for="gift_date_n">N</label>
									</li>
								</ul>
							</div>
						</div>
					</div>
						<div id="dis_period_area" class="">
							<div class="table">
								<div class="sear-tit sear-tit03">지급기간 설정</div>
								<div>
									<div class="cal-row">
										<div class="cal-input cal-input180">
											<input type="text" id="start_ymd" name="start_ymd" class="date-i" placeholder />
											<i class="material-icons">event_available</i>
										</div>
										<div class="cal-dash">-</div>
										<div class="cal-input cal-input180">
											<input type="text" id="end_ymd" name="end_ymd" class="date-i" placeholder />
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
						<div class="table vertical-top">
							<div class="sear-tit sear-tit03">사은품 수량</div>
							
							<div class="wid-in">
								<div class="sear-smtit">접수수단별 구분</div>
								<div>
									<ul class="chk-ul">
										<li>
											<input type="radio" id="accept_type_y" value="Y" onclick="choose_area();" name="accept_type" checked/>
											<label for="accept_type_y">Y</label>
										</li>
										<li>
											<input type="radio" id="accept_type_n" value="N" onclick="choose_area();" name="accept_type"/>
											<label for="accept_type_n">N</label>
										</li>
									</ul>
									
								</div>
							</div>
							
							<div class="wid-in">
								<div class="sear-smtit">총 수량</div>
								<div>
									<input type="text" id="gift_cnt_t" name="gift_cnt_t" value="" class="inputDisabled" disabled="disabled">
								</div>
							</div>
							<div class="wid-in">
								<div class="sear-smtit">남은 수량</div>
								<div>
									<input type="text" id="gift_cnt_left" name="gift_cnt_left" value="" class="inputDisabled" disabled="disabled">
								</div>
							</div>
							
							<div class="wid-in">
								<div class="sear-smtit">
									<!-- <input type="checkbox" id="gift_cnt_w_chk" name="gift_cnt_w_chk"/> -->
								<label class="accept_type_y"  for="gift_cnt_w_chk">WEB</label>
								</div>
								<div>									
									<input type="text" id="gift_cnt_w" class="accept_type_y accept_cnt" name="gift_cnt_w" value=""  placeholder="수량을 입력해주세요.">
								</div>
							</div>
							<div class="wid-in" >
								<div class="sear-smtit">
									<!-- <input type="checkbox" id="gift_cnt_m_chk" name="gift_cnt_m_chk"/> -->
								<label class="accept_type_y"  for="gift_cnt_m_chk">MOBILE</label>
								</div>
								<div>									
									<input type="text" id="gift_cnt_m" class="accept_type_y accept_cnt" name="gift_cnt_m" value=""  placeholder="수량을 입력해주세요.">
								</div>
							</div>
							<div class="wid-in">
								<div class="sear-smtit">
									<!-- <input type="checkbox" id="gift_cnt_d_chk" name="gift_cnt_d_chk"/> -->
								<label class="accept_type_y"  for="gift_cnt_d_chk">DESK</label>
								</div>
								<div>									
									<input type="text" id="gift_cnt_d" class="accept_type_y accept_cnt" name="gift_cnt_d" value=""  placeholder="수량을 입력해주세요.">
								</div>
							</div>
							<div class="wid-in">
								<div class="sear-smtit">취소시 반납 여부</div>
								<div>
									<ul class="chk-ul">
										<li>
											<input type="radio" id="return_fg_y" name="return_fg" value="Y" checked/>
											<label for="return_fg_y">Y</label>
										</li>
										<li>
											<input type="radio" id="return_fg_n" name="return_fg" value="N"/>
											<label for="return_fg_n">N</label>
										</li>
									</ul>
									
								</div>
							</div>
						</div>
					</div>
				</div>				
			</div>
			
			<div class="bor-div">
			
			
				<div class="top-row table-input">
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit">등록일시</div>
							<div>
								<input type="text" id="create_date" name="create_date" value="" class="inputDisabled" placeholder="미등록" disabled="disabled">
							</div>
						</div>
					</div>
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit sear-tit_120 sear-tit_left">등록자</div>
							<div>
								<input type="text" id="create_regi_no" name="create_regi_no" value="" class="inputDisabled" placeholder="미등록" disabled="disabled">
							</div>
						</div>
					</div>
				</div>
				
				<div class="top-row table-input">
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit">수정일시</div>
							<div>
								<input type="text" id="update_date" name="update_date" value="" class="inputDisabled" placeholder="미수정" disabled="disabled">
							</div>
						</div>
					</div>
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit sear-tit_120 sear-tit_left">수정자</div>
							<div>
								<input type="text" id="update_regi_no" name="update_regi_no" value="" class="inputDisabled" placeholder="미수정" disabled="disabled">
							</div>
						</div>
					</div>
				</div>
						
			</div>
	
		</div>	
	</div>
	
	

</div>
<div class="btn-wr text-center">
<script>
function gift_reset(){
	$('#code_fg_a').prop('checked',true);
	gift_change();
	gift_cd='';
	$('#gift_price').val('');
	$('#subject_fg_a').prop('checked',false);
	$('#subject_fg_b').prop('checked',false);
	$('#subject_fg_c').prop('checked',false);
	
	$('#cust_fg').val('');
	$('.cust_fg').text('전체');
	$('#lect_cnt').val(0);
	$('#semester_cnt').val(0);
	
	$('#cust_class').prop('checked',true);
	custList='';
	
	$('#give_type_auto').prop('checked',true);
	
	$('#start_ymd').val('');
	$('#end_ymd').val('');
	
	$('#accept_type_y').prop('checked',true);
	$('#gift_cnt_w').val('');
	$('#gift_cnt_m').val('');
	$('#gift_cnt_d').val('');	
	$('#gift_cnt_t').val('');	
	$('#gift_cnt_left').val('');
	choose_area();
	
	$('#create_date').val('');
	$('#create_regi_no').val('');
	$('#update_date').val('');
	$('#update_regi_no').val('');
	
	$('#return_fg_y').prop('checked',true);
}
</script>
	<a class="btn btn01 ok-btn" href="javascript:gift_reset();">초기화</a>
	<a class="btn btn02 ok-btn" href="javascript:fncSubmit();">저장</a>
</div>

<div id="give_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg gift-edit edit-scroll">
        		<div class="close" onclick="javascript:$('#give_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		
	        	<jsp:include page="/WEB-INF/pages/common/getCustList.jsp"/>
	        	
        	</div>
        </div>
    </div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>