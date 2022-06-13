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
			$(".cap-numb").html("결과 "+result.listCnt+" / 전체"+result.listCnt_all+"개");
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
					inner += '	<span class="open"><a href="./academy_upload?seq='+result.list[i].SEQ+'"><b>수정</b></a></span>';
					inner += '</li>';
				}
			}
			else
			{
				inner += '<li>';
				inner += '검색결과가 없습니다.';
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
		alert("선택된 항목이 없습니다.");
		return;
	}
	
	if(confirm("정말 삭제하시겠습니까?"))
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
			type : "GET", //전송방식을 지정한다 (POST,GET)
			url : "./sortNews?sort="+i+"&seq="+seq,//호출 URL을 설정한다. GET방식일경우 뒤에 파라티터를 붙여서 사용해도된다.
			dataType : "text",//호출한 페이지의 형식이다. xml,json,html,text등의 여러 방식을 사용할 수 있다.
			async:false,
			error : function() 
			{
				alert("통신 중 오류가 발생하였습니다.");
			},
			success : function(data) 
			{
				
			}
		});
	}
	alert("저장되었습니다.");
}
</script>

<div class="sub-tit">
	<h2>아카데미 뉴스</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<A class="btn btn01 btn01_1" href="/web/academy_upload"><i class="material-icons">add</i> 게시글 등록 </A>
	</div>
</div>

<div class="table-top ">

	<div class="table">
		<div class="wid-6">
			<div class="table">
				<div class="search-wr search-wr_div">				
					<select class="wid-10" id="search_type" name="search_type" de-data="검색항목">
						<option value="">검색항목</option>
						<option value="내용">내용</option>
						<option value="제목">제목</option>
					</select>
					<div class="search-wr_div02 sear-6">					
					    <input type="text" class="inp-100" id="search_name" name="search_name" onkeypress="excuteEnter(getList)" placeholder="검색어를 입력해주세요.">
					    <input class="search-btn" type="button" value="검색" onclick="getList();">
					</div>
				</div>
				
			</div>
		</div>
		<div class="wid-4">
			<div class="table">
				<div class="sear-tit">카테고리</div>
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
					<select class="wid-10" id="search_date_type" name="search_date_type" de-data="등록일">
						<option value="등록일">등록일</option>
						<option value="수정일">수정일</option>
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
				<div class="sear-tit sear-tit_90">지점</div>
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
		<p class="cap-numb">결과 0개 / 전체 0개</p>
	</div>
	<div class="cap-r text-right">
		<div class="table float-right">
			<div class="sel-scr">
				<a class="btn btn03" onclick="javascript:setSort();">순서 저장하기</a>
				<!-- <a class="btn btn01" href="#"><i class="material-icons">import_export</i>ASC</a>
				<a class="bor-btn btn01 mrg-l6" href="#"><i class="fas fa-file-download"></i></a> -->
<!-- 				<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기"> -->
<!-- 					<option value="10">10개 보기</option> -->
<!-- 					<option value="20">20개 보기</option> -->
<!-- 					<option value="50">50개 보기</option> -->
<!-- 					<option value="100">100개 보기</option> -->
<!-- 					<option value="300">300개 보기</option> -->
<!-- 					<option value="500">500개 보기</option> -->
<!-- 					<option value="1000">1000개 보기</option> -->
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
				<span>지점 </span>
				<span>카테고리 </span>
				<span class="tdwid-450">제목 </span>
				<span>작성자 </span>
				<span>등록일/수정일 </span>
				<span>조회</span>
				<span>출력</span>
				<span>관리</span>
			</li>
		</ul>
		<ul class="ul10 sortable" id="target">
<!-- 			<li> -->
<!-- 				<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 				<span class="td-no">49</span> -->
<!-- 			   	<span>분당점</span> -->
<!-- 			   	<span>NOTICE</span> -->
<!-- 			   	<span class="td-350">Refresh Time</span> -->
<!-- 			   	<span>이강준</span> -->
<!-- 				<span>2019-11-09</span> -->
<!-- 				<span>134</span> -->
<!-- 			   	<span>N</span> -->
<!-- 			   	<span class="open"><b>수정</b></span> -->
<!-- 			</li> -->
<!-- 			<li class="move-tr"> -->
<!-- 				<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 				<span class="td-no">49</span> -->
<!-- 			   	<span>분당점</span> -->
<!-- 			   	<span>NOTICE</span> -->
<!-- 			   	<span class="td-350">Refresh Time</span> -->
<!-- 			   	<span>이강준</span> -->
<!-- 				<span>2019-11-09</span> -->
<!-- 				<span>134</span> -->
<!-- 			   	<span>N</span> -->
<!-- 			   	<span class="open"><b>수정</b></span> -->
<!-- 			</li> -->
			
<!-- 			<li> -->
<!-- 				<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 				<span class="td-no">49</span> -->
<!-- 			   	<span>분당점</span> -->
<!-- 			   	<span>NOTICE</span> -->
<!-- 			   	<span class="td-350">Refresh Time</span> -->
<!-- 			   	<span>이강준</span> -->
<!-- 				<span>2019-11-09</span> -->
<!-- 				<span>134</span> -->
<!-- 			   	<span>N</span> -->
<!-- 			   	<span class="open"><b>수정</b></span> -->
<!-- 			</li> -->
		</ul>
		
		
	</div>
	<br>
	<a class="btn btn01" onclick="javascript:delNews();">선택 삭제</a>

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
					<th>지점 <img src="/img/th_down.png" /></th>
					<th>카테고리 <img src="/img/th_down.png" /></th>
					<th>제목 <img src="/img/th_down.png" /></th>
					<th>작성자 <img src="/img/th_down.png" /></th>
					<th>등록일/수정일 <img src="/img/th_down.png" /></th>
					<th>조회<img src="/img/th_down.png" /></th>
					<th>출력<img src="/img/th_down.png" /></th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>분당점</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>이강준</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>수정</span>
				   	</td>
				</tr>
				<tr>
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>분당점</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>이강준</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>수정</span>
				   	</td>
				</tr>
				<tr class="move-tr">
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>분당점</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>이강준</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>수정</span>
				   	</td>
				</tr>
				<tr>
					<td class="td-chk">
						<input type="checkbox" name="idx1"><label></label>
					</td>
					<td>49</td>
				   	<td>분당점</td>
				   	<td>NOTICE</td>
				   	<td>Refresh Time</td>
				   	<td>이강준</td>
					<td>2019-11-09</td>
					<td>134</td>
				   	<td>N</td>
				   	<td class="open">
				   		<span>수정</span>
				   	</td>
				</tr>
				
				
			</tbody>
		</table>
	</div> <br>
	<a class="btn btn01" href="#">선택 삭제</a>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>
 -->

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>