<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker_month.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown1()
{
	var filename = "지급리스트";
	var table = "excelTable1";
    exportExcel(filename, table);
}
function excelDown2()
{
	var filename = "지급제외 리스트";
	var table = "excelTable2";
    exportExcel(filename, table);
}
$(function(){
	$(".listSize").parent().addClass("listSize-box");
})

var scr_stat = getCookie("scr_stat");
var page = 1;
var order_by = "";
var sort_type = "";
var m_page = 1;
var m_order_by = "";
var m_sort_type = "";
var isLoading = false;
function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".search-btn02").addClass("loading-sear");
	$(".search-btn02").prop("disabled", true);
	$(".search-btn").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".search-btn02").removeClass("loading-sear");			
	$(".search-btn02").prop("disabled", false);
	$(".search-btn").prop("disabled", false);
	isLoading = false;
	checkInit();
}
$(document).ready(function(){
	setPeri();
	fncPeri();
});
function checkInit()
{
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
	$("#chk_all2").change(function() {
		if($("input:checkbox[name='chk_all2']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all2").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all2").val()+"']").prop("checked", false);
		}
	});
}
function periInit()
{
	getPayMonth('food');
}
function getPaymentCheckAll()
{
	page = 1;
	order_by = "";
	sort_type = "";
	m_page = 1;
	m_order_by = "";
	m_sort_type = "";
	getPaymentCheck(1);
	getPaymentCheck(2);
}
var food_ym = "";
function getPaymentCheck(val, paging_type)
{
	if(val == 1)
	{
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getFoodList",
			dataType : "text",
			data : 
			{
				page : page,
				order_by : order_by,
				sort_type : sort_type,
				listSize : $("#listSize").val(),
				
				food_ym : $("input[name='food_ym']:checked").val().substring(0,6),
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				submit_yn : $("#submit_yn").val(),
				act : 'Y' //지급제외여부
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				if(result.isSuc != "success")
				{
					alert(result.msg);
					getListEnd();
					return;
				}
				var inner = "";
				$(".cap-numb").eq(0).html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
				if(result.list.length > 0)
				{
					food_ym = result.list[0].FOOD_YM;
					for(var i = 0; i < result.list.length; i++)
					{
						if(result.list[i].END_YN == "Y")
						{
							inner += '<tr class="bg-red" id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
						}
						else
						{
							inner += '<tr id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
						}
						inner += '	<td><input type="checkbox" id="chk_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'" name="chk_val" value=""><label for="chk_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'"></label></td>';
						inner += '	<td>'+result.list[i].LECTURE_NM+'</td>';
						inner += '	<td>'+result.list[i].BIRTH_YMD+'</td>';
						inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
						inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
						inner += '	<td>'+cutDate(result.list[i].START_YMD)+'</td>';
						inner += '	<td>'+cutDate(result.list[i].END_YMD)+'</td>';
						inner += '	<td>'+nullChkZero(result.list[i].REGIS_NO)+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_FOOD_AMT))+'</td>';
// 						inner += '	<td>'+result.list[i].PART_REGIS_FEE+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.list[i].TOT_FOOD_AMT))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.list[i].FOOD_PAY_AMT_1))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.list[i].FOOD_PAY_AMT_2))+'</td>';
						inner += '	<td>'+comma(nullChkZero(result.list[i].FOOD_PAY_AMT_3))+'</td>';
						inner += '	<td>'+result.list[i].SUBMIT_YN+'</td>';
						inner += '</tr>';
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="14"><div class="no-data">검색결과가 없습니다.</div></td>';
					inner += '</tr>';
				}
				
				order_by = result.order_by;
				sort_type = result.sort_type;
				search_name = result.search_name;
				if(paging_type == "scroll")
				{
					if(result.list.length > 0)
					{
						$(".list1").append(inner);
					}
				}
				else
				{
					$(".list1").html(inner);
				}
				$(".paging1").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
				getListEnd();
			}
		});	
	}
	else
	{
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getFoodList",
			dataType : "text",
			data : 
			{
				page : m_page,
				order_by : m_order_by,
				sort_type : m_sort_type,
				listSize : $("#listSize2").val(),
				
				food_ym : $("input[name='food_ym']:checked").val().substring(0,6),
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				submit_yn : $("#submit_yn").val(),
				act : 'N' //지급제외여부
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				if(result.isSuc != "success")
				{
					getListEnd();
					return;
				}
				var inner = "";
				$(".cap-numb").eq(1).html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
				
				if(result.list.length > 0)
				{
					for(var i = 0; i < result.list.length; i++)
					{
						if(result.list[i].END_YN == "Y")
						{
							inner += '<tr class="bg-red" id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
						}
						else
						{
							inner += '<tr id="tr_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'">';
						}
						
						inner += '	<td><input type="checkbox" id="chk2_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'" name="chk_val2" value=""><label for="chk2_'+trim(result.list[i].STORE)+'_'+trim(result.list[i].PERIOD)+'_'+trim(result.list[i].SUBJECT_CD)+'_'+result.list[i].JOURNAL_YN+'"></label></td>';
						inner += '	<td>'+result.list[i].LECTURE_NM+'</td>';
						inner += '	<td>'+result.list[i].BIRTH_YMD+'</td>';
						inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
						inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
						inner += '	<td>'+result.list[i].START_YMD+'</td>';
						inner += '	<td>'+result.list[i].END_YMD+'</td>';
						inner += '	<td>'+result.list[i].REGIS_NO+'</td>';
						inner += '	<td>'+result.list[i].TOT_FOOD_AMT+'</td>';
// 						inner += '	<td>'+result.list[i].PART_REGIS_FEE+'</td>';
						inner += '	<td>'+result.list[i].TOT_FOOD_AMT+'</td>';
						inner += '	<td>'+comma(nullChk(result.list[i].FOOD_PAY_AMT_1))+'</td>';
						inner += '	<td>'+comma(nullChk(result.list[i].FOOD_PAY_AMT_2))+'</td>';
						inner += '	<td>'+comma(nullChk(result.list[i].FOOD_PAY_AMT_3))+'</td>';
						inner += '	<td>'+result.list[i].SUBMIT_YN+'</td>';
						inner += '</tr>';
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="14"><div class="no-data">검색결과가 없습니다.</div></td>';
					inner += '</tr>';
				}
				m_order_by = result.order_by;
				m_sort_type = result.sort_type;
				m_search_name = result.search_name;
				if(paging_type == "scroll")
				{
					if(result.list.length > 0)
					{
						$(".list2").append(inner);
					}
				}
				else
				{
					$(".list2").html(inner);
				}
				$(".paging2").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 2));
				getListEnd();
			}
		});	
	}
}
function makePaging(nowPage, s_page, e_page, pageNum, val)
{
	if(val == 1)
	{
		page = nowPage;
		var inner = "";
		if(scr_stat == "ON")
		{
			inner += '<div class="page_num" style="display:none;">';
		}
		else
		{
			inner += '<div class="page_num" style="display:block;">';
		}
		if(Number(page) > 5)
		{
			inner += '		<a onclick="javascript:pageMoveAjax(1);"> ◀◀ </a>';
			inner += '    	<a onclick="javascript:pageMoveAjax('+(Number(s_page)-1)+');"> ◀ </a>';
		}
		var pagingCnt = 0;
		if(e_page != '0')
		{
			for(var i = Number(s_page); i <= Number(e_page); i++)
			{
				pagingCnt ++;
				if(i == page)
				{
					inner += '			<a onclick="javascript:pageMoveAjax('+i+');" id="p_'+i+'" class="p_btn active">'+i+'</a>';
				}
				else
				{
					inner += '			<a onclick="javascript:pageMoveAjax('+i+');" id="p_'+i+'" class="p_btn">'+i+'</a>';
				}
			}
		}
		if(e_page == '0')
		{
			inner += '		 <a onclick="javascript:pageMoveAjax(1);">1</a>';
		}
		if(pageNum != page)
		{
			if(Number(pageNum) > 5)
			{
				if(pagingCnt > 4)
				{
					if(Number(e_page)+1 > Number(pageNum))
					{
						inner += '            		<a onclick="javascript:pageMoveAjax('+pageNum+');"> ▶ </a>'; 
						inner += '            		<a onclick="javascript:pageMoveAjax('+pageNum+');"> ▶▶ </a>'; 
					}
					else
					{
						inner += '					<a onclick="javascript:pageMoveAjax('+(Number(e_page)+1)+');"> ▶ </a>';
						inner += '            		<a onclick="javascript:pageMoveAjax('+pageNum+');"> ▶▶ </a>'; 
					}
				}
			}
		}
		inner += '</div>';
		return inner;
	}
	else
	{
		m_page = nowPage;
		var inner = "";
		if(scr_stat == "ON")
		{
			inner += '<div class="page_num" style="display:none;">';
		}
		else
		{
			inner += '<div class="page_num" style="display:block;">';
		}
		if(Number(m_page) > 5)
		{
			inner += '		<a onclick="javascript:pageMoveAjax2(1);"> ◀◀ </a>';
			inner += '    	<a onclick="javascript:pageMoveAjax2('+(Number(s_page)-1)+');"> ◀ </a>';
		}
		var pagingCnt = 0;
		if(e_page != '0')
		{
			for(var i = Number(s_page); i <= Number(e_page); i++)
			{
				pagingCnt ++;
				if(i == m_page)
				{
					inner += '			<a onclick="javascript:pageMoveAjax2('+i+');" id="p_'+i+'" class="p_btn active">'+i+'</a>';
				}
				else
				{
					inner += '			<a onclick="javascript:pageMoveAjax2('+i+');" id="p_'+i+'" class="p_btn">'+i+'</a>';
				}
			}
		}
		if(e_page == '0')
		{
			inner += '		 <a onclick="javascript:pageMoveAjax2(1);">1</a>';
		}
		if(pageNum != m_page)
		{
			if(Number(pageNum) > 5)
			{
				if(pagingCnt > 4)
				{
					if(Number(e_page)+1 > Number(pageNum))
					{
						inner += '            		<a onclick="javascript:pageMoveAjax2('+pageNum+');"> ▶ </a>'; 
						inner += '            		<a onclick="javascript:pageMoveAjax2('+pageNum+');"> ▶▶ </a>'; 
					}
					else
					{
						inner += '					<a onclick="javascript:pageMoveAjax2('+(Number(e_page)+1)+');"> ▶ </a>';
						inner += '            		<a onclick="javascript:pageMoveAjax2('+pageNum+');"> ▶▶ </a>'; 
					}
				}
			}
		}
		inner += '</div>';
		return inner;
	}
	isLoading = false;
}
function reSortAjax(act)
{
	if(!isLoading)
	{
		sort_type = act.replace("sort_", "");
		if(order_by == "")
		{
			order_by = "desc";
		}
		else if(order_by == "desc")
		{
			order_by = "asc";
		}
		else if(order_by == "asc")
		{
			order_by = "desc";
		}
		page = 1;
		getPaymentCheck(1);
	}
}
function pageMoveAjax(nowPage)
{
	if(!isLoading)
	{
		page = nowPage;
		getPaymentCheck(1);
	}
}
function reSortAjax2(act)
{
	if(!isLoading)
	{
		m_sort_type = act.replace("sort_", "");
		if(m_order_by == "")
		{
			m_order_by = "desc";
		}
		else if(m_order_by == "desc")
		{
			m_order_by = "asc";
		}
		else if(m_order_by == "asc")
		{
			m_order_by = "desc";
		}
		m_page = 1;
		getPaymentCheck(2);
	}
}
function pageMoveAjax2(nowPage)
{
	if(!isLoading)
	{
		m_page = nowPage;
		getPaymentCheck(2);
	}
}
function pageMoveScroll(nowPage)
{
	page = nowPage;
	getPaymentCheck(1, 'scroll');
}
function pageMoveScroll2(nowPage)
{
	m_page = nowPage;
	getPaymentCheck(2, 'scroll');
}
function jr_action()
{
	var chkList = "";
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).attr("id").replace("chk_", "")+"|";
    	}
	});
	
	$.ajax({
		type : "POST", 
		url : "./saveFood",
		dataType : "text",
		async : false,
		data : 
		{
			chkList : chkList,
			act : $("#jr_act").val(),
			food_ym : $("input[name='food_ym']:checked").val()
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
				alert("저장되었습니다.");
			}
			else
			{
				alert(result.msg);
			}
		}
	});	
}
function setExcept(act)
{
	var chkList = "";
	if(act == "N")
	{
		$("input:checkbox[name='chk_val']").each(function(){
		    if($(this).is(":checked"))
	    	{
		    	var tr = $(this).attr("id").replace("chk_", "tr_");
		    	var tr_html = '<tr id="'+tr+'">'+$("#"+tr).html().replace(/chk_0/gi, "chk2_0").replace(/chk_val/gi, "chk_val2")+'</tr>';
		    	$("#"+tr).remove();
		    	$(".list2").append(tr_html);
	    	}
		});
	}
	else
	{
		$("input:checkbox[name='chk_val2']").each(function(){
		    if($(this).is(":checked"))
	    	{
		    	var tr = $(this).attr("id").replace("chk2_", "tr_");
		    	var tr_html = '<tr id="'+tr+'">'+$("#"+tr).html().replace(/chk2_0/gi, "chk_0").replace(/chk_val2/gi, "chk_val")+'</tr>';
		    	$("#"+tr).remove();
		    	$(".list1").append(tr_html);
	    	}
		});
	}
	checkInit();
}
</script>
<div class="sub-tit">
	<h2>재료비 점검</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<!-- 
	<div class="btn-right">
		<a class="btn btn02" href="#">재료비 계산 </a>
		<a class="btn btn01 btn01_1" href="#">계산 취소 </a>
	</div>
	 -->
</div>


<div class="table-top">
	<div class="top-row sear-wr">
		<div class="">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<div class="oddn-sel02">
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
		</div>
		<div class="mag-l2">
			<div class="table table-auto">
				<div class="sear-tit sear-tit_left">대상연월</div>
				<div>
					<ul class="chk-ul" id="ul_radio">
							
					</ul>
				</div>
			</div>
		</div>
		<div class="wid-2 mag-l2">
			<div class="table">
				<div class="sear-tit sear-tit_left">마감여부</div>
				<div>
					<select id="submit_yn" name="submit_yn" de-data="전체">
						<option value="">전체</option>
						<option value="Y">Y</option>
						<option value="N">N</option>
					</select>
				</div>
			</div>
		</div>
<!-- 		<div class="wid-2 "> -->
<!-- 			<div class="table"> -->
<!-- 				<div class="sear-tit sear-tit_90 sear-tit_left">차수</div> -->
<!-- 				<div> -->
<!-- 					<select id="pay_day" name="pay_day" de-data="전체"> -->
<!-- 						<option value="">전체</option> -->
<!-- 						<option value="1">1</option> -->
<!-- 						<option value="2">2</option> -->
<!-- 						<option value="3">3</option> -->
<!-- 					</select> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getPaymentCheckAll()">
</div>


<div class="table-wr">
	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			<div class="table table02 table-auto float-right sel-scr">
				<div>
					<p class="ip-ritit">선택한 강좌를</p>
				</div>
				<div>
					<select de-data="마감" id="jr_act" name="jr_act">
						<option value="Y">마감</option>
						<option value="N">마감취소</option>
					</select>
					<a class="bor-btn btn03 btn-mar6" onclick="javascript:jr_action();">반영</a>
				</div>
				<div>			
					<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown1();"><i class="fas fa-file-download"></i></a>
					<select id="listSize" name="listSize" onchange="getPaymentCheck(1)" de-data="10개 보기">
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
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col />
				<col />
				<col />
				<col  width="200px">
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk"><input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_regis_fee')">정상입금액<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_tot_regis_fee')">총 재료비<img src="/img/th_up.png" id="sort_tot_regis_fee"></th>
					<th>1차입금액</th>
					<th>2차입금액</th>
					<th>3차입금액</th>
					<th onclick="reSortAjax('sort_submit_yn')">마감여부<img src="/img/th_up.png" id="sort_confirm_yn"></th>
				</tr>	
			</thead>
		</table>
	</div>
	<div class="table-list table-csplist scroll1">
		<table id="excelTable1">
			<colgroup>
				<col width="40px">
				<col />
				<col />
				<col />
				<col  width="200px">
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk"><input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_regis_fee')">정상입금액<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_tot_regis_fee')">총 재료비<img src="/img/th_up.png" id="sort_tot_regis_fee"></th>
					<th>1차입금액</th>
					<th>2차입금액</th>
					<th>3차입금액</th>
					<th onclick="reSortAjax('sort_submit_yn')">마감여부<img src="/img/th_up.png" id="sort_confirm_yn"></th>
				</tr>			
			</thead>
			<tbody class="list1">
<!-- 				<tr> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>개인</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>3,600,000</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td class="bg-red">3,600,000</td> -->
<!-- 					<td class="bg-gray">2,000,000</td> -->
<!-- 					<td class="bg-gray">1,600,000</td> -->
<!-- 					<td class="bg-blue">0</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>		 -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>3,600,000</td> -->
<!-- 					<td>1</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td class="bg-red">3,600,000</td> -->
<!-- 					<td class="bg-gray">2,000,000</td> -->
<!-- 					<td class="bg-gray">1,600,000</td> -->
<!-- 					<td class="bg-blue">0</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>		 -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	<div class="paging1">
	</div>
</div>
<div class="text-center move-updo give-wrap">
	<div class="move-arrow">
		<div class="next-btn bor-btn btn01"><i class="material-icons" onclick="setExcept('N')">keyboard_arrow_down</i></div>
		<div class="prev-btn bor-btn btn01"><i class="material-icons" onclick="setExcept('Y')">keyboard_arrow_up</i></div>
	</div>
</div>
<div class="table-wr">
	<div class="table-cap table">
		<div class="cap-l">
			<h2>지급제외 리스트</h2>
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			<div class="table table02 table-auto float-right sel-scr">
				<div>			
					<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown2();"><i class="fas fa-file-download"></i></a>
					<select id="listSize2" name="listSize2" onchange="getPaymentCheck(2)" de-data="10개 보기">
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
	
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col />
				<col />
				<col />
				<col  width="200px">
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk"><input type="checkbox" id="chk_all2" name="chk_all2" value="chk_val2"><label for="chk_all2"></label></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_tot_food_amt')">정상입금액<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_tot_food_amt')">총 재료비<img src="/img/th_up.png" id="sort_tot_regis_fee"></th>
					<th>1차입금액</th>
					<th>2차입금액</th>
					<th>3차입금액</th>
					<th onclick="reSortAjax('sort_submit_yn')">마감여부<img src="/img/th_up.png" id="sort_confirm_yn"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-csplist scroll2">
		<table id="excelTable2">
			<colgroup>
				<col width="40px">
				<col />
				<col />
				<col />
				<col  width="200px">
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
				<col />
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk"><input type="checkbox" id="chk_all2" name="chk_all2" value="chk_val2"><label for="chk_all2"></label></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_regis_no')">현원<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_tot_food_amt')">정상입금액<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_tot_food_amt')">총 재료비<img src="/img/th_up.png" id="sort_tot_regis_fee"></th>
					<th>1차입금액</th>
					<th>2차입금액</th>
					<th>3차입금액</th>
					<th onclick="reSortAjax('sort_submit_yn')">마감여부<img src="/img/th_up.png" id="sort_confirm_yn"></th>
				</tr>				
			</thead>
			<tbody class="list2">
<!-- 				<tr> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>개인</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>3,600,000</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td class="bg-red">3,600,000</td> -->
<!-- 					<td class="bg-gray">2,000,000</td> -->
<!-- 					<td class="bg-gray">1,600,000</td> -->
<!-- 					<td class="bg-blue">0</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>		 -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>3,600,000</td> -->
<!-- 					<td>1</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td class="bg-red">3,600,000</td> -->
<!-- 					<td class="bg-gray">2,000,000</td> -->
<!-- 					<td class="bg-gray">1,600,000</td> -->
<!-- 					<td class="bg-blue">0</td> -->
<!-- 					<td>2019-09-01</td> -->
<!-- 					<td>소윤진</td>		 -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	<div class="paging2">
	</div>
</div>
<script>
$(document).ready(function(){
	getPayMonth('food');
	getPaymentCheckAll();
});
$(document).ready(function(){
	if(scr_stat == "ON")
	{
		$(".listSize-box").hide();
		$(".table-list").scroll(function() {
			var scrollTop = $(this).scrollTop();
	        var innerHeight = $(this).innerHeight();
	        var scrollHeight = $(this).prop('scrollHeight');

	        if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)
	        {
	        	if(!isLoading)
	        	{
	        		isLoading = true;
		        	page = page + 1;
		        	if($(this).hasClass("scroll1"))
	        		{
			        	page = page + 1;
			        	pageMoveScroll(page);
	        		}
	        		else if($(this).hasClass("scroll2"))
	        		{
			        	m_page = m_page + 1;
			        	pageMoveScroll2(m_page);
	        		}
	        	}
	        }
		});
	}
	else
	{
		$(".listSize-box").show();
	}
})
</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>