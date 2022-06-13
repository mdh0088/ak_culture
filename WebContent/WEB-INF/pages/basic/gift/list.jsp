<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>

var gift_fg="";
window.onload = function(){
	choose_gift_fg();
}

function periInit(){
	choose_gift_fg();
}

function excelDown()
{
	var filename = "사은품 지급내역";
	var table = "excelTable";
    exportExcel(filename, table);
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
	 			$("#start_ymd").val(cutDate(result.ADULT_S_BGN_YMD));
	 			$("#end_ymd").val(cutDate(result.END_YMD));
	 			
			}
		});	
	}
}


function choose_gift_fg(){
	gift_fg="";
	if ( $('#gift_fg_a').prop("checked")==true && $('#gift_fg_b').prop("checked")==false) {
		gift_fg ='1';
	}else if($('#gift_fg_a').prop("checked")==false && $('#gift_fg_b').prop("checked")==true){
		gift_fg ='2';
	}else if($('#gift_fg_a').prop("checked")==true && $('#gift_fg_b').prop("checked")==true){
		gift_fg ="3";
	}
	
	$('#choose_fg').val(choose_fg);
	
	
	$('#gift_title').val('');
	$('#gift_title').empty();
	$('.gift_title_ul').empty();
	
	if (gift_fg!="") {
		
		if (gift_fg==3) {
			gift_fg="";
		}
		
		$.ajax({
			type : "POST", 
			url : "./changeGift",
			dataType : "text",
			data : 
			{
				store : $('#selBranch').val(),
				period : $('#selPeri').val(),
				gift_fg : gift_fg
				
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
				var inner_li = "";
				inner +='<option value="">전체</option>';
				inner_li +='<li>전체</li>';
				for (var i = 0; i < result.length; i++) {
					inner +='<option value="'+result[i].GIFT_CD+'">'+result[i].GIFT_NM+'</option>';
					inner_li +='<li>'+result[i].GIFT_NM+'</li>';

				}
				$('#gift_title').append(inner);
				$('.gift_title_ul').append(inner_li);
				//gift_title
				
			}
		});
	}
	
}
function all_chker(){
	if ( $('#idxAll').prop("checked")==true )  {
		$('.gift_chk').prop("checked",true);
	}else{
		$('.gift_chk').prop("checked",false);			
	}
}

/*
function choose_search(val){
	if ($(val).val()=="") {
		$('#search_name').attr('readonly','readonly');
		$('#search_name').attr('placeholder','검색 항목을 선택해주세요.');
		$('#search_name').val('');
	}else{
		$('#search_name').removeAttr('readonly');
		$('#search_name').attr('placeholder','검색어를 입력하세요.');
	}
}
*/



function update_content(idx,cust_no,gift_cd){
	var cust_no = cust_no;
	var gift_cd = gift_cd;
	var conts = $('.cont_'+idx).val();
	
	$.ajax({
		type : "POST", 
		url : "./updateContent",
		dataType : "text",
		async : false,
		data : 
		{
			store : $('#selBranch').val(),
			period : $('#selPeri').val(),
			contents : conts,
			cust_no : cust_no,
			gift_cd : gift_cd
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			//console.log(data);
			//var result = JSON.parse(data);
			alert('저장됐습니다.');
			getList();
		}
	});
	
	
}

function getList(paging_type){
	getListStart();
	
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("search_type", $("#search_type").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("start_ymd", $("#start_ymd").val(), 9999);
	setCookie("end_ymd", $("#end_ymd").val(), 9999);
	setCookie("gift_status", $("#gift_status").val(), 9999);
	setCookie("gift_cd", $("#gift_cd").val(), 9999);
	setCookie("gift_fg_a", $("#gift_fg_a").is(":checked"), 9999);
	setCookie("gift_fg_b", $("#gift_fg_b").is(":checked"), 9999);
	
	$.ajax({
		type : "POST", 
		url : "./getGiftlist",
		dataType : "text",
		data : 
		{	
			
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			search_name : $('#search_name').val(),
			search_type : $('#search_type').val(),
			store : $('#selBranch').val(),
			period : $('#selPeri').val(),
			
			start_day : $('#start_ymd').val(),
			end_day : $('#end_ymd').val(),
			gift_status : $('#gift_status').val(),
			gift_fg : gift_fg,
			gift_cd : nullChk($('#gift_title').val())
					
			
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
					inner +='		<input type="checkbox" id="chk_'+i+'" class="gift_chk" name="chk_val" value="'+result.list[i].CUST_NO+'_'+result.list[i].GIFT_CD+'|">';
					
					inner +='		<label for="chk_'+i+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+nullChk(result.list[i].RNUM)+'</td>';
					inner += '	<td class="gift_cus_no_'+i+'">'+nullChk(result.list[i].CUST_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].KOR_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].GIFT_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].GIFT_FG)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POS_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ACCEPT_TYPE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].GIFT_GIVE_DATE)+'</td>';
					/*
					if (nullChk(result.list[i].GIFT_GIVE_DATE)=="" && nullChk(result.list[i].GIFT_BACK_DATE)=="") 
					{
						inner += '	<td>미지급</td>';
					}
					else
					{
					*/
						inner += '	<td>'+nullChk(result.list[i].GIVE_TYPE)+'</td>';						
					//}
					inner += '	<td>'+nullChk(result.list[i].GIVE_ORDER_CNT)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].GIFT_BACK_DATE)+'</td>';
					inner += '	<td class="gift-td"><p style="display:none;">'+nullChk(result.list[i].CONTENTS)+'</p><input type="text" class="cont_'+i+'" value="'+nullChk(result.list[i].CONTENTS)+'"><a onclick="javascript:update_content('+i+',\''+result.list[i].CUST_NO+'\',\''+result.list[i].GIFT_CD+'\');" class="btn03 notExcel">저장</a></td>';
					
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
			$("#list_target").html(inner);
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});
	
 	
	
}


function endAction()
{
	var chkList = "";
	//var send_tm ="Y";
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).val();
    	}
	});
	
	if (chkList=="") 
	{
		alert('회원을 선택해주세요');
		return;
	}
	$.ajax({
		type : "POST", 
		url : "./endAction",
		dataType : "text",
		async : false,
		data : 
		{
			chkList : chkList,
			act : $("#end_act").val(),
			store : $('#selBranch').val(),
			period : $('#selPeri').val()
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
    			getList();
    		}
    		else
    		{
	    		alert(result.msg);
    		}
		}
	});	
	
	
	
}

</script>

<div class="sub-tit">
	<h2>사은품 지급내역</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	
	<div class="btn-right">
		<A class="btn btn01" href="../gift/write"><i class="material-icons">add</i>사은품 등록</A>
	</div>
</div>
	<input type="hidden" id="choose_fg" name="choose_fg">
	<div class="table-top">
		<div class="table top-row">
			<div class="wid-35">
				<div class="table table-auto wid-contop">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
			
			<div>
				<div class="table table-auto table-input">
					<div>
						<div class="cal-row">
							<div class="cal-input cal-input02 cal-input_park">
								<input type="text" id="start_ymd" name="start_ymd" class="date-i start-i" value="" />
								<i class="material-icons">event_available</i>
							</div>
							<div class="cal-dash">-</div>
							<div class="cal-input cal-input02 cal-input_park">
								<input type="text" id=end_ymd name="end_ymd" class="date-i ready-i" value=""/>
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="top-row">
			<div class="wid-35">
				<div class="table">
					<div class="search-wr sel100">
							<select id="search_type" name="search_type"  de-data="회원명">
								<option value="kor_nm">회원명</option>
								<option value="cus_no">멤버스번호</option>
								<option value="ptl_id">포털ID</option>
								<option value="phone_num">휴대폰번호</option>
							</select>
							
						    
						    <input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요." value="">
						    <input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
							
					</div>
				</div>
			</div>		
			<div class="wid-2 ">
				<div class="table">
					<div>
						<div class="table">
							<div class="sear-tit sear-tit_left">지급구분</div>
							<div>
								<select id="gift_status" name="gift_status" de-data="전체">
									<!--  <option value="">전체</option> -->
									<option value="">전체</option>
									<option value="1">지급</option>
									<option value="2">미지급</option>
									<option value="0">반납</option>
									<option value="3">강좌취소</option>
									<!-- <option value="9">취소</option>  -->
								</select>
							</div>
						</div>
					</div>
					
				</div>
			</div>
			<div class="wid-2 mag-l4">
				<div class="table">
					<div class="sear-tit">사은품 종류</div>
					<div>
						<ul class="chk-ul">
							<li>
								<input type="checkbox" id="gift_fg_a" name="gift_fg_a" onclick="choose_gift_fg();" checked="checked"/>
								<label for="gift_fg_a">상품권</label>
							</li>
							<li>
								<input type="checkbox" id="gift_fg_b" name="gift_fg_b" onclick="choose_gift_fg();" checked="checked"/>
								<label for="gift_fg_b">현물</label>
							</li>
						</ul>
						
					</div>
				</div>
			</div>
			<div class="wid-1 mag-l2">
				<div class="table">
					<div>
						<div class="table">
							<div class="sear-tit">사은품명</div>
							<div>
								<select id="gift_title" name="gift_title" de-data="선택하세요.">
			
								</select>
							</div>
						</div>
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
			<div>
				<p class="ip-ritit">선택한 사은품을</p>
			</div>
			<div>
				<select de-data="지급" id="end_act" name="end_act">
					<option value="1">지급</option>
					<option value="0">반납</option>
				</select>
				<a class="bor-btn btn03 btn-mar6" onclick="javascript:endAction();">반영</a>
			</div>
			<div class="sel-scr">
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
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
					<col width="60px">
					<col>
					<col width="80px">
					<col width="200px">
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col width="100px">
				</colgroup>
				<thead>
					<tr>
						<th class="td-chk">
							<input type="checkbox" id="idxAll" name="idx" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
						</th>						
						<th onclick="reSortAjax('sort_rnum')">No.<img src="/img/th_up.png" id="sort_rnum"></th>
						<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_list_cus_no"></th>
						<th onclick="reSortAjax('sort_kor_nm')">회원명 <img src="/img/th_up.png" id="sort_list_kor_nm"></th>
						<th onclick="reSortAjax('sort_gift_nm')" class="td-220">사은품명 <img src="/img/th_up.png" id="sort_list_short_name"></th>
						<th onclick="reSortAjax('sort_gift_fg')" class="td-90">사은품 종류 <img src="/img/th_up.png" id="sort_list_gift_code_fg"></th>		
						<th onclick="reSortAjax('sort_pos_no')">지급POS <img src="/img/th_up.png" id="sort_list_pos_no"></th>			
						<th onclick="reSortAjax('sort_cust_fg')">회원구분<img src="/img/th_up.png" id="sort_list_cust_fg"></th>		
						<th onclick="reSortAjax('sort_accept_type')">접수구분<img src="/img/th_up.png" id="sort_list_accept_gubun"></th>
						<th onclick="reSortAjax('sort_gift_give_date')" class="td-110" >사은품 지급일<img src="/img/th_up.png" id="sort_list_gift_give_date"></th>
						<th onclick="reSortAjax('sort_give_type')">지급구분 <img src="/img/th_up.png" id="sort_list_give_type"></th>
						<th onclick="reSortAjax('sort_give_order_cnt')">지급순번 <img src="/img/th_up.png" id="sort_list_give_order_cnt"></th>
						<th onclick="reSortAjax('sort_gift_back_date')" class="td-110">사은품 반납일<img src="/img/th_up.png" id="sort_list_gift_back_date"></th>
						<th onclick="reSortAjax('sort_contents')">비고 <img src="/img/th_up.png" id="sort_list_contents"></th>
					</tr>
				</thead>
			</table>
		</div>
		<div class="table-list">
			<table id="excelTable">
				<colgroup>
					<col width="60px">
					<col>
					<col width="80px">
					<col width="200px">
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col width="100px">
				</colgroup>
				<thead>
					<tr>
						<th class="td-chk">
							<input type="checkbox" id="idxAll" name="idx" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
						</th>
						<th onclick="reSortAjax('sort_rnum')">No.<img src="/img/th_up.png" id="sort_rnum"></th>
						<th onclick="reSortAjax('sort_cus_no')">멤버스번호<img src="/img/th_up.png" id="sort_list_cus_no"></th>
						<th onclick="reSortAjax('sort_kor_nm')">회원명 <img src="/img/th_up.png" id="sort_list_kor_nm"></th>
						<th onclick="reSortAjax('sort_gift_nm')" class="td-220">사은품명 <img src="/img/th_up.png" id="sort_list_short_name"></th>
						<th onclick="reSortAjax('sort_gift_fg')" class="td-90">사은품 종류 <img src="/img/th_up.png" id="sort_list_gift_code_fg"></th>		
						<th onclick="reSortAjax('sort_pos_no')">지급POS <img src="/img/th_up.png" id="sort_list_pos_no"></th>			
						<th onclick="reSortAjax('sort_cust_fg')">회원구분<img src="/img/th_up.png" id="sort_list_cust_fg"></th>		
						<th onclick="reSortAjax('sort_accept_type')">접수구분<img src="/img/th_up.png" id="sort_list_accept_gubun"></th>
						<th onclick="reSortAjax('sort_gift_give_date')" class="td-110" >사은품 지급일<img src="/img/th_up.png" id="sort_list_gift_give_date"></th>
						<th onclick="reSortAjax('sort_give_type')">지급구분 <img src="/img/th_up.png" id="sort_list_give_type"></th>
						<th onclick="reSortAjax('sort_give_order_cnt')">지급순번 <img src="/img/th_up.png" id="sort_list_give_order_cnt"></th>
						<th onclick="reSortAjax('sort_gift_back_date')" class="td-110">사은품 반납일<img src="/img/th_up.png" id="sort_list_gift_back_date"></th>
						<th onclick="reSortAjax('sort_contents')">비고 <img src="/img/th_up.png" id="sort_list_contents"></th>
					</tr>
				</thead>
				<tbody id="list_target">
				<!-- 
					<c:forEach var="i" items="${list}" varStatus="loop">
						<tr>
							<td class="td-chk">
								<input type="checkbox" id="idx_${loop.index}" class="gift_chk" name="gift_idx" value="${i.SUB_CODE}"><label for="idx_${loop.index}"></label>
							</td>
							
						   	<td class="gift_cus_no_${loop.index}">${i.LIST_CUS_NO}</td>
						   	<td class="gift_code_fg_${loop.index} dis-no">${i.CODE_FG}</td>
						   	<td class="gift_sub_code_${loop.index} dis-no">${i.SUB_CODE}</td>
						   	<td>${i.LIST_KOR_NM}</td>					   	
						   	<td>${i.LIST_SHORT_NAME}</td>
						   	<td>${i.PAY_PRICE}</td>			
						   	<td>${i.LIST_GIFT_CODE_FG}</td>		   	
						   	<td>${i.POS_NO}</td>					   	
						   	<td>${i.LIST_CUST_FG}</td>
						   	<td>${i.LIST_ACCEPT_GUBUN}</td>
						   	<td>${i.GIFT_DATE}</td>
						   	<td>${i.LIST_GIVE_GUBUN}</td>
						   	<td>${i.GIFT_BACK_DATE}</td>
						   	<td class="gift-td"><input type="text" class="cont_${loop.index}" value="${i.CONTENTS}"><a onclick="javascript:update_content(${loop.index});" class="btn03">저장</a></td>	
						</tr>
					</c:forEach>
				 -->
				</tbody>
			</table>
		</div>
</div>
<script>
$( document ).ready(function() {
	$("#search_type").val("kor_nm");
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("search_type")) != "") { $("#search_type").val(nullChk(getCookie("search_type"))); $(".search_type").html($("#search_type option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	fncPeri();
	selPeri();
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("start_ymd")) != "") { $("#start_ymd").val(nullChk(getCookie("start_ymd")));}
	if(nullChk(getCookie("end_ymd")) != "") { $("#end_ymd").val(nullChk(getCookie("end_ymd")));}
	if(nullChk(getCookie("gift_status")) != "") { $("#gift_status").val(nullChk(getCookie("gift_status"))); $(".gift_status").html($("#gift_status option:checked").text());}
	if(nullChk(getCookie("gift_cd")) != "") { $("#gift_cd").val(nullChk(getCookie("gift_cd"))); $(".gift_cd").html($("#gift_cd option:checked").text());}
	if(nullChk(getCookie("gift_fg_a")) == "true") 
	{
		$("input:checkbox[id='gift_fg_a']").prop("checked", true);   
	}
	if(nullChk(getCookie("gift_fg_b")) == "true") 
	{
		$("input:checkbox[id='gift_fg_b']").prop("checked", true);   
	}
	getList();

});
</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>