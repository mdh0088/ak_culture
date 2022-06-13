<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>
function excelDown()
{
	
	var filename = "출석부";
	var table = "excelTable";
	
	var inner ="";
	
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강좌 : ${EXCEL_SUBJECT_NM}(${SUBJECT_CD})</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강사 : ${WEB_LECTURER_NM}</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강의 기간 : ${START_YMD} ~ ${END_YMD}</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='	<th>강의 시간 :'+cutLectHour('${LECT_HOUR}')+'</th>';
	inner +='</tr>';
	inner +='<tr class="addTarget">';
	inner +='	<th></th>';
	inner +='</tr>';
	
	$('#list_head_target').prepend(inner);
    exportExcel(filename, table);
    $('.addTarget').remove();
}

function phone_masking(str){
	var arr = str.split('-');
	var middle_str = "";
	for (var i = 0; i < arr[1].length; i++) {
		middle_str+="*";
	}
	return arr[0]+"-"+middle_str+"-"+arr[2];
}

$(document).ready(function() {
	$("#chk_all").change(function() 
	{
		if($("input:checkbox[name='chk_all']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", false);
		}
	});
	
	$(".table-list").removeClass('scr-staton');
	
});

window.onload = function(){
	$('#selBranch').val("${STORE}");
	$('#selPeri').val("${PERIOD}");
	setPeri();
	$("#selYear").val("${WEB_TEXT}".substring(0,4));
	$(".selYear").html("${WEB_TEXT}".substring(0,4));

	
	fncPeri();
	getList();
}



function guessSchedule(start_ymd, type)
{
	

   //console.log(start_ymd.substring(0, 4));
   //console.log(start_ymd.substring(4,6)-1);
   //console.log(start_ymd.substring(6,8));
   //console.log(start_ymd.substring(0,8));
   console.log(start_ymd);
   var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8) ,00 ,00 );
   //var date_start = new Date(start_ymd.substring(0, 4), start_ymd.substring(4,6)-1, start_ymd.substring(6,8) ,11 ,59 );
   var current_date = new Date();
 
   console.log("DATE START : "+date_start);
   console.log("CURRENT START : "+current_date);
   
   var typex = type;	
   if(current_date < date_start || start_ymd=="X")
   {
      typex = "";
   }
 

   
   return typex; 
}

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



function getList(paging_type) 
{
	
	
	$.ajax({
		type : "POST", 
		url : "./getCustAttendList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $('#selBranch').val(),
			period : $('#selPeri').val(),
			subject_cd : "${SUBJECT_CD}"
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			$("#result").val(data);
			var result = JSON.parse(data);
			if (result.isSuc=="success") {
				$('.top_area').show();
				$('#lect_ymd').text(cutDate(result.start_ymd)+ '~' +cutDate(result.end_ymd));
				$('#lect_hour').text(cutLectHour(result.lect_hour));
				
				$('#subject_nm').val(result.subject_nm);
				$('#subject_cd').val(result.subject_cd);
				$('#lecr_nm').val(result.web_lecturer_nm);
				
				$('.lect-tit').text(result.subject_nm+'('+result.subject_cd+')');
				$('.lect-tit2').text(result.web_lecturer_nm+' 강사');
				$('.btn08').text(result.store_nm);
				
				
				$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt+"개");
				var inner = "";
				$('#day_chk').val(result.day_chk);
				var day_chk_arr = result.day_chk.split('|');
				///////////List head세팅 start//////////////////
				inner ="";
				inner +='<tr>';
				inner +='	<th class="td-chk"> <input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label> </th>';
				inner +='	<th>No.</th>';
				inner +='	<th onclick="reSortAjax(\'sort_parent_nm\')">회원명<img src="/img/th_up.png" id="sort_parent_nm"></th>';
				inner +='	<th onclick="reSortAjax(\'sort_kids_nm\')"> 자녀명 <img src="/img/th_up.png" id="sort_kids_nm"></th> ';
				inner +='	<th onclick="reSortAjax(\'sort_cust_fg\')"> 구분 <img src="/img/th_up.png" id="sort_cust_fg"></th> ';
				inner +='	<th onclick="reSortAjax(\'sort_cust_no\')">회원번호 <img src="/img/th_up.png" id="sort_cust_no"></th> ';
				inner +='	<th class="phone_area phone_show" onclick="reSortAjax(\'sort_phone_no\')">전화번호 <img src="/img/th_up.png" id="sort_phone_no"></th>';
				inner +='	<th onclick="reSortAjax(\'sort_car_no\')">차량번호<img src="/img/th_up.png" id="sort_car_no"></th>';
				//inner +='	<th onclick="reSortAjax(\'sort_cust_fg\')">수강형태 <img src="/img/th_up.png" id="sort_cust_fg"></th>';
				for (var i = 0; i < day_chk_arr.length-1; i++) 
				{
					inner +='<th class="chk-date" style="mso-number-format:\@">';
					inner +='	['+day_chk_arr[i].substr(4,2)+'/'+day_chk_arr[i].substr(6,2)+']';
					inner +='</th>'	
				}
	
				
				inner +='<th>비고</th>';
				inner +='</tr>';
				$('#list_head_target').html(inner);
				inner=""; //inner 초기화
				
				var inner2 = "";
				
				
				inner2 += '<table>';
				inner2 += '	<colgroup>';
				inner2 += '		<col width="40px">';
				inner2 += '		<col width="60px">';
				inner2 += '		<col width="300px">';
				inner2 += '		<col>';
				inner2 += '		<col>';
				inner2 += '		<col>';
				inner2 += '		<col>';
				for (var i = 0; i < day_chk_arr.length-1; i++) {
					inner2 += '		<col  width="40px">';
				}
				inner2 += '	</colgroup>';
				inner2 += '	<thead>';
				inner2 += inner;
				inner2 += '	</thead>';
				inner2 += '</table>';
				
				$('#list_head_target_head').html(inner2);
				
				var inner3 = "";			

				inner3 += '		<col width="40px">';
				inner3 += '		<col width="60px">';
				inner3 += '		<col>';
				inner3 += '		<col>';
				inner3 += '		<col>';
				inner3 += '		<col>';
				inner3 += '		<col>';
				for (var i = 0; i < day_chk_arr.length-1; i++) {
					inner3 += '		<col  width="40px">';
				}
				$('#list_colgroup').html(inner3);
				
				///////////List head세팅 end//////////////////
				
				var dayChk = ""; //출석체크 값 세팅			
				per_cnt=0;
				for (var i = 0; i < day_chk_arr.length-1; i++) {
					cntForGraph(day_chk_arr[i]);				
				}
				
				per_cnt=Math.round(per_cnt/(day_chk_arr.length-1)*100);
				$("#per_span").css("width", per_cnt+"%");
				$("#per_div").html(per_cnt+"%");
				
				if(result.list.length > 0)
				{
					inner="";
					for(var i = 0; i < result.list.length; i++)
					{
						dayChk = result.list[i].DAY_CHK.split('|');
						
						inner += '<tr>';
						inner += '	<td class="td-chk">';
						inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" name="chk_val" value="">';
						inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'"></label>';
						inner += '	</td>';
						inner += '  <td>'+(i+1)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].PARENT_NM)+'</td>';						
						inner += '	<td>'+nullChk(result.list[i].KIDS_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CUST_NO)+'</td>';
						inner += '	<td class="phone_area phone_show"><span style="display:none;">\'</span>'+nullChk(result.list[i].PHONE_NO)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].CAR_NO)+'</td>';
						//inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
						
						console.log("len : "+dayChk.length);
						for (var j = 0; j < dayChk.length-1; j++) 
						{
							if (dayChk[j]=="O") 
							{
								inner += '	<td>'+dayChk[j]+'</td>';
							}
							else
							{
								inner += '	<td></td>';
							}
						}
						inner += '	<td>'+nullChk(result.list[i].CONTENT)+'</td>';
						//inner += '	<td>'+guessSchedule("${DAY2}",nullChk(result.list[i].DAY2))+'</td>';
						inner += '</tr>';
					
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="'+(7+day_chk_arr.length)+'"><div class="no-data">수강생이 없습니다.</div></td>';
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
			}else{
				
				$('.top_area').hide();
				$(".cap-numb").html("결과 0 / 전체0개");
				inner += '<tr>';
				inner += '	<td><div class="no-data">이번 기수에 등록된 강좌가 없습니다.</div></td>';
				inner += '</tr>';
				$('#list_colgroup').empty();
				$('#list_head_target').empty();
				$("#list_target").html(inner);
				$("#per_span").css("width", "0%");
				$("#per_div").html("0%");
			}
		}
	});	
}

function goPrint()
{
	//var gsWin = window.open("about:blank", "winName");
	window.open('', 'AK', 'height=700,width=1200');
	var frm = document.getElementById("printForm");
	frm.target ="AK";
	frm.submit();
}





function show_phone_no(){
	if($('.phone_area').hasClass("phone_show"))
	{
		$('.phone_area').removeClass('phone_show');
		$('.phone_area').hide();
		$('#phone_chk').val('hide');
	}
	else
	{
		$('.phone_area').addClass('phone_show');
		$('.phone_area').show();
		$('#phone_chk').val('show');
	}
	
}


</script>

<form id="printForm" name="printForm" method="post" action="./print_proc" >
	<input type="hidden" id="subject_nm" name="subject_nm" value="">
	<input type="hidden" id="subject_cd" name="subject_cd" value="">
	<input type="hidden" id="lecr_nm" name="lecr_nm" value="">
	<input type="hidden" id="result" name="result">
	<input type="hidden" id="day_chk" name="day_chk">
	<input type="hidden" id="phone_chk" name="phone_chk" value="show">
</form>
<iframe id="printFrame" name="printFrame" style="display:none;"></iframe>

<div class="sub-tit">
	<h2>출석부 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb">
		<li>강좌 관리</li>
		<li>출석부 관리</li>
	</ul>
</div>

<div class="lect-top table-top first wid-10 top_area">
<p class="lect-st">${MAIN_NM}<i class="material-icons">keyboard_arrow_right</i><span class="color-pink">${SECT_NM}</span></p>
	<div class="table table-auto">
		<div class="lect-titwr">
			<p class="lect-tit"></p>
			<p class="lect-tit2"></p>
			<p class="btn btn08"></p>
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

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-3">
			<div class="table table02 table-input wid-contop">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
		</div>
		<div class="wid-1">
			<div class="table table-input">
				<div><input class="search-btn03 btn btn02" type="button" value="선택완료" onclick="javascript:pagingReset(); getList();"></div>
			</div>
		</div>
	</div>
</div>

<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
		<div class="btn btn03 btn-mar6" onclick="show_phone_no()">연락처보기</div>
	</div>
	<div class="cap-r text-right">
		<div class="float-right">
			<div>
				<a class="bor-btn btn01 print-btn" onclick="javascript:goPrint();"><i class="material-icons">print</i></a> 
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
				<select id="listSize" name="listSize" onchange="getList()" de-data="100개 보기">
				<!-- 	<option value="10">10개 보기</option>
					<option value="20">20개 보기</option>
					<option value="50">50개 보기</option> -->
					<option value="100">100개 보기</option>
					<option value="300">300개 보기</option>
					<option value="500">500개 보기</option>
					<option value="1000">1000개 보기</option>
				</select>
			</div>
		</div>
	</div>
</div>
<div class="table-wr ip-list attend-table">
	<div class="thead-box" id="list_head_target_head">
		
	</div>
	<div class="table-list">
		<table id="excelTable">
			<colgroup id="list_colgroup">
			
			</colgroup>
			<thead id="list_head_target">
				<!-- 
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th> 
					<th onclick="reSortAjax('sort_ptl_id')">포털ID <img src="/img/th_up.png" id="sort_ptl_id"></th> 
					<th onclick="reSortAjax('sort_phone_no')">전화번호 <img src="/img/th_up.png" id="sort_phone_no"></th> 
					<th onclick="reSortAjax('sort_sex_fg')">성별 <img src="/img/th_up.png" id="sort_sex_fg"></th> 
					<th onclick="reSortAjax('sort_cust_date')">가입일<img src="/img/th_up.png" id="sort_cust_date"></th> 
					<th onclick="reSortAjax('sort_cust_fg')">수강형태 <img src="/img/th_up.png" id="sort_cust_fg"></th>

					<th class="chk-date"><c:if test="${DAY1 ne 'X'}" >${fn:substring(DAY1,4,6)}/${fn:substring(DAY1,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY2 ne 'X'}" >${fn:substring(DAY2,4,6)}/${fn:substring(DAY2,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY3 ne 'X'}" >${fn:substring(DAY3,4,6)}/${fn:substring(DAY3,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY4 ne 'X'}" >${fn:substring(DAY4,4,6)}/${fn:substring(DAY4,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY5 ne 'X'}" >${fn:substring(DAY5,4,6)}/${fn:substring(DAY5,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY6 ne 'X'}" >${fn:substring(DAY6,4,6)}/${fn:substring(DAY6,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY7 ne 'X'}" >${fn:substring(DAY7,4,6)}/${fn:substring(DAY7,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY8 ne 'X'}" >${fn:substring(DAY8,4,6)}/${fn:substring(DAY8,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY9 ne 'X'}" >${fn:substring(DAY9,4,6)}/${fn:substring(DAY9,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY10 ne 'X'}" >${fn:substring(DAY10,4,6)}/${fn:substring(DAY10,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY11 ne 'X'}" >${fn:substring(DAY11,4,6)}/${fn:substring(DAY11,6,8)}</c:if></th>
					<th class="chk-date"><c:if test="${DAY12 ne 'X'}" >${fn:substring(DAY12,4,6)}/${fn:substring(DAY12,6,8)}</c:if></th>
					<th>비고</th>
				</tr>
				 -->
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
										<input type="text" data-name="아이피 주소" id="write_ip" name="write_ip" class="notEmpty" value="211.192.6.37">
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