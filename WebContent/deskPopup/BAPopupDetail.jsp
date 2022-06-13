<%--
 * System       : 문화1
 * Program ID   : BaPopup.jsp 
 * Program Name : 수강신청
 * Descripmtion  : 고객정보입력 
 * Creation     : 2019.
--%>
<%@ page import="java.util.*" %>

<%@ page import="ak_culture.classes.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page 	import="java.io.*,java.util.*,java.lang.String"%>


<%

String kor_nm    = Utils.isNull(request.getParameter("korNm"))    ? ""        : request.getParameter("korNm");
String birth_ymd    = Utils.isNull(request.getParameter("birthYmd"))    ? ""        : request.getParameter("birthYmd");
String hphone    = Utils.isNull(request.getParameter("hp"))    ? "0000"        : request.getParameter("hp");
String store_nm    = Utils.isNull(request.getParameter("storeNm"))    ? ""        : request.getParameter("storeNm");
String sale_ymd    = Utils.isNull(request.getParameter("saleYmd"))    ? "00000000"        : request.getParameter("saleYmd");

String store    = Utils.isNull(request.getParameter("store"))    ? ""        : request.getParameter("store");
String period    = Utils.isNull(request.getParameter("period"))    ? ""        : request.getParameter("period");
String cust_no    = Utils.isNull(request.getParameter("custNo"))    ? ""        : request.getParameter("custNo");
String pos_no    = Utils.isNull(request.getParameter("posNo"))    ? ""        : request.getParameter("posNo");
String sign_no    = Utils.isNull(request.getParameter("signNo"))    ? ""        : request.getParameter("signNo");

String sign_ymd ="";

if(!sale_ymd.equals("00000000")){
    sign_ymd = sale_ymd.substring(0,4)+". "+sale_ymd.substring(4,6)+". "+sale_ymd.substring(6);    
}

if(!hphone.equals("0000")){
    hphone = hphone.substring(0,hphone.length() - 4)+"****";   
}


//시간없이 개발하니 보안,효율성,적합성등 추후 수정 필요!!
 
Vector  vec1  = Bapopupq1.SubjectDetail(store,period,cust_no,sale_ymd,sign_no);
int     count = vec1.size();
String sign ="";
if (count != 0){
	
    BaPopupBn babn0 = (BaPopupBn)vec1.elementAt(0);
    
    sign = babn0.getSign_data();
    
}

%>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
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

<body>
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
                <strong>고객님, 정보를 입력하는 중입니다.</strong>
                <span>잠시만 기다려 주세요.</span>
            </div>
        </div>
    </div>
    
    <div class="wrap">

                <div class="content ak-academy-06">
            <div class="container">

                <input type="radio" name="print" id="document1" value="1" class="input-radio" checked>
                
                <div class="header">
                    <div class="input-radio-wrap">
                        <label for="document1">
                            <span class="input-radio-label">
                                <span class="icon"></span>
                                <span class="text">AK문화아카데미 수강신청서</span>
                            </span>
                        </label>
                    </div>
                    <button type="button" class="btn btn-print" onclick="print();">인쇄</button>
                </div>

                <div id="print-document1" class="printable-container">
                    <h2 class="page-title">AK문화아카데미 수강신청서</h2>
                    <div class="section">
                        <h2 class="section-title">고객 정보</h2>
                        
                        <div class="info-table">
                            <table class="info-table-body">
                                <caption>고객 정보</caption>
                                <tbody>
                                    <tr>
                                        <th>성명</th>
                                        <td><%=kor_nm %></td>
                                    </tr>
                                    <tr>
                                        <th>생년월일</th>
                                        <td><%=birth_ymd %></td>
                                    </tr>
                                    <tr>
                                        <th>연락처</th>
                                        <td><%=hphone %></td>
                                    </tr>
                                    <tr>
                                        <th>지점</th>
                                        <td><%=store_nm %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
    
                    <div class="section">
                        <h2 class="section-title">강좌 정보</h2>
                        <ul class="course-list">
                         <% 
                        	if (count == 0)
							{
						%>
							<li class="course-list-item">
									<img id ="sign_img" name ="sign_img" src="../img/deskPopup/subject_fail.jpg" class="img-block">
                            </li>
						<%
							}else{
								for(int i=0;i<count;i++){
								    BaPopupBn babn = (BaPopupBn)vec1.elementAt(i);
						%>
                            <li class="course-list-item">
                                <div class="course-table">
                                    <table class="course-table-body">
                                        <caption>강좌 정보</caption>
                                        <colgroup>
                                            <col style="width:8%;"><col style="width:17%;"><col style="width:auto;"><col style="width:16%;"><col style="width:22%;">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th rowspan="3" class="no"><%=babn.getSubject_cnt() %></th>
                                                <th>강좌명</th>
                                                <td colspan="3"><%=babn.getSubject_nm()%></td>
                                            </tr>
                                            <tr>
                                                <th>강의시간</th>
                                                <td><%=babn.getDay_flag()%>  (<%=babn.getLect_hour()%>)</td>
                                                <th rowspan="2">수강료<br><%if(!"".equals(babn.getFood_amt())&& babn.getFood_amt() != null){%>/ 재료비<%} %></th>
                                                <td rowspan="2"><%=babn.getRegis_fee()%>원<br><%=babn.getFood_amt()%></td>
                                            </tr>
                                            <tr>
                                                <th>강의기간</th>
                                                <td><%=babn.getStart_ymd()%>~<%=babn.getEnd_ymd()%></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </li>
                            	<%	}//for
							}	//else
						%>
						
                        </ul>
                    </div>
	                  
					<p class="sign-date"><%=sign_ymd %></p>

                        <div class="sign-box signed">
                            <div class="sign-area">
                                <img id ="sign_img" name ="sign_img" src=<%=sign %> class="img-block">
                            </div>
                        </div>
                        
                    </div>

            </div><!-- //container -->
            
        </div><!-- //content -->

    </div><!-- //wrap -->

    <script src="../inc/js/deskPopup/lib/jquery.min.js"></script>
    <script src="../inc/js/deskPopup/plugins.js"></script>
    <script src="../inc/js/deskPopup/main.js"></script>
    
</body>

</html>
