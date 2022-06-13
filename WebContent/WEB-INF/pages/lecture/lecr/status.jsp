<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>

$(function(){
	/* 알림톡 팝업 */
	$(".tm-custlist > table > tbody > tr").each(function(){
		var mult = $(this).find(".tm-radi");
		var mpop = $(this).find(".sms-pop");
		
		mult.click(function(){
			if(mpop.css("display") == "none"){
				mpop.css("display","block");
				mult.addClass("act");
			}else{
				mpop.css("display","none");
				mult.removeClass("act");
			}
		})
	});
});

$(document).ready(function(){
	if ("${login_rep_store}"!='') 
	{
		$('#selBranch').val("${login_rep_store}");
		$('.selBranch').text("${login_rep_store_nm}");
	}
	
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
	$('#status').val('P');
	$('.status').text('심사전');
	
});

$(window).ready(function(){
	$("#banner").on('change',function(){
	  var fileName = $("#banner").val();
	  $(".upload-name").val(fileName);
	});
	getList();
	
	
	
	
});

function getList(paging_type)
{
	getListStart();
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("search_type", $("#search_type").val(), 9999);
	setCookie("aply_type", $("#aply_type").val(), 9999);
	setCookie("status", $("#status").val(), 9999);
	setCookie("start_ymd", $("#start_ymd").val(), 9999);
	setCookie("end_ymd", $("#end_ymd").val(), 9999);
	
	$.ajax({
		type : "POST", 
		url : "./getApplyList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $('#selBranch').val(),
			aply_type : $('#aply_type').val(),
			status : $('#status').val(),
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			start_ymd : $('#start_ymd').val(),
			end_ymd : $('#end_ymd').val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					
					inner += '		<input type="checkbox" id="val_'+nullChk(result.list[i].REG_NO)+'" name="chk_val" value="'+nullChk(result.list[i].CUST_NO+'_'+result.list[i].REG_NO)+'"><label for="val_'+nullChk(result.list[i].REG_NO)+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].APLY_TYPE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].APLY_STORE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].LEC_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].KOR_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].NTR_DC)+'</td>';
					//inner += '	<td class="color-blue line-blue" onclick="javascript:transPop()" style="cursor:pointer;">회화를 위한 기초 영문법</td>';
					inner += '	<td class="open02"><a href="./detail?reg_no='+result.list[i].REG_NO+'&cust_no='+result.list[i].CUST_NO+'"><span>계획서 보기</span></a></td>';
					inner += '	<td>'+nullChk(result.list[i].SUBMIT_DATE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STATUS)+'</td>';
					if(nullChk(result.list[i].REVIEW) != "")
					{
						inner += '	<td class="open02">';
						inner += '		<span onclick="openReview(\''+nullChk(result.list[i].CUST_NO)+'_'+nullChk(result.list[i].REG_NO)+'\')">심사평 수정</span>';
					}
					else
					{
						inner += '	<td class="open">';
						inner += '		<span onclick="openReview(\''+nullChk(result.list[i].CUST_NO)+'_'+nullChk(result.list[i].REG_NO)+'\')">심사평 작성</span>';
						
					}
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].UPDATE_DATE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MANAGER)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="13"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			if(paging_type == "scroll")
			{
				if(result.list.length > 0)
				{
					$("#list_target").append(inner);
				}
			}
			else
			{
				$("#list_target").html(inner);
			}
			//$("#list_target").html(inner);
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});	
}

function writePage()
{
	$('#write_layer').fadeIn(200);	
}

function openReview(val)
{
	var arr= val.split('_');
	$("#cust_no").val(arr[0]);
	$("#reg_no").val(arr[1]);
	$.ajax({
		type : "POST", 
		url : "./getReview",
		dataType : "text",
		async : false,
		data : 
		{
			cust_no : arr[0],
			reg_no : arr[1]
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$("#review").val(repWord(nullChk(result.REVIEW)));
		}
	});	
	$("#review_layer").fadeIn(200);
}

function saveReview()
{
	$("#fncForm").ajaxSubmit({
		success: function(data)
		{
			console.log(data);
			var result = JSON.parse(data);
    		if(result.isSuc == "success")
    		{
    			alert(result.msg);
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});
}

function pass_process(){
	
	var f = document.getElementsByName('chk_val');
	var chk_list="";
	for (var i = 0; i < f.length; i++) {
		if(f[i].checked==true){
			chk_list +=f[i].value+'|';
		}
	}
	
	if (chk_list.length==0) {
		alert("반영할 지원서를 선택해주세요.");
		return;
	}
	
	chk_list = chk_list.slice(0,-1); 
	$.ajax({
		type : "POST", 
		url : "./doPass",
		dataType : "text",
		async : false,
		data : 
		{
			passValue : $("#passValue").val(),
			chk_list : chk_list
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			getList();
		}
	});
}

function apply_delete(){
	
	if(!confirm("정말 삭제하시겠습니까?")){
		return;
	}
	
	var f = document.getElementsByName('chk_val');
	var chk_list="";
	for (var i = 0; i < f.length; i++) {
		if(f[i].checked==true){
			chk_list +=f[i].value+'|';
		}
	}
	
	if (chk_list.length==0) {
		alert("반영할 지원서를 선택해주세요.");
		return;
	}
	
	chk_list = chk_list.slice(0,-1); 
	$.ajax({
		type : "POST", 
		url : "./doDelete",
		dataType : "text",
		async : false,
		data : 
		{
			chk_list : chk_list
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			getList();
		}
	});
}


function transPop()
{
	$('#trans_layer').fadeIn(200);	
}
</script>

<div class="sub-tit">
	<h2>강사 지원 현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>	
</div>

<div class="table-top table-top02">
	<div class="top-row">
		<div class="table table-auto sear-wr">
			<div class="wid-4">
				<div class="table table-auto ">
					<div>
						<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</div>
					<div>
						<select id="aply_type" name="aply_type" de-data="전체"> 
							<option value="">전체</option>
							<option value="C">일반</option>
							<option value="S">시그니처</option>
						</select> 
					</div>
					<div>
						<select id="status" name="status" de-data="전체"> 
							<option value="">전체</option>
							<option value="P">심사전</option>
							<option value="S">합격</option>
							<option value="F">불합격</option>
						</select> 
					</div>
				</div>
			</div>
			
			<div class="wid-6 lect-st">
				<div class="search-wr sel100">
					<select id="search_type" name="search_type" de-data="검색항목">
						<option value="kor_nm">이름</option>
						<option value="email_addr">이메일</option>
						<option value="phone_no">휴대폰번호</option>
					</select>
				    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
				    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
				</div>
			</div>
		</div>
	</div>
	<div class="top-row">
		<div class="wid-4">
			<div class="table table-input">
				<div class="sear-tit sear-tit sear-tit_90">조회기간</div>
				<div>
					<div class="cal-row">
						<div class="cal-input cal-input02 cal-input_rec">
							<input type="text" class="date-i start-i" id="start_ymd" value=""/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input cal-input02 cal-input_rec">
							<input type="text" class="date-i ready-i" id="end_ymd" value=""/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	
	
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
</div>
<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="table float-right margin-auto">
			<a class="bor-btn btn03 mrg-l6" onclick="apply_delete();" style="background-color: #111a3b; background: #111a3b; border:solid 1px #111a3b">삭제</a>
			<div>
				<select id="passValue" de-data="불합격 처리하기">
					<option value="F">불합격 처리하기</option>
					<option value="S">합격 처리하기</option>
				</select>					
			</div>
			<div class="sel-scr">
				<a class="bor-btn btn03 mrg-l6" onclick="pass_process();">반영</a>
				<a class="bor-btn btn01 mrg-l6" href="#"><i class="fas fa-file-download"></i></a>
				<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
					<option value="10">10개 보기</option>
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
<div class="table-wr ip-list">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col width="300px">
				<col>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th>번호</th>
					<th onclick="reSortAjax('sort_aply_type')">구분<img src="/img/th_up.png" id="sort_aply_type"></th>
					<th onclick="reSortAjax('sort_aply_store')">지점<img src="/img/th_up.png" id="sort_aply_store"></th>
					<th onclick="reSortAjax('sort_lec_nm')">강좌명<img src="/img/th_up.png" id="sort_lec_nm"></th>
					<th onclick="reSortAjax('sort_kor_nm')">강사명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_ntr_dc')">성별<img src="/img/th_up.png" id="sort_ntr_dc"></th>
					<th class="td-220">강의 계획서</th>
					<th class="td-120" onclick="reSortAjax('sort_submit_date')">지원일자<img src="/img/th_up.png" id="sort_submit_date"></th>
					<th onclick="reSortAjax('sort_status')">결과<img src="/img/th_up.png" id="sort_status"></th>
					<th>심사현황</th>
					<th onclick="reSortAjax('sort_update_date')">처리일자<img src="/img/th_up.png" id="sort_update_date"></th>
					<th onclick="reSortAjax('sort_manager')">담당자<img src="/img/th_up.png" id="sort_manager"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list tm-custlist">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col width="60px">
				<col>
				<col width="300px">
				<col>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th>번호</th>
					<th onclick="reSortAjax('sort_aply_type')">구분<img src="/img/th_up.png" id="sort_aply_type"></th>
					<th onclick="reSortAjax('sort_aply_store')">지점<img src="/img/th_up.png" id="sort_aply_store"></th>
					<th onclick="reSortAjax('sort_lec_nm')">강좌명<img src="/img/th_up.png" id="sort_lec_nm"></th>
					<th onclick="reSortAjax('sort_kor_nm')">강사명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_ntr_dc')">성별<img src="/img/th_up.png" id="sort_ntr_dc"></th>
					<th class="td-220">강의 계획서</th>
					<th class="td-120" onclick="reSortAjax('sort_submit_date')">지원일자<img src="/img/th_up.png" id="sort_submit_date"></th>
					<th onclick="reSortAjax('sort_status')">결과<img src="/img/th_up.png" id="sort_status"></th>
					<th>심사현황</th>
					<th onclick="reSortAjax('sort_update_date')">처리일자<img src="/img/th_up.png" id="sort_update_date"></th>
					<th onclick="reSortAjax('sort_manager')">담당자<img src="/img/th_up.png" id="sort_manager"></th>
				</tr>
			</thead>
			<tbody id="list_target">
				
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>12078</td> -->
<!-- 					<td>분당점</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>김포스</td> -->
<!-- 					<td>일요 밸런스 요가</td> -->
<!-- 					<td>2019-06-01</td> -->
<!-- 					<td class="open"><span>심사평 작성</span></td> -->
<!-- 					<td class="tm-radi"><span>SMS</span><span>TM</span> -->
<!-- 						<div class="sms-pop"> -->
<!-- 							<div class="sms-con01">010-2334-6740</div> -->
<!-- 							<div class="sms-con02"> -->
<!-- 								내용 -->
<!-- 							<span>통화메모를 남길 수 있습니다.</span> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="sms-pop"> -->
<!-- 							<div class="sms-con01">010-2334-6740</div> -->
<!-- 							<div class="sms-con02"> -->
<!-- 								내용 -->
<!-- 							<span>통화메모를 남길 수 있습니다.</span> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>12078</td> -->
<!-- 					<td>분당점</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>김포스</td> -->
<!-- 					<td>일요 밸런스 요가</td> -->
<!-- 					<td>2019-06-01</td> -->
<!-- 					<td class="open"><span>심사평 작성</span></td> -->
<!-- 					<td class="tm-radi"><span>SMS</span><span>TM</span> -->
<!-- 						<div class="sms-pop"> -->
<!-- 							<div class="sms-con01">010-2334-6740</div> -->
<!-- 							<div class="sms-con02"> -->
<!-- 								내용 -->
<!-- 							<span>통화메모를 남길 수 있습니다.</span> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="sms-pop"> -->
<!-- 							<div class="sms-con01">010-2334-6740</div> -->
<!-- 							<div class="sms-con02"> -->
<!-- 								내용 -->
<!-- 							<span>통화메모를 남길 수 있습니다.</span> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>12078</td> -->
<!-- 					<td>분당점</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>김포스</td> -->
<!-- 					<td>일요 밸런스 요가</td> -->
<!-- 					<td>2019-06-01</td> -->
<!-- 					<td class="open02"><span>심사평 작성</span></td> -->
<!-- 					<td class="tm-radi"><span>SMS</span><span>TM</span> -->
<!-- 						<div class="sms-pop"> -->
<!-- 							<div class="sms-con01">010-2334-6740</div> -->
<!-- 							<div class="sms-con02"> -->
<!-- 								내용 -->
<!-- 							<span>통화메모를 남길 수 있습니다.</span> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 						<div class="sms-pop"> -->
<!-- 							<div class="sms-con01">010-2334-6740</div> -->
<!-- 							<div class="sms-con02"> -->
<!-- 								내용 -->
<!-- 							<span>통화메모를 남길 수 있습니다.</span> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				
				
				
				
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>

<div id="write_layer" class="write-contwrap list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3>계약조건 및 계약서</h3>        			
        			<div class="table-top bg01 lec-contwr">
        				<div class="top-row">
        					<div class="wid-3">	        						
								<div class="table">
									<div class="sear-tit">강사명</div>
									<div>
										<input type="text" id="" name="" value="">
									</div>
								</div>									
        					</div>
        					<div class="wid-3 mag-l4">	        						
								<div class="table">
									<div class="sear-tit">강의명</div>
									<div>
										<input type="text" id="" name="" value="">
									</div>
								</div>									
        					</div>
        					<div class="wid-35 mag-l4">	        						
								<div class="table">
									<div class="sear-tit sear-tit_120">강사료 지급 방법</div>
									<div>
										<input type="text" id="" name="" value="">
									</div>
								</div>									
        					</div>
        				</div>
        				
       					<div class="top-row">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">강의기간</div>
									<div>
										<div class="cal-row">
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="start_ymd" name="start_ymd">
												<i class="material-icons">event_available</i>
											</div>
											<div class="cal-dash wid-1">-</div>
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="end_ymd" name="end_ymd">
												<i class="material-icons">event_available</i>
											</div>
										</div>
									</div>
								</div>
							</div>
							
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">강의시간</div>
									<div>
										<div class="cal-row">
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="start_ymd" name="start_ymd">
												<i class="material-icons">query_builder</i>
											</div>
											<div class="cal-dash wid-1">-</div>
											<div class="cal-input wid-45">
												<input type="text" class="date-i" id="end_ymd" name="end_ymd">
												<i class="material-icons">query_builder</i>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
        			
        			</div> <!-- // lect-pwrap -->
        			
        			<div class=" text-center">
						<a class="btn btn02 ok-btn">발송하기</a>
					</div>
					
        		</div>
        	</div>
        </div>
    </div>
</div>
<div id="review_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#review_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">심사평 작성</h3>
        			<form id="fncForm" name="fncForm" method="POST" action="./saveReview">
	        			<input type="hidden" id="cust_no" name="cust_no">
	        			<input type="hidden" id="reg_no" name="reg_no">
	        			<textarea style="height:333px;" id="review" name="review"></textarea>
        			</form>
        			<div class=" text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:saveReview();" style="margin-top:30px;">저장</a>
					</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>


<div id="trans_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#trans_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		
        		<div>
        			<h3>강의계획서</h3>
        			
        			<div class="tr-content">
        				<div class="tr-div01">
        					<div class="wid-10">								
								<div class="sear-tit">수강 대상</div>
								<div>
									<input type="text" class="bg_blue" value="회화를 위한 기초 영문법">
								</div>								
							</div>
							
							<div class="wid-10">								
								<div class="sear-tit">강좌소개 및 특징 요약</div>
								<div>
									<textarea class="bg_blue" >여행 뿐 아니라 해외에서 부딪히는 다양한 상황에서 자신을 표현 할 수 있는 1. ntroduction  2. restaurant  3. going places  4. No problem  5. change  6. celebration  7. interview  8. common wish  9. capsule hotel  10. bad habit  11. ethnic dishes  12. on vacation
									</textarea>
								</div>								
							</div>
							
							<div class="wid-10">								
								<div class="sear-tit">시그니처 클래스에 지원한 이유</div>
								<div>
									<textarea class="bg_blue" >여행 뿐 아니라 해외에서 부딪히는 다양한 상황에서 자신을 표현 할 수 있는 1. ntroduction  2. restaurant  3. going places  4. No problem  5. change  6. celebration  7. interview  8. common wish  9. capsule hotel  10. bad habit  11. ethnic dishes  12. on vacation
									</textarea>
								</div>								
							</div>
						</div>
						<div class="tr-div02">
	        				<div class="wid-10">
								<div class="table">
									<div class="sear-tit">수강 대상</div>
									<div>
										<ul class="chk-ul">
											<li>
												<input type="checkbox" id="all-auto" name="all-auto">
												<label for="all-auto">성인</label>
											</li>
											<li>
												<input type="checkbox" id="all-indi" name="all-indi">
												<label for="all-indi">초등</label>
											</li>
											<li>
												<input type="checkbox" id="all-indi" name="all-indi">
												<label for="all-indi">유아</label>
											</li>
											<li>
												<input type="checkbox" id="all-indi" name="all-indi">
												<label for="all-indi">엄마와 함께</label>
											</li>
										</ul>
									</div>
								</div>
							</div>
							
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">진행 횟수</div>
									<div>
										<ul class="chk-ul">
											<li>
												<input type="checkbox" id="all-auto" name="all-auto">
												<label for="all-auto">정규</label>
											</li>
											<li>
												<input type="checkbox" id="all-indi" name="all-indi">
												<label for="all-indi">단기</label>
											</li>
											<li>
												<input type="checkbox" id="all-indi" name="all-indi">
												<label for="all-indi">특강</label>
											</li>
										</ul>
									</div>
								</div>
							</div>
							
							<div class="wid-10 tran-file">
								<div class="table">
									<div class="sear-tit">첨부파일</div>
									<div>
										<div class="filebox"> 
											<label for="banner"><i class="material-icons">get_app</i>파일다운로드</label> 
											<input type="file" id="banner" name="banner"> 
											
											<input class="upload-name" value="">
											<span>* 각 첨부파일 당 10mb까지 업로드 가능합니다. <br> * 작품 혹은 홍보하고 싶은 이미지를 등록해주세요.</span>
										</div>
										
									</div>
								</div>
							</div>
						</div>
        			
        			</div>
        			
        		</div>
        		
        			<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn">확인</a>
					</div>
        	</div>
        </div>
	</div>
</div>
<script>
$( document ).ready(function() {
	$("#search_type").val("kor_nm");
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type"))); $(".search_type").html($("#search_type option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	if(nullChk(getCookie("aply_type")) != "") { $("#aply_type").val(nullChk(getCookie("aply_type"))); $(".aply_type").html($("#aply_type option:checked").text());}
	if(nullChk(getCookie("status")) != "") { $("#status").val(nullChk(getCookie("status"))); $(".status").html($("#status option:checked").text());}
	if(nullChk(getCookie("start_ymd")) != "") { $("#start_ymd").val(nullChk(getCookie("start_ymd")));}
	if(nullChk(getCookie("end_ymd")) != "") { $("#end_ymd").val(nullChk(getCookie("end_ymd")));}
	fncPeri();
	
	
	getList();
	reSortAjax('sort_submit_date');

});
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>