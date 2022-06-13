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
	var filename = "회원리스트";
	var table = "excelTable";
	
	$('.sms_title_for_show').hide();
	$('.sms_content').show();
	
    exportExcel(filename, table);
    
    $('.sms_content').hide();
	$('.sms_title_for_show').show();
}


$( document ).ready(function() {

	getList();	
	$('.sms_content').hide();
	$('.sms_title_for_excel').hide();
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
	

});

function getList(paging_type){
	getListStart();

	$.ajax({
		type : "POST", 
		url : "./getSmsCustList",
		dataType : "text",
		data : 
		{	
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			store : '${store}',
			period : '${period}',
			sms_seq : '${sms_seq}'
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
				var phone_no1 ="";
				var phone_no2 ="";
				var phone_no3 ="";
				
				var tr_len =$('#excelTable >tbody tr').length;
				
				for(var i = 0; i < result.list.length; i++)
				{
					
					phone_no1 = result.list[i].RECEIVER.substring(0,3);
					phone_no2 = result.list[i].RECEIVER.substring(3,7);
					phone_no3 = result.list[i].RECEIVER.substring(7,13);
					
					
					inner += '<tr>';
					inner += '	<td>'+(tr_len+(i+1))+'</td>';
					inner += '	<td>'+result.list[i].CUST_NO+'</td>';
					inner += '	<td>'+result.list[i].KOR_NM+'</td>';
					inner += '	<td class="txt-b">'+nullChk(result.list[i].PTL_ID)+'</td>';
					inner += '	<td>'+phone_no1+'－'+phone_no2+'－'+phone_no3+'</td>';
					inner += '	<td>'+result.list[i].SEND_TYPE+'</td>';
					
					
					inner += '	<td class="sms_title_for_show" onclick="show_content(\''+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SMS_SEQ+'_'+result.list[i].CUST_NO+'\')" class="tm-title">';
					inner +='		<div class="txt">'+result.list[i].TITLE+'<i class="material-icons">message</i></div>';
					inner += '	</td>';
					inner += '	<td class="sms_content" style="display:none;">'+result.list[i].MESSAGE+'</td>';
					inner += '	<td>'+result.list[i].MANAGER_NM+'</td>';
					inner += '	<td>'+result.list[i].SMS_YN+'</td>';
					inner += '	<td>'+result.list[i].SEND_RESULT+'</td>';
					inner += '	<td>'+result.list[i].CREATE_DATE+'</td>';
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

function show_content(val){
	var arr= val.split('_');

	$.ajax({
		type : "POST", 
		url : "./getContent",
		dataType : "text",
		async : false,
		data : 
		{
			store : arr[0],
			period : arr[1],
			sms_seq : arr[2],
			cust_no : arr[3]
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$("#review").val(repWord(nullChk(result.MESSAGE)));
		}
	});	
	$("#review_layer").fadeIn(200);
}

</script>

<div class="sub-tit table">
	<div class="btn-wr btn-style">
		<a class="btn btn01" class="ipNow" href="list">SMS </a>
		<a class="btn btn02" href="list_tm">TM</a>
	</div>
</div>

<div class="sub-tit">
	<h2>SMS 회원리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb">
		<li>수강/회원 관리</li>
		<li>SMS 리스트</li>
		<li>TM 리스트</li>
		<li>SMS 회원리스트</li>
	</ul>
	
</div>

<div class="table-wr ip-list">
	<div class="table-cap table">
		<div class="cap-r text-right">
			<div class="float-right">
				<div class="sel-scr">
					<a class="bor-btn btn01" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
					<select id="listSize" name="listSize" onchange="getList();" de-data="10개 보기">
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
	
	<div class="table-list tm-custlist">
		<table id="excelTable">
			<thead>
				<tr>
					<th>No.</th>
					<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_cus_no"></th>
					<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
					<th onclick="reSortAjax('sort_ptl_id')">포털ID<img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th onclick="reSortAjax('sort_phone_no')">휴대폰<img src="/img/th_up.png" id="sort_phone_no"></th>
					<th onclick="reSortAjax('sort_send_type')">구분<img src="/img/th_up.png" id="sort_send_type"></th>
					<th onclick="reSortAjax('sort_cont_title')">제목<img src="/img/th_up.png" id="sort_cont_title"></th>
					<th class="sms_content" onclick="reSortAjax('sort_message')">내용<img src="/img/th_up.png" id="sort_message"></th>
					<th onclick="reSortAjax('sort_manager_nm')">등록자<img src="/img/th_up.png" id="sort_manager_nm"></th>
					<th onclick="reSortAjax('sort_sms_yn')">수신여부<img src="/img/th_up.png" id="sort_sms_yn"></th>
					<th onclick="reSortAjax('sort_send_result')">발송상태<img src="/img/th_up.png" id="sort_send_result"></th>
					<th onclick="reSortAjax('sort_create_date')">발송일시<img src="/img/th_up.png" id="sort_create_date"></th>
				</tr>
			</thead>
			<tbody id="list_target">
				
				

			</tbody>
		</table>
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
        			<h3 class="text-center">전송 메시지</h3>
        			<form id="fncForm" name="fncForm" method="POST" action="./saveReview">
	        			<textarea style="height:333px;" id="review" name="review" readonly="readonly"></textarea>
        			</form>
        			<!--  
        			<div class=" text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:saveReview();" style="margin-top:30px;">저장</a>
					</div>
					-->
	        	</div>
        	</div>
        </div>
    </div>	
</div>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>