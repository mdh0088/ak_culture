<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
//파일관련
$("#voc_file").change(function(e){
	var get_file = document.getElementById("voc_file");
	var get_size = 0;
	var max_size = 5 * 1024 * 1024;//5MB
	if ('files' in get_file) {
		//파일수 체크
	    if (get_file.files.length > 5) {
	        alert("파일은 5개까지 등록 가능합니다.");
	        document.getElementById("voc_file").value = "";
	        return;
	    }
	    //파일용량 체크
	    for(var i = 0; i < get_file.files.length; i++){
			get_size += get_file.files[i].size;
	    }
		if(get_size > max_size){
			alert("파일용량이 5MB를 초과하였습니다");
			document.getElementById("voc_file").value = "";
			return;
		}
	}
});

function confirm()
{
	$('#confirm_layer').fadeIn(200);	
}
function companion()
{
	$('#companion_layer').fadeIn(200);	
}
function confirm02()
{
	$('#confirm_layer02').fadeIn(200);	
}
function confirm03()
{
	$('#confirm_layer03').fadeIn(200);	
}
function fncSubmit(){
	var container = document.getElementById("return_reason");
	if(container.value == ""){
		alert("반려사유를 입력해주세요.");
		container.focus();
		return false;
	}
};
//전체 체크박스
function checked_all(data){
	if(data.previousSibling.checked){
		data.previousSibling.checked = false;
	}else if(!data.previousSibling.checked){
		data.previousSibling.checked = true;
	}
	var chk_checked = data.previousSibling.checked;
	var idx_arr = document.querySelectorAll("input[name*='idx']");
	if(chk_checked == true){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = true;
		}
	}else if(chk_checked == false){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = false;
		}
	}
}
//부분 체크박스
function checked_part(data){
	if(data.previousSibling.checked){
		data.previousSibling.checked = false;
	}else if(!data.previousSibling.checked){
		data.previousSibling.checked = true;
	}
	var chk_checked = data.previousSibling.checked;
	var idx_arr = document.querySelectorAll("input[name*='idx"+data.dataset.val+"']");
	if(chk_checked == true){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = true;
		}
	}else if(chk_checked == false){
		for(var i = 0; i < idx_arr.length; i++){
			idx_arr[i].checked = false;
		}
	}
}
//단일 체크박스
function checked_one(data){
	var $this = data.previousSibling;
	var chk_checked = $this.checked;
	if(chk_checked == true){
		$this.checked = false;
	}else if(chk_checked == false){
		$this.checked = true;
	}
}
</script>

<div class="sub-tit">
	<h2>거래선 결재</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<!-- <div class="btn-right">
		<a class="btn btn02">승인</a>
		<a class="btn btn01" onclick="javascript:companion();">반려</a>
	</div>
	 -->
</div>


<div class="table-cap table" style="margin-top:50px;">
	<div class="cap-l">
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		
		<div class="table table02 table-auto float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 mrg-l6" href="#"><i class="fas fa-file-download"></i></a>
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

<div class="table-wr ip-list">
	
	<div class="table-list">
		<table>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="checkAll"><label onclick="checked_all(this);"></label>
					</th>
					<th>강사명<i class="material-icons">import_export</i></th>
					<th>연락처<i class="material-icons">import_export</i></th>
					<th>주민등록번호<i class="material-icons">import_export</i></th>
					<th>주소<i class="material-icons">import_export</i></th>
					<th>사업자번호<i class="material-icons">import_export</i></th>
					<th>개인/법인<i class="material-icons">import_export</i></th>
					<th>사업자명<i class="material-icons">import_export</i></th>
					<th>입금은행<i class="material-icons">import_export</i></th>
					<th>예금주<i class="material-icons">import_export</i></th>
					<th>계좌번호<i class="material-icons">import_export</i></th>
					<th>상태<i class="material-icons">import_export</i></th>		
				</tr>
			</thead>
			<tbody>
				<tr>			
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
					</td>
					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td>
					<td>010-2352-6985</td>
					<td>851230-206321</td>
					<td>(53026)서울시 강동구 성안로 156</td>
					<td>851230-206321</td>
					<td>법인</td>
					<td>김정인</td>
					<td>국민</td>
					<td>김태연</td>
					<td>0234164512354</td>	
					<td class="color-blue line-blue" onclick="javascript:confirm02()">승인</td>			
				</tr>
				<tr>			
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
					</td>
					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td>
					<td>010-2352-6985</td>
					<td>851230-206321</td>
					<td>(53026)서울시 강동구 성안로 156</td>
					<td>851230-206321</td>
					<td>법인</td>
					<td>김정인</td>
					<td>국민</td>
					<td>김태연</td>
					<td>0234164512354</td>	
					<td class="red-line" style="cursor:pointer;" onclick="javascript:confirm()">미승인</td>				
				</tr>
				<tr>			
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
					</td>
					<td class="color-blue line-blue" onclick="location.href='/lecture/lecr/listed'" style="cursor:pointer;">김태연</td>
					<td>010-2352-6985</td>
					<td>851230-206321</td>
					<td>(53026)서울시 강동구 성안로 156</td>
					<td>851230-206321</td>
					<td>법인</td>
					<td>김정인</td>
					<td>국민</td>
					<td>김태연</td>
					<td>0234164512354</td>		
					<td class="color-blue line-blue" onclick="javascript:confirm03()">반려</td>			
				</tr>
			</tbody>
		</table>
	</div>
	
</div>



<div id="confirm_layer" class="trans-conf list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
	       	<div class="list-edit white-bg">
	       		<div class="close" onclick="javascript:$('#confirm_layer').fadeOut(200);">
	     			닫기<i class="far fa-window-close"></i>
	     		</div>
	     		<div>
	     			<h3 class="text-center">결재관련 사항 확인</h3>					
	     		</div>
	     		
	     		<div class="ak-wrap_new">
				
					<div class="table-list mem-manage trans-list">			
						<div class="top-row sear-wr">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">제목</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="제목을 입력하세요.">
									</div>
								</div>
							</div>	
						</div>
						
						<div class="top-row sear-wr">	
					
							<div class="wid-4">
								<div class="table">
									<div class="sear-tit">결재자</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="이름을 입력하세요.">
									</div>
								
								</div>
							</div>
							<div class="wid-6">
								<div class="table">
									<div class="sear-tit sear-tit_left">결재경로</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="경로를 입력하세요.">
									</div>
								
								</div>
							</div>
					
						</div>	
						<br>
						<div class="trans-wrap">
							<div class="row">
								<div class="wid-5">
									<div class="bor-div">
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">성명(한글)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="정상임">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">성명(영문)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="Jungsangim">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">휴대폰</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="010-5623-5612">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">주민등록번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="912365-203625">
													</div>
												</div>
											</div>
										</div>						
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">주소</div>
													<div class="table-mem">
														<div class="input-wid2">
															<input type="text" id="cus_address_1" name="cus_address_1" class="inputDisabled inp-30" placeholder="53026">
															<input type="text" id="cus_address_2" name="cus_address_2" class="inputDisabled inp-70" placeholder="서울시 강동구 성안로 156">
														</div>
														<div>
															<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" placeholder="우주빌딩 503호, 902호">
														</div>
													</div>
												</div>
											</div>									
										</div>	
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">첨부파일</div>
													<div class="file-wrap">
														<div class="filebox"> 																	
															<span class="wpcf7-form-control-wrap">
																<span><input type="file" id="voc_file" name="voc_file[]" multiple></span>
															</span>
														</div>
													</div>
												</div>
											</div>
										</div>
														
									</div>
								</div>
								
								
								<div class="wid-5 wid-5_last">
									<div class="bor-div">
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">사업자번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="956231563-623115962">
													</div>
												</div>
											</div>									
										</div>		
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">법인 구분</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="법인">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">사업자명</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">입금은행</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="국민은행">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">예금주</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">계좌번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="12365312-56313020">
													</div>
												</div>
											</div>									
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">반려사유</div>
													<div>
														<input type="text" class="inp-100" id="return_reason" placeholder="">
													</div>
												</div>
											</div>									
										</div>
										
									</div>
									
									
								</div>
							</div>
							
						
						</div> <!-- trans-wrap end -->
						
						
						
						<div class="text-center">
							<a class="btn btn02">승인</a>
							<a class="btn btn01" onclick="javascript:fncSubmit();">반려</a>
						</div>
				
					</div>
				</div>
	     		
	     	</div>
	     </div>
	</div>
</div>



<div id="confirm_layer02" class="trans-conf list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
	       	<div class="list-edit white-bg">
	       		<div class="close" onclick="javascript:$('#confirm_layer02').fadeOut(200);">
	     			닫기<i class="far fa-window-close"></i>
	     		</div>
	     		<div>
	     			<h3 class="text-center">결재관련 사항 확인</h3>					
	     		</div>
	     		
	     		<div class="ak-wrap_new">
				
					<div class="table-list mem-manage trans-list">			
						<div class="top-row sear-wr">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">제목</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="제목을 입력하세요.">
									</div>
								</div>
							</div>	
						</div>
						
						<div class="top-row sear-wr">	
					
							<div class="wid-4">
								<div class="table">
									<div class="sear-tit">결재자</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="이름을 입력하세요.">
									</div>
								
								</div>
							</div>
							<div class="wid-6">
								<div class="table">
									<div class="sear-tit sear-tit_left">결재경로</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="경로를 입력하세요.">
									</div>
								
								</div>
							</div>
					
						</div>	
						<br>
						
						<div class="trans-wrap">
							<div class="row">
								<div class="wid-5">
									<div class="bor-div">
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">성명(한글)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="정상임">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">성명(영문)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="Jungsangim">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">휴대폰</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="010-5623-5612">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">주민등록번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="912365-203625">
													</div>
												</div>
											</div>
										</div>						
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">주소</div>
													<div class="table-mem">
														<div class="input-wid2">
															<input type="text" id="cus_address_1" name="cus_address_1" class="inputDisabled inp-30" placeholder="53026">
															<input type="text" id="cus_address_2" name="cus_address_2" class="inputDisabled inp-70" placeholder="서울시 강동구 성안로 156">
														</div>
														<div>
															<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" placeholder="우주빌딩 503호, 902호">
														</div>
													</div>
												</div>
											</div>									
										</div>	
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">첨부파일</div>
													<div class="file-wrap">
														<div class="filebox"> 																	
															<span class="wpcf7-form-control-wrap">
																<span><input type="file" id="voc_file" name="voc_file[]" multiple></span>
															</span>
														</div>
													</div>
												</div>
											</div>
										</div>
														
									</div>
								</div>
								
								
								<div class="wid-5 wid-5_last">
									<div class="bor-div">
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">사업자번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="956231563-623115962">
													</div>
												</div>
											</div>									
										</div>		
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">법인 구분</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="법인">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">사업자명</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">입금은행</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="국민은행">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">예금주</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">계좌번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="12365312-56313020">
													</div>
												</div>
											</div>									
										</div>
										
									</div>
									
									
								</div>
							</div>
							
						
						</div> <!-- trans-wrap end -->
						
						
						
						<div class="text-center">
							<a class="btn btn02">확인</a>
						</div>
				
					</div>
				</div>
	     		
	     	</div>
	     </div>
	</div>
</div>

<div id="confirm_layer03" class="trans-conf list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
	       	<div class="list-edit white-bg">
	       		<div class="close" onclick="javascript:$('#confirm_layer03').fadeOut(200);">
	     			닫기<i class="far fa-window-close"></i>
	     		</div>
	     		<div>
	     			<h3 class="text-center">결재관련 사항 확인</h3>					
	     		</div>
	     		
	     		<div class="ak-wrap_new">
				
					<div class="table-list mem-manage trans-list">		
						<div class="top-row sear-wr">
							<div class="wid-10">
								<div class="table">
									<div class="sear-tit">제목</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="제목을 입력하세요.">
									</div>
								</div>
							</div>	
						</div>
						
						<div class="top-row sear-wr">	
					
							<div class="wid-4">
								<div class="table">
									<div class="sear-tit">결재자</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="이름을 입력하세요.">
									</div>
								
								</div>
							</div>
							<div class="wid-6">
								<div class="table">
									<div class="sear-tit sear-tit_left">결재경로</div>
									<div>
										<input type="text" class="inp-100 inputDisabled" placeholder="경로를 입력하세요.">
									</div>
								
								</div>
							</div>
					
						</div>	
						<br>	
						
						<div class="trans-wrap">
							<div class="row">
								<div class="wid-5">
									<div class="bor-div">
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">성명(한글)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="정상임">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">성명(영문)</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="Jungsangim">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">휴대폰</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="010-5623-5612">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">주민등록번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="912365-203625">
													</div>
												</div>
											</div>
										</div>						
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">주소</div>
													<div class="table-mem">
														<div class="input-wid2">
															<input type="text" id="cus_address_1" name="cus_address_1" class="inputDisabled inp-30" placeholder="53026">
															<input type="text" id="cus_address_2" name="cus_address_2" class="inputDisabled inp-70" placeholder="서울시 강동구 성안로 156">
														</div>
														<div>
															<input type="text" id="cus_address_3" name="cus_address_3" class="inputDisabled inp-100" placeholder="우주빌딩 503호, 902호">
														</div>
													</div>
												</div>
											</div>									
										</div>	
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit sear-tit-top">첨부파일</div>
													<div class="file-wrap">
														<div class="filebox"> 																	
															<span class="wpcf7-form-control-wrap">
																<span><input type="file" id="voc_file" name="voc_file[]" multiple></span>
															</span>
														</div>
													</div>
												</div>
											</div>
										</div>
														
									</div>
								</div>
								
								
								<div class="wid-5 wid-5_last">
									<div class="bor-div">
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">사업자번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="956231563-623115962">
													</div>
												</div>
											</div>									
										</div>		
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">법인 구분</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="법인">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">사업자명</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row table-input">
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit">입금은행</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="국민은행">
													</div>
												</div>
											</div>
											<div class="wid-5">
												<div class="table">
													<div class="sear-tit sear-tit_120 sear-tit_left">예금주</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="이호걸">
													</div>
												</div>
											</div>
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">계좌번호</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="12365312-56313020">
													</div>
												</div>
											</div>									
										</div>
										
										<div class="top-row">
											<div class="wid-10">
												<div class="table">
													<div class="sear-tit">반려사유</div>
													<div>
														<input type="text" class="inputDisabled inp-100" placeholder="강사료 기준에 대한 변경사항 적용 필요로 인해 반려함.">
													</div>
												</div>
											</div>									
										</div>
										
									</div>
									
									
								</div>
							</div>
							
						
						</div> <!-- trans-wrap end -->
						
						
						
						<div class="text-center">
							<a class="btn btn02">확인</a>
						</div>
				
					</div>
				</div>
	     		
	     	</div>
	     </div>
	</div>
</div>




<div id="companion_layer" class="trans-conf list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
	       	<div class="list-edit white-bg">
	       		<div class="close" onclick="javascript:$('#companion_layer').fadeOut(200);">
	     			닫기<i class="far fa-window-close"></i>
	     		</div>
	     		<div>
	     			<h3 class="text-center">반려 사유</h3>					
	     		</div>
	     		
	     		<div class="companion-box">
	     			강사료 기준에 대한 변경사항 적용 필요로 인해 반려함.
	     		</div>
	     		<div class="text-center">
					<a class="btn btn02">반려</a>
				</div>
	     	</div>
	     	
	     </div>
	</div>
</div>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>