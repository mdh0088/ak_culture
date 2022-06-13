<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
$(document).ready(function() {
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
	$("#canc_contents").val(repWord(nullChk('${canc_contents}')));
});
function viewCanc()
{
	$("#canc_layer").fadeIn(200);
}
function viewSms()
{
	$("#sms_layer").fadeIn(200);
}
function insCanc()
{
	$.ajax({
		type : "POST", 
		url : "./insCanc",
		dataType : "text",
		data : 
		{
			contents : $("#canc_contents").val()
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
    		}
    		else
    		{
    			alert(result.msg);
    		}
		}
	});	
}
function sendSms()
{
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
	    	var chkId = $(this).attr("id").replace("chk_", "").split("_");
	    	var store = chkId[0];
	    	var phone_no = chkId[1];
	    	
	    	$.ajax({
	    		type : "POST", 
	    		url : "/common/single_send_sms",
	    		dataType : "text",
	    		data : 
	    		{
	    			store : store,
	    			phone_no : phone_no,
	    			title : '강의계획서 작성요청',
	    			msg : $("#sms_contents").val()
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
	        		}
	        		else
	        		{
	        			alert(result.msg);
	        		}
	    		}
	    	});	
    	}
	});
	
}
function getList(paging_type) 
{
	getListStart();
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("year", $("#selYear").val(), 9999);
	setCookie("season", $("#selSeason").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("search_type", $("#search_type").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("pelt_status", $("#pelt_status").val(), 9999);
	setCookie("is_finish", $("#is_finish").val(), 9999);
	setCookie("main_cd", $("#main_cd").val(), 9999);
	setCookie("sect_cd", $("#sect_cd").val(), 9999);
	
	$.ajax({
		type : "POST", 
		url : "/lecture/lect/getPeltList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			day_flag : '0000000',
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			pelt_status : $("#pelt_status").val(),
			is_finish : $("#is_finish").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val()
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
					inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PHONE_NO+'_'+i+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PHONE_NO+'_'+i+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+nullChk(result.list[i].LECTURER_NM)+'</td>';
					inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+comma(nullChk(result.list[i].REGIS_FEE))+'</td>';
					inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
					inner += '	<td>'+cutLectHour(result.list[i].LECT_HOUR)+'</td>';
					if(nullChk(result.list[i].PLAN_CNT) != "")
					{
						inner += '	<td>'+result.list[i].PLAN_CNT+'%</td>';
						if(result.list[i].PLAN_CNT == "100")
						{
							inner += '	<td class="line-blue" onclick="location.href=\'/web/plan_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">완료</td>';
						}
						else
						{
							inner += '	<td class="color-red line-blue" onclick="location.href=\'/web/plan_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">미완료</td>';
						}
					}
					else
					{
						inner += '	<td>0%</td>';
						inner += '	<td class="color-red line-blue" onclick="location.href=\'/web/plan_write?store='+result.list[i].STORE+'&period='+result.list[i].PERIOD+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">미완료</td>';
					}
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
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			$("#per_span").css("width", result.percent+"%");
			$("#per_div").html(result.percent+"%");
			getListEnd();
		}
	});	
}
function selMaincd2(idx){	
// 	var x = document.getElementById("selPeri").selectedIndex;
// 	var y = document.getElementById("selPeri").options;
// 	var z = document.getElementById("selPeri").options[y[x].index];

	main_cd = idx;
	if (main_cd==2 || main_cd==3 || main_cd==8) {
		$('.withBaby').show();
	}else{
		$('.withBaby').hide();
	}
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		async:false,
		data : 
		{
			maincd : main_cd,
// 			selBranch : z.getAttribute("store")
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
			var inner ="";
			$("#sect_cd").empty();
			$(".sect_cd_ul").html("");
			
			$(".sect_cd_ul").append('<li>전체</li>');
			$("#sect_cd").append('<option value="">전체</option>');
			if(result.length > 0)
			{
				
				inner=""; 
				for (var i = 0; i < result.length; i++) 
				{
					$(".sect_cd_ul").append('<li>'+result[i].SECT_NM+'</li>');
					$("#sect_cd").append('<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>');
				}
			}
			else
			{
				
			}
			$("#sect_cd").val("");
			$(".sect_cd").html("전체");
		}
	});	
}
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
			var inner ="";
			$("#sect_cd").empty();
			$(".sect_cd_ul").html("");
			
			$(".sect_cd_ul").append('<li>전체</li>');
			$("#sect_cd").append('<option value="">전체</option>');
			if(result.length > 0)
			{
				
				inner="";
				for (var i = 0; i < result.length; i++) 
				{
					$(".sect_cd_ul").append('<li>'+result[i].SECT_NM+'</li>');
					$("#sect_cd").append('<option value="'+result[i].SECT_CD+'">'+result[i].SECT_NM+'</option>');
				}
			}
			else
			{
				
			}
			$("#sect_cd").val("");
			$(".sect_cd").html("전체");
		}
	});	
}
</script>

<div class="sub-tit">
	<h2>강의계획서 작성리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<div class="plan-grp plan-grp02">
			<div class="plan-gtit">전체 작성상황</div>
			<div class="plan-grpd"><div class="plg-wr"><span id="per_span"></span></div></div>
			<div class="plan-per color-pink" id="per_div"></div>
		</div>
		<a class="btn btn02 btn-inline" onclick="javascript:viewCanc();">취소/환불 규정</a>
		<a class="btn btn01  btn01_1" onclick="viewSms();">일괄 강의계획서 작성요청</a>
		
	</div>
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-3">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
		</div>
		
<!-- 		<div class="wid-35_2"> -->
<!-- 			<div class="cal-row cal-row_inline cal-row02 table"> -->
<!-- 				<div class="cal-input cal-input180 wid-4"> -->
<!-- 					<input type="text" class="date-i" id="start_ymd" name="start_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 				<div class="cal-dash">-</div> -->
<!-- 				<div class="cal-input cal-input180 wid-4"> -->
<!-- 					<input type="text" class="date-i" id="end_ymd" name="end_ymd"/> -->
<!-- 					<i class="material-icons">event_available</i> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-2"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">대분류</div> -->
<!-- 				<div> -->
<!-- 					<select de-data="선택"> -->
<!-- 						<option>분류1</option> -->
<!-- 						<option>분류2</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="wid-3 mag-l2 wid-rt02"> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit-70">중분류</div> -->
<!-- 				<div> -->
<!-- 					<select de-data="선택"> -->
<!-- 						<option>분류1</option> -->
<!-- 						<option>분류2</option> -->
<!-- 					</select> -->
<!-- 					<ul class="chk-ul"> -->
<!-- 						<li> -->
<!-- 							<input type="checkbox" id="all-c" name="all-c"> -->
<!-- 							<label for="all-c">폐강제외</label> -->
<!-- 						</li>							 -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="wid-35 mag-r2">
			<div class="table">
				<div class="search-wr sel100">
					<select id="search_type" name="search_type" de-data="강좌명">
						<option value="subject_nm">강좌명</option>
						<option value="subject_cd">코드번호</option>
					</select>
				    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
				    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
				</div>
			</div>
		</div>
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit-70">완료여부</div>
				<div class="oddn-sel">
					<select id="is_finish" name="is_finish" de-data="전체">
						<option value="">전체</option>
						<option value="Y">완료</option>
						<option value="N">미완료</option>
					</select>
				</div>
			</div>
		</div>
		<div class="wid-2">
			<div class="table">
				<div class="sear-tit sear-tit-70">접수상태</div>
				<div class="oddn-sel"s>
					<select id="pelt_status" name="pelt_status" de-data="전체">
						<option value="">전체</option>
						<option value="play">모집중</option>
						<option value="finish">마감</option>
						<option value="end">폐강</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="top-row">
		<div class="wid-15">
			<div class="table table-90">
				<div class="sear-tit sear-tit-70">대분류</div>
				<div class="oddn-sel">
					<select de-data="전체" id="main_cd" name="main_cd" data-name="대분류" onchange="selMaincd(this)">
						<option value="">전체</option>
						<c:forEach var="j" items="${maincdList}" varStatus="loop">
							<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit-70">중분류</div>
				<div class="oddn-sel">
					<select de-data="전체" id="sect_cd" name="sect_cd" onchange="">
						<option value="">전체</option>
					</select>
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
		
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
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
				<col width="40px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_bapelttb.store')">지점 <img src="/img/th_up.png" id="sort_bapelttb.store"></th>
					<th onclick="reSortAjax('sort_is_finish')">유형 <img src="/img/th_up.png" id="sort_is_finish"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					
					<th onclick="reSortAjax('sort_bapelttb.subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_bapelttb.subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
					<th onclick="reSortAjax('sort_plan_cnt')">작성률 <img src="/img/th_up.png" id="sort_plan_cnt"></th>
					<th >강의계획서 </th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_bapelttb.store')">지점 <img src="/img/th_up.png" id="sort_bapelttb.store"></th>
					<th onclick="reSortAjax('sort_is_finish')">유형 <img src="/img/th_up.png" id="sort_is_finish"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류 <img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류 <img src="/img/th_up.png" id="sort_sect_nm"></th>					
					<th onclick="reSortAjax('sort_bapelttb.subject_cd')">강좌코드 <img src="/img/th_up.png" id="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명 <img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_bapelttb.subject_nm')">강좌명 <img src="/img/th_up.png" id="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료 <img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일 <img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간 <img src="/img/th_up.png" id="sort_lect_hour"></th>
					<th onclick="reSortAjax('sort_plan_cnt')">작성률 <img src="/img/th_up.png" id="sort_plan_cnt"></th>
					<th >강의계획서 </th>
				</tr>
			</thead>
			<tbody id="list_target">
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>분당점</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">이호걸</td> -->
<!-- 					<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">일요 밸런스 요가</td> -->
<!-- 					<td>80,000</td> -->
<!-- 					<td>목</td> -->
<!-- 					<td>10:30~11:50</td> -->
<!-- 					<td>50%</td> -->
<!-- 					<td class="color-red line-blue" onclick="location.href='/web/plan_write'" style="cursor:pointer;">미완료</td> -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
</div>
<div id="canc_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#canc_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">취소/환불 규정</h3>
        			<textarea id="canc_contents" name="canc_contents">
        			
        			</textarea>
        			<div class="btn-wr text-center">
        				<a class="btn btn02 ok-btn" onclick="javascript:insCanc();">저장</a>
        			</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>
<div id="sms_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#sms_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">강의계획서 작성요청</h3>
        			<textarea id="sms_contents" name="sms_contents">
        			
        			</textarea>
        			<div class="btn-wr text-center">
        				<a class="btn btn02 ok-btn" onclick="javascript:sendSms();">발송</a>
        			</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>
<script>
$(document).ready(function() {
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("year")) != "") { $("#selYear").val(nullChk(getCookie("year"))); $(".selYear").html($("#selYear option:checked").text());}
	fncPeri();
	if(nullChk(getCookie("season")) != "") { $("#selSeason").val(nullChk(getCookie("season"))); $(".selSeason").html($("#selSeason").val() + " / "+nullChk(getCookie("period")))}
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type"))); $(".search_type").html($("#search_type option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("pelt_status")) != "") { $("#pelt_status").val(nullChk(getCookie("pelt_status"))); $(".pelt_status").html($("#pelt_status option:checked").text());}
	if(nullChk(getCookie("is_finish")) != "") { $("#is_finish").val(nullChk(getCookie("is_finish"))); $(".is_finish").html($("#is_finish option:checked").text());}
	if(nullChk(getCookie("main_cd")) != "") { $("#main_cd").val(nullChk(getCookie("main_cd"))); $(".main_cd").html($("#main_cd option:checked").text());}
	selMaincd2(getCookie("main_cd"));
	if(nullChk(getCookie("sect_cd")) != "") { $("#sect_cd").val(nullChk(getCookie("sect_cd"))); $(".sect_cd").html($("#sect_cd option:checked").text());}
	setPeri();
	getList();
});
</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>