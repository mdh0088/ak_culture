<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<link rel="import" href="/inc/date_picker/date_picker.html">

<script>

</script>
<div class="sub-tit">
	<h2>이강관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<a class="btn btn01 btn01_1" href="write"><i class="material-icons">add</i>이강신청</a>
	</div>
</div>
<form id="fncForm" name="fncForm" method="get" action="./list">
	<div class="table-top">
		<div class="top-row sear-wr">
			<div class="wid-3">
				<div class="table table-auto">
					<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
				</div>
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
			<div class="wid-35 ">
				<div class="cal-row table cal-row02 table-90">
					<div class="cal-input wid-4">
						<input type="text" class="date-i hasDatepicker" id="start_ymd" name="start_ymd">
						<i class="material-icons">event_available</i>
					</div>
					<div class="cal-dash">-</div>
					<div class="cal-input wid-4">
						<input type="text" class="date-i hasDatepicker" id="end_ymd" name="end_ymd">
						<i class="material-icons">event_available</i>
					</div>
				</div>
			</div>
			<div class="wid-4">
				<div class="table">
					<div class="search-wr sear-22">
						<select id="" name="" onchange="reSelect()" de-data="검색항목">
							<option value="20">멤버스번호</option>
							<option value="20">포털ID</option>
							<option value="20">휴대폰번호</option>
							<option value="50">회원명</option>
						</select>
					    <input type="text" id="search_name" name="search_name" onkeypress="excuteEnter(reSelect)" placeholder="검색어를 입력하세요.">
					    <input class="search-btn" type="button" value="검색" onclick="reSelect()">
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
			<div class="table float-right sel-scr">
				<div>
					<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a>
					<select id="listSize" name="listSize" onchange="reSelect()" de-data="10개 보기">
						<option value="20">10개 보기</option>
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
<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="280px">
				<col>
				<col width="280px">
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
					</th>
					<th onclick="reSort('sort_cus_no')">멤버스번호 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_ptl_id')">포털ID <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_kor_nm')">회원명 <i class="material-icons">import_export</i></th>
<!-- 					<th onclick="reSort('sort_seq_no')">기수 <i class="material-icons">import_export</i></th> -->
					<th onclick="reSort('sort_prev_subject_cd')">기존강좌코드 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_prev_subject_nm')">기존강좌명 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_next_subject_cd')">이강강좌코드 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_next_subject_nm')">이강신청 강좌명 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_create_date')">이강완료일 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_name')">담당자 <i class="material-icons">import_export</i></th>	
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table>
			<colgroup>
				<col width="60px">
				<col>
				<col>
				<col>
				<col>
				<col width="280px">
				<col>
				<col width="280px">
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="idxAll" name="idx" value="idxAll"><label for="idxAll"></label>
					</th>
					<th onclick="reSort('sort_cus_no')">멤버스번호 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_ptl_id')">포털ID <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_kor_nm')">회원명 <i class="material-icons">import_export</i></th>
<!-- 					<th onclick="reSort('sort_seq_no')">기수 <i class="material-icons">import_export</i></th> -->
					<th onclick="reSort('sort_prev_subject_cd')">기존강좌코드 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_prev_subject_nm')">기존강좌명 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_next_subject_cd')">이강강좌코드 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_next_subject_nm')">이강신청 강좌명 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_create_date')">이강완료일 <i class="material-icons">import_export</i></th>
					<th onclick="reSort('sort_name')">담당자 <i class="material-icons">import_export</i></th>	
				</tr>
			</thead>
			<tbody>
				<c:forEach var="i" items="${list}" varStatus="loop">
					<tr>
						<td class="td-chk">
							<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label>
						</td>
						<td>${i.CUS_NO}</td>
						<td>${i.PTL_ID}</td>
						<td>${i.KOR_NM}</td>
						<td>${i.PREV_SUBJECT_CD}</td>
						<td>${i.PREV_SUBJECT_NM}</td>
						<td>${i.NEXT_SUBJECT_CD}</td>
						<td>${i.NEXT_SUBJECT_NM}</td>
						<td>${fn:substring(i.CREATE_DATE, 0, 4)}-${fn:substring(i.CREATE_DATE, 4, 6)}-${fn:substring(i.CREATE_DATE, 6, 8)}</td>
						<td>${i.NAME}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
</div>

<jsp:include page="/WEB-INF/pages/common/paging.jsp"/>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>