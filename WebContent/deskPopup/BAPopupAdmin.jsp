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

<%
//1번 정보
String kor_nm    = Utils.isNull(request.getParameter("korNm"))    ? ""        : request.getParameter("korNm");
kor_nm = URLDecoder.decode(kor_nm,"UTF-8");
String birth_ymd    = Utils.isNull(request.getParameter("birthYmd"))    ? "00000000"        : request.getParameter("birthYmd");
String hphone    = Utils.isNull(request.getParameter("hp"))    ? ""        : request.getParameter("hp");
String store_nm    = Utils.isNull(request.getParameter("storeNm"))    ? ""        : request.getParameter("storeNm");
store_nm=URLDecoder.decode(store_nm,"UTF-8");

//2번 정보
String cust_no    = Utils.isNull(request.getParameter("custNo"))    ? ""        : request.getParameter("custNo");
cust_no = URLDecoder.decode(cust_no,"UTF-8");
String store    = Utils.isNull(request.getParameter("store"))    ? ""        : request.getParameter("store");
String period    = Utils.isNull(request.getParameter("period"))    ? ""        : request.getParameter("period");
String pos_no    = Utils.isNull(request.getParameter("posNo"))    ? ""        : request.getParameter("posNo");
String resi_no    = Utils.isNull(request.getParameter("resiNo"))    ? ""        : request.getParameter("resiNo");
String sale_ymd    = Utils.isNull(request.getParameter("saleYmd"))    ? ""        : request.getParameter("saleYmd");
String sum    = Utils.isNull(request.getParameter("sum"))    ? "0"        : request.getParameter("sum");





System.out.println("=================="+sum);

if(!birth_ymd.equals("00000000")){
    birth_ymd = birth_ymd.substring(0,4)+"-"+birth_ymd.substring(4,6)+"-"+birth_ymd.substring(6);    
}

//시간없이 개발하니 보안,효율성,적합성등 추후 수정 필요!!마지막까지 추가 개발요구사항...
%>
<!DOCTYPE html>
<html lang="ko">

<head>
  
    
</head>

<script language="javascript">

var oPop;
var loadPop;

	
  function callStep1(){
	document.form.step.src = "../img/deskPopup/step_01_on.png";
	var kor_nm = "<%=kor_nm%>";
	var store_nm = "<%=store_nm%>";
	var birth_ymd = "<%=birth_ymd%>";
	var hphone = "<%=hphone%>";
	var cust_no = "<%=cust_no%>";
	var store = "<%=store%>";
	var period = "<%=period%>";
	
	
	var url = encodeURI("./BAPopupSubject.jsp?korNm="+kor_nm+"&birthYmd="+birth_ymd+"&hp="+hphone+"&storeNm="+store_nm+"&custNo="+cust_no+"&store="+store+"&period="+period);
	//oPop = window.open(url,'POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,fullscreen=yes,resizable=no,width=760,height=1024, top=0 left=0','channelmode','scrollbars');
	var w = window.outerWidth,
		h = window.outerHeight,
		w2 = w/2-250;
	//alert(w+"//"+w2)
	oPop = window.open(url,'POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,menubar=no,scrollbars=yes,resizable=no, top=1080, left=1920, width=760,height=1920');
	//oPop.moveTo(-250, -h);  
	//oPop = window.open(url,'POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=768,height=1024 top=1080 left=1910','channelmode','scrollbars');
	
	//고객대기화면 닫기
	loadPop = window.open('./BaPopupLoading.jsp','POPLoading0101','toolbar=no,location=no,status=no,scrollbars=yes,menubar=no,resizable=no,width=1,height=1 top=0 left=1'); 
	if(loadPop!=null){
		 loadPop.close();
	}
 	
	return false;
  }
  

  
  function callStep2(){
		var cust_no = "<%=cust_no%>";
		var store = "<%=store%>";
		var period = "<%=period%>";
		var pos_no = "<%=pos_no%>";
		var resi_no = "<%=resi_no%>";
		var sale_ymd = "<%=sale_ymd%>";

		if(document.form.count.value == "N"){
			alert("회원 / 강좌정보 확인 필수입니다.!");
			return false;
		}
		
		if(document.form.count.value == 0){
			alert("강좌정보가 없습니다.!!");
			return false;
		}
		
		document.form.step.src = "../img/deskPopup/step_02_on.png";
		
		//원
		var url = "./BaPopupSign.jsp?saleYmd="+sale_ymd+"&custNo="+cust_no+"&store="+store+"&period="+period+"&posNo="+pos_no+"&resiNo="+resi_no;
		var w = window.outerWidth,
		h = window.outerHeight,
		w2 = w/2-250;
		oPop = window.open(url,'POPEvent0101_1','toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=no,directories=no,top=0, left='+w2+', width=500,height='+h);
		oPop.moveTo(-250, -h);  
		
		
		//oPop = window.open(url,'POPEvent0101_1','toolbar=no,location=no,scrollbars=yes,status=no,menubar=no,resizable=no,directories=no,width=768,height=1024 top=1080 left=1910');
		return false;
  }
  
  function callStep3(){
	    var kor_nm = "<%=kor_nm%>";
		var store_nm = "<%=store_nm%>";
		var birth_ymd = "<%=birth_ymd%>";
		var hphone = "<%=hphone%>";
	 	var cust_no = "<%=cust_no%>";
		var store = "<%=store%>";
		var period = "<%=period%>";
		var pos_no = "<%=pos_no%>";
		var resi_no = "<%=resi_no%>";
		var sale_ymd = "<%=sale_ymd%>";
		var sign_ck = document.form.sign_ck.value;

		document.form.step.src = "../img/deskPopup/step_03_on.png";

		var url = "./BAPopupConf.jsp?saleYmd="+sale_ymd+"&custNo="+cust_no+"&store="+store+"&period="+period+"&posNo="+pos_no+"&resiNo="+resi_no+"&korNm="+kor_nm+"&birthYmd="+birth_ymd+"&hp="+hphone+"&storeNm="+store_nm;

		oPop = window.open(url,'POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=768,height=1024 top=0 left=1920');
		//oPop = window.open(url,'POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=768,height=1024 top=1080 left=1910');
		return false;
  }

     function confClose(){
    	 //if(oPop == null){
    		 var sum = "<%=sum%>";
    		 if(sum > 0){
    			 opener.myWindow = window.open('./BaPopupLoading2.jsp','POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1,height=1 top=0 left=1');	 
    		 }else{
    			 opener.myWindow = window.open('./BaPopupLoading3.jsp','POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1,height=1 top=0 left=1');	 
    		 }
    		  
    	 //}
    	 
	    //if(oPop!=null){
//	    	oPop.close();
	//    }
	    alert("수강신청서 작성이 완료되었습니다.");
         window.close();
     
     }
     
     function adminClose(){
    	 if(oPop == null){
    		 var sum = "<%=sum%>";
    		 if(sum > 0){
    			 opener.myWindow = window.open('./BaPopupLoading2.jsp','POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1,height=1 top=0 left=1');	 
    		 }else{
    			 oPop = window.open('./BaPopupLoading3.jsp','POPEvent0101_1','toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1,height=1 top=0 left=1');	 
    		 } 
    	 }
    	 
	    if(oPop!=null){
	    	oPop.close();
	    }
         window.close();
     
     }     
</script>
<body onload="javascript:callStep1();">
<form name="form">   
<img id="step" src="../img/deskPopup/step_01_on.jpg" alt="" style="display:block;margin:30px auto;width:688px;height:100px;">
    
    <table style="width:688px;margin:0 auto;padding:0;border-spacing:0;border:0; text-align:center">
        <tr>
            <td><img onclick="javascript:return callStep1();" src="../img/deskPopup/btn_step_01.png" alt=""></td>
            <td style="padding:0 0 0 33px;"><img onclick="javascript:return callStep2();" src="../img/deskPopup/btn_step_02.png" alt=""></td>
            <td style="padding:0 0 0 33px;"><img onclick="javascript:return adminClose();" src="../img/deskPopup/btn_step_04.png" alt=""></td>
        </tr>
    </table>

<input type="hidden" name="kor_nm" id ="kor_nm" >
<input type="hidden" name="birth_ymd" id ="birth_ymd" >
<input type="hidden" name="hphone" id ="hphone" >
<input type="hidden" name="store_nm" id ="store_nm">
<input type="hidden" name="cust_no" id ="cust_no">
<input type="hidden" name="store" id ="store" >
<input type="hidden" name="period" id ="period">
<input type="hidden" name="pos_no" id ="pos_no">
<input type="hidden" name="resi_no" id ="resi_no">
<input type="hidden" name="sale_ymd" id ="sale_ymd">
<input type="hidden" name="sign_ck" id ="sign_ck">
<input type="hidden" name="count" id ="count" value="N">

</form>

</body>

</html>
