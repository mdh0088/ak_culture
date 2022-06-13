<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown1()
{
	var filename = "거래선 신규등록";
	var table = "excelTable1";
    exportExcel(filename, table);
}
function excelDown2()
{
	var filename = "거래선 처리결과";
	var table = "excelTable2";
    exportExcel(filename, table);
}
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
// 	trans_add();
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
});
function getLecrLineListAll()
{
	page = 1;
	order_by = "";
	sort_type = "";
	m_page = 1;
	m_order_by = "";
	m_sort_type = "";
	getLecrLineList(1);
	getLecrLineList(2);
}
function getLecrLineList1()
{
	page = 1;
	order_by = "";
	sort_type = "";
	getLecrLineList(1);
}
function getLecrLineList2()
{
	m_page = 1;
	m_order_by = "";
	m_sort_type = "";
	getLecrLineList(2);
}
function getLecrLineList(val, paging_type)
{
	if(val == 1)
	{
		setCookie("page", page, 9999);
		setCookie("order_by", order_by, 9999);
		setCookie("sort_type", sort_type, 9999);
		setCookie("listSize", $("#listSize").val(), 9999);
		setCookie("store", $("#selBranch").val(), 9999);
		setCookie("search_name1", $("#search_name1").val(), 9999);
		setCookie("search_corp_fg1", $("#search_corp_fg1").val(), 9999);
		
		$.ajax({
			type : "POST", 
			url : "./getLecrLineList",
			dataType : "text",
			data : 
			{
				listSize : $("#listSize").val(),
				store : $("#selBranch").val(),
				page : page,
				order_by : order_by,
				sort_type : sort_type,
				search_name : $("#search_name1").val(),
				search_corp_fg : $("#search_corp_fg1").val()
				
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
						var corp_fg_nm = "";
						if(result.list[i].CORP_FG == "1")
						{
							corp_fg_nm = "법인";
						}
						else if(result.list[i].CORP_FG == "2")
						{
							corp_fg_nm = "개인";
						}
						
						inner += '<tr>';			
						inner += '	<td class="td-chk">';
						inner += '		<input type="checkbox" id="val1_'+result.list[i].LECTURER_CD+'" name="chk_val1"><label for="val1_'+result.list[i].LECTURER_CD+'"></label>';
						inner += '	</td>';
						inner += '	<td>'+result.list[i].LECTURER_KOR_NM+'</td>';
						inner += '	<td>'+nullChk(result.list[i].LECR_PHONE)+'</td>';
						inner += '	<td>'+cutJumin(result.list[i].LECTURER_CD)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].LECR_ADDR)+'</td>';
						inner += '	<td>'+cutBiz(nullChk(result.list[i].BIZ_NO))+'</td>';
						inner += '	<td>'+corp_fg_nm+'</td>';
						inner += '	<td>'+nullChk(result.list[i].PRESIDENT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].BANK_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].ACCOUNT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].ACCOUNT_NO)+'</td>';
						inner += '	<td>';
						if(nullChk(result.list[i].STATUS_FG) == '')
						{
							inner += '상신전';
						}
						else if(nullChk(result.list[i].STATUS_FG) == 'I' || nullChk(result.list[i].STATUS_FG) == 'F')
						{
							inner += '상신대기';
						}
						inner += '	</td>';
						inner += '	<td></td>';				
						inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';				
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
		setCookie("search_name2", $("#search_name2").val(), 9999);
		setCookie("search_corp_fg2", $("#search_corp_fg2").val(), 9999);
		
		$.ajax({
			type : "POST", 
			url : "./getLecrLineList",
			dataType : "text",
			data : 
			{
				listSize : $("#listSize2").val(),
				page : m_page,
				order_by : m_order_by,
				sort_type : m_sort_type,
				
				store : $("#selBranch").val(),
// 				period : $("#selPeri").val(),
				search_name : $("#search_name2").val(),
				search_corp_fg : $("#search_corp_fg2").val(),
				status_fg : 'Y'
// 				is_new : $("#is_new").val()
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
						var corp_fg_nm = "";
						if(result.list[i].CORP_FG == "1")
						{
							corp_fg_nm = "법인";
						}
						else if(result.list[i].CORP_FG == "2")
						{
							corp_fg_nm = "개인";
						}
						
						inner += '<tr>';			
						inner += '	<td>'+result.list[i].LECTURER_KOR_NM+'</td>';
						inner += '	<td>'+nullChk(result.list[i].LECR_PHONE)+'</td>';
						inner += '	<td>'+cutJumin(result.list[i].LECTURER_CD)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].LECR_ADDR)+'</td>';
						inner += '	<td>'+cutBiz(nullChk(result.list[i].BIZ_NO))+'</td>';
						inner += '	<td>'+corp_fg_nm+'</td>';
						inner += '	<td>'+nullChk(result.list[i].PRESIDENT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].BANK_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].ACCOUNT_NM)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].ACCOUNT_NO)+'</td>';
						inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
						inner += '</tr>';
					}
				}
				else
				{
					inner += '<tr>';
					inner += '	<td colspan="11"><div class="no-data">검색결과가 없습니다.</div></td>';
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
		getLecrLineList(1);
	}
}
function pageMoveAjax(nowPage)
{
	if(!isLoading)
	{
		page = nowPage;
		getLecrLineList(1);
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
		getLecrLineList(2);
	}
}
function pageMoveAjax2(nowPage)
{
	if(!isLoading)
	{
		m_page = nowPage;
		getLecrLineList(2);
	}
}
function pageMoveScroll(nowPage)
{
	page = nowPage;
	getLecrLineList(1, 'scroll');
}
function pageMoveScroll2(nowPage)
{
	m_page = nowPage;
	getLecrLineList(2, 'scroll');
}

//파일관련
$("#voc_file").change(function(e){
	var get_file = document.getElementById("voc_file");
	var get_size = 0;
	var max_size = 5 * 1024 * 1024;//5MB
	if ('files' in get_file) {
		//파일수 체크
	    if (get_file.files.length > 5) {
	        alert("파일은 5개까지 등록 가능합니다.");
	        document.getElementById("voc_file").value = "";
	        return;
	    }
	    //파일용량 체크
	    for(var i = 0; i < get_file.files.length; i++){
			get_size += get_file.files[i].size;
	    }
		if(get_size > max_size){
			alert("파일용량이 5MB를 초과하였습니다");
			document.getElementById("voc_file").value = "";
			return;
		}
	}
});
$(function(){

	/* 알림톡 팝업 */
	$(".trans_tablelist > table > tbody > tr").each(function(){
		var mult = $(this).find(".cancel-wr");
		var mpop = $(this).find(".cancel-pop");
		
		mult.click(function(){
			if(mpop.css("display") == "none"){
				mpop.css("display","block");
			}else{
				mpop.css("display","none");
			}
			
		})
		
	});
});	
function confirm()
{
	$('#confirm_layer').fadeIn(200);	
}

var chkList = "";
function delLecr()
{
	chkList = "";
	$("input:checkbox[name='chk_val1']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += '\''+$(this).attr("id").replace("val1_", "")+'\',';
    	}
	});
	if(chkList == "")
	{
		alert("거래선이 선택되지 않았습니다.");
		return;
	}
	else
	{
		chkList = chkList.substring(0, chkList.length-1);
		$.ajax({
			type : "POST", 
			url : "./delLecr",
			dataType : "text",
			async:false,
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
	    			location.reload();
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});	
	}
}
function filePopup()
{
	chkList = "";
	$("input:checkbox[name='chk_val1']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += '\''+$(this).attr("id").replace("val1_", "")+'\',';
    	}
	});
	if(chkList == "")
	{
		alert("거래선이 선택되지 않았습니다.");
		return;
	}
	else
	{
		//초기화
		var inner = "";
		inner += '<div class="le-cell">';
		inner += '	<div class="le-inner">';
		inner += '       	<div class="list-edit white-bg">';
		inner += '       		<div class="close" onclick="javascript:$(\'#file_layer\').fadeOut(200);">';
		inner += '     			닫기<i class="far fa-window-close"></i>';
		inner += '    		</div>';
		inner += '     		<div class="lect-pwrap02">';
		inner += '     			<h3 class="text-center">거래선 상신 파일 첨부</h3>';
		inner += '     			<div class="top-row sear-wr">';
		inner += '					<div class="wid-10">';
		inner += '						<div class="table">';
		inner += '							<div class="sear-tit">제목</div>';
		inner += '							<div>';
		inner += '								<input type="text" id="subject" name="subject" class="inp-100" placeholder="제목을 입력하세요.">';
		inner += '							</div>';
		inner += '						</div>';
		inner += '					</div>';	
		inner += '				</div>';
		inner += '				<div class="table">';
		inner += '	     			<div class="wid-5">';
		inner += '	     				<input type="text" id="search_user_name" name="search_user_name" onkeypress="excuteEnter(line_search)">';
		inner += '	     				<div class="trans-sere">';
		inner += '	     					<ul id="left_ul" class="list-ul"></ul>';
		inner += '	     				</div>';
		inner += '	     			</div>';
		inner += '	     			<div class="wid-5">';
		inner += '	     				<div class="trans-sere-r">';
		inner += '		     				<ul id="lecr_target" class="">';
		inner += '		     				</ul>';
		inner += '	     				</div>';
		inner += '	     			</div>';
		inner += '     			</div>';
		inner += '				<div class="table">';
		inner += '	     			<div class="wid-5">';
		inner += '	     				<div class="btn-right">';
		inner += '		     				<a class="btn btn01" onclick="sort_li(\'up\');">위로</a>';
		inner += '		     				<a class="btn btn01" onclick="sort_li(\'down\');">아래로</a>';
		inner += '		     				<a class="btn btn02" onclick="sort_li(\'del\');">삭제</a>';
		inner += '		     			</div>';
		inner += '		     			<div class="trans-sere">';
		inner += '		     				<ul id="right_ul" class="list-ul">';
		inner += '		     					<li id="first_li">${login_name} / ${login_sct_nm}</li>';
		inner += '		     				</ul>';
		inner += '	     				</div>';
		inner += '	     			</div>';
		inner += '	     			<div class="wid-5">';
		inner += '		     			<div class="file-boxwrap" id="file_target">';
		inner += '		     				<div class="file-wrap">';
		inner += '								<div class="btn-right">';
		inner += '									<a class="btn btn02" onclick="addFile()">파일추가</a>';
		inner += '								</div>';
		inner += '								<div class="trans-sere">';
		inner += '			     				</div>';
		inner += '		     				</div>';
		inner += '						</div>';
		inner += '					</div>';			     			
		inner += '     			</div>';
		inner += '				<div class="text-center btn-wr">';
		inner += '					<a class="btn btn02" onclick="fncSubmit()">거래선 상신</a>';
		inner += '				</div>';
		inner += '     		</div>';
		inner += '		</div>';
		inner += '	</div>';
		inner += '</div>';
		$('#file_layer').html(inner);
		//초기화
		chkList = chkList.substring(0, chkList.length-1);
		$.ajax({
			type : "POST", 
			url : "./getLecrDetailByTransaction",
			dataType : "text",
			async:false,
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
				$("#lecr_target").html('');
				for(var i = 0; i < result.length; i++)
				{
					if(i != 0)
					{
						$("#lecr_target").append('<li>-------------------------------------------------------</li>')
					}
					if(result[i].CORP_FG == "1") //법인
					{
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;"><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">대표자</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].PRESIDENT_NM)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;"><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">사업자번호</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].BIZ_NO)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;"><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">사업자명</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].PRESIDENT_NM)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;""><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">입금은행</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].BANK_NM)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;""><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">예금주</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].ACCOUNT_NM)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;"><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">계좌번호</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].ACCOUNT_NO)+'</span></li>')
					}
					else if(result[i].CORP_FG == "2") //개인
					{
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;""><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">강사명</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].LECTURER_KOR_NM)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;""><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">주민번호</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].LECTURER_CD)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;""><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">입금은행</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].BANK_NM)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;""><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">예금주</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].ACCOUNT_NM)+'</span></li>')
						$("#lecr_target").append('<li style="display: Table; width: 100%; table-layout: fixed; margin: 0; list-style: none;""><span style="display: table-cell; padding: 11px 10px; font-weight: 700; width: 100px; font-size:14px; color:#010101;">계좌번호</span><span style="display: table-cell; padding: 11px 10px; font-size:14px; color:#010101;">'+nullChk(result[i].ACCOUNT_NO)+'</span></li>')
					}
				}
			}
		});	
		$('#file_layer').fadeIn(200);	
		
	}
}
function confirm03()
{
	$('#confirm_layer03').fadeIn(200);	
}
//전체 체크박스
function checked_all(data){
	if(data.previousSibling.checked){
		data.previousSibling.checked = false;
	}else if(!data.previousSibling.checked){
		data.previousSibling.checked = true;
	}
	var chk_checked = data.previousSibling.checked;
	var idx_arr = document.querySelectorAll("input[name*='idx']");
	if(chk_checked == true){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = true;
		}
	}else if(chk_checked == false){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = false;
		}
	}
}
//부분 체크박스
function checked_part(data){
	if(data.previousSibling.checked){
		data.previousSibling.checked = false;
	}else if(!data.previousSibling.checked){
		data.previousSibling.checked = true;
	}
	var chk_checked = data.previousSibling.checked;
	var idx_arr = document.querySelectorAll("input[name*='idx"+data.dataset.val+"']");
	if(chk_checked == true){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = true;
		}
	}else if(chk_checked == false){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = false;
		}
	}
}
//단일 체크박스
function checked_one(data){
	var $this = data.previousSibling;
	var chk_checked = $this.checked;
	if(chk_checked == true){
		$this.checked = false;
	}else if(chk_checked == false){
		$this.checked = true;
	}
}


// var trans_cnt = 1; 
// function trans_add()
// {
// 	var inner = "";
	
// 	inner += '<div class="wid-3" style="margin-left:0px !important" id="trans_div1_'+trans_cnt+'">';
// 	inner += '	<div class="table">';
// 	inner += '		<div class="sear-tit">결재자 '+trans_cnt+'</div>';
// 	inner += '		<div>';
// 	inner += '			<input type="text" id="title_'+trans_cnt+'" name="title_'+trans_cnt+'" class="inp-100" placeholder="이름을 입력하세요.">';
// 	inner += '		</div>';
// 	inner += '	</div>';
// 	inner += '</div>';
	
// 	inner += '<div class="wid-4 mag-l4" id="trans_div2_'+trans_cnt+'">';
// 	inner += '	<div class="table">';
// 	inner += '		<div>';
// 	inner += '			<ul class="chk-ul">';
// 	inner += '				<li>';
// 	inner += '					<input type="radio" id="line_'+trans_cnt+'_9" name="line_'+trans_cnt+'" checked/>';
// 	inner += '					<label for="rad-c">결재</label>';
// 	inner += '				</li>';
// 	inner += '				<li>';
// 	inner += '					<input type="radio" id="line_'+trans_cnt+'_9" name="line_'+trans_cnt+'"/>';
// 	inner += '					<label for="rad-c">합의</label>';
// 	inner += '				</li>';
// 	inner += '				<li>';
// 	inner += '					<input type="radio" id="line_'+trans_cnt+'_9" name="line_'+trans_cnt+'"/>';
// 	inner += '					<label for="rad-c">후결</label>';
// 	inner += '				</li>';
// 	inner += '				<li>';
// 	inner += '					<input type="radio" id="line_'+trans_cnt+'_9" name="line_'+trans_cnt+'"/>';
// 	inner += '					<label for="rad-c">통보</label>';
// 	inner += '				</li>';
// 	inner += '				<li>';
// 							if(trans_cnt == 1)
// 							{
// 	inner += '					<i class="material-icons add" onclick="trans_add()">add_circle_outline</i>';
// 							}
// 							else
// 							{
// 	inner += '					<i class="material-icons remove" onclick="remove_trans('+trans_cnt+')">remove_circle_outline</i>';
// 							}
// 	inner += '				</li>';
// 	inner += '			</ul>';
// 	inner += '		</div>';
// 	inner += '	</div>';
// 	inner += '</div>';
// 	inner += '<br>';
	
// 	$("#trans_target").append(inner);
// 	trans_cnt ++;
// }
// function remove_trans(val)
// {
// 	$("#trans_div1_"+val).remove();
// 	$("#trans_div2_"+val).remove();
// }
function line_search()
{
	$.ajax({
		type : "POST", 
		url : "./line_search",
		dataType : "text",
		async : false,
		data : 
		{
			user_nm : $("#search_user_name").val()
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
			for(var i = 0; i < result.length; i++)
			{
				inner += '<li ondblclick="selUser(\''+encodeURI(JSON.stringify(result[i]))+'\')">'+nullChk(result[i].USER_NM)+' / '+nullChk(result[i].SCT_NM)+'</li>';
			}
			$("#left_ul").html(inner);
		}
	});	
	
}

function selUser(ret)
{
	var result = JSON.parse(decodeURI(ret));
	var inner = '';
	if(document.getElementById(result.USER_ID))
	{
		alert("같은사람이 있어요");
	}
	else
	{
		inner += '<li id="'+result.USER_ID+'" class="li_sort" onclick="selRight(\''+result.USER_ID+'\');">'+nullChk(result.USER_NM)+' / '+nullChk(result.SCT_NM)+' / ';
		inner += '<select id="line_'+result.USER_ID+'" name="line_'+result.USER_ID+'">';
		inner += '	<option value="1">결재</option>'
		inner += '	<option value="2">합의</option>'
		inner += '	<option value="3">후결</option>'
		inner += '	<option value="9">참조</option>'
		inner += '</select>';
		inner += '</li>';
		
		$("#right_ul").append(inner);
	}
}
var clickUser = "";
function selRight(val)
{
	clickUser = val;
}
function fncSubmit()
{
	var isFile = true;
	var fileList = "";
	var idList = "";
	var lineList = "";
	$(".trans_file").each(function(){
		var this_id = $(this).attr("id");
		this_id = this_id.replace("trans_file_", "");
		
		fileList += this_id + "|";
	    if($(this).val() == "")
    	{
    		isFile = false;
    	}
	});
	$(".li_sort").each(function(){
		var this_id = $(this).attr("id");
		idList += this_id + "|";
		lineList += $("#line_"+this_id).val() + "|";
	})
	
	if(!isFile)
	{
		alert("파일을 등록해주세요.");
		return;
	}
	else if(idList == "")
	{
		alert("결재경로가 없습니다.");
		return;
	}
	else
	{
		$("#idList").val(idList);
		$("#lineList").val(lineList);
		$("#fileList").val(fileList);
		$("#chkList").val(chkList);
		$("#htmlContent").val($("#lecr_target").html());
		
		$("#fncForm").ajaxSubmit({
			success: function(data)
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
		});
	}
	
}
function sort_li(act)
{
	aa = new Array();
	$(".li_sort").each(function(){
		var this_id = $(this).attr("id");
		aa.push(this_id);
	})
	for(var i = 0; i < aa.length; i++)
	{
		if(aa[i] == clickUser)
		{
			if(act == 'up')
			{
				var tmp = aa[i-1];
				aa[i-1] = clickUser;
				aa[i] = tmp;
			}
			else if(act == 'down')
			{
				if((i+1) < aa.length)
				{
					var tmp = aa[i+1];
					aa[i+1] = clickUser;
					aa[i] = tmp;
				}
			}
			else if(act == 'del')
			{
				$("#"+aa[i]).remove();
				aa.splice(i, 1);
			}
			break;
		}
	}
	for(var i = 0; i < aa.length; i++)
	{
		if(i == 0)
		{
			$("#"+aa[i]).insertAfter("#first_li");
		}
		else
		{
			$("#"+aa[i]).insertAfter("#"+aa[i-1]);
		}
	}
}
var file_cnt = 1;
function addFile()
{
	var inner = "";
	inner += '<div class="file-wrap" id="div_'+file_cnt+'">';
	inner += '	<ul class="file-ul">';
	inner += '		<li>';
	inner += '			<div class="filebox">'; 
	inner += '				<span class="wpcf7-form-control-wrap">';
	inner += '					<span>';
	inner += '						<label for="trans_file_'+file_cnt+'"><img src="/img/img-file02.png" /> 파일선택</label>'; 
	inner += '						<input type="file" id="trans_file_'+file_cnt+'" name="trans_file_'+file_cnt+'" class="trans_file"> ';
	inner += '						<input class="upload-name-'+file_cnt+'" value="이미지를 첨부해주세요.">';
	inner += '					</span>';
	inner += '				</span>';
	inner += '			</div>';
	inner += '		</li>';
	inner += '	</ul>';
	inner += '	<div class="btn-right">';
	inner += '		<a class="btn btn03" onclick="delFile('+file_cnt+')">삭제</a>';
	inner += '	</div>';
	inner += '</div>';
	
	$("#file_target .trans-sere").append(inner);
	
	$("#trans_file_"+file_cnt).on('change',function(){
	  var fileName = $("#trans_file_"+file_cnt).val();
	  $(".upload-name-"+file_cnt).val(fileName);
	});
	file_cnt ++;
	fileInit();
}
function fileInit()
{
	$(".trans_file").on('change',function(){
		var this_id = $(this).attr("id");
		this_id = this_id.replace("trans_file_", "");
		var fileName = $("#trans_file_"+this_id).val();
		$(".upload-name-"+this_id).val(fileName);
	});
}
function delFile(val)
{
	$("#div_"+val).remove();
}
</script>

<div class="sub-tit">
	<h2>거래선 상신</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn02" onclick="javascript:filePopup()">거래선 상신</a>
<!-- 		<a class="btn btn01" onclick="javascript:delLecr()">신규등록 리스트 삭제</a> -->
	</div>
	
</div>

<div>
	<select de-data="전체" id="selBranch" name="selBranch" onchange="getLecrLineListAll()">
			<option value="">전체</option>
		<c:forEach var="i" items="${branchList}" varStatus="loop">
			<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
		</c:forEach>
	</select>
</div>


<div class="table-wr">
	<div class="table-cap table">
		<div class="cap-l">
			<h2>신규등록 리스트</h2>
		</div>
		
	</div>
	
	<div class="table-top table-top02 lecr-transwr">
		<div class="top-row">
			<div class="wid-4">
				<div class="search-wr sel100">
				    <input type="text" id="search_name1" class="inp-100" name="search_name1" onkeypress="excuteEnter(getLecrLineList1)" placeholder="법인 대표명/강사명을 입력해주세요.">
			  		<input class="search-btn" type="button" value="검색" onclick="getLecrLineList1()">
				</div>
			</div>
			
			
			<div class="wid-3 wid-lt02">
				<div class="table table-auto">
					<div class="sear-tit sear-tit-120">법인/개인</div>
					<div>
						<select de-data="전체" id="search_corp_fg1" name="search_corp_fg1">
							<option value="">전체</option>
							<option value="1">법인</option>
							<option value="2">개인</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getLecrLineList1()">
	</div>
</div>

<div class="table-wr ip-list">
	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			
			<div class="table table02 table-auto float-right">
				<div class="sel-scr">
					<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown1();"><i class="fas fa-file-download"></i></a>
					<select id="listSize" name="listSize" onchange="getLecrLineList(1)" de-data="10개 보기">
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
				<col width="40">
				<col width="120">
				<col width="120">
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
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all1" name="chk_all1" value="chk_val1"><label for="chk_all1"></label>
					</th>
					<th class="td-80" onclick="reSortAjax('sort_lecturer_kor_nm')">강사명<img src="/img/th_up.png" class="sort_lecturer_kor_nm"></th>
					<th onclick="reSortAjax('sort_h_phone_no2')">연락처<img src="/img/th_up.png" class="sort_h_phone_no2"></th>
					<th class="td-120" onclick="reSortAjax('sort_lecturer_cd')">주민등록번호<img src="/img/th_up.png" class="sort_lecturer_cd"></th>
					<th class="td-220" onclick="reSortAjax('sort_addr_tx')">주소<img src="/img/th_up.png" class="sort_addr_tx"></th>
					<th onclick="reSortAjax('sort_biz_no')">사업자번호<img src="/img/th_up.png" class="sort_biz_no"></th>
					<th onclick="reSortAjax('sort_corp_fg')">개인/법인<img src="/img/th_up.png" class="sort_corp_fg"></th>
					<th onclick="reSortAjax('sort_president_nm')">사업자명<img src="/img/th_up.png" class="sort_president_nm"></th>
					<th onclick="reSortAjax('sort_bank_nm')">입금은행<img src="/img/th_up.png" class="sort_bank_nm"></th>
					<th onclick="reSortAjax('sort_account_nm')">예금주<img src="/img/th_up.png" class="sort_account_nm"></th>
					<th onclick="reSortAjax('sort_account_no')">계좌번호<img src="/img/th_up.png" class="sort_account_no"></th>	
					<th>처리현황<img src="/img/th_up.png" id="sort_"></th>	
					<th>정보입력<img src="/img/th_up.png" id="sort_"></th>	
					<th onclick="reSortAjax('sort_store')">등록지점<img src="/img/th_up.png" class="sort_"></th>				
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list trans_tablelist scroll1">
		<table id="excelTable1">
			<colgroup>
				<col width="40">
				<col width="120">
				<col width="120">
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
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all1" name="chk_all1" value="chk_val1"><label for="chk_all1"></label>
					</th>
					<th class="td-80" onclick="reSortAjax('sort_lecturer_kor_nm')">강사명<img src="/img/th_up.png" class="sort_lecturer_kor_nm"></th>
					<th onclick="reSortAjax('sort_h_phone_no2')">연락처<img src="/img/th_up.png" class="sort_h_phone_no2"></th>
					<th class="td-120" onclick="reSortAjax('sort_lecturer_cd')">주민등록번호<img src="/img/th_up.png" class="sort_lecturer_cd"></th>
					<th class="td-220" onclick="reSortAjax('sort_addr_tx')">주소<img src="/img/th_up.png" class="sort_addr_tx"></th>
					<th onclick="reSortAjax('sort_biz_no')">사업자번호<img src="/img/th_up.png" class="sort_biz_no"></th>
					<th onclick="reSortAjax('sort_corp_fg')">개인/법인<img src="/img/th_up.png" class="sort_corp_fg"></th>
					<th onclick="reSortAjax('sort_president_nm')">사업자명<img src="/img/th_up.png" class="sort_president_nm"></th>
					<th onclick="reSortAjax('sort_bank_nm')">입금은행<img src="/img/th_up.png" class="sort_bank_nm"></th>
					<th onclick="reSortAjax('sort_account_nm')">예금주<img src="/img/th_up.png" class="sort_account_nm"></th>
					<th onclick="reSortAjax('sort_account_no')">계좌번호<img src="/img/th_up.png" class="sort_account_no"></th>	
					<th>처리현황<img src="/img/th_up.png" id="sort_"></th>	
					<th>정보입력<img src="/img/th_up.png" id="sort_"></th>	
					<th onclick="reSortAjax('sort_store')">등록지점<img src="/img/th_up.png" class="sort_"></th>	
				</tr>
			</thead>
			<tbody class="list1">
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label> -->
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>(53026)서울시 강동구 성안로 156</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td onclick="javascript:confirm()">김정인</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>김태연</td> -->
<!-- 					<td>0234164512354</td> -->
<!-- 					<td class="color-blue line-blue" onclick="javascript:confirm03()">반려</td> -->
<!-- 					<td>Y</td>				 -->
<!-- 				</tr> -->
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label> -->
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>(53026)서울시 강동구 성안로 156</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td onclick="javascript:confirm()">김정인</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>김태연</td> -->
<!-- 					<td>0234164512354</td>	 -->
<!-- 					<td>대기</td>	 -->
<!-- 					<td>Y</td>				 -->
<!-- 				</tr> -->
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label> -->
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>(53026)서울시 강동구 성안로 156</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>-</td>		 -->
<!-- 					<td class="color-red">N</td> -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
	<div class="paging1">
	</div>
</div>

<div class="table-wr">
	<div class="table-cap table">
		<div class="cap-l">
			<h2>처리결과 조회</h2>
		</div>
		
	</div>
	
	<div class="table-top table-top02 lecr-transwr">
		<div class="top-row">
			<div class="wid-4">
				<div class="search-wr sel100">
				    <input type="text" id="search_name2" class="inp-100" name="search_name2" onkeypress="excuteEnter(getLecrLineList2)" placeholder="법인 대표명/강사명을 입력해주세요.">
			  		<input class="search-btn" type="button" value="검색" onclick="getLecrLineList2()">
				</div>
			</div>
			
			
			<div class="wid-3 wid-lt02">
				<div class="table table-auto">
					<div class="sear-tit sear-tit-120">법인/개인</div>
					<div>
						<select de-data="전체" id="search_corp_fg2" name="search_corp_fg2">
							<option value="">전체</option>
							<option value="1">법인</option>
							<option value="2">개인</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getLecrLineList2()">
	</div>
</div>


<div class="table-wr ip-list table-mtop">
		
	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			
			<div class="table table02 table-auto float-right">
				<div class="sel-scr">
					<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown2();"><i class="fas fa-file-download"></i></a>
					<select id="listSize2" name="listSize2" onchange="getLecrLineList(2)" de-data="10개 보기">
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
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-80" onclick="reSortAjax2('sort_lecturer_kor_nm')">강사명<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_h_phone_no2')">연락처<img src="/img/th_up.png" class="sort_"></th>
					<th class="td-120" onclick="reSortAjax2('sort_lecturer_cd')">주민등록번호<img src="/img/th_up.png" class="sort_"></th>
					<th class="td-220" onclick="reSortAjax2('sort_addr_tx')">주소<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_biz_no')">사업자번호<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_corp_fg')">개인/법인<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_president_nm')">사업자명<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_bank_cd')">입금은행<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_account_nm')">예금주<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_account_no')">계좌번호<img src="/img/th_up.png" class="sort_"></th>		
					<th onclick="reSortAjax2('sort_store')">등록지점<img src="/img/th_up.png" class="sort_"></th>			
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list scroll2">
		<table id="excelTable2">
			<thead>
				<tr>
					<th class="td-80" onclick="reSortAjax2('sort_lecturer_kor_nm')">강사명<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_h_phone_no2')">연락처<img src="/img/th_up.png" class="sort_"></th>
					<th class="td-120" onclick="reSortAjax2('sort_lecturer_cd')">주민등록번호<img src="/img/th_up.png" class="sort_"></th>
					<th class="td-220" onclick="reSortAjax2('sort_addr_tx')">주소<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_biz_no')">사업자번호<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_corp_fg')">개인/법인<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_president_nm')">사업자명<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_bank_cd')">입금은행<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_account_nm')">예금주<img src="/img/th_up.png" class="sort_"></th>
					<th onclick="reSortAjax2('sort_account_no')">계좌번호<img src="/img/th_up.png" class="sort_"></th>		
					<th onclick="reSortAjax2('sort_store')">등록지점<img src="/img/th_up.png" class="sort_"></th>		
				</tr>
			</thead>
			<tbody class="list2">
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" name="idx2"><label onclick="checked_one(this);"></label> -->
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>(53026)서울시 강동구 성안로 156</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>김정인</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>김태연</td> -->
<!-- 					<td>0234164512354</td>			 -->
<!-- 				</tr> -->
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" name="idx2"><label onclick="checked_one(this);"></label> -->
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>(53026)서울시 강동구 성안로 156</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>김정인</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>김태연</td> -->
<!-- 					<td>0234164512354</td>			 -->
<!-- 				</tr> -->
<!-- 				<tr>			 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" name="idx2"><label onclick="checked_one(this);"></label> -->
<!-- 					</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>(53026)서울시 강동구 성안로 156</td> -->
<!-- 					<td>851230-206321</td> -->
<!-- 					<td>법인</td> -->
<!-- 					<td>김정인</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>김태연</td> -->
<!-- 					<td>0234164512354</td>			 -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	<div class="paging2">
	</div>
</div>

<div id="confirm_layer" class="trans-conf list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
	       	<div class="list-edit white-bg">
	       		<div class="close" onclick="javascript:$('#confirm_layer').fadeOut(200);">
	     			닫기<i class="far fa-window-close"></i>
	     		</div>
	     		<div>
	     			<h3 class="text-center">결재관련 사항 확인</h3>
	     			
	     					
					
	     		</div>
	     		
	     		<div class="ak-wrap_new">
				
					<div class="table-list mem-manage trans-list">			
						
						<div class="trans-wrap">
							<div class="row">
								<div class="wid-5">
									<div class="bor-div">
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">성명(한글)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="정상임">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">성명(영문)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="Jungsangim">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">휴대폰</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="010-5623-5612">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">주민등록번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="912365-203625">
													</div>
												</div>
											</div>
										</div>						
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">주소</div>
													<div class="table-mem">
														<div class="input-wid2">
															<input type="text" id="cus_address_1" name="cus_address_1" class="inputDisabled inp-30" placeholder="53026">
															<input type="text" id="cus_address_2" name="cus_address_2" class="inputDisabled inp-70" placeholder="서울시 강동구 성안로 156">
														</div>
														<div>
															<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" placeholder="우주빌딩 503호, 902호">
														</div>
													</div>
												</div>
											</div>									
										</div>								
									</div>
								</div>
								
								
								<div class="wid-5 wid-5_last">
									<div class="bor-div">
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">사업자번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="956231563-623115962">
													</div>
												</div>
											</div>									
										</div>		
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">법인 구분</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="법인">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">사업자명</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">입금은행</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="국민은행">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">예금주</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">계좌번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="12365312-56313020">
													</div>
												</div>
											</div>									
										</div>
										
									</div>
									
									
								</div>
							</div>
							
						
						</div> <!-- trans-wrap end -->
						
						<div class="text-center">
							<a class="btn btn02">확인</a>
						</div>
				
					</div>
				</div>
	     		
	     	</div>
	     </div>
	</div>
</div>

<form id="fncForm" name="fncForm" method="POST" action="./trans_proc" enctype="multipart/form-data">
	<input type="hidden" id="idList" name="idList">
	<input type="hidden" id="lineList" name="lineList">
	<input type="hidden" id="fileList" name="fileList">
	<input type="hidden" id="chkList" name="chkList">
	<input type="hidden" id="htmlContent" name="htmlContent">
	
	<div id="file_layer" class="trans-conf list-edit-wrap">
		<div class="le-cell">
			<div class="le-inner">
		       	<div class="list-edit white-bg">
		       		<div class="close" onclick="javascript:$('#file_layer').fadeOut(200);">
		     			닫기<i class="far fa-window-close"></i>
		     		</div>
		     		<div class="lect-pwrap02">
		     			<h3 class="text-center">거래선 상신 파일 첨부</h3>
		     			<div class="top-row sear-wr">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">제목</div>
									<div>
										<input type="text" id="subject" name="subject" class="inp-100" placeholder="제목을 입력하세요.">
									</div>
								</div>
							</div>	
						</div>
						<!-- 거래선 왼쪽칸 -->
						<div class="table">
			     			<div class="wid-5">
			     				<input type="text" id="search_user_name" name="search_user_name" onkeypress="excuteEnter(line_search)">
			     				<div class="trans-sere">
			     					<ul id="left_ul" class="list-ul"></ul>
			     				</div>
			     			</div>
			     			<div class="wid-5">
			     				<div class="trans-sere-r">
				     				<ul id="lecr_target" class="">
				     				</ul>
			     				</div>
			     			</div>
			     			
		     			</div>
						<div class="table">
			     			<div class="wid-5">
			     				<div class="btn-right">
				     				<a class="btn btn01" onclick="sort_li('up');">위로</a>
				     				<a class="btn btn01" onclick="sort_li('down');">아래로</a>
				     				<a class="btn btn02" onclick="sort_li('del');">삭제</a>
				     			</div>
				     			<div class="trans-sere">
				     				<ul id="right_ul" class="list-ul">
				     					<li id="first_li">${login_name} / ${login_sct_nm}</li>
				     				</ul>
			     				</div>
			     			</div>
			     			<div class="wid-5">
				     			<div class="file-boxwrap" id="file_target">
				     				<div class="file-wrap">
										<div class="btn-right">
											<a class="btn btn02" onclick="addFile()">파일추가</a>
										</div>
										<div class="trans-sere">
					     				</div>
				     				</div>
									
								</div>
							</div>			     			
		     			</div>
						<div class="text-center btn-wr">
							<a class="btn btn02" onclick="fncSubmit()">거래선 상신</a>
						</div>
		     		</div>
	    		</div>
	    	</div>
		</div>
	</div>
</form>

<div id="confirm_layer03" class="trans-conf list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
	       	<div class="list-edit white-bg">
	       		<div class="close" onclick="javascript:$('#confirm_layer03').fadeOut(200);">
	     			닫기<i class="far fa-window-close"></i>
	     		</div>
	     		<div>
	     			<h3 class="text-center">결재관련 사항 확인</h3>					
	     		</div>
	     		
	     		<div class="ak-wrap_new">
				
					<div class="table-list mem-manage trans-list">			
						
						<div class="trans-wrap">
							<div class="row">
								<div class="wid-5">
									<div class="bor-div">
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">성명(한글)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="정상임">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">성명(영문)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="Jungsangim">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">휴대폰</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="010-5623-5612">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">주민등록번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="912365-203625">
													</div>
												</div>
											</div>
										</div>						
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">주소</div>
													<div class="table-mem">
														<div class="input-wid2">
															<input type="text" id="cus_address_1" name="cus_address_1" class="inputDisabled inp-30" placeholder="53026">
															<input type="text" id="cus_address_2" name="cus_address_2" class="inputDisabled inp-70" placeholder="서울시 강동구 성안로 156">
														</div>
														<div>
															<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" placeholder="우주빌딩 503호, 902호">
														</div>
													</div>
												</div>
											</div>									
										</div>	
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">첨부파일</div>
													<div class="file-wrap">
														<div class="filebox"> 																	
															<span class="wpcf7-form-control-wrap">
																<span><input type="file" id="voc_file" name="voc_file[]" multiple></span>
															</span>
														</div>
													</div>
												</div>
											</div>
										</div>
														
									</div>
								</div>
								
								
								<div class="wid-5 wid-5_last">
									<div class="bor-div">
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">사업자번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="956231563-623115962">
													</div>
												</div>
											</div>									
										</div>		
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">법인 구분</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="법인">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">사업자명</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">입금은행</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="국민은행">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">예금주</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">계좌번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="12365312-56313020">
													</div>
												</div>
											</div>									
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">반려사유</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="강사료 기준에 대한 변경사항 적용 필요로 인해 반려함.">
													</div>
												</div>
											</div>									
										</div>
										
									</div>
									
									
								</div>
							</div>
							
						
						</div> <!-- trans-wrap end -->
						
						
						
						<div class="text-center">
							<a class="btn btn02">확인</a>
						</div>
				
					</div>
				</div>
	     		
	     	</div>
	     </div>
	</div>
</div>


<!-- 
<div class="table-top table-top02 first">
	<div class="top-row sear-wr">
		<div class="wid-10">
			<div class="table">
				<div class="sear-tit">제목</div>
				<div>
					<input type="text" class="inp-100" placeholder="제목을 입력하세요.">
				</div>
			</div>
		</div>	
	</div>
	<div class="top-row sear-wr">	

		<div class="wid-4">
			<div class="table">
				<div class="sear-tit">결재자</div>
				<div>
					<input type="text" class="inp-100" placeholder="이름을 입력하세요.">
				</div>
			
			</div>
		</div>
		<div class="wid-6">
			<div class="table">
				<div class="sear-tit sear-tit_left">결재경로</div>
				<div>
					<input type="text" class="inp-100" placeholder="경로를 입력하세요.">
				</div>
			
			</div>
		</div>

	</div>
	
	<div class="top-row" >
		<div class="sear-tit"></div>
		<div>
			<ul class="chk-ul chk-ul_ra">
				<li>
					<input type="radio" checked>
					<label for="all-c">결재</label>
				</li>
				<li>
					<input type="radio">
					<label for="all-c">알림</label>
				</li>
				<li>
					<input type="radio">
					<label for="all-c">후결</label>
				</li>
				<li>
					<input type="radio">
					<label for="all-c">통보</label>
				</li>
			</ul>
		</div>
		
	</div>
</div>

<div class="white-bg ak-wrap_new">

	<h3 class="h3-tit">강사 이력 정보</h3>

	<div class="table-list mem-manage trans-list">
		<div class="top-row">
			<div class="wid-10">
				<div class="table">
					<div class="lecr-sear">
						먼저 휴대폰번호를 검색하세요
						<div>
							<A class="btn btn02" onclick="javascript:phoneSearch()">Search</A>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="trans-wrap">
			<div class="row">
				<div class="wid-5">
					<div class="bor-div">
						<div class="top-row table-input">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">성명(한글)</div>
									<div>
										<input type="text" id="cus_birth" name="cus_birth" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">성명(영문)</div>
									<div>
										<input type="text" id="cus_h_tel" name="cus_h_tel" placeholder="입력하세요." class="inp-100">
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">휴대폰</div>
									<div>
										<input type="text" id="cus_birth" name="cus_birth" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">주민등록번호</div>
									<div>
										<input type="text" id="cus_h_tel" name="cus_h_tel" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>
						</div>						
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">사업자번호</div>
									<div>
										<input type="text" id="cus_birth" name="cus_birth" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>									
						</div>						
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit sear-tit-top">주소</div>
									<div class="table-mem">
										<div class="input-wid2">
											<input type="text" id="cus_address_1" name="cus_address_1" class="inputDisabled inp-30" placeholder="" disabled="disabled">
											<input type="text" id="cus_address_2" name="cus_address_2" class="inputDisabled inp-70" placeholder="" disabled="disabled">
										</div>
										<div>
											<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" placeholder="" disabled="disabled">
										</div>
									</div>
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
									<div class="sear-tit">직장명</div>
									<div>
										<input type="text" id="cus_birth" name="cus_birth" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">부서명</div>
									<div>
										<input type="text" id="cus_h_tel" name="cus_h_tel" placeholder="입력하세요." class="inp-100">
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row table-input">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">직급</div>
									<div>
										<input type="text" id="cus_birth" name="cus_birth" placeholder="입력하세요." class="inp-100">
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">회사번호</div>
									<div>
										<input type="text" id="cus_h_tel" name="cus_h_tel" placeholder="입력하세요." class="inp-100" >
									</div>
								</div>
							</div>
						</div>
						
					</div>
					
					<div class="bor-div">
						<div class="top-row table-input">
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit">입금은행</div>
									<div>
										<input type="text" id="cus_birth" name="cus_birth" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>
							<div class="wid-5">
								<div class="table">
									<div class="sear-tit sear-tit_120 sear-tit_left">법인 구분</div>
									<div>
										<input type="text" id="cus_h_tel" name="cus_h_tel" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>
						</div>
						
						<div class="top-row">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">계좌번호</div>
									<div>
										<input type="text" id="cus_birth" name="cus_birth" class="inputDisabled inp-100" disabled="disabled">
									</div>
								</div>
							</div>
							
						</div>
						
					</div>
					
				</div>
			</div>
			
		
		</div> 

	</div>
</div>


<div class="white-bg trans-bottom">
	<div class="file-wrap">
		<ul class="file-ul">
			<li>
				<input type="checkbox" id="all-c" name="all-c">
				<label for="all-c"></label>
			</li>
			<li>
				<div class="filebox"> 
					
					<span class="wpcf7-form-control-wrap">
						<span><input type="file" id="voc_file" name="voc_file[]" multiple></span>
					</span>
				</div>

			
			</li>
		</ul>
		
		<div class="btn-right">
			<a class="btn btn02">추가</a>
			<a class="btn btn03">삭제</a>
		
		</div>
	</div>

</div>

 -->
<script>
$(document).ready(function(){
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	if(nullChk(getCookie("search_name1")) != "") { $("#search_name1").val(nullChk(getCookie("search_name1")));}
	if(nullChk(getCookie("search_corp_fg1")) != "") { $("#search_corp_fg1").val(nullChk(getCookie("search_corp_fg1"))); $(".search_corp_fg1").html($("#search_corp_fg1 option:checked").text());}
	
	if(nullChk(getCookie("m_page")) != "") { page = nullChk(getCookie("m_page")); }
	if(nullChk(getCookie("m_order_by")) != "") { order_by = nullChk(getCookie("m_order_by")); }
	if(nullChk(getCookie("m_sort_type")) != "") { sort_type = nullChk(getCookie("m_sort_type")); }
	if(nullChk(getCookie("listSize2")) != "") { $("#listSize2").val(nullChk(getCookie("listSize2"))); $(".listSize2").html($("#listSize2 option:checked").text());}
	if(nullChk(getCookie("search_name2")) != "") { $("#search_name2").val(nullChk(getCookie("search_name2")));}
	if(nullChk(getCookie("search_corp_fg2")) != "") { $("#search_corp_fg2").val(nullChk(getCookie("search_corp_fg2"))); $(".search_corp_fg2").html($("#search_corp_fg2 option:checked").text());}
	
	getLecrLineListAll();
})
</script>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>