<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>

<script>
var main_cd ="";
function selMaincd(idx){	
// 	var x = document.getElementById("selPeri").selectedIndex;
// 	var y = document.getElementById("selPeri").options;
// 	var z = document.getElementById("selPeri").options[y[x].index];

	main_cd = $(idx).val();
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
	}else{
		$('.withBaby').hide();
	}
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		data : 
		{
			maincd : main_cd,
// 			selBranch : z.getAttribute("store")
			selBranch : $("#target_selBranch").val()
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
			var inner_li="";
			$("#sect_cd").empty();
			$(".sect_cd_ul").empty();
			if(result.length > 0)
			{
				inner="";
				for (var i = 0; i < result.length; i++) {
					inner+='<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>';
					inner_li+='<li>'+result[i].SECT_NM+'</li>';
				}
				$("#sect_cd").append(inner);
				
				$("#sect_cd").val("");
				$(".sect_cd").html("선택하세요.");
				$(".sect_cd_ul").append(inner_li);
			}
			else
			{
				
			}
		}
	});	
}

var sect_cd="";
var sect_text ="";
var main_cd = "";
function sect_choose(){
	sect_value = $('#sect_cd').val();
	sect_text = $('.sect_cd').text();
	//$("#sect_cd").val(sect_value);
	//$(".sect_cd").html(sect_text);
	
	//$('.select-ul').css('display','none');
	
	main_cd =$("#main_cd").val();
	var lect_cd = main_cd+''+sect_value+''+'0001';
	$('#lect_cd').val(lect_cd);
	/*
	$.ajax({
		type : "POST", 
		url : "./getlectcode",
		dataType : "text",
		data : 
		{
			main_cd : main_cd,
			sect_cd : sect_value
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var lect_cd = 0;
			if (result.length==0) {
				lect_cd = '0001';
			}else{
				lect_cd = (result[0].LECT_CD*1)+1;				
			}
			if(String(lect_cd).length == 1)
			{
				lect_cd = "000"+lect_cd;
			}
			if(String(lect_cd).length == 2)
			{
				lect_cd = "00"+lect_cd;
			}
			if(String(lect_cd).length == 3)
			{
				lect_cd = "0"+lect_cd;
			}
			
			$("#lect_cd").val(lect_cd);
		}
	});	
	*/
	
	$.ajax({
		type : "POST", 
		url : "/basic/peri/getCancled",
		dataType : "text",
		async : false,
		data : 
		{
			selPeri : $("#selPeri").val(),
			selStore : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
		//	var result = JSON.parse(data);

		}
	});	
	
}

var encd_cust_cnt =1;
function search_cust_encd(){

	var choose_year = $('#target_selYear').val();
	var season = $('#target_selSeason').val();
	var start_day='';
	var end_day='';
	
	if(season =='봄학기'){
		start_day = choose_year+''+'0300';
		end_day = choose_year+''+'0599';
	}else if(season =='여름학기'){
		start_day = choose_year+''+'0600';
		end_day = choose_year+''+'0899';
	}else if(season =='가을학기'){
		start_day = choose_year+''+'0900';
		end_day = choose_year+''+'1199';
	}else if(season =='겨울학기'){
		start_day = choose_year+''+'1200';
		end_day = choose_year+''+'0299';
	}else{
		start_day = choose_year+''+'0000';
		end_day = choose_year+''+'9999';
	}
	
	$.ajax({
		type : "POST", 
		url : "./getEncdCustList",
		dataType : "text",
		async : false,
		data : 
		{
			selBranch : $('#selBranch').val(),
			//main_cd	: 1,
			main_cd : $('#main_cd').val(),
			sect_cd : $('#sect_cd').val(),
			lect_cd : $('#lect_cd').val(),
			start_day : start_day,
			end_day : end_day
			
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
			$('#addcust_area').empty();
			
			
			for(var i = 0; i < result.length; i++)
			{
				inner='';
				
				inner+='<tr id="encd_cust_tr_'+encd_cust_cnt+'" class="left">';
				inner+='	<td>';
				inner+='		<input type="checkbox" id="cust_list'+encd_cust_cnt+'" class="cust_list_chk left_chk chk_input" name="idx" value="'+result[i].CUST_NO+'"><label for="cust_list'+encd_cust_cnt+'"></label>';
				inner+='	</td>';
				
				inner+='	<td class="chk_num">'+(i+1)+'</td>';
				inner+='	<td>'+result[i].KOR_NM+'</td>';
				inner+='	<td id="cus_no">'+result[i].CUS_NO+'</td>';
				inner+='	<td>브론즈</td>';
				inner+='	<td>'+result[i].CNT+'</td>';
				inner+='</tr>';
				if ((i+1)==result.length) {
					inner+='<tr id="add_area_left" style="display:none;">';
					inner+='</tr>';
				}
				encd_cust_cnt++;
				$('#addcust_area').append(inner);
			}
		}
	});	
}

function switch_cust(from,to){
	var chk_flag =0;
	
	  var chkArray = [];
      $('input[name="idx"]:checked').each(function(i){//체크된 리스트 저장
    	  chkArray.push($(this).val());
      });
      
      var numbering =1;
      $('.'+to+'_chk').each(function(){
    	for (var i = 0; i < chkArray.length; i++) {
			if (chkArray[i] == $(this).val()) {
				alert($(this).parent().next().next().text()+'님은 이미 존재합니다.');
				chk_flag=1;
			}
		}  
      })
	
	if (chk_flag==1) {
		return;
	}
	
	var move_area ="";
	$('.cust_list_chk').each(function(){ 
		if( $(this).prop("checked")==true ){
			$(this).parent().parent().removeClass(from);
			$(this).removeClass(from+'_chk');
			$(this).addClass(to+'_chk');
			$(this).parent().parent().addClass(to);
			$(this).prop("checked",false);
			move_area = $(this).parent().parent().attr('id');
			$('#'+move_area).insertBefore('#add_area_'+to);
		}
	})
	$('.chk_input').prop("checked",false);
	
    var numbering =1;
    $('.right_chk').each(function(){
  	 	 $(this).parent().next().text(numbering);
  	  	numbering++;
    })
    
    numbering=1;
    $('.left_chk').each(function(){
    	$(this).parent().next().text(numbering);
    	numbering++;
    })
}

function all_chker(way){
	if ( $('#'+way+'_all_chk').prop("checked")==true )  {
		$('.'+way+'_chk').prop("checked",false);			
	}else{
		$('.'+way+'_chk').prop("checked",true);
	}
}

function choose_cust(){
	custList = "";
	custArray =[];
    $('input[name="idx"]:checked').each(function(i){//체크된 리스트 저장
    	//custList=custList+$(this).parent().next().next().next().text()+'@'; //멤버스 번호
    	custList =custList+$(this).val()+'@';	//고객번호
    	custArray.push($(this).val());
    });
    if (custArray.length==0) {
		alert('회원을 선택해주세요.');
		return;
	}
    
    $('#give_layer').fadeOut(200);	
}

function choose_cancle(){
	custList = "";
	custArray =[];
	$('#give_layer').fadeOut(200);
}

</script>

<div class="give-wrap">
	<form>
		<div class="top-row">
			<div class="wid-5">
				<h3>대상자 지정</h3>
				<div class="table-top bg01">
					<div class="top-row">
						<div class="wid-10">
							<div class="table table02 table-input wid-contop">
								<div>
									<select de-data="${branchList[0].SHORT_NAME}" id="target_selBranch" name="selBranch" onchange="fncPeri()">
										<c:forEach var="i" items="${branchList}" varStatus="loop">
											<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
										</c:forEach>
									</select>
								</div>
								<div class="sel-scr">
									<select de-data="${year}" id="target_selYear" name="selYear" onchange="fncPeri()">
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
								</div>
								<div>
									<select de-data="봄학기" id="target_selSeason" name="selSeason" onchange="fncPeri()">
										<option value="봄학기">봄학기</option> 
										<option value="여름학기">여름학기</option> 
										<option value="가을학기">가을학기</option> 
										<option value="겨울학기">겨울학기</option> 
									</select>
								</div>
							</div>
							
						</div>
					</div>
					<div class="top-row">
						<div class="wid-10">
							<div class="table table02 table-input wid-contop">
								<div class="wid-2">
									<select de-data="대분류" id="main_cd" name="main_cd" data-name="대분류" class="notEmpty" onchange="selMaincd(this)">
										<c:forEach var="j" items="${maincdList}" varStatus="loop">
											<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
										</c:forEach>
									</select>
								</div>	
								<div class="sel-scr wid-2">
									<select de-data="중분류" id="sect_cd" name="sect_cd" data-name="중분류" class="notEmpty" onchange="sect_choose(this)">

									</select>
								</div>
								
								<div class="wid-35 gift-code">
									<div class="sear-tit">강좌코드</div>
									<div>
										<input type="text" id="lect_cd" name="lect_cd" value="" class="inputDisabled" disabled="disabled">
									</div>
								</div>
							</div>
						</div>
					</div>
					<input class="search-btn02 btn btn02" type="button" value="Search" onclick="search_cust_encd()">				
				</div>
				
				
				<div class="gift-table">
					<div class="table-cap table">
						
						<div class="cap-r text-right">
							<div><a class="bor-btn bor-btn02 btn03" href="#">검색회원 전체추가</a></div>
							<div class="sel-scr mrg-l6">
								<select id="listSize" name="listSize" onchange="reSelect()" de-data="10개 보기">
									<option value="20">10개 보기</option>
									<option value="20">20개 보기</option>
									<option value="50">50개 보기</option>
									<option value="100">100개 보기</option>
									<option value="300">300개 보기</option>
									<option value="500">500개 보기</option>
									<option value="1000">1000개 보기</option>
								</select>
							</div>
						</div>
					</div>
				
					<div class="table-list table-csplist table-wid6">
						<table>
							
							<thead>
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="left_all_chk" class="chk_input" name="left_all_chk" value="idxAll"><label for="left_all_chk" onclick="all_chker('left');"></label>
									</th>
									<th>NO.</th>
									<th>회원명<i class="material-icons">import_export</i></th>
									<th>멤버스번호<i class="material-icons">import_export</i></th>
									<th>회원등급<i class="material-icons">import_export</i></th>
									<th>수강강좌수<i class="material-icons">import_export</i></th>
								</tr>
							</thead>
							<tbody id="addcust_area">
								<tr id="add_area_right">
								</tr>
								
							</tbody>
						</table>
					</div>
				
				
				</div>
			
			</div>
			
			
			<div class="wid-5 wid-5_gift">
				<h3>선택회원 리스트</h3>
				
				<div class="gift-table gift-table02">
					<div class="table-cap table">
						
						<div class="cap-r text-right">
							<div><a class="bor-btn bor-btn02 btn03" href="#">검색회원 전체추가</a></div>
							<div class="sel-scr mrg-l6">
								<select id="listSize" name="listSize" onchange="reSelect()" de-data="10개 보기">
									<option value="20">10개 보기</option>
									<option value="20">20개 보기</option>
									<option value="50">50개 보기</option>
									<option value="100">100개 보기</option>
									<option value="300">300개 보기</option>
									<option value="500">500개 보기</option>
									<option value="1000">1000개 보기</option>
								</select>
							</div>
						</div>
					</div>
				
					<div class="table-list table-csplist table-wid6">
						<table>
							
							<thead>
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="right_all_chk" class="chk_input" name="right_all_chk" value="idxAll"><label for="right_all_chk" onclick="all_chker('right');"></label>
									</th>
									<th>NO.</th>
									<th>회원명<i class="material-icons">import_export</i></th>
									<th>멤버스번호<i class="material-icons">import_export</i></th>
									<th>회원등급<i class="material-icons">import_export</i></th>
									<th>수강강좌수<i class="material-icons">import_export</i></th>
								</tr>
							</thead>
							<tbody id='choose_area'>
								<tr id="add_area_right" style="display:none;">
								</tr>
								
							</tbody>
						</table>
					</div>
				
				
				</div>
			
			</div>
			
			
		</div>
		
		<div class="move-arrow">
			<div class="next-btn"><i class="material-icons" onclick="switch_cust('left','right');">keyboard_arrow_right</i></div>
			<div class="prev-btn"><i class="material-icons" onclick="switch_cust('right','left');">keyboard_arrow_left</i></div>
		</div>
		
		
	</form>
	<div class="btn-wr text-center">
		<a class="btn btn01 ok-btn" onclick="javascript:choose_cancle();">취소</a>
		<a class="btn btn02 ok-btn" onclick="javascript:choose_cust();">선택완료</a>
	</div>
	</form>
</div>