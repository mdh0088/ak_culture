<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<script>
//closest polyfill START
if (!Element.prototype.matches) {
	Element.prototype.matches = Element.prototype.msMatchesSelector || 
								Element.prototype.webkitMatchesSelector;
}
if (!Element.prototype.closest) {
	Element.prototype.closest = function(s) {
	var el = this;
	
	do {
		if (Element.prototype.matches.call(el, s)) return el;
		el = el.parentElement || el.parentNode;
	} while (el !== null && el.nodeType === 1);
		return null;
	};
}
//closest polyfill END
$(function(){
	$(".depermi-btn").click(function(){
		$(".depermi-list").show();
	})
	$(".master-btn").click(function(){
		$(".master-edit").show();
	})
	$(".cancle-btn").click(function(){
		$(".master-edit").hide();
	})
})

function fncSubmitAuth()
{
	var fnc_data = document.getElementById("auth_tb").querySelectorAll("select");
	var data_length = document.getElementById("auth_tb").querySelectorAll("tbody .parm input[type=checkbox]:checked").length;
	var level_name = document.getElementById("auth_level_name").value;
	if(level_name == ""){
		alert("먼저 운영자를 선택하세요.");
		return false;
	}
	if(data_length == 0 ){
		alert("선택된 자료가 없습니다");
		return false;
	}
	var msg = "";
	$(fnc_data).each(function(currentIndex, currentValue){
		if(!loopStat){
			return false;
		}
		var chk_checked = currentValue.parentElement.parentElement.parentElement.querySelector("input[type=checkbox]").checked;
		var auth_uri = currentValue.dataset.addr;
		var auth_key = currentValue.value;
		if(chk_checked && nullChk(auth_uri) != ""){
	 		$.ajax({
				data: {
					level_name: level_name,
					auth_uri: auth_uri,
					auth_key: auth_key,
					auth_chk: "Y"
				},
				type: "POST",
				url: "./levelProc",
				success: function(data)
				{
		    		if(data.isSuc == "success")
		    		{
						if(currentIndex == fnc_data.length-1)
						{
				   			alert("저장되었습니다.");
						}
		    		}
		    		else
		    		{
		    			alert("저장중 오류가 발생하였습니다.");
		    			return false;
		    		}
				}
			});
		}
	});
	alert("저장되었습니다.");
}
function fncSubmit(){
	var name = document.getElementById("level_name").value;
	if(name == ""){
		alert("운영자 명칭을 작성해주세요.");
		document.getElementById("level_name").focus();
		return false;
	}
	$.ajax({
		data:{
			level_name: name,
			auth_chk: "Y"
		},
		type: "POST",
		url: "./levelIns",
		success: function(data)
		{
			alert(data.msg);
			if(data.isSuc == "success"){
				location.reload();
			}
		}
	});
}
//수정버튼
var prev_level_name = "";
var edit_on_dup = 0;
function edit_on(el){
	var status = el.innerText;
	if(status == "수정"){
		if(edit_on_dup > 0){
			alert("수정이 완료되지 않은 목록이 존재합니다. \n수정을 완료해 주세요.");
			return false;
		}
		prev_level_name = el.parentElement.parentElement.querySelector(".txt span").innerText;
		var input = document.createElement("input");
		input.type = "text";
		input.name = "up_level_name";
		input.value = prev_level_name;
		el.innerText = "완료";
		el.parentElement.parentElement.querySelector(".txt span").innerHTML = "";
		el.parentElement.parentElement.querySelector(".txt span").appendChild(input);
		edit_on_dup = 1;
	}else if(status == "완료"){
		var up_level_name = document.getElementsByName("up_level_name")[0].value;
		$.ajax({
			data:{
				level_name: prev_level_name,
				up_level_name: up_level_name,
				auth_chk: "Y"
			},
			type: "POST",
			url: "./levelEdit",
			success: function(data){
				if(data.isSuc == "fail"){
					alert(data.msg);
					document.getElementsByName("up_level_name")[0].value = prev_level_name;
				}else{
					alert(data.msg);
					var container = document.querySelector("#auth_level_name");
					var target_li = Array.prototype.slice.call(container.parentElement.querySelectorAll(".select-ul li")).filter(function(li){
						return li.textContent == prev_level_name;
					})[0];
					target_li.textContent = up_level_name;
					var target_option = Array.prototype.slice.call(container.options).filter(function(option){
						return option.textContent == prev_level_name;
					})[0];
					target_option.value = up_level_name;
					target_option.textContent = up_level_name;
					el.innerText = "수정";
					el.parentElement.parentElement.querySelector(".txt span").innerText = up_level_name;
				}
			}
		});
		edit_on_dup = 0;
	}
}
//삭제버튼
function lvl_del(el, option){
	var txt = el.parentElement.parentElement.querySelector(".txt span").textContent;
	if(option > 0){
		alert("사용중인 권한은 삭제 할 수 없습니다.");
		return false;
	}
	if(confirm("정말 삭제하시겠습니까?")){
		$.ajax({
			data:{
				level_name: txt,
				auth_chk: "Y"
			},
			type: "POST",
			url: "./levelDel",
			success: function(data){
				alert(data.msg);
				location.reload();
			}
		});
	}
}
//체크한 부분만 변환
function checked_option(el){
	var fnc_data = document.getElementById("auth_tb").querySelectorAll("tbody select");
	var data_length = document.getElementById("auth_tb").querySelectorAll("tbody .parm input[type=checkbox]:checked").length;
	if(data_length == 0 ){
		alert("선택된 자료가 없습니다");
		return false;
	}
	$(fnc_data).each(function(currentIndex, currentValue){
		var chk_checked = currentValue.parentElement.parentElement.parentElement.querySelector("input[type=checkbox]").checked;
		if(chk_checked){
			currentValue.value = el.value;
			Array.prototype.slice.call(currentValue.options).filter(function(option){
				return option.value == el.value;
			})[0].setAttribute("selected", "selected");
			currentValue.parentElement.querySelector(".selectedOption").textContent = el.options[el.selectedIndex].text;
		}
	});
	el.parentElement.querySelector(".selectedOption").textContent = "권한선택";
	chk_color();
}
</script>

<div class="sub-tit">
	<h2>등급별 권한 설정</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<A class="btn btn01 btn01_1" href="../user/log">운영자 로그관리 </A>
	</div>
</div>
<div class="row view-page">
	
	<div class="wid-5">
		<div class="white-bg table-view">
			<h3>권한설정</h3>
			<div class="table table_mars mar20">
				<div class="sel-arr">
					<select id="auth_level_name" de-data="운영자 선택" onchange="getCheck(this.value);">
							<option value="">운영자 선택</option>
							<option value="기본값">기본값</option>
						<c:forEach var="i" items="${cate }"> 
							<option value="${i.NAME}">${i.NAME}</option>
						</c:forEach>
					</select>
					<A class="bor-btn btn03 master-btn">운영자 추가/편집</A>
				</div>
				<div class="sel-arr btn-right">
					<select de-data="권한선택" onchange="checked_option(this);">
						<option value="RW">전체</option>
						<option value="R">보기</option>
						<option value="">접근불가</option>
					</select>
					
				</div>
			</div>
			
			<div class="table-wr table-wr02">
				<div class="table-cap table">
					<div class="table-list table-list02 table-ak">
						<!-- <table id="auth_tb">
							<thead>
								<tr>
									<th class="td-chk">
										<input type="checkbox" id="checkAll"><label onclick="checked_all(this);"></label>
									</th>
									<th>메뉴명</th>
									<th>권한설정</th> 
								</tr>
							</thead>
							<tbody>
								<tr class="toggle-t">
									<td class="td-chk">
										<input type="checkbox" name="idx1"><label data-val="1" onclick="checked_part(this);"></label>
									</td>
								   	<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 기본관리</td>
								   	<td class="perm-sel">
										<select name="temp_1" de-data="전체" onchange="chk_part_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr class="toggle-o parm">
									<td colspan="3">
										<Table>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">운영자 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/user" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">IP 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/ip" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">POS 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/pos" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">코드 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/code" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">기수 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/peri" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">주차 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/park" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">사은품 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/gift" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">할인 관리</td>
											   	<td class="perm-sel">
													<select name="temp_1" de-data="전체" data-addr="/basic/encd" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
										</Table>
									</td>
								</tr>
							</tbody>
							<tbody>
								<tr class="toggle-t parm">
									<td class="td-chk">
										<input type="checkbox" name="idx2"><label data-val="2" onclick="checked_one(this);"></label>
									</td>
								   	<td class="tog-tit">강사관리</td>
								   	<td class="perm-sel">
										<select name="temp_2" de-data="전체" data-addr="/lecture/lecr" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</tbody>
							<tbody>
								<tr class="toggle-t parm">
									<td class="td-chk">
										<input type="checkbox" name="idx3"><label data-val="3" onclick="checked_one(this);"></label>
									</td>
								   	<td class="tog-tit">강좌관리</td>
								   	<td class="perm-sel">
										<select name="temp_3" de-data="전체" data-addr="/lecture/lect" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</tbody>
							<tbody>
								<tr class="toggle-t">
									<td class="td-chk">
										<input type="checkbox" name="idx4"><label data-val="4" onclick="checked_part(this);"></label>
									</td>
								   	<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 수강/회원관리</td>
								   	<td class="perm-sel">
										<select name="temp_4" de-data="전체" onchange="chk_part_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr class="toggle-o parm">
									<td colspan="3">
										<Table>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx4"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">회원 관리</td>
											   	<td class="perm-sel">
													<select name="temp_4" de-data="전체" data-addr="/member/cust" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx4"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">수강 관리</td>
											   	<td class="perm-sel">
													<select name="temp_4" de-data="전체" data-addr="/member/lect" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx4"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">대기자 관리</td>
											   	<td class="perm-sel">
													<select name="temp_4" de-data="전체" data-addr="/member/wait" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx4"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">이강 관리</td>
											   	<td class="perm-sel">
													<select name="temp_4" de-data="전체" data-addr="/member/relo" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
											<tr>
												<td class="td-chk">
													<input type="checkbox" name="idx4"><label onclick="checked_one(this);"></label>
												</td>
											   	<td class="tog-otit">SMS/TM</td>
											   	<td class="perm-sel">
													<select name="temp_4" de-data="전체" data-addr="/member/sms" onchange="chk_one_option(this);">
														<option value="RW">전체</option>
														<option value="R">보기</option>
														<option value="">접근불가</option>
													</select>
											   	</td>
											</tr>
										</Table>
									</td>
								</tr>
							</tbody>
							<tbody>
								<tr class="toggle-t parm">
									<td class="td-chk">
										<input type="checkbox" name="idx5"><label data-val="5" onclick="checked_one(this);"></label>
									</td>
								   	<td class="tog-tit">매출/마감관리</td>
								   	<td class="perm-sel">
										<select name="temp_5" de-data="전체" data-addr="/trms/trms" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</tbody>
							<tbody>
								<tr class="toggle-t parm">
									<td class="td-chk">
										<input type="checkbox" name="idx6"><label data-val="6" onclick="checked_one(this);"></label>
									</td>
								   	<td class="tog-tit">정산관리</td>
								   	<td class="perm-sel">
										<select name="temp_6" de-data="전체" data-addr="/it" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</tbody>
						</table> -->
						<jsp:include page="./authTB.jsp"/>
					</div>
				</div>
			</div> <!-- //table-wr -->
			<div class="btn-wr text-center">
				<a class="btn btn01 btn01_1" href="/basic/user/list"><i class="material-icons">menu</i>목록</a>
				<a class="btn btn02 ok-btn icon-r" onclick="fncSubmitAuth();">반영</a>
			</div>
		</div> <!-- //white-bg -->
	</div> <!-- //wid-5 -->
	
	
	<div class="wid-5">
		<div class="white-bg table-view master-edit">
			<h3 class="h3-tit">운영자 추가</h3>
			<div class="table-wr">
				<div class="table-list table-list02">
					<ul class="master-ul">
						<c:forEach var="i" items="${cate}">
							<li>
								<div class="txt"><span>${i.NAME}</span> ${i.CNT}명 사용중</div>
								<div class="edit-btn">
									<a class="btn btn02" onclick="edit_on(this);">수정</a>
									<a class="btn btn03" onclick="lvl_del(this, '${i.CNT}')">삭제</a>
								</div>
							</li>
						</c:forEach>
						<li class="edit-active">
							<input type="text" id="level_name" value="" class="inp-100" placeholder="운영자 명칭을 작성해주세요.">
						</li>
					</ul>
				</div>				
			</div>
			
			<div class="btn-wr text-center">
				<a class="btn btn01 ok-btn cancle-btn">닫기</a>
				<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();">저장</a>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	
	
</div><!-- //row -->
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>