<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker_month.html"/>

<script>
$(document).ready(function(){
	setPeri();
	fncPeri();
});
function getList()
{
	$.ajax({
		type : "POST", 
		url : "./getCorp1List",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			lect_ym : $("#lect_ym").val(),
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
					inner += '	<td>'+result.list[i].CO_NM+'</td>';
					inner += '	<td>'+result.list[i].BANK_NM+'</td>';
					inner += '	<td>'+result.list[i].ACCOUNT_NO+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_CD+'</td>';
					inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
					inner += '	<td>'+result.list[i].REGIS_FEE+'</td>';
					inner += '	<td>'+result.list[i].FIX_AMT+'</td>';
					inner += '	<td>'+result.list[i].FIX_RATE+'</td>';
					inner += '	<td>'+result.list[i].PAY_DAY+'</td>';
					inner += '	<td>'+result.list[i].CAPACITY_NO+'</td>';
					inner += '	<td>'+result.list[i].REGIS_NO+'</td>';
					inner += '	<td>'+result.list[i].PART_REGIS_NO+'</td>';
					inner += '	<td>'+result.list[i].PART_REGIS_AMT+'</td>';
					inner += '	<td>'+result.list[i].JOURNAL_YN+'</td>';
					inner += '	<td>'+result.list[i].ISSUE_YN+'</td>';
					inner += '	<td>'+result.list[i].ACCEPT_NM+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="20"><div class="no-data">??????????????? ????????????.</div></td>';
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
</script>
<div class="sub-tit">
	<h2>??????????????? ???????????? ??????</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn01" href="#">??????</a>
	</div>
</div>


<div class="table-top">
	<div class="top-row sear-wr">
		<div class="wid-7">
			<div class="table">
				<div class="wid-45">
					<div class="table table02 table-input wid-contop">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
				</div>
				<div class="wid-15">
					<div class="table">
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">arrow_right_alt</i></div>
						<div class=" sel-scr">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="wid-2 mag-l4">
			<div class="table">
				<div class="sear-tit">????????????</div>
				<div>
					<input type="text" class="date-i" id="lect_ym" name="lect_ym">
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
					<select id="listSize" name="listSize" onchange="getList()" de-data="10??? ??????">
						<option value="10">10??? ??????</option>
						<option value="20">20??? ??????</option>
						<option value="50">50??? ??????</option>
						<option value="100">100??? ??????</option>
						<option value="300">300??? ??????</option>
						<option value="500">500??? ??????</option>
						<option value="1000">1000??? ??????</option>
					</select>
				</div>
			</div>
			
			
		</div>
	</div>
	
	<div class="table-list  table-csplist">
		<table>
			<thead>
				<tr>
					<th onclick="reSortAjax('sort_main_cd')">?????????<img src="/img/th_up.png" id="sort_main_cd"></th>
					<th onclick="reSortAjax('sort_main_nm')">?????????<img src="/img/th_up.png" id="sort_main_nm"></th>
					<th onclick="reSortAjax('sort_sect_cd')">?????????<img src="/img/th_up.png" id="sort_sect_cd"></th>
					<th onclick="reSortAjax('sort_sect_nm')">?????????<img src="/img/th_up.png" id="sort_sect_nm"></th>
					<th onclick="reSortAjax('sort_co_nm')">?????????<img src="/img/th_up.png" id="sort_co_nm"></th>
					<th onclick="reSortAjax('sort_bank_nm')">????????????<img src="/img/th_up.png" id="sort_bank_nm"></th>
					<th onclick="reSortAjax('sort_account_no')">????????????<img src="/img/th_up.png" id="sort_account_no"></th>
					<th onclick="reSortAjax('sort_subject_cd')">??????<img src="/img/th_up.png" id="sort_subject_cd"></th>
					<th onclick="reSortAjax('sort_subject_nm')">?????????<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_regis_fee')">?????????<img src="/img/th_up.png" id="sort_regis_fee"></th>
					<th onclick="reSortAjax('sort_fix_amt')">??????<img src="/img/th_up.png" id="sort_fix_amt"></th>
					<th onclick="reSortAjax('sort_fix_rate')">??????<img src="/img/th_up.png" id="sort_fix_rate"></th>
					<th onclick="reSortAjax('sort_pay_day')">????????????<img src="/img/th_up.png" id="sort_pay_day"></th>
					<th onclick="reSortAjax('sort_capacity_no')">????????????<img src="/img/th_up.png" id="sort_capacity_no"></th>
					<th onclick="reSortAjax('sort_regis_no')">????????????<img src="/img/th_up.png" id="sort_regis_no"></th>
					<th onclick="reSortAjax('sort_part_regis_no')">????????????<img src="/img/th_up.png" id="sort_part_regis_no"></th>
					<th onclick="reSortAjax('sort_part_regis_amt')">???????????????<img src="/img/th_up.png" id="sort_part_regis_amt"></th>
					<th onclick="reSortAjax('sort_journal_yn')">????????????<img src="/img/th_up.png" id="sort_journal_yn"></th>
					<th onclick="reSortAjax('sort_issue_yn')">????????????<img src="/img/th_up.png" id="sort_issue_yn"></th>
					<th onclick="reSortAjax('sort_accept_nm')">????????????<img src="/img/th_up.png" id="sort_accept_nm"></th>
				</tr>
				
			</thead>
			<tbody id="list_target">
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">???????????? ?????????</td> -->
<!-- 					<td>?????????</td> -->
<!-- 					<td>???????????????</td> -->
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
<!-- 					<td>?????????</td>									 -->
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
<!-- 									<th>?????????</th> -->
<!-- 									<th>??????</th> -->
<!-- 									<th>????????????</th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 									<th></th> -->
<!-- 								</tr> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>???????????? ????????????</td> -->
<!-- 									<td>???</td> -->
<!-- 									<td>??????</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>???????????? ????????????</td> -->
<!-- 									<td>???</td> -->
<!-- 									<td>??????</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>220,000</td> -->
<!-- 									<td>2019-11-10</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td>3</td> -->
<!-- 									<td>???????????? ????????????</td> -->
<!-- 									<td>???</td> -->
<!-- 									<td>??????</td> -->
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
<!-- 					<td class="color-blue line-blue">???????????? ?????????</td> -->
<!-- 					<td>?????????</td> -->
<!-- 					<td>???????????????</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>?????????</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">???????????? ?????????</td> -->
<!-- 					<td>?????????</td> -->
<!-- 					<td>???????????????</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>?????????</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">???????????? ?????????</td> -->
<!-- 					<td>?????????</td> -->
<!-- 					<td>???????????????</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>?????????</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">???????????? ?????????</td> -->
<!-- 					<td>?????????</td> -->
<!-- 					<td>???????????????</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td class="tdbtn_red"><span>??????</span></td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>?????????</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr>					 -->
<!-- 					<td class="td-chk"> -->
<!-- 						<input type="checkbox" id="idx" name="idx" value=""><label for="idx"></label> -->
<!-- 					</td> -->
<!-- 					<td>808-88-00920</td> -->
<!-- 					<td class="color-blue line-blue">???????????? ?????????</td> -->
<!-- 					<td>?????????</td> -->
<!-- 					<td>???????????????</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">550,000</td> -->
<!-- 					<td class="bg-red">50,000</td> -->
<!-- 					<td>010-2352-6985</td> -->
<!-- 					<td>hi@musign.net</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>?????????</td>									 -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
	
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>