//인증심사 T-027 : 단말기 등록 정보 확인 
var posCertiNo = "####AKWEBPOS3001";//POSSW식별번호[16] - cmc 식별번호 update

var c_print_stat = "OFF"; //가맹점용 전표 출력여부
var a_print_stat = "OFF"; //가맹점용 전표 출력여부

var subject_arr = "";
var part_subject_arr = "";
var child_no1_arr = "";
var child_no2_arr = "";
var child_no3_arr = "";
var part_regis_fee_arr = "";
var part_food_amt_arr = "";
var subject_nm_arr = "";
var regis_fee_arr = "";
var food_amt_arr = "";

var rep_subject_cd = ""; //대표강좌 셋팅 (주차)
var rep_recpt_no = "";

var pay_fg = "7"; //2 : 수강료, 3 : 부분입금, 7 : 재료비 + 수강료, 8 : 중도수강 나중에 수정해야함.    

var total_pay = 0; //총 금액
var total_regis_fee = 0; //총 수강료
var total_food_amt = 0; //총 재료비
var final_pay = 0; // 할인빼고 뭐빼고 하여튼 최종 결제해야할 금액

var encd_pay1 = 0; //할인금액1
var encd_pay2 = 0; //할인금액2

var cash_amt = 0;
var card_amt = 0;
var coupon_amt = 0;
var mcoupon_amt = 0;
var key_value = ""; //현금승인시 사용
var user_ip = ""; //관리자 아이피
var login_name = ""; //관리자 이름
var pos_no = ""; //관리자 포스번호
var cashrec_n_coupon_arr = ""; //상품권할때 추가한다.
var cashrec_n_coupon = 0; //상품권할때 추가한다.
var cashrec_y_coupon = 0; //상품권할때 추가한다.

var pos_status = "";



//현금영수증용 카드 변수
var cash_card_rfFlag = "";
var cash_card_cardFlag = "";
var cash_card_modelNo = "";
var cash_card_encDtCnt = "";
var cash_card_encGubun = "";
var cash_card_ksn = "";
var cash_card_encData = "";
var cash_card_ksn1 = "";
var cash_card_encData1 = "";

var cash_card_cardFlag1 = "";
var cash_card_cardFlag2 = "";
var cash_card_cardFlag3 = "";
var cash_card_cardFlag4 = "";

var cash_ls_send_str = "";

var cash_approve_no = "";
var cash_bank_cd = "";
var cash_rate = "";
var cash_message = "";
var cash_issue_fg = "";
var cash_id_fg = "";
var cash_id_no = "";
var cash_approve_amt = 0;
//현금영수증용 카드 변수

//단말기 체크 변수
var reader_modelCd = "";
var reader_ver = "";
var reader_serialNo = "";
var reader_protoVer = "";
var reader_useMsrTr = "";
var reader_maxVan = "";
var reader_vanCnt = "";
var reader_vanCode = "";
var reader_vanNm = "";
var reader_reciKeyVer = "";
var reader_encMeth = "";
var reader_vanCode1 = "";
var reader_vanNm1 = "";
var reader_reciKeyVer1 = "";
var reader_encMeth1 = "";
var reader_vanCode2 = "";
var reader_vanNm2 = "";
var reader_reciKeyVer2 = "";
var reader_encMeth2 = "";
var reader_vanCode3 = "";
var reader_vanNm3 = "";
var reader_reciKeyVer3 = "";
var reader_encMeth3 = "";
var reader_vanCode4 = "";
var reader_vanNm4 = "";
var reader_reciKeyVer4 = "";
var reader_encMeth4 = "";
var reader_secuVer1 = "";
var reader_integrity = "";
var reader_secuVer = "";
//단말기 체크 변수

//상품권 Grid 배열들
var coupon_fg_arr = "";
var coupon_cd_arr = "";
var coupon_no_arr = "";
var face_amt_arr = "";
var cashrec_yn_arr = "";
var vat_cal_ext_rate_arr = "";
var vat_cal_rate_arr = "";
var cp_change_amt_arr = "";
var cp_chage_apy_y_amt_arr = "";
var cp_chage_apy_n_amt_arr = "";
var cashrec_amt_arr = "";
var cashrec_n_amt_arr = "";
//상품권 Grid 배열들

//모바일상품권 변수들
var barcode_no = "";
var mcoupon_approve_status = 0; //모바일상품권 승인여부 승인시 1로 바뀜.
var mcoupon_remain_amt = 0; //사용가능금액
var mcoupon_search_cd = 0; //모바일상품권 조회 여부 조회시 1로 바뀜.
var mcoupon_approve_cd = 0; 
var mcoupon_rmn_amt = 0; //잔여금
var mcoupon_cnt = 0; //단독결제 복합결제
var mcoupon_approve_no = ""; //승인번호
var mcoupon_approve_amt = 0; //승인금액
//모바일상품권 변수들


//멤버스포인트 변수들
var akmem_card_fg = "";
var akmem_card_no = "";
var akmem_card_rfFlag = "";
var akmem_card_cvm = "";
var akmem_card_onlineYN = "";
var akmem_card_cardNo = "";
var akmem_card_modelNo = "";
var akmem_card_encDtCnt = "";
var akmem_card_vanCode = "";
var akmem_card_encGubun = "";
var akmem_card_ksn = "";
var akmem_card_encData = "";
var akmem_card_vanCode1 = "";
var akmem_card_encGubun1 = "";
var akmem_card_ksn1 = "";
var akmem_card_encData1 = "";
var akmem_card_vanCode2 = "";
var akmem_card_encGubun2 = "";
var akmem_card_ksn2 = "";
var akmem_card_encData2 = "";
var akmem_card_vanCode3 = "";
var akmem_card_encGubun3 = "";
var akmem_card_ksn3 = "";
var akmem_card_encData3 = "";
var akmem_card_vanCode4 = "";
var akmem_card_encGubun4 = "";
var akmem_card_ksn4 = "";
var akmem_card_encData4 = "";
var akmem_card_encCardNo_send_str = ""; //암호화된 카드번호
var akmem_card_type_nm = "";
var akmem_card_co_origin_seq = "";
var akmem_total_point = 0;
var akmem_use_min_point = 0;
var akmem_use_max_point = 0;
var akmem_use_hurdle = 0;
var akmem_cust_grade = "";
var akmem_sApprovNo = "";
var akmem_use_sApprovNo = ""; //마일리지 사용요청 결과

var akmem_cust_no = "";

var akmem_resp_no = "";
var akmem_resp_msg = "";
var akmem_family_cust_no = "";
var akmem_cust_name = "";
var akmem_cust_level = "";
var akmem_regi_card_yn = "";
var akmem_regi_card_no = "";
var akmem_use_yn = "";

var akmem_card_fallback_gubun = "";
var akmem_card_fallback_reason = "";

var akmem_card_hide_card_no = "";

var akmem_card_no = ""; //사용자눈에 보이는 그 카드번호
var akmem_pswd = ""; //멤버스카드 비밀번호

var ls_akmem_send_str = "";

var akmem_recpt_point = ""; //적립 마일리지


var akmem_save_approve_no = "";
var akmem_save_approve_no_pos = "";
var akmem_save_approve_no_point = "";

var point_amt = 0; //포인트 사용금액
var point_approve_yn = "N"; //포인트 사용여부. 기존화면에서 포인트 사용 누르면 이거 Y로 바꿈

//멤버스포인트 변수들


//카드결제 변수들
var ic_card_emv = "";
var ic_card_sign = "";
var ic_card_month = "";
var ic_card_valid = "0000"; // IC단말기 유효기간정보 받지 않음(추후 APP카드로 인해 변경가능) 여전법 이후
var ic_card_rfFlag = "";
var ic_card_cvm = "";
var ic_card_onlineYN = "";
var ic_card_cardNo = "";
var ic_card_modelNo = "";
var ic_card_encDtCnt = "";
var ic_card_vanCode = "";
var ic_card_encGubun = "";
var ic_card_ksn = "";
var ic_card_encData = "";
var ic_card_vanCode1 = "";
var ic_card_encGubun1 = "";
var ic_card_ksn1 = "";
var ic_card_encData1 = "";
var ic_card_vanCode2 = "";
var ic_card_encGubun2 = "";
var ic_card_ksn2 = "";
var ic_card_encData2 = "";
var ic_card_vanCode3 = "";
var ic_card_encGubun3 = "";
var ic_card_ksn3 = "";
var ic_card_encData3 = "";
var ic_card_vanCode4 = "";
var ic_card_encGubun4 = "";
var ic_card_ksn4 = "";
var ic_card_encData4 = "";
var ic_card_encCardNo_send_str = "";

var ic_card_cardFlag1 = "";
var ic_card_cardFlag2 = "";
var ic_card_cardFlag3 = "";
var ic_card_cardFlag4 = "";

var ic_card_fallback_gubun = "";
var ic_card_fallback_reason = "";

var ic_card_hide_card_no = "";
var ic_card_hide_card_gubun = "";
var ic_card_no = ""; //사용자눈에 보이는 그 카드번호
var ic_card_flag = "";
var ic_card_nm = "";
var ic_card_co_origin_seq = "";
var ic_card_sain_fg = "";
var ic_card_pri_nm = "";

var ic_card_data_fg = "";

var ic_card_approve_no = "";
var ic_card_approve_message = "";
var ic_card_rest_amt = "";
var ic_card_rate = "";
var ic_card_return_cd = "";

var ic_ls_send_str = "";
var ic_ls_send_str_F = "";

var is_wcc = "";
var signText = "";
var signT = "";
//카드결제 변수들


//BC QR 변수들
var bc_qr_value = "";
//BC QR 변수들


var recpt_no = "";

var md = "";
var op = "";
var goods = "";

var point_cash = 0;
var point_aksincard = 0;
var point_aksamcard = 0;
var point_card = 0;
var point_coupon = 0;
var point_mcoupon = 0;
var point_akkbcard = 0;
var point_akwbcard = 0;

var pay_akcoupon = 0; //뭔지모르겠다.

var isSuc = true; //ajax에서는 return을 쓸수없기때문에 이걸 쓴다

function saleInit()
{
	if($("#selBranch").val() == "01") {
		md = "090031";
		op = "0001";	
		goods = "09003100001130";
	}else if($("#selBranch").val() == "02") {
		md = "090033";
		op = "0001";
		goods = "09003300001130";
	}else if($("#selBranch").val() == "03") {
		md = "090012";
		op = "0001";
		goods = "09001200012238";
	}else if($("#selBranch").val() == "04") { 
		md = "000152";
		op = "0001";
		goods = "00015200011201";
	}else if($("#selBranch").val() == "05") {
		md = "000246";
		op = "0001";
		goods = "00024600012001";
	}
	getMemberPay();
}
function getMemberPay() {
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/getMemberPay",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			point_cash = result.CASH;
			point_aksincard = result.AKSINCARD;
			point_aksamcard = result.AKSAMCARD;
			point_card = result.CARD;
			point_coupon = result.COUPON;
			point_mcoupon = result.MCOUPON;
			point_akkbcard = result.AKKBCARD;
			point_akwbcard = 0;
		}
	});
	
	
}	//getMemberPay()
function openMCouponLayer()
{
	javascript:$('#mcoupon_layer').fadeIn(200);
	$("#mcouponLayer_final_pay").val(eval(nullCheck(final_pay)));
}
function openCouponLayer()
{
	javascript:$('#coupon_layer').fadeIn(200);
}
function openCashLayer()
{
	$('#cash_layer').fadeIn(200);
	cash_amt = Number($("#cash_amt").val());
	
	if ((ic_card_co_origin_seq == "555") || (ic_card_co_origin_seq == "666")) {
		cash_amt = eval(nullCheck(cash_amt)) 
		         + eval(nullCheck(coupon_amt))	 
				 + eval(nullCheck(mcoupon_amt))  
				 + eval(nullCheck(card_amt))
				 - eval(nullCheck(cashrec_n_coupon)) ;	//2019.03.11 ljs : 증정상품권 현금영수증제외 금액 추가 
	}else {
		cash_amt = eval(nullCheck(cash_amt)) 
		         + eval(nullCheck(coupon_amt))	 
				 + eval(nullCheck(mcoupon_amt))  
				 - eval(nullCheck(cashrec_n_coupon)) ;//2019.03.11 ljs : 증정상품권 현금영수증제외 금액 추가  
	}
	$("#cashLayer_cash_amt").val(cash_amt);
}
//현금승인시 자동공제 버튼클릭시 호출
function auto_deduction()
{
	key_value = "0100001234";
	$("#cashLayer_key_value").val(key_value);
}

//현금승인시 keyIn 버튼 클릭
function cash_key_in()
{
	key_value = ""; //초기화
	key_value = keyInControl($('input[name="cashLayer_select_fg"]:checked').val());
	
	$("#cashLayer_key_value").val(key_value);
	
	if(key_value == ""){						
		return;
	}	
	
	if($('input[name="cashLayer_select_fg"]:checked').val() == "h_phone"){ //핸드폰번호
	}else if($('input[name="cashLayer_select_fg"]:checked').val() == "regis_no"){// 주민등록번호
	}else if($('input[name="cashLayer_select_fg"]:checked').val() == "biz_no"){//사업자등등록번호
	}else if($('input[name="cashLayer_select_fg"]:checked').val() == "card_no"){
	}	
}
function keyInControl(kIflag){
	var sD = "";
	var sE;
	var reVl = "";
	var ret; 
	// 단말 연결 확인
	var conTest = cardX.ReqReset();
	if(conTest <0){
		alert("단말기가 정상적으로 연결되지 않았습니다.");
		return "";
	}
	
	//서명패드 senddata 설정
	if(kIflag == "h_phone"){ //핸드폰번호
		sD = "#01"+11+"핸드폰번호를 입력 해 주세요.";

	}else if(kIflag == "card_no"){//카드번호
			sD = 	"0"					//거래 구분자	AN(1)	0 :  신용  , 1 : 교통 ,  2 : 신용 + 멤버쉽
				   +"0"					//거래 종류	AN(1)	0 :  구매  , 1 : 취소
				   +getTimeStamp()		//거래 일시	AN(14)	YYYYMMDDHHMMSS
				   +f_setfill(cash_amt,9,'L')			//거래 금액	AN(9)	Right Justfy
				   +f_setfill_zero(pos_no,8,'L') 			//단말기 ID	AN(8)	단말기 ID(TID) : 0 으로 Padding8자리가 넘는 경우 8자리까지만 사용
				   +"2"					//EMV PIN 설정	AN(1)	 1 : PIN 입력, 2 : PIN 입력 안 함 (ED-946 은 사용안함) 3 : 은련만 PIN 입력
				   +"1"				    //Card Input 설정	AN(1)	1 : MS/IC, 2 : Only MS, 3 : Only IC( 기능 Disable ) 4 :KEYIN : 서명패드 에서 지원
				   +"1"					//"EMV MS거래 허용 여부	AN(1)	 1 : MS 거래허용, 2 : MS 거래불가( 기능 Disable )
				   +f_setfill("21",16,'R')				//SEED DATA	AN(16)	RANDOM DATA	
				 //  +"03"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
				 //  +"140000200300944541";				//카드사 BIN 	AN(6xN)	RANDOM DATA	
				+"05"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩   
			    +"140000200300944541942150451842"; 	//kicc(6) + 유통키(6) + 국민(6) + 비씨(6)+ 신한(6)    
		
	}else if(kIflag == "regis_no"){// 주민등록번호
		sD = "#01"+13+"주민등록번호를 입력 해 주세요.";
	}else if(kIflag == "biz_no"){//사업자등등록번호
		sD = "#01"+10+"사업자등록번호를 입력 해 주세요.";			
	}
	// 단말 호출
	if(kIflag == "card_no"){

		ret = cardX.ReqCmd( 0xFB, 0x11, 0x20, sD, sE);
		ret = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "현금영수증 카드처리중입니다.", sE);

		var caVl = cardX.RcvData;
		
		
		//카드데이터 parse setting
		//model.makeValue("/root/data/danmal_data/caVl",caVl);
		cash_card_rfFlag = caVl.substring(0,4);
		cash_card_cardFlag = caVl.substring(0,4);
		cash_card_modelNo = caVl.substring(46,54);
		cash_card_encDtCnt = caVl.substring(54,56);
		cash_card_encGubun = caVl.substring(62,64);
		cash_card_ksn = caVl.substring(64,84);
		cash_card_encData = caVl.substring(84,148); 
		
		cash_card_ksn1 = caVl.substring(156,176);
		cash_card_encData1 = caVl.substring(176,240); 
		
		cash_card_cardFlag1 = cash_card_cardFlag.substring(0,1);
		cash_card_cardFlag2 = cash_card_cardFlag.substring(1,2);
		cash_card_cardFlag3 = cash_card_cardFlag.substring(2,3);
		cash_card_cardFlag4 = cash_card_cardFlag.substring(3,4);
		
		
		//fallback check 및 IC 체크
		if(ret > -1 && (cash_card_rfFlag.substring(0,1) =="C" 
			|| cash_card_rfFlag.substring(0,2) =="MF"
			|| cash_card_encDtCnt != "00")){
				alert("IC카드로 현금영수증 등록을 할 수 없습니다.");
				return;
//				model.makeValue("/root/data/fallback/gubun", ic_card_cardFlag2);
//				model.makeValue("/root/data/fallback/reason", "0"+ic_card_cardFlag3);

				
//			var fbrs = ic_card_fallback_reason;
//			if(!(fbrs=="01" ||fbrs=="02" ||fbrs=="03" ||fbrs=="04" ||fbrs=="05" ||fbrs=="06" ||fbrs=="07")){
//				alert("비정상 F/B 입니다. \n카드등록을 다시 해주세요.");
//				return; 
//			}
		}	
		//카드번호 parse setting
		reVl = caVl.substring(6,caVl.indexOf("="));
	}else{
		ret =  cardX.ReqCmd( 0xC3, 0, 0, sD, sE);
		ret =  cardX.WaitCmd( 0xC5, 0x00, 1000, 1, "현금영수증 인식번호를 입력중입니다.", sE);
		//서명패드 입력값 세팅
		reVl = cardX.RcvData;
	}	

	if(ret < 0){
		cardX.ReqReset();
		alert(cardX.ErrMsg);
		if(kIflag=="card_no" )
		{
			$("#cashLayer_key_value").attr("readOnly", true);
		}else{
			$("#cashLayer_key_value").attr("readOnly", false);
		}
		return "";
	} else {
		//alert(cardX.RcvData);
		cardDanMemReset();
		return reVl;
	}

}
function cash_approveCheck() {
	
	var is_id_fg = ""; 
	if ($('input[name="cashLayer_select_fg"]:checked').val() == "h_phone") 
	{
		is_wcc = "@";
		is_id_fg = "2";
	}
	else if ($('input[name="cashLayer_select_fg"]:checked').val() == "card_no")
	{
		is_wcc = "I";
		is_id_fg = "1";	
	}
	else if ($('input[name="cashLayer_select_fg"]:checked').val() == "regis_no")
	{
		is_wcc = "@";
		is_id_fg = "3";
	}
	else if ($('input[name="cashLayer_select_fg"]:checked').val() == "biz_no")
	{
		if ($('input[name="cashLayer_deduction"]:checked').val() == "0") {
			alert("소득공제인 경우 사업자등록번호를 입력할 수 없습니다.");
			return;
		}
		else
		{
			is_wcc = "@";
			is_id_fg = "4";			
		}
	}
	
	
	//전문생성
	var	amt = 0;
	var	ls_send_programID = "XB077S"; //여전법 이후 XA077S =>XB077S 로 변경 18.01.30
	var	KFTC_TERM_ID = "9047000000"
	var	NICE_TERM_ID = "9540030001"
	var	KICC_TERM_ID = "104504    "
	var 	pinData = ""; //BBBB  기존 > 여전법 이후 "     "? 현금영수증은 사업자 기준으로 처리로 BBBB, CCCC, "    " 중 뭐가 들어가도 상관없음
	var 	cardLen = "";
	var amt			= cash_amt.toString();
	
	//08.07월 부터 현금은 모두 영수증 발행 필수
	if(parseInt(amt) < 1) {						
		alert("현금 결재내역이 없습니다.");
		return;
	}

	s			= 11 - amt.length;
	amt			= fill("0", s) + amt.toString();
	
	

	//ls_valid = "0000";여전법이전
	ls_card_corp_cd = "000";
	ls_vat = "00000000000";					
	//ls_cust = model.getValue("/root/req/key_value"); 미사용
	//ls_data1 = f_setfill( ls_cust + "=" + ls_valid, 37, "R"); 여전법이후 변경
	ls_data1 = key_value;
	
	if(is_wcc != "@"){ //카드번호 key-in ic카드일 경우
		ls_data1 = "SECU"+cash_card_modelNo
						+cash_card_encGubun
						+cash_card_ksn
						+cash_card_encData; 
		
		cardLen = "098"//f_setfill_zero(eval(ls_data1.length).toString(),3,'L');		
		ls_card_corp_cd = "000";
		//매상등록 사용 카드번호 복호화 전문생성
		//encCardNoSendStr();
	}	
	
	if(cash_card_rfFlag == "MF"){
		is_wcc = "F";
	}else if(trim(cash_card_rfFlag) == "M"){
		ls_data1 = key_value; 
		is_wcc = "A";
	}

	store = $("#selBranch").val()
	
	if(store == "01") {
		ls_saupja = "1138107313";
	} else if(store == "02") {
		ls_saupja = "1248128579";						
	} else if(store == "03") {
		ls_saupja = "1298542346";
	} else if(store == "04") {
		ls_saupja = "1258124085";
	} else if(store == "05") {
		ls_saupja = "2248523362";
	}

	//product = ls_send_programID +"0000"+ space(36);
	  product = ls_send_programID + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
	//-------여전법이전----------------------------------------------------------//
	// 본부코드[2] + 점코드[2] + POS번호[6] + 영수증번호[4] +            		 //  
	// CardCheckBillFg[2] + WCC[1] + Length[2]  + CardsqNo[3] +	        		 //
	// 카드데이터[37] + 할부개월[2] + 금액[11]   + PIN_DATA(PASSWORD)[4]      	 // 
	//-------여전법이후---------------------------------------------------------------- //
	// 본부코드[2]+점포코드[2]+POS번호[6]+영수증번호[4]          		                //  
	// CARD/수표구분[2]+WCC[1]+카드길이[3]+카드사고유일련번호[3]+	        			//							
	// 카드번호(암호화)[98]+할부개월[2]+사업자번호[10]+부가세[11]+금액[11]+PIN_DATA[4]+ //
	// 승인번호[8]+승인일자[6]+FILLER[35] 												//			
	//----------------------------------------------------------------------------------//
	var is_issue_fg = "";
	var is_inst_nm = "";
	
	if ($('input[name="cashLayer_deduction"]:checked').val() == "0") {
		is_issue_fg = "1";
		is_inst_nm = "01";
	} else if ($('input[name="cashLayer_deduction"]:checked').val() == "1") {
		is_issue_fg = "2";
		is_inst_nm = "02";
	}
	
	ls_data1 = ls_data1.replace(/[^0-9]/g,'');
	ls_send_str = '00' + store + pos_no + "0000"
		         + "21"  + is_wcc + f_setfill(cardLen,3,'R') + f_setfill(ls_card_corp_cd,3,'R')
		         + f_setfill(ls_data1,98,'R') + is_inst_nm + ls_saupja + ls_vat + amt +  f_setfill(pinData,4,'R')
		         + fill("",8) + fill("",6) +  fill("",35)  ;
	ls_send_str = product + ls_send_str;		
	ls_send_str = f_setfill(ls_send_str, 1024, "R");
	

	cash_ls_send_str = ls_send_str;
	
	//현금영수증승인 Transaction
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetApproveNo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			ls_send_str : cash_ls_send_str,
			hq : '00',
			store : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			cash_approve_no = result.approve_no;
			$("#cashLayer_approve_no").val(cash_approve_no);
			cash_bank_cd = result.bank_cd;
			cash_rate = result.rate;
			cash_message = result.message;
			cash_issue_fg = is_issue_fg;
			cash_id_fg = is_id_fg;
			cash_id_no = key_value;
			cash_approve_amt = cash_amt;
		}
	});
}
function setCouponGrid()
{
	var isEmpty = "N";
	$("[name='couponLayer_coupon_no']").each(function() 
	{
		if($(this).val() == "")
		{
			alert("상품권번호를 입력해주세요.");
			isEmpty = "Y";
			return false;
		}
	});
	if(isEmpty == "Y")
	{
		return false;
	}
	$("[name='couponLayer_face_amt']").each(function() 
	{
		if($(this).val() == "")
		{
			alert("액면금액을 입력해주세요.");
			isEmpty = "Y";
			return false;
		}
	});
	if(isEmpty == "Y")
	{
		return false;
	}
	$("[name='couponLayer_cashrec_yn']").each(function() 
	{
		if($(this).val() == "")
		{
			alert("현금영수증 100% 여부를 입력해주세요.");
			isEmpty = "Y";
			return false;
		}
	});
	if(isEmpty == "Y")
	{
		return false;
	}
	$("[name='couponLayer_vat_cal_ext_rate']").each(function() 
	{
		if($(this).val() == "")
		{
			alert("부가세 제외 비율을 입력해주세요.");
			isEmpty = "Y";
			return false;
		}
	});
	if(isEmpty == "Y")
	{
		return false;
	}
	$("[name='couponLayer_vat_cal_rate']").each(function() 
	{
		if($(this).val() == "")
		{
			alert("부가세 비율을 입력해주세요.");
			isEmpty = "Y";
			return false;
		}
	});
	if(isEmpty == "Y")
	{
		return false;
	}
//	$("[name='couponLayer_cp_chage_amt']").each(function() 
//	{
//		if($(this).val() == "")
//		{
//			alert("검스름돈을 입력해주세요.");
//			isEmpty = "Y";
//			return false;
//		}
//	});
//	if(isEmpty == "Y")
//	{
//		return false;
//	}
//	$("[name='couponLayer_cp_chage_apy_y_amt']").each(function() 
//	{
//		if($(this).val() == "")
//		{
//			alert("검스름돈 적용 영수증 대상금액을 입력해주세요.");
//			isEmpty = "Y";
//			return false;
//		}
//	});
//	if(isEmpty == "Y")
//	{
//		return false;
//	}
//	$("[name='couponLayer_cp_chage_apy_n_amt']").each(function() 
//	{
//		if($(this).val() == "")
//		{
//			alert("거스름돈 적용 영수증 미대상 금액을 입력해주세요.");
//			isEmpty = "Y";
//			return false;
//		}
//	});
//	if(isEmpty == "Y")
//	{
//		return false;
//	}
//	$("[name='couponLayer_cashrec_amt']").each(function() 
//	{
//		if($(this).val() == "")
//		{
//			alert("현금영수증 대상 금액을 입력해주세요.");
//			isEmpty = "Y";
//		}
//	});
//	if(isEmpty == "Y")
//	{
//		return false;
//	}
//	$("[name='couponLayer_cashrec_n_amt']").each(function() 
//	{
//		if($(this).val() == "")
//		{
//			alert("현금영수증 미대상 금액을 입력해주세요.");
//			isEmpty = "Y";
//			return false;
//		}
//	});
//	if(isEmpty == "Y")
//	{
//		return false;
//	}
	if(isEmpty == "N")
	{
		coupon_fg_arr = "";
		coupon_cd_arr = "";
		coupon_no_arr = "";
		face_amt_arr = "";
		cashrec_yn_arr = "";
		vat_cal_ext_rate_arr = "";
		vat_cal_rate_arr = "";
		cp_change_amt_arr = "";
		cp_chage_apy_y_amt_arr = "";
		cp_chage_apy_n_amt_arr = "";
		cashrec_amt_arr = "";
		cashrec_n_amt_arr = "";
		$("[name='couponLayer_coupon_fg']").each(function() 
		{
			coupon_fg_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_coupon_cd']").each(function() 
		{
			coupon_cd_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_coupon_no']").each(function() 
		{
			coupon_no_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_face_amt']").each(function() 
		{
			face_amt_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_cashrec_yn']").each(function() 
		{
			cashrec_yn_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_vat_cal_ext_rate']").each(function() 
		{
			vat_cal_ext_rate_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_vat_cal_rate']").each(function() 
		{
			vat_cal_rate_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_cp_chage_amt']").each(function() 
		{
			cp_change_amt_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_cp_chage_apy_y_amt']").each(function() 
		{
			cp_chage_apy_y_amt_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_cp_chage_apy_n_amt']").each(function() 
		{
			cp_chage_apy_n_amt_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_cashrec_amt']").each(function() 
		{
			cashrec_amt_arr += $(this).val()+"|";
		});
		$("[name='couponLayer_cashrec_n_amt']").each(function() 
		{
			cashrec_n_amt_arr += $(this).val()+"|";
		});
		$('#coupon_layer').fadeOut(200);
	}
	eventPayFg();
}

function eventPayFg() {
	//2019.03.11 ljs 사용마일리지(point_amt), 증정상품권구분하여 금액설정 추가 (금액처리 우선순위 : 마일리지>쿠폰 > 지불라디오 버튼 값) START  
	var akmemPointApproveYn = point_approve_yn;
	var akPointAmt = 0;
	var remainAmt = eval(nullCheck(final_pay));
	
	var couponAmt = 0;
	var cashrecNCoupon = 0;  //영수증출력시 "자사증정-현금영수증제외" 금액으로 사용
	var cashrecYCoupon = 0;  //현금영수증(BASale0203.xrw)계산시 쿠폰 대상금액으로 사용
	
    if(akmemPointApproveYn != null && akmemPointApproveYn != '' && akmemPointApproveYn == "Y") 
	{
		akPointAmt = point_amt;
		remainAmt = eval(remainAmt) - eval(nullCheck(akPointAmt));  //마일리지적용
    } 
    
    
    var coupon_fg_split = coupon_fg_arr.split("|");
    var coupon_cd_split = coupon_cd_arr.split("|");
    var coupon_no_split = coupon_no_arr.split("|");
    var face_amt_split = face_amt_arr.split("|");
    var cashrec_yn_split = cashrec_yn_arr.split("|");
    var vat_cal_ext_rate_split = vat_cal_ext_rate_arr.split("|");
    var vat_cal_rate_split = vat_cal_rate_arr.split("|");
    var cp_change_amt_split = cp_change_amt_arr.split("|");
    var cp_chage_apy_y_amt_split = cp_chage_apy_y_amt_arr.split("|");
    var cp_chage_apy_n_amt_split = cp_chage_apy_n_amt_arr.split("|");
    var cashrec_amt_split = cashrec_amt_arr.split("|");
    var cashrec_n_amt_split = cashrec_n_amt_arr.split("|");
    
    
	
    var coupon_cnt = coupon_fg_split.length -1;
	if(coupon_cnt > 0) 
	{
		if(remainAmt == 0)
		{
			alert("총 결제금액을 마일리지로 모두 선택하셨습니다.");
			//상품권그리드 초기화
			$("#target_coupon").html("");
		}
		
		/*******************************************************************************************
			2019.04.08 상품권 현금영수증 대상관련 요구사항(전달받은 사항-권오현부장님, 김성근이사님)
			1. 타사상품권 : 현금영수증 100% 적용
			2. 자사(증정 포함) 상품권 : [사용처 != 발행법인]인 경우 현금영수증 100% 적용
			3. 자사(증정 포함) 상품권 : [사용처 == 발행법인]인 경우 부가세제외비율을 제외한 금액 적용
			4. 거스름돈이 발생하는 경우 : 발생한 거스름돈 제외한 금액만큼 현금영수증 적용
			5. 금액처리 : 소수점이하 절사, 원단위 10원단위로 처리 (2019.04.10 정홍규차장님) 
			예) [결제금액 상품권으로 100% 결제하는 기준] 
			    상품권 10,000원, 결제금액 9,990원, 부가세제외비율 57% 인 경우
			    상품권 현금영수증 대상금액 = 결제금액 X 부가세비율 
				                           = 9,990원 X 43% = 4295.7원 ==(원단위절사적용)==> 4,290원
				상품권 현금영수증 제외금액 = 결제금액 - 상품권 현금영수증 대상금액(원단위절사적용)
				                           = 9,990원 - 4,290원 = 5,700원
		*******************************************************************************************/
		if( remainAmt > 0 )
		{   
			for(var i = 0; i < coupon_cnt; i++)
			{
				couponAmt += nullCheck(face_amt_split[i]);
			}
			remainAmt = eval(nullCheck(remainAmt)) - eval(nullCheck(couponAmt));  //쿠폰금액적용
			
			//거스름돈 반영된 현금영수증 대상금액 산정
			var faceAmtSum = 0;
			var maxChageApyAmt = 0;   //거스름돈 적용시 현금영수증금액이 가장 큰 금액
			
			var c_coupon_fg = null;
			var c_coupon_cd = null;
			var c_coupon_no = null;
			var c_face_amt = 0;
			var c_cashrec_yn = null;
			var c_vat_cal_ext_rate = 0;
			var c_vat_cal_rate = 0;
			var c_cp_chage_amt = 0;
			var c_cp_chage_apy_y_amt = 0;
			var c_cp_chage_apy_n_amt = 0;
			var c_cashrec_amt = 0;	
			var c_cashrec_n_amt = 0;
			
			for(var i = 0; i < coupon_cnt; i++)
			{
				if( face_amt_split[i] != null
				    && face_amt_split[i] != ""
					&& coupon_no_split[i] != null
				    && coupon_no_split[i] != ""
				  )
				{
					var faceAmt      = face_amt_split[i];
					var cashrec_yn   = cashrec_yn_split[i];
					var vat_cal_rate = vat_cal_rate_split[i];

					//alert("i ==>" + i + "[거스름돈 처리전]remainAmt[" + remainAmt + "] faceAmt[" + faceAmt  + "]");
				
					/******************************************************************
					** 2019.04.18 ljs 권오현부장님 전달사항 반영
					거스름돈 발생시 비율계산시 현금영수증금액이 가장 큰 금액에 적용	
					공식 : 거스름돈 미포함 계산 - 거스름돈 포함 계산 = 차액이 가장 작은 값에 거스름돈 적용
							상품권금액이 거스름돈보다 작은 경우는 거스름돈 적용대상에서 제외
					*******************************************************************/
					/**** 0. 거스름돈관련 쿠폰필드 초기화 ****/


//					cp_change_amt_split[i] = 0;
//					cp_chage_apy_n_amt_split[i] = 0;
//					cp_chage_apy_y_amt_split[i] = 0;	
//					cashrec_n_amt_split[i] = 0;
//					cashrec_amt_split[i] = 0;
				
					/**** 1. 거스름돈 미포함 부가세제외비율적용 *****/
					if(faceAmt >= 0)
					{
						//자사(증정)사용 상품권(사용처 == 발행법인 이면 부가세제외비율을 제외한 금액적용)
						if(((cashrec_yn != null ) || (trim(cashrec_yn) != "" )) && cashrec_yn == "N") 
						{ 
							var cashrecYAmt = parseInt(parseInt(faceAmt * (vat_cal_rate/100)) * 0.1) * 10 ;
							var cashrecNAmt = parseInt(faceAmt - cashrecYAmt);
				        
							//alert("[부가세비율반영]vat_cal_rate[" + vat_cal_rate + "] faceAmt[" + faceAmt 
							//+ "] cashrecNAmt[" + cashrecNAmt + "] cashrecYAmt[" + cashrecYAmt + "]");
					
							cashrec_n_amt_split[i] = cashrecNAmt;
							cashrec_amt_split[i] = cashrecYAmt;
						} //이외 현금영수증 100% 적용
						else
						{
							cashrec_n_amt_split[i] = 0;
							cashrec_amt_split[i] = faceAmt;

							//alert("[현금영수증100]vat_cal_rate[" + vat_cal_rate_split[i] + "] faceAmt[" + faceAmt 
							//+ "] cashrecNAmt[" + cashrec_n_amt_split[i] 
							//+ "] cashrecYAmt[" + cashrec_amt_split[i] + "]");
						}
					}
					else if(faceAmt < 0)
					{
						cashrec_n_amt_split[i] = 0;
						cashrec_amt_split[i] = 0;
						
						//alert("[faceAmt <0] vat_cal_rate[" + vat_cal_rate_split[i] + "] faceAmt[" + faceAmt 
						//+ "] cashrecNAmt[" + cashrec_n_amt_split[i] 
						//+ "] cashrecYAmt[" + cashrec_amt_split[i] + "]");
					}										
				
					/**** 2. 거스름돈 포함 부가세제외비율적용 *****/
					//거스름돈 발생
					if( remainAmt < 0 )
					{
						cp_change_amt_split[i] = remainAmt;
						faceAmt = parseInt(faceAmt) + parseInt(remainAmt); 
					
						//alert("[거스름돈 포함 부가세제외비율]remainAmt[" + remainAmt + "] faceAmt[" + faceAmt  + "]");
				
						if(faceAmt >= 0)
						{
							//자사(증정)사용 상품권(사용처 == 발행법인 이면 부가세제외비율을 제외한 금액적용)
							if(((cashrec_yn != null ) || (trim(cashrec_yn) != "" )) && cashrec_yn == "N") 
							{ 
								var cashrecYAmt = parseInt(parseInt(faceAmt * (vat_cal_rate/100)) * 0.1) * 10 ;
								var cashrecNAmt = parseInt(faceAmt - cashrecYAmt);
								var reCashrecYAmt = cashrec_amt_split[i];
								var resultAmt = parseInt(reCashrecYAmt - cashrecYAmt);

								//alert("[거스름부가세비율반영 전]maxChageApyAmt[" + maxChageApyAmt + "] cashrecYAmt[" + cashrecYAmt + "] resultAmt[" + resultAmt +"]");
							 
								// 거스름돈미포함 계산 - 거스름돈포함 => 가장 작은 값에 거스름돈 반영
								if(i == 0 && cashrecYAmt >= 0 )
								{
									maxChageApyAmt = resultAmt;
									cp_chage_apy_n_amt_split[i] = cashrecNAmt;
									cp_chage_apy_y_amt_split[i] = cashrecYAmt;
								
								//alert("[거스름부가세비율반영1]cp_chage_apy_n_amt[" + cp_chage_apy_n_amt_split[i]
								//     + "] cp_chage_apy_y_amt[" + cp_chage_apy_y_amt_split[i] +"]");												
								}
							
								if( (i != 0 && cashrecYAmt >= 0 ) && (maxChageApyAmt == 0 || maxChageApyAmt > resultAmt) )	
								{
									maxChageApyAmt = resultAmt;
									cp_chage_apy_n_amt_split[i] = cashrecNAmt;
									cp_chage_apy_y_amt_split[i] = cashrecYAmt;	

								//alert("[거스름부가세비율반영1-1]cp_chage_apy_n_amt[" + cp_chage_apy_n_amt_split[i]
								//      + "] cp_chage_apy_y_amt[" + cp_chage_apy_y_amt_split[i] +"]");

									c_coupon_fg          = coupon_fg_split[i];
									c_coupon_cd          = coupon_cd_split[i];
									c_coupon_no          = coupon_no_split[i];
									c_face_amt           = face_amt_split[i];
									c_cashrec_yn         = cashrec_yn_split[i];
									c_vat_cal_ext_rate   = vat_cal_ext_rate_split[i];
									c_vat_cal_rate       = vat_cal_rate_split[i];
									c_cp_chage_amt       = cp_change_amt_split[i];
									c_cp_chage_apy_y_amt = cp_chage_apy_y_amt_split[i];
									c_cp_chage_apy_n_amt = cp_chage_apy_n_amt_split[i];
									c_cashrec_amt        = cashrec_amt_split[i];	
									c_cashrec_n_amt      = cashrec_n_amt_split[i];	
								
									//alert("거스름부가세비율반영2 i[" + i 
									//	+          "] c_coupon_fg[" +          c_coupon_fg +    "] c_coupon_cd[" +    c_coupon_cd +          "] c_coupon_no[" + c_coupon_no 
									//	+           "] c_face_amt[" +           c_face_amt  +  "] c_cashrec_yn[" +   c_cashrec_yn +   "] c_vat_cal_ext_rate[" + c_vat_cal_ext_rate  
									//	+       "] c_vat_cal_rate[" +       c_vat_cal_rate + "] c_cp_chage_amt[" + c_cp_chage_amt + "] c_cp_chage_apy_y_amt[" + c_cp_chage_apy_y_amt
									//	+ "] c_cp_chage_apy_n_amt[" + c_cp_chage_apy_n_amt +  "] c_cashrec_amt[" +  c_cashrec_amt +      "] c_cashrec_n_amt[" + c_cashrec_n_amt + "]");									

									coupon_fg_split[i]          = coupon_fg_split[0];
									coupon_cd_split[i]         = coupon_cd_split[0];
									coupon_no_split[i]          = coupon_no_split[0];
									face_amt_split[i]           = face_amt_split[0];
									cashrec_yn_split[i]         = cashrec_yn_split[0];
									vat_cal_ext_rate_split[i]   = vat_cal_ext_rate_split[0];
									vat_cal_rate_split[i]       = vat_cal_rate_split[0];
									cp_change_amt_split[i]       = cp_change_amt_split[0];
									cp_chage_apy_y_amt_split[i] = 0;
									cp_chage_apy_n_amt_split[i] = 0;
									cashrec_amt_split[i]        = cashrec_amt_split[0];
									cashrec_n_amt_split[i]      = cashrec_n_amt_split[0];
								
									/*
									alert("[거스름부가세비율반영3]gridCoupon.valueMatrix(i, gridCoupon.colRef(coupon_fg))[" + coupon_fg_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(coupon_cd))[" + coupon_cd_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(coupon_no))[" + coupon_no_split[i] 
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(face_amt))[" + face_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cashrec_yn))[" + cashrec_yn_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(vat_cal_ext_rate))[" + vat_cal_ext_rate_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(vat_cal_rate))[" + vat_cal_rate_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cp_chage_amt))[" + cp_change_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cp_chage_apy_y_amt))[" + cp_chage_apy_y_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cp_chage_apy_n_amt))[" + cp_chage_apy_n_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cashrec_amt))[" + cashrec_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cashrec_n_amt))[" + cashrec_n_amt_split[i]									
									+"]");
									*/
								
									coupon_fg_split[0]          = c_coupon_fg;
									coupon_cd_split[0]          = c_coupon_cd;
									coupon_no_split[0]          = c_coupon_no;
									face_amt_split[0]           = c_face_amt;
									cashrec_yn_split[0]         = c_cashrec_yn;
									vat_cal_ext_rate_split[0]   = c_vat_cal_ext_rate;
									vat_cal_rate_split[0]       = c_vat_cal_rate;
									cp_change_amt_split[0]       = c_cp_chage_amt;
									cp_chage_apy_y_amt_split[0] = c_cp_chage_apy_y_amt;
									cp_chage_apy_n_amt_split[0] = c_cp_chage_apy_n_amt;
									cashrec_amt_split[0]        = c_cashrec_amt;
									cashrec_n_amt_split[0]      = c_cashrec_n_amt;
								
									/*
									alert("[거스름부가세비율반영4]gridCoupon.valueMatrix(1, gridCoupon.colRef(coupon_fg))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("coupon_fg"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(coupon_cd))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("coupon_cd")) 
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(coupon_no))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("coupon_no")) 
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(face_amt))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("face_amt"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cashrec_yn))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("cashrec_yn"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(vat_cal_ext_rate))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("vat_cal_ext_rate"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(vat_cal_rate))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("vat_cal_rate"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cp_chage_amt))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("cp_chage_amt"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cp_chage_apy_y_amt))[" + cp_chage_apy_y_amt_split[0]
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cp_chage_apy_n_amt))[" + cp_chage_apy_n_amt_split[0]
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cashrec_amt))[" + cashrec_amt_split[0]
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cashrec_n_amt))[" + cashrec_n_amt_split[0]									
									+"]");
									*/
								
									c_coupon_fg = null;
									c_coupon_cd = null;
									c_coupon_no = null;
									c_face_amt = 0;
									c_cashrec_yn = null;
									c_vat_cal_ext_rate = 0;
									c_vat_cal_rate = 0;
									c_cp_chage_amt = 0;
									c_cp_chage_apy_y_amt = 0;
									c_cp_chage_apy_n_amt = 0;
									c_cashrec_amt = 0;
									c_cashrec_n_amt = 0;
								}
							} //이외 현금영수증 100% 적용
							else
							{
								var reCashrecYAmt = cashrec_amt_split[i];
								var resultAmt = parseInt(reCashrecYAmt - faceAmt);
							
								// 거스름돈미포함 계산 - 거스름돈포함 => 가장 작은 값에 거스름돈 반영
								if(i == 0 && faceAmt >= 0 )
								{
									maxChageApyAmt = resultAmt;
									cp_chage_apy_n_amt_split[i] = 0;
									cp_chage_apy_y_amt_split[i] = faceAmt;
								}
							
								//alert("[거스름현금영수증100 전]maxChageApyAmt[" + maxChageApyAmt + "] faceAmt[" + faceAmt +"]");
							
								if( (i != 0 && faceAmt >= 0 ) && (maxChageApyAmt == 0 || maxChageApyAmt > resultAmt) )	
								{
									maxChageApyAmt = resultAmt;
									cp_chage_apy_n_amt_split[i] = 0;
									cp_chage_apy_y_amt_split[i] = faceAmt;												
								
									c_coupon_fg          = coupon_fg_split[i];
									c_coupon_cd          = coupon_cd_split[i];
									c_coupon_no          = coupon_no_split[i];
									c_face_amt           = face_amt_split[i];
									c_cashrec_yn         = cashrec_yn_split[i];
									c_vat_cal_ext_rate   = vat_cal_ext_rate_split[i];
									c_vat_cal_rate       = vat_cal_rate_split[i];
									c_cp_chage_amt       = cp_change_amt_split[i];
									c_cp_chage_apy_y_amt = cp_chage_apy_y_amt_split[i];
									c_cp_chage_apy_n_amt = cp_chage_apy_n_amt_split[i];
									c_cashrec_amt        = cashrec_amt_split[i];
									c_cashrec_n_amt      = cashrec_n_amt_split[i];
								
									/*
									alert("[거스름현금영수증100 1]maxChageApyAmt[" + maxChageApyAmt + "] c_cp_chage_apy_y_amt[" + c_cp_chage_apy_y_amt 
								    + "] c_cp_chage_apy_n_amt[" + c_cp_chage_apy_n_amt 
									+ "] c_cashrec_amt[" + c_cashrec_amt + "] c_cashrec_n_amt[" + c_cashrec_n_amt + "]");
									
									alert("거스름현금영수증100 i[" + i 
									+          "] c_coupon_fg[" +          c_coupon_fg +    "] c_coupon_cd[" +    c_coupon_cd +          "] c_coupon_no[" + c_coupon_no 
									+           "] c_face_amt[" +           c_face_amt  +  "] c_cashrec_yn[" +   c_cashrec_yn +   "] c_vat_cal_ext_rate[" + c_vat_cal_ext_rate  
									+       "] c_vat_cal_rate[" +       c_vat_cal_rate + "] c_cp_chage_amt[" + c_cp_chage_amt + "] c_cp_chage_apy_y_amt[" + c_cp_chage_apy_y_amt
									+ "] c_cp_chage_apy_n_amt[" + c_cp_chage_apy_n_amt +  "] c_cashrec_amt[" +  c_cashrec_amt +      "] c_cashrec_n_amt[" + c_cashrec_n_amt + "]");									
									*/	
									coupon_fg_split[i]          = coupon_fg_split[0];
									coupon_cd_split[i]         = coupon_cd_split[0];
									coupon_no_split[i]          = coupon_no_split[0];
									face_amt_split[i]           = face_amt_split[0];
									cashrec_yn_split[i]         = cashrec_yn_split[0];
									vat_cal_ext_rate_split[i]   = vat_cal_ext_rate_split[0];
									vat_cal_rate_split[i]       = vat_cal_rate_split[0];
									cp_change_amt_split[i]       = cp_change_amt_split[0];
									cp_chage_apy_y_amt_split[i] = 0;
									cp_chage_apy_n_amt_split[i] = 0;
									cashrec_amt_split[i]        = cashrec_amt_split[0];
									cashrec_n_amt_split[i]      = cashrec_n_amt_split[0];

									/*
									alert("[거스름현금영수증100 2]gridCoupon.valueMatrix(i, gridCoupon.colRef(coupon_fg))[" + coupon_fg_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(coupon_cd))[" + coupon_cd_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(coupon_no))[" + coupon_no_split[i] 
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(face_amt))[" + face_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cashrec_yn))[" + cashrec_yn_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(vat_cal_ext_rate))[" + vat_cal_ext_rate_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(vat_cal_rate))[" + vat_cal_rate_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cp_chage_amt))[" + cp_change_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cp_chage_apy_y_amt))[" + cp_chage_apy_y_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cp_chage_apy_n_amt))[" + cp_chage_apy_n_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cashrec_amt))[" + cashrec_amt_split[i]
									+ "] gridCoupon.valueMatrix(i, gridCoupon.colRef(cashrec_n_amt))[" + cashrec_n_amt_split[i]									
									+"]");
									*/
								
									coupon_fg_split[0]          = c_coupon_fg;
									coupon_cd_split[0]          = c_coupon_cd;
									coupon_no_split[0]          = c_coupon_no;
									face_amt_split[0]           = c_face_amt;
									cashrec_yn_split[0]         = c_cashrec_yn;
									vat_cal_ext_rate_split[0]   = c_vat_cal_ext_rate;
									vat_cal_rate_split[0]       = c_vat_cal_rate;
									cp_change_amt_split[0]       = c_cp_chage_amt;
									cp_chage_apy_y_amt_split[0] = c_cp_chage_apy_y_amt;
									cp_chage_apy_n_amt_split[0] = c_cp_chage_apy_n_amt;
									cashrec_amt_split[0]        = c_cashrec_amt;
									cashrec_n_amt_split[0]      = c_cashrec_n_amt;
								
									/*
									alert("[거스름현금영수증100 3]gridCoupon.valueMatrix(1, gridCoupon.colRef(coupon_fg))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("coupon_fg"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(coupon_cd))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("coupon_cd")) 
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(coupon_no))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("coupon_no")) 
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(face_amt))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("face_amt"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cashrec_yn))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("cashrec_yn"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(vat_cal_ext_rate))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("vat_cal_ext_rate"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(vat_cal_rate))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("vat_cal_rate"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cp_chage_amt))[" + gridCoupon.valueMatrix(1, gridCoupon.colRef("cp_chage_amt"))
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cp_chage_apy_y_amt))[" + cp_chage_apy_y_amt_split[0]
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cp_chage_apy_n_amt))[" + cp_chage_apy_n_amt_split[0]
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cashrec_amt))[" + cashrec_amt_split[0]
									+ "] gridCoupon.valueMatrix(1, gridCoupon.colRef(cashrec_n_amt))[" + cashrec_n_amt_split[0]									
									+"]");
									*/
								
									c_coupon_fg = null;
									c_coupon_cd = null;
									c_coupon_no = null;
									c_face_amt = 0;
									c_cashrec_yn = null;
									c_vat_cal_ext_rate = 0;
									c_vat_cal_rate = 0;
									c_cp_chage_amt = 0;
									c_cp_chage_apy_y_amt = 0;
									c_cp_chage_apy_n_amt = 0;
									c_cashrec_amt = 0;
									c_cashrec_n_amt = 0;
								}
							}
						}
					}
				}
			}
		
			/**** 3. 거스름돈 반영된 가장 큰 금액 현금영수증대상 금액으로 적용 *****/
			if(cp_chage_apy_y_amt_split[0] != 0)
			{
				//alert("[거스름반영 전]cashrec_n_amt[" + cashrec_n_amt_split[0]
				//+ "] cashrec_amt[" + cashrec_amt_split[0] + "]");
					
				cashrec_n_amt_split[0] = cp_chage_apy_n_amt_split[0];
				cashrec_amt_split[0] = cp_chage_apy_y_amt_split[0];

				//alert("[거스름반영 후]cashrec_n_amt[" + cashrec_n_amt_split[0]
				//	+ "] cashrec_amt[" + cashrec_amt_split[0] + "]");								
			}
			
			for(var i = 0; i < coupon_cnt; i++)
			{
				cashrecNCoupon += nullCheck(cashrec_n_amt_split[i]);
				cashrecYCoupon += nullCheck(cashrec_amt_split[i]);
			}
		}					
		cashrec_n_coupon = cashrecNCoupon;
		cashrec_y_coupon = cashrecYCoupon;
		
		if(couponAmt != null && couponAmt != '') 
		{
			coupon_amt = couponAmt;
			$("#coupon_amt").val(coupon_amt);
		}
	}		
	//2019.03.11 ljs : 사용마일리지(point_amt), 증정상품권구분하여 금액설정 추가 END
	

	//지불 라디오 버튼 클릭시 이벤트 처리
}//eventPayFg()

function mcoupon_getRemain()
{
	barcode_no = $("#mcouponLayer_barcode_no").val();
	if(barcode_no.substring(0,2) == "11"){
		if(mcoupon_approve_status == 1){
			alert("모바일 상품권 승인처리가 완료 되어 조회 할 수 없습니다.");
			return;
		}
		mcoupon_search();		//바코드 잔액 확인
	}else if(barcode_no.substring(0,2) == "12"){
		alert("카카오톡 판매용으로 직사용 불가(AK지류 상품권 교환)");
		return;
	}else if(barcode_no.substring(0,2) == "13"){
		alert("삼성전자판매 사은용으로 직사용 불가(AK지류상품권 교환)");
		return;
		
	}else{
		alert("모바일 상품권 번호 확인 부탁드립니다.");
		return;
	}
}
function mcoupon_search() {
	barcode_no = trim(barcode_no.replace("-",""));
	
	if(barcode_no == null || barcode_no == "" || barcode_no.length != 12){
		alert("모바일 상품권 번호를 올바르게 입력해주세요.");
		$("#mcouponLayer_barcode_no").focus();
		return;
	}
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/getBAMobileCouponCheck",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			pos_no : pos_no,
			barcode_no : barcode_no,
			store : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			mcoupon_remain_amt = result.remain_amt;
			$("#mcouponLayer_remain_amt").val(mcoupon_remain_amt);
			mcoupon_search_cd = 1;
		}
	});
}
function mcoupon_approveCheck()
{
	if(mcoupon_approve_status == 1){
		alert("모바일상품권 결제 승인되었습니다.");
		return;
	}
	var search_cd = mcoupon_search_cd;
	
	var tot_sale_amt_i 		= Number(final_pay);
	var remain_amt_i 		= Number(mcoupon_remain_amt);
	var sale_amt_i 			= Number($("#mcouponLayer_use_amt").val());
	
	if (search_cd == 0) {
	    alert("모바일상품권 잔액조회가 되지 않았습니다.");
	    return;
	}
	if (remain_amt_i  == "000000000000" || remain_amt_i == "0" || remain_amt_i == "" ) {
	    alert("모바일상품권 사용가능금액을 확인해 주세요.");
	    return;
	}
	if (tot_sale_amt_i  == "000000000000" || tot_sale_amt_i == "0" || tot_sale_amt_i == "" ) {
	    alert("총결제금액을 확인해 주세요.");
	    return;
	}
	if (sale_amt_i <= 0 ) {
	    alert("사용금액을 확인해 주세요.");
	    return;
	}
	
	if(remain_amt_i < sale_amt_i){
		alert("보유금액이 부족합니다.");
		return ;
	}
	
	if(sale_amt_i > tot_sale_amt_i){
		alert("사용금액이 결제금액보다 큽니다.");
		return ;
	}
	
	if( confirm(sale_amt_i + "원을 결제하시겠습니까?" ) ) {
		
		$.ajax({
			type : "POST", 
			url : "/member/lect/getApproveMobileCoupon",
			dataType : "text",
			async:false,
			cache : false,
			data : 
			{
				pos_no : pos_no,
				barcode_no : barcode_no,
				sale_amt : sale_amt_i,
				store : $("#selBranch").val()
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				var rmn_amt = tot_sale_amt_i - sale_amt_i;
				
				$("#mcouponLayer_barcode_no").attr("readOnly", true);
				$("#mcouponLayer_use_amt").attr("readOnly", true);
				$("#point_amt").attr("readOnly", true);
				
				mcoupon_amt = Number($("#mcouponLayer_use_amt").val());
				mcoupon_cnt = rmn_amt == 0 ? 1 : 2;
				
				alert("모바일상품권 승인 처리가 완료 되었습니다.");
				
				mcoupon_approve_cd = 1;
				
				mcoupon_approve_no = result.approve_no;
				mcoupon_approve_amt = result.approve_amt;
				mcoupon_rmn_amt = result.coupon_remain_amt;
				
				$("#mcouponLayer_approve_amt").val(mcoupon_approve_amt);
				$("#mcouponLayer_approve_no").val(mcoupon_approve_no);
				$("#mcouponLayer_coupon_remain_amt").val(mcoupon_rmn_amt);
			}
		});
	} else {
		mcoupon_approve_cd = 0;
	    return;
	}
}
function AKmem_getPoint()
{
	var tmp_akmem_cardno = $("#card_no").val();
	
	if(tmp_akmem_cardno != ""){
		akmem_card_fg = "@";
		akmem_card_no = tmp_akmem_cardno;
		AKmem_cardStatusCheck();
	}
}
function AKmem_cardStatusCheck()
{
	var ls_store	=	$("#selBranch").val();
	var ls_akmem_card_no     	=	akmem_card_no;
	
	var tranGubun = akmem_card_rfFlag;
	
	// 유효성체크
	if(ls_akmem_card_no == null || trim(ls_akmem_card_no) == "" ) {
		return;
	}
	
	var send_data = (trim(tranGubun) == "M" || akmem_card_fg == "@")?AKmem_Run('XB241S','READ'):AKmem_Run('XB241S','READ');
	
	var enc_card = $("#akmem_card_no").val();
	
	if(enc_card.indexOf("*") > 0 )
	{
		encCardNoSendStr("akmem");//멤버쉽 카드 복호화
	}
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetAkmemCustInfo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{ 
			hq : '00',
			store : $("#selBranch").val(),
			send_data : send_data,
			akmem_encCardNo_send_str : akmem_card_encCardNo_send_str
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			if(result.sApprovNo != '00')
			{
				alert("[포인트조회 오류!]"+result.sMessage);
			}
			else
			{
				var AKmem_Card_Type = result.AKmem_Card_Type;
				
				if( AKmem_Card_Type == "1" ) {
					akmem_card_type_nm = "단순멤버스카드";
				}else if( AKmem_Card_Type == "2" ) {
					akmem_card_type_nm = "신한제휴카드";
				}else if( AKmem_Card_Type == "3" ) {
					akmem_card_type_nm = "드림카드(이관)";
				}else if( AKmem_Card_Type == "4" ) {
					akmem_card_type_nm = "플러스카드(이관)";
				}else if( AKmem_Card_Type == "5" ) {
					akmem_card_type_nm = "VIP카드(이관)";
				}else if( AKmem_Card_Type == "6" ) {
					akmem_card_type_nm = "영(이관)";
				}else if( AKmem_Card_Type == "7" ) {
					akmem_card_type_nm = "동탄사랑(이관)";
				}else if( AKmem_Card_Type == "8" ) {
					akmem_card_type_nm = "KB국민제휴";
				}else if( AKmem_Card_Type == "9" ) {
					//2020.02.03 kjp AK우리카드로 명칭 변경
					//akmem_card_type_nm = "기타(마일리지)";	
					akmem_card_type_nm = "AK우리카드";
				}else{
					//선발급카드 유무 체크
					if(result.AKmem_use_yn == "0"){
						akmem_card_type_nm = "선발급 카드";
					}else{
						akmem_card_type_nm = "기타 카드";
					}
					// 10.04.21 드림카드, 플러스카드 적립불가 (계상화주임)  START ---------------------
					//2020.02.03 kjp 적립가능카드에 "9" 추가
					//if(( AKmem_Card_Type == "1" ) ||( AKmem_Card_Type == "2" ) ||( AKmem_Card_Type == "8" ))  {
					if(( AKmem_Card_Type == "1" ) ||( AKmem_Card_Type == "2" ) ||( AKmem_Card_Type == "8" ) ||( AKmem_Card_Type == "9" ))  {
						//alert("적립가능 카드~!")
					}else{
						alert("단순멤버스카드 또는 제휴신용카드만 적립가능합니다. \n드림카드/플러스카드는 멤버스카드를 재발급 받으시기 바랍니다.")
						return ;
					}							
					// 10.04.21 드림카드, 플러스카드 적립불가 (계상화주임) END -----------------------
  
					//AK기프트(555), 홈플러스(666) 멤버스 적립 불가 체크 추가(2012.01.12) -----------------------
					var ls_card_fg = akmem_card_co_origin_seq;
					if(  (ls_card_fg =="555") && (Number(result.AKmem_total_point) > 0 )
							 && (($("#akmem_card_no").val() != null ) || (trim($("#akmem_card_no").val()) != "" ))) {
								alert("[AK기프트카드]는 멤버스 적립이 불가능합니다! [멤버스카드 초기화]. 재확인하시기 바랍니다.");
						return;
	
					}
				}
				$("#akmem_card_type").val(akmem_card_type_nm);
				$("#akmem_card_name").val(result.AKmem_CustName);
				$("#akmem_total_point").html(comma(Number(result.AKmem_total_point))+" <span>원</span>");
				akmem_total_point = result.AKmem_total_point;
				
                akmem_use_min_point = result.AKmem_Use_Min_Point;
                akmem_use_max_point = result.AKmem_Use_Max_Point;
                akmem_use_hurdle = result.AKmem_Use_hurdle;
                akmem_cust_grade = result.AKmem_CustGrade;
                akmem_pswd = result.AKmem_Pswd;
                akmem_sApprovNo = result.sApprovNo;
                akmem_cust_no = result.AKmem_CustNo;
                
                akmem_resp_no = result.AKmem_Resp_No;
                akmem_resp_msg = result.AKmem_Resp_Msg;
                if(nullChk(result.AKmem_CardNo) != "")
                {
                	akmem_card_no = result.AKmem_CardNo;
                }
                akmem_family_cust_no = result.AKmem_Family_CustNo;
                akmem_cust_name = result.AKmem_CustName;
                akmem_cust_level = result.AKmem_CustLevel;
                akmem_regi_card_yn = result.AKmem_RegiCard_yn;
                akmem_regi_card_no = result.AKmem_RegiCard_no;
                akmem_use_yn = result.AKmem_use_yn;
                
                point_amt = 0;
                point_approve_yn = "N";
                
               
                $("#akmem_cust_grade").val(result.AKmem_CustGrade);
			}
		}
	});
}
function AKmem_Run(pID,pType){
    var ls_store    =   $("#selBranch").val();
    var send_data   =   '';             
    //switch (pID) { 여전법 이후 switch에서 if else 로 변경 
        // case 'XA241S' :
       if(pID == 'XA241S' || pID == 'XB241S' ){ 
            //----------------------------------------------//
            //    회원 인증 조회 로직                               //
            //----------------------------------------------//
            var ls_akmem_card_no        =   akmem_card_no;  
            
            var ls_header   =      AKmem_Header(pID,pType);   //CREATE HEADER
            //Data
            //var WCC         =  "3";    // 여전법 이전 카드입력구분  1 : MSR, 2 : IC, 3 : Key In 
            //var PERM_RQ_DIV =   "1";    //  여전법 이전 1.POS/2.단말
            //var CARD_NO     =  f_setfill(ls_akmem_card_no,37,"R"); // 여전법 이전  
            var WCC         =  pID == 'XA241S'?"1": (akmem_card_fg == "A"? "2":"3");    // 카드입력구분  1 : MSR, 2 : IC, 3 : Key In 
            var PERM_RQ_DIV =   "1";    //  1.POS/2.단말
            var CARD_NO     =  pID == 'XA241S'?f_setfill(ls_akmem_card_no,37,"R"):f_setfill(ls_akmem_card_no,37,"R"); //  카드번호 전문IC XB241S일때 스페이스 처리
            var PSWD            =   f_setfill("",16,"R");//"                ";  //  space(16)
            var NOR_CD_CK_YN    =   "1";    //일반신용카드 체크여부
            var NOR_CDNO        =   "                "; //일반신용카드번호
            var DE_DIV_CD       =   "  ";   //  거래구분코드
            var DE_RSON     =   "   ";  //  거래사유코드
            var FRAN_NM     =   ""; //  가맹점명
            var FRAN_CD     =   ""; //  가맹점코드
                if ( ls_store == "01" ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                if ( ls_store == "02" ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                if ( ls_store == "03" ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                if ( ls_store == "04" ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}
                if ( ls_store == "05" ) { FRAN_CD = "00503"; FRAN_NM = "문화아카데미 원주점";}
            var TEAM_CD     =   "   ";  //  팀코드
            var POS_NO      =   pos_no;     //pos번호
            var MBR_INFO_RQ =   "1";    //  회원정보 요청 1: 요청 , 0:요청하지 않음(응답전문에 회원전보 포함여부)
            var ksn_encData = akmem_card_encData1; //KSN(20)+Base64(EncData)(64) 유통키 암호화  18.02.12 최보성
            //2019.06.21 ljs : 전문 XA->XB 변경으로 암호화된 카드번호(제휴카드인 경우)일때만 ENC_CARD_NO 값이 처리되도록 보완
            if( ls_akmem_card_no != null && ls_akmem_card_no.indexOf("*") == -1 ) { ksn_encData = ""; }
            
            var ENC_CARD_NO =  pID == 'XB241S'?f_setfill(ksn_encData,84,"R"):f_setfill("",84,"R") ; // 여전법이후 항목 추가 18.02.12 최보성 전문IC XB241S 아닐 때 스페이스 처리
            var FILLER      =   "                                                  ";   //space(50)
            
            var ls_data =   WCC + PERM_RQ_DIV + CARD_NO + PSWD + NOR_CD_CK_YN + NOR_CDNO + DE_DIV_CD + DE_RSON + FRAN_CD + TEAM_CD + POS_NO + MBR_INFO_RQ +ENC_CARD_NO +FILLER ;
 
            send_data   =   f_setfill( ls_header + ls_data, 1024, "R"); //1024byte를 항상 채워준다.  
            
       //    break;          
       // case 'XA242S' : 여전법 이후 switch에서 if else 로 변경 
        }
       else if(pID =='XA242S'|| pID =='XB242S' ){
           //----------------------------------------------//
           //    포인트 적립 로직                                                           //
           //----------------------------------------------//     
                                                     
           //타입에 맞게 valid
           if(pType == 'SAVE'){
               var FRAN_NM     =   ""; //  가맹점명
               var FRAN_CD     =   ""; //  가맹점코드
                   if ( ls_store == "01" ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                   if ( ls_store == "02" ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                   if ( ls_store == "03" ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                   if ( ls_store == "04" ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}
                   if ( ls_store == "05" ) { FRAN_CD = "00503"; FRAN_NM = "문화아카데미 원주점";}
                               
               var ls_akmem_card_no =   akmem_card_no;  
               var ls_custno   =   f_setfill(akmem_cust_no,9,"R");  //고객번호
               var ls_fam_custno=  f_setfill(akmem_family_cust_no,10,"R");   //가족번호
               var ls_cus_rg_yn=   akmem_use_yn;  //고객등록여부
               var ls_stt_cdno =   akmem_card_no;  //구매결재카드정보
               var ls_sale_ymd =   getNow();
               var ls_pos_no   =   pos_no;
               var ls_recpt_no =   recpt_no;
               var ls_rs_use_div_cd=   '1';     //적립구분(1.적립,2.취소)
               var ls_tot_sales_amt=   final_pay;    //총결재금액
               var ls_recpt_point= akmem_recpt_point; //총적립요청금액
               var ls_orgl_info_yn    =   "0";    //1.원개래 정보 있음 2.원거래 정보 없음
               var ls_orgl_info_div   =   " ";    //"1":운영사 원승인정보, "2":참여사 원승인정보
               var ls_orgl_perm_no    =   f_setfill("",31,"R");   //원 승인번호
               var ls_orgl_de_dt  =   f_setfill("",8,"R");    //원 승인날짜
               //가맹점코드(5)+거래일자(8)+POS번호(6)+'00000000'+거래번호(4)
               var PTCP_PERM_NO=   FRAN_CD + ls_sale_ymd + ls_pos_no + "00000000" + ls_recpt_no;
                    PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");           
               var DFN_DT      =   ls_sale_ymd;  //확정일자 space(8) 
   
           }
           else if(pType == 'CANCEL'){
               // 이전거래 가맹점코드 (멤버스 오픈 이전 거래는 각점의 백화점 가맹점 매출로 잡혀있으므로 취소시 각 백화점 가맹점번호로 참여사승인번호를 부여 해야 함.
               var FRAN_NM     =   ""; //  가맹점명
               var FRAN_CD     =   ""; //  가맹점코드
               if( cancel_akmem_approve_no == ""){
                   //멤버스 오픈 이전 거래 백화점 가맹점번호 set
                   if ( ls_store == "01" ) { FRAN_CD = "00101"; FRAN_NM = "문화아카데미 구로점";}
                   if ( ls_store == "02" ) { FRAN_CD = "00201"; FRAN_NM = "문화아카데미 수원점";}
                   if ( ls_store == "03" ) { FRAN_CD = "00301"; FRAN_NM = "문화아카데미 분당점";}
                   if ( ls_store == "04" ) { FRAN_CD = "00401"; FRAN_NM = "문화아카데미 평택점";}
                   if ( ls_store == "05" ) { FRAN_CD = "00501"; FRAN_NM = "문화아카데미 원주점";}
               }else{
                   //멤버스 오픈 이후 거래 문화센터 가맹점번호 set
                   if ( ls_store == "01" ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                   if ( ls_store == "02" ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                   if ( ls_store == "03" ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                   if ( ls_store == "04" ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";} 
                   if ( ls_store == "05" ) { FRAN_CD = "00503"; FRAN_NM = "문화아카데미 원주점";}
               }
               var ls_akmem_card_no = cancel_akmem_card_no;  
               var ls_custno   =   f_setfill(cancel_akmem_cust_no,9,"R");  //고객번호
               var ls_fam_custno=  f_setfill(cancel_akmem_family_cust_no,10,"R");   //가족번호
               var ls_cus_rg_yn=   'Y';  //고객등록여부
               var ls_stt_cdno =   '';  //구매결재카드정보
               var ls_sys_ymd  =   getNow();    //시스템 날짜
               var ls_sale_ymd =   cancel_sale_ymd;     //원거래 일자 
               var ls_pos_no   =   cancel_recpt_pos_no;       //원거래 pos
               
               // 09.07.03 취소시 발생 포스번호 원포스번호 요청오류로 수정함 ls_pos_no2 생성함(해선)
               //var ls_pos_no2   =   model.getValue("/root/req/pos_no");			    //pos번호	
               //--------------------------------------------------------------------
               
               // 2014.07.01 취소시 원거래 번호를 끌고올 시 인터넷 포스, 모바일 포스 적립 취소시 포스번호 중복으로 취소 불가 
               var ls_pos_no2   =   pos_no;
               
               //2019.05.29 ljs  : 전성민대리님 소스변경 내역 반영 - ls_pos_no = 070013 추가
               if(ls_pos_no == "070014" || ls_pos_no == "070013")
               {
               	ls_pos_no2 = ls_pos_no;
               }
               
               //var ls_orgl_recpt_no = getGridColumnNameValue(gridMain, gridMain.row, "recpt_no");    //원 영수증번호
               var ls_orgl_recpt_no =  cancel_recpt_no;    //원 영수증번호
               var ls_recpt_no =   cancel_new_recpt_no;   //취소 영수증 번호
               var ls_rs_use_div_cd=   '2';     //적립구분(1.적립,2.취소)                
               var ls_tot_sales_amt=   cancel_net_sale_amt;   //총결재(취소)금액
               var ls_recpt_point  =   cancel_akmem_recpt_point; //총적립요청금액      
               var ls_orgl_info_yn    =   "1";    //1.원개래 정보 있음 2.원거래 정보 없음
                   //var ls_orgl_info_div   =   "1";    //"1":운영사 원승인정보, "2":참여사 원승인정보 
                   //var ls_orgl_perm_no    =   f_setfill(model.getValue("/root/res/akmem_data/akmem_approve_no"),31,"R");   //원 승인번호
               var ls_orgl_info_div   =   "2";    //"1":운영사 원승인정보, "2":참여사 원승인정보 (멤버스 오픈 이전 원거래 취소 때문에 참여사 승인정보로 변경)
               var ls_orgl_perm_no    =   f_setfill( FRAN_CD + ls_sale_ymd + ls_pos_no + "00000000" + ls_orgl_recpt_no ,31,"R"); 
               var ls_orgl_de_dt  =   f_setfill(ls_sale_ymd,8,"R");    //원 승인날짜                      
               //가맹점코드(5)+거래일자(8)+POS번호(6)+'00000000'+거래번호(4)
               //09.07.03 취소시 발생 포스번호 원포스번호 요청오류로 수정함 [ls_pos_no-> ls_pos_no2]  var PTCP_PERM_NO=  FRAN_CD + ls_sys_ymd + ls_pos_no + "00000000" + ls_recpt_no;
               var PTCP_PERM_NO=  FRAN_CD + ls_sys_ymd + ls_pos_no2 + "00000000" + ls_recpt_no;
                   PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");
               var DFN_DT      =   ls_sys_ymd;  //확정일자 space(8)
           }
           
           
           var ls_header   =      AKmem_Header(pID,pType);   //CREATE HEADER
           //Data
           //var WCC         =   "3";    //  여전법 이전  KEY-IN 
           //var PERM_RQ_DIV =   "1";    //  여전법 이전 1.POS/2.단말
           //var CARD_NO     =   f_setfill(ls_akmem_card_no,37,"R"); //  여전법 이전  카드번호
           
           var WCC         =  pID == 'XA242S'? "1": (akmem_card_fg == "A"? "2":"3");    // 카드입력구분  1 : MSR, 2 : IC, 3 : Key In 
           var PERM_RQ_DIV =   "2";    //  1.POS/2.단말
           var CARD_NO     =  pID == 'XA242S'?f_setfill(ls_akmem_card_no,37,"R"):f_setfill(ls_akmem_card_no,37,"R"); //  카드번호 전문IC XB241S일때 스페이스 처리
           
           var CUS_NO      =   ls_custno;  //고객번호
           var FML_PT_MG_NO=  f_setfill(ls_fam_custno,10,"R"); //가족번호
           var CUS_RG_YN   =   ls_cus_rg_yn ;  //고객등록여부
           var STT_CDNO    =   f_setfill(ls_stt_cdno,16,"R");    //구매결재카드정보
           var PSWD        =   f_setfill("",16,"R");//"                ";  //  space(16)
           var TEAM_CD     =   "   ";  //  팀코드
           var DE_DT       =   "@@@@@@@@"; //거래일자
           var DE_PTM      =   "@@@@@@";       //시분초
           var DE_DIV      =   "10";               //10.적립
           var DE_RSON     =   "101";          //거래사유코드 (100.대금결재,101.문화센터강좌신청)
           var RS_USE_DIV_CD   =   ls_rs_use_div_cd;                //적립구분(1.적립,2.취소)
           var TOT_SALES_AMT=  f_setfill_zero(ls_tot_sales_amt,12,"L"); //총결재금액
           var SL_NM       =   FRAN_NM + f_setfill("",50-lenByte(FRAN_NM),"R");   //매출대표명
           var DC_AMT      =   fill("0",12);   //에누리 space(12)
           var ITEM_QTY        =   fill("0",3);    //품목수량 space(3)
           var TOT_CREA_PT =   f_setfill_zero(ls_recpt_point,10,"L");  //총적립요청금액
           var CASH_STT_AMT    =   fill("0",12);   //space(12)
           var CREA_PT_CASH    =   fill("0",10);   
           var CD_STT_AMT  =   fill("0",12);   
           var CREA_PT_CD  =   fill("0",10);   
           var WRKCP_PDB_STT_AMT   =   fill("0",12);   
           var CREA_PT_WRKCP_PDB   =   fill("0",10);   
           var OCMP_PDB_STT_AMT    =   fill("0",12);   
           var CREA_PT_OCMP_PDB    =   fill("0",10);   
           var PT_STT_AMT  =   fill("0",12);   
           var CREA_PT_PT  =   fill("0",10);   
           var ETC_STT_AMT =   fill("0",12);   
           var CREA_PT_ETC =   fill("0",10);   
           var FSDE_PT_OC_YN=  "0";
           var FSDE_PT     =   fill("0",10);   
           var BIRTH_PT_OC_YN= "0";
           var BIRTH_PT        =   fill("0",10);   
           var WEDD_DT_PT_OC_YN=   "0";
           var WEDD_DT_PT  =   fill("0",10);   
           var ADDM_RS_PT_OC_YN1=  "0";
           var ADDM_RS_PT1 =   fill("0",10);   
           var ADDM_RS_PT_OC_YN2=  "0";
           var ADDM_RS_PT2 =   fill("0",10);   
           var MBR_INFO_RQ =   "1";    //회원정보요청
           var FILLER      =   f_setfill("",50,"R");
           var ORGL_INFO_YN    =   ls_orgl_info_yn;    //1.원개래 정보 있음 2.원거래 정보 없음
           var ORGL_INFO_DIV   =   ls_orgl_info_div;    //"1":운영사 원승인정보, "2":참여사 원승인정보
           var ORGL_PERM_NO    =   ls_orgl_perm_no;   //원 승인번호
           var ORGL_DE_DT      =   ls_orgl_de_dt;    //원 승인날짜
           var EV_CNT      =   "0";
           var EV_CD1      =   f_setfill("",10,"R");   //이벤트코드
           var EV_NM1      =   f_setfill("",100,"R");  //이벤트코드
           var SALES_AMT1  =   fill("0",12);   //이벤트코드
           var EV_PT1      =   fill("0",10);   //이벤트코드
           var EV_CD2      =   f_setfill("",10,"R");   //이벤트코드
           var EV_NM2      =   f_setfill("",100,"R");  //이벤트코드
           var SALES_AMT2  =   fill("0",12);   //이벤트코드
           var EV_PT2      =   fill("0",10);   //이벤트코드
           
           var ksn_encData = akmem_card_ksn1+akmem_card_encData1; //KSN(20)+Base64(EncData)(64)  18.02.12 최보성
           //2019.06.21 ljs : 전문 XA->XB 변경으로 암호화된 카드번호(제휴카드인 경우)일때만 ENC_CARD_NO 값이 처리되도록 보완
           if( ls_akmem_card_no != null && ls_akmem_card_no.indexOf("*") == -1 ) { ksn_encData = ""; }
           
           var ENC_CARD_NO =  pID == 'XB242S'?f_setfill(ksn_encData,84,"R"):f_setfill("",84,"R") ; // 여전법이후 항목 추가 18.02.12 최보성 전문IC XB241S 아닐 때 스페이스 처리

           var ls_data =   WCC + PERM_RQ_DIV + CARD_NO + CUS_NO + FML_PT_MG_NO + CUS_RG_YN + STT_CDNO + PSWD + FRAN_CD + TEAM_CD ;
           ls_data   = ls_data +  PTCP_PERM_NO + DE_DT + DE_PTM + DFN_DT + DE_DIV + DE_RSON + RS_USE_DIV_CD + TOT_SALES_AMT + SL_NM ;
           ls_data   = ls_data +  DC_AMT + ITEM_QTY + TOT_CREA_PT + CASH_STT_AMT + CREA_PT_CASH + CD_STT_AMT + CREA_PT_CD + WRKCP_PDB_STT_AMT ;
           ls_data   = ls_data +  CREA_PT_WRKCP_PDB + OCMP_PDB_STT_AMT + CREA_PT_OCMP_PDB + PT_STT_AMT + CREA_PT_PT + ETC_STT_AMT + CREA_PT_ETC ;
           ls_data   = ls_data +  FSDE_PT_OC_YN + FSDE_PT + BIRTH_PT_OC_YN + BIRTH_PT + WEDD_DT_PT_OC_YN + WEDD_DT_PT + ADDM_RS_PT_OC_YN1 + ADDM_RS_PT1 ;
           ls_data   = ls_data +  ADDM_RS_PT_OC_YN2 + ADDM_RS_PT2 + MBR_INFO_RQ + FILLER + ORGL_INFO_YN + ORGL_INFO_DIV + ORGL_PERM_NO + ORGL_DE_DT ;
           ls_data   = ls_data +  EV_CNT + EV_CD1 + EV_NM1 + SALES_AMT1 + EV_PT1 + EV_CD2 + EV_NM2 + SALES_AMT2 + EV_PT2+ENC_CARD_NO;//여전법 이후 ENC_CARD_NO  추가, Filler는 항목 추가 안하고  스페이스 처리

           send_data   =   f_setfill( ls_header + ls_data, 1024, "R"); //1024byte를 항상 채워준다.                        
//           break;   여전법 이후 switch에서 if else 로 변
//2019.03.25 ljs 마일리지 사용/취소 추가
   }
       else if(pID == 'XA243S' || pID == 'XB243S'){

           //----------------------------------------------//
           //    마일리지 사용 로직                                                        //
           //----------------------------------------------//     
           //타입에 맞게 valid
           if(pType == 'USE'){
               var FRAN_NM     =   ""; //  가맹점명
               var FRAN_CD     =   ""; //  가맹점코드
                   if ( ls_store == "01" ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                   if ( ls_store == "02" ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                   if ( ls_store == "03" ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                   if ( ls_store == "04" ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}
                   if ( ls_store == "05" ) { FRAN_CD = "00503"; FRAN_NM = "문화아카데미 원주점";}
                               
               var ls_akmem_card_no =  akmem_card_no;  
               var ls_custno        =  f_setfill(akmem_cust_no,9,"R");  //고객번호
               var ls_fam_custno    =  f_setfill(akmem_family_cust_no,10,"R");   //가족번호
               var ls_sale_ymd      =  getNow();
               var ls_pos_no        =  pos_no;
               var ls_recpt_no      =  recpt_no;
               var ls_rs_use_div_cd =  '1';     //적립구분(1.적립,2.취소)
               var ls_use_pt        =  point_amt;     //총사용요청금액
               var ls_orgl_info_yn  =  "0";    //1.원개래 정보 있음 2.원거래 정보 없음
               var ls_orgl_info_div =  " ";    //"1":운영사 원승인정보, "2":참여사 원승인정보
               var ls_orgl_perm_no  =  f_setfill("",31,"R");   //원 승인번호
               var ls_orgl_de_dt    =  f_setfill("",8,"R");    //원 승인날짜                
           
     			/********************************************************* 
     			// 2019.04.02 ljs : 참여사 승인번호 변경(uniq 해야함)
               //포멧 : 가맹점코드(5)+거래일자(8)+POS번호(6)+거래번호(4)+'22'+ 거래시분초(6)
               **********************************************************/ 
 		    	var PTCP_PERM_NO     =  FRAN_CD + ls_sale_ymd + ls_pos_no + ls_recpt_no + "22" + "000000" ;
                   PTCP_PERM_NO     =  f_setfill(PTCP_PERM_NO,31,"R");           

           }
           else if(pType == 'CANCEL'){
               // 이전거래 가맹점코드 (멤버스 오픈 이전 거래는 각점의 백화점 가맹점 매출로 잡혀있으므로 취소시 각 백화점 가맹점번호로 참여사승인번호를 부여 해야 함.
               var FRAN_NM     =   ""; //  가맹점명
               var FRAN_CD     =   ""; //  가맹점코드
               if( cancel_akmem_approve_no == ""){
                   //멤버스 오픈 이전 거래 백화점 가맹점번호 set
                   if ( ls_store == "01" ) { FRAN_CD = "00101"; FRAN_NM = "문화아카데미 구로점";}
                   if ( ls_store == "02" ) { FRAN_CD = "00201"; FRAN_NM = "문화아카데미 수원점";}
                   if ( ls_store == "03" ) { FRAN_CD = "00301"; FRAN_NM = "문화아카데미 분당점";}
                   if ( ls_store == "04" ) { FRAN_CD = "00401"; FRAN_NM = "문화아카데미 평택점";}
                   if ( ls_store == "05" ) { FRAN_CD = "00501"; FRAN_NM = "문화아카데미 원주점";}
               }else{
                   //멤버스 오픈 이후 거래 문화센터 가맹점번호 set
                   if ( ls_store == "01" ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                   if ( ls_store == "02" ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                   if ( ls_store == "03" ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                   if ( ls_store == "04" ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";} 
                   if ( ls_store == "05" ) { FRAN_CD = "00503"; FRAN_NM = "문화아카데미 원주점";}
               }
               var ls_akmem_card_no = cancel_akmem_approve_no;  
               var ls_custno        = f_setfill(akmem_cust_no,9,"R");  //고객번호
               var ls_fam_custno    = f_setfill(akmem_family_cust_no,10,"R");   //가족번호
               var ls_sys_ymd       = getNow();         //시스템 날짜
               var ls_sale_ymd      = cancle_sale_ymd; //원거래 일자 
               var ls_pos_no        = cancle_recpt_pos_no;   //원거래 pos
               
               // 2014.07.01 취소시 원거래 번호를 끌고올 시 인터넷 포스, 모바일 포스 적립 취소시 포스번호 중복으로 취소 불가 
               var ls_pos_no2   =  pos_no;
               
               //2019.05.29 ljs  : 전성민대리님 소스변경 내역 반영 - ls_pos_no = 070013 추가
               if(ls_pos_no == "070014" || ls_pos_no == "070013")
               {
               	ls_pos_no2 = ls_pos_no;
               }
               
               var ls_orgl_recpt_no =  cancel_recpt_no;    //원 영수증번호
               var ls_recpt_no      =  cancel_new_recpt_no;   //취소 영수증 번호
               var ls_rs_use_div_cd =  '2';     //적립구분(1.적립,2.취소)                
               var ls_use_pt        =  cancel_akmem_point_amt;  //총사용요청금액      
               var ls_orgl_info_yn  =  "1";    //1.원개래 정보 있음 2.원거래 정보 없음
               var ls_orgl_info_div =  "2";    //"1":운영사 원승인정보, "2":참여사 원승인정보 (멤버스 오픈 이전 원거래 취소 때문에 참여사 승인정보로 변경)
               
     			/********************************************************* 
     			// 2019.04.02 ljs : 참여사 승인번호 변경(uniq 해야함)
               //포멧 : 가맹점코드(5)+거래일자(8)+POS번호(6)+거래번호(4)+'22'+ 거래시분초(6)
               **********************************************************/      			
     			var ls_orgl_perm_no  =  f_setfill( FRAN_CD + ls_sale_ymd + ls_pos_no + ls_orgl_recpt_no + "22" + "000000",31,"R"); 
               var ls_orgl_de_dt    =  f_setfill(ls_sale_ymd,8,"R");    //원 승인날짜  
                                   
     			/********************************************************* 
     			// 2019.04.02 ljs : 참여사 승인번호 변경(uniq 해야함)
               //포멧 : 가맹점코드(5)+거래일자(8)+POS번호(6)+거래번호(4)+'22'+ 거래시분초(6)
               **********************************************************/
     			var PTCP_PERM_NO     =  FRAN_CD + ls_sys_ymd + ls_pos_no2 + ls_recpt_no + "22" + "000001" ;         
                   PTCP_PERM_NO     =  f_setfill(PTCP_PERM_NO,31,"R");
           }
           
           var ls_header   =  AKmem_Header(pID,pType);   //CREATE HEADER
           
           var WCC             =  pID == 'XA243S'? "1": (akmem_card_fg == "A"? "2":"3");    // 카드입력구분  1 : MSR, 2 : IC, 3 : Key In 
           var PERM_RQ_DIV     =  "2";    //  1.POS/2.단말
           var CARD_NO         =  pID == 'XA243S'?f_setfill(ls_akmem_card_no,37,"R"):f_setfill(ls_akmem_card_no,37,"R"); //  카드번호 전문IC XB241S일때 스페이스 처리
           
           var CUS_NO          =   ls_custno;  //고객번호
           var FML_PT_MG_NO    =   f_setfill(ls_fam_custno,10,"R"); //가족번호
           var PSWD            =   f_setfill("",16,"R");//"                ";  //  space(16)
           var TEAM_CD         =   "   ";  //  팀코드
           
           //var DE_DT            =  ls_sale_ymd; //거래일자
           //var DE_PTM           =  getSystemDate().format("HHMISS");   //시분초
           var DE_DT            =  "@@@@@@@@";		//거래일자
           var DE_PTM          =  "@@@@@@"			//시분초
           var DE_DIV           =  "20";       //10.적립  20.포인트사용
           var DE_RSON          =  "200";      //거래사유코드 (100.대금결재,101.문화센터강좌신청, 200:포인트결제)
           var RS_USE_DIV_CD    =  ls_rs_use_div_cd;                        //적립구분(1.적립,2.취소)
           var USE_PT           =  f_setfill_zero(ls_use_pt,10,"L");  //총사용요청금액
           var SL_NM            =  FRAN_NM + f_setfill("",50-lenByte(FRAN_NM),"R");  //매출대표명
           var FSDE_PT_OC_YN    =  "0";
           var FSDE_PT          =  fill("0",10);   
           var BIRTH_PT_OC_YN   =  "0";
           var BIRTH_PT         =  fill("0",10);   
           var WEDD_DT_PT_OC_YN =  "0";
           var WEDD_DT_PT       =  fill("0",10);   
           var ADDM_RS_PT_OC_YN1=  "0";
           var ADDM_RS_PT1      =  fill("0",10);   
           var ADDM_RS_PT_OC_YN2=  "0";
           var ADDM_RS_PT2      =  fill("0",10);   
           var MBR_INFO_RQ      =  "1";    //회원정보요청
           var ORGL_INFO_YN     =  ls_orgl_info_yn;     //1.원개래 정보 있음 2.원거래 정보 없음
           var ORGL_INFO_DIV    =  ls_orgl_info_div;    //"1":운영사 원승인정보, "2":참여사 원승인정보
           var ORGL_PERM_NO     =  ls_orgl_perm_no;     //원 승인번호
           var ORGL_DE_DT       =  ls_orgl_de_dt;       //원 승인날짜

           var ksn_encData = akmem_card_ksn1 + akmem_card_encData1; //KSN(20)+Base64(EncData)(64)  18.02.12 최보성
           //2019.06.21 ljs : 전문 XA->XB 변경으로 암호화된 카드번호(제휴카드인 경우)일때만 ENC_CARD_NO 값이 처리되도록 보완
           if( ls_akmem_card_no != null && ls_akmem_card_no.indexOf("*") == -1 ) { ksn_encData = ""; }    
           
           var ENC_CARD_NO =  pID == 'XB243S'?f_setfill(ksn_encData,84,"R"):f_setfill("",84,"R") ; // 여전법이후 항목 추가 18.02.12 최보성 전문IC XB241S 아닐 때 스페이스 처리

           var ls_data =   WCC + PERM_RQ_DIV + CARD_NO + CUS_NO + FML_PT_MG_NO + PSWD + FRAN_CD + TEAM_CD ;
           ls_data   = ls_data +  PTCP_PERM_NO + DE_DT + DE_PTM + DE_DIV + DE_RSON + RS_USE_DIV_CD + USE_PT + SL_NM; 
           ls_data   = ls_data +  FSDE_PT_OC_YN + FSDE_PT + BIRTH_PT_OC_YN + BIRTH_PT + WEDD_DT_PT_OC_YN + WEDD_DT_PT + ADDM_RS_PT_OC_YN1 + ADDM_RS_PT1 ;
           ls_data   = ls_data +  ADDM_RS_PT_OC_YN2 + ADDM_RS_PT2 + MBR_INFO_RQ + ORGL_INFO_YN + ORGL_INFO_DIV + ORGL_PERM_NO + ORGL_DE_DT + ENC_CARD_NO; //Filler는 항목 추가 안하고  스페이스 처리

           send_data   =   f_setfill( ls_header + ls_data, 1024, "R"); //1024byte를 항상 채워준다.                        
   }
    return send_data;
}  
function AKmem_Header(pID,pType){
    var ls_send_programID       =  pID ;    //멤버스 회원인증 
    var ls_store	=	$("#selBranch").val();
    var ls_inst_cd  ;
        //기관코드 셋팅
        if( ls_store == "01" )  {  ls_inst_cd   =   "1011"; }
        if( ls_store == "02" )  {  ls_inst_cd   =   "1031"; }
        if( ls_store == "03" )  {  ls_inst_cd   =   "1021"; }
        if( ls_store == "04" )  {  ls_inst_cd   =   "1041"; }
        if( ls_store == "05" )  {  ls_inst_cd   =   "1021"; }//분당점과 동일하게 되어있지만 신경쓰지 않아도 됨 문의사항 멤버스로
        if( ls_inst_cd == "" )  {  alert("기관코드 셋팅 오류 전산실 연락"); return; }
                                    
    var product = ls_send_programID + "0000" + space(32);
    //var product = ls_send_programID + "0000" + "00000000000000000000000000000000";

    //헤더 셋팅
    var HD_TY           =   "I" //요청
    var GRAM_NO ;       //전문번호(2000:회원인증요청,1110:포인트적립요청,1120:포인트적립취소, 1210:마일리지사용, 1220:마일리지사용취소)
        if(pID == "XA241S" || pID == "XB241S") {   GRAM_NO =   "2000"; } // 여전법이후 전문IC XB241S  추가 18.02.12 최보성
        if(pID == "XA242S" || pID == "XB242S") {   
            if(pType == 'SAVE'){   GRAM_NO =   "1110";  }
            if(pType == 'CANCEL'){ GRAM_NO =   "1120";  }
        }
        //2019.03.25 ljs :마일리지사용/취소 추가
        if(pID == "XA243S" || pID == "XB243S") {   
            if(pType == 'USE'){    GRAM_NO =   "1210";  }
            if(pType == 'CANCEL'){ GRAM_NO =   "1220";  }
        }  
    var INST_CD     =   ls_inst_cd ;
    var TRS_DT      =   "@@@@@@@@"; //매출일자
    var TRS_PTM     =   "@@@@@@";       //시분초
    var GRAM_DIV        =   "ON";       //ONLINE
    var RSP_CD      =   "  ";
    var DATA_SZ     ;   //data size(header+deail)
        if(pID == "XA241S" || pID == "XB241S") {   DATA_SZ =   "0193"; } // 여전법이후 전문IC XB241S 추가 18.02.12 최보성
        if(pID == "XA242S" || pID == "XB242S") {   DATA_SZ =   "0840"; }
        if(pID == "XA243S" || pID == "XB243S") {   DATA_SZ =   "0391"; } //2019.03.25 ljs :마일리지사용/취소 추가
    var SYS_AREA        =   "                    "; 
    
    var ls_header   =   product + HD_TY + GRAM_NO + INST_CD + TRS_DT + TRS_PTM + GRAM_DIV + RSP_CD + DATA_SZ + SYS_AREA ;   
    
    return ls_header;
}
function cardSelectFg(){
	var flag = $("#normal_type").val();
	cancel_card_amt = 0;
	$("[name='pere_idx']").each(function() 
	{
		if($(this).is(":checked") )
		{
			var cancel_idx = $(this).attr('id').replace("pere_idx", "cancel_idx");
			cancel_reason = $("#"+cancel_idx).val(); //취소사유
			
			var result = JSON.parse(decodeURI($(this).val()));
			if(!isNaN(result.CARD_AMT))
			{
				cancel_card_amt += Number(result.CARD_AMT);
			}
		}
	});
	
	if(cancel_card_amt > 0)
	{
		card_amt = cancel_card_amt;
	}
	else
	{
		card_amt = final_pay - cash_amt - coupon_amt - mcoupon_amt - point_amt;
	}
	$("#card_amt").val(card_amt);
	
	
	if(card_amt == 0 && cancel_card_amt == 0) 
	{
		alert("결제금액이 없습니다.");
		return;
	} 

	if(flag == "card"){ // 카드 승인구분 세팅
		is_wcc = "A";
	}else if(flag == "samPay"){
		is_wcc = "M";
	}	
	 cardController("card"); 
}//cardSelectFg(flag)
function cardController(gubun){
	var sD;
	var sE;
	var ret; 
	var sendData;
	var conTest = cardX.ReqReset();
	if(conTest <0){
		//alert("단말기가 정상적으로 연결되지 않았습니다.");
//		setCardReaderOpen(cardX);
		//return
	}
	if(gubun == "card") {
		sendData = 
					"0"					//거래 구분자	AN(1)	“0” :  신용  , “1” : 교통 , “2” : 신용 + 멤버쉽
				   +"0"					//거래 종류	AN(1)	“0” :  구매  , “1” : 취소
				   +getTimeStamp()		//거래 일시	AN(14)	YYYYMMDDHHMMSS
				   +f_setfill(card_amt,9,'L')			//거래 금액	AN(9)	Right Justfy
				   +f_setfill_zero(pos_no,8,'L')  //"00802327"//f_setfill_zero(pos_no,8,'L') 			//단말기 ID	AN(8)	"단말기 ID(TID) :“0”으로 Padding8자리가 넘는 경우 8자리까지만 사용"
				   +"2"					//EMV PIN 설정	AN(1)	"“1” : PIN 입력,“2” : PIN 입력 안 함 (ED-946 은 사용안함)“3” : 은련만 PIN 입력"
				   +"1"				    //Card Input 설정	AN(1)	"“1” : MS/IC, “2” : Only MS, “3” : Only IC( 기능 Disable )“4”:KEYIN : 서명패드 에서 지원"
				   +"1"					//"EMV MS거래 허용 여부"	AN(1)	"“1” : MS 거래허용, “2” : MS 거래불가( 기능 Disable )"
				   +f_setfill("21",16,'R')				//SEED DATA	AN(16)	RANDOM DATA		
				   +"05"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
				   +"140000200300944541942150451842";				//카드사 BIN 	AN(6xN)	RANDOM DATA	   
				   //+"03"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
				   //+"140000200300944541";				//카드사 BIN 	AN(6xN)	RANDOM DATA	
		ret = cardX.ReqCmd( 0xFB, 0x11, 0x20, sendData, sE);
		ret = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "처리중입니다.", sE);

	}else if(gubun == "member") {
		 sendData = "2"					//거래 구분자	AN(1)	“0” :  신용  , “1” : 교통 , “2” : 신용 + 멤버쉽
				   +"0"					//거래 종류	AN(1)	“0” :  구매  , “1” : 취소
				   +getTimeStamp()		//거래 일시	AN(14)	YYYYMMDDHHMMSS
				   +f_setfill(card_amt,9,'L')				//거래 금액	AN(9)	Right Justfy
				   +f_setfill_zero(pos_no,8,'L')  			//단말기 ID	AN(8)	"단말기 ID(TID) :“0”으로 Padding8자리가 넘는 경우 8자리까지만 사용"
				   +"2"					//EMV PIN 설정	AN(1)	"“1” : PIN 입력,“2” : PIN 입력 안 함 (ED-946 은 사용안함)“3” : 은련만 PIN 입력"
				   +"1"				    //Card Input 설정	AN(1)	"“1” : MS/IC, “2” : Only MS, “3” : Only IC( 기능 Disable )“4”:KEYIN : 서명패드 에서 지원"
				   +"1"					//"EMV MS거래 허용 여부"	AN(1)	"“1” : MS 거래허용, “2” : MS 거래불가( 기능 Disable )"
				   +f_setfill("21",16,'R')				//SEED DATA	AN(16)	RANDOM DATA				
				   +"05"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
				   +"140000200300944541942150451842";				//카드사 BIN 	AN(6xN)	RANDOM DATA	   
				   //+"03"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
				   //+"140000200300944541";				//카드사 BIN 	AN(6xN)	RANDOM DATA
		ret = cardX.ReqCmd( 0xFB, 0x11, 0x20, sendData, sE);
		ret = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "처리중입니다.", sE);				
	}
	
	if(ret < 0)
	{	
		cardX.ReqReset();
		alert(cardX.ErrMsg);
	} else {
		//alert();
		/**  IC 카드 = 거래구분 (1) : C(IC 거래) / FIlter (3) : '' 
		 *   RF 카드 = 거래구분 (1) : R(RF 거래),I(IR 거래) 
		 *			  / 이통사구분 (1) : S(SKT), K(KTF), L(LGT) 
		 *			  / 카드방식 (1) : M(Mobile), P(Plastic) 
		 *			  /카드종류 (1) : V(Visa Wave), P(Pay pass), M(Mifare), L(BC모바일), q(qVDC)
		 *   MS 카드 = 거래구분 (1) : M(MS 거래) 
		 *			  / FallBack구분 (1) : Space(정상), F(FallBack거래시)
		 *			  / FallBack사용여부 (1) : 1(chip 전원을 넣었으나 응답이 없을 경우) 
		 *				    				  ,2(상호지원 Application이 없을 경우)
		 *									  ,3(Chip 데이터 읽기 실패) 
		 *									  ,4(Mandatory 데이터 미포함)
		 *									  ,5(CVM command 응답 실패)
		 *									  ,6(EMV command 잘못 설정)
		 *									  ,7 터미널 오작동
		 *			  /MS거래 설정여부 (1) : P(설정), space(그외)
		 */
		 
		// cmc - 키 심어진게 랜덤 일 수 있으므로 체크하여 넣어 준다.
		console.log(cardX.RcvData);
		var cardX_cnt = cardX.RcvData.substr(55,1);
		var cardX_ing = cardX.RcvData.substring(56);
		var enc = "";
		var enc1 = "";
		var enc2 = "";
		var enc3 = "";
		var enc4 = "";
		
		for(var i=0; i<cardX_cnt; i++){
			switch(i){
				case 0 :
					if(cardX_ing.substr(6, 2) == "24") {
						enc = cardX_ing.substr(28, 130);
						cardX_ing = cardX_ing.substring(158);	// 키 자른 나머지 데이터
					}
					else {
						enc = cardX_ing.substr(28, 64);
						cardX_ing = cardX_ing.substring(92);	// 키 자른 나머지 데이터
					}
					break;
				case 1 :
					if(cardX_ing.substr(6, 2) == "24") {
						enc1 = cardX_ing.substr(28, 130);
						cardX_ing = cardX_ing.substring(158);	// 키 자른 나머지 데이터
					}
					else {
						enc1 = cardX_ing.substr(28, 64);
						cardX_ing = cardX_ing.substring(92);	// 키 자른 나머지 데이터
					}
					break;
				case 2 :
					if(cardX_ing.substr(6, 2) == "24") {
						enc2 = cardX_ing.substr(28, 130);
						cardX_ing = cardX_ing.substring(158);	// 키 자른 나머지 데이터
					}
					else {
						enc2 = cardX_ing.substr(28, 64);
						cardX_ing = cardX_ing.substring(92);	// 키 자른 나머지 데이터
					}
					break;
				case 3 :
					if(cardX_ing.substr(6, 2) == "24") {
						enc3 = cardX_ing.substr(28, 130);
						cardX_ing = cardX_ing.substring(158);	// 키 자른 나머지 데이터
					}
					else {
						enc3 = cardX_ing.substr(28, 64);
						cardX_ing = cardX_ing.substring(92);	// 키 자른 나머지 데이터
					}
					break;
				case 4 :
					if(cardX_ing.substr(6, 2) == "24") {
						enc4 = cardX_ing.substr(28, 130);
						cardX_ing = cardX_ing.substring(158);	// 키 자른 나머지 데이터
					}
					else {
						enc4 = cardX_ing.substr(28, 64);
						cardX_ing = cardX_ing.substring(92);	// 키 자른 나머지 데이터
					}
					break;
				default :
				// 카드사 추가 될 시 늘려 줘야 함. - cmc
			}
		}
		
		var danmal_data = cardX.RcvData;
		if(gubun == "card"){
			ic_card_rfFlag = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			ic_card_cvm = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			ic_card_onlineYN = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			ic_card_cardNo = danmal_data.substring(0,40); danmal_data = danmal_data.substring(40);
			ic_card_modelNo = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
			ic_card_encDtCnt = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			ic_card_vanCode = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			ic_card_encGubun = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			ic_card_ksn = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			ic_card_encData = danmal_data.substring(0,enc.length); danmal_data = danmal_data.substring(enc.length);
			ic_card_vanCode1 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			ic_card_encGubun1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			ic_card_ksn1 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			ic_card_encData1 = danmal_data.substring(0,enc1.length); danmal_data = danmal_data.substring(enc1.length);
			ic_card_vanCode2 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			ic_card_encGubun2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			ic_card_ksn2 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			ic_card_encData2 = danmal_data.substring(0,enc2.length); danmal_data = danmal_data.substring(enc2.length);
			ic_card_vanCode3 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			ic_card_encGubun3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			ic_card_ksn3 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			ic_card_encData3 = danmal_data.substring(0,enc3.length); danmal_data = danmal_data.substring(enc3.length);
			ic_card_vanCode4 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			ic_card_encGubun4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			ic_card_ksn4 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			ic_card_encData4 = danmal_data.substring(0,enc4.length); danmal_data = danmal_data.substring(enc4.length);
			ic_card_emv = cardX.Emv;
			
			
			ic_card_cardFlag1 = ic_card_rfFlag.substring(0,1);
			ic_card_cardFlag2 = ic_card_rfFlag.substring(1,2);
			ic_card_cardFlag3 = ic_card_rfFlag.substring(2,3);
			ic_card_cardFlag4 = ic_card_rfFlag.substring(3,4);
			
			//fallback check
			
			//인증심사 T-002 : ‘정상적인 Fall-back 거래’에 따른 신용거래 처리 확인
			if(ic_card_rfFlag.substring(0,2) =="MF"){
				ic_card_fallback_gubun = ic_card_cardFlag2;
				ic_card_fallback_reason = "0"+ic_card_cardFlag3;
				var fbrs = ic_card_fallback_reason;
				if(!(fbrs=="01" ||fbrs=="02" ||fbrs=="03" ||fbrs=="04" ||fbrs=="05" ||fbrs=="06" ||fbrs=="07")){
						var fbmsg = "";
						if(fbrs=="01"){
							fbmsg = "Chip 전원을 넣었으나 응답이 없을 경우";
						}else if(fbrs=="02"){
							fbmsg = "상호지원 Application이 없을 경우"; 
						}else if(fbrs=="03"){
							fbmsg = "Chip 데이터 읽기 실패"; 
						}else if(fbrs=="04"){
							fbmsg = "Mandatory 데이터 미포함"; 
						}else if(fbrs=="05"){
							fbmsg = "CVM command 응답 실패"; 
						}else if(fbrs=="06"){
							fbmsg = "EMV command 잘못 설정";
						}else if(fbrs=="07"){
							fbmsg = "터미널 오작동";
						}
						alert("비정상 F/B 입니다.\n"+
								"["+fbrs+"]: "+fbmsg+
								" \n카드등록을 다시 해주세요.")
					return; 
				}	
			}	
			ic_card_hide_card_no = ic_card_cardNo;
			
			setCardNoRead(); //카드 분류하기
			
			//autoSign();

		}else if("member"){
			akmem_card_rfFlag = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			akmem_card_cvm = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			akmem_card_onlineYN = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			akmem_card_cardNo = danmal_data.substring(0,40); danmal_data = danmal_data.substring(40);
			akmem_card_modelNo = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
			akmem_card_encDtCnt = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			akmem_card_vanCode = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			akmem_card_encGubun = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			akmem_card_ksn = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			akmem_card_encData = danmal_data.substring(0,enc.length); danmal_data = danmal_data.substring(enc.length);
			akmem_card_vanCode1 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			akmem_card_encGubun1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			akmem_card_ksn1 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			akmem_card_encData1 = danmal_data.substring(0,enc1.length); danmal_data = danmal_data.substring(enc1.length);
			akmem_card_vanCode2 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			akmem_card_encGubun2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			akmem_card_ksn2 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			akmem_card_encData2 = danmal_data.substring(0,enc2.length); danmal_data = danmal_data.substring(enc2.length);
			akmem_card_vanCode3 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			akmem_card_encGubun3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			akmem_card_ksn3 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			akmem_card_encData3 = danmal_data.substring(0,enc3.length); danmal_data = danmal_data.substring(enc3.length);
			akmem_card_vanCode4 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			akmem_card_encGubun4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			akmem_card_ksn4 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			akmem_card_encData4 = danmal_data.substring(0,enc4.length); danmal_data = danmal_data.substring(enc4.length);
			akmem_card_emv = cardX.Emv;
			
			//fallback check
			if(akmem_card_rfFlag.substring(0,2) =="MF"){
				akmem_card_fallback_gubun = akmem_card_cardFlag2;
				akmem_card_fallback_reason = "0"+akmem_card_cardFlag3;
				var fbrs = ic_card_fallback_reason;
				if(!(fbrs=="01" ||fbrs=="02" ||fbrs=="03" ||fbrs=="04" ||fbrs=="05" ||fbrs=="06" ||fbrs=="07")){
						var fbmsg = "";
						if(fbrs=="01"){
							fbmsg = "Chip 전원을 넣었으나 응답이 없을 경우";
						}else if(fbrs=="02"){
							fbmsg = "상호지원 Application이 없을 경우"; 
						}else if(fbrs=="03"){
							fbmsg = "Chip 데이터 읽기 실패"; 
						}else if(fbrs=="04"){
							fbmsg = "Mandatory 데이터 미포함"; 
						}else if(fbrs=="05"){
							fbmsg = "CVM command 응답 실패"; 
						}else if(fbrs=="06"){
							fbmsg = "EMV command 잘못 설정";
						}else if(fbrs=="07"){
							fbmsg = "터미널 오작동";
						}
						alert("비정상 F/B 입니다.\n"+
								"["+fbrs+"]: "+fbmsg+
								" \n카드등록을 다시 해주세요.")
					return; 
				}	
			}							
			akmem_card_hide_card_no = akmem_card_cardNo;

			AKmem_cardRead();  //카드 분류하기
		}	
		danmal_data = "";
	}

}//cardController

function setCardNoRead() {
	var hideCode = ic_card_hide_card_no;
	var num_length = hideCode.indexOf("=");
	
	//분당점이면 카드센싱시 첫번째자리 지움
	
	/* TEST시만 주석 꼭 풀기 ★★★★★★★★★★★★★★★★★★
	card_no.value = hideCode.substring(0, num_length);
	*/
	
	/* 기존소스 백업(2013.01.22)
	if($("#selBranch").val() == "03") {
		card_no.value = hideCode.substring(1, num_length);
	}else {
		card_no.value = hideCode.substring(0, num_length);
	}
	*/
	
	/*분당점 카드센싱기 교체진행(2013.01.22)  기존소스 주석처리필요 ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
	  전점 통일
	*/
	$("#ic_card_no").val(hideCode.substring(0, num_length));
	ic_card_no = $("#ic_card_no").val();
	
	
	if(ic_card_encDtCnt != "0"){
		encCardNoSendStr("card");
	}
	// 무서명체크 추가로 기존소스 백업 (10.06.10) 	
	// var ls_ret_str = f_card_gubun_nm("all", model.getValue("/root/req/card_no"));
	var ls_ret_str			= f_card_gubun_nm("new", ic_card_no);
	var ls_card_fg			= ls_ret_str.substring(0, 1)
	ic_card_co_origin_seq	= ls_ret_str.substring(1, 4);
	ic_card_sain_fg		= ls_ret_str.substring(4, 5);
	ic_card_nm				= ls_ret_str.substring(5);
	
	//AK기프트(555), 홈플러스(666) 멤버스 적립 불가 체크 추가(2012.01.17) -----------------------
	if(((ic_card_co_origin_seq =="555" )) && (akmem_total_point > 0 )
		&& ((akmem_card_no != null ) || (trim(akmem_card_no) != "" ))) {
		
		alert("[AK기프트카드]는 멤버스 적립이 불가능합니다! [신용카드]로 카드등록 다시 해주시기 바랍니다.!!");
		return;
	} 
	//--------------------------------------------------------------------
	
	// 분당점 경우 청구 벤사  nice : 2으로 구로,수원점 경우 kicc:3 으로 변경 08. 05.04    <-- 오류 
	// 2: 타사카드, 3 : 유통제휴카드 로 원복처리 08. 05.19
	//if($("#selBranch").val() == "03") {
	if(ls_card_fg != "3") {
		if(ic_card_co_origin_seq == "822" ) {  //  "823"은 테스트용 추후 검토 후 삭제 최보성 || ic_card_co_origin_seq == "823"
			ls_card_fg = "4";	 // 신한제휴는 4
		}else if(ic_card_co_origin_seq == "555") {
			ls_card_fg = "5";	 // AK기프트카드는 5  (2012.01.06) 추가
		}else if(ic_card_co_origin_seq == "666") {
			ls_card_fg = "6";	 // 홈플러스카드는 6  (2012.01.17) 추가
		}else if(ic_card_co_origin_seq == "042") {
			ls_card_fg = "8";	 // AK KB국민카드 8  (2017.09.26) 추가
		}else if(ic_card_co_origin_seq == "034") {
			ls_card_fg = "W";	 // AK 우리카드 W  (2020.02.03 kjp) 추가
		}else{
			ls_card_fg = "2";
		}
	}

			// 삼성페이는 "M" 으로 저장 (단, BC/현대카드는 이미 "93" 을 사용하고 있어 제외함) 여전법 이전 사
//						var checkSamPay = hideCode.substring(24, 26);
//						//alert("hideCode : " + hideCode + "\ncheckSamPay : " + checkSamPay + "\nic_card_co_origin_seq : " + ic_card_co_origin_seq);
//						if(ic_card_co_origin_seq != "031" && ic_card_co_origin_seq != "951") {	// BC/현대카드 제외 (BC : 031, 현대 : 951)
//							if(checkSamPay == "93") {										// 삼성페이
//								ls_card_fg = "M";
//							}
//						}
	
	// 삼성페이는 "M" 으로 저장 (단, BC/현대카드는 이미 "93" 을 사용하고 있어 제외함)
	var checkSamPay = is_wcc;

	//alert("hideCode : " + hideCode + "\ncheckSamPay : " + checkSamPay + "\nic_card_co_origin_seq : " + ic_card_co_origin_seq);
	//if(ic_card_co_origin_seq != "031" && ic_card_co_origin_seq != "951") {	// BC/현대카드 제외 (BC : 031, 현대 : 951)//2018.01.30 최보성 삼성페이 등록시 결제는 모두 삼성페이구분
		if(checkSamPay == "M") {										// 삼성페이
			ls_card_fg = "M";
		}
	//}
	//}else {
	//	ls_card_fg = "3";
	//}

	//  개인정보 복호화 START (10.02.03)   ----------------------
	//var strDesCardno = model.getValue("/root/data/card_data/card_no");
	// 암호화 하여 보여줌(0:암호화,1:복호화) 여전법 이전
	//out_card_no_des.value  = des3Object.GetDesProd( strDesCardno,0);
	//model.setValue("/root/data/card_data/card_no_des",  des3Object.GetDesProd( strDesCardno,0));
	// 개인정보 복호화 END ------------------------------------------
	
	ic_card_data_fg = ls_card_fg;
	ic_card_nm = ic_card_nm;
	ic_card_sain_fg = ic_card_sain_fg;
	
	$("#ic_card_no").val(ic_card_no);
	$("#ic_card_nm").val(ic_card_nm);
	
	var hideCode2 = hideCode.substring(num_length+5, num_length+11);
	ic_card_hide_card_gubun = hideCode2;
	
	/*여전법 시행 IC단말기에서 유효년월을 가져오지 않음 2018.01.23**/
//	valid.value = hideCode.substring(num_length + 3, num_length + 5) + hideCode.substring(num_length + 1, num_length + 3);
	
	//AK멤버스 등록된 카드만 사용가능함 (문화센터는 제외 090106 정재형dr 확인 )
	/*
	if(AKmem_RegiCard_check(model.getValue("/root/data/card_data/card_no")) == false){
		alert("등록된 연계카드가 아닙니다. 결재를 계속할수 없습니다.");
		//return; //임시로 막아둠 test
	}
	*/
}//setCardNoRead
function AKmem_cardRead() {
	var akmem_hideCode = akmem_card_hide_card_no;
	var num_length = akmem_hideCode.indexOf("=");
	
	$("#akmem_card_no").val(Track4Cardno(akmem_hideCode));
	akmem_card_no = Track4Cardno(akmem_hideCode);
	//card read
	AKmem_cardStatusCheck();  
}//AKmem_cardRead()				


function Track4Cardno(cardNo){
    //trackdata 의 left 4 byte 가 7700 이면 드림카드로 간주함. 그 외 는 16 byte 를 return
    var returnCardNo = "";
    var num_length = cardNo.indexOf("=");   
    if(num_length == -1) num_length = 16;
    
    if(cardNo.substring(0,4) == "7700") {
        //드림카드 이면 
        returnCardNo = f_setfill_zero(cardNo.substring(4, num_length - 1),16,"R");
    } else if(cardNo.substring(0,1) == "0") {
        returnCardNo = cardNo.substring(4, num_length) ;
    } else {
        returnCardNo = f_setfill(cardNo.substring(num_length-16, num_length),16,"R"); 
    }
    return returnCardNo;
}
function akmem_use()
{
	var this_val = $("#point_amt").val();
	this_val = this_val.replace(/[^0-9]/g, '');
	$("#point_amt").val(this_val);
	
	var pointAmt = 0;
	var akmemUseMinPoint = eval(nullCheck(akmem_use_min_point));  //최소사용 포인트
	var akmemUseMaxPoint = eval(nullCheck(akmem_use_max_point));  //최대사용 포인트
	var akmemUseHurdle   = eval(nullCheck(akmem_use_hurdle));     //사용단위(허들) 포인트
	
	point_amt = $("#point_amt").val();
	//재료비체크
	if(total_food_amt > 0) {
//		alert("마일리지로 재료비를 받을 수 없습니다.")
//		$("#point_amt").val('0');
//		point_amt = 0;
//		return;
	}
	//카드승인여부체크
	if(!isNull(ic_card_approve_no)) {
		alert("카드승인을 받고 난 후에는 마일리지을 등록할 수 없습니다.");
		$("#point_amt").val('0');
		point_amt = 0;
		return;
	}
	
	// 사용단위설정 : 사용단위 0인 경우 10으로 설정(현금계산 고려해서..)
	if(point_amt > 0 && akmemUseHurdle == 0){
		akmemUseHurdle = 10;
	}	
		
	//최소사용포인트 설정 : 최소사용포인트 0인 경우 10으로 설정(현금계산 고려해서..)
	if(point_amt > 0 && akmemUseMinPoint == 0){
		akmemUseMinPoint = 10;
	}
	//최대사용포인트 설정 : 최대사용포인트 0인 경우 총마일리지로 설정
	if(point_amt > 0 && akmemUseMaxPoint == 0){
		akmemUseMaxPoint = Number(Number(Number(akmem_total_point)/akmemUseMinPoint)*akmemUseMinPoint);
	}

	//alert("point_amt.value[" + point_amt.value + "] akmemUseMinPoint[" 
	//+ akmemUseMinPoint + "] akmemUseMaxPoint[" + akmemUseMaxPoint + "] akmemUseHurdle[" + akmemUseHurdle +"]");
	
	if(point_amt != null && point_amt != "" && point_amt != 0) 
	{
		pointAmt = eval(nullCheck(point_amt));
		var pointCk = pointAmt % akmemUseHurdle;  //사용단위포인트 check
        var totalRegisFee = eval(nullCheck(total_regis_fee));  //결재금액						
		
		if(pointCk > 0 || pointCk < -0)
		{ 
			alert("마일리지 사용단위는 "+ akmemUseHurdle + "점 입니다.");
			point_amt = 0;
			return;
			
		}
		else if(pointAmt < akmemUseMinPoint)
		{
			alert("최소사용 마일리지는 "+ akmemUseMinPoint + "점 입니다.");
			point_amt = 0;
			return;
		}
		else if(pointAmt > akmemUseMaxPoint)
		{
			alert("최대사용 마일리지는 "+ akmemUseMaxPoint + "점 입니다.");
			point_amt = 0;
			return;
		}
		else if(pointAmt > totalRegisFee)
		{
			alert("사용마일리지가 결재금액보다 많습니다. 결재금액은 "+ totalRegisFee + "원 입니다.");
			point_amt = 0;
			return;
		}	
	}					


	// 단말기 입력 - 패스워드입력받음 (keyInControl)
	var keyVl = keyInControl_akmem();
	var aKmemPswd = akmem_pswd;
    var keyTryYn = "N";
	//alert("keyVl==>" + keyVl);
	//alert("aKmemPswd==>" + model.getValue("/root/data/akmem_point/AKmem_Pswd"));
	
	//2019.05.30 ljs  현업요청 : 비밀번호 3번 시도 가능하도록 처리
	for(var i =1; i < 3 ; i++)
	{
		if(aKmemPswd == keyVl){
			keyTryYn = "N";
			break;
		}
		
		//2019.06.18 ljs  비밀번호입력 취소시
		if(keyVl == -1)
		{
			$("#point_amt").val('0');
			point_amt = 0;
			return;							
		}
		else if(keyVl == ""){
			keyTryYn = "Y";
			alert("비밀번호 " + i + "번 틀리셨습니다.");
			//keyVl = keyInControl();
			//model.setValue("/root/data/akmem_point/point_amt", 0);
			//point_amt.value = 0;
			//return;
		}	
		else if(aKmemPswd != keyVl){
			keyTryYn = "Y";
			alert("비밀번호 " + i + "번 틀리셨습니다.");
			//model.setValue("/root/data/akmem_point/point_amt", 0);
			//point_amt.value = 0;
			//return;
		}
		
		if(keyTryYn == "Y")
		{
			keyVl = keyInControl_akmem();
			aKmemPswd = akmem_pswd;
		}
	}
	
	if(keyTryYn == "Y")
	{
		alert("비밀번호 3번이상 틀리셨습니다. AK멤버스센터에 문의하세요.");
		$("#point_amt").val('0');
		point_amt = 0;
		return;							
	}
	
    if(aKmemPswd == keyVl){
		//사용마일리지 결제
		point_approve_yn = "Y";
		point_amt = pointAmt;
		
	    eventPayFg();

		//영수증번호조회
	    
	    $.ajax({
			type : "POST", 
			url : "/member/lect/getRecpt",
			dataType : "text",
			async:false,
			cache : false,
			data : 
			{
				store : $("#selBranch").val(),
				pos_no : pos_no
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				recpt_no = data;
			}
		});
	    
	    
	    var recptNo = recpt_no;
		

		var regisAmt = total_regis_fee;
		var foodAmt = total_food_amt;

		//대표강좌 셋팅(주차 2018.19.19)
		rep_subject_cd = subject_arr.split("|")[0];

		var enuri	   = encd_pay1 + encd_pay2;

		//AKmembers 포인트 사용요청 
		if(akmem_sApprovNo == "00"){
	
			//2019.03.11 ljs 사용요청 마일리지가 0원 이상일때만 실행 START
			if(point_amt > 0){
				AKmem_pointUse(); //AKmembers Point USE 포인트 사용

				if(akmem_use_sApprovNo != '00' ) 
				{
					point_approve_yn = "N";
					$("#point_amt").val('0');
					point_amt = 0;
					eventPayFg();

					alert("마일리지사용 승인 실패하였습니다.");
					return;
				}	
				else
				{
					
				}
			}
			//2019.03.11 ljs 사용요청 마일리지가 0원 이상일때만 실행 END
		}								
		
		alert("마일리지사용 승인되었습니다.");
		return;							
	}
}
function AKmem_pointUse() 
{
	var ls_store	     =	$("#selBranch").val();
	var ls_akmem_card_no =	akmem_card_no;
	var tranGubun        = akmem_card_rfFlag;
	
	// 유효성체크
	if(ls_akmem_card_no == null || trim(ls_akmem_card_no) == "" ) 
	{
		return;
	}					
	
	var send_data = ""; // 카드멤버쉽 전문 생성 여전법이후 , MS = XA241S, IC = XB241S 전문 IC사용
	
	if(trim(tranGubun) == "M" || akmem_card_fg == "@")
	{
		send_data = AKmem_Run('XB243S','USE');
	}else
	{
		//2019.06.24 ljs 암호화된 카드번호 복호화 하여 처리
		var use_akmem_cardno = akmem_card_no;
		send_data = AKmem_Run('XB243S','USE');
		//2019.06.24 ljs 암호화된 카드번호 복호화 하여 처리
		//encCardNoSendStr("akmem");//멤버쉽 카드 복호화
	}	
	ls_akmem_send_str = send_data;

	//포인트 사용요청 Transaction
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetAkmemCustInfo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			hq : '00',
			store : $("#selBranch").val(),
			send_data : send_data,
			akmem_encCardNo_send_str : akmem_card_encCardNo_send_str,
			
			pos_no : pos_no,
			recpt_no : recpt_no,
			total_pay : total_pay,
			total_enuri_amt : encd_pay1 + encd_pay2,
			total_regis_fee : final_pay,
			total_show_amt : total_pay,
			akmem_card_no : akmem_card_no,
			akmem_point_amt : point_amt
	
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			akmem_use_sApprovNo = result.sApprovNo;
			if(akmem_use_sApprovNo != '00')
			{
				alert("[포인트조회 오류!]"+result.sMessage);
				alert("[포인트사용 오류!] 포인트 번호 메모 후 전산실로 연락 바랍니다. ");
				return;
			}
			else
			{
				
			}
		}
	});
}//AKmem_pointUse()   //AKmembers Point 사용 포인트 : 2019.03.11 ljs 추가 END
//KeyIn 조회 호출 프로세스 START (2019.03.11 ljs : 맴버스포인트 비밀번호 조회)
function keyInControl_akmem(){
	var sD = "";
	var sE;
	var reVl = "";
	var ret; 
	// 단말 연결 확인
	var conTest = cardX.ReqReset();
	if(conTest <0){
		alert("단말기가 정상적으로 연결되지 않았습니다.");
		return;  //2019.03.11 "" --> false 변경
	}
		
	//서명패드 senddata 설정
		sD = "#01"+10+"패스워드를 입력 해 주세요.";			
		
	// 단말 호출
	ret =  cardX.ReqCmd( 0xF8, 0, 0,"", sE);
	ret =  cardX.WaitCmd( 0xF9,  sD, 0, 1, "비밀번호입력중입니다.", sE);
	//서명패드 입력값 세팅
	reVl = cardX.RcvData;

	if(ret < 0){
		cardX.ReqReset();
		//alert(cardX.ErrMsg);
		return reVl;
	} else {
		//alert(cardX.RcvData);
//		cardDanMemReset();
	
		return reVl;
	}
}		
// KeyIn 조회 호출 프로세스 END (2019.03.11 ljs : 맴버스포인트 비밀번호 조회)
function QRChipData()
{
	if($("input[name=payment_type]:checked").val() == "simple")
	{
		var QrData = $("#ic_card_no").val()
		
		var AddData = "0" + "0" +  getTimeStamp() + "000000001" + "00000000";
		var sR = "";
		var ret;
		
		try {
			ret = CardX.GetQRChipData(QrData, AddData, sR, 0);	// BCQR 데이터를 dll 호출하여 리턴값을 받아온다.
			sR = CardX.Data;														// 받아온 데이터
			
			if (sR != null || sR != "" ) {
				bcQrData(sR);  // 데이터 부모 창으로 보냄
			}
			else {
				alert("qr코드가 확인되지 않습니다. 재 진행 바랍니다.");
			}
			sR = null;
			alert("인식완료");
		}
		catch(err) {
			
			alert(err.name + ": " + err.message);
			alert("에러발생. QR코드 스캔 진행을 다시 해 주시기 바랍니다.");
		}
	}
}
function bcQrData(sR) {
	
//	if(!isNull(pay_card)) {	//카드금액setting
//		model.setValue("/root/data/card_data/card_total_amt", card_amt);
//		model.refresh();
//	} 
//	else {
//		alert("카드금액을 입력후 등록을 눌러주세요");
//		return;
//	}
//	search_fg.disabled = false;
	bc_qr_value = sR;
	
	
	if(bc_qr_value == null || bc_qr_value == "" ){
		alert("에러발생. QR코드 스캔 진행을 다시 해 주시기 바랍니다.");
		return;
	}
	
	var qr_card_no_real = (bc_qr_value.substr(6, 40)).substr(0, (bc_qr_value.substr(6, 40)).indexOf("="));// 리얼 카드 번호
	var qr_card_no =  qr_card_no_real.substring(0,6) + "******" +  qr_card_no_real.substring(12); 
	
	var ls_ret_str = f_card_gubun_nm("new", qr_card_no_real);	// 카드정보를 가져 온다.
	var ls_card_fg			    = ls_ret_str.substring(0, 1);
	ic_card_co_origin_seq	= ls_ret_str.substring(1, 4);
	ic_card_sain_fg		    = ls_ret_str.substring(4, 5);
	ic_card_nm				= ls_ret_str.substring(5);
	
	is_wcc = "I";		// IC카드 거래로 인식 하게끔 -> 승인조회시  카드에 따라 Q 나 q 로 변경
	ls_card_fg = "Q"; // KICC 로 van 청구 해야 함.

	$("#ic_card_no").val(qr_card_no);
	$("#ic_card_nm").val(card_nm);
	ic_card_no = qr_card_no;
	ic_card_data_fg = ls_card_fg;
	ic_card_encCardNo_send_str = qr_card_no;
	ic_card_hide_card_no =  qr_card_no_real;
		
	qr_card_no_real = "";
	qr_card_no = "";
}

var signAct = ""; //결제인지 취소인지
function autoSign(act)
{
	cancel_card_amt = 0;
	$("[name='pere_idx']").each(function() 
	{
		if($(this).is(":checked") )
		{
			var cancel_idx = $(this).attr('id').replace("pere_idx", "cancel_idx");
			cancel_reason = $("#"+cancel_idx).val(); //취소사유
			
			var result = JSON.parse(decodeURI($(this).val()));
			if(!isNaN(result.CARD_AMT))
			{
				cancel_card_amt += Number(result.CARD_AMT);
			}
		}
	});
	
	if(ic_card_no == "" && cancel_card_amt > 0)
	{
		alert("취소처리할 카드를 등록해주세요.");
		return;
	}

	if(cancel_card_amt == 0 && act == 'cancel')
	{
		signText = "1";
		posCancel();
		return;
	}
	
	var ls_card_corp_cd	=	ic_card_co_origin_seq;
	var ls_card_sain_fg	=	ic_card_sain_fg;
	var ls_halbu_no    	=	ic_card_month;
	var cardAmt = 0;
	
	signAct = act;
	if(act == 'send')
	{
		cardAmt = card_amt;
	}
	else if(act == 'cancel')
	{
		cardAmt = cancel_card_amt;
	}
	
	if(ls_halbu_no == "00") {
		if( (  (ls_card_corp_cd == "822") || (ls_card_corp_cd == "823") ) && ( cardAmt <= 50000 )) {
			signText = "1";
			alert("[신한카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if( (  (ls_card_corp_cd == "002") || (ls_card_corp_cd == "003") || (ls_card_corp_cd == "004")|| (ls_card_corp_cd == "005")||
					   (ls_card_corp_cd == "992")|| (ls_card_corp_cd == "993")) && ( cardAmt <= 50000 )) {
			signText = "1";
			alert("[삼성카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if(  (ls_card_corp_cd == "031")  && ( cardAmt <= 50000 )  && ( ls_card_sain_fg  == 'Y' ) ) {
		//}else if(  (ls_card_corp_cd == "031")  && ( cardAmt <= 50000 )  ) {		기존소스 백업 (10.06.10)
			signText = "1";
			alert("[BC카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if( ((ls_card_corp_cd == "041") || (ls_card_corp_cd == "042")) && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[국민카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if(  (ls_card_corp_cd == "951")  && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[현대카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if(  (ls_card_corp_cd == "052")  && ( cardAmt <= 50000 )  && ( ls_card_sain_fg  == 'Y' ) ) {
		//}else if(  (ls_card_corp_cd == "052")  && ( cardAmt <= 50000 ) ) {	    기존소스 백업(12.06.26)
			signText = "1";
			alert("[외환카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if(  (ls_card_corp_cd == "961")  && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[롯데카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if(  ls_card_corp_cd == "555") {	
			signText = "1";
			alert("[AK-GIFT카드]는 금액대 무관 전자서명 무서명 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else if(  (ls_card_corp_cd == "061")  && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[NH카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			if(act == 'send'){approveCheck();}
			else{posCancel();}
		}else{        
			signView();
			var sE;
			cardX.ReqSignA (2,"0788888",cardAmt,"","",sE);
		}
	}else {
		signView();
		var sE;
		cardX.ReqSignA (2,"0788888",cardAmt,"","",sE);
	}	
}


function signView(act)
{
	$('#give_layer').fadeIn(200);
	$(".close").fadeIn(200);
}
function closeSignView()
{
	$('#give_layer').fadeOut(200); 
	ic_card_sign = cardX.Sign;
	if(signAct == "send")
	{
		approveCheck();
	}
	else 
	{
		posCancel();
	}
}
function approveCheck() {
	ic_card_month = $("#month").val();
	// IC단말기 유효기간정보 받지 않음(추후 APP카드로 인해 변경가능) 여전법 이후
	
	var ls_send_programID		= "XB071S"; //전문IC[6]
	var ls_receive_programID	= "XA071R";
	var KFTC_TERM_ID			= "9047000000";	//의미없는 cat_id 데몬에서 cat_id 생성
	var NICE_TERM_ID			= "9540030001";
	var KICC_TERM_ID			= "104504";
	var s = 0;

	var ls_hq 				=	'00'; // 본부코드[2]
	var ls_store 			=	$("#selBranch").val(); //점포코드[2]
	var ls_pos_no 			=	pos_no; //POS번호[6]

	var check_card_amt  	=	card_amt;
	var ls_card_no     		=	ic_card_no; 
	var ls_halbu_no    		=	ic_card_month; //할부개월[2]
	var ls_amt         		=	card_amt; //금액[11]
	var is_valid_date   	=	ic_card_valid; // 유효기간 
	var ls_card_corp_cd		=	ic_card_co_origin_seq; //카드사고유일련번호[3]
	var ls_approve_no 		=	ic_card_approve_no;   //원승인번호[8]
	
	

//카드승인전 유효성체크
	if(ls_card_no == null || trim(ls_card_no) == "" || trim(ls_card_no).length < 12) {
		alert("카드번호를 입력해주세요");
		return;
	}
	
	if(ls_card_corp_cd == null || trim(ls_card_corp_cd) == "" || trim(ls_card_corp_cd).length != 3) {
		alert("카드번호를 다시 입력해주세요");
		return;
	}

	if(ls_card_corp_cd == "888") {
		alert("KT패스카드입니다");
		return;
	}

	 //한국관광카드로는 결제불가
	if(ls_card_no.substring(0, 6) == "409336" || ls_card_no.substring(0, 6) == "942069") {
		alert("한국관광카드로는 결제 할 수 없습니다.");
		return;
	}
	//여전법으로 유효기간 체크 불필요 2018.01.24 최보성
//		if(is_valid_date == null || trim(is_valid_date) == "" || trim(is_valid_date).length != 4) {
//			alert("유효기간을 입력해주세요");
//			model.setFocus("valid");
//			return;
//		}

	if(ls_halbu_no == null || trim(ls_halbu_no) == "") {
		alert("할부개월을 입력해주세요");
		return;
	}
	
	if(ls_halbu_no.length < 2) {
		alert("할부개월을 2자리로 입력해주세요");
		return;
	}	
	
	if(ls_amt == null || trim(ls_amt) == "" || ls_amt == "0") {
		alert("결제금액을 입력해주세요");
		return;
	}

	if(trim(ls_approve_no) != "") {
		alert("승인번호가 이미 조회되었습니다.");
		return;
	}
	
	if(trim(ls_amt) != trim(check_card_amt)) {
		alert("카드금액이 일치하지 않습니다. 카드등록을 다시 해주세요");
		return;
	}

	if(ls_card_no.substring(0, 4) == "3601") {
		alert("자사카드는 사용하지 않습니다!");
		return;
	}
	
	/*
	//AK멤버스 등록된 카드만 사용가능함 (문화센터는 제외 090106 정재형dr 확인 )
	if(AKmem_RegiCard_check(model.getValue("/root/data/card_data/card_no")) == false){
		alert("등록된 연계카드가 아닙니다. 결재를 계속할수 없습니다.");
		//return;	//임시로 막아둠 TEST
	}
	*/

//	autoSign();//여전법 이후 승인전 사인 받기

	if(signText == "1")
	{
		signT = signText;
	}
	else
	{
		signT = ic_card_sign;
		signText = ic_card_sign;
	}
	

	if(signT == null || signT == undefined|| signT === "" || trim(signT) === ""){
		alert("사인이 되지 않았습니다. \n승인번호 조회 버튼을 다시 눌러주시길 바랍니다.");
//				cardX.ReqReset(); 
//				autoSign();
		return;
	}	
	
	if(is_wcc == "A" || is_wcc == "M" || is_wcc == "I") { // 여전법 이후 카드거래 구분
		//var card_data = model.getValue("/root/req/hide_card_no");  여전법이전 2018.01.25 최보성
		//"SECU"+기종번호(4)+버전(4)+암호구분(2)+KSN(20)+Base64(EncData)(64) 여전법이후 2018.01.25 최보성
		var card_data = "SECU"+ic_card_modelNo
						+ic_card_encGubun
						+ic_card_ksn
						+ic_card_encData; 
		


		//카드리더기-분당점은 KDE 리더기 사용으로 앞에 @문자가 붙어 해당 부분을 잘라내는 작업이 선행되어야 한다. 2008.02.25
		//구로, 수원은 카드리더기에 따라서 첫자리 제거 여부를 판단해야함
		
		/*분당점 카드센싱기 교체진행(2013.01.22)  기존소스 주석처리필요 ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
		  전점 통일							
		if(ls_hq == "00" && ls_store == "03") {
		   --	TEST시만 주석달기/ REAL은 활성화 꼭!!  ★★★★★★★★★★★★★★★
			card_data			= card_data.substring(1);   

		}
		*/
		
		var amt         	= ls_amt.toString();
		s					= 11 - amt.length;
		var ls_amt			= fill("0", s) + amt;
		var is_card_data 	= f_setfill(card_data, 37, "R" );
		//var length 			= card_data.length;
		var length 			= "098"; // 2018.01.24 최보성 변경
		is_wcc         = "I" // 2018.01.24 최보성 추가
	} else if(is_wcc == "@") {// 여전법 이전 매뉴얼 거래 
		var amt         	= ls_amt;
		s					= 11 - amt.length;
		var ls_amt 			= fill("0", s) + amt;
		var ls_ymd   		= is_valid_date;
		var ls_card_data1 	= trim(ls_card_no) + "=" + ls_ymd.substring(2, 4) + ls_ymd.substring(0, 2);
		var is_card_data  	= f_setfill( ls_card_data1, 37, "R" );
		var length 			= ls_card_data1.length;
	}

		//----------------------------------------------//
		//    카드 승인조회 로직                        //
		//----------------------------------------------//
	//var product = ls_send_programID + "0000" + space(32);
	var product = ls_send_programID + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
	
	//------여전법이전------------------------------------------------------//
	// 본부코드[2] + 점코드[2] + POS번호[6] + 터미널ID(KFTC :10자리)[15] +  // 
	// 터미널ID(NICE :10자리)[15] + 터미널ID[15] + 카드/수표구분[2]   +     //
	// WCC(A/@)자동,수동[1] + 카드데이터길이[2]  + 카드사 일련번호[3] +     //
	// 카드데이터[37] + 할부개월[2] + 금액[11]   + PIN_DATA(PASSWORD)[4]    // 
	//---여전법 이후(타사카드경우)----------------------------------------------------------------------------------------------------//
	// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]+터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]                    //
	// +WCC[1]+길이[3]+카드사고유일련번호[3]+카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]                    //
	// +WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]+거래구분[1]+이통사구분[1]+카드방식[1]              //
	// +RF카드종류[1]+동글매체구분[1]+단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] //
	//------------------------------------------------------------------------------------------------------------------//
	/*  기존소스 백업함(09.03.24)
	
		  var ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
				+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
				+ is_wcc + length + ls_card_corp_cd 
				+ is_card_data + ls_halbu_no + ls_amt + "BBBB";
	
	
	 BBBB : 식품관 가맹점 승인됨
	 분당점 식품관 가맹점 / 구로,수원 백화점 가맹점 승인되었음 (구로,수원 식품관 가맹점이 없었으므로 BBBB 보내도 백화점가맹점처리되었음)
	 구로점 09.03.25 부터 식품관 가맹점 추가로 분당점만 BBBB /구로, 수원은 Space 4자리 처리요망  (09.03.24 김경명과장 요청SDS POS담당자 )
	 
	 */
	
	var ls_gubun =  "    "; //전점 백화점가맹점으로 변경(자금팀 송진영,박진범 요청 2017.09.13)
	
	// (09.04.20 평택점 식품관 가맹점 처리로 수정 :김경명, 정재형 ) 기존  분당점 식품관 가맹점 "BBBB" 처리
	// if ((ls_hq == "00" && ls_store == "03") || (ls_hq == "00" && ls_store == "04")) {   
	// 구로점, 수원점 백화점 가맹점 space(4) 처리
	
	
	// 구로점 식품관 가맹점으로 승인요청변경(10.10.25- 홍선미주임)  취소시 원거래 가맹점 정보로 승인취소 요청!!
	/* (new) 전점 백화점 가맹점 요청(2013.06.09)  평택점 제외
	ls_gubun =  "    "; 
	*/
	
	/* 기존소스백업(2013.06.09) 
	(new) 전점 백화점 가맹점 요청(2013.06.09)  평택점 제외  (13.06.10) 송진영 주임 
	if (ls_hq == "00" && ls_store == "04" ) {
		ls_gubun = "BBBB";
	}else{
		ls_gubun =  "    "; 
	}
	
	  기존소스 백업(11.06.01) 
		 var ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
				+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
				+ is_wcc + length + ls_card_corp_cd 
				+ is_card_data + ls_halbu_no + ls_amt + ls_gubun;
	*/
	//-------------------------------------------------------------------------------------------------------
	// 은련카드 포멧변경으로 전문 요청 수정(11.06.01) 각 점별 별도 오픈되어 점별 구 전문포멧/신 전문포멧 구분 추가
	//-------------------------------------------------------------------------------------------------------
	var ls_send_str_F = "";// KB전문 실패시 추가 전문
	var ls_pre_ack_no = "";   		//원승인번호[8]
	var ls_pre_sale_ymd = "";   	//원매출일자[6]
	var ls_filler = "";				//FILLER[2]예약필드(2)
	var ls_working = "";			//WorkingKey[16]은련카드 비밀번호(16)
	var ls_royalty = "";			// 로열티데이터[203] //여전법이전->(BC파트너스) 부가세율(2) + 할인여부(1) + 로열티 Data + space 로열티 데이터는 POS API가 전달한 그대로의 Data 값을 Setting
	var ls_resi_no = "";			// 주민번호(식품점사용)(13)
	
	var ls_send_str = "";
	
	// KICC 단말변경 2018.01.24 최보성
	var pin_Data = ""; //PIN_DATA[4]

	var trsnGubun1 = ic_card_cardFlag1; //RF FLAG 첫째자리 ->'R' (RF거래), 'I'(IR 거래) 'M' (MS거래) 'C' (IC거래) 
	var trsnGubun2 = ic_card_cardFlag2; //RF FLAG 둘째자리 ->SKT : 'S', KTF : 'K' , LGT : 'L' (RF거래/이통사구분), 'I'(IR 거래) 'F' (MS거래) '' (IC거래)			
	var mbCorp  = "";
	var cardTp  = "";
	var rfCdKnd = "";
	var fbReason = ""; //Fallback사유[2]
	var emvYN = "Y";
	var emvReqdata = ic_card_emv.replace("$",""); //EMV요청DATA[400]
	var emvReqdata2 = ic_card_emv.replace("$",""); //EMV요청DATA[400] - 씨티카드
	
	/*****거래 구분 세팅 여전법 이후 start *************************/
	if(trsnGubun1 == "R" || trsnGubun1 == "I" || is_wcc == "M" ){
		 mbCorp = ic_card_cardFlag2; //+이통사구분[1]
		 cardTp = ic_card_cardFlag3; //+카드방식[1]
		 rfCdKnd = ic_card_cardFlag4; //+RF카드종류[1]					
		if(trsnGubun1 == "R"  && ls_card_corp_cd  == "031") {//BCNFC
			ls_send_programID = "NFB71S" ;
		}else if(trsnGubun1 == "R"  && ls_card_corp_cd  == "030000"){//payon
			is_wcc = "P" 
			ls_send_programID = "PYB71S" ;
		}
	}else if(trsnGubun2 == "F"){//MSR 거래시 fb
		is_wcc = "F";
		fbReason = ic_card_fallback_reason; 
		emvYN ="N";
		emvReqdata = "";
	}else if(trsnGubun1 == "M"){
		emvYN ="N";							
		is_wcc = "A";
		emvReqdata = "";
	}else{
		
		//cmc12345 - 씨티카드 로직 추가
		if(trsnGubun1 == "C") {
			
			var citi_check = ic_card_pri_nm;
			
			if( citi_check == "씨티카드" ){
				emvReqdata = emvReqdata.substr(0,10) + "43" + emvReqdata.substring(12);
			}
			else {
			}
		}
		else {
		}
				
		trsnGubun1 = '';
		is_wcc = "I";						
	}	

	if(trsnGubun1 == "R" && emvReqdata.replace("19454D0000","").length === 0){//삼성페이 RF 거래시 
		emvYN ="N";							
		is_wcc = "A";		
		emvReqdata = "";
	}	
	/*****거래 구분 세팅 여전법 이후 end *************************/
	/* 전문  New 
	
	ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
					+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
					+ is_wcc + length + ls_card_corp_cd 
					+ is_card_data + ls_halbu_no + ls_amt + ls_gubun 
					+ f_setfill(ls_pre_ack_no,8,"R") +  f_setfill(ls_pre_sale_ymd,6,"R") + f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") 
					+ f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");	
	
	if(ls_card_corp_cd == "666") {
		alert("[홈플러스선불카드]는 2017년 6월30일 이후로 사용할수 없습니다.")
	} */
	
	/***승인전문세팅 start*******************************************/
	var key_card_data = "";
	var is_KB_card_data = "";
	var is_BC_card_data = "";
	var is_SH_card_data = "";
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 벤사키
	if(ic_card_vanCode == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "140000" ){
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 유통키 
	if(ic_card_vanCode == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "200300" ){
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		key_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 국민 
	if(ic_card_vanCode == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "944541" ){
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		is_KB_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 비씨
	if(ic_card_vanCode == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "942150" ){
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		is_BC_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 신한
	if(ic_card_vanCode == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "451842" ){
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		is_SH_card_data = "";
	}

	// AK기프트(555),홈플러스(666) 카드 승인 추가(2012.01.10) START  ------------------------------------------
	if(ls_card_corp_cd == "555") {
		if(total_food_amt > 0) {
			alert("[AK기프트카드]로 재료비를 받을 수 없습니다.")
			//card_form_reset();
			return;
		}
		
		if(is_wcc == "@") {
			alert("[AK기프트카드]는 카드등록 swipe만 가능합니다. [manual] 결제불가!!!!");
			//card_form_reset();
			return;
		}	
		 
		//점서버로 변경 밑에 if 추후 삭제 2016.10.10  기프트,선불카드 헤더
//			if (ls_store != "03" ) { 	 //분당점외 나머지 지점 경우 
			ls_send_programID		= "XB075S";
			ls_receive_programID	= "XB075R";
//			}else {								 //분당점 경우 
//				ls_send_programID		= "XM090S";  
//				ls_receive_programID	= "XM090R";
//			}
		
		//product = ls_send_programID + "0000" + space(32);
		  product = ls_send_programID + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
		  length = "098";
		//영수증번호 
		  $.ajax({
				type : "POST", 
				url : "/member/lect/getRecpt",
				dataType : "text",
				async:false,
				cache : false,
				data : 
				{
					store : $("#selBranch").val(),
					pos_no : pos_no
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					recpt_no = data;
				}
			});
		  
		var recptNo = recpt_no;
		is_wcc = "A";
		 //본부코드[2]+점포코드[2]+POS 번호[6]+거래번호[4]+CARD구분[2]
		ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(recptNo,4,"R")  + "10"
					//WCC[1]+길이[3]+카드사[3]+카드번호(암호화)[98]+할부개월[2]+금액[11]+PIN_DATA(PASSWORD)[4]
					+ is_wcc + length + ls_card_corp_cd + f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill_zero(ls_amt,11,'L') + f_setfill(pin_Data,4,'R');
	} else if(ls_card_corp_cd == "041" || ls_card_corp_cd == "042" ) {
		// 2017.07.12 황인철 - "국민카드(041)", "국민제휴카드(042)" 일 경우 KB직승인 시작
		//ls_send_programID		= "XA271S";
		ls_send_programID		= "XB271S";

		product 		= ls_send_programID + "0000" + space(32);
		length = "164"
		var today		= new Date();
		var today_str	= f_setfill_zero((today.getMonth()+1)+"",2,"L") + f_setfill_zero(today.getDate() + "",2,"L");
		var time_str	= f_setfill_zero(today.getHours() + "",2,"L") + f_setfill_zero(today.getMinutes() + "",2,"L") + f_setfill_zero(today.getSeconds() + "",2,"L");
		
		var trOpTm		= time_str;						// 거래개시시간 (신규)
		var trOpDt		= today_str;					// 거래개시일 (신규)
		var trSeq		= ls_pos_no + "0000" + "01";	// 거래일련번호 (신규) - POSNO(6) + 거래번호(4) + SEQ(2)
		/*  cmc - 위에서 정의 해서 내려오게 수정
		var is_KB_card_data    = "SECU"+ic_card_modelNo
							+ic_card_encGubun2
							+ic_card_ksn2
							+ic_card_encData2; 
		*/
//		ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
//						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
//						+ is_wcc + length + ls_card_corp_cd 
//						+ is_card_data + ls_halbu_no + ls_amt + ls_gubun 
//						+ f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,165,"R")
//						+ f_setfill(trOpTm,6,"R")		// 거래개시시간 (신규)
//						+ f_setfill(trOpDt,4,"R")		// 거래개시일 (신규)
//						+ f_setfill(trSeq,12,"R")		// 거래일련번호 (신규)
//						+ f_setfill(ls_pre_ack_no,8,"R") 	// 원승인번호 (신규)
//						+ f_setfill(ls_pre_sale_ymd,8,"R");	// 원거래일자 (신규)
						
//			alert("send : " + ls_send_programID + "\n전문[" + ls_send_str.length + "] : " + ls_send_str);
		
		// 2017.07.12 황인철 - "국민카드(041)", "국민제휴카드(042)" 일 경우 KB직승인 끝

		//2018.04.12 최보성 여전법 이후		
			//본부코드[2]+점포코드[2]+POS 번호[6]+터미널ID1[15]+터미널ID2[15]+
	  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")+ f_setfill(NICE_TERM_ID,15,"R")  
			//터미널ID3[15]+CARD/수표구분[2]+WCC[1]+VAN/직승인[2]+길이[3]+카드사 고유일련번호[3]+  
			+f_setfill(KICC_TERM_ID,15,"R")  + "10" + is_wcc+ "01" + length + ls_card_corp_cd   
			//VAN 카드 DATA[98]+직승인 카드 DATA[98]+전문추적번호[12]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]	is_KB_card_data
			+ f_setfill(key_card_data,98,'R')+ f_setfill(is_KB_card_data,164,'R')+f_setfill(trSeq,12,"R") + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
			//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
			+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd,6,"R") 
			//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
			+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
			 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
			+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,402,"R")   ;
				
			// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
	  ls_send_str_F = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
			// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
			+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
			// WCC[1]+길이[3]+카드사고유일련번호[3] 
			+ is_wcc + "098" + ls_card_corp_cd                                        
			 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
			+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
			//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
			+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd,6,"R") 
			//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
			+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
			 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
			+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;
	}
	//else if(ls_card_corp_cd == "031") {	//BC 카드 직승인 전문 시작
	else if(ls_card_corp_cd == "031" || ls_card_corp_cd == "033" || ls_card_corp_cd == "034") {	//2020.02.03 kjp BC 카드 직승인 전문 우리카드 추가
		ls_send_programID		= "XB414S";
		// product = 전문ic + 응답코드 + 단품 INDEX정보 + 소스 INDEX정보 + CLASS INDEX정보 + 담당자 INDEX정보
		product 		= ls_send_programID + "0000" + "       0" + "       0" + "       0" + "       0";
		//var trSeq		= ls_pos_no + "0000" + "01";	//전문추적번호  POSNO(6) + 거래번호(4) + SEQ(2)
		var today		= new Date();
		var time_str	= f_setfill_zero(today.getHours() + "",2,"L") + f_setfill_zero(today.getMinutes() + "",2,"L") + f_setfill_zero(today.getSeconds() + "",2,"L");
		
		var trSeq		= ls_pos_no + time_str;	//전문추적번호  POSNO(6) + 거래번호(4) + SEQ(2)time_str
		
		ls_send_str = ls_hq 							 //본부코드[2]
					+ ls_store							 //점포코드[2]
					+ ls_pos_no							 //POS 번호[6]
					+ f_setfill(KFTC_TERM_ID,15,"R")	 //터미널ID1[15]
					+ f_setfill(NICE_TERM_ID,15,"R")  	 //터미널ID2[15]
					+ f_setfill(KICC_TERM_ID,15,"R")	 //터미널ID3[15]
					+ "10"								 //CARD/수표구분[2]
					+ is_wcc							 //WCC[1]
					+ "02"								 //VAN/직승인[2] - 00 - VAN, KB - 01, BC - 02, SH - 03
					+ "164"								 //길이[3]  - van_ic = 098 , 직승인iC = 164 
					+ ls_card_corp_cd 					 //카드사 고유일련번호[3]
					+ f_setfill(key_card_data,98,'R')		 //유통키 카드 DATA[98]
					+ f_setfill(is_BC_card_data,164,'R') //직승인 카드 DATA[164]  "SECU"+기종번호(4)+버전(4)+암호구분(2)+KSN(20)+HexaString(130)
					+ f_setfill(trSeq,12,"R")			 //전문추적번호[12]   POSNO(6) + 거래번호(4) + SEQ(2)
					+ f_setfill(ls_halbu_no,2,'R')		 //할부개월[2]
					+ f_setfill(ls_amt,11,'R')			 //금액[11]
					+ f_setfill(pin_Data,4,"R")          //PIN_DATA[4]
					+ f_setfill(ls_filler,2,"R")         //FILLER[2]	is_K_card_data
					+ f_setfill(ls_working,16,"R")		 //WorkingKey[16]
					+ f_setfill(ls_royalty,203,"R")		 //로열티데이터[203]
					+ f_setfill(ls_pre_ack_no,8,"R")	 //원승인번호[8]
					+ f_setfill(ls_pre_sale_ymd,6,"R")	 //원매출일자[6]
					+ f_setfill(trsnGubun1,1,"R")		 //거래구분[1]
					+ f_setfill(mbCorp,1,"R")			 //이통사구분[1]
					+ f_setfill(cardTp,1,"R")			 //카드방식[1]
					+ f_setfill(rfCdKnd,1,"R")			 //RF카드종류[1]
					+ space(1) 							 //동글매체구분[1]
					+ "B" 								 //단말종류구분[1]
					+ f_setfill(posCertiNo,16,"R") 		 //POSSW식별번호[16]
					+ f_setfill(fbReason,2,"R") 		 //Fallback사유[2]
					+ emvYN 							 //EMVData유무[1]
					+ f_setfill(emvReqdata,402,"R") ;	 //EMV요청DATA[400]
					
		//직승인 실패 시 van사 통해 결제 위해 사용되는 값(미리 만들어서 같이 보내는 용도로 사용됨)
		ls_send_str_F = ls_hq							 //본부코드[2]
					  + ls_store 						 //점포코드[2]
					  + ls_pos_no 						 //POS번호[6]
					  + f_setfill(KFTC_TERM_ID,15,"R")   //터미널ID1[15]
					  + f_setfill(NICE_TERM_ID,15,"R")	 //터미널ID2[15]
					  + f_setfill(KICC_TERM_ID,15,"R")	 //터미널ID3[15]
					  + "10"                             //CARD/수표구분[2] 
					  + is_wcc							 //WCC[1]
					  + "098"							 //길이[3]
					  + ls_card_corp_cd 				 //카드사고유일련번호[3] 
					  + f_setfill(card_data,98,'R')		 //카드DATA[98]
					  + f_setfill(ls_halbu_no,2,'R')	 //할부개월[2]
					  + f_setfill(ls_amt,11,'R')		 //금액[11]
					  + f_setfill(pin_Data,4,"R")		 //PIN_DATA[4]
					  + f_setfill(ls_filler,2,"R")		 //FILLER[2]
					  + f_setfill(ls_working,16,"R")	 //WorkingKey[16]
					  + f_setfill(ls_royalty,203,"R")	 //로열티데이터[203]
					  + f_setfill(ls_pre_ack_no,8,"R")	 //원승인번호[8]
					  + f_setfill(ls_pre_sale_ymd,6,"R") //원매출일자[6]
					  + f_setfill(trsnGubun1,1,"R")	 	 //거래구분[1]
					  + f_setfill(mbCorp,1,"R")			 //이통사구분[1]
					  + f_setfill(cardTp,1,"R")			 //카드방식[1]
					  + f_setfill(rfCdKnd,1,"R")		 //RF카드종류[1]
					  + space(1) 						 //동글매체구분[1]
					  +"B"								 //단말종류구분[1]
					  + f_setfill(posCertiNo,16,"R")	 //POSSW식별번호[16]
					  + f_setfill(fbReason,2,"R")		 //Fallback사유[2]
					  + emvYN							 //EMVData유무[1]
					  + f_setfill(emvReqdata2,400,"R") ;	 //EMV요청DATA[400]
	}
	else if(ls_card_corp_cd == "822" || ls_card_corp_cd == "823" ) {	//신한 카드 직승인 전문 시작
	
		ls_send_programID		= "XB424S";
		// product = 전문ic + 응답코드 + 단품 INDEX정보 + 소스 INDEX정보 + CLASS INDEX정보 + 담당자 INDEX정보
		product 		= ls_send_programID + "0000" + "       0" + "       0" + "       0" + "       0";
		var trSeq		= ls_pos_no + "0000" + "01";	//전문추적번호  POSNO(6) + 거래번호(4) + SEQ(2)
		
		ls_send_str = ls_hq 							 //본부코드[2]
		            + ls_store							 //점포코드[2]
					+ ls_pos_no							 //POS 번호[6]
					+ f_setfill(KFTC_TERM_ID,15,"R")	 //터미널ID1[15]
					+ f_setfill(NICE_TERM_ID,15,"R")  	 //터미널ID2[15]
					+ f_setfill(KICC_TERM_ID,15,"R")	 //터미널ID3[15]
					+ "10"								 //CARD/수표구분[2]
					+ is_wcc							 //WCC[1]
					+ "03"								 // VAN/직승인[2] - 00 - VAN, KB - 01, BC - 02, SH - 03
					+ "164"								 //길이[3]  - van_ic = 098 , 직승인iC = 164 
					+ ls_card_corp_cd 					 //카드사 고유일련번호[3]
					+ f_setfill(key_card_data,98,'R')		 //VAN 카드 DATA[98]
					+ f_setfill(is_SH_card_data,164,'R') //직승인 카드 DATA[164]  "SECU"+기종번호(4)+버전(4)+암호구분(2)+KSN(20)+HexaString(130)
					+ f_setfill(trSeq,12,"R")			 //전문추적번호[12]   POSNO(6) + 거래번호(4) + SEQ(2)
					+ f_setfill(ls_halbu_no,2,'R')		 //할부개월[2]
					+ f_setfill(ls_amt,11,'R')			 //금액[11]
					+ f_setfill(pin_Data,4,"R")          //PIN_DATA[4]
					+ f_setfill(ls_filler,2,"R")         //FILLER[2]	is_K_card_data
					+ f_setfill(ls_working,16,"R")		 //WorkingKey[16]
					+ f_setfill(ls_royalty,203,"R")		 //로열티데이터[203]
					+ f_setfill(ls_pre_ack_no,8,"R")	 //원승인번호[8]
					+ f_setfill(ls_pre_sale_ymd,6,"R")	 //원매출일자[6]
					+ f_setfill(trsnGubun1,1,"R")		 //거래구분[1]
					+ f_setfill(mbCorp,1,"R")			 //이통사구분[1]
					+ f_setfill(cardTp,1,"R")			 //카드방식[1]
					+ f_setfill(rfCdKnd,1,"R")			 //RF카드종류[1]
					+ space(1) 							 //동글매체구분[1]
					+ "B" 								 //단말종류구분[1]
					+ f_setfill(posCertiNo,16,"R") 		 //POSSW식별번호[16]
					+ f_setfill(fbReason,2,"R") 		 //Fallback사유[2]
					+ emvYN 							 //EMVData유무[1]
					+ f_setfill(emvReqdata,402,"R") ;	 //EMV요청DATA[400]
					
		//직승인 실패 시 van사 통해 결제 위해 사용되는 값(미리 만들어서 같이 보내는 용도로 사용됨)
		ls_send_str_F = ls_hq							 //본부코드[2]
		              + ls_store 						 //점포코드[2]
					  + ls_pos_no 						 //POS번호[6]
					  + f_setfill(KFTC_TERM_ID,15,"R")   //터미널ID1[15]
					  + f_setfill(NICE_TERM_ID,15,"R")	 //터미널ID2[15]
					  + f_setfill(KICC_TERM_ID,15,"R")	 //터미널ID3[15]
					  + "10"                             //CARD/수표구분[2] 
					  + is_wcc							 //WCC[1]
					  + "098"							 //길이[3]
					  + ls_card_corp_cd 				 //카드사고유일련번호[3] 
			          + f_setfill(card_data,98,'R')		 //카드DATA[98]
					  + f_setfill(ls_halbu_no,2,'R')	 //할부개월[2]
					  + f_setfill(ls_amt,11,'R')		 //금액[11]
					  + f_setfill(pin_Data,4,"R")		 //PIN_DATA[4]
					  + f_setfill(ls_filler,2,"R")		 //FILLER[2]
					  + f_setfill(ls_working,16,"R")	 //WorkingKey[16]
					  + f_setfill(ls_royalty,203,"R")	 //로열티데이터[203]
					  + f_setfill(ls_pre_ack_no,8,"R")	 //원승인번호[8]
					  + f_setfill(ls_pre_sale_ymd,6,"R") //원매출일자[6]
			          + f_setfill(trsnGubun1,1,"R")	 	 //거래구분[1]
					  + f_setfill(mbCorp,1,"R")			 //이통사구분[1]
					  + f_setfill(cardTp,1,"R")			 //카드방식[1]
					  + f_setfill(rfCdKnd,1,"R")		 //RF카드종류[1]
					  + space(1) 						 //동글매체구분[1]
					  +"B"								 //단말종류구분[1]
					  + f_setfill(posCertiNo,16,"R")	 //POSSW식별번호[16]
					  + f_setfill(fbReason,2,"R")		 //Fallback사유[2]
					  + emvYN							 //EMVData유무[1]
					  + f_setfill(emvReqdata,400,"R") ;	 //EMV요청DATA[400]
	}else {
			
		// 구로점 구 전문포멧
		if (ls_hq == "00" && ls_store == "01" ) { 
//				ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")  
//						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
//						+ is_wcc + length + ls_card_corp_cd 
//						+ is_card_data + ls_halbu_no + ls_amt + ls_gubun 
//						+ f_setfill(ls_pre_ack_no,8,"R") +  f_setfill(ls_pre_sale_ymd,6,"R") + f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") 
//						+ f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");	
						// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
				  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
						// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
						// WCC[1]+길이[3]+카드사고유일련번호[3] 
						+ is_wcc + length + ls_card_corp_cd                                        
						 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
						+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
						//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
						+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd,6,"R") 
						//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
						+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
						 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
						+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;
		// 수원점 이면 신 전문포멧으로 승인요청(new)	11.06.06
		}else if (ls_hq == "00" && ls_store == "02" ) {
//				ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
//						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
//						+ is_wcc + length + ls_card_corp_cd 
//						+ is_card_data + ls_halbu_no + ls_amt + ls_gubun 
//						+ f_setfill(ls_pre_ack_no,8,"R") +  f_setfill(ls_pre_sale_ymd,6,"R") + f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") 
//						+ f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");
						// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
				  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
						// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
						// WCC[1]+길이[3]+카드사고유일련번호[3] 
						+ is_wcc + length + ls_card_corp_cd                                        
						 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
						+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
						//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
						+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd,6,"R") 
						//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
						+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
						 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
						+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;
		// 분당점 구 전문포멧
		}else if (ls_hq == "00" && ls_store == "03" ) {
						// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
				  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
						// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
						// WCC[1]+길이[3]+카드사고유일련번호[3] 
						+ is_wcc + length + ls_card_corp_cd                                        
						 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
						+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
						//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
						+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd,6,"R") 
						//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
						+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
						 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
						+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;

		// 평택점 구 전문포멧                                 
		}else if (ls_hq == "00" && ls_store == "04" ) { 
//				  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
//						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
//						+ is_wcc + length + ls_card_corp_cd 
//						+ is_card_data + ls_halbu_no + ls_amt + ls_gubun 
//						+ f_setfill(ls_pre_ack_no,8,"R") +  f_setfill(ls_pre_sale_ymd,6,"R") + f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") 
//						+ f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");
						// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
				  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
						// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
						// WCC[1]+길이[3]+카드사고유일련번호[3] 
						+ is_wcc + length + ls_card_corp_cd                                        
						 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
						+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
						//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
						+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd,6,"R") 
						//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
						+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
						 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
						+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;
		// 원주점 구 전문포멧
		}else if (ls_hq == "00" && ls_store == "05" ) { 
//				  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
//						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
//						+ is_wcc + length + ls_card_corp_cd 
//						+ is_card_data + ls_halbu_no + ls_amt + ls_gubun 
//						+ f_setfill(ls_pre_ack_no,8,"R") +  f_setfill(ls_pre_sale_ymd,6,"R") + f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") 
//						+ f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");
						// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
				  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
						// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
						// WCC[1]+길이[3]+카드사고유일련번호[3] 
						+ is_wcc + length + ls_card_corp_cd                                        
						 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
						+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
						//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
						+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd,6,"R") 
						//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
						+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
						 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
						+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;
		}
		//-------------------------------------------------------------------------------------------------------
	}
	if(bc_qr_value != null && bc_qr_value != ""  ) {
		// BC QR 전문 생성 시작
		ls_send_programID = "XB511S";
		// product = 전문ic + 응답코드 + 단품 INDEX정보 + 소스 INDEX정보 + CLASS INDEX정보 + 담당자 INDEX정보
		// 즉 product = 전문의 HEADER 부분
		product 		= ls_send_programID + "0000" + "00000000" + "00000000" +"00000000" + "00000000" ;
		
		// bc qr 은 card_data 항목 - 카드번호 데이터로 보낸다.
		var qr_track2 = bc_qr_data.substr(6, 40);														// track2 데이터
		var qr_emv_data = bc_qr_data.substring(47, bc_qr_data.length - 46);
		var qr_gubun      = bc_qr_data.substr(3, 1) ; // (L, C)
		var check_bill_fg = "";
		
		if(qr_gubun == "L") {		// QR 코드가 국내 일 시    Q  L						
			is_wcc = "Q";
			check_bill_fg = "10" ;
		}
		else {							// QR 코드가 해외 일 시	  Q  C
			is_wcc = "q";
			check_bill_fg = "22" ;
		}
		
		ls_send_str = ls_hq 										// 본부코드[2]
						 + ls_store  									// 점포코드[2]
						 + ls_pos_no  								// POS번호[6]
						 + f_setfill(KFTC_TERM_ID,15,"R")		// 터미널ID1[15]
						 + f_setfill(NICE_TERM_ID,15,"R")  	// 터미널ID2[15]
						 + f_setfill(KICC_TERM_ID,15,"R")  	// 터미널ID3[15]
						 + check_bill_fg								// CARD/수표구분[2]
						 + is_wcc 										// WCC[1]
						 + "098"	 										// 길이[3] 
						 + ls_card_corp_cd							// 카드사고유일련번호[3]
						 + f_setfill(qr_track2, 98, 'R') 			// 카드DATA[98]
						 + f_setfill(ls_halbu_no,2,'R') 			// 할부개월[2]
						 + f_setfill_zero(ls_amt,11,'L') 		// 금액[11]
						 + f_setfill(pin_Data,4,"R") 				// PIN_DATA[4]
						 + f_setfill(ls_filler,2,"R")					// FILLER[2]
						 + f_setfill(ls_working,16,"R") 			// WorkingKey[16]
						 + f_setfill(ls_royalty,203,"R") 			// 로열티데이터[203]
						 + f_setfill(ls_pre_ack_no,8,"R") 		// 원승인번호[8]
						 + f_setfill(ls_pre_sale_ymd,6,"R")		// 원매출일자[6]
						 + f_setfill(trsnGubun1,1,"R") 			// 거래구분[1]
						 + f_setfill(mbCorp,1,"R") 				// 이통사구분[1]
						 + f_setfill(cardTp,1,"R") 					// 카드방식[1]
						 + f_setfill(rfCdKnd,1,"R") 				// RF카드종류[1]
						 + space(1)									// 동글매체구분[1]
						 +"B" 											// 단말종류구분[1]
						 + f_setfill(posCertiNo,16,"R") 			// POSSW식별번호[16]
						 + f_setfill(fbReason,2,"R") 				// Fallback사유[2]
						 + "Y"	 										// EMVData유무[1]
						 + f_setfill(qr_emv_data,400, "R") ;	// EMV요청DATA[400]
	}
	else {
	}
	
	// AK기프트카드 승인 추가(2012.01.10) END ------------------------------------------
	ls_send_str	= product + ls_send_str;
	ls_send_str	= f_setfill(ls_send_str, 1060, "R");
	ic_ls_send_str = ls_send_str;
	ic_ls_send_str_F = f_setfill(product + ls_send_str_F, 1060, "R");
	
	/* 
	// cminc1115 - 여전법 인증용 -  전문 base64 로 encoding
	var ls_send_str_F2  = product + ls_send_str_F;
	ls_send_str_F2 = f_setfill(ls_send_str_F2, 1060, "R");
	//cminc11111111
	ls_send_str = Base64.encode(ls_send_str);
	ls_send_str_F2 = Base64.encode(ls_send_str_F2);
	
	model.setValue("/root/req/ls_send_str", ls_send_str);
	model.makeValue("/root/req/ls_send_str_F", ls_send_str_F2);
	*/
	
	/***승인전문세팅 end*******************************************/
	
	//카드승인 Transaction
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetApproveNo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			ls_send_str : ic_ls_send_str,
			hq : '00',
			store : $("#selBranch").val(),
			ls_send_str_F : ic_ls_send_str_F
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			data = null;
			$("#ic_card_approve_no").val(result.approve_no);
			ic_card_approve_no = result.approve_no;
			ic_card_return_cd = result.return_cd;
			ic_card_rest_amt = result.rest_amt;
			ic_card_rate = result.rate;
			var ls_message = result.message;
			var rest_amt = result.rest_amt;
			var ls_return_cd = ic_card_return_cd;
			
			result = null;
			
			if(ls_return_cd == "7804" || ls_return_cd == "1401"){
				while( ls_return_cd == "7804" || ls_return_cd == "1401" ) {
					ls_return_cd = "X";	//무한루프 방지
					
					alert("은련QR 고액결제입니다\n" + "고객앱에서 핀번호 입력이 필요합니다.\n" + "핀번호 입력 후 [확인]버튼을 눌러 주세요.");
					
					ls_send_str = ls_hq 										// 본부코드[2]
									 + ls_store  									// 점포코드[2]
									 + ls_pos_no  								// POS번호[6]
									 + f_setfill(KFTC_TERM_ID,15,"R")		// 터미널ID1[15]
									 + f_setfill(NICE_TERM_ID,15,"R")  	// 터미널ID2[15]
									 + f_setfill(KICC_TERM_ID,15,"R")  	// 터미널ID3[15]
									 + "23"											// CARD/수표구분[2]					// bcqr 은련 조회 로 변경 하여 전문 실행
									 + is_wcc 										// WCC[1]
									 + "098"	 										// 길이[3] 
									 + ls_card_corp_cd							// 카드사고유일련번호[3]
									 + f_setfill(qr_track2, 98, 'R') 			// 카드DATA[98]
									 + f_setfill(ls_halbu_no,2,'R') 			// 할부개월[2]
									 + f_setfill_zero(ls_amt,11,'L') 		// 금액[11]
									 + f_setfill(pin_Data,4,"R") 				// PIN_DATA[4]
									 + f_setfill(ls_filler,2,"R")					// FILLER[2]
									 + f_setfill(ls_working,16,"R") 			// WorkingKey[16]
									 + f_setfill(ls_royalty,203,"R") 			// 로열티데이터[203]
									 + f_setfill(ls_pre_ack_no,8,"R") 		// 원승인번호[8]
									 + f_setfill(ls_pre_sale_ymd,6,"R")		// 원매출일자[6]
									 + f_setfill(trsnGubun1,1,"R") 			// 거래구분[1]
									 + f_setfill(mbCorp,1,"R") 				// 이통사구분[1]
									 + f_setfill(cardTp,1,"R") 					// 카드방식[1]
									 + f_setfill(rfCdKnd,1,"R") 				// RF카드종류[1]
									 + space(1)									// 동글매체구분[1]
									 +"B" 											// 단말종류구분[1]
									 + f_setfill(posCertiNo,16,"R") 			// POSSW식별번호[16]
									 + f_setfill(fbReason,2,"R") 				// Fallback사유[2]
									 + "Y"	 										// EMVData유무[1]
									 + f_setfill(qr_emv_data,400, "R") ;	// EMV요청DATA[400]
							 
					ls_send_str	= product + ls_send_str;
					ls_send_str	= f_setfill(ls_send_str, 1060, "R");
					ic_ls_send_str = ls_send_str;
					
					
					$.ajax({
						type : "POST", 
						url : "/member/lect/GetApproveNo",
						dataType : "text",
						async:false,
						cache : false,
						data : 
						{
							ls_send_str : ic_ls_send_str,
							hq : '00',
							store : $("#selBranch").val()
						},
						error : function() 
						{
							console.log("AJAX ERROR");
						},
						success : function(data2) 
						{
							var result2 = JSON.parse(data2);
							data2 = null;
							ls_return_cd = result2.return_cd;
							ls_message = result2.message;
							rest_amt = result2.rest_amt;
							
							ls_send_str = null;
							ls_send_str_F = null;
							result2 = null;
							dataReset();
							
						}
					});
				}
			}
			else {
			}
			// 은련qr 고액 로직 끝 - cmc
			if(ls_message == "잔액부족") 
			{
				ls_message = ls_message +"잔액("+rest_amt+"원)"; 
			}
			
			if(ic_card_approve_no.length < 7 ||
			   trim(ic_card_approve_no) == '') {
			}else {
			//	autoSign(); //최보성 여전법이후 카드읽은 후 서명 받는 걸로 process 변경 완료후 control disable처리
//				Comp_Disable()// 승인 후 결제 완료시
			
				
				
				/********제휴사카드 마일리지 적립여부 및 잔액명기 process start ********************/
				var carddatafg = ic_card_data_fg;		

				//2020.02.03 kjp 우리카드 추가
				//if((carddatafg == "4" || carddatafg == "8")
				if((carddatafg == "4" || carddatafg == "8" || carddatafg == "W")
						&& confirmMsg("제휴카드로 마일리지를 적립하시겠습니까?")) { // 제휴카드 마일리지 적립여부 
					
					akmem_card_hide_card_no = ic_card_cardNo;
					
					AKmem_cardRead();
					
					//2019.06.21 ljs : 사용마일리지 승인후 제휴카드 마일리지 적립시 화면에 사용마일리지 표기되도록 처리 START
//					if(point_amt > 0){
//						model.setValue("/root/data/akmem_point/point_amt", model.getValue("/root/data/pay_data/akmem_point_amt"));
//						model.refresh();
//					}   
					//2019.06.21 ljs : 사용마일리지 승인후 제휴카드 마일리지 적립시 화면에 사용마일리지 표기되도록 처리 END								
				}else{
					
				}
				var restamt = ic_card_rest_amt; //타사/자사 선불카드관련 잔액정보
				//if(carddatafg == "5" || carddatafg == "6" ) { // 잔액명기 18.02.05 최보성 test중
//				if(restamt !=  null && restamt.trim() !=  "" && restamt !=  "000000000" ) { // 잔액명기 18.02.05 최보성 
//					var sbBalance = card_amt + " / 잔액: " + Number(ic_card_rest_amt)+"원";
//					model.makeValue("/root/data/approve_data/balance", sbBalance);
//
//					pay_card.attribute("format") =""; // 결재정보 카드 금액 포맷변경
//					pay_card.attribute("ref") = "/root/data/approve_data/balance"; // 결재정보 카드 금액 참조 변경
//				
//					model.refresh();
//					//model.refreshpart("/root/data/pay_data/card_amt");
//				}
				/********제휴사카드 마일리지 적립여부 및 잔액명기 process end ********************/
			}
		}
	});
	
	
}//approveCheck()
function fncSubmit()
{
	if(subject_arr == "") {
		alert("매상등록할 강좌가 없습니다.");
		return;
	}
	//중복처리 방지 FLAG CHECK
	if(pos_status == "Y"){
		alert("이미 매상등록이 처리가 되었습니다");
		return;
	}
	//중도수강 또는 부분입금 처리시 , 강좌별 결재금액을 반드시 입력하여야 함 (결재정보창에만 입력하고 결재하는 경우를 막음)
//	if(total_regis_fee == 0){
//		alert("수강료 총액이 0원 입니다. 해당 강좌의 수강료를 기입해 주세요");
//		return;
//	}
	var changeCharge = eval(nullCheck(cash_amt)) 
	+ eval(nullCheck(card_amt)) 
	+ eval(nullCheck(coupon_amt)) 
	+ eval(nullCheck(mcoupon_amt)) 
	+ eval(nullCheck(point_amt))   //2019.03.11 ljs : 사용마일리지(akmem_point_amt) 추가
	- eval(nullCheck(final_pay)) ;
	
	if (changeCharge < 0) {
		alert("수강료보다 결제금액이 적습니다. 금액을 확인해주세요");
		return;
	}
	//결재금액과 입금액합계가 not equals = Alert  (거스름돈이 발생하면 안됩)
	if (changeCharge > 0) {
		alert("결제금액과 입금액합계가 다릅니다. 금액을 확인해주세요");
		return;
	}
	if(card_amt > 0)
	{
		if(ic_card_approve_no.length < 5) {//현대카드 승인번호 5자리 현대에서 발급하는 Discover카드(해외)
			alert("카드 승인번호를 확인하여 주십시오.\nIS팀 연락 바랍니다.");
			return;
		}
		if(isNull(ic_card_approve_no)) {
			alert("카드승인을 받지 않으셨습니다.");
			return;
		}
	}
	
	
	var coupon_fg_split = coupon_fg_arr.split("|");
    var coupon_cd_split = coupon_cd_arr.split("|");
    var coupon_no_split = coupon_no_arr.split("|");
    var face_amt_split = face_amt_arr.split("|");
    var cashrec_yn_split = cashrec_yn_arr.split("|");
    var vat_cal_ext_rate_split = vat_cal_ext_rate_arr.split("|");
    var vat_cal_rate_split = vat_cal_rate_arr.split("|");
    var cp_change_amt_split = cp_change_amt_arr.split("|");
    var cp_chage_apy_y_amt_split = cp_chage_apy_y_amt_arr.split("|");
    var cp_chage_apy_n_amt_split = cp_chage_apy_n_amt_arr.split("|");
    var cashrec_amt_split = cashrec_amt_arr.split("|");
    var cashrec_n_amt_split = cashrec_n_amt_arr.split("|");
    
    var coupon_cnt = coupon_fg_split.length -1;
    
    for(var i = 0; i < coupon_cnt; i++)
	{
    	if( ( coupon_no_split[i] == null
  			  || coupon_no_split[i] == "" )
  			 && ( face_amt_split[i] != null
  			     && face_amt_split[i] != ""  )
  		   ){
  				alert("상품권번호는 필수입력입니다.");
  				return;
  			}
	}
	//2019.06.27 ljs 상품권 Grid 빈로우 삭제 END
    
    if(cash_amt > 0)
	{
    	//현금승인번호가 없으면
		if(isNull(cash_approve_no)) 
        {
			//2019.04.26 ljs 현금승인금액체크 0원인 경우 처리 START
			//(지불방법 카드+상품권일때 상품권 모든 금액이 현금영수증제외금액인 경우 현금승인금액 0원인 케이스 발생)
			var card_co_origin_seq 	=  ic_card_co_origin_seq;	
		
			if ((card_co_origin_seq == "555") || (card_co_origin_seq == "666")) {
				cash_amt = eval(nullCheck(cash_amt)) 
							+ eval(nullCheck(coupon_amt))	 
							+ eval(nullCheck(mcoupon_amt))    
							+ eval(nullCheck(card_amt))
							- eval(nullCheck(cashrec_n_coupon)) ;	//2019.03.11 ljs : 증정상품권 현금영수증제외 금액 추가 
			}else {
				cash_amt = eval(nullCheck(cash_amt)) 
							+ eval(nullCheck(coupon_amt))	 
							+ eval(nullCheck(mcoupon_amt))  
							- eval(nullCheck(cashrec_n_coupon)) ;//2019.03.11 ljs : 증정상품권 현금영수증제외 금액 추가  
			}							

			//alert("[현금영수증]cash_amt[" + cash_amt +"]");
			if(eval(cash_amt) > 0)
			{
			//2019.04.26  ljs 현금승인금액체크 0원인 경우 처리 END						

				//현금금액이 5000원이상이면
				//현금금액이 0원 이상 이면
				if(Number($("#cash_amt").val()) >0) {		// 현금
					//if(confirmMsg("5000원 이상의 현금지불은 현금영수증을 발급받아야 합니다.\n현금영수증 페이지로 이동하시겠습니까?")) {
					
					openCashLayer();
					return;
					//} else {
					//	return;
					//}
				} else if(Number($("#cash_amt").val()) >= 5000) {		// 지류상품권
				//if(confirmMsg("5000원 이상의 현금지불은 현금영수증을 발급받아야 합니다.\n현금영수증 페이지로 이동하시겠습니까?")) {
					openCashLayer();
					return;
				//} else {
				//	return;
				//}
				} else if(Number($("#mcoupon_amt").val()) > 0) {		// 모바일상품권			2017.08.24
					openCashLayer();
					return;
				}
			}
		} 
	}
  //AK기프트(555),홈플러스(666)카드 현금영수증 발급 추가(2012.01.12) ★★★★★★★★★★★★★★★------------
	//홈플러스(666)카드 제거(2017.08.30) ★★★★★★★★★★★★★★★------------
	var ls_card_fg = ic_card_co_origin_seq;
	if( (isNull(cash_approve_no)) 
		&& (ls_card_fg=="555")
		&& (trim(ic_card_approve_no) != null || trim(ic_card_approve_no) != "") 
		&& (card_amt > 0 ) 
		&& (eval(cash_amt) > 0)  //현금승인금액체크 0원인 케이스 제외  (2019.04.26 ljs)
		) {
			alert("[AK기프트카드]는 현금영수증 가능합니다.!!");
			openCashLayer();
			return;
	}			   
     // -------------------------------------------------------------------------------	        
	 
	if(cash_approve_no.substring(0, 4) == "Fail") {
		alert("현금영수증 승인에 실패하여 매상등록 할 수 없습니다.");
		return;
	}
	
	//카드금액 확인
	if(card_amt != $("#card_amt").val()) {
		alert("카드금액이 맞지 않습니다.! 다시 확인해주세요!!");
		return;
	}
					
	
	/*
	//에누리 사유 입력 확인
	if(model.getValue("/root/req/enuri_fg") != "0"){
		if(model.getValue("/root/req/enuri_desc") == ""){
			alert("에누리 사유코드를 입력해 주세요");
			return;
		}
	}
	*/
    //2019.05.09 ljs 마일리지 사용 적용시 영수증번호 조회함
	var recptNo = recpt_no;
	if(recptNo == null || recptNo == "")
	{
		$.ajax({
			type : "POST", 
			url : "/member/lect/getRecpt",
			dataType : "text",
			async:false,
			cache : false,
			data : 
			{
				store : $("#selBranch").val(),
				pos_no : pos_no
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				recpt_no = data;
			}
		});
		recptNo = recpt_no;
	}
	var regisAmt = total_regis_fee;
	var foodAmt = total_food_amt;
	
	rep_subject_cd = subject_arr.split("|")[0];
	rep_recpt_no = recptNo;
	
	var enuri = encd_pay1 + encd_pay2;
	
	saleInit(); //초기값을 셋팅한다.
	
	if( akmem_sApprovNo == "00" ){
		// 적용 ROULE 은 백화점 POS/PDA와 동일함
		// 현금 100% 인정, 타사 50% 인정, AK신한카드 70% 인정, 상품권 0% 인정, 002삼성제휴 0% 인정
		AKpoint_Calc_refresh();
	}
	var qr_card_chk = ic_card_no;
	if(bc_qr_value != null && bc_qr_value != "") {
		// 매상등록 프로세스  bcqr 은 복호화 할 게 없음.		cmc - 20190510
		
		if( bc_qr_value.substr(3, 1) == "L" ) {
			ic_card_data_fg = "Q";
		}
		else if(bc_qr_value.substr(3, 1) == "C") {
			ic_card_data_fg = "q";
		}
		else {
		
		}
		
		//<-- 20200220 kjp 우리제휴 추가 start
		//model.setValue("/root/data/card_data/card_co_origin_seq", "031"); 	//카드사고유일련번호 - 은련카드 일 때도 031 로 변경 한다.
		if(ic_card_co_origin_seq != "034"){
			ic_card_co_origin_seq = "031"; 	//카드사고유일련번호 - 은련카드 일 때도 031 로 변경 한다.
		}
		//<-- 20200220 kjp 우리제휴 추가 end
	}
	else {
		//매상등록 사용 카드번호 복호화 전문생성
		encCardNoSendStr("card");
	}
	
	//매상등록 Process
	child_no1_arr = "";
	child_no2_arr = "";
	child_no3_arr = "";
	encd_no1_arr = "";
	encd_no2_arr = "";
	encd_amt1_arr = "";
	encd_amt2_arr = "";
	part_regis_fee_arr = "";
	part_food_amt_arr = "";
	
	for(var z = 0; z < subject_arr.split("|").length-1; z++)
	{
		child_no1_arr += child1_no.get(subject_arr.split("|")[z])+"|";
		child_no2_arr += child2_no.get(subject_arr.split("|")[z])+"|";
		child_no3_arr += child3_no.get(subject_arr.split("|")[z])+"|";
		encd_no1_arr += encd1_no.get(subject_arr.split("|")[z])+"|";
		encd_no2_arr += encd2_no.get(subject_arr.split("|")[z])+"|";
		encd_amt1_arr += encd1_amt.get(subject_arr.split("|")[z])+"|";
		encd_amt2_arr += encd2_amt.get(subject_arr.split("|")[z])+"|";
		part_regis_fee_arr += part_regis_fee.get(subject_arr.split("|")[z])+"|";
		part_food_amt_arr += part_food_amt.get(subject_arr.split("|")[z])+"|";
	}
	$.ajax({
		type : "POST", 
		url : "/member/lect/sale_proc",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cust_no : $("#cust_no").val(),
			pos_no : pos_no,
			recpt_no : recpt_no,
			cash_amt : cash_amt,
			card_amt : card_amt,
			mcoupon_amt : mcoupon_amt,
			regis_amt : total_regis_fee,
			food_amt : total_food_amt,
			total_show_amt : total_pay,
			total_amt : final_pay,
			akmem_point_amt : point_amt,
			coupon_amt : coupon_amt,
			md : md,
			op : op,
			goods : goods,
			subject_arr : subject_arr,
			part_subject_arr : part_subject_arr,
			child_no1_arr : child_no1_arr,
			child_no2_arr : child_no2_arr,
			child_no3_arr : child_no3_arr,
			encd_no1_arr : encd_no1_arr,
			encd_no2_arr : encd_no2_arr,
			encd_amt1_arr : encd_amt1_arr,
			encd_amt2_arr : encd_amt2_arr,
			part_regis_fee_arr : part_regis_fee_arr,
			part_food_amt_arr : part_food_amt_arr,
			card_data_fg : ic_card_data_fg,
			
			encCardNo_send_str : ic_card_encCardNo_send_str,
			card_co_origin_seq : ic_card_co_origin_seq,
			card_approve_no : ic_card_approve_no,
			month : ic_card_month,
			rate : ic_card_rate,
			sign_data : signT,
			
			barcode_no : barcode_no,
			mcoupon_approve_no : mcoupon_approve_no,
			mcoupon_approve_amt : mcoupon_approve_amt,
			
			cash_approve_no : cash_approve_no,
			cash_approve_amt : cash_approve_amt,
			cash_issue_fg : cash_issue_fg,
			cash_id_fg : cash_id_fg,
			cash_id_no : cash_id_no,
			cash_rate : cash_rate,
			
			
			coupon_fg_arr : coupon_fg_arr,
			coupon_cd_arr : coupon_cd_arr,
			coupon_no_arr : coupon_no_arr,
			face_amt_arr : face_amt_arr,
			cashrec_yn_arr : cashrec_yn_arr,
			vat_cal_ext_rate_arr : vat_cal_ext_rate_arr,
			vat_cal_rate_arr : vat_cal_rate_arr,
			cp_change_amt_arr : cp_change_amt_arr,
			cp_chage_apy_y_amt_arr : cp_chage_apy_y_amt_arr,
			cp_chage_apy_n_amt_arr : cp_chage_apy_n_amt_arr,
			cashrec_amt_arr : cashrec_amt_arr,
			cashrec_n_amt_arr : cashrec_n_amt_arr,
			
			change : $("#change").val() //거스름돈
			
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			alert("등록이 완료되었습니다.");
			if($("#point_amt").val() != null && $("#point_amt").val() != "")
			{
				if(Number($("#point_amt").val()) > 0)
				{
					akmem_use();
				}
			}
			if(akmem_sApprovNo == "00"){
				//적립요청 마일리지가 0원 이상일때만 실행
				if(akmem_recpt_point > 0){
					AKmem_pointSave(); //AKmembers Point Save 포인트 적립
				}
			}
			pos_status = "Y";
			
			if(ic_card_month == '00')
			{
				if(c_print_stat == "ON")
				{
					if(confirm("고객영수증을 출력하시겠습니까?"))
					{
						if(posInit()) {
							posPrint();
							if(printer.DeviceEnabled ) {
								printer.ReleaseDevice();
								printer.close();
							}
							alert("영수증 인쇄가 완료되었습니다.");		
						}
					}
				}
				if(a_print_stat == "ON")
				{
					if(confirm("가맹영수증을 출력하시겠습니까?"))
					{
						if(posInit()) {
							posPrint();
							if(printer.DeviceEnabled ) {
								printer.ReleaseDevice();
								printer.close();
							}
							alert("영수증 인쇄가 완료되었습니다.");		
						}
					}
				}
			}
			else
			{
				if(posInit()) {
					posPrint(); //고객용
					posPrint(); //가맹용
					if(printer.DeviceEnabled ) {
						printer.ReleaseDevice();
						printer.close();
					}
					alert("영수증 인쇄가 완료되었습니다.");		
				}
			}
			cardX.ResetMem(); // 영수증 출력 완료시 단말기 메모리 초기화 18.02.12 최보성
			dataReset(); //변수 초기화
			location.reload();
		}
	});
	
}
function AKmem_pointSave() {
	var ls_store	=	$("#selBranch").val()
	var ls_akmem_card_no     	=	akmem_card_no;
	var tranGubun = akmem_card_rfFlag;
//	var akmem_card_fg = akmem_card_fg;
	
	// 유효성체크
	if(ls_akmem_card_no == null || trim(ls_akmem_card_no) == "" ) {
		return;
	}					
	
	//var send_data = AKmem_Run('XA242S','SAVE');
	var send_data = ""; // 카드멤버쉽 전문 생성 여전법이후 , MS = XA241S, IC = XB241S 전문 IC사용

	if(trim(tranGubun) == "M" || akmem_card_fg == "@"){
		send_data = AKmem_Run('XB242S','SAVE');
	}else{
		send_data = AKmem_Run('XB242S','SAVE');
		encCardNoSendStr("akmem");//멤버쉽 카드 복호화
	}	
	/*
	// cminc1115 - 여전법 으로 멤버쉽 막고 이부분으로 대체 
	send_data = AKmem_Run('XB242S','SAVE');
	model.setValue("/root/req/akmem_cardno",  akmem_cardno.value);
	*/
	
	ls_akmem_send_str = send_data;

	//포인트 적립요청 Transaction
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetAkmemCustInfo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			hq : '00',
			store : $("#selBranch").val(),
			send_data : send_data,
			akmem_encCardNo_send_str : akmem_card_encCardNo_send_str,
			
			pos_no : pos_no,
			recpt_no : recpt_no,
			total_enuri_amt : encd_pay1 + encd_pay2,
			total_pay : total_pay,
			total_regis_fee : final_pay,
			akmem_card_no : akmem_card_no,
			
			total_show_amt : total_pay,
			akmem_point_amt : point_amt,
			
			akmem_cust_no : akmem_cust_no,
			akmem_family_cust_no : akmem_family_cust_no,
			akmem_recpt_point : akmem_recpt_point
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			if(result.sApprovNo != '00')
			{
				alert("[포인트적립 오류!]"+result.sMessage);
				alert("[포인트적립 오류!] 포인트 번호 메모 후 전산실로 연락 바랍니다. ");
			}
			else
			{
				akmem_recpt_point = result.AKmem_recpt_point;
				akmem_save_approve_no = result.AKmem_SaveApproveNo;
				akmem_save_approve_no_pos = result.AKmem_SaveApproveNo_POS;
				akmem_save_approve_no_point = result.AKmem_SaveApprove_Point;
			}
		}
	});
	
}//AKmem_pointSave()
function AKpoint_Calc_refresh() {
	var pPointAmt = AKpoint_Calc();
	akmem_recpt_point = pPointAmt;
}
function AKpoint_Calc(){
	var pCach 		= 0;
	var pCard 		= 0;
	var pCardFg 	= 0;
	var pCoupon 	= 0;
	var pMCoupon 	= 0;
	var pPointAmt 	= 0;
	
	pCach 			= cash_amt;
	pCard 			= card_amt;
	pCardFg 		= ic_card_co_origin_seq;
	pCoupon 		= Number(coupon_amt);  /*거스름돈 존재시 상품권 적립보완 2011.03.07 */
	pMCoupon 		= Number(mcoupon_amt);  /*모바일상품권 결제추가 2017.07.28 */
	
	pPointAmt ; //포인트 적용 인정금액
	
	var pAkCoupon =  0; 		
	
	// 결제수단별 적립율 조회(09.12.03)  START --------------------------	
	
	var face_amt_split = face_amt_arr.split("|");
	var coupon_cnt = face_amt_split.length -1;
	for(var i = 0; i < coupon_cnt; i++)
	{
		pAkCoupon += Number(face_amt_split[i]);
	}

	pay_akcoupon = pAkCoupon;
	
	var mCash	    = 0;
	var mAKsinCard 	= 0;
	var mAKsamCard 	= 0;
	var mCard 		= 0;
	var mCoupon 	= 0;
	//2020.02.04 kjp AK우리카드 추가
	var mMobileCoupon = 0;
	var mAKKBCard = 0;
	var mAKWBCard = 0;
	
	mCash	    	= Number(point_cash);
	mAKsinCard   	= Number(point_aksincard);
	mAKsamCard 		= Number(point_aksamcard);
	mCard           = Number(point_card);
	mCoupon 		= Number(point_coupon);
	mMobileCoupon 	= Number(point_mcoupon);		// 모바일상품권
	mAKKBCard 		= Number(point_akkbcard);
	mAKWBCard 		= Number(point_akwbcard);		//2020.02.04 kjp AK우리카드 추가

	//2020.02.04 kjp AK우리카드 추가
	if(pCardFg == '822'){	//신한
		pPointAmt = Number((pCach * mCash) + (pCard * mAKsinCard) +(pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
	}else if(pCardFg == '042'){	//국민
		pPointAmt = Number((pCach * mCash) + (pCard * mAKKBCard)+ (pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
	}else if(pCardFg == '034'){	//우리
		pPointAmt = Number((pCach * mCash) + (pCard * mAKWBCard)+ (pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
	}else if(pCardFg == '002'){
		pPointAmt = Number((pCach * mCash) + (pCard * mAKsamCard)+ (pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
	}else{
		pPointAmt = Number((pCach * mCash) + (pCard * mCard) + (pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
	}
	
	/*
	if(pay_fg.value == 'cash') {
		
		//  pPointAmt =  Number((pCach * mCash) + (pAkCoupon * mCoupon) ) ;								//50% 현금, 자사 상품권 10%
		
		
		// 거스름돈 있는 경우(상품권 결제) 보완 2011.03.07
		if ((pChange > 0) && (pCoupon > 0)) {
		   pPointAmt = (pCoupon - pChange) * mCoupon;
		}else{
		   pPointAmt = Number((pCach * mCash) + (pAkCoupon * mCoupon) );
		}	
	}else if(pay_fg.value == 'mcoupon'){	//모바일 복합 결제
		if(pCardFg == '822' || pCardFg == '042'){ //신한,국민 동일 인정율이라 한군데서관리 분리 필요시 수정
			pPointAmt = Number((pCach * mCash) + (pCard * mAKsinCard) +(pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
		}else if(pCardFg == '002'){
			pPointAmt = Number((pCach * mCash) + (pCard * mAKsamCard)+ (pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
		}else{
			pPointAmt = Number((pCach * mCash) + (pCard * mCard) + (pAkCoupon * mCoupon) + (pMCoupon * mMobileCoupon));
		}
	}else{	//카드 및 카드 복합결재
		if(pCardFg == '822' || pCardFg == '042'){ //신한,국민  동일 인정율이라 한군데서관리 분리 필요시 수정
			pPointAmt = Number((pCach * mCash) + (pCard * mAKsinCard) +(pAkCoupon * mCoupon));		       //70% 인정
		}else if(pCardFg == '002'){
			pPointAmt = Number((pCach * mCash) + (pCard * mAKsamCard)+ (pAkCoupon * mCoupon)) ; 		//10% 인정
		}else{
			pPointAmt = Number((pCach * mCash) + (pCard * mCard) + (pAkCoupon * mCoupon)) ; 			//10% 인정
		}
	}
	*/
	/*
	if(pay_fg.value == 'cash'){
		//현금결재 100%
		pPointAmt = pCach ;
	}else{
		//카드 및 카드 복합결재
		//AK신한 카드 확인 70%
		if(pCardFg == '822'){
			pPointAmt = pCach + (pCard * 0.7) ;	//70% 인정
		}else if(pCardFg == '002'){
			pPointAmt = pCach + (pCard * 0) ; 	//0% 인정
		}else{
			pPointAmt = pCach + (pCard * 0.5) ; //50% 인정
		}
	}
	*/
	pPointAmt = Math.ceil(pPointAmt * 0.01); //해당 인정 금액의 1% 가 적립액 (올림)
	//alert(pPointAmt);
	return pPointAmt;
}		





































































































































function zero(length)
{
    var zeroString = "";
    for(var i = 0; i < length; i++) {
        zeroString = zeroString + "0";
    }
    return zeroString;
}
function getTimeStamp() {
	var d = new Date();
	return f_setfill_zero(d.getFullYear().toString(), 4, "L")+f_setfill_zero(eval(d.getMonth()+1).toString(), 2, "L")+f_setfill_zero(d.getDate().toString(), 2, "L")
			+f_setfill_zero(d.getHours().toString(), 2, "L")+f_setfill_zero(d.getMinutes().toString(), 2, "L")+f_setfill_zero(d.getSeconds().toString(), 2, "L");
}
function f_setfill_zero(temp_str, str_length, str_flag)
{
    var temp_len = 0;
    temp_len = trim(temp_str).length;
    if(trim(temp_str) == null)   return zero(str_length);
    if(temp_len >= str_length)   return temp_str.substring(0, str_length);
    if(str_flag == "R")          return trim(temp_str) + zero(str_length - temp_len);
    else if(str_flag == "L")         return zero(str_length - temp_len) + trim(temp_str);
    else {
    	alert("[" + temp_str + "] 오른쪽(R),왼쪽(L)을 지정하십시오");
        return temp_str
    }
}
function f_setfill(temp_str, str_length, str_flag)
{
    var temp_len = 0;
    temp_len = trim(temp_str).length;
    if(trim(temp_str) == null)   return space(str_length);
    if(temp_len >= str_length)   return temp_str.substring(0, str_length);
    if(str_flag == "R")          return trim(temp_str) + space(str_length - temp_len);
    else if(str_flag == "L")         return space(str_length - temp_len) + trim(temp_str);
    else {
        alert("[" + temp_str + "] 오른쪽(R),왼쪽(L)을 지정하십시오");
        return temp_str
    }
}
function space(length)
{
    var spaceString = "";
    for(var i = 0; i < length; i++) {
        spaceString = spaceString + " ";
    }
    return spaceString;
}
function cardDanMemReset(){
    cardX.RcvData = 1 ;
    cardX.RcvData = 0 ;
   
    cardX.Emv = 1 ;
    cardX.Emv = 0 ;
    
    cardX.ResetMem(); 
    cardX.ReqReset();
}
//str값이 null인 경우 숫자로 만들어줌.
function nullCheck(str) {
	if(str == "" || str == null) {
		return 0;
	} else {
		return eval(str);
	}
}
function posInit() {
	if(printer.DeviceEnabled ) {
		printer.ReleaseDevice();
		printer.close();
	} 
	
	if (printer.Open("IPOS_PRINTER") != 0) {
		alert('프린터가 연결되어 있지 않습니다!!!-1');
		printer.Release();
		printer.close();
		return;
	} else {
		if (printer.ClaimDevice("1000") != 0 ) {
			alert("프린터가 연결되어 있지 않습니다!!!-2");
			printer.Release();
			printer.close();
			return;
		} else {
			return true;
		}
	}
}//posInit()
function cardXCheck()
{
	OCXcheck(); //ActiveX 체크
	if(setCardReaderOpen()){		// 단말기 PORT 체크
		danMaldataParse(cardX.RcvData);
		CardReaderIntegrity();		// 무결성 체크
		Insert_Integrity();			// DB저장
	} else {
		alert("단말기 전원상태를 확인하여 주십시오.\nIC단말기 무결성 체크가 되지 않았습니다.");
	}
	
	var conTest = cardX.ReqReset();
	if(conTest <0){
		alert("단말기가 정상적으로 연결되지 않았습니다.");
		return;  //2019.03.11 "" --> false 변경
	}
}

function setCardReaderOpen(){
    
//    var sPort = 3;      // PORT정보 가져오기
    var ref;
    
//    ref = cardX.Open(sPort,115200,'');
//    if (ref < 0) {
//        alert("연결된 IC단말기 Port번호를 확인하여 주십시오.");
//    }
    
    ref = cardX.ReqCmd( 0xFB, 0x11, 0x02, "", "");
    ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 0, "처리중입니다.","");
    if(ref >= 0) {
        return true;
    }
}
function readerClose() {
    var ref;
    ref = cardX.ReqReset(); 
    ref = cardX.Close();
} 
function OCXcheck() {
    var installed;
    var msg;
    var ocxNm = "KiccPosIE.KiccPosIEX"      //ProgID
    
    try {
        var axObj = new ActiveXObject(ocxNm);
        

        if(axObj){
            installed = true;

        } else {
            installed = false;
        }
    } catch (e) {
        installed = false;
    }
    
    if(!installed) {
        alert("ActiveX가 정상적으로 설치되지 않았습니다.\nIS팀에 문의하여 주시기 바랍니다.");
    }
}
function danMaldataParse(rcvData) {
	
	var danmal_data = rcvData;
	
//	reader_modelCd = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_ver = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_serialNo = danmal_data.substring(0,12); danmal_data = danmal_data.substring(12);
//	reader_protoVer = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
//	reader_useMsrTr = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
//	reader_maxVan = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
//	reader_vanCnt = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
//	
//	reader_vanCode = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_vanNm = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
//	reader_reciKeyVer = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_encMeth = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
//	reader_vanCode1 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_vanNm1 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
//	reader_reciKeyVer1 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_encMeth1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
//	reader_vanCode2 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_vanNm2 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
//	reader_reciKeyVer2 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_encMeth2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
//	reader_vanCode3 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_vanNm3 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
//	reader_reciKeyVer3 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_encMeth3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
//	reader_vanCode4 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_vanNm4 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
//	reader_reciKeyVer4 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
//	reader_encMeth4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
	reader_secuVer1 = danmal_data.substring(125,141);  
//	danmal_data = danmal_data.substring(16);
	
	reader_secuVer = "AKWEBPOS3001"; // cmc - 식별번호update
}

//인증심사 T-025 : 카드리더기 무결성 점검 수행 여부 확인 (무결성 점검 주기)
function CardReaderIntegrity() {
    var ref;
    cardX.SendHandle();
    ref = cardX.ReqCmd( 0xFB, 0x11, 0x30, "", "");
    ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 10000, 1, "무결성 침해 검증 진행중 입니다.", "");
    
    sRet = cardX.RcvData;
    
    var resVl =  sRet.substring(0,2);
    
    var encCnt = reader_vanCnt;// 단말기 암호화키 갯수

    if(resVl ==  null || trim(resVl) == "" || resVl == undefined  ){
      resVl = "ERROR";
    }
   
    reader_integrity = resVl;
    
    readerClose();
    if(resVl == "ERROR")
	{
    	$("html").html('');
    	alert("무결성검증에 실패하였습니다.");
    	return;
	}
}
function Insert_Integrity() {
	$.ajax({
		type : "POST", 
		url : "/member/lect/insert_integrity",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			integrity : reader_integrity,
			secuVer : reader_secuVer,
			secuVer1 : reader_secuVer1
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
		}
	});
}
function encCardNoSendStr(encFlag){//
	var product = "XB245S" + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
	//암호화카드번호 KSN[20]+BASE64[64] track2 데이터
	var encCardNo = "";
	var encpath = "";	
	if(encFlag == "card"){
		encCardNo = ic_card_ksn1 + ic_card_encData1;
		product =  product + encCardNo +fill("",50);
		ic_card_encCardNo_send_str = f_setfill(product,1024,'R');
	}else if(encFlag == "akmem"){
		encCardNo = akmem_card_ksn1 + akmem_card_encData1;
		product =  product + encCardNo +fill("",50);
		akmem_card_encCardNo_send_str = f_setfill(product,1024,'R');
	}	
}//encCardNoSendStr
function f_card_gubun_nm(gubun, card_no) {
	var li_row = 0;
	$.ajax({
		type : "POST", 
		url : "/member/lect/getCardCount",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			encCardNo_send_str : ic_card_encCardNo_send_str,
			store : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			li_row = data;
		}
	});
    //1. 인자값으로 받은 카드번호를 통해 국민제휴카드인지 조회한다. 삼성 -> 국민으로 변경 20170908
    if(li_row > 0) {
        if     (gubun == "flag")        return "8";
        else if(gubun == "name")        return "AK KB국민카드";
        else if(gubun == "origin_seq")  return "042";
        else if(gubun == "all")         return "8042AK KB국민카드";
        else if(gubun == "new")         return "8042NAK KB국민카드";   // 10.06.10 추가 (전자서명 무서명 관련)
        else if(gubun == "state")       return "";                  // 12.11.20 발행사표기추가(제휴카드는 생략)
    } else {
        var ls_card_no = null;
        ls_card_no = card_no.substring(0, 6);

        for(li_row = 6; li_row > 0; li_row--) {
            switch(li_row) {
                case 5 :
                    ls_card_no = ls_card_no.substring(0, li_row) + "X";
                    break;
                case 4 :
                    ls_card_no = ls_card_no.substring(0, li_row) + "XX";
                    break;                              
                case 3 :
                    ls_card_no = ls_card_no.substring(0, li_row) + "XXX";
                    break;                              
                case 2 :
                    ls_card_no = ls_card_no.substring(0, li_row) + "XXXX";
                    break;                              
                case 1 :
                    ls_card_no = ls_card_no.substring(0, li_row) + "XXXXX";
                    break;  
                default :                           
                break;
            }
            
            $.ajax({
        		type : "POST", 
        		url : "/member/lect/getCardNo",
        		dataType : "text",
        		async:false,
        		cache : false,
        		data : 
        		{
        			card_no : ls_card_no
        		},
        		error : function() 
        		{
        			console.log("AJAX ERROR");
        		},
        		success : function(data) 
        		{
        			var result = JSON.parse(data);
        			ic_card_flag = result.CARD_FLAG;
        			ic_card_nm = result.CARD_NM;
        			ic_card_co_origin_seq = result.CARD_CO_ORIGIN_SEQ;
        			ic_card_sain_fg = result.SAIN_FG;
        			ic_card_pri_nm = result.CARD_PRI_NM;
        		}
        	});
            
            
            
            //ls_card_no를 통해 실제 카드정보를 조회한다.
            
            //823 신한카드 중 822 신한제휴 구분 체크
            if(ic_card_co_origin_seq == "823"){
            
                //신한제휴 고객 DB를 통해 신한제휴카드 구분함.
            	var li_row822 = 0;
            	$.ajax({
            		type : "POST", 
            		url : "/member/lect/getCardCount822",
            		dataType : "text",
            		async:false,
            		cache : false,
            		data : 
            		{
            			encCardNo_send_str : ic_card_encCardNo_send_str,
            			store : $("#selBranch").val()
            		},
            		error : function() 
            		{
            			console.log("AJAX ERROR");
            		},
            		success : function(data) 
            		{
            			li_row822 = data;
            		}
            	});
                
                if(li_row822 > 0) {                                
                    if     (gubun == "flag")        return "4"; // card_flag 2:타사 3:삼성제휴 4:신한제휴  5:AK기프트
                    else if(gubun == "name")        return "AK 신한카드";
                    else if(gubun == "origin_seq")  return "822"; //신한제휴 코드;
                    else if(gubun == "all")         return "4822AK 신한카드카드";      
                    else if(gubun == "new")         return "4822NAK 신한카드카드";   // 10.06.10 추가 (전자서명 무서명 관련)  
                    else if(gubun == "state")       return "";                  // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)          
                }else{
                    if     (gubun == "flag")        return "2";
                    else if(gubun == "name")        return ic_card_nm;
                    else if(gubun == "origin_seq")  return ic_card_co_origin_seq;
                    else if(gubun == "all")         return "2" + ic_card_co_origin_seq + ic_card_nm;                                        
                    else if(gubun == "new")         return "2" + ic_card_co_origin_seq + ic_card_sain_fg +ic_card_nm; // 10.06.10 추가 (전자서명 무서명 관련)                     
                    else if(gubun == "state")       return ic_card_pri_nm;                                      // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
                }
            // AK기프트카드 추가  START ------------------------                                    
            }else if (ic_card_co_origin_seq == "555"){     //AK기프트카드 
                    if     (gubun == "flag")        return "5"; // card_flag 2:타사 3:삼성제휴 4:신한제휴 5:AK기프트 6:홈플러스선불
                    else if(gubun == "name")        return "AK기프트카드";
                    else if(gubun == "origin_seq")  return "555"; //AK기프트 코드;
                    else if(gubun == "all")         return "5555AK기프트카드";      
                    else if(gubun == "new")         return "5555NAK기프트카드";   
                    else if(gubun == "state")       return "";                  // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
            // AK기프트카드 추가 END ------------------------ 
            // 홈플러스선불카드 추가  START ------------------------    
            }else if (ic_card_co_origin_seq == "666"){     //홈플러스선불카드 
                    if     (gubun == "flag")        return "6"; // card_flag 2:타사 3:삼성제휴 4:신한제휴 5:AK기프트 6:홈플러스선
                    else if(gubun == "name")        return "홈플러스선불카드";
                    else if(gubun == "origin_seq")  return "555"; //AK기프트 코드;
                    else if(gubun == "all")         return "6666홈플러스선불카드";      
                    else if(gubun == "new")         return "6666N홈플러스선불카드";  
                    else if(gubun == "state")       return "";                  // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
             }       
            // 홈플러스선불카드 추가  END ------------------------   
            
            if(ic_card_flag != "" || ic_card_flag.length > 0) {
                if     (gubun == "flag")        return "2";
                else if(gubun == "name")        return ic_card_nm;
                else if(gubun == "origin_seq")  return ic_card_co_origin_seq;
                else if(gubun == "all")         return "2" + ic_card_co_origin_seq + ic_card_nm;
                else if(gubun == "new")         return "2" + ic_card_co_origin_seq + ic_card_sain_fg +ic_card_nm; // 10.06.10 추가 (전자서명 무서명 관련) 
                else if(gubun == "state")       return ic_card_pri_nm;                                      // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
            }
        } //for문 끝
        if(ic_card_flag == "" || ic_card_flag.length == 0) {
            if     (gubun == "flag") return "2";
            else if(gubun == "name") return "KT패스카드";
            else if(gubun == "origin_seq") return "888";
            else if(gubun == "all") return "2888KT패스카드";
            else if(gubun == "new") return "2888NKT패스카드";  // 10.06.10 추가 (전자서명 무서명 관련) 
            else if(gubun == "state")       return "";        // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
        }    
            
           
    } //if-else문 끝
}
function daydiff(day){
	var fday = new Date(day.substring(0,4),eval(day.substring(4,6)-1),day.substring(6,8))
	var tday = new Date();
	return Math.floor((tday - fday)/(24 * 3600 * 1000))
}	
function isNull(val) {
    for(var i=0; i< val.length; i++) {
        if(trim(val[i]) != "") {
            //하나라도 값이 있다면 false
            return false;
        }
    }
    return true;
}
function fill(addString, length) // 0 5
{
    var charString = "";
    for(var i = 0; i < length; i++) {
        charString = charString + addString;
    }
    return charString;
}
function posPrint() {
	var ls_recpt_no, ls_card_no, ls_coupon_no, ls_barcode, ls_subject_nm, ls_mc_card_no;
	var ls_sale_date, ls_pos_no, ls_intypem, ls_card_fg;
	var ls_data, ls_trade_all_amt, ls_enuri_amt, ls_net_sale_amt;
	var ls_escape,ls_font;
	var ls_normal, ls_doublewide, ls_doublehigh, ls_doublehighwide;
	var i = 0;
	var ls_card_amt, ls_cash_amt, ls_rest_amt, ls_mc_card_amt;
	
	var ls_issue_fg, ls_id_no, ls_aprv_no, ls_approve_no, ls_mc_approve_no;
	var ls_sign , ls_e_sign
	var ls_memcard_no
	var ls_v_enuri_amt
	 //2019.03.11 ljs : 사용마일리지(ls_point_amt), 상품권총금액(ls_coupon_amt), 현금영수증제외금액(ls_cashrec_n_coupon) 추가
	var ls_point_amt, ls_coupon_amt, ls_cashrec_n_coupon;
	var ls_bc_qr_value;	//cmc qr 코드 거래시 영수증에 qr 이라 찍어 주기 위해 추가
	
	ls_escape 				= String.fromCharCode(27);
	ls_font					= '|bC';
	ls_normal 				= '|1C';
	ls_doublewide	 		= '|2C';
	ls_doublehigh 			= '|3C';
	ls_doublehighwide		= '|4C';

	ls_sale_date			= getNow();
	ls_pos_no    			= pos_no;
	ls_recpt_no				= recpt_no;
	ls_card_amt	 		= card_amt;
	ls_issue_fg  			= cash_issue_fg;
	ls_id_no     				= cash_id_no;
	ls_id_fg					= cash_id_fg;
	ls_approve_no  		= ic_card_approve_no;
	ls_mc_approve_no  	= mcoupon_approve_no;
	ls_mc_card_amt  		= mcoupon_approve_amt;
	ls_mc_card_no  		= barcode_no;
	ls_mc_remain_amt  	= mcoupon_rmn_amt;
	ls_aprv_no				= cash_approve_no;
	ls_cash_amt 			= cash_amt;
	ls_card_no				= ic_card_no;
	sale_ymd				= ls_sale_date.substring(0, 4) + "년" + ls_sale_date.substring(4, 6) + "월" +  ls_sale_date.substring(6, 8) + "일";
	conversion_recpt_no	= "NO." + ls_pos_no + "-" + ls_recpt_no;
	sale_time				= getTime().substring(0,2) + "시" + getTime().substring(2,4) + "분"  + getTime().substring(4,6) + "초";
	
	ls_card_fg				= ic_card_co_origin_seq; 	//AK기프트 잔액 추가(12.01.11)
	ls_rest_amt				= ic_card_rest_amt; 			//AK기프트 잔액 추가(12.01.11)
	
	ls_bc_qr_value				= bc_qr_value;		//bcqr 영수증 - cmc
	//2019.03.11 ljs 사용마일리지, 상품권관련 추가 START
	ls_point_amt            = point_amt;        //사용마일리지 추가
	if(ls_point_amt != null && trim(ls_point_amt) !=  "" )
	{
		ls_point_amt = 0;
	}
	ls_coupon_amt          = coupon_amt;            //총상품권금액 추가
	ls_cashrec_n_coupon    = cashrec_n_coupon;  //자사 현금영수증제외금액 추가
	//2019.03.11 ljs 사용마일리지, 상품권관련 추가 END

	//분당점이면 바코드 91로 시작
	if($("#selBranch").val() == "03") {
		ls_barcode			= "91" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	} else if($("#selBranch").val() == "01") {
		ls_barcode			= "92" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	} else if($("#selBranch").val() == "02") {
		ls_barcode			= "93" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}else if($("#selBranch").val() == "04") {
		ls_barcode			= "94" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}else if($("#selBranch").val() == "05") {
		ls_barcode			= "95" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}
	//==================================================================
	// 10.06.10 무서명 기준 체크 추가
	var ls_card_sain_fg	= ic_card_sain_fg;
	var sale_date = setWeekDay(ls_sale_date);
	
	var subject_split = subject_arr.split("|");
	var subject_nm_split = subject_nm_arr.split("|");
	var regis_fee_split = regis_fee_arr.split("|");
	var food_amt_split = food_amt_arr.split("|");
	
	if($("#selBranch").val() == "03") {
		//분당점
		ls_data  = ls_escape + ls_font
		ls_data += "AK S&D(주) AK 분당점\n"
		ls_data += "129-85-42346  김 재 천\n"
		ls_data += "경기도 성남시 분당구 황새울로 360번길 42\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	} else if($("#selBranch").val() == "01") {
		//구로점
		ls_data  = ls_escape + ls_font
		ls_data += "에이케이아이에스(주) 구로본점\n"
		ls_data += "113-81-07313  백차현, 김재영\n"
		ls_data += "서울특별시 구로구 구로중앙로 152\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	} else if($("#selBranch").val() == "02") {
		//수원점
		ls_data  = ls_escape + ls_font
		ls_data += "수원애경역사(주) 수원점\n"
		ls_data += "124-81-28579  김 재 천\n"
		ls_data += "경기도 수원시 팔달구 덕영대로 924\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	} else if($("#selBranch").val() == "04") {
		//평택점
		ls_data  = ls_escape + ls_font
		ls_data += "평택역사(주) 평택점\n"
		ls_data += "125-81-24085  김 재 천\n"
		ls_data += "경기도 평택시 평택로 51\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	} else if($("#selBranch").val() == "05") {
		//원주점
		ls_data  = ls_escape + ls_font
		ls_data += "에이케이에스앤디(주) AK원주점\n"
		ls_data += "224-85-23362 김 재 천\n"
		ls_data += "강원도 원주시 봉화로 1\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	}

	ls_data += '----------------------------------------\r\n'
	ls_data += ' 강좌명    수강료     재료비     합  계 \r\n'
	ls_data += '----------------------------------------\r\n'
		
	for(i = 0; i < subject_split.length-1; i++)
	{
		var regis_fee_i = regis_fee_split[i];
		var food_fee_i	= food_amt_split[i];
		var sub_tot_fee	= eval(regis_fee_i) + eval(food_fee_i);
		
		ls_data += subject_split[i] +' '+subject_nm_split[i]
		ls_data += '\r\n'
		ls_data += f_setfill(comma(regis_fee_i),17,'L')
		ls_data += f_setfill(comma(food_fee_i),11,'L')
		ls_data += f_setfill(comma(sub_tot_fee.toString()),12,'L')
		ls_data += '\r\n'
	}
	
	ls_data += "총강좌수 : "+ (subject_split.length-1) + "\r\n";
	ls_data += '----------------------------------------';
	//합계
	ls_trade_all_amt 	= total_pay;
	//에누리
	ls_enuri_amt 		= encd_pay1 + encd_pay2;
	
	//매출액
	ls_net_sale_amt 	= final_pay;
	//받은돈
	ls_get_sale_amt 	= cash_amt + card_amt + coupon_amt + mcoupon_amt;
	//거스름돈
	ls_change			= nullCheck($("#change").val());
	
	ls_data += '\r\n'
	ls_data += ls_escape + ls_doublewide
	
	// 합    계→ 에누리 포함금액으로, 에누리→ (-) 표시 변경요청 (12.09.27) - 이장근요청
	ls_data += '합    계 '  + f_setfill(comma(ls_trade_all_amt), 9, 'L')	+ '원\r\n'		   // 나머지는 총 수강료 금액으로 표시
	
	// 에누리 영수증 표시금액(-1) 표시 (12.09.27) - 이장근
	ls_v_enuri_amt = ls_enuri_amt * -1 ;
	
	ls_data += '에 누 리 ' + f_setfill(comma(ls_v_enuri_amt), 9, 'L')	+ '원\r\n'
	ls_data += '결제금액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'
	ls_data += '지불금액 ' + f_setfill(comma(ls_get_sale_amt), 9, 'L')	+ '원\r\n'
	ls_data += '거스름돈 ' + f_setfill(comma(ls_change), 9, 'L')		+ '원\r\n'
	ls_data += ls_escape + ls_normal
	ls_data += '----------------------------------------\r\n' ;

	// 상품권이 있으면...
	if(coupon_fg_arr != "") 
                        {
                                /* 2019.03.11 ljs 포멧변경으로 기존소스 주석처리(자사/타사 상품권 총매수, 금액, 자사증정-현금영수증제외 금액 표기하도록 포멧수정) 
		var coupon_name = "";
		ls_data += "상품권\r\n";
		
		for(i = 1; i < gridCoupon.rows; i++) {
			if(gridCoupon.valueMatrix(i, gridCoupon.colRef("coupon_fg")) == "0") {
				coupon_name = "자사";
			} else {
				coupon_name = "타사";
			}
			ls_data += i + ". " + coupon_name + "  번호 : "  + gridCoupon.valueMatrix(i, gridCoupon.colRef("coupon_no")) + f_setfill(comma(gridCoupon.valueMatrix(i, gridCoupon.colRef("face_amt"))), 8, 'L') + "원";
		}
		ls_data += '\r\n\r\n';
                               						*/
	    //2019.03.11 ljs 포멧변경 (자사/타사 상품권 총매수, 금액, 자사증정-현금영수증제외 금액 표기하도록 포멧변경) START
		var my_coupon_name = "자사";
		var my_coupon_no = "";
		var my_coupon_count = 0;
		var my_Face_Amt = 0;
		var other_coupon_name = "타사";
		var other_coupon_no = "";
		var other_coupon_count = 0;
		var other_Face_Amt = 0;
		
		
		var coupon_fg_split = coupon_fg_arr.split("|");
	    var coupon_cd_split = coupon_cd_arr.split("|");
	    var coupon_no_split = coupon_no_arr.split("|");
	    var face_amt_split = face_amt_arr.split("|");
	    var cashrec_yn_split = cashrec_yn_arr.split("|");
	    var vat_cal_ext_rate_split = vat_cal_ext_rate_arr.split("|");
	    var vat_cal_rate_split = vat_cal_rate_arr.split("|");
	    var cp_change_amt_split = cp_change_amt_arr.split("|");
	    var cp_chage_apy_y_amt_split = cp_chage_apy_y_amt_arr.split("|");
	    var cp_chage_apy_n_amt_split = cp_chage_apy_n_amt_arr.split("|");
	    var cashrec_amt_split = cashrec_amt_arr.split("|");
	    var cashrec_n_amt_split = cashrec_n_amt_arr.split("|");
	    var coupon_cnt = coupon_fg_split.length -1;
	    
	    for(var i = 0; i < coupon_cnt; i++)
		{
	    	if(coupon_fg_split[i] == "0" 
				   || coupon_fg_split[i] == "7") 
			{
				my_coupon_count += 1;
				my_Face_Amt +=  parseInt(face_amt_split[i]);
				
				if(my_coupon_no == "" || my_coupon_no == null )
				{
					my_coupon_no = coupon_no_split[i]; 
				}
            } 
             else
			{
                other_coupon_count += 1;
				other_Face_Amt +=  parseInt(face_amt_split[i]);
				
				if(other_coupon_no == "" || other_coupon_no == null )
				{
					other_coupon_no = coupon_no_split[i]; 
				}
			} 
		}
	    

		//자사상품권표기
		if(my_coupon_no != "" && my_coupon_no != null )
		{
			ls_data += "자사상품권" + f_setfill("",5,'R');
			ls_data += f_setfill(comma(my_coupon_count.toString()), 10, 'L') + " 매";
			ls_data += f_setfill(comma(my_Face_Amt.toString()),10,'L') + '원\r\n';
			ls_data += '상품권 번호 : ' + my_coupon_no + '\r\n';
		}
		//타사상품권표기
		if(other_coupon_no != "" && other_coupon_no != null )
		{
			ls_data += "타사상품권" + f_setfill("",5,'R');
			ls_data += f_setfill(comma(other_coupon_count.toString()), 10, 'L') + " 매";
			ls_data += f_setfill(comma(other_Face_Amt.toString()),10,'L') + '원\r\n';
			ls_data += '상품권 번호 : ' + other_coupon_no + '\r\n';							
		}	
		
		if( (ls_mc_approve_no != null && ls_mc_approve_no != "") || 
		    (ls_card_no != null && ls_card_no != "" && card_amt > 0 ) ||
			(ls_cash_amt != null && ls_cash_amt != ""&& ls_cash_amt != "0") 
		)
		{
			ls_data += '\r\n';		
		}	
		//2019.03.11 ljs 포멧변경 (자사/타사 상품권 총매수, 금액, 자사증정-현금영수증제외 금액 표기하도록 포멧변경) END
	}
	
	// 모바일 상품권		2017.08.14 추가
	if(ls_mc_approve_no != null && ls_mc_approve_no != "") {
		ls_data += "모바일상품권\r\n";
		ls_data += "상품권:" + ls_mc_card_no + "\r\n";
		ls_data += "승인:" + ls_mc_approve_no + "\r\n";
		ls_data += f_setfill("",19,'R') + "청구금액:" +  f_setfill(comma(ls_mc_card_amt), 10, 'L') + "원\r\n";
		ls_data += f_setfill("",17,'R') + "상품권잔액:" +  f_setfill(comma(ls_mc_remain_amt), 10, 'L') + "원\r\n";
		ls_data += '\r\n';
	}
	
	// 카드결제이면...
	//2019.04.24 ljs - 카드금액 체크 추가 ( 김성근이사님 의견반영)
	if(ls_card_no != null && ls_card_no != "" && card_amt > 0 ) {
		var monthValue = "";
	//	ls_data += f_card_gubun_nm('name', ls_card_no) +'\r\n'
	// 발행사 표기 추가(12.11.20)
		//ls_data += f_card_gubun_nm('name', ls_card_no) +  f_setfill(f_card_gubun_nm('state', ls_card_no),28,'L') +'\r\n' 여전법 이전
		
		//cmc - bcqr 결제 시 QR 같이 찍어준다.
		if(ls_bc_qr_value != null && ls_bc_qr_value != ""){
			
			var qr_gubun2      = ls_bc_qr_value.substr(3, 1) ; // (L, C)
			
			if(qr_gubun2 == "L" || qr_gubun2 == "C"){
				ls_data += ic_card_nm +  "(QR)" + f_setfill('',22,'L') +'\r\n'
			}
			else{
				ls_data += ic_card_nm +  f_setfill('',28,'L') +'\r\n'
			}
		}
		else {
			ls_data += ic_card_nm +  f_setfill('',28,'L') +'\r\n'
		}
		
		if(ic_card_month == "00") {
			monthValue = "일시불";
			ls_data += f_setfill(monthValue,20,'R')+ '\r\n';
		} else {
			monthValue = "할부 " + ic_card_month + "개월";
			ls_data += f_setfill(monthValue,19,'R')+ '\r\n';
		}
		//ls_data += f_setfill(comma(ls_card_amt), 15, 'L') +'원\r\n'; 여전법 이후 카드금액 2번나오는거 주석
		// 10.06.23 (backup) ls_data += '카드 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-"+  ls_card_no.substring(12) +  "         **/**" + '\r\n'
		//ls_data += '카드번호:'+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-"+ ls_card_no.substring(12)  +  "       **/**" + '\r\n' // 여전법 이전 
		ls_data += '카드번호:'+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 6) + "**-****-"+ ls_card_no.substring(12)  + '\r\n';// 여전법 이후 유효기간 삭제
		
		if (ls_card_fg == "555" || (ls_rest_amt != null && trim(ls_rest_amt) !=  "" && ls_rest_amt !=  "000000000"))  {
			ls_rest_amt = Number(ls_rest_amt);
			ls_rest_amt = ls_rest_amt.toString(); //앞에 0 없애기위해 형변환쓰
			ls_data += '승인번호:'+ ls_approve_no +'  '+'카드잔액:'+f_setfill(comma(ls_rest_amt),10,'L')+'원';
		}else {
			ls_data += '승인번호:'+ ls_approve_no +'  '+'청구금액:'+f_setfill(comma(ls_card_amt),10,'L')+'원';
		}
		
		ls_data += '\r\n';
	}
	// 현금
	if(ls_cash_amt != null && ls_cash_amt != ""&& ls_cash_amt != "0") {
		ls_data += ls_escape + ls_normal;
		ls_data += "현     금" + f_setfill(comma(ls_cash_amt.toString()), 29,'L') +'원\r\n';
		ls_data += ls_escape + ls_normal;
	}

                        //2019.03.11 ljs 자사증정-현금영수증제외 추가 START
	if(ls_cashrec_n_coupon > 0)
	{
		ls_data += '----------------------------------------\r\n' ;
		ls_data += "   (자사증정-현금영수증제외)" + f_setfill(comma(ls_cashrec_n_coupon.toString()), 10, 'L') + "원\r\n";
	}
    //2019.03.11 ljs 자사증정-현금영수증제외 추가 END
	
	//2019.03.11 ljs AK멤버스 적립마일리지 표기 위치 변경 START
	//AK멤버스 적립마일리지 표기, 사용마일리지 추가
	if(akmem_save_approve_no != "" 
	   || akmem_sApprovNo != "")
	{
		var ls_AKmem_SaveApproveNo_POS = akmem_save_approve_no_pos ;
		
		//전액 사용마일리지 사용한 경우
		if(akmem_save_approve_no == "" 
		   && akmem_sApprovNo != "")
		{
			ls_AKmem_SaveApproveNo_POS = akmem_save_approve_no_pos ;
		}
		
		ls_memcard_no  = akmem_card_no;
		ls_data += '----------------------------------------\r\n'
		//ls_data += "AK멤버스 카드번호 :  " + ls_memcard_no.substring(0, 4) + "-" + ls_memcard_no.substring(4, 8) + "-****-" + ls_memcard_no.substring(12) +'\r\n'여전법이전
		ls_data += "AK멤버스 카드번호 :  " + ls_memcard_no.substring(0, 4) + "-" + ls_memcard_no.substring(4, 6) + "**-****-" + ls_memcard_no.substring(12) +'\r\n'
		ls_data += "AK멤버스 회원번호 :  " + akmem_cust_no +'\r\n'
		ls_data += "AK멤버스 승인번호 :  " + ls_AKmem_SaveApproveNo_POS +'\r\n'
		ls_data += "AK멤버스 적립 마일리지 : " + f_setfill(comma(akmem_recpt_point), 13,'L') +'점\r\n'
		//2019.03.11 ljs 사용마일리지 추가
		ls_data += "AK멤버스 사용 마일리지 : "  + f_setfill(comma(point_amt), 13,'L') +'점\r\n'  //2019.03.11 ljs  사용마일리지 추가
		if(akmem_save_approve_no != "")
		{
			ls_data += "AK멤버스 누적 마일리지 : "  + f_setfill(comma(akmem_save_approve_no_point), 13,'L') +'점\r\n'
		}
		else
		{
			ls_data += "AK멤버스 누적 마일리지 : "  + f_setfill(comma(akmem_save_approve_no_point), 13,'L') +'점\r\n'
		}
	}
	//2019.03.11 ljs AK멤버스 적립마일리지 표기 위치 변경 END
	// 현금영수증일때
	if(ls_aprv_no != null && ls_aprv_no != "") {
		var ls_cust_mark = "";

		if(ls_id_fg == "1") {
			//10.06.23 (backup) ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 8) + "-****-" + ls_id_no.substring(12);
			ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 8) + "-****-" + ls_id_no.substring(12);
		} else if(ls_id_fg == "2") {
			ls_cust_mark = Left(ls_id_no, trim(ls_id_no).length - 4) + "****";
		} else if(ls_id_fg == "3") {
			ls_cust_mark  = ls_id_no.substring(0, 6) + "-*******";
		} else if(ls_id_fg == "4") {
			ls_cust_mark  = ls_id_no;
		}

		if(ls_issue_fg == "1") {
			ls_issue_fg = "소득공제";
		} else if(ls_issue_fg == "2")  {
			ls_issue_fg = "지출공제";
		}

		ls_data = ls_data.substring(0, ls_data.lastIndexOf("\r\n"));
		ls_data += '----------------------------------------\r\n';
		ls_data += ls_escape + ls_doublewide
		ls_data += "-- 현금(" + ls_issue_fg + ") --\r\n"
		ls_data += ls_escape + ls_normal
		ls_data += '              ( 고  객  용 )            \r\n'

		if(trim(ls_id_no) == '0100001234') {
			ls_data += '식별번호:' + ls_cust_mark + '(국세청 지정코드)' + '\r\n'
		} else {
			ls_data += '식별번호:' + ls_cust_mark + '\r\n'
		}						

		ls_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma(cash_amt)+ '원\r\n'
		ls_data += '----------------------------------------\r\n'
		ls_data += ' 현금영수증 문의: ☏ 1544-2020\r\n'
		ls_data += ' http://www.현금영수증.kr\r\n'
	}
	ls_data += '----------------------------------------\r\n';   //2019.03.11 ljs 위치변경 
	ls_data = ls_data.substring(0, ls_data.lastIndexOf("\r\n"));
	if (ls_card_fg == "555") {
		ls_data += "AK기프트카드 실물이 없는(분실 및 폐기)\n";
		ls_data += "경우 취소가 불가하오니 유의하시기\n";
		ls_data += "바랍니다. \n";
		ls_data += "----------------------------------------\r\n\r\n";
	}
	/*여전법 이후 문구 수정*/
	ls_data += "여신전문금융업법('15년 7월)에 따라\n"
	ls_data += "환불/교환/재결제의 경우 \n"
	ls_data += "결제하셨던 영수증 및 카드를\n"
	ls_data += "반드시 지참하셔야 합니다.\r\n\r\n"
	
	ls_data += "(현금/상품권은 영수증만 지참)\n"
	ls_data += "강좌 취소시 사은품은 반납하셔야\n"
	ls_data += "취소(환불)가 가능합니다.\r\n\r\n"
	
//				ls_data += "본 영수증은 교환 및 환불시 필요하오니\n";
//				ls_data += "잘 보관하시기 바랍니다. 감사합니다.\r\n\r\n";
//				ls_data += "강좌 취소시 수령하신 사은품은 반납하셔야\n";
//				ls_data += "취소(환불)가 가능합니다.\r\n\r\n";
	
	// 모바일 상품권일 경우 문구추가
	if(ls_mc_approve_no != null && ls_mc_approve_no != ""){
		ls_data += f_setfill("",2,'R') + "※ 모바일상품권잔액은 해당 사용 바코드\r\n";
		ls_data += f_setfill("",5,'R') + "에 대한 결제 후 잔액이 표기됩니다.\n";
		ls_data += f_setfill("",2,'R') + "※ AK 모바일상품권 잔액환불 문의 : \r\n";
		ls_data += f_setfill("",5,'R') + "갤럭시아컴즈 고객센터 ☎ 1566-0123 \r\n";
		ls_data += f_setfill("",5,'R') + "(운영시간 : 평일 09시 ~ 18시 / \r\n";
		ls_data += f_setfill("",18,'R') + "주말 및 공휴일 휴무)\r\n\r\n";
	}					
	//현금 영수증 자진발급제 일때 보여주기!
	if(trim(ls_id_no) == "0100001234") {
		ls_data += "본 영수증은 국세청 현금 영수증 자진\n";
		ls_data += "발급제 시행에 따라 발급된 영수증으로써\n";
		ls_data += "개인 소득공제 및 지출증빙은 국세청에서\n";
		ls_data += "신청할 수 있습니다.\r\n\r\n";
	}
	
	ls_data += f_setfill(sale_time,16,'R');
	
	if($("#selBranch").val() == "01"){
		ls_data += "전화번호:02-818-0895\n";
	}else if($("#selBranch").val() == "02"){
		ls_data += "전화번호:031-240-0523\n";
	}else if($("#selBranch").val() == "03"){
		ls_data += "전화번호:031-779-3810\n";
	}else if($("#selBranch").val() == "04"){
		ls_data += "전화번호:031-615-1050\n";
	}else if($("#selBranch").val() == "05"){
		ls_data += "전화번호:033-811-5001\n";
	}
	ls_data += f_setfill("담당자: "+ login_name,34,'L') + "\n";
	
	printer.PrintNormal(2, '\r\n');
	printer.Printbitmap(2, "C:\\IPOSNAME_AKP.BMP", -11, -1);
	printer.DeviceEnabled = true;
	printer.RecLineChars = 40;
	printer.PrintNormal(2, '\r\n');
	printer.PrintNormal(2, ls_data);
	printer.PrintNormal(2, ' \r\n');
	printer.Printbarcode(2, ls_barcode, 110, 50, 20, -2, -13);
	printer.PrintNormal(2, '\r\n\r\n\r\n\r\n');
	printer.CutPaper(95);

	// 전자서명인 경우 ls_e_sign의 값이 1이여야 한다.<=여전법이전
	// 전자서명인 경우 ls_e_sign의 값이 $이여야 한다.<=여전법이후
	// 전자서명을 받지 않았을 경우 카드전표를 뽑는다.
	var ls_e_sign = "";
	ls_e_sign = Left(signText, 1);
	if((ls_card_no != null && ls_card_no != "") && (ls_e_sign == ""|| ls_e_sign == "0")) {
		//==================================================================
		
		// 09.07.14 신한카드 50,000미만 무서명추가  ------------------------------------------------------------------------------------------------------------------
		// 10.04.01 삼성카드, BC카드  50,000미만 무서명추가  ---------------------------------------------------------------------------------------------------------
		// 10.07.20 국민카드  50,000 미만 무서명 추가
		// 10.09.30 현대카드  50,000 미만 무서명 추가(10.01~)
							 
		var ls_card_corp_cd	=	ic_card_co_origin_seq;
		
		/* if( (  (ls_card_corp_cd == "822") || (ls_card_corp_cd == "823") 
			|| (ls_card_corp_cd == "002") || (ls_card_corp_cd == "003") || (ls_card_corp_cd == "004") || (ls_card_corp_cd == "005") 
			|| (ls_card_corp_cd == "992") || (ls_card_corp_cd == "993") || (ls_card_corp_cd == "031") ) && ( ls_card_amt < 50000 )) {	
		*/	  
		
		 // 10.06.10 무서명 기준 추가 (BC카드)
		 // 11.05.25 외환카드 50,000 미만  무서명 기준 추가 
		 // 11.07.25 롯데카드 50,000 미만 무서명 기준 추가(11.08.16 적용)
		 // 12.06.26 외환카드 중 하나SK카드 무서명 제외추가 (일부카드 무서명제외 53건) 
																																													   
		 // 13.05.28 NH카드 50,000 미만 무서명 기준 추가 (이진아주임)
		 // 13.06.26 할부거래 무서명 제외추가(송진영주임)
								 
		var ls_halbu_no    	=	ic_card_month;
		
		 
		if( (  (ls_card_corp_cd == "822") || (ls_card_corp_cd == "823") 
			|| (ls_card_corp_cd == "002") || (ls_card_corp_cd == "003") || (ls_card_corp_cd == "004") || (ls_card_corp_cd == "005") 
			|| (ls_card_corp_cd == "992") || (ls_card_corp_cd == "993") || ((ls_card_corp_cd == "031") && (ls_card_sain_fg == "Y"))
			|| (ls_card_corp_cd == "041") || (ls_card_corp_cd == "042") || (ls_card_corp_cd == "951") || ((ls_card_corp_cd == "052") && (ls_card_sain_fg == "Y"))
			|| (ls_card_corp_cd == "961") || (ls_card_corp_cd == "061") 
			|| (ls_card_corp_cd == "033") || (ls_card_corp_cd == "034")) && ( ls_card_amt < 50000 ) // 2020.02.03 kjp 우리카드,AK우리카드 추가
			&& (ls_halbu_no == "00") // 13.06.26 할부거래 무서명 제외추가(송진영주임)
			) {	
				
		// 12.10.29 AK-GIFT[555], 홈플러스[666] 무서명기준 추가 (금액대 무관). KT[888]는 원래 결제 안됨 							
		}else if (ls_card_corp_cd == "555" ) {
			
			  
		}else {
				
				if($("#selBranch").val() == "03") {
					//분당점
					ls_data  = ls_escape + ls_font
					//분당점 에이알디홀딩스(주) -> AK S&D(주) 변경(2012.06.26)
					ls_data += "AK S&D(주) AK 분당점\n"
					ls_data += "129-85-42346  김 재 천\n"
					ls_data += "경기도 성남시 분당구 황새울로 360번길 42\n"
					ls_data += "Tel: 1661-1114\n"
					ls_data += "http://www.akplaza.com www.akmall.com\n"
					ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
					ls_data += '\r\n\r\n'
					ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
					ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
					
				} else if($("#selBranch").val() == "01") {
					//구로점
					ls_data  = ls_escape + ls_font
					ls_data += "에이케이아이에스(주) 구로본점\n"
					ls_data += "113-81-07313  백차현, 김재영\n"
					ls_data += "서울특별시 구로구 구로중앙로 152\n"
					ls_data += "Tel: 1661-1114\n"	
					ls_data += "http://www.akplaza.com www.akmall.com\n"
					ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
					ls_data += '\r\n\r\n'									
					ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
					ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
				} else if($("#selBranch").val() == "02") {
					//수원점
					ls_data  = ls_escape + ls_font
					ls_data += "수원애경역사(주) 수원점\n"
					ls_data += "124-81-28579  김 재 천\n"
					ls_data += "경기도 수원시 팔달구 덕영대로 924\n"
					ls_data += "Tel: 1661-1114\n"
					ls_data += "http://www.akplaza.com www.akmall.com\n"
					ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
					ls_data += '\r\n\r\n'
					ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
					ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
				}else if($("#selBranch").val() == "04") {
					//평택점
					ls_data  = ls_escape + ls_font
					ls_data += "평택역사(주) 평택점\n"
					ls_data += "125-81-24085  김 재 천\n"
					ls_data += "경기도 평택시 평택로 51\n"
					ls_data += "Tel: 1661-1114\n"
					ls_data += "http://www.akplaza.com www.akmall.com\n";
					ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
					ls_data += '\r\n\r\n'
					ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n";
					ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n";
				}else if($("#selBranch").val() == "05") {
					//원주점
					ls_data  = ls_escape + ls_font
					ls_data += "에이케이에스앤디(주) AK원주점\n";
					ls_data += "224-85-23362 김 재 천\n";
					ls_data += "강원도 원주시 봉화로 1\n";
					ls_data += "Tel: 1661-1114\n";
					ls_data += "http://www.akplaza.com www.akmall.com\n";
					ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
					ls_data += '\r\n\r\n';
					ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n";
					ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n";
				}
				
				ls_data += ls_escape + ls_normal;
				ls_data += '----------------------------------------\r\n';
				ls_data += ' 강좌명    수강료     재료비     합  계 \r\n';
				ls_data += '----------------------------------------\r\n';
				for(i = 0; i < subject_split.length-1; i++)
				{
					var regis_fee_i = regis_fee_split[i];
					var food_fee_i	= food_amt_split[i];
					var sub_tot_fee	= eval(regis_fee_i) + eval(food_fee_i);
					
					ls_data += subject_split[i] +' '+subject_nm_split[i]
					ls_data += '\r\n'
					ls_data += f_setfill(comma(regis_fee_i),17,'L')
					ls_data += f_setfill(comma(food_fee_i),11,'L')
					ls_data += f_setfill(comma(sub_tot_fee.toString()),12,'L')
					ls_data += '\r\n'
				}

				
				ls_data += "총강좌수 : "+ (subject_split.length-1) + "\r\n";
				ls_data += '----------------------------------------';

				ls_trade_all_amt 	= total_regis_fee;
				
				//if(cbx_part_pay.value == "Y" || cbx_middle_pay.value == "Y") {
				ls_enuri_amt 		= encd_pay1 + encd_pay2;
				ls_card_amt 		= card_amt;

				ls_data += '\r\n'
				ls_data += ls_escape + ls_doublewide
				
				// 기존소스백업 ls_data += '합  계 ' + f_setfill(comma(ls_trade_all_amt), 11, 'L')	+ '원\r\n'
				
				//부분입금, 중도수강은 결제금액으로  분리(12.10.04)
				ls_data += '합  계 ' + f_setfill(comma(ls_trade_all_amt), 11, 'L')	+ '원\r\n'  // 나머지는 총 수강료 금액으로 표시
				
				// 에누리 영수증 표시금액(-1) 표시 (12.09.27) - 이장근
				ls_v_enuri_amt = ls_enuri_amt * -1 ;
				/*
				ls_data += '에누리 ' + f_setfill(comma(ls_enuri_amt), 11, 'L')		+ '원\r\n'
				*/
				ls_data += '에누리 ' + f_setfill(comma(ls_v_enuri_amt), 11, 'L')	+ '원\r\n'
				ls_data += '카드액 ' + f_setfill(comma(ls_card_amt), 11, 'L')	+ '원\r\n'
				ls_data += '청구액 ' + f_setfill(comma(ls_card_amt), 11, 'L')	+ '원\r\n'	
				ls_data += ls_escape + ls_normal
//								ls_data += '----------------------------------------\r\n' 
				///////////////////////////////////
				ls_data += '----------------------------------------\r\n'
				ls_data += '----         카 드 전 표            ----\r\n'
				ls_data += '----------------------------------------\r\n'
				ls_data += ls_escape + ls_doublewide
				//ls_data += f_card_gubun_nm('name', ls_card_no) +'\r\n' 여전법 이전
				
				if(ls_bc_qr_value != null && ls_bc_qr_value != ""){
			
					var qr_gubun2      = ls_bc_qr_value.substr(3, 1) ; // (L, C)
					
					if(qr_gubun2 == "L" || qr_gubun2 == "C"){
						ls_data += ic_card_nm +  "(QR)" +'\r\n'
					}
					else{
						ls_data += ic_card_nm +'\r\n'
					}
				}
				else {
					ls_data += ic_card_nm +'\r\n'
				}
				
				if(ic_card_month == "00") {
					monthValue = "일시불";
					monthValue = f_setfill(monthValue,15,'L');
				} else {
					monthValue = "할부 " + ic_card_month + "개월";
					monthValue = f_setfill(monthValue,14,'L');
				}
				
				ls_data += ls_escape + ls_normal
				//ls_data += '카드번호 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12) + "     **/**" + "\r\n" 여전법이전
				ls_data += '카드번호 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 6) + "**-****-" + ls_card_no.substring(12) + "\r\n"; //여전법이후 유효기간 삭제
				ls_data += '승인번호 : '+ ls_approve_no +'   '+ monthValue + "\r\n"
				ls_data += '----------------------------------------\r\n'
				ls_data += '고객서명 :                              \r\n\r\n'
				ls_data += '----------------------------------------\r\n'

				ls_data += f_setfill(sale_time,16,'R') 
				//+ f_setfill('담당자: '+ login_name,12,'L')
				if($("#selBranch").val() == "01"){
					ls_data += "전화번호:02-818-0895\n"
				}else if($("#selBranch").val() == "02"){
					ls_data += "전화번호:031-240-0523\n";
				}else if($("#selBranch").val() == "03"){
					ls_data += "전화번호:031-779-3810\n"
				}else if($("#selBranch").val() == "04"){
					ls_data += "전화번호:031-615-1050\n"
				}else if($("#selBranch").val() == "05"){
					ls_data += "전화번호:033-811-5001\n"
				}
				
				ls_data += f_setfill("담당자: "+ login_name,34,'L') + "\n";
				printer.PrintNormal(2, '\r\n');
				printer.Printbitmap(2, "C:\\IPOSNAME_AKP.BMP", -11, -1);
				printer.PrintNormal(2, '\r\n');
				printer.PrintNormal(2, ls_data);
				printer.PrintNormal(2, ' \r\n');
				printer.Printbarcode(2, ls_barcode, 110, 50, 20, -2, -13);
				printer.PrintNormal(2, '\r\n\r\n\r\n\r\n');
				printer.CutPaper(95);
			}		
	}// 09.07.14 신한카드 50,000미만 무서명추가  ------------------------------------------------------------------------------------------------------------------
}//posPrint()
function posPrintPrev() {
	var ls_print_data = ls_header_data + ls_detail_data + ls_footer_data;
	
	printer.PrintNormal(2, '\r\n');
	printer.Printbitmap(2, "C:\\IPOSNAME_AKP.BMP", -11, -1);
	printer.DeviceEnabled = true;
	printer.RecLineChars = 40;
	printer.PrintNormal(2, '\r\n');
	printer.PrintNormal(2, ls_print_data);
	printer.PrintNormal(2, ' \r\n');
	printer.Printbarcode(2, ls_barcode, 110, 50, 20, -2, -13);
	printer.PrintNormal(2, '\r\n\r\n\r\n\r\n');
	printer.CutPaper(95);
	alert("영수증 인쇄가 완료되었습니다.");

}
function setWeekDay(strDate) {
	var hanDay = new Array("일", "월", "화", "수", "목", "금", "토");

	var sYear = strDate.substring(0,4);
	var sMonth = strDate.substring(4,6);
	var sDay = strDate.substring(6,8);
	var newDate = new Date(parseInt(sYear, 10), parseInt(parseInt(sMonth, 10)-1, 10), parseInt(sDay, 10));
	return hanDay[newDate.getDay()];
}//setWeekDay
function Left(str, n) {
    if (n <= 0)
            return "";
    else if (n > String(str).length)
            return str;
    else
            return String(str).substring(0,n);
}

/**
 * 파워빌더 Right
 * 작성자 : 이용성
 */
function Right(str, n) {
    if (n <= 0)
           return "";
    else if (n > String(str).length)
           return str;
    else {
           var iLen = String(str).length;
           return String(str).substring(iLen, iLen - n);
    }
}

//인증심사 T-012 : 민감한 신용카드 정보의 저장 여부 및 완전삭제 여부 확인
function dataReset()
{
	subject_arr = "";
	subject_nm_arr = "";
	regis_fee_arr = "";
	food_amt_arr = "";

	rep_subject_cd = ""; //대표강좌 셋팅 (주차)
	rep_recpt_no = "";

	pay_fg = "7"; //2 : 수강료, 3 : 부분입금, 7 : 재료비 + 수강료, 8 : 중도수강 나중에 수정해야함.    

	total_pay = 0; //총 금액
	total_regis_fee = 0; //총 수강료
	total_food_amt = 0; //총 재료비
	final_pay = 0; // 할인빼고 뭐빼고 하여튼 최종 결제해야할 금액

	encd_pay1 = 0; //할인금액1
	encd_pay2 = 0; //할인금액2

	cash_amt = 0;
	card_amt = 0;
	coupon_amt = 0;
	mcoupon_amt = 0;
	key_value = ""; //현금승인시 사용
	user_ip = ""; //관리자 아이피
	pos_no = ""; //관리자 포스번호
	cashrec_n_coupon_arr = ""; //상품권할때 추가한다.
	cashrec_n_coupon = 0; //상품권할때 추가한다.
	cashrec_y_coupon = 0; //상품권할때 추가한다.

	pos_status = "";



	//현금영수증용 카드 변수
	cash_card_rfFlag = "";
	cash_card_cardFlag = "";
	cash_card_modelNo = "";
	cash_card_encDtCnt = "";
	cash_card_encGubun = "";
	cash_card_ksn = "";
	cash_card_encData = "";
	cash_card_ksn1 = "";
	cash_card_encData1 = "";

	cash_card_cardFlag1 = "";
	cash_card_cardFlag2 = "";
	cash_card_cardFlag3 = "";
	cash_card_cardFlag4 = "";

	cash_ls_send_str = "";

	cash_approve_no = "";
	cash_bank_cd = "";
	cash_rate = "";
	cash_message = "";
	cash_issue_fg = "";
	cash_id_fg = "";
	cash_id_no = "";
	cash_approve_amt = 0;
	//현금영수증용 카드 변수

	//단말기 체크 변수
	reader_modelCd = "";
	reader_ver = "";
	reader_serialNo = "";
	reader_protoVer = "";
	reader_useMsrTr = "";
	reader_maxVan = "";
	reader_vanCnt = "";
	reader_vanCode = "";
	reader_vanNm = "";
	reader_reciKeyVer = "";
	reader_encMeth = "";
	reader_vanCode1 = "";
	reader_vanNm1 = "";
	reader_reciKeyVer1 = "";
	reader_encMeth1 = "";
	reader_vanCode2 = "";
	reader_vanNm2 = "";
	reader_reciKeyVer2 = "";
	reader_encMeth2 = "";
	reader_vanCode3 = "";
	reader_vanNm3 = "";
	reader_reciKeyVer3 = "";
	reader_encMeth3 = "";
	reader_vanCode4 = "";
	reader_vanNm4 = "";
	reader_reciKeyVer4 = "";
	reader_encMeth4 = "";
	reader_secuVer1 = "";
	reader_integrity = "";
	reader_secuVer = "";
	//단말기 체크 변수

	//상품권 Grid 배열들
	coupon_fg_arr = "";
	coupon_cd_arr = "";
	coupon_no_arr = "";
	face_amt_arr = "";
	cashrec_yn_arr = "";
	vat_cal_ext_rate_arr = "";
	vat_cal_rate_arr = "";
	cp_change_amt_arr = "";
	cp_chage_apy_y_amt_arr = "";
	cp_chage_apy_n_amt_arr = "";
	cashrec_amt_arr = "";
	cashrec_n_amt_arr = "";
	//상품권 Grid 배열들

	//모바일상품권 변수들
	barcode_no = "";
	mcoupon_approve_status = 0; //모바일상품권 승인여부 승인시 1로 바뀜.
	mcoupon_remain_amt = 0; //사용가능금액
	mcoupon_search_cd = 0; //모바일상품권 조회 여부 조회시 1로 바뀜.
	mcoupon_approve_cd = 0; 
	mcoupon_rmn_amt = 0; //잔여금
	mcoupon_cnt = 0; //단독결제 복합결제
	mcoupon_approve_no = ""; //승인번호
	mcoupon_approve_amt = 0; //승인금액
	//모바일상품권 변수들


	//멤버스포인트 변수들
	akmem_card_fg = "";
	akmem_card_no = "";
	akmem_card_rfFlag = "";
	akmem_card_cvm = "";
	akmem_card_onlineYN = "";
	akmem_card_cardNo = "";
	akmem_card_modelNo = "";
	akmem_card_encDtCnt = "";
	akmem_card_vanCode = "";
	akmem_card_encGubun = "";
	akmem_card_ksn = "";
	akmem_card_encData = "";
	akmem_card_vanCode1 = "";
	akmem_card_encGubun1 = "";
	akmem_card_ksn1 = "";
	akmem_card_encData1 = "";
	akmem_card_vanCode2 = "";
	akmem_card_encGubun2 = "";
	akmem_card_ksn2 = "";
	akmem_card_encData2 = "";
	akmem_card_vanCode3 = "";
	akmem_card_encGubun3 = "";
	akmem_card_ksn3 = "";
	akmem_card_encData3 = "";
	akmem_card_vanCode4 = "";
	akmem_card_encGubun4 = "";
	akmem_card_ksn4 = "";
	akmem_card_encData4 = "";
	akmem_card_encCardNo_send_str = ""; //암호화된 카드번호
	akmem_card_type_nm = "";
	akmem_card_co_origin_seq = "";
	akmem_total_point = 0;
	akmem_use_min_point = 0;
	akmem_use_max_point = 0;
	akmem_use_hurdle = 0;
	akmem_cust_grade = "";
	akmem_sApprovNo = "";

	akmem_cust_no = "";

	akmem_resp_no = "";
	akmem_resp_msg = "";
	akmem_family_cust_no = "";
	akmem_cust_name = "";
	akmem_cust_level = "";
	akmem_regi_card_yn = "";
	akmem_regi_card_no = "";
	akmem_use_yn = "";

	akmem_card_fallback_gubun = "";
	akmem_card_fallback_reason = "";

	akmem_card_hide_card_no = "";

	akmem_card_no = ""; //사용자눈에 보이는 그 카드번호
	akmem_pswd = ""; //멤버스카드 비밀번호

	ls_akmem_send_str = "";

	akmem_recpt_point = ""; //적립 마일리지


	akmem_save_approve_no = "";
	akmem_save_approve_no_pos = "";
	akmem_save_approve_no_point = "";

	point_amt = 0; //포인트 사용금액
	point_approve_yn = "N"; //포인트 사용여부. 기존화면에서 포인트 사용 누르면 이거 Y로 바꿈

	//멤버스포인트 변수들


	//카드결제 변수들
	ic_card_emv = "";
	ic_card_month = "";
	ic_card_valid = "0000"; 
	ic_card_rfFlag = "";
	ic_card_cvm = "";
	ic_card_onlineYN = "";
	ic_card_cardNo = "";
	ic_card_modelNo = "";
	ic_card_encDtCnt = "";
	ic_card_vanCode = "";
	ic_card_encGubun = "";
	ic_card_ksn = "";
	ic_card_encData = "";
	ic_card_vanCode1 = "";
	ic_card_encGubun1 = "";
	ic_card_ksn1 = "";
	ic_card_encData1 = "";
	ic_card_vanCode2 = "";
	ic_card_encGubun2 = "";
	ic_card_ksn2 = "";
	ic_card_encData2 = "";
	ic_card_vanCode3 = "";
	ic_card_encGubun3 = "";
	ic_card_ksn3 = "";
	ic_card_encData3 = "";
	ic_card_vanCode4 = "";
	ic_card_encGubun4 = "";
	ic_card_ksn4 = "";
	ic_card_encData4 = "";
	ic_card_encCardNo_send_str = "";

	ic_card_cardFlag1 = "";
	ic_card_cardFlag2 = "";
	ic_card_cardFlag3 = "";
	ic_card_cardFlag4 = "";

	ic_card_fallback_gubun = "";
	ic_card_fallback_reason = "";

	ic_card_hide_card_no = "";
	ic_card_no = "";
	ic_card_flag = "";
	ic_card_nm = "";
	ic_card_co_origin_seq = "";
	ic_card_sain_fg = "";
	ic_card_pri_nm = "";

	ic_card_data_fg = "";

	ic_card_approve_no = "";
	ic_card_approve_message = "";
	ic_card_rest_amt = "";
	ic_card_return_cd = "";

	ic_ls_send_str = "";
	ic_ls_send_str_F = "";
	
	$("#ic_card_no").val('');
	$("#ic_card_nm").val('');
	$("#month").val('');
	$("#card_amt").val('');
	$("#ic_card_approve_no").val('');

	is_wcc = "";
	signText = "";
	signT = "";
	//카드결제 변수들


	//BC QR 변수들
	bc_qr_value = "";
	//BC QR 변수들


	recpt_no = "";

	md = "";
	op = "";
	goods = "";

	point_cash = 0;
	point_aksincard = 0;
	point_aksamcard = 0;
	point_card = 0;
	point_coupon = 0;
	point_mcoupon = 0;
	point_akkbcard = 0;
	point_akwbcard = 0;

	pay_akcoupon = 0; //뭔지모르겠다.
	cardDanMemReset();
}




































































































//결제 취소 함수
var cancel_sale_ymd = "";
var cancle_pos_no = "";
var cancel_recpt_pos_no = "";
var cancel_recpt_no = "";
var cancel_reason = "";
var cancel_new_recpt_no = "";

var cancel_regis_fee = 0;
var cancel_food_fee = 0;
var cancel_enuri_amt = 0;
var cancel_net_sale_amt = 0;
var cancel_trade_all_amt = 0;
var cancel_card_amt = 0;

var cancel_ic_approve_no = "";

var cancel_akmem_card_no = "";
var cancel_akmem_approve_no = "";
var cancel_akmem_card_use = "";
var cancel_akmem_custno_use = "";
var cancel_akmem_point_amt = 0;

var cancel_ls_akmem_send_str = "";

var cancel_akmem_total_point = "";

var cancel_akmem_use_min_point = "";
var cancel_akmem_use_max_point = "";
var cancel_akmem_use_hurdle = "";
var cancel_akmem_cust_grade = "";
var cancel_akmem_pswd = "";
var cancel_akmem_sApprovNo = "";
var cancel_akmem_cust_no = "";

var cancel_akmem_resp_no = "";
var cancel_akmem_resp_msg = "";
var cancel_akmem_family_cust_no = "";
var cancel_akmem_cust_name = "";
var cancel_akmem_cust_level = "";
var cancel_akmem_regi_card_yn = "";
var cancel_akmem_regi_card_no = "";
var cancel_akmem_use_yn = "";
var cancel_akmem_recpt_point = 0;

var cancel_mc_approve_no = ""; //결제당시 승인번호. 취소시 사용
var cancel_proc_mc_approve_no = ""; //취소당시 승인번호. 영수증출력시 사용
var cancel_proc_remain_amt = ""; //취소시 잔액. 영수증출력시 사용
var cancle_proc_point_approve_no = "";
var cancle_proc_point_save_approve_no_pos = "";
var cancle_proc_point_save_approve_point = "";
var cancel_mc_card_amt = "";


var cancel_result = ""; //취소 결과
var cancel_mc_result_cd = ""; //mc 취소 결과
var subject_result = "";

function posCancel(){
	cancle_pos_no = pos_no;
	posCheck();
	if(check === -1) {
		return;
	}	
	chargeCheck();
	var chkCnt = 0;
	$("[name='pere_idx']").each(function() 
	{
		if($(this).is(":checked") )
		{
			chkCnt ++;
		}
	});
	if(chkCnt == 0)
	{
		alert("취소할 결제를 선택해주세요.");
		return;
	}
	$("[name='pere_idx']").each(function() 
	{
		if($(this).is(":checked") )
		{
			var cancel_idx = $(this).attr('id').replace("pere_idx", "cancel_idx");
			cancel_reason = $("#"+cancel_idx).val(); //취소사유
			
			var result = JSON.parse(decodeURI($(this).val()));
			
			cancel_sale_ymd = result.SALE_YMD;
			cancel_recpt_pos_no = result.POS_NO;
			cancel_recpt_no = result.RECPT_NO;
			cancel_akmem_point_amt = result.AKMEM_USE_POINT;
			cancel_akmem_card_no = result.AKMEM_CARD_NO;
			
			cancel_regis_fee = result.REGIS_FEE;
			cancel_food_fee = result.FOOD_FEE;
			cancel_enuri_amt = result.ENURI_AMT;
			cancel_trade_all_amt = result.TRADE_ALL_AMT;
			cancel_net_sale_amt = result.NET_SALE_AMT;
			cancel_akmem_recpt_point = result.AKMEM_RECPT_POINT;
			
			cancel_ic_approve_no = result.APPROVE_NO;
			
			cancel_mc_approve_no = result.MC_APPROVE_NO;
			cancel_mc_card_amt = result.MC_CARD_AMT;
			
			//인터넷POS마감로직
			if(result.POS_NO == "070013") {
				$.ajax({
					type : "POST", 
					url : "/member/lect/posEndCheck",
					dataType : "text",
					async:false,
					cache : false,
					data : 
					{
						store : $("#selBranch").val(),
						pos_no : result.POS_NO
					},
					error : function() 
					{
						console.log("AJAX ERROR");
					},
					success : function(data) 
					{
						isSuc = true;
						if(data == "Y") {
							alert("인터넷 POS 마감 되었습니다.");
							isSuc = false;
						}
					}
				});
				if(!isSuc)
				{
					return;
				}
			}
			//모바일 POS마감로직
			if(result.POS_NO == "070014") {
				
				$.ajax({
					type : "POST", 
					url : "/member/lect/posEndCheck",
					dataType : "text",
					async:false,
					cache : false,
					data : 
					{
						store : $("#selBranch").val(),
						pos_no : result.POS_NO
					},
					error : function() 
					{
						console.log("AJAX ERROR");
					},
					success : function(data) 
					{
						isSuc = true;
						if(data == "Y") {
							alert("모바일 POS 마감 되었습니다.");
							isSuc = false;
						}
					}
				});
				if(!isSuc)
				{
					return;
				}
				
			}
			var posOpenYn = pos_open_yn;
			var posEndYn = pos_end_yn;
			
			if(result.IN_TYPE == "취소") {
				alert("이미 취소된 강좌입니다.");
				return;
			}
			
			/* 2014.09.07 DCC 개발로 인해 접수일자가 9/16일 이전이면서 카드사 코드가 941, 992, 993 일 경우 취소 안되게 변경 */
			if(result.SALE_YMD < "20140916" && (result.CARD_CORP_NO == '941'  || result.CARD_CORP_NO == '992' || result.CARD_CORP_NO == '993'))
			{
				alert("카드취소불가/자금팀문의");
				return;
			}
			
			if(posOpenYn == null || posOpenYn == "" || posOpenYn == "N") {
				alert("준비금 등록을 먼저 하십시요!");
				return;
			}
			
			if(posEndYn == "Y") {
				alert("이미 POS마감 되었습니다!");
				return;
			}
//			if(isGridEmpty(gridMain)) {
//				alert("거래내역을 먼저 조회하시기 바랍니다.")
//				return;
//			} else {
//				if(gridMain.row < 1) {
//					alert("취소할 작업을 먼저 선택하세요");
//					return;
//				}
//			}
//			if(isGridEmpty(gridSub)) {
//				alert("수강강좌내역을 조회하시기 바랍니다.")
//				return;
//			}
			/*					// ★☆ 2014.07 강석민 PG사 취소시 알림 추후 시스템 개발 
			if(result.TID.length > 1)
			{
				alert("해당 주문건은 KCP 건으로 10/23일부터 자동 취소 됩니다. admin8.kcp.co.kr");
			}*/
			
//			if(cancel_reason == null || cancel_reason == '') {
//				alert("취소사유를 선택해 주십시요.");
//				return;
//			}
			
//			if(cancel_fg == "btn_discretion"){//강제취소일 때
//				if(!(daydiff(result.SALE_YMD) < 90 && getGridColumnNameValue(gridMain, gridMain.row, "card_no") != "" )
//						|| (getGridColumnNameValue(gridMain, gridMain.row, "card_type") == "Check/선불카드" || getSystemDate().format("yyyymmdd") == result.SALE_YMD || result.CARD_CORP_NO == "555" || result.CARD_CORP_NO == "666")
//						|| result.TID != ""){
//					alert("[매출취소]버튼으로 처리부탁드립니다.");
//					return;						
//				}
//			}else{ //매출취소일때		
				
				//bc qr 체크를 위해 추가 cmc  매출취소 버튼 눌렀을 시
				var card_data_fg = result.CARD_FG;
				var bc_qr_data = bc_qr_value;
				
				if( card_data_fg == "Q" || card_data_fg == "q") {	//bcqr 일 시 에는 카드센싱 필요 x
					if (bc_qr_data == null || bc_qr_data == "") {	//데이터가 없으면, qr 코드 가져 와야 함.
						alert("해당 건은 BCQR 코드로 매출이 일어난 건 입니다. QR코드 스캔을 해주세요.");
						return;
					}
					
					if(bc_qr_data == "Error"){
						alert("Qr 코드가 정상적이지 않습니다. 재진행 바랍니다.");
						return;
					}
					
					if( bc_qr_data == null || bc_qr_data == "" ){
						alert("에러발생. QR코드 스캔 진행을 다시 해 주시기 바랍니다.");
						return;
					}
					
					//QR코드를 스캔했기때문에 해당변수는 bcQrData 에서 처리한다.
					
//					var qr_track2 = bc_qr_data.substr(6, 40);														// track2 데이터
//					var qr_card_no_real = qr_track2.substr(0, qr_track2.indexOf("="));			// 리얼 카드 번호
//					var qr_card_no =  qr_card_no_real.substring(0,6) + "******" +  qr_card_no_real.substring(12); 
//					
//					model.setValue("/root/data/akgift_data/akgift_cardno",		qr_card_no);			// 화면에 보이는 카드번호는 마스킹 처리
//					model.setValue("/root/data/approve_data/card_no_qr",	qr_card_no_real);
//					model.setValue("/root/data/akgift_data/hide_card_no",		qr_card_no_real);
//					model.setValue("/root/req/card_no", qr_card_no_real);								
////					model.refresh();
//					
//					qr_track2 = "";
//					qr_card_no =  "";
//					qr_card_no_real = "";
				}
//				else { // bc qr 이 아닐 시 일반 로직 cmc
//					if(result.CARD_CORP_NO != "" && result.TID == ""
//						&& (ic_card_no == "" || ic_card_no == null )){//여전법 이후 2018.02.13 최보성 카드센싱 필수
//						akgift_card_in.dispatch("onclick");
//						
//						if(ic_card_no == "" || ic_card_no == null ){
//							return;
//						}	
//					}
//				}
				if(daydiff(result.SALE_YMD) <= 90 
						&& nullChk(result.CARD_CORP_NO) != "" 
							&& nullChk(result.TID) == ""){
					if(bc_qr_data == null || bc_qr_data == "") {
						// bc qr 이 아닐 시 에 기존 로직 cmc (BCQR 일 시 복호화 필요 X)
						//카드 번호 복호화 전문
						encCardNoSendStr('card');
					}
					else {
						
					}
					//영수증 카드 번호체크
					
					$.ajax({
	            		type : "POST", 
	            		url : "/member/lect/getApproveCardCnt",
	            		dataType : "text",
	            		async:false,
	            		cache : false,
	            		data : 
	            		{
	            			encCardNo_send_str : ic_card_encCardNo_send_str,
	            			store : $("#selBranch").val(),
	            			card_fg : result.CARD_FG,
	            			sale_ymd : result.SALE_YMD,
	            			recpt_no : result.RECPT_NO,
	            			pos_no : result.POS_NO
	            		},
	            		error : function() 
	            		{
	            			console.log("AJAX ERROR");
	            		},
	            		success : function(data) 
	            		{
	            			isSuc = true;
	            			if(data < 1)
            				{
	            				alert("입력된 카드번호와 거래된 카드번호가 상이합니다.");
	            				isSuc = false;
            				}
	            		}
	            	});
					if(!isSuc)
					{
						return;
					}
				}
				var inCard= ic_card_no;
				var gridCard = result.CARD_NO;
				if((nullChk(result.CARD_NO) != "" && nullChk(result.TID) == "") 
						&& !(inCard.substring(0,6) == gridCard.substring(0,6) && inCard.substring(12) == gridCard.substring(12))
				)
				{//여전법 이후 2018.02.13 최보성 카드센싱 필수
					alert("취소처리할 신용카드와 일치하지 않습니다.");
					return;
				}	
//			} 	
			
			
			//포인트 사은품 지급여부 체크 (추가 080721 by CH)
			//임시로 막아놈 CH
			//	if(point_gift_yn() == "Y"){ alert("해당 영수증으로 [포인트 사은품]을 지급받으셨습니다. \n\n(드림카드 데스크/플러스 데스크)를 방문하셔서 사은품 반납 후 취소 하실수 있습니다."); return ;}
			
			var sale_ymd, pos_no, recpt_no, period;
			
			sale_ymd	=	result.SALE_YMD;	
			pos_no		=	result.POS_NO;	
			recpt_no	=	result.RECPT_NO;
			period		=	result.PERIOD;
			tid			=	nullChk(result.TID);
			var conFMsg = "";
				conFMsg = "접수일자 : " + sale_ymd.substring(0, 4) + "년 " + sale_ymd.substring(4, 6) + "월 " +  + sale_ymd.substring(6, 8) + "일"  +
				"\n\nPOS번호 : " + pos_no + 
				"\n\n영 수 증  : " + recpt_no +
				"\n\n기      수 : " + period + "기" + 
				"\n\n해당 수강신청을 취소하시겠습니까?";
			if(confirm(conFMsg)) {
				//042기 이상 기수에서 사은품 로직 구동.
				//if(parseInt(result.PERIOD.substring(1, 3)) > 41) {
				//2019.05.27 ljs 마일리지 -1000점 이상인 경우 매출취소불가하도록 처리 START
				
				var ls_akmem_recpt_point = result.AKMEM_RECPT_POINT;
				var ls_akmem_use_point   = result.AKMEM_USE_POINT;
				var ls_akmem_card_no     = result.AKMEM_CARD_NO;
				
				if(ls_akmem_recpt_point == null || ls_akmem_recpt_point == "")
				{
					ls_akmem_recpt_point = 0;
				}
				
				if(ls_akmem_use_point == null || ls_akmem_use_point == "")
				{
					ls_akmem_use_point = 0;
				}
				
				var remainPoint = parseFloat(ls_akmem_use_point - ls_akmem_recpt_point);
				
				//alert("[TEST minPoint1] ls_akmem_recpt_point[" + ls_akmem_recpt_point + "] ls_akmem_use_point[" + ls_akmem_use_point 
				//	  + "] ls_akmem_card_no[" + ls_akmem_card_no + "] remainPoint[" + remainPoint + "]");
				
				if( ls_akmem_card_no != null  && ls_akmem_card_no != "" && remainPoint < 0)
				{
					akmem_card_no = ls_akmem_card_no;
					
					var send_data = AKmem_Run('XB241S','READ'); // 카드멤버쉽 전문 생성 여전법이후 , MS = XA241S, IC = XB241S 전문 IC사용
					
					//카드승인 Transaction
					
					
					
					$.ajax({
						type : "POST", 
						url : "/member/lect/GetAkmemCustInfo",
						dataType : "text",
						async:false,
						cache : false,
						data : 
						{
							hq : '00',
							store : $("#selBranch").val(),
							send_data : send_data
						},
						error : function() 
						{
							console.log("AJAX ERROR");
						},
						success : function(data) 
						{
							isSuc = true;
							var result_this = JSON.parse(data);
							if(result_this.sApprovNo != '00')
							{
								alert("[포인트조회 오류!]"+result_this.sMessage);
							}
							else
							{
								var ls_akmem_total_point =  result_this.AKmem_total_point;
								
								if(ls_akmem_total_point == null || ls_akmem_total_point == "")
								{
									ls_akmem_total_point = 0;
								}									
								
								var totRemainPoint = parseFloat(ls_akmem_total_point) + parseFloat(ls_akmem_use_point) - parseFloat(ls_akmem_recpt_point);
								var minPoint = -1000;
								
								//alert("[TEST minPoint2] ls_akmem_total_point[" + ls_akmem_total_point + "] totRemainPoint [" + totRemainPoint
								//     + "] ls_akmem_use_point[" + ls_akmem_use_point + "] ls_akmem_recpt_point[" + ls_akmem_recpt_point + "]");
								
								if(totRemainPoint <= minPoint)
								{
									alert("마일리지 부족으로 매출취소 불가하니, AK멤버스센터에 문의하세요.");
									isSuc = false;									
								}
								
								
								
								cancel_akmem_total_point = result_this.AKmem_total_point;
								
								cancel_akmem_use_min_point = result_this.AKmem_Use_Min_Point;
								cancel_akmem_use_max_point = result_this.AKmem_Use_Max_Point;
								cancel_akmem_use_hurdle = result_this.AKmem_Use_hurdle;
								cancel_akmem_cust_grade = result_this.AKmem_CustGrade;
								cancel_akmem_pswd = result_this.AKmem_Pswd;
								cancel_akmem_sApprovNo = result_this.sApprovNo;
								cancel_akmem_cust_no = result_this.AKmem_CustNo;
				                
								cancel_akmem_resp_no = result_this.AKmem_Resp_No;
								cancel_akmem_resp_msg = result_this.AKmem_Resp_Msg;
								cancel_akmem_card_no = result_this.AKmem_CardNo;
								cancel_akmem_family_cust_no = result_this.AKmem_Family_CustNo;
								cancel_akmem_cust_name = result_this.AKmem_CustName;
								cancel_akmem_cust_level = result_this.AKmem_CustLevel;
								cancel_akmem_regi_card_yn = result_this.AKmem_RegiCard_yn;
								cancel_akmem_regi_card_no = result_this.AKmem_RegiCard_no;
								cancel_akmem_use_yn = result_this.AKmem_use_yn;
							}
						}
					});
					if(!isSuc)
					{
						return;
					}
					
				}
				//2019.05.27 ljs 마일리지 -1000점 이상인 경우 매출취소불가하도록 처리 END
				
				//수강신청 취소
				
				
				
				$.ajax({
					type : "POST", 
					url : "/member/lect/getRecptNoByCancel",
					dataType : "text",
					async:false,
					cache : false,
					data : 
					{
						store : $("#selBranch").val(),
						pos_no : cancle_pos_no,
						recpt_pos_no : result.POS_NO
					},
					error : function() 
					{
						console.log("AJAX ERROR");
					},
					success : function(data) 
					{
						var result_this = JSON.parse(data);
						cancel_new_recpt_no = result_this[0].NEW_RECPT_NO;
					}
				});
				$.ajax({
					type : "POST", 
					url : "/member/lect/getTotalPointSendList",
					dataType : "text",
					async:false,
					cache : false,
					data : 
					{
						store : $("#selBranch").val(),
						sale_ymd : result.SALE_YMD,
						pos_no : result.pos_no,
						recpt_no : result.recpt_no
					},
					error : function() 
					{
						console.log("AJAX ERROR");
					},
					success : function(data) 
					{
						var result_this = JSON.parse(data);
						if(result_this.length > 0)
						{
							cancel_akmem_approve_no = result_this[0].CARD_NO;
							cancel_akmem_card_use = result_this[0].CARD_NO_USE;
							cancel_akmem_custno_use = result_this[0].AKMEM_CUSTNO_USE;
							
							
							if( cancel_akmem_approve_no != ""){
								var usePointAmt = result_this[0].AKMEM_USE_POINT;
								if(usePointAmt != null && usePointAmt != "" && usePointAmt != "0" )
								{ 
									var reTryYn = "N";
									if(AKmem_pointUseCancel() != '0')
									{
										reTryYn = "Y";
										//alert('[TEST]사용마일리지 누적 오류발생! 2차 시도 하겠습니다.');
									}
									
									if(reTryYn == "Y")
									{
										var ret = AKmem_pointUseCancel();
										if(ret != '0')
										{
											reTryYn = "Y";
											//alert('[TEST]사용마일리지 누적 오류발생! 3차 시도 하겠습니다.');
										}
										else
										{
											reTryYn = "N";
										}
									}
									
									if(reTryYn == "Y")
									{
										var ret = AKmem_pointUseCancel();
										if(ret != '0')
										{
											alert('사용마일리지 누적 오류발생! 전산실로 연락 바랍니다.');
											//alert("매출취소 처리되지 않았습니다.");
											//return;  //2019.05.30  ljs 현업요청 : 사용마일리지 전문오류시에도 매출취소 가능하도록 처리
										}
										else
										{
											reTryYn = "N";
										}										
									}
									//2019.05.28 ljs 전문실패시 3번 시도 END
								}
								var akmemRecptPoint = cancel_akmem_recpt_point;
								if(akmemRecptPoint != null && akmemRecptPoint != "" && akmemRecptPoint != "0" )
								{
//2019.05.28 ljs 전문실패시 3번 시도 START
//								if(AKmem_pointCancel() != '0'){
//									alert('마일리지 차감에서 오류발생! 전산실로 연락 바랍니다.');  //2019.04.10 ljs : 포인트 -> 마일리지 명칭변경
//								}									
									
									var reTryYn = "N";
									if(AKmem_pointCancel() != '0')
									{
										reTryYn = "Y";
										//alert('[TEST]마일리지 차감 오류발생! 2차 시도 하겠습니다.');
									}
									
									if(reTryYn == "Y")
									{
										var ret = AKmem_pointCancel();
										if(ret != '0')
										{
											reTryYn = "Y";
											//alert('[TEST]마일리지 차감 오류발생! 3차 시도 하겠습니다.');
										}
										else
										{
											reTryYn = "N";
										}
									}
									
									if(reTryYn == "Y")
									{
										var ret = AKmem_pointCancel();
										if(ret != '0')
										{
											alert('마일리지 차감 오류발생! 전산실로 연락 바랍니다.');  //2019.04.10 ljs : 포인트 -> 마일리지 명칭변경
										}
										else
										{
											reTryYn = "N";
										}										
									}
//2019.05.28 ljs 전문실패시 3번 시도 END								
								}
							}
						}
					}
				});
				
				
				// 모바일상품권 승인번호가 있을 경우, 모바일상품권 취소전문 송신
				var ls_mc_approve_no 	= nullChk(result.MC_APPROVE_NO);
				var ls_mc_card_amt 		= nullChk(result.MC_CARD_AMT);
				
				if (ls_mc_approve_no != "" && ls_mc_card_amt != "" && ls_mc_approve_no != null && ls_mc_card_amt != null) {
					// 해당 로직 안타서(데이터가 없는데 실행 되버림) 수정 해봄 cmc
					//if (ls_mc_approve_no != "" && ls_mc_card_amt != "") 
					cancelMobileCoupon();
				}
				// 카드 승인번호가 있을 경우, 카드매출 취소전문 송신
				var ls_approve_no 	= result.APPROVE_NO;
				
				if(ls_approve_no != null && ls_approve_no != '') {
					// 당일매출 당일취소이면 승인취소	
					
					//AK기프트(555),홈플러스(666)카드 취소 로직추가 (당일이전 매출도 취소가능/실물 카드센싱시만 취소가능)
					var ls_card_gubun 	= ic_card_hide_card_gubun;
					var ls_card_fg 		= result.CARD_CORP_NO;
					var ls_van_fg 		= result.CARD_VAN_FG;
					
					/*   2014.09 소스 백업 비교용 추후 삭제 가능 승인 즉시 취소 개발
					  if ((getSystemDate().format("yyyymmdd") == result.SALE_YMD) || ((ls_card_fg == "555")  || ( ls_card_fg== "666") ) ) {     
					    
					    		if (((ls_card_fg == "555")||(ls_card_fg == "666") ) 
					    		&& ( (trim(ls_card_gubun) == "" ) || (trim(ls_card_gubun)== null )  ) ) {
					    	  		alert("AK기프트카드/홈플러스(선불카드)는 [카드등록]후 카드센싱이 되어야 매출취소 가능합니다. 실물카드 필요~!!!");
									return;
						    	  }else if (((ls_card_fg == "555") ||(ls_card_fg== "666") )
						    	  		&& ( getGridColumnNameValue(gridMain, gridMain.row, "card_no") !=  model.getValue("/root/data/akgift_data/akgift_cardno ")) ) {
						    	  			alert("취소할 카드번호와 실물카드번호가 불일치합니다.  동일한 카드만 취소가능~!!!");
		 								return;
						    	  }else{				
			    	  				// ★☆ TID가 없을 경우에만 실행 2014.07
			    	  				if(tid == null || tid == "")
			    	  				{
						    			approveCheckCard();
			    	  				}else{
			    	  					autoSign();
			    	  				}
						    	  }
							   }else {
								    autoSign();
							   }
					 */
					
					if (((ls_card_fg == "555")||(ls_card_fg == "666") ) && ( (trim(ls_card_gubun) == "" ) || (trim(ls_card_gubun)== null )  ) ) {
						alert("AK기프트카드/홈플러스(선불카드)는 [카드등록]후 카드센싱이 되어야 매출취소 가능합니다. 실물카드 필요~!!!");
						return;
					} else if (((ls_card_fg == "555") ||(ls_card_fg== "666") ) && ( result.CARD_NO !=  ic_card_no) ) {
						alert("취소할 카드번호와 실물카드번호가 불일치합니다.  동일한 카드만 취소가능~!!!");
						return;
					} else {
						// 555,666 이 아닌 카드 취소시 
						// ★☆ TID가 없을 경우에만 실행 2014.07
						var card_type = result.CARD_TYPE;
//						autoSign('cancel');
						if(signText == "1")
						{
							signT = signText;
						}
						else
						{
							signT = ic_card_sign;
							signText = ic_card_sign;
						}
						if(signText == null || signText == undefined || trim(signText) === ""){
							alert("사인이 되지 않았습니다. \n[매출취소]버튼을 다시 눌러주시길 바랍니다.");
							return;
						}
						if(tid == null || tid == ""){
							// 2014.10 BC카드 개발 후 들어내면 됨 
							//if(ls_card_fg != "031" || getSystemDate().format("yyyymmdd") == result.SALE_YMD)
							// 체크 선불 카드 이건, 결제일 취소일이 동일한 경우 취소 승인 전문 발송
							// check 1. 신용카드 당일 취소
							// check2. 체크카드 결제 건 환불
							
							if(card_type == "Check/선불카드" || getNow() == result.SALE_YMD || ls_card_fg == "555" || ls_card_fg == "666"){
								approveCheckCard(result.CARD_NO, result.INST_MM, result.CARD_AMT, result.CARD_CORP_NO, result.APPROVE_NO, result.CARD_VAN_FG, result.CARD_FG);
							}
							//					else {
							//						autoSign();
							//
							//					}  
							
						}else{
							// PG 자동 취소 개발  2014.10 주석 해제 
							
							
							$.ajax({
								type : "POST", 
								url : "/member/lect/cancel_pg_proc",
								dataType : "text",
								async:false,
								cache : false,
								data : 
								{
									store : result.STORE,
									period : result.PERIOD,
									sale_ymd : result.SALE_YMD,
									recpt_no : result.RECPT_NO,
									pos_no_ori : result.POS_NO,
									tid : result.TID,
									card_corp_no : result.CARD_CORP_NO
								},
								error : function() 
								{
									console.log("AJAX ERROR");
								},
								success : function(data) 
								{
									isSuc = true;
									if(data != "SUCCESS"){
										alert("PG 거래건으로 취소가 정상적으로 되지 않았습니다. \n전산실 문의 및 수동 취소 필수");
										isSuc = false;
									}
								}
							});
							if(!isSuc)
							{
								return;
							}
							
							
						}
					}
				}
				// LG,신한통합관련 취소시 카드 prefix체크 정보 넘김(08.08.12 해선)
				//var ls_card_corp_no;
				//ls_card_corp_no = f_card_gubun_nm('origin_seq', getGridColumnNameValue(gridMain, gridMain.row, "card_no")) ;		
				
				// 모바일 상품권 취소 승인번호 저장을 위해 변수지정
				var ls_mc_approve_no 		= (cancel_mc_approve_no == null || trim(cancel_mc_approve_no) == "") ? ls_mc_approve_no : cancel_mc_approve_no;
				
				//주차관련 대표번호 셋팅(2018.3.20)
				
				
//				model.setValue("/root/req/total_show_amt",	getGridColumnNameValue(gridMain, gridMain.row, "trade_all_amt")); 
				
				var card_cancel_fail = cancel_result;
				card_cancel_fail = card_cancel_fail != "1" ? 0 : 1;
				
				var mc_card_cancel_fail = cancel_mc_result_cd;
				mc_card_cancel_fail = mc_card_cancel_fail == "00" ? 0 : 1;
				$.ajax({
					type : "POST", 
					url : "/member/lect/cancel_proc",
					dataType : "text",
					async:false,
					cache : false,
					data : 
					{
						store : $("#selBranch").val(),
						pos_no : cancle_pos_no,
						recpt_pos_no : result.POS_NO,
						period : result.PERIOD,
						sale_ymd : result.SALE_YMD,
						recpt_no : result.RECPT_NO,
						period : result.PERIOD,
						pay_fg : result.PAY_FG,
						cancel_rmk : result.CANCEL_RMK,
						approve_no : result.APPROVE_NO,
						mc_approve_no : result.MC_APPROVE_NO,
						card_amt : result.CARD_AMT,
						mc_card_amt : result.MC_CARD_AMT,
						akmem_use_point : result.AKMEM_USE_POINT,
						sign : signT,
						result : cancel_result,
						card_cancel_fail : card_cancel_fail,
						mc_card_cancel_fail : mc_card_cancel_fail,
						cust_no : cancel_akmem_cust_no
						
					},
					error : function() 
					{
						console.log("AJAX ERROR");
					},
					success : function(data) 
					{
						var aprv_no 		= result.APRV_NO;
						var ls_card_fg 		= result.CARD_CORP_NO;
						var ls_cash_amt 	= Number(result.CASH_AMT);
						var ls_coupon_amt 	= Number(result.COUPON_AMT);
						var ls_mc_card_amt 	= Number(result.MC_CARD_AMT);
						var ls_card_amt 	= Number(result.CARD_AMT);
						
						//2019.04.10 ljs 현금영수증제외대상금액 추가 START
						var ls_cashrec_ext_amt = Number(result.CASHREC_EXT_AMT);
						//(asis : 모든 쿠폰금액, tobe : 현금영수증대상금액만 적용)
						ls_cash_amt			+= ls_coupon_amt + ls_mc_card_amt - ls_cashrec_ext_amt;
						//2019.04.10 ljs 현금영수증제외대상금액 추가 END
						
						var ls_send_amt 	= ls_cash_amt + ls_card_amt;
						
						if(aprv_no != null && aprv_no != "" && aprv_no != "N") {
							approveCheckCancel(result.CARD_CORP_NO, result.CASH_AMT, result.CARD_AMT, result.COUPON_AMT, result.MC_CARD_AMT, result.CASHREC_EXT_AMT,result.ID_FG,result.ID_NO,result.ISSUE_FG,result.VAN_FG,result.APRV_NO,result.POS_NO);
							//현금취소승인작업 저장 
							$.ajax({
								type : "POST", 
								url : "/member/lect/cash_cancel_proc",
								dataType : "text",
								async:false,
								cache : false,
								data : 
								{
									store : $("#selBranch").val(),
									recpt_pos_no : cancel_recpt_pos_no,
									pos_no : cancle_pos_no,
									new_recpt_no : cancel_new_recpt_no,
									cash_amt : result.CASH_AMT,
									repay_amt : result.CAHGNE,
									issue_fg : result.ISSUE_FG,
									id_fg : result.ID_FG,
									id_no : result.ID_NO,
									approve_no : cash_approve_no,
									van_fg : result.VAN_FG
									
								},
								error : function() 
								{
									console.log("AJAX ERROR");
								},
								success : function(data) 
								{
								}
							});
						}
						alert("매출취소가 완료되었습니다.");
						dataReset(); //변수 초기화
					}
				});
			}
		}
	});

	
}
//인증심사 T-026 : 카드리더기 무결성 점검 수행 여부 확인 (무결성 검증 실패 시 대응 방안)
function posCheck()
{
	if(pos_no == "" || pos_no == null) {
		alert("해당IP는 POS번호가 등록되어 있지 않습니다.\nIP관리에서 POS번호를 등록한 후 사용하세요");
		return check = -1;
	}
	
	var card_chk = reader_integrity;
	if(card_chk != "G0") {
		alert("IC단말기 무결성 검사가 정상적으로 수행되지 않았습니다.\n");
		return check = -1;
	}
	return check = 0;
}

var pos_open_yn = "";
var pos_end_yn = "";
function chargeCheck()
{
	$.ajax({
		type : "POST", 
		url : "/member/lect/chargeCheck",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			pos_no : pos_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			if(data != "")
			{
				var result = JSON.parse(data);
				pos_open_yn = result.POS_OPEN_YN;
				pos_end_yn = result.POS_END_YN;
			}
		}
	});
}
function AKmem_pointUseCancel() {
	//2019.06.25 ljs 적립/사용 카드번호가 다른케이스 추가
	
	var send_data = AKmem_Run('XB243S','CANCEL');   //2019.05.22  ljs XA243S --> XB243S 변경
//	cancel_akmem_point_amt = 0;  //BAPTCATB.card_amt 적용시 사용포인트 빼주는 부분 처리를 위해
	cancel_ls_akmem_send_str = send_data;
	
	//포인트 사용취소 요청 Transaction
	var ret_val = -1;
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetAkmemCustInfo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			hq : '00',
			store : $("#selBranch").val(),
			send_data : send_data,
			akmem_encCardNo_send_str : akmem_card_encCardNo_send_str,
			
			pos_no : pos_no,
			recpt_no : cancel_new_recpt_no,
			
			
			total_pay : cancel_trade_all_amt,
			total_enuri_amt : cancel_enuri_amt,
			total_regis_fee : cancel_net_sale_amt,
			total_show_amt : cancel_trade_all_amt,
			
			akmem_card_no : cancel_akmem_card_no,
			akmem_point_amt : cancel_akmem_point_amt
	
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			if(result.sApprovNo != '00')
			{
				alert(result.sMessage);
				ret_val = -1;
			}
			else
			{
				ret_val = 0;
			}
		}
	});
	return ret_val;
}
//AKmembers Point USE Cancel 포인트 사용취소 END  (2019.04.10 ljs)

function AKmem_pointCancel() {
	//2019.06.25 ljs 적립/사용 카드번호가 다른케이스 추가
	var send_data = AKmem_Run('XB242S','CANCEL');   //2019.05.22  ljs XA242S --> XB242S 변경
//	model.makeValue("/root/req/akmem_point_amt", "0");  //2019.04.10 ljs 사용마일리지 추가 : BAPTCATB.card_amt 적용시 사용포인트 빼주는 부분 처리를 위해
	cancel_ls_akmem_send_str = send_data;
	
	//포인트 적립취소 요청 Transaction
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetAkmemCustInfo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			hq : '00',
			store : $("#selBranch").val(),
			send_data : send_data,
			akmem_encCardNo_send_str : akmem_card_encCardNo_send_str,
			
			pos_no : pos_no,
			recpt_no : cancel_new_recpt_no,
			
			
			total_pay : cancel_trade_all_amt,
			total_enuri_amt : cancel_enuri_amt,
			total_regis_fee : cancel_net_sale_amt,
			total_show_amt : cancel_trade_all_amt,
			
			akmem_card_no : cancel_akmem_card_no,
			akmem_point_amt : cancel_akmem_point_amt
	
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			cancle_proc_point_approve_no = result.sApproveNo;
			cancle_proc_point_save_approve_no_pos = result.AKmem_SaveApproveNo_POS;
			cancle_proc_point_save_approve_point = result.AKmem_SaveApprove_Point;
			if(result.sApprovNo != '00')
			{
				alert(result.sMessage);
				return -1;
			}
			else
			{
				return 0;
			}
		}
	});
	
}


function approveCheckCard(card_no, inst_mm, card_amt, card_corp_no, approve_no, card_van_fg, card_fg) {
	
	var ls_send_programID		= "";
	var ls_receive_programID	= "";
	var KFTC_TERM_ID			= "9047000000";
	var NICE_TERM_ID			= "9540030001";
	var KICC_TERM_ID			= "104504";
	var s = 0;
	

	var ls_card_no     		=	card_no;
	var ls_halbu_no    		=	inst_mm;
	var ls_amt         		=	card_amt;
	var ls_card_corp_cd		=	card_corp_no;
	var ls_approve_no 		=	approve_no;
	var amt         		=   card_amt.toString();
	
	s						= 11 - amt.length;
	var ls_amt 				= fill("0", s) + amt;
	 
	// 유효기간 6자리 변경 (10.10.26) DESK 4자리(월+년) WEB 6자리(년4+월)로 되어있어 통일함
	// WEB-> DESK 취소시 유효기간 자리수때문에 승인취소 일부 불가(비씨,국민) -유효기간경과
	// var ls_card_data1 	= trim(ls_card_no) + "=" + is_valid_date.substring(2, 4) + is_valid_date.substring(0, 2);
	
	var ls_card_data1 = "";
	var ls_card_gubun = "";
	
	var is_wcc = "A"; // 거래방식 @ : Manual, A : Swipe, P : Payon, , I : IC, F : Fallback, T : 거래고유번호
	var pin_Data = ""; //PIN_DATA[4]
	
	var trsnGubun1 = ic_card_cardFlag1; //RF FLAG 첫째자리 ->'R' (RF거래), 'I'(IR 거래) 'M' (MS거래) 'C' (IC거래) 
	var trsnGubun2 = ic_card_cardFlag2; //RF FLAG 둘째자리 ->SKT : 'S', KTF : 'K' , LGT : 'L' (RF거래/이통사구분), 'I'(IR 거래) 'F' (MS거래) '' (IC거래)
	var mbCorp  = "";
	var cardTp  = "";
	var rfCdKnd = "";
	//var posCertiNo = "####AKWEBPOS1001";//POSSW식별번호[16]
	var posCertiNo = "####AKWEBPOS3001";//cmc 식별번호 update
	var fbReason = ""; //Fallback사유[2]
	var emvYN = "Y";
	var emvReqdata = ic_card_emv.replace("$",""); //EMV요청DATA[400]
	var emvReqdata2 = ic_card_emv.replace("$",""); //EMV요청DATA[400]
	//cmc - 카드사 전문 세팅 시작
	var card_data = "";
	var key_card_data = "";
	var is_KB_card_data = "";
	var is_BC_card_data = "";
	var is_SH_card_data = "";
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 벤사키
	if(ic_card_vanCode == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "140000") {
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "140000" ){
		card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 유통키 
	if(ic_card_vanCode == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "200300") {
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "200300" ){
		key_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		key_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 국민 
	if(ic_card_vanCode == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "944541") {
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "944541" ){
		is_KB_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		is_KB_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 비씨
	if(ic_card_vanCode == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "942150") {
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "942150" ){
		is_BC_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		is_BC_card_data = "";
	}
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 신한
	if(ic_card_vanCode == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun
							+ ic_card_ksn
							+ ic_card_encData;
	}
	else if(ic_card_vanCode1 == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun1
							+ ic_card_ksn1
							+ ic_card_encData1;
	}
	else if(ic_card_vanCode2 == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun2
							+ ic_card_ksn2
							+ ic_card_encData2;
	}
	else if(ic_card_vanCode3 == "451842") {
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun3
							+ ic_card_ksn3
							+ ic_card_encData3;
	}
	else if(ic_card_vanCode4 == "451842" ){
		is_SH_card_data = "SECU"
							+ ic_card_modelNo
							+ ic_card_encGubun4
							+ ic_card_ksn4
							+ ic_card_encData4;
	}
	else {
		is_SH_card_data = "";
	}
	
	if(trsnGubun1 == "R" || trsnGubun1 == "I" || is_wcc == "M" ){
		 mbCorp = ic_card_cardFlag2; //+이통사구분[1]
		 cardTp = ic_card_cardFlag3; //+카드방식[1]
		 rfCdKnd = ic_card_cardFlag4; //+RF카드종류[1]	
		
		if(trsnGubun1 == "R"  && ls_card_corp_cd  == "031") {//BCNFC
			ls_send_programID = "NFB71S" ;
		}else if(trsnGubun1 == "R"  && ls_card_corp_cd  == "030000"){//payon
			is_wcc = "P" 
			ls_send_programID = "PYB71S" ;
		}
	}else if(trsnGubun2 == "F"){//MSR 거래시 fb
		is_wcc = "F";
		fbReason = ic_card_fallback_reason; 
		emvYN ="N";
		emvReqdata = "";
	}else if(trsnGubun1 == "M"){
		emvYN ="N";
		is_wcc = "A";
		emvReqdata = "";
	}else{
		
		//cmc12345 - 씨티카드 로직 추가
		if(trsnGubun1 == "C") {
			var citi_check = ic_card_pri_nm;
			
			if( citi_check == "씨티카드" ){
				emvReqdata = emvReqdata.substr(0,10) + "43" + emvReqdata.substring(12);
			}
			else {
			}
		}
		else {
		}
		
		trsnGubun1 = '';
		is_wcc = "I";
	}	
	
	if(trsnGubun1 == "R" && emvReqdata.replace("19454D0000","").length === 0){
		emvYN ="N";
		is_wcc = "A";
	}	
//	if ( is_valid_date.length  == 4 ) {
//		ls_card_data1 = trim(ls_card_no) + "=" + is_valid_date.substring(2, 4) + is_valid_date.substring(0, 2);
//	}else if ( is_valid_date.length  == 6 ){
//		ls_card_data1 	= trim(ls_card_no) + "=" + is_valid_date.substring(2, 4) + is_valid_date.substring(4, 6);
//	}else {
//		alert('전산실 문의!!');
//		model.setValue("/root/req/result", "1");
//	} 여전법이후 유효기간을 쓰지 않음
	
	//AK기프트(555), 홈플러스(666) 카드센싱 유일정보 필요함(2012.01.17)
	if ((ls_card_corp_cd == "555")||(ls_card_corp_cd == "666")) {
		ls_card_gubun = ic_card_hide_card_gubun;
		ls_card_data1 = ls_card_data1 + ls_card_gubun;
	}
	
	var is_card_data  	= f_setfill( ls_card_data1, 37, "R" );
	//var length 			= ls_card_data1.length; 여전법 이전
	var length 			= "098"; // van사 전문 카드번호 데이터 길이
	
	var ls_hq 		= '00';
	var ls_store 	= $("#selBranch").val();
	var ls_pos_no 	= cancel_recpt_pos_no;
//	var ls_pos_no 	= model.getValue("/root/req/pos_no");
	
	var ls_sale_ymd  =  cancel_sale_ymd;
	ls_sale_ymd  = ls_sale_ymd.substring(2, 8) ;
	
	
	//01:KFTC(금융결제원), 02:NICE,   03:KOVAN,    04:SSCARD
	//05:KICC,       06:KOCS,   00:기타(전화승인)
	//여전법 이후
	// 01 KFTC	// 02 NICE	// 03 KOVEN	// 04 SSCARD	// 05 KICC
	// 06 JTNET	// 07 KIS	// 08 SPCN

	var ls_cardvan_fg   =  card_van_fg;
	
	if( ls_cardvan_fg == "01" ) {         // 금결원
	//	ls_send_programID = "CA011S";  
		ls_send_programID = "CB011S";  
	}else if( ls_cardvan_fg == "02") {   // nice   200904 csy  add
		//ls_send_programID = "CA012S";
		ls_send_programID = "CB012S";
	} else if( ls_cardvan_fg == "03") {  // kovan  200904 csy  add
		//ls_send_programID = "CA014S";
		ls_send_programID = "CB014S";
	}else if( ls_cardvan_fg == "05") {   // KICC
		//ls_send_programID = "CA015S";  
		ls_send_programID = "CB015S";  
	}else if( ls_cardvan_fg == "06"){  // KOCES=>JTNET 
		//ls_send_programID = "CA016S";
		ls_send_programID = "CB016S";
	}else if( ls_cardvan_fg == "07") {   // KIS 201612
		//ls_send_programID = "CA017S";
		ls_send_programID = "CB017S";   
	}else if( ls_cardvan_fg == "08") {   // SPCN 201612
		//ls_send_programID = "CA018S";
		ls_send_programID = "CB018S";
	}
	
	if ((ls_card_corp_cd == "555") || (ls_card_corp_cd == "666")) {
		/* 여전법이전
        	//if ($("#selBranch").val() != "03" ) { 	 //분당점외 나머지 지점 경우 
				ls_send_programID		= "XA076S";				
        	//}else {								//분당점 경우 
       		//	ls_send_programID		= "XM091S";
        	//}
			
		*/	

			ls_send_programID		= "XB076S";				 //여전법 이후 
	}
		
	//----------------------------------------------//
	//    카드 승인조회 로직                     		    //
	//----------------------------------------------//
	//여전법 이전 var product = ls_send_programID + "0000" + space(32);
	var product = ls_send_programID + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
	var ls_gubun = "";
	var ls_send_str_F = "";
	//-----취소 전문 --------------------------------------------------------//	
	// 본부코드[2] + 점코드[2] + POS번호[6] +  카드/수표구분[2]   +                 //
	// WCC(A/@)자동,수동[1] + 카드데이터길이[2]  + 카드사 일련번호[3] +        //
	// 카드데이터[37] + 할부개월[2] + 금액[11]   + PIN_DATA(PASSWORD)[4] + //
	// 정상건의 승인번호[8] + 현재년월일[6]                                                    // 
	//---여전법 이후(타사카드경우)--------------------------------------------------------------------------------------//
	// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]+터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]                    //
	// +WCC[1]+길이[3]+카드사고유일련번호[3]+카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]                    //
	// +WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]+거래구분[1]+이통사구분[1]+카드방식[1]              //
	// +RF카드종류[1]+동글매체구분[1]+단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] //
	//------------------------------------------------------------------------------------------------------------------//		
	
	// (09.04.20 평택점 식품관 가맹점 처리로 수정 :김경명, 정재형 ) 기존  분당점 식품관 가맹점 "BBBB" 처리
	
	// 구로점 식품관 가맹점으로 승인요청변경(10.10.25- 홍선미주임)  취소시 원거래 가맹점 정보로 승인취소 요청!!
	// (new) 전점 백화점 가맹점 요청(2013.06.09)  단, 원거래 체크후 원거래가 식품관경우 식품관으로 취소처리
	// 2017.09.14 이전 결제일인 경우 식품관 가맹점 "BBBB" 처리, 2017.09.14 이후 결제일인 경우 "    " 처리
	if (ls_hq == "00" && ls_store == "04" && ls_sale_ymd < "170914") {
		ls_gubun = "BBBB"; 					
	}else{																  
		ls_gubun =  "    "; 
	}
//alert("ls_sale_ymd : " + ls_sale_ymd + "\nls_store : " + ls_store + "\nls_gubun : " + ls_gubun);								
	//-------------------------------------------------------------------------------------------------------
	// 은련카드 포멧변경으로 전문 요청 수정(11.06.01) 각 점별 별도 오픈되어 점별 구 전문포멧/신 전문포멧 구분 추가
	//-------------------------------------------------------------------------------------------------------				
	var ls_filler = "";				//예약필드(2)
	var ls_working = "";			//은련카드 비밀번호(16)
	var ls_royalty = "";			// 로열티 데이터(16) (BC파트너스) 부가세율(2) + 할인여부(1) + 로열티 Data + space 로열티 데이터는 POS API가 전달한 그대로의 Data 값을 Setting
	var ls_resi_no = "";			// 주민번호(식품점사용)(13)	
	
	var ls_send_str = "";
	
	
	var ls_pre_ack_no	= ls_approve_no;		// 원승인번호 (신규)
	var ls_pre_sale_ymd	= cancel_sale_ymd;	// 원거래일자 (신규)
	// AK기프트(555), 홈플러스(666) 카드 추가(2012.01.17) ---------------------------------------
	if ((ls_card_corp_cd == "555") ||(ls_card_corp_cd == "666")) {
		var ls_new_recpt_no = "";
		
		ls_new_recpt_no = cancel_new_recpt_no;
		// 여전법 이전
//		ls_send_str = model.getValue("/root/req/hq") + $("#selBranch").val()  + ls_pos_no  + ls_new_recpt_no  +"10"
//				+ 'A'+ length + ls_card_corp_cd 
//				+ is_card_data + ls_halbu_no + ls_amt + ls_gubun + ls_approve_no +  ls_sale_ymd;	
				
			 //본부코드[2]+점포코드[2]+POS 번호[6]+거래번호[4]+CARD구분[2]
			ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(ls_new_recpt_no,4,"R")  + "10"
						//WCC[1]+길이[3]+카드사[3]+카드번호(암호화)[98]+할부개월[2]+금액[11]+PIN_DATA(PASSWORD)[4]
						+ is_wcc + length + ls_card_corp_cd + f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill_zero(ls_amt,11,'L') + f_setfill("",4,'R')
						//원승인번호[8]+원승인일자[6]
						+ ls_approve_no +  ls_sale_ymd;
		// AK기프트(555), 홈플러스(666) 카드 추가(2012.01.17) ---------------------------------------					 
	} else if(ls_cardvan_fg == "11") {		// Van사 코드가 "KB직승인(11)" 일 경우
		// 2017.07.12 황인철 - Van사 코드가 "KB직승인(11)" 일 경우 KB직승인 취소
		//ls_send_programID		= "XA272S";
		ls_send_programID		= "XB272S";
		length = "164"; // KB사 전문 카드번호 데이터 길이
		/* cmc - 위에서 정의 해서 내려옴.
	    var is_KB_card_data    = "SECU"+model.getValue("/root/data/danmal_data/modelNo")
									+model.getValue("/root/data/danmal_data/encGubun2")
									+model.getValue("/root/data/danmal_data/ksn2")
									+model.getValue("/root/data/danmal_data/encData2"); 
		*/
						
		product 		= ls_send_programID + "0000" + space(32);
		
		var trOpTm			= "";					// 거래개시시간 (신규)
		var trOpDt			= "";					// 거래개시일 (신규)
		//var trSeq			= "";					// 거래일련번호 (신규) - POSNO(6) + 거래번호(4) + SEQ(2)
		var trSeq		= ls_pos_no + "0000" + "01";	// 거래일련번호 (신규) - POSNO(6) + 거래번호(4) + SEQ(2) - cmc 안넣으면 전문오류남 기존에 왜 null?


//		ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R") 
//						+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"
//						+ '@' + length + ls_card_corp_cd 
//						+ is_card_data + ls_halbu_no + ls_amt + ls_gubun 
//						+ f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,165,"R")
//						+ f_setfill(trOpTm,6,"R")		// 거래개시시간 (신규)
//						+ f_setfill(trOpDt,4,"R")		// 거래개시일 (신규)
//						+ f_setfill(trSeq,12,"R")		// 거래일련번호 (신규)
//						+ f_setfill(ls_pre_ack_no,8,"R") 	// 원승인번호 (신규)
//						+ f_setfill(ls_pre_sale_ymd,8,"R");	// 원거래일자 (신규)
						
//		alert("send : " + ls_send_programID + "\n전문[" + ls_send_str.length + "] : " + ls_send_str);
			// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]+터미널ID2[15]
	  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")+ f_setfill(NICE_TERM_ID,15,"R")  + 
			//터미널ID3[15]+CARD/수표구분[2]+WCC[1]+VAN/직승인[2]+길이[3]+카드사 고유일련번호[3]+  
			f_setfill(KICC_TERM_ID,15,"R")  + "10" + is_wcc+ "01" + length + ls_card_corp_cd                                         
			//VAN 카드 DATA[98]+직승인 카드 DATA[98]+전문추적번호[12]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]	
			+ f_setfill(key_card_data,98,'R')+ f_setfill(is_KB_card_data,164,'R')+f_setfill(trSeq,12,"R") + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
			//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
			+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd.substring(2,8),6,"R") 
			//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
			+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
			 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
			+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,402,"R")   ;
		// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
	  ls_send_str_F = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
			// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
			+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
			// WCC[1]+길이[3]+카드사고유일련번호[3] 
			+ is_wcc + length + ls_card_corp_cd                                        
			 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
			+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
			//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
			+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 
			//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
			+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
			 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
			+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;	
	}
	else if(ls_cardvan_fg == "12") {		// VAN사 코드 12 -> BC직승인 취소  cmc
	
		ls_send_programID		= "XB415S";
		length = "164";
		product 		= ls_send_programID + "0000" + "00000000"+"00000000"+"00000000"+"00000000";			// 헤더 부분
		
		var trOpTm	= "";	// 거래개시시간 (신규)
		var trOpDt		= "";	// 거래개시일 (신규)
		
		var today		= new Date();
		var time_str	= f_setfill_zero(today.getHours() + "",2,"L") + f_setfill_zero(today.getMinutes() + "",2,"L") + f_setfill_zero(today.getSeconds() + "",2,"L");
		//var trSeq		= ls_pos_no + "0000" + "01";	// 거래일련번호 (신규) - POSNO(6) + 거래번호(4) + SEQ(2)
		var trSeq		= ls_pos_no + time_str;	// 거래일련번호 (신규) - POSNO(6) + 거래번호(4) + SEQ(2)

	  ls_send_str = ls_hq 											// 본부코드[2]
	                   + ls_store 										// 점포코드[2]
					   + ls_pos_no									// POS번호[6]
					   + f_setfill(KFTC_TERM_ID,15,"R")		// 터미널ID1[15]
					   + f_setfill(NICE_TERM_ID,15,"R")		// 터미널ID2[15]
					   + f_setfill(KICC_TERM_ID,15,"R")		// 터미널ID3[15]
					   + "10"												// CARD/수표구분[2]
					   + is_wcc											// WCC[1]
					   + "02"												// VAN/직승인[2] - 00 - VAN, KB - 01, BC - 02, SH - 03
					   + length											// 길이[3]
					   + ls_card_corp_cd    						// 카드사 고유일련번호[3]
					   + f_setfill(key_card_data,98,'R')		// VAN 카드 DATA[98]
					   + f_setfill(is_BC_card_data,164,'R')	// 직승인 카드 DATA[164]
					   + f_setfill(trSeq,12,"R")						// 전문추적번호[12]
					   + f_setfill(ls_halbu_no,2,'R')				// 할부개월[2]
					   + f_setfill(ls_amt,11,'R')					// 금액[11]
					   + f_setfill(pin_Data,4,"R")					// PIN_DATA[4]
					   + f_setfill(ls_filler,2,"R") 					// FILLER[2]
					   + f_setfill(ls_working,16,"R")				// WorkingKey[16]
					   + f_setfill(ls_royalty,203,"R")				// 로열티데이터[203]
					   + f_setfill(ls_pre_ack_no,8,"R")			// 원승인번호[8]
					   + f_setfill(ls_pre_sale_ymd.substring(2,8),6,"R")	// 원매출일자[6]
					   + f_setfill(trsnGubun1,1,"R") 				// 거래구분[1]
					   + f_setfill(mbCorp,1,"R") 					// 이통사구분[1]
					   + f_setfill(cardTp,1,"R") 					// 카드방식[1]
					   + f_setfill(rfCdKnd,1,"R") 					// RF카드종류[1]
					   + space(1)										// 동글매체구분[1]
					   + "B" 												// 단말종류구분[1]
					   + f_setfill(posCertiNo,16,"R") 			// POSSW식별번호[16]
					   + f_setfill(fbReason,2,"R") 				// Fallback사유[2]
					   + emvYN 										// EMVData유무[1]
					   + f_setfill(emvReqdata,402,"R") ;   	// EMV요청DATA[400] 

	  ls_send_str_F = ls_hq 										// 본부코드[2]
	                       + ls_store									// 점포코드[2]
						   + ls_pos_no								// POS번호[6]
						   + f_setfill(KFTC_TERM_ID,15,"R")	// 터미널ID1[15]
						   + f_setfill(NICE_TERM_ID,15,"R")	// 터미널ID2[15]
						   + f_setfill(KICC_TERM_ID,15,"R")	// 터미널ID3[15]
						   + "10"  										// CARD/수표구분[2]
						   + is_wcc										// WCC[1]
						   + length										// 길이[3]
						   + ls_card_corp_cd   					// 카드사고유일련번호[3]
						   + f_setfill(card_data,98,'R')			// 카드DATA[98]
						   + f_setfill(ls_halbu_no,2,'R')			// 할부개월[2]
						   + f_setfill(ls_amt,11,'R')				// 금액[11]
						   + f_setfill(pin_Data,4,"R")				// PIN_DATA[4]
						   + f_setfill(ls_filler,2,"R") 				// FILLER[2]
						   + f_setfill(ls_working,16,"R")			// WorkingKey[16]
						   + f_setfill(ls_royalty,203,"R")			// 로열티데이터[203]
						   + f_setfill(ls_pre_ack_no,8,"R")		// 원승인번호[8]
						   + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 	// 원매출일자[6]
						   + f_setfill(trsnGubun1,1,"R")			// 거래구분[1]
						   + f_setfill(mbCorp,1,"R")				// 이통사구분[1]
						   + f_setfill(cardTp,1,"R")				// 카드방식[1]
						   + f_setfill(rfCdKnd,1,"R")				// RF카드종류[1]
						   + space(1) 								// 동글매체구분[1]
						   + "B"											// 단말종류구분[1]
						   + f_setfill(posCertiNo,16,"R")		// POSSW식별번호[16]
						   + f_setfill(fbReason,2,"R")			// Fallback사유[2]
						   + emvYN									// EMVData유무[1]
						   + f_setfill(emvReqdata2,400,"R")  ;	// 	EMV요청DATA[400]
	}
	else if(ls_cardvan_fg == "13") {		// VAN사 코드 13 -> 신한(SH) 직승인 취소 cmc
	
		ls_send_programID = "XB425S";
		length = "164"; 
		product 		= ls_send_programID + "0000" + "00000000"+"00000000"+"00000000"+"00000000";			// 헤더 부분
		
		var trOpTm	= "";	// 거래개시시간 (신규)
		var trOpDt		= "";	// 거래개시일 (신규)
		var trSeq		= ls_pos_no + "0000" + "01";	// 거래일련번호 (신규) - POSNO(6) + 거래번호(4) + SEQ(2)

	  ls_send_str = ls_hq 											// 본부코드[2]
	                   + ls_store 										// 점포코드[2]
					   + ls_pos_no									// POS번호[6]
					   + f_setfill(KFTC_TERM_ID,15,"R")		// 터미널ID1[15]
					   + f_setfill(NICE_TERM_ID,15,"R")		// 터미널ID2[15]
					   + f_setfill(KICC_TERM_ID,15,"R")		// 터미널ID3[15]
					   + "10"												// CARD/수표구분[2]
					   + is_wcc											// WCC[1]
					   + "03"												// VAN/직승인[2] - 00 - VAN, KB - 01, BC - 02, SH - 03
					   + length											// 길이[3]
					   + ls_card_corp_cd    						// 카드사 고유일련번호[3]
					   + f_setfill(key_card_data,98,'R')				// VAN 카드 DATA[98]
					   + f_setfill(is_SH_card_data,164,'R')	// 직승인 카드 DATA[164]
					   + f_setfill(trSeq,12,"R")						// 전문추적번호[12]
					   + f_setfill(ls_halbu_no,2,'R')				// 할부개월[2]
					   + f_setfill(ls_amt,11,'R')					// 금액[11]
					   + f_setfill(pin_Data,4,"R")					// PIN_DATA[4]
					   + f_setfill(ls_filler,2,"R") 					// FILLER[2]
					   + f_setfill(ls_working,16,"R")				// WorkingKey[16]
					   + f_setfill(ls_royalty,203,"R")				// 로열티데이터[203]
					   + f_setfill(ls_pre_ack_no,8,"R")			// 원승인번호[8]
					   + f_setfill(ls_pre_sale_ymd.substring(2,8),6,"R")	// 원매출일자[6]
					   + f_setfill(trsnGubun1,1,"R") 				// 거래구분[1]
					   + f_setfill(mbCorp,1,"R") 					// 이통사구분[1]
					   + f_setfill(cardTp,1,"R") 					// 카드방식[1]
					   + f_setfill(rfCdKnd,1,"R") 					// RF카드종류[1]
					   + space(1)										// 동글매체구분[1]
					   + "B" 												// 단말종류구분[1]
					   + f_setfill(posCertiNo,16,"R") 			// POSSW식별번호[16]
					   + f_setfill(fbReason,2,"R") 				// Fallback사유[2]
					   + emvYN 										// EMVData유무[1]
					   + f_setfill(emvReqdata,402,"R") ;   	// EMV요청DATA[400] 

	  ls_send_str_F = ls_hq 										// 본부코드[2]
	                       + ls_store									// 점포코드[2]
						   + ls_pos_no								// POS번호[6]
						   + f_setfill(KFTC_TERM_ID,15,"R")	// 터미널ID1[15]
						   + f_setfill(NICE_TERM_ID,15,"R")	// 터미널ID2[15]
						   + f_setfill(KICC_TERM_ID,15,"R")	// 터미널ID3[15]
						   + "10"  										// CARD/수표구분[2]
						   + is_wcc										// WCC[1]
						   + length										// 길이[3]
						   + ls_card_corp_cd   					// 카드사고유일련번호[3]
						   + f_setfill(card_data,98,'R')			// 카드DATA[98]
						   + f_setfill(ls_halbu_no,2,'R')			// 할부개월[2]
						   + f_setfill(ls_amt,11,'R')				// 금액[11]
						   + f_setfill(pin_Data,4,"R")				// PIN_DATA[4]
						   + f_setfill(ls_filler,2,"R") 				// FILLER[2]
						   + f_setfill(ls_working,16,"R")			// WorkingKey[16]
						   + f_setfill(ls_royalty,203,"R")			// 로열티데이터[203]
						   + f_setfill(ls_pre_ack_no,8,"R")		// 원승인번호[8]
						   + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 	// 원매출일자[6]
						   + f_setfill(trsnGubun1,1,"R")			// 거래구분[1]
						   + f_setfill(mbCorp,1,"R")				// 이통사구분[1]
						   + f_setfill(cardTp,1,"R")				// 카드방식[1]
						   + f_setfill(rfCdKnd,1,"R")				// RF카드종류[1]
						   + space(1) 								// 동글매체구분[1]
						   + "B"											// 단말종류구분[1]
						   + f_setfill(posCertiNo,16,"R")		// POSSW식별번호[16]
						   + f_setfill(fbReason,2,"R")			// Fallback사유[2]
						   + emvYN									// EMVData유무[1]
						   + f_setfill(emvReqdata,400,"R")  ;	// 	EMV요청DATA[400]
	} else {
		// 구로점 구 전문포멧
		if ($("#selBranch").val() == "01" ) { 
//			ls_send_str = model.getValue("/root/req/hq") + $("#selBranch").val()  + ls_pos_no  +  "10"
//					+ '@' + length + ls_card_corp_cd 
//					+ is_card_data + ls_halbu_no + ls_amt + ls_gubun + ls_approve_no +  ls_sale_ymd
//					+ f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");	
				// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
		  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
				// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
				+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
				// WCC[1]+길이[3]+카드사고유일련번호[3] 
				+ is_wcc + length + ls_card_corp_cd                                        
				 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
				+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
				//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
				+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 
				//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
				+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
				 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
				+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;			
		// 수원점 이면 신 전문포멧으로 승인요청(new)	11.06.06														
		}else if ($("#selBranch").val() == "02" ) { 
//			ls_send_str = model.getValue("/root/req/hq") + $("#selBranch").val()  + ls_pos_no  +  "10"
//					+ '@' + length + ls_card_corp_cd 
//					+ is_card_data + ls_halbu_no + ls_amt + ls_gubun + ls_approve_no +  ls_sale_ymd
//					+ f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");					
				// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
		  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
				// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
				+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
				// WCC[1]+길이[3]+카드사고유일련번호[3] 
				+ is_wcc + length + ls_card_corp_cd                                        
				 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
				+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
				//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
				+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 
				//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
				+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
				 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
				+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;	
		// 분당점  구 전문포멧									
		}else if ($("#selBranch").val() == "03" ) { 											
//			ls_send_str = model.getValue("/root/req/hq") + $("#selBranch").val()  + ls_pos_no  +  "10"
//					+ '@' + length + ls_card_corp_cd 
//					+ is_card_data + ls_halbu_no + ls_amt + ls_gubun + ls_approve_no +  ls_sale_ymd
//					+ f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");
				// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
		  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
				// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
				+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
				// WCC[1]+길이[3]+카드사고유일련번호[3] 
				+ is_wcc + length + ls_card_corp_cd                                        
				 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
				+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
				//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
				+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 
				//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
				+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
				 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
				+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;	
		// 평택점 구 전문포멧													
		}else if ($("#selBranch").val() == "04" ) { 		
//			ls_send_str = model.getValue("/root/req/hq") + $("#selBranch").val()  + ls_pos_no  +  "10"
//					+ '@' + length + ls_card_corp_cd 
//					+ is_card_data + ls_halbu_no + ls_amt + ls_gubun + ls_approve_no +  ls_sale_ymd
//					+ f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");	
				// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
		  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
				// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
				+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
				// WCC[1]+길이[3]+카드사고유일련번호[3] 
				+ is_wcc + length + ls_card_corp_cd                                        
				 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
				+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
				//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
				+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 
				//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
				+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
				 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
				+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;	
		// 원주점 구 전문포멧													
		}else if ($("#selBranch").val() == "05" ) { 		
//			ls_send_str = model.getValue("/root/req/hq") + $("#selBranch").val()  + ls_pos_no  +  "10"
//					+ '@' + length + ls_card_corp_cd 
//					+ is_card_data + ls_halbu_no + ls_amt + ls_gubun + ls_approve_no +  ls_sale_ymd
//					+ f_setfill(ls_filler,2,"R") +  f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R")  + f_setfill(ls_resi_no,13,"R");	
				// 본부코드[2]+점포코드[2]+POS번호[6]+터미널ID1[15]
		  ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(KFTC_TERM_ID,15,"R")   
				// 터미널ID2[15]+터미널ID3[15]+CARD/수표구분[2]  
				+ f_setfill(NICE_TERM_ID,15,"R")  + f_setfill(KICC_TERM_ID,15,"R")  + "10"  
				// WCC[1]+길이[3]+카드사고유일련번호[3] 
				+ is_wcc + length + ls_card_corp_cd                                        
				 //카드DATA[98]+할부개월[2]+금액[11]+PIN_DATA[4]+FILLER[2]
				+ f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill(ls_amt,11,'R') + f_setfill(pin_Data,4,"R") + f_setfill(ls_filler,2,"R") 
				//WorkingKey[16]+로열티데이터[203]+원승인번호[8]+원매출일자[6]
				+ f_setfill(ls_working,16,"R") + f_setfill(ls_royalty,203,"R") + f_setfill(ls_pre_ack_no,8,"R") + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 
				//+거래구분[1]+이통사구분[1]+카드방식[1]+RF카드종류[1]+동글매체구분[1]
				+ f_setfill(trsnGubun1,1,"R") + f_setfill(mbCorp,1,"R") + f_setfill(cardTp,1,"R") + f_setfill(rfCdKnd,1,"R") + space(1) 
				 //단말종류구분[1]+POSSW식별번호[16]+Fallback사유[2]+EMVData유무[1]+EMV요청DATA[400] 
				+"B" + f_setfill(posCertiNo,16,"R") + f_setfill(fbReason,2,"R") + emvYN + f_setfill(emvReqdata,400,"R")   ;	
		}
	}
	
	var card_data_fg = card_fg;
	var bc_qr_data = bc_qr_value;
	
	if(bc_qr_data == null || bc_qr_data == ""  ) {
		
	}
	else {
		if(card_data_fg == "Q" || card_data_fg == "q" ) {		//bc QR 문 만들어야 함.  cmc
			// BC QR 전문 생성 시작
			ls_send_programID = "XB512S";
			
			// product = 전문ic + 응답코드 + 단품 INDEX정보 + 소스 INDEX정보 + CLASS INDEX정보 + 담당자 INDEX정보
			// 즉 product = 전문의 HEADER 부분
			product 		= ls_send_programID + "0000" + "00000000" + "00000000" +"00000000" + "00000000" ;
			
			// bc qr 은 card_data 항목 - 카드번호 데이터로 보낸다.
			var qr_track2 = bc_qr_data.substr(6, 40);														// track2 데이터
			
			var qr_gubun      = bc_qr_data.substr(3, 1) ; // (L, C)
			var qr_emv_data = bc_qr_data.substring(47, bc_qr_data.length - 46);
			
			var check_bill_fg = "";
			
			if(qr_gubun == "L") {		// QR 코드가 국내 일 시    Q  L
				
				is_wcc = "Q";
				check_bill_fg = "10" ;
			}
			else {							// QR 코드가 해외 일 시	  Q  C
				is_wcc = "q";
				check_bill_fg = "22" ;
			}
			
			ls_send_str  = ls_hq 															// 본부코드[2]
							  + ls_store														// 점포코드[2]
							  + ls_pos_no													// POS번호[6]
							  + f_setfill(KFTC_TERM_ID,15,"R")   						// 터미널ID1[15]
							  + f_setfill(NICE_TERM_ID,15,"R")							// 터미널ID2[15]
							  + f_setfill(KICC_TERM_ID,15,"R")							// 터미널ID3[15]
							  + check_bill_fg 												// CARD/수표구분[2]
							  + is_wcc 															// WCC[1]
							  + length 															// 길이[3]
							  + ls_card_corp_cd  											// 카드사고유일련번호[3]
							  + f_setfill(qr_track2,98,'R')								// 카드DATA[98]
							  + f_setfill(ls_halbu_no,2,'R')								// 할부개월[2]
							  + f_setfill_zero(ls_amt,11,'L')							// 금액[11]
							  + f_setfill(pin_Data,4,"R")									// PIN_DATA[4]
							  + f_setfill(ls_filler,2,"R") 										// FILLER[2]
							  + f_setfill(ls_working,16,"R")								// WorkingKey[16]
							  + f_setfill(ls_royalty,203,"R")								// 로열티데이터[203]
							  + f_setfill(ls_pre_ack_no,8,"R")							// 원승인번호[8]
							  + f_setfill(ls_pre_sale_ymd.substring(2.8),6,"R") 	// 원매출일자[6]
							  + f_setfill(trsnGubun1,1,"R")								// 거래구분[1]
							  + f_setfill(mbCorp,1,"R")									// 이통사구분[1]
							  + f_setfill(cardTp,1,"R")										// 카드방식[1]
							  + f_setfill(rfCdKnd,1,"R")									// RF카드종류[1]
							  + space(1) 														// 동글매체구분[1]
							  +"B"																// 단말종류구분[1]
							  + f_setfill(posCertiNo,16,"R")								// POSSW식별번호[16]
							  + f_setfill(fbReason,2,"R")									// Fallback사유[2]
							  + emvYN															// EMVData유무[1]
							  + f_setfill(qr_emv_data,400,"R")   ;						// EMV요청DATA[400]
		}
	}
	//-------------------------------------------------------------------------------------------------------
	
	ls_send_str	= product + ls_send_str;
	ls_send_str	= f_setfill(ls_send_str, 1060, "R");
	
	ic_ls_send_str = ls_send_str;
	ic_ls_send_str_F = f_setfill(product + ls_send_str_F, 1060, "R");
	// 2014.10 체크카드 즉시 취소시 기매입 취소로 인해 에러 발생시 정상 처리를 위한 승인번호 셋팅
	
	//카드승인 Transaction
	$.ajax({
		type : "POST", 
		url : "/member/lect/card_cancel_proc",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			hq : '00',
			store : $("#selBranch").val(),
			approve_no_exp : cancel_ic_approve_no,
			ls_send_str : ic_ls_send_str
			
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var ls_msg 		= trim(result.message);
			var ls_aprv_no 	= result.approve_no;
			var ls_card_fg = card_corp_no;

			if(ls_msg.indexOf("정상거래") == -1 && ls_msg.indexOf("취소거절이미매입된거래") == -1){
				cancel_result = "1";
			}
			
			// 체크카드 익일 취소 시 "취소거절이미매입된거래" 라고 돌아오는 메시지를 정상 메시지로 변경	2017.09.11
			if(ls_msg.indexOf("취소거절이미매입된거래") > -1)
				ls_msg = "정상거래";
			
			if (((ls_card_fg =="555")  ||(ls_card_fg =="666") )
			  && (trim(result.rest_amt)== "")) {
				alert('전산실 문의~!!');
				cancel_result = "1";
			}	
			alert(ls_msg);
			if(ls_aprv_no.length < 7 ||
			   trim(ls_aprv_no) == '') {
				approve_no.value = "";
			} 
			
		}
	});
	

}

function cancelMobileCoupon() {
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/getCancelMobileCoupon",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			pos_no : pos_no,
			tel_corp_fg : 1,
			aprv_no : cancel_mc_approve_no,
			aprv_amt : cancel_mc_card_amt,
			sale_ymd : cancel_sale_ymd
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var result_msg 	= result.result_msg;
			
			cancel_mc_result_cd = result.result_cd;
			cancel_proc_mc_approve_no = result.approve_no;
			cancel_proc_remain_amt = result.remain_amt;
			alert(result_msg);
		}
	});
	
}
function approveCheckCancel(card_corp_no, cash_amt, card_amt, coupon_amt, mc_card_amt, cashrec_ext_amt, id_fg, id_no, issue_fg, van_fg, aprv_no, pos_no) {
	
	//전문생성
	//var	ls_send_programID 	= "XA078S";여전법이전
	var	ls_send_programID 	= "XB078S"; //여전법 이후 2018.02.19
	var	KFTC_TERM_ID 		= "9047000000";
	var	NICE_TERM_ID 		= "9540030001";
	var	KICC_TERM_ID 		= "104504    ";
	
	//현금+상품권 금액
	
	//AK기프트(555), 홈플러스(666) 카드금액 현금영수증 포함
	var ls_card_fg 		= card_corp_no;
	var ls_send_amt 	= 0;
	
	var ls_cash_amt		= cash_amt;
	ls_cash_amt			= parseInt(ls_cash_amt == null || ls_cash_amt == "" ? 0 : ls_cash_amt);
	var ls_card_amt		= card_amt;
	ls_card_amt			= parseInt(ls_card_amt == null || ls_card_amt == "" ? 0 : ls_card_amt);
	var ls_coupon_amt	= coupon_amt;
	ls_coupon_amt		= parseInt(ls_coupon_amt == null || ls_coupon_amt == "" ? 0 : ls_coupon_amt);
	var ls_mc_card_amt	= mc_card_amt;
	ls_mc_card_amt		= parseInt(ls_mc_card_amt == null || ls_mc_card_amt == "" ? 0 : ls_mc_card_amt);
	//2019.04.10 ljs 상품권 현금영수증제외대상금액추가 START
	var ls_cashrec_ext_amt	= cashrec_ext_amt;
	ls_cashrec_ext_amt		= parseInt(ls_cashrec_ext_amt == null || ls_cashrec_ext_amt == "" ? 0 : ls_cashrec_ext_amt);	
	//2019.04.10 ljs 상품권 현금영수증제외대상금액추가 END
	var cardLen = "";// 여전법 이후 추가
	
	//2019.04.10 ljs 현금영수증제외대상금액추가 START
	ls_send_amt = ls_cash_amt + ls_coupon_amt + ls_mc_card_amt - ls_cashrec_ext_amt;
	//2019.04.10 ljs 현금영수증제외대상금액추가 END

	if ( (ls_card_fg == "555" ) || (ls_card_fg == "666" ) ) {
		ls_send_amt += ls_card_amt;
	}

	if (ls_send_amt <= 0) {
		alert("현금영수증 취소작업중 에러가 발생하였습니다.");
	}

	//amt	= f_setfill_zero(ls_send_amt, 11, "L");		// 왜 외부 함수 호출이 안되는지 알 수 없음
	var s		= 11 - ls_send_amt.toString().length;
	var amt		= fill("0", s) + ls_send_amt.toString();

	ls_valid 		= "0000";
	ls_card_corp_cd = "000";
	ls_vat 			= "00000000000";

	var id_fg, issue_fg, is_wcc, is_inst_nm;
//	id_fg		= gridMain.valueMatrix(gridMain.row,gridMain.colRef("id_fg")); //변수명 중복으로 뮤자인 제거
//	issue_fg	= gridMain.valueMatrix(gridMain.row,gridMain.colRef("issue_fg")); //변수명 중복으로 뮤자인 제거
	
	if(id_fg == '1') {
		is_wcc = 'A'
//		var trsnGubun1 = model.getValue("/root/data/rfFlag1/cardFlag1"); //거래구분[1]
//		var trsnGubun2 = model.getValue("/root/data/rfFlag1/cardFlag2"); //거래구분[1]
//
//		var card_data = "SECU"+model.getValue("/root/data/danmal_data1/modelNo")
//						+model.getValue("/root/data/danmal_data1/encGubun")
//						+model.getValue("/root/data/danmal_data1/ksn")
//						+model.getValue("/root/data/danmal_data1/encData"); 
//		if(trsnGubun2 == "F"){//MSR 거래시 fb
//			is_wcc = "F";
//		}else if(trsnGubun1 == "M"){
			is_wcc = "A";
//			if(model.getValue("/root/data/danmal_data1/encDtCnt") == "00"){
				card_data = id_no
//			}
//		}else{
//			is_wcc = "I";
//		}	
		ls_cust 		= card_data;
	} else {
		is_wcc = '@'
		ls_cust 		= id_no
	}

	ls_data1 		= f_setfill( ls_cust , 98, "R");
	//ls_data1 		= f_setfill( ls_cust + "=" + ls_valid, 37, "R"); 여전법이전 
	
	store 			= $("#selBranch").val();
	// 09.04.20 기존소스 백업 (점별 사업자번호 세팅 이상함) 해선
	// if(store == "02") ls_saupja = "1298510975";
	// else ls_saupja = "1298542346";
	
	// 점별 세팅
	if(store == "01") {
		ls_saupja 	= "1138107313";
	} else if(store == "02") {
		ls_saupja 	= "1248128579";
	} else if(store == "03") {
		ls_saupja 	= "1298542346";
	} else if(store == "04") {
		ls_saupja 	= "1258124085";
	} else if(store == "05") {
		ls_saupja 	= "2248523362";
	}
	
	if(issue_fg == '1') {
		is_inst_nm = '01'
	} else {
		is_inst_nm = '02'
	}
	
	/* 현금영수증 취소경우 원거래 승인 벤사로 취소 요청변경(2012.08.20)  */
	var ls_cashvan_fg   =  van_fg;
	
	//영업서버 -> 점서버 변경 20161010
//	if(store == "03") {
//		if (ls_cashvan_fg == "2"){ 
//		    ls_send_programID = "XA103S";     //NICE 
//		 }else if(ls_cashvan_fg == "4"){ 
//		    ls_send_programID = "XA104S";     //KOVAN   
//		 }
//	}else {   
		// 2012.08.28 적용 : 분당, 평택 / 2012.08.30 적용 : 구로, 수원  /2014.03.19 금결원추가. 01
		if (ls_cashvan_fg == "1"){ 
		    //여전법 이전 ls_send_programID = "XA087S";    //현금 영수증 취소(KFTC). POS는 카드현금 둘다씀
			ls_send_programID = "XB087S";
		 }else if (ls_cashvan_fg == "2"){ 
		    //여전법 이전 ls_send_programID = "XA082S";    //NICE 
			ls_send_programID = "XB082S";	
		 }else if(ls_cashvan_fg == "4"){ 
		    //여전법 이전 ls_send_programID = "XA084S";    //KOVAN   
			ls_send_programID = "XB084S";
		 }else if(ls_cashvan_fg == "6"){ 
		    //여전법 이전 ls_send_programID = "XA080S";    //KICC
			ls_send_programID = "XB080S";
		 }else if(ls_cashvan_fg == "7"){ 
		    //여전법 이전 ls_send_programID = "XA085S";    //JTNET  //평택벤사 현재 사용안함16.05.12 /16.11전점사용
			ls_send_programID = "XB085S";
		 }else if(ls_cashvan_fg == "8"){ 
		    //여전법 이전 ls_send_programID = "XA093S";    //KIS 16.12 추가
			ls_send_programID = "XB093S";
		 }else if(ls_cashvan_fg == "9"){ 
		    //여전법 이전 ls_send_programID = "XA086S";    //SPCN 16.12 추가
			ls_send_programID = "XB086S";
		 }
//	}
	
	// 여전법 이전 product = ls_send_programID + space(36);
	product = ls_send_programID + space(36);
	product = ls_send_programID + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
	//-------------------------------------------------------------------- //
	// 본부코드[2] + 점코드[2] + POS번호[6] + 영수증번호[4] +              //  
	// CardCheckBillFg[2] + WCC[1] + Length[2]  + CardsqNo[3] +	           //
	// 카드데이터[37] + 할부개월[2] + 금액[11]   + PIN_DATA(PASSWORD)[4]   // 
	// 부가세+ 사업자번호
	/* 현금영수증 취소 원거래정보 승인번호(8) + 승인날짜(6)   추가 2012.08.20 */
	//-여전법이후------------------------------------------------------------------------------------------------------//
	//본부코드[2]+점포코드[2]+POS 번호[6]+영수증번호[4]+CARD/수표구분[2]
	//+WCC[1]+카드길이[3]+카드사 고유일련번호[3]+    //
	//카드번호(암호화)[98]+할부개월[2]+사업자번호[10]+부가세[11]+금액[11]
	//+PIN_DATA[4]+승인번호[8]+승인일자[6]+FILLER[35]//
	//---------------------------------------------------------------------------------------------------------------- //
	var ls_org_aprv_no = aprv_no ;
	ls_org_aprv_no = ls_org_aprv_no.substring(1,9);
	
	var ls_org_sale_ymd =   cancel_sale_ymd;
	ls_org_sale_ymd = ls_org_sale_ymd.substring(2,8);
	 
	//ls_send_str = model.getValue("/root/req/hq") + store + gridMain.valueMatrix(gridMain.row, gridMain.colRef("pos_no")) + "0000"
	//	         + "21"  + is_wcc + "37" + ls_card_corp_cd
	//	         + ls_data1 + is_inst_nm  + amt + "BBBB"
	//	         + ls_vat + ls_saupja 
	//	         + ls_org_aprv_no +  ls_org_sale_ymd ;   /* 현금영수증 취소 원거래정보 승인번호(8) + 승인날짜(6)   추가 2012.08.20 */
				
	ls_send_str = '00' + store + pos_no + "0000"
		         + "21"  + is_wcc + f_setfill(cardLen,3,'R') + ls_card_corp_cd
		         + ls_data1 +  is_inst_nm + ls_saupja+ ls_vat  + amt 
		         + f_setfill("",4,'R')+ ls_org_aprv_no +  ls_org_sale_ymd ;
				 
	ls_send_str = product + ls_send_str;		
	ls_send_str = f_setfill(ls_send_str, 1024, "R");
	
//	model.setValue("/root/req/ls_send_str", ls_send_str);
	
	cash_ls_send_str = ls_send_str;
	
	//현금영수증승인 Transaction
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetApproveNo",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			ls_send_str : cash_ls_send_str,
			hq : '00',
			store : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var ls_msg 		= trim(result.message);
			alert(ls_msg);
			
			cash_approve_no = result.approve_no;
			cash_rate = result.rate;
		}
	});
}




var ls_header_data = "";
var ls_detail_data = "";
var ls_footer_data = "";

var ls_recpt_no, ls_card_no, ls_coupon_no, ls_barcode, ls_subject_nm;
var ls_sale_date, ls_pos_no, ls_intype;
var ls_data, ls_trade_all_amt, ls_enuri_amt, ls_net_sale_amt;
var ls_escape,ls_font;
var ls_normal, ls_doublewide, ls_doublehigh, ls_doublehighwide;
var i = 0;
var ls_card_amt, ls_cash_amt;

var ls_issue_fg, ls_id_no, ls_aprv_no, ls_approve_no;
var ls_sign , ls_e_sign;
var remain_amt_flag = false;

function printStart()
{
	if(posInit()) {
		$("[name='pere_idx']").each(function() 
		{
			if($(this).is(":checked") )
			{
				var cancel_idx = $(this).attr('id').replace("pere_idx", "cancel_idx");
				cancel_reason = $("#"+cancel_idx).val(); //취소사유
				
				var result = JSON.parse(decodeURI($(this).val()));
				
				//전역변수 셋팅
				
				//전역변수 셋팅
				pos_detail($(this).val());
				
				var ls_card_amt 	= result.CARD_AMT;
				ls_card_amt			= ls_card_amt == null || ls_card_amt == "" ? 0 : parseInt(ls_card_amt); 
				var ls_cash_amt 	= result.CASH_AMT;
				ls_cash_amt			= ls_cash_amt == null || ls_cash_amt == "" ? 0 : parseInt(ls_cash_amt);
				var ls_mc_card_amt 	= result.MC_CARD_AMT;
				ls_mc_card_amt		= ls_mc_card_amt == null || ls_mc_card_amt == "" ? 0 : parseInt(ls_mc_card_amt);
				var ls_e_sign 		= result.E_SIGN;
				//2019.04.29 ljs 취소된 후 영수증출력시 마일리지 정보 조회
				var ls_akmem_approve_no = result.AKMEM_APPROVE_NO;
				
				if(ls_card_amt > 0 || ls_mc_card_amt > 0) {
					if(confirm("고객영수증을 출력하시겠습니까?"))
					{
						pos_header('C', $(this).val());	// 고객용
						pos_footer('C', $(this).val());	// 카드
						posPrintPrev();
						
						if(ls_card_amt > 0 && ls_e_sign != "1") {
							pos_header('S', $(this).val());	// 카드전표
							pos_footer('S', $(this).val());	// Card 수거용
							posPrintPrev();
						}
					}
					if(confirm("가맹영수증을 출력하시겠습니까?"))
					{
						pos_header('A', $(this).val());
						pos_footer('A', $(this).val());
						posPrintPrev();
					}
				}
			}
		});
	}
}

function pos_detail(json)
{
	var result = JSON.parse(decodeURI(json));
	$.ajax({
		type : "POST", 
		url : "/member/lect/getCancelSubject",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			recpt_pos_no : result.POS_NO,
			period : result.PERIOD,
			sale_ymd : result.SALE_YMD,
			recpt_no : result.RECPT_NO
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result_this = JSON.parse(data);
			
			for(var i = 0; i < result_this.length; i++)
			{
				var regis_fee = result_this[i].UPRICE;
				var food_fee = result_this[i].FOOD_AMT;
				var sub_tot_fee = 0;
				sub_tot_fee = Number(regis_fee) + Number(food_fee);
				
				ls_detail_data += result_this[i].SUBJECT_CD +' '+ result_this[i].SUBJECT_NM;
				ls_detail_data += '\r\n';
				ls_detail_data += f_setfill(comma(regis_fee),17,'L');
				ls_detail_data += f_setfill(comma(food_fee),11,'L');
				ls_detail_data += f_setfill(comma(sub_tot_fee.toString()),12,'L');
				ls_detail_data += '\r\n';
			}
			ls_detail_data += "총강좌수 : "+ result_this.length + "\r\n";
			ls_detail_data += '----------------------------------------';
		}
	});
}
function pos_header(flag, json) {
	var result = JSON.parse(decodeURI(json));
	
	ls_header_data = "";
	
	if(result.POS_NO == '070013') {
		ls_pos_no = '070013';
	} else if(result.POS_NO == '070014'){
		ls_pos_no = '070014';
	} else {
		ls_pos_no = pos_no;
	}
	
	ls_escape 			= String.fromCharCode(27);
	ls_font				= '|bC';
	ls_normal 			= '|1C';
	ls_doublewide	 	= '|2C';
	ls_doublehigh 		= '|3C';
	ls_doublehighwide	= '|4C';

	ls_sale_date		= result.SALE_YMD;
	ls_recpt_no			= result.RECPT_NO;
	ls_card_amt	 		= result.CARD_AMT;
	ls_issue_fg  		= result.ISSUE_FG;
	ls_id_no     		= result.ID_NO;
	ls_id_fg			= result.ID_FG;
	ls_approve_no  		= result.APPROVE_NO;
	ls_aprv_no			= result.APRV_NO;
	ls_cash_amt 		= result.CASH_AMT;
	ls_card_no			= result.CARD_NO;
	ls_mc_card_amt 		= result.MC_CARD_AMT;
	ls_cashrec_ext_amt  = result.CASHREC_EXT_AMT;    //2019.04.30 ljs 현금영수증제외대상금액
	
	sale_ymd			= ls_sale_date.substring(0, 4) + "년" + ls_sale_date.substring(4, 6) + "월" +  ls_sale_date.substring(6, 8) + "일";
	conversion_recpt_no	= "NO." + ls_pos_no + "-" + ls_recpt_no;
	sale_time			= getTime().substring(0,2) + "시" + getTime().substring(2,4) + "분"  + getTime().substring(4,6) + "초";
	
	//AK기프트(555),홈플러스(666) 인정금액 추가
	ls_card_fg 	= result.CARD_CORP_NO
	
	//2019.04.30 ljs 현금영수증제외대상금액 추가
	ls_send_amt = eval(ls_card_amt) + eval(ls_cash_amt) + eval(ls_mc_card_amt) - eval(ls_cashrec_ext_amt);    
	
	//분당점이면 바코드 91로 시작 POS는81
	if($("#selBranch").val() == "03") {
		ls_barcode			= "91" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	} else if($("#selBranch").val() == "01") {
		ls_barcode			= "92" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	} else if($("#selBranch").val() == "02") {
		ls_barcode			= "93" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}else if($("#selBranch").val() == "04") {
		ls_barcode			= "94" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}else if($("#selBranch").val() == "05") {
		ls_barcode			= "95" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}

	var sale_date = setWeekDay(ls_sale_date);
	//==================================================================
	if($("#selBranch").val() == "03") {
		//분당점
		ls_header_data  = ls_escape + ls_font
//기존소스백업(2012.06.26)						
//		ls_header_data += "에이알디홀딩스(주)AK PLAZA 분당점\n"
//분당점 에이알디홀딩스(주) -> AK S&D(주) 변경(2012.06.26)
		ls_header_data += "AK S&D(주) AK 분당점\n"	
		ls_header_data += "129-85-42346  김 재 천\n"
		ls_header_data += "경기도 성남시 분당구 황새울로 360번길 42\n"
		ls_header_data += "Tel: 1661-1114\n"
		ls_header_data += "http://www.akplaza.com www.akmall.com\n"
		ls_header_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_header_data += '\r\n\r\n'
//		ls_header_data += "축하! AK PLAZA 분당점 개점 12주년!\n"
//		ls_header_data += "한결같이 사랑해주셔서 고맙습니다.\r\n\r\n"	
		
//기존소스 백업 (10.02.16)			
//		ls_header_data += "새로운 생활의 즐거움! AK PLAZA\n"
//		ls_header_data += "항상 최고로 모시겠습니다.\r\n\r\n"	
		ls_header_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_header_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
//09.08.24 분당점 문구 수정요청(정보전략 정재형)						
//		ls_header_data += "새로운 생활의 즐거움! AK PLAZA\n"
//		ls_header_data += "유통최초 한국서비스품질 4회 인증\n"						
//		ls_header_data += "\"최고의 서비스로 모시겠습니다.\"\r\n\r\n"	
				
	} else if($("#selBranch").val() == "01") {
		//구로점
		ls_header_data  = ls_escape + ls_font
		ls_header_data += "에이케이아이에스(주) 구로본점\n"
		ls_header_data += "113-81-07313  백차현, 김재영\n"
		ls_header_data += "서울특별시 구로구 구로중앙로 152\n"
		ls_header_data += "Tel: 1661-1114\n"
		ls_header_data += "http://www.akplaza.com www.akmall.com\n"
//		ls_header_data += "Http://www.aktown.co.kr\n"
		ls_header_data +=  sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_header_data += '\r\n\r\n'
//기존소스 백업 (10.02.16)
//		ls_header_data += "새로운 생활의 즐거움! AK PLAZA\n"
//		ls_header_data += "항상 최고로 모시겠습니다.\r\n\r\n"	
		ls_header_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_header_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"								
	} else if($("#selBranch").val() == "02") {
		//수원점
		ls_header_data  = ls_escape + ls_font
		ls_header_data += "수원애경역사(주) 수원점\n"
		ls_header_data += "124-81-28579  김 재 천\n"
		ls_header_data += "경기도 수원시 팔달구 덕영대로 924\n"
		ls_header_data += "Tel: 1661-1114\n"	
		ls_header_data += "http://www.akplaza.com www.akmall.com\n"							
//		ls_header_data += "Http://www.aktown.co.kr\n"												
		//ls_header_data +=  f_setfill(sale_ymd,21,'R') + f_setfill(conversion_recpt_no,16,'L');
		ls_header_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_header_data += '\r\n\r\n'
//기존소스 백업 (10.02.16)			
//		ls_header_data += "새로운 생활의 즐거움! AK PLAZA\n"
//		ls_header_data += "항상 최고로 모시겠습니다.\r\n\r\n"	
		ls_header_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_header_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	}else if($("#selBranch").val() == "04") {
		//평택점
		ls_header_data  = ls_escape + ls_font
		ls_header_data += "평택역사(주) 평택점\n"
		ls_header_data += "125-81-24085  김 진 태\n"
		ls_header_data += "경기도 평택시 평택로 51\n"
		ls_header_data += "Tel: 1661-1114\n"	
		ls_header_data += "http://www.akplaza.com www.akmall.com\n"
		ls_header_data +=  sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_header_data += '\r\n\r\n'
		ls_header_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_header_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	}else if($("#selBranch").val() == "05") {
		//원주점
		ls_header_data  = ls_escape + ls_font
		ls_header_data += "에이케이에스앤디(주) AK원주점\n"
		ls_header_data += "224-85-23362  김 진 태\n"
		ls_header_data += "강원도 원주시 봉화로 1\n"
		ls_header_data += "Tel: 1661-1114\n"	
		ls_header_data += "http://www.akplaza.com www.akmall.com\n"
		ls_header_data +=  sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_header_data += '\r\n\r\n'
		ls_header_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_header_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"							
	}	
	if(result.IN_TYPE == "취소")
	{
		ls_header_data += ls_escape + ls_doublewide + "  [ 반 품 등 록 ]\n"
	}
	else
	{
		ls_header_data += ls_escape + ls_doublewide + "  [ 매 출 등 록 ]\n"
	}
	
	
	if(flag == "C") {
		if(ls_card_amt != "0") {
			ls_header_data += '           (고객용)\n'
		}
		ls_header_data += ls_escape + ls_normal                        	+ 
		'----------------------------------------\n'			+ 
		' 강좌명    수강료     재료비     합  계 \n' 				+	 
		'----------------------------------------\n'
	} else if(flag == "S") {
		ls_header_data += ls_escape + ls_normal                        	+ 
		'----------------------------------------\n'			+ 
		' 강좌명    수강료     재료비     합  계 \n' 				+	 
		'----------------------------------------\n'
/*						
		ls_header_data += '                   \n'	                	     	+ 
		ls_escape + ls_normal                            				+		 
		'----------------------------------------\n' 		+ 
		'----         카 드 전 표(M)         ----\n' 				+ 
		'----------------------------------------\n' 		+ 
		
		ls_escape + ls_doublewide                    				+
		result.CARD_NM + '\n'                  + 
		ls_escape + ls_normal                 					+ 
*/						
//		+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12) +  "                **/**" + '\r\n'               				+
/*						f_setfill(ls_approve_no, 25, 'R')            				+
		f_setfill(result.INST_MM, 15, 'L')        + '\n' 				+
		'----------------------------------------\n'*/
	} else if(flag == "A") {
		ls_header_data += ls_escape + ls_font                          	+
		ls_escape + ls_doublewide                    				+
		'           (매장용)\n'	                     					+
		ls_escape + ls_normal                        				+
		'                                        \n' 					+
		'POSNO       :' + f_setfill(ls_pos_no,  26, 'L') + '\n' 		+
		'판매원      :' + f_setfill(login_name, 24, 'L') + '\n' 		+
		'                                        \n' 					+
		'영수증 번호 :' + f_setfill(ls_recpt_no, 26, 'L') + '\n' 	+
		'전  표 번호 :' + f_setfill(ls_pos_no+ls_recpt_no, 26, 'L') + '\n' +
		'                                        \n' 					+
		' 강좌명    수강료     재료비     합  계 \n'
	}
}
function pos_footer(flag, json) {
	
	var result = JSON.parse(decodeURI(json));
	var sub_tot_fee = 0;
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/getCancelSubject",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			recpt_pos_no : result.POS_NO,
			period : result.PERIOD,
			sale_ymd : result.SALE_YMD,
			recpt_no : result.RECPT_NO
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result_this = JSON.parse(data);
			
			for(var i = 0; i < result_this.length; i++)
			{
				var regis_fee = result_this[i].UPRICE;
				var food_fee = result_this[i].FOOD_AMT;
				sub_tot_fee = sub_tot_fee + Number(regis_fee) + Number(food_fee);
			}
		}
	});
	ls_footer_data = "";
	ls_trade_all_amt 	= sub_tot_fee;
	//ls_enuri_amt 		= eval(getGridColumnSum(gridSub, "enuri_amt1")) + eval(getGridColumnSum(gridSub, "enuri_amt2"));
	ls_enuri_amt 		= result.ENURI_AMT;
	if(result.IN_TYPE == "취소")
	{
		ls_net_sale_amt 	= '-' + (ls_trade_all_amt - ls_enuri_amt);
		ls_get_sale_amt 	= '-' + result.TRADE_ALL_AMT;
	}
	else
	{
		ls_net_sale_amt 	= (ls_trade_all_amt - ls_enuri_amt);
		ls_get_sale_amt 	= result.TRADE_ALL_AMT;
	}
	ls_change			= result.CHANGE;
	ls_change			= ls_change == null || ls_change == "" ? 0 : parseInt(ls_change);
	
	// 카드 정보
	var ls_card_nm     		=	result.CARD_NM;
	var ls_card_no     		=	result.CARD_NO;
	var ls_halbu_no    		=	result.INST_MM;
	var ls_card_amt         =	result.CARD_AMT;	
	var ls_approve_no 		=	result.APPROVE_NO;
	
	var ls_bc_qr_value     = result.CARD_FG;	// bcqr 영수증 찍어주기 위해 - cmc
	
	// 모바일상품권 정보
	var ls_mc_approve_no1	= cancel_proc_mc_approve_no;				// 매출취소 직후 취소 승인번호
	var ls_mc_approve_no2	= result.MC_APPROVE_NO;	// 영수증출력 클릭 시 취소 승인번호
	var ls_mc_approve_no	= (ls_mc_approve_no1 == null || trim(ls_mc_approve_no1) == "") ? ls_mc_approve_no2 : ls_mc_approve_no1;
	
	var ls_mc_card_no		= result.MC_CARD_NO;		// 바코드번호
	var ls_mc_remain_amt	= cancel_proc_remain_amt;				// 잔액
	var ls_mc_card_amt		= result.MC_CARD_AMT;	// 승인금액
	ls_mc_card_amt			= (ls_mc_card_amt == null || trim(ls_mc_card_amt) == "") ? 0 : ls_mc_card_amt;
	
	// 에누리 영수증 표시금액(-1) 표시 (12.09.27) - 이장근 
	ls_v_enuri_amt = ls_enuri_amt * -1 ;
	// 일반 카드 결제시 C, S
	if(flag == "C") {
		ls_footer_data += '\r\n';
		ls_footer_data += ls_escape + ls_doublewide;
		
		// 부분입금, 중도수강은 결제금액으로 표시(12.10.04)
		if((result.PAY_FG == '부분입금')||(result.PAY_FG == '중도수강')) {
			ls_footer_data += '합    계 '  + f_setfill(comma(ls_net_sale_amt), 9, 'L') + '원\r\n';
		}else{
			if(result.IN_TYPE == "취소")
			{
				ls_footer_data += '합    계 '  + f_setfill(comma("-" + ls_trade_all_amt), 9, 'L') + '원\r\n';
			}
			else
			{
				ls_footer_data += '합    계 '  + f_setfill(comma(ls_trade_all_amt), 9, 'L') + '원\r\n';
			}
			
		}
		
		//ls_footer_data += '합    계 '  + f_setfill(comma(ls_trade_all_amt), 9, 'L') + '원\r\n'
		/*
		합계 → 에누리포함금액, 에누리 → (-)표시, 매 출 액 → 결제금액, 받 은 돈 → 지불금액 변경으로 기존소스백업 (12.09.27) - 이장근요청	
		ls_footer_data += '합    계 '  + f_setfill(comma(ls_net_sale_amt), 9, 'L') + '원\r\n'
		ls_footer_data += '에 누 리 ' + f_setfill(comma(ls_enuri_amt), 9, 'L')	+ '원\r\n' 
		ls_footer_data += '매 출 액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '받 은 돈 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'	
		*/
		ls_footer_data += '에 누 리 ' + f_setfill(comma(ls_v_enuri_amt), 9, 'L')	+ '원\r\n';
		ls_footer_data += '결제금액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n';
		ls_footer_data += '지불금액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n';
		ls_footer_data += '거스름돈 ' + f_setfill(comma(ls_change), 9, 'L')		+ '원\r\n';
		ls_footer_data += ls_escape + ls_normal;
		ls_footer_data += '----------------------------------------\r\n';

		// 모바일 상품권		2017.08.14 추가
		if(ls_mc_approve_no != null && ls_mc_approve_no != "") {
			ls_footer_data += "모바일상품권\r\n";
			ls_footer_data += "상품권:" + ls_mc_card_no + "\r\n";
			ls_footer_data += "승인:" + ls_mc_approve_no + "\r\n";
			ls_footer_data += f_setfill("",19,'R') + "청구금액:" +  f_setfill(comma('-'+ls_mc_card_amt), 10, 'L') + "원\r\n";
			
			if(remain_amt_flag) {
				ls_footer_data += f_setfill("",17,'R') + "상품권잔액:" +  f_setfill(comma(ls_mc_remain_amt), 10, 'L') + "원\r\n";
			}
			ls_footer_data += '\r\n';
		}

		// 카드일 때
		if(ls_approve_no != null && ls_approve_no != "") {
			var monthValue = "";

// -- 08.09.05 취소시 유통카드 출력경우 방지 수정(해선) --------------------
//						ls_footer_data += f_card_gubun_nm('name', ls_card_no) +'\r\n'
//						ls_footer_data += result.CARD_NM +'\r\n'
// 발행사 표기 추가(12.11.20)
			//ls_footer_data += ls_card_nm +  f_setfill(f_card_gubun_nm('state', ls_card_no),28,'L') +'\r\n'; 여전법 이후
			
			//cmc123456
			if(ls_bc_qr_value == "Q" || ls_bc_qr_value == "q" ) {
			// cmc - bcqr 결제 건 일시 영수증에 QR 추가
				ls_footer_data += ls_card_nm + "(QR)" + f_setfill('',22,'L') +'\r\n';
			}
			else {
				ls_footer_data += ls_card_nm +  f_setfill('',28,'L') +'\r\n';
			}
// ----------------------------------------------------------------------
	
			if(ls_halbu_no == "00") {
				monthValue = "일시불";
				ls_footer_data += f_setfill(monthValue,20,'R')+'\r\n';
			} else {
				monthValue = "할부 " + ls_halbu_no + "개월";
				ls_footer_data += f_setfill(monthValue,19,'R')+'\r\n';
			}							
			
			//ls_footer_data += f_setfill(comma('-'+ls_card_amt), 15, 'L') +'원\r\n'; 여전법 이후 카드금액 2번 나오는거 주석
//10.06.23(backup)		       ls_footer_data += '카드 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12) +  "         **/**" + '\r\n'
//여전법 이전			ls_footer_data += '카드번호:'+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12)  +  "       **/**" + '\r\n';

			ls_footer_data += '카드번호:'+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12)  +  "            " + '\r\n'; //유효기간삭제
			if(result.IN_TYPE == "취소")
			{
				ls_footer_data += '승인번호:'+ ls_approve_no +'  '+'청구금액:'+f_setfill(comma('-'+ls_card_amt),10,'L')+'원';
			}
			else
			{
				ls_footer_data += '승인번호:'+ ls_approve_no +'  '+'청구금액:'+f_setfill(comma(ls_card_amt),10,'L')+'원';
			}
			
			ls_footer_data += '\r\n';
		}

		// 카드+현금일때...
		if(ls_cash_amt != null && ls_cash_amt != ""&& ls_cash_amt != "0") {
			ls_footer_data += ls_escape + ls_normal;
			ls_footer_data += "현     금" + f_setfill(comma('-'+ ls_cash_amt.toString()), 29,'L') +'원\r\n';
			ls_footer_data += ls_escape + ls_normal;
		}
		//2019.04.18 원영수증 포멧(매상등록)에 맞추기위해 위치변경 START
		//AKmembers 차감 기록 출력
		
		if(cancle_proc_point_approve_no != "" 
		   || nullChk(result.AKMEM_APPROVE_NO) != "")  //2019.04.29 ljs 취소후 영수증출력시 마일리지 정보가 있는 경우
		{
			ls_footer_data += getPrint_AKmembers(json);
		}
		//2019.04.18 원영수증 포멧(매상등록)에 맞추기위해 위치변경 END
		// 현금영수증일때
		if(ls_aprv_no != null && ls_aprv_no != ""&& ls_aprv_no != "N") {
			var ls_cust_mark = "";

			if(ls_id_fg == "1") {
				//10.06.23(backup) ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 8) + "-****-"+ ls_id_no.substring(12);
				ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 6) + "**-****-"+ls_id_no.substring(12);
			} else if(ls_id_fg == "2") {
				ls_cust_mark = Left(ls_id_no, trim(ls_id_no).length - 4) + "****";
			} else if(ls_id_fg == "3") {
				ls_cust_mark  = ls_id_no.substring(0, 6) + "-*******";
			} else if(ls_id_fg == "4") {
				ls_cust_mark  = ls_id_no;
			}

			if(ls_issue_fg == "1") {
				ls_issue_fg = "소득공제";
			} else if(ls_issue_fg == "2")  {
				ls_issue_fg = "지출공제";
			}

			ls_footer_data = ls_footer_data.substring(0, ls_footer_data.lastIndexOf("\r\n"));
			ls_footer_data += '----------------------------------------\r\n';
			ls_footer_data += ls_escape + ls_doublewide
			ls_footer_data += "-- 현금(" + ls_issue_fg + ") --\r\n" 
			ls_footer_data += ls_escape + ls_normal
			ls_footer_data += '              ( 고  객  용 )            \r\n'

			if(trim(ls_id_no) == '0100001234') {
				ls_footer_data += '식별번호:' + ls_cust_mark + '(국세청 지정코드)' + '\r\n'
			} else {
				ls_footer_data += '식별번호:' + ls_cust_mark + '\r\n'
			}

			//ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+ls_cash_amt)+ '원\r\n'
			
			//AK기프트(555), 홈플러스(666)카드 추가
			if ((ls_card_fg == "555") || (ls_card_fg == "666")) {
				ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+ls_send_amt)+ '원\r\n';
			}else {	 //2019.04.30 ljs 현금영수증제외대상금액 추가	
				ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+(eval(ls_cash_amt) + eval(ls_mc_card_amt) - eval(ls_cashrec_ext_amt)))+ '원\r\n';
			}
			
			ls_footer_data += '----------------------------------------\r\n' 
			ls_footer_data += ' 현금영수증 문의: ☏ 1544-2020\r\n'
			ls_footer_data += ' http://www.현금영수증.kr\r\n'
		}
		ls_footer_data += '----------------------------------------\r\n';
		ls_footer_data = ls_footer_data.substring(0, ls_footer_data.lastIndexOf("\r\n"));


		//ls_footer_data += "총강좌수 : "+ getGridTotalRows(gridSub) + "\r\n\r\n"
		
		// 모바일 상품권일 경우 문구추가
		if(ls_mc_approve_no != null && ls_mc_approve_no != ""){
			ls_footer_data += f_setfill("",2,'R') + "※ AK 모바일상품권 잔액환불 문의 : \r\n";
			ls_footer_data += f_setfill("",5,'R') + "갤럭시아컴즈 고객센터 ☎ 1566-0123 \r\n";
			ls_footer_data += f_setfill("",5,'R') + "(운영시간 : 평일 09시 ~ 18시 / \r\n";
			ls_footer_data += f_setfill("",18,'R') + "주말 및 공휴일 휴무)\r\n\r\n";
		}
		
		//현금 영수증 자진발급제 일때 보여주기!
		if(trim(ls_id_no) == "0100001234") {
			ls_footer_data += "본 영수증은 국세청 현금 영수증 자진\n"
			ls_footer_data += "발급제 시행에 따라 발급된 영수증으로써\n"
			ls_footer_data += "개인 소득공제 및 지출증빙은 국세청에서\n"
			ls_footer_data += "신청할 수 있습니다.\r\n\r\n"
		}
		
		ls_footer_data += f_setfill(sale_time,16,'R');
		if($("#selBranch").val() == "01"){
			ls_footer_data += "전화번호:02-818-0895\n" 
		}else if($("#selBranch").val() == "02"){
			ls_footer_data += "전화번호:031-240-0523\n"
		}else if($("#selBranch").val() == "03"){
			ls_footer_data += "전화번호:031-779-3810\n" 
		}else if($("#selBranch").val() == "04"){
			ls_footer_data += "전화번호:031-615-1050\n"
		}else if($("#selBranch").val() == "05"){
			ls_footer_data += "전화번호:033-811-5001\n"
		}
		
		ls_footer_data += f_setfill('담당자: '+ login_name,34,'L') + "\n"
	
	// Card 수거용
	} else if(flag == "S") {
		ls_footer_data += '\r\n'
		ls_footer_data += ls_escape + ls_doublewide
		/* 합    계→ 에누리 포함금액, 에누리 → (-)표시, 매출액 → 합계, 에누리포함금액 변경으로 기존소스백업 (12.09.27) - 이장근요청
		ls_footer_data += '매 출 액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '에 누 리 ' + f_setfill(comma(ls_enuri_amt), 9, 'L')		+ '원\r\n'
		*/
		
		//ls_footer_data += '합    계 ' + f_setfill(comma(ls_trade_all_amt), 9, 'L')	+ '원\r\n'
		
		// 부분입금, 중도수강은 결제금액으로 표시(12.10.04)
		if((result.PAY_FG == '부분입금')||(result.PAY_FG == '중도수강')) {
			ls_footer_data += '합    계 '  + f_setfill(comma(ls_card_amt), 9, 'L') + '원\r\n'
		}else{
			ls_footer_data += '합    계 '  + f_setfill(comma("-" + ls_trade_all_amt), 9, 'L') + '원\r\n'
		}						
		
		ls_footer_data += '에 누 리 ' + f_setfill(comma(ls_v_enuri_amt), 9, 'L')	+ '원\r\n';
		ls_footer_data += '카 드 액 ' + f_setfill(comma('-' + ls_card_amt), 9, 'L')		+ '원\r\n';
		ls_footer_data += '청 구 액 ' + f_setfill(comma('-' + ls_card_amt), 9, 'L')		+ '원\r\n';
		ls_footer_data += ls_escape + ls_normal;
		//////////////////////////////////////////
		ls_footer_data += '----------------------------------------\n';
		ls_footer_data += '----         카 드 전 표            ----\n';
		ls_footer_data += '----------------------------------------\n';
		ls_footer_data += ls_escape + ls_doublewide;
//		result.CARD_NM + '\n' + 
		// ls_footer_data += f_card_gubun_nm('name', ls_card_no) + '\r\n'; 여전법 이전
		
		//cmc123456
		if(ls_bc_qr_value == "Q" || ls_bc_qr_value == "q") {
		// cmc - bcqr 결제 건 일시 영수증에 QR 추가
			ls_footer_data += ls_card_nm + "(QR)" + '\r\n';
		}
		else {
			ls_footer_data += ls_card_nm + '\r\n';
		}

		if(result.INST_MM == "00") {
			monthValue = "일시불";
			monthValue = f_setfill(monthValue,15,'L');
		} else {
			monthValue = "할부 " + result.INST_MM + "개월";
			monthValue = f_setfill(monthValue,14,'L');
		}
		
		ls_footer_data += ls_escape + ls_normal;
		
		//ls_footer_data += '카드번호 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12) + "     **/**" + "\r\n" 여전법이전
		ls_footer_data += '카드번호 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12) + "\r\n" //여전법 이후 유효기간 삭제 
		ls_footer_data += '승인번호 : '+ ls_approve_no +'   '+ monthValue + "\r\n"
		
		ls_footer_data += '----------------------------------------\r\n';
		ls_footer_data += '고객서명 :                              \r\n\r\n';
		ls_footer_data += '----------------------------------------\r\n';

		ls_footer_data += f_setfill(sale_time,16,'R');
		if($("#selBranch").val() == "01"){
			ls_footer_data += "전화번호:02-818-0895\n" 
		}else if($("#selBranch").val() == "02"){
			ls_footer_data += "전화번호:031-240-0523\n"
		}else if($("#selBranch").val() == "03"){
			ls_footer_data += "전화번호:031-779-3810\n" 
		}else if($("#selBranch").val() == "04"){
			ls_footer_data += "전화번호:031-615-1050\n"
		}else if($("#selBranch").val() == "05"){
			ls_footer_data += "전화번호:033-811-5001\n"
		}
		
		ls_footer_data += f_setfill('담당자: '+ login_name,34,'L') + "\n"

		ls_footer_data += '----------------------------------------\r\n' 
		ls_footer_data += '취소사유 : \n'
		ls_footer_data += 'S M 확인 : \n'
		
	//현금
	} else if(flag == "A") {
		ls_footer_data += '\r\n'
		ls_footer_data += ls_escape + ls_doublewide
		/* 합계 →  에누리포함금액, 에누리 → (-) 표시금액, 매 출 액 → 결제금액, 받 은 돈 → 지불금액 변경으로 기존소스백업 (12.09.27) - 이장근요청
		ls_footer_data += '합    계 '  + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '에 누 리 ' + f_setfill(comma(ls_enuri_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '매 출 액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '받 은 돈 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'	
		*/
		//ls_footer_data += '합    계 '  + f_setfill(comma(ls_trade_all_amt), 9, 'L') + '원\r\n'
		
		// 부분입금, 중도수강은 결제금액으로 표시(12.10.02)
		if((result.PAY_FG == '부분입금')||(result.PAY_FG == '중도수강')) {
			ls_footer_data += '합    계 '  + f_setfill(comma(ls_net_sale_amt), 9, 'L') + '원\r\n'
		}else{
			if(result.IN_TYPE == "취소")
			{
				ls_footer_data += '합    계 '  + f_setfill(comma("-" + ls_trade_all_amt), 9, 'L') + '원\r\n'
			}
			else
			{
				ls_footer_data += '합    계 '  + f_setfill(comma(ls_trade_all_amt), 9, 'L') + '원\r\n'
			}
		}
		
		ls_footer_data += '에 누 리 ' + f_setfill(comma(ls_v_enuri_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '결제금액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '지불금액 ' + f_setfill(comma(ls_net_sale_amt), 9, 'L')	+ '원\r\n'
		ls_footer_data += '거스름돈 ' + f_setfill(comma(ls_change), 9, 'L')		+ '원\r\n'
		ls_footer_data += ls_escape + ls_normal
		ls_footer_data += '----------------------------------------\r\n' ;

		// 모바일 상품권		2017.08.14 추가
		if(ls_mc_approve_no != null && ls_mc_approve_no != "") {
			ls_footer_data += "모바일상품권\r\n";
			ls_footer_data += "상품권:" + ls_mc_card_no + "\r\n";
			ls_footer_data += "승인:" + ls_mc_approve_no + "\r\n";
			ls_footer_data += f_setfill("",19,'R') + "청구금액:" +  f_setfill(comma('-'+ls_mc_card_amt), 10, 'L') + "원\r\n";
			
			if(remain_amt_flag) {
				ls_footer_data += f_setfill("",17,'R') + "상품권잔액:" +  f_setfill(comma(ls_mc_remain_amt), 10, 'L') + "원\r\n";
			}
			ls_footer_data += '\r\n';
		}
		
		// 카드결제이면...
		if(ls_card_no != null && ls_card_no != "") {

			var monthValue = "";
//-- 08.09.05 취소시 유통카드 출력경우 방지 수정(해선) --------------------
//			ls_footer_data += f_card_gubun_nm('name', ls_card_no) +'\r\n'
//			ls_footer_data += result.CARD_NM +'\r\n'
//발행사 표기 추가(12.11.20)
			//ls_footer_data += result.CARD_NM +  f_setfill(f_card_gubun_nm('state', ls_card_no),28,'L') +'\r\n'

			//cmc123456
			if(ls_bc_qr_value == "Q" || ls_bc_qr_value == "q" ) {
			// cmc - bcqr 결제 건 일시 영수증에 QR 추가
				ls_footer_data += result.CARD_NM + "(QR)" + f_setfill('',28,'L') +'\r\n'
			}
			else {
				ls_footer_data += result.CARD_NM +  f_setfill('',28,'L') +'\r\n'
			}
//----------------------------------------------------------------------

			if(result.INST_MM == "00") {
				monthValue = "일시불";
				ls_footer_data += f_setfill(monthValue,20,'R')+  '\r\n';
			} else {
				monthValue = "할부 " + result.INST_MM + "개월";
				ls_footer_data += f_setfill(monthValue,19,'R')+  '\r\n';
			}							
			
			//ls_footer_data += f_setfill(comma('-'+ls_card_amt), 15, 'L') +'원\r\n' 여전법이후 금액표시 삭제
			//10.06.23 (backup) ls_footer_data += '카드 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12) +  "         **/**" + '\r\n'												
			//ls_footer_data += '카드 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 8) + "-****-" + ls_card_no.substring(12) +  "         **/**" + '\r\n'
			ls_footer_data += '카드 : '+ ls_card_no.substring(0, 4) + "-" + ls_card_no.substring(4, 6) + "**-****-" + ls_card_no.substring(12) +  '\r\n';//여전법이후 유효기간 삭제
			if(result.IN_TYPE == "취소")
			{
				ls_footer_data += '승인 : '+ ls_approve_no +'    '+'청구금액:'+f_setfill(comma('-'+ls_card_amt),10,'L')+'원'
			}
			else
			{
				ls_footer_data += '승인 : '+ ls_approve_no +'    '+'청구금액:'+f_setfill(comma(ls_card_amt),10,'L')+'원'
			}
			ls_footer_data += '\r\n'
		}

		// 카드+현금일때...
		if(ls_cash_amt != null && ls_cash_amt != ""&& ls_cash_amt != "0") {
			ls_footer_data += ls_escape + ls_normal
			ls_footer_data += "현     금" + f_setfill(comma('-'+ls_cash_amt.toString()), 29,'L') +'원\r\n'
			ls_footer_data += ls_escape + ls_normal
			/*
			if(ls_aprv_no != null && ls_aprv_no != ""&& ls_aprv_no != "N") {
				ls_footer_data += '----------------------------------------\r\n' 
			}*/
		}
		//2019.04.30 ljs 매상등록 영수증포멧 변경으로 위치변경 START
		//AKmembers 차감 기록 출력
		if(cancle_proc_point_approve_no != ""
		  || result.AKMEM_APPROVE_NO != "")  //2019.04.29 ljs 취소후 영수증출력시 마일리지 정보가 있는 경우
		{
			ls_footer_data += getPrint_AKmembers(json);
		}
		//2019.04.30 ljs 매상등록 영수증포멧 변경으로 위치변경 END
		// 현금영수증일때
		if(ls_aprv_no != null && ls_aprv_no != ""&& ls_aprv_no != "N") {
			var ls_cust_mark = "";

			if(ls_id_fg == "1") {
			//10.06.23 (backup) ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 8) + "-****-" + ls_id_no.substring(12);
				ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 8) + "-****-" + ls_id_no.substring(12);
			} else if(ls_id_fg == "2") {
				ls_cust_mark = Left(ls_id_no, trim(ls_id_no).length - 4) + "****";
			} else if(ls_id_fg == "3") {
				ls_cust_mark  = ls_id_no.substring(0, 6) + "-*******";
			} else if(ls_id_fg == "4") {
				ls_cust_mark  = ls_id_no;
			}

			if(ls_issue_fg == "1") {
				ls_issue_fg = "소득공제";
			} else if(ls_issue_fg == "2")  {
				ls_issue_fg = "지출공제";
			}

			ls_footer_data = ls_footer_data.substring(0, ls_footer_data.lastIndexOf("\r\n"));
			ls_footer_data += '----------------------------------------\r\n' 
			ls_footer_data += ls_escape + ls_doublewide
			ls_footer_data += "-- 현금(" + ls_issue_fg + ") --\r\n" 
			ls_footer_data += ls_escape + ls_normal
			ls_footer_data += '              ( 고  객  용 )            \r\n'

			if(trim(ls_id_no) == '0100001234') {
				ls_footer_data += '식별번호:' + ls_cust_mark + '(국세청 지정코드)' + '\r\n'
			} else {
				ls_footer_data += '식별번호:' + ls_cust_mark + '\r\n'
			}						

			//ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+ls_cash_amt)+ '원\r\n'
			
			//AK기프트(555), 홈플러스(666)카드 추가
			if ((ls_card_fg == "555") || (ls_card_fg == "666")) {
				ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+ls_send_amt)+ '원\r\n'
			}else {	 //2019.04.30 ljs 현금영수증제외대상금액 추가
				ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+(eval(ls_cash_amt) + eval(ls_mc_card_amt) - eval(ls_cashrec_ext_amt)))+ '원\r\n'
			}
			
			ls_footer_data += '----------------------------------------\r\n' 
			ls_footer_data += ' 현금영수증 문의: ☏ 1544-2020\r\n'
			ls_footer_data += ' http://www.현금영수증.kr\r\n'
		}
		ls_footer_data += '----------------------------------------\r\n';
		ls_footer_data = ls_footer_data.substring(0, ls_footer_data.lastIndexOf("\r\n"));
		
		
		//ls_footer_data += '----------------------------------------\r\n';
		//ls_footer_data += "총강좌수 : "+ getGridTotalRows(gridSub) + "\r\n\r\n"
		
		// 모바일 상품권일 경우 문구추가
		if(ls_mc_approve_no != null && ls_mc_approve_no != ""){
			ls_footer_data += f_setfill("",2,'R') + "※ AK 모바일상품권 잔액환불 문의 : \r\n";
			ls_footer_data += f_setfill("",5,'R') + "갤럭시아컴즈 고객센터 ☎ 1566-0123 \r\n";
			ls_footer_data += f_setfill("",5,'R') + "(운영시간 : 평일 09시 ~ 18시 / \r\n";
			ls_footer_data += f_setfill("",18,'R') + "주말 및 공휴일 휴무)\r\n\r\n";
		}
		
		//현금 영수증 자진발급제 일때 보여주기!
		if(trim(ls_id_no) == "0100001234") {
			ls_footer_data += "본 영수증은 국세청 현금 영수증 자진\n"
			ls_footer_data += "발급제 시행에 따라 발급된 영수증으로써\n"	
			ls_footer_data += "개인 소득공제 및 지출증빙은 국세청에서\n"	
			ls_footer_data += "신청할 수 있습니다.\r\n\r\n"			
		}

//		ls_footer_data += ls_escape + ls_doublewide
//		ls_footer_data += '==== [현금반품] ====\n'						
//		ls_footer_data += '          ( 경리용 )\n'						
//		ls_footer_data += ls_escape + ls_normal							
//		ls_footer_data += '----------------------------------------\n'	
//		ls_footer_data += '영업부서        담당:       과장:       \n\n'
//		ls_footer_data += '경    리        담당:       과장:       \n'	
//		ls_footer_data += '취소사유                                \n\n'
//		ls_footer_data += '구매일자       년    월    일           \n\n'
//		ls_footer_data += '고객성명                                \n'	
//		ls_footer_data += '========================================\n'	
//		ls_footer_data += '주    소                                \n'	
//		ls_footer_data += '========================================\n'	
//		ls_footer_data += '전화번호                                \n'	
//		ls_footer_data += '----------------------------------------\n'	
//		
		ls_footer_data += f_setfill(sale_time,16,'R');
		if($("#selBranch").val() == "01"){
			ls_footer_data += "전화번호:02-818-0895\n" 
		}else if($("#selBranch").val() == "02"){
			ls_footer_data += "전화번호:031-240-0523\n"
		}else if($("#selBranch").val() == "03"){
			ls_footer_data += "전화번호:031-779-3810\n" 
		}else if($("#selBranch").val() == "04"){
			ls_footer_data += "전화번호:031-615-1050\n"
		}else if($("#selBranch").val() == "05"){
			ls_footer_data += "전화번호:033-811-5001\n"
		}
		
		else{
			ls_footer_data += "전화번호:031-615-1050\n"
		}
		ls_footer_data += f_setfill('담당자: '+ login_name,34,'L') + "\n"
	} else if(flag == "B") {
		ls_footer_data += '\n취소금액' + f_setfill("-" + comma(eval(ls_cash_amt) + eval(ls_mc_card_amt)),30,'L')+'원\n';
		ls_footer_data += '----------------------------------------\n';
		// 현금영수증일때
		if(ls_aprv_no != null && ls_aprv_no != ""&& ls_aprv_no != "N") {
			var ls_cust_mark = "";

			if(ls_id_fg == "1") {
				//10.06.23 (backup) ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 8) + "-****-" + ls_id_no.substring(12);
				ls_cust_mark = ls_id_no.substring(0, 4) + "-" + ls_id_no.substring(4, 8) + "-****-" + ls_id_no.substring(12);
			} else if(ls_id_fg == "2") {
				ls_cust_mark = Left(ls_id_no, trim(ls_id_no).length - 4) + "****";
			} else if(ls_id_fg == "3") {
				ls_cust_mark  = ls_id_no.substring(0, 6) + "-*******";
			} else if(ls_id_fg == "4") {
				ls_cust_mark  = ls_id_no;
			}

			if(ls_issue_fg == "1") {
				ls_issue_fg = "소득공제";
			} else if(ls_issue_fg == "2")  {
				ls_issue_fg = "지출공제";
			}

			ls_footer_data += ls_escape + ls_doublewide
			ls_footer_data += "-- 현금(" + ls_issue_fg + ") --\r\n" 
			ls_footer_data += ls_escape + ls_normal
			ls_footer_data += '              ( 고  객  용 )            \r\n'

			if(trim(ls_id_no) == '0100001234') {
				ls_footer_data += '식별번호:' + ls_cust_mark + '(국세청 지정코드)' + '\r\n'
			} else {
				ls_footer_data += '식별번호:' + ls_cust_mark + '\r\n'
			}						
			
			//ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+ls_cash_amt)+ '원\r\n'
			
			//AK기프트(555), 홈플러스(666)카드 추가
			if ((ls_card_fg == "555") || (ls_card_fg == "666")) {
				ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+ls_send_amt)+ '원\r\n'
			}else {	 //2019.04.30 ljs 현금영수증제외대상금액 추가
				ls_footer_data += '승인번호:' + ls_aprv_no + '  인정금액:' + comma('-'+(eval(ls_cash_amt) + eval(ls_mc_card_amt) - eval(ls_cashrec_ext_amt)))+ '원\r\n'
			}
			
			ls_footer_data += '----------------------------------------\r\n' 
			ls_footer_data += ' 현금영수증 문의: ☏ 1544-2020\r\n'
			ls_footer_data += ' http://www.현금영수증.kr\r\n'
		}
		ls_footer_data += '----------------------------------------\r\n';
		ls_footer_data = ls_footer_data.substring(0, ls_footer_data.lastIndexOf("\r\n"));
		
		//ls_footer_data += "총강좌수 : "+ getGridTotalRows(gridSub) + "\r\n\r\n";
		
		//현금 영수증 자진발급제 일때 보여주기!
		if(trim(ls_id_no) == "0100001234") {
			ls_footer_data += "본 영수증은 국세청 현금 영수증 자진\n";
			ls_footer_data += "발급제 시행에 따라 발급된 영수증으로써\n";
			ls_footer_data += "개인 소득공제 및 지출증빙은 국세청에서\n";
			ls_footer_data += "신청할 수 있습니다.\r\n\r\n";
		}
			
		sale_ymd = sale_ymd.substring(0, 5) + " " + sale_ymd.substring(5, 8) + " " + sale_ymd.substring(8, 11);
			
		ls_footer_data += ls_escape + ls_normal;
		ls_footer_data += '----------------------------------------\n';	
		ls_footer_data += '취소일자:' + f_setfill(sale_ymd,19,'R') + '\n';	
		ls_footer_data += '========================================\n';
		ls_footer_data += '구매일자:      년  월  일   요일        \n';
		ls_footer_data += '----------------------------------------\n';
	}
}
function getPrint_AKmembers(json){
	var result = JSON.parse(decodeURI(json));
	var data = '';
	 //2019.04.29 ljs 취소후 영수증출력시 마일리지 정보가 있는 경우
    if(nullChk(result.AKMEM_APPROVE_NO) != "")
	{
		var ls_memcard_no  = result.AKMEM_CARD_NO;
		var ls_akmem_custno = result.AKMEM_CUST_NO;
		var ls_akmem_approve_no = result.AKMEM_APPROVE_NO;
		var ls_akmem_recpt_point = result.AKMEM_RECPT_POINT; 
		var ls_akmem_use_point = result.AKMEM_USE_POINT;
		var ls_card_in_amt = result.CARD_IN_AMT; 
		
		data += '----------------------------------------\r\n' 
		data += "AK멤버스 카드번호 :  " + ls_memcard_no.substring(0, 4) + "-" + ls_memcard_no.substring(4, 6) + "**-****-" + ls_memcard_no.substring(12) +'\r\n' //여전법이후
		data += "AK멤버스 회원번호 :  " + ls_akmem_custno +'\r\n'
		data += "AK멤버스 승인번호 :  " + ls_akmem_approve_no +'\r\n'						
		data += "AK멤버스 차감 마일리지 : " + f_setfill('-'+comma(ls_akmem_recpt_point), 13,'L') +'점\r\n'
		data += "AK멤버스 환급 마일리지 : " + f_setfill(comma(ls_akmem_use_point), 13,'L') +'점\r\n'
		data += "AK멤버스 누적 마일리지 : "  + f_setfill(comma(ls_card_in_amt), 13,'L') +'점\r\n'
	}
//	else
//	{
//		var ls_memcard_no  = $("#card_no").val();
//		data += '----------------------------------------\r\n' 
//		//10.06.23 (backup) data += "AK멤버스 카드번호 :  " + cardno_split(model.getValue("/root/res/akmem_data/card_no")) +'\r\n'
//		//여전법이전    data += "AK멤버스 카드번호 :  " + ls_memcard_no.substring(0, 4) + "-" + ls_memcard_no.substring(4, 8) + "-****-" + ls_memcard_no.substring(12) +'\r\n'
//		data += "AK멤버스 카드번호 :  " + ls_memcard_no.substring(0, 4) + "-" + ls_memcard_no.substring(4, 6) + "**-****-" + ls_memcard_no.substring(12) +'\r\n' //여전법이후
//		data += "AK멤버스 회원번호 :  " + model.getValue("/root/res/akmem_data/akmem_custno") +'\r\n'
//		data += "AK멤버스 승인번호 :  " + cancle_proc_point_save_approve_no_pos +'\r\n'						
//		data += "AK멤버스 차감 마일리지 : " + f_setfill('-'+comma(cancle_proc_recpt_point), 13,'L') +'점\r\n'
//		//2019.04.10 ljs 사용마일리지 환급
//		data += "AK멤버스 환급 마일리지 : " + f_setfill(comma(model.getValue("/root/res/akmem_data/akmem_use_point")), 13,'L') +'점\r\n'
//		data += "AK멤버스 누적 마일리지 : "  + f_setfill(comma(cancle_proc_point_save_approve_point), 13,'L') +'점\r\n'
//		//data += '----------------------------------------\r\n' 	
//	}
	return data;
}	

function chgCoupon(chg, idx)
{
	if(chg == "coupon_fg") {
		if($("#couponLayer_coupon_fg"+idx).val() == 0
		|| $("#couponLayer_coupon_fg"+idx).val() == 7 ) // 2019.03.11 ljs : 증정용 추가
		{
			$("#couponLayer_coupon_cd"+idx).addClass("inputDisabled");
			$("#couponLayer_coupon_cd"+idx).attr("readOnly", true);
			$("#couponLayer_face_amt"+idx).val('');
			$("#couponLayer_coupon_cd"+idx).val('');
		} else {
			//alert("[홈플러스 상품권]은 2017년 6월30일 이후로 사용할수 없습니다.")
			$("#couponLayer_coupon_cd"+idx).removeClass("inputDisabled");
			$("#couponLayer_coupon_cd"+idx).attr("readOnly", false);
		}
	//권종구분 선택시 액면금액에 금액 자동으로 뿌려주기
	} else if(chg == "coupon_cd") {
		switch($("#couponLayer_coupon_cd"+idx).val()) {
		case "02" :
			$("#couponLayer_face_amt"+idx).val(2000);
			break;
		case "03" :
			$("#couponLayer_face_amt"+idx).val(3000);
			break;
		case "05" :
			$("#couponLayer_face_amt"+idx).val(5000);
			break;
		case "11" :
			$("#couponLayer_face_amt"+idx).val(10000);
			break;
		case "13" :
			$("#couponLayer_face_amt"+idx).val(30000);
			break;
		case "15" :
			$("#couponLayer_face_amt"+idx).val(50000);
			break;
		case "17" :
			$("#couponLayer_face_amt"+idx).val(70000);
			break;
		case "21" :
			$("#couponLayer_face_amt"+idx).val(100000);
			break;
		case "23" :
			$("#couponLayer_face_amt"+idx).val(300000);
			break;
		case "25" :
			$("#couponLayer_face_amt"+idx).val(500000);
			break;
		default :
		break;
		}
		
//		if(pay_fg.value == "cash" || pay_fg.value == "card_coupon" || pay_fg.value == "mcoupon") {
//			pay_fg.dispatch("xforms-value-changed");
//		}
		
	//상품권 번호 값이 변경되었을 경우
	} else {
		//상품권 번호가 변경되었을 때 만약 자사 상품권 이라면 번호를 통해 액면가와 권종구분 자동 셋팅해줌.
		if($("#couponLayer_coupon_fg"+idx).val() == 0
		|| $("#couponLayer_coupon_fg"+idx).val() == 7 )  //2019.03.11 ljs : 증정 상품권 추가
		{
			var couponNo = $("#couponLayer_coupon_no"+idx).val();
			
			if(couponNo.length == "13") {
				
				$.ajax({
					type : "POST", 
					url : "/member/lect/getCpConvert",
					dataType : "text",
					async:false,
					cache : false,
					data : 
					{
						coupon_no : couponNo
					},
					error : function() 
					{
						console.log("AJAX ERROR");
					},
					success : function(data) 
					{
						$("#couponLayer_coupon_no"+idx).val(data);
						couponNo = $("#couponLayer_coupon_no"+idx).val();
					}
				});
				//상품권 변환
			}
			
			//구권일경우
			if(Left(couponNo, 1) == '9') {
				switch(couponNo.substring(4, 7)) {
					case "010" :
						$("#couponLayer_coupon_cd"+idx).val("11");
						$("#couponLayer_face_amt"+idx).val(10000);
						break;
					case "030" :
						$("#couponLayer_coupon_cd"+idx).val("13");
						$("#couponLayer_face_amt"+idx).val(30000);
						break;
					case "050" :
						$("#couponLayer_coupon_cd"+idx).val("15");
						$("#couponLayer_face_amt"+idx).val(50000);
						break;
					case "070" :
						$("#couponLayer_coupon_cd"+idx).val("17");
						$("#couponLayer_face_amt"+idx).val(70000);
						break;
					case "100" :
						$("#couponLayer_coupon_cd"+idx).val("21");
						$("#couponLayer_face_amt"+idx).val(100000);
						break;
					case "300" :
						$("#couponLayer_coupon_cd"+idx).val("23");
						$("#couponLayer_face_amt"+idx).val(300000);
						break;
					case "500" :
						$("#couponLayer_coupon_cd"+idx).val("25");
						$("#couponLayer_face_amt"+idx).val(500000);
						break;
				}
			//신권일경우
			} else {
				switch(couponNo.substring(4, 6)) {
					case "05" :
						$("#couponLayer_coupon_cd"+idx).val("05");
						$("#couponLayer_face_amt"+idx).val(5000);
						break;
					case "11" :
						$("#couponLayer_coupon_cd"+idx).val("11");
						$("#couponLayer_face_amt"+idx).val(10000);
						break;
					case "13" :
						$("#couponLayer_coupon_cd"+idx).val("13");
						$("#couponLayer_face_amt"+idx).val(30000);
						break;
					case "15" :
						$("#couponLayer_coupon_cd"+idx).val("15");
						$("#couponLayer_face_amt"+idx).val(50000);
						break;
					case "17" :
						$("#couponLayer_coupon_cd"+idx).val("17");
						$("#couponLayer_face_amt"+idx).val(70000);
						break;
					case "21" :
						$("#couponLayer_coupon_cd"+idx).val("21");
						$("#couponLayer_face_amt"+idx).val(100000);
						break;
					case "23" :
						$("#couponLayer_coupon_cd"+idx).val("23");
						$("#couponLayer_face_amt"+idx).val(300000);
						break;
					case "25" :
						$("#couponLayer_coupon_cd"+idx).val("25");
						$("#couponLayer_face_amt"+idx).val(500000);
						break;
				}
			}
			
			/**
			 * 상품권 마스터 테이블에서 실제로 자료가 있는지 검색한다.
			 */
			
			$.ajax({
				type : "POST", 
				url : "/member/lect/getCpInfo",
				dataType : "text",
				async:false,
				cache : false,
				data : 
				{
					store : $("#selBranch").val(),
					coupon_no : $("#couponLayer_coupon_no"+idx).val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					var result = JSON.parse(data);
					//상품권 에러처리
					var coupon_stat = result.COUPON_STAT;
					/* 자사 상품권 유효기간 5년 경과 강제회수작업으로 (~10.03.31) 교환처리 안내추가 (10.03.31)  */
					var coupon_gubun = result.COUPON_GUBUN;
					var callbk_dept = result.CALLBK_DEPT;
					
					//2019.03.11 ljs : 증정상품권인 경우 자동으로 구분 셋팅, 부가세제외비율,현금영수증대상여부, 현금영수증미대상금액 필드 추가 START
					var cashrec_yn = result.CASHREC_YN;
					var vat_cal_ext_rate = result.VAT_CAL_EXT_RATE;
					var vat_cal_rate = 100;
					
					//alert("vat_cal_ext_rate[" + model.getValue("/root/res/coupon_info/vat_cal_ext_rate") + "]");
							  
					//행사정보마스터(BEMASTTB) 테이블에 없는 경우 현금영수증대상금액 100%(자사상품권 타사사용)로 간주
					if(vat_cal_ext_rate == null && trim(vat_cal_ext_rate) == "")
					{
						vat_cal_ext_rate = 0;
						vat_cal_rate = 100;
					}
					else
					{
						vat_cal_rate = 100 - vat_cal_ext_rate;
					}
					
					//증정상품권인 경우 자동으로 구분 셋팅
					if(coupon_gubun == 7)
					{
						$("#couponLayer_coupon_fg"+idx).val(coupon_gubun);
					}

					$("#couponLayer_cashrec_yn"+idx).val(cashrec_yn);
					$("#couponLayer_vat_cal_ext_rate"+idx).val(vat_cal_ext_rate);
					$("#couponLayer_vat_cal_rate"+idx).val(vat_cal_rate);
					//2019.03.11 ljs : 증정상품권인 경우 자동으로 구분 셋팅, 부가세제외비율,현금영수증대상여부, 현금영수증미대상금액 필드 추가 END

					if(coupon_stat == null || coupon_stat == '' ) {
						alert("존재하지 않는 상품권 번호입니다.");
						return false;
					}
					
					// 상품권 체크 보완 김남준 주임(2015.01.08) 
					if(coupon_gubun == "1" || coupon_gubun == "5" || coupon_gubun == "9")
					{
						alert("유효기간(5년)경과, 상품권데스크 교환요망");
						return false; 
					}
					
					// 기존소스백업 (2013.06.17)if(coupon_stat == "2" ) {
					// 상품권 체크 보완 최종훈대리 (2013.06.17) 0:미판매, 1:판매, 2:회수, 3:분실, 4:파손, 5:폐기
					// 상품권 체크 보완 김남준주임 (2014.12.29) 6: AK기회수
					
					if((coupon_stat != "1" ) && (coupon_stat != "0" ) && (coupon_stat != "6")) {
						if ((coupon_gubun =="7" ||coupon_gubun =="9") && (callbk_dept == "020210")) { // 강제회수  AK, 애경
							alert("유효기간(5년)이 경과된 상품권이오니,\n상품권데스크(정산소)에서 교환 후 사용하십시오!");
						}else if (coupon_gubun =="5" && callbk_dept == "011110"){                              //  강제회수 삼성플라자
							alert("유효기간(5년)이 경과된 상품권이오니,\n상품권데스크(정산소)에서 교환 후 사용하십시오!!");
						}else {
							alert("이미 회수된 상품권 번호입니다.");
						}
						return false;
					}

					if(coupon_stat == "0" ) {
						alert("판매가 되지 않은 상품권 번호입니다.");
						return false;
					}
				
				}
			});
		}

		// 2019.03.11 ljs : 현금영수증대상여부 추가 START
		if($("#couponLayer_coupon_fg"+idx).val() == 5 ) 
		{
			$("#couponLayer_cashrec_yn"+idx).val("Y");
			$("#couponLayer_vat_cal_ext_rate"+idx).val(0);
			$("#couponLayer_vat_cal_rate"+idx).val(100);
		}
		// 2019.03.11 ljs : 현금영수증대상여부 추가 END
		
		//중복 상품권 번호 Check
		var cpchk = 0;
		$("[name='couponLayer_coupon_no']").each(function() 
		{
			if($("#couponLayer_coupon_no"+idx).val() == $(this).val())
			{
				cpchk ++;
			}
		});
		if( cpchk > 1) //당연히 하나는 걸릴테니 2개부터 
		{
			alert("중복된 상품권 번호가 있습니다.");
			return false;
		}
		
		//회수정보 번호 Check (자사, 증정 상품권일때)   2019.03.11 ljs START
		if($("#couponLayer_coupon_fg"+idx).val() == 0 
		   || $("#couponLayer_coupon_fg"+idx).val() == 7)
		{
			$.ajax({
				type : "POST", 
				url : "/member/lect/getCpBack",
				dataType : "text",
				async:false,
				cache : false,
				data : 
				{
					coupon_no : $("#couponLayer_coupon_no"+idx).val()
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					if(Number(data) > 0)
					{
						alert("회수된 상품권 번호가 있습니다.");
						return false;	
					}
				}
			});
		}
		//회수정보 번호 Check (자사, 증정 상품권일때)   2019.03.11 ljs END
	}
}
function lenByte(code){
 var code_byte = 0;
    for (var inx = 0; inx < code.length; inx++) {
        var oneChar = escape(code.charAt(inx));
        if ( oneChar.length == 1 ) {
            code_byte ++;
        } else if (oneChar.indexOf("%u") != -1) {
            code_byte += 2;
        } else if (oneChar.indexOf("%") != -1) {
            code_byte += oneChar.length/3;
        }
    }
    return code_byte;
}