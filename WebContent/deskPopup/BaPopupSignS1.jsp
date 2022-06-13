<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires",0);
	response.setHeader("Cache-Control","no-cache");
%>
<%@ page import="ak_culture.classes.*" %>
<%@ page import="java.util.*" %>

<%
Enumeration params = request.getParameterNames();

System.out.println("----------------------------");

while (params.hasMoreElements()){

    String name = (String)params.nextElement();

    System.out.println(name + " : " +request.getParameter(name));

}

System.out.println("----------------------------");


String store    = Utils.isNull(request.getParameter("store"))    ? "00"        : request.getParameter("store");
String cust_no    = Utils.isNull(request.getParameter("cust_no"))    ? "000000000"        : request.getParameter("cust_no");
String period    = Utils.isNull(request.getParameter("period"))    ? "000"        : request.getParameter("period");
String pos_no    = Utils.isNull(request.getParameter("pos_no"))    ? "000000"        : request.getParameter("pos_no");
String sign    = Utils.isNull(request.getParameter("sign"))    ? ""        : request.getParameter("sign");
String resi_no    = Utils.isNull(request.getParameter("resi_no"))    ? "0000"        : request.getParameter("resi_no");
	
    boolean bResult = true;
    bResult = Bapopupq1.SignIns(store,cust_no,period,pos_no,sign,resi_no);    
%>

 <script language="javascript">
 window.opener.confClose();
 //self.close();
 </script>


