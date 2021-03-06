<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>
$(document).ready(function() {
	$( ".sortable" ).sortable();
    $( ".sortable" ).disableSelection();
	getList();
	init();
});
var isLoading = false;
function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".search-btn02").addClass("loading-sear");
	$(".search-btn02").prop("disabled", true);
	$(".search-btn").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".search-btn02").removeClass("loading-sear");		
	$(".search-btn02").prop("disabled", false);
	$(".search-btn").prop("disabled", false);
	isLoading = false;
}
$(document).ready(function() {
	$( ".sortable" ).sortable();
    $( ".sortable" ).disableSelection();
	getList();
	init();
});
function init()
{
	$("#chk_all").change(function() {
		if($("input:checkbox[name='chk_all']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all").val()+"']").prop("checked", false);
		}
	});	
}
function getList(paging_type) 
{
	getListStart();
	var chkCate = "";
	$("[name='news_category']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkCate += '\''+$(this).val()+"\',";
		}
	});
	var chkStore = "";
	$("[name='selBranch']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkStore += '\''+$(this).val()+"\',";
		}
	});
	$.ajax({
		type : "POST", 
		url : "./getNewsList",
		dataType : "text",
		data : 
		{
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			search_cate : chkCate,
			search_store : chkStore,
			search_date_type : $("#search_date_type").val(),
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$(".cap-numb").html("?????? "+result.listCnt+" / ??????"+result.listCnt_all+"???");
			var inner = "";
			if(result.list.length > 0)
			{
				for(var i = 0; i < result.list.length; i++)
				{
					inner += '<li class="move-tr">';
					inner += '	<input type="hidden" id="seq_'+result.list[i].SEQ+'" name="seqs">';
					inner += '	<span class="tdwid-40"><input type="checkbox" id="chk_'+result.list[i].SEQ+'" name="chk_val" value=""><label for="chk_'+result.list[i].SEQ+'"></label></span>';
					inner += '	<span class="tdwid-40">'+(nullChkZero(result.list[i].SORT)+1)+'</span>';
					inner += '	<span>'+result.list[i].STORE_NM+'</span>';
					inner += '	<span>'+result.list[i].CATEGORY+'</span>';
					inner += '	<span class="tdwid-450">'+result.list[i].TITLE+'</span>';
					inner += '	<span>'+result.list[i].CREATE_RESI_NM+'</span>';
					inner += '	<span>'+cutDate(result.list[i].CREATE_DATE)+'</span>';
					inner += '	<span></span>';
					inner += '	<span>'+result.list[i].IS_SHOW+'</span>';
					inner += '	<span class="open"><a href="./academy_upload?seq='+result.list[i].SEQ+'"><b>??????</b></a></span>';
					inner += '</li>';
				}
			}
			else
			{
				inner += '<li>';
				inner += '??????????????? ????????????.';
				inner += '</li>';
			}
			$("#target").html(inner);
			getListEnd();
		}
	});	
	init();
}
function delNews()
{
	var chkSeq = "";
	$("[name='chk_val']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkSeq += '\''+$(this).attr("id").replace("chk_", "")+"\',";
		}
	});
	if(chkSeq == "")
	{
		alert("????????? ????????? ????????????.");
		return;
	}
	
	if(confirm("?????? ?????????????????????????"))
	{
		$.ajax({
			type : "POST", 
			url : "./delNews",
			dataType : "text",
			async : false,
			data : 
			{
				seq : chkSeq
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				console.log(data);
				var result = JSON.parse(data);
				if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	    			location.reload();
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});	
	}
}
function setSort()
{
	for(var i = 0; i<document.getElementsByName('seqs').length; i++)
	{
		var seq = document.getElementsByName('seqs')[i].getAttribute('id').split("_")[1];
		$.ajax({
			type : "GET", //??????????????? ???????????? (POST,GET)
			url : "./sortNews?sort="+i+"&seq="+seq,//?????? URL??? ????????????. GET??????????????? ?????? ??????????????? ????????? ??????????????????.
			dataType : "text",//????????? ???????????? ????????????. xml,json,html,text?????? ?????? ????????? ????????? ??? ??????.
			async:false,
			error : function() 
			{
				alert("?????? ??? ????????? ?????????????????????.");
			},
			success : function(data) 
			{
				
			}
		});
	}
	alert("?????????????????????.");
}
</script>

<div class="sub-tit">
	<h2>???????????? ??????</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<A class="btn btn01 btn01_1" href="/web/academy_upload"><i class="material-icons">add</i> ????????? ?????? </A>
	</div>
</div>

<div class="table-top ">

	<div class="table">
		<div class="wid-6">
			<div class="table">
				<div class="search-wr search-wr_div">				
					<select class="wid-10" id="search_type" name="search_type" de-data="????????????">
						<option value="">????????????</option>
						<option value="??????">??????</option>
						<option value="??????">??????</option>
					</select>
					<div class="search-wr_div02 sear-6">					
					    <input type="text" class="inp-100" id="search_name" name="search_name" onkeypress="excuteEnter(getList)" placeholder="???????????? ??????????????????.">
					    <input class="search-btn" type="button" value="??????" onclick="getList();">
					</div>
				</div>
				
			</div>
		</div>
		<div class="wid-4">
			<div class="table">
				<div class="sear-tit">????????????</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="news_category1" name="news_category" value="NOTICE" />
							<label for="news_category1">NOTICE</label>
						</li>
						<li>
							<input type="checkbox" id="news_category2" name="news_category" value="EVENT" />
							<label for="news_category2">EVENT</label>
						</li>
					</ul>
					
				</div>
			</div>
		</div>
		
		
	</div>
	<div class="table">
		<div class="wid-5">
			<div class="table table-auto">
				<div class="">
					<select class="wid-10" id="search_date_type" name="search_date_type" de-data="?????????">
						<option value="?????????">?????????</option>
						<option value="?????????">?????????</option>
					</select>
				</div>
				<div>					
					<div class="cal-row table table-auto">
						<div class="cal-input  ">
							<input type="text" id="search_start" name="search_start" value="" class="date-i three-i" />
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input ">
							<input type="text" id="search_end" name="search_end" value="" class="date-i ready-i" />
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-5">
			<div class="table">
				<div class="sear-tit sear-tit_90">??????</div>
				<div>
					<ul class="chk-ul">
						<c:forEach var="i" items="${branchList}" varStatus="loop">
							<li>
								<input type="checkbox" id="selBranch${loop.index}" name="selBranch"  value="${i.SUB_CODE}"/>
								<label for="selBranch${loop.index}">${i.SHORT_NAME}</label>
							</li> 
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getList()">
	
</div>

<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb">?????? 0??? / ?????? 0???</p>
	</div>
	<div class="cap-r text-right">
		<div class="table float-right">
			<div class="sel-scr">
				<a class="btn btn03" onclick="javascript:setSort();">?????? ????????????</a>
				<!-- <a class="btn btn01" href="#"><i class="material-icons">import_export</i>ASC</a>
				<a class="bor-btn btn01 mrg-l6" href="#"><i class="fas fa-file-download"></i></a> -->
<!-- 				<select id="listSize" name="listSize" onchange="getList()" de-data="10??? ??????"> -->
<!-- 					<option value="10">10??? ??????</option> -->
<!-- 					<option value="20">20??? ??????</option> -->
<!-- 					<option value="50">50??? ??????</option> -->
<!-- 					<option value="100">100??? ??????</option> -->
<!-- 					<option value="300">300??? ??????</option> -->
<!-- 					<option value="500">500??? ??????</option> -->
<!-- 					<option value="1000">1000??? ??????</option> -->
<!-- 				</select> -->
			</div>
		</div>
		
		
	</div>
	
</div>


<div class="table-dragwr">
	<div class="table-inner">
	
		<ul class="ul10">
			<li class="table-th">
				<span class="tdwid-40"><input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label></span>
				<span class="tdwid-40">NO. </span>
				<span>?????? </span>
				<span>???????????? </span>
				<span class="tdwid-450">?????? </span>
				<span>????????? </span>
				<span>?????????/????????? </span>
				<span>??????</span>
				<span>??????</span>
				<span>??????</span>
			</li>
		</ul>
		<ul class="ul10 sortable" id="target">
<!-- 			<li> -->
<!-- 				<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 				<span class="td-no">49</span> -->
<!-- 			   	<span>?????????</span> -->
<!-- 			   	<span>NOTICE</span> -->
<!-- 			   	<span class="td-350">Refresh Time</span> -->
<!-- 			   	<span>?????????</span> -->
<!-- 				<span>2019-11-09</span> -->
<!-- 				<span>134</span> -->
<!-- 			   	<span>N</span> -->
<!-- 			   	<span class="open"><b>??????</b></span> -->
<!-- 			</li> -->
<!-- 			<li class="move-tr"> -->
<!-- 				<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 				<span class="td-no">49</span> -->
<!-- 			   	<span>?????????</span> -->
<!-- 			   	<span>NOTICE</span> -->
<!-- 			   	<span class="td-350">Refresh Time</span> -->
<!-- 			   	<span>?????????</span> -->
<!-- 				<span>2019-11-09</span> -->
<!-- 				<span>134</span> -->
<!-- 			   	<span>N</span> -->
<!-- 			   	<span class="open"><b>??????</b></span> -->
<!-- 			</li> -->
			
<!-- 			<li> -->
<!-- 				<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 				<span class="td-no">49</span> -->
<!-- 			   	<span>?????????</span> -->
<!-- 			   	<span>NOTICE</span> -->
<!-- 			   	<span class="td-350">Refresh Time</span> -->
<!-- 			   	<span>?????????</span> -->
<!-- 				<span>2019-11-09</span> -->
<!-- 				<span>134</span> -->
<!-- 			   	<span>N</span> -->
<!-- 			   	<span class="open"><b>??????</b></span> -->
<!-- 			</li> -->
		</ul>
		
		
	</div>
	<br>
	<a class="btn btn01" onclick="javascript:delNews();">?????? ??????</a>

</div>

<!-- 
<div class="table-wr">
	<div class="table-list">
		<table>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="checkAll"><label ></label>
					</th>
					<th class="td-no">NO. <img src="/img/th_down.png" /></th>
					<th>?????? <img src="/img/th_down.png" /></th>
					<th>???????????? <img src="/img/th_down.png" /></th>
					<th>?????? <img src="/img/th_down.png" /></th>
					<th>????????? <img src="/img/th_down.png" /></th>
					<th>?????????/????????? <img src="/img/th_down.png" /></th>
					<th>??????<img src="/img/th_down.png" /></th>
					<th>??????<img src="/img/th_down.png" /></th>
					<th>??????</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>?????????</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>?????????</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>??????</span>
				   	</td>
				</tr>
				<tr>
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>?????????</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>?????????</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>??????</span>
				   	</td>
				</tr>
				<tr class="move-tr">
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>?????????</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>?????????</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>??????</span>
				   	</td>
				</tr>
				<tr>
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>?????????</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>?????????</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>??????</span>
				   	</td>
				</tr>
				
				
			</tbody>
		</table>
	</div> <br>
	<a class="btn btn01" href="#">?????? ??????</a>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>
 -->

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>