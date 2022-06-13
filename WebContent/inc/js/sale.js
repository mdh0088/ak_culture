var regis_fee = 0;
var food_amt = 0;
var total_pay = 0;

var card_flag           = "";
var card_nm             = "";
var card_co_origin_seq  = "";
var card_sain_fg        = "";
var card_pri_nm         = "";

var $root$req$encCardNo_send_str = "";
var $root$req$store = "";
var $root$req$card_no = "";
var $root$data$card_data$month = "";
var $root$data$card_data$bc_qr_value = "";
var $root$req$hq = "00";
var $root$req$md = "";
var $root$req$op = "";
var $root$req$goods = "";
var $root$req$period = "";
var $root$req$cust_no = "";
var $root$req$kor_nm = "";
var $root$req$pos_no = "";
var $root$akmem_info$akmem_cust_no = "";
var $root$data$akmem_card_data$akmem_cardno = "";
var $root$req$akmem_cardno = "";
var $root$data$akmem_card_data$akmem_card_fg = "";
var $root$req$total_regis_fee = "";
var $root$data$pay_data$card_amt = "";
var $root$data$card_data$card_total_amt = "";
var $root$req$total_show_amt = "";
var $root$req$total_enuri_amt = "";
var $root$data$danmal_data$rfFlag = "";
var $root$data$danmal_data$cvm = "";
var $root$data$danmal_data$onlineYN = "";
var $root$data$danmal_data$cardNo = "";
var $root$data$danmal_data$modelNo = "";
var $root$data$danmal_data$encDtCnt = "";
var $root$data$danmal_data$vanCode = "";
var $root$data$danmal_data$encGubun = "";
var $root$data$danmal_data$ksn = "";
var $root$data$danmal_data$encData = "";
var $root$data$danmal_data$vanCode1 = "";
var $root$data$danmal_data$encGubun1 = "";
var $root$data$danmal_data$ksn1 = "";
var $root$data$danmal_data$encData1 = "";
var $root$data$danmal_data$vanCode2 = "";
var $root$data$danmal_data$encGubun2 = "";
var $root$data$danmal_data$ksn2 = "";
var $root$data$danmal_data$encData2 = "";
var $root$data$danmal_data$vanCode3 = "";
var $root$data$danmal_data$encGubun3 = "";
var $root$data$danmal_data$ksn3 = "";
var $root$data$danmal_data$encData3 = "";
var $root$data$danmal_data$vanCode4 = "";
var $root$data$danmal_data$encGubun4 = "";
var $root$data$danmal_data$ksn4 = "";
var $root$data$danmal_data$encData4 = "";
var $root$data$rfFlag = "";
var $root$data$rfFlag$cardFlag1 = "";
var $root$data$rfFlag$cardFlag2 = "";
var $root$data$rfFlag$cardFlag3 = "";
var $root$data$rfFlag$cardFlag4 = "";
var $root$data$fallback$gubun = "";
var $root$data$fallback$reason = "";
var $root$req$hide_card_no = "";
var $root$data$card_data$card_no = "";
var $root$data$card_data$card_data_fg = "";
var $root$data$card_data$card_nm = "";
var $root$data$card_data$card_co_origin_seq = "";
var $root$data$card_data$card_sain_fg = "";
var $root$res$card_info$card_pri_nm = "";

var $root$data$akmem_danmal_data$rfFlag = "";
var $root$data$akmem_danmal_data$cvm = "";
var $root$data$akmem_danmal_data$onlineYN = "";
var $root$data$akmem_danmal_data$cardNo = "";
var $root$data$akmem_danmal_data$modelNo = "";
var $root$data$akmem_danmal_data$encDtCnt = "";
var $root$data$akmem_danmal_data$vanCode = "";
var $root$data$akmem_danmal_data$encGubun = "";
var $root$data$akmem_danmal_data$ksn = "";
var $root$data$akmem_danmal_data$encData = "";
var $root$data$akmem_danmal_data$vanCode1 = "";
var $root$data$akmem_danmal_data$encGubun1 = "";
var $root$data$akmem_danmal_data$ksn1 = "";
var $root$data$akmem_danmal_data$encData1 = "";
var $root$data$akmem_danmal_data$vanCode2 = "";
var $root$data$akmem_danmal_data$encGubun2 = "";
var $root$data$akmem_danmal_data$ksn2 = "";
var $root$data$akmem_danmal_data$encData2 = "";
var $root$data$akmem_danmal_data$vanCode3 = "";
var $root$data$akmem_danmal_data$encGubun3 = "";
var $root$data$akmem_danmal_data$ksn3 = "";
var $root$data$akmem_danmal_data$encData3 = "";
var $root$data$akmem_danmal_data$vanCode4 = "";
var $root$data$akmem_danmal_data$encGubun4 = "";
var $root$data$akmem_danmal_data$ksn4 = "";
var $root$data$akmem_danmal_data$encData4 = "";
var $root$req$hide_akmem_card_no = "";
var $root$req$akmem_encCardNo_send_str = "";
var $root$req$ls_send_str = "";
var $root$req$ls_send_str_F = "";
var $root$data$danmal_data$emv = "";

var $root$reader_data$modelCd = "";
var $root$reader_data$ver = "";
var $root$reader_data$serialNo = "";
var $root$reader_data$protoVer = "";
var $root$reader_data$useMsrTr = "";
var $root$reader_data$maxVan = "";
var $root$reader_data$vanCnt = "";
var $root$reader_data$vanCode = "";
var $root$reader_data$vanNm = "";
var $root$reader_data$reciKeyVer = "";
var $root$reader_data$encMeth = "";
var $root$reader_data$vanCode1 = "";
var $root$reader_data$vanNm1 = "";
var $root$reader_data$reciKeyVer1 = "";
var $root$reader_data$encMeth1 = "";
var $root$reader_data$vanCode2 = "";
var $root$reader_data$vanNm2 = "";
var $root$reader_data$reciKeyVer2 = "";
var $root$reader_data$encMeth2 = "";
var $root$reader_data$vanCode3 = "";
var $root$reader_data$vanNm3 = "";
var $root$reader_data$reciKeyVer3 = "";
var $root$reader_data$encMeth3 = "";
var $root$reader_data$vanCode4 = "";
var $root$reader_data$vanNm4 = "";
var $root$reader_data$reciKeyVer4 = "";
var $root$reader_data$encMeth4 = "";
var $root$reader_data$secuVer1 = "";
var $root$reader_data$integrity = "";
var $root$reader_data$secuVer = "";
var $root$res$recpt_no = "";

function posInit() {
	if(printer.DeviceEnabled ) {
		printer.ReleaseDevice();
		printer.close();
	} 
	/*
	else {
		//프린터 DeviceEnadbled 결과에 따라 반드시 return문을 추가해주어야 explore down을 방지할 수 있습니다.
		alert('프린터가 연결되어 있지 않습니다!!!');
		return false;
	}*/
	
	if (printer.Open("IPOS_PRINTER") != 0) {
		alert('프린터가 연결되어 있지 않습니다!!!-1');
		printer.Release();
		printer.close();
		return false;
	} else {
		if (printer.ClaimDevice("1000") != 0 ) {
			alert("프린터가 연결되어 있지 않습니다!!!-2");
			printer.Release();
			printer.close();
			return false;
		} else {
			printer.DeviceEnabled = true;
			printer.RecLineChars = 40;
//			printer.PrintNormal(2, '\r\n\r\n\r\n\r\n');
//			printer.PrintNormal(2, '수석님은 카트허접');
//			printer.PrintNormal(2, '\r\n\r\n\r\n\r\n');
//			printer.CutPaper(95);
			return true;
		}
	}
}//posInit()
function cardXCheck()
{
	OCXcheck();
	if(setCardReaderOpen()){		// 단말기 PORT 체크
		danMaldataParse(CardX.RcvData);
		CardReaderIntegrity();		// 무결성 체크
		Insert_Integrity();			// DB저장
	} else {
		alert("단말기 전원상태를 확인하여 주십시오.\nIC단말기 무결성 체크가 되지 않았습니다.");
	}
	
	var conTest = CardX.ReqReset();
	if(conTest <0){
		alert("단말기가 정상적으로 연결되지 않았습니다.");
		return false;  //2019.03.11 "" --> false 변경
	}
}

function setCardReaderOpen(){
    
    var sPort = 3;      // PORT정보 가져오기
    var ref;
    
//    ref = CardX.Open(sPort,115200,'');
//    if (ref < 0) {
//        alert("연결된 IC단말기 Port번호를 확인하여 주십시오.");
//    }
    
    ref = CardX.ReqCmd( 0xFB, 0x11, 0x02, "", "");
    ref = CardX.WaitCmd( 0xFB, CardX.RcvData, 1000, 0, "처리중입니다.","");
    if(ref >= 0) {
        return true;
    }
}
function readerClose() {
    var ref;
    ref = CardX.ReqReset(); 
    ref = CardX.Close();
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
function AKmem_cardStatusCheck()
{
	var ls_store	=	$("#selBranch").val();
	var ls_akmem_card_no     	=	$root$data$akmem_card_data$akmem_cardno;
	var tranGubun = $root$data$akmem_danmal_data$rfFlag;
	var akmem_card_fg = $root$data$akmem_card_data$akmem_card_fg;
	
	var send_data = (tranGubun.trim() == "M" || akmem_card_fg == "@")?AKmem_Run('XB241S','READ'):AKmem_Run('XB241S','READ');
	var enc_card = $root$data$akmem_card_data$akmem_cardno;
	if(enc_card.indexOf("*") > 0 )
	{
		encCardNoSendStr("akmem");//멤버쉽 카드 복호화
	}
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetAkmemCustInfo",
		dataType : "text",
		async:false,
		data : 
		{
			hq : '00',
			store : $root$req$store,
			send_data : send_data,
			akmem_encCardNo_send_str : $root$req$akmem_encCardNo_send_str
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			//여기에 포인트 갯수가 들어있다.
		}
	});
}
function AKmem_Run(pID,pType){
	
    var ls_store    =   $("#selBranch").val();
    var akmem_card_fg    =   $root$data$akmem_card_data$akmem_card_fg;// WCC 구분 위해 카드등록구분 추가 
    var send_data   =   '';             
    //switch (pID) { 여전법 이후 switch에서 if else 로 변경 
        // case 'XA241S' :
       if(pID == 'XA241S' || pID == 'XB241S' ){ 
            //----------------------------------------------//
            //    회원 인증 조회 로직                               //
            //----------------------------------------------//
            var ls_akmem_card_no        =   $root$data$akmem_card_data$akmem_cardno;  
            
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
            var POS_NO      =   $root$req$pos_no;     //pos번호
            var MBR_INFO_RQ =   "1";    //  회원정보 요청 1: 요청 , 0:요청하지 않음(응답전문에 회원전보 포함여부)
            var ksn_encData = $root$data$akmem_danmal_data$ksn1+$root$data$akmem_danmal_data$encData1; //KSN(20)+Base64(EncData)(64) 유통키 암호화  18.02.12 최보성
            //2019.06.21 ljs : 전문 XA->XB 변경으로 암호화된 카드번호(제휴카드인 경우)일때만 ENC_CARD_NO 값이 처리되도록 보완
            if( ls_akmem_card_no != null && ls_akmem_card_no.indexOf("*") == -1 ) { ksn_encData = ""; }
            
            var ENC_CARD_NO =  pID == 'XB241S'?f_setfill(ksn_encData,84,"R"):f_setfill("",84,"R") ; // 여전법이후 항목 추가 18.02.12 최보성 전문IC XB241S 아닐 때 스페이스 처리
            var FILLER      =   "                                                  ";   //space(50)
            
            var ls_data =   WCC + PERM_RQ_DIV + CARD_NO + PSWD + NOR_CD_CK_YN + NOR_CDNO + DE_DIV_CD + DE_RSON + FRAN_CD + TEAM_CD + POS_NO + MBR_INFO_RQ +ENC_CARD_NO +FILLER ;
 
            send_data   =   f_setfill( ls_header + ls_data, 1024, "R"); //1024byte를 항상 채워준다.  
            
       //    break;          
       // case 'XA242S' : 여전법 이후 switch에서 if else 로 변경 
        }else if(pID =='XA242S'|| pID =='XB242S' ){
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
                                
                var ls_akmem_card_no =   $root$data$akmem_card_data$akmem_cardno;  
                var ls_custno   =   f_setfill(model.getValue("/root/data/akmem_point/AKmem_CustNo"),9,"R");  //고객번호
                var ls_fam_custno=  f_setfill(model.getValue("/root/data/akmem_point/AKmem_Family_CustNo"),10,"R");   //가족번호
                var ls_cus_rg_yn=   model.getValue("/root/data/akmem_point/AKmem_use_yn");  //고객등록여부
                var ls_stt_cdno =   model.getValue("/root/data/akmem_card_data/akmem_cardno");  //구매결재카드정보
                var ls_sale_ymd =   model.getValue("/root/req/sale_ymd");
                var ls_pos_no   =   model.getValue("/root/req/pos_no");
                var ls_recpt_no =   model.getValue("/root/res/recpt_no");
                var ls_rs_use_div_cd=   '1';     //적립구분(1.적립,2.취소)
                var ls_tot_sales_amt=   model.getValue("/root/data/pay_data/total_amt");    //총결재금액
                var ls_recpt_point= model.getValue("/root/data/akmem_card_data/AKmem_recpt_point"); //총적립요청금액
                var ls_orgl_info_yn    =   "0";    //1.원개래 정보 있음 2.원거래 정보 없음
                var ls_orgl_info_div   =   " ";    //"1":운영사 원승인정보, "2":참여사 원승인정보
                var ls_orgl_perm_no    =   f_setfill("",31,"R");   //원 승인번호
                var ls_orgl_de_dt  =   f_setfill("",8,"R");    //원 승인날짜                
                //가맹점코드(5)+거래일자(8)+POS번호(6)+'00000000'+거래번호(4)
                var PTCP_PERM_NO=   FRAN_CD + ls_sale_ymd + ls_pos_no + "00000000" + ls_recpt_no;
                     PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");           
                var DFN_DT      =   ls_sale_ymd;  //확정일자 space(8) 
    
            }else if(pType == 'CANCEL'){
                // 이전거래 가맹점코드 (멤버스 오픈 이전 거래는 각점의 백화점 가맹점 매출로 잡혀있으므로 취소시 각 백화점 가맹점번호로 참여사승인번호를 부여 해야 함.
                var FRAN_NM     =   ""; //  가맹점명
                var FRAN_CD     =   ""; //  가맹점코드
                if( model.getValue("/root/res/akmem_data/akmem_approve_no") == ""){
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
                var ls_akmem_card_no = model.getValue("/root/res/akmem_data/card_no");  
                var ls_custno   =   f_setfill(model.getValue("/root/res/akmem_data/akmem_custno"),9,"R");  //고객번호
                var ls_fam_custno=  f_setfill(model.getValue("/root/res/akmem_data/akmem_family_custno"),10,"R");   //가족번호
                var ls_cus_rg_yn=   'Y';  //고객등록여부
                var ls_stt_cdno =   '';  //구매결재카드정보
                var ls_sys_ymd  =   model.getValue("/root/res/akmem_data/system_date");    //시스템 날짜
                var ls_sale_ymd =   getGridColumnNameValue(gridMain, gridMain.row, "sale_ymd");     //원거래 일자 
                var ls_pos_no   =   getGridColumnNameValue(gridMain, gridMain.row, "pos_no");       //원거래 pos
                
                // 09.07.03 취소시 발생 포스번호 원포스번호 요청오류로 수정함 ls_pos_no2 생성함(해선)
                //var ls_pos_no2   =   model.getValue("/root/req/pos_no");			    //pos번호	
                //--------------------------------------------------------------------
                
                // 2014.07.01 취소시 원거래 번호를 끌고올 시 인터넷 포스, 모바일 포스 적립 취소시 포스번호 중복으로 취소 불가 
                var ls_pos_no2   =   model.getValue("/root/req/pos_no");
                
                //2019.05.29 ljs  : 전성민대리님 소스변경 내역 반영 - ls_pos_no = 070013 추가
                if(ls_pos_no == "070014" || ls_pos_no == "070013")
                {
                	ls_pos_no2 = ls_pos_no;
                }
                
                //var ls_orgl_recpt_no = getGridColumnNameValue(gridMain, gridMain.row, "recpt_no");    //원 영수증번호
                var ls_orgl_recpt_no =  model.getValue("/root/res/akmem_data/recpt_no");    //원 영수증번호
                var ls_recpt_no =   model.getValue("/root/res/new_recpt_no");   //취소 영수증 번호
                var ls_rs_use_div_cd=   '2';     //적립구분(1.적립,2.취소)                
                var ls_tot_sales_amt=   model.getValue("/root/res/akmem_data/total_regis_fee");   //총결재(취소)금액
                var ls_recpt_point  =   model.getValue("/root/res/akmem_data/akmem_recpt_point"); //총적립요청금액      
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
            
            var ksn_encData = model.getValue("/root/data/akmem_danmal_data/ksn1")+model.getValue("/root/data/akmem_danmal_data/encData1"); //KSN(20)+Base64(EncData)(64)  18.02.12 최보성
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
//            break;   여전법 이후 switch에서 if else 로 변
//2019.03.25 ljs 마일리지 사용/취소 추가
    }else if(pID == 'XA243S' || pID == 'XB243S'){

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
                                
                var ls_akmem_card_no =  model.getValue("/root/data/akmem_card_data/akmem_cardno");  
                var ls_custno        =  f_setfill(model.getValue("/root/data/akmem_point/AKmem_CustNo"),9,"R");  //고객번호
                var ls_fam_custno    =  f_setfill(model.getValue("/root/data/akmem_point/AKmem_Family_CustNo"),10,"R");   //가족번호
                var ls_sale_ymd      =  model.getValue("/root/req/sale_ymd");
                var ls_pos_no        =  model.getValue("/root/req/pos_no");
                var ls_recpt_no      =  model.getValue("/root/res/recpt_no");
                var ls_rs_use_div_cd =  '1';     //적립구분(1.적립,2.취소)
                var ls_use_pt        =  model.getValue("/root/data/akmem_point/point_amt");     //총사용요청금액
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

            }else if(pType == 'CANCEL'){
                // 이전거래 가맹점코드 (멤버스 오픈 이전 거래는 각점의 백화점 가맹점 매출로 잡혀있으므로 취소시 각 백화점 가맹점번호로 참여사승인번호를 부여 해야 함.
                var FRAN_NM     =   ""; //  가맹점명
                var FRAN_CD     =   ""; //  가맹점코드
                if( model.getValue("/root/res/akmem_data/akmem_approve_no") == ""){
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
                var ls_akmem_card_no = model.getValue("/root/res/akmem_data/card_no");  
                var ls_custno        = f_setfill(model.getValue("/root/res/akmem_data/akmem_custno"),9,"R");  //고객번호
                var ls_fam_custno    = f_setfill(model.getValue("/root/res/akmem_data/akmem_family_custno"),10,"R");   //가족번호
                var ls_sys_ymd       = model.getValue("/root/res/akmem_data/system_date");         //시스템 날짜
                var ls_sale_ymd      = getGridColumnNameValue(gridMain, gridMain.row, "sale_ymd"); //원거래 일자 
                var ls_pos_no        = getGridColumnNameValue(gridMain, gridMain.row, "pos_no");   //원거래 pos
                
                // 2014.07.01 취소시 원거래 번호를 끌고올 시 인터넷 포스, 모바일 포스 적립 취소시 포스번호 중복으로 취소 불가 
                var ls_pos_no2   =   model.getValue("/root/req/pos_no");
                
                //2019.05.29 ljs  : 전성민대리님 소스변경 내역 반영 - ls_pos_no = 070013 추가
                if(ls_pos_no == "070014" || ls_pos_no == "070013")
                {
                	ls_pos_no2 = ls_pos_no;
                }
                
                var ls_orgl_recpt_no =  model.getValue("/root/res/akmem_data/recpt_no");    //원 영수증번호
                var ls_recpt_no      =  model.getValue("/root/res/new_recpt_no");   //취소 영수증 번호
                var ls_rs_use_div_cd =  '2';     //적립구분(1.적립,2.취소)                
                var ls_use_pt        =  model.getValue("/root/res/akmem_data/akmem_use_point");  //총사용요청금액      
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

            var ksn_encData = model.getValue("/root/data/akmem_danmal_data/ksn1")+model.getValue("/root/data/akmem_danmal_data/encData1"); //KSN(20)+Base64(EncData)(64)  18.02.12 최보성
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
        if( ls_inst_cd == "" )  {  alert("기관코드 셋팅 오류 전산실 연락"); return false; }
                                    
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
function danMaldataParse(rcvData) {
	var danmal_data = rcvData;
	
	$root$reader_data$modelCd = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$ver = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$serialNo = danmal_data.substring(0,12); danmal_data = danmal_data.substring(12);
	$root$reader_data$protoVer = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
	$root$reader_data$useMsrTr = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
	$root$reader_data$maxVan = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
	$root$reader_data$vanCnt = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
	
	$root$reader_data$vanCode = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$vanNm = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
	$root$reader_data$reciKeyVer = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$encMeth = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
	$root$reader_data$vanCode1 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$vanNm1 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
	$root$reader_data$reciKeyVer1 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$encMeth1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
	$root$reader_data$vanCode2 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$vanNm2 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
	$root$reader_data$reciKeyVer2 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$encMeth2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
	$root$reader_data$vanCode3 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$vanNm3 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
	$root$reader_data$reciKeyVer3 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$encMeth3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
	$root$reader_data$vanCode4 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$vanNm4 = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
	$root$reader_data$reciKeyVer4 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
	$root$reader_data$encMeth4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
	$root$reader_data$secuVer1 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
	
	$root$reader_data$secuVer = "AKWEBPOS3001"; // cmc - 식별번호update
}

function CardReaderIntegrity() {
    var ref;
    CardX.SendHandle();
    ref = CardX.ReqCmd( 0xFB, 0x11, 0x30, "", "");
    ref = CardX.WaitCmd( 0xFB, CardX.RcvData, 10000, 1, "무결성 침해 검증 진행중 입니다.", "");
    
    sRet = CardX.RcvData;
    
    var resVl =  sRet.substring(0,2);
    
    var encCnt = $root$reader_data$vanCnt;// 단말기 암호화키 갯수
//    if(encCnt != "5"){ // 직승인 추가 - bc, 신한 -- cmc
//        alert("단말기 키다운로드가 정상적으로 되지 않았습니다.\n 전산실에 연락바랍니다.");
//        resVl = "ERROR";
//       } 

    if(resVl ==  null || resVl.trim() == "" || resVl == undefined  ){
      resVl = "ERROR";
    }
   
    $root$reader_data$integrity = resVl;
    
    readerClose();
}
function Insert_Integrity() {
	$.ajax({
		type : "POST", 
		url : "/member/lect/insert_integrity",
		dataType : "text",
		async:false,
		data : 
		{
			store : $("#selBranch").val(),
			integrity : $root$reader_data$integrity,
			secuVer : $root$reader_data$secuVer,
			secuVer1 : $root$reader_data$secuVer1
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

function f_card_gubun_nm(gubun, card_no) {
	
	var li_row = 0;
	$.ajax({
		type : "POST", 
		url : "/member/lect/getCardCount",
		dataType : "text",
		async:false,
		data : 
		{
			encCardNo_send_str : $root$req$encCardNo_send_str,
			store : $root$req$store
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
            $root$req$card_no = ls_card_no;
            
            //ls_card_no를 통해 실제 카드정보를 조회한다.
//            act.setAction("/action/ba/GetCardNo");
//            act.setRef("/root/req");
//            act.setResultref("/root/res/card_info");
//            if(act.submit(true)) {
//                model.setValue("/root/req/card_no", card_no);            
//            }
            
            $.ajax({
        		type : "POST", 
        		url : "/member/lect/getCardNo",
        		dataType : "text",
        		async:false,
        		data : 
        		{
        			card_no : $root$req$card_no
        		},
        		error : function() 
        		{
        			console.log("AJAX ERROR");
        		},
        		success : function(data) 
        		{
        			var result = JSON.parse(data);
        			card_flag = result.CARD_FLAG;
        			card_nm = result.CARD_NM;
        			card_co_origin_seq = result.CARD_CO_ORIGIN_SEQ;
        			card_sain_fg = result.SAIN_FG;
        			card_pri_nm = result.CARD_PRI_NM;
        		}
        	});
        
            
            //823 신한카드 중 822 신한제휴 구분 체크
            if(card_co_origin_seq == "823"){
            
                //신한제휴 고객 DB를 통해 신한제휴카드 구분함.
//                act.setAction("/action/ba/GetCardCount822");
//                act.setRef("/root/req");
//                act.setResultref("/root/res/card_info/li_row822");
//                if(act.submit(true)) {}
            	
            	var li_row822 = 0;
            	$.ajax({
            		type : "POST", 
            		url : "/member/lect/getCardCount822",
            		dataType : "text",
            		async:false,
            		data : 
            		{
            			encCardNo_send_str : $root$req$encCardNo_send_str,
            			store : $root$req$store
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
                    else if(gubun == "name")        return card_nm;
                    else if(gubun == "origin_seq")  return card_co_origin_seq;
                    else if(gubun == "all")         return "2" + card_co_origin_seq + card_nm;                                        
                    else if(gubun == "new")         return "2" + card_co_origin_seq + card_sain_fg +card_nm; // 10.06.10 추가 (전자서명 무서명 관련)                     
                    else if(gubun == "state")       return card_pri_nm;                                      // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
                }
            // AK기프트카드 추가  START ------------------------                                    
            }else if (card_co_origin_seq == "555"){     //AK기프트카드 
                    if     (gubun == "flag")        return "5"; // card_flag 2:타사 3:삼성제휴 4:신한제휴 5:AK기프트 6:홈플러스선불
                    else if(gubun == "name")        return "AK기프트카드";
                    else if(gubun == "origin_seq")  return "555"; //AK기프트 코드;
                    else if(gubun == "all")         return "5555AK기프트카드";      
                    else if(gubun == "new")         return "5555NAK기프트카드";   
                    else if(gubun == "state")       return "";                  // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
            // AK기프트카드 추가 END ------------------------ 
            // 홈플러스선불카드 추가  START ------------------------    
            }else if (card_co_origin_seq == "666"){     //홈플러스선불카드 
                    if     (gubun == "flag")        return "6"; // card_flag 2:타사 3:삼성제휴 4:신한제휴 5:AK기프트 6:홈플러스선
                    else if(gubun == "name")        return "홈플러스선불카드";
                    else if(gubun == "origin_seq")  return "555"; //AK기프트 코드;
                    else if(gubun == "all")         return "6666홈플러스선불카드";      
                    else if(gubun == "new")         return "6666N홈플러스선불카드";  
                    else if(gubun == "state")       return "";                  // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
             }       
            // 홈플러스선불카드 추가  END ------------------------   
            
            if(card_flag != "" || card_flag.length > 0) {
                if     (gubun == "flag")        return "2";
                else if(gubun == "name")        return card_nm;
                else if(gubun == "origin_seq")  return card_co_origin_seq;
                else if(gubun == "all")         return "2" + card_co_origin_seq + card_nm;
                else if(gubun == "new")         return "2" + card_co_origin_seq + card_sain_fg +card_nm; // 10.06.10 추가 (전자서명 무서명 관련) 
                else if(gubun == "state")       return card_pri_nm;                                      // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
            }
        } //for문 끝
        if(card_flag == "" || card_flag.length == 0) {
            if     (gubun == "flag") return "2";
            else if(gubun == "name") return "KT패스카드";
            else if(gubun == "origin_seq") return "888";
            else if(gubun == "all") return "2888KT패스카드";
            else if(gubun == "new") return "2888NKT패스카드";  // 10.06.10 추가 (전자서명 무서명 관련) 
            else if(gubun == "state")       return "";        // 12.11.20 발행사표기추가(제휴카드, 기프트,선불카드 생략)   
        }    
            
           
    } //if-else문 끝
}
function danmal_reset()
{
	CardX.ReqReSet();
}
function signView()
{
	$('#give_layer').fadeIn(200);
	$(".close").fadeIn(200);
}
function zero(length)
{
    var zeroString = "";
    for(var i = 0; i < length; i++) {
        zeroString = zeroString + "0";
    }
    return zeroString;
}
function trim(stringToTrim) {
    return stringToTrim.replace(/^\s+|\s+$/g,"");
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
function MAKE_MSG(Secudata){
	var msg = "S01=EX;S02=D1;S03= ;S04=40;S05=0700081;S06=C;S08=A;";
	msg = msg + "S09=" + "SECU" + Secudata.substring(46,46+8) + Secudata.substring(46+8+6) + ";S10=YYMM;";
	msg = msg + "S11=00;S12=1000;S17=0;S18=91;S19=N;S29=EASYPOS0003";
	fncForm.EDT_REQ.value = msg;
}
function cardController(gubun){
	danmal_reset();
	var card_amt = Number(total_pay)-Number($("#cash").val())-Number($("#encd_pay").val());
	$("#card_amt").val(card_amt);
	var sD;
	var sE;
	var ret;
	if(gubun == "card") 
	{
		sendData = 
			"0"					//거래 구분자	AN(1)	“0” :  신용  , “1” : 교통 , “2” : 신용 + 멤버쉽
			+"0"					//거래 종류	AN(1)	“0” :  구매  , “1” : 취소
			+getTimeStamp()		//거래 일시	AN(14)	YYYYMMDDHHMMSS
			+space(9-(String(card_amt)).length)+card_amt			//거래 금액	AN(9)	Right Justfy
			+"00"+$root$req$pos_no  //"00802327"//f_setfill_zero(model.getValue("/root/req/pos_no"),8,'L') 			//단말기 ID	AN(8)	"단말기 ID(TID) :“0”으로 Padding8자리가 넘는 경우 8자리까지만 사용"
			+"2"					//EMV PIN 설정	AN(1)	"“1” : PIN 입력,“2” : PIN 입력 안 함 (ED-946 은 사용안함)“3” : 은련만 PIN 입력"
			+"1"				    //Card Input 설정	AN(1)	"“1” : MS/IC, “2” : Only MS, “3” : Only IC( 기능 Disable )“4”:KEYIN : 서명패드 에서 지원"
			+"1"					//"EMV MS거래 허용 여부"	AN(1)	"“1” : MS 거래허용, “2” : MS 거래불가( 기능 Disable )"
			+f_setfill("21",16,'R')				//SEED DATA	AN(16)	RANDOM DATA		
			+"05"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
			+"140000200300944541942150451842";				//카드사 BIN 	AN(6xN)	RANDOM DATA
		
		ret = CardX.ReqCmd( 0xFB, 0x11, 0x20, sendData, sE);
		ret = CardX.WaitCmd( 0xFB, CardX.RcvData, 1000, 1, "처리중입니다.", sE);
	}
	else if(gubun == "member") 
	{
		sendData = "2"					//거래 구분자	AN(1)	“0” :  신용  , “1” : 교통 , “2” : 신용 + 멤버쉽
			   +"0"					//거래 종류	AN(1)	“0” :  구매  , “1” : 취소
			   +getTimeStamp()		//거래 일시	AN(14)	YYYYMMDDHHMMSS
			   +space(9-(String(card_amt)).length)+card_amt			//거래 금액	AN(9)	Right Justfy
			   +"00"+$root$req$pos_no  //"00802327"//f_setfill_zero(model.getValue("/root/req/pos_no"),8,'L') 			//단말기 ID	AN(8)	"단말기 ID(TID) :“0”으로 Padding8자리가 넘는 경우 8자리까지만 사용"
			   +"2"					//EMV PIN 설정	AN(1)	"“1” : PIN 입력,“2” : PIN 입력 안 함 (ED-946 은 사용안함)“3” : 은련만 PIN 입력"
			   +"1"				    //Card Input 설정	AN(1)	"“1” : MS/IC, “2” : Only MS, “3” : Only IC( 기능 Disable )“4”:KEYIN : 서명패드 에서 지원"
			   +"1"					//"EMV MS거래 허용 여부"	AN(1)	"“1” : MS 거래허용, “2” : MS 거래불가( 기능 Disable )"
			   +f_setfill("21",16,'R')				//SEED DATA	AN(16)	RANDOM DATA				
			   +"05"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
			   +"140000200300944541942150451842";				//카드사 BIN 	AN(6xN)	RANDOM DATA	   
			   //+"03"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
			   //+"140000200300944541";				//카드사 BIN 	AN(6xN)	RANDOM DATA
		ret = CardX.ReqCmd( 0xFB, 0x11, 0x20, sendData, sE);
		ret = CardX.WaitCmd( 0xFB, CardX.RcvData, 1000, 1, "처리중입니다.", sE);
	}
		$root$data$card_data$month = $("#month").val();
		$root$req$store = $("#selBranch").val();
		$root$req$period = $("#selPeri").val();
		$root$req$cust_no = $("#cust_no").val();
		$root$req$kor_nm = $("#kor_nm").val();
		$root$akmem_info$akmem_cust_no = $("#cus_no").val();
		$root$data$akmem_card_data$akmem_cardno = $("#card_no").val();
		$root$req$akmem_cardno = $("#card_no").val();
		$root$req$card_no = $("#card_no").val();
		
		var tmp_akmem_cardno = $("#card_no").val();
		if(tmp_akmem_cardno != ""){
			$root$data$akmem_card_data$akmem_card_fg = "@";
		}
		
		$root$req$total_regis_fee = total_pay;
		$root$data$pay_data$card_amt = card_amt;
		$root$data$card_data$card_total_amt = Number(total_pay)-Number($("#cash").val()) - Number($("#encd_pay").val());
		
		$root$req$total_enuri_amt = "0";
		
		$root$req$total_show_amt = total_pay;
		
		var cardX_cnt = fncForm.EDT_RECV.value.substring(55,56);
		var cardX_ing = fncForm.EDT_RECV.value.substring(56);
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
		if(gubun == "card")
		{
			var danmal_data = fncForm.EDT_RECV.value;
			
			console.log(danmal_data);
			$root$data$danmal_data$rfFlag = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			$root$data$danmal_data$cvm = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			$root$data$danmal_data$onlineYN = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			$root$data$danmal_data$cardNo = danmal_data.substring(0,40); danmal_data = danmal_data.substring(40);
			$root$data$danmal_data$modelNo = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
			$root$data$danmal_data$encDtCnt = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$danmal_data$vanCode = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			$root$data$danmal_data$encGubun = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$danmal_data$ksn = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$danmal_data$encData = danmal_data.substring(0,enc.length); danmal_data = danmal_data.substring(enc.length);
			$root$data$danmal_data$vanCode1 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			$root$data$danmal_data$encGubun1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$danmal_data$ksn1 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$danmal_data$encData1 = danmal_data.substring(0,enc1.length); danmal_data = danmal_data.substring(enc1.length);
			$root$data$danmal_data$vanCode2 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			$root$data$danmal_data$encGubun2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$danmal_data$ksn2 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$danmal_data$encData2 = danmal_data.substring(0,enc2.length); danmal_data = danmal_data.substring(enc2.length);
			$root$data$danmal_data$vanCode3 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			$root$data$danmal_data$encGubun3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$danmal_data$ksn3 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$danmal_data$encData3 = danmal_data.substring(0,enc3.length); danmal_data = danmal_data.substring(enc3.length);
			$root$data$danmal_data$vanCode4 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
			$root$data$danmal_data$encGubun4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$danmal_data$ksn4 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$danmal_data$encData4 = danmal_data.substring(0,enc4.length); danmal_data = danmal_data.substring(enc4.length);
			$root$data$danmal_data$emv = CardX.Emv;
			
			
			var rfflag = fncForm.EDT_RECV.value.substring(0,4);
			$root$data$rfFlag$cardFlag1 = rfflag.substring(0,1);
			$root$data$rfFlag$cardFlag2 = rfflag.substring(1,2);
			$root$data$rfFlag$cardFlag3 = rfflag.substring(2,3);
			$root$data$rfFlag$cardFlag4 = rfflag.substring(3,4);
			
			
			if($root$data$danmal_data$rfFlag.substring(0,2) =="MF"){
				$root$data$fallback$gubun = rfflag.substring(1,2);
				$root$data$fallback$reason = "0"+rfflag.substring(2,3);
				var fbrs = $root$data$fallback$reason;
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
						$("#ic_card_no").val("비정상 F/B 입니다.\n"+
								"["+fbrs+"]: "+fbmsg+
								" \n카드등록을 다시 해주세요.")
					return; 
				}	
			}
			var cardNo = $root$data$danmal_data$cardNo;
			$root$req$hide_card_no = cardNo;
			
			
			
			
			
			//setCardNoRead()
			
			
			
			var hideCode = cardNo;
			var num_length = hideCode.indexOf("=");
			var card_no = hideCode.substring(0, num_length);
			$root$req$card_no = card_no;
			
			if($root$data$danmal_data$encDtCnt != "0"){
				encCardNoSendStr("card");
			}
			var ls_ret_str = f_card_gubun_nm("new", $root$req$card_no);
			
			var ls_card_fg			= ls_ret_str.substring(0, 1)
			var card_co_origin_seq	= ls_ret_str.substring(1, 4);
			var card_sain_fg		= ls_ret_str.substring(4, 5);
			var card_nm				= ls_ret_str.substring(5);
			
			$("#card_co_origin_seq").val(card_co_origin_seq);
			if(ls_card_fg != "3") {
				if(card_co_origin_seq == "822" ) {  //  "823"은 테스트용 추후 검토 후 삭제 최보성 || card_co_origin_seq == "823"
					ls_card_fg = "4";	 // 신한제휴는 4
				}else if(card_co_origin_seq == "555") {
					ls_card_fg = "5";	 // AK기프트카드는 5  (2012.01.06) 추가
				}else if(card_co_origin_seq == "666") {
					ls_card_fg = "6";	 // 홈플러스카드는 6  (2012.01.17) 추가
				}else if(card_co_origin_seq == "042") {
					ls_card_fg = "8";	 // AK KB국민카드 8  (2017.09.26) 추가
				}else{
					ls_card_fg = "2";
				}
			}
			$("#ic_card_no").val(card_no);
			$("#ic_card_nm").val(card_nm);
			
			$root$data$card_data$card_no = card_no;
			$root$data$card_data$card_data_fg = ls_card_fg;
			$root$data$card_data$card_nm = card_nm;
			$root$data$card_data$card_co_origin_seq = card_co_origin_seq;
			$root$data$card_data$card_sain_fg = card_sain_fg;
			$root$res$card_info$card_pri_nm = card_pri_nm;
		}
		else if(gubun == "member")
		{
			var danmal_data = fncForm.EDT_RECV.value;
			$root$data$akmem_danmal_data$rfFlag = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			$root$data$akmem_danmal_data$cvm = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			$root$data$akmem_danmal_data$onlineYN = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
			$root$data$akmem_danmal_data$cardNo = danmal_data.substring(0,40); danmal_data = danmal_data.substring(40);
			$root$data$akmem_danmal_data$modelNo = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
			$root$data$akmem_danmal_data$encDtCnt = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$akmem_danmal_data$vanCode = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			$root$data$akmem_danmal_data$encGubun = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$akmem_danmal_data$ksn = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$akmem_danmal_data$encData = danmal_data.substring(0,enc.length); danmal_data = danmal_data.substring(enc.length);
			$root$data$akmem_danmal_data$vanCode1 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			$root$data$akmem_danmal_data$encGubun1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$akmem_danmal_data$ksn1 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$akmem_danmal_data$encData1 = danmal_data.substring(0,enc1.length); danmal_data = danmal_data.substring(enc1.length);
			$root$data$akmem_danmal_data$vanCode2 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			$root$data$akmem_danmal_data$encGubun2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$akmem_danmal_data$ksn2 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$akmem_danmal_data$encData2 = danmal_data.substring(0,enc2.length); danmal_data = danmal_data.substring(enc2.length);
			$root$data$akmem_danmal_data$vanCode3 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			$root$data$akmem_danmal_data$encGubun3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$akmem_danmal_data$ksn3 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$akmem_danmal_data$encData3 = danmal_data.substring(0,enc3.length); danmal_data = danmal_data.substring(enc3.length);
			$root$data$akmem_danmal_data$vanCode4 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
			$root$data$akmem_danmal_data$encGubun4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
			$root$data$akmem_danmal_data$ksn4 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
			$root$data$akmem_danmal_data$encData4 = danmal_data.substring(0,enc4.length); danmal_data = danmal_data.substring(enc4.length);
			
			if($root$data$akmem_danmal_data$rfFlag.substring(0,2) =="MF"){
				$root$data$fallback$gubun = rfflag.substring(1,2);
				$root$data$fallback$reason = "0"+rfflag.substring(2,3);
				var fbrs = $root$data$fallback$reason;
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
						$("#ic_card_no").val("비정상 F/B 입니다.\n"+
								"["+fbrs+"]: "+fbmsg+
								" \n카드등록을 다시 해주세요.")
					return; 
				}	
			}
			var akmem_hideCode = $root$data$akmem_danmal_data$cardNo;
			var num_length = akmem_hideCode.indexOf("=");
			
			
			$("#ic_akmem_card_no").val(Track4Cardno(akmem_hideCode));
			
			$root$data$akmem_card_data$akmem_cardno = Track4Cardno(akmem_hideCode);
			AKmem_cardStatusCheck();
		}
  }
function cardController_c(gubun){
	danmal_reset();
	var card_amt = Number(total_pay)-Number($("#cash").val())-Number($("#encd_pay").val());
	$("#card_amt").val(card_amt);
	var sD;
	var sE;
	var ret;
	if(gubun == "card") 
	{
		sendData = 
			"0"					//거래 구분자	AN(1)	“0” :  신용  , “1” : 교통 , “2” : 신용 + 멤버쉽
			+"0"					//거래 종류	AN(1)	“0” :  구매  , “1” : 취소
			+getTimeStamp()		//거래 일시	AN(14)	YYYYMMDDHHMMSS
			+space(9-(String(card_amt)).length)+card_amt			//거래 금액	AN(9)	Right Justfy
			+"00"+$root$req$pos_no  //"00802327"//f_setfill_zero(model.getValue("/root/req/pos_no"),8,'L') 			//단말기 ID	AN(8)	"단말기 ID(TID) :“0”으로 Padding8자리가 넘는 경우 8자리까지만 사용"
			+"2"					//EMV PIN 설정	AN(1)	"“1” : PIN 입력,“2” : PIN 입력 안 함 (ED-946 은 사용안함)“3” : 은련만 PIN 입력"
			+"1"				    //Card Input 설정	AN(1)	"“1” : MS/IC, “2” : Only MS, “3” : Only IC( 기능 Disable )“4”:KEYIN : 서명패드 에서 지원"
			+"1"					//"EMV MS거래 허용 여부"	AN(1)	"“1” : MS 거래허용, “2” : MS 거래불가( 기능 Disable )"
			+f_setfill("21",16,'R')				//SEED DATA	AN(16)	RANDOM DATA		
			+"05"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
			+"140000200300944541942150451842";				//카드사 BIN 	AN(6xN)	RANDOM DATA
		
		ret = CardX.ReqCmd( 0xFB, 0x11, 0x20, sendData, sE);
		ret = CardX.WaitCmd( 0xFB, CardX.RcvData, 1000, 1, "처리중입니다.", sE);
	}
	else if(gubun == "member") 
	{
		sendData = "2"					//거래 구분자	AN(1)	“0” :  신용  , “1” : 교통 , “2” : 신용 + 멤버쉽
			+"0"					//거래 종류	AN(1)	“0” :  구매  , “1” : 취소
			+getTimeStamp()		//거래 일시	AN(14)	YYYYMMDDHHMMSS
			+space(9-(String(card_amt)).length)+card_amt			//거래 금액	AN(9)	Right Justfy
			+"00788888"  //"00802327"//f_setfill_zero(model.getValue("/root/req/pos_no"),8,'L') 			//단말기 ID	AN(8)	"단말기 ID(TID) :“0”으로 Padding8자리가 넘는 경우 8자리까지만 사용"
			+"2"					//EMV PIN 설정	AN(1)	"“1” : PIN 입력,“2” : PIN 입력 안 함 (ED-946 은 사용안함)“3” : 은련만 PIN 입력"
			+"1"				    //Card Input 설정	AN(1)	"“1” : MS/IC, “2” : Only MS, “3” : Only IC( 기능 Disable )“4”:KEYIN : 서명패드 에서 지원"
			+"1"					//"EMV MS거래 허용 여부"	AN(1)	"“1” : MS 거래허용, “2” : MS 거래불가( 기능 Disable )"
			+f_setfill("21",16,'R')				//SEED DATA	AN(16)	RANDOM DATA				
			+"05"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
			+"140000200300944541942150451842";				//카드사 BIN 	AN(6xN)	RANDOM DATA	   
		//+"03"				//요청 갯수	AN(2)	00 ~ 99 : “00” 일 경우 스크래치 Data 전송 후 대기 값이 없는 경우 VAN 사 정보만 리딩
		//+"140000200300944541";				//카드사 BIN 	AN(6xN)	RANDOM DATA
		ret = CardX.ReqCmd( 0xFB, 0x11, 0x20, sendData, sE);
		ret = CardX.WaitCmd( 0xFB, CardX.RcvData, 1000, 1, "처리중입니다.", sE);
	}
	$root$data$card_data$month = $("#month").val();
	$root$req$store = $("#selBranch").val();
	$root$req$period = $("#selPeri").val();
	$root$req$cust_no = $("#cust_no").val();
	$root$req$kor_nm = $("#kor_nm").val();
	$root$akmem_info$akmem_cust_no = $("#cus_no").val();
	$root$data$akmem_card_data$akmem_cardno = $("#card_no").val();
	$root$req$akmem_cardno = $("#card_no").val();
	$root$req$card_no = $("#card_no").val();
	
	var tmp_akmem_cardno = $("#card_no").val();
	if(tmp_akmem_cardno != ""){
		$root$data$akmem_card_data$akmem_card_fg = "@";
	}
	
	$root$req$total_regis_fee = total_pay;
	$root$data$pay_data$card_amt = card_amt;
	$root$data$card_data$card_total_amt = Number(total_pay)-Number($("#cash").val()) - Number($("#encd_pay").val());
	
	$root$req$total_enuri_amt = "0";
	
	$root$req$total_show_amt = total_pay;
	
	var cardX_cnt = fncForm.EDT_RECV.value.substring(55,56);
	var cardX_ing = fncForm.EDT_RECV.value.substring(56);
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
	if(gubun == "card")
	{
		var danmal_data = fncForm.EDT_RECV.value;
		
		console.log(danmal_data);
		$root$data$danmal_data$rfFlag = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		$root$data$danmal_data$cvm = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
		$root$data$danmal_data$onlineYN = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
		$root$data$danmal_data$cardNo = danmal_data.substring(0,40); danmal_data = danmal_data.substring(40);
		$root$data$danmal_data$modelNo = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
		$root$data$danmal_data$encDtCnt = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$data$danmal_data$vanCode = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		$root$data$danmal_data$encGubun = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$data$danmal_data$ksn = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$data$danmal_data$encData = danmal_data.substring(0,enc.length); danmal_data = danmal_data.substring(enc.length);
		$root$data$danmal_data$vanCode1 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		$root$data$danmal_data$encGubun1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$data$danmal_data$ksn1 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$data$danmal_data$encData1 = danmal_data.substring(0,enc1.length); danmal_data = danmal_data.substring(enc1.length);
		$root$data$danmal_data$vanCode2 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		$root$data$danmal_data$encGubun2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$data$danmal_data$ksn2 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$data$danmal_data$encData2 = danmal_data.substring(0,enc2.length); danmal_data = danmal_data.substring(enc2.length);
		$root$data$danmal_data$vanCode3 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		$root$data$danmal_data$encGubun3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$data$danmal_data$ksn3 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$data$danmal_data$encData3 = danmal_data.substring(0,enc3.length); danmal_data = danmal_data.substring(enc3.length);
		$root$data$danmal_data$vanCode4 = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		$root$data$danmal_data$encGubun4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$data$danmal_data$ksn4 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$data$danmal_data$encData4 = danmal_data.substring(0,enc4.length); danmal_data = danmal_data.substring(enc4.length);
		$root$data$danmal_data$emv = CardX.Emv;
		
		
		var rfflag = fncForm.EDT_RECV.value.substring(0,4);
		$root$data$rfFlag$cardFlag1 = rfflag.substring(0,1);
		$root$data$rfFlag$cardFlag2 = rfflag.substring(1,2);
		$root$data$rfFlag$cardFlag3 = rfflag.substring(2,3);
		$root$data$rfFlag$cardFlag4 = rfflag.substring(3,4);
		
		
		if($root$data$danmal_data$rfFlag.substring(0,2) =="MF"){
			$root$data$fallback$gubun = rfflag.substring(1,2);
			$root$data$fallback$reason = "0"+rfflag.substring(2,3);
			var fbrs = $root$data$fallback$reason;
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
				$("#ic_card_no").val("비정상 F/B 입니다.\n"+
						"["+fbrs+"]: "+fbmsg+
				" \n카드등록을 다시 해주세요.")
				return; 
			}	
		}
		var cardNo = $root$data$danmal_data$cardNo;
		$root$req$hide_card_no = cardNo;
		
		
		
		
		
		//setCardNoRead()
		
		
		
		var hideCode = cardNo;
		var num_length = hideCode.indexOf("=");
		var card_no = hideCode.substring(0, num_length);
		$root$req$card_no = card_no;
		
		if($root$data$danmal_data$encDtCnt != "0"){
			encCardNoSendStr("card");
		}
		var ls_ret_str = f_card_gubun_nm("new", $root$req$card_no);
		
		var ls_card_fg			= ls_ret_str.substring(0, 1)
		var card_co_origin_seq	= ls_ret_str.substring(1, 4);
		var card_sain_fg		= ls_ret_str.substring(4, 5);
		var card_nm				= ls_ret_str.substring(5);
		
		$("#card_co_origin_seq").val(card_co_origin_seq);
		if(ls_card_fg != "3") {
			if(card_co_origin_seq == "822" ) {  //  "823"은 테스트용 추후 검토 후 삭제 최보성 || card_co_origin_seq == "823"
				ls_card_fg = "4";	 // 신한제휴는 4
			}else if(card_co_origin_seq == "555") {
				ls_card_fg = "5";	 // AK기프트카드는 5  (2012.01.06) 추가
			}else if(card_co_origin_seq == "666") {
				ls_card_fg = "6";	 // 홈플러스카드는 6  (2012.01.17) 추가
			}else if(card_co_origin_seq == "042") {
				ls_card_fg = "8";	 // AK KB국민카드 8  (2017.09.26) 추가
			}else{
				ls_card_fg = "2";
			}
		}
		$("#ic_card_no").val(card_no);
		$("#ic_card_nm").val(card_nm);
		
		$root$data$card_data$card_no = card_no;
		$root$data$card_data$card_data_fg = ls_card_fg;
		$root$data$card_data$card_nm = card_nm;
		$root$data$card_data$card_co_origin_seq = card_co_origin_seq;
		$root$data$card_data$card_sain_fg = card_sain_fg;
		$root$res$card_info$card_pri_nm = card_pri_nm;
	}
	else if(gubun == "member")
	{
		var danmal_data = fncForm.EDT_RECV.value;
		$root$akmem_danmal_data$rfFlag = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		$root$akmem_danmal_data$cvm = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
		$root$akmem_danmal_data$onlineYN = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
		$root$akmem_danmal_data$cardNo = danmal_data.substring(0,40); danmal_data = danmal_data.substring(40);
		$root$akmem_danmal_data$modelNo = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
		$root$akmem_danmal_data$encDtCnt = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$akmem_danmal_data$vanCode = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		$root$akmem_danmal_data$encGubun = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$akmem_danmal_data$ksn = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$akmem_danmal_data$encData = danmal_data.substring(0,enc.length); danmal_data = danmal_data.substring(enc.length);
		$root$akmem_danmal_data$vanCode1 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		$root$akmem_danmal_data$encGubun1 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$akmem_danmal_data$ksn1 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$akmem_danmal_data$encData1 = danmal_data.substring(0,enc1.length); danmal_data = danmal_data.substring(enc1.length);
		$root$akmem_danmal_data$vanCode2 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		$root$akmem_danmal_data$encGubun2 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$akmem_danmal_data$ksn2 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$akmem_danmal_data$encData2 = danmal_data.substring(0,enc2.length); danmal_data = danmal_data.substring(enc2.length);
		$root$akmem_danmal_data$vanCode3 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		$root$akmem_danmal_data$encGubun3 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$akmem_danmal_data$ksn3 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$akmem_danmal_data$encData3 = danmal_data.substring(0,enc3.length); danmal_data = danmal_data.substring(enc3.length);
		$root$akmem_danmal_data$vanCode4 = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		$root$akmem_danmal_data$encGubun4 = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		$root$akmem_danmal_data$ksn4 = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		$root$akmem_danmal_data$encData4 = danmal_data.substring(0,enc4.length); danmal_data = danmal_data.substring(enc4.length);
		
		if($root$data$akmem_danmal_data$rfFlag.substring(0,2) =="MF"){
			$root$data$fallback$gubun = rfflag.substring(1,2);
			$root$data$fallback$reason = "0"+rfflag.substring(2,3);
			var fbrs = $root$data$fallback$reason;
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
				$("#ic_card_no").val("비정상 F/B 입니다.\n"+
						"["+fbrs+"]: "+fbmsg+
				" \n카드등록을 다시 해주세요.")
				return; 
			}	
		}
		$root$req$hide_akmem_card_no = fncForm.EDT_RECV.value.substring(6,46);
	}
}
function encCardNoSendStr(encFlag){//
	var product = "XB245S" + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
	//암호화카드번호 KSN[20]+BASE64[64] track2 데이터
	var encCardNo = "";
	if(encFlag == "card"){
		encCardNo = $root$data$danmal_data$ksn1 + $root$data$danmal_data$encData1;
		product =  product + encCardNo +fill("",50);
		$root$req$encCardNo_send_str = f_setfill(product,1024,'R');
	}else if(encFlag == "akmem"){
		encCardNo = $root$data$akmem_danmal_data$ksn1 + $root$data$akmem_danmal_data$encData1;
		product =  product + encCardNo +fill("",50);
		$root$req$akmem_encCardNo_send_str = f_setfill(product,1024,'R');
	}	
	//암호화카드번호[84]+FILLER[]
}
function fill(addString, length) // 0 5
{
    var charString = "";
    for(var i = 0; i < length; i++) {
        charString = charString + addString;
    }
    return charString;
}
var signText = "";
function autoSign()
{
	var ls_card_corp_cd	=	$root$data$card_data$card_co_origin_seq;
	var ls_card_sain_fg	=	$root$data$card_data$card_sain_fg;
	var ls_halbu_no    	=	$root$data$card_data$month;
	var cardAmt = Number($root$data$pay_data$card_amt);
	
	if(ls_halbu_no == "00") {
		if( (  (ls_card_corp_cd == "822") || (ls_card_corp_cd == "823") ) && ( cardAmt <= 50000 )) {
			signText = "1";
			alert("[신한카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else if( (  (ls_card_corp_cd == "002") || (ls_card_corp_cd == "003") || (ls_card_corp_cd == "004")|| (ls_card_corp_cd == "005")||
					   (ls_card_corp_cd == "992")|| (ls_card_corp_cd == "993")) && ( cardAmt <= 50000 )) {
			signText = "1";
			alert("[삼성카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else if(  (ls_card_corp_cd == "031")  && ( cardAmt <= 50000 )  && ( ls_card_sain_fg  == 'Y' ) ) {
		//}else if(  (ls_card_corp_cd == "031")  && ( cardAmt <= 50000 )  ) {		기존소스 백업 (10.06.10)
			signText = "1";
			alert("[BC카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else if( ((ls_card_corp_cd == "041") || (ls_card_corp_cd == "042")) && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[국민카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else if(  (ls_card_corp_cd == "951")  && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[현대카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else if(  (ls_card_corp_cd == "052")  && ( cardAmt <= 50000 )  && ( ls_card_sain_fg  == 'Y' ) ) {
		//}else if(  (ls_card_corp_cd == "052")  && ( cardAmt <= 50000 ) ) {	    기존소스 백업(12.06.26)
			signText = "1";
			alert("[외환카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else if(  (ls_card_corp_cd == "961")  && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[롯데카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else if(  ls_card_corp_cd == "555") {	
			signText = "1";
			alert("[AK-GIFT카드]는 금액대 무관 전자서명 무서명 대상매출입니다.");
			approveCheck();
		}else if(  (ls_card_corp_cd == "061")  && ( cardAmt <= 50000 ) ) {
			signText = "1";
			alert("[NH카드 50,000원 이하 전자서명 무서명] 대상매출입니다.");
			approveCheck();
		}else{        
			signView();
			var sE;
			CardX.ReqSignA (2,"0788888",cardAmt,"","",sE);
		}
	}else {
		signView();
		var sE;
		CardX.ReqSignA (2,"0788888",cardAmt,"","",sE);
	}	
}

var is_wcc = "";
function cardSelectFg(flag)
{
	if(flag == "card"){ // 카드 승인구분 세팅
		$(".card-slide").eq(1).slideToggle();	
		cardController("card");
		is_wcc = "A";
	}else if(flag == "samPay"){
		is_wcc = "M";
	}	
	else if(flag == "member"){
		is_wcc = "M";
	}	
}
//if(flag == "card"){ // 카드 승인구분 세팅
//	is_wcc = "A";
//}else if(flag == "samPay"){
//	is_wcc = "M";
//}	
function approveCheck() {
	
	// IC단말기 유효기간정보 받지 않음(추후 APP카드로 인해 변경가능) 여전법 이후
	
	var ls_send_programID		= "XB071S"; //전문IC[6]
	var ls_receive_programID	= "XA071R";
	var KFTC_TERM_ID			= "9047000000";	//의미없는 cat_id 데몬에서 cat_id 생성
	var NICE_TERM_ID			= "9540030001";
	var KICC_TERM_ID			= "104504";
	var s = 0;

	var ls_hq 				=	$root$req$hq; // 본부코드[2]
	var ls_store 			=	$root$req$store; //점포코드[2]
	var ls_pos_no 			=	$root$req$pos_no; //POS번호[6]
	
	
	var check_card_amt  	=	$root$data$pay_data$card_amt;
	var ls_card_no     		=	$root$data$card_data$card_no;
//	ls_card_no = ls_card_no.substring(0,4)+"-"+ls_card_no.substring(4,8)+"-"+ls_card_no.substring(8,12)+"-"+ls_card_no.substring(12,16);
	var ls_halbu_no    		=	$("#month").val(); //할부개월[2]
	var ls_amt         		=	$root$data$card_data$card_total_amt; //금액[11]
	var is_valid_date   	=	"0000"; // 유효기간 
	var ls_card_corp_cd		=	$root$data$card_data$card_co_origin_seq; //카드사고유일련번호[3]
	var ls_approve_no 		=	"";   //원승인번호[8] (모르겠다.)
	var ls_rest_amt 		=	"0";    //AK 기프트카드잔액(12.01.12)
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
	if(ls_amt == null || trim(String(ls_amt)) == "" || ls_amt == "0") {
		alert("결제금액을 입력해주세요");
		return;
	}
	if(trim(ls_approve_no) != "") {
		alert("승인번호가 이미 조회되었습니다.");
		return;
	}
	if(trim(String(ls_amt)) != trim(String(check_card_amt))) {
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
	var signT = "";
	
	if(signText == "1")
	{
		signT = signText;
	}
	else
	{
		signT = CardX.Sign;
	}
	
	//임시로 서명데이터

	if(signT == null || signT == undefined|| signT === "" || signT.trim() === ""){
		alert("사인이 되지 않았습니다. \n승인번호 조회 버튼을 다시 눌러주시길 바랍니다.");
//				cardX.ReqReset(); 
//				autoSign();
		return;
	}	
		if(is_wcc == "A" || is_wcc == "M" || is_wcc == "I") { // 여전법 이후 카드거래 구분
			//var card_data = model.getValue("/root/req/hide_card_no");  여전법이전 2018.01.25 최보성
			//"SECU"+기종번호(4)+버전(4)+암호구분(2)+KSN(20)+Base64(EncData)(64) 여전법이후 2018.01.25 최보성
			var card_data = "SECU"+$root$data$danmal_data$modelNo
							+$root$data$danmal_data$encGubun
							+$root$data$danmal_data$ksn
							+$root$data$danmal_data$encData; 
			//카드리더기-분당점은 KDE 리더기 사용으로 앞에 @문자가 붙어 해당 부분을 잘라내는 작업이 선행되어야 한다. 2008.02.25
			//구로, 수원은 카드리더기에 따라서 첫자리 제거 여부를 판단해야함
			
			/*분당점 카드센싱기 교체진행(2013.01.22)  기존소스 주석처리필요 ◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈◈
			  전점 통일							
			if(ls_hq == "00" && ls_store == "03") {
			   --	TEST시만 주석달기/ REAL은 활성화 꼭!!  ★★★★★★★★★★★★★★★
							= card_data.substring(1);   

			}
			*/
			var amt         	= String(ls_amt); //100000
			s					= 11 - amt.length; //5
			var ls_amt			= fill("0", s) + amt.toString(); //fill("0", 5)
			var is_card_data 	= f_setfill(card_data, 37, "R" );
			//var length 			= card_data.length;
			var length 			= "098"; // 2018.01.24 최보성 변경
			is_wcc         = "I" // 2018.01.24 최보성 추가
		} else if(is_wcc == "@") {// 여전법 이전 매뉴얼 거래 
			var amt         	= String(ls_amt);
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

	var trsnGubun1 = $root$data$rfFlag$cardFlag1; //RF FLAG 첫째자리 ->'R' (RF거래), 'I'(IR 거래) 'M' (MS거래) 'C' (IC거래) 
	var trsnGubun2 = $root$data$rfFlag$cardFlag2; //RF FLAG 둘째자리 ->SKT : 'S', KTF : 'K' , LGT : 'L' (RF거래/이통사구분), 'I'(IR 거래) 'F' (MS거래) '' (IC거래)
	var mbCorp  = "";
	var cardTp  = "";
	var rfCdKnd = "";
	var posCertiNo = "####AKWEBPOS3001";//POSSW식별번호[16] - cmc 식별번호 update
	var fbReason = ""; //Fallback사유[2]
	var emvYN = "Y";
	var emvReqdata = $root$data$danmal_data$emv.replace("$",""); //EMV요청DATA[400]
	var emvReqdata2 = $root$data$danmal_data$emv.replace("$",""); //EMV요청DATA[400] - 씨티카드
	/*****거래 구분 세팅 여전법 이후 start *************************/
	if(trsnGubun1 == "R" || trsnGubun1 == "I" || is_wcc == "M" ){
		 mbCorp = $root$data$rfFlag$cardFlag2; //+이통사구분[1]
		 cardTp = $root$data$rfFlag$cardFlag3; //+카드방식[1]
		 rfCdKnd = $root$data$rfFlag$cardFlag4; //+RF카드종류[1]					
		if(trsnGubun1 == "R"  && ls_card_corp_cd  == "031") {//BCNFC
			ls_send_programID = "NFB71S" ;
		}else if(trsnGubun1 == "R"  && ls_card_corp_cd  == "030000"){//payon
			is_wcc = "P" 
			ls_send_programID = "PYB71S" ;
		}
	}else if(trsnGubun2 == "F"){//MSR 거래시 fb
		is_wcc = "F";
		fbReason = $root$data$fallback$reason; 
		emvYN ="N";
		emvReqdata = "";
	}else if(trsnGubun1 == "M"){
		emvYN ="N";							
		is_wcc = "A";
		emvReqdata = "";
	}else{
		
		//cmc12345 - 씨티카드 로직 추가
		if(trsnGubun1 == "C") {
			var citi_check = "";
			
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
	
	console.log("vanCode"+$root$data$danmal_data$vanCode);
	console.log("vanCode1"+$root$data$danmal_data$vanCode1);
	console.log("vanCode2"+$root$data$danmal_data$vanCode2);
	console.log("vanCode3"+$root$data$danmal_data$vanCode3);
	console.log("vanCode4"+$root$data$danmal_data$vanCode4);
	if($root$data$danmal_data$vanCode == "140000") {
		card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun
							+ $root$data$danmal_data$ksn
							+ $root$data$danmal_data$encData;
	}
	else if($root$data$danmal_data$vanCode1 == "140000") {
		card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun1
							+ $root$data$danmal_data$ksn1
							+ $root$data$danmal_data$encData1;
	}
	else if($root$data$danmal_data$vanCode2 == "140000") {
		card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun2
							+ $root$data$danmal_data$ksn2
							+ $root$data$danmal_data$encData2;
	}
	else if($root$data$danmal_data$vanCode3 == "140000") {
		card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun3
							+ $root$data$danmal_data$ksn3
							+ $root$data$danmal_data$encData3;
	}
	else if($root$data$danmal_data$vanCode4 == "140000" ){
		card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun4
							+ $root$data$danmal_data$ksn4
							+ $root$data$danmal_data$encData4;
	}
	else {
		card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 유통키 
	if($root$data$danmal_data$vanCode == "200300") {
		key_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun
							+ $root$data$danmal_data$ksn
							+ $root$data$danmal_data$encData;
	}
	else if($root$data$danmal_data$vanCode1 == "200300") {
		key_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun1
							+ $root$data$danmal_data$ksn1
							+ $root$data$danmal_data$encData1
	}
	else if($root$data$danmal_data$vanCode2 == "200300") {
		key_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun2
							+ $root$data$danmal_data$ksn2
							+ $root$data$danmal_data$encData2;
	}
	else if($root$data$danmal_data$vanCode3 == "200300") {
		key_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun3
							+ $root$data$danmal_data$ksn3
							+ $root$data$danmal_data$encData3;
	}
	else if($root$data$danmal_data$vanCode4 == "200300" ){
		key_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun4
							+ $root$data$danmal_data$ksn4
							+ $root$data$danmal_data$encData4;
	}
	else {
		key_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 국민 
	if($root$data$danmal_data$vanCode == "944541") {
		is_KB_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun
							+ $root$data$danmal_data$ksn
							+ $root$data$danmal_data$encData;
	}
	else if($root$data$danmal_data$vanCode1 == "944541") {
		is_KB_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun1
							+ $root$data$danmal_data$ksn1
							+ $root$data$danmal_data$encData1
	}
	else if($root$data$danmal_data$vanCode2 == "944541") {
		is_KB_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun2
							+ $root$data$danmal_data$ksn2
							+ $root$data$danmal_data$encData2;
	}
	else if($root$data$danmal_data$vanCode3 == "944541") {
		is_KB_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun3
							+ $root$data$danmal_data$ksn3
							+ $root$data$danmal_data$encData3;
	}
	else if($root$data$danmal_data$vanCode4 == "944541" ){
		is_KB_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun4
							+ $root$data$danmal_data$ksn4
							+ $root$data$danmal_data$encData4;
	}
	else {
		is_KB_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 비씨
	if($root$data$danmal_data$vanCode == "942150") {
		is_BC_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun
							+ $root$data$danmal_data$ksn
							+ $root$data$danmal_data$encData;
	}
	else if($root$data$danmal_data$vanCode1 == "942150") {
		is_BC_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun1
							+ $root$data$danmal_data$ksn1
							+ $root$data$danmal_data$encData1
	}
	else if($root$data$danmal_data$vanCode2 == "942150") {
		is_BC_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun2
							+ $root$data$danmal_data$ksn2
							+ $root$data$danmal_data$encData2;
	}
	else if($root$data$danmal_data$vanCode3 == "942150") {
		is_BC_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun3
							+ $root$data$danmal_data$ksn3
							+ $root$data$danmal_data$encData3;
	}
	else if($root$data$danmal_data$vanCode4 == "942150" ){
		is_BC_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun4
							+ $root$data$danmal_data$ksn4
							+ $root$data$danmal_data$encData4;
	}
	else {
		is_BC_card_data = "";
	}
	
	// cmc - 각 단말기별 bin 코드로 카드사 데이터를 만듬 - 신한
	if($root$data$danmal_data$vanCode == "451842") {
		is_SH_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun
							+ $root$data$danmal_data$ksn
							+ $root$data$danmal_data$encData;
	}
	else if($root$data$danmal_data$vanCode1 == "451842") {
		is_SH_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun1
							+ $root$data$danmal_data$ksn1
							+ $root$data$danmal_data$encData1
	}
	else if($root$data$danmal_data$vanCode2 == "451842") {
		is_SH_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun2
							+ $root$data$danmal_data$ksn2
							+ $root$data$danmal_data$encData2;
	}
	else if($root$data$danmal_data$vanCode3 == "451842") {
		is_SH_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun3
							+ $root$data$danmal_data$ksn3
							+ $root$data$danmal_data$encData3;
	}
	else if($root$data$danmal_data$vanCode4 == "451842" ){
		is_SH_card_data = "SECU"
							+ $root$data$danmal_data$modelNo
							+ $root$data$danmal_data$encGubun4
							+ $root$data$danmal_data$ksn4
							+ $root$data$danmal_data$encData4;
	}
	else {
		is_SH_card_data = "";
	}
	// AK기프트(555),홈플러스(666) 카드 승인 추가(2012.01.10) START  ------------------------------------------
	if(ls_card_corp_cd == "555") {
//		if(getGridColumnSum(gridMain, "food_amt") > 0) {
//			alert("[AK기프트카드]로 재료비를 받을 수 없습니다.")
//			card_form_reset();
//			pay_fg.select(1);
//			return false;
//		}
//		
//		if(is_wcc == "@") {
//			alert("[AK기프트카드]는 카드등록 swipe만 가능합니다. [manual] 결제불가!!!!");
//			card_form_reset();
//			return;
//		}	
//		 
//		//점서버로 변경 밑에 if 추후 삭제 2016.10.10  기프트,선불카드 헤더
////			if (ls_store != "03" ) { 	 //분당점외 나머지 지점 경우 
//			ls_send_programID		= "XB075S";
//			ls_receive_programID	= "XB075R";
////			}else {								 //분당점 경우 
////				ls_send_programID		= "XM090S";  
////				ls_receive_programID	= "XM090R";
////			}
//		
//		//product = ls_send_programID + "0000" + space(32);
//		  product = ls_send_programID + "0000" + fill("0",32); //전문IC[6]+응답코드[4]+단품INDEX정보[8]+소스INDEX정보[8]+CLASSINDEX정보[8]+담당자INDEX정보[8]
//		  length = "098";
//		//영수증번호 
//		var act = new Transaction(submission);
//		act.setAction("/action/ba/BASale0202_S02");
//		act.setRef("/root/req");
//		act.setResultref("/root/res/recpt_no");
//		if(act.submit(true)) {
//			var recptNo = model.getValue("/root/res/recpt_no");
//		}
//		is_wcc = "A";
//		 //본부코드[2]+점포코드[2]+POS 번호[6]+거래번호[4]+CARD구분[2]
//		ls_send_str = ls_hq + ls_store  + ls_pos_no  + f_setfill(recptNo,4,"R")  + "10"
//					//WCC[1]+길이[3]+카드사[3]+카드번호(암호화)[98]+할부개월[2]+금액[11]+PIN_DATA(PASSWORD)[4]
//					+ is_wcc + length + ls_card_corp_cd + f_setfill(card_data,98,'R') + f_setfill(ls_halbu_no,2,'R') + f_setfill_zero(ls_amt,11,'L') + f_setfill(pin_Data,4,'R');
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
		var is_KB_card_data    = "SECU"+$root$data$danmal_data$modelNo
							+$root$data$danmal_data$encGubun2
							+$root$data$danmal_data$ksn2
							+$root$data$danmal_data$encData2; 
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
	else if(ls_card_corp_cd == "031") {	//BC 카드 직승인 전문 시작

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

//	if(model.getValue("/root/data/card_data/bc_qr_value") != null && model.getValue("/root/data/card_data/bc_qr_value") != ""  ) {
		// BC QR 전문 생성 시작
//		ls_send_programID = "XB511S";
//		// product = 전문ic + 응답코드 + 단품 INDEX정보 + 소스 INDEX정보 + CLASS INDEX정보 + 담당자 INDEX정보
//		// 즉 product = 전문의 HEADER 부분
//		product 		= ls_send_programID + "0000" + "00000000" + "00000000" +"00000000" + "00000000" ;
//		
//		// bc qr 은 card_data 항목 - 카드번호 데이터로 보낸다.
//		var bc_qr_data = model.getValue("/root/data/card_data/bc_qr_value");
//		var qr_track2 = bc_qr_data.substr(6, 40);														// track2 데이터
//		var qr_emv_data = bc_qr_data.substring(47, bc_qr_data.length - 46);
//		var qr_gubun      = bc_qr_data.substr(3, 1) ; // (L, C)
//		var check_bill_fg = "";
//		
//		if(qr_gubun == "L") {		// QR 코드가 국내 일 시    Q  L						
//			is_wcc = "Q";
//			check_bill_fg = "10" ;
//		}
//		else {							// QR 코드가 해외 일 시	  Q  C
//			is_wcc = "q";
//			check_bill_fg = "22" ;
//		}
//		
//		ls_send_str = ls_hq 										// 본부코드[2]
//						 + ls_store  									// 점포코드[2]
//						 + ls_pos_no  								// POS번호[6]
//						 + f_setfill(KFTC_TERM_ID,15,"R")		// 터미널ID1[15]
//						 + f_setfill(NICE_TERM_ID,15,"R")  	// 터미널ID2[15]
//						 + f_setfill(KICC_TERM_ID,15,"R")  	// 터미널ID3[15]
//						 + check_bill_fg								// CARD/수표구분[2]
//						 + is_wcc 										// WCC[1]
//						 + "098"	 										// 길이[3] 
//						 + ls_card_corp_cd							// 카드사고유일련번호[3]
//						 + f_setfill(qr_track2, 98, 'R') 			// 카드DATA[98]
//						 + f_setfill(ls_halbu_no,2,'R') 			// 할부개월[2]
//						 + f_setfill_zero(ls_amt,11,'L') 		// 금액[11]
//						 + f_setfill(pin_Data,4,"R") 				// PIN_DATA[4]
//						 + f_setfill(ls_filler,2,"R")					// FILLER[2]
//						 + f_setfill(ls_working,16,"R") 			// WorkingKey[16]
//						 + f_setfill(ls_royalty,203,"R") 			// 로열티데이터[203]
//						 + f_setfill(ls_pre_ack_no,8,"R") 		// 원승인번호[8]
//						 + f_setfill(ls_pre_sale_ymd,6,"R")		// 원매출일자[6]
//						 + f_setfill(trsnGubun1,1,"R") 			// 거래구분[1]
//						 + f_setfill(mbCorp,1,"R") 				// 이통사구분[1]
//						 + f_setfill(cardTp,1,"R") 					// 카드방식[1]
//						 + f_setfill(rfCdKnd,1,"R") 				// RF카드종류[1]
//						 + space(1)									// 동글매체구분[1]
//						 +"B" 											// 단말종류구분[1]
//						 + f_setfill(posCertiNo,16,"R") 			// POSSW식별번호[16]
//						 + f_setfill(fbReason,2,"R") 				// Fallback사유[2]
//						 + "Y"	 										// EMVData유무[1]
//						 + f_setfill(qr_emv_data,400, "R") ;	// EMV요청DATA[400]
//	}
//	else {
//	}
	
	// AK기프트카드 승인 추가(2012.01.10) END ------------------------------------------
	ls_send_str	= product + ls_send_str;
	ls_send_str	= f_setfill(ls_send_str, 1060, "R");
	$root$req$ls_send_str = ls_send_str;
	$root$req$ls_send_str_F = f_setfill(product + ls_send_str_F, 1060, "R");
	
	console.log(ls_send_str);
//	model.makeValue("/root/req/ls_send_str_F", f_setfill(product + ls_send_str_F, 1060, "R"));
	
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
//	var act = new Transaction(submission);
//	act.setAction("/action/ba/GetApproveNo");
//	act.setRef("/root/req");
//	act.setResultref("/root/data/approve_data");
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetApproveNo",
		dataType : "text",
		async:false,
		data : 
		{
			ls_send_str : ls_send_str,
			hq : '00',
			store : $root$req$store,
			ls_send_str_F : $root$req$ls_send_str_F
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			$("#recieve").val(data);
		}
	});
	
//	if(act.submit(true)) {
//		
//		var ls_message = model.getValue("/root/data/approve_data/message");
//		var rest_amt = model.getValue("/root/data/approve_data/rest_amt");
//		
//		// 은련qr 고액 로직 시작 - cmc
//		var ls_return_cd = model.getValue("/root/data/approve_data/return_cd");
//		
//		if(ls_return_cd == "7804" || ls_return_cd == "1401"){
//			while( ls_return_cd == "7804" || ls_return_cd == "1401" ) {
//				ls_return_cd = "X";	//무한루프 방지
//				
//				alert("은련QR 고액결제입니다\n" + "고객앱에서 핀번호 입력이 필요합니다.\n" + "핀번호 입력 후 [확인]버튼을 눌러 주세요.");
//				
//				ls_send_str = ls_hq 										// 본부코드[2]
//								 + ls_store  									// 점포코드[2]
//								 + ls_pos_no  								// POS번호[6]
//								 + f_setfill(KFTC_TERM_ID,15,"R")		// 터미널ID1[15]
//								 + f_setfill(NICE_TERM_ID,15,"R")  	// 터미널ID2[15]
//								 + f_setfill(KICC_TERM_ID,15,"R")  	// 터미널ID3[15]
//								 + "23"											// CARD/수표구분[2]					// bcqr 은련 조회 로 변경 하여 전문 실행
//								 + is_wcc 										// WCC[1]
//								 + "098"	 										// 길이[3] 
//								 + ls_card_corp_cd							// 카드사고유일련번호[3]
//								 + f_setfill(qr_track2, 98, 'R') 			// 카드DATA[98]
//								 + f_setfill(ls_halbu_no,2,'R') 			// 할부개월[2]
//								 + f_setfill_zero(ls_amt,11,'L') 		// 금액[11]
//								 + f_setfill(pin_Data,4,"R") 				// PIN_DATA[4]
//								 + f_setfill(ls_filler,2,"R")					// FILLER[2]
//								 + f_setfill(ls_working,16,"R") 			// WorkingKey[16]
//								 + f_setfill(ls_royalty,203,"R") 			// 로열티데이터[203]
//								 + f_setfill(ls_pre_ack_no,8,"R") 		// 원승인번호[8]
//								 + f_setfill(ls_pre_sale_ymd,6,"R")		// 원매출일자[6]
//								 + f_setfill(trsnGubun1,1,"R") 			// 거래구분[1]
//								 + f_setfill(mbCorp,1,"R") 				// 이통사구분[1]
//								 + f_setfill(cardTp,1,"R") 					// 카드방식[1]
//								 + f_setfill(rfCdKnd,1,"R") 				// RF카드종류[1]
//								 + space(1)									// 동글매체구분[1]
//								 +"B" 											// 단말종류구분[1]
//								 + f_setfill(posCertiNo,16,"R") 			// POSSW식별번호[16]
//								 + f_setfill(fbReason,2,"R") 				// Fallback사유[2]
//								 + "Y"	 										// EMVData유무[1]
//								 + f_setfill(qr_emv_data,400, "R") ;	// EMV요청DATA[400]
//						 
//				ls_send_str	= product + ls_send_str;
//				ls_send_str	= f_setfill(ls_send_str, 1060, "R");
//				model.setValue("/root/req/ls_send_str", ls_send_str);
//				
//				var act = new Transaction(submission);
//				act.setAction("/action/ba/GetApproveNo");
//				act.setRef("/root/req");
//				act.setResultref("/root/data/approve_data");
//				
//				if(act.submit(true)) {
//					ls_return_cd = model.getValue("/root/data/approve_data/return_cd");
//					ls_message = model.getValue("/root/data/approve_data/message");
//					rest_amt = model.getValue("/root/data/approve_data/rest_amt");
//				}
//			}
//		}
//		else {
//		
//		}
//		// 은련qr 고액 로직 끝 - cmc
//		
//		if(ls_message == "잔액부족") ls_message = ls_message +"잔액("+rest_amt+"원)";
//		
//		alert(ls_message);
//		
//		if(model.getValue("/root/data/approve_data/approve_no").length < 7 ||
//		   model.getValue("/root/data/approve_data/approve_no").trim() == '') {
//		   approve_no.value = "";
//		}else {
//		//	autoSign(); //최보성 여전법이후 카드읽은 후 서명 받는 걸로 process 변경 완료후 control disable처리
//			Comp_Disable()// 승인 후 결제 완료시
//		
//			
//			
//			/********제휴사카드 마일리지 적립여부 및 잔액명기 process start ********************/
//			var carddatafg = model.getValue("/root/data/card_data/card_data_fg");		
//
//			if((carddatafg == "4" || carddatafg == "8")
//					&& confirmMsg("제휴카드로 마일리지를 적립하시겠습니까?")) { // 제휴카드 마일리지 적립여부 
//				akmem_card_fg.select(0); //멤버스 포인트 결제구분 선택(20180816 최보성)
//				model.setValue("/root/req/hide_akmem_card_no", model.getValue("/root/data/danmal_data/cardNo"));
//				model.makeNode("/root/data/akmem_danmal_data");
//				model.copyNode("/root/data/akmem_danmal_data","/root/data/danmal_data")
//				
//				model.refresh();
//				
//				AKmem_cardRead();
//				
//				//2019.06.21 ljs : 사용마일리지 승인후 제휴카드 마일리지 적립시 화면에 사용마일리지 표기되도록 처리 START
//				if(model.getValue("/root/data/pay_data/akmem_point_amt") > 0){
//					model.setValue("/root/data/akmem_point/point_amt", model.getValue("/root/data/pay_data/akmem_point_amt"));
//					model.refresh();
//				}   
//				//2019.06.21 ljs : 사용마일리지 승인후 제휴카드 마일리지 적립시 화면에 사용마일리지 표기되도록 처리 END								
//				
//				model.setFocus("btn_ok"); 
//			}else{
//				if(pay_fg.value == "card_cash"){ 
//					model.setFocus("cash_approve");
//				}else{
//					model.setFocus("btn_ok"); 
//				}
//			}
//			var restamt = model.getValue("/root/data/approve_data/rest_amt"); //타사/자사 선불카드관련 잔액정보
//			//if(carddatafg == "5" || carddatafg == "6" ) { // 잔액명기 18.02.05 최보성 test중
//			if(restamt !=  null && restamt.trim() !=  "" && restamt !=  "000000000" ) { // 잔액명기 18.02.05 최보성 
//				var sbBalance = model.getValue("/root/data/pay_data/card_amt") + " / 잔액: " + Number(model.getValue("/root/data/approve_data/rest_amt"))+"원";
//				model.makeValue("/root/data/approve_data/balance", sbBalance);
//
//				pay_card.attribute("format") =""; // 결재정보 카드 금액 포맷변경
//				pay_card.attribute("ref") = "/root/data/approve_data/balance"; // 결재정보 카드 금액 참조 변경
//			
//				model.refresh();
//				//model.refreshpart("/root/data/pay_data/card_amt");
//			}
//			/********제휴사카드 마일리지 적립여부 및 잔액명기 process end ********************/
//		}
//		
//		/* cminc1115 - 여전법 전문 데이터 삭제 */
//		model.removeNode("/root/req/ls_send_str_F");
//		model.removeNode("/root/req/ls_send_str");
//		model.makeValue("/root/req/ls_send_str_F","");
//		model.makeValue("/root/req/ls_send_str","");
//		model.setValue("/root/req/ls_send_str_F", "");
//		model.setValue("/root/req/ls_send_str", "");
//		model.refresh();
//		
//	}	
}//approveCheck()

function dataReset()
{

	regis_fee = 0;
	food_amt = 0;
	total_pay = 0;

	card_flag           = "";
	card_nm             = "";
	card_co_origin_seq  = "";
	card_sain_fg        = "";
	card_pri_nm         = "";

	$root$req$encCardNo_send_str = "";
	$root$req$store = "";
	$root$req$card_no = "";
	$root$data$card_data$month = "";
	$root$req$hq = "00";
	$root$req$md = "";
	$root$req$op = "";
	$root$req$goods = "";
	$root$req$period = "";
	$root$req$cust_no = "";
	$root$req$kor_nm = "";
	$root$req$pos_no = "";
	$root$akmem_info$akmem_cust_no = "";
	$root$data$akmem_card_data$akmem_cardno = "";
	$root$req$akmem_cardno = "";
	$root$data$akmem_card_data$akmem_card_fg = "";
	$root$req$total_regis_fee = "";
	$root$data$pay_data$card_amt = "";
	$root$data$card_data$card_total_amt = "";
	$root$req$total_show_amt = "";
	$root$req$total_enuri_amt = "";
	$root$data$danmal_data$rfFlag = "";
	$root$data$danmal_data$cvm = "";
	$root$data$danmal_data$onlineYN = "";
	$root$data$danmal_data$cardNo = "";
	$root$data$danmal_data$modelNo = "";
	$root$data$danmal_data$encDtCnt = "";
	$root$data$danmal_data$vanCode = "";
	$root$data$danmal_data$encGubun = "";
	$root$data$danmal_data$ksn = "";
	$root$data$danmal_data$encData = "";
	$root$data$danmal_data$vanCode1 = "";
	$root$data$danmal_data$encGubun1 = "";
	$root$data$danmal_data$ksn1 = "";
	$root$data$danmal_data$encData1 = "";
	$root$data$danmal_data$vanCode2 = "";
	$root$data$danmal_data$encGubun2 = "";
	$root$data$danmal_data$ksn2 = "";
	$root$data$danmal_data$encData2 = "";
	$root$data$danmal_data$vanCode3 = "";
	$root$data$danmal_data$encGubun3 = "";
	$root$data$danmal_data$ksn3 = "";
	$root$data$danmal_data$encData3 = "";
	$root$data$danmal_data$vanCode4 = "";
	$root$data$danmal_data$encGubun4 = "";
	$root$data$danmal_data$ksn4 = "";
	$root$data$danmal_data$encData4 = "";
	$root$data$rfFlag = "";
	$root$data$rfFlag$cardFlag1 = "";
	$root$data$rfFlag$cardFlag2 = "";
	$root$data$rfFlag$cardFlag3 = "";
	$root$data$rfFlag$cardFlag4 = "";
	$root$data$fallback$gubun = "";
	$root$data$fallback$reason = "";
	$root$req$hide_card_no = "";
	$root$data$card_data$card_no = "";
	$root$data$card_data$card_data_fg = "";
	$root$data$card_data$card_nm = "";
	$root$data$card_data$card_co_origin_seq = "";
	$root$data$card_data$card_sain_fg = "";
	$root$res$card_info$card_pri_nm = "";

	$root$data$akmem_danmal_data$rfFlag = "";
	$root$data$akmem_danmal_data$cvm = "";
	$root$data$akmem_danmal_data$onlineYN = "";
	$root$data$akmem_danmal_data$cardNo = "";
	$root$data$akmem_danmal_data$modelNo = "";
	$root$data$akmem_danmal_data$encDtCnt = "";
	$root$data$akmem_danmal_data$vanCode = "";
	$root$data$akmem_danmal_data$encGubun = "";
	$root$data$akmem_danmal_data$ksn = "";
	$root$data$akmem_danmal_data$encData = "";
	$root$data$akmem_danmal_data$vanCode1 = "";
	$root$data$akmem_danmal_data$encGubun1 = "";
	$root$data$akmem_danmal_data$ksn1 = "";
	$root$data$akmem_danmal_data$encData1 = "";
	$root$data$akmem_danmal_data$vanCode2 = "";
	$root$data$akmem_danmal_data$encGubun2 = "";
	$root$data$akmem_danmal_data$ksn2 = "";
	$root$data$akmem_danmal_data$encData2 = "";
	$root$data$akmem_danmal_data$vanCode3 = "";
	$root$data$akmem_danmal_data$encGubun3 = "";
	$root$data$akmem_danmal_data$ksn3 = "";
	$root$data$akmem_danmal_data$encData3 = "";
	$root$data$akmem_danmal_data$vanCode4 = "";
	$root$data$akmem_danmal_data$encGubun4 = "";
	$root$data$akmem_danmal_data$ksn4 = "";
	$root$data$akmem_danmal_data$encData4 = "";
	$root$req$hide_akmem_card_no = "";
	$root$req$akmem_encCardNo_send_str = "";
	$root$req$ls_send_str = "";
	$root$req$ls_send_str_F = "";
	$root$data$danmal_data$emv = "";

	$root$reader_data$modelCd = "";
	$root$reader_data$ver = "";
	$root$reader_data$serialNo = "";
	$root$reader_data$protoVer = "";
	$root$reader_data$useMsrTr = "";
	$root$reader_data$maxVan = "";
	$root$reader_data$vanCnt = "";
	$root$reader_data$vanCode = "";
	$root$reader_data$vanNm = "";
	$root$reader_data$reciKeyVer = "";
	$root$reader_data$encMeth = "";
	$root$reader_data$vanCode1 = "";
	$root$reader_data$vanNm1 = "";
	$root$reader_data$reciKeyVer1 = "";
	$root$reader_data$encMeth1 = "";
	$root$reader_data$vanCode2 = "";
	$root$reader_data$vanNm2 = "";
	$root$reader_data$reciKeyVer2 = "";
	$root$reader_data$encMeth2 = "";
	$root$reader_data$vanCode3 = "";
	$root$reader_data$vanNm3 = "";
	$root$reader_data$reciKeyVer3 = "";
	$root$reader_data$encMeth3 = "";
	$root$reader_data$vanCode4 = "";
	$root$reader_data$vanNm4 = "";
	$root$reader_data$reciKeyVer4 = "";
	$root$reader_data$encMeth4 = "";
	$root$reader_data$secuVer1 = "";
	$root$reader_data$integrity = "";
	$root$reader_data$secuVer = "";
}





function QRChipData()
{
	var QrData = $("#inputQr").val()
	
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
function bcQrData(sR) {
	
//	if(!isNull(pay_card)) {	//카드금액setting
//		model.setValue("/root/data/card_data/card_total_amt", model.getValue("/root/data/pay_data/card_amt"));
//		model.refresh();
//	} 
//	else {
//		alertMsg("카드금액을 입력후 등록을 눌러주세요");
//		return false;
//	}
//	search_fg.disabled = false;
	$root$data$card_data$bc_qr_value = sR;
	
	var bc_qr_data    = $root$data$card_data$bc_qr_value;		// bc qr 데이터
	
	if(bc_qr_data == null || bc_qr_data == "" ){
		alert("에러발생. QR코드 스캔 진행을 다시 해 주시기 바랍니다.");
		return;
	}
	
	var qr_card_no_real = (bc_qr_data.substr(6, 40)).substr(0, (bc_qr_data.substr(6, 40)).indexOf("="));// 리얼 카드 번호
	var qr_card_no =  qr_card_no_real.substring(0,6) + "******" +  qr_card_no_real.substring(12); 
	
	var ls_ret_str = f_card_gubun_nm("new", qr_card_no_real);	// 카드정보를 가져 온다.
	var ls_card_fg			    = ls_ret_str.substring(0, 1);
	var card_co_origin_seq	= ls_ret_str.substring(1, 4);
	var card_sain_fg		    = ls_ret_str.substring(4, 5);
	var card_nm				    = ls_ret_str.substring(5);
	
	is_wcc = "I";		// IC카드 거래로 인식 하게끔 -> 승인조회시  카드에 따라 Q 나 q 로 변경
	ls_card_fg = "Q"; // KICC 로 van 청구 해야 함.

	$("#ic_card_no").val(qr_card_no);
	$("#ic_card_nm").val(card_nm);
	$root$data$card_data$card_no = qr_card_no;
	$root$data$card_data$card_data_fg = ls_card_fg;
	$root$data$card_data$card_nm = card_nm;
	$root$data$card_data$card_co_origin_seq = card_co_origin_seq;
	$root$data$card_data$card_sain_fg = card_sain_fg;
	
	qr_card_no_real = "";
	qr_card_no = "";
	bc_qr_data = "";
	
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
	ls_pos_no    			= $root$req$pos_no;
	ls_recpt_no				= $root$res$recpt_no;
	ls_card_amt	 		= $root$data$pay_data$card_amt;
	ls_issue_fg  			= ''; //model.getValue("/root/data/cash_approve_data/cash_issue_fg");
	ls_id_no     				= ''; //model.getValue("/root/data/cash_approve_data/id_no");
	ls_id_fg					= ''; //model.getValue("/root/data/cash_approve_data/cash_id_fg");
	ls_approve_no  		= '';//model.getValue("/root/data/approve_data/approve_no");
	ls_mc_approve_no  	= '';//model.getValue("/root/data/mcoupon_data/mc_approve_no");
	ls_mc_card_amt  		= '';//model.getValue("/root/data/mcoupon_data/mc_card_amt");
	ls_mc_card_no  		= '';//model.getValue("/root/data/mcoupon_data/mc_card_no");
	ls_mc_remain_amt  	= '';//model.getValue("/root/data/mcoupon_data/mc_remain_amt");
	ls_aprv_no				= '';//model.getValue("/root/data/cash_approve_data/cash_approve_no");
	ls_cash_amt 			= $("#cash").val();
	ls_card_no				= $root$data$card_data$card_no;
	sale_ymd				= ls_sale_date.substring(0, 4) + "년" + ls_sale_date.substring(4, 6) + "월" +  ls_sale_date.substring(6, 8) + "일";
	conversion_recpt_no	= "NO." + ls_pos_no + "-" + ls_recpt_no;
	sale_time				= getTime().substring(0,2) + "시" + getTime().substring(2,4) + "분" + getTime().substring(4,6) + "초";
	
	ls_card_fg				= $root$data$card_data$card_co_origin_seq; 	//AK기프트 잔액 추가(12.01.11)
	ls_rest_amt				= ''; //model.getValue("/root/data/approve_data/rest_amt"); 			//AK기프트 잔액 추가(12.01.11)
	
	ls_bc_qr_value				= $root$data$card_data$bc_qr_value;		//bcqr 영수증 - cmc
	//2019.03.11 ljs 사용마일리지, 상품권관련 추가 START
	ls_point_amt            = ''; //model.getValue("/root/data/pay_data/akmem_point_amt");        //사용마일리지 추가
	if(ls_point_amt != null && ls_point_amt !=  "" )
	{
		ls_point_amt = 0;
	}
	ls_coupon_amt          = ''; //model.getValue("/root/data/pay_data/coupon");            //총상품권금액 추가
	ls_cashrec_n_coupon    = ''; //model.getValue("/root/data/pay_data/cashrec_n_coupon");  //자사 현금영수증제외금액 추가
	//2019.03.11 ljs 사용마일리지, 상품권관련 추가 END

	//분당점이면 바코드 91로 시작
	if($root$req$hq == "00" && $root$req$store == "03") {
		ls_barcode			= "91" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	} else if($root$req$hq == "00" && $root$req$store == "01") {
		ls_barcode			= "92" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	} else if($root$req$hq == "00" && $root$req$store == "02") {
		ls_barcode			= "93" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}else if($root$req$hq == "00" && $root$req$store == "04") {
		ls_barcode			= "94" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}else if($root$req$hq == "00" && $root$req$store == "05") {
		ls_barcode			= "95" + ls_sale_date.substring(2) + ls_pos_no + ls_recpt_no;
	}
	
	//==================================================================
	// 10.06.10 무서명 기준 체크 추가
	var ls_card_sain_fg	= $root$data$card_data$card_sain_fg;
	var sale_date = setWeekDay(ls_sale_date);
	
	if($root$req$hq == "00" && $root$req$store == "03") {
		//분당점
		ls_data  = ls_escape + ls_font
		ls_data += "AK S&D(주) AK 분당점\n"
		ls_data += "129-85-42346  김 진 태\n"
		ls_data += "경기도 성남시 분당구 황새울로 360번길 42\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	} else if($root$req$hq == "00" && $root$req$store == "01") {
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
	} else if($root$req$hq == "00" && $root$req$store == "02") {
		//수원점
		ls_data  = ls_escape + ls_font
		ls_data += "수원애경역사(주) 수원점\n"
		ls_data += "124-81-28579  김 진 태\n"
		ls_data += "경기도 수원시 팔달구 덕영대로 924\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	} else if($root$req$hq == "00" && $root$req$store == "04") {
		//평택점
		ls_data  = ls_escape + ls_font
		ls_data += "평택역사(주) 평택점\n"
		ls_data += "125-81-24085  김 진 태\n"
		ls_data += "경기도 평택시 평택로 51\n"
		ls_data += "Tel: 1661-1114\n"
		ls_data += "http://www.akplaza.com www.akmall.com\n"
		ls_data += sale_ymd + " " + sale_date + "요일   " + f_setfill(conversion_recpt_no,16,'L');
		ls_data += '\r\n\r\n'
		ls_data += "새로운 생활의 즐거움 Wanna Be My Lift! \n"
		ls_data += "It's AK 항상 최고로 모시겠습니다.\r\n\r\n"
	} else if($root$req$hq == "00" && $root$req$store == "05") {
		//원주점
		ls_data  = ls_escape + ls_font
		ls_data += "에이케이에스앤디(주) AK원주점\n"
		ls_data += "224-85-23362 김 진 태\n"
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
	var chk_subject_cd_arr = $("#chk_subject_cd").val().split("|");
	var chk_regis_fee_arr = regis_fee_arr.split("|");
	var chk_food_amt_arr = food_amt_arr.split("|");
	var chk_subject_nm_arr = subject_nm_arr.split("|");
	var cbx_middle_pay = 'N';
	var cbx_part_pay = 'N';
	for(i = 0; i < chk_subject_cd_arr.length-1; i++) {
		var regis_fee	= 0;
		var food_fee	= 0;
		// 09.12.15 (부분입금, 중도수강시 수강료 ,재료비, 합계 금액 실 결제금액으로 수정(박지선)
		if(cbx_middle_pay.value == "Y" || cbx_part_pay.value == "Y") {
			regis_fee	= chk_regis_fee_arr[i]; //gridMain.valueMatrix(i, gridMain.colRef("regis_amt"));
			food_fee	= chk_food_amt_arr[i]; //gridMain.valueMatrix(i, gridMain.colRef("food_amt"));
		}else{
			regis_fee	= chk_regis_fee_arr[i]; //gridMain.valueMatrix(i, gridMain.colRef("regis_fee"));
			food_fee	= chk_food_amt_arr[i]; //gridMain.valueMatrix(i, gridMain.colRef("food_fee"));
		}	
			var sub_tot_fee	= 0;
			sub_tot_fee = eval(regis_fee) + eval(food_fee);
			
			ls_data += chk_subject_cd_arr[i] +' '+ chk_subject_nm_arr[i];
			ls_data += '\r\n'
			ls_data += f_setfill(ConvAmtInt(regis_fee),17,'L')
			ls_data += f_setfill(ConvAmtInt(food_fee),11,'L')
			ls_data += f_setfill(ConvAmtInt(sub_tot_fee.toString()),12,'L')
			ls_data += '\r\n'
	}
	
	ls_data += "총강좌수 : "+ chk_subject_cd_arr.length-1 + "\r\n";
	ls_data += '----------------------------------------';
	
					
				ls_data += f_setfill("담당자: 정기영",34,'L') + "\n";
				
				printer.PrintNormal(2, '\r\n');
				//if($root$req$hq == "00" && $root$req$store == "03") {					
//				printer.Printbitmap(2, "C:\\IPOSNAME_AKP.BMP", -11, -1);
				//} else {
				//	printer.Printbitmap(2, "C:\\IPOSNAMEAK.BMP", -11, -1);
				//}
				printer.PrintNormal(2, '\r\n');
				printer.PrintNormal(2, ls_data);
				printer.PrintNormal(2, ' \r\n');
				printer.PrintNormal(2, '\r\n\r\n\r\n\r\n');
				printer.CutPaper(95);
}//posPrint()
function ConvAmtInt(sval) {
    var sRst="";  // 결과값

    var num = sval.toString();

    if(isNaN(parseInt(num))) return sval;
    if(!isFinite(parseInt(num))) return sval;

    num = Math.round(parseFloat(num)).toString();

    var iOrd= num.toString().length;  // 길이

    //음수인경우 음수부호 이후의 숫자를 잘라내고 음수부호를 나중에 붙여준다.
    if((num.substring(0,1)) == "-") {
        num = num.substring(1,iOrd);
        iOrd -= 1; sRst = "-";
    }

    for(var i = 0; i < num.length; i++) {
        sRst += num.substring(i,i+1);
        if(iOrd != 1 && (iOrd-1) % 3 == 0) sRst += ",";
        iOrd -= 1;
    }
    return sRst;
}
function setWeekDay(strDate) {
	var hanDay = new Array("일", "월", "화", "수", "목", "금", "토");

	var sYear = strDate.substring(0,4);
	var sMonth = strDate.substring(4,6);
	var sDay = strDate.substring(6,8);
	var newDate = new Date(parseInt(sYear, 10), parseInt(parseInt(sMonth, 10)-1, 10), parseInt(sDay, 10));
	return hanDay[newDate.getDay()];
}//setWeekDay
