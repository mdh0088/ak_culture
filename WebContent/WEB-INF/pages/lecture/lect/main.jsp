<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
var scr_stat = getCookie("scr_stat");
var page = 1;
var order_by = "";
var sort_type = "";
var m_page = 1;
var m_order_by = "";
var m_sort_type = "";
var isLoading = false;
$(function(){
	$(".listSize").parent().addClass("listSize-box");
	$(".listSize2").parent().addClass("listSize-box");
})

function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".search-btn02").addClass("loading-sear");
	$(".search-btn02").prop("disabled", true);
	$(".btn02").addClass("loading-sear");
	$(".btn02").prop("disabled", true);
	$(".search-btn").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".search-btn02").removeClass("loading-sear");		
	$(".search-btn02").prop("disabled", false);
	$(".btn02").removeClass("loading-sear");		
	$(".btn02").prop("disabled", false);
	$(".search-btn").prop("disabled", false);
	isLoading = false;
}
$(document).ready(function(){
	setPeri();
	fncPeri();
	$("#chk_all1").change(function() {
		if($("input:checkbox[name='chk_all1']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all1").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all1").val()+"']").prop("checked", false);
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
});
function getLectListAll()
{
	page = 1;
	order_by = "";
	sort_type = "";
	m_page = 1;
	m_order_by = "";
	m_sort_type = "";
	
	getLectList(1);
	getLectList(2);
}
function getLectList(val, paging_type)
{
	var mon = '0'
	var tue = '0'
	var wed = '0'
	var thu = '0'
	var fri = '0'
	var sat = '0'
	var sun = '0'
	
	if($("#yoil_mon").is(":checked"))
	{
		mon = '1';
	}
	if($("#yoil_tue").is(":checked"))
	{
		tue = '1';
	}
	if($("#yoil_wed").is(":checked"))
	{
		wed = '1';
	}
	if($("#yoil_thu").is(":checked"))
	{
		thu = '1';
	}
	if($("#yoil_fri").is(":checked"))
	{
		fri = '1';
	}
	if($("#yoil_sat").is(":checked"))
	{
		sat = '1';
	}
	if($("#yoil_sun").is(":checked"))
	{
		sun = '1';
	}
	var day_flag = mon+""+tue+""+wed+""+thu+""+fri+""+sat+""+sun;
	if(val == 1)
	{
		setCookie("page", page, 9999);
		setCookie("order_by", order_by, 9999);
		setCookie("sort_type", sort_type, 9999);
		setCookie("listSize", $("#listSize").val(), 9999);
		setCookie("store", $("#selBranch").val(), 9999);
		setCookie("period", $("#selPeri").val(), 9999);
		setCookie("search_type", $("#search_type").val(), 9999);
		setCookie("search_name", $("#search_name").val(), 9999);
		setCookie("pelt_status", $("#pelt_status").val(), 9999);
		setCookie("subject_fg", $("#subject_fg").val(), 9999);
		setCookie("main_cd", $("#main_cd").val(), 9999);
		setCookie("sect_cd", $("#sect_cd").val(), 9999);
		setCookie("day_flag", day_flag, 9999);
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getLectList",
			dataType : "text",
			data : 
			{
				listSize : $("#listSize").val(),
				page : page,
				order_by : order_by,
				sort_type : sort_type,
				
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				search_type : $("#search_type").val(),
				search_name : $("#search_name").val(),
				pelt_status : $("#pelt_status").val(),
				subject_fg : $("#subject_fg").val(),
				main_cd : $("#main_cd").val(),
				sect_cd : $("#sect_cd").val(),
				day_flag : day_flag
// 				search_start : $("#search_start").val(),
// 				search_end : $("#search_end").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				$(".cap-numb").eq(0).html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
				var inner = "";
				
				if(result.list.length > 0)
				{
					for(var i = 0; i < result.list.length; i++)
					{
						if(result.list[i].ISPLAY == '폐강')
						{
							inner += '<tr class="bg-red">';
						}
						else if(result.list[i].ISPLAY == '마감')
						{
							inner += '<tr class="bg-blue">';
						}
						else
						{
							inner += '<tr>';
						}
						inner += '	<td class="td-chk">';
						inner += '		<input type="checkbox" id="val1_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'" name="chk_val1"><label for="val1_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'"></label>';
						inner += '	</td>';
						inner += '	<td>'+result.list[i].RNUM+'</td>';
						inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
						inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
						inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+nullChk(result.list[i].LECTURER_NM)+'</td>';
						inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
						inner += '	<td>'+cutLectHour(result.list[i].LECT_HOUR)+'</td>';
						inner += '	<td>'+comma(result.list[i].REGIS_FEE)+'</td>';
						if(result.list[i].FOOD_YN == 'Y')
						{
							inner += '	<td>'+comma(result.list[i].FOOD_AMT)+'</td>';
						}
						else if(result.list[i].FOOD_YN == 'R')
						{
							inner += '	<td>별도</td>';
						}
						else
						{
							inner += '	<td>0</td>';
						}
						inner += '	<td>'+result.list[i].LECT_CNT+'</td>';
						inner += '	<td>'+cutDate(result.list[i].START_YMD).substring(2)+'</td>';
						inner += '	<td>'+cutDate(result.list[i].END_YMD).substring(2)+'</td>';
						inner += '	<td>'+result.list[i].CORP_FG+'</td>';
						inner += '	<td>'+nullChk(result.list[i].ISPLAY)+'</td>';
						inner += '	<td>'+cutDate(nullChk(result.list[i].WEB_CANCEL_YMD))+'</td>';
						
						inner += '</tr>';
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="16"><div class="no-data">검색결과가 없습니다.</div></td>';
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
		setCookie("m_page", m_page, 9999);
		setCookie("m_order_by", m_order_by, 9999);
		setCookie("m_sort_type", m_sort_type, 9999);
		setCookie("listSize2", $("#listSize2").val(), 9999);
		setCookie("act", '중도', 9999);
		setCookie("store", $("#selBranch").val(), 9999);
		setCookie("period", $("#selPeri").val(), 9999);
		setCookie("search_type", $("#search_type").val(), 9999);
		setCookie("search_name", $("#search_name").val(), 9999);
		setCookie("pelt_status", $("#pelt_status").val(), 9999);
		setCookie("subject_fg", $("#subject_fg").val(), 9999);
		setCookie("main_cd", $("#main_cd").val(), 9999);
		setCookie("sect_cd", $("#sect_cd").val(), 9999);
		setCookie("day_flag", day_flag, 9999);
		getListStart();
		$.ajax({
			type : "POST", 
			url : "./getLectList",
			dataType : "text",
			data : 
			{
				listSize : $("#listSize2").val(),
				page : m_page,
				order_by : m_order_by,
				sort_type : m_sort_type,
				act : '중도',
				
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				search_type : $("#search_type").val(),
				search_name : $("#search_name").val(),
				pelt_status : $("#pelt_status").val(),
				subject_fg : $("#subject_fg").val(),
				main_cd : $("#main_cd").val(),
				sect_cd : $("#sect_cd").val(),
				day_flag : day_flag
// 				search_start : $("#search_start").val(),
// 				search_end : $("#search_end").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				$(".cap-numb").eq(1).html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
				var inner = "";
				
				if(result.list.length > 0)
				{
					for(var i = 0; i < result.list.length; i++)
					{
						inner += '<tr>';
						inner += '	<td class="td-chk">';
						inner += '		<input type="checkbox" id="val2_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'" name="chk_val2"><label for="val2_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'"></label>';
						inner += '	</td>';
						inner += '	<td>'+result.list[i].RNUM+'</td>';
						inner += '	<td>'+nullChk(result.list[i].MAIN_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SECT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SUBJECT_FG_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].SUBJECT_CD)+'</td>';
						inner += '	<td class="color-blue line-blue text-left" onclick="location.href=\'/lecture/lect/list_detail?store='+trim(result.list[i].STORE)+'&period='+trim(result.list[i].PERIOD)+'&subject_cd='+trim(result.list[i].SUBJECT_CD)+'\'" style="cursor:pointer;">'+result.list[i].SUBJECT_NM+'</td>';
						inner += '	<td class="color-blue line-blue" onclick="location.href=\'/lecture/lecr/listed?cn='+result.list[i].CUS_NO+'\'" style="cursor:pointer;">'+nullChk(result.list[i].LECTURER_NM)+'</td>';
						inner += '	<td>'+cutYoil(result.list[i].DAY_FLAG)+'</td>';
						inner += '	<td>'+cutLectHour(result.list[i].LECT_HOUR)+'</td>';
						inner += '	<td>'+comma(result.list[i].REGIS_FEE)+'</td>';
						if(result.list[i].FOOD_YN == 'Y')
						{
							inner += '	<td>'+comma(result.list[i].FOOD_AMT)+'</td>';
						}
						else
						{
							inner += '	<td>0</td>';
						}
						inner += '	<td>'+result.list[i].LECT_CNT+'</td>';
						inner += '	<td>'+cutDate(result.list[i].START_YMD).substring(2)+'</td>';
						inner += '	<td>'+cutDate(result.list[i].END_YMD).substring(2)+'</td>';
						inner += '	<td>'+result.list[i].CORP_FG+'</td>';
						if(result.list[i].SUBJECT_FG == '1')
						{
							inner += '	<td>정규</td>';	
						}
						else if(result.list[i].SUBJECT_FG == '2')
						{
							inner += '	<td>단기</td>';
						}
						else if(result.list[i].SUBJECT_FG == '3')
						{
							inner += '	<td>특강</td>';
						}
						inner += '	<td>'+result.list[i].CREATE_RESI_NM+'</td>';
						inner += '</tr>';
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="17"><div class="no-data">검색결과가 없습니다.</div></td>';
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
	thSize();
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
		page = 1;
		getLectList(1);
	}
}
function pageMoveAjax(nowPage)
{
	if(!isLoading)
	{
		page = nowPage;
		getLectList(1);
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
			$("."+act).attr("src", "/img/th_down.png");
		}
		else if(m_order_by == "desc")
		{
		
			m_order_by = "asc";
			$("."+act).attr("src", "/img/th_up.png");
		}
		else if(m_order_by == "asc")
		{
			
			m_order_by = "desc";
			$("."+act).attr("src", "/img/th_down.png");
		}
		m_page = 1;
		getLectList(2);
	}
}
function pageMoveAjax2(nowPage)
{
	if(!isLoading)
	{
		m_page = nowPage;
		getLectList(2);
	}
}
function pageMoveScroll(nowPage)
{
	page = nowPage;
	getLectList(1, 'scroll');
}
function pageMoveScroll2(nowPage)
{
	m_page = nowPage;
	getLectList(2, 'scroll');
}
function setMid()
{
	var chkList = "";
	var chkCnt = 0;
	$("input:checkbox[name='chk_val1']").each(function(){
	    if($(this).is(":checked"))
    	{
	    	chkCnt ++;
    		chkList = $(this).attr("id").replace("val1_", "");
    	}
	});
	if(chkList == "")
	{
		alert("강좌가 선택되지 않았습니다.");
		return;
	}
	else if(chkCnt > 1)
	{
		alert("중도수강코드 생성은 하나씩만 가능합니다.");
		return;
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "./setMid",
			dataType : "text",
			async : false,
			data : 
			{
				mid : chkList
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				$("#mid_start_ymd").val(cutDate(result.start_ymd));
				$("#mid_lect_cnt").val(result.lect_cnt);
				$("#mid_regis_fee").val(result.regis_fee);
				$("#mid_food_amt").val(result.food_amt);
				
				$("#mid_store").val(result.store);
				$("#mid_period").val(result.period);
				$("#mid_subject_cd").val(result.subject_cd);
				
				$('#mid_layer').fadeIn(200);
				
// 				if(result.isSuc == "success")
// 	    		{
// 	    			alert(result.msg);
// 	    			getLectListAll();
// 	    		}
// 	    		else
// 	    		{
// 		    		alert(result.msg);
// 	    		}
			}
		});	
	}
	
}

function lectDel(idx){
	var chkList = "";
	var chkCnt = 0;
	$("input:checkbox[name='chk_val"+idx+"']").each(function(){
	    if($(this).is(":checked"))
    	{
	    	chkCnt ++;
    		chkList=chkList + trim($(this).attr("id").replace("val"+idx+"_", ""))+'|';
    	}
	});
	if(chkList == "")
	{
		alert("강좌가 선택되지 않았습니다.");
		return;
	}
	else
	{
		$.ajax({
			type : "POST", 
			url : "./lectDel",
			dataType : "text",
			async : false,
			data : 
			{
				mid : chkList
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
 	    			getLectListAll();
 	    		}
 	    		else
 	    		{
 		    		alert(result.msg);
 	    		}
			}
		});
		
	}
	

}
function goSale()
{
	var chkList = "";
	var peoples = 0;
	$("input:checkbox[name='chk_val2']").each(function(){
	    if($(this).is(":checked"))
    	{
	    	peoples ++;
    		chkList=chkList + trim($(this).attr("id").replace("val2_", "0_"));
    	}
	});
	if(chkList == "")
	{
		alert("선택값이 없습니다.");
		return;
	}
	if(peoples > 1)
	{
		alert("2개 강좌 이상 수강신청 불가합니다.");
		return;
	}
	location.href="/member/lect/view?data="+chkList;

}
function computeMid()
{
	$.ajax({
		type : "POST", 
		url : "./computeMid",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#mid_store").val(),
			period : $("#mid_period").val(),
			subject_cd : $("#mid_subject_cd").val(),
			start_ymd : $("#mid_start_ymd").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			$("#mid_start_ymd").val(cutDate(result.start_ymd));
			$("#mid_lect_cnt").val(result.lect_cnt);
			$("#mid_regis_fee").val(result.regis_fee);
			$("#mid_food_amt").val(result.food_amt);
		}
	});		
}
function getPrevPeri()
{
	if(!isLoading)
	{
		var con = false;
		if(confirm("전기 개설강좌의 수에 따라 10분 이상 소요될 수 있습니다.\n그래도 진행하시겠습니까?"))
		{
			$.ajax({
				type : "POST", 
				url : "./getPrevPeri_ready",
				dataType : "text",
				async : false,
				data : 
				{
					store : $("#selBranch").val(),
					period : $("#selPeri").val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					if(Number(data) > 0)
					{
						if(confirm(data+"개의 강좌가 중복됩니다.\n중복되는 강좌는 무시하고 등록됩니다.\n그래도 진행하시겠습니까?"))
						{
							con = true;
						}
					}
					else
					{
						con = true;
					}
				}
			});	
			
			if(con)
			{
				getListStart();
				$.ajax({
					type : "POST", 
					url : "./getPrevPeri",
					dataType : "text",
					async : false,
					data : 
					{
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
						getListEnd();
					}
				});	
			}
		}
	}
}
function makeMid()
{
	$.ajax({
		type : "POST", 
		url : "./makeMid",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#mid_store").val(),
			period : $("#mid_period").val(),
			subject_cd : $("#mid_subject_cd").val(),
			start_ymd : $("#mid_start_ymd").val()
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
    			getLectListAll();
    			$('#mid_layer').fadeOut(200);
    		}
    		else
    		{
	    		alert(result.msg);
    		}
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


</script>

<div class="sub-tit">
	<h2>개설강좌등록 메인</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn02" onclick="javascript:getPrevPeri()">전기 개설강좌 불러오기</a>
<!-- 		<a class="btn btn01 btn01_1" href="/lecture/lect/attend">출석부 관리 </a> -->
	</div>
</div>

<div class="table-top table-top02">
	<div class="top-row sear-wr">
		<div class="wid-10">
			<div class="table">
				<div class="wid-7">
					<div class="table table-auto">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div class="wid-3">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class="oddn-sel sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	<div class="top-row">
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

		<div class="wid-45 mag-r2">
			<div class="table">
				<div class="search-wr sel100 search-wr_div">
					<select id="search_type" name="search_type" de-data="강좌명">
						<option value="subject_nm">강좌명</option>
						<option value="subject_cd">코드번호</option>
						<option value="lecturer_nm">강사명</option>
					</select>
					<div class="search-wr_div02 sear-6">
					    <input type="text" id="search_name" class="inp-100" name="search_name" onkeypress="excuteEnter(getLectListAll)" placeholder="검색어를 입력하세요.">
					    <input class="search-btn" type="button" value="검색" onclick="getLectListAll()">
					</div>
				</div>
			</div>
		</div>
		<div class="wid-15">
			<div class="table">
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
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit-70">유형</div>
				<div class="oddn-sel">
					<select id="subject_fg" name="subject_fg" de-data="전체">
						<option value="">전체</option>
						<option value="1">정규</option>
						<option value="2">단기</option>
						<option value="3">특강</option>
					</select>
				</div>
			</div>
		</div>
	</div>
	<div class="top-row">
		<div class="wid-45 mag-r2">
			<div class="table">
				<div class="sear-tit sear-tit-70">요일</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="yoil_mon" name="yoil_mon" checked>
							<label for="yoil_mon">월</label>
						</li>
						<li>
							<input type="checkbox" id="yoil_tue" name="yoil_tue" checked>
							<label for="yoil_tue">화</label>
						</li>
						<li>
							<input type="checkbox" id="yoil_wed" name="yoil_wed" checked>
							<label for="yoil_wed">수</label>
						</li>
						<li>
							<input type="checkbox" id="yoil_thu" name="yoil_thu" checked>
							<label for="yoil_thu">목</label>
						</li>
						<li>
							<input type="checkbox" id="yoil_fri" name="yoil_fri" checked>
							<label for="yoil_fri">금</label>
						</li>
						<li>
							<input type="checkbox" id="yoil_sat" name="yoil_sat" checked>
							<label for="yoil_sat">토</label>
						</li>
						<li>
							<input type="checkbox" id="yoil_sun" name="yoil_sun" checked>
							<label for="yoil_sun">일</label>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
		
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit-70">접수상태</div>
				<div class="oddn-sel">
					<select id="pelt_status" name="pelt_status" de-data="전체">
						<option value="">전체</option>
						<option value="end">폐강</option>
						<option value="notEnd">폐강제외</option>
					</select>
				</div>
			</div>
		</div>
<!-- 		<div class="wid-4"> -->
<!-- 			<div class="table margin-auto"> -->
<!-- 				<div class="sear-tit">강좌시작일</div> -->
<!-- 				<div> -->
<!-- 					<div class="cal-row cal-row02 table"> -->
<!-- 						<div class="cal-input wid-4"> -->
<!-- 							<input type="text" class="date-i start-i" id="search_start" name="search_start"/> -->
<!-- 							<i class="material-icons">event_available</i> -->
<!-- 						</div> -->
<!-- 						<div class="cal-dash">-</div> -->
<!-- 						<div class="cal-input wid-4"> -->
<!-- 							<input type="text" class="date-i ready-i" id="search_end" name="search_end"/> -->
<!-- 							<i class="material-icons">event_available</i> -->
<!-- 						</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div>			 -->
<!-- 		</div> -->
		
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getLectListAll()">
</div>
<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
				<a class="btn btn02" href="/lecture/lect/write">강의 신규등록</a>
				<select id="listSize" name="listSize" onchange="getLectList(1)" de-data="10개 보기">
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
				<col width="40px">
				<col>
				<col>
				<col width="60px">
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="100px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all1" name="chk_all1" value="chk_val1"><label for="chk_all1"></label>
					</th>
					<th>NO.</th>
					<th onclick="reSortAjax('sort_main_nm')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류<img src="/img/th_up.png" id="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_bapelttb.subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax('sort_bapelttb.subject_nm')">강좌명<img src="/img/th_up.png" id="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_day_flag')">요일<img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">시간<img src="/img/th_up.png" id="sort_lect_hour"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비<img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">횟수<img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_corp_fg')">할인여부<img src="/img/th_up.png" id="sort_corp_fg"></th>
					<th onclick="reSortAjax('sort_end_yn')">개설구분<img src="/img/th_up.png" id="sort_end_yn"></th>
					<th onclick="reSortAjax('sort_web_cancel_ymd')">취소마감일<img src="/img/th_up.png" id="sort_web_cancel_ymd"></th>				
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list scroll1">
		<table>
			<colgroup>
				<col width="40px">
				<col width="40px">
				<col>
				<col>
				<col width="60px">
				<col>
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="100px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all1" name="chk_all1" value="chk_val1"><label for="chk_all1"></label>
					</th>
					<th>NO.</th>
					<th onclick="reSortAjax('sort_main_nm')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류<img src="/img/th_up.png" id="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax('sort_bapelttb.subject_cd')">강좌코드<img src="/img/th_up.png" id="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax('sort_bapelttb.subject_nm')">강좌명<img src="/img/th_up.png" id="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_day_flag')">요일<img src="/img/th_up.png" id="sort_day_flag"></th>
					<th onclick="reSortAjax('sort_lect_hour')">시간<img src="/img/th_up.png" id="sort_lect_hour"></th>
					<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비<img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_lect_cnt')">횟수<img src="/img/th_up.png" id="sort_lect_cnt"></th>
					<th onclick="reSortAjax('sort_start_ymd')">시작일<img src="/img/th_up.png" id="sort_start_ymd"></th>
					<th onclick="reSortAjax('sort_end_ymd')">종료일<img src="/img/th_up.png" id="sort_end_ymd"></th>
					<th onclick="reSortAjax('sort_corp_fg')">할인여부<img src="/img/th_up.png" id="sort_corp_fg"></th>
					<th onclick="reSortAjax('sort_end_yn')">개설구분<img src="/img/th_up.png" id="sort_end_yn"></th>
					<th onclick="reSortAjax('sort_web_cancel_ymd')">취소마감일<img src="/img/th_up.png" id="sort_web_cancel_ymd"></th>				
				</tr>
			</thead>
			<tbody class="list1">
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>43</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">일요 밸런스 요가</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">이호걸</td> -->
<!-- 					<td>목</td> -->
<!-- 					<td>10:30~11:50</td> -->
<!-- 					<td>80,000</td> -->
<!-- 					<td>30,000</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>Y</td> -->
<!-- 					<td>개강</td>					 -->
<!-- 				</tr> -->
				
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>43</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">일요 밸런스 요가</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">이호걸</td> -->
<!-- 					<td>목</td> -->
<!-- 					<td>10:30~11:50</td> -->
<!-- 					<td>80,000</td> -->
<!-- 					<td>30,000</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>Y</td> -->
<!-- 					<td>개강</td>					 -->
<!-- 				</tr> -->
				
<!-- 				<tr class="bg-red">			 -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>43</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">일요 밸런스 요가</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">이호걸</td> -->
<!-- 					<td>목</td> -->
<!-- 					<td>10:30~11:50</td> -->
<!-- 					<td>80,000</td> -->
<!-- 					<td>30,000</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>Y</td> -->
<!-- 					<td>폐강</td>					 -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	<div class="paging1">
	</div>
	
	<div class="btn-wr text-center">
		<a class="btn btn03" onclick="javascript:setMid();">중도 수강코드 생성</a>
		<a class="btn btn01" onclick="javascript:lectDel('1');">삭제</a>
	</div>
</div>


<br><br>
<div class="table-cap table ">
	<div class="cap-l">
		<h2>중도 수강 리스트</h2>
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
				<select id="listSize2" name="listSize2" onchange="getLectList(2)" de-data="10개 보기">
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
				<col width="60px">
				<col width="60px">
				<col>
				<col width="200px">
				<col>
				<col width="60px">
				<col>
				<col>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="100px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all2" name="chk_all2" value="chk_val2"><label for="chk_all2"></label>
					</th>
					<th>NO.</th>
					<th onclick="reSortAjax2('sort_main_nm')">대분류<img src="/img/th_up.png" class="sort_main_nm"></th>
					<th onclick="reSortAjax2('sort_sect_nm')">중분류<img src="/img/th_up.png" class="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax2('sort_bapelttb.subject_cd')">강좌코드<img src="/img/th_up.png" class="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax2('sort_bapelttb.subject_nm')">강좌명<img src="/img/th_up.png" class="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax2('sort_lecturer_nm')">강사명<img src="/img/th_up.png" class="sort_lecturer_nm"></th>
					<th  onclick="reSortAjax2('sort_day_flag')">요일<img src="/img/th_up.png" class="sort_day_flag"></th>
					<th onclick="reSortAjax2('sort_lect_hour')">시간<img src="/img/th_up.png" class="sort_lect_hour"></th>
					<th onclick="reSortAjax2('sort_regis_fee')">수강료<img src="/img/th_up.png" class="sort_regis_fee"></th>
					<th onclick="reSortAjax2('sort_food_amt')">재료비<img src="/img/th_up.png" class="sort_food_amt"></th>
					<th onclick="reSortAjax2('sort_lect_cnt')">횟수<img src="/img/th_up.png" class="sort_lect_cnt"></th>
					<th onclick="reSortAjax2('sort_start_ymd')">시작일<img src="/img/th_up.png" class="sort_start_ymd"></th>
					<th onclick="reSortAjax2('sort_end_ymd')">종료일<img src="/img/th_up.png" class="sort_end_ymd"></th>
					<th onclick="reSortAjax2('sort_corp_fg')">할인여부<img src="/img/th_up.png" id="sort_corp_fg"></th>
					<th onclick="reSortAjax2('sort_subject_fg')">강좌유형<img src="/img/th_up.png" class="sort_subject_fg"></th>
					<th onclick="reSortAjax2('sort_create_resi_no')">개설 담당자<img src="/img/th_up.png" class="sort_create_resi_no"></th>				
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list scroll2">
		<table>
			<colgroup>
				<col width="60px">
				<col width="60px">
				<col>
				<col width="60px">
				<col width="60px">
				<col>
				<col width="200px">
				<col>
				<col width="60px">
				<col>
				<col>
				<col width="60px">
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="100px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all2" name="chk_all2" value="chk_val2"><label for="chk_all2"></label>
					</th>
					<th>NO.</th>
					<th onclick="reSortAjax2('sort_main_nm')">대분류<img src="/img/th_up.png" class="sort_main_nm"></th>
					<th onclick="reSortAjax2('sort_sect_nm')">중분류<img src="/img/th_up.png" class="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_subject_fg')">유형<img src="/img/th_up.png" id="sort_subject_fg"></th>
					<th onclick="reSortAjax2('sort_bapelttb.subject_cd')">강좌코드<img src="/img/th_up.png" class="sort_bapelttb.subject_cd"></th>
					<th onclick="reSortAjax2('sort_bapelttb.subject_nm')">강좌명<img src="/img/th_up.png" class="sort_bapelttb.subject_nm"></th>
					<th onclick="reSortAjax2('sort_lecturer_nm')">강사명<img src="/img/th_up.png" class="sort_lecturer_nm"></th>
					<th  onclick="reSortAjax2('sort_day_flag')">요일<img src="/img/th_up.png" class="sort_day_flag"></th>
					<th onclick="reSortAjax2('sort_lect_hour')">시간<img src="/img/th_up.png" class="sort_lect_hour"></th>
					<th onclick="reSortAjax2('sort_regis_fee')">수강료<img src="/img/th_up.png" class="sort_regis_fee"></th>
					<th onclick="reSortAjax2('sort_food_amt')">재료비<img src="/img/th_up.png" class="sort_food_amt"></th>
					<th onclick="reSortAjax2('sort_lect_cnt')">횟수<img src="/img/th_up.png" class="sort_lect_cnt"></th>
					<th onclick="reSortAjax2('sort_start_ymd')">시작일<img src="/img/th_up.png" class="sort_start_ymd"></th>
					<th onclick="reSortAjax2('sort_end_ymd')">종료일<img src="/img/th_up.png" class="sort_end_ymd"></th>
					<th onclick="reSortAjax2('sort_corp_fg')">할인여부<img src="/img/th_up.png" id="sort_corp_fg"></th>
					<th onclick="reSortAjax2('sort_subject_fg')">강좌유형<img src="/img/th_up.png" class="sort_subject_fg"></th>
					<th onclick="reSortAjax2('sort_create_resi_no')">개설 담당자<img src="/img/th_up.png" class="sort_create_resi_no"></th>				
				</tr>
			</thead>
			<tbody class="list2">
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>43</td> -->
<!-- 					<td>성인</td> -->
<!-- 					<td>건강/웰빙</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td class="color-blue line-blue text-left" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">일요 밸런스 요가</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lect/listed'" style="cursor:pointer;">이호걸</td> -->
<!-- 					<td>목</td> -->
<!-- 					<td>10:30~11:50</td> -->
<!-- 					<td>80,000</td> -->
<!-- 					<td>30,000</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2020-03-01</td> -->
<!-- 					<td>2020-05-31</td> -->
<!-- 					<td>Y</td> -->
<!-- 					<td>정규</td>	 -->
<!-- 					<td>김지연</td>					 -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	<div class="paging2">
	</div>
	<div class="btn-wr text-center">
		<a class="btn btn02" onclick="javascript:goSale();">수강신청</a>
		<a class="btn btn01" onclick="javascript:lectDel('2');">삭제</a>
	</div>
</div>



<div id="mid_layer" class="list-edit-wrap popwid-500">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg">
        		<div class="close" onclick="javascript:$('#mid_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="mid-wrap">
	        		<h3 class="status_now">중도 수강코드 생성</h3>
	        		<div class="ak-wrap_new">
						<div class="table">
							<div class="sear-tit">시작일</div>
							<div>
								<input type="text" class="date-i notEmpty" id="mid_start_ymd" name="mid_start_ymd" onchange="computeMid()"/>
							</div>
						</div>
						<div class="table">
							<div class="sear-tit">횟수</div>
							<div>
								<input type="text" id="mid_lect_cnt" name="mid_lect_cnt" class="inputDisabled"/>
							</div>
						</div>
						<div class="table">
							<div class="sear-tit">수강료</div>
							<div>
								<input type="text" id="mid_regis_fee" name="mid_regis_fee" class="inputDisabled"/>
							</div>
						</div>
						<div class="table">
							<div class="sear-tit">재료비</div>
							<div>
								<input type="text" id="mid_food_amt" name="mid_food_amt" class="inputDisabled"/>
							</div>
						</div>
					</div>
	        		
	        		<input type="hidden" id="mid_store" name="mid_store">
	        		<input type="hidden" id="mid_period" name="mid_period">
	        		<input type="hidden" id="mid_subject_cd" name="mid_subject_cd">
	        		<div class="btn-wr text-center">
	        			<a class="btn btn02" onclick="javascript:makeMid();">저장</a>
					</div>
	        		
				</div>
        	</div>
        </div>
    </div>	
</div>
<script>
$(document).ready(function(){
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("m_page")) != "") { m_page = nullChk(getCookie("m_page")); }
	if(nullChk(getCookie("m_order_by")) != "") { m_order_by = nullChk(getCookie("m_order_by")); }
	if(nullChk(getCookie("m_sort_type")) != "") { m_sort_type = nullChk(getCookie("m_sort_type")); }
	if(nullChk(getCookie("listSize2")) != "") { $("#listSize2").val(nullChk(getCookie("listSize2"))); $(".listSize2").html($("#listSize2 option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	fncPeri();
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type"))); $(".search_type").html($("#search_type option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("pelt_status")) != "") { $("#pelt_status").val(nullChk(getCookie("pelt_status"))); $(".pelt_status").html($("#pelt_status option:checked").text());}
	if(nullChk(getCookie("subject_fg")) != "") { $("#subject_fg").val(nullChk(getCookie("subject_fg"))); $(".subject_fg").html($("#subject_fg option:checked").text());}
	if(nullChk(getCookie("main_cd")) != "") { $("#main_cd").val(nullChk(getCookie("main_cd"))); $(".main_cd").html($("#main_cd option:checked").text());}
	selMaincd2(getCookie("main_cd"));
	if(nullChk(getCookie("sect_cd")) != "") { $("#sect_cd").val(nullChk(getCookie("sect_cd"))); $(".sect_cd").html($("#sect_cd option:checked").text());}
	if(nullChk(getCookie("day_flag")) != "") 
	{
		var mon = getCookie("day_flag").substring(0,1);
		if(mon == "1")
		{
			$("input:checkbox[id='yoil_mon']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_mon']").prop("checked", false);
		}
		var tue = getCookie("day_flag").substring(1,2);
		if(tue == "1")
		{
			$("input:checkbox[id='yoil_tue']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_tue']").prop("checked", false);
		}
		var wed = getCookie("day_flag").substring(2,3);
		if(wed == "1")
		{
			$("input:checkbox[id='yoil_wed']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_wed']").prop("checked", false);
		}
		var thu = getCookie("day_flag").substring(3,4);
		if(thu == "1")
		{
			$("input:checkbox[id='yoil_thu']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_thu']").prop("checked", false);
		}
		var fri = getCookie("day_flag").substring(4,5);
		if(fri == "1")
		{
			$("input:checkbox[id='yoil_fri']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_fri']").prop("checked", false);
		}
		var sat = getCookie("day_flag").substring(5,6);
		if(sat == "1")
		{
			$("input:checkbox[id='yoil_sat']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_sat']").prop("checked", false);
		}
		var sun = getCookie("day_flag").substring(6,7);
		if(sun == "1")
		{
			$("input:checkbox[id='yoil_sun']").prop("checked", true);   
		}
		else
		{
			$("input:checkbox[id='yoil_sun']").prop("checked", false);
		}
	}
	getLectListAll();
})
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

$(document).ready(function() {
	
	
});

</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>