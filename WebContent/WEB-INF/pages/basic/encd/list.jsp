<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<link rel="import" href="/inc/date_picker/date_picker.html">

<script>


function excelDown()
{
	var filename = "할인내역";
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

/*
function choose_fg(){
	if ( $('#cust_fg_a').prop("checked")==1 && $('#cust_fg_b').prop("checked")!=1 ) {
		$('#cust_fg').val(1);
	}else if( $('#cust_fg_a').prop("checked")!=1 && $('#cust_fg_b').prop("checked")==1 ){
		$('#cust_fg').val(2);
	}else if( $('#cust_fg_a').prop("checked")==1 && $('#cust_fg_b').prop("checked")==1 ){
		$('#cust_fg').val(3);
	}else{
		$('#cust_fg').val('');
	}
}
*/

function all_chker(){
	if ( $('#idxAll').prop("checked")==true )  {
		$('.encd_chk').prop("checked",true);
	}else{
		$('.encd_chk').prop("checked",false);			
	}
}

function getList(){
	getListStart();
	
	setCookie("page", page, 9999);
	setCookie("order_by", order_by, 9999);
	setCookie("sort_type", sort_type, 9999);
	setCookie("listSize", $("#listSize").val(), 9999);
	setCookie("search_name", $("#search_name").val(), 9999);
	setCookie("search_con", $("#search_con").val(), 9999);
	setCookie("store", $("#selBranch").val(), 9999);
	setCookie("period", $("#selPeri").val(), 9999);
	setCookie("start_ymd", $("#start_ymd").val(), 9999);
	setCookie("end_ymd", $("#end_ymd").val(), 9999);
	
	setCookie("cust_fg_a", $("#cust_fg_a").is(":checked"), 9999);
	setCookie("cust_fg_b", $("#cust_fg_b").is(":checked"), 9999);
	setCookie("encd_list", $("#encd_list").val(), 9999);
	
	var cust_fg="";
	if ( $('#cust_fg_a').prop("checked")==1 && $('#cust_fg_b').prop("checked")!=1 ) {
		cust_fg="1";
	}else if( $('#cust_fg_a').prop("checked")!=1 && $('#cust_fg_b').prop("checked")==1 ){
		cust_fg="2";
	}else if( $('#cust_fg_a').prop("checked")==1 && $('#cust_fg_b').prop("checked")==1 ){
		cust_fg="";
	}
 	
	var encd_list = $('#encd_list').val();
	encd_list = encd_list.replace("할인코드가 없습니다.", "");
	$.ajax({
		type : "POST", 
		url : "./getEncdlist",
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
			search_con : $('#search_con').val(),
			start_day : $('#start_ymd').val(),
			end_day : $('#end_ymd').val(),
			cust_fg : cust_fg,
			encd_list : encd_list
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
			
			if(result.list.length > 0)
			{
				
				var sum_regis_fee=0;
				var sum_tot_enuri_amt=0;
				var sum_tot_amt=0;
				var sum_enuri_rate=0;
				
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner +='		<input type="checkbox" id="encd_chk_'+i+'" class="encd_chk" name="encd_idx"><label for="encd_chk_'+i+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUST_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].KOR_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].GRADE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].CUST_FG)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ENURI_NM1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ENURI_NM2)+'</td>';
					inner += '	<td class="color-blue">'+comma(nullChk(result.list[i].REGIS_FEE))+'</td>';
					inner += '	<td class="bg-gray">'+comma(nullChk(result.list[i].TOT_ENURI_AMT))+'</td>';
					inner += '	<td class="color-red">'+comma(nullChk(result.list[i].TOT_AMT))+'</td>';
					inner += '	<td class="bg-red">'+nullChk(result.list[i].ENURI_RATE)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SALE_YMD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].POS_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].RECPT_NO)+'</td>';
// 					inner += '	<td>'+nullChk(result.list[i].CREATE_RESI_NO)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].SUBJECT_NM)+'</td>';
					inner += '</tr>';
					
					
					sum_regis_fee += Number(result.list[i].REGIS_FEE);
					sum_tot_enuri_amt += Number(result.list[i].TOT_ENURI_AMT);
					sum_tot_amt += Number(result.list[i].TOT_AMT);
					
					if(i == result.list.length-1)
					{
						sum_enuri_rate = (sum_tot_enuri_amt * 100) / sum_regis_fee;
						
						inner += '<tr class="tr-tfoot">';
						inner +='	<td colspan="8" class="bold">합계</td>';
						inner +='	<td>'+comma(sum_regis_fee)+'</td>';
						inner +='	<td>'+comma(sum_tot_enuri_amt)+'</td>';
						inner +='	<td>'+comma(sum_tot_amt)+'</td>';
						if (sum_regis_fee > 0) 
						{
							inner +='	<td>'+Math.round(sum_enuri_rate)+'%</td>';							
						}
						else
						{
							inner +='	<td>0%</td>';	
						}
						inner +='	<td colspan="4"></td>';
						inner += '</tr>';
						
					}
					
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
			listSize = result.listSize;
			$("#list_target").html(inner);
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});
}

function getEncdListByList(){
	$.ajax({
		type : "POST", 
		url : "./getEncdListByList",
		dataType : "text",
		data : 
		{
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
			
			$('#encd_list').empty();
			$('.encd_list_ul').empty();
			var inner="";
			var inner_li="";
			
			if (result.length!=0) {
				inner +='<option value="">전체</option>';
				inner_li += '<li>전체</li>';
				for (var i = 0; i < result.length; i++) {
					inner +='<option value="'+result[i].ENURI_CD+'">'+result[i].ENURI_NM+'</option>';
					inner_li += '<li>'+result[i].ENURI_NM+'</li>';
				}
			}else{
				inner +='<option>할인코드가 없습니다.</option>';
				inner_li += '<li>할인코드가 없습니다.</li>';
			}
			$('#encd_list').append(inner);
			$('.encd_list_ul').append(inner_li);
		}
	});
}

function periInit()
{
	getEncdListByList();
}

</script>

<div class="sub-tit">
	<h2>할인 내역</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<a class="btn btn01 btn01_1" href="listed"><i class="material-icons">add</i>할인코드 관리</a>
	</div>
</div>

	<div class="table-top">
		<div class="top-row sear-wr">
			<div class="wid-5">
				<div class="table">
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
			<div class="wid-5">
				<div class="table">
					<div class="search-wr">
						<select id="search_con" name="search_con" de-data="검색항목">
							<option value="cus_no">멤버스번호</option>
							<option value="kor_nm">회원명</option>
						</select>
						    
						<input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
						<input class="search-btn" type="button" value="검색" onclick="javascript:pagingReset(); getList();">
					</div>
				</div>
			</div>
		</div>
		<div class="top-row">
			<div class="wid-5 ">
				<div class="cal-row cal-row02 table">
					<div class="cal-input wid-4">
						<input type="text" class="date-i start-i" id="start_ymd" name="start_ymd"/>
						<i class="material-icons">event_available</i>
					</div>
					<div class="cal-dash">-</div>
					<div class="cal-input wid-4">
						<input type="text" class="date-i ready-i" id="end_ymd" name="end_ymd"/>
						<i class="material-icons">event_available</i>
					</div>
				</div>
			</div>
			<div class="wid-5">
				<div class="table">
					<div>
						<div class="table margin-auto">
							<div class="sear-tit">회원구분</div>
							<div>
							<ul class="chk-ul">
								<li>
									<input type="checkbox" id="cust_fg_a" name="cust_fg_a"/>
									<label for="cust_fg_a">기존</label>
								</li>
								<li>
									<input type="checkbox" id="cust_fg_b" name="cust_fg_b"/>
									<label for="cust_fg_b">신규</label>
								</li>
							</ul>
						</div>
						</div>
					</div>
					<div>
						<div class="table margin-auto sel-scr">
							<div class="sear-tit">할인코드명</div>
							<div class="sel190">
								<select id="encd_list" name="encd_list" de-data="선택하세요">
									<option valeu=""></option>
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
			<div class="table float-right">
				<div class="sel-scr">
					<a class="bor-btn btn01" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
					<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
						<option value="10">10개 보기</option>
						<option value="20">20개 보기</option>
						<option value="50">50개 보기</option>
						<option value="100">100개 보기</option>
						<option value="300">300개 보기</option>
						<option value="500">500개 보기</option>
						<option value="1000">1000개 보기</option>
						<option value="7000">7000개 보기</option>
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
				<col width="40px">
				<col>
				<col>
				<col>
				<col>
				<col width="100px">
				<col width="100px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col width="250px">
			</colgroup>
			<thead>
				<tr>
						<th class="td-chk">
							<input type="checkbox" id="idxAll" name="idx" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
						</th>
						<th class="td-50">NO.</th>
						<th onclick="reSortAjax('sort_cust_no')" class="td-90">멤버스번호 <img src="/img/th_up.png" id="sort_cust_no"></th>
						<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
						<th onclick="reSortAjax('sort_grade')">회원등급<img src="/img/th_up.png" id="sort_grade"></th>
						<th onclick="reSortAjax('sort_cust_fg')">회원구분<img src="/img/th_up.png" id="sort_cust_fg"></th>
<!-- 						<th onclick="reSortAjax('sort_enuri_code1')">할인코드1<img src="/img/th_up.png" id="sort_enuri_code1"></th> -->
<!-- 						<th onclick="reSortAjax('sort_enuri_code2')">할인코드2<img src="/img/th_up.png" id="sort_enuri_code2"></th> -->
						<th onclick="reSortAjax('sort_enuri_nm1')" class="td-140">할인코드명1<img src="/img/th_up.png" id="sort_enuri_nm1"></th>
						<th onclick="reSortAjax('sort_enuri_nm2')" class="td-140">할인코드명2<img src="/img/th_up.png" id="sort_enuri_nm2"></th>
						<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
						<th onclick="reSortAjax('sort_tot_enuri_amt')">할인금액<img src="/img/th_up.png" id="sort_tot_enuri_amt"></th>
						<th onclick="reSortAjax('sort_tot_amt')" class="td-90">순매출금액<img src="/img/th_up.png" id="sort_tot_amt"></th>
						<th onclick="reSortAjax('sort_enuri_rate')" class="td-80">할인율(%)<img src="/img/th_up.png" id="sort_enuri_rate"></th>
						<th onclick="reSortAjax('sort_sale_ymd')">매출일<img src="/img/th_up.png" id="sort_sale_ymd"></th>
						<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
						<th onclick="reSortAjax('sort_recpt_no')" class="td-90">영수증번호 <img src="/img/th_up.png" id="sort_recpt_no"></th>
<!-- 						<th onclick="reSortAjax('sort_create_resi_no')">승인번호 <img src="/img/th_up.png" id="sort_create_resi_no"></th> -->
						<th onclick="reSortAjax('sort_subject_nm')" class="td-170">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>					
					</tr>
			</thead>
		</table>
	</div>
		<div class="table-list">
			<table id="excelTable">
				<colgroup>
					<col width="40px">
					<col width="40px">
					<col>
					<col>
					<col>
					<col>
					<col width="100px">
					<col width="100px">
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col>
					<col width="250px">
				</colgroup>
				<thead>
					<tr>
						<th class="td-chk">
							<input type="checkbox" id="idxAll" name="idx" value="idxAll" onclick="all_chker();"><label for="idxAll"></label>
						</th>
						<th class="td-50">NO.</th>
						<th onclick="reSortAjax('sort_cust_no')" class="td-90">멤버스번호 <img src="/img/th_up.png" id="sort_cust_no"></th>
						<th onclick="reSortAjax('sort_kor_nm')">회원명<img src="/img/th_up.png" id="sort_kor_nm"></th>
						<th onclick="reSortAjax('sort_grade')">회원등급<img src="/img/th_up.png" id="sort_grade"></th>
						
						<th onclick="reSortAjax('sort_cust_fg')">회원구분<img src="/img/th_up.png" id="sort_cust_fg"></th>
<!-- 						<th onclick="reSortAjax('sort_enuri_code1')">할인코드1<img src="/img/th_up.png" id="sort_enuri_code1"></th> -->
<!-- 						<th onclick="reSortAjax('sort_enuri_code2')">할인코드2<img src="/img/th_up.png" id="sort_enuri_code2"></th> -->
						<th onclick="reSortAjax('sort_enuri_nm1')" class="td-140">할인코드명1<img src="/img/th_up.png" id="sort_enuri_nm1"></th>
						<th onclick="reSortAjax('sort_enuri_nm2')" class="td-140">할인코드명2<img src="/img/th_up.png" id="sort_enuri_nm2"></th>
						<th onclick="reSortAjax('sort_regis_fee')">수강료<img src="/img/th_up.png" id="sort_regis_fee"></th>
						<th onclick="reSortAjax('sort_tot_enuri_amt')">할인금액<img src="/img/th_up.png" id="sort_tot_enuri_amt"></th>
						<th onclick="reSortAjax('sort_tot_amt')" class="td-90">순매출금액<img src="/img/th_up.png" id="sort_tot_amt"></th>
						<th onclick="reSortAjax('sort_enuri_rate')" class="td-80">할인율(%)<img src="/img/th_up.png" id="sort_enuri_rate"></th>
						<th onclick="reSortAjax('sort_sale_ymd')">매출일<img src="/img/th_up.png" id="sort_sale_ymd"></th>
						<th onclick="reSortAjax('sort_pos_no')">POS번호<img src="/img/th_up.png" id="sort_pos_no"></th>
						<th onclick="reSortAjax('sort_recpt_no')" class="td-90">영수증번호 <img src="/img/th_up.png" id="sort_recpt_no"></th>
<!-- 						<th onclick="reSortAjax('sort_create_resi_no')">승인번호 <img src="/img/th_up.png" id="sort_create_resi_no"></th> -->
						<th onclick="reSortAjax('sort_subject_nm')" class="td-170">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>					
					</tr>
				</thead>
				<tbody id="list_target">
					<!-- 
					<c:forEach var="i" items="${list}" varStatus="loop">
						<tr class="tr_each idx_${loop.index}">
							<td class="td-chk">
								<input type="checkbox" id="idx_${loop.index}" class="encd_chk" name="encd_idx" value="${i.SUB_CODE}"><label for="idx_${loop.index}"></label>
							</td>
							<td>${loop.index}</td>
							<td >${i.ENCD_CUS_NO}</td>
							<td>${i.ENCD_KOR_NM}</td>
							<td>${i.ENCD_CUST_FG}</td>
							<td>${i.ENURI_AMT1}</td>
							<td>${i.ENURI_NM}</td>
							<td class="color-blue">${i.REGIS_FEE}</td>
							<td class="bg-gray">${i.ENURI_AMT2}</td>
							<td class="color-red">${i.NET_SALE_AMT}</td>
							<td class="bg-red">${i.ENURI_2_FG}</td>
							<td>${i.SALE_YMD}</td>
							<td>${i.POS_NO}</td>
							<td>${i.RECPT_NO}</td>
							<td>${i.CREATE_RESI_NO}</td>
							<td>한글서예</td>
						</tr>
					</c:forEach>
					 -->
				</tbody>
			</table>
		</div>
		
	</div>
	<script>
	$( document ).ready(function() {
		//$('#selBranch').attr('onchange','fncPeri();getEncdListByList()');
		//$('#selPeri').attr('onchange','fncPeri2();getEncdListByList()');
		//store_change();
		if(nullChk(getCookie("page")) != "") { page = nullChk(getCookie("page")); }
		if(nullChk(getCookie("order_by")) != "") { order_by = nullChk(getCookie("order_by")); }
		if(nullChk(getCookie("sort_type")) != "") { sort_type = nullChk(getCookie("sort_type")); }
		if(nullChk(getCookie("listSize")) != "") { $("#listSize").val(nullChk(getCookie("listSize"))); $(".listSize").html($("#listSize option:checked").text());}
		if(nullChk(getCookie("search_name")) != "") { $("#search_name").val(nullChk(getCookie("search_name")));}
		if(nullChk(getCookie("search_con")) != "") { $("#search_con").val(nullChk(getCookie("search_con"))); $(".search_con").html($("#search_con option:checked").text());}
		if(nullChk(getCookie("store")) != "") { $("#selBranch").val(nullChk(getCookie("store"))); $(".selBranch").html($("#selBranch option:checked").text());} else {setPeri();}
		fncPeri();
		selPeri();
		if(nullChk(getCookie("period")) != "") { $("#selPeri").val(nullChk(getCookie("period"))); $(".selPeri").html($("#selBranch option:checked").text());}
		if(nullChk(getCookie("start_ymd")) != "") { $("#start_ymd").val(nullChk(getCookie("start_ymd")));}
		if(nullChk(getCookie("end_ymd")) != "") { $("#end_ymd").val(nullChk(getCookie("end_ymd")));}
		if(nullChk(getCookie("cust_fg_a")) == "true") 
		{
			$("input:checkbox[id='cust_fg_a']").prop("checked", true);   
		}
		if(nullChk(getCookie("cust_fg_b")) == "true") 
		{
			$("input:checkbox[id='cust_fg_b']").prop("checked", true);   
		}
		if(nullChk(getCookie("encd_list")) != "") { $("#encd_list").val(nullChk(getCookie("encd_list"))); $(".encd_list").html($("#encd_list option:checked").text());}
		getEncdListByList();
		getList();

	});
	</script>
<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>