<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>

function all_chker(){
	if ( $('#idxAll').prop("checked")==true )  {
		$('.gift_chk').prop("checked",true);
	}else{
		$('.gift_chk').prop("checked",false);			
	}
}

function delGift(){
	
	if(!confirm("정말 삭제하시겠습니까?")){
		return;
	}
	
	var len = document.getElementsByName("idx").length;
	var chk_flag=false;
	var gift_value="";
	var gift_cd ="";
	
	
	for (var i = 0; i < len; i++) {
		if (document.getElementsByName("idx")[i].checked==true) {
			chk_flag=true;
			gift_value = document.getElementsByName("idx")[i].value.split('_');
			if (gift_value[1]!=gift_value[2]) {
				alert("이미 지급된 회원이 있습니다.");
				return;
			}
			gift_cd += gift_value[0]+"|";
			
		}
	}
	
	if (chk_flag==false) {
		alert("삭제할 상품권을 선택해주세요.");
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./delGift",
		dataType : "text",
		data : 
		{	
			gift_cd : gift_cd
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
			getList();
		}
	});
	
	
}


function getList(){
	getListStart();
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("gubun", $("#gubun").val(), 9999);
	setCookie("gift_fg_a", $("#gift_fg_a").is(":checked"), 9999);
	setCookie("gift_fg_b", $("#gift_fg_b").is(":checked"), 9999);
	//var gift_fg ='\'31\'';
	var gift_fg="";
	if ( $('#gift_fg_a').prop("checked")==true && $('#gift_fg_b').prop("checked")==false)  {
		gift_fg ='\'1\''; //상풍권
	}else if($('#gift_fg_b').prop("checked")==true && $('#gift_fg_a').prop("checked")==false){
		gift_fg ='\'2\''; //현물
	}else if($('#gift_fg_a').prop("checked")==true && $('#gift_fg_b').prop("checked")==true){
		gift_fg ='\'1\',\'2\'';
	}else if($('#gift_fg_a').prop("checked")==false && $('#gift_fg_b').prop("checked")==false){
		gift_fg="";
	}
 	

	$.ajax({
		type : "POST", 
		url : "./getGiftlisted",
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
			gubun : $('#gubun').val(),
			gift_fg: gift_fg
			
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
			
			var season = $('#selSeason').val();
			if (season=='봄학기') 
			{
				season = 1;
			}
			else if(season=='여름학기')
			{
				season = 2;
			}
			else if(season=='가을학기')
			{
				season = 3;
			}
			else
			{
				season = 4;
			}
			
			
			if(result.list.length > 0)
			{
				var give_fg_nm="";
			
				for(var i = 0; i < result.list.length; i++)
				{
				
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner +='		<input type="checkbox" id="gift_chk_'+i+'" class="gift_chk" name="idx" value="'+result.list[i].GIFT_CD+'_'+result.list[i].GIFT_CNT_T+'_'+result.list[i].LEFT_CNT+'"><label for="gift_chk_'+i+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+result.list[i].GUBUN+'</td>';
					inner += '	<td>'+result.list[i].GIFT_FG+'</td>';
					inner += '	<td onclick="location.href=\'/basic/gift/write?store='+result.list[i].STORE+'&year='+$('#selYear').val()+'&period='+result.list[i].PERIOD+'&season='+season+'&gift_cd='+trim(result.list[i].GIFT_CD)+'\'" style="cursor:pointer;">'+result.list[i].GIFT_NM+'</td>';
					//inner += '	<td class="color-red">'+result.list[i].GIFT_CNT_T+'</td>';
					inner += '	<td class="gift-tdw bg-gray">'+result.list[i].GIFT_CNT_T+'</td>';
					inner += '	<td class="gift-tdw bg-blue">'+result.list[i].GIFT_CNT_W+'</td>';
					inner += '	<td class="gift-tdw bg-red">'+result.list[i].GIFT_CNT_M+'</td>';
					inner += '	<td class="gift-tdw bg-gray">'+result.list[i].GIFT_CNT_D+'</td>';
					inner += '	<td class="gift-tdw color-blue">'+result.list[i].LEFT_CNT+'</td>';
					inner += '	<td>'+result.list[i].GIVE_PERIOD+'</td>';
					inner += '	<td>'+result.list[i].GIVE_TYPE+'</td>';
					inner += '	<td>'+result.list[i].CREATE_DATE+'</td>';
					inner += '	<td>'+result.list[i].REGI_NAME+'</td>';
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


</script>



<div class="sub-tit">
	<h2>사은품 리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<ul id="breadcrumbs" class="breadcrumb">
		<li>기본관리</li>
		<li>사은품관리</li>
	</ul>
	
	<div class="btn-right">
		<A class="btn btn02" href="../gift/list">사은품 지급내역</A>
		<A class="btn btn01 btn01_1" href="../gift/write"><i class="material-icons">add</i>사은품 등록</A>
	</div>
</div>

	<input type="hidden" id="gift_fg" name="gift_fg" value="">
	
	<div class="table-top">
		<div class="top-row sear-wr">
			<div class="wid-35">
				<div class="table table-auto">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<div class="oddn-sel02 sel-scr">
					<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
				</div>
			</div>
			<div class="wid-25">
				<div class="table">
					<div class="sear-tit sear-tit_70 sear-tit_left">구분</div>
					<div class="">
						<select id="gubun" name="gubun" de-data="전체">
							<option value="">전체</option>
							<option value="1">진행</option>
							<option value="2">종료</option>
							<!-- <option value="3">대기중</option> -->
						</select>
					</div>
				</div>
			</div>
			<div class="wid-3">
				<div class="table">
					<div class="sear-tit">사은품 종류</div>
					<div>
						<ul class="chk-ul">
							<li>
								<input type="checkbox" id="gift_fg_a"/>
								<label for="gift_fg_a">상품권</label>
							</li>
							<li>
								<input type="checkbox" id="gift_fg_b"/>
								<label for="gift_fg_b">현물</label>
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
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r sel-scr text-right">
			<a class="bor-btn btn03 mrg-l6" onclick="delGift();">삭제</a>
			<a class="bor-btn btn01 mrg-l6" ><i class="fas fa-file-download"></i></a>
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
	<div class="table-wr table-wr-two">		
		<div class="thead-box">
			<table>
				<colgroup>
					<col width="60px">
					<col width="80px">
					<col width="80px">
					<col>
					<col width="65px">
					<col width="65px">
					<col width="65px">
					<col width="65px">
					<col width="65px">
					<col>
					<col width="140px">
					<col width="120px">
					<col width="100px">
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2" class="td-chk">
							<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
						</th>
						<th class="td-60"  rowspan="2" onclick="reSortAjax('sort_gubun')">구분<img src="/img/th_up.png" id="sort_gubun"></th>
						<th class="td-90" rowspan="2" onclick="reSortAjax('sort_gift_fg')">사은품 종류<img src="/img/th_up.png" id="sort_gift_fg"></th>
						<th class="td-220" rowspan="2" onclick="reSortAjax('sort_gift_nm')">사은품명<img src="/img/th_up.png" id="sort_gift_nm"></th>					
						<!--  <th rowspan="2" onclick="reSortAjax('sort_gift_cnt_t')">전체수량<img src="/img/th_up.png" id="sort_gift_cnt_t"></th>-->
						<th colspan="4">접수 수단별 수량</th>										
						<th rowspan="2" onclick="reSortAjax('sort_left_cnt')">남은수량<img src="/img/th_up.png" id="sort_left_cnt"></th>
						<th class="td-140" rowspan="2" onclick="reSortAjax('sort_give_period_start')">지급기간<img src="/img/th_up.png" id="sort_give_period_start"></th>
						<th rowspan="2" onclick="reSortAjax('sort_give_type')">지급방식<img src="/img/th_up.png" id="sort_give_type"></th>
						<th rowspan="2" onclick="reSortAjax('sort_create_date')">등록일자<img src="/img/th_up.png" id="sort_create_date"></th>
						<th rowspan="2" onclick="reSortAjax('sort_regi_name')">등록자<img src="/img/th_up.png" id="sort_regi_name"></th>
					</tr>
					<tr class="table-csptr">
						<th onclick="reSortAjax('sort_gift_cnt_t')">전체<img src="/img/th_up.png" id="sort_gift_cnt_t"></th>
						<th onclick="reSortAjax('sort_gift_cnt_w')">WEB<img src="/img/th_up.png" id="sort_gift_cnt_w"></th>
						<th onclick="reSortAjax('sort_gift_cnt_m')">MOBILE<img src="/img/th_up.png" id="sort_gift_cnt_m"></th>
						<th onclick="reSortAjax('sort_gift_cnt_d')">DESK<img src="/img/th_up.png" id="sort_gift_cnt_d"></th>				
					</tr>
				</thead>
			</table>
		</div>		
		<div class="table-list table-csplist">
			<table id="excelTable">
				<colgroup>
					<col width="60px">
					<col width="80px">
					<col width="80px">
					<col>
					<col width="65px">
					<col width="65px">
					<col width="65px">
					<col width="65px">
					<col width="65px">
					<col>
					<col width="140px">
					<col width="120px">
					<col width="100px">
				</colgroup>
				<thead>
					<tr>
						<th rowspan="2" class="td-chk">
							<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
						</th>
						<th class="td-60"  rowspan="2" onclick="reSortAjax('sort_gubun')">구분<img src="/img/th_up.png" id="sort_gubun"></th>
						<th class="td-90" rowspan="2" onclick="reSortAjax('sort_gift_fg')">사은품 종류<img src="/img/th_up.png" id="sort_gift_fg"></th>
						<th class="td-220" rowspan="2" onclick="reSortAjax('sort_gift_nm')">사은품명<img src="/img/th_up.png" id="sort_gift_nm"></th>					
						<!--  <th rowspan="2" onclick="reSortAjax('sort_gift_cnt_t')">전체수량<img src="/img/th_up.png" id="sort_gift_cnt_t"></th>-->
						<th colspan="4">접수 수단별 수량</th>										
						<th rowspan="2" onclick="reSortAjax('sort_left_cnt')">남은수량<img src="/img/th_up.png" id="sort_left_cnt"></th>
						<th class="td-140" rowspan="2" onclick="reSortAjax('sort_give_period_start')">지급기간<img src="/img/th_up.png" id="sort_give_period_start"></th>
						<th rowspan="2" onclick="reSortAjax('sort_give_type')">지급방식<img src="/img/th_up.png" id="sort_give_type"></th>
						<th rowspan="2" onclick="reSortAjax('sort_create_date')">등록일자<img src="/img/th_up.png" id="sort_create_date"></th>
						<th rowspan="2" onclick="reSortAjax('sort_regi_name')">등록자<img src="/img/th_up.png" id="sort_regi_name"></th>
					</tr>
					<tr class="table-csptr">
						<th onclick="reSortAjax('sort_gift_cnt_t')">전체<img src="/img/th_up.png" id="sort_gift_cnt_t"></th>
						<th onclick="reSortAjax('sort_gift_cnt_w')">WEB<img src="/img/th_up.png" id="sort_gift_cnt_w"></th>
						<th onclick="reSortAjax('sort_gift_cnt_m')">MOBILE<img src="/img/th_up.png" id="sort_gift_cnt_m"></th>
						<th onclick="reSortAjax('sort_gift_cnt_d')">DESK<img src="/img/th_up.png" id="sort_gift_cnt_d"></th>				
					</tr>
				</thead>
				<tbody id="list_target">				
				
				</tbody>
			</table>
		</div>
	</div>
	
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

<script>

$(document).ready(function(){
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	fncPeri();
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	if(nullChk(getCookie("gubun")) != "") { $("#gubun").val(nullChk(getCookie("gubun"))); $(".gubun").html($("#gubun option:checked").text());}
	
	if(nullChk(getCookie("gift_fg_a")) == "true") 
	{
		$("input:checkbox[id='gift_fg_a']").prop("checked", true);   
	}
	if(nullChk(getCookie("gift_fg_b")) == "true") 
	{
		$("input:checkbox[id='gift_fg_b']").prop("checked", true);   
	}
	
	getList();
})

</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>