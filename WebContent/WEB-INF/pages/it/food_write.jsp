<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
$(document).ready(function(){
	setPeri();
	fncPeri();
});
function getList()
{
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
			
			food_ymd : $("#food_ymd").val(),
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			main_cd : $("#main_cd").val(),
			sect_cd : $("#sect_cd").val(),
			journal_yn : $("#journal_yn").val()
			
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
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+result.list[i].MAIN_CD+'</td>';
					inner += '	<td>'+result.list[i].MAIN_NM+'</td>';
					inner += '	<td>'+result.list[i].SECT_CD+'</td>';
					inner += '	<td>'+result.list[i].SECT_NM+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+result.list[i].LECTURER_NM+'</td>';
					inner += '	<td>'+result.list[i].BIRTH_YMD+'</td>';
					inner += '	<td>'+result.list[i].CAPACITY_NO+'</td>';
					inner += '	<td>'+result.list[i].REGIS_NO+'</td>';
					inner += '	<td>'+result.list[i].FOOD_AMT+'</td>';
					inner += '	<td>'+result.list[i].FOOD_ALL_AMT+'</td>';
					inner += '	<td>'+result.list[i].FOOD_PAY_AMT+'</td>';
					inner += '	<td>'+result.list[i].FOOD_REST_AMT+'</td>';
					inner += '	<td>'+result.list[i].JOURNAL_YN+'</td>';
					inner += '	<td>'+result.list[i].CONFIRM_YN+'</td>';
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
			listSize = result.listSize;
			$("#list_target").html(inner);
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
		}
	});	
}
var main_cd ="";
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
			if(result.length > 0)
			{
				inner="";
				$(".sect_cd").html(result[0].SECT_NM);
				for (var i = 0; i < result.length; i++) {
					inner+='<option value="'+result[i].SECT_CD+'" onclick="sect_choose(this)">'+result[i].SECT_NM+'</option>';
				}
				$("#sect_cd").append(inner);
				$("#sect_cd").val(result[0].SECT_CD);
				$(".sect_cd_ul").append(inner);
			}
			else
			{
				
			}
		}
	});	
}
function sect_choose(idx){
	sect_value = $(idx).val();
	sect_text = $(idx).text();
	
	$("#sect_cd").val(sect_value);
	$(".sect_cd").html(sect_text);
	
	$('.select-ul').css('display','none');
}
</script>
<div class="sub-tit">
	<h2>재료비  지불항목 등록</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn01" href="#">저장</a>
	</div>
</div>


<div class="table-top">
	<div class="top-row sear-wr">
		<div class="wid-10">
			<div class="table">
				<div class="wid-45">
					<div class="table table02 table-input wid-contop">
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
	<div class="top-row">
		<div class="wid-2 mag-r4">
			<div class="table">
				<div class="sear-tit">지급일</div>
				<div>
					<input type="text" class="date-i" id="food_ymd" name="food_ymd">
				</div>
			</div>
		</div>
		<div class="wid-2 mag-r4">
			<div class="table">
				<div class="sear-tit">대분류</div>
				<div>
					<select de-data="선택하세요." id="main_cd" name="main_cd" data-name="대분류" class="notEmpty" onchange="selMaincd(this)">
						<c:forEach var="j" items="${maincdList}" varStatus="loop">
							<option value="${j.SUB_CODE}">${j.SHORT_NAME}</option>
						</c:forEach>
					</select>
				</div>
			</div>
		</div>
		<div class="wid-2 mag-r4">
			<div class="table">
				<div class="sear-tit">중분류</div>
				<div>
					<select de-data="선택하세요." id="sect_cd" name="sect_cd" data-name="중분류" class="notEmpty" onchange="">
	
					</select>
				</div>
			</div>
		</div>
		<div class="wid-2">
			<div class="table">
				<div class="sear-tit">분개여부</div>
				<div>
					<select de-data="전체" id="journal_yn" name="journal_yn">
						<option value="">전체</option>
						<option value="Y">분개</option>
						<option value="N">미분개</option>
					</select>
				</div>
			</div>
		</div>
		
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getList();">
</div>


<div class="table-wr ">
	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			<div class="table table02 table-auto float-right sel-scr">
				<div>			
					<a class="bor-btn btn01" href="#"><i class="material-icons">local_printshop</i></a>
					<a class="bor-btn btn01 mrg-l6" href="#"><i class="fas fa-file-download"></i></a>
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
	
	<div class="table-list  table-csplist">
		<table>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_main_cd')">대코드<img src="/img/th_up.png" id="sort_main_cd"></th>
					<th onclick="reSortAjax('sort_main_nm')">대분류<img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_cd')">중코드<img src="/img/th_up.png" id="sort_sect_cd"></th>
					<th onclick="reSortAjax('sort_sect_nm')">중분류<img src="/img/th_up.png" id="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_subject_cd')">코드<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_lecturer_nm')">강사명<img src="/img/th_up.png" id="sort_lecturer_nm"></th>
					<th onclick="reSortAjax('sort_birth_ymd')">생년월일<img src="/img/th_up.png" id="sort_birth_ymd"></th>
					<th onclick="reSortAjax('sort_capacity_no')">정원<img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_regis_no')">등록<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_food_amt')">재료비<img src="/img/th_up.png" id="sort_food_amt"></th>
					<th onclick="reSortAjax('sort_food_all_amt')">재료비입금<img src="/img/th_up.png" id="sort_food_all_amt"></th>
					<th onclick="reSortAjax('sort_food_pay_amt')">재료비지불<img src="/img/th_up.png" id="sort_food_pay_amt"></th>
					<th onclick="reSortAjax('sort_food_rest_amt')">재료비잔고<img src="/img/th_up.png" id="sort_food_rest_amt"></th>
					<th onclick="reSortAjax('sort_journal_yn')">분개여부<img src="/img/th_up.png" id="sort_journal_yn"></th>
					<th onclick="reSortAjax('sort_confirm_yn')">등록여부<img src="/img/th_up.png" id="sort_confirm_yn"></th>
				</tr>
				
			</thead>
			<tbody id="list_target">
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td class="tdbtn_cal"> -->
<!-- 						<span> -->
<!-- 							<input type="text" class="date-i" value="2019-09-06" /> -->
<!-- 							<i class="material-icons">event_available</i></td> -->
<!-- 						</span> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr class="hide-tr"> -->
<!-- 					<td colspan="14"> -->
<!-- 						<table> -->
<%-- 							<colgroup> --%>
<%-- 								<col width="7%;" /> --%>
<%-- 								<col width="15%;" /> --%>
<%-- 								<col width="5%;" /> --%>
<%-- 								<col width="8.3%;" /> --%>
<%-- 								<col width="7%;" /> --%>
<%-- 								<col width="7.2%;" /> --%>
<%-- 								<col width="7.2%;" /> --%>
<%-- 								<col /> --%>
<%-- 							</colgroup> --%>
<!-- 							<thead> -->
<!-- 								<tr> -->
<!-- 									<th>NO.</th> -->
<!-- 									<th>강좌명</th> -->
<!-- 									<th>요일</th> -->
<!-- 									<th>지급기준</th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 								</tr> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>트니트니 율동체조</td> -->
<!-- 									<td>금</td> -->
<!-- 									<td>정률</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>트니트니 율동체조</td> -->
<!-- 									<td>금</td> -->
<!-- 									<td>정률</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>트니트니 율동체조</td> -->
<!-- 									<td>금</td> -->
<!-- 									<td>정률</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</td> -->
				
<!-- 				</tr> -->
				
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td class="tdbtn_red"><span>입력</span></td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">주식회사 뮤자인</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>세금계산서</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
	
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>