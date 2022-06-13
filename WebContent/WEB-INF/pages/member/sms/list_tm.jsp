<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
var custList="";
var isBack = false;





	
	
function getList(paging_type){
	
	
	var result="";
	if ($('#tm_result_a').prop("checked")==1 && $('#tm_result_b').prop("checked")!=1) 
	{
		result="\'Y\'";
	}
	else if ($('#tm_result_a').prop("checked")!=1 && $('#tm_result_b').prop("checked")==1) 
	{
		result="\'N\'";
	}
	else if ($('#tm_result_a').prop("checked")==1 && $('#tm_result_b').prop("checked")==1)
	{
		result="\'Y\',\'N\'";
	}
	
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("year", $("#selYear").val(), 9999);
	setCookie("season", $("#selSeason").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("searchType", $("#searchType").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("send_start_tm", $("#send_start_tm").val(), 9999);
	setCookie("send_end_tm", $("#send_end_tm").val(), 9999);
	setCookie("tm_purpose", $("#tm_purpose").val(), 9999);
	setCookie("result", result, 9999);
	
	
	getListStart();
	searchType
	$.ajax({
		type : "POST", 
		url : "./getTmList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			search_name : $('#search_name').val(),
			listSize : $("#listSize").val(),
			
			store : $('#selBranch').val(),
			period : $('#selPeri').val(),
			searchType : $('#searchType').val(),
			start_day : $('#send_start_tm').val(),
			end_day : $('#send_end_tm').val(),
			purpose : $('#tm_purpose').val(),
			result : result
			
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
			var cust_len="";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					
					if (nullChk(result.list[i].RESULT) =='완료') {
						inner += '<tr style="opacity :0.5 ">';
					}else{
						inner += '<tr>';
					}
					inner += '	<td><input type="checkbox" value="'+result.list[i].TM_SEQ+'" class="tmChk" style="display:block"></td>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+result.list[i].PURPOSE+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+result.list[i].TOT_REGIS_NO+'</td>';						
					inner += '	<td>'+result.list[i].RESULT+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MANAGER_NM)+'</td>';
					inner += '	<td>'+result.list[i].CREATE_DATE+'</td>';
					inner += '	<td>'+nullChk(result.list[i].DEAD_YMD)+'</td>';
					cust_len = nullChk(result.list[i].TARGET).split(',');
					if (cust_len.length>1) 
					{
					
						inner += '	<td onclick="javascript:location.href=\'/member/sms/tm_cust?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&tm_seq='+result.list[i].TM_SEQ+'&subject_cd='+nullChk(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;"><span>'+cust_len[0]+' 외 '+(cust_len.length-1)+'명</span><i class="material-icons add">add_circle_outline</i></td>';								
					
					}
					else
					{
						inner += '	<td onclick="javascript:location.href=\'/member/sms/tm_cust?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&tm_seq='+result.list[i].TM_SEQ+'&subject_cd='+nullChk(result.list[i].SUBJECT_CD)+'\'" class="tm-bor01">'+nullChk(result.list[i].TARGET)+'<i class="material-icons add">add_circle_outline</i></td>';					
					
					}
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="10"><div class="no-data">검색결과가 없습니다.</div></td>';
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

/*
function tm_detail(idx)
{
	var arr=idx.split('_');
	location.href ='/member/sms/tm_cust?store='+arr[0]+'&period='+arr[1]+'&tm_seq='+arr[2];

}
*/

function write_tm()
{
	$('#give_layer').fadeIn(200);
}

function delTm(){
	if(!confirm("정말 삭제하시겠습니까?")){
		return;
	}
	
	
	var seq ="";
	$('.tmChk').each(function(){ 
		if ($(this).prop("checked")) {
			seq += $(this).val()+"|";
		}
	})

	if (seq=="")
	{
		alert("삭제할 TM을 선택해주세요.");		
	}
	
	$.ajax({
		type : "POST", 
		url : "./delTm",
		dataType : "text",
		data : 
		{
			store : $('#selBranch').val(),
			period : $('#selPeri').val(),
			seq : seq
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
			if (result.isSuc=="success") {
				getList();
			}
		}
	});	
	
}

function selPeri()
{
	if($(".selPeri").html().indexOf("검색된") > -1)
	{
		alert("기수 정보가 없습니다.");
		$(".hidden_area").hide();
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "/basic/peri/getPeriOne",
			dataType : "text",
			async : false,
			data : 
			{
				selPeri : $("#selPeri").val(),
				selBranch : $("#selBranch").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
	 			$("#send_start_tm").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#send_end_tm").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}

</script>





<div class="sub-tit table">
	<div class="btn-wr btn-style">
		<a class="btn btn01" class="ipNow" href="list">SMS </a>
		<a class="btn btn02" href="list_tm">TM</a>
	</div>
	<div class="float-right">
		<a class="btn btn01 btn01_1" onclick="write_tm();">TM 등록</a>
	</div>
</div>

<div class="sub-tit">
	<h2>TM 리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	
</div>
<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-5">
			<div class="table">
				<div class="wid-35">
					<div class="table table02 table-input wid-contop">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-5">
				<div class="search-wr search-wr_div">
					<select id="searchType" name="searchType" de-data="강좌명">
						<option value="sub_nm">강좌명</option>
						<option value="title">제목</option>
						<option value="cus_no">멤버스번호</option>
						<option value="ptl_id">포털ID</option>
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
		<div class="wid-5">
			<div class="table">
				<div>
					<div class="cal-row cal-row02 table">
						<div class="cal-input wid-4">
							<input type="text" class="date-i start-i" id="send_start_tm" name="send_start_tm"/>
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input wid-4">
							<input type="text" class="date-i ready-i" id="send_end_tm" name="send_end_tm"/>
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_left">목적</div>
						<div>
							<select id="tm_purpose" name="tm_purpose" de-data="선택하세요">
								<option value="">전체</option>
								<option value="1">강좌폐강</option>
								<option value="2">폐강취소</option>
							    <option value="3">회원연락</option>
								<!--  <option value="4">휴강</option> -->
								<option value="5">강사연락</option>
								<option value="6">기타</option>
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-5">
			<div class="table ">
				<div class="sear-tit sear-tit-70">결과</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="tm_result_a" name="tm_result_a"/>
							<label for="tm_result_a">완료</label>
						</li>
						<li>
							<input type="checkbox" id="tm_result_b" name="tm_result_b"/>
							<label for="tm_result_b">진행중</label>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
</div>

<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb">결과 332개</p>
	</div>
	<div class="cap-r text-right">
		<div class="float-right">
			<div class="sel-scr">
				<a class="bor-btn btn03 btn-mar6" onclick="javascript:delTm();">삭제</a>
				<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a>
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
				<col>
				<col width="450px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="120px">
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>번호 </th>
					<th onclick="reSortAjax('sort_purpose')">목적<img src="/img/th_up.png" id="sort_purpose"></th>
					<th onclick="reSortAjax('sort_subject_nm')">제목 / 강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_tot_regis_no')">현원<img src="/img/th_up.png" id="sort_tot_regis_no"></th>
					<th onclick="reSortAjax('sort_result')">결과<img src="/img/th_up.png" id="sort_result"></th>
					<th onclick="reSortAjax('sort_manager_nm')">등록자<img src="/img/th_up.png" id="sort_manager_nm"></th>
					<th onclick="reSortAjax('sort_create_date')">등록일<img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_dead_ymd')">완료 예정일<img src="/img/th_up.png" id="sort_dead_ymd"></th>
					<th onclick="reSortAjax('sort_target')">대상<img src="/img/th_up.png" id="sort_target"></th>
				</tr>
			</thead>
		</table>
	</div>
	
	<div class="table-list">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col width="450px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="120px">
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>번호</th>
					<th onclick="reSortAjax('sort_purpose')">목적<img src="/img/th_up.png" id="sort_purpose"></th>
					<th onclick="reSortAjax('sort_subject_nm')">제목 / 강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_tot_regis_no')">현원<img src="/img/th_up.png" id="sort_tot_regis_no"></th>
					<th onclick="reSortAjax('sort_result')">결과<img src="/img/th_up.png" id="sort_result"></th>
					<th onclick="reSortAjax('sort_manager_nm')">등록자<img src="/img/th_up.png" id="sort_manager_nm"></th>
					<th onclick="reSortAjax('sort_create_date')">등록일<img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_dead_ymd')">완료 예정일<img src="/img/th_up.png" id="sort_dead_ymd"></th>
					<th onclick="reSortAjax('sort_target')">대상<img src="/img/th_up.png" id="sort_target"></th>
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
    </div>	.
</div>


<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

<div id="give_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg gift-edit edit-scroll">
        		<div class="close" onclick="javascript:$('#give_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        		<jsp:include page="/WEB-INF/pages/common/getCustListForTm.jsp"/>
        	</div>
        </div>
    </div>	
</div>
<script>
window.onpageshow = function(event) {
	
	if ( event.persisted || (window.performance && window.performance.navigation.type == 2))
	{
		if (getCookie("result"=="Y"))
		{ 
			$("input:checkbox[id='tm_result_a']").prop("checked", true); 
		}
		else if (getCookie("result"=="N"))
		{
			$("input:checkbox[id='tm_result_b']").prop("checked", true); 
		}
		else if (getCookie("result"=="\'Y\',\'N\'"))
		{
			$("input:checkbox[id='tm_result_a']").prop("checked", true); 
			$("input:checkbox[id='tm_result_b']").prop("checked", true); 
		}
		if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
		if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
		if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
		if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());}
		if(nullChk(getCookie("year")) != "") { $("#selYear").val(nullChk(getCookie("year"))); $(".selYear").html($("#selYear option:checked").text());}
		fncPeri();
		if(nullChk(getCookie("season")) != "") { $("#selSeason").val(nullChk(getCookie("season"))); $(".selSeason").html($("#selSeason").val() + " / "+nullChk(getCookie("period")))}
		if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
		if(nullChk(getCookie("searchType")) != "") { $("#searchType").val(nullChk(getCookie("searchType"))); $(".searchType").html($("#searchType option:checked").text());}
		if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
		if(nullChk(getCookie("send_start_tm")) != "") { $("#send_start_tm").val(nullChk(getCookie("send_start_tm")));}
		if(nullChk(getCookie("send_end_tm")) != "") { $("#send_end_tm").val(nullChk(getCookie("send_end_tm")));}
		if(nullChk(getCookie("tm_purpose")) != "") 
		{ 
			
			$("#tm_purpose").val(nullChk(getCookie("tm_purpose"))); 
			$(".tm_purpose").html($("#tm_purpose option:checked").text());
		}
	
	}
	selPeri();
	getList();
}
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>















