<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<meta http-equiv="X-UA-Compatible" content="IE=11">
<meta http-equiv="Expires" content="Mon, 06 Jan 1990 00:00:01 GMT">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<script src="/inc/js/sale3.js"></script>
<style>
.redFont > td
{
color:red;
}
</style>
<div id="give_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg sign-edit">
        		<div class="close" onclick="javascript:closeSignView();" style="display:none;">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="give-wrap">
					<OBJECT id="cardX" style="WIDTH: 256px; HEIGHT: 128px" classid="clsid:93137A73-7A61-4911-8018-C758BBE73F53"></OBJECT>
					<object id="cardX2" classid="clsid:93137A73-7A61-4911-8018-C758BBE73F53" style="left:10px; top:56px; width:0px; height:0px; "></object>
				</div>
				<div class=" text-center" style="margin-top: 30px;">
					<a class="btn btn02 ok-btn" onclick="closeSignView()">확인</a>
				</div>
        	</div>
        </div>
    </div>	
</div>
<div id="cash_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg phone-edit">
        		<div class="close" onclick="javascript:$('#cash_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="cash-wrap">
	        		<div class="table">
		        		<div class="wid-3">
		        			<ul class="chk-ul">
		        				<li>
		        					<input type="radio" id="cashLayer_deduction1" name="cashLayer_deduction" value="0" checked>
									<label for="cashLayer_deduction1">소득공제</label>
		        				</li>
		        				<li>
		        					<input type="radio" id="cashLayer_deduction2" name="cashLayer_deduction" value="1">
									<label for="cashLayer_deduction2">지출공제</label>
		        				</li>
		        			</ul>
		        		
		        		</div>
		        		<div>
		        			<a class="btn btn01" onclick="javascript:auto_deduction();">자동공제</a>
		        			<a class="btn btn01" onclick="javascript:cash_key_in();" id="cashLayer_btn_next">Key-In</a>
		        			<a class="btn btn01" href="#" id="cashLayer_btn_next_card" style="display:none;">카드등록</a>
		        		</div>
	        		</div>
	        		<div class="table">
		        		<div class="wid-65">
		        			<ul class="chk-ul">
		        				<li>
				        			<input type="radio" id="cashLayer_select_fg1" name="cashLayer_select_fg" value="h_phone" checked>
									<label for="cashLayer_select_fg1">휴대폰번호</label>
					        	</li>
		        				<li>
				        			<input type="radio" id="cashLayer_select_fg2" name="cashLayer_select_fg" value="card_no">
									<label for="cashLayer_select_fg2">카드번호</label>
		        				</li>
		        				<li>
				        			<input type="radio" id="cashLayer_select_fg3" name="cashLayer_select_fg" value="regis_no">
									<label for="cashLayer_select_fg3">주민번호</label>
		        				</li>
		        				<li>
				        			<input type="radio" id="cashLayer_select_fg4" name="cashLayer_select_fg" value="biz_no">
									<label for="cashLayer_select_fg4">사업자등록번호</label>
		        				</li>
		        			</ul>
		        		
		        		</div>
		        		<div>
		        			<input type="text" id="cashLayer_key_value" name="cashLayer_key_value">
		        		</div>
	        		
	        		</div>
		        	<div class="table ">
		        		<div>
		        			<div class="table table-auto">
								<div class="sear-tit">금액</div>
								<div>
									<input type="text" id="cashLayer_cash_amt" name="cashLayer_cash_amt">
								</div>
							</div>
		        		</div>
		        		
	       				<div>
	       					<a class="btn btn01" onclick="javascript:cash_approveCheck();">현금영수증 승인번호 조회</a>
	       				</div>
		        		<div>
		        			<div class="table table-auto">		        			
								<div class="sear-tit text-center">승인번호</div>
								<div>
		        			<input type="text" id="cashLayer_approve_no" name="cashLayer_approve_no">
								</div>
							</div>
		        		</div>
		        	</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<div id="mcoupon_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg ">
        		<div class="close" onclick="javascript:$('#mcoupon_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="mcoupon-wrap">
	        		<h3>모바일 상품권</h3>
	        		<div class="top-row">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_140">총 결제금액</div>
								<div>
									<input type="text" id="mcouponLayer_final_pay" name="mcouponLayer_final_pay">
								</div>
							</div>
						</div>
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_140">모바일상품권번호</div>
								<div>
									<input type="text" id="mcouponLayer_barcode_no" name="mcouponLayer_barcode_no">
								</div>
							</div>
						</div>
					</div>
					<div class="top-row">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_140">사용가능금액</div>
								<div>
									<input type="text" id="mcouponLayer_remain_amt" name="mcouponLayer_remain_amt">
								</div>
							</div>
						</div>
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_140">사용금액</div>
								<div>
									<input type="text" id="mcouponLayer_use_amt" name="mcouponLayer_use_amt" class="comma">
								</div>
							</div>
						</div>
					</div>
					<div class="top-row">
<!-- 						<div class="wid-5"> -->
<!-- 							<div class="table"> -->
<!-- 								<div class="sear-tit sear-tit_140">결제 잔여금</div> -->
<!-- 								<div> -->
<!-- 									<input type="text" id="mcouponLayer_rmn_amt" name="mcouponLayer_rmn_amt"> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="wid-5"> -->
<!-- 							<div class="table"> -->
<!-- 								<div class="sear-tit sear-tit_140">차액지불구분</div> -->
<!-- 								<div> -->
<!-- 									<ul class="chk-ul"> -->
<!-- 										<li> -->
<!-- 											<input type="radio" id="mcouponLayer_rmn_fg1" name="mcouponLayer_rmn_fg" value="zero" checked> -->
<!-- 											<label for="mcouponLayer_rmn_fg1">없음</label> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 						        			<input type="radio" id="mcouponLayer_rmn_fg2" name="mcouponLayer_rmn_fg" value="m_card"> -->
<!-- 											<label for="mcouponLayer_rmn_fg2">카드</label> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 						        			<input type="radio" id="mcouponLayer_rmn_fg3" name="mcouponLayer_rmn_fg" value="m_cash"> -->
<!-- 											<label for="mcouponLayer_rmn_fg3">현금+지류상품권</label> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>
					<div class="top-row">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_140">모바일상품권 잔여금</div>
								<div>
									<input type="text" id="mcouponLayer_coupon_remain_amt" name="mcouponLayer_coupon_remain_amt">
								</div>
							</div>
						</div>
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_140">승인금액</div>
								<div>
									<input type="text" id="mcouponLayer_approve_amt" name="mcouponLayer_approve_amt">
								</div>
							</div>
						</div>
					</div>
					<div class="top-row">
						<div class="wid-5">
							<div class="table">
								<div class="sear-tit sear-tit_140">승인번호</div>
								<div>
									<input type="text" id="mcouponLayer_approve_no" name="mcouponLayer_approve_no">
								</div>
							</div>
						</div>
					</div>
	        		<div class="btn-wr text-center">
						<a class="btn btn02" onclick="javascript:mcoupon_getRemain();"> 조회</a>
						<a class="btn btn03" onclick="javascript:mcoupon_approveCheck()"> 승인</a>
						<a class="btn btn01" onclick="javascript:$('#mcoupon_layer').fadeOut(200);"> 닫기</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<div id="coupon_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg popwid-1300">
        		<div class="close" onclick="$('#coupon_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="coupon-wrap">
	        		<h3>상품권</h3>
					<div class="table-wr">
						<div class="table-list table-list02">
							<table>
								<colgroup>
									<col width="130px">
									<col width="130px">
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col>
									<col width="60px">
								</colgroup>
								<thead>
									<tr>
										<th>구분</th>
										<th>권종구분</th>
										<th>상품권번호</th>
										<th>액면금액</th>
										<th>현금영수증 <br>100% 여부</th>
										<th>부가세제외비율(%)</th>
										<th>부가세비율(%)</th>
										<th>거스름돈</th>
										<th>거스름돈적용<br>영수증대상금액</th>
										<th>거스름돈적용<br>영수증미대상금액</th>
										<th>현금영수증<br>대상금액</th>
										<th>현금영수증<br>미대상금액</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="target_coupon">
									
								</tbody>
							</table>
						</div>
					</div>
					<div class="btn-wr text-center">
<!-- 						<a class="btn btn01" onclick="pageReset()">초기화</a> -->
						<a class="btn btn02" onclick="javascript:add_coupon();"> 추가</a>
						<a class="btn btn02" onclick="javascript:setCouponGrid();"> 적용</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<object id="printer" classid="clsid:ccb90152-b81e-11d2-ab74-0040054c3719" style="left:5px; top:500px; width:0px; height:0px; "></object>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>

var child1_no = "";
var child1_nm = "";
var child2_no = "";
var child2_nm = "";
var child3_no = "";
var child3_nm = "";
var encd1_no = "";
var encd2_no = "";
var encd1_amt = "";
var encd2_amt = "";
var part_regis_fee = "";
var part_food_amt = "";
var part_lect_cnt = "";

var encd_limit = "";
var encd_use_limit = "";
$(document).ready(function(){
	
	
	child1_no = new HashMap();
	child1_nm = new HashMap();
	child2_no = new HashMap();
	child2_nm = new HashMap();
	child3_no = new HashMap();
	child3_nm = new HashMap();
	encd1_no = new HashMap();
	encd2_no = new HashMap();
	encd1_amt = new HashMap();
	encd2_amt = new HashMap();
	part_regis_fee = new HashMap();
	part_food_amt = new HashMap();
	part_lect_cnt = new HashMap();
	encd_limit = new HashMap();
	encd_use_limit = new HashMap();
	pos_no = '${pos_no}';
	sPort = '${autosign_port}';
	user_ip = '${user_ip}';
	login_name = '${login_name}';
	
	c_print_stat = getCookie("c_print_stat"); //가맹점 전표 출력여부
	a_print_stat = getCookie("a_print_stat"); //가맹점 전표 출력여부
	setPeri();
	chargeCheck();
	var browser = isBrowserCheck();
	if(browser != "Chrome" && pos_no != "070020")
	{
		cardXCheck(); //단말기 무결성 검사
// 		posInit(); //프린터기 검사 이거 있으면 인쇄안됨 주석 풀지말것
	}
	saleInit(); //초기값 셋팅
	
	$("#sw_version").html("S/W 버전 : "+posCertiNo);
	$("#hw_version").html("H/W 버전 : "+reader_secuVer1);
	
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
	
});
var isLoading = false;
function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".search-btn02").addClass("loading-sear");
	$(".search-btn02").prop("disabled", true);
	$(".search-btn").prop("disabled", true);
	
	$(".btn02").addClass("loading-sear");
	$(".btn02").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".search-btn02").removeClass("loading-sear");			
	$(".search-btn02").prop("disabled", false);
	$(".search-btn").prop("disabled", false);
	
	$(".btn02").removeClass("loading-sear");
	$(".btn02").prop("disabled", false);
	isLoading = false;
}
function getPeriByStore()
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
			if(result.length > 0)
			{
				$(".searchPere_period").html(result[0].PERIOD);
				$("#searchPere_period").val(result[0].PERIOD);
				
				for(var i = 0; i < result.length; i++)
				{
					$("#searchPere_period").append('<option value="'+result[i].PERIOD+'">'+result[i].PERIOD+'</option>');
					$(".searchPere_period_ul").append('<li>'+result[i].PERIOD+'</li>');
				}
				var nowPeri = $("#selPeri").val();
				$("#searchPere_period").val(nowPeri);
				$(".searchPere_period").html(nowPeri);
			}
			else
			{
				$(".searchPere_period").html("검색된 기수정보가 없습니다.");
			}
		}
	});	
}
function chk_pelt_init()
{
	$("#chk_pelt").change(function() {
		if($("input:checkbox[name='chk_pelt']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_pelt").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_pelt").val()+"']").prop("checked", false);
		}
	});
}
$(document).ready(function(){
	chk_pelt_init();
	$(".mem-slide_Wrap").each(function(){
		var tit = $(this).find(".card-txt");
		var cont = $(this).find(".card-slide");
		tit.click(function(){
			cont.slideToggle();			
		})
		
	})
});
var coupon_cnt = 1;
function add_coupon()
{
	$.ajax({
		type : "POST", 
		url : "./getCouponCdCombo",
		dataType : "text",
		async : false,
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			var inner = "";
			inner += '<tr id="coupon_div_'+coupon_cnt+'">';
			inner += '	<td>';
			inner += '		<select id="couponLayer_coupon_fg'+coupon_cnt+'" name="couponLayer_coupon_fg" de-data="자사" onchange="chgCoupon(\'coupon_fg\', '+coupon_cnt+')">';
			inner += '			<option value="0">자사</option>';
			inner += '			<option value="5">타사</option>';
			inner += '			<option value="7">증정</option>';
			inner += '		<select>';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<select id="couponLayer_coupon_cd'+coupon_cnt+'" name="couponLayer_coupon_cd" de-data="'+result[0].LABEL+'" onchange="chgCoupon(\'coupon_fg\', '+coupon_cnt+')"">';
			for(var i = 0; i < result.length; i++)
			{
				inner += '			<option value="'+result[i].VALUE+'">'+result[i].LABEL+'</option>';
			}
			inner += '		<select>';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_coupon_no'+coupon_cnt+'" name="couponLayer_coupon_no" onkeypress="excuteEnter_param(chgCoupon, \'coupon_no\', '+coupon_cnt+')">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_face_amt'+coupon_cnt+'" name="couponLayer_face_amt">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_cashrec_yn'+coupon_cnt+'" name="couponLayer_cashrec_yn">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_vat_cal_ext_rate'+coupon_cnt+'" name="couponLayer_vat_cal_ext_rate">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_vat_cal_rate'+coupon_cnt+'" name="couponLayer_vat_cal_rate">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_cp_chage_amt'+coupon_cnt+'" name="couponLayer_cp_chage_amt">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_cp_chage_apy_y_amt'+coupon_cnt+'" name="couponLayer_cp_chage_apy_y_amt">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_cp_chage_apy_n_amt'+coupon_cnt+'" name="couponLayer_cp_chage_apy_n_amt">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_cashrec_amt'+coupon_cnt+'" name="couponLayer_cashrec_amt">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<input type="text" id="couponLayer_cashrec_n_amt'+coupon_cnt+'" name="couponLayer_cashrec_n_amt">';
			inner += '	</td>';
			inner += '	<td>';
			inner += '		<i class="material-icons remove" onclick="remove_coupon('+coupon_cnt+')">remove_circle_outline</i>';
			inner += '	</td>';
			inner += '</tr>';
			$("#target_coupon").append(inner);
			coupon_cnt ++;
		}
	});
	
}
function remove_coupon(idx)
{
	$("#coupon_div_"+idx).remove();
}
function courseSearch()
{
	$('#search_layer').fadeIn(200);	
}
function partCancel()
{
	$.ajax({
		type : "POST", 
		url : "./getCancelSubjectList",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cust_no : $("#cust_no").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			$("#part_subject_target").html('');
			var inner = "";
			inner += '<select id="part_subject" name="part_subject" onchange="selPartSubject()">';
			for(var i = 0; i < result.length; i++)
			{
				if(i == 0)
				{
					inner += '<option value="" selected>선택</option>';
				}
				inner += '<option value="'+encodeURI(JSON.stringify(result[i]))+'">'+result[i].SUBJECT_NM+'</option>';
			}
			inner += "</select>";
			$("#part_subject_target").html(inner);
		}
	});	
	$('#cancel_layer').fadeIn(200);	
}
function selPartSubject()
{
	$("#part_target").html('');
	if($("#part_subject").val() != '')
	{
		var result = JSON.parse(decodeURI($("#part_subject").val()));
		selLect($("#part_subject").val());
		$.ajax({
			type : "POST", 
			url : "/lecture/lect/computeMid2",
			dataType : "text",
			async : false,
			data : 
			{
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				subject_cd : result.SUBJECT_CD,
				start_ymd : getNow()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result2 = JSON.parse(data);
				var inner = "";
				
				total_lect_cnt = Number(result2.total_lect_cnt);
				total_regis_fee = Number(result2.total_regis_fee);
				total_food_amt = Number(result2.total_food_amt);
				lect_cnt = result2.lect_cnt;
				
				if(result.MAIN_CD == '2') //베이비
				{
					if(nullChk(trim(result.CHILD_NO1)) != "" && nullChk(trim(result.CHILD_NO1)) != "0")
					{
						total_regis_fee += Number(total_regis_fee) / 2;
						total_food_amt += Number(total_food_amt) / 2;
					}
				}
				if(result.MAIN_CD == '3') //베이비
				{
					if(nullChk(trim(result.CHILD_NO1)) != "" && nullChk(trim(result.CHILD_NO1)) != "0")
					{
// 						total_regis_fee += Number(total_regis_fee);
// 						total_food_amt += Number(total_food_amt);
					}
				}
				
				inner += '<select id="part_lect_cnt" name="part_lect_cnt" onchange="computePrice('+total_lect_cnt+', '+total_regis_fee+', '+total_food_amt+')">';
				for(var i = 1; i <= Number(total_lect_cnt); i++)
				{
					if( i == Number(lect_cnt))
					{
						inner += '<option value="'+i+'" selected>'+i+'회</option>';
					}
					else
					{
						inner += '<option value="'+i+'">'+i+'회</option>';
					}
				}
				inner += "</select>";
				inner += " / "+total_lect_cnt+"회";
				$("#part_target").html(inner);
				
				computePrice(total_lect_cnt, total_regis_fee, total_food_amt);
// 				$("#part_regis_fee").val(result2.regis_fee);
// 				$("#part_food_amt").val(result2.food_amt);
				
				part_subject_cd = result.SUBJECT_CD;
			}
		});	
	}
}
function computePrice(total_lect_cnt, total_regis_fee, total_food_amt)
{
	var regis_fee = Number(total_regis_fee) / Number(total_lect_cnt) * Number($("#part_lect_cnt").val());
	regis_fee = Math.floor((regis_fee + 90) / 100) * 100;
	var food_amt = Number(total_food_amt) / Number(total_lect_cnt) * Number($("#part_lect_cnt").val());
	food_amt = Math.floor((food_amt + 90) / 100) * 100;
	
	$("#part_regis_fee").val(regis_fee);
	$("#part_food_amt").val(food_amt);
}


var order_by = "";
var sort_type = "";
function reSortAjax(act)
{
	if(!isLoading)
	{
		sort_type = act.replace("sort_", "");
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
		userSearch();
	}
}
var lect_order_by = "";
var lect_sort_type = "";
function reSortAjax_lect(act)
{
	if(!isLoading)
	{
		lect_sort_type = act.replace("sort_", "");
		if(lect_order_by == "")
		{
			lect_order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		else if(lect_order_by == "desc")
		{
			lect_order_by = "asc";
			$("#"+act).attr("src", "/img/th_up.png");
		}
		else if(lect_order_by == "asc")
		{
			lect_order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		getLectSearch('search');
	}
}
function userSearch()
{
	if($("#cust_no").val() != "")
	{
		alert("새로고침 후 다시 검색해주세요.");
		return;
	}
	
	if($("#search_name").val() == "" && $("#user_name").val() == "")
	{
		alert("검색어를 입력해주세요.");
		return;
	}
	
	if(!isLoading)
	{
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./userSearch",
			dataType : "text",
			data : 
			{
				search_name : $("#search_name").val(),
				order_by : order_by,
				sort_type : sort_type
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				var inner = "";
				if(result.length > 0)
 				{
 					for(var i = 0; i < result.length; i++)
 					{
 						inner += '<tr ondblclick="selUserOnPop('+result[i].CUST_NO+')" onmouseover="over_tr(this);" onmouseout="left_tr(this);">';
 						inner += '	<td>'+result[i].KOR_NM+'</td>';
 						inner += '	<td>'+cutDate(result[i].BIRTH_YMD)+'</td>';
 						inner += '	<td>'+nullChk(result[i].CUS_NO)+'</td>';
 						inner += '	<td>'+result[i].GRADE+'</td>';
 						inner += '	<td>'+result[i].PERE_CNT+'</td>';
 						inner += '</tr>';
 					}
 				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="5"><div class="no-data">검색결과가 없습니다.</div></td>';
					inner += '</tr>';
				}
				$("#search_user_target").html(inner);
				
// 				$("#searchResult").html("");
// 				$(".searchResult").html("");
// 				$(".searchResult_ul").html("");
// 				if(result.length > 0)
// 				{
// 					$(".searchResult").append(result[0].KOR_NM+" | "+result[0].PHONE_NO1+"-"+result[0].PHONE_NO2+"-"+result[0].PHONE_NO3+" | "+result[0].CUST_NO);
// 					for(var i = 0; i < result.length; i++)
// 					{
// 						$("#searchResult").append("<option value='"+result[i].CUST_NO+"'>"+result[i].KOR_NM+" | "+result[i].PHONE_NO1+"-"+result[i].PHONE_NO2+"-"+result[i].PHONE_NO3+" | "+result[i].CUST_NO+"</option>");
// 						$(".searchResult_ul").append("<li>"+result[i].KOR_NM+" | "+result[i].PHONE_NO1+"-"+result[i].PHONE_NO2+"-"+result[i].PHONE_NO3+" | "+result[i].CUST_NO+"</li>");
// 					}
// 				}
// 				else
// 				{
// 					$(".searchResult").append("검색결과가 없습니다.");
// 				}
				getListEnd();
			}
		});
	}
	$('#user_search_layer').fadeIn(200);	
	
}
function selUserOnPop(val)
{
	$("#searchResult").val(val);
	choose_confirm('search');
}
function choose_confirm(val)
{
	//대기자에서 넘어온거랑 손수검색한거 분기
	var search_cust_no = "";
	if(val != "search")
	{
		$("#searchResult").val(val);
	}
	search_cust_no = $("#searchResult").val();
	$('#user_search_layer').fadeOut(200);
	$.ajax({
		type : "POST", 
		url : "/common/getUserByCust",
		dataType : "text",
		async:false,
		data : 
		{
			cust_no : search_cust_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			$("#kor_nm").val(nullChk(result.list.KOR_NM));
			$("#kor_nm_view").val(nullChk(result.list.KOR_NM));
		 	$("#phone_no").val(trim(nullChk(result.list.PHONE_NO1))+"-"+nullChk(result.list.PHONE_NO2)+"-"+nullChk(result.list.PHONE_NO3));
		 	$("#h_phone_no").val(trim(nullChk(result.list.H_PHONE_NO_1))+"-"+nullChk(result.list.H_PHONE_NO_2)+"-"+nullChk(result.list.H_PHONE_NO_3));
		 	$("#birth_ymd").val(cutDate(nullChk(result.list.BIRTH_YMD)));
		 	$("#email_addr").val(nullChk(result.list.EMAIL_ADDR));
		 	$("#cus_no").val(nullChk(result.list.CUS_NO));
		 	$("#cust_no").val(nullChk(result.list.CUST_NO));
		 	$("#car_no").val(nullChk(result.list.CAR_NO));
		 	$("#card_no").val(nullChk(result.list.CARD_NO));
		 	$("#post_no").val(nullChk(result.list.POST_NO1+result.list.POST_NO2));
		 	$("#addr_tx1").val(nullChk(result.list.ADDR_TX1));
		 	$("#addr_tx2").val(nullChk(result.list.ADDR_TX2));
		 	$("#user_class").val(nullChk(result.list.CLASS));
		 	
		 	if(result.list.EMAIL_YN == "Y")
		 	{
		 		$("input:checkbox[id='chk_mail']").prop("checked", true); 
		 	}
		 	else if(result.list.EMAIL_YN == "N")
		 	{
		 		$("input:checkbox[id='chk_mail']").prop("checked", false);
		 	}
		 	if(result.list.SMS_YN == "Y")
		 	{
		 		$("input:checkbox[id='chk_sms']").prop("checked", true); 
		 	}
		 	else if(result.list.SMS_YN == "N")
		 	{
		 		$("input:checkbox[id='chk_sms']").prop("checked", false);
		 	}
		}
	});
	getPereByCust();
	getChildByCust();
	
// 	$.ajax({
// 		type : "POST", 
// 		url : "./getPereByCust",
// 		dataType : "text",
// 		async:false,
// 		data : 
// 		{
// 			store : $('#selBranch').val(),
// 			period : $("#selPeri").val(),
// 			cust_no : $("#searchResult").val()
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			var result = JSON.parse(data);
// 			var inner = "";
// 			for(var i = 0; i < result.length; i++)
// 			{
// 				inner += '<tr>';
// 				inner += '	<td class="td-chk">';
// 				inner += '		<input type="checkbox" id="pere_idx'+i+'" name="pere_idx" value="'+encodeURI(JSON.stringify(result[i]))+'"><label for="pere_idx'+i+'"></label>';
// 				inner += '	</td>';
// 				inner += '	<td>'+result[i].SALE_YMD+'</td>';
// 				inner += '	<td>'+result[i].PERIOD+'</td>';
// 				inner += '	<td>'+result[i].POS_NO+'</td>';
// 				inner += '	<td>'+result[i].RECPT_NO+'</td>';
// 				inner += '	<td>'+nullChk(result[i].ORI_RECPT_NO)+'</td>';
// 				inner += '	<td>'+result[i].IN_TYPE+'</td>';
// 				if(result[i].IN_TYPE != '취소')
// 				{
// 					inner += '<td><select id="cancel_idx'+i+'">'
// 					inner += '	<option value="00">강좌변경</option>';
// 					inner += '	<option value="01">강좌폐강</option>';
// 					inner += '	<option value="02">강좌내용에대한불만</option>';
// 					inner += '	<option value="03">강사에대한불만</option>';
// 					inner += '	<option value="04">강좌레벨차이</option>';
// 					inner += '	<option value="05">건강문제</option>';
// 					inner += '	<option value="06">아이부적응</option>';
// 					inner += '	<option value="07">이사</option>';
// 					inner += '	<option value="08">출산</option>';
// 					inner += '	<option value="09">개인적 스케쥴 변경</option>';
// 					inner += '	<option value="10">시설불만</option>';
// 					inner += '	<option value="11">자녀위탁 어려움</option>';
// 					inner += '	<option value="12">타교육기관 이용</option>';
// 					inner += '	<option value="13">결제수단변경</option>';
// 					inner += '	<option value="14">취업및진학</option>';
// 					inner += '	<option value="15">여행및출장</option>';
// 					inner += '	<option value="16">온라인취소</option>';
// 					inner += '	<option value="99">기타</option>';
// 					inner += '</select></td>'
// 				}
// 				else
// 				{
// 					inner += '	<td>'+result[i].CANCEL_RMK+'</td>';
// 				}
// // 				inner += '	<td>'+result[i].PAY_FG+'</td>';
// // 				inner += '	<td>'+result[i].CASH_AMT+'</td>';
// // 				inner += '	<td>'+result[i].COUPON_AMT+'</td>';
// // 				inner += '	<td>'+result[i].POINT_AMT+'</td>';
// 				inner += '	<td>'+result[i].CARD_TYPE+'</td>';
// 				inner += '	<td>'+result[i].CARD_NM+'</td>';
// 				inner += '	<td>'+result[i].CARD_NO+'</td>';
// // 				inner += '	<td>'+result[i].APPROVE_NO+'</td>';
// 				inner += '	<td>'+result[i].CARD_AMT+'</td>';
// // 				inner += '	<td>'+result[i].MC_CARD_NM+'</td>';
// // 				inner += '	<td>'+result[i].MC_CARD_NO+'</td>';
// // 				inner += '	<td>'+result[i].MC_APPROVE_NO+'</td>';
// // 				inner += '	<td>'+result[i].MC_CARD_AMT+'</td>';
// // 				inner += '	<td>'+result[i].TID+'</td>';
// 				inner += '	<td>'+result[i].INST_MM+'</td>';
// // 				inner += '	<td>'+result[i].ENURI_AMT1+'</td>';
// // 				inner += '	<td>'+result[i].ENURI_NM1+'</td>';
// // 				inner += '	<td>'+result[i].ENURI_AMT2+'</td>';
// // 				inner += '	<td>'+result[i].ENURI_NM2+'</td>';
// // 				inner += '	<td>'+result[i].ID_NO+'</td>';
// // 				inner += '	<td>'+result[i].APRV_NO+'</td>';
// // 				inner += '	<td>'+result[i].VAN_FG+'</td>';
// 				inner += '	<td>'+result[i].E_SIGN+'</td>';
// // 				inner += '	<td>'+result[i].CARD_CORP_NO+'</td>';
// // 				inner += '	<td>'+result[i].CARD_VAN_FG+'</td>';
// // 				inner += '	<td>'+result[i].MC_CARD_CORP_NO+'</td>';
// // 				inner += '	<td>'+result[i].MC_CARD_VAN_FG+'</td>';
// // 				inner += '	<td>'+result[i].ENURI_AMT+'</td>';
// // 				inner += '	<td>'+result[i].CHANGE+'</td>';
// // 				inner += '	<td>'+result[i].TRADE_ALL_AMT+'</td>';
// // 				inner += '	<td>'+result[i].VALID_DATE+'</td>';
// 				inner += '</tr>';
// 			}
// 			$("#pere_target").html(inner);
// 		}
// 	});

	
	getEnuriList(); //할인 리스트 call

// 	$.ajax({
// 		type : "POST", 
// 		url : "./getEnuriByCust",
// 		dataType : "text",
// 		async:false,
// 		data : 
// 		{
// 			store : $('#selBranch').val(),
// 			cust_no : $("#searchResult").val()
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			var result = JSON.parse(data);
// 			var inner = "";
// 			for(var i = 0; i < result.length; i++)
// 			{
// 				if(i == 0)
// 				{
// 					$("#selEnuri1").append('<option value="">선택하세요.</option>');
// 					$(".selEnuri1_ul").append('<li>선택하세요.</li>');
// 					$("#selEnuri2").append('<option value="">선택하세요.</option>');
// 					$(".selEnuri2_ul").append('<li>선택하세요.</li>');
// 				}
// 				$("#selEnuri1").append('<option value="'+result[i].ENURI_FG+'_'+result[i].ENURI+'_'+result[i].DUPL_DISCOUNT_YN+'_'+result[i].LIMITED_AMT+'">'+result[i].ENURI_NM+'</option>');
// 				$(".selEnuri1_ul").append('<li>'+result[i].ENURI_NM+'</li>');
// 				$("#selEnuri2").append('<option value="'+result[i].ENURI_FG+'_'+result[i].ENURI+'_'+result[i].DUPL_DISCOUNT_YN+'_'+result[i].LIMITED_AMT+'">'+result[i].ENURI_NM+'</option>');
// 				$(".selEnuri2_ul").append('<li>'+result[i].ENURI_NM+'</li>');
// 			}
// 		}
// 	});

	
	/*
	$.ajax({
		type : "POST", 
		url : "./getGiftByCust",
		dataType : "text",
		async:false,
		data : 
		{
			cust_no : $("#searchResult").val(),
			period : $("#selPeri").val(),
			store : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			for(var i = 0; i < result.length; i++)
			{
				$("#selGift1").append('<option value="'+result[i].CODE_FG+'_'+result[i].SUB_CODE+'">'+result[i].GIFT_NM+'</option>');
				$(".selGift1_ul").append('<li>'+result[i].GIFT_NM+'</li>');
				$("#selGift2").append('<option value="'+result[i].CODE_FG+'_'+result[i].SUB_CODE+'">'+result[i].GIFT_NM+'</option>');
				$(".selGift2_ul").append('<li>'+result[i].GIFT_NM+'</li>');
			}
		}
	});
	*/
	//거래내역 리스트가 중복되어 삭제
// 	$.ajax({
// 		type : "POST", 
// 		url : "./getSaleByCust",
// 		dataType : "text",
// 		async:false,
// 		data : 
// 		{
// 			cust_no : $("#searchResult").val()
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			var result = JSON.parse(data);
// 			var inner = "";
// 			for(var i = 0; i < result.length; i++)
// 			{
// 				inner += '<tr>';
// 				inner += '	<td class="td-chk">';
// 				inner += '		<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label>';
// 				inner += '	</td>';
// 				inner += '   	<td>'+cutDate(result[i].SALE_YMD)+'</td>';
// 				if(result[i].WEB_ACCEPT_FG == "C")
// 				{
// 					inner += '   	<td>DESC</td>';
// 				}
// 				else
// 				{
// 					inner += '   	<td>WEB</td>';
// 				}
// 				inner += '   	<td>'+result[i].POS_NO+'</td>';
// 				inner += '   	<td>'+result[i].RECPT_NO+'</td>';
// 				inner += '   	<td>'+result[i].APPROVE_NO+'</td>';
// 				if(result[i].WEB_ACCEPT_FG == "0")
// 				{
// 					inner += '   	<td>현금</td>';
// 					inner += '   	<td></td>';
// 				}
// 				else if(result[i].CARD_AMT != "0" && result[i].CASH_AMT != "0")
// 				{
// 					inner += '   	<td>현금/카드</td>';
// 					inner += '   	<td>'+result[i].CARD_NM+'</td>';
// 				}
// 				else
// 				{
// 					inner += '   	<td>카드</td>';
// 					inner += '   	<td>'+result[i].CARD_NM+'</td>';
// 				}
// 				inner += '   	<td>'+result[i].CARD_NO+'</td>';
// 				inner += '   	<td></td>';
// 				inner += '   	<td></td>';
// 				inner += '   	<td>'+result[i].ENURI_AMT2+'</td>';
// 				inner += '   	<td>'+result[i].NET_SALE_AMT+'</td>';
// 				inner += '   	<td></td>';
// 				inner += '   	<td></td>';		
// 				inner += '</tr>';
// 			}
// 			$("#sale_target").html(inner);
// 		}
// 	});
	
// 	$.ajax({
// 		type : "POST", 
// 		url : "./getSideList",
// 		dataType : "text",
// 		data : 
// 		{
// 			store : $("#selBranch").val(),
// 			period : $("#selPeri").val(),
// 			cust_no : $("#searchResult").val()
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			var result = JSON.parse(data);
// 			var inner = "";
			
// 			if(result.GiftList.length > 0)
// 			{
// 				for(var i = 0; i < result.GiftList.length; i++)
// 				{
// 					$("#selGift1").append('<option value="'+result.GiftList[i].CODE_FG+'_'+result.GiftList[i].SUB_CODE+'_'+result.GiftList[i].GIVE_FG+'">'+result.GiftList[i].SHORT_CODE+'</option>');
// 					$(".selGift1_ul").append('<li>'+result.GiftList[i].SHORT_CODE+'</li>');
// 					$("#selGift2").append('<option value="'+result.GiftList[i].CODE_FG+'_'+result.GiftList[i].SUB_CODE+'_'+result.GiftList[i].GIVE_FG+'">'+result.GiftList[i].SHORT_CODE+'</option>');
// 					$(".selGift2_ul").append('<li>'+result.GiftList[i].SHORT_CODE+'</li>');
// 				}
// 			}
// 			else
// 			{
// 				$("#selGift1").append('<option value="">지급된 사은품이 없습니다.</option>');
// 				$(".selGift1_ul").append('<li>지급된 사은품이 없습니다.</li>');
// 				$("#selGift2").append('<option value="">지급된 사은품이 없습니다.</option>');
// 				$(".selGift2_ul").append('<li>지급된 사은품이 없습니다.</li>');
// 			}
// 		}
// 	});
//	getGiftList();
	
	//멤버스 포인트 조회
	
	AKmem_getPoint('basic'); //뮤자인에선 이거 안됨..
	
	//멤버스 포인트 조회
	
	getChild();
	getMemo();
}
function getMemo()
{
	$.ajax({
		type : "POST", 
		url : "/member/cust/getMemo",
		dataType : "text",
		async : false,
		data : 
		{
			cust_no : $("#searchResult").val(),
			order_by : '',
			sort_type : '',
			listSize : '999'
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
				inner +='</tr>';
				
			}
			$('.cust_memo_area').append(inner);
		}
		
	});
}
function showMemo()
{
	$('#memo_layer').fadeIn(200);
}
function getChildByCust()
{
	
	$.ajax({
		type : "POST", 
		url : "/member/cust/getChildInfo",
		dataType : "text",
		data : 
		{
			cust_no : $("#searchResult").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{

			//$('.cust_memo_area').empty();
			var result = JSON.parse(data);
			var inner ="";
			
			$("#child_no1").empty(); $(".child_no1_ul").empty();
			$("#child_no2").empty(); $(".child_no2_ul").empty();
			$("#child_no3").empty(); $(".child_no3_ul").empty();
			
			$("#child_no1").append('<option value="">선택</option>');
			$(".child_no1_ul").append('<li>선택</li>');
			$("#child_no2").append('<option value="">선택</option>');
			$(".child_no2_ul").append('<li>선택</li>');
			$("#child_no3").append('<option value="">선택</option>');
			$(".child_no3_ul").append('<li>선택</li>');
			$("#child_no1").append('<option value="'+$("#cust_no").val()+'">본인</option>');
			$(".child_no1_ul").append('<li>본인</li>');				
			for (var i = 0; i < result.length; i++) {
				
				$("#child_no1").append('<option value="'+result[i].CHILD_NO+'">'+result[i].CHILD_NM+'</option>');
				$(".child_no1_ul").append('<li>'+result[i].CHILD_NM+'</li>');
				$("#child_no2").append('<option value="'+result[i].CHILD_NO+'">'+result[i].CHILD_NM+'</option>');
				$(".child_no2_ul").append('<li>'+result[i].CHILD_NM+'</li>');
				$("#child_no3").append('<option value="'+result[i].CHILD_NO+'">'+result[i].CHILD_NM+'</option>');
				$(".child_no3_ul").append('<li>'+result[i].CHILD_NM+'</li>');
			}
		}
	});
}
function getPereByCust()
{
	$.ajax({
		type : "POST", 
		url : "./getPereByCust",
		dataType : "text",
		async:false,
		data : 
		{
			store : $('#selBranch').val(),
			cust_no : $("#searchResult").val(),
			isCancel : $("#isCancel_type").val(),
			period : $("#searchPere_period").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			for(var i = 0; i < result.length; i++)
			{
				if($("#isCancel_type").val() == "in" || $("#isCancel_type").val() == "part")
				{
					if(result[i].END_YN == "Y") //폐강강좌는 빨갛게!
					{
						inner += '<tr id="" class="redFont pereByCust tr_'+result[i].SALE_YMD+'_'+result[i].POS_NO+'_'+result[i].RECPT_NO+'">';
					}
					else
					{
						inner += '<tr id="" class="pereByCust tr_'+result[i].SALE_YMD+'_'+result[i].POS_NO+'_'+result[i].RECPT_NO+'">';
					}
				}
				else
				{
					
					if(result[i].END_YN == "Y") //폐강강좌는 빨갛게!
					{
						inner += '<tr id="" class="redFont pereByCust tr_'+result[i].SALE_YMD+'_'+result[i].CANCEL_POS_NO+'_'+result[i].CANCEL_RECPT_NO+'">';
					}
					else
					{
						inner += '<tr id="" class="pereByCust tr_'+result[i].SALE_YMD+'_'+result[i].CANCEL_POS_NO+'_'+result[i].CANCEL_RECPT_NO+'">';
					}
				}
				inner += '	<td>';
				if($("#isCancel_type").val() == "in" || $("#isCancel_type").val() == "part")
				{
					inner += '		<input type="radio" id="radio_'+i+'" name="radio_pelt" onclick="getPayment(\''+result[i].STORE+'\',\''+result[i].PERIOD+'\',\''+result[i].SUBJECT_CD+'\',\''+result[i].SALE_YMD+'\',\''+result[i].RECPT_NO+'\',\''+result[i].CUST_NO+'\',\''+result[i].POS_NO+'\')">';
				}
				else
				{
					inner += '		<input type="radio" id="radio_'+i+'" name="radio_pelt" onclick="getPayment(\''+result[i].STORE+'\',\''+result[i].PERIOD+'\',\''+result[i].SUBJECT_CD+'\',\''+result[i].CANCEL_YMD+'\',\''+result[i].CANCEL_RECPT_NO+'\',\''+result[i].CUST_NO+'\',\''+result[i].CANCEL_POS_NO+'\')">';
				}
				inner += '		<label for="radio_'+i+'"></label>';
				inner += '	</td>';
				inner += '	<td>'+cutDate(result[i].SALE_YMD)+'</td>';
				inner += '	<td>'+cutDate(nullChk(result[i].CANCEL_YMD))+'</td>';
				inner += '	<td>'+result[i].SUBJECT_CD+'</td>';
				inner += '	<td>'+result[i].SUBJECT_NM+'</td>';
				inner += '	<td>'+cutDate(result[i].START_YMD)+' ~ '+cutDate(result[i].END_YMD)+'</td>';
				inner += '	<td>'+cutYoil(result[i].DAY_FLAG)+'</td>';
				inner += '	<td>'+cutLectHour(result[i].LECT_HOUR)+'</td>';
				inner += '	<td>'+result[i].WEB_LECTURER_NM+'</td>';
				inner += '	<td>'+comma(nullChk(result[i].REGIS_FEE))+'/'+comma(nullChk(result[i].FOOD_AMT))+'</td>';
				
				if($("#isCancel_type").val() == "part" || $("#isCancel_type").val() == "part_cancel")
				{
					inner += '	<td></td>';
				}
				else
				{
					if(result[i].MAIN_CD == "2") //베이비
					{
						var tmp = result[i].CUST_NM;
						if(nullChk(result[i].CHILD1_NM) != '') { tmp += "/"+result[i].CHILD1_NM; }
						if(nullChk(result[i].CHILD2_NM) != '') { tmp += "/"+result[i].CHILD2_NM; }
						inner += '	<td>'+tmp+'</td>';
					}
					else if(result[i].MAIN_CD == "3") //키즈
					{
						var tmp = "";
						if(nullChk(result[i].CHILD1_NM) != '') { tmp += ""+result[i].CHILD1_NM; }
						if(nullChk(result[i].CHILD2_NM) != '') { tmp += "/"+result[i].CHILD2_NM; }
						inner += '	<td>'+tmp+'</td>';
					}
					else if(result[i].MAIN_CD == "4") //패밀리
					{
						var tmp = "";
						if(nullChk(result[i].CHILD1_NM) != '') { tmp += ""+result[i].CHILD1_NM; }
						else if(nullChk(result[i].CHILD2_NM) != '') { tmp += ""+result[i].CHILD2_NM; }
						else
						{
							tmp = result[i].CUST_NM;
						}
						inner += '	<td>'+tmp+'</td>';
					}
					else
					{
						inner += '	<td>'+result[i].CUST_NM+'</td>';
					}
				}
				inner += '</tr>';
			}
			$("#pere_target").html(inner);
		}
	});	
}
function getPayment(store, period, subject_cd, sale_ymd, recpt_no, cust_no, pos_no)
{
	$.ajax({
		type : "POST", 
		url : "./getPayment",
		dataType : "text",
		async : false,
		data : 
		{
			store : store,
			period : period,
			subject_cd : subject_cd,
			sale_ymd : sale_ymd,
			recpt_no : recpt_no,
			cust_no : cust_no,
			pos_no : pos_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			for(var i = 0; i < result.length; i++)
			{
				inner += '<tr>';
				inner += '	<td class="td-chk">';
				inner += '		<input type="checkbox" id="pere_idx'+i+'" name="pere_idx" value="'+encodeURI(JSON.stringify(result[i]))+'"><label for="pere_idx'+i+'"></label>';
				inner += '	</td>';
				inner += '	<td>'+result[i].POS_NO+'</td>';
				inner += '	<td>'+result[i].RECPT_NO+'</td>';
				inner += '	<td>'+nullChk(result[i].APPROVE_NO)+'</td>';
				var pay_type = "";
				if(result[i].CARD_AMT != '0') { pay_type += "/"+result[i].CARD_NM; }
				if(result[i].CASH_AMT != '0') { pay_type += "/현금"; }
				if(result[i].POINT_AMT != '0') { pay_type += "/마일리지"; }
				if(result[i].MY_FACE_AMT != '0' || result[i].YOUR_FACE_AMT != '0') { pay_type += "/상품권"; }
				pay_type = pay_type.substring(1, pay_type.length);
				inner += '	<td>'+pay_type+'</td>';
				inner += '	<td>'+comma(result[i].POINT_AMT)+'</td>';
				inner += '	<td>'+comma(result[i].CASH_AMT)+'</td>';
				inner += '	<td>'+comma(result[i].MY_FACE_AMT)+'</td>';
				inner += '	<td>'+comma(result[i].YOUR_FACE_AMT)+'</td>';
				inner += '	<td>'+comma(result[i].CARD_AMT)+'</td>';
// 				var enuri_nm = "";
// 				if(nullChk(result[i].ENURI_NM1) != '') { enuri_nm += result[i].ENURI_NM1; }
// 				if(nullChk(result[i].ENURI_NM2) != '') { enuri_nm += "/"+result[i].ENURI_NM2; }
// 				inner += '	<td>'+enuri_nm+'</td>';
				inner += '	<td>'+comma(result[i].ENURI_AMT)+'</td>';
				if(result[i].NET_SALE_AMT == result[i].REGIS_FEE)
				{
					var tmp = Number(result[i].NET_SALE_AMT)+Number(result[i].FOOD_FEE)
					inner += '	<td>'+comma(tmp)+'</td>';
				}
				else
				{
					inner += '	<td>'+comma(result[i].NET_SALE_AMT)+'</td>';
				}
				inner += '	<td>'+nullChk(result[i].GIFT_LIST).replace(/,/gi, "/")+'</td>';
				inner += '	<td>'+nullChk(result[i].RETURN_GIFT_LIST).replace(/,/gi, "/")+'</td>';
				inner += '</tr>';
				$(".pereByCust").css("background-color", "white");
				$(".tr_"+result[i].SALE_YMD+"_"+result[i].POS_NO+"_"+result[i].RECPT_NO).css("background-color", "#edf1f6");
			}
			$("#sale_target").html(inner);
		}
	});	
}
function getChild()
{
	$.ajax({
		type : "POST", 
		url : "./getChildByCust",
		dataType : "text",
		data : 
		{
			cust_no : $("#searchResult").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			if(result.length > 0)
			{
				var gender="";
				for(var i = 0; i < result.length; i++)
				{
					(trim(result[i].GENDER)=="M") ? gender = "남" :gender = "여";
					
					inner += '<tr class="child01">';
					//inner += '	<td>'+result[i].CHILD_NO+'</td>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '  <td>'+result[i].CHILD_NM+'</td>';
					inner += '  <td>'+gender+'</td>';
					inner += '  <td>'+cutDate(result[i].BIRTH)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="4"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#child_target").html(inner);
		}
	});	
}
var child_cnt = 1;
function addChild()
{
	var class_cnt = $('.child01').length;
	if (class_cnt>=3) {
		alert('자녀는 3명만 등록할 수 있습니다.');
		return;
	}
	
	var inner = "";
	inner += '<tr class="child01">';
	inner += '	<td></td>';
	inner += '  <td><input type="text" id="child_nm_'+child_cnt+'" name="child_nm" ></td>';
	inner += '  <td>';
	inner +='		<div class="select-box">';
	inner +='			<div class="selectedOption child_gender_'+child_cnt+'">남</div>';
	inner +='			<ul class="select-ul child_gender_'+child_cnt+'_ul" style="display: none;">';
	inner +='				<li>남</li>';
	inner +='				<li>여</li>';
	inner +='			</ul>';
	inner +='			<select de-data="남" id="child_gender_'+child_cnt+'" name="child_gender" style="display: none;">';
	inner +='				<option value="M">남</option>';
	inner +='				<option value="F">여</option>';
	inner +='			</select>';
	inner +='		</div>';
	inner +='	</td>';
	inner += '  <td><input type="text" id="child_birth_'+child_cnt+'" name="child_birth" class="date-i" style="width:110px;"></td>';
	inner += '</tr>';
	$("#child_target").prepend(inner);
	dateInit();
	child_cnt ++;
}
function addChildProc()
{
	var isEmpty = false;
	var cust_no = $("#searchResult").val();
	if (cust_no=="") {
		alert("고객을 선택해주세요.");
		return;
	}
	
	
	var nm = "";
	$("[name='child_nm']").each(function() 
	{
		if($(this).val() != "")
		{
			nm += $(this).val()+"|";
		}
		else
		{
			alert("자녀 이름을 입력해주세요.");
			$(this).focus();
			isEmpty = true;
			return false;
		}
	});
	
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
			alert("생년월일을 입력해주세요.");
			$(this).focus();
			isEmpty = true;
			return false;
		}
	});
	
	if(isEmpty)
	{
		return false;
	}
	
	if(nm != '' && birth != '')
	{
		$.ajax({
			type : "POST", 
			url : "./saveChild",
			dataType : "text",
			data : 
			{
				child_nm : nm,
				child_gender : gender,
				child_birth : birth,
				cust_no : $("#searchResult").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	    			getChild();
	    		}
	    		else
	    		{
		    		alert(result.msg);
	    		}
			}
		});
	}
	
	
}
function getLectSearch(val)
{
	//대기자에서 넘어온거랑 손수검색한거 분기
	var searchVal = "";
	var searchStore = "";
	var searchPeriod = "";
	var searchSubject_cd = "";
	
	if(val == "search")
	{
		if($("#lect_searchVal").val() == "")
		{
			alert("강좌코드나 강좌명을 입력하세요.");
			$("#lect_searchVal").focus();
			return;
		}
		searchVal = $("#lect_searchVal").val();
		searchStore = $("#selBranch").val();
		searchPeriod = $("#selPeri").val();
	}
	else
	{
		searchStore = '${store}';
		searchPeriod = '${period}';
		searchSubject_cd = '${subject_cd}';
	}
	$.ajax({
		type : "POST", 
		url : "/common/getLectSearch",
		dataType : "text",
		async:false,
		data : 
		{
			searchVal : searchVal,
			store : searchStore,
			period : searchPeriod,
			subject_cd : searchSubject_cd,
			order_by : lect_order_by,
			sort_type : lect_sort_type
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			$("#tb1_target").html("");
			var inner = "";
			if(result.length > 1)
			{
				for(var i = 0; i < result.length; i++)
				{
					if(result[i].END_YN == "Y") //폐강강좌는 빨갛게!
					{
						inner += '<tr ondblclick="selLect(\''+encodeURI(JSON.stringify(result[i]))+'\')" class="redFont lect_'+result[i].SUBJECT_CD+'">';
					}
					else
					{
						inner += '<tr ondblclick="selLect(\''+encodeURI(JSON.stringify(result[i]))+'\')" class="lect_'+result[i].SUBJECT_CD+'">';
					}
					inner += '	<td>'+result[i].SUBJECT_CD+'</td>';
					inner += '	<td>'+result[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+nullChk(result[i].CAPACITY_NO)+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result[i].REGIS_NO)) + Number(nullChkZero(result[i].WEB_REGIS_NO)))+'</td>';
					inner += '	<td>'+comma(Number(nullChkZero(result[i].WAIT_CNT)))+'</td>';
					if(nullChk(result[i].START_YMD) != "" && nullChk(result[i].END_YMD) != "")
					{
						inner += '	<td>'+cutDate(result[i].START_YMD).substring(5)+' ~ '+cutDate(result[i].END_YMD).substring(5)+'</td>';
					}
					else
					{
						inner += '	<td></td>';
					}
					if(nullChk(result[i].LECT_HOUR) != "")
					{
						inner += '	<td>'+result[i].LECT_HOUR.substring(0,2)+':'+result[i].LECT_HOUR.substring(2,4)+' ~ '+result[i].LECT_HOUR.substring(4,6)+':'+result[i].LECT_HOUR.substring(6,8)+'</td>';
					}
					else
					{
						inner += '	<td></td>';
					}
					if(nullChk(result[i].DAY_FLAG) != "")
					{
						inner += '	<td>'+cutYoil(result[i].DAY_FLAG)+'</td>';
					}
					else
					{
						inner += '	<td></td>';
					}
					inner += '</tr>';
				}
				$("#tb1_target").html(inner);
				$("#lect_search_layer").fadeIn(200);
			}
			else if(result.length == 1)
			{
				selLect(encodeURI(JSON.stringify(result[0])));
// 				goMoveLect();
			}
			else
			{
				if(searchStore != '00')
				{
					alert("검색결과가 없습니다.");
				}
			}
		}
	});
	for(var i = 0; i < subject_arr.split("|").length-1; i++)
	{
// 		$(".lect_"+subject_arr.split("|")[i]).hide();
	}
}
function selLect(ret)
{
	$("#search_layer").fadeOut(200);
	$("#lect_search_layer").fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
	if(result.MAIN_CD == "2") //베이비
	{
		$("#target_child1").show();
		$("#target_child2").show();
		$("#target_child3").show();
	}
	else if(result.MAIN_CD == "3") //키즈
	{
		$("#target_child1").show();
		if(result.IS_TWO == "Y")
		{
			$("#target_child2").show();
			$("#target_child3").hide();
		}
		else
		{
			$("#target_child2").hide();
			$("#target_child3").hide();
		}
	}
	else
	{
		$("#target_child1").show();
		$("#target_child2").hide();
		$("#target_child3").hide();
	}
	$("#child_no1").val('');
	$("#child_no2").val('');
	$("#child_no3").val('');
	$(".child_no1").html('선택');
	$(".child_no2").html('선택');
	$(".child_no3").html('선택');
	
	$("#sel_subject_nm").val(result.SUBJECT_NM);
	$("#sel_subject_cd").val(result.SUBJECT_CD);
	$("#sel_web_lecturer_nm").val(result.WEB_LECTURER_NM);
	if(result.END_YN == 'Y')
	{
		$("#sel_end_yn").val('폐강');
		$("#sel_end_yn").attr('style', 'color:red !important');
	}
	else
	{
		$("#sel_end_yn").val('개강');
		$("#sel_end_yn").attr('style', '');
	}
	$("#sel_capacity_no").val(result.CAPACITY_NO);
	$("#sel_regis_no").val(Number(nullChkZero(result.REGIS_NO)) + Number(nullChkZero(result.WEB_REGIS_NO)));
	$("#sel_wait_cnt").val(nullChkZero(result.WAIT_CNT));
	$("#sel_day_flag").val(cutYoil(result.DAY_FLAG));
	$("#sel_lect_hour").val(cutLectHour(result.LECT_HOUR));
	$("#sel_ymd").val(cutDateNotYear(result.START_YMD) +"~"+cutDateNotYear(result.END_YMD));
	$("#sel_regis_fee").val(comma(result.REGIS_FEE));
	if(result.FOOD_YN == 'Y')
	{
		$("#sel_food_amt").val(comma(result.FOOD_AMT));
	}
	else
	{
		$("#sel_food_amt").val("0");
	}
	
	if(result.FOOD_YN == 'Y')
	{
		$("#sel_food_amt").val(comma(result.FOOD_AMT));
	}
	else if(result.FOOD_YN == 'R')
	{
		$("#sel_food_amt").val("별도");
	}
	else
	{
		$("#sel_food_amt").val("0");
	}
	
	var tmp = $("#sel_food_amt").val();
	if(tmp == "별도")
	{
		tmp = "0";
	}
	tmp = Number(tmp.replace(/,/gi, ""));
	var total_pay = Number($("#sel_regis_fee").val().replace(/,/gi, "")) + tmp;
	$("#sel_total_pay").val(comma(total_pay));
	
// 	if(subject_arr.indexOf(trim(result.SUBJECT_CD)) == -1)
// 	{
// 		subject_arr_imsi = trim(result.SUBJECT_CD)+"|";
// 	}
}
function selMainCd(code)
{
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		async:false,
		data : 
		{
			maincd : code,
			selBranch : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner ="";
			if(result.length > 0)
			{
				inner="";
				for (var i = 0; i < result.length; i++) 
				{
					inner += '<li onclick="selSectCd(\''+result[i].MAIN_CD+'\', \''+result[i].SECT_CD+'\')">'+result[i].SECT_NM+'</li>';
				}
			}
			else
			{
				
			}
			$(".sect_ul").html(inner);
		}
	});	
	for(var i = 0; i < subject_arr.split("|").length-1; i++)
	{
// 		$(".lect_"+subject_arr.split("|")[i]).hide();
	}
}
function selSectCd(maincd, sectcd)
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeltBySect",
		dataType : "text",
		async:false,
		data : 
		{
			maincd : maincd,
			sectcd : sectcd,
			store : $("#selBranch").val(),
			period : $("#selPeri").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			var inner = "";
			if(result.length > 0)
			{
				for(var i = 0; i< result.length; i++)
				{
					inner += '<li class="lect_'+result[i].SUBJECT_CD+'" ondblclick="selLect(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
					if(result[i].END_YN == "Y") //폐강강좌는 빨갛게!
					{
						inner += '	<div class="tit" style="color:red;">'+result[i].SUBJECT_NM+'</div>';
						inner += '	<div class="date" style="color:red;">'+cutYoil(result[i].DAY_FLAG)+' '+cutLectHour(result[i].LECT_HOUR)+'/'+result[i].WEB_LECTURER_NM+'</div>';
					}
					else
					{
						inner += '	<div class="tit">'+result[i].SUBJECT_NM+'</div>';
						inner += '	<div class="date">'+cutYoil(result[i].DAY_FLAG)+' '+cutLectHour(result[i].LECT_HOUR)+'/'+result[i].WEB_LECTURER_NM+'</div>';
					}
					inner += '</li>';
				}
			}
			else
			{
				inner += '<li>';
				inner += '	검색결과가 없습니다.';
				inner += '</li>';
			}
			
			$(".pelt_ul").html(inner);
			
		}
	});	
	for(var i = 0; i < subject_arr.split("|").length-1; i++)
	{
// 		$(".lect_"+subject_arr.split("|")[i]).hide();
	}
}
// function selPeltCd(ret)
// {
// 	var result = JSON.parse(decodeURI(ret));	
// 	var inner = "";
// 	if(!document.getElementById("tr_"+trim(result.SUBJECT_CD)))
// 	{
// 		inner += '<tr id="tr_'+trim(result.SUBJECT_CD)+'">';
// 		inner += '	<td class="td-chk">';
// 		inner += '		<input type="checkbox" id="pelt_'+trim(result.SUBJECT_CD)+'" name="chk_pelt_list"><label for="pelt_'+trim(result.SUBJECT_CD)+'"></label>';
// 		inner += '	</td>';
// 		inner += '	<td>'+result.SUBJECT_NM+'</td>';
// 		inner += '	<td>'+result.WEB_LECTURER_NM+'</td>';
// 		inner += '	<td>'+cutYoil(result.DAY_FLAG)+'</td>';
// 		inner += '	<td>'+cutLectHour(result.LECT_HOUR)+'</td>';
// 		inner += '</tr>';
		
// 		$(".selLectTable").append(inner);
// 		chk_pelt_init();
// 	}
// 	else
// 	{
// 		alert("이미 등록되었습니다.");
// 	}
// }
// function peltTrAct(act)
// {
// 	$('#search_layer').fadeOut(200);	
// 	$("input:checkbox[name='chk_pelt_list']").each(function(){
// 	    if($(this).is(":checked"))
//     	{
//     		var subCd = $(this).attr("id").replace("pelt_", "");
// 			if(act == 'del')
// 			{
// 				$("#tr_"+subCd).remove();
// 			}
// 			else
// 			{
// 				if(subject_arr.indexOf(subCd) == -1)
// 				{
// 					subject_arr += subCd+"|";
// 					goMoveLect();
// 				}
// 			}
//     	}
// 	});
// }


// var subject_arr_imsi = "";
var part_subject_cd = "";
function goMoveLect(act)
{
	if($("#cust_no").val() == "")
	{
		alert("회원검색을 먼저 해주세요.");
		return;
	}
	var rtn = true;
	$('#cancel_layer').fadeOut(200);
	if(act != 'remove')
	{
		//이미 강좌 등록이 되어있는지 체크
		
		var tmpCust = "";
		if(trim($("#child_no1").val()).length == 9)
		{
			tmpCust = "0";
		}
		else
		{
			tmpCust = $("#child_no1").val();
		}
		if(act != "part")
		{
			$.ajax({
				type : "POST", 
				url : "/common/isInPeltByCust",
				dataType : "text",
				async:false,
				data : 
				{
					store : $("#selBranch").val(),
					period : $("#selPeri").val(),
					subject_cd : $("#sel_subject_cd").val(),
					cust_no : $("#cust_no").val(),
					child_no1 : tmpCust
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					var result_cnt = JSON.parse(data);
					if(Number(result_cnt.CNT) > 0 )
					{
						alert("이미 수강신청된 강좌입니다");
						rtn = false;
					}
				}
			});
			$.ajax({
				type : "POST", 
				url : "/common/isFullPeltByCust",
				dataType : "text",
				async:false,
				data : 
				{
					store : $("#selBranch").val(),
					period : $("#selPeri").val(),
					subject_cd : $("#sel_subject_cd").val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					var result_cnt = JSON.parse(data);
					if(Number(result_cnt.POSSIBLE_NO) <= 0 )
					{
						alert("정원이 찬 강좌입니다.");
						rtn = false;
					}
				}
			});
		}
		else if(act == 'part')
		{
			$.ajax({
				type : "POST", 
				url : "/common/isPartPayByCust",
				dataType : "text",
				async:false,
				data : 
				{
					store : $("#selBranch").val(),
					period : $("#selPeri").val(),
					subject_cd : $("#sel_subject_cd").val(),
					cust_no : $("#cust_no").val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					var result_cnt = JSON.parse(data);
					if(Number(result_cnt.CNT) > 0 )
					{
						//2021-08-11 제거
// 						alert("이미 부분입금 결제완료된 강좌입니다");
// 						rtn = false;
					}
				}
			});
		}
	}
	if(rtn)
	{
		if(act == "remove")
		{
			
		}
		else
		{
			subject_arr += $("#sel_subject_cd").val()+"|";
		}
		subject_nm_arr = "";
		regis_fee_arr = "";
		food_amt_arr = "";
		total_pay = 0;
		total_regis_fee = 0;
		total_food_amt = 0;
		
		$.ajax({
			type : "POST", 
			url : "/common/getPeltBySubjectCd",
			dataType : "text",
			async:false,
			data : 
			{
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				subject_cd : subject_arr
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				var inner = "";
				if(result.length > 0)
				{
					if(act != "part" && act != "remove")
					{
						if($("#child_no1").val() == "")
						{
							alert("수강자를 선택해주세요.");
							return;
						}
						if($("#child_no1").val() == $("#child_no2").val() && $("#child_no1").val() != "" && $("#child_no2").val() != "")
						{
							alert("수강자가 중복됩니다.");
							return;
						}
						if($("#child_no1").val() == $("#child_no3").val() && $("#child_no1").val() != "" && $("#child_no3").val() != "")
						{
							alert("수강자가 중복됩니다.");
							return;
						}
						if($("#child_no2").val() == $("#child_no3").val() && $("#child_no2").val() != "" && $("#child_no3").val() != "")
						{
							alert("수강자가 중복됩니다.");
							return;
						}
						for(var i = 0; i< result.length; i++) 
						{
							if(result[i].MAIN_CD == '1' && $("#child_no1").val().length <= 3 && result[i].SUBJECT_CD == $("#sel_subject_cd").val()) //성인
							{
								alert("성인강좌에 자녀를 선택할 수 없습니다.");
								return;
							}
							if(result[i].MAIN_CD == '2' && $("#child_no2").val() == "" && result[i].SUBJECT_CD == $("#sel_subject_cd").val()) //베이비
							{
								alert("자녀를 선택해주세요.");
								return;
							}
							if(result[i].MAIN_CD == '3' && result[i].IS_TWO != 'Y' && result[i].SUBJECT_CD == $("#sel_subject_cd").val()) 
							{
								if($("#child_no1").val().length > 3)
								{
									alert("키즈강좌의 수강자가 성인일 수 없습니다.");
									return;
								}
							}
							if(result[i].MAIN_CD == '3' && result[i].IS_TWO == 'Y' && result[i].SUBJECT_CD == $("#sel_subject_cd").val()) 
							{
								if($("#child_no1").val().length < 3 || $("#child_no2").val().length > 3)
								{
									alert("성인-자녀 순으로 등록해주세요.");
									return;
								}
								if($("#child_no2").val() == "")
								{
									alert("자녀를 선택해주세요.");
									return;
								}
							}
						}
					}
					
					
					subject_arr = "";
					child1_no.remove($("#sel_subject_cd").val()); //자식 초기화
					child1_nm.remove($("#sel_subject_cd").val()); //자식 초기화
					child2_no.remove($("#sel_subject_cd").val()); //자식 초기화
					child2_nm.remove($("#sel_subject_cd").val()); //자식 초기화
					child3_no.remove($("#sel_subject_cd").val()); //자식 초기화
					child3_nm.remove($("#sel_subject_cd").val()); //자식 초기화
					encd1_no.remove($("#sel_subject_cd").val()); //할인 초기화
					encd2_no.remove($("#sel_subject_cd").val()); //할인 초기화
					encd1_amt.remove($("#sel_subject_cd").val()); //할인 초기화
					encd2_amt.remove($("#sel_subject_cd").val()); //할인 초기화
					
					part_regis_fee.remove($("#sel_subject_cd").val());
					part_food_amt.remove($("#sel_subject_cd").val());
					part_lect_cnt.remove($("#sel_subject_cd").val());
					for(var i = 0; i< result.length; i++)
					{
						//자녀정보를 배열에 넣음
						if($("#child_no1").val() != "" && $("#sel_subject_cd").val() == result[i].SUBJECT_CD) //새로 쓰는거기때문에 자녀가 강좌에도 다 들어가버린다.
						{
							child1_no.put(result[i].SUBJECT_CD, $("#child_no1").val());
							child1_nm.put(result[i].SUBJECT_CD, $("select[name='child_no1'] option[value='"+$("#child_no1").val()+"']").html());
						}
						if($("#child_no2").val() != "" && $("#sel_subject_cd").val() == result[i].SUBJECT_CD)
						{
							child2_no.put(result[i].SUBJECT_CD, $("#child_no2").val());
							child2_nm.put(result[i].SUBJECT_CD, $("select[name='child_no2'] option[value='"+$("#child_no2").val()+"']").html());
						}
						if($("#child_no3").val() != "" && $("#sel_subject_cd").val() == result[i].SUBJECT_CD)
						{
							child3_no.put(result[i].SUBJECT_CD, $("#child_no3").val());
							child3_nm.put(result[i].SUBJECT_CD, $("select[name='child_no3'] option[value='"+$("#child_no3").val()+"']").html());
						}
						//자녀정보를 배열에 넣음
						
						var this_lect_cnt = 0;
						var this_regis_fee = 0;
						var this_food_amt = 0;
						if(part_subject_cd == result[i].SUBJECT_CD)
						{
							this_lect_cnt = $("#part_lect_cnt").val();
							this_regis_fee = $("#part_regis_fee").val();
							this_food_amt = $("#part_food_amt").val();
							part_regis_fee.put(result[i].SUBJECT_CD, $("#part_regis_fee").val());
							part_food_amt.put(result[i].SUBJECT_CD, $("#part_food_amt").val());
							part_lect_cnt.put(result[i].SUBJECT_CD, $("#part_lect_cnt").val());
						}
						else if(part_subject_arr.indexOf(result[i].SUBJECT_CD) > -1)
						{
							this_lect_cnt = part_lect_cnt.get(result[i].SUBJECT_CD);
							this_regis_fee = part_regis_fee.get(result[i].SUBJECT_CD);
							this_food_amt = part_food_amt.get(result[i].SUBJECT_CD);
						}
						else
						{
							this_lect_cnt = result[i].LECT_CNT;
							this_regis_fee = result[i].REGIS_FEE;
							this_food_amt = result[i].FOOD_AMT;
						}
						subject_arr += trim(result[i].SUBJECT_CD)+"|";
						if(act == "part")
						{
							if(part_subject_arr.indexOf($("#sel_subject_cd").val()) == -1)
							{
								part_subject_arr += trim($("#sel_subject_cd").val())+"|";
							}
							else
							{
								part_subject_arr += "undefined"+"|";
							}
						}
						inner += '<tr id="lect_area'+i+'">';
						inner += '	<td class="subject_arr">'+result[i].SUBJECT_CD+'</td>';
						inner += '	<td>'+result[i].SUBJECT_NM+'</td>';
						inner += '  <td>'+this_lect_cnt+'</td>';
						if(result.END_YN == 'Y')
						{
							inner += '  <td>폐강</td>';
						}
						else
						{
							inner += '  <td>개강</td>';
						}
						inner += '  <td>'+comma(this_regis_fee)+'</td>';
						if(result[i].FOOD_YN == 'Y')
						{
							inner += '  <td>'+comma(this_food_amt)+'</td>';
						}
						else
						{
							inner += '  <td>0</td>';
						}
						inner += '  <td class="rem-td">';
						if(nullChk(child1_nm.get(result[i].SUBJECT_CD)) != "")
						{
							inner += child1_nm.get(result[i].SUBJECT_CD);
						}
						if(nullChk(child2_nm.get(result[i].SUBJECT_CD)) != "")
						{
							if(nullChk(child1_nm.get(result[i].SUBJECT_CD)) != "")
							{
								inner += ",";
							}
							inner += child2_nm.get(result[i].SUBJECT_CD);
						}
						if(nullChk(child3_nm.get(result[i].SUBJECT_CD)) != "")
						{
							if(nullChk(child1_nm.get(result[i].SUBJECT_CD)) != "" || nullChk(child2_nm.get(result[i].SUBJECT_CD)) != "")
							{
								inner += ",";
							}
							inner += child3_nm.get(result[i].SUBJECT_CD);
						}
						inner += '  </td>';
						inner += '  <td>';
						inner += '  	<span class="btn s-btn btn03 sale-btn" onclick="getEncdList(\''+result[i].SUBJECT_CD+'\')" >할인</span>';
						inner += '  	<div class="btn-row"><i class="material-icons remove" onclick="remove_lect('+i+', \''+result[i].SUBJECT_CD+'\')">remove_circle_outline</i></div>';
						inner += '  </td>';
						
						inner += '</tr>';
						
						//가격 업데이트
						var regis_fee = Number(this_regis_fee);
						var food_amt = 0;
						if(result[i].FOOD_YN == 'Y')
						{
							food_amt = Number(this_food_amt);
						}
						total_pay += food_amt + regis_fee;
						
						regis_fee_arr += regis_fee+"|";
						total_regis_fee += regis_fee;
						
						food_amt_arr += food_amt+"|";
						total_food_amt += food_amt;
						if(result[i].MAIN_CD == '2') //베이비
						{
							if(nullChk(child2_nm.get(result[i].SUBJECT_CD)) != "" && nullChk(child3_nm.get(result[i].SUBJECT_CD)) != "")
							{
								total_pay += (food_amt + regis_fee) / 2;
								total_regis_fee += regis_fee / 2;
								total_food_amt += food_amt / 2;
							}
						}
// 						if(result[i].MAIN_CD == '3' && result[i].IS_TWO) //키즈
// 						{
// 							if(nullChk(child1_nm.get(result[i].SUBJECT_CD)) != "" && nullChk(child2_nm.get(result[i].SUBJECT_CD)) != "")
// 							{
// 								total_pay += food_amt + regis_fee;
// 								total_regis_fee += regis_fee;
// 								total_food_amt += food_amt;
// 							}
// 						}
						
						subject_nm_arr += result[i].SUBJECT_NM+"|";
// 						selEnuri();
						//가격 업데이트
						
						if(act != "part" && act != "remove")
						{
							getGiftInfo(subject_arr);
						}
						
						
					}
				}
				else
				{
					inner += '<tr><td colspan="7"><div class="no-data">선택된 강좌가 없습니다.</div></td></tr>';
				}
				$("#tb2_target").html(inner);
				$("#input_lect_cnt").html("현재 등록된 강좌수 : "+(subject_arr.split("|").length-1));
				setFinalPay();
			}
		});
	}
	for(var i = 0; i < subject_arr.split("|").length-1; i++)
	{
		
	}
}
function chk_one(obj)
{
	var chkCnt = 0;
	$(".encd1_chk").each(function(){
	    if($(this).is(":checked"))
    	{
	    	chkCnt++;
    	}
	});
	
	if(chkCnt > 1)
	{
		alert("즉시할인권은 중복사용이 불가합니다.");
	}
	
	
 	if($("#"+obj).is(":checked"))
 	{
 		$(".encd1_chk").prop("checked", false);
 		$("#"+obj).prop("checked", true);
 	}
 	else
 	{
 		$(".encd1_chk").prop("checked", false);
 	}
}
var chk_id = ""; //다시띄울때 보여주기위해 저장해놓자.
function getEncdList(subject_cd)
{
	var grade_nm = $('#user_class').val();
	var grade ="";
	
	if (grade_nm=='E-Diamond') { grade='109' }
	else if(grade_nm=='Diamond') { grade='110' }
	else if(grade_nm=='Platinum+') { grade='120' }
	else if(grade_nm=='Platinum') { grade='111' }
	else if(grade_nm=='Crystal') { grade='112' }
	else if(grade_nm=='Gold') { grade='114' }
	else if(grade_nm=='Silver') { grade='115' }
	else if(grade_nm=='Bronze') { grade='116' }
	else if(grade_nm=='Ace') { grade='117' }
	else if(grade_nm=='Friends') { grade='118' }
	else {grade='119' }
	
	
	
	$.ajax({
		type : "POST", 
		url : "/common/getEncdList",
		dataType : "text",
		async:false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cust_no : $("#cust_no").val(),
			subject_cd : subject_cd,
			grade : grade
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			console.log(data);
			if(result.isSuc != "success")
    		{
    			alert(result.msg);
    		}
    		else
    		{
				if(result.list.length > 0)
				{
					$("#encd_layer").fadeIn(200);
					$("#target_encd1").html('');
					$("#target_encd2").html('');
					for(var i = 0; i < result.list.length; i++)
					{
						var inner = "";
						inner += '<div class="overcd-box">';
						inner += '<div class="overcd-chk">';
						if(result.list[i].DUPL_YN == "N")
						{
							inner += '	<input type="checkbox" class="encd1_chk" onclick="chk_one(this.id)" id="enuri_cd_'+subject_cd+'_'+result.list[i].ENURI_CD+'_'+result.list[i].DUPL_YN+'_'+result.list[i].ENURI_FG+'_'+result.list[i].ENURI+'_'+result.list[i].LIMITED_AMT+'_'+result.list[i].LIMITED_CNT+'" name="enuri_cd_'+subject_cd+'"><label for="enuri_cd_'+subject_cd+'_'+result.list[i].ENURI_CD+'_'+result.list[i].DUPL_YN+'_'+result.list[i].ENURI_FG+'_'+result.list[i].ENURI+'_'+result.list[i].LIMITED_AMT+'_'+result.list[i].LIMITED_CNT+'"></label>';
						}
						else
						{
							inner += '	<input type="checkbox" id="enuri_cd_'+subject_cd+'_'+result.list[i].ENURI_CD+'_'+result.list[i].DUPL_YN+'_'+result.list[i].ENURI_FG+'_'+result.list[i].ENURI+'_'+result.list[i].LIMITED_AMT+'_'+result.list[i].LIMITED_CNT+'" name="enuri_cd_'+subject_cd+'"><label for="enuri_cd_'+subject_cd+'_'+result.list[i].ENURI_CD+'_'+result.list[i].DUPL_YN+'_'+result.list[i].ENURI_FG+'_'+result.list[i].ENURI+'_'+result.list[i].LIMITED_AMT+'_'+result.list[i].LIMITED_CNT+'"></label>';
						}
						inner += '</div>';
						inner += '<p>할인코드명 : '+result.list[i].ENURI_NM+'</p>';
						if(result.list[i].ENURI_FG == '1')
						{
							inner += '<p>할인구분 : 정률</p>';
							inner += '<p>할인금액 : '+result.list[i].ENURI+'%</p>';
						}
						else
						{
							inner += '<p>할인구분 : 정액</p>';
							inner += '<p>할인금액 : '+comma(result.list[i].ENURI)+'</p>';
						}
						inner += '</div>';
						if(result.list[i].DUPL_YN == "N")
						{
							$("#target_encd1").append(inner);
						}
						else
						{
							$("#target_encd2").append(inner);
						}
					}
					var chk_id_arr = chk_id.split("|");
					for(var i = 0; i < chk_id_arr.length-1; i++)
					{
						if(document.getElementById(chk_id_arr[i]))
						{
							$("input:checkbox[id='"+chk_id_arr[i]+"']").attr("checked", true);
						}
					}
				}
				else
				{
					alert("가능한 할인코드가 없습니다.");
				}
				var inner = '<a class="btn btn02 ok-btn" onclick="javascript:encdSubmit(\''+subject_cd+'\');">확인</a>';
				$("#target_encd3").html(inner);
    		}
		}
	});
}
function encdSubmit(subject_cd)
{
	var chk_id_arr = chk_id.split("|");
	for(var i = 0; i < chk_id_arr.length-1; i++) //해당강좌 체크목록 지우기
	{
		if(chk_id_arr[i].indexOf(subject_cd) > -1)
		{
			chk_id = chk_id.replace(chk_id_arr[i], "");
		}
	}
	var chkList = "";
	$("input:checkbox[name='enuri_cd_"+subject_cd+"']").each(function(){
	    if($(this).is(":checked"))
    	{
	    	chk_id += $(this).attr("id")+"|";
    		chkList += $(this).attr("id").replace("enuri_cd_", "")+"|";
    	}
	});
	encd1_no.remove(subject_cd); //할인 초기화
	encd2_no.remove(subject_cd); //할인 초기화
	encd1_amt.remove(subject_cd); //할인 초기화
	encd2_amt.remove(subject_cd); //할인 초기화
	var chkArr = chkList.split("|");
	if(chkArr.length-1 > 2)
	{
		alert("할인코드는 최대 두개까지 선택 가능합니다.");
		return;
	}
	var dupl_n = 0;
	var enuri_fg_1 = 0;
	var enuri_fg_2 = 0;
	
	encd_use_limit = new HashMap();
	var subject_arr_split = subject_arr.split('|');
	for(var i = 0; i < subject_arr_split.length-1; i++)
	{
		var enuri_cd = encd1_no.get(subject_arr_split[i]);
		encd_use_limit.put(enuri_cd, nullChkZero(encd_use_limit.get(enuri_cd)) +1);
		enuri_cd = encd2_no.get(subject_arr_split[i]);
		encd_use_limit.put(enuri_cd, nullChkZero(encd_use_limit.get(enuri_cd)) +1);
	}
	
	for(var i = 0; i < chkArr.length-1; i++)
	{
		var chkDetail = chkArr[i].split("_");
		var dupl_yn = chkDetail[2];
		var enuri_fg = chkDetail[3];
		encd_limit.put(chkDetail[1], chkDetail[6]);
		if(encd_limit.get(chkDetail[1]) < nullChkZero(encd_use_limit.get(chkDetail[1])) +1)
		{
			alert("해당 할인권의 제한횟수를 초과하였습니다.\n다른 할인권을 선택해주세요.");
			return;
		}
		if(dupl_yn == "N")
		{
			dupl_n ++;
		}
		if(enuri_fg == "1")
		{
			enuri_fg_1 ++;
		}
		else
		{
			enuri_fg_2 ++;
		}
	}
	if(dupl_n > 1)
	{
		alert("중복이 불가한 할인코드가 있습니다.");
		return;
	}
	else
	{
		var tmp_subject_arr = subject_arr.split("|");
		var tmp_regis_fee_arr = regis_fee_arr.split("|");
		var encd_regis_fee_arr = regis_fee_arr.split("|");
		if(enuri_fg_1 > 0 && enuri_fg_2 > 0) //정액 정률이 섞여있다면 정액 먼저 할인
		{
			var tmp_amt = 0;
			for(var i = 0; i < chkArr.length-1; i++)
			{
				var chkDetail = chkArr[i].split("_");
				var subject_cd = chkDetail[0];
				var enuri_cd = chkDetail[1];
				var dupl_yn = chkDetail[2];
				var enuri_fg = chkDetail[3];
				var enuri = chkDetail[4];
				var limit = chkDetail[5];
				if(enuri_fg == "2")
				{
					for(var z = 0; z < tmp_subject_arr.length-1; z++)
					{
						if(subject_cd == tmp_subject_arr[z])
						{
							if(nullChk(limit) != '')
							{
								if(Number(enuri) > Number(limit))
								{
									enuri = limit;
								}
							}
							if(Number(enuri) > Number(encd_regis_fee_arr[z]))
							{
								enuri = encd_regis_fee_arr[z];
							}
							encd_regis_fee_arr[z] = Number(encd_regis_fee_arr[z]) - Number(enuri);
							encd1_no.put(subject_cd, enuri_cd);
							encd1_amt.put(subject_cd, Number(tmp_regis_fee_arr[z]) - Number(encd_regis_fee_arr[z]));
							tmp_amt = encd_regis_fee_arr[z];
						}
					}
				}
			}
			for(var i = 0; i < chkArr.length-1; i++)
			{
				var chkDetail = chkArr[i].split("_");
				var subject_cd = chkDetail[0];
				var enuri_cd = chkDetail[1];
				var dupl_yn = chkDetail[2];
				var enuri_fg = chkDetail[3];
				var enuri = chkDetail[4];
				var limit = chkDetail[5];
				if(enuri_fg == "1")
				{
					for(var z = 0; z < tmp_subject_arr.length-1; z++)
					{
						if(subject_cd == tmp_subject_arr[z])
						{
							var tmp_enuri_amt = convInt(Number(encd_regis_fee_arr[z]) / 100 * (Number(enuri)));
							if(nullChk(limit) != '')
							{
								if(Number(tmp_enuri_amt) > Number(limit))
								{
									tmp_enuri_amt = limit;
								}
							}
							encd_regis_fee_arr[z] = convInt(Number(encd_regis_fee_arr[z])) - Number(tmp_enuri_amt);
							encd2_no.put(subject_cd, enuri_cd);
							encd2_amt.put(subject_cd, convInt(Number(tmp_amt) - Number(encd_regis_fee_arr[z])));
						}
					}
				}
			}
		}
		else
		{
			var tmp_amt = 0;
			for(var i = 0; i < chkArr.length-1; i++)
			{
				var chkDetail = chkArr[i].split("_");
				var subject_cd = chkDetail[0];
				var enuri_cd = chkDetail[1];
				var dupl_yn = chkDetail[2];
				var enuri_fg = chkDetail[3];
				var enuri = chkDetail[4];
				var limit = chkDetail[5];
				for(var z = 0; z < tmp_subject_arr.length-1; z++)
				{
					if(subject_cd == tmp_subject_arr[z])
					{
						
						if(i == 0)
						{
							if(enuri_fg == "1")
							{
								var tmp_enuri_amt = convInt(Number(encd_regis_fee_arr[z]) / 100 * (Number(enuri)));
								if(nullChk(limit) != '')
								{
									if(Number(tmp_enuri_amt) > Number(limit))
									{
										tmp_enuri_amt = limit;
									}
								}
								
								encd_regis_fee_arr[z] = convInt(Number(encd_regis_fee_arr[z])) - Number(tmp_enuri_amt);
							}
							else
							{
								if(nullChk(limit) != '')
								{
									if(Number(enuri) > Number(limit))
									{
										enuri = limit;
									}
								}
								if(Number(enuri) > Number(encd_regis_fee_arr[z]))
								{
									enuri = encd_regis_fee_arr[z];
								}
								encd_regis_fee_arr[z] = convInt(Number(encd_regis_fee_arr[z]) - Number(enuri));
							}
							encd1_no.put(subject_cd, enuri_cd);
							encd1_amt.put(subject_cd, convInt(Number(tmp_regis_fee_arr[z]) - Number(encd_regis_fee_arr[z])));
							tmp_amt = encd_regis_fee_arr[z];
						}
						else
						{
							if(enuri_fg == "1")
							{
								var tmp_enuri_amt = convInt(Number(encd_regis_fee_arr[z]) / 100 * (Number(enuri)));
								if(nullChk(limit) != '')
								{
									if(Number(tmp_enuri_amt) > Number(limit))
									{
										tmp_enuri_amt = limit;
									}
								}
								encd_regis_fee_arr[z] = convInt(Number(encd_regis_fee_arr[z])) - Number(tmp_enuri_amt);
							}
							else
							{
								if(nullChk(limit) != '')
								{
									if(Number(enuri) > Number(limit))
									{
										enuri = limit;
									}
								}
								if(Number(enuri) > Number(encd_regis_fee_arr[z]))
								{
									enuri = encd_regis_fee_arr[z];
								}
								encd_regis_fee_arr[z] = convInt(Number(encd_regis_fee_arr[z]) - Number(enuri));
							}
							encd2_no.put(subject_cd, enuri_cd);
							encd2_amt.put(subject_cd, convInt(Number(tmp_amt) - Number(encd_regis_fee_arr[z])));
						}
					}
				}
			}
		}
		final_pay = 0;
		var encd_pay = 0;
		for(var i = 0; i < tmp_subject_arr.length-1; i++)
		{
			final_pay += convInt((Number(tmp_regis_fee_arr[i]) - Number(nullChkZero(encd1_amt.get(tmp_subject_arr[i]))) - Number(nullChkZero(encd2_amt.get(tmp_subject_arr[i])))));
			final_pay += convInt(food_amt_arr.split("|")[i]);
			encd_pay += convInt(Number(nullChkZero(encd1_amt.get(tmp_subject_arr[i]))) + Number(nullChkZero(encd2_amt.get(tmp_subject_arr[i]))));
		}
		$("#encd_pay").val(comma(encd_pay))
		$("#total_pay_span").html(comma(final_pay)+" <span>원</span>");
		$('#encd_layer').fadeOut(200);
	}
}
function remove_lect(idx, subject_cd){
	$('#lect_area'+idx).remove();
// 	subject_arr_imsi = subject_arr_imsi.replace(subject_cd+"|", "");
	subject_arr = subject_arr.replace(subject_cd+"|", "");
	part_subject_arr = part_subject_arr.replace(subject_cd+"|", "");
	goMoveLect('remove');
}

function setFinalPay()
{
	final_pay = total_pay;
	$("#total_pay_span").html(comma(final_pay)+" <span>원</span>");
}
function selEnuri()
{
	var enuri1 = nullChk($("#selEnuri1").val());
	var enuri2 = nullChk($("#selEnuri2").val());

	

	
	if(enuri1 != "" && enuri1 != null && enuri1 != undefined)
	{
		var enuri_fg = enuri1.split("_")[0]; 
		var enuri = enuri1.split("_")[1]; 
		var enuri1_dupl=enuri1.split("_")[2];
		var enuri1_limit=enuri1.split("_")[3];

		
		
		encd_pay1 = total_pay;
		if(enuri_fg == "1")
		{
			encd_pay1 = Number(encd_pay1) * Number(enuri)/100;
		}
		else if(enuri_fg == "2")
		{
			encd_pay1 = Number(enuri);
		}
		
		
		if (enuri1_limit!=0 && encd_pay1 > enuri1_limit) { //제한금액 초과시 값 세팅
			encd_pay1=enuri1_limit;
		}
		
	}else{
		encd_pay1=0;
	}
	
	
	if(enuri2 != "" && enuri2 != null && enuri2 != undefined)
	{
		var enuri_fg = enuri2.split("_")[0]; 
		var enuri = enuri2.split("_")[1]; 
		var enuri2_dupl=enuri2.split("_")[2];
		var enuri2_limit=enuri2.split("_")[3];
		
		encd_pay2 = total_pay;
		if(enuri_fg == "1")
		{
			encd_pay2 = Number(encd_pay2) * Number(enuri)/100;
		}
		else if(enuri_fg == "2")
		{
			encd_pay2 = Number(enuri);
		}
		
		if (enuri2_limit!=0 && encd_pay2 > enuri2_limit) { //제한금액 초과시 값 세팅
			encd_pay2=enuri2_limit;
		}
	}else{
		encd_pay2=0;
	}
	if (enuri1.indexOf('_Y_')!=-1) {	//중복불가 쿠폰선택시 할인 값 세팅
		alert('중복 불가 쿠폰입니다.');
		encd_pay2=0;
		$('#selEnuri2').val("");
		$('.selEnuri2').text('선택하세요.');
		$('#selEnuri2_area').hide();
	}else{
		$('#selEnuri2_area').show();
	}
	
	if (enuri2.indexOf('_Y_')!=-1) {
		alert('중복 불가 쿠폰입니다.');
		encd_pay1=0;
		$('#selEnuri1').val("");
		$('.selEnuri1').text('선택하세요.');
		$('#selEnuri1_area').hide();
	}else{
		$('#selEnuri1_area').show();
	}
	
	$("#encd_pay").val(encd_pay1 + encd_pay2);
	
	setFinalPay();
}
// 	 function fncSubmit()
// 	 {
// 	 	var validationFlag = "Y";
// 	 	$(".notEmpty").each(function() 
// 	 	{
// 	 		if ($(this).val() == "") 
// 	 		{
// 	 			alert(this.dataset.name+"을(를) 입력해주세요.");
// 	 			$(this).focus();
// 	 			validationFlag = "N";
// 	 			return false;
// 	 		}
// 	 	});
// 	 	if(validationFlag == "Y")
// 	 	{
// 	 		$("#card_data_fg").val($root$data$card_data$card_data_fg);
// 	 		$("#encCardNo_send_str").val($root$req$encCardNo_send_str);
// 	 		$("#chk_subject_cd").val(subject_arr);
// 	 		$("#fncForm").ajaxSubmit({
// 	 			success: function(data)
// 				{
// 	 				var result = JSON.parse(data);
// 		    		if(result.isSuc == "success")
// 		    		{
// 		    			alert("저장되었습니다.");
// 	 	    			$root$res$recpt_no = result.recpt_no;
// 	 	    			dataReset();
		    			
// 	 	    			posPrint();
// 	 	    		}
// 	 	    		else
// 	 	    		{
// 	 	    			alert(result.msg);
// 	 	    		}
// 	 			}
// 	 		});
// 	 	}
// 	 }
function sendWait()
{
	if($("#cust_no").val() == "")
	{
		alert("회원검색을 먼저 해주세요.");
		return;
	}
	else if($("#sel_subject_cd").val() == "")
	{
		alert("강좌검색을 먼저 해주세요.");
		return;
	}
	else
	{
		var tmpCust = "";
		if(trim($("#child_no1").val()).length == 9)
		{
			tmpCust = "0";
		}
		else
		{
			tmpCust = $("#child_no1").val();
		}
		
		if(tmpCust == "")
		{
			alert("수강자를 선택해주세요.");
			return;
		}
		
		
		$.ajax({
			type : "POST", 
			url : "./sendWait",
			dataType : "text",
			data : 
			{
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				subject_cd : $("#sel_subject_cd").val(),
				cust_no : $("#cust_no").val(),
				child_no1 : tmpCust
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
// 	    			location.reload();
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}


/*
function give_gift(){
	var gift_val1 = $('#selGift1').val();
	var gift_val2 = $('#selGift2').val();
	
	
	
	if ($('.selGift1').text()=="선택하세요.") {
		gift_val1="";
	}
	
	if ($('.selGift2').text()=="선택하세요.") {
		gift_val2="";
	}
	
	if (gift_val1=="" && gift_val2=="") {
		alert("사은품을 선택해주세요.");
		return;
	}
	
	if (gift_val1 == gift_val2) {
		alert("같은 사은품을 선택하셨습니다.");
		return;
	}
	

		
	
	$.ajax({
		type : "POST", 
		url : "./giveGift",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cust_no : $("#cust_no").val(),
			gift_val1 : gift_val1,
			gift_val2 : gift_val2
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			if(result.isSuc == "success")
    		{
    			alert(result.msg);
    			getGiftList();
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});
	
	
}
*/
function getEnuriList(){
	$.ajax({
		type : "POST", 
		url : "./getEnuriByCust",
		dataType : "text",
		async:false,
		data : 
		{
			store : $('#selBranch').val(),
			period : $("#selPeri").val(),
			cust_no : $("#searchResult").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			for(var i = 0; i < result.length; i++)
			{
				if(i == 0)
				{
					$("#selEnuri1").append('<option value="">선택하세요.</option>');
					$(".selEnuri1_ul").append('<li>선택하세요.</li>');
					$("#selEnuri2").append('<option value="">선택하세요.</option>');
					$(".selEnuri2_ul").append('<li>선택하세요.</li>');
				}
				$("#selEnuri1").append('<option value="'+result[i].ENURI_FG+'_'+result[i].ENURI+'_'+result[i].DUPL_DISCOUNT_YN+'_'+result[i].LIMITED_AMT+'">'+result[i].ENURI_NM+'</option>');
				$(".selEnuri1_ul").append('<li>'+result[i].ENURI_NM+'</li>');
				$("#selEnuri2").append('<option value="'+result[i].ENURI_FG+'_'+result[i].ENURI+'_'+result[i].DUPL_DISCOUNT_YN+'_'+result[i].LIMITED_AMT+'">'+result[i].ENURI_NM+'</option>');
				$(".selEnuri2_ul").append('<li>'+result[i].ENURI_NM+'</li>');
			}
		}
	});
}
/*
function getGiftList(){
	$.ajax({
		type : "POST", 
		url : "./getSideList",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cust_no : $("#searchResult").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			
			if(result.GiftList.length > 0)
			{
				for(var i = 0; i < result.GiftList.length; i++)
				{
					$("#selGift1").html('<option value="'+result.GiftList[i].GIFT_CD+'_'+result.GiftList[i].GIFT_PRICE+'">'+result.GiftList[i].GIFT_NM+'</option>');
					$(".selGift1_ul").html('<li>'+result.GiftList[i].GIFT_NM+'</li>');
					$("#selGift2").html('<option value="'+result.GiftList[i].GIFT_CD+'_'+result.GiftList[i].GIFT_PRICE+'">'+result.GiftList[i].GIFT_NM+'</option>');
					$(".selGift2_ul").html('<li>'+result.GiftList[i].GIFT_NM+'</li>');
				}
			}
			else
			{
				$("#selGift1").html('<option value="">지급된 사은품이 없습니다.</option>');
				$(".selGift1_ul").html('<li>지급된 사은품이 없습니다.</li>');
				$("#selGift2").html('<option value="">지급된 사은품이 없습니다.</option>');
				$(".selGift2_ul").html('<li>지급된 사은품이 없습니다.</li>');
			}
		}
	});
	
}
*/

function uptCar(){
	$.ajax({
		type : "POST", 
		url : "./uptCar",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			car_no : $('#car_no').val(),
			cust_no : $("#cust_no").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
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

function payCancel()
{
	$('#cancel_list_layer').fadeIn(200);	
}
function paymentAction(val)
{
	$(".payment_div").hide();
	$("#payment_"+val).show();
	
	if(val == "normal")
	{
		$("#card_submit_btn").show();
		$("#keyin_submit_btn").show();
	}
}


function interOn(){
	var divText = document.getElementById("inter_layer").outerHTML;
	//var myWindow = window.open('/member/lect/view.jsp','_blank','width=450,height=600, status=no, menubar=no, toolbar=no, resizable=no');
	//var myWindow = window.open('/member/lect/view.jsp','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,fullscreen=yes,resizable=no,width=760,height=1024, top=0 left=0','channelmode','scrollbars');
	var w = window.outerWidth,
		h = window.outerHeight,
		w2 = w/2-380,
		h2 = window.screen.availLeft;
	
	var myWindow = window.open('/member/lect/view.jsp','_blank','directories=no, toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no, top=1080, left=1920, width=760,height=1080');
	//myWindow.moveTo(-750, -h);  
	//console.log(w+"//"+w2+"//"+h);
	
	
	myWindow.focus();
	
	var doc = myWindow.document;
	doc.open();
	doc.write('<!DOCTYPE html>');	
	doc.write('<meta name="viewport" content="width=device-width, initial-scale=1">');
	doc.write('<meta name="viewport" content="width=device-width, initial-scale=1">');
	doc.write('<link rel="stylesheet" href="/inc/css/admin.css">');
	doc.write('<link rel="stylesheet" href="/inc/css/popup.css">');
	
	doc.write('<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"><'+'/script>');
	doc.write('<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"><'+'/script>');
	doc.write('<script src="http://malsup.github.io/min/jquery.form.min.js"><'+'/script>');
	doc.write('<script src="/inc/js/function.js"><'+'/script>');
	
	doc.write('<body onload="toggleFullScreen(document.body)">'+divText+'</body>');    
    doc.close();
    
}

// $(window).load(function(){
// 	test();
// })

// function test(){
// 	var wid =  $(window).width(),
// 	hei = $(window).height();
// 	xPos = document.body.offsetWidth;
// 	xPos += window.screenLeft; // 듀얼 모니터일 때
// 	console.log(wid+"//"+hei+"//"+xPos);
// 	window.open('/deskPopup/BAPopupAdmin.jsp','POPEvent0101','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width='+wid+',height'+hei+' top=0 left='+xPos);	
// }
var myWindow;
function insTempPere()
{
	
	var arr ="";	
	$('.subject_arr').each(function(){ 
		arr += $(this).text()+"|";
	})


	$.ajax({
		type : "POST", 
		url : "./insTempPere",
		dataType : "text",
		async:false,
		data : 
		{
			subject_arr : arr,
			cust_no : $("#cust_no").val(),
			store : $("#selBranch").val(),
			period : $("#selPeri").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var wid =  $(window).width(),
				hei = $(window).height();
				xPos = document.body.offsetWidth;
				xPos += window.screenLeft; // 듀얼 모니터일 때
			var result = JSON.parse(data);
			if(result.isSuc == "success")
    		{
				var kor_nm = $("#kor_nm").val();
				var store_nm = $(".selBranch").html();
				var birth_ymd = $("#birth_ymd").val().replace(/-/gi, ""); 
				var hphone = $("#h_phone_no").val();
				var cust_no = $("#cust_no").val();
				var store = $("#selBranch").val();
				var period = $("#selPeri").val();
				var resi_no = '${login_seq}';
				var sale_ymd = getNow();
				var url = encodeURI("/deskPopup/BAPopupAdmin.jsp?korNm="+kor_nm+"&birthYmd="+birth_ymd+"&hp="+hphone+"&storeNm="+store_nm+"&saleYmd="+sale_ymd+"&custNo="+trim(cust_no)+"&store="+store+"&period="+period+"&posNo="+pos_no+"&resiNo="+resi_no+"&sum="+total_pay);
				var w = window.outerWidth,
					h = window.outerHeight,
					w2 = w/2-490;
				//alert(w+"//"+w2)
				myWindow = window.open(url,'POPEvent0101','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,top=0, left='+w2+', width=980,height='+h);
// 				if(myWindow.requestFullscreen)
// 				{
// 					myWindow.requestFullscreen();
// 				}
// 				else if(myWindow.webkitRequestFullscreen)
// 				{
// 					myWindow.webkitRequestFullscreen();
// 				}
// 				else if(myWindow.mozRequestFullScreen)
// 				{
// 					myWindow.mozRequestFullScreen();
// 				}
// 				else if(myWindow.msRequestFullScreen)
// 				{
// 					myWindow.msRequestFullScreen();
// 				}
				console.log("url : "+url);
    		}
    		else
    		{
	    		alert(result.msg);
	    		
    		}
		}
	});	
}


function getGiftInfo(subject_cd){
	
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/getGiftInfo",
		dataType : "text",
		async:false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cust_no : $("#cust_no").val(),
			subject_cd : subject_cd
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner = "";
			if (result.isSuc=="success")
			{
				alert(repWord(result.msg));	
			}
		}
	});
	
}

</script>
<div class="sub-tit">
	<h2>수강관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
<!-- 		<A class="btn btn02" onclick="javascript:cardXCheck();">검증 </A> -->
		<a class="btn btn01" onclick="javascript:location.href='/member/lect/view'">초기화</a>
		<A class="btn btn03 btn01_1" onclick="javascript:interOn();">고객정보입력 </A>
	</div>
</div>
	<div class="btn-right">
		<span id="sw_version" style="background-color:#999"></span>
		<span id="hw_version" style="background-color:#999"></span>
	</div>

<form id="fncForm" name="fncForm" method="POST" action="./sale_proc">
	<div class="table-top">
		<div class="top-row sear-wr">
			<div class="wid-3">
				<div class="table">
					<div class="wid-45">
						<div class="table table-auto">
							<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
						</div>
					</div>
					<div class="wid-15">
						<div class="table">
							<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
							<div class="oddn-sel02">
								<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
							</div>
						</div>
					</div>
				</div>
			</div>			
			<div class="wid-45 ">
				<div class="search-wr">
<!-- 					<select id="searchType" name="searchType" de-data="휴대폰(뒷자리 4자리)"> -->
<!-- 						<option value="phone">휴대폰(뒷자리 4자리)</option> -->
<!-- 						<option value="card">카드번호</option> -->
<!-- 						<option value="members">멤버스번호</option> -->
<!-- 					</select> -->
				    <input type="text" id="search_name" name="search_name" style="width:96% !important" placeholder="휴대폰 뒷자리 / 카드번호 / 멤버스번호 / 회원명 / 생년월일이 검색됩니다." onkeypress="excuteEnter(userSearch)">
				    <input class="search-btn" type="button" value="검색" onclick="userSearch()">
				</div>
			</div>	
<!-- 			<div class="wid-3 mag-lr2"> -->
<!-- 				<div class="table"> -->
<!-- 					<div> -->
<!-- 						<div class="table"> -->
<!-- 							<div class="sear-tit sear-tit_120 sear-tit_left">회원명</div> -->
<!-- 							<div> -->
<!-- 								<input type="text" id="user_name" name="user_name" /> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</div> -->
					
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="wid-2"> -->
<!-- 				<div class="table table-input"> -->
<!-- 					<div class="sear-tit sear-tit_left">생년월일</div> -->
<!-- 					<div> -->
<!-- 						<input type="text" id="birth" name="birth" placeholder="YY/MM/DD"/> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="userSearch()">
	</div>
	
	<div class="grid-1000">
		<div class="mem-step mem-step01">
			<div class="step-tit">STEP 1 <span>고객정보</span></div>
			
			<div class="member-table member-profile">
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
													<input type="text" id="phone_no" name="phone_no" class="inputDisabled inp-100" >
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="wid-10">
								<div class="table">
									
									<div class="sear-tit sear-tit-top">이메일</div>
									<div>
										<input type="text" id="email_addr" name="email_addr" class="inputDisabled inp-100" >
										
										<div class="sear-smtit">
											<input type="checkbox" id="chk_mail" name="chk_mail" disabled="disabled">
											<label for="chk_mail">수신동의</label>
											<span>정보/이벤트 SMS 수신에 동의합니다.</span>		
										</div>
										
									</div>
								
								</div>
							</div>
							
							<div class="wid-10">
								<div class="table">
									
									<div class="sear-tit sear-tit-top">휴대폰</div>
									<div>
										<input type="text" id="h_phone_no" name="h_phone_no" class="inputDisabled inp-100" >
										
										<div class="sear-smtit">
											<input type="checkbox" id="chk_sms" name="chk_sms" disabled="disabled">
											<label for="chk_sms">수신동의</label>
											<span>정보/이벤트 SMS 수신에 동의합니다.</span>		
										</div>
										
									</div>
								
								</div>
							</div>
								
						</div>
					</div> <!-- // wid-5 end -->
						
					
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
					
						
						
							<div class="wid-10">
								<div class="table">
									<div class="top-row">
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit-top">멤버스번호</div>
												<div>
													<input type="text" id="cus_no" name="cus_no" class="inputDisabled inp-100" >
												</div>
											</div>
										</div>
										<div class="wid-5">
											<div class="table">
												<div class="sear-tit sear-tit-top">회원등급</div>
												<div>
													<input type="text" id="user_class" name="user_class" class="inputDisabled inp-100" >
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
													<input type="text" id="" name="" class="inputDisabled inp-100" >
												</div>
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
										<a class="btn btn02 btn-mar6" onclick="javascript:uptCar();">저장</a>
									</div>
								</div>
							</div>
							<input type="text" id="cust_no" name="cust_no" class="notEmpty" data-name="고객정보" style="display:none;">
							<a class="btn btn02 btn-mar6" onclick="javascript:showMemo();">메모보기</a>
							<div id="memoDiv" style="display:none;">
							
							</div>
						</div>
					</div> <!-- //wid-5_last end -->
					
				</div> <!-- //row end -->
				
			</div> <!-- // table-list end -->
		</div> <!-- //mem-step01 end -->
		<div id="search_layer" class="list-edit-wrap">
			<div class="le-cell">
				<div class="le-inner">
		        	<div class="list-edit white-bg">
		        		<div class="close" onclick="javascript:$('#search_layer').fadeOut(200);">
		        			닫기<i class="far fa-window-close"></i>
		        		</div>
		        		<div>
		        			<h3>강좌검색</h3>
		        			<div class="lect-pwrap02">
		        				<div class="table">
		        					<div class="wid-5 lec-1dept">
		        						<div class="table">
		        							<div class="wid-5">
				        						<p class="h3-stit">대분류</p>
				        						<ul class="sect_ul_big">
				        							<c:forEach var="j" items="${maincdList}" varStatus="loop">
														<li onclick="selMainCd('${j.SUB_CODE}')">${j.SHORT_NAME}</li>
													</c:forEach>
				        						</ul>
			        						</div>
			        						<div class="wid-5">
				        						<p class="h3-stit">중분류</p>
				        						<ul class="sect_ul">
				        						</ul>
			        						</div>
		        						</div>
		        					</div>
		        					<div class="wid-5 lec-2dept">
		        						<p class="h3-stit">강좌명</p>
		        						<div>
			        						<ul class="pelt_ul">
			        							
			        						</ul>
			        					</div>
		        					</div>
		        				</div>
		        			
		        			</div> <!-- // lect-pwrap02 -->
		        			
	<!-- 						<div class="lect-pwrap03"> -->
	<!-- 							<h3>선택된 강좌</h3> -->
	<!-- 							<a class="btn btn01" onclick="peltTrAct('del')">삭제</a> -->
								
	<!-- 							<div class="table-list"> -->
	<!-- 								<table> -->
	<!-- 									<thead> -->
	<!-- 										<tr> -->
	<!-- 											<th class="td-chk"> -->
	<!-- 												<input type="checkbox" id="chk_pelt" name="chk_pelt" value="chk_pelt_list"><label for="chk_pelt"></label> -->
	<!-- 											</th> -->
	<!-- 											<th>강좌명<i class="material-icons">import_export</i></th> -->
	<!-- 											<th>강사명<i class="material-icons">import_export</i></th> -->
	<!-- 											<th>강의요일<i class="material-icons">import_export</i></th> -->
	<!-- 											<th>강의시간<i class="material-icons">import_export</i></th> -->
	<!-- 										</tr> -->
	<!-- 									</thead> -->
										
	<!-- 									<tbody class="selLectTable"> -->
	<!-- 									</tbody> -->
										
	<!-- 								</table> -->
								
	<!-- 							</div> -->
							
							
	<!-- 						</div> // lect-pwrap03 -->
							
	<!-- 						<div class=" text-center"> -->
	<!-- 							<a class="btn btn02 ok-btn" onclick="javascript:peltTrAct('sel');">선택완료</a> -->
	<!-- 						</div> -->
			        	</div>
		        	</div>
		        </div>
		    </div>	
		</div>
		
	
		<div id="user_search_layer" class="list-edit-wrap">
			<div class="le-cell">
				<div class="le-inner">
		        	<div class="list-edit white-bg edit-scroll">
		        		<div class="close" onclick="javascript:$('#user_search_layer').fadeOut(200);">
		        			닫기<i class="far fa-window-close"></i>
		        		</div>
		        		<div>
		        			<h3 class="text-center">고객 조회</h3>
							<div class="table table02 table-searnum">
								<div class="wid-5 sel-scr">
									<input type="hidden" id="searchResult" name="searchResult">
	<!-- 								<a class="btn btn02" onclick="choose_confirm('search');">선택완료</a> -->
								</div>
			        		</div>
			        		<div class="top-row">
										<div class="table-list table-csplist table-wid10" style="display:block !important;">
											<table>
												<thead>
													<tr>
														<th onclick="reSortAjax('sort_kor_nm')">회원명 <img src="/img/th_up.png" id="sort_kor_nm"></th>
														<th onclick="reSortAjax('sort_birth_ymd')">생년월일 <img src="/img/th_up.png" id="sort_birth_ymd"></th>
														<th onclick="reSortAjax('sort_cus_no')">멤버스번호 <img src="/img/th_up.png" id="sort_cus_no"></th>
														<th onclick="reSortAjax('sort_grade')">회원등급 <img src="/img/th_up.png" id="sort_grade"></th>
														<th onclick="reSortAjax('sort_pere_cnt')">수강강좌수 <img src="/img/th_up.png" id="sort_pere_cnt"></th>
													</tr>
												</thead>
												<tbody id="search_user_target">
												</tbody>
											</table>
										</div>
									
									
								
								</div>		
							
						
	<!-- 						<div class="btn-wr text-center"> -->
	<!-- 							<a class="btn btn01 ok-btn" onclick="javascript:choose_cancle();">취소</a> -->
	<!-- 							<a class="btn btn02 ok-btn" onclick="choose_confirm('search');">선택완료</a> -->
	<!-- 						</div> -->
			        	</div>
		        	</div>
		        </div>
		    </div>	
		</div>
		<div id="memo_layer" class="list-edit-wrap">
			<div class="le-cell">
				<div class="le-inner">
		        	<div class="list-edit white-bg edit-scroll">
		        		<div class="close" onclick="javascript:$('#memo_layer').fadeOut(200);">
		        			닫기<i class="far fa-window-close"></i>
		        		</div>
		        		<div>
		        			<h3 class="text-center">메모</h3>
			        		<div class="top-row">
								<div class="table-list table-csplist table-wid10" style="display:block !important;">
									<table>
										<thead>
											<tr>
												<th>내용</th>
												<th>작성일시</th>
												<th>작성자</th>
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
		<div id="encd_layer" class="list-edit-wrap">
			<div class="le-cell">
				<div class="le-inner">
		        	<div class="list-edit white-bg">
		        		<div class="close" onclick="javascript:$('#encd_layer').fadeOut(200);">
		        			닫기<i class="far fa-window-close"></i>
		        		</div>
		        		<div>
		        			<h3>할인코드 <span class="h3-span">(최대 2개까지 선택가능합니다)</span></h3>
							<div>
								<p class="h3-stit">즉시할인</p>
								<div class="overcode-wr">
									<div id="target_encd1">
									</div>
								</div>
								<p class="h3-stit">중복할인</p>
								<div class="overcode-wr">
									<div id="target_encd2">
									</div>
								</div>
								<div class="overcode-wr">
									<div id="target_encd3" class="text-center">	
									</div>							
								</div>
			        		</div>
			        	</div>
		        	</div>
		        </div>
		    </div>	
		</div>
		<div id="lect_search_layer" class="list-edit-wrap">
			<div class="le-cell">
				<div class="le-inner">
		        	<div class="list-edit white-bg edit-scroll">
		        		<div class="close" onclick="javascript:$('#lect_search_layer').fadeOut(200);">
		        			닫기<i class="far fa-window-close"></i>
		        		</div>
		        		<br>
		        		<div class="table-list">
			        		<table>
								<colgroup>
									<col>
									<col width="150px">
									<col>
									<col>
									<col>
									<col>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th onclick="reSortAjax_lect('sort_subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_subject_cd"></th>
										<th onclick="reSortAjax_lect('sort_subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_subject_nm"></th>
										<th onclick="reSortAjax_lect('sort_capacity_no')">정원 <img src="/img/th_up.png" id="sort_capacity_no"></th>
										<th onclick="reSortAjax_lect('sort_regis_no')">현원 <img src="/img/th_up.png" id="sort_regis_no"></th>
										<th onclick="reSortAjax_lect('sort_wait_cnt')">대기자 <img src="/img/th_up.png" id="sort_wait_cnt"></th>
										<th onclick="reSortAjax_lect('sort_start_ymd')">기간 <img src="/img/th_up.png" id="sort_start_ymd"></th>
										<th onclick="reSortAjax_lect('sort_lect_hour')">시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
										<th onclick="reSortAjax_lect('sort_day_flag')">요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
									</tr>
								</thead>
								<tbody id="tb1_target">									
								</tbody>
							</table>
						</div>
		        	</div>
		        </div>
		    </div>	
		</div>
		
		<div id="cancel_layer" class="can-edit list-edit-wrap">
			<div class="le-cell">
				<div class="le-inner">
		        	<div class="list-edit white-bg">
		        		<div class="close" onclick="javascript:$('#cancel_layer').fadeOut(200);">
		        			닫기<i class="far fa-window-close"></i>
		        		</div>
		        		<div>
		        			<h3 class="text-center">취소 후 부분입금</h3>
		        			
		        			<div class="table-top bg01">
		        			
		        				<div class="top-row table-input">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">취소강좌</div>
											<div id="part_subject_target">
	<!-- 											<input type="text" value="5회/12회" class="inp-100 text-center" placeholder="" readOnly> -->
											</div>
										</div>
									</div>
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">수강 강의 회차</div>
											<div id="part_target">
	<!-- 											<input type="text" value="5회/12회" class="inp-100 text-center" placeholder="" readOnly> -->
											</div>
										</div>
									</div>
	<!-- 								<div class="wid-10"> -->
	<!-- 									<div class="table"> -->
	<!-- 										<div class="sear-tit">결제금액</div> -->
	<!-- 										<div> -->
	<!-- 											<input type="text" value="" class="inp-100 text-right" placeholder="" readOnly> -->
	<!-- 										</div> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
								</div>
								
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">수강료</div>
											<div>
												<input type="text" id="part_regis_fee" name="part_regis_fee" value="" class="inp-100 text-right">
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_left">재료비</div>
											<div>
												<input type="text" id="part_food_amt" name="part_food_amt" value="" class="inp-100 text-right">
											</div>
										</div>
									</div>
								</div>
								
		        			</div>
		        			
		        			<div class=" text-center">
								<a class="btn btn02 ok-btn" onclick="javascript:goMoveLect('part');">확인</a>
							</div>
							
		        		</div>
		        	</div>
		        </div>
		    </div>
		</div>
		<div class="dis-no">
			<div id="inter_layer" class="">
			
			<script>
			
				function addChar(num)
				{
					var memNum = document.getElementById('inter-phone').value+""+num;
					document.getElementById('inter-phone').value=memNum;
				}
	
				function delChar()
				{
					var memNum = document.getElementById('inter-phone').value;
					memNum = memNum.substr(0,memNum.length-1);
					document.getElementById('inter-phone').value=memNum;
				}
	
	
				function resetChar()
				{
					document.getElementById('inter-phone').value="";
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
				function searchCust_Hp() {
					var hp_no = $("#inter-phone").val();
					if(hp_no == "") {
						alert("고객정보를 입력하세요!");
						return false;
					} else {
						
						// 회원 수 조회
						$.ajax({
							type : "POST", 
							url : "/common/BACust0101_S01",
							dataType : "text",
							async:false,
							data : 
							{
								val : hp_no
							},
							error : function() 
							{
								console.log("AJAX ERROR");
							},
							success : function(data) 
							{
								console.log(data);
								var result = JSON.parse(data);
								var count = result.length;
								
								if(count > 0)
								{
									opener.document.getElementById("search_name").value = trim(result[0].H_PHONE_NO_1)+trim(result[0].H_PHONE_NO_2)+trim(result[0].H_PHONE_NO_3);
									opener.userSearch();
								}
								else
								{
									alert("조회된 회원이 없습니다.");
								}
							}
						});	
					}
				}
				
				function new_searchCust_Hp() {
					var hp_no = $("#inter-phone").val();
					if(hp_no == "") {
						alert("고객정보를 입력하세요!");
						return false;
					} else {
						
						// 회원 수 조회
						$.ajax({
							type : "POST", 
							url : "/common/get_AMS_info_by_tel",
							dataType : "text",
							async:false,
							data : 
							{
								store : opener.document.getElementById("selBranch").value,
								period : opener.document.getElementById("selPeri").value,
								val : hp_no
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
									opener.document.getElementById("search_name").value = trim(result.cus_no);
									opener.userSearch();
								}	
							
							}
						});	
					}
				}
				
				function new_select_point(){
					
					var val = $("#inter-phone").val()
					opener.document.getElementById("search_name").value = val;
					opener.userSearch();
							
				}
				
				
				function new_member(){
					var cus_val = $("#inter-phone").val();
					if(cus_val == "") {
						alert("고객정보를 입력하세요!");
						return false;
					} else {
						
						// 회원 수 조회
						$.ajax({
							type : "POST", 
							url : "/common/get_AMS_info_by_cus_no",
							dataType : "text",
							async:false,
							data : 
							{
								store : opener.document.getElementById("selBranch").value,
								period : opener.document.getElementById("selPeri").value,
								val : cus_val
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
									opener.document.getElementById("search_name").value = trim(result.cus_no);
									opener.userSearch();
								}	
							
							}
						});	
					}
				}
				
				function sendCustInfo(){
					
					var history = 	document.querySelector('input[name="inter_type"]:checked').value;
					var info_type = 	document.querySelector('input[name="info_type"]:checked').value;
					
					
					if(history =="Y"){
						if(info_type =="1"){
							searchCust_Hp();
						}else if(info_type =="2"){
							new_select_point();
							
						}
					}else{
						if(info_type =="1"){
							new_searchCust_Hp();
						}else if(info_type =="2"){
							new_member();
						}
					}
					
					window.close();
					
// 					var search_type = document.querySelector('input[name="inter_Info"]:checked').value;
// 					var cont = document.getElementById('inter-phone').value;
// 					if (cont=="") {
// 						alert("회원 정보를 입력해주세요.");
// 						return;
// 					}
					
// 					getListStart();
// 					$.ajax({
// 						type : "POST", 
// 						url : "./addToCulture",
// 						dataType : "text",
// 						data : 
// 						{
// 							search_type : search_type,
// 							cont : cont
// 						},
// 						error : function() 
// 						{
// 							console.log("AJAX ERROR");
// 						},
// 						success : function(data) 
// 						{
// 							console.log(data);
// 							var result = JSON.parse(data);
// 							alert(result.msg);
// 							getListEnd();
// 						}
// 					});
					
					//opener.addCust(search_type,cont);
				}
				
			</script>
			
				<div class="le-cell">
					<div class="le-inner">
			        	<div class="white-bg">
			        		<div>
			        			<h3 class="text-center">멤버스 고객 연동</h3>
								
								<div class="inter-txt">
									<p>AK문화아카데미 수강이력 여부를 체크해주세요.</p>
									<div class="inter-sel">
										<ul>
											<li>
												<input type="radio" id="inter_type1" name="inter_type" value="N" onclick="" checked="">
												<label for="inter_type1">없음</label>
											</li>
											<li>
												<input type="radio" id="inter_type2" name="inter_type" value="Y" onclick="">
												<label for="inter_type2">있음</label>
											</li>
										</ul>
									</div>
								</div>
								<div class="inter-txt">
									<p>조회하실 고객님의 정보를 입력해주세요.</p>
									<div class="inter-sel">
										<ul>
											<li>
												<input type="radio" id="info_type1" name="info_type" value="1" onclick="" checked="">
												<label for="info_type1">연락처</label>
											</li>
											<li>
												<input type="radio" id="info_type2" name="info_type" value="2" onclick="">
												<label for="info_type2">멤버스 카드번호</label>
											</li>
										</ul>
									</div>
								</div>
								<div class="inter-phn">
									<input type="text" id="inter-phone" name="inter-phone">
								</div>
								<div class="inter-numb">
									<ul>
										<li onclick="addChar(1)">1</li>
										<li onclick="addChar(2)">2</li>
										<li onclick="addChar(3)">3</li>
										<li onclick="addChar(4)">4</li>
										<li onclick="addChar(5)">5</li>
										<li onclick="addChar(6)">6</li>
										<li onclick="addChar(7)">7</li>
										<li onclick="addChar(8)">8</li>
										<li onclick="addChar(9)">9</li>
										<li onclick="addChar(0)">0</li>
										<li class="font-15" onclick="delChar()">지우기</li>
										<li class="font-15" onclick="resetChar()">초기화</li>
									</ul>
								</div>
								<div class="btn-wr text-center">
									<a class="btn btn02 ok-btn" onclick="sendCustInfo()">확인</a>
								</div>
			        		</div>
			        	</div>
			        </div>
			    </div>	
			</div>
		</div>
		<div class="row mem-row">
			<div class="wid-35">
				<div class="white-bg white-bg02">
					<div class="mem-top">
						<div class="lt">
							<h3 class="h3-tit">자녀
							회원</h3>
						</div>
						<div class="rt">
							<a class="btn btn03" onclick="javascript:addChild();"><i class="material-icons">add</i>자녀회원 추가</a>
						</div>
					</div>
					
					<div class="table-list">
						<table>
							<colgroup>
								<col width="50px">
								<col width="80px">
								<col />
								<col width="80px">
							</colgroup>
							<thead>
								<tr>
									<th>NO.</th>
									<th>회원명</th>
									<th>성별</th>
									<th>생년월일</th>
								</tr>
							</thead>
							<tbody id="child_target">
								
								
							</tbody>
						</table>				
						<div class="text-right btn-wr">
						<a class="btn btn02 btn-mar6" onclick="javascript:addChildProc();">저장</a>
						</div>	
			
					</div>
				</div>
			</div> <!-- //wid-35 end -->
			
			<div class="wid-65">
				<div class="white-bg white-bg02">
					<div class="mem-top">
						<div class="lt">
							<h3 class="h3-tit">강좌이력</h3>
						</div>
						<div class="rt sel-arr">
							<select id="isCancel_type" name="isCancel_type" de-data="등록" onchange="getPereByCust()">
								<option value="in">등록</option>
								<option value="out">취소</option>
								<option value="part">부분입금</option>
								<option value="part_cancel">부분입금취소</option>
							</select>
							<select id="searchPere_period" name="searchPere_period" de-data="$" onchange="getPereByCust()">
							</select>
						</div>
					</div>
					
					<div class="table-list lec-tableli">
						<table>
							<thead>
								<tr>
									<th class="td-chk"></th>
									<th>접수일자</th>
									<th>취소일자</th>
									<th>강좌코드</th>
									<th style="width:200px;">강좌명</th>
									<th>강좌일정</th>
									<th>요일</th>
									<th>강의시간</th>
									<th>강사명</th>
									<th>수강료/재료비</th>
									<th>수강자</th>									
								</tr>
							</thead>
							<tbody id="pere_target">
								
	<!-- 							<tr> -->
	<!-- 								<td class="td-chk"> -->
	<!-- 									<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
	<!-- 								</td> -->
	<!-- 								<td>101001</td> -->
	<!-- 								<td>일요명상과요가</td> -->
	<!-- 								<td>최웅</td> -->
	<!-- 								<td>100,000</td> -->
	<!-- 								<td>40,000</td> -->
	<!-- 								<td>07-01~10-31</td> -->
	<!-- 								<td>12:00~14:00</td> -->
	<!-- 								<td>월</td> -->
	<!-- 								<td>12</td> -->
	<!-- 								<td>자녀</td>							 -->
	<!-- 							</tr> -->
								
	<!-- 							<tr> -->
	<!-- 								<td class="td-chk"> -->
	<!-- 									<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
	<!-- 								</td> -->
	<!-- 								<td>101001</td> -->
	<!-- 								<td>일요명상과요가</td> -->
	<!-- 								<td>최웅</td> -->
	<!-- 								<td>100,000</td> -->
	<!-- 								<td>40,000</td> -->
	<!-- 								<td>07-01~10-31</td> -->
	<!-- 								<td>12:00~14:00</td> -->
	<!-- 								<td>월</td> -->
	<!-- 								<td>12</td> -->
	<!-- 								<td>자녀</td>							 -->
	<!-- 							</tr> -->
	<!-- 							<tr> -->
	<!-- 								<td class="td-chk"> -->
	<!-- 									<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
	<!-- 								</td> -->
	<!-- 								<td>101001</td> -->
	<!-- 								<td>일요명상과요가</td> -->
	<!-- 								<td>최웅</td> -->
	<!-- 								<td>100,000</td> -->
	<!-- 								<td>40,000</td> -->
	<!-- 								<td>07-01~10-31</td> -->
	<!-- 								<td>12:00~14:00</td> -->
	<!-- 								<td>월</td> -->
	<!-- 								<td>12</td> -->
	<!-- 								<td>자녀</td>							 -->
	<!-- 							</tr> -->
								
								
							</tbody>
						</table>
							
					
					</div>
					
				</div>
			</div> <!-- //wid-65 end -->
		
		</div> <!-- //mem-row end -->
		
		
		<div class="table-wr table-wr_mem">
			 
			<div class="table-list mem-table white-bg02">
			
				<div class="cap-r text-right" style="margin-bottom: -30px;">
					<a class="btn btn02" onclick="javascript:printStart();"><i class="material-icons">receipt</i>영수증 재발행</a>
					<a class="btn btn01 btn01_1" onclick="javascript:autoSign('cancel');">결제취소</a>
					<a class="btn btn01 btn01_1" onclick="javascript:autoSign('super_cancel');">강제취소</a>
				</div>
				<h3 class="h3-tit">거래내역 <span>강좌를 선택하시면 상세내용을 확인할 수 있습니다.</span></h3>
				<table>
					<thead>
						<tr class="td-chk">
							<th><input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label></th>
							<th>POS번호<i class="material-icons">import_export</i></th>
							<th>영수증번호<i class="material-icons">import_export</i></th>
							<th>승인번호<i class="material-icons">import_export</i></th>
							<th>결제수단<i class="material-icons">import_export</i></th>
							<th>마일리지<i class="material-icons">import_export</i></th>
							<th>현금<i class="material-icons">import_export</i></th>
							<th>자사상품권<i class="material-icons">import_export</i></th>
							<th>타사상품권<i class="material-icons">import_export</i></th>
							<th>카드<i class="material-icons">import_export</i></th>
<!-- 							<th>할인내역<i class="material-icons">import_export</i></th> -->
							<th>할인총액<i class="material-icons">import_export</i></th>
							<th>총결제금액<i class="material-icons">import_export</i></th>
							<th>사은품명<i class="material-icons">import_export</i></th>
							<th>반납필요<i class="material-icons">import_export</i></th>		
						</tr>
					</thead>
					<tbody id="sale_target">
	<!-- 					<tr> -->
	<!-- 						<td class="td-chk"> -->
	<!-- 							<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
	<!-- 						</td> -->
	<!-- 					   	<td>2019-06-23 16:43</td> -->
	<!-- 					   	<td>DESK</td> -->
	<!-- 					   	<td>070002</td> -->
	<!-- 					   	<td>0041</td> -->
	<!-- 					   	<td>123456789</td> -->
	<!-- 					   	<td>카드</td> -->
	<!-- 					   	<td>KB</td> -->
	<!-- 					   	<td>5561512155452211</td> -->
	<!-- 					   	<td>20,000</td> -->
	<!-- 					   	<td>2회연속수강</td> -->
	<!-- 					   	<td>20,000</td> -->
	<!-- 					   	<td>60,000</td> -->
	<!-- 					   	<td>선착순 5만원 수강권</td> -->
	<!-- 					   	<td>Y</td>		 -->
	<!-- 					</tr> -->
					</tbody>
				</table>
			</div>
			
		</div> <!-- //table-wr_mem end -->
		
		<div class="table-wr table-wr_mem02">
			<div class="row view-page">
				<div class="wid-5">
					<div class="mem-step mem-step02">
						<div class="step-tit">STEP 2 <span>수강신청서 작성</span></div>
						
						
						<div class="white-bg table-list st-twowrap ak-wrap_new">
							<div class="table-wr">
								<div class="tit-btn">
									<h3 class="h3-tit">&nbsp;</h3>
									
									<div class="sel-arr fl-ri">
										<a class="btn-a btn03 mar-no" onclick="javascript:courseSearch()">강좌검색</a>
									</div>
								</div>
								
								<div class="row row_mem">					
									<div class="wid-10">
										<input type="text" id="lect_searchVal" name="lect_searchVal" value="" class="inp-80_1" onkeypress="excuteEnter_param(getLectSearch, 'search')" placeholder="강좌코드나 강좌명, 강사명을 검색하세요.">
										<a class="point-btn" onclick="javascript:getLectSearch('search');">조회</a>
									</div>
								</div>
								<div class="top-row table-input table-wsel" style="margin-bottom: 8px;" id="child_div">
									<div class="table">
										<div class="sear-tit">수강자</div>
										<div class="wid3-sel">
<!-- 											<div> -->
<!-- 												<input type="text" id="kor_nm_view" name="kor_nm_view" value="" class="inputDisabled inp-100 inptxt" readOnly style="width: 88% !important;"> -->
<!-- 											</div> -->
											<div id="target_child1" style="display:none;">
												<select id="child_no1" name="child_no1" de-data="선택">
													<option value="">선택</option>
	<!-- 												<option value="20">이강준</option> -->
	<!-- 												<option value="50">이강준</option> -->
												</select>
											</div>
											<div id="target_child2" style="display:none;">
												<select id="child_no2" name="child_no2" de-data="선택">
													<option value="">선택</option>
	<!-- 												<option value="20">이호걸</option> -->
	<!-- 												<option value="20">이강준</option> -->
	<!-- 												<option value="50">이강준</option> -->
												</select>
											</div>
											<div id="target_child3" style="display:none;">
												<select id="child_no3" name="child_no3" de-data="선택">
													<option value="">선택</option>
	<!-- 												<option value="20">이호걸</option> -->
	<!-- 												<option value="20">이강준</option> -->
	<!-- 												<option value="50">이강준</option> -->
												</select>
											</div>
	<!-- 										<div> -->
	<!-- 											<select id="listSize" name="listSize" onchange="reSelect()" de-data="이강준"> -->
	<!-- 												<option value="20">이호걸</option> -->
	<!-- 												<option value="20">이강준</option> -->
	<!-- 												<option value="50">이강준</option> -->
	<!-- 											</select> -->
	<!-- 										</div> -->
										</div>
									</div>
								</div> 
								<div class="bor-div">
									<div class="top-row table-input">
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">강좌명</div>
												<div>
													<input type="text" id="sel_subject_nm" name="sel_subject_nm" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
									</div> 
									
									<div class="top-row table-input">
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad2">강좌코드</div>
												<div>
													<input type="text" id="sel_subject_cd" name="sel_subject_cd" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">강사명</div>
												<div>
													<input type="text" id="sel_web_lecturer_nm" name="sel_web_lecturer_nm" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">상태</div>
												<div>
													<input type="text" id="sel_end_yn" name="sel_end_yn" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
									</div> 
									
									<div class="top-row table-input">
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit">정원</div>
												<div>
													<input type="text" id="sel_capacity_no" name="sel_capacity_no" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">현원</div>
												<div>
													<input type="text" id="sel_regis_no" name="sel_regis_no" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">대기자</div>
												<div>
													<input type="text" id="sel_wait_cnt" name="sel_wait_cnt" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
									</div> 
									
									<div class="top-row table-input">
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit">요일</div>
												<div>
													<input type="text" id="sel_day_flag" name="sel_day_flag" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">시간</div>
												<div>
													<input type="text" id="sel_lect_hour" name="sel_lect_hour" value="" class="inputDisabled inp-100 inptxt" readOnly>
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">기간</div>
												<div>
													<input type="text" id="sel_ymd" name="sel_ymd" value="" class="inputDisabled inp-100 inptxt">
												</div>
											</div>
										</div>
									</div> 
									
									
									<div class="top-row table-input">
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit">수강료</div>
												<div>
													<input type="text" id="sel_regis_fee" name="sel_regis_fee" value="0" class="inputDisabled inp-100 text-right inptxt">
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">재료비</div>
												<div>
													<input type="text" id="sel_food_amt" name="sel_food_amt" value="0" class="inputDisabled inp-100 text-right inptxt">
												</div>
											</div>
										</div>
										<div class="wid-3">
											<div class="table">
												<div class="sear-tit tit-pad">합계금액</div>
												<div>
													<input type="text" id="sel_total_pay" name="sel_total_pay" value="" class="inputDisabled inp-100 text-right inptxt">
												</div>
											</div>
										</div>
									</div> 
									
								</div> 	
								<div class="step2-btn text-center">
									<a class="btn btn02" onclick="javascript:partCancel()">취소 후 부분 입금</a>
									<a class="btn btn03" onclick="javascript:sendWait()">대기등록</a>
									<a class="btn btn01" onclick="javascript:goMoveLect()">강좌등록</a>
								</div>
								
							</div> <!--  //table-wr end -->
						
						</div>
						
					</div>
					
					<div class="mem02-arrow dis-no">
						<div class="move-arrow">
							<div class="down-btn" onclick="goMoveLect()"><i class="material-icons">arrow_drop_down</i></div>
							<!--   <div class="up-btn" onclick="goMoveLect('2')"><i class="material-icons">arrow_drop_up</i></div> -->
						</div>
					</div>
					
					<div class="white-bg">
						<h3 class="h3-tit">수강신청 리스트 <span id="input_lect_cnt" style="font-size: 0.7em;font-weight: 400;float: right;"></span></h3>
						<div class="table-wr">
							<div class="table-list table-list02 gray-chk">
								<table>
									<colgroup>
										<col />
										<col width="150px">
										<col />
										<col />
										<col />
										<col />
										<col />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th>강좌코드<i class="material-icons">import_export</i></th>
											<th>강좌명<i class="material-icons">import_export</i></th>
											<th>강좌횟수<i class="material-icons">import_export</i></th>
											<th>상태<i class="material-icons">import_export</i></th>
											<th>수강료<i class="material-icons">import_export</i></th>
											<th>재료비<i class="material-icons">import_export</i></th>
											<th>수강자<i class="material-icons">import_export</i></th>
											<th>할인<i class="material-icons">import_export</i></th>
										</tr>
									</thead>
									<tbody id="tb2_target">									
										<tr>									
											<td colspan="7"><div class="no-data">선택된 강좌가 없습니다.</div></td>
										</tr>								
									</tbody>							
										
									</tbody>
								</table>
							</div>
							
							<div class=" text-center" style="margin-top:30px;">
								<a class="btn btn02 ok-btn" onclick="insTempPere()">수강신청서 작성</a>
							</div>
							
						</div> <!-- //table-wr end -->
				
					</div> <!-- //white-bg end -->
					
					
				</div>
				
				<div class="wid-5 wid-5_last">
					<div class="mem-step mem-step03">
						<div class="step-tit">STEP 3 <span>결제</span></div>
<!-- 						<div class="step-smtit">할인선택</div> -->
						
						<div class="white-bg mem03-wrap ak-wrap_new">
							<div class="bor-div">
						
<!-- 								<div class="top-row"> -->
<!-- 									<div class="wid-10"> -->
<!-- 										<div class="table"> -->
<!-- 											<div class="sear-tit">합계금액</div> -->
<!-- 											<div> -->
<!-- 												<input type="text" id="encd_total_pay" name="encd_total_pay" value="" class="inputDisabled inp-100 text-right inptxt"> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
<!-- 								<div class="top-row table-input"> -->
<!-- 									<div class="wid-5"> -->
<!-- 										<div class="table"> -->
<!-- 											<div class="sear-tit">할인1</div> -->
<!-- 											<div id="selEnuri1_area"> -->
<!-- 												<select id="selEnuri1" name="selEnuri1" onchange="selEnuri()" de-data="선택하세요."> -->
<!-- 												</select> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 									<div class="wid-5"> -->
<!-- 										<div class="table"> -->
<!-- 											<div class="sear-tit sear-tit_120 sear-tit_left">할인2</div> -->
<!-- 											<div id="selEnuri2_area"> -->
<!-- 												<select id="selEnuri2" name="selEnuri2" onchange="selEnuri()" de-data="선택하세요."> -->
<!-- 												</select> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 									</div> -->
<!-- 								</div> -->
								
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">할인금액</div>
											<div>
												<input type="text" id="encd_pay" name="encd_pay" value="" class="inputDisabled inp-100 text-right inptxt">
											</div>
										</div>
									</div>
								</div> 
							</div>
						
						</div> <!-- // white-bg -->
						
						
						<div class="step-smtit b-top">포인트 선택</div>
						
						<div class="white-bg ">
							<div class="top-row">
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit">포인트</div>
										<div class="sear-cont">
											<div class="point-wid01">
												<div class="point-txt">가용 포인트</div>
												<div class="point-num" id="akmem_total_point">0 <span>원</span></div>
											</div>
											<div class="point-wid03">
												<div class="bar-inpt">
													<input type="text" id="point_amt" name="point_amt" value="0" class="inp-100 text-right comma" placeholder="0" onkeyup="onlyNumber(this,0);usePointCheck();">
													<i class="fas fa-barcode"></i>
												</div>
											</div>
											<div class="point-wid02">
<!-- 												<a class="point-btn" onclick="javascript:akmem_use();">사용</a> -->
											</div>
										
										</div>
									</div>
								</div>
								
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit"></div>
										
										<div>
	<!-- 										<a class="pass-btn" onclick="javascript:akmem_use();">비밀번호 요청</a> -->
										</div>
									</div>
								</div>
							</div> 
						
						</div> <!-- // white-bg -->
						
						<div class="total-wrap mem-slide_Wrap ak-wrap_new">
							<div>
								<div class="card-txt"><span>AK멤버스 포인트 </span><i class="material-icons">keyboard_arrow_down</i></div>
								<div class="card-slide" style="display:none;">
									<div class="bor-div">
										<div class="top-row">
											<div class="wid-5">			
												<ul class="chk-ul">
													<li>
														<input type="radio" id="akmem_card_fg1" name="akmem_card_fg" value="A" checked>
														<label for="akmem_card_fg1">swipe</label>
													</li>
													<li>
														<input type="radio" id="akmem_card_fg2" name="akmem_card_fg" value="@" checked>
														<label for="akmem_card_fg2">swipe</label>
													</li>
												</ul>
											</div>
												
											<div class="wid-5 card-btnwr">
												<a class="btn-a btn03" onclick="javascript:cardController('member');">카드조회</a>
												<a class="btn-a btn03" onclick="javascript:AKmem_getPoint('card');">멤버스조회</a>
												<a class="btn-a btn01" onclick="javascript:akmemDanMemReset();">초기화</a>
											</div>
										</div>
										<div class="top-row table-input">
											
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">카드번호</div>
													<div>
														<input type="text" id="akmem_card_no" name="akmem_card_no" value="" class=" inp-100" placeholder="">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">고객명</div>
													<div>
														<input type="text" id="akmem_card_name" name="akmem_card_name" value="" class=" inp-100" placeholder="">
													</div>
												</div>
											</div>
										
										</div>
										
										<div class="top-row ">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">카드유형</div>
													<div style="font-size:0;">
														<input type="text" id="akmem_card_type" name="akmem_card_type" value="" class=" wid-5" placeholder="">
														<input type="text" id="akmem_cust_grade" name="akmem_cust_grade" value="" class=" wid-5" placeholder="">
													</div>
												</div>
											</div>
										
										</div>
										
										
										
									</div>
								</div>
								
							</div>
								
								
							<div class="total-price">
								<div class="lt">
									결제할 금액(합계금액 - 할인합계)
								</div>
								<div class="rt">
									<div class="point-num" id="total_pay_span">0 <span>원</span></div>
								</div>
							</div>
							
						</div> <!-- // total-wrap -->
						
						<div class="step-smtit b-top">최종 결제수단선택</div>
						
						<div class="white-bg ak-wrap_new ">
							<div class="bor-div">
								<div class="top-row">
									<div class="wid-10">
										<div class="table">
											<div class="sear-tit">현금</div>
											<div>
												<input type="text" id="cash_amt" name="cash_amt" value="0" class=" inp-78 comma" onclick="" placeholder="입력하세요.">
												<a class="btn-a btn01" onclick="javascript:openCashLayer();">현금승인</a>
												<ul class="chk-ul">
													<li>
														<input type="checkbox" id="credit_yn" name="credit_yn" value="">
														<label for="credit_yn">COD 외상</label>
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>
								
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">모바일 상품권</div>
											<div>
												<div class="bar-inpt">
													<input type="text" id="mc_approve_no" name="mc_approve_no" value="" class="inp-30" placeholder="" onclick="openMCouponLayer()">
													<input type="text" id="mcoupon_amt" name="mcoupon_amt" value="0" class="inp-70"  onclick="openMCouponLayer()" style="margin-left:0px !important" placeholder="">
	<!-- 												<i class="fas fa-barcode"></i> -->
												</div>
											</div>
										</div>
									</div>
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit sear-tit_120 sear-tit_left">상품권</div>
											<div>
												<div class="bar-inpt">
													<input type="text" id="coupon_amt" name="coupon_amt" value="0" class="inp-100" placeholder="" onclick="openCouponLayer()">
	<!-- 												<i class="fas fa-barcode"></i> -->
												</div>
											</div>
										</div>
									</div>
								</div>
								
	<!-- 							<div class="top-row table-input"> -->
	<!-- 								<div class="wid-5"> -->
	<!-- 									<div class="table"> -->
	<!-- 										<div class="sear-tit">BC-QR</div> -->
	<!-- 										<div> -->
	<!-- <!-- 											<a class="btn-a btn01 btn-100" onclick="javascript:QRChipData();">조회</a> --> 
	<!-- 											<input type="text" id="inputQr" name="inputQr" onkeypress="excuteEnter(QRChipData)"> -->
	<!-- 										</div> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
	<!-- 								<div class="wid-5"> -->
	<!-- 									<div class="table"> -->
	<!-- 										<div class="sear-tit sear-tit_120 sear-tit_left">간편결제</div> -->
	<!-- 										<div> -->
	<!-- 											<select id="listSize" name="listSize" onchange="reSelect()" de-data="국민은행"> -->
	<!-- 												<option value="20">국민은행</option> -->
	<!-- 												<option value="20">국민은행</option> -->
	<!-- 												<option value="50">국민은행</option> -->
	<!-- 											</select> -->
	<!-- 										</div> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
									
	<!-- 							</div> -->
								<div class="top-row table-input">
									<div class="wid-5">
										<div class="table">
											<div class="sear-tit">거스름돈</div>
											<div>
												<input type="text" id="change" name="change" value="0">
											</div>
										</div>
									</div>
	<!-- 								<div class="wid-5"> -->
	<!-- 									<div class="table"> -->
	<!-- 										<div class="sear-tit sear-tit_120 sear-tit_left">카드결제</div> -->
	<!-- 										<div> -->
	<!-- 											<a class="btn-a btn01 btn-100" onclick="javascript:cardSelectFg('card')">결제하기</a> -->
	<!-- 										</div> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
								</div>
							</div>
						</div> <!-- // white-bg -->
						
						<div class="white-bg_last mem-slide_Wrap ak-wrap_new">
							<div>
								<div class="card-txt"><span>카드정보</span><i class="material-icons">keyboard_arrow_down</i></div>
								<div class="card-slide">
									<div class="bor-div">
										<div class="top-row">
											<div class="wid-3">			
												<ul class="chk-ul">
													<li>
														<input type="radio" id="payment_type1" name="payment_type" value="simple" onclick="paymentAction('simple');" checked>
														<label for="payment_type1">간편</label>
													</li>
													<li>
														<input type="radio" id="payment_type2" name="payment_type" value="normal" onclick="paymentAction('normal');">
														<label for="payment_type2">일반</label>
													</li>
												</ul>
											</div>
											<div class="wid-3 payment_div" id="payment_simple">
												<select id="simple_type" de-data="BC-QR">
													<option value="bc">BC-QR</option>
													<option value="naver">NAVER</option>
												</select>
											</div>
											<div class="wid-3 payment_div" id="payment_normal" style="display:none;">
												<select id="normal_type" de-data="IC-CARD">
													<option value="card">IC-CARD</option>
													<option value="samPay">삼성페이</option>
												</select>
											</div>
											<div class="wid-4 card-btnwr">
												<a class="btn-a btn01" onclick="javascript:cardDanMemReset();">초기화</a>
												<a class="btn-a btn02 payment_div" id="card_submit_btn" onclick="javascript:cardSelectFg('card');" style="display:none; ">등록하기</a>
												<a class="btn-a btn02 payment_div" id="keyin_submit_btn" onclick="javascript:cardSelectFg('keyin');" style="display:none;">KeyIn</a>
											</div>
										</div>
										<div class="top-row table-input">		
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">카드번호</div>
													<div>
														<input type="text" id="ic_card_no" name="ic_card_no" value="" class=" inp-100" placeholder="" onkeypress="excuteEnter(QRChipData)">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">카드회사</div>
													<div>
														<input type="text" id="ic_card_nm" name="ic_card_nm" value="" class=" inp-100" placeholder="">
													</div>
												</div>
											</div>									
										</div>
										<div class="top-row table-input">									
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">할부개월</div>
													<div>
														<input type="text" id="month" name="month" value="00" class=" inp-100" placeholder="">
													</div>
												</div>
											</div>		
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">입금액</div>
													<div>
														<input type="text" id="card_amt" name="card_amt" value="0" class=" inp-100" placeholder="">
													</div>
												</div>
											</div>									
										</div>
										<div class="top-row table-input">									
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">승인번호</div>
													<div>
														<input type="text" id="ic_card_approve_no" name="ic_card_approve_no" value="" class=" inp-100 notEmpty" placeholder="" data-name="결제정보">
													</div>
												</div>
											</div>
																			
										</div>
									</div>
									
									<div class="btn-wr text-center">
										<a class="btn btn02 ok-btn" onclick="javascript:autoSign('send');">승인번호 조회</a>
										<a class="btn btn03 ok-btn" onclick="javascript:fncSubmit();">결제하기</a>
									</div>
								</div>
							</div>
							
							
						</div>
						
	<!-- 					<div class="white-bg mem-gift"> -->
						
	<!-- 						<h3 class="h3-tit">사은품 선택</h3> -->
							
	<!-- 						<div class="top-row"> -->
	<!-- 							<div class="wid-10"> -->
	<!-- 								<div class="table"> -->
	<!-- 									<div class="sear-tit">사은품1</div> -->
	<!-- 									<div> -->
	<!-- 										<select id="selGift1" name="selGift1" de-data="선택하세요."> -->
	<!-- 										</select> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
	<!-- 							</div>						 -->
	<!-- 						</div> -->
							
	<!-- 						<div class="top-row"> -->
	<!-- 							<div class="wid-10"> -->
	<!-- 								<div class="table"> -->
	<!-- 									<div class="sear-tit">사은품2</div> -->
	<!-- 									<div> -->
	<!-- 										<select id="selGift2" name="selGift2" de-data="선택하세요."> -->
	<!-- 										</select> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
	<!-- 							</div>						 -->
	<!-- 						</div> -->
							
	<!-- 						<div class="btn-wr text-center"> -->
	<!-- 							<a class="btn btn02 ok-btn" onclick="javascript:give_gift();">사은품지급</a> -->
	<!-- 						</div> -->
						
						
						
						
	<!-- 					</div> // white-bg -->
						
					</div>
				</div>
			</div>
		
		
		
		</div> <!-- //table-wr_mem02 end -->
		
	</div>
	<input type="hidden" id="total_pay" name="total_pay">
	<input type="hidden" id="regis_fee" name="regis_fee">
	<input type="hidden" id="food_amt" name="food_amt">
	<input type="hidden" id="chk_subject_cd" name="chk_subject_cd">
	<input type="hidden" id="card_data_fg" name="card_data_fg">
	<input type="hidden" id="encCardNo_send_str" name="encCardNo_send_str">
	<input type="hidden" id="sign_data" name="sign_data">
	<input type="hidden" id="card_id" name="card_id">
	<input type="hidden" id="card_co_origin_seq" name="card_co_origin_seq">
</form>

<div id="cancel_list_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#cancel_list_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">결제취소 이력</h3>
					<div class="table-wr">
						<div class="table-cap table">
							<div class="cap-l">
								<p class="cap-numb"></p>
							</div>
							<div class="cap-r text-right">
								<div class="table table02 table-auto float-right">
									
									<div>
										<p class="ip-ritit">선택한 항목을</p>
									</div>	
									<div class="sel-scr">							
										<a href="#" class="btn btn02 mrg-lr6"><i class="material-icons">receipt</i>영수증 재발행</a>
										<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a>										
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
						</div>
						<div class="billing-history">
							<div class="table-list">
								<table>
									<colgroup>
										<col width="40px">
										<col>
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
											<th class="td-chk">
												<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
											</th>
											<th>지점 <i class="material-icons">import_export</i></th>
											<th>기수 <i class="material-icons">import_export</i></th>
											<th>결제일자 <i class="material-icons">import_export</i></th>
											<th>결제구분 <i class="material-icons">import_export</i></th>
											<th>포스번호 <i class="material-icons">import_export</i></th>
											<th>영수증번호 <i class="material-icons">import_export</i></th>
											<th>결제수단 <i class="material-icons">import_export</i></th>
											<th>강좌코드 <i class="material-icons">import_export</i></th>
											<th>강좌명 <i class="material-icons">import_export</i></th>
											<th>강사명 <i class="material-icons">import_export</i></th>
											<th>수강자 <i class="material-icons">import_export</i></th>
											<th>재료비 <i class="material-icons">import_export</i></th>
											<th>할인 <i class="material-icons">import_export</i></th>
											<th>수강료 <i class="material-icons">import_export</i></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="td-chk">
												<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label>
											</td>
											<td>분당점</td>
											<td>052</td>
											<td>2019-09-02</td>
											<td>WEB</td>
											<td>-</td>
											<td>-</td>
											<td>카드</td>
											<td>135095</td>
											<td>중장년을 위한 노화방지 요가</td>
											<td>김명진</td>
											<td>본인</td>
											<td class="text-right bg-gray">0</td>
											<td class="text-right">0</td>
											<td class="text-right bg-red">90,000</td>
										</tr>
										
										<tr>
											<td class="td-chk">
												<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label>
											</td>
											<td>분당점</td>
											<td>052</td>
											<td>2019-09-02</td>
											<td>WEB</td>
											<td>-</td>
											<td>-</td>
											<td class="multi">복합  <i class="material-icons">message</i>
										   		<div class="multi-pop">카드 + 상품권</div>
										   	</td>
											<td>135095</td>
											<td>중장년을 위한 노화방지 요가</td>
											<td>김명진</td>
											<td>본인</td>
											<td class="text-right bg-gray">0</td>
											<td class="text-right">0</td>
											<td class="text-right bg-red">90,000</td>
										</tr>
										
										<tr>
											<td class="td-chk">
												<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label>
											</td>
											<td>분당점</td>
											<td>052</td>
											<td>2019-09-02</td>
											<td>WEB</td>
											<td>-</td>
											<td>-</td>
											<td class="multi">복합  <i class="material-icons">message</i>
										   		<div class="multi-pop">카드 + 상품권</div>
										   	</td>
											<td>135095</td>
											<td>중장년을 위한 노화방지 요가</td>
											<td>김명진</td>
											<td>본인</td>
											<td class="text-right bg-gray">0</td>
											<td class="text-right">0</td>
											<td class="text-right bg-red">90,000</td>
										</tr>
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

<script>

$(document).ready(function(){
	//강좌리스트 검색을위한 기수 리스트 
	getPeriByStore();
	//강좌리스트 검색을위한 기수 리스트
	
	//대기자에서 넘어온경우 회원과 강좌를 셋팅한다
	if('${isWait}' == 'true')
	{
		if('${cust_no}' != '0')
		{
			choose_confirm('${cust_no}');
		}
		
		getLectSearch('wait');
	}
	//대기자에서 넘어온경우 회원과 강좌를 셋팅한다
	
});



function save_cus_info()
{
	
		if(!confirm("등록하시겠습니까?")){
			return;
		}
	
		var sex_fg="";
		var marry_fg="";
		var email_yn="";
		var sms_yn="";
		

		
		var post_value=$('#postcode').val();
		var post1_val = post_value.substr(0,3);
		var post2_val = post_value.substr(3);
		 
		 if($('#rad-male').prop("checked")==1) {
			 sex_fg="M";
		 }else if($('#rad-female').prop("checked")==1){
			 sex_fg="F";
		 }
		 
		 if($('#married_a').prop("checked")==1) {
			 marry_fg="1";
		 }else if($('#married_b').prop("checked")==1){
			 marry_fg="2";
		 }
		 
		 
		 if($('#email_chk').prop("checked")==1) {
			 email_yn="Y";
		 }else{
			 email_yn="N";
		 }
		 
		 if($('#sms_chk').prop("checked")==1) {
			 sms_yn="Y";
		 }else{
			 sms_yn="N";
		 }
		 

		 
		 $.ajax({
				type : "POST", 
				url : "./write_proc",
				dataType : "text",
				async : false,
				data : 
				{
					
					kor_nm:$('#kor_nm').val(),
					eng_nm:eng_nm,
					birth_ymd:$('#birth_ymd').val(),
					sex_fg:sex_fg,
					marry_fg:marry_fg,
					marry_ymd:$('#marry_ymd').val(),
					post_no1:post1_val,
					post_no2:post2_val,
					addr_tx1:$('#addr_tx1').val(),
					addr_tx2:$('#addr_tx2').val(),
					phone_no:$('#phone_no').val(),
					h_phone_no_1:$('#h_phone_no_1').val(),
					h_phone_no_2:$('#h_phone_no_2').val(),
					h_phone_no_3:$('#h_phone_no_3').val(),
					email_addr:$('#email_addr').val(),
					email_yn:email_yn,
					sms_yn:sms_yn,
					point_no:$('#card_no').val(),
					ptl_id:$('#ptl_id').val(),
					cus_no:$("#searchResult").val(),
					ptl_pw:ptl_pw,
					di:di,
					ci:ci,
					car_no: $('#car_no').val(),
					memo_cont : $('#memo_cont').val(),
					auth_chk:"Y"
					
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
	    			location.reload();
				}
			});
	
}

</script>







<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>