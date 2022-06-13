<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
//var tm_seq = "${tm_seq}";
var cust_no = "";
$( document ).ready(function() {
	getList();
});


$(function(){
	/* 알림톡 팝업 */
	$(".tm-custlist > table > tbody > tr").each(function(){
		var mult = $(this).find(".tm-title");
		var mpop = $(this).find(".title-pop");
		mult.click(function(){
			if(mpop.css("display") == "none"){
				mpop.css("display","block");
			}else{
				mpop.css("display","none");
			}
		})
	});
	
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
	
	if ("${subject_cd}"!="") 
	{
		$('#lect_ymd').text(cutDate("${START_YMD}")+ '~' +cutDate("${END_YMD}"));
		$('#lect_hour').text(cutLectHour("${LECT_HOUR}"));
		
		var day_chk_arr = "${DAY_CHK}".split('|');
		per_cnt=0;
		for (var i = 0; i < day_chk_arr.length-1; i++) {
			cntForGraph(day_chk_arr[i]);				
		}
		
		per_cnt=Math.round(per_cnt/(day_chk_arr.length-1)*100);
		$("#per_span").css("width", per_cnt+"%");
		$("#per_div").html(per_cnt+"%");
	}

});


var per_cnt=0;
function cntForGraph(start_ymd)
{
   var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8) ,00 ,00 );
   var current_date = new Date();
   if(current_date > date_start)
   {
      typex = "";
	  per_cnt++;
   }
}




function getList(){
	
	$.ajax({
		type : "POST", 
		url : "./tm_cust_list",
		dataType : "text",
		data : 
		{
			page : page,
			listSize : '9999',
			order_by : order_by,
			sort_type : sort_type,
			store : '${store}',
			period : '${period}',
			tm_seq : '${tm_seq}'
			
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
			
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					
						
					if (nullChk(result.list[i].RESULT) =='완료') {
						inner += '<tr style="opacity :0.5 ">';
					}else{
						inner += '<tr>';
					}
					
					inner += '	<td>'+result.list[i].NUM+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUST_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PTL_ID)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PHONE_NO)+'</td>';
					inner += '	<td class="tm-bor01"><span onclick="location.href=\'javascript:tmPopup('+result.list[i].CUST_NO+')\'" style="cursor:pointer;">'+result.list[i].KOR_NM+'</span></td>';
					inner += '	<td>'+nullChk(result.list[i].RESULT)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="12"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			
			order_by = result.order_by;
			sort_type = result.sort_type;
			//listSize = result.listSize;
			$("#list_target").html(inner);
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
	
}

var upt_memo_seq =[];
function tmPopup(idx)
{
	cust_no = idx;
	upt_memo_seq=[];
	var now_manager_name = '${login_name}';
	var now_day = cutDate(getNow());
	
	$.ajax({
		type : "POST", 
		url : "./getTmCustMemo",
		dataType : "text",
		async : false,
		data : 
		{
			store : "${store}",
			period : "${period}",
			tm_seq : "${tm_seq}",
			cust_no : cust_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			
			$('#cust_detail_area').empty();
			console.log(data);
			var inner ="";
			var result = JSON.parse(data);
			if (result.cust_info.length!=0) 
			{
				$('#tm_name').val(result.cust_info[0].KOR_NM);
				$('#tm_cus_no').val(result.cust_info[0].CUS_NO);	
				$('#tm_ptl_id').val(result.cust_info[0].PTL_ID);	
				$('#tm_phone_no').val(result.cust_info[0].PHONE_NO);	
			}
			
			for(var i = 0; i < result.list.length; i++)
			{
				
				upt_memo_seq.push(result.list[i].MEMO_SEQ);
				inner ='';
				inner +='<tr class="detail">';
				inner +='	<td class="text-left std-popbtn"><input type="text" id="tm_memo" name="memo" value="'+nullChk(result.list[i].MEMO)+'" placeholder="내용을 입력하세요.">';
				inner += '		<div class="std-newpop">';
				inner += '		<textarea class="comment_det">'+nullChk(result.list[i].MEMO)+'</textarea>';
				inner += '			<i class="far fa-window-close"></i>';
				inner += '		</div>';
				inner += '	</td>';
				inner +='	<td>'+nullChk(result.list[i].MANAGER_NM)+'</td>';
				inner +='	<td>'+nullChk(result.list[i].CREATE_DATE)+'</td>';
				
				inner +='	<td class="cen">';
				inner +='		<select id="tm_receiver_'+result.list[i].MEMO_SEQ+'" name="receiver">';
				inner +='			<option value="1">본인</option>';
				inner +='			<option value="2">배우자</option>';
				inner +='			<option value="3">자녀</option>';
				inner +='			<option value="4">기타</option>';
				inner +='		</select>';
				inner +='	</td>';
				
				inner +='	<td class="cen">';
				inner +='		<select id="tm_recall_yn_'+result.list[i].MEMO_SEQ+'" name="recall">';
				inner +='			<option value="Y">Y</option>';
				inner +='			<option value="N">N</option>';
				inner +='		</select>';
				inner +='	</td>';
				
				
				inner +='</tr>';
		
				$('#cust_detail_area').append(inner);
				$('#tm_receiver_'+result.list[i].MEMO_SEQ).val(result.list[i].RECEIVER);
				$('#tm_recall_yn_'+result.list[i].MEMO_SEQ).val(result.list[i].RECALL_YN);
			}
		}
	});
	$('#tm_layer').fadeIn(200);	
	thSize();
	commentInit();
}

function save_tm_info(){
	
	
	var upt_memo =[];
	var upt_receiver =[];
	var upt_recall =[];

	$('input[name="memo"]').each(function(i){//체크된 리스트 저장
		upt_memo.push($(this).val());
    });
	$('select[name="receiver"]').each(function(i){//체크된 리스트 저장
		upt_receiver.push($(this).val());
    });
	$('select[name="recall"]').each(function(i){//체크된 리스트 저장
		upt_recall.push($(this).val());
    });
	
	console.log(upt_memo);
	console.log(upt_receiver);
	console.log(upt_recall);
	console.log(upt_memo_seq);

	$.ajax({
		type : "POST", 
		url : "./write_tm_info",
		dataType : "text",
		async : false,
		data : 
		{
			store : "${store}",
			period : "${period}",
			tm_seq : "${tm_seq}",
			cust_no : cust_no,
			memo : $('#target_memo').val(),
			receiver: $('#target_receiver').val(),
			recall_yn: $('#target_recall_yn').val(),
			
			upt_memo : nullChk(upt_memo),
			upt_receiver : nullChk(upt_receiver),
			upt_recall : nullChk(upt_recall),
			upt_memo_seq : nullChk(upt_memo_seq)
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
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
	})
	
}

function send_sms(idx){
	$('#getCustNo').val(idx);	
	document.send_smsForm.action="/member/sms/write"; 
	document.send_smsForm.method="post"; 
	document.send_smsForm.submit(); 
}


function saveAllPass(){
	$.ajax({
		type : "POST", 
		url : "./saveAllPass",
		dataType : "text",
		async : false,
		data : 
		{
			tm_seq : "${tm_seq}"
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
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
	})
}
function commentInit()
{
	$(".std-popbtn").each(function(){
		var close = $(this).find(".fa-window-close");
		var pop = $(this).find(".std-newpop");
		$(this).find("input").click(function(){
			pop.show();
		})
		close.click(function(){
			pop.hide();
		})
	})
}
</script>

<form>

</form>
<form name="send_smsForm"> 
	<input type="hidden" id="getCustNo" name="getCustNo"  /> 
</form>
<div class="sub-tit table">
	<div class="btn-wr btn-style">
		<a class="btn btn01" class="ipNow" href="list">SMS </a>
		<a class="btn btn02" href="list_tm">TM</a>
	</div>
</div>

<div class="sub-tit">
	<h2>TM 회원리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<!-- 
	<p class="lect-st">${data.MAIN_NM}<i class="material-icons">keyboard_arrow_right</i><span class="color-pink">${data.SECT_NM}</span></p>
	<div class="table table-auto">
		<div class="lect-titwr">
			<p class="lect-tit">${data.SUBJECT_NM}(${data.SUBJECT_CD})</p>
			<p class="lect-tit2">${data.WEB_LECTURER_NM} 강사</p>
			<p class="btn btn08">${data.STORE_NAME}</p>
		</div>

	</div>
	 -->
</div>
<c:if test="${subject_cd ne ''}">
	<div class="lect-top table-top first wid-10 top_area">
	<p class="lect-st">${MAIN_NM}<i class="material-icons">keyboard_arrow_right</i><span class="color-pink">${SECT_NM}</span></p>
		<div class="table table-auto">
			<div class="lect-titwr">
				<p class="lect-tit">${SUBJECT_NM}</p>
				<p class="lect-tit2">${WEB_LECTURER_NM}</p>
				<p class="btn btn08">${STORE_NM}</p>
			</div>
			<div class="plan-grp">
				<div class="plan-gtit">강의진행도</div>
				<div class="plan-grpd"><div class="plg-wr"><span id="per_span"></span></div></div>
				<div class="plan-per color-pink" id="per_div"></div>
			</div>
			
		</div>
			<div>
				강의기간 : <span id="lect_ymd"></span><br>
				강의시간 :	<span id="lect_hour"></span>
				
			</div>
	</div>
</c:if>
<!--
<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb">결과 332개</p>
		</div>
</div>
-->
<div class="table-wr ip-list">
	<div class="thead-box">
		<table>
			<colgroup>
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_rownum')" class="td-80">번호<img src="/img/th_up.png" id="sort_rownum"></th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th onclick="reSortAjax('sort_phone_no')">휴대폰<img src="/img/th_up.png" id="sort_phone_no"></th>
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>	
					<th onclick="reSortAjax('sort_result')">결과<img src="/img/th_up.png" id="sort_result"></th>					
				</tr>
			</thead>
		</table>
	</div>
	
	<div class="table-list tm-custlist">
		<table>
			<colgroup>
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_rownum')" class="td-80">번호<img src="/img/th_up.png" id="sort_rownum"></th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th onclick="reSortAjax('sort_phone_no')">휴대폰<img src="/img/th_up.png" id="sort_phone_no"></th>
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_result')">결과<img src="/img/th_up.png" id="sort_result"></th>			
				</tr>
			</thead>
			<tbody id="list_target">
							
			</tbody>
		</table>
	</div>
</div>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

<div class="btn-wr text-center">
	<a href="/member/sms/list_tm" class="btn btn02 ok-btn">목록</a>
	<a onclick="saveAllPass()" class="btn btn02 ok-btn">일괄완료</a>
</div>


<div id="tm_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg ak-wrap_new ip-edit">
        		<div class="close" onclick="javascript:$('#tm_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<form>
        				<div class="top-row">
        					<h3>TM 회원 상세리스트</h3>
        				</div>
        				<div class="tm-wrap mem-manage">
	        				<div class="row ">
	        					<div class="wid-5">
	        						<div class="bor-div">	
										<div class="wid-10">
											<div class="table">
												<div class="sear-tit">내용</div>
												<div>
													<textarea id="target_memo" name="target_memo" class="notEmpty inp-100 sms-textarea" onkeypress="javascript:fnChkByte(this,'2000')"></textarea>
												</div>
											</div>
										</div>
										
										
										<div class="wid-10">
											<div class="table table-input">
												<div class="text-left">
													<div class="table">
														<div class="sear-tit">수신자</div>
														<div>
															<select id="target_receiver" name="target_receiver" de-data="본인">
																<option value="1">본인</option>
																<option value="2">배우자</option>
																<option value="3">자녀</option>
																<option value="4">기타</option>
															</select>
														</div>
													</div>
													
													
													<div class="table">
														<div class="sear-tit">재통화 필요</div>
														<div>
															<select id="target_recall_yn" name="target_recall" de-data="Y">
																<option value="Y">Y</option>
																<option value="N">N</option>
															</select>
														</div>
													</div>
												</div>
												
												<div class="text-right">
													<div class="sms-btn sms-txtn"><b id="text_num">0</b>/1000자</div>
												</div>
											</div>
										</div>
									</div>
	        					</div>
	        					<div class="wid-5 wid-5_last">
	        						<div class="bor-div">
			        					<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">회원명</div>
													<div>
														<input type="text" id="tm_name" name="tm_name" value="" class="inputDisabled inp-100" placeholder="김태연">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">멤버스번호</div>
													<div>
														<input type="text" id="tm_cus_no" name="tm_cus_no" value="" class="inputDisabled inp-100" placeholder="1233546">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">포털</div>
													<div>
														<input type="text" id="tm_ptl_id" name="tm_ptl_id" value="" class="inputDisabled inp-100" placeholder="akadmin">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">휴대폰</div>
													<div>
														<input type="text" id="tm_phone_no" name="tm_phone_no" value="" class="inputDisabled inp-100" placeholder="010-6525-6985">
													</div>
												</div>
											</div>
										</div>
			        				</div>
									<div class="table-wr">
										<div class="thead-box">
											<table>
												<colgroup>
													<col>
													<col>
													<col>
													<col width="100px">
													<col width="100px">
												</colgroup>
												<thead>
													<tr>
														<th>내용</th>
														<th>등록자</th>
														<th>일시</th>
														<th>수신자</th>
														<th>재통화 필요</th>
													</tr>
												</thead>
											</table>
										</div>
										<div class="table-list table-list_tmlist">
											<table>
												<colgroup>
													<col>
													<col>
													<col>
													<col width="100px">
													<col width="100px">
												</colgroup>				
												<thead>
													<tr>
														<th>내용</th>
														<th>등록자</th>
														<th>일시</th>
														<th>수신자</th>
														<th>재통화 필요</th>
													</tr>
												</thead>
												<tbody id="cust_detail_area">		
												
													
												</tbody>
											</table>
										</div>
									</div>
				        			<div class="btn-wr text-center">
										<a onclick="javascript:save_tm_info()" class="btn btn02 ok-btn">저장</a>
									</div>
	        					</div>
	        				</div>
	        			</div>
	        			
						
        			</div>
        			
        			</form>
        			
        		</div>
				
			
			
        	</div>
        </div>
    </div>	
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>