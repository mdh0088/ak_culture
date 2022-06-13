<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>
<script>
function excelDown()
{
	var filename = "강사료 분개전송";
	var table = "excelTable";
    exportExcel(filename, table);
}
$(document).ready(function(){
	setBundang();
	getList();
});
function getList()
{
// 	getListStart();
	$.ajax({
		type : "POST", 
		url : "./getEndList",
		dataType : "text",
		data : 
		{
			corp_fg : $("#corp_fg").val(),
			store : $("#selBranch").val(),
			sale_ymd : $("#sale_ymd").val()
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
// 			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].PGM_NM)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].REQ_START_TM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].STATUS)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].JOB_START_TM)+'</td>';
					inner += '	<td>'+cutDate(result.list[i].JOB_END_TM)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ERROR_CD)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].ERROR_MSG)+'</td>';
					inner += '	<td>'+nullChk(result.list[i].USER_NM)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="10"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
// 			order_by = result.order_by;
// 			sort_type = result.sort_type;
// 			listSize = result.listSize;
			$("#list_target").html(inner);
// 			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
// 			getListEnd();
		}
	});	
}
function fncSubmit(act)
{
	$("#act").val(act);
	
	if(act == "jaemu_cancle")
	{
		$("#fncForm").attr("action", "./jaemu_end_proc");
	}
	else
	{
		$("#fncForm").attr("action", "./end_proc");
	}
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
</script>
<div class="sub-tit">
	<h2>강사료 분개/전송</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn s-btn btn01" onclick="javascript:fncSubmit('cancle');">분개 취소</a>
		<a class="btn s-btn btn01" onclick="javascript:fncSubmit('jaemu_cancle');">전송 취소</a>
		<a class="btn btn02" onclick="javascript:fncSubmit('send');">분개 작업</a>
		<a class="btn btn03" onclick="javascript:fncSubmit('submit');">분개 전송하기</a>
<!-- 		<a class="btn btn03" onclick="javascript:status();">작업 현황</a> -->
	</div>
</div>

<form id="fncForm" name="fncForm" method="POST">
	<div class="table-top">
		<div class="top-row sear-wr">
			<div>
				<div class="table table-auto">
					<div>
						<select id="hq" name="hq" de-data="[00] 애경유통">
							<option value="00">[00] 애경유통</option>
						</select>
					</div>
					<div>
						<c:if test="${isBonbu eq 'T'}">
							<select de-data="전체" id="selBranch" name="selBranch">
								<option value="">전체</option>
								<c:forEach var="i" items="${branchList}" varStatus="loop">
									<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
								</c:forEach>
							</select>
						</c:if>
						<c:if test="${isBonbu eq 'F'}">
							<select de-data="${login_rep_store_nm}" id="selBranch" name="selBranch">
								<c:forEach var="i" items="${branchList}" varStatus="loop">
									<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
								</c:forEach>
							</select>
						</c:if>
					</div>
				</div>
			</div>
			<div class="wid-2 mag-l2">
				<div class="table">
					<div class="sear-tit sear-tit-70">지급일자</div>
					<div>
						<div class="cal-row cal-row02 table">
							<div class="cal-input wid-4">
								<input type="text" class="date-i ready-i" id="sale_ymd" name="sale_ymd"/>
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="wid-2">
				<div class="table">
					<div class="sear-tit sear-tit_120 sear-tit_left">강사구분</div>
					<div>
						<select id="corp_fg" name="corp_fg" de-data="법인">
							<option value="1">법인</option>
							<option value="2">개인</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="top-row">
	<!-- 		<div class="wid-2"> -->
	<!-- 			<div class="table"> -->
	<!-- 				<div class="sear-tit sear-tit_70">상태</div> -->
	<!-- 				<div> -->
	<!-- 					<select de-data="전체"> -->
	<!-- 						<option>폐강</option> -->
	<!-- 						<option>정상</option> -->
	<!-- 					</select> -->
	<!-- 				</div> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
			
	<!-- 		<div class="wid-25"> -->
	<!-- 			<div class="table"> -->
	<!-- 				<div class="sear-tit sear-tit_120 sear-tit_left">강좌유형</div> -->
	<!-- 				<div> -->
	<!-- 					<select de-data="전체"> -->
	<!-- 						<option>특강</option> -->
	<!-- 						<option>단기</option> -->
	<!-- 						<option>정규</option> -->
	<!-- 					</select> -->
	<!-- 				</div> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
			
	<!-- 		<div class="wid-3 mag-l2"> -->
	<!-- 			<div class="table"> -->
	<!-- 				<div class="sear-tit">분개전송여부</div> -->
	<!-- 				<div> -->
	<!-- 					<ul class="chk-ul"> -->
	<!-- 						<li> -->
	<!-- 							<input type="radio" id="rad-c" name="rad-1" checked=""> -->
	<!-- 							<label for="rad-c">전체</label> -->
	<!-- 						</li> -->
	<!-- 						<li> -->
	<!-- 							<input type="radio" id="rad-c" name="rad-2"> -->
	<!-- 							<label for="rad-c">전송</label> -->
	<!-- 						</li> -->
	<!-- 						<li> -->
	<!-- 							<input type="radio" id="rad-c" name="rad-2"> -->
	<!-- 							<label for="rad-c">미전송</label> -->
	<!-- 						</li> -->
	<!-- 					</ul> -->
	<!-- 				</div> -->
	<!-- 			</div> -->
	<!-- 		</div> -->
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getList();">
	</div>
	<input type="hidden" id="act" name="act">
</form>

<div class="table-cap table">
<!-- 	<div class="cap-l"> -->
<!-- 		<p class="cap-numb"></p> -->
<!-- 	</div> -->
	<div class="cap-r text-right">
		<div class="table table02 table-auto float-right sel-scr">
			<div>			
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
<div class="table-wr ">	
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="80px">
				<col width="150px">
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
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_store_nm')">점<img src="/img/th_up.png" id="sort_store_nm"></th>
					<th onclick="reSortAjax('sort_pgm_nm')">프로그램명<img src="/img/th_up.png" id="sort_pgm_nm"></th>
					<th onclick="reSortAjax('sort_req_start_tm')">작업의뢰시간<img src="/img/th_up.png" id="sort_req_start_tm"></th>
					<th onclick="reSortAjax('sort_status')">상태<img src="/img/th_up.png" id="sort_status"></th>
					<th onclick="reSortAjax('sort_job_start_tm')">작업시작시간<img src="/img/th_up.png" id="sort_job_start_tm"></th>
					<th onclick="reSortAjax('sort_job_end_tm')">작업종료시간<img src="/img/th_up.png" id="sort_job_end_tm"></th>
					<th onclick="reSortAjax('sort_error_cd')">오류코드<img src="/img/th_up.png" id="sort_error_cd"></th>
					<th onclick="reSortAjax('sort_error_msg')">메세지<img src="/img/th_up.png" id="sort_error_msg"></th>
					<th onclick="reSortAjax('sort_user_nm')">작업자<img src="/img/th_up.png" id="sort_user_nm"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-csplist">
		<table id="excelTable">
			<colgroup>
				<col width="40px">
				<col width="80px">
				<col width="150px">
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
					<th class="td-no">NO.</th>
					<th onclick="reSortAjax('sort_store_nm')">점<img src="/img/th_up.png" id="sort_store_nm"></th>
					<th onclick="reSortAjax('sort_pgm_nm')">프로그램명<img src="/img/th_up.png" id="sort_pgm_nm"></th>
					<th onclick="reSortAjax('sort_req_start_tm')">작업의뢰시간<img src="/img/th_up.png" id="sort_req_start_tm"></th>
					<th onclick="reSortAjax('sort_status')">상태<img src="/img/th_up.png" id="sort_status"></th>
					<th onclick="reSortAjax('sort_job_start_tm')">작업시작시간<img src="/img/th_up.png" id="sort_job_start_tm"></th>
					<th onclick="reSortAjax('sort_job_end_tm')">작업종료시간<img src="/img/th_up.png" id="sort_job_end_tm"></th>
					<th onclick="reSortAjax('sort_error_cd')">오류코드<img src="/img/th_up.png" id="sort_error_cd"></th>
					<th onclick="reSortAjax('sort_error_msg')">메세지<img src="/img/th_up.png" id="sort_error_msg"></th>
					<th onclick="reSortAjax('sort_user_nm')">작업자<img src="/img/th_up.png" id="sort_user_nm"></th>
				</tr>
				
			</thead>
			<tbody id="list_target">
<!-- 				<tr>					 -->
<!-- 					<td>1</td>	 -->
<!-- 					<td>법인</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김화영</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2,500,000</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>1,250,000</td> -->
<!-- 					<td>2019-11-11</td> -->
<!-- 					<td>Y</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr>					 -->
<!-- 					<td>1</td>	 -->
<!-- 					<td>법인</td> -->
<!-- 					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김화영</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>정규</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>회화를 위한 기초 영문법</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>12</td> -->
<!-- 					<td>2,500,000</td> -->
<!-- 					<td>-</td> -->
<!-- 					<td>1,250,000</td> -->
<!-- 					<td>2019-11-11</td> -->
<!-- 					<td>Y</td> -->
<!-- 					<td>2019-09-01</td>					 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
<%-- 	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/> --%>
<!-- 	<div class="total-fix total-fix01"> -->
<!-- 		<ul> -->
<!-- 			<li class="first">총 725건</li> -->
<!-- 			<li class="li02">계</li> -->
<!-- 			<li class="li03">187,225,000</li> -->
<!-- 			<li class="li04">50,000</li> -->
<!-- 			<li class="li05">2,243,154</li> -->
<!-- 			<li class="li06"></li> -->
<!-- 			<li class="last"><img src="/img/excel-i.png" /></li> -->
<!-- 		</ul> -->
<!-- 	</div> -->
	
</div>



<!-- <div id="write_layer" class="list-edit-wrap"> -->
<!-- 	<div class="le-cell"> -->
<!-- 		<div class="le-inner"> -->
<!--         	<div class="list-edit white-bg itend-edit"> -->
<!--         		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200); close_act();"> -->
<!--         			닫기<i class="far fa-window-close"></i> -->
<!--         		</div> -->
<!-- 				<div> -->
<!-- 				여기 -->
<!-- 					<form id="fncFormIp" name="fncFormIp" method="POST"> -->
<!-- 						<h3 class="status_now">작업 현황</h3> -->
<!-- 						<div class="top-row change-wrap"> -->
<!-- 							<div class="wid10"> -->
<!-- 								<div class="table-list table-list_end"> -->
<!-- 									<table> -->
<!-- 										<thead> -->
<!-- 											<tr> -->
<!-- 												<th>NO</th> -->
<!-- 												<th>분개일시</th> -->
<!-- 												<th>분개여부</th> -->
<!-- 												<th>담당자</th> -->
<!-- 												<th>전송건</th> -->
<!-- 											</tr> -->
											
<!-- 										</thead> -->
<!-- 										<tbody> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 										</tbody> -->
									
<!-- 									</table> -->
<!-- 								</div> -->
<!-- 							</div> -->
							
<!-- 						</div> -->
<!-- 					</form> -->
<!-- 					<div class="btn-wr text-center"> -->
<!-- 						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitIp();">확인</a> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!--         	</div> -->
<!--         </div> -->
<!--     </div>	 -->
<!-- </div> -->



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>