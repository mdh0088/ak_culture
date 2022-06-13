<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>


function lect_delete()
{
	var cn = '${cn}';
	var store = '${store}';
	var period = '${period}';
	$.ajax({
		type : "POST", 
		url : "./endAction",
		dataType : "text",
		data : 
		{
			chkList : store+"_"+period+"_"+cn+"|",
			act : 'Y'
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
</script>


<div class="sub-tit">
	<h2>강좌별 수강현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<a class="btn btn02" onclick="javascript:lect_delete();">폐강처리</a>
		<a class="btn btn01 btn01_1" href="/member/wait/list">대기자 관리</a>
	</div>
</div>

<div class="lect-top table-top first">
	<div class="">
		<p class="lect-st">성인<i class="material-icons">keyboard_arrow_right</i><span class="color-pink">건강웰빙</span></p>
		<div class="lect-titwr">
			<p class="lect-tit">${data.SUBJECT_NM}(${fn:trim(data.SUBJECT_CD)})</p>
			<p class="lect-tit2">${data.WEB_LECTURER_NM} 강사</p>
			<p class="btn btn08">${data.STORE_NAME}</p>
		</div>
	</div>
</div>
<form id="fncForm" name="fncForm" method="get" action="./list">
	<div class="table-top table-top02">
		<div class="top-row sear-wr">
			<div class="wid-5">
				<div class="table">
					<div class="search-wr sel100">
						<select id="" name="" onchange="reSelect()" de-data="검색항목">
							<option value="20">멤버스번호</option>
							<option value="50">포털ID</option>
							<option value="50">휴대폰번호</option>
							<option value="50">회원명</option>
						</select>
					    <input type="text" id="search_name" name="search_name" onkeypress="excuteEnter(reSelect)" placeholder="검색어를 입력하세요.">
					    <input class="search-btn" type="button" value="검색" onclick="reSelect()">
					</div>
				
				</div>
			</div>
			<div class="wid-5">
				<div class="table table-input">
					<div>
						<div class="cal-row table cal-row_auto">
							<div class="cal-input cal-input02">
								<input type="text" class="date-i">
								<i class="material-icons">event_available</i>
							</div>
							<div class="cal-dash">-</div>
							<div class="cal-input cal-input02">
								<input type="text" class="date-i">
								<i class="material-icons">event_available</i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="top-row table-input">
			<div class="wid-35">
				<div class="table table-90">
					<div class="sear-tit">신청구분</div>
					<div>
						<select de-data="선택">
							<option>MOBILE</option>
							<option>DESK</option>
							<option>WEB</option>
						</select>
					</div>
				</div>
			</div>
			<div class="wid-35">
				<div class="table table-90">
					<div class="sear-tit">회원구분</div>
					<div>
						<select de-data="선택">
							<option>전체</option>
							<option>신규</option>
							<option>기존</option>
						</select>
					</div>
				</div>
			</div>
			<div class="wid-35">
				<div class="table table-90">
					<div class="sear-tit">상태</div>
					<div>
						<select de-data="선택">
							<option>등록</option>
							<option>취소</option>
							<option>대기</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<input class="search-btn02 btn btn02" type="button" value="Search" onclick="reSelect()">
	</div>
	<div class="table-cap table">
		<div class="cap-l">
			<p class="cap-numb"></p>
		</div>
		<div class="cap-r text-right">
			
			<div class="table table02 table-auto float-right">
				<div>
					<p class="ip-ritit">선택한 항목을</p>
				</div>
				<div>
					<a class="bor-btn btn01 btn-mar6" href="#"><i class="material-icons">settings_phone</i></a>
					<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a>
					<select id="listSize" name="listSize" onchange="reSelect()" de-data="10개 보기">
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
	<input type="hidden" id="page" name="page" value="${page}">
	<input type="hidden" id="order_by" name="order_by" value="${order_by}">
    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
</form>
<div class="table-wr ip-list">
	<div class="table-list">
		<table>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
					</th>
					<th>NO.</th>
					<th onclick="reSort('sort_cus_no')">멤버스번호 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_ptl_id')">포털ID <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_kor_nm')">회원명 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_sex_fg')">성별 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_birth_ymd')">생년월일 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_seq_no')">신청구분 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_seq_no')">결제수단 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_sale_ymd')">결제일 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_seq_no')">회원구분 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_seq_no')">수강구분 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_seq_no')">상태 <i class="material-icons">import_export</i></th>				
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" items="${list}" varStatus="loop">
					<tr>
						<td class="td-chk">
							<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label>
						</td>
						<td>${loop.index+1}</td>
						<td>${i.CUS_NO}</td>
						<td>${i.PTL_ID}</td>
						<td class="color-blue line-blue" onclick="location.href='/member/cust/list_mem'" style="cursor:pointer;">${i.KOR_NM }</td>
						<td>${i.SEX_FG }</td>
						<td>${i.BIRTH_YMD }</td>
						<td>?</td>
						<td>?</td>
						<td>${i.SALE_YMD }</td>
						<td>?</td>
						<td>?</td>
						<td class="color-blue line-blue">?</td>
					</tr>
				</c:forEach>
<!-- 				<tr class="cancel-row"> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>1</td> -->
<!-- 					<td>12345689</td> -->
<!-- 					<td>musign</td> -->
<!-- 					<td class="color-blue line-blue">김태연</td> -->
<!-- 					<td>F</td> -->
<!-- 					<td>1984-01-18</td> -->
<!-- 					<td>WEB</td> -->
<!-- 					<td>신용카드</td> -->
<!-- 					<td>2019-09-02</td> -->
<!-- 					<td>신규</td> -->
<!-- 					<td>신규</td> -->
<!-- 					<td>취소</td> -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
</div>


<jsp:include page="/WEB-INF/pages/common/paging.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>