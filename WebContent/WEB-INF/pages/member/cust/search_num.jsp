<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function getUserList()
{
	if($("#searchPhone").val() == "")
	{
		alert("휴대폰번호를 윕력해주세요.");
		$("#searchPhone").focus();
		return;
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "./getUserList",
			dataType : "text",
			data : 
			{
				searchPhone : $("#searchPhone").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				
				$("#searchResult").empty();
				$(".select-ul:eq(18)").empty();
				

				
				console.log(data);
				$("#searchResult").empty();
				var result = JSON.parse(data);
				
				var inner = "";
				var p_num1 = 0;
				var p_num2 = 0;
				var p_num3 = 0;
				var p_num = "";
				var kor_name ="";
				
				if(result.length != 0){
					for(var i = 0; i<result.length; i++)
					{
						inner = "";
						p_num1 = result[i].PHONE_NO1;
						p_num2 = result[i].PHONE_NO2;
						p_num3 = result[i].PHONE_NO3;
						kor_name = result[i].KOR_NM;
						p_num = kor_name+'|'+p_num1+'-'+p_num2+'-'+p_num3;
						var only_num = p_num1+'-'+p_num2+'-'+p_num3;
						
						inner = "<option onclick=choose_cus('"+result[i].CUST_NO+"',this)>"+p_num+"</option>";
						
						
						
						$("#searchResult").append(inner);
						$(".select-ul:eq(18)").append(inner);
						if (i==0) {
							$(".selectedOption:eq(18)").html(p_num);
						}

					}
				}else{
	    			inner = "";
					p_num1 = result[0].PHONE_NO1;
					p_num2 = result[0].PHONE_NO2;
					p_num3 = result[0].PHONE_NO3;
					kor_name = result[0].KOR_NM;
					p_num = kor_name+'|'+p_num1+'-'+p_num2+'-'+p_num3;
					inner = "<option onclick=choose_cus('"+result[i].CUST_NO+"')>"+p_num+"</option>";
	    			
					$("#searchResult").append(inner);
					$(".select-ul:eq(18)").append(inner);
					$(".selectedOption:eq(18)").html("");
					
	    		}
				

			}
		});
	}
}

var cus_info ="";
function choose_cus(idx,this_val){
	cus_info = $(this_val).val();
	$(".selectedOption:eq(18)").html(cus_info);
	$("#cus_no").val(idx);
}

function choose_confirm(){
	//alert($("#cus_no").val());
	$('#give_layer').fadeOut(200);
	
	$.ajax({
		type : "POST", 
		url : "./getCusList",
		dataType : "text",
		data : 
		{
			search_cus : $("#cus_no").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			

			
			console.log(data);
			var result = JSON.parse(data);
			var home_tel_no = result[0].H_PHONE_NO_1+'-'+result[0].H_PHONE_NO_2+'-'+result[0].H_PHONE_NO_3;
			var tel_no =  result[0].PHONE_NO1+'-'+result[0].PHONE_NO2+'-'+result[0].PHONE_NO3;
			
			$('.name').text(result[0].KOR_NM);
			$('#cus_name1').val(result[0].KOR_NM);
			$('#cus_birth1').val(result[0].BIRTH_YMD);
			$('#cus_name').val(result[0].KOR_NM);
			$('#cus_birth').val(result[0].BIRTH_YMD);
			$('#cus_h_tel').val(home_tel_no);
			$('#cus_mail').val(result[0].EMAIL_ADDR);
			$('#cus_tel').val(tel_no);
			
			if (result[0].EMAIL_YN=='Y') {  //이메일 수신 동의
				
			}
			
			if (result[0].SMS_YN=='Y') {	//SMS 수신 동의
				
			}
			$('#cus_memNo').val(result[0].CUS_NO);
			$('#cus_ptl_id').val(result[0].PTL_ID);
			$('#cus_join_date').val(result[0].CREATE_DATE);
			//$('#cus_memNo_card').val(); //멤버스 카드 번호
			//$('#cus_baking_mom').val(); //베키맘여부
			
			if (result[0].SEX_FG=='F') { //성별
				
			}
			
			if (result[0].MARRY_FG=='1') { //결혼여부
				
			}
			
			$('#cus_address_1').val(result[0].POST_NO1+'-'+result[0].POST_NO2);
			$('#cus_address_2').val(result[0].ADDR_TX1);
			$('#cus_address_3').val(result[0].ADDR_TX2);
		}
	});
	
}
</script>
<div>
	<input type="hidden" id="cus_no">
	
	<form id="fncFormIp" name="fncFormIp" method="POST" action="./write_proc">
		<div>
        	<h3 class="text-center">휴대폰번호 조회</h3>
			<div class="table table02 table-searnum">
				<div class="wid-5">
					<input type="text" data-name="휴대폰번호 뒷자리" id="searchPhone" name="searchPhone" class="" placeholder="휴대폰 뒷번호 네자리 입력">
					<a class="btn btn02" onclick="javascript:getUserList()">검색</a>
				</div>
				<div class="wid-5">
					<Select de-data="&nbsp;" id="searchResult" name="searchResult">
				</Select>
					<a class="btn btn02" onclick="choose_confirm();">선택완료</a>
				</div>
       		</div>
       	</div>
		
	</form>
</div>