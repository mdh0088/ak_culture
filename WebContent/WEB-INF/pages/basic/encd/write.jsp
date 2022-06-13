
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>

var enuri_cd="${enuri_cd}";
var custList="";
var isChk=${isChk}; //기수 바뀔때 초기화를 위한 세팅

function periInit()
{
	if (isChk===false) 
	{
		encd_reset();
		enuri_cd='';
	}
	store_change();
}

$( document ).ready(function() 
{
	$('#new_encd_nm_area').hide();
	$('.grade_area2').hide();
	$('#selBranch').attr('onchange','fncPeri();');
	$('#selPeri').attr('onchange','fncPeri2();');
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
});

window.onload = function()
{
	if (enuri_cd!="") //listed페이지에서 넘어올시 세팅
	{
		$("#selBranch").val('${store}');
		$("#selYear").val('${enuri_year}');
		$(".selYear").html('${enuri_year}');
		fncPeri();	
		$("#selSeason").val('${season_nm}');
		$(".selSeason").html('${season_nm} / ${period}');
		$("#selPeri").val('${period}');
		store_change();
		enuri_cd = '${enuri_cd}';
		choose_code();
		$('.enuri_cd').html('${enuri_nm}');	
	}
}

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

function check_new()
{
	if ($('#check_new').prop("checked")) 
	{
		$('.enuri_cd_area').hide();
		$('#new_encd_nm_area').show();
		$('#dis_period_start').val('');
		$('#dis_period_end').val('');
		
		$('#encd_rate').val('');
		$('#encd_limit_pay').val('');
		$('#encd_amount').val('');
		$('#encd_limit_cnt').val('');
	}
	else
	{
		store_change();
		$('#new_encd_nm_area').hide();
		$('.enuri_cd_area').show();		
	}
	enuri_cd="";
}


function choose_area()
{
	if ( $('#encd_fg_rate').prop("checked")) 
	{
		$('#encd_rate').removeAttr('readonly');
		$('#encd_amount').val('');
		$('#encd_amount').attr('readonly','readonly');
		$('.dis_limit_pay_area').show();
	}
	else
	{
		$('#encd_amount').removeAttr('readonly');
		$('#encd_rate').val('');
		$('#encd_rate').attr('readonly','readonly');
		$('#encd_rate').val('');
		$('#dis_limit_pay').val('');
		$('.dis_limit_pay_area').hide();
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


function store_change()
{
	
	$('#enuri_cd').val('');
	$('.enuri_cd').text('할인코드를 선택해주세요.');
	
		$.ajax({
			type : "POST", 
			url : "./getEncdCode",
			dataType : "text",
			data : 
			{
				store : $("#selBranch").val(),
				period : $('#selPeri').val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				
				$('#enuri_cd').empty();
				$('.enuri_cd_ul').empty();
				var inner="";
				var inner_li="";
				
				if (result.length!=0) {
					for (var i = 0; i < result.length; i++) {
						inner +='<option value="'+result[i].ENURI_CD+'">'+result[i].ENURI_NM+'</option>';
						inner_li += '<li>'+result[i].ENURI_NM+'</li>';
					}
				}else{
					inner +='<option>선택할 할인코드가 없습니다.</option>';
					inner_li += '<li>선택할 할인코드가 없습니다.</li>';
				}
				$('#enuri_cd').html(inner);
				$('.enuri_cd_ul').html(inner_li);
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
	
	if (class_value=='1') {
		$('.cust_level').text('전체');
		$(".chk-select").hide();
		$(".chk-select[cust_numb='1']").show();
	}else if(class_value=='2'){
		$('.cust_level').text('전체');
		$(".chk-select").hide();
		$(".chk-select[cust_numb='2']").show();
	}else if(class_value=='3'){
		$('.cust_level').text('전체');
		$(".chk-select").hide();
		$(".chk-select[cust_numb='3']").show();
	}else if(class_value=='4'){
		$('.cust_level').text('전체');
		$(".chk-select").hide();
		$(".chk-select[cust_numb='4']").show();
	}else{
		$(".chk-select").hide();
	}
}

/*
function choose_class(val)
{
	var choose_val_list = "";
	if ($(val).val() !="" && $(val).val()!=null) //값을 선택시
	{ 
		choose_val = $(val).val();
	}
	else //전체 선택시
	{ 
		$('.level_value').each(function()
		{ 
			choose_val = $(this).val();
			choose_val_list =choose_val_list+choose_val +',';
		})
		choose_val = choose_val_list;
		choose_val = choose_val.slice(0,-1);	
	}
}
*/
function choose_code(idx)
{

	if (nullChk(idx)!="") 
	{
		enuri_cd = $(idx).val();		
	}
	
	if (enuri_cd>0) 
	{
		$.ajax({
			type : "POST", 
			url : "./getEncdInfo",
			dataType : "text",
			data : 
			{
				store : $('#selBranch').val(),//store
				period : $('#selPeri').val(),
				enuri_cd : enuri_cd//할인코드
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
					if (nullChk(result[0].LECT_SUBJECT_FG)!="") 
					{
						$("input:radio[name='lect_type']:radio[value='"+result[0].LECT_SUBJECT_FG+"']").prop('checked', true);
					}
					
					if (nullChk(result[0].MAIN_CD)!="") 
					{
						$('.lect_main_cd').text($("select[name='lect_main_cd'] option[value='"+result[0].MAIN_CD+"']").text());
						$("select[name='lect_main_cd'] option[value='"+result[0].MAIN_CD+"']").attr("selected", "selected");
						selMaincd("","lect");
						
					}
									
					if (nullChk(result[0].SECT_CD)!="") 
					{
						
						$('.lect_sect_cd').text($("select[name='lect_sect_cd'] option[value='"+result[0].SECT_CD+"']").text());
						$("select[name='lect_sect_cd'] option[value='"+result[0].SECT_CD+"']").attr("selected", "selected");
					}
					
					if (nullChk(result[0].SUBJECT_CD)!="") 
					{
						document.getElementsByName("lect_subject_cd")[0].value=result[0].SUBJECT_CD;		
					}
					
					if (nullChk(result[0].DISCOUNT_PERIOD_START)!="") 
					{
						document.getElementsByName("dis_period_start")[0].value=result[0].DISCOUNT_PERIOD_START;	
					}
					
					if (nullChk(result[0].DISCOUNT_PERIOD_END)!="") 
					{
						document.getElementsByName("dis_period_end")[0].value=result[0].DISCOUNT_PERIOD_END;	
					}
					
					if (nullChk(result[0].ENURI_FG)!="") 
					{
						$("input:radio[name='encd_fg']:radio[value='"+result[0].ENURI_FG+"']").prop('checked', true);
						choose_area();
						
						if (result[0].ENURI_FG==1) 
						{
							document.getElementsByName("encd_rate")[0].value=result[0].ENURI;	
						}
						else
						{
							document.getElementsByName("encd_amount")[0].value=result[0].ENURI;	
						}
					}
					
					if (nullChk(result[0].LIMITED_AMT)!="") 
					{
						document.getElementsByName("encd_limit_pay")[0].value=result[0].LIMITED_AMT;	
					}
					if (nullChk(result[0].LIMITED_CNT)!="") 
					{
						document.getElementsByName("encd_limit_cnt")[0].value=result[0].LIMITED_CNT;	
					}
					
					if (nullChk(result[0].LECTOR_FEE_YN)!="") 
					{
						$("input:radio[name='fee_yn']:radio[value='"+result[0].LECTOR_FEE_YN+"']").prop('checked', true);
					}
					if (nullChk(result[0].DUPL_YN)!="") 
					{
						$("input:radio[name='dupl_yn']:radio[value='"+result[0].DUPL_YN+"']").prop('checked', true);
					}
					
					
					
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
					
					if (nullChk(result[0].SEMESTER_CNT)!="") {
						$('#semester_cnt').val(result[0].SEMESTER_CNT);
					}else{
						$('#semester_cnt').val(0);
					}
				
					if (nullChk(result[0].GRADE)!="") {
						var arr=result[0].GRADE.split(',');
						for (var i = 0; i < arr.length; i++) {
							$("input[name=chk_cust][value="+arr[i]+"]").prop("checked",true);
						}
						
					}else
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

function fncSubmitEncd()
{
	var choose_val="";
	var chk_new = "";
	//var enuri_cd ="";
	var new_encd_nm ="";
	if (document.getElementsByName("check_new")[0].checked==true) 
	{
		chk_new = "on";
		new_encd_nm =document.getElementsByName("new_encd_nm")[0].value;
		if (trim(new_encd_nm)=="")
		{
			alert('신규 할인 명을 입력하세요.');
			document.getElementsByName("new_encd_nm")[0].focus();
			document.getElementsByName("new_encd_nm")[0].value="";
			return;
		}
		
		
	}
	else
	{
		chk_new = "off";
		//enuri_cd = document.getElementsByName("enuri_cd")[0].value;
	}
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
	
	if (give_fg=="G") 
	{ //지급대상이 고객등급별이면
		if (document.getElementsByName("subject_fg_a")[0].checked==true) 
		{
			con1_subject_fg_a="1";
		}
		if (document.getElementsByName("subject_fg_b")[0].checked==true) 
		{
			con1_subject_fg_b="2";
		}
		if (document.getElementsByName("subject_fg_c")[0].checked==true) 
		{
			con1_subject_fg_c="3";
		}

	 	cust_fg = document.getElementsByName("cust_fg")[0].value;
	 	lect_cnt = document.getElementsByName("lect_cnt")[0].value;
	 	semester_cnt = document.getElementsByName("semester_cnt")[0].value;
	}
	
	var lect_type = document.querySelector('input[name="lect_type"]:checked').value;
	var lect_main_cd = document.getElementsByName("lect_main_cd")[0].value;
	var lect_sect_cd = document.getElementsByName("lect_sect_cd")[0].value;
	var lect_subject_cd = document.getElementsByName("lect_subject_cd")[0].value;
	
	var dis_period_start =document.getElementsByName("dis_period_start")[0].value;
	var dis_period_end =document.getElementsByName("dis_period_end")[0].value;
	
	var encd_fg = document.querySelector('input[name="encd_fg"]:checked').value;
	var enuri = "";
	var encd_limit_pay ="";
	var encd_limit_cnt = document.getElementsByName("encd_limit_cnt")[0].value;
	if (encd_fg==1) 
	{
		enuri = document.getElementsByName("encd_rate")[0].value;
		encd_limit_pay = document.getElementsByName("encd_limit_pay")[0].value; 
	}
	else
	{
		enuri = document.getElementsByName("encd_amount")[0].value;		
	}
	
	var fee_yn =document.querySelector('input[name="fee_yn"]:checked').value;
	var dupl_yn =document.querySelector('input[name="dupl_yn"]:checked').value;
	
	
	if (chk_new=="off" && enuri_cd=="") 
	{
		alert("할인코드를 선택하거나 신규 할인코드를 등록해주세요.");
		return;
	}
	
    var start_ymd_arr = dis_period_start.split('-');
    var end_ymd_arr = dis_period_end.split('-');
    var start_date = new Date(start_ymd_arr[0], start_ymd_arr[1], start_ymd_arr[2] ,11 ,59 );
    var end_date = new Date(end_ymd_arr[0], end_ymd_arr[1], end_ymd_arr[2] ,11 ,59 );
   
    if (dis_period_start=="" && dis_period_end=="") 
    {
		alert("할인 기간을 설정해주세요.");
		return;
	}
    
    if(end_date < start_date)
    {
       alert("할인기간을 다시 설정해 주세요.");
       return;
    }
    
    if (enuri=="")
    {
		alert("정액/정률을 설정해주세요.");
		return;
	}
    
    if (encd_fg==1 && encd_limit_pay=="") 
    {
		alert("제한금액을 설정해주세요.");
		return;
	}
    
    
    if (encd_limit_cnt=="") 
    {
		alert("제한횟수를 설정해주세요.");
		return;
	}
    
    if (encd_limit_cnt=="0") 
    {
		alert("1회 이상 설정해주세요.");
		return;
	}
    
    
    $('.waitForLoad').show();
 
    getListStart();
	$.ajax({
		type : "POST", 
		url : "./write_proc",
		dataType : "text",
		data : 
		{
			store : $('#selBranch').val(),//store
			period : $('#selPeri').val(),//period
			
			chk_new : chk_new,
			enuri_cd : enuri_cd,
			new_encd_nm : new_encd_nm,
			give_fg : give_fg,
			custList : custList,
			choose_val : choose_val,
			con1_subject_fg_a : con1_subject_fg_a,
			con1_subject_fg_b : con1_subject_fg_b,
			con1_subject_fg_c : con1_subject_fg_c,
			cust_fg : cust_fg,
			lect_cnt : lect_cnt,
			semester_cnt : semester_cnt, //강좌수
			lect_type : lect_type, 
			lect_main_cd : lect_main_cd,
			lect_sect_cd : lect_sect_cd,
			lect_subject_cd : lect_subject_cd,
			dis_period_start : dis_period_start,
			dis_period_end : dis_period_end,
			encd_fg : encd_fg,
			enuri : enuri,
			encd_limit_pay : encd_limit_pay,
			encd_limit_cnt : encd_limit_cnt,
			fee_yn : fee_yn,
			dupl_yn : dupl_yn,
			auth_chk : "Y"
		},
		error : function() 
		{
			console.log("AJAX ERROR");
			getListEnd();
			$('.waitForLoad').hide();
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			alert(result.msg);	
			if (result.isSuc=='success') {
				location.href="/basic/encd/listed";
			}
			getListEnd();
			$('.waitForLoad').hide();
		}
	});
	    
}


function encd_reset()
{
	$('#lect_type').prop('checked',true);
	store_change();
	enuri_cd='';
	
	$('#subject_fg_a').prop('checked',false);
	$('#subject_fg_b').prop('checked',false);
	$('#subject_fg_c').prop('checked',false);
	
	$('#cust_fg').val('');
	$('.cust_fg').text('전체');
	$('#lect_cnt').val(0);
	$('#semester_cnt').val(0);
	
	$('#lect_type_e').prop('checked',true);
	$('#lect_type_f').prop('checked',false);
	$('#lect_type_g').prop('checked',false);
	$('#lect_type_h').prop('checked',false);
	//alert( $('#lect_main_cd').val() );
	selMaincd('','lect');
	//alert( $('#lect_main_cd').val() );	
	$('#lect_main_cd').val('');
	$('.lect_main_cd').text('전체');
	$('#lect_subject_cd').val('');
	$('#cust_class').prop('checked',true);
	custList='';
	
	
	$('#dis_period_start').val('');
	$('#dis_period_end').val('');
	
	$('#encd_rate').val('');
	$('#encd_limit_pay').val('');
	$('#encd_amount').val('');	
	$('#encd_limit_cnt').val('');	
	choose_area();
	
	$('#create_date').val('');
	$('#create_regi_no').val('');
	$('#update_date').val('');
	$('#update_regi_no').val('');
	
	$('#return_fg_y').prop('checked',true);
}

function all_grade(no){
	if ( $('#custs_all'+no).prop("checked")==true )  
	{
		$('.chk_cust_'+no).prop("checked",true);
	}
	else
	{
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

function getPrevEncd(){

	getListStart();
	$.ajax({
		type : "POST", 
		url : "./getBfEncdList",
		dataType : "text",
		data : 
		{
			store : $('#selBranch').val(),//store
			period : $('#selPeri').val()//period
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
				location.reload();
			}
			getListEnd();
		}
	});
	
}


</script>

<div class="sub-tit">
	<h2>할인코드</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>

<div class="row view-page gift-wrap ledt-wrap">
	<div class="wid-5">
		<div class="top-row">
			<div class="wid-10">
				<div class="table table-auto ">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>			
			
					<div class="sel-o">
						<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
					</div>
					<div>
						<input type="button" value="전 기수 할인권 불러오기" onclick="getPrevEncd();">
					</div>
					
				</div>
			</div>
		</div>
		<div class="white-bg ak-wrap_new">
			<h3 class="h3-tit">할인코드등록</h3>
			<div class="bor-div">
				<div class="top-row table-input sel-scr">
					<div class="wid-10">
						<div class="table table-auto">
							<div class="sear-tit">할인코드명</div>
							<div class="wid-3">
								<ul class="chk-ul">
									<li>
										<input type="checkbox" id="check_new" name="check_new" value="on" onclick="check_new();">
										<label for="check_new">신규</label>
									</li>
								</ul>
							</div>
							<div>
								<div id="new_encd_nm_area">
									<input type="text" id="new_encd_nm" name="new_encd_nm" placeholder="할인코드 명을 입력해주세요.">
								</div>
								<div class="sel-98 enuri_cd_area sel-full">
									<select id="enuri_cd" name="enuri_cd" class="" de-data="할인코드를 선택해주세요." onchange="choose_code(this);">
									
									</select>			
								</div>
							</div>
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
							<div class="wid-2">
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
							
								<ul class="chk-ul disc-ul01">
									<li>
										<input type="radio" id="cust_class" name="give_fg" value="G" onclick="choose_area();" checked/>
										<label for="cust_class">고객등급별</label>
									</li>
									<li id="cust_class_room" class="grade_area1 cust_class">
										<select de-data="전체" id="cust_level_package" onchange="class_change();">
											<option>전체</option>
											<option value="1">A-CLASS</option>
											<option value="2">우수가망</option>
											<option value="3">일반</option>
											<option value="4">임직원</option>
										</select>
									</li>
									
									<!-- 
									<li class='grade_area2 cust_class'>
										<select id="cust_level" de-data="전체" onchange="choose_class(this);">

										</select>
									</li>
									 -->
								</ul>
								
								<div class="select-box select-box-no chk-select" cust_numb="1" style="display: none;">
									<div class="selectedOption sub_target">전체</div>
									<ul class="select-ul cust_slec">
										<li ><input type="checkbox" id="custs_all1" class="chk_grade" name="chkall1" onclick="all_grade(1); chk_target();"/><label for="custs_all1">전체</label></li>
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
										<li ><input type="checkbox" id="custs_all2" class="chk_grade" name="chkall2" onclick="all_grade(2); chk_target();"/><label for="custs_all2">전체</label></li>
										<li ><input type="checkbox" id="custs_08" name="chk_cust" class="chk_cust_2 chk_grade" value="116" onclick="chk_target();"/><label for="custs_08">Bronze</label></li>
										<li ><input type="checkbox" id="custs_09" name="chk_cust" class="chk_cust_2 chk_grade" value="117" onclick="chk_target();"/><label for="custs_09">Ace</label></li>
									</ul>
								</div>
								
								<div class="select-box select-box-no chk-select" cust_numb="3" style="display: none;">
									<div class="selectedOption sub_target">전체</div>
									<ul class="select-ul cust_slec">
										<li ><input type="checkbox" id="custs_all3" class="chk_grade" name="chkall3" onclick="all_grade(3); chk_target();"/><label for="custs_all3">전체</label></li>
										<li ><input type="checkbox" id="custs_10" name="chk_cust" class="chk_cust_3 chk_grade" value="118" onclick="chk_target();"/><label for="custs_10">Friends</label></li>
										<li ><input type="checkbox" id="custs_11" name="chk_cust" class="chk_cust_3 chk_grade" value="119" onclick="chk_target();"/><label for="custs_11">Entry</label></li>
									</ul>
								</div>
								
								<div class="select-box select-box-no chk-select" cust_numb="4" style="display: none;">
									<div class="selectedOption sub_target">전체</div>
									<ul class="select-ul cust_slec">
										<li ><input type="checkbox" id="custs_all4" class="chk_grade" name="chkall4" onclick="all_grade(4); chk_target();"/><label for="custs_all4">전체</label></li>
										<li ><input type="checkbox" id="custs_12" name="chk_cust" class="chk_cust_4 chk_grade" value="1100" onclick="chk_target();"/><label for="custs_12">AK PLAZA/MALL 퇴직 임직원</label></li>
										<li ><input type="checkbox" id="custs_13" name="chk_cust" class="chk_cust_4 chk_grade" value="1101" onclick="chk_target();"/><label for="custs_13">AK PLAZA/MALL 재직 임직원</label></li>
										<li ><input type="checkbox" id="custs_14" name="chk_cust" class="chk_cust_4 chk_grade" value="1301" onclick="chk_target();"/><label for="custs_14">애경 유통그룹외 임직원(임직원)</label></li>
									</ul>
								</div>
								
								
								
								
								
								<ul class="chk-ul chk-ul02 disc-ul02">
									<li>
										<input type="radio" id="cust_target" name="give_fg" value="T" onclick="choose_area();">
										<label class="chk-red" for="cust_target" ><a id="target_area" onclick="javascript:addCode()">대상자 지정</a></label>
									</li>
								</ul>
								
								
								
								
								
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="bor-div" >
			
				<h3 class="h3-tit">적용강좌</h3> <br>
				<div class="top-row">
					<div class="wid-10">
						<div class="table">
							<div>								
								<ul class="chk-ul">
								<!-- 
									<li>
										<input type="checkbox" id="check_search" name="check_search" value="on" onclick="check_search();">
										<label for="check_search">입력</label>
									</li>
								 -->
									<li>
										<input type="radio" id="lect_type_e" value="" name="lect_type" checked/>
										<label for="lect_type_e">전체</label>
									</li>
									<li>
										<input type="radio" id="lect_type_f" value="1" name="lect_type">
										<label for="lect_type_f">정규</label>
									</li>
									<li>
										<input type="radio" id="lect_type_g" value="2" name="lect_type">
										<label for="lect_type_g">단기</label>
									</li>
									<li>
										<input type="radio" id="lect_type_h" value="3" name="lect_type">
										<label for="lect_type_h">특강</label>
									</li>
									
								</ul>
							</div>
						</div>
					</div>
					
				</div>
				
				<div class="top-row">
					<div class="wid-10">
						<div class="table">
							<div>
								<div class="table table02 table-input ">
									<div class="wid-2">
										<select de-data="대분류" id="lect_main_cd" name="lect_main_cd" data-name="대분류" class="notEmpty" onchange="selMaincd(this,'lect')">
												<option value="">전체</option>
											<c:forEach var="j" items="${maincdList}" varStatus="loop">
												<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
											</c:forEach>
										</select>
									</div>	
									<div class="sel-scr wid-2">
										<select de-data="중분류" id="lect_sect_cd" name="lect_sect_cd" data-name="중분류" class="notEmpty">
	
										</select>
									</div>
									
									<div class="wid-35 gift-code gift-code02">
										<div class="sear-tit sear-tit_left">강좌코드</div>
										<div>
											<input type="text" id="lect_subject_cd" name="lect_subject_cd" value="" >
										</div>
										<!-- 
										<div class="sel-98 lect_search_area sel-full">
											<select id="search_val" name="search_val" class="" de-data="강좌를 선택해주세요." onchange="choose_lect(this);">
											
											</select>			
										</div>
										 -->
									</div>
									
									
									
									
								</div>
							</div>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
	<div class="wid-5">
		<div class="white-bg bg-pad">
			<div id="dis_period_yn_area" class="bor-div" style="border-top:0;">
				<div class="top-row">
					<div id="dis_period_area" class="">
						<div class="table">
							<div class="sear-tit sear-tit03">할인기간 설정</div>
							<div>
								<div class="cal-row">
									<div class="cal-input cal-input180">
										<input type="text" id="dis_period_start" name="dis_period_start"  class="date-i" readonly="readonly" placeholder />
										<i class="material-icons">event_available</i>
									</div>
									<div class="cal-dash">-</div>
									<div class="cal-input cal-input180">
										<input type="text" id="dis_period_end" name="dis_period_end" class="date-i" readonly="readonly" placeholder />
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
							<div class="sear-tit sear-tit03">할인구분</div>
							<div class="wid-in wid-in_encd">
								<div class="sear-smtit">
									<input type="radio" id="encd_fg_rate" name="encd_fg" value="1" onclick="choose_area();" checked/>
									<label for="encd_fg_rate">정률</label>
								</div>
								<input type="text" id="encd_rate" name="encd_rate" value="" placeholder=""> <span class="txt">%</span>
							</div>
							<div class="wid-in wid-in_encd">
								<div class="sear-smtit sear-smtit02 dis_limit_pay_area">
									제한금액
								</div>
								<input type="text" id="encd_limit_pay" class="dis_limit_pay_area comma" name="encd_limit_pay" value="" placeholder=""> <span class="txt dis_limit_pay_area">원 이하</span>
							</div>
							<div class="wid-in wid-in_encd">
								<div class="sear-smtit">
									<input type="radio" id="encd_fg_amount" name="encd_fg" value="2" onclick="choose_area();" readonly="readonly">
									<label for="encd_fg_amount">정액</label>
								</div>
								<input type="text" id="encd_amount" name="encd_amount" value="" class="comma" placeholder=""> <span class="txt">원</span>
							</div>
						</div>
					</div>
				</div>			
				<div class="top-row">
					<div class="wid-10">
						<div class="table">
							<div class="sear-tit sear-tit03">
								제한횟수
							</div>
							<input type="text" id="encd_limit_cnt" name="encd_limit_cnt" value="" placeholder=""> <span class="txt"> 회 이하</span>
						</div>
					</div>
				</div>	
			</div>
			
			<div class="bor-div">
				<div class="top-row">
					<div class="table">
						<div class="sear-tit sear-tit03">강사료 보존여부</div>
						<div>
							<ul class="chk-ul">
								<li>
									<input type="radio" id="fee_y" name="fee_yn" value="Y" checked/>
									<label for="fee_y">Y</label>
								</li>
								<li>
									<input type="radio" id="fee_n" name="fee_yn" value="N" />
									<label for="fee_n">N</label>
								</li>
							</ul>
							
						</div>
					</div>
				</div>	
				<div class="top-row">
					<div class="table">
						<div class="sear-tit sear-tit03">중복할인 가능여부</div>
						<div>
							<ul class="chk-ul">
								<li>
									<input type="radio" id="dupl_y" name="dupl_yn" value="Y" checked/>
									<label for="dupl_y">Y</label>
								</li>
								<li>
									<input type="radio" id="dupl_n" name="dupl_yn" value="N"  />
									<label for="dupl_n">N</label>
								</li>
							</ul>
							
						</div>
					</div>
				</div>		
	
			</div>
			
			<div class="bor-div">
				<div class="top-row">
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
							<div class="sear-tit sear-tit_left">등록자</div>
							<div>
								<input type="text" id="create_regi_no" name="create_regi_no" value="" class="inputDisabled" placeholder="미등록" disabled="disabled">
							</div>
						</div>
					</div>
				</div>		
				<div class="top-row">
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
							<div class="sear-tit sear-tit_left">수정자</div>
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
	<a class="btn btn01 ok-btn" href="javascript:encd_reset();">초기화</a>
	<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitEncd();">저장</a>
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