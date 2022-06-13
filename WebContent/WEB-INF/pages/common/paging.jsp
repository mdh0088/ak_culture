<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
var listSize = '${listSize}';
var page = '${page}';
var search_name = '${search_name}';
var order_by = '${order_by}';
var sort_type = '${sort_type}';
var scr_stat = getCookie("scr_stat");

$(document).ready(function(){
	$("#search_name").val(search_name);
	
	if(listSize != "")
	{
		$("#listSize").val(listSize);
		$(".listSize").html(listSize+"개 보기");
	}
	
	if(scr_stat == "ON")
	{
		jQuery(window).scroll(function() {
			var scrollTop = $(this).scrollTop();
	        var innerHeight = $(this).innerHeight();
	        var scrollHeight = $(this).prop('scrollHeight');
	
	        if($(document).height() <= $(window).scrollTop() + $(window).height())
	        {
	       		var act = $("#fncForm").attr("action");
	       		var p = $("#page").val();
	       		$("#page").val(Number(p)+1);
	       		
	       		var queryString = $("#fncForm").serialize() ;
	       		$.ajax({
	       			type : "POST", 
	       			url : act,
	       			dataType : "text",
	       			data : queryString,
	       			async : false,
	       			error : function() 
	       			{
	       				console.log("AJAX ERROR");
	       			},
	       			success : function(data) 
	       			{
	       				$("#paging_result").html(data.substring(data.indexOf("<table>"), data.indexOf("</table>")+8)); //</table>가 8글자니까 +8
	       				var ht = $("#paging_result").find("tbody").html();
	       				$(".table-list").find("table").find("tbody").append(ht);
	       			}
	       		});
	        }
		});
	}
	else
	{
		$("#p_"+page).addClass("active");
		$(".page_num").show();
	}
})

function reSelect()
{
	$("#page").val(1);
	$("#fncForm").submit();
}
function reSort(act)
{
	var sort_type = act.replace("sort_", "");
	if(order_by == "")
	{
		order_by = "desc";
	}
	else if(order_by == "desc")
	{
		order_by = "asc";
	}
	else if(order_by == "asc")
	{
		order_by = "desc";
	}
	
	$("#sort_type").val(sort_type);
	$("#order_by").val(order_by);			
	$("#page").val(1);
	$("#fncForm").submit();
}
function pageMove(page)
{
	$("#page").val(page);
	$("#fncForm").submit();
}
</script>
<div id="paging_result" style="display:none;"></div>
<div class="page_num" style="display:none;">
	<c:if test="${5 < page}">
		<a onclick="javascript:pageMove(1);"> ◀◀ </a>
    	<a onclick="javascript:pageMove(${s_page-1});"> ◀ </a>
	</c:if>
	<c:set var="pagingCnt" value="0"/>
	<c:if test="${e_page ne 0}">
		<c:forEach var="i" begin="${s_page}" end="${e_page}" varStatus="loop">
			<c:set var="pagingCnt" value="${pagingCnt+1}"/>
			<a onclick="javascript:pageMove(${loop.index});" id="p_${loop.index}" class="p_btn">${loop.index}</a>
		</c:forEach>
	</c:if>
	<c:if test="${e_page eq 0}">
		 <a onclick="javascript:pageMove(1);">1</a>
	</c:if>
	
	<c:if test="${pageNum ne page}">
		<c:if test="${pageNum > 5}">
			<c:if test="${pagingCnt > 4}">
				<c:if test="${e_page+1 > pageNum}">
					<a onclick="javascript:pageMove(${pageNum});"> ▶ </a>
            		<a onclick="javascript:pageMove(${pageNum});"> ▶▶ </a> 
				</c:if>
				<c:if test="${e_page+1 <= pageNum}">
					<a onclick="javascript:pageMove(${e_page+1});"> ▶ </a>
            		<a onclick="javascript:pageMove(${pageNum});"> ▶▶ </a> 
				</c:if>
			</c:if>
		</c:if>
	</c:if>
</div>