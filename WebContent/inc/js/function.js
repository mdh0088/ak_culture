$( document ).ready(function() {
	$('.inputDisabled').attr('readOnly', true);
	
	 $('body').on("keyup",'.comma', function(){
		 var data = $(this).val().replace(/,/gi, "");
		 data = data.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	     $(this).val(data);
	 });
	 $('body').on("keyup",'.date-i', function(){
		 var data = $(this).val().replace(/-/gi, "");
		 if(data.length == 8)
		 {
			 var y = data.substring(0,4);
			 var m = data.substring(4,6);
			 var d = data.substring(6,8);
			 if(Number(m) > 12)
			 {
				 m = "12";
			 }
			 if(Number(d) > 31)
			 {
				 d = "31";
			 }
			 
			 data = y + "-"+m + "-" + d;
			 
		 }
		 if(data.length == 6)
		 {
			 var y = data.substring(0,4);
			 var m = data.substring(4,6);
			 var d = data.substring(6,8);
			 data = y+"-"+m;
			 if(Number(m) > 12)
			 {
				 m = "12";
			 }
			 data = y + "-" + m;
		 }
	     $(this).val(data);
	 });
	 $('body').on("keyup",'.onlyNumber', function(){
		 var data = $(this).val();
		 data = data.replace(/[^0-9]/g, '');
	     $(this).val(data);
	 });
});
function isBrowserCheck(){ 
	const agt = navigator.userAgent.toLowerCase(); 
	if (agt.indexOf("chrome") != -1) return 'Chrome'; 
	if (agt.indexOf("opera") != -1) return 'Opera'; 
	if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
	if (agt.indexOf("webtv") != -1) return 'WebTV'; 
	if (agt.indexOf("beonex") != -1) return 'Beonex'; 
	if (agt.indexOf("chimera") != -1) return 'Chimera'; 
	if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
	if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
	if (agt.indexOf("firefox") != -1) return 'Firefox'; 
	if (agt.indexOf("safari") != -1) return 'Safari'; 
	if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
	if (agt.indexOf("netscape") != -1) return 'Netscape'; 
	if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla'; 
	if (agt.indexOf("msie") != -1) { 
    	let rv = -1; 
		if (navigator.appName == 'Microsoft Internet Explorer') { 
			let ua = navigator.userAgent; var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})"); 
		if (re.exec(ua) != null) 
			rv = parseFloat(RegExp.$1); 
		} 
		return 'Internet Explorer '+rv; 
	} 
}
function pageReset()
{
	var link = location.href;
	location.href = link;
}
function setBundang()
{
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
}
function setPeri()
{
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
}
function get_label(fld) {
	var id = fld;
	var labels = document.getElementsByTagName('label');
	var el = null;
	var text = '';
	for (i = 0; i < labels.length; i++) {
		if (id == labels[i].htmlFor) {
			el = labels[i];
			break;
		}
	}
	if (el != null) {
		text = el.innerHTML;
	}
	return text;
}
function lengthCheck(val, max)
{
	var len = $("#"+val).val().length;
	$("#"+val+"_length").html("<Span>"+len+"</Span> / "+max+"자</div>");
}
function excuteEnter(excuteFunc)
{
	if(event.keyCode == 13){
		if(typeof isLoading == 'undefined')
		{
			excuteFunc();
			return;
		}
		else if(!isLoading)
		{
			excuteFunc();
			return;
		}
	}
}
function excuteEnter_param(excuteFunc, param1, param2)
{
	if(event.keyCode == 13){
		if(typeof isLoading == 'undefined')
		{
			excuteFunc(param1, param2);
			return;
		}
		else if(!isLoading)
		{
			excuteFunc(param1, param2);
			return;
		}
	}
}

function calcAge(birth) {                 

    var date = new Date();
    var year = date.getFullYear();
    var month = (date.getMonth() + 1);
    var day = date.getDate();       
    if (month < 10) month = '0' + month;
    if (day < 10) day = '0' + day;
    var monthDay = month + day;
    birth = birth.replace('-', '').replace('-', '');
    var birthdayy = birth.substr(0, 4);
    var birthdaymd = birth.substr(4, 4);
    var age = monthDay < birthdaymd ? year - birthdayy - 1 : year - birthdayy;

    return age;
}

function getInputDayLabel(dd) {
    
    var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
    
    var today = new Date(dd).getDay();
    var todayLabel = week[today];
    
    return todayLabel;
}
function cutDate(dd)
{
	if(dd == "" || dd == null || dd == 'null' || dd == undefined)
	{
		return "";
	}
	else
	{
		if(trim(dd).length == 6)
		{
			var year = dd.substring(0,4);
			var month = dd.substring(4,6);
			return year+"-"+month;
		}
		else if(trim(dd).length == 8)
		{
			var year = dd.substring(0,4);
			var month = dd.substring(4,6);
			var day = dd.substring(6,8);
			return year+"-"+month+"-"+day;
		}
		else if(trim(dd).length == 14)
		{
			var year = dd.substring(0,4);
			var month = dd.substring(4,6);
			var day = dd.substring(6,8);
			var hour = dd.substring(8,10);
			var min = dd.substring(10,12);
			var sec = dd.substring(12,14);
			return year+"-"+month+"-"+day+" "+hour+":"+min+":"+sec;
		}
		else
		{
			return dd;
		}
	}
}
function cutDateNotYear(dd)
{
	if(dd == "" || dd == null || dd == 'null' || dd == undefined)
	{
		return "";
	}
	else
	{
		if(trim(dd).length == 8)
		{
			var month = dd.substring(4,6);
			var day = dd.substring(6,8);
			return month+"-"+day;
		}
		else
		{
			return dd;
		}
	}
}
function cutBiz(dd)
{
	if(dd == "" || dd == null || dd == 'null' || dd == undefined)
	{
		return "";
	}
	else
	{
		if(trim(dd).length == 10)
		{
			var dd1 = dd.substring(0,3);
			var dd2 = dd.substring(3,5);
			var dd3 = dd.substring(5,10);
			return dd1+"-"+dd2+"-"+dd3;
		}
		else
		{
			return dd;
		}
	}
}

function cutPhone(dd)
{
	if(dd == "" || dd == null || dd == 'null' || dd == undefined)
	{
		return "";
	}
	else
	{
		if(trim(dd).length == 11)
		{
			var phone1 = dd.substring(0,3);
			var phone2 = dd.substring(3,7);
			var phone3 = dd.substring(7,11);
			return phone1 + "-" + phone2 + "-" + phone3;
		}
		else if(trim(dd).length == 10)
		{
			var phone1 = dd.substring(0,3);
			var phone2 = dd.substring(3,6);
			var phone3 = dd.substring(6,10);
			return phone1 + "-" + phone2 + "-" + phone3;
		}
		else
		{
			return dd;
		}
	}
}

function cutDate2(dd)
{
	if(dd != '' && dd != null)
	{
		var year = dd.substring(0,4);
		var month = dd.substring(4,6);
		var day = dd.substring(6,8);
		return year+"-"+month+"-"+day;
	}
}

function nullChk(d)
{
	if(d == "" || d == null || d == 'null' || d == undefined)
	{
		return "";
	}
	else
	{
		return d;
	}
}
function nullChkZero(d)
{
	if(d == "" || d == null || d == 'null' || d == undefined)
	{
		return Number("0");
	}
	else
	{
		var ret = d.toString().replace(/,/gi, ""); 
		return Number(ret);
	}
}
function convInt(d)
{
	return Math.ceil(nullChkZero(d));
}
function comma(x) {
    return nullChkZero(x).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}
var setCookie = function(name, value, exp) 
{
	var date = new Date();
	date.setTime(date.getTime() + exp*24*60*60*1000);
	document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
};
var getCookie = function(name) 
{
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;
};
function getNow()
{
	var date = new Date(); 
	var year = date.getFullYear(); 
	var month = new String(date.getMonth()+1); 
	var day = new String(date.getDate()); 

	// 한자리수일 경우 0을 채워준다. 
	if(month.length == 1){ 
	  month = "0" + month; 
	} 
	if(day.length == 1){ 
	  day = "0" + day; 
	} 
	return year + "" + month + "" + day;
}
function getTime()
{
	var date = new Date(); 
	var h = date.getHours();
	var m = date.getMinutes();
	var s = date.getSeconds();
	// 한자리수일 경우 0을 채워준다. 
	if(h.toString().length == 1){ 
	  h = "0" + h.toString(); 
	} 
	if(m.toString().length == 1){ 
	  m = "0" + m.toString(); 
	} 
	if(s.toString().length == 1){ 
		s = "0" + s.toString(); 
	} 
	return h + "" + m + "" + s;
}
function cutLectHour(lecthour)
{
	if(lecthour.length != 8)
	{
		return "";
	}
	else
	{
		var lect1 = "";
		var lect2 = "";
		var lect3 = "";
		var lect4 = "";
		
		lect1 = lecthour.substring(0,2);
		lect2 = lecthour.substring(2,4);
		lect3 = lecthour.substring(4,6);
		lect4 = lecthour.substring(6,8);
		
		return lect1 + ":" + lect2 + "~" + lect3 + ":" + lect4;
	}
}
function cutYoil(day_flag)
{
	var yoil = "";
	if(day_flag.split('')[0] == "1")
	{
		yoil += ",월";
	}
	if(day_flag.split('')[1] == "1")
	{
		yoil += ",화";
	}
	if(day_flag.split('')[2] == "1")
	{
		yoil += ",수";
	}
	if(day_flag.split('')[3] == "1")
	{
		yoil += ",목";
	}
	if(day_flag.split('')[4] == "1")
	{
		yoil += ",금";
	}
	if(day_flag.split('')[5] == "1")
	{
		yoil += ",토";
	}
	if(day_flag.split('')[6] == "1")
	{
		yoil += ",일";
	}
	yoil = yoil.substring(1, yoil.length);
	return yoil;
}
function trim(stringToTrim) {
    return nullChk(stringToTrim).toString().replace(/^\s+|\s+$/g,"");
}
function ck_age(age) { 
	if(nullChk(age) != "")
	{
		var year=parseInt(new Date().getFullYear()); 
		var ck=parseInt(age.substring(0,4)); 
		return (year-ck)+1; // 우리나라 나이 표시 +1 더함 
	}
	else
	{
		return 0;
	}
}

function show_address(post, addr) {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            document.getElementById(post).value = data.zonecode;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
	            document.getElementById(addr).value = roadAddr;
               // document.getElementById("extraAddress").value = extraRoadAddr;
            } else {
	            document.getElementById(addr).value = data.jibunAddress;
               // document.getElementById("extraAddress").value = '';
            }

            var guideTextBox = document.getElementById("guide");
            
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if(data.autoRoadAddress) {
            	
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                //guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
               // guideTextBox.style.display = 'block';

            } else if(data.autoJibunAddress) {
            	
                var expJibunAddr = data.autoJibunAddress;
               //guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
               // guideTextBox.style.display = 'block';
            } else {
            	
               // guideTextBox.innerHTML = '';
               // guideTextBox.style.display = 'none';
            }
        }
    }).open();
}
function repWord(dd)
{
	dd = dd.replace(/&amt;/gi, "&");
	dd = dd.replace(/&lt;/gi, "<");
	dd = dd.replace(/&gt;/gi, ">");
	dd = dd.replace(/&quot;/gi, "\"");
	dd = dd.replace(/&#039;/gi, "\'");
	dd = dd.replace(/<br>/gi, "\n");
	
	return dd;
	
}

function repWord2(str){
	str = str.replace(/&/g,"&amt;");
	str = str.replace(/</g,"&lt;");
	str = str.replace(/>/g,"&gt;");
	str = str.replace(/\"/g,"&quot;");
	str = str.replace(/\'/g,"&#039;");
	str = str.replace(/\n/g,"<br>");
 return str;
}
//6자리 uid생성
function generateUID() {
	var ranNum = Math.floor(Math.random()*(999999-100000+1)) + 100000;
	return String(ranNum);
}
//계좌실명조회
function coocon_api(bank_cd, search_acct_no, acnm_no){
	if(nullChk(bank_cd) == "" || nullChk(search_acct_no == "") || nullChk(acnm_no) == ""){
		alert("필요 정보가 부족합니다");
		return false;
	}
   	const SECR_KEY = "26ITwrC3lVJCeh3XeBYr";
	const KEY = "ACCTNM_RCMS_WAPI";
    var REQ_DATA = new Object();
        REQ_DATA.BANK_CD = bank_cd;		//은행코드
        REQ_DATA.SEARCH_ACCT_NO = search_acct_no;	//계좌번호
        REQ_DATA.ACNM_NO = acnm_no;		//증명번호 ex)사업자번호 10자리 or 생년월일 6자리
        REQ_DATA.TRSC_SEQ_NO = "7"+generateUID();	//거래일련번호

    var JSONData = new Object();
    JSONData.SECR_KEY = SECR_KEY;
    JSONData.KEY = KEY;
    JSONData.REQ_DATA = [];
    JSONData.REQ_DATA.push(REQ_DATA);
    
    var acct_nm = "";
    $.ajax({
        type: "POST",
        url: "/common/coocon_api",
        async: false,
        data:{
            JSONData: JSON.stringify(JSONData)
        },
        success: function(data){
        	var result = JSON.parse(data.res);
        	if(result.RSLT_CD != "000"){	//000을 제외하면 오류
        		alert(result.RSLT_MSG+"\n"+result.RSLT_CD);
        		return false;
        	}else{
        		acct_nm = result.RESP_DATA[0].ACCT_NM; //예금주명(최대 20byte)
        		if(nullChk(acct_nm) == ""){	//거래일련번호 중복시 데이터조회가 안되어 추가함
        			alert("일시적인 오류입니다. 다시 시도해 주세요.");
        			return false;
        		}
        	}
        }
    });
    return acct_nm;
}
function nice_api(gubun, reqNum){
	if((gubun != "A") && (gubun != "B")){
		alert("데이터를 정확히 입력해주세요");
		return false;
	}
	if((gubun == "A" && reqNum.length != 10) || (gubun == "B" && reqNum.length != 13)){
		alert("데이터를 정확히 입력해주세요");
		return false;
	}
	$.ajax({
        type: "POST",
        url: "/common/nice_api",
        async: false,
        data:{
            gubun: gubun,	//사업자번호=A, 법인번호=B
            reqNum: reqNum	//요청값
        },
        success: function(data){
        	console.log(data);
        	if(data.isSuc == "success"){
        		alert("조회성공");
        		console.log(data.msg); 	//기업상태
        		console.log(data.compName);	//기업명
        		console.log(data.repName);	//대표자명
        	}else if(data.isSuc == "failed" || nullChk(data.errCode) == "-9"){
        		var inner = '조회에 실패하였습니다. 입력한 정보를 다시 확인하여주세요.\n';
        			inner += '\n';
        			inner += '같은 오류가 계속 발생할경우\n';
        			inner += '나이스 DB에 법인 정보를 등록/재등록 요청해주세요\n';
        			inner += ' * 영업일 기준 평균 1~2시간 소요\n';
        			inner += ' * 확인 버튼 클릭시 요청페이지로 이동합니다.(팝업 허용 필요)';
        		if(confirm(inner)){
        			window.open('https://www.niceid.co.kr/front/personal/corporate/corporate_register.jsp?menu_num=1&page_num=0&page_num_1=4', '_blank');
        		}
        	}else{
        		alert("시스템 에러: "+data.errCode);
        	}
        }
    });
}
function cutJumin(val)
{
	var data = "";
	if(val.length == 13)
	{
		data = val.substring(0,6) + "-" + val.substring(6,7) + "******";
	}
	else
	{
		data = "주민번호오류";
	}
	return data;
}
// AK사업자번호로 테스트
// nice_api("A", "1258129907"); 
// data.msg: 정상
// data.compName: 에이케이에스앤디(주)
// data.rep: 심상보


//자바스크립트 해시맵
HashMap = function(){  
    this.map = new Array();
};  
HashMap.prototype = {  
    put : function(key, value){  
        this.map[key] = value;
    },  
    get : function(key){  
        return this.map[key];
    },  
    getAll : function(){  
        return this.map;
    },  
    clear : function(){  
        this.map = new Array();
    },  
    isEmpty : function(){    
         return (this.map.size() == 0);
    },
    remove : function(key){    
         delete this.map[key];
    },
    toString : function(){
        var temp = '';
        for(i in this.map){  
            temp = temp + ',' + i + ':' +  this.map[i];
        }
        temp = temp.replace(',','');
          return temp;
    },
    keySet : function(){  
        var keys = new Array();  
        for(i in this.map){  
            keys.push(i);
        }  
        return keys;
    }
};
//자바스크립트 해시맵


function fnChkByte(obj, maxByte) {
    var str = obj.value;
    var str_len = str.length;
 
    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";
 
    for (var i = 0; i < str_len; i++) {
        one_char = str.charAt(i);
 
        if (escape(one_char).length > 4) {
            rbyte += 2; //한글2Byte
        } else {
            rbyte++; //영문 등 나머지 1Byte
        }
 
        if (rbyte <= maxByte) {
            rlen = i + 1; //return할 문자열 갯수
        }
    }
 
    if (rbyte > maxByte) {
        alert("한글 " + (maxByte / 2) + "자 / 영문 " + maxByte + "자를 초과 입력할 수 없습니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
    } else {
//        document.getElementById('byteInfo').innerText = rbyte;
    }
}
function getPayMonth(act)
{
	$.ajax({
        type: "POST",
        url: "/it/getPayMonth",
        async: false,
        data:{
            store : $("#selBranch").val(),
            period : $("#selPeri").val()
        },
        success : function(data) 
		{
			console.log(data);
        	var result = data;
        	$("#ul_radio").html('');
        	
        	var inner = "";
        	if(act == "regis")
        	{
        		if(nullChk(result.TECH_1_YMD) != "")
        		{
        			inner += '<li>';
        			inner += '	<input type="radio" id="lect_ym1" name="lect_ym" value="'+result.TECH_1_YMD.substring(0,6)+'" checked>';
        			inner += '	<label for="lect_ym1">1차('+cutDate(result.TECH_1_YMD.substring(0,6))+')</label>';
        			inner += '</li>';
        		}
        		if(nullChk(result.TECH_2_YMD) != "")
        		{
        			inner += '<li>';
        			inner += '	<input type="radio" id="lect_ym2" name="lect_ym" value="'+result.TECH_2_YMD.substring(0,6)+'" checked>';
        			inner += '	<label for="lect_ym2">2차('+cutDate(result.TECH_2_YMD.substring(0,6))+')</label>';
        			inner += '</li>';
        		}
        		if(nullChk(result.TECH_3_YMD) != "")
        		{
        			inner += '<li>';
        			inner += '	<input type="radio" id="lect_ym3" name="lect_ym" value="'+result.TECH_3_YMD.substring(0,6)+'" checked>';
        			inner += '	<label for="lect_ym3">3차('+cutDate(result.TECH_3_YMD.substring(0,6))+')</label>';
        			inner += '</li>';
        		}
        	}
        	else
        	{
        		if(nullChk(result.MATE_1_YMD) != "")
        		{
        			inner += '<li>';
        			inner += '	<input type="radio" id="food_ym1" name="food_ym" value="'+result.MATE_1_YMD.substring(0,8)+'" checked>';
        			inner += '	<label for="food_ym1">1차('+cutDate(result.MATE_1_YMD.substring(0,6))+')</label>';
        			inner += '</li>';
        		}
        		if(nullChk(result.MATE_2_YMD) != "")
        		{
        			inner += '<li>';
        			inner += '	<input type="radio" id="food_ym2" name="food_ym" value="'+result.MATE_2_YMD.substring(0,8)+'" checked>';
        			inner += '	<label for="food_ym2">2차('+cutDate(result.MATE_2_YMD.substring(0,6))+')</label>';
        			inner += '</li>';
        		}
        		if(nullChk(result.MATE_3_YMD) != "")
        		{
        			inner += '<li>';
        			inner += '	<input type="radio" id="food_ym3" name="food_ym" value="'+result.MATE_3_YMD.substring(0,8)+'" checked>';
        			inner += '	<label for="food_ym3">3차('+cutDate(result.MATE_3_YMD.substring(0,6))+')</label>';
        			inner += '</li>';
        		}
        	}
        	$("#ul_radio").html(inner);
        }
    });
}

function getLastDay(y, m)
{
	var last   = new Date(y,m); 

    last   = new Date( last - 1 ); 

    return last.getDate();

}
function resetCookie()
{
	setCookie("room_store_nm", '', 9999);
	setCookie("room_store", '', 9999);
	setCookie("page", '', 9999);
	setCookie("order_by", '', 9999);
	setCookie("sort_type", '', 9999);
	setCookie("listSize", '', 9999);
	setCookie("store", '', 9999);
	setCookie("year", '', 9999);
	setCookie("season", '', 9999);
	setCookie("selYear1", '', 9999);
	setCookie("selYear2", '', 9999);
	setCookie("selSeason1", '', 9999);
	setCookie("selSeason2", '', 9999);
	setCookie("period", '', 9999);
	setCookie("search_type", '', 9999);
	setCookie("search_name", '', 9999);
	setCookie("pelt_status", '', 9999);
	setCookie("is_finish", '', 9999);
	setCookie("main_cd", '', 9999);
	setCookie("search_start", '', 9999);
	setCookie("search_end", '', 9999);
	setCookie("subject_fg", '', 9999);
	setCookie("status_fg", '', 9999);
	setCookie("contract_type01", '', 9999);
	setCookie("contract_type02", '', 9999);
	setCookie("contract_type03", '', 9999);
	setCookie("contract_type04", '', 9999);
	setCookie("day_flag", '', 9999);
	setCookie("date_start", '', 9999);
	setCookie("date_end", '', 9999);
	setCookie("car_num", '', 9999);
	setCookie("mgmt_num", '', 9999);
	setCookie("park_info", '', 9999);
	setCookie("del_yn", '', 9999);
	setCookie("gubun", '', 9999);
	setCookie("gift_fg_a", '', 9999);
	setCookie("gift_fg_b", '', 9999);
	setCookie("cust_fg_a", '', 9999);
	setCookie("cust_fg_b", '', 9999);
	setCookie("start_ymd", '', 9999);
	setCookie("end_ymd", '', 9999);
	setCookie("encd_list", '', 9999);
	setCookie("search_con", '', 9999);
	setCookie("grade", '', 9999);
	setCookie("pelt_status", '', 9999);
	setCookie("search_name1", '', 9999);
	setCookie("search_name2", '', 9999);
	setCookie("search_corp_fg1", '', 9999);
	setCookie("search_corp_fg2", '', 9999);
	setCookie("corp_fg", '', 9999);
	setCookie("aply_type", '', 9999);
	setCookie("print_type", '', 9999);
	setCookie("lect_nm", '', 9999);
	setCookie("search_subject_fg", '', 9999);
	setCookie("lect_cnt_start", '', 9999);
	setCookie("lect_cnt_end", '', 9999);
	
}


function CheckMaxString(obj, maxNum){ 
	var li_str_len = obj.length; 
	var li_byte = 0; 
	var li_len = 0; 
	var ls_one_char = ""; 
	var ls_str2 = ""; 
	
	for( var j=0; j<li_str_len; j++)
	{ 
		ls_one_char = obj.charAt(j); 
		if(escape(ls_one_char).length > 4 )
		{ 
			li_byte += 2; 
		}
		else
		{ 
			li_byte++; 
		} 
		
		if(li_byte <= maxNum)
		{ 
			li_len = j+1; 
		} 
	} 
	
	if(li_byte > maxNum)
	{ 
		ls_str2 = obj.substr(0, li_len)+"..."; 
	}
	else
	{ 
		ls_str2 = obj; 
	} 
	return ls_str2; 
}


function over_tr(idx){
	$(idx).css("background-color","#ee908e");
}

function left_tr(idx){
	$(idx).css("background-color","white");
}


function CheckMaxString(obj, maxNum){ 
		var li_str_len = obj.length; 
		var li_byte = 0; 
		var li_len = 0; 
		var ls_one_char = ""; 
		var ls_str2 = ""; 
		for( var j=0; j<li_str_len; j++){ 
			ls_one_char = obj.charAt(j); 
			if(escape(ls_one_char).length > 4 ) {
				li_byte += 2; 
			}else{ 
				li_byte++; 
			} 
			
			if(li_byte <= maxNum){ 
				li_len = j+1; 
				} 
			} 
		
		if(li_byte > maxNum){ 
			ls_str2 = obj.substr(0, li_len)+"...";
		}else{ 
			ls_str2 = obj; 
		} return ls_str2; 
}
function toggleFullScreen(elem) {
    // ## The below if statement seems to work better ## if ((document.fullScreenElement && document.fullScreenElement !== null) || (document.msfullscreenElement && document.msfullscreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)) {
    if ((document.fullScreenElement !== undefined && document.fullScreenElement === null) || (document.msFullscreenElement !== undefined && document.msFullscreenElement === null) || (document.mozFullScreen !== undefined && !document.mozFullScreen) || (document.webkitIsFullScreen !== undefined && !document.webkitIsFullScreen)) {
        if (elem.requestFullScreen) {
            elem.requestFullScreen();
        } else if (elem.mozRequestFullScreen) {
            elem.mozRequestFullScreen();
        } else if (elem.webkitRequestFullScreen) {
            elem.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
        } else if (elem.msRequestFullscreen) {
            elem.msRequestFullscreen();
        }
    } else {
        if (document.cancelFullScreen) {
            document.cancelFullScreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.webkitCancelFullScreen) {
            document.webkitCancelFullScreen();
        } else if (document.msExitFullscreen) {
            document.msExitFullscreen();
        }
    }
}

function isCellPhone(p) {
    p = p.split('-').join('');
    return p;
}




