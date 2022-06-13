<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/inc/css/admin.css">
<link rel="stylesheet" href="/inc/css/popup.css">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/musign.js"></script>
<script src="/inc/js/jquery.breadcrumbs-generator.js"></script>
<script>
function addChar(num){
	var memNum = $('#inter-phone').val()+""+num;
	$('#inter-phone').val(memNum);
}

function delChar(){
	var memNum = $('#inter-phone').val();
	memNum = memNum.substr(0,memNum.length-1);
	$('#inter-phone').val(memNum);
}


function resetChar(){
	$('#inter-phone').val('');
}



</script>


<div class="le-cell">
	<div class="le-inner">
       	<div class="white-bg">
       		<div>
       			<h3 class="text-center">멤버스 고객 연동</h3>
				
				<div class="inter-txt">
					<p>AK문화아카데미 수강이력 여부를 체크해주세요.</p>
					<div class="inter-sel">
						<ul>
							<li>
								<input type="radio" id="inter_type1" name="inter_type" value="no" onclick="" checked="">
					<label for="inter_type1">없음</label>
				</li>
				<li>
					<input type="radio" id="inter_type2" name="inter_type" value="yes" onclick="">
					<label for="inter_type2">있음</label>
				</li>
			</ul>
		</div>
	</div>
	<div class="inter-txt">
		<p>조회하실 고객님의 정보를 입력해주세요.</p>
		<div class="inter-sel">
			<ul>
			
				<li>
					<input type="radio" id="inter_Info1" name="inter_Info" value="phone" onclick="" checked="">
					<label for="inter_Info1">연락처</label>
				</li>
				
				<li>
					<input type="radio" id="inter_Info2" name="inter_Info" value="cardnumber" onclick="">
					<label for="inter_Info2">멤버스 카드번호</label>
				</li>
				
			</ul>
		</div>
	</div>
	<div class="inter-phn">
		<input type="text" id="inter-phone" numberOnly/>
	</div>
	<div class="inter-numb">
		<ul>
			<li onclick="addChar(1)">1</li>
			<li onclick="addChar(2)">2</li>
			<li onclick="addChar(3)">3</li>
			<li onclick="addChar(4)">4</li>
			<li onclick="addChar(5)">5</li>
			<li onclick="addChar(6)">6</li>
			<li onclick="addChar(7)">7</li>
			<li onclick="addChar(8)">8</li>
			<li onclick="addChar(9)">9</li>
			<li onclick="addChar(0)">0</li>
			<li class="font-15" onclick="delChar()">지우기</li>
			<li class="font-15" onclick="resetChar()">초기화</li>
		</ul>
	</div>
	<div class="btn-wr text-center">
		<a class="btn btn02 ok-btn" onclick="save_cus_info()">확인</a>
	</div>
    		</div>
    	</div>
    </div>
</div>	