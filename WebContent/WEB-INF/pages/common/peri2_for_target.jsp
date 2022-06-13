<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<select de-data="${perilist[0].PERIOD}" id="target_selPeri" name="target_selPeri" onchange="target_fncPeri2()">
	<c:forEach var="i" items="${perilist}" varStatus="loop">
		<option value="${i.PERIOD}" store="${i.STORE}">${i.PERIOD} / ${i.STORE_NM}</option> 
	</c:forEach>
</select>