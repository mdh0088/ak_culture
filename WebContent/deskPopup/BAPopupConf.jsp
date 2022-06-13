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
String hphone    = Utils.isNull(request.getParameter("hp"))    ? ""        : request.getParameter("hp");
String store_nm    = Utils.isNull(request.getParameter("storeNm"))    ? ""        : request.getParameter("storeNm");
String sale_ymd    = Utils.isNull(request.getParameter("saleYmd"))    ? "00000000"        : request.getParameter("saleYmd");

String store    = Utils.isNull(request.getParameter("store"))    ? ""        : request.getParameter("store");
String period    = Utils.isNull(request.getParameter("period"))    ? ""        : request.getParameter("period");
String cust_no    = Utils.isNull(request.getParameter("custNo"))    ? ""        : request.getParameter("custNo");

if(!sale_ymd.equals("00000000")){
    sale_ymd = sale_ymd.substring(0,4)+". "+sale_ymd.substring(4,6)+". "+sale_ymd.substring(6);    
}

//시간없이 개발하니 보안,효율성,적합성등 추후 수정 필요!!- 마지막까지 추가 개발요구사항...재료비 수정필요
Vector  vec1  = Bapopupq1.SubjectRead(store,period,cust_no);  
int     count = vec1.size();

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

<script language="javascript">

	function img_set(){
		document.form3.sign_img.src = window.opener.document.form.sign_ck.value;
		
	}

     function sfClose(){
     	window.opener.confClose();
     	return false;
      }
</script>
<body onload="javascript:img_set();">
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
    
        <div class="content ak-academy-04">
            <div class="container">

                <!-- 20190521 수정 : 레이아웃 변경 -->
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

                <!-- 20190603 수정 : 레이아웃 변경 -->
                <div class="section">
                    <h2 class="section-title">강좌 정보</h2>
                    <ul class="course-list">
                        <% 
                        	if (count == 0)
							{
						%>
							<li class="course-list-item">
									강좌정보가 없습니다.
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
                                                <th rowspan="3" class="no"><%=i+1 %></th>
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
                                        
                		<%			}//for
							}	//else
						%>
                    </ul>
                </div>
                <!-- //20190603 수정 : 레이아웃 변경 -->

                <div class="section">
                    <h2 class="page-title">AK문화아카데미 개인정보 수집/이용 동의</h2>

                    <!-- 20190603 수정 : 클래스명 수정 -->
                    <div class="agreement-container js-accordion">
                        <div class="agreement-header">
                            <h3 class="agreement-title">AK문화아카데미 이용 동의<em>(필수)</em></h3>
                            <div class="input-radio-wrap">
                                <label>
                                    <input type="radio" name="policy" value="1" class="input-radio" disabled checked>
                                    <span class="input-radio-label">
                                        <span class="icon"></span>
                                        <span class="text">동의</span>
                                    </span>
                                </label>
                                <label>
                                    <input type="radio" name="policy" value="0" class="input-radio" disabled>
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
                                <div class="nano">
                                    <div class="nano-content">
                                        <!-- 내용 -->
                                        <!-- 20190603 수정 : 내용수정 -->
                                        <p>AK멤버스 가입 회원에 한해 수강신청이 가능하며, 본 신청서를 통해 수집된 회원의 개인정보는 [AK멤버스 개인정보취급방침]에 따라 보호 및 관리됩니다.</p><p>본인은 AK멤버스 회원 가입시 [AK멤버스 회원약관]을 확인하였으며, 이에 동의합니다.</p>                          
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 20190603 수정 : 클래스명 수정 -->
                    <div class="agreement-container js-accordion">
                        <div class="agreement-header">
                            <h3 class="agreement-title">개인정보 수집 동의<em>(필수)</em></h3>
                            <div class="input-radio-wrap">
                                <label>
                                    <input type="radio" name="privacy" value="1" class="input-radio" disabled checked>
                                    <span class="input-radio-label">
                                        <span class="icon"></span>
                                        <span class="text">동의</span>
                                    </span>
                                </label>
                                <label>
                                    <input type="radio" name="privacy" value="0" class="input-radio" disabled>
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
                                <div class="nano">
                                    <div class="nano-content">
                                        <!-- 내용 -->
                                        <p>본인은 AK PLAZA 문화아카데미가 정보를 요청하는 것에 대해 충분히 이해하며, 개인정보를 AK PLAZA 문화아카데미가 수집 및 이용 하는 데에 동의합니다.</p>
                                        <p>※ 만 14세 미만의 가족(자녀) 회원의 수강 신청일 경우 부모의 동의 및 서명으로 가입 처리 됩니다.</p>
                                        <p>※ 수강 신청시 수집한 개인정보는 수강 신청 및 강의 제공을 위한 용도로만 이용되며, 다른 목적으로 이용되지 않습니다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
					<form name="form3">
                    <div class="sign-box signed">
                        <div class="sign-area">
                         	   강좌정보가 없습니다.
                        </div>
                    </div>
                    </form>
                    <p class="sign-date"><%=sale_ymd %></p>

                    <!-- 20190603 수정 : 버튼 추가 -->
                    	<div class="btn-wrap">
                            <button type="submit" onclick="javascript:return sfClose();" class="btn">수강 신청서 작성 완료</button>
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