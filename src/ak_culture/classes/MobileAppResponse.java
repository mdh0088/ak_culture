package ak_culture.classes;

public class MobileAppResponse {
    
    public static final String res_00 = "정상처리 되었습니다.";

    public static final String res_11 = "전문전송일이 틀립니다.";

    public static final String res_12 = "거래금액오류";
    
    public static final String res_13 = "미발행 바코드";
    
    public static final String res_14 = "상품권 유효기간 만료";
    
    public static final String res_15 = "사용 가능한 상품권이 아님";

    public static final String res_20 = "미등록 가맹점";

    public static final String res_21 = "가맹점 사용가능 상품권 종류가 없습니다.";

    public static final String res_22 = "결제요청번호 중복입니다.";

    public static final String res_23 = "승인내역이 존재하지 않습니다.";

    public static final String res_24 = "승인내역이 중복하여 존재합니다.";

    public static final String res_25 = "승인내역이 존재하지 않습니다.(상품권별)";

    public static final String res_26 = "상품권 발행원장이 존재하지 않습니다.";  

    public static final String res_27 = "승인취소잔액 불일치";

    public static final String res_28 = "이미 취소된 거래";

    public static final String res_31 = "잔액이 부족합니다.";

    public static final String res_41 = "시스템에러입니다. 전화요망";

    public static final String res_61 = "회원 아이디가 존재하지 않습니다.";

    public static final String res_62 = "인증번호가 존재하지 않습니다.";

    public static final String res_63 = "인증번호가 일치하지 않습니다.";

    public static final String res_64 = "인증번호 유효시간 초과";

    public static final String res_65 = "유효기간 인증 1회 오류";
    
    public static final String res_66 = "유효기간 인증 2회 오류";
    
    public static final String res_67 = "유효기간 인증 3회 오류(인증 횟수 초과)";
    
    public static final String res_68 = "유효기간 인증 오류 상품권 잠김";

    public static final String res_77 = "결제금액오류";
    
    public static String getResponseStr(String code) {
        
        String response = null;
        
        if ("00".equals(code)) {
            response = res_00;
    
        } else if ("11".equals(code)) {
            response = res_11;
    
        } else if ("12".equals(code)) {
            response = res_12;
    
        } else if ("13".equals(code)) {
            response = res_13;
    
        } else if ("14".equals(code)) {
            response = res_14;
    
        } else if ("15".equals(code)) {
            response = res_15;
    
        } else if ("20".equals(code)) {
            response = res_20;
    
        } else if ("21".equals(code)) {
            response = res_21;
    
        } else if ("22".equals(code)) {
            response = res_22;
    
        } else if ("23".equals(code)) {
            response = res_23;
    
        } else if ("24".equals(code)) {
            response = res_24;
    
        } else if ("25".equals(code)) {
            response = res_25;
    
        } else if ("26".equals(code)) {
            response = res_26;
    
        } else if ("27".equals(code)) {
            response = res_27;
    
        } else if ("28".equals(code)) {
            response = res_28;
    
        } else if ("31".equals(code)) {
            response = res_31;
    
        } else if ("41".equals(code)) {
            response = res_41;
    
        } else if ("61".equals(code)) {
            response = res_61;
    
        } else if ("62".equals(code)) {
            response = res_62;
    
        } else if ("63".equals(code)) {
            response = res_63;
    
        } else if ("64".equals(code)) {
            response = res_64;
    
        } else if ("65".equals(code)) {
            response = res_65;
    
        } else if ("66".equals(code)) {
            response = res_66;
    
        } else if ("67".equals(code)) {
            response = res_67;
    
        } else if ("68".equals(code)) {
            response = res_68;
    
        } else if ("77".equals(code)) {
            response = res_77;
    
        }
        
        return response;
    }
}

