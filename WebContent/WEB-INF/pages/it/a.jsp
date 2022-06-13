<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>


<div class="sub-tit">
	<h2>수강관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<a class="btn btn01 ok-btn" onclick="pageReset()">초기화</a>
		<A class="btn btn01 btn01_1" href="write">고객정보입력 </A>
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
						<div class="sear-tit sear-tit_oddn"><i class="material-icons">insert_link</i></div>
						<div class="oddn-sel02">
							<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="top-row">
		
		<div class="wid-45 ">
			<div class="table">
				<div class="search-wr">
					<select id="searchType" name="searchType" de-data="검색항목">
						<option value="card">카드번호</option>
						<option value="members">멤버스번호</option>
						<option value="phone">휴대폰(뒷자리 4자리)</option>
						<option value="tel">전화번호</option>
					</select>
					<input type="hidden" id="page" name="page" value="${page}">
				    <input type="text" id="search_name" name="search_name" onkeypress="excuteEnter(reSelect)" placeholder="검색어를 입력하세요.">
				    <input class="search-btn" type="button" value="검색" onclick="reSelect()">
					<input type="hidden" id="order_by" name="order_by" value="${order_by}">
				    <input type="hidden" id="sort_type" name="sort_type" value="${sort_type}">
				</div>
			</div>
		</div>	
		<div class="wid-3 mag-lr2">
			<div class="table">
				<div>
					<div class="table">
						<div class="sear-tit sear-tit_120 sear-tit_left">회원명</div>
						<div>
							<input type="text" id="user_name" name="user_name" />
						</div>
					</div>
				</div>
				
			</div>
		</div>
		<div class="wid-2">
			<div class="table table-input">
				<div class="sear-tit sear-tit_left">생일</div>
				<div>
					<input type="text" id="birth" name="birth" placeholder="YYYY/MM/DD"/>
				</div>
			</div>
		</div>
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="userSearch()">
</div>