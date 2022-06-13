<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<link rel="import" href="/inc/date_picker/date_picker.html">
<style>
.redFont > td
{
color:red;
}
.grayFont > td
{
color:#bfbfbf;
}
</style>
<script>

function commentInit()
{
	$(".std-popbtn").each(function(){
		var close = $(this).find(".fa-window-close");
		var pop = $(this).find(".std-newpop");
		$(this).find("span").click(function(){
			pop.show();
		})
		close.click(function(){
			pop.hide();
		})
	})
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
	 			$("#search_start").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#search_end").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}
function tmInit()
{
	$(".tm-custlist > table > tbody > tr").each(function(){
		var mult = $(this).find(".tm-radi > span.tm");
		var mpop = $(this).find(".sms-pop");
		
		mult.click(function(){
			if(mpop.css("display") == "none"){
				mpop.css("display","block");
				mult.addClass("act");
			}else{
				mpop.hide()
				mult.removeClass("act");
			}
		})
	});
}
var sms_phone_no = "";
function openSms(kor_nm, phone_no){
	$("#sms_phone_no").html(phone_no);
	sms_phone_no = phone_no;
	$("#sms_kor_nm").html(kor_nm);
	$("#sms_layer").fadeIn(200);
}
function getList(paging_type)
{
	getListStart();
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("search_type", $("#search_type").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("main_cd", $("#main_cd").val(), 9999);
	setCookie("sect_cd", $("#sect_cd").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("search_start", $("#search_start").val(), 9999);
	setCookie("search_end", $("#search_end").val(), 9999);
	
	$.ajax({
		type : "POST", 
		url : "./getWaitLectList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val(),
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val()
			
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
					if(result.list[i].END_YN == "Y") //폐강강좌는 빨갛게!
					{
						inner += '<tr class="redFont">';
					}
					else if(result.list[i].IS_START == "Y") //시작일 지난강좌는 회색!
					{
						inner += '<tr class="grayFont">';
					}
					else
					{
						inner += '<tr>';
					}
					inner += '	<td>';
					inner += '		<input type="radio" id="radio_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'" name="radio_pelt" onclick="getWaiter(\''+result.list[i].STORE+'\',\''+result.list[i].PERIOD+'\',\''+result.list[i].SUBJECT_CD+'\')">';
					inner += '		<label for="radio_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].WEB_LECTURER_NM)+'</td>';
					inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CAPACITY_NO)+'</td>';
					inner += '	<td class="color-blue">'+comma(Number(nullChkZero(result.list[i].REGIS_NO)) + Number(nullChkZero(result.list[i].WEB_REGIS_NO)))+'</td>';
					inner += '	<td class="color-red">'+nullChk(result.list[i].POSSIBLE_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].WAIT_CNT)+'</td>';
					inner += '	<td>'+comma(result.list[i].REGIS_FEE)+'</td>';
					inner += '	<td>'+cutDate(nullChk(result.list[i].START_YMD))+'</td>';
					inner += '	<td>'+cutYoil(nullChk(result.list[i].DAY_FLAG))+'</td>';
					inner += '	<td>'+cutLectHour(nullChk(result.list[i].LECT_HOUR))+'</td>';
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
			getListEnd();
		}
	});	
}
var main_cd ="";
function selMaincd(idx){	

	main_cd = $(idx).val();
	
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		data : 
		{
			maincd : main_cd,
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
			
			$(".sect_cd_ul").append('<li>선택하세요</li>');
			$("#sect_cd").append('<option value="">선택하세요</option>');
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
			$(".sect_cd").html("선택하세요.");
		}
	});	
}
var selStore = "";
var selPeriod = "";
var selSubject_cd = "";
function getWaiter(store, period, subject_cd)
{
	getListStart();
	selStore = store;
	selPeriod = period;
	selSubject_cd = subject_cd;
	$.ajax({
		type : "POST", 
		url : "./getWaiter",
		dataType : "text",
		async : false,
		data : 
		{
			store : store,
			period : period,
			subject_cd : subject_cd
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
				var inner = "";
				var wait_cnt = 0;
				for(var i = 0; i < result.length; i++)
				{
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="waiter_'+result[i].CUST_NO+'_'+result[i].STORE+'_'+result[i].PERIOD+'_'+result[i].SUBJECT_CD+'" name="chk_waiter_list"><label for="waiter_'+result[i].CUST_NO+'_'+result[i].STORE+'_'+result[i].PERIOD+'_'+result[i].SUBJECT_CD+'"></label>';
					inner += '	</td>';
					if(result[i].DELETE_FG == "1")
					{
						wait_cnt++;
						inner += '	<td>'+wait_cnt+'</td>';
					}
					else
					{
						inner += '	<td></td>';
					}
					inner += '	<td>'+result[i].CUS_NO+'</td>';
					inner += '	<td class="txt-b">'+nullChk(result[i].PTL_ID)+'</td>';
					inner += '	<td>'+result[i].KOR_NM+'</td>';
					inner += '	<td>'+cutDate(result[i].BIRTH_YMD)+'</td>';
					if(result[i].IS_NEW != '0') 
					{
						inner += '	<td>기존</td>';
					}
					else 
					{
						inner += '	<td>신규</td>';
					}
					if(result[i].DELETE_FG == "1")
					{
						inner += '	<td>대기중</td>';
					}
					else if(result[i].DELETE_FG == "2")
					{
						inner += '	<td>등록</td>';
					}
					else if(result[i].DELETE_FG == "3")
					{
						inner += '	<td class="color-red">취소</td>';
					}
					inner += '	<td class="tm-radi tm-radi02"><span class="sms" onclick="javascript:openSms(\''+result[i].KOR_NM+'\', \''+nullChk(trim(result[i].PHONE_NO))+'\');">SMS</span> <span class="tm">TM</span>';
					inner += '   		<div class="sms-pop">';
					inner += '   			<div class="sms-con01">'+nullChk(trim(result[i].PHONE_NO))+'</div>';
// 					inner += '   			<div class="sms-con02">';
// 					inner += '   				('+result[i].KOR_NM+')';
// 					inner += '   				<span>통화메모를 남길 수 있습니다.</span>';
// 					inner += '   			</div>';
					inner += '		</div>';
					inner += '	</td>';
					inner += '	<td class="std-popbtn memo-radi memo-radi02">';
					inner += '		<span class="tm" style="font-size:10px;">MEMO</span>';
					inner += '		<div class="std-newpop">';
					inner += '		<textarea id="comment_'+result[i].STORE+'_'+result[i].PERIOD+'_'+result[i].SUBJECT_CD+'_'+trim(result[i].CUST_NO)+'">'+repWord(nullChk(result[i].COMMENTS))+'</textarea>';
					inner += '		<a class="btn btn03 ok-btn" onclick="javascript:insComment(\''+result[i].STORE+'\',\''+result[i].PERIOD+'\',\''+result[i].SUBJECT_CD+'\',\''+result[i].CUST_NO+'\');">저장</a>';
					inner += '			<i class="far fa-window-close"></i>';
					inner += '		</div>';
					inner += '	</td>';
					if(result[i].DELETE_FG == "1")
					{
						inner += '	<td>'+cutDate(trim(result[i].CREATE_DATE))+'</td>';
					}
					else if(result[i].DELETE_FG == "2")
					{
						inner += '	<td>'+cutDate(trim(result[i].UPDATE_DATE))+'</td>';
					}
					else if(result[i].DELETE_FG == "3")
					{
						inner += '	<td>'+cutDate(trim(result[i].CANCEL_DATE))+'</td>';
					}
					inner += '	<td>'+nullChk(result[i].NAME)+'</td>';
					inner += '</tr>';
				}
				
				
				$("#waiter").html(inner);
				tmInit();
				commentInit();
			}
			else
			{
			
			}
			getListEnd();
		}
	});	
}
function sendSms()
{
	$.ajax({
		type : "POST", 
		url : "/common/single_send_sms",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			phone_no : sms_phone_no.replace(/-/gi, ""),
			title : '대기자 순번 도래',
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
function insComment(store, period, subject_cd, cust_no)
{
	var comment = $("#comment_"+store+"_"+period+"_"+subject_cd+"_"+trim(cust_no)).val();
	
	$.ajax({
		type : "POST", 
		url : "./insComment",
		dataType : "text",
		async : false,
		data : 
		{
			store : store,
			period : period,
			subject_cd : subject_cd,
			cust_no : cust_no,
			comment : comment
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
    			getWaiter(store, period, subject_cd);
    		}
    		else
    		{
	    		alert(result.msg);
    		}
		}
	});	
}
function waitCancle()
{
	var chkList = "";
	$("input:checkbox[name='chk_waiter_list']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).attr("id").replace("waiter_", "")+"|";
    	}
	});
	if(chkList == "")
	{
		alert("선택값이 없습니다.");
		return;
	}
	$.ajax({
		type : "POST", 
		url : "./waitCancle",
		dataType : "text",
		async : false,
		data : 
		{
			chkList : chkList
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
function goSale()
{
	var chkList = "";
	var peoples = 0;
	$("input:checkbox[name='chk_waiter_list']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).attr("id").replace("waiter_", "");
    		peoples ++;
    	}
	});
	if(chkList == "")
	{
		alert("선택값이 없습니다.");
		return;
	}
	if(peoples > 1)
	{
		alert("2인이상 수강신청 불가합니다.");
		return;
	}
	location.href="/member/lect/view?data="+chkList;
// 	$.ajax({
// 		type : "POST", 
// 		url : "./waitCancle",
// 		dataType : "text",
// 		async : false,
// 		data : 
// 		{
// 			chkList : chkList
// 		},
// 		error : function() 
// 		{
// 			console.log("AJAX ERROR");
// 		},
// 		success : function(data) 
// 		{
// 			console.log(data);
// 			var result = JSON.parse(data);
// 			if(result.isSuc == "success")
//     		{
//     			alert(result.msg);
//     		}
//     		else
//     		{
// 	    		alert(result.msg);
//     		}
// 		}
// 	});	
}

</script>
<div id="sms_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg sms-edit">
        		<div class="close" onclick="$('#sms_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="smspop-wrap">
					<div class="sms-pop sms-pop-sms">
						<div class="sms-con01" id="sms_phone_no">010-2334-6740</div>
						<div class="sms-con02">
							<span id="sms_kor_nm">akadmin(이호걸)</span>
							<textarea id="sms_contents" name="sms_contents" placeholder="내용을 입력해주세요."></textarea>
						</div>
					</div>
				</div>
				<div class=" text-center" style="margin-top: 30px;">
					<a class="btn btn02 ok-btn" onclick="javascript:sendSms()">전송</a>
				</div>
        	</div>
        </div>
    </div>	
</div>
<div class="sub-tit">
	<h2>대기자관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>
	<div class="table-top">
		<div class="top-row">
			<div class="wid-3">
				<div class="table table02 table-input wid-contop">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
			<div class="wid-4">
				<div class="table table-90">
					<div class="search-wr sear-22 sel100">
						<select id="search_type" name="search_type" de-data="강좌명">
							<option value="subject_nm">강좌명</option>
							<option value="subject_cd">코드번호</option>
							<option value="cust_nm">회원명</option>
						</select>
					    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
				    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
					</div>
				</div>
			</div>
			<div class="wid-15">
				<div class="table">
					<div class="sear-tit sear-tit_70">대분류</div>
					<div>
						<select de-data="선택하세요." id="main_cd" name="main_cd" data-name="대분류" class="notEmpty" onchange="selMaincd(this)">
							<option value="">선택하세요</option>
							<c:forEach var="j" items="${maincdList}" varStatus="loop">
								<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="wid-15">
				<div class="table">
					<div class="sear-tit sear-tit_70">중분류</div>
					<div>
						<select de-data="선택하세요." id="sect_cd" name="sect_cd" data-name="중분류" class="notEmpty" onchange="">

						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="top-row">
			<div class="wid-4">
				<div class="table table-90">
					<div class="sear-tit sear-tit-120">강좌시작일</div>
					<div>
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" class="date-i start-i" id="search_start" name="search_start"/>
								<i class="material-icons">event_available</i>
							</div>
							<div class="cal-dash">-</div>
							<div class="cal-input wid-4">
								<input type="text" class="date-i ready-i" id="search_end" name="search_end"/>
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>			
			</div>
<!-- 			<div class="wid-25"> -->
<!-- 				<div class="table"> -->
<!-- 					<div class="sear-tit">강좌명</div> -->
<!-- 					<div> -->
<!-- 						<input type="text" id="" name=""placeholder="입력하세요."> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 			<div class="wid-25"> -->
<!-- 				<div class="table"> -->
<!-- 					<div class="sear-tit">강좌코드</div> -->
<!-- 					<div> -->
<!-- 						<input type="text" id="" name=""placeholder="입력하세요."> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
		
	</div>
	<div class="table-cap table">
		<div class="cap-l">
			<h2>대기자가 있는 강좌</h2>
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			<div class="table float-right">
				<div class="sel-scr">
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
<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col width="500px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th onclick="reSortAjax('sort_main_cd')">대분류<img src="/img/th_up.png" id="sort_main_cd"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원<img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_tot_regis_no')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_possible_no')">잔여<img src="/img/th_up.png" id="sort_possible_no"></th>
					<th onclick="reSortAjax('sort_TO_NUMBER(wait_cnt)')">대기자수<img src="/img/th_up.png" id="sort_TO_NUMBER(wait_cnt)"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일<img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간<img src="/img/th_up.png" id="sort_lect_hour"></th>					
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-list-shot">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col width="500px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="80px">
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th onclick="reSortAjax('sort_main_cd')">대분류<img src="/img/th_up.png" id="sort_main_cd"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_web_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_web_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원<img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_tot_regis_no')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_possible_no')">잔여<img src="/img/th_up.png" id="sort_possible_no"></th>
					<th onclick="reSortAjax('sort_TO_NUMBER(wait_cnt)')">대기자수<img src="/img/th_up.png" id="sort_TO_NUMBER(wait_cnt)"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_day_flag')">강의요일<img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">강의시간<img src="/img/th_up.png" id="sort_lect_hour"></th>					
				</tr>
			</thead>
			<tbody id="list_target">
				<c:forEach var="i" items="${list}" varStatus="loop">
					<tr>
						<td>
							<input type="radio" id="radio_${i.STORE}_${i.PERIOD}_${i.SUBJECT_CD}" name="radio_pelt" onclick="getWaiter('${i.STORE}','${i.PERIOD}','${fn:trim(i.SUBJECT_CD)}')">
							<label for="radio_${loop.index}"></label>
						</td>
						<td>${i.MAIN_NM }</td>
						<td>${i.SUBJECT_FG_NM }</td>
						<td>${i.SUBJECT_CD }</td>
						<td>${i.WEB_LECTURER_NM }</td>
						<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">${i.SUBJECT_NM }</td>
						<td>${i.CAPACITY_NO }</td>
						<td class="color-blue">${i.REGIS_NO }</td>
						<td class="color-red">${i.CAPACITY_NO - i.REGIS_NO}</td>
						<td>${i.WAIT_CNT }</td>
						<td>${i.REGIS_FEE }</td>
						<td>
							<c:set var="day_flag" value="${i.DAY_FLAG }"/>
							<script>
							var yoil = "";
							var day_flag = '${day_flag}';
							if(day_flag.split('')[0] == "1")
							{
								yoil += ",월";
							}
							if(day_flag.split('')[1] == "1")
							{
								yoil += ",화";
							}
							if(day_flag.split('')[2] == "1")
							{
								yoil += ",수";
							}
							if(day_flag.split('')[3] == "1")
							{
								yoil += ",목";
							}
							if(day_flag.split('')[4] == "1")
							{
								yoil += ",금";
							}
							if(day_flag.split('')[5] == "1")
							{
								yoil += ",토";
							}
							if(day_flag.split('')[6] == "1")
							{
								yoil += ",일";
							}
							yoil = yoil.substring(1, yoil.length);
							document.write(yoil);
							</script>
						</td>
						<td>${fn:substring(i.LECT_HOUR,0,2)}:${fn:substring(i.LECT_HOUR,2,4)}~${fn:substring(i.LECT_HOUR,4,6)}:${fn:substring(i.LECT_HOUR,6,8)}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</div>

<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<div class="table-cap table">
	<div class="cap-l wid-4">
		<h2>대기자 리스트</h2>
<!-- 			<p class="cap-numb"></p> -->
	</div>
<!-- 		<div class="cap-r text-right"> -->
<!-- 			<div class="table table02 table-auto float-right"> -->
<!-- 				<div class="sel-scr">					 -->
<!-- <!-- 					<a class="btn btn01 btn-mar6" href="#">제외</a> --> 
<!-- <!-- 					<a class="btn btn01 btn-mar6" href="#">제외 취소</a> --> 
<!-- <!-- 					<a class="btn btn01 btn-mar6" href="#">포기</a> --> 
<!-- 					<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a> -->
<!-- 					<select id="listSize" name="listSize" onchange="reSelect()" de-data="10개 보기"> -->
<!-- 						<option value="10">10개 보기</option> -->
<!-- 						<option value="20">20개 보기</option> -->
<!-- 						<option value="50">50개 보기</option> -->
<!-- 						<option value="100">100개 보기</option> -->
<!-- 						<option value="300">300개 보기</option> -->
<!-- 						<option value="500">500개 보기</option> -->
<!-- 						<option value="1000">1000개 보기</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
</div>
<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
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
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_waiter" name="chk_waiter" value="chk_waiter_list"><label for="chk_waiter"></label>
					</th>
					<th>순번<i class="material-icons">import_export</i></th>
					<th>멤버스번호<i class="material-icons">import_export</i></th>
					<th>포털ID<i class="material-icons">import_export</i></th>
					<th>회원명<i class="material-icons">import_export</i></th>
					<th>생년월일<i class="material-icons">import_export</i></th>
					<th>회원구분<i class="material-icons">import_export</i></th>
					<th>상태<i class="material-icons">import_export</i></th>
					<th>SMS/TM<i class="material-icons">import_export</i></th>
					<th>메모<i class="material-icons">import_export</i></th>
					<th>처리일<i class="material-icons">import_export</i></th>
					<th>담당자<i class="material-icons">import_export</i></th>			
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list tm-custlist table-list-shot">
		<table>
			<colgroup>
				<col width="40px">
				<col width="60px">
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
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_waiter" name="chk_waiter" value="chk_waiter_list"><label for="chk_waiter"></label>
					</th>
					<th>순번<i class="material-icons">import_export</i></th>
					<th>멤버스번호<i class="material-icons">import_export</i></th>
					<th>포털ID<i class="material-icons">import_export</i></th>
					<th>회원명<i class="material-icons">import_export</i></th>
					<th>생년월일<i class="material-icons">import_export</i></th>
					<th>회원구분<i class="material-icons">import_export</i></th>
					<th>상태<i class="material-icons">import_export</i></th>
					<th>SMS/TM<i class="material-icons">import_export</i></th>
					<th>메모<i class="material-icons">import_export</i></th>
					<th>처리일<i class="material-icons">import_export</i></th>
					<th>담당자<i class="material-icons">import_export</i></th>
				</tr>
			</thead>
			<tbody id="waiter">
				
			</tbody>
		</table>
	</div>
	
	
	<div class="btn-wr text-center">
		<a class="btn btn03 ok-btn" onclick="javascript:goSale();">수강신청</a>
		<a class="btn btn03 ok-btn" onclick="javascript:waitCancle();">대기취소</a>
<!-- 		<a class="btn btn01 ok-btn" href="">삭제</a> -->
<!-- 		<a class="btn btn02 ok-btn" onclick="javascript:();">저장</a> -->
	</div>
	
</div>


<script>
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
$(document).ready(function(){
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	selPeri();
	if(nullChk(getCookie("search_start")) != "") { $("#search_start").val(nullChk(getCookie("search_start")));}
	if(nullChk(getCookie("search_end")) != "") { $("#search_end").val(nullChk(getCookie("search_end")));}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type"))); $(".search_type").html($("#search_type option:checked").text());}
	if(nullChk(getCookie("main_cd")) != "") { $("#main_cd").val(nullChk(getCookie("main_cd"))); $(".main_cd").html($("#main_cd option:checked").text());}
	selMaincd2(getCookie("main_cd"));
	if(nullChk(getCookie("sect_cd")) != "") { $("#sect_cd").val(nullChk(getCookie("sect_cd"))); $(".sect_cd").html($("#sect_cd option:checked").text());}
	
	
	$("#chk_waiter").change(function() {
		if($("input:checkbox[name='chk_waiter']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_waiter").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_waiter").val()+"']").prop("checked", false);
		}
	});
	/* 알림톡 팝업 */
	
	fncPeri();
	getList();
	//지점 바꾸면 대분류,중분류 초기화
	$(".selBranch_ul > li").click( function() {
		$("#sect_cd").empty();
		$(".sect_cd_ul").html("");
		$(".sect_cd_ul").append('<li>전체</li>');
		$("#sect_cd").append('<option value="">전체</option>');
		
		$("#main_cd").val("");
		$(".main_cd").html("전체");
		$("#sect_cd").val("");
		$(".sect_cd").html("전체");
	});
	tmInit();
	commentInit();
});
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>