<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
$(function(){
	$(".tog-tit").click(function(){
		var $this = $(this).parent();
		var chk = $this.next().css("display");
		if(chk == "none"){
			$this.addClass("toggle-on");
		}else{
			$this.removeClass("toggle-on");
		}
		$this.next().slideToggle();
	}) 
})
$(function(){
	$(".tog-otit").click(function(){
		if(this.querySelectorAll(".material-icons").length > 0){
			var $this = $(this).parent();
			var chk = $this.next().css("display");
			if(chk == "none"){
				$this.addClass("toggle-on2");
			}else{
				$this.removeClass("toggle-on2");
			}
			$this.next().slideToggle();
		}
	}) 
})
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
//셀렉트박스
function chk_part_option(data){
	var cont_text = data.closest("tr").nextElementSibling.querySelectorAll(".selectedOption");
	var text = data.options[data.selectedIndex].textContent;
	var cont_val = data.closest("tr").nextElementSibling.querySelectorAll("select[name='"+data.name+"']");
	if(data.name.indexOf('-') === -1){
		cont_val = data.closest("tr").nextElementSibling.querySelectorAll("select[name*='"+data.name+"']");
	}
	var val = data.value;
	for(i = 0; i < cont_text.length; i++){
		cont_text[i].textContent = text;
		cont_val[i].value = val;
	}
	chk_color();
}
function chk_one_option(data){
	chk_color();
}
//셀렉트박스 색 변경
function chk_color(){
	chk_custom();
	var data_arr = $("select[name*=temp]");
	for(var i = 0, length = data_arr.length; i < length; i++){
		var container = $(data_arr[i]).parent().parent();
		container.removeClass("sel-red sel-blue");
		if(data_arr[i].parentElement.querySelector(".selectedOption").textContent != "사용자 정의"){
			switch($(data_arr[i]).parent().find(".selectedOption").text()){
				case '전체':
					break;
				case '보기':
					container.addClass("sel-red");
					break;
				case '접근불가':
					container.addClass("sel-blue");
					break;
				default:
					break;
			}
		}
	}
}
//사용자 정의 체크
function chk_custom(){
	var contFunc = function(container){
		if(container.length > 1){
			var val_arr = [];
			for(var n = 1, length = container.length; n < length; n++){
				if(nullChk(container[n].dataset.addr) != ""){
					val_arr.push(container[n].options[container[n].selectedIndex].text);
				}
			}
			var dup_cnt = val_arr.filter(function(item, idx, array){
				return array.indexOf( item ) === idx ;
			}).length;
			var text = "";
			if(dup_cnt == 1){	//모두 같을때
				text = val_arr[0];
				Array.prototype.slice.call(container[0].parentElement.querySelectorAll("select option")).filter(function(el){
					return el.textContent == text;
				})[0].setAttribute("selected", "selected");
			}else{				//같지 않은게 하나라도 있을경우
				text = "사용자 정의";
				container[0].value = "RW";
			}
			container[0].parentElement.querySelector(".selectedOption").textContent = text;
		}
	}
	
	var data_arr = document.querySelectorAll("#auth_tb select[name*=temp]");
	var num_arr = [];
	for(var i = 0, length = data_arr.length; i < length; i++){
		num_arr.push(parseInt(data_arr[i].name.split("_")[1]));
	}
	num_arr.sort(function(a, b){
		return b - a;
	});
	var fir_cnt = num_arr[0];	//select 카테고리 개수
	for(var i = 1; i < fir_cnt+1; i++){
		var sec_cnt = document.querySelectorAll("#auth_tb select[name*='temp_"+i+"-']").length;
		if(sec_cnt > 0){
			for(var n = 0; n < sec_cnt; n++){
				contFunc(document.querySelectorAll("#auth_tb select[name*='temp_"+i+"-"+n+"']"));
			}
		}
		contFunc(document.querySelectorAll("#auth_tb select[name*='temp_"+i+"']"));
	}
}
//권한 불러오기
function getCheck(name){
	if(typeof auth_name != "undefined"){
		auth_name = name;
	}
	var cont = $("#select[name*=temp]");
	for(var i = 0; i < cont.length; i++){
		cont[i].parent().parent().removeClass("sel-red sel-blue");
	}
	$.ajax({
		data:{
			level_name: name
		},
		type: "POST",
		url: "./levelGet",
		success: function(data)
		{
			for(var i = 0; i < data.length; i++){
				var item = data[i];
				var container = document.querySelector("[data-addr='"+item.AUTH_URI+"']");
				if(container != null){
					if(nullChk(item.AUTH_KEY) != ""){
						container.value = item.AUTH_KEY;
						var text = container.querySelector("option[value='"+item.AUTH_KEY+"']").innerText;
					}else{
						container.value = "";
						var text = "접근불가";
					}
					Array.prototype.slice.call(container).filter(function(el){
						return el.textContent === text;
					})[0].setAttribute("selected", "selected");
					container.parentElement.querySelector(".selectedOption").innerText = text;
				}
			}
			var target = document.querySelectorAll("#auth_tb input[type=checkbox]");
			for(var i = 0; i < target.length; i++){
				if(!target[i].checked){
					checked_all(target[i].nextSibling);
					break;
				}
			}
			chk_color();
		}
	});
}
//초기화
function resetAuth(){
	var auth_cont = document.querySelectorAll("#auth_tb tbody .select-box");
	for(var i = 0; i < auth_cont.length; i++){
		auth_cont[i].querySelector("select").value = "RW";
		auth_cont[i].querySelector(".selectedOption").textContent = "전체";
	}
}
</script>




<table id="auth_tb">
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
							<input type="checkbox" name="idx1-1"><label data-val="1-1" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div>운영자 관리</td>
					   	<td class="perm-sel">
							<select name="temp_1-1" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 운영자 관리 -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx1-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">운영자 리스트</td>
								   	<td class="perm-sel">
										<select name="temp_1-1" de-data="전체" data-addr="/basic/user/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx1-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="tog-otit">IP 관리</td>
								   	<td class="perm-sel">
										<select name="temp_1-1" de-data="전체" data-addr="/basic/ip/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx1-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="tog-otit">POS 관리</td>
								   	<td class="perm-sel">
										<select name="temp_1-1" de-data="전체" data-addr="/basic/pos/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 운영자 관리 -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx1"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">기수 관리</td>
					   	<td class="perm-sel">
							<select name="temp_1" de-data="전체" data-addr="/basic/peri/list" onchange="chk_one_option(this);">
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
							<select name="temp_1" de-data="전체" data-addr="/basic/park/list" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx1-2"><label data-val="1-2" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div>사은품 관리</td>
					   	<td class="perm-sel">
							<select name="temp_1-2" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 사은품 관리 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx1-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">사은품 리스트</td>
								   	<td class="perm-sel">
										<select name="temp_1-2" de-data="전체" data-addr="/basic/gift/listed" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx1-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">사은품 지급내역</td>
								   	<td class="perm-sel">
										<select name="temp_1-2" de-data="전체" data-addr="/basic/gift/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
							</table>
						</td>
					</tr>
					<!-- 사은품 관리 END -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx1-3"><label data-val="1-3" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div>할인 관리</td>
					   	<td class="perm-sel">
							<select name="temp_1-3" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 할인 관리 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx1-3"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">할인코드 리스트</td>
								   	<td class="perm-sel">
										<select name="temp_1-3" de-data="전체" data-addr="/basic/encd/listed" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx1-3"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">할인 내역</td>
								   	<td class="perm-sel">
										<select name="temp_1-3" de-data="전체" data-addr="/basic/encd/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
							</table>
						</td>
					</tr>
					<!-- 할인 관리 END -->
				</Table>
			</td>
		</tr>
	</tbody>
	<!-- 강사 관리 -->
	<tbody>
		<tr class="toggle-t">
			<td class="td-chk">
				<input type="checkbox" name="idx2"><label data-val="2" onclick="checked_part(this);"></label>
			</td>
		   	<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 강사 관리</td>
		   	<td class="perm-sel">
				<select name="temp_2" de-data="전체" onchange="chk_part_option(this);">
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
							<input type="checkbox" name="idx2"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강사 등록</td>
					   	<td class="perm-sel">
							<select name="temp_2" de-data="전체" data-addr="/lecture/lecr/write" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx2-1"><label data-val="2-1" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 강사 정보</td>
					   	<td class="perm-sel">
							<select name="temp_2-1" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 강사 정보 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx2-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강사 조회</td>
								   	<td class="perm-sel">
										<select name="temp_2-1" de-data="전체" data-addr="/lecture/lecr/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx2-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">신규강사 평가 리스트</td>                      
								   	<td class="perm-sel">
										<select name="temp_2-1" de-data="전체" data-addr="/lecture/lecr/list_new" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
							</table>
						</td>
					</tr>
					<!-- 강사 정보 END -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx2"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">거래선 상신</td>
					   	<td class="perm-sel">
							<select name="temp_2" de-data="전체" data-addr="/lecture/lecr/transaction" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx2"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강사 계약서</td>
					   	<td class="perm-sel">
							<select name="temp_2" de-data="전체" data-addr="/lecture/lecr/contract" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx2"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강사 지원 현황</td>
					   	<td class="perm-sel">
							<select name="temp_2" de-data="전체" data-addr="/lecture/lecr/status" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx2-2"><label data-val="2-2" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 증명서 관리</td>
					   	<td class="perm-sel">
							<select name="temp_2-2" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 증명서 관리 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx2-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">증명서 발급 리스트</td>
								   	<td class="perm-sel">
										<select name="temp_2-2" de-data="전체" data-addr="/lecture/lecr/certificate_list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx2-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">출강 증명서</td>                      
								   	<td class="perm-sel">
										<select name="temp_2-2" de-data="전체" data-addr="/lecture/lecr/certificate" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx2-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">원천 징수 영수증</td>                      
								   	<td class="perm-sel">
										<select name="temp_2-2" de-data="전체" data-addr="/lecture/lecr/certificate_tax" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
							</table>
						</td>
					</tr>        
					<!-- 증명서 관리 END -->
				</Table>
			</td>
		</tr>
	</tbody>
	<!-- 강좌 관리 -->
	<tbody>
		<tr class="toggle-t">
			<td class="td-chk">
				<input type="checkbox" name="idx3"><label data-val="3" onclick="checked_part(this);"></label>
			</td>
			<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 강좌 관리</td>
			<td class="perm-sel">
				<select name="temp_3" de-data="전체" onchange="chk_part_option(this);">
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
							<input type="checkbox" name="idx3"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강좌분류관리</td>
					   	<td class="perm-sel">
							<select name="temp_3" de-data="전체" data-addr="/lecture/lect/list_cate" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx3"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">개설강좌 등록</td>
					   	<td class="perm-sel">
							<select name="temp_3" de-data="전체" data-addr="/lecture/lect/main" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx3"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강좌 리스트</td>
					   	<td class="perm-sel">
							<select name="temp_3" de-data="전체" data-addr="/lecture/lect/list" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx3"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강의실 관리</td>
					   	<td class="perm-sel">
							<select name="temp_3" de-data="전체" data-addr="/lecture/lect/room" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx3"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">출석부 관리</td>
					   	<td class="perm-sel">
							<select name="temp_3" de-data="전체" data-addr="/lecture/lect/attend" onchange="chk_one_option(this);">
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
	<!-- 수강/회원 관리 -->
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
					   	<td class="tog-otit">회원등록관리</td>
					   	<td class="perm-sel">
							<select name="temp_4" de-data="전체" data-addr="/member/cust/list_mem" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx4-1"><label data-val="4-1" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 회원 정보</td>
					   	<td class="perm-sel">
							<select name="temp_4-1" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 회원 정보 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx4-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">회원 리스트</td>
								   	<td class="perm-sel">
										<select name="temp_4-1" de-data="전체" data-addr="/member/cust/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx4-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">회원 등록</td>
								   	<td class="perm-sel">
										<select name="temp_4-1" de-data="전체" data-addr="/member/cust/write" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
							</table>
						</td>
					</tr>
					<!-- 회원 정보 END -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx4"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">수강 관리</td>
					   	<td class="perm-sel">
							<select name="temp_4" de-data="전체" data-addr="/member/lect/view" onchange="chk_one_option(this);">
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
							<select name="temp_4" de-data="전체" data-addr="/member/wait/list" onchange="chk_one_option(this);">
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
							<select name="temp_4" de-data="전체" data-addr="/member/relo/write" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx4-3"><label data-val="4-3" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> SMS/TM</td>
					   	<td class="perm-sel">
							<select name="temp_4-3" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- SMS/TM START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx4-3"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">SMS 리스트</td>
								   	<td class="perm-sel">
										<select name="temp_4-3" de-data="전체" data-addr="/member/sms/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx4-3"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">TM 리스트</td>
								   	<td class="perm-sel">
										<select name="temp_4-3" de-data="전체" data-addr="/member/sms/list_tm" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
							</table>
						</td>
					</tr>
					<!-- SMS/TM END -->
				</Table>
			</td>
		</tr>
	</tbody>
	
	<tbody>
		<tr class="toggle-t">
			<td class="td-chk">
				<input type="checkbox" name="idx5"><label data-val="5" onclick="checked_part(this);"></label>
			</td>
		   	<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 매출/마감 관리</td>
		   	<td class="perm-sel">
				<select name="temp_5" de-data="전체" onchange="chk_part_option(this);">
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
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">준비금 등록</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/trms/trms/trms_write" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">마감 등록</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/trms/trms/close_write" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">일일 정산</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/trms/trms/check" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">정산지 출력</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/trms/trms/print" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">매출유형별 조회</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/trms/trms/list" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">매출 상세 현황</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/trms/trms/detail" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">매출분개 전송</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/trms/trms/send" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx5"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강좌별 매출 상세 현황</td>
					   	<td class="perm-sel">
							<select name="temp_5" de-data="전체" data-addr="/lecture/lect/detail" onchange="chk_one_option(this);">
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
		<tr class="toggle-t">
			<td class="td-chk">
				<input type="checkbox" name="idx6"><label data-val="6" onclick="checked_part(this);"></label>
			</td>
		   	<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 정산 관리</td>
		   	<td class="perm-sel">
				<select name="temp_6" de-data="전체" onchange="chk_part_option(this);">
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
							<input type="checkbox" name="idx6"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강사료 기준변경</td>
					   	<td class="perm-sel">
							<select name="temp_6" de-data="전체" data-addr="/it/change" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx6-1"><label data-val="6-1" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 강사료 정산관리</td>
					   	<td class="perm-sel">
							<select name="temp_6-1" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 강사료 정산관리 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">지급기준 점검</td>
								   	<td class="perm-sel">
										<select name="temp_6-1" de-data="전체" data-addr="/it/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td class="td-chk"> -->
<!-- 										<input type="checkbox" name="idx6-1"><label onclick="checked_one(this);"></label> -->
<!-- 									</td> -->
<!-- 								   	<td class="togg-otit">강사료 마감내역</td> -->
<!-- 								   	<td class="perm-sel"> -->
<!-- 										<select name="temp_6-1" de-data="전체" data-addr="/it/regisEnd" onchange="chk_one_option(this);"> -->
<!-- 											<option value="RW">전체</option> -->
<!-- 											<option value="R">보기</option> -->
<!-- 											<option value="">접근불가</option> -->
<!-- 										</select> -->
<!-- 								   	</td> -->
<!-- 								</tr> -->
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강사료 분개/전송</td>
								   	<td class="perm-sel">
										<select name="temp_6-1" de-data="전체" data-addr="/it/end" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">법인강사료 전자증빙</td>
								   	<td class="perm-sel">
										<select name="temp_6-1" de-data="전체" data-addr="/it/elect" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강사료 지급 현황</td>
								   	<td class="perm-sel">
										<select name="temp_6-1" de-data="전체" data-addr="/it/status" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">기수별 강사료 지급 현황</td>
								   	<td class="perm-sel">
										<select name="temp_6-1" de-data="전체" data-addr="/it/statusByPeri" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 강사료 정산관리 END -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx6-2"><label data-val="6-2" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 재료비 정산관리</td>
					   	<td class="perm-sel">
							<select name="temp_6-2" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 재료비 정산관리 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">재료비 점검</td>
								   	<td class="perm-sel">
										<select name="temp_6-2" de-data="전체" data-addr="/it/check" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">재료비 마감내역</td>
								   	<td class="perm-sel">
										<select name="temp_6-2" de-data="전체" data-addr="/it/foodEnd" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">재료비 분개/전송</td>
								   	<td class="perm-sel">
										<select name="temp_6-2" de-data="전체" data-addr="/it/deadline" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx6-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">기수별 재료비 지급 현황</td>
								   	<td class="perm-sel">
										<select name="temp_6-2" de-data="전체" data-addr="/it/material" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 재료비 정산관리 END -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx6"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">계정별 집계표</td>
					   	<td class="perm-sel">
							<select name="temp_6" de-data="전체" data-addr="/it/tally" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx6"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">대금지불 의뢰서</td>
					   	<td class="perm-sel">
							<select name="temp_6" de-data="전체" data-addr="/it/payment" onchange="chk_one_option(this);">
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
		<tr class="toggle-t">
			<td class="td-chk">
				<input type="checkbox" name="idx7"><label data-val="7" onclick="checked_part(this);"></label>
			</td>
		   	<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 통계 관리</td>
		   	<td class="perm-sel">
				<select name="temp_7" de-data="전체" onchange="chk_part_option(this);">
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
							<input type="checkbox" name="idx7"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">목표입력</td>
					   	<td class="perm-sel">
							<select name="temp_7" de-data="전체" data-addr="/stat/target" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx7-1"><label data-val="7-1" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 매출 통계</td>
					   	<td class="perm-sel">
							<select name="temp_7-1" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 매출 통계 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">점별 실적</td>
								   	<td class="perm-sel">
										<select name="temp_7-1" de-data="전체" data-addr="/stat/perfor" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강좌군별 실적 분석</td>
								   	<td class="perm-sel">
										<select name="temp_7-1" de-data="전체" data-addr="/stat/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강좌별 접수 현황</td>
								   	<td class="perm-sel">
										<select name="temp_7-1" de-data="전체" data-addr="/stat/receipt" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr><!-- 요기요!!!! -->
									<td class="td-chk">
										<input type="checkbox" name="idx7-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강좌별 회원 상세 현황</td>
								   	<td class="perm-sel">
										<select name="temp_7-1" de-data="전체" data-addr="/stat/receipt_detail" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">일별 접수 현황</td>
								   	<td class="perm-sel">
										<select name="temp_7-1" de-data="전체" data-addr="/stat/receipt_day" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 매출 통계 END -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx7-2"><label data-val="7-2" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 회원 통계</td>
					   	<td class="perm-sel">
							<select name="temp_7-2" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select> 
					   	</td>
					</tr>
					<!-- 회원 통계 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">전체 회원 통계</td>
								   	<td class="perm-sel">
										<select name="temp_7-2" de-data="전체" data-addr="/stat/member_list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강좌별 회원 구분</td>
								   	<td class="perm-sel">
										<select name="temp_7-2" de-data="전체" data-addr="/stat/member_lecture" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-2"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강의실별 접수 현황</td>
								   	<td class="perm-sel">
										<select name="temp_7-2" de-data="전체" data-addr="/stat/member_receipt" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 회원 통계 END -->
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx7-3"><label data-val="7-3" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> 강사 통계</td>
					   	<td class="perm-sel">
							<select name="temp_7-3" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 강사 통계 START -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-3"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강사료 지급 현황</td>
								   	<td class="perm-sel">
										<select name="temp_7-3" de-data="전체" data-addr="/stat/payment" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx7-3"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">강사별 출강점 현황</td>
								   	<td class="perm-sel">
										<select name="temp_7-3" de-data="전체" data-addr="/stat/attend" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>
								</tr>
							</table>
						</td>
					</tr>
					<!-- 강사 통계 END -->
				</Table>
			</td>
		</tr>
	</tbody>
	<tbody>
		<tr class="toggle-t">
			<td class="td-chk">
				<input type="checkbox" name="idx8"><label data-val="8" onclick="checked_part(this);"></label>
			</td>
		   	<td class="tog-tit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div> WEB관리</td>
		   	<td class="perm-sel">
				<select name="temp_8" de-data="전체" onchange="chk_part_option(this);">
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
							<input type="checkbox" name="idx8-1"><label data-val="8-1" onclick="checked_part(this);"></label>
						</td>
					   	<td class="tog-otit"><div class="toggle-i"><i class="material-icons add">add_circle_outline</i><i class="material-icons remove">remove_circle_outline</i></div>메인 디자인 관리</td>
					   	<td class="perm-sel">
							<select name="temp_8-1" de-data="전체" onchange="chk_part_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<!-- 운영자 관리 -->
					<tr class="togg-o">
						<td colspan="3">
							<table>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx8-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">메인 배너 관리</td>
								   	<td class="perm-sel">
										<select name="temp_8-1" de-data="전체" data-addr="/web/list" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
								<tr>
									<td class="td-chk">
										<input type="checkbox" name="idx8-1"><label onclick="checked_one(this);"></label>
									</td>
								   	<td class="togg-otit">중간 배너 관리</td>
								   	<td class="perm-sel">
										<select name="temp_8-1" de-data="전체" data-addr="/web/sublist" onchange="chk_one_option(this);">
											<option value="RW">전체</option>
											<option value="R">보기</option>
											<option value="">접근불가</option>
										</select>
								   	</td>									
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx8"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">아카데미 뉴스</td>
					   	<td class="perm-sel">
							<select name="temp_8" de-data="전체" data-addr="/web/academy" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx8"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">추천 강좌</td>
					   	<td class="perm-sel">
							<select name="temp_8" de-data="전체" data-addr="/web/lecture" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx8"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">강의계획서</td>
					   	<td class="perm-sel">
							<select name="temp_8" de-data="전체" data-addr="/web/plan" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx8"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">팝업 관리</td>
					   	<td class="perm-sel">
							<select name="temp_8" de-data="전체" data-addr="/web/popup" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
					<tr>
						<td class="td-chk">
							<input type="checkbox" name="idx8"><label onclick="checked_one(this);"></label>
						</td>
					   	<td class="tog-otit">후기 관리</td>
					   	<td class="perm-sel">
							<select name="temp_8" de-data="전체" data-addr="/web/review" onchange="chk_one_option(this);">
								<option value="RW">전체</option>
								<option value="R">보기</option>
								<option value="">접근불가</option>
							</select>
					   	</td>
					</tr>
				</Table>
			</td>
		</tr>
</table>