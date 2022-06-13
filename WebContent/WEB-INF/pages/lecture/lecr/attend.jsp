<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css" media="print">
@media print {
  .noprint{ display:none !important; }
 }	
@page {
	size: a4;
	margin: 10mm 5mm; 
}
</style>
<style>
*{
	/*font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";*/
	font-family:"바탕체",BatangChe;
	font-size:16px;
	letter-spacing:1px;
	line-height:1.6;
	padding:0;
	margin:0;
	box-sizing:border-box;
	
}
.attend_box{
    border: 1px solid #000;
    padding:50px 50px;
    margin: 15px auto 0;
}
h3{
	font-size:30px;
	font-weight:bold;
	text-align:center;
	margin-top:50px;
}
.p1{
	
}
.p2{
	text-align:center;
}
.p3{
	text-align:center;
	margin:50px 0;
}
.p4{
	text-align:center;
	font-size:22px;
	font-weight:bold;
	padding-left:80px;
}
.p4 span{
	width:80px;
	height:80px;
	border:3px solid #ddd;
	text-align:right;
	color:#ddd;
	display:inline-block;
	padding:23px 0;
	padding-right:5px;
	vertical-align:middle;
	margin-left:30px;
}
.logo{
	text-align:center;
}
.attend_wrap{    
    width: 100%;
    max-width:1200px;
    position: absolute;
    left: 50%;
    top: 0;
    height: 100%;
    transform:translateX(-50%);
    -webkit-transform:translateX(-50%);
}
.attend-content{
	margin:60px 0;
    min-height:600px;
}
.attend-content > div{
	margin:15px 0;
	padding-left:160px;
}
.attend-content > div > span{
	width: 160px;
    text-align: justify;
    display: inline-block;
    vertical-align: top;
    margin-left:-160px;
    
}
.attend-content > div > span:after{
    content: '';
    display: inline-block;
    width: 100%;
}
.attend-content p{
    display: inline-block;
    vertical-align: top;
    padding-lefT:20px;
}
.attend-content p:before{
	content:":";
	display:inline-block;
	width:20px;
	margin-left:-20px;
	float:left;
	text-align:center;

}
.attend-content p span, .p3 span{
	padding:0 5px 0 3px;
}
.btn{
	padding:0 15px;
	text-align:Center;
	font-size:12px;
	display:inline-block;
	min-width: 120px;
	height: 34px;
	line-height:32px;
	border-radius: 20px;
	cursor:pointer;
	vertical-align:middle;
	font-family:-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji";
	background:#4c546e;
	color:#fff;
	border: solid 1px #4c546e;
    letter-spacing: 0;
    position: absolute;
    left: 30px;
    top: 30px;
}
</style>

<a class="btn print-btn noprint" onclick="window.print();">인쇄하기</a> 
<div class="attend_wrap">
	<div class="attend_box">
		<c:set var="now" value="<%=new java.util.Date()%>" />
		<p class="p1">문서번호 : 문출 <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /></p>
		<h3>출 강 증 명 서</h3>
		
		<div class="attend-content">
			<div><span>성 명</span><p>${lecturer_nm}</p></div>
			<div><span>주 민 등 록 번 호</span><p>${lecturer_cd}</p></div>
			<div><span>주 소</span><p>${cus_addr}</p></div>
			<div><span>강 좌 명</span><p>${subject_list}</p></div>
			<div><span>출 강 기 간</span><p>${fn:substring(start_ymd,0,4)}<span>년</span> ${fn:substring(start_ymd,4,6)}<span>월</span> ${fn:substring(start_ymd,6,8)}<span>일</span> ~ ${fn:substring(end_ymd,0,4)}<span>년</span> ${fn:substring(end_ymd,4,6)}<span>월</span> ${fn:substring(end_ymd,6,8)}<span>일</span></p></div>
<!-- 			<div><span>용 도</span><p>기관제출용</p></div> -->
		</div><!-- //attend-content end -->
		
		<p class="p2">위의 사실을 증명합니다.</p>
		<p class="p3"><fmt:formatDate value="${now}" pattern="yyyy" /><span>년</span> <fmt:formatDate value="${now}" pattern="MM" /><span>월</span> <fmt:formatDate value="${now}" pattern="dd" /><span>일</span></p>
		<p class="p4">문화아카데미 ${printStore}<span>인<img src="/img/AK_stamp.png" style="width: 77px;margin-top: -50px;"/></span></p>
		<div class="logo"><img src="/img/ak-logo_attend.png" /></div>
	</div><!--  //attend_box end -->
</div><!-- //attend_wrap end -->




