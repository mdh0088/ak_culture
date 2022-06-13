/**
 * BA(문화아카데미) 공통 javascript
 * 
 * @author 이 용 성
 * @version 1.0, 2007. 11. 12
 */

/**
 * 카드번호로 카드회사명과 flag를 불러오는 함수
 */


/********************************************************
 *   1. encode3des() : 해당문자를 3DES로 encode한다.
 *          - param   str        암호화할 문자
 *          - return  encode_str 암호화된 문자
*********************************************************/
function encode3des( str ) {
     var encode_str = des3Object.GetDesProd( str, 0);
     return encode_str;
}

/********************************************************
 *   2. decode3des() : 해당문자를 3DES로 decode한다.
 *          - param   str        복호화할 암호문자
 *          - return  decode_str 복호화된 문자
*********************************************************/
function decode3des( str ) {
     var decode_str = des3Object.GetDesProd( str, 1);
     return decode_str;
}    

/********************************************************
 *   3. encode_print() : 해당문자를 암호화하면 화면에 출력한다.  
 *          - param   str        암호화하여 화면에 출력할 문자
 *          - return  X
 *          - 사용방법 : <script>encode_print( "6695044BFE53A8D43137" )</script> 를 출력하고 싶은 위치에 넣는다.
*********************************************************/
function encode_print( str ) {
    document.write(encode3des( str ));
}

/********************************************************
 *   4. decode_print() : 해당문자를 복호화하면 화면에 출력한다.  
 *          - param   str        복호화하여 화면에 출력할 문자
 *          - return  X
 *          - 사용방법 <script>decode_print( "6695044BFE53A8D43137" )</script> 를 출력하고 싶은 위치에 넣는다.
*********************************************************/
function decode_print( str ) {
    document.write(decode3des( str ));
}

function f_card_gubun_nm(gubun, card_no) {
    //1. 인자값으로 받은 카드번호를 통해 국민제휴카드인지 조회한다. 삼성 -> 국민으로 변경 20170908
    var act = new Transaction(submission);
    act.setAction("/action/ba/GetCardCount");
    act.setRef("/root/req");
    act.setResultref("/root/res/card_info/li_row");
    if(act.submit(true)) {}

    var li_row = 0;
    li_row = model.getValue("/root/res/card_info/li_row");
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
            model.setValue("/root/req/card_no", ls_card_no);
            
            //ls_card_no를 통해 실제 카드정보를 조회한다.
            act.setAction("/action/ba/GetCardNo");
            act.setRef("/root/req");
            act.setResultref("/root/res/card_info");
            if(act.submit(true)) {
                model.setValue("/root/req/card_no", card_no);            
            }
        
            var card_flag           = model.getValue("/root/res/card_info/card_flag");
            var card_nm             = model.getValue("/root/res/card_info/card_nm");
            var card_co_origin_seq  = model.getValue("/root/res/card_info/card_co_origin_seq");
            var card_sain_fg        = model.getValue("/root/res/card_info/sain_fg");      // 10.06.10 추가 (전자서명 무서명 관련)
            var card_pri_nm         = model.getValue("/root/res/card_info/card_pri_nm");  // 12.11.20 발행사표기추가(제휴카드는 생략)
            
            //823 신한카드 중 822 신한제휴 구분 체크
            if(card_co_origin_seq == "823"){
            
                //신한제휴 고객 DB를 통해 신한제휴카드 구분함.
                act.setAction("/action/ba/GetCardCount822");
                act.setRef("/root/req");
                act.setResultref("/root/res/card_info/li_row822");
                if(act.submit(true)) {}
                
                var li_row822 = 0;
                li_row822 = model.getValue("/root/res/card_info/li_row822");
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

/**
 * 주민번호 유효성 체크
 */
function isValidSSN(str) {
    if(countNumericCharacter(str) != str.length) {
        return false;
    }
    var date = '';
    var t = str.charAt(6);
    switch(t) {
        case '1': case'2':
            date = '19' + str.substring(0,6);
            break;
        case '3': case'4':
            date = '20' + str.substring(0,6);
            break;
        default:
            return isValidAlienSSN(str);
    }
    if(!isValidDateString(date)) {
        return false;
    }
    var tot = 0;
    var sCode="234567892345";
    for(var i=0; i<12; i++) {
        tot += parseInt(str.substring(i,i+1), 10) * parseInt(sCode.substring(i,i+1), 10);
    }
    tot = 11 - (tot%11);
    tot = tot % 10;
    
    if(parseInt(str.substring(12, 13), 10) == tot) {
        return true;
    }else {
        return false;
    }
}
/** 
 * 스트링 문자열을 char 배열로 리턴한다.
 */
function strToArray(str) {
    var arr = new Array(str.length);
    for(var i=0; i<str.length; i++) {
        arr[i] = str.charAt(i);
    }
    return arr;
}
/**
 * 외국인 등록번호 유효성 체크
 */
function isValidAlienSSN(str) {
    if(countNumericCharacter(str) != str.length) {
        return false;
    }
    var date = '';
    var t = str.charAt(6);
    switch(t) {
        case '0': case'9':
            date = '18' + str.substring(0,6);
            break;
        case '5': case'6':
            date = '19' + str.substring(0,6);
            break;
        case '7': case'8':
            date = '20' + str.substring(0,6);
            break;
        default:
            return false;
    }
    if(!isValidDateString(date)) {
        return false;
    }
    var arr = strToArray(str);
    
    var odd = arr[7]*10 + arr[8];
    if(odd % 2 != 0) {
        return false;
    }
    if( arr[11]!=6 && arr[11]!=7 && arr[11]!=8 && arr[11]!=9 ) {
        return false;
    }    
    
    var multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];
    var sum = 0;
    for(var i=0, sum=0; i<12; i++) { 
        sum += (arr[i] *= multipliers[i]); 
    }
    
    sum = 11 - (sum%11);
    if(sum >= 10) { sum -= 10; }
    sum += 2;
    if(sum >= 10) { sum -= 10; }
    if(sum != arr[12]) {
        return false;
    } else {
        return true;
    }
}

/***********************************************************************************
 * 외국인 등록번호 유효성 체크(NEW) 13.05.29 START
***********************************************************************************/
function ResnoForeignerNoChk(str) {

    //자리수 체크
    if (str == null || str == "" || str.length != 13 )
    {
        return false;
    }
    //숫자 유효성 체크
    if((str) == '0')
    {
        return false;
    }

    //1,2,3,4로 뒷자리가 시작하는지 체크 및 1900년대 출생과 2000년대 출생 체크
    var birth_day = "";

    if (str.substring(6,7) == '1' || str.substring(6,7) == '2' )
    {
        birth_day = "19"+str.substring(0,6);
    }
    else if ( str.substring(6,7) == '3' || str.substring(6,7) == '4' )
    {
        birth_day = "20"+str.substring(0,6);
    // 외국인등록번호의 경우처리
    }

    // 생년월일 날짜 유효성 체크
    /*
    var yyyy = birth_day.substring(0,4);
    var mm   = birth_day.substring(4,6);
    var dd   = birth_day.substring(6,8);

    if ( isValidDate( yyyy,mm,dd ) == 'N' )
    {
        return false;
    }
    */
    
    if ( str.substring(6,7) == '5' || str.substring(6,7) == '6' ||
              str.substring(6,7) == '7' || str.substring(6,7) == '8' ||
              str.substring(6,7) == '9' || str.substring(6,7) == '0' )
    {
        if(!ForeignerNoChk(str))
        {
            return false;
        }
    }
    else
    {
        if( ResnoChk1(str) == '-1')
        {
            return false;
        }
    }

    return true;

}

/* 외국인 체크 */
function ForeignerNoChk(str) {
    //자리수 체크
    if (str == null || str  == "" || str.length != 13 )
    {
        return false;
    }
    //숫자 유효성 체크
    if(numberTypeChk(str) == '0')
    {
        return false;
    }

    var birth_day = "";
    if (        str.substring(6,7) == "9" || str.substring(6,7) == "0" ) {
        birth_day = "18"+str.substring(0,6);
    } else if ( str.substring(6,7) == "5" || str.substring(6,7) == "6" ) {
        birth_day = "19"+str.substring(0,6);
    } else if ( str.substring(6,7) == "7" || str.substring(6,7) == "8" ) {
        birth_day = "20"+str.substring(0,6);
    } else {
        return false;
    }
    // 생년월일 날짜 유효성 체크
    /*var yyyy = birth_day.substring(0,4);
    var mm   = birth_day.substring(4,6);
    var dd   = birth_day.substring(6,8);

    if ( isValidDate( yyyy,mm,dd ) == 'N' )
    {
        return false;
    }*/

    //주민등록번호 유효성 체크

    var sResnoVal = str;
    var sum = 0;
    var odd = 0;
    var i = 0;
    var j = 0;

    buf = new Array();

    for ( i = 0; i < 13; i++)
    {
        buf[i] = parseInt( sResnoVal.substring( i,i+1) );
    }

    odd = buf[7]*10 + buf[8];

    if (odd%2 != 0)
    {
      return false;
    }

    if ((buf[11] != 6)&&(buf[11] != 7)&&(buf[11] != 8)&&(buf[11] != 9))
    {
      return false;
    }

    multipliers = new Array(2,3,4,5,6,7,8,9,2,3,4,5);

    for ( j = 0; j < 12; j++)
    {
        sum += (buf[j] *= multipliers[j]);
    }

    sum = 11 - ( sum % 11 );

    if ( sum >= 10 )
    {
        sum -= 10;
    }

    sum += 2;

    if ( sum >= 10 )
    {
        sum -= 10;
    }

    if ( sum != buf[12] )
    {
        return false;
    }
    else
    {
        return true;
    }
}

/* 내국인 체크 */
function ResnoChk1(sResnoVal) {
    var jumintot =0;
    var juminadd ='234567892345';
    for (var i = 0;i < 12 ; i++)
    {
        jumintot = eval(jumintot+parseInt(sResnoVal.substring(i,i+1)*parseInt(juminadd.substring(i,i+1))));
    }

    jumintot = 11 - eval((jumintot%11));

    if (jumintot == 10)
    {
        jumintot =0;
    }
    else if (jumintot == 11)
    {
        jumintot =1;
    }

    var resno2 = sResnoVal.substring(6,7);
    if( resno2 == 0 || resno2 > 4)
    {
        return '-1';
    }

    if (parseInt(sResnoVal.substring(12,13)) !=jumintot)
    {
        return '-1';
    }
    else
    {
        return '0';
    }
}

function numberTypeChk(src) {
    var number_chk = 1;
    var number_char = "0123456789";

    for (var i = 0 ; i < src.length ; i++)
    {
        if(number_char.indexOf(src.charAt(i)) == -1)
        {
            number_chk = 0;
        }
    }

    return number_chk;
}
/***********************************************************************************
 * 외국인 등록번호 유효성 체크(NEW) 13.05.29 END
***********************************************************************************/

function countNumericCharacter(str) {
    var cnt = 0;
    for(var i=0; i<str.length; i++) {
        if(str.charCodeAt(i) >= 48 && str.charCodeAt(i) <= 57) {
            cnt++;
        }
    }
    return cnt;
}

function isValidDateString(dt) {
    if(dt == ""){
        return false;
    }

    var date = dt.replace(/-/gi, "");
    if(date.length != 8) {
        return false;
    }

    var inputYear = parseInt(date.substr(0,4), 10);
    var inputMonth = parseInt(date.substr(4,2), 10);
    var inputDate = parseInt(date.substr(6,2), 10);

    if(isNaN(inputYear) || isNaN(inputYear) || isNaN(inputDate)) {
        return false;
    }

    if(inputMonth > 12 || inputMonth < 1){
        return false;
    }
    
    if(inputDate < 1 || inputDate > lastday(inputYear, inputMonth)) {
        return false;
    }    

    return true;
}

//카드번호 4자리씩 split
function cardno_split(cardno){
    return cardno.substr(0,4) + '-' + cardno.substr(4,4) + '-' + cardno.substr(8,4) + '-' + cardno.substr(12,4);
}

//byte계산
function lenByte(code){
 //바이트수에 따른 입력  
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
//AKmembers 전문 Header 생성
function AKmem_Header(pID,pType){
    var ls_send_programID       =  pID ;    //멤버스 회원인증 
    var ls_store    =   model.getValue("/root/req/store");
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
//AKmembers 전문 생성
function AKmem_Run(pID,pType){
    var ls_store    =   model.getValue("/root/req/store");
    var akmem_card_fg    =   model.getValue("/root/data/akmem_card_data/akmem_card_fg");// WCC 구분 위해 카드등록구분 추가 
    var send_data   =   '';             
    //switch (pID) { 여전법 이후 switch에서 if else 로 변경 
        // case 'XA241S' :
       if(pID == 'XA241S' || pID == 'XB241S' ){ 
            //----------------------------------------------//
            //    회원 인증 조회 로직                               //
            //----------------------------------------------//
            var ls_akmem_card_no        =   model.getValue("/root/data/akmem_card_data/akmem_cardno");  
            
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
            var POS_NO      =   model.getValue("/root/req/pos_no");     //pos번호
            var MBR_INFO_RQ =   "1";    //  회원정보 요청 1: 요청 , 0:요청하지 않음(응답전문에 회원전보 포함여부)
            var ksn_encData = model.getValue("/root/data/akmem_danmal_data/ksn1")+model.getValue("/root/data/akmem_danmal_data/encData1"); //KSN(20)+Base64(EncData)(64) 유통키 암호화  18.02.12 최보성
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
                                
                var ls_akmem_card_no =   model.getValue("/root/data/akmem_card_data/akmem_cardno");  
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
/*
/  대기자 정보 팝업
*/        
function openWaitListSearchPopup()
{   
    model.removeNodeset("/root/param1");
    
    model.makeNode("/root/param1/popupyn");
    model.makeNode("/root/param1/status");     
    model.makeNode("/root/param1/cust_no");
    model.makeNode("/root/param1/period");
    model.makeNode("/root/param1/store");   
    model.makeNode("/root/param1/subject_cd");   
    
    model.setValue("/root/param1/popupyn", "Y"); //요청 상태
    model.setValue("/root/param1/status", "request"); //요청 상태
    
    window.load("/ui/ba/BASale1501.xrw",
                "modal",
                "BASale1501",
                "width:1000px; height:620px; min:hidden; max:hidden; resize:false; align:center; caption:hidden",
                "/root/param1",
                "/root/param1");                               

    var node = instance1.selectSingleNode("/root/param1");
    
    if(model.getValue("/root/param1/status") == "request")
    {
        return null;
    }else{
        var ret = new Object();
        bindInstanceToObject("/root/param1", ret);  
        return ret;
   }
}

/**
 * 지정된 포멧에 맞는 현재의 날짜를 반환합니다.
 * 
 * @param format
 * @returns {String}
 */
function getCurrentDate(format, strDate)
{
	var date = new Date();
	
	var y;
	var m;
	var d;
	
	if(strDate == null)
	{
		y = date.getYear();
		m = date.getMonth() + 1;
		d = date.getDate();
		
		// 사파리 이놈..
		if(y < 2000)
			y = y + 1900;
	}
	else
	{
		y = parseInt(strDate.substring(0, 4), 10);
		m = parseInt(strDate.substring(4, 6), 10);
		d = parseInt(strDate.substring(6, 8), 10);
	}
	
	var ret = "";
	
	if(format == "yyyymmdd" || format == null)
	{
		ret += y;
		ret += (m < 10) ? "0" + m : m;
		ret += (d < 10) ? "0" + d : d;
	}
	else
	{
		if(format == "yyyy-mm-dd")
		{
			ret += y;
			ret += "-";
			ret += (m < 10) ? "0" + m : m;
			ret += "-";
			ret += (d < 10) ? "0" + d : d;
		}
		else
		{
			if(format == "yyyy/mm/dd")
			{
				ret += y;
				ret += "/";
				ret += (m < 10) ? "0" + m : m;
				ret += "/";
				ret += (d < 10) ? "0" + d : d;
			}
			else
			{
				if(format == "yyyymm")
				{
					ret += y;
					ret += (m < 10) ? "0" + m : m;
				}
				else
				{
					// 에러 처리
					ret = "";
				}
			}
		}
	}
	return ret;
}


function returnGridValue2OpnerBa(gridObj, row) {
    var node = opener.model.instance1.selectSingleNode("/root/param1");
    var childList = node.childNodes;
    while(child = childList.nextNode()) {
        //child.nodeValue = gridObj.valueMatrix(row, gridObj.colRef(child.nodeName));
        child.nodeValue = model.getValue(gridObj.nodeset+"["+row+"]/"+child.nodeName);      
    }
}

/********************************************************
 *   신용IC 단말기 관련 function
 *   object 선언 : cardX 명칭으로 선언(대소문자구분)
*********************************************************/

// OCX 설치확인 (18.01.22_최보성)
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

//단말기 open (18.01.22_최보성)
function setCardReaderOpen(){
    
    var sPos = getPos();        // POS정보 가져오기
    var sPort = getPort();      // PORT정보 가져오기
    var ref;
    
    ref = cardX.Open(sPort,115200,'');
    
    if (ref < 0) {
        alert("연결된 IC단말기 Port번호를 확인하여 주십시오.");
        return false;
    }
    
    ref = cardX.ReqCmd( 0xFB, 0x11, 0x02, "", "");
    ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 1000, 0, "처리중입니다.","");
    
    if(ref >= 0) {
        return true;
    }
}
     
//카드 단말기 포트를 Close한다 (18.01.22_최보성) 
function readerClose() {
    var ref;
    ref = cardX.ReqReset(); 
    ref = cardX.Close();
} 

//node parse 함수 (2018.01.22 최보성)
function makeNodelValue(gubun, cardObj , oriData){
    var  endNum, startNum=0;
    for(var i =0; i < cardObj.length; i++) {
        if(i == 0) {
            endNum = cardObj[i].size;
        } else {
            startNum = endNum;
            endNum = cardObj[i].size+endNum;
        }
        
        if( cardObj[i].type == "h") {
             model.makeValue("/root/"+gubun+"/"+cardObj[i].ref, oriData.charCodeAt(startNum));
        } else {
             model.makeValue("/root/"+gubun+"/"+cardObj[i].ref, oriData.substring(startNum,endNum));
        }
    } 
    
    var chlength = oriData.length;
    var ranvl =  Math.floor(Math.random() * 100);
    
    //oriData = recardMemReset(chlength , ranvl );
}
function makeNodePathValue(gubun, cardObj){
    var oriPathData = model.getValue("/root/data/danmal_data/rfFlag");
    var  endNum, startNum=0;
    for(var i =0; i < cardObj.length; i++) {
        if(i == 0) {
            endNum = cardObj[i].size;
        } else {
            startNum = endNum;
            endNum = cardObj[i].size+endNum;
        }
        
        if( cardObj[i].type == "h") {
             model.makeValue("/root/"+gubun+"/"+cardObj[i].ref, oriPathData.charCodeAt(startNum));
        } else {
             model.makeValue("/root/"+gubun+"/"+cardObj[i].ref, oriPathData.substring(startNum,endNum));
        }
    } 

}

function cardDanMemReset(){
    cardX.RcvData = 1 ;
    cardX.RcvData = 0 ;
   
    cardX.Emv = 1 ;
    cardX.Emv = 0 ;
    
    cardX.ResetMem(); 
    cardX.ReqReset();
}

function recardMemReset(chlen , chDt ){

    for(var ch1 =0; ch1 < chlen; ch1++) {
     if(ch1===0) chgch= String.fromCharCode(chDt);
    
       chgch += String.fromCharCode(chDt);
    }
    return chgch;
}
function cardMemReset(oriData){
    cardX.ResetMem(); 
    
    var chgch;
    var ranvl =  Math.floor(Math.random() * 100);
    for(var ch1 =0; ch1 < oriData.length; ch1++) {
     if(ch1===0) chgch= String.fromCharCode(ranvl);
    
       chgch += String.fromCharCode(ranvl);
    }
    oriData = chgch;
    chgch = null;

    for(var ch2 =0; ch2 < oriData.length; ch2++) {
      if(ch2===0) ch2= String.fromCharCode(ranvl);
       chgch += String.fromCharCode(0xFF);      
    }
    oriData = chgch;
    chgch = null;

    for(var ch3 =0; ch3 < oriData.length; ch3++) {
      if(ch3===0) ch3= String.fromCharCode(ranvl);
      
       chgch += String.fromCharCode(0x00);            
    }
    oriData = chgch;
   
} 

//sign패드 호출 (2018.01.22)
function createSignChkDialog(cardAmt){//test증
    var sE;
    var sD = model.getValue("/root/req/pos_no");
    var ref;
    ref = cardX.ReqSignA (2,sD,cardAmt,"","",sE);
    //alert("Sign중입니다. Sign이 완료되면 확인버튼을 눌러주세요");
    return cardX.Sign; 
}

// POS 번호 가져오기(공통마스터관리 > IP관리 > "POS번호" 값)
function getPos() {
    var sPos = model.getValue("/root/res/pos/pos_no");
    if ( sPos == "" ) { alert("POS 등록이 되지 않았습니다.\n[IP관리] 메뉴에서 확인하여 주십시오."); return 0; }
    return sPos;
}

//PORT 번호 가져오기(공통마스터관리 > IP관리 >  "전자서명 포트번호" 값)
function getPort() {
    var sPort = model.getValue("/root/res/pos/autosign_port");
    if ( sPort == "" ) { alert("PORT 등록이 되지 않았습니다.\n[IP관리] 메뉴에서 확인하여 주십시오."); return 0; }
    return sPort;
}

// 무결성 검증 체크(정상 : G0 , 침해 : B1, B2, B3, B4) 
function CardReaderIntegrity() {
    var ref;
    var chkDate = new Date();
    cardX.SendHandle();
    ref = cardX.ReqCmd( 0xFB, 0x11, 0x30, "", "");
    ref = cardX.WaitCmd( 0xFB, cardX.RcvData, 10000, 1, "무결성 침해 검증 진행중 입니다.", "");
    
//    if(ref >= 0) {
//        sRet = cardX.RcvData;
//    } else {
//        sRet = "ERROR";
//    }
    
    sRet = cardX.RcvData;

    var resVl =  sRet.substring(0,2);
    
    var encCnt = model.getValue("/root/reader_data/vanCnt");// 단말기 암호화키 갯수

    // if(encCnt != "3"){
     if(encCnt != "5"){ // 직승인 추가 - bc, 신한 -- cmc
      alert("단말기 키다운로드가 정상적으로 되지 않았습니다.\n 전산실에 연락바랍니다.");
      resVl = "ERROR";
     } 

    if(resVl ==  null || resVl.trim() == "" || resVl == undefined  ){
      resVl = "ERROR";
    }
   
    model.makeValue("/root/reader_data/integrity", resVl);
    model.makeValue("/root/reader_data/integrity_time", chkDate.format("yyyymmddhhmiss"));
    
    cardX.Clear();
    cardX.Close();
}

//무결성 검증 결과값 DATABASE LOG생성
function Insert_Integrity() {
    var act = new Transaction(submission);
    act.setAction("/action/ba/BASale2301_T01");
    act.setRef("/root/req, /root/reader_data, /root/res/pos");
    if(act.submit(true)) {
        try {
            model.refresh();
        }catch(err) {}
    }
}

//단말기 데이터 호출함수
function danMaldataParse(rcvData) {
  /*  var cardObj=[{ref: "modelCd",   size: 4}                //모델코드          AN(4)   모델코드 예) ED-946N : 301M
                ,{ref: "ver",       size: 4}                //버전                AN(4)   프로그램 버전 (0001~9999)
                ,{ref: "serialNo",  size: 12}               //시리얼번호        AN(12)   생산시 셋팅된 serial no 예) 3+261+31+000001~999999
                ,{ref: "protoVer",  size:2}                 //프로토콜버젼      AN(2) 32 : 대칭형 키수신 버전 (RSA 2048 + DUKPT)
                ,{ref: "useMsrTr",  size:1}                 //사용 MSR Track    AN(1) 1:1Track 2:2Track 3:3Track
                ,{ref: "maxVan",    size:1, type: "h"}      //Max Van           HEX(1)  최대 VAN 동시 수용 개수(10 개 : 0x0A )
                ,{ref: "vanCnt",    size:1, type: "h"}      //VAN 개수            HEX(1)  아래 부분 반복갯수(키수신 개수)
                ,{ref: "vanCode",   size:4}                 //VAN CODE          AN(4)   KICC:”1400” 
                ,{ref: "vanNm",     size:10}                //VAN NAME          AN(10)  VAN 사명
                ,{ref: "reciKeyVer",size:4}                 //키수신 공개키버젼 AN(4)   키수신 공개키 버전
                ,{ref: "encMeth",   size:2}                 //암호화 방식        AN(2)   22: 대칭형 암호화 (DUKPT)
                ,{ref: "secuVer",   size:16}                //보안인증번호        AN(16)  KTC 인증번호 16 자리
                ,{ref: "reciKeyVer1",size:2}                //키수신 공개키버젼 AN(4)   키수신 공개키 버전
                ,{ref: "encMeth1",  size:2}                 //암호화 방식        AN(2)   22: 대칭형 암호화 (DUKPT)
                ,{ref: "secuVer1",  size:16}                //보안인증번호        AN(16)  KTC 인증번호 16 자리
                ];*/
                
                
    var cardObj=[{ref: "modelCd",   size: 4}                //모델코드          AN(4)   모델코드 예) ED-946N : 301M
                ,{ref: "ver",       size: 4}                //버전                AN(4)   프로그램 버전 (0001~9999)
                ,{ref: "serialNo",  size: 12}               //시리얼번호        AN(12)   생산시 셋팅된 serial no 예) 3+261+31+000001~999999
                ,{ref: "protoVer",  size:2}                 //프로토콜버젼      AN(2) 32 : 대칭형 키수신 버전 (RSA 2048 + DUKPT)
                ,{ref: "useMsrTr",  size:1}                 //사용 MSR Track    AN(1) 1:1Track 2:2Track 3:3Track
                ,{ref: "maxVan",    size:1, type: "h"}      //Max Van           HEX(1)  최대 VAN 동시 수용 개수(10 개 : 0x0A )
                ,{ref: "vanCnt",    size:1, type: "h"}      //VAN 개수            HEX(1)  아래 부분 반복갯수(키수신 개수)
                ,{ref: "vanCode",   size:4}                 //VAN CODE          AN(4)   KICC:”1400” 
                ,{ref: "vanNm",     size:10}                //VAN NAME          AN(10)  VAN 사명
                ,{ref: "reciKeyVer",size:4}                 //키수신 공개키버젼 AN(4)   키수신 공개키 버전
                ,{ref: "encMeth",   size:2}                 //암호화 방식        AN(2)   22: 대칭형 암호화 (DUKPT)
                ,{ref: "vanCode1",   size:4}                 //VAN CODE          AN(4)   KICC:”1400” 
                ,{ref: "vanNm1",     size:10}                //VAN NAME          AN(10)  VAN 사명
                ,{ref: "reciKeyVer1",size:4}                 //키수신 공개키버젼 AN(4)   키수신 공개키 버전
                ,{ref: "encMeth1",   size:2}                 //암호화 방식        AN(2)   22: 대칭형 암호화 (DUKPT)          
                ,{ref: "vanCode2",   size:4}                 //VAN CODE          AN(4)   KICC:”1400” 
                ,{ref: "vanNm2",     size:10}                //VAN NAME          AN(10)  VAN 사명
                ,{ref: "reciKeyVer2",size:4}                 //키수신 공개키버젼 AN(4)   키수신 공개키 버전
                ,{ref: "encMeth2",   size:2}                 //암호화 방식        AN(2)   22: 대칭형 암호화 (DUKPT)          
                ,{ref: "vanCode3",   size:4}                 //VAN CODE          AN(4)   KICC:”1400” 
                ,{ref: "vanNm3",     size:10}                //VAN NAME          AN(10)  VAN 사명
                ,{ref: "reciKeyVer3",size:4}                 //키수신 공개키버젼 AN(4)   키수신 공개키 버전
                ,{ref: "encMeth3",   size:2}                 //암호화 방식        AN(2)   22: 대칭형 암호화 (DUKPT)
                ,{ref: "vanCode4",   size:4}                 //VAN CODE          AN(4)   KICC:”1400” 
                ,{ref: "vanNm4",     size:10}                //VAN NAME          AN(10)  VAN 사명
                ,{ref: "reciKeyVer4",size:4}                 //키수신 공개키버젼 AN(4)   키수신 공개키 버전
                ,{ref: "encMeth4",   size:2}                 //암호화 방식        AN(2)   22: 대칭형 암호화 (DUKPT)
                ,{ref: "secuVer1",   size:16}                //보안인증번호        AN(16)  KTC 인증번호 16 자리
                ];
    makeNodelValue("reader_data",cardObj, rcvData );        // node danmal parse
	//model.makeValue("/root/reader_data/secuVer", "AKWEBPOS1001" );        // node danmal parse
    model.makeValue("/root/reader_data/secuVer", "AKWEBPOS2001" );        // cmc - 식별번호update
}

//오른쪽 문자 자르기 - Right(변수,자를문자길이)
function Right(str, intC) {
    return str.slice( -(intC) );
}

//왼쪽 문자 자르기 - Right(변수,자를문자길이)
function Left(str, intC) {
    return str.slice(0, intC);
}
/**
 * 화면이동 : signpad서명창
 */
function signPopUp(cardAmt) {
 readerClose();
 model.makeValue("/root/data/sing_data/card_amt",cardAmt);
 window.load("BAsignPop_new.xrw",
    "modal",
    "signPop",
    "width:400px; height:270px; min:hidden; max:hidden; resize:false; align:center; caption:hidden");
}//signPopUp()

//카드리더기 ocx object 추가
function writeReaderobj(arg1){
 var wrtAtt = "id:cardX;"
     wrtAtt += "clsid:{93137A73-7A61-4911-8018-C758BBE73F53};"
     if(arguments.length === 0){
       wrtAtt += "left:50px;top:0px;width:0px;height:0px;"
     }else{
       wrtAtt += arg1;
     }
     wrtAtt += "CODEBASE='http://Company..co.kr/vankicc/KiccPosIEX_1.0.4.8.cab#version=1.0.4.8' VIEWASTEXT;"
 body.createChild("xforms:object", wrtAtt);
}

function nvl(str, defaultStr) {
    if(typeof str == "undefined" || str == null || str == "") {
        str = defaultStr;
    }
    return str;
}

/*
//cminc1115 - 자바스크립트 base64 encoding - 여전법
var Base64 = {
    _keyStr: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",
    encode: function(e) {
        var t = "";
        var n, r, i, s, o, u, a;
        var f = 0;
        e = Base64._utf8_encode(e);
        while (f < e.length) {
            n = e.charCodeAt(f++);
            r = e.charCodeAt(f++);
            i = e.charCodeAt(f++);
            s = n >> 2;
            o = (n & 3) << 4 | r >> 4;
            u = (r & 15) << 2 | i >> 6;
            a = i & 63;
            if (isNaN(r)) {
                u = a = 64
            } else if (isNaN(i)) {
                a = 64
            }
            t = t + this._keyStr.charAt(s) + this._keyStr.charAt(o) + this._keyStr.charAt(u) + this._keyStr.charAt(a)
        }
        return t
    },
    decode: function(e) {
        var t = "";
        var n, r, i;
        var s, o, u, a;
        var f = 0;
        e = e.replace(/[^A-Za-z0-9\+\/\=]/g, "");
        while (f < e.length) {
            s = this._keyStr.indexOf(e.charAt(f++));
            o = this._keyStr.indexOf(e.charAt(f++));
            u = this._keyStr.indexOf(e.charAt(f++));
            a = this._keyStr.indexOf(e.charAt(f++));
            n = s << 2 | o >> 4;
            r = (o & 15) << 4 | u >> 2;
            i = (u & 3) << 6 | a;
            t = t + String.fromCharCode(n);
            if (u != 64) {
                t = t + String.fromCharCode(r)
            }
            if (a != 64) {
                t = t + String.fromCharCode(i)
            }
        }
        t = Base64._utf8_decode(t);
        return t
    },
    _utf8_encode: function(e) {
        e = e.replace(/\r\n/g, "\n");
        var t = "";
        for (var n = 0; n < e.length; n++) {
            var r = e.charCodeAt(n);
            if (r < 128) {
                t += String.fromCharCode(r)
            } else if (r > 127 && r < 2048) {
                t += String.fromCharCode(r >> 6 | 192);
                t += String.fromCharCode(r & 63 | 128)
            } else {
                t += String.fromCharCode(r >> 12 | 224);
                t += String.fromCharCode(r >> 6 & 63 | 128);
                t += String.fromCharCode(r & 63 | 128)
            }
        }
        return t
    },
    _utf8_decode: function(e) {
        var t = "";
        var n = 0;
        var r = c1 = c2 = 0;
        while (n < e.length) {
            r = e.charCodeAt(n);
            if (r < 128) {
                t += String.fromCharCode(r);
                n++
            } else if (r > 191 && r < 224) {
                c2 = e.charCodeAt(n + 1);
                t += String.fromCharCode((r & 31) << 6 | c2 & 63);
                n += 2
            } else {
                c2 = e.charCodeAt(n + 1);
                c3 = e.charCodeAt(n + 2);
                t += String.fromCharCode((r & 15) << 12 | (c2 & 63) << 6 | c3 & 63);
                n += 3
            }
        }
        return t
    }
}
*/