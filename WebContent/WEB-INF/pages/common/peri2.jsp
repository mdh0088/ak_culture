<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<select de-data="${perilist[0].PERIOD}" id="selPeri" name="selPeri" onchange="fncPeri2()" style="display:none; ">
	<option value="99999" store=""></option> <!-- 전체검색을 막기위해 --> 
	<c:forEach var="i" items="${perilist}" varStatus="loop">
		<option value="${i.PERIOD}" store="${i.STORE}">${i.PERIOD} / ${i.STORE_NM}</option> 
	</c:forEach>
</select>