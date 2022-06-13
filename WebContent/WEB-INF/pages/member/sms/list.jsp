<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>


function excelDown()
{
	var filename = "SMS리스트";
	var table = "list_target";

    exportExcel(filename, table);

}



window.onload = function(){
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
	getList();
}

function getList(paging_type){
	getListStart();
	var send_type="";
	if ($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")!=1 && $('#chk_lms').prop("checked")!=1) {
		send_type="1";
	}else if($('#chk_alarm').prop("checked")!=1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")!=1){
		send_type="2";
	}else if($('#chk_alarm').prop("checked")!=1 && $('#chk_sms').prop("checked")!=1 && $('#chk_lms').prop("checked")==1){
		send_type="3";
	}else if($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")!=1){
		send_type="1|2";
	}else if($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")!=1 && $('#chk_lms').prop("checked")==1){
		send_type="1|3";
	}else if($('#chk_alarm').prop("checked")!=1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")==1){
		send_type="2|3";
	}else if($('#chk_alarm').prop("checked")==1 && $('#chk_sms').prop("checked")==1 && $('#chk_lms').prop("checked")==1){
		send_type="1|2|3";
	}
 	

	$.ajax({
		type : "POST", 
		url : "./getMessageList",
		dataType : "text",
		data : 
		{	
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			search_name : $('#search_name').val(),
			listSize : $("#listSize").val(),
			
			store : $('#selBranch').val(),
			start_day : $('#send_start').val(),
			end_day : $('#send_end').val(),
			search_type :$('#searchType').val(),
			send_state : $('#send_state').val(),
			send_type : send_type
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
			var cust_len=0;
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					cust_len = (result.list[i].CNT*1);
					
					inner += '<tr>';
					inner += '	<td>'+(i+1)+'</td>';
					//inner += '	<td>'+nullChk(result.list[i].SEND_STATE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SEND_TYPE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].TITLE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MANAGER_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].RESERVE_TIME)+'</td>';
					
					
					if (cust_len >1) 
					{
						inner += '	<td onclick="location.href=\'/member/sms/sms_cust?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&sms_seq='+result.list[i].SMS_SEQ+'\'">발송대상 '+cust_len+'명<i class="material-icons add cur-point">add_circle_outline</i></td>';	
					}
					else
					{
						inner += '	<td onclick="location.href=\'/member/sms/sms_cust?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&sms_seq='+result.list[i].SMS_SEQ+'\'">'+result.list[i].KOR_NM+'</td>';	
					}
					
					inner += '	<td>'+result.list[i].SUC_CNT+'</td>';
					inner += '	<td>'+result.list[i].SEND_RESULT+'</td>';
					inner += '</tr>';
					
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="7"><div class="no-data">검색결과가 없습니다.</div></td>';
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
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});
	
 	
	
}

</script>



<div class="sub-tit table">
	<div class="btn-style">
		<a class="btn btn02" class="ipNow" href="list">SMS </a>
		<a class="btn btn01" href="list_tm">TM</a>
	</div>
	<div class="float-right">
		<a class="btn btn01 btn01_1" href="write">SMS 발송</a>
	</div>
</div>

<div class="sub-tit">
	<h2>SMS 리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-5">
			<div class="table">
				<div class="wid-15">
					<div class="table table02 table-input wid-contop">
						<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch">
							<c:forEach var="i" items="${branchList}" varStatus="loop">
								<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
							</c:forEach>
						</select>
					</div>
				</div>
					<div class="wid-25">
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" class="date-i start-i" id="send_start" name="send_start"/>
								<i class="material-icons">event_available</i>
							</div>
							<div class="cal-dash">-</div>
							<div class="cal-input wid-4">
								<input type="text" class="date-i ready-i" id="send_end" name="send_end"/>
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
			</div>
		</div>
		<div class="wid-5">
				<div class="search-wr search-wr_div">
					<select id="searchType" name="searchType" de-data="제목">
						<option value="title">제목</option>
						<option value="cus_no">멤버스번호</option>
						<option value="phone_nm">휴대폰번호</option>
						<option value="kor_nm">회원명</option>
					</select>
				    <div class="search-wr_div02 sear-6">
					    <input type="text" id="search_name" class="inp-100" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
					    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
				    </div>
				</div>
		</div>
		
	</div>
	<div class="top-row">
		<div class="wid-2">
			<div class="table">
				<div class="sear-tit sear-tit-70">발송상태</div>
				<div>
					<select de-data="선택하세요" id="send_state" name="send_state">
						<option value="">전체</option>
						<option value="S">발송성공</option>
						<option value="F">발송실패</option>
					</select>
				</div>
			</div>
		</div>
		<div class="wid-3">
			<div class="table ">
				<div class="sear-tit sear-tit-70">발송구분</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="chk_sms" name="chk_sms"/>
							<label for="chk_sms">SMS</label>
						</li>
						<li>
							<input type="checkbox" id="chk_lms" name="chk_lms"/>
							<label for="chk_lms">LMS</label>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!--  
		<div class="wid-5">
			<div class="table">
				<div class="sear-tit sear-tit-70">발송유형</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="all-auto" name="all-auto"/>
							<label for="all-auto">자동발송</label>
						</li>
						<li>
							<input type="checkbox" id="all-indi" name="all-indi"/>
							<label for="all-indi">개별발송</label>
						</li>
						<li>
							<input type="checkbox" id="all-all" name="all-all"/>
							<label for="all-all">전체발송</label>
						</li>
					</ul>
				</div>
			</div>
		</div>
		-->
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
</div>
<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
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
		<table >
			<colgroup>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_rownum')" class="td-80">번호 <img src="/img/th_up.png" id="sort_rownum"></th>
					<!--  <th onclick="reSortAjax('sort_send_state')">발송유형 <img src="/img/th_up.png" id="sort_send_state"></th>-->
					<th onclick="reSortAjax('sort_send_type')">구분 <img src="/img/th_up.png" id="sort_send_type"></th>
					<th onclick="reSortAjax('sort_title')" class="td-350">제목 <img src="/img/th_up.png" id="sort_title"></th>
					<th onclick="reSortAjax('sort_manager_nm')">발송자 <img src="/img/th_up.png" id="sort_manager_nm"></th>
					<th onclick="reSortAjax('sort_reserve_time')">발송일시 <img src="/img/th_up.png" id="sort_reserve_time"></th>
					<th onclick="reSortAjax('sort_kor_nm')">발송대상 <img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_suc_cnt')">발송성공 <img src="/img/th_up.png" id="sort_suc_cnt"></th>
					<th onclick="reSortAjax('sort_send_result')">발송상태 <img src="/img/th_up.png" id="sort_send_result"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table>
			<colgroup>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_rownum')" class="td-80">번호 <img src="/img/th_up.png" id="sort_rownum"></th>
					<!-- <th onclick="reSortAjax('sort_send_state')">발송유형 <img src="/img/th_up.png" id="sort_send_state"></th>-->
					<th onclick="reSortAjax('sort_send_type')">구분 <img src="/img/th_up.png" id="sort_send_type"></th>
					<th onclick="reSortAjax('sort_title')" class="td-350">제목 <img src="/img/th_up.png" id="sort_title"></th>
					<th onclick="reSortAjax('sort_manager_nm')">발송자 <img src="/img/th_up.png" id="sort_manager_nm"></th>
					<th onclick="reSortAjax('sort_reserve_time')">발송일시 <img src="/img/th_up.png" id="sort_reserve_time"></th>
					<th onclick="reSortAjax('sort_kor_nm')">발송대상 <img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_suc_cnt')">발송성공 <img src="/img/th_up.png" id="sort_suc_cnt"></th>
					<th onclick="reSortAjax('sort_send_result')">발송상태 <img src="/img/th_up.png" id="sort_send_result"></th>
				</tr>
			</thead>
			<tbody id="list_target">
			
				
			</tbody>
		</table>
	</div>
</div>





<div id="write_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg ip-edit">
        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200); close_act();">
        			닫기<i class="far fa-window-close"></i>
        		</div>
				<div>
				<!-- 여기 -->
					<form id="fncFormIp" name="fncFormIp" method="POST">
						<h3 class="status_now">IP 추가</h3>
						<div class="top-row inp-bgno">
							<div class="wid-10">
								<div class="table">
									<div class="wid-10">
										<input type="text" id="write_ip" name="write_ip" class="notEmpty" value="211.192.6.37">
										<label for="write_ip" class="notShow">IP주소</label>
									</div>
									<div class="wid-3">
										<a class="btn btn03">직접입력</a>
									</div>
								</div>
							</div>
							
							<div class="wid-5 bor-r">
								<div class="table">
									<div class="sear-tit">지점</div>
									<div>
										<select id="write_ppcard_print_yn" name="write_ppcard_print_yn" class="notEmpty" de-data="선택">
											<option value="Y">분당점</option>
											<option value="W">분당점</option>
											<option value="N">분당점</option>
										</select>
									</div>
								</div>
								<div class="table">
									<div class="sear-tit">POS 번호</div>
									<div>
										<select id="write_ppcard_print_yn" name="write_ppcard_print_yn" class="notEmpty" de-data="선택">
											<option value="Y">070001</option>
											<option value="W">070001</option>
											<option value="N">070001</option>
										</select>
									</div>
								</div>
								<div class="table">
									<div class="sear-tit">카드발급기</div>
									<div>
										<select id="write_ppcard_print_yn" name="write_ppcard_print_yn" class="notEmpty" de-data="선택">
											<option value="Y">ID-2000ZP(RW)</option>
											<option value="W">ZP-2000(W)</option>
											<option value="N">없음</option>
										</select>
									</div>
								</div>
																
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">단말기 종류</div>
									<div>
										<select id="write_tml_type" name="write_tml_type" class="notEmpty" de-data="선택">
											<option value="P">POS</option>
											<option value="C">CAT</option>
										</select>
									</div>
								</div>
								
								<div class="table">
									<div class="sear-tit">POS 프린터</div>
									<div>
										<ul class="radio-ul">
											<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">O</label></li>
											<li><input type="radio" id="view_status2-1" name="view_status" value="2"><label for="view_status2-1">X</label></li>
										</ul>
									</div>
								</div>
								
								<div class="table">
									<div class="sear-tit">포트번호</div>
									<div>
										<div class="table table02">
											<div>발급기</div>
											<div>
												<select id="write_tml_type" name="write_tml_type" class="notEmpty" de-data="선택">
													<option value="P">5</option>
													<option value="C">5</option>
												</select>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
					<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitIp();"><i class="material-icons">vertical_align_bottom</i>저장</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>