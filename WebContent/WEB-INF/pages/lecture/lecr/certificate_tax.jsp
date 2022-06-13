<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
$(document).ready(function(){
	setBundang();
	$("#chk_all").change(function() {
		if($("input:checkbox[name='chk_all']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", false);
		}
	});
});
var isLoading = false;
function selPeri()
{
	if($("#selBranch").val() == "02")
	{
		$("#ak_biz_no").val('124-81-28579');
		$("#ak_biz_nm").val('수원애경역사 (주)');
		$("#ak_biz_addr").val('경기도 수원시 팔달구 덕영대로 924, 1층(매산로 1가)');
	}
	if($("#selBranch").val() == "03")
	{
		$("#ak_biz_no").val('129-85-42346');
		$("#ak_biz_nm").val('에이케이에스앤디 (주)');
		$("#ak_biz_addr").val('경기도 성남시 분당구 황새울로360번길 42, 1층(서현동)');
	}
	if($("#selBranch").val() == "04")
	{
		$("#ak_biz_no").val('378-85-01457');
		$("#ak_biz_nm").val('에이케이에스앤디(주) AK평택점');
		$("#ak_biz_addr").val('경기도 평택시 평택로 51, 1층(평택동)');
	}
	if($("#selBranch").val() == "05")
	{
		$("#ak_biz_no").val('224-85-23362');
		$("#ak_biz_nm").val('에이케이에스앤디(주) AK원주점');
		$("#ak_biz_addr").val('강원도 원주시 봉화로 1, 1층(단계동)');
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
function getList()
{
	if($("#sel_lecturer_nm").val() == "")
	{
		alert("강사명을 입력해주세요.");
		return
	}
	else
	{
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getTax",
			dataType : "text",
			data : 
			{
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				lecturer_nm : $("#sel_lecturer_nm").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				var inner = "";
				if(result.length > 1)
				{
					for(var i = 0; i < result.length; i++)
					{
						inner += '<tr onclick="selUser(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
							inner += '	<td>'+result[i].WEB_LECTURER_NM+" | "+result[i].CUS_NO+'</td>';
						inner += '</tr>';
					}
					$("#tb_target").html(inner);
					$("#search_layer").fadeIn(200);
				}
				else if(result.length == 1)
				{
					selUser(encodeURI(JSON.stringify(result[0])));
				}
				else
				{
					alert("검색결과가 없습니다.");
				}
				getListEnd();
			}
		});	
	}
}

function selUser(ret)
{
	$('#search_layer').fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
 	$("#lecturer_cd").val(result.LECTURER_CD);
 	$("#lecturer_nm").val(result.WEB_LECTURER_NM);
 	$("#cus_address").val("("+nullChk(result.PSNO)+") "+nullChk(result.PNADD)+" "+nullChk(result.DTS_ADDR));
 	$("#biz_no").val(result.BIZ_NO);
 	$("#biz_nm").val(result.BIZ_NM);
 	$("#biz_addr_tx").val("("+result.BIZ_POST_NO+") "+result.BIZ_ADDR_TX);
 	
 	$("#store").val(result.STORE);
 	$("#period").val(result.PERIOD);
 	$("#corp_fg").val(result.CORP_FG);
 	$("#cus_no").val(result.CUS_NO);
 	
 	$.ajax({
		type : "POST", 
		url : "./getTaxDetail",
		dataType : "text",
		async : false,
		data : 
		{
			store : result.STORE,
			period : result.PERIOD,
			corp_fg : result.CORP_FG,
			lecturer_cd : result.LECTURER_CD
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			if(result.length > 0)
			{
				for(var i = 0; i < result.length; i++)
				{
					var tax_rate = 0;
					if(result.CORP_FG == "1") { tax_rate = 0; }
					else { tax_rate = 3; }
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="val_'+trim(result[i].SUBJECT_CD)+'_'+i+'" name="chk_val"><label for="val_'+trim(result[i].SUBJECT_CD)+'_'+i+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+cutDate(result[i].ACCT_SLIP_YMD)+'</td>';
					inner += '	<td>'+comma(nullChkZero(result[i].LECT_PAY))+'</td>';
					inner += '	<td>'+tax_rate+'</td>';
					inner += '	<td>'+comma(nullChkZero(result[i].INCOME_TAX))+'</td>';
					inner += '	<td>'+comma(nullChkZero(result[i].RESI_TAX))+'</td>';
					inner += '	<td class="bg-red">'+comma(nullChkZero(result[i].NET_LECT_PAY))+'</td>';						
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="7"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target").html(inner);
		}
	});	
 	
}
function fncSubmit()
{
	if($("#lecturer_nm").val() == "")
	{
		alert("강사검색을 해주세요.");
		return;
	}
	var subject_list = "";
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
	    	var this_id = $(this).attr("id").split("_")[1];
	    	subject_list += this_id+"|";
    	}
	});
	if(subject_list == "")
	{
		alert("발급할 대상을 선택해주세요.");
		return;
	}
	$("#subject_list").val(subject_list);
	var gsWin = window.open("about:blank", "winName");
	var frm = document.getElementById("fncForm");
	frm.target = "winName";
	frm.submit();
}
</script>

<div class="sub-tit">
	<h2>원천징수영수증 발급</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"><li>강사관리</li><li>증명서 관리</li><li>원천징수 영수증 발급</li></ul>
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
<!-- 		<div class="wid-25"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">그룹</div> -->
<!-- 				<div> -->
<!-- 					<select id="hq" name="hq" de-data="[00] 애경유통"> -->
<!-- 						<option value="00">[00] 애경유통</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="wid-3">
			<div class="table">
				<div class="wid-35" style="width:100% !important">
					<div class="table table02 table-input wid-contop">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-2">
			<div class="table">
				<div class="sear-tit sear-tit-70">강사명</div>
				<div>
					<input type="text" class="" id="sel_lecturer_nm" name="sel_lecturer_nm" placeholder="강사명을 입력하세요.">
				</div>
			</div>
		</div>
	</div>
	
	<div class="top-row sear-wr">
		
<!-- 		<div class="wid-2 mag-l4"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">강사번호</div> -->
<!-- 				<div> -->
<!-- 					<input type="text" class="" id="sel_lecturer_cd" name="sel_lecturer_cd" placeholder="강사번호를 입력하세요."> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		
<!-- 		<div class="wid-5 mag-l4"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit_120">출력용도</div> -->
<!-- 				<div> -->
<!-- 					<ul class="chk-ul chk-ul-fg"> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="print_fg_2" name="print_fg" value="2" checked=""> -->
<!-- 							<label for="print_fg_2">발행자 보관용</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="print_fg_1" name="print_fg" value="1"> -->
<!-- 							<label for="print_fg_1">발행자 보고용</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="print_fg_1" name="print_fg" value="1"> -->
<!-- 							<label for="print_fg_1">소득자 보관용</label> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<input type="radio" id="print_fg_1" name="print_fg" value="1"> -->
<!-- 							<label for="print_fg_1">소득자 보고용</label> -->
<!-- 						</li> -->
						
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	
	</div>
	
	
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
</div>



<div class="table-top table-top02 tab-topb">
	<h3>징수의무자</h3><br>
	<div class="top-row sear-wr">
		<div class="wid-2 mag-r2">
			<div class="table">
				<div class="sear-tit sear-tit_120">사업자등록번호</div>
				<div>
					<input type="text" class="inputDisabled" id="ak_biz_no" name="" value="12-985-42346" readOnly/>
				</div>
			</div>
		</div>
		<div class="wid-2 mag-l4">
			<div class="table">
				<div class="sear-tit sear-tit_70">법인명</div>
				<div>
					<input type="text" class="inputDisabled" id="ak_biz_nm" name="" value="AK S&D(주) AK분당점" readOnly/>
				</div>
			</div>
		</div>
		<div class="wid-2 mag-l4">
			<div class="table">
				<div class="sear-tit sear-tit_70">성명</div>
				<div>
					<input type="text" class="inputDisabled" id="kor_nm" name="" value="김재천" readOnly/>
				</div>
			</div>
		</div>
		<div class="wid-3 mag-l2">
			<div class="table">
				<div class="sear-tit sear-tit_70">주소</div>
				<div>
					<input type="text" class="inputDisabled inp-100" id="ak_biz_addr" name="" value="경기도 성남시 분당구 황새울로 360번길 42" readOnly/>
				</div>
			</div>
		</div>
	</div>

	
</div>

<form id="fncForm" name="fncForm" method="POST" action="./tax">
	<input type="hidden" id="store" name="store">
	<input type="hidden" id="period" name="period">
	<input type="hidden" id="subject_list" name="subject_list">
	<input type="hidden" id="corp_fg" name="corp_fg">
	<input type="hidden" id="cus_no" name="cus_no">
	<div class="table-top table-top02 tab-topb">
		<h3>소득자</h3>
		<div class="member-profile lecture-profile active">
			<div class="table-list ak-wrap_new">
				<div class="row">
					<div class="wid-5">
						<div class="bor-div">
						
							<div class="top-row table-input">
								<div class="wid-5">
									<div class="table">
										<div class="sear-tit">강사명</div>
										<div>
											<input type="text" class="inputDisabled" id="lecturer_nm" name="lecturer_nm" value="" readOnly/>
										</div>
									</div>
								</div>
								<div class="wid-5">
									<div class="table">
										<div class="sear-tit sear-tit_120 sear-tit_left">강사주민번호</div>
										<div>
											<input type="text" class="inputDisabled" id="lecturer_cd" name="lecturer_cd" value="" readOnly/>
										</div>
									</div>
								</div>
							</div>
							<div class="top-row table-input">
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit-top">주소1</div>
										<div>
											<input type="text" id="cus_address" name="cus_address" class="inputDisabled inp-100" value="" placeholder="" readOnly>
										</div>
									</div>
								</div>						
							</div>
	<!-- 						<div class="top-row table-input"> -->
	<!-- 							<div class="wid-10"> -->
	<!-- 								<div class="table"> -->
	<!-- 									<div class="sear-tit sear-tit-top">주소2</div> -->
	<!-- 									<div> -->
	<!-- 										<input type="text" id="biz_addr_tx1" name="cus_address_3" class="inputDisabled inp-100" value="경기도 성남시 분당구 황새울로 360번길 42" placeholder="" readOnly> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
	<!-- 							</div>						 -->
	<!-- 						</div> -->
						</div>
						
					</div> <!-- wid-5 end -->
					
					<div class="wid-5 wid-5_last">
						<div class="bor-div">
						
							<div class="top-row table-input">
								<div class="wid-5">
									<div class="table">
										<div class="sear-tit">상호</div>
										<div>
											<input type="text" class="inputDisabled" id="biz_nm" name="biz_nm" value="" readOnly/>
										</div>
									</div>
								</div>
								<div class="wid-5">
									<div class="table">
										<div class="sear-tit sear-tit_120 ">사업자등록번호</div>
										<div>
											<input type="text" class="inputDisabled" id="biz_no" name="biz_no" value="" readOnly/>
										</div>
									</div>
								</div>
							</div>
							<div class="top-row table-input">
								<div class="wid-10">
									<div class="table">
										<div class="sear-tit sear-tit-top">주소1</div>
										<div>
											<input type="text" id="biz_addr_tx" name="biz_addr_tx" class="inputDisabled inp-100" value="" placeholder="" readOnly>
										</div>
									</div>
								</div>						
							</div>
	<!-- 						<div class="top-row table-input"> -->
	<!-- 							<div class="wid-10"> -->
	<!-- 								<div class="table"> -->
	<!-- 									<div class="sear-tit sear-tit-top">주소2</div> -->
	<!-- 									<div> -->
	<!-- 										<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" value="경기도 성남시 분당구 황새울로 360번길 42" placeholder="" readOnly> -->
	<!-- 									</div> -->
	<!-- 								</div> -->
	<!-- 							</div>						 -->
	<!-- 						</div> -->
						</div>
						
					</div> <!-- wid-5_last end -->
					
				</div>
			</div>
		</div>
		
	</div>
</form>


<div class="table-wr table-top table-top02 tab-topb">	
	<h3>지급</h3>	<br>
	<div class="table-list certi-table" style="padding:0;">
		
		<table>

			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th>지급일</th>
					<th>지급총액</th>
					<th>세율</th>
					<th>소득세</th>
					<th>주민세</th>
					<th>실지급액</th>					
				</tr>
			</thead>
			<tbody id="list_target">
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>2020-02-20</td> -->
<!-- 					<td>4,800,000</td> -->
<!-- 					<td>3</td> -->
<!-- 					<td>144,000</td>	 -->
<!-- 					<td>14,400</td>	 -->
<!-- 					<td class="bg-red">4,800,000</td>						 -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>2020-02-20</td> -->
<!-- 					<td>4,800,000</td> -->
<!-- 					<td>3</td> -->
<!-- 					<td>144,000</td>	 -->
<!-- 					<td>14,400</td>	 -->
<!-- 					<td class="bg-red">4,800,000</td>						 -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>2020-02-20</td> -->
<!-- 					<td>4,800,000</td> -->
<!-- 					<td>3</td> -->
<!-- 					<td>144,000</td>	 -->
<!-- 					<td>14,400</td>	 -->
<!-- 					<td class="bg-red">4,800,000</td>						 -->
<!-- 				</tr> -->
			
			</tbody>
			
		</table>
	</div>
</div>

<p class="imp-red">* 위의 원천징수세액(수급금액)을 정히 영수(지급)합니다. 출력시 세금계산서 양식으로 출력됩니다.</p>

<div class="btn-wr text-center">
	<a class="btn btn02" onclick="javascript:fncSubmit();">발급하기</a>
</div>

<div id="search_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#search_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">강사 조회</h3>
       				<table class="cursor-table">
						<tbody id="tb_target">									
						</tbody>
					</table>
	        	</div>
        	</div>
        </div>
    </div>	
</div>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>