<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<script>

function all_chker(){
	if ( $('#idxAll').prop("checked")==true )  {
		$('.encd_chk').prop("checked",true);
	}else{
		$('.encd_chk').prop("checked",false);			
	}
}

function delEncd(){
	
	if(!confirm("정말 삭제하시겠습니까?")){
		return;
	}
	
	var len = document.getElementsByName("idx").length;
	var chk_flag=false;
	var enuri_value="";
	var enuri_cd ="";
	
	
	for (var i = 0; i < len; i++) {
		if (document.getElementsByName("idx")[i].checked==true) {
			chk_flag=true;
			enuri_value = document.getElementsByName("idx")[i].value.split('_');
			if (enuri_value[1]!=0) {
				alert("이미 지급된 회원이 있습니다.");
				return;
			}
			enuri_cd += enuri_value[0]+"|";
			
		}
	}
	
	if (chk_flag==false) {
		alert("삭제할 할인코드를 선택해주세요.");
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "./delEncd",
		dataType : "text",
		data : 
		{	
			store : $('#selBranch').val(),
			period :$('#selPeri').val(),
			enuri_cd : enuri_cd
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

function getList(paging_type){
	getListStart();
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	$.ajax({
		type : "POST", 
		url : "./getEncdlisted",
		dataType : "text",
		data : 
		{	
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			store : $('#selBranch').val(),
			period :$('#selPeri').val()
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt+"개");
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
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner +='		<input type="checkbox" id="encd_chk_'+i+'" class="encd_chk" value="'+result.list[i].ENURI_CD+'_'+result.list[i].GIVE_CNT+'" name="idx" ><label for="encd_chk_'+i+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+result.list[i].RNUM+'</td>';		
					if (result.list[i].STORE_NAME!="" && result.list[i].STORE_NAME!=null) {
						inner += '	<td>'+result.list[i].STORE_NAME+'</td>';						
					}else{
						inner += '	<td>-</td>';
					}
					
					inner += '	<td onclick="location.href=\'/basic/encd/write?store='+trim(result.list[i].STORE)+'&year='+$('#selYear').val()+'&season='+season+'&period='+trim(result.list[i].PERIOD)+'&enuri_cd='+trim(result.list[i].ENURI_CD)+'\'" style="cursor:pointer;">'+result.list[i].ENURI_NM+'</td>';
					
					if (result.list[i].DISCOUNT_PERIOD_START!="" && result.list[i].DISCOUNT_PERIOD_START!=null) {
						console.log(result.list[i].DISCOUNT_PERIOD_START);
						inner += '	<td>'+result.list[i].DISCOUNT_PERIOD_START+' ~ '+result.list[i].DISCOUNT_PERIOD_END+'</td>';
					}else{
						inner += '	<td>-</td>';
					}
					
					inner += '	<td>'+result.list[i].ENURI_FG+'</td>';
					if(result.list[i].ENURI_FG == "정률")
					{
						inner += '	<td>'+comma(result.list[i].ENURI)+'%</td>';
					}
					else
					{
						inner += '	<td>'+comma(result.list[i].ENURI)+'</td>';
					}
					
					
					if (result.list[i].LIMITED_AMT!="" && result.list[i].LIMITED_AMT!=null) {
						inner += '	<td>'+comma(result.list[i].LIMITED_AMT)+'</td>';						
					}else{
						inner += '	<td>-</td>';
					}
					
					if (result.list[i].LIMITED_CNT!="" && result.list[i].LIMITED_CNT!=null) {
						inner += '	<td>'+result.list[i].LIMITED_CNT+'</td>';
					}else{
						inner += '	<td>-</td>';
					}
					inner += '	<td>'+result.list[i].GIVE_FG+'</td>';
					//inner += '	<td>'+result.list[i].USE_YN+'</td>';
					inner += '	<td>'+result.list[i].REGISTER+'</td>';
					inner += '	<td>'+result.list[i].CREATE_DATE+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="12"><div class="no-data">검색결과가 없습니다.</div></td>';
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
</script>
<div class="sub-tit">
	<h2>할인코드 리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<a class="btn btn01 btn01_1" href="list">할인내역</a>
		<a class="btn btn02" href="write"><i class="material-icons">add</i>할인코드 등록</a>
	</div>
</div>



<div class="table-top">
		<div class="top-row sear-wr">
			<div class="wid-10">
				<div class="table">
					<div class="wid-45">
						<div class="table table-auto wid-contop">
							<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
						</div>
					</div>
					<div class="wid-15">
						<div class="table">
							<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
							<div class="oddn-sel02 sel-scr">
								<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
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
	<div class="cap-r sel-scr text-right">
		<a class="bor-btn btn03 mrg-l6" onclick="delEncd();">삭제</a>
	</div>
</div>
<div class="table-wr">	
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="40px">
				<col>
				<col>
				<col>
				<col width="12%">
				<col>
				<col>
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
					</th>
					<th class="td-60">NO.</th>
					<th class="td-60">지점</th>
					<th onclick="reSortAjax('sort_enuri_nm')" class="td-140">할인코드명 <img src="/img/th_up.png" id="sort_enuri_nm"></th>
					<th onclick="reSortAjax('sort_discount_period_start')" class="td-140">기간 <img src="/img/th_up.png" id="sort_discount_period_start"></th>
					<th onclick="reSortAjax('sort_enuri_fg')">할인구분 <img src="/img/th_up.png" id="sort_enuri_fg"></th>
					<th onclick="reSortAjax('sort_enuri')">할인금액(%) <img src="/img/th_up.png" id="sort_enuri"></th>
					<th onclick="reSortAjax('sort_limited_amt')">제한금액<img src="/img/th_up.png" id="sort_limited_amt"></th>
					<th onclick="reSortAjax('sort_limited_cnt')">제한횟수 <img src="/img/th_up.png" id="sort_limited_cnt"></th>
					<!-- <th onclick="reSortAjax('sort_use_yn')">사용여부<img src="/img/th_up.png" id="sort_use_yn"></th> -->
					<th onclick="reSortAjax('sort_give_fg')">지급대상 <img src="/img/th_up.png" id="sort_give_fg"></th>
					<th onclick="reSortAjax('sort_register')">등록자 <img src="/img/th_up.png" id="sort_register"></th>
					<th onclick="reSortAjax('sort_create_date')">등록일자<img src="/img/th_up.png" id="sort_create_date"></th>					
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table>
			<colgroup>
				<col width="40px">
				<col width="40px">
				<col>
				<col>
				<col>
				<col width="12%">
				<col>
				<col>
				<col>
				<col>
				<col width="130px">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idxAll" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
					</th>
					<th class="td-60">NO.</th>
					<th class="td-60">지점</th>
					<th onclick="reSortAjax('sort_enuri_nm')" class="td-140">할인코드명 <img src="/img/th_up.png" id="sort_enuri_nm"></th>
					<th onclick="reSortAjax('sort_discount_period_start')" class="td-140">기간 <img src="/img/th_up.png" id="sort_discount_period_start"></th>
					<th onclick="reSortAjax('sort_enuri_fg')">할인구분 <img src="/img/th_up.png" id="sort_enuri_fg"></th>
					<th onclick="reSortAjax('sort_enuri')">할인금액(%) <img src="/img/th_up.png" id="sort_enuri"></th>
					<th onclick="reSortAjax('sort_limited_amt')">제한금액<img src="/img/th_up.png" id="sort_limited_amt"></th>
					<th onclick="reSortAjax('sort_limited_cnt')">제한횟수 <img src="/img/th_up.png" id="sort_limited_cnt"></th>
					
					<!-- <th onclick="reSortAjax('sort_use_yn')">사용여부<img src="/img/th_up.png" id="sort_use_yn"></th> -->
					<th onclick="reSortAjax('sort_give_fg')">지급대상 <img src="/img/th_up.png" id="sort_give_fg"></th>
					<th onclick="reSortAjax('sort_register')">등록자 <img src="/img/th_up.png" id="sort_register"></th>
					<th onclick="reSortAjax('sort_create_date')">등록일자<img src="/img/th_up.png" id="sort_create_date"></th>					
				</tr>
			</thead>
			<tbody id="list_target">


			</tbody>
		</table>
	</div>
	
</div>

<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
<script>
$( document ).ready(function() {
	
	if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
	if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
	if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
	if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
	if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
	fncPeri();
	if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
	getList();
	reSortAjax('sort_create_date');
});
</script>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>