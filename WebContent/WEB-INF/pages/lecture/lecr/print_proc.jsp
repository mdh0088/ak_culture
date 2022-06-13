<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
<script src="/inc/js/musign.js"></script>
<script src="/inc/js/jquery.breadcrumbs-generator.js"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500|Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp">
<script src="/inc/js/function.js"></script>
<link rel="stylesheet" href="/inc/css/contract/contractPrint.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />

<script>

window.onload = function(){
	printPage();
}

function printPage(){
	 var initBody;
	 window.onbeforeprint = function(){
	  initBody = document.body.innerHTML;
	  document.body.innerHTML =  document.getElementById('list_target').innerHTML;
	 };
	 window.onafterprint = function(){
	  document.body.innerHTML = initBody;
	 };
	 window.print();
	 return false;
	}
	
</script>

<style type="text/css">
@page {
  size:210mm 297mm; /*A4*/
  margin:0mm
 }
@media print {	
	*{
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
		margin:0;
		padding:0;
		box-sizing:border-box;
	}
	table td, table th {
		border:0;
		border: 1px solid #e0e0e0;
		padding:5px;
		font-size:12px;
		text-align:Center;
		
	}
	table {
	    border-collapse: collapse;
	    border-spacing: 0;
	    width: 100%;
	}
	body {
		font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
	}
	.contract-box .ct-kor{
		margin-bottom:60px;
	}
	table.cl-table td{
		border-left: 1px solid #e8e8e8;
	}
	table.cl-table  {
	    border:1px solid #e8e8e8;
	}
	table.cl-table th.table-bg{
    	background: #fafafa;
	}
	table.cl-table01 {
	    border-top: 2px solid #cfb6a4;
    	margin-top: 30px;
	}
	ul, li{
		margin:0;
		list-style:none;
	}
		
	
}
</style>

<div id="list_target">
	${result}
</div>