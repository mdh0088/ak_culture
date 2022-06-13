<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(document).ready(function(){
	var code_cnt =  $(".code_num").length-1;
	var last_code_value= $(".code_num").eq(code_cnt).text()*1;
	last_code_value = last_code_value+1;
	
	$('.add_main_code').each(function(){ 
		$(this).val(last_code_value);
		return false;
	})
	
	$('.add_main_code').val("${LastCode}");
	
})
var add_code_cnt = 2;
function add_code(){
	
	var code_value_cnt =  $(".add_main_code").length-1;
	var last_value= $(".add_main_code").eq(code_value_cnt).val()*1;
	last_value = last_value+1;
	
	var inner = "";
	inner += '<div class="main_code_area table table02 code_area_'+add_code_cnt+'">';
	inner += '	<div class="wid-2"><input class="add_main_code" value="'+last_value+'" type="text" placeholder="'+add_code_cnt+'" readonly="readonly"/></div>';
	inner += '	<div class="wid-3"><input type="text" class="add_main_code_nm" placeholder="코드명" /></div>';
	inner += '	<div class="wid-10"><input type="text" class="add_main_code_cont" placeholder="코드내용을 입력하세요." /></div>';
	inner += '	<div class="btn-row pad-l6"><i class="material-icons remove" onclick="remove_code('+add_code_cnt+');">remove_circle_outline</i></div>';
	inner += '</div>';
	$(".add_area").append(inner);
	
	add_code_cnt ++;
}

function remove_code(idx)
{
	$(".code_area_"+idx).remove();
}




var add_subcode_cnt = 2;
function add_subcode(){
	
	var code_num = "";
	$('.code_num').each(function(){ 
		code_num = code_num+$(this).text()+'@';
	})
	
	code_num_arr = code_num.split('@');
	
	var inner = "";
	inner += '<div class="bor-div sub_code_area_'+add_subcode_cnt+'">';
	inner += '	<div class="sub_code_area table table02  sel-scr">';
	inner += '		<div>';
	
	inner += ' 			<div class="select-box">';
	inner += '				<div class="selectedOption sub_area_'+add_subcode_cnt+'"></div>';
	inner += '				<ul class="select-ul sub_area_'+add_subcode_cnt+'_ul" style="display:none; overflow:hidden;">';
	
	for (var i = 0; i < code_num_arr.length-1; i++) {
		inner +='				<li>'+code_num_arr[i]+'</li>';
	}
	
	inner += '				</ul>';
	inner += '				<select name="write_cate" class="notEmpty main_code main'+add_subcode_cnt+'" de-data="선택하세요" style="display:none;" onchange="choose_code_fg('+add_subcode_cnt+');">';
	
	for (var i = 0; i < code_num_arr.length-1; i++) {
	inner +='				<option value="'+code_num_arr[i]+'">'+code_num_arr[i]+'</option>';
	}
	
	inner += '				</select>';
	inner += '			</div>';
	
	inner += '		</div>';
	inner += '		<div>';
	inner += '			<div class="btn-row pad-l6"><i class="material-icons remove" onclick="remove_subcode('+add_subcode_cnt+');">remove_circle_outline</i></div>';
	inner += '		</div>';
	inner += '	</div>';
	
	inner += '	<div class="sub_code_area table table02">';
	inner += '		<div class="wid-2"><input type="text" class="sub_code sub'+add_subcode_cnt+'" placeholder="" readonly=readonly/></div>';
	inner += '		<div class="wid-3"><input type="text" class="wid9_mar5 sub_code_title" placeholder="코드명" /></div>';
	inner += '		<div class="wid-10"><input type="text" class="sub_code_cont" placeholder="코드내용을 입력하세요." /></div>';
	inner += '		<div class="btn-row pad-l6"><i class="material-icons add" onclick="add_inner_line('+add_subcode_cnt+')">add_circle_outline</i></div>';
	inner += '	</div>';
	
	inner += '</div>';
	$(".subcode_area").append(inner);
	
	add_subcode_cnt ++;
}

function remove_subcode(idx)
{
	$(".sub_code_area_"+idx).remove();
}


var add_inner_cnt = 2;
function add_inner_line(idx){
	var last_value =[];	
    $('.sub_code').each(function(i){
    	last_value.push($(this).val());
    });
    
    last_num = (last_value[last_value.length-1]*1)+1;
    
    
	var inner = "";
	inner += '<div class="sub_code_area table table02 inner_line_'+idx+'_'+add_inner_cnt+'">';
	inner += '	<div class="wid-2"><input class="sub_value_'+idx+' sub_code sub'+idx+'" type="text" value="'+last_num+'" placeholder=""/></div>';
	inner += '	<div class="wid-3"><input type="text" class="wid9_mar5 sub_code_title" placeholder="코드명" /></div>';
	inner += '	<div class="wid-10"><input type="text" class="sub_code_cont" placeholder="코드내용을 입력하세요." /></div>';
	inner += '	<div class="btn-row pad-l6"><i class="material-icons remove" onclick="remove_inner_line('+idx+','+add_inner_cnt+')">remove_circle_outline</i></div>';
	inner += '</div>';
	$(".sub_code_area_"+idx).append(inner);
	

	
	
	
	add_inner_cnt ++;
}

function remove_inner_line(idx,cnt)
{
	$(".inner_line_"+idx+"_"+cnt).remove();
}



function fncSubmit(){
	var main_code ="";
	var sub_code ="";
	var sub_code_title="";
	var sub_code_cont="";
	var chker="";
	var chker_arr="";
	
	
	var empty_flag=0;
	
	$('.sub_code_area').each(function(){
		if ($(this).children().find('.sub_code').val()=="") {
			alert("값을 입력해주세요.");
			empty_flag=1;
			($(this).children().find('.sub_code')).focus();
			return false;
		}
		
		if ($(this).children().find('.sub_code_title').val()=="") {
			alert("값을 입력해주세요.");
			empty_flag=1;
			($(this).children().find('.sub_code_title')).focus();
			return false;
		}
		
		if ($(this).children().find('.sub_code_cont').val()=="") {
			alert("값을 입력해주세요.");
			empty_flag=1;
			($(this).children().find('.sub_code_cont')).focus();
			return false;
		}
		
		
	})
	
	if (empty_flag==1) {
		return;
	}
	
		$('.main_code').each(function(){
			main_code = main_code+$(this).val()+'@';
			chker=$(this).attr('class');
			chker = chker.split(' ');
			chker = chker[2].split('main');
			chker = chker[1];
			
			$('.sub'+chker).each(function(){
				chker=$(this).parent().parent().parent().attr('class');
				//alert(chker);
				sub_code = sub_code+$(this).val()+'@';
				sub_code_title = sub_code_title+$(this).parent().next().find('.sub_code_title').val()+'@';
				sub_code_cont = sub_code_cont+$(this).parent().next().next().find('.sub_code_cont').val()+'@';
			})
			
			sub_code = sub_code+'-';
			sub_code_title = sub_code_title+'-';
			sub_code_cont = sub_code_cont+'-';
			
		})
		
		$('#main_code').val(main_code);
		$('#sub_code').val(sub_code);
		$('#sub_code_title').val(sub_code_title);
		$('#sub_code_cont').val(sub_code_cont);
		
		
		
		//var main_code_arr = main_code.split('@');
		//var sub_code_arr = sub_code.split("?");
		//var sub_code_title_arr = sub_code_title.split("?");
		//var sub_code_cont_arr = sub_code_cont.split("?");
		
		//var a ="";
		//var b ="";
		//var c ="";
		//var d ="";
		
	//	for (var i = 0; i < main_code_arr.length-1; i++) {

		//	a= main_code_arr[i];
			//var insert_sub_code = sub_code_arr[i].split("@");
			//var insert_sub_code_title = sub_code_title_arr[i].split("@");
			//var insert_sub_code_cont = sub_code_cont_arr[i].split("@");
			

				
			//for (var j = 0; j < insert_sub_code.length-1; j++) {
			//	b=insert_sub_code[j];
			//	c=insert_sub_code_title[j];
			//	d=insert_sub_code_cont[j];
			//	alert(a+','+b+','+c+','+d);
			//}

			
			
	//	}
		
		

		
		$("#fncForm").ajaxSubmit({
			success: function(data)
			{
				console.log(data);
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
 	    			location.reload();
	    		}
	    		else
	    		{
		    		alert(result.msg);
	    		}
			}
		});
		
}
var last_num="";
function choose_code_fg(idx){
	var pattern_num = /[0-9]/;
	var pattern_eng = /[a-zA-Z]/;

	
	$.ajax({
		type : "POST", 
		url : "./getLastSub",
		dataType : "text",
		data : 
		{
			code_fg : $('#sub_code_fg').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			
			if(result[result.length-1] != null && result[result.length-1] != undefined)
			{
				last_num = result[result.length-1].SUB_CODE;
			}
			else
			{
				last_num = "0";
			}
			
			
			//if (pattern_eng.test(last_num)) {
			//	alert("ZA".charCodeAt());
			//}
			
			if (pattern_num.test(last_num)) {
// 				$('.sub'+idx).val((last_num*1)+1);						
			}
			last_num=$('.sub'+idx).val();
			
		}
	});
}

function add_mainCode(){
	
	var len = $('.add_main_code').length;
	var main_code="";
	var main_code_nm="";
	var main_code_cont="";
	
	$('.main_code_area').each(function(){
		main_code = main_code+$(this).children().find('.add_main_code').val()+'|';
		main_code_nm = main_code_nm+$(this).children().find('.add_main_code_nm').val()+'|';
		main_code_cont = main_code_cont+$(this).children().find('.add_main_code_cont').val()+'|';
	})
	
	
	$.ajax({
		type : "POST", 
		url : "./addMainCode",
		dataType : "text",
		data : 
		{
			main_code : main_code,
			main_code_nm :main_code_nm,
			main_code_cont : main_code_cont
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
			
		}
	});
	
	getMainCode();
	
}

function save_cancel(){
	$('#write_layer').fadeOut(200);
	$('.add_area').empty();
}

</script>
<div>
	<form id="fncForm" name="fncForm" method="post" action="./write_proc">
		<input type="hidden" id="main_code" name="main_code" value="">
		<input type="hidden" id="sub_code" name="sub_code" value="">
		<input type="hidden" id="sub_code_title" name="sub_code_title" value="">
		<input type="hidden" id="sub_code_cont" name="sub_code_cont" value="">
		
	</form>
	
	<form>
		<div class="top-row vertical-top ak-wrap_code">
			<div class="wid-5">
			
				<h3>코드 추가</h3>
				
				<div class="main_code_area table table02 code_area_1">
					<div class="wid-2"><input class="add_main_code" type="text" value="" readonly="readonly"/></div>
					<div class="wid-3"><input type="text" class="add_main_code_nm" placeholder="코드명" /></div>
					<div class="wid-10"><input type="text" class="add_main_code_cont" placeholder="코드내용을 입력하세요." /></div>
					<div class="btn-row pad-l6"><i class="material-icons add" onclick="add_code();">add_circle_outline</i></div>
				</div>

				<div class='add_area'>


				</div>

				<div class="btn-right">
					<a class="btn btn04" onclick="javascript:add_mainCode();">저장</a>
				</div>				
				
			</div>
			<div class="wid-5 wid-5_last subcode_area">
				
				<h3>세부코드 추가</h3>
				<div class="bor-div sub_code_area_1">
					<div class="table table-auto sel-scr">
						<div>
							<select name="write_cate" id="sub_code_fg" class="notEmpty main_code main1" de-data="선택하세요" onchange="choose_code_fg(1);">	
							<c:forEach var="i" items="${code_list}" varStatus="loop">
								<option class="code_num" value="${i.SUB_CODE}">${i.SUB_CODE} | ${i.SHORT_NAME}</option>
							</c:forEach>					
							</select>
							
						</div>
						<div>
							<div class="btn-row pad-l6"><i class="material-icons add" onclick="add_subcode()">add_circle_outline</i></div>
						</div>
						
					</div>
					<div class="sub_code_area table table02 inner_line_1">
						<div class="wid-2"><input type="text" class="sub_code sub1" placeholder=""/></div>
						<div class="wid-3"><input type="text" class="wid9_mar5 sub_code_title" placeholder="코드명" /></div>
						<div class="wid-10"><input type="text" class="sub_code_cont" placeholder="코드내용을 입력하세요." /></div>
						<div class="btn-row pad-l6"><i class="material-icons add" onclick="add_inner_line(1);">add_circle_outline</i></div>
					</div>
					

					
				</div>
				

				
			</div>
		</div>
	</form>
	<div class="btn-wr text-center">
		<a class="btn btn01 ok-btn" onclick="javascript:save_cancel();">저장하지 않음</a>
		<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();">저장</a>
	</div>
	</form>
</div>