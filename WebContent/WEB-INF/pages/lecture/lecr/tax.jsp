<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style type="text/css" media="print">

@page {
	margin: 10mm 5mm; 
    size: landscape;
}
@media print {
  .noprint{ display:none !important; }
 }
</style>


<a class="btn print-btn noprint" onclick="window.print();">인쇄하기</a> 
<div class="tax_wrap">
	<p class="p1">[별지 제 23호 서식 (2)] (2020. 4. 14 개정)</p>
	<div class="tax-box">
		<div class="tax-title_section">
			<div class="t-number">
				<table>
					<tr>
						<th>관 례 번 호</th>
						<td></td>
					</tr>
					<tr>
						<th>귀 속 연 도</th>
						<td class="text-right"><span class="td-sp"></span>년</td>
					</tr>
				</table>
			</div> <!-- // t-number  -->
			
			<div class="t-center">
				<div>
					<h3>사 업 소 득 &nbsp; 원 천 징 수 영 수 증</h3>
					<h3>사 업 소 득 지 급 조 서</h3>	
				</div>
				
				<p>(발행자 보관용)</p>		
			</div> <!--  // t-center -->
			
			<div class="t-reside">
				<table>
					<tr>
						<th>거주구분</th>
						<td>거주자 1</td>
					</tr>
					<tr>
						<th>내 · 외국인</th>
						<td>내국인 1, 외국인 9</td>
					</tr>
				</table>
			</div> <!-- // t-reside -->
			
		</div> <!-- // tax-title_section -->
		
		<div class="tax-table_section">
			<div class="table table-sec01">		
				<table>
					<tr>
						<td rowspan="2" class="txt-j"><span>징 수</span> 의 무 자</td>
						<td class="txt-j02">① 사 업 자 등 록 번 호</td>
						<td>${ak_biz_no}</td>
						<td class="txt-j02">② 법 인 명  &nbsp; 또는  &nbsp; 상 호</td>
						<td>${ak_biz_nm}</td>
						<td class="txt-j02">③ 성 &nbsp; 명</td>
						<td class="tb-ri">김재천</td>
					</tr>
					<tr>
						<td class="txt-j02">④ 주 민 (법 인) 등 록 번 호</td>
						<td>${ak_corp_no }</td>
						<td class="txt-j02">⑤ 소 재 지  &nbsp; 또는  &nbsp; 주 소</td>
						<td colspan="3">${ak_biz_addr}</td>
					</tr>
				</table>
			</div><!--  //table-sec01  -->
		
			<div class="table table-sec02">
				<table>
					<tr>
						<td rowspan="4" class="txt-j">소 득 자</td>
						<td class="txt-j02"><span>① 상 호</span></td>
						<td>${biz_nm}</td>
						<td class="txt-j02">② 사 업 자 등 록 번 호</td>
						<td class="tb-ri">${biz_no}</td>
					</tr>
					<tr>
						<td class="txt-j02">③ 사 업 장 소 재 지</td>
						<td colspan="3">${biz_addr_tx}</td>
					</tr>
					<tr>
						<td class="txt-j02"><span>④ 성 명</span></td>
						<td>${lecturer_nm}</td>
						<td class="txt-j02">⑤ 주 민 등 록 번 호</td>
						<td>${fn:substring(lecturer_cd, 0, 6)}-${fn:substring(lecturer_cd, 6, 13)}</td>
					</tr>
					<tr>
						<td class="txt-j02"><span>⑥ 주 소</span></td>
						<td colspan="3">${cus_address}</td>
					</tr>
					<tr>
						<td class="txt-j">⑦ 업 종 구 분</td>
						<td>63</td>
						<td colspan="3">※ 작성요령참조</td>
					</tr>
				</table>
				
				<table>
					<thead>
						<tr>
							<th colspan="3">⑧ 지급</th>
							<th colspan="2">⑨ 소득취득</th>
							<th rowspan="2">⑩ 지급총액</th>
							<th rowspan="2">⑪ 세율</th>
							<th colspan="3" class="tb-ri">원천징수세액</th>
						</tr>
						<tr>
							<th>년</th>
							<th>월</th>
							<th>일</th>
							<th>년</th>
							<th>월</th>
							<th>⑫ 소득세</th>
							<th>⑬ 주민세</th>
							<th>⑭ 계</th>
						</tr>
					</thead>
					
					<tbody>
						<c:forEach var="i" items="${list}" varStatus="loop">
							<tr>
								<td>${fn:substring(i.ACCT_SLIP_YMD, 0, 4)}</td>
								<td>${fn:substring(i.ACCT_SLIP_YMD, 4, 6)}</td>
								<td>${fn:substring(i.ACCT_SLIP_YMD, 6, 8)}</td>
								<td>${fn:substring(i.ACCT_SLIP_YMD, 0, 4)}</td>
								<td>${fn:substring(i.ACCT_SLIP_YMD, 4, 6)}</td>
								<td class="text-right"><fmt:formatNumber value="${i.LECT_PAY}" pattern="#,###"/></td>
								<td class="text-right">${i.TAX_RATE}</td>
								<td class="text-right"><fmt:formatNumber value="${i.INCOME_TAX}" pattern="#,###"/></td>
								<td class="text-right"><fmt:formatNumber value="${i.RESI_TAX}" pattern="#,###"/></td>
								<td class="text-right"><fmt:formatNumber value="${i.NET_LECT_PAY}" pattern="#,###"/></td>
							</tr>
						</c:forEach>
						
<!-- 						<tr> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 						</tr> -->
						
<!-- 						<tr> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td></td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 							<td class="text-right">0</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>
				
				<p class="table-p">위의 원천징수세액(수입금액)을 정히 영수(지급)합니다.</p>
				
				<p class="ymd-p">${y} <span>년</span>  ${m} <span>월</span> ${d} <span>일</span></p>
				<p class="info">징수(보고)의무자 ${ak_biz_nm } <span>김재천<img src="/img/ak_stamp2.png" style="width: 90px;margin-bottom: -25px;"/></span></p>
				
				<p class="name-p">${lecturer_nm} <span>귀하</span></p>
			</div>	
			<!--  // table-sec02 -->
			
			
		</div> <!-- // tax-table_section -->
		
		<div class="table tax-content_section">
			<p>&lt;작성요령&gt;</p>
			<ul>
				<li>1. 이 서식은 거주자가 사업소득이 발생한 경우에 한하여 작성하여, 비거주자는 별지 제 23호 서식(4)을 사용하여야 합니다.</li>
				<li>2. ⑥ 업종구분란에는 소득자의 업종에 해당하는 아래 업종구분코드를 정확하게 기재하여야 합니다.</li>
				<li>3. 세액이 소액부징수에 해당하는 경우에는 세액을 "0"으로 기재합니다.</li>
			</ul>
			
			<table>
				<tr>
					<td rowspan="4" style="width:50px;">업종 <br>구분 <br>코드</td>
					<td>의사등</td>
					<td>문학·학술·국술등제작자</td>
					<td>가수·배우·탤런트</td>
					<td>직업 운동가</td>
					<td>보험모집인</td>
					<td>방문판매원</td>
					<td>다단계판매원<br>의 후원수당</td>
					<td>기타모집수당</td>
					<td>화가및관련<br>예술가</td>
					<td class="tb-ri">작곡가</td>
				</tr>
				
				<tr>
					<td>43</td>
					<td>48</td>
					<td>46</td>
					<td>47</td>
					<td>48</td>
					<td>49</td>
					<td>50</td>
					<td>51</td>
					<td>52</td>
					<td>53</td>
				</tr>
				
				<tr>
					<td>모델</td>
					<td>성악가 등</td>
					<td>연구보조서비스</td>
					<td>자문·교문로등</td>
					<td>바둑기사</td>
					<td>꽃꽃이</td>
					<td>학원강사 및 <br> 재단사</td>
					<td>배달원</td>
					<td>컴퓨터프로그래머 등</td>
					<td>기타</td>
				</tr>
				
				<tr>
					<td>54</td>
					<td>55</td>
					<td>56</td>
					<td>57</td>
					<td>58</td>
					<td>59</td>
					<td>60</td>
					<td>61</td>
					<td>62</td>
					<td>63</td>
				</tr>
			</table>
		
		</div> <!-- // tax-content_section -->
		
		
	</div> <!-- //tax-box -->
	
	<div class="tax-bottxt">* 취급자 확인이 없는 것은 무효입니다. <div class="sign">취급자인 <span></span></div></div>
	<div class="fl-right">297mm * 210m (인쇄용지 60m<sup>2</sup>(재활용품))</div>
</div>







<style>
*{
/* 	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Noto Sans", sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol", "Noto Color Emoji"; */
	font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
	font-size:10px;
	line-height:1.6;
	padding:0;
	margin:0;
	box-sizing:border-box;
}
.tax_wrap{max-width:1100px; margin:0 auto;}
.tax_wrap > p.p1{font-size:12px; font-weight:600; margin:0;}
.tax-box{border:3px solid #000;}
.tax-title_section{padding:15px 20px; display:table; margin:0 auto;}
.tax-title_section > div{display:table-cell; vertical-align: middle;}
.t-center{text-align:center; width:60%;}
.t-center > div{max-width:345px; margin:0 auto;}
.t-center > div > h3{width:345px; text-align:justify; font-size:20px; margin:0;}
.t-center > div > h3:after{content:'';display:inline-block; width:100%;}
.t-center > div + p{font-size:13px; font-weight:bold;}
table th, table td{border:1px solid #000; font-size:9px; padding:2px 5px;}
table{border-collapse:collapse; display:table; width:100%; table-layout:fixed;}
.table-p{font-size:11px;padding:5px;}
.ymd-p{text-align:center;margin:10px 0;}
.ymd-p span{padding-left:15px; padding-right:40px;}
.info{letter-spagin:0;font-size:12px;margin-right:150px;text-align:right;
    margin-top: -30px;}
.name-p{font-size:14px; margin-left:100px;}
ul,li{margin:0;padding:0;list-style:none;}
.tax-content_section{border-top:1px solid #000;}
.tax-content_section > p{font-size:12px; padding:5px 0 0 15px;}
.tax-content_section ul{padding:0 0 15px 20px;}
.tax-content_section ul li{font-size:10px;}
.tax-content_section table td{text-align:center;}
.ts-th{width:180px;}
.t-number table th, .t-reside table th{width:100px;}
.text-right{text-align:right;}

.txt-j02{width:155px}
.txt-j{width:130px;text-align:justify;padding:0 20px;}
.txt-j span{width:130px;text-align:justify;}
.txt-j:after, .txt-j span:after{content:'';display:inline-block;width:100%;}
/*.txt-j02{width:177px;text-align:justify;padding:0 5px;}
.txt-j02:after{content:'';display:inline-block;width:100%;}*/
.tax-bottxt{float:left;font-size:12px;margin-top: 5px;}
.tax-bottxt .sign{display:inline-block;margin-left:30px;}
.tax-bottxt .sign span{border:1px solid #000;display:inline-block;vertical-align:middle;width:50px;height:25px;}
.fl-right{float:right;font-size:12px;font-weight:bold;}
.table table th, .table table td{border-left:0;}
.tb-ri{border-right:0;}
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












