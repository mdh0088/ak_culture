<%--
 * System       : 문화1
 * Program ID   : BaPopup.jsp 
 * Program Name : 수강신청
 * Descripmtion  : 고객정보입력 
 * Creation     : 2019.
--%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="java.util.*" %>

<%@ page import="ak_culture.classes.*" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page 	import="java.io.*,java.util.*,java.lang.String"%>
<%

String kor_nm    = Utils.isNull(request.getParameter("korNm"))    ? ""        : request.getParameter("korNm");
kor_nm = URLDecoder.decode(kor_nm,"UTF-8");
String birth_ymd    = Utils.isNull(request.getParameter("birthYmd"))    ? ""        : request.getParameter("birthYmd");
String hphone    = Utils.isNull(request.getParameter("hp"))    ? "000"        : request.getParameter("hp");
if(hphone.equals("--"))
{
	hphone = "000";
}
String store_nm    = Utils.isNull(request.getParameter("storeNm"))    ? ""        : request.getParameter("storeNm");
store_nm=URLDecoder.decode(store_nm,"UTF-8");

String store    = Utils.isNull(request.getParameter("store"))    ? ""        : request.getParameter("store");
String period    = Utils.isNull(request.getParameter("period"))    ? ""        : request.getParameter("period");
String cust_no    = Utils.isNull(request.getParameter("custNo"))    ? ""        : request.getParameter("custNo");
cust_no = URLDecoder.decode(cust_no,"UTF-8");
//시간없이 개발하니 보안,효율성,적합성등 추후 수정 필요!!마지막까지 추가 개발요구사항...

Vector  vec1  = Bapopupq1.SubjectRead(store,period,cust_no); 
int     count = vec1.size();
//*표기변경
if(!hphone.equals("000")){
    hphone = hphone.substring(0,hphone.length()-4)+"****";    
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

<script language="javascript">
	opener.document.form.count.value = "<%=count%>";
     
     function sfClose(){
     	 window.opener.document.form.step.src = "../img/deskPopup/step_02_on.jpg";
     	window.opener.callStep2();
     	 //window.close();
     	return false;
      }
     
</script>
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
    
        <div class="content ak-academy-02">
            <div class="container">

                <form action="/">

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
                                                <td rowspan="2" class="td-borno"><%=babn.getRegis_fee()%>원<br>
                                                <%
                                                if(babn.getFood_amt() != null)
                                                {
                                                	%>
	                                                <%=babn.getFood_amt()%>
                                                	<%
                                                }
                                                %>
                                                </td>
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

                    <!-- 20190521 수정 : 취소버튼 삭제 -->
                    <div class="btn-wrap">
                        <button onclick="javascript:return sfClose();" class="btn">확인</button>
                    </div>
                    
                </form>

            </div><!-- //container -->

        </div><!-- //content -->

    </div><!-- //wrap -->
    
    <script src="../inc/js/deskPopup/lib/jquery.min.js"></script>
    <script src="../inc/js/deskPopup/plugins.js"></script>
    <script src="../inc/js/deskPopup/main.js"></script>
    
</body>

</html>