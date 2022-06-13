var auth_cardBin = "";
var saupjaNo = "";
var certiflag = "";
var nsaupjaNo = "";
var nDanmaltype = "";
var danmalSerial = "";
var danmalCertiNo1 = "";
var danmalCertiNo2 = "";
var auth_timeStamp = "";
var taSimid = "";
var ATC = "";
var random = "";
var hashAlgoId = "";
var hsahtaSIM = "";
var IPKver = "";
var IPKidx = "";
var encLen = "";
var ehashTaSIM = "";
var preText = "";
var reqAuth_send_str = "";
var pos_head_str = "";

var ipk_cardBin = "";
var ipk_timeStamp = "";

var type = "";
var ekbpk = "";
var KBPKver = "";
var KBPKidx = "";
var KBPKalg = "";

var req_ipek_send_str = "";

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
function goAction()
{
	var sFlag = $('input[name="selectFlag"]:checked').val();
	setCardReaderOpen()
	if ( sFlag == "1" ) {
		getSamDanReq();
	} 
	else if(sFlag == "2"  ){
		getBCSamDanReq();	//BC 단말인증 , ipk 다운로드
	}
	else if(sFlag == "3") {
		getSHSamDanReq();	//신한 단말인증 , ipk 다운로드	
	}
	else {
		
	}
	readerClose();	
	location.reload();
	
}

function setCardReaderOpen(){
    
    var sPort = 3;      // PORT정보 가져오기
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

function getSamDanReq(){
	var cardBin = '944541';
	var kbsajaNo = '1000000009';
	var sajaNo = '1298542346';
	var infgid = '01';
	var danType = '20';
	//var posid = '###AKWEBPOS10001';//######EP-7633001 ########2003POST ####AKWEBPOS1001
	var posid    = '####AKWEBPOS3001'; 	// cmc - 식별번호 변경
	var timeStm = getNow() + getTime();
	
	ref = cardX.ReqCmd( 0xFB, 0x11, 0x43, cardBin+sajaNo+infgid+danType+posid+timeStm,"안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "정보인증요청중입니다.","실패요!!");

	
	if(ref > 0){
		var danmal_data = cardX.RcvData;
		
		auth_cardBin = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		saupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		certiflag = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		nsaupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		nDanmaltype = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		danmalSerial = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		danmalCertiNo1 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		danmalCertiNo2 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		auth_timeStamp = danmal_data.substring(0,14); danmal_data = danmal_data.substring(14);
		taSimid = danmal_data.substring(0,32); danmal_data = danmal_data.substring(32);
		ATC = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
		random = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		hashAlgoId = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		hsahtaSIM = danmal_data.substring(0,512); danmal_data = danmal_data.substring(512);
		IPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		IPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		encLen = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		ehashTaSIM = danmal_data.substring(0,1024); danmal_data = danmal_data.substring(1024);
		preText = danmal_data.substring(0,216); danmal_data = danmal_data.substring(216);
		danmal_data = "";
	}else{
		return;
	}	
	
	//전문IC[6]+응답코드[4]+단품 INDEX 정보[8]+소스 INDEX 정보[8]+CLASS INDEX 정보	[8]+담당자 INDEX 정보[8]
	pos_head_str  = "XB281S"+"0000"+"00000000"+"00000000"+"00000000"+"00000000";
	//거래구분코드[4]AN+전문전송일시[14]N+카드사구분코드[6]N+사업자번호(기관번호)[10]N+거래고유번호[12]AN+예비[54]AN		
	var head_str  = "T010"+f_setfill(auth_timeStamp,14,'R')+f_setfill(auth_cardBin,6,'R')+f_setfill(kbsajaNo,10,'R')+f_setfill("031030159999",12,'R')+f_setfill("",54,'R');
	//인증 구분 식별자[2]AN+가맹점사업자번호[10]N+단말기형태[2]N+단말기고유번호[20]ANS+등록단말기식별번호#1[16]ANS
	//등록단말기식별번호#2[16]ANS+TIMESTAMP[14]N+taSIM-id[32]AN+ATC[8]AN+RANDOM[16]AN+HASH알고리즘-id[2]AN
	//HASHtaSIM[512]AN+IPK-Version[2]AN+IPK-Index[4]AN+Encryption Length[4]N+E(HASHtaSIM)[1024]AN+예비[216]ANS
	var data_str = f_setfill(certiflag,2,'R')+f_setfill(nsaupjaNo,10,'R')+//f_setfill(model.getValue("root/data/reqAuthDan/saupjaNo"),10,'R')+
					f_setfill(nDanmaltype,2,'R')+f_setfill(danmalSerial,20,'R')+
					f_setfill(danmalCertiNo1,16,'R')+f_setfill(danmalCertiNo2,16,'R')+
					f_setfill(auth_timeStamp,14,'R')+f_setfill(taSimid,32,'R')+
					f_setfill(ATC,8,'R')+f_setfill(random,16,'R')+
					f_setfill(hashAlgoId,2,'R')+f_setfill(hsahtaSIM,512,'R')+
					f_setfill(IPKver,2,'R')+f_setfill(IPKidx,4,'R')+
					f_setfill(encLen,4,'R')+f_setfill(ehashTaSIM,1024,'R')+
					f_setfill(preText,216,'R');
					
	var reqAuth_send_str = pos_head_str+head_str+data_str;
	
	reqAuth_send_str = f_setfill(reqAuth_send_str,2048,'R');
	
	timeStm = getNow() + getTime();
	var recardBin = ""; // 각 카드사 대표BIN N 6
	var resajaNo = ""; // 가맹점 사업자번호 또는 카드사가 부여한 기관번호  N 10
	var resCode =  ""; //응답코드 AN 4
	var randomHost = ""; // RANDOMHOST AN 16 카드사 호스트가 생성한 랜덤번호
	var iskver = ""; //ISK-Version AN 2 IPK 의 버전과 동일
	var iskidx = ""; //ISK-Index AN 4 IPK 의 인덱스값과 동일
	var signDt = ""; //Sign data 길이 N 4 사인 데이터의 길이 예) “0512” (실제 사인데이터 길이256)
	var signRhost = ""; //Sign(RANDOMHOST) AN 1,024 ISK 로 사인한 결과값 실제 암호화된 데이터(512 byte) 외의 나머지데이터(512 byte)는 공백 문자(0x20) 패딩
	var preText = f_setfill("",846,'R')//model.getValue("/root/res/resAuthDan/preText") ; //예비 ANS 846 공백문자.
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetReqAuthDanmal",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			pos_head_str : pos_head_str,
			reqAuth_send_str : reqAuth_send_str
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			recardBin = result.recardBin; // 각 카드사 대표BIN N 6
			resajaNo = result.resajaNo; // 가맹점 사업자번호 또는 카드사가 부여한 기관번호  N 10
			resCode =  result.resCode; //응답코드 AN 4
			randomHost = result.randomHost; // RANDOMHOST AN 16 카드사 호스트가 생성한 랜덤번호
			iskver = result.iskver; //ISK-Version AN 2 IPK 의 버전과 동일
			iskidx = result.iskidx; //ISK-Index AN 4 IPK 의 인덱스값과 동일
			signDt = result.signDt; //Sign data 길이 N 4 사인 데이터의 길이 예) “0512” (실제 사인데이터 길이256)
			signRhost = result.signRhost; //Sign(RANDOMHOST) AN 1,024 ISK 로 사인한 결과값 실제 암호화된 데이터(512 byte) 외의 나머지데이터(512 byte)는 공백 문자(0x20) 패딩
			preText = f_setfill("",846,'R')//model.getValue("/root/res/resAuthDan/preText") ; //예비 ANS 846 공백문자.
		}
	});

	ref = cardX.ReqCmd( 0xFB, 0x11, 0x44, recardBin+resajaNo+resCode+randomHost+iskver+iskidx+signDt+f_setfill(signRhost,1024,'R')+preText,"안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "SAM정보결과 수신중입니다.","실패요!!");

	if(ref < 0){
			alert("실패");
			return;
	}else{
		alert("SAM정보결과 수신완료");
	}	

	ref = cardX.ReqCmd( 0xFB, 0x11, 0x45, cardBin+sajaNo+danType+danmalCertiNo1+timeStm,"안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "IPEK정보인증요청중입니다.","실패요!!");
	
	

	if(ref > -1){
		
		var danmal_data = cardX.RcvData;
		
		ipk_cardBin = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		saupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		type = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		danmalSerial = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		danmalCertiNo1 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		danmalCertiNo2 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		ipk_timeStamp = danmal_data.substring(0,14); danmal_data = danmal_data.substring(14);
		taSimid = danmal_data.substring(0,32); danmal_data = danmal_data.substring(32);
		IPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		IPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		KBPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		KBPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		KBPKalg = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
		encLen = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		ekbpk = danmal_data.substring(0,1024); danmal_data = danmal_data.substring(1024);
		preText = danmal_data.substring(0,749); danmal_data = danmal_data.substring(749);
		danmal_data = "";
	}

	//전문IC[6]+응답코드[4]+단품 INDEX 정보[8]+소스 INDEX 정보[8]+CLASS INDEX 정보	[8]+담당자 INDEX 정보[8]
	 pos_head_str  = "XB282S"+"0000"+"00000000"+"00000000"+"00000000"+"00000000";
	//거래구분코드[4]AN+전문전송일시[14]N+카드사구분코드[6]N+사업자번호(기관번호)[10]N+거래고유번호[12]AN+예비[54]AN		
	 head_str  = "T020"+f_setfill(auth_timeStamp,14,'R')+f_setfill(auth_cardBin,6,'R')+f_setfill(kbsajaNo,10,'R')+f_setfill("031030159999",12,'R')+f_setfill("",54,'R');
	//가맹점사업자번호[10]N+단말기형태[2]N+단말기고유번호[20]ANS+등록단말기식별번호#1[16]ANS+등록단말기식별번호#2[16]ANS+
	//TIMESTAMP[14]N+taSIM-id[32]AN+IPK-Version[2]AN+IPK-Index[4]AN+KBPK-Version[2]AN+KBPK-Index[4]AN+KBPK-ALG[1]AN+
	//Encryption Length[4]AN+E(KBPK)IPK[1024]AN+예비[749]ANS
	 data_str = f_setfill(saupjaNo,10,'R')+f_setfill(type,2,'R')+
					f_setfill(danmalSerial,20,'R')+f_setfill(danmalCertiNo1,16,'R')+
					f_setfill(danmalCertiNo2,16,'R')+f_setfill(ipk_timeStamp,14,'R')+
					f_setfill(taSimid,32,'R')+f_setfill(IPKver,2,'R')+
					f_setfill(IPKidx,4,'R')+f_setfill(KBPKver,2,'R')+
					f_setfill(KBPKidx,4,'R')+f_setfill(KBPKalg,1,'R')+
					f_setfill(encLen,4,'R')+f_setfill(ekbpk,1024,'R')+
					f_setfill(preText,749,'R');
	var reqAuth_send_str = pos_head_str+head_str+data_str;
	
	req_ipek_send_str = f_setfill(reqAuth_send_str,2048,'R');
	
	recardBin = "";
	resajaNo = "";
	resCode	 = "";
	 var KSN		 = "";
	 var ipekver	 = "";
	 var ipekidx	 = "";
	 var ipekalg	 = "";
	 var eipeklen = "";
	 var eipek	 = "";
	 var maclen	 = "";
	 var mac		 = "";
	 var kbnm = ""; 
	 preText	 = "";

	$.ajax({
		type : "POST", 
		url : "/member/lect/GetReqAuthDanmal",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			pos_head_str : pos_head_str,
			req_ipek_send_str : req_ipek_send_str
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			recardBin = result.recardBin;
			resajaNo = result.resajaNo;
			resCode	 = result.resCode;
			 var KSN		 = result.KSN;
			 var ipekver	 = result.ipekver;
			 var ipekidx	 = result.ipekidx;
			 var ipekalg	 = result.ipekalg;
			 var eipeklen = result.eipeklen;
			 var eipek	 = f_setfill(result.eipek,512,'R');
			 var maclen	 = result.maclen;
			 var mac		 = result.mac;
			 var kbnm = f_setfill("KBCARD",10,'R'); 
			 preText	 = f_setfill("",1333,'R')//model.getValue("/root/res/resIPEKDan/preText");
		}
	});
	

	ref = cardX.ReqCmd( 0xFB, 0x11, 0x46, "A"+cardBin+sajaNo+kbnm+resCode+KSN+ipekver+ipekidx+ipekalg+eipeklen+eipek+maclen+mac+preText,"안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "IPEK정보결과 수신중입니다.","실패요!!");

	if(ref < 0){
		alert("실패");

	}else{
		alert("IPEK정보결과 수신완료");
	}	
	dataReset();
}

function getBCSamDanReq(){
	var cardBin  = '942150';		//BC 카드사 대표 BIN
	var bcsajaNo = '1000000013';	//사업자번호(기관번호)
	var sajaNo   = '1298542346';
	var infgid   = '01';
	var danType  = '20';
	var posid    = '####AKWEBPOS3001'; 	// cmc - 식별번호 변경
	var timeStm = getNow() + getTime();
	
	/* 단말인증거래 T010 시작 - bc 는 7010 으로 넘김 */
	ref = cardX.ReqCmd( 0xFB, 0x11, 0x43,   cardBin
	                                      + sajaNo
										  + infgid
										  + danType
										  + posid
										  + timeStm, "안됨");					
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "정보인증 요청 중 입니다.", "실패요!!");
	
	
	if(ref > 0){
		var danmal_data = cardX.RcvData;
		
		auth_cardBin = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		saupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		certiflag = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		nsaupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		nDanmaltype = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		danmalSerial = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		danmalCertiNo1 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		danmalCertiNo2 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		auth_timeStamp = danmal_data.substring(0,14); danmal_data = danmal_data.substring(14);
		taSimid = danmal_data.substring(0,32); danmal_data = danmal_data.substring(32);
		ATC = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
		random = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		hashAlgoId = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		hsahtaSIM = danmal_data.substring(0,512); danmal_data = danmal_data.substring(512);
		IPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		IPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		encLen = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		ehashTaSIM = danmal_data.substring(0,1024); danmal_data = danmal_data.substring(1024);
		preText = danmal_data.substring(0,216); danmal_data = danmal_data.substring(216);
		danmal_data = "";
	}else{
		return;
	}	
	
	pos_head_str  = "XB411S"	// 전문IC[6] 
	                  + "0000"		// 응답코드[4]
					  + "00000000"	// 단품 INDEX 정보[8]
					  + "00000000"	// 소스 INDEX 정보[8]
					  + "00000000"	// CLASS INDEX 정보	[8]
					  + "00000000" ;// 담당자 INDEX 정보[8]
	
	//전문 헤더	/*  bc 는 7010 으로 넘김 */
	var head_str  = "7010"																// 거래구분코드[4]AN
	              + f_setfill(auth_timeStamp,14,'R')	// 전문전송일시[14]N
				  + f_setfill(auth_cardBin,6,'R')		// 카드사구분코드[6]N
				  + f_setfill(bcsajaNo,10,'R')											// 사업자번호(기관번호)[10]N
				  + f_setfill("729219001506", 12, 'R')									// 거래고유번호[12]AN
				  + f_setfill("",54,'R') ;												// 예비[54]AN	
	
	//전문 DETAIL
	var data_str = f_setfill(certiflag,2,'R')		// 인증 구분 식별자[2]AN
	             + f_setfill(nsaupjaNo,10,'R')		// 가맹점사업자번호[10]N	
	             + f_setfill(nDanmaltype,2,'R')		// 단말기형태[2]N
				 + f_setfill(danmalSerial,20,'R')	// 단말기고유번호[20]ANS
				 + f_setfill(danmalCertiNo1,16,'R')	// 등록단말기식별번호#1[16]ANS
				 + f_setfill(danmalCertiNo2,16,'R')	// 등록단말기식별번호#2[16]ANS
				 + f_setfill(auth_timeStamp,14,'R')		// TIME STAMP[14]N
				 + f_setfill(taSimid,32,'R')			// taSIM-id[32]AN
				 + f_setfill(ATC,8,'R')				// ATC[8]AN
				 + f_setfill(random,16,'R')			// RANDOM[16]AN
				 + f_setfill(hashAlgoId,2,'R')		// HASH알고리즘-id[2]AN
				 + f_setfill(hsahtaSIM,512,'R')		// HASHtaSIM[512]AN
				 + f_setfill(IPKver,2,'R')			// IPK-Version[2]AN
				 + f_setfill(IPKidx,4,'R')			// IPK-Index[4]AN
				 + f_setfill(encLen,4,'R')			// Encryption Length[4]N
				 + f_setfill(ehashTaSIM,1024,'R')	// E(HASHtaSIM)[1024]AN
				 + f_setfill(preText,216,'R') ;		// 예비[216]ANS

	var reqAuth_send_str = pos_head_str + head_str + data_str;
	
	reqAuth_send_str = f_setfill(reqAuth_send_str, 2048, 'R');
	
	timeStm = getNow() + getTime();
	var recardBin = ""; // 각 카드사 대표BIN N 6
	var resajaNo = ""; // 가맹점 사업자번호 또는 카드사가 부여한 기관번호  N 10
	var resCode =  ""; //응답코드 AN 4
	var randomHost = ""; // RANDOMHOST AN 16 카드사 호스트가 생성한 랜덤번호
	var iskver = ""; //ISK-Version AN 2 IPK 의 버전과 동일
	var iskidx = ""; //ISK-Index AN 4 IPK 의 인덱스값과 동일
	var signDt = ""; //Sign data 길이 N 4 사인 데이터의 길이 예) “0512” (실제 사인데이터 길이256)
	var signRhost = ""; //Sign(RANDOMHOST) AN 1,024 ISK 로 사인한 결과값 실제 암호화된 데이터(512 byte) 외의 나머지데이터(512 byte)는 공백 문자(0x20) 패딩
	var preText = f_setfill("",846,'R')//model.getValue("/root/res/resAuthDan/preText") ; //예비 ANS 846 공백문자.

	
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetReqAuthDanmal",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			pos_head_str : pos_head_str,
			reqAuth_send_str : reqAuth_send_str
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			recardBin = result.recardBin; // 각 카드사 대표BIN N 6
			resajaNo = result.resajaNo; // 가맹점 사업자번호 또는 카드사가 부여한 기관번호  N 10
			resCode =  result.resCode; //응답코드 AN 4
			randomHost = result.randomHost; // RANDOMHOST AN 16 카드사 호스트가 생성한 랜덤번호
			iskver = result.iskver; //ISK-Version AN 2 IPK 의 버전과 동일
			iskidx = result.iskidx; //ISK-Index AN 4 IPK 의 인덱스값과 동일
			signDt = result.signDt; //Sign data 길이 N 4 사인 데이터의 길이 예) “0512” (실제 사인데이터 길이256)
			signRhost = result.signRhost; //Sign(RANDOMHOST) AN 1,024 ISK 로 사인한 결과값 실제 암호화된 데이터(512 byte) 외의 나머지데이터(512 byte)는 공백 문자(0x20) 패딩
			preText = f_setfill("",846,'R')//model.getValue("/root/res/resAuthDan/preText") ; //예비 ANS 846 공백문자.
		}
	});
	
	timeStm = getNow() + getTime();
	
	ref = cardX.ReqCmd( 0xFB, 0x11, 0x44,   recardBin
	                                      + resajaNo
										  + resCode
										  + randomHost
										  + iskver
										  + iskidx
										  + signDt
										  + f_setfill(signRhost,1024,'R')+preText, "안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "SAM정보결과 수신중입니다.", "실패요!!");

	if(ref < 0){
			alert("실패");
			return;
	}
	else{
		alert("SAM정보결과 수신완료");
	}	
	/* 단말인증거래 T010 끝 */
	
	/* 암호화키 다운로드거래 T020 시작 */
	ref = cardX.ReqCmd( 0xFB, 0x11, 0x45,   cardBin
	                                      + sajaNo
										  + danType
										  + danmalCertiNo1
										  + timeStm, "안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "IPEK정보인증 요청 중 입니다.","실패요!!");

	if(ref > -1){
		
		var danmal_data = cardX.RcvData;
		
		ipk_cardBin = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		saupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		type = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		danmalSerial = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		danmalCertiNo1 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		danmalCertiNo2 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		ipk_timeStamp = danmal_data.substring(0,14); danmal_data = danmal_data.substring(14);
		taSimid = danmal_data.substring(0,32); danmal_data = danmal_data.substring(32);
		IPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		IPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		KBPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		KBPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		KBPKalg = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
		encLen = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		ekbpk = danmal_data.substring(0,1024); danmal_data = danmal_data.substring(1024);
		preText = danmal_data.substring(0,749); danmal_data = danmal_data.substring(749);
		danmal_data = "";
	}

	//전문IC[6]+응답코드[4]+단품 INDEX 정보[8]+소스 INDEX 정보[8]+CLASS INDEX 정보	[8]+담당자 INDEX 정보[8]
	 pos_head_str  = "XB412S"+"0000"+"00000000"+"00000000"+"00000000"+"00000000";
	 
	 head_str  = "7020"																// 거래구분코드[4]AN
	           + f_setfill(auth_timeStamp,14,'R')	// 전문전송일시[14]N
			   + f_setfill(auth_cardBin,6,'R')	// 카드사구분코드[6]N
			   + f_setfill(bcsajaNo, 10, 'R')										// 사업자번호(기관번호)[10]N
			   + f_setfill("729219001507", 12, 'R')									// 거래고유번호[12]AN
			   + f_setfill("",54,'R') ;												// 예비[54]AN

	 data_str = f_setfill(saupjaNo,10,'R')		// 가맹점사업자번호[10]N
	          + f_setfill(type,2,'R')			// 단말기형태[2]N
			  + f_setfill(danmalSerial,20,'R')	// 단말기고유번호[20]ANS
			  + f_setfill(danmalCertiNo1,16,'R')	// 등록단말기식별번호#1[16]ANS
			  + f_setfill(danmalCertiNo2,16,'R')	// 등록단말기식별번호#2[16]ANS
			  + f_setfill(ipk_timeStamp,14,'R')		// TIMESTAMP[14]N
			  + f_setfill(taSimid,32,'R')		// taSIM-id[32]AN
			  + f_setfill(IPKver,2,'R')			// IPK-Version[2]AN
			  + f_setfill(IPKidx,4,'R')			// IPK-Index[4]AN
			  + f_setfill(KBPKver,2,'R')			// KBPK-Version[2]AN+
			  + f_setfill(KBPKidx,4,'R')			// KBPK-Index[4]AN
			  + f_setfill(KBPKalg,1,'R')			// KBPK-ALG[1]AN
			  + f_setfill(encLen,4,'R')			// Encryption Length[4]AN
			  + f_setfill(ekbpk,1024,'R')		// E(KBPK)IPK[1024]AN
			  + f_setfill(preText,749,'R') ;		// 예비[749]ANS
			  
	var reqAuth_send_str = pos_head_str + head_str + data_str;
	
	req_ipek_send_str = f_setfill(reqAuth_send_str,2048,'R');
	
	recardBin = "";
	resajaNo = "";
	resCode	 = "";
	 var KSN		 = "";
	 var ipekver	 = "";
	 var ipekidx	 = "";
	 var ipekalg	 = "";
	 var eipeklen = "";
	 var eipek	 = "";
	 var maclen	 = "";
	 var mac		 = "";
	 var bcnm = ""; 
	 preText	 = "";
	
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetReqAuthDanmal",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			pos_head_str : pos_head_str,
			req_ipek_send_str : req_ipek_send_str
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			recardBin = result.recardBin;
			resajaNo = result.resajaNo;
			resCode	 = result.resCode;
			 var KSN		 = result.KSN;
			 var ipekver	 = result.ipekver;
			 var ipekidx	 = result.ipekidx;
			 var ipekalg	 = result.ipekalg;
			 var eipeklen = result.eipeklen;
			 var eipek	 = f_setfill(result.eipek,512,'R');
			 var maclen	 = result.maclen;
			 var mac		 = result.mac;
			 var bcnm = f_setfill("BCCARD",10,'R'); 
			 preText	 = f_setfill("",1333,'R')//model.getValue("/root/res/resIPEKDan/preText");
		}
	});
	
	/*  0000	정상
		0001	입력값오류
		0002	동일인증값(타임스탬프/랜덤)
		0003	tasim-id/단말기정보(고유번호,식별번호) 상이
		0004	미등록기관 (조치방법 :가맹점사업자번호를 카드사에 등록해야함)
		0005	HASH 불일치
		0006	신규IPK 미등록 (T030거래)
		0007	미인증단말기 오류 (T020거래)
		0011	암복호화 장비연계오류
		9999	기타오류 (system오류등)
	*/

	ref = cardX.ReqCmd( 0xFB, 0x11, 0x46, "A" + cardBin
	                                          + sajaNo
	                                          + bcnm
											  + resCode
											  + KSN
											  + ipekver
											  + ipekidx
											  + ipekalg
											  + eipeklen
											  + eipek
											  + maclen
											  + mac
											  + preText, "안됨" );

	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "IPEK정보결과 수신 중 입니다.", "실패요!!");

	if(ref < 0){
		alert("실패");

	}
	else{
		alert("IPEK정보결과 수신완료");
	}
	dataReset();
	
}

function getSHSamDanReq(){

	var cardBin  = '451842';		//각 카드사 대표 BIN
	var shsajaNo = '1000000015';	//사업자번호(기관번호)
	var sajaNo   = '1298542346';
	var infgid   = '01';
	var danType  = '20';
	//var posid    = '###AKWEBPOS10001'; 
	var posid    = '####AKWEBPOS3001'; 	// cmc - 식별번호 변경
	var timeStm = getNow() + getTime();
	
	/* 단말인증거래 T010 시작 */
	ref = cardX.ReqCmd( 0xFB, 0x11, 0x43, cardBin
															+ shsajaNo
															+ infgid
															+ danType
															+ posid
															+ timeStm, "안됨");
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "정보인증 요청 중 입니다.", "실패요!!");
	
	if(ref > 0){
		var danmal_data = cardX.RcvData;
		
		auth_cardBin = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		saupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		certiflag = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		nsaupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		nDanmaltype = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		danmalSerial = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		danmalCertiNo1 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		danmalCertiNo2 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		auth_timeStamp = danmal_data.substring(0,14); danmal_data = danmal_data.substring(14);
		taSimid = danmal_data.substring(0,32); danmal_data = danmal_data.substring(32);
		ATC = danmal_data.substring(0,8); danmal_data = danmal_data.substring(8);
		random = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		hashAlgoId = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		hsahtaSIM = danmal_data.substring(0,512); danmal_data = danmal_data.substring(512);
		IPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		IPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		encLen = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		ehashTaSIM = danmal_data.substring(0,1024); danmal_data = danmal_data.substring(1024);
		preText = danmal_data.substring(0,216); danmal_data = danmal_data.substring(216);
		danmal_data = "";
	}else{
		return;
	}

	var pos_head_str  = "XB421S"	// 전문IC[6] 
	                  + "0000"		// 응답코드[4]
					  + "00000000"	// 단품 INDEX 정보[8]
					  + "00000000"	// 소스 INDEX 정보[8]
					  + "00000000"	// CLASS INDEX 정보	[8]
					  + "00000000" ;// 담당자 INDEX 정보[8]
					  
	//전문 헤더
	var head_str  = "T010"																// 거래구분코드[4]AN
	              + f_setfill(auth_timeStamp,14,'R')	// 전문전송일시[14]N
				  + f_setfill(auth_cardBin,6,'R')		// 카드사구분코드[6]N
				  + f_setfill(shsajaNo,10,'R')											// 사업자번호(기관번호)[10]N
				  + f_setfill("729219001506", 12, 'R')									// 거래고유번호[12]AN
				  + f_setfill("",54,'R') ;												// 예비[54]AN
	
	//전문 DETAIL
	var data_str = f_setfill(certiflag,2,'R')		// 인증 구분 식별자[2]AN
				    + f_setfill(nsaupjaNo,10,'R')		// 가맹점사업자번호[10]N	
				    + f_setfill(nDanmaltype,2,'R')		// 단말기형태[2]N
					 + f_setfill(danmalSerial,20,'R')	// 단말기고유번호[20]ANS
					 + f_setfill(danmalCertiNo1,16,'R')	// 등록단말기식별번호#1[16]ANS
					 + f_setfill(danmalCertiNo2,16,'R')	// 등록단말기식별번호#2[16]ANS
					 + f_setfill(auth_timeStamp,14,'R')		// TIME STAMP[14]N
					 + f_setfill(taSimid,32,'R')			// taSIM-id[32]AN
					 + f_setfill(ATC,8,'R')				// ATC[8]AN
					 + f_setfill(random,16,'R')			// RANDOM[16]AN
					 + f_setfill(hashAlgoId,2,'R')		// HASH알고리즘-id[2]AN
					 + f_setfill(hsahtaSIM,512,'R')		// HASHtaSIM[512]AN
					 + f_setfill(IPKver,2,'R')			// IPK-Version[2]AN
					 + f_setfill(IPKidx,4,'R')			// IPK-Index[4]AN
					 + f_setfill(encLen,4,'R')			// Encryption Length[4]N
					 + f_setfill(ehashTaSIM,1024,'R')	// E(HASHtaSIM)[1024]AN
					 + f_setfill(preText,216,'R') ;		// 예비[216]ANS
					
	var reqAuth_send_str = pos_head_str + head_str + data_str;
	
	reqAuth_send_str = f_setfill(reqAuth_send_str, 2048, 'R');
	
	timeStm = getNow() + getTime();
	var recardBin = ""; // 각 카드사 대표BIN N 6
	var resajaNo = ""; // 가맹점 사업자번호 또는 카드사가 부여한 기관번호  N 10
	var resCode =  ""; //응답코드 AN 4
	var randomHost = ""; // RANDOMHOST AN 16 카드사 호스트가 생성한 랜덤번호
	var iskver = ""; //ISK-Version AN 2 IPK 의 버전과 동일
	var iskidx = ""; //ISK-Index AN 4 IPK 의 인덱스값과 동일
	var signDt = ""; //Sign data 길이 N 4 사인 데이터의 길이 예) “0512” (실제 사인데이터 길이256)
	var signRhost = ""; //Sign(RANDOMHOST) AN 1,024 ISK 로 사인한 결과값 실제 암호화된 데이터(512 byte) 외의 나머지데이터(512 byte)는 공백 문자(0x20) 패딩
	var preText = f_setfill("",846,'R')//model.getValue("/root/res/resAuthDan/preText") ; //예비 ANS 846 공백문자.

	
	$.ajax({
		type : "POST", 
		url : "/member/lect/GetReqAuthDanmal",
		dataType : "text",
		async:false,
		cache : false,
		data : 
		{
			store : $("#selBranch").val(),
			pos_head_str : pos_head_str,
			reqAuth_send_str : reqAuth_send_str
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			recardBin = result.recardBin; // 각 카드사 대표BIN N 6
			resajaNo = result.resajaNo; // 가맹점 사업자번호 또는 카드사가 부여한 기관번호  N 10
			resCode =  result.resCode; //응답코드 AN 4
			randomHost = result.randomHost; // RANDOMHOST AN 16 카드사 호스트가 생성한 랜덤번호
			iskver = result.iskver; //ISK-Version AN 2 IPK 의 버전과 동일
			iskidx = result.iskidx; //ISK-Index AN 4 IPK 의 인덱스값과 동일
			signDt = result.signDt; //Sign data 길이 N 4 사인 데이터의 길이 예) “0512” (실제 사인데이터 길이256)
			signRhost = result.signRhost; //Sign(RANDOMHOST) AN 1,024 ISK 로 사인한 결과값 실제 암호화된 데이터(512 byte) 외의 나머지데이터(512 byte)는 공백 문자(0x20) 패딩
			preText = f_setfill("",846,'R')//model.getValue("/root/res/resAuthDan/preText") ; //예비 ANS 846 공백문자.
		}
	});
	timeStm = getNow() + getTime();
	

	ref = cardX.ReqCmd( 0xFB, 0x11, 0x44,   recardBin
															  + resajaNo
															  + resCode
															  + randomHost
															  + iskver
															  + iskidx
															  + signDt
															  + f_setfill(signRhost,1024,'R')+preText, "안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "SAM정보결과 수신중입니다.", "실패요!!");
	
	if(ref < 0){
			alert("실패");
			return;
	}
	else{
		alert("SAM정보결과 수신완료");
	}	
	/* 단말인증거래 T010 끝 */
	
	/* 암호화키 다운로드거래 T020 시작 */
	ref = cardX.ReqCmd( 0xFB, 0x11, 0x45,   cardBin
															  //+ sajaNo
															  + shsajaNo
															  + danType
															  + danmalCertiNo1
															  + timeStm, "안됨" );
	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "IPEK정보인증 요청 중 입니다.","실패요!!");

	if(ref > -1){
		
		var danmal_data = cardX.RcvData;
		
		ipk_cardBin = danmal_data.substring(0,6); danmal_data = danmal_data.substring(6);
		saupjaNo = danmal_data.substring(0,10); danmal_data = danmal_data.substring(10);
		type = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		danmalSerial = danmal_data.substring(0,20); danmal_data = danmal_data.substring(20);
		danmalCertiNo1 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		danmalCertiNo2 = danmal_data.substring(0,16); danmal_data = danmal_data.substring(16);
		ipk_timeStamp = danmal_data.substring(0,14); danmal_data = danmal_data.substring(14);
		taSimid = danmal_data.substring(0,32); danmal_data = danmal_data.substring(32);
		IPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		IPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		KBPKver = danmal_data.substring(0,2); danmal_data = danmal_data.substring(2);
		KBPKidx = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		KBPKalg = danmal_data.substring(0,1); danmal_data = danmal_data.substring(1);
		encLen = danmal_data.substring(0,4); danmal_data = danmal_data.substring(4);
		ekbpk = danmal_data.substring(0,1024); danmal_data = danmal_data.substring(1024);
		preText = danmal_data.substring(0,749); danmal_data = danmal_data.substring(749);
		danmal_data = "";
	}

	//전문IC[6]+응답코드[4]+단품 INDEX 정보[8]+소스 INDEX 정보[8]+CLASS INDEX 정보	[8]+담당자 INDEX 정보[8]
	 pos_head_str  = "XB422S"+"0000"+"00000000"+"00000000"+"00000000"+"00000000";
	 
	 head_str  = "T020"																// 거래구분코드[4]AN
	           + f_setfill(auth_timeStamp,14,'R')	// 전문전송일시[14]N
			   + f_setfill(auth_cardBin,6,'R')	// 카드사구분코드[6]N
			   + f_setfill(shsajaNo, 10, 'R')										// 사업자번호(기관번호)[10]N
			   + f_setfill("729219001507", 12, 'R')									// 거래고유번호[12]AN
			   + f_setfill("",54,'R') ;												// 예비[54]AN
			   
	 data_str = f_setfill(saupjaNo,10,'R')		// 가맹점사업자번호[10]N
			     + f_setfill(type,2,'R')			// 단말기형태[2]N
				  + f_setfill(danmalSerial,20,'R')	// 단말기고유번호[20]ANS
				  + f_setfill(danmalCertiNo1,16,'R')	// 등록단말기식별번호#1[16]ANS
				  + f_setfill(danmalCertiNo2,16,'R')	// 등록단말기식별번호#2[16]ANS
				  + f_setfill(ipk_timeStamp,14,'R')		// TIMESTAMP[14]N
				  + f_setfill(taSimid,32,'R')		// taSIM-id[32]AN
				  + f_setfill(IPKver,2,'R')			// IPK-Version[2]AN
				  + f_setfill(IPKidx,4,'R')			// IPK-Index[4]AN
				  + f_setfill(KBPKver,2,'R')			// KBPK-Version[2]AN+
				  + f_setfill(KBPKidx,4,'R')			// KBPK-Index[4]AN
				  + f_setfill(KBPKalg,1,'R')			// KBPK-ALG[1]AN
				  + f_setfill(encLen,4,'R')			// Encryption Length[4]AN
				  + f_setfill(ekbpk,1024,'R')		// E(KBPK)IPK[1024]AN
				  + f_setfill(preText,749,'R') ;		// 예비[749]ANS
			  
	var reqAuth_send_str = pos_head_str + head_str + data_str;
	
	req_ipek_send_str = f_setfill(reqAuth_send_str,2048,'R');
	
	recardBin = "";
	resajaNo = "";
	resCode	 = "";
	 var KSN		 = "";
	 var ipekver	 = "";
	 var ipekidx	 = "";
	 var ipekalg	 = "";
	 var eipeklen = "";
	 var eipek	 = "";
	 var maclen	 = "";
	 var mac		 = "";
	 var shnm = ""; 
	 preText	 = "";
	 
	 $.ajax({
			type : "POST", 
			url : "/member/lect/GetReqAuthDanmal",
			dataType : "text",
			async:false,
			cache : false,
			data : 
			{
				store : $("#selBranch").val(),
				pos_head_str : pos_head_str,
				req_ipek_send_str : req_ipek_send_str
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
				
				recardBin = result.recardBin;
				resajaNo = result.resajaNo;
				resCode	 = result.resCode;
				 var KSN		 = result.KSN;
				 var ipekver	 = result.ipekver;
				 var ipekidx	 = result.ipekidx;
				 var ipekalg	 = result.ipekalg;
				 var eipeklen = result.eipeklen;
				 var eipek	 = f_setfill(result.eipek,512,'R');
				 var maclen	 = result.maclen;
				 var mac		 = result.mac;
				 var shnm = f_setfill("SHCARD",10,'R'); 
				 preText	 = f_setfill("",1333,'R')//model.getValue("/root/res/resIPEKDan/preText");
			}
		});
	
	/*  0000	정상
		0001	입력값오류
		0002	동일인증값(타임스탬프/랜덤)
		0003	tasim-id/단말기정보(고유번호,식별번호) 상이
		0004	미등록기관 (조치방법 :가맹점사업자번호를 카드사에 등록해야함)
		0005	HASH 불일치
		0006	신규IPK 미등록 (T030거래)
		0007	미인증단말기 오류 (T020거래)
		0011	암복호화 장비연계오류
		9999	기타오류 (system오류등)
	*/

	ref = cardX.ReqCmd( 0xFB, 0x11, 0x46, "A" + cardBin
																  + sajaNo
																  + shnm
																  + resCode
																  + KSN
																  + ipekver
																  + ipekidx
																  + ipekalg
																  + eipeklen
																  + eipek
																  + maclen
																  + mac
																  + preText, "안됨" );

	ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 1, "IPEK정보결과 수신 중 입니다.", "실패요!!");

	if(ref < 0){
		alert("실패");
	}
	else{
		alert("IPEK정보결과 수신완료");
	}
	/* 암호화키 다운로드거래 T020 끝 */
	dataReset();

}

function dataReset()
{
	auth_cardBin = "";
	saupjaNo = "";
	certiflag = "";
	nsaupjaNo = "";
	nDanmaltype = "";
	danmalSerial = "";
	danmalCertiNo1 = "";
	danmalCertiNo2 = "";
	auth_timeStamp = "";
	taSimid = "";
	ATC = "";
	random = "";
	hashAlgoId = "";
	hsahtaSIM = "";
	IPKver = "";
	IPKidx = "";
	encLen = "";
	ehashTaSIM = "";
	preText = "";
	reqAuth_send_str = "";
	pos_head_str = "";

	ipk_cardBin = "";
	ipk_timeStamp = "";

	type = "";
	ekbpk = "";
	KBPKver = "";
	KBPKidx = "";
	KBPKalg = "";

	req_ipek_send_str = "";
	
	req_ipek_send_str = f_setfill(reqAuth_send_str,2048,'R');
	
	recardBin = "";
	resajaNo = "";
	resCode	 = "";
	KSN		 = "";
	ipekver	 = "";
	ipekidx	 = "";
	ipekalg	 = "";
	eipeklen = "";
	eipek	 = "";
	maclen	 = "";
	mac		 = "";
	kbnm = ""; 
	preText	 = "";
	cardDanMemReset();
}
function cardDanMemReset(){
    cardX.RcvData = 1 ;
    cardX.RcvData = 0 ;
   
    cardX.Emv = 1 ;
    cardX.Emv = 0 ;
    
    cardX.ResetMem(); 
    cardX.ReqReset();
}