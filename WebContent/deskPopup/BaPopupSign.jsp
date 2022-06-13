<%--
 * System       : 문화1
 * Program ID   : BaPopupSign.jsp 
 * Program Name : 수강신청
 * Descripmtion  : 고객정보입력 
 * Creation     : 2019.
--%>
<%@ page import="java.util.*" %>

<%@ page import="ak_culture.classes.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page 	import="java.io.*,java.util.*,java.lang.String"%>

<%

String cust_no    = Utils.isNull(request.getParameter("custNo"))    ? ""        : request.getParameter("custNo");
String store    = Utils.isNull(request.getParameter("store"))    ? ""        : request.getParameter("store");
String period    = Utils.isNull(request.getParameter("period"))    ? ""        : request.getParameter("period");
String pos_no    = Utils.isNull(request.getParameter("posNo"))    ? ""        : request.getParameter("posNo");
String resi_no    = Utils.isNull(request.getParameter("resiNo"))    ? ""        : request.getParameter("resiNo");
String sale_ymd    = Utils.isNull(request.getParameter("saleYmd"))    ? "00000000"        : request.getParameter("saleYmd");

if(!sale_ymd.equals("00000000")){
    sale_ymd = sale_ymd.substring(0,4)+". "+sale_ymd.substring(4,6)+". "+sale_ymd.substring(6);    
}

//시간없이 개발하니 보안,효율성,적합성등 추후 수정 필요!!마지막까지 추가 개발요구사항...
%>


<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<title>Welcome to CULTURE ACADEMY | AK 문화아카데미</title>
	<meta name="format-detection" content="telephone=no,address=no,email=no">
	<meta name="keywords" content="AK Plaza Culture Academy">
    <meta name="description" content="AK Plaza 문화아카데미에서 다양한 강좌를 만나보세요.">
    <link rel="shortcut icon" href="../img/deskPopup/akicon.ico">
    <link rel="stylesheet" href="../inc/css/deskPopup/common.css">
    <link rel="stylesheet" href="../inc/css/deskPopup/academy.css">
    <script src="../inc/js/deskPopup/ba_common.js"></script>
    
</head>

<body  onload="javascript:window.moveTo('-767','-1026');" style="overflow-y: hidden">
    <!--[if lt IE 9]>
      <p id="browser-upgrade" style="padding:4px 1em;font-size:12px;color:#000;background:#ffc;border-bottom:2px outset #fff;margin:0;text-align:left">사용하는 브라우저에서 사이트가 정상적으로 표시되지 않습니다. 최신 브라우저로 <a href="http://outdatedbrowser.com/ko" style="color:#00f;text-decoration:underline;">업데이트</a> 하세요. Your browser is out of date! Update your browser to view this website correctly. <a href="http://outdatedbrowser.com/ko" style="padding:0 4px;color:#00f;font-weight:bold;text-decoration:underline;">Update now</a></p>
    <![endif]-->

    <div class="loader">
        <div class="loader-body">
            <div class="loader-spinner">
                <div></div><div></div>
                <div></div><div></div>
                <div></div><div></div>
                <div></div><div></div>
                <div></div><div></div>
                <div></div><div></div>
            </div>
            <div class="loader-text">
                <!-- 20190521 수정 -->
                <strong>고객님, 정보를 입력하는 중입니다.</strong>
                <span>잠시만 기다려 주세요.</span>
            </div>
        </div>
    </div>

    <div class="wrap">
        <header class="header">
            <div class="header-title-wrap">
                <!-- 20190603 수정: 내용수정 -->
                <h1 class="header-title">Welcome To <strong>CULTURE ACADEMY</strong></h1>
                <p class="header-title-sub">AK 문화아카데미에서 다양한 강좌를 만나보세요!</p>
            </div>
        </header>
    
        <div class="content ak-academy-03">

                <form name="form2" method="post" action="BaPopupSignS1.jsp">
                
                    <div style="position:absolute;top:150px;bottom:420px;left:0;right:0;width:700px;margin:0 auto;padding:0 40px;overflow:hidden;overflow-y:auto;">
                        <h2 class="page-title">AK문화아카데미 개인정보 수집/이용 동의</h2>

                        <!-- 20190603 수정 : 클래스명 수정 -->
                        <div class="agreement-container js-accordion expanded">
                            <div class="agreement-header">
                                <h3 class="agreement-title">AK문화아카데미 이용 동의<em>(필수)</em></h3>
                                <div class="input-radio-wrap">
                                    <label>
                                        <input type="radio" name="policy" id="policy" value="1" class="input-radio">
                                        <span class="input-radio-label">
                                            <span class="icon"></span>
                                            <span class="text">동의</span>
                                        </span>
                                    </label>
                                    <label>
                                        <input type="radio" name="policy" id="policy" value="0" class="input-radio">
                                        <span class="input-radio-label">
                                            <span class="icon"></span>
                                            <span class="text">미 동의</span>
                                        </span>
                                    </label>
                                </div>
                               <button type="button" class="btn btn-white btn-toggle">자세히보기</button>
                            </div>
                            <div class="agreement-body js-accordion-body">
                                <div class="agreement-content">
                                            <!-- 내용 -->
                                            <!-- 20190603 수정 : 내용수정 -->      
                                            <p>AK멤버스 가입 회원에 한해 수강신청이 가능하며, 본 신청서를 통해 수집된 회원의 개인정보는 [AK멤버스 개인정보취급방침]에 따라 보호 및 관리됩니다.</p><p>본인은 AK멤버스 회원 가입시 [AK멤버스 회원약관]을 확인하였으며, 이에 동의합니다.</p>                          
                                        </div>
                                    </div>
                                </div>
                        <!-- 20190603 수정 : 클래스명 수정 -->
                        <div class="agreement-container js-accordion expanded">
                            <div class="agreement-header">
                                <h3 class="agreement-title">개인정보 수집이용 동의<em>(필수)</em></h3>
                                <div class="input-radio-wrap">
                                    <label>
                                        <input type="radio" name="privacy" id="privacy" value="1" class="input-radio">
                                        <span class="input-radio-label">
                                            <span class="icon"></span>
                                            <span class="text">동의</span>
                                        </span>
                                    </label>
                                    <label>
                                        <input type="radio" name="privacy" id="privacy" value="0" class="input-radio">
                                        <span class="input-radio-label">
                                            <span class="icon"></span>
                                            <span class="text">미 동의</span>
                                        </span>
                                    </label>
                                </div>
                            	<button type="button" class="btn btn-white btn-toggle">자세히보기</button>
                            </div>
                            <div class="agreement-body js-accordion-body">
                                <div class="agreement-content">
                                            <!-- 내용 -->
                                            <p>본인은 AK PLAZA 문화아카데미가 정보를 요청하는 것에 대해 충분히 이해하며, 개인정보를 AK PLAZA 문화아카데미가 수집 및 이용 하는 데에 동의합니다.</p>
                                            <p>※ 만 14세 미만의 가족(자녀) 회원의 수강 신청일 경우 부모의 동의 및 서명으로 가입 처리 됩니다.</p>
                                            <p>※ 수강 신청시 수집한 개인정보는 수강 신청 및 강의 제공을 위한 용도로만 이용되며, 다른 목적으로 이용되지 않습니다.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
		
						<div style="position:absolute;bottom:0;left:0;right:0;width:700px;margin:0 auto;padding:0 40px 40px;">
	                        <!-- [D] 서명 입력시 signed 클래스 추가 -->
	                        <div class="sign-box">
	                            <!-- 20190603 수정 : 내용수정 -->
	                            <p class="placeholder">이름을 입력해주세요</p>
	                            <div class="sign-area"><canvas id="signature-pad" class="signature-pad" width=690 height=300></canvas></div>
	                            <button type="button" class="btn-sign-reset" id="clear">서명초기화</button>
	                            
	                        </div>
	                        
	                        <p class="sign-date"><%=sale_ymd %></p>
	
	                        <div class="btn-wrap">
	                            <button onclick="javascript:return signResult();" class="btn">확인</button>
	                        </div>
       				   </div>
               
				<input type="hidden" name="store" value=<%=store %>>
				<input type="hidden" name="cust_no" value=<%=cust_no %>>
				<input type="hidden" name="period" value=<%=period %>>
				<input type="hidden" name="pos_no" value=<%=pos_no %>>
				<input type="hidden" name="resi_no" value=<%=resi_no %>>
				<input type="hidden" name="sign">
                </form>


        </div><!-- //content -->

    </div><!-- //wrap -->

    <script src="../inc/js/deskPopup/lib/jquery.min.js"></script>
    <script src="../inc/js/deskPopup/plugins.js"></script>
    <script src="../inc/js/deskPopup/main.js"></script>
    <script src="../inc/js/deskPopup/lib/signature_pad.min.js"></script>
    <script src="../inc/js/deskPopup/ba_sign.js"></script>
    
</body>

</html>
