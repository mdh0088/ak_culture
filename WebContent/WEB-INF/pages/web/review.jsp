<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>

<script>

$(document).ready(function(){
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
});
function getList(paging_type)
{
	getListStart();
	var is_best = "";
	if($('input:checkbox[id="is_best"]').is(':checked'))
	{
		is_best = "Y"
	}
	else
	{
		//is_best = "N";
		is_best = "";
	}
	$.ajax({
		type : "POST", 
		url : "./getReviewList",
		dataType : "text",
		data : 
		{
			page : page,
			order_by : order_by,
			sort_type : sort_type,
			listSize : $("#listSize").val(),
			
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			search_type : $("#search_type").val(),
			search_name : $("#search_name").val(),
			start_ymd : $("#start_ymd").val(),
			end_ymd : $("#end_ymd").val(),
			lecturer_nm : $("#lecturer_nm").val(),
			subject_nm : $("#subject_nm").val(),
			is_reco : $('input[name="is_reco"]:checked').val(),
			is_best : is_best

			
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
					var web_text = result.list[i].WEB_TEXT.split(" ")[1];
					var is_best = "";
					if(result.list[i].BEST_YN == "Y")
					{
						is_best = "BEST 선정";
					}
					var content = nullChk(result.list[i].CONTENT);
					if(content > 20)
					{
						content = result.list[i].CONTENT.substring(0,20) + "..";
					}
					inner += '<tr>';
					inner += '	<td class="td-chk">';
					inner += '		<input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'" name="chk_val" value="">';
					inner += '		<label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+trim(result.list[i].SUBJECT_CD)+'"></label>';
					inner += '	</td>';
					inner += '	<td>'+web_text+'</td>';
					inner += '  <td class="color-blue line-blue text-left">'+result.list[i].SUBJECT_NM+'</td>';
					inner += '  <td class="color-blue line-blue">'+result.list[i].WEB_LECTURER_NM+'</td>';
					inner += '  <td>'+content+'</td>';
					inner += '  <td>'+result.list[i].PTL_ID+'</td>';
					inner += '	<td>'+cutDate(result.list[i].CREATE_DATE)+'</td>';
					inner += '  <td>'+result.list[i].RECO_YN+'</td>';
					inner += '  <td>'+is_best+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="8"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			order_by = result.order_by;
			sort_type = result.sort_type;
			listSize = result.listSize;
			if(paging_type == "scroll")
			{
				if(result.list.length > 0)
				{
					$("#list_target").append(inner);
				}
			}
			else
			{
				$("#list_target").html(inner);
			}
			$(".paging").html(makePaging(result.page, result.s_page, result.e_page, result.pageNum, 1));
			getListEnd();
		}
	});	
}
function bestAction()
{
	var chkList = "";
	$("input:checkbox[name='chk_val']").each(function(){
	    if($(this).is(":checked"))
    	{
    		chkList += $(this).attr("id").replace("chk_", "")+"|";
    	}
	});
	
	$.ajax({
		type : "POST", 
		url : "./bestAction",
		dataType : "text",
		async : false,
		data : 
		{
			chkList : chkList,
			act : $("#best_act").val()
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
    			getList();
    		}
    		else
    		{
	    		alert(result.msg);
    		}
		}
	});	
}
</script>


<div class="sub-tit">
	<h2>수강후기 관리</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
</div>

<div class="table-top ">
	<div class="top-row sear-wr">
		<div class="">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<div class="oddn-sel sel-scr">
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
		</div>
		<div class="wid-4 mag-lr2">
			<div class="search-wr search-wr_div">				
				<select class="" id="search_type" name="search_type" de-data="아이디">
					<option value="user_id">아이디</option>
					<option value="user_name">이름</option>
					<option value="phone">휴대전화번호</option>
					<option value="email">이메일</option>
				</select>
				<input type="text" id="search_name" name="search_name" onkeypress="javascript:pagingReset(); excuteEnter(getList);" placeholder="검색어를 입력하세요.">
				<input class="search-btn" type="button" value="검색" onclick="getList()">
				
			</div>			
		</div>
		<div class="wid-1">
			<div class="table table-auto">
				<div class="sear-tit">BEST 여부</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="is_best" name="is_best" />
							<label for="is_best"></label>
						</li>
						
					</ul>
					
				</div>
			</div>
		</div>
	</div>
	<div class="top-row">
		<div class="wid-35">
			<div class="table">
				<div class="sear-tit sear-tit_90">등록일</div>
				<div>
					<div class="cal-row cal-row02 table">
						<div class="cal-input  ">
							<input type="text" id="start_ymd" name="start_ymd" value="" class="date-i three-i" />
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input ">
							<input type="text" id="end_ymd" name="end_ymd" value="" class="date-i ready-i" />
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
		</div>		
		
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit sear-tit_left">강사명</div>
				<div>
					<input type="text" id="lecturer_nm" name="lecturer_nm" value="" class=" " placeholder="" >
				</div>
			</div>
		</div>
		<div class="wid-2 ">
			<div class="table">
				<div class="sear-tit sear-tit_left">강좌명</div>
				<div>
					<input type="text" id="subject_nm" name="subject_nm" value="" class="inp-80 " placeholder="" >
				</div>
			</div>
		</div>
		
		<div class="wid-3">
			<div class="table">
				<div class="sear-tit sear-tit_90 sear-tit_left">조건</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="radio" id="is_reco1" name="is_reco" value="" checked/>
							<label for="is_reco1">최근 등록순</label>
						</li>
						<li>
							<input type="radio" id="is_reco2" name="is_reco" value="Y" checked/>
							<label for="is_reco2">추천</label>
						</li>
						<li>
							<input type="radio" id="is_reco3" name="is_reco" value="N" checked/>
							<label for="is_reco3">비추천</label>
						</li>
					</ul>
					
				</div>
			</div>
		</div>
		
		
		
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:pagingReset(); getList();">
	
</div>

<div class="table-cap table">
	<div class="cap-l">
		<p class="cap-numb">결과 0개 / 전체 0개</p>
	</div>
	<div class="cap-r text-right">
		<div class="table table-auto float-right verti-mid">
			<div>
				<p class="ip-ritit">선택한 후기를</p>
			</div>
			<div>
				<select de-data="BEST 선정" id="best_act" name="best_act">
					<option value="Y">BEST 선정</option>
					<option value="N">BEST 선정 취소</option>
				</select>
				<a class="bor-btn btn03 btn-mar6" onclick="javascript:bestAction();">반영</a>
			</div>
			<div class="sel-scr">
				<select id="listSize" name="listSize" onchange="getList()" de-data="10개 보기">
					<option value="10">10개 보기</option>
					<option value="20">20개 보기</option>
					<option value="50">50개 보기</option>
					<option value="100">100개 보기</option>
					<option value="300">300개 보기</option>
					<option value="500">500개 보기</option>
					<option value="1000">1000개 보기</option>
				</select>
			</div>
		</div>
		
		
	</div>
	
</div>

<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="40px">
				<col width="80px">
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col">
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_web_text')">학기<img src="/img/th_up.png" id="sort_web_text"></th>
					<th onclick="reSortAjax('sort_subject_nm')" class="td-220">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_web_text')">강사명<img src="/img/th_up.png" id="sort_web_text"></th>
					<th onclick="reSortAjax('sort_content')" class="td-220">내용<img src="/img/th_up.png" id="sort_content"></th>
					<th onclick="reSortAjax('sort_ptl_id')">작성자<img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th onclick="reSortAjax('sort_create_date')">등록일<img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_reco_yn')">추천여부<img src="/img/th_up.png" id="sort_reco_yn"></th>
					<th onclick="reSortAjax('sort_best_yn')">당첨<img src="/img/th_up.png" id="sort_best_yn"></th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list">
		<table>
			<colgroup>
				<col width="40px">
				<col width="80px">
				<col width="400px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col">
			</colgroup>
			<thead>
				<tr>					
					<th class="td-chk">
						<input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label>
					</th>
					<th onclick="reSortAjax('sort_web_text')">학기<img src="/img/th_up.png" id="sort_web_text"></th>
					<th onclick="reSortAjax('sort_subject_nm')" class="td-220">강좌명<img src="/img/th_up.png" id="sort_subject_nm"></th>
					<th onclick="reSortAjax('sort_web_text')">강사명<img src="/img/th_up.png" id="sort_web_text"></th>
					<th onclick="reSortAjax('sort_content')" class="td-220">내용<img src="/img/th_up.png" id="sort_content"></th>
					<th onclick="reSortAjax('sort_ptl_id')">작성자<img src="/img/th_up.png" id="sort_ptl_id"></th>
					<th onclick="reSortAjax('sort_create_date')">등록일<img src="/img/th_up.png" id="sort_create_date"></th>
					<th onclick="reSortAjax('sort_reco_yn')">추천여부<img src="/img/th_up.png" id="sort_reco_yn"></th>
					<th onclick="reSortAjax('sort_best_yn')">당첨<img src="/img/th_up.png" id="sort_best_yn"></th>
				</tr>
			</thead>
			<tbody id="list_target">
<!-- 				<tr> -->
<!-- 					<td>봄학기</td> -->
<!-- 				   	<td class="color-blue line-blue text-left">1회 오레아 오감 통합놀이</td> -->
<!-- 				   	<td class="color-blue line-blue">오윤희</td> -->
<!-- 				   	<td>1회 체험해봤어요 ~</td> -->
<!-- 				   	<td>mj8404</td> -->
<!-- 					<td>2019-11-09</td> -->
<!-- 				   	<td>N</td> -->
<!-- 				   	<td>BEST 선정</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>겨울학기</td> -->
<!-- 				   	<td class="color-blue line-blue text-left">1회 오레아 오감 통합놀이</td> -->
<!-- 				   	<td class="color-blue line-blue">오윤희</td> -->
<!-- 				   	<td>1회 체험해봤어요 ~</td> -->
<!-- 				   	<td>mj8404</td> -->
<!-- 					<td>2019-11-09</td> -->
<!-- 				   	<td>N</td> -->
<!-- 				   	<td>BEST 선정</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>가을학기</td> -->
<!-- 				   	<td class="color-blue line-blue text-left">1회 오레아 오감 통합놀이</td> -->
<!-- 				   	<td class="color-blue line-blue">오윤희</td> -->
<!-- 				   	<td>1회 체험해봤어요 ~</td> -->
<!-- 				   	<td>mj8404</td> -->
<!-- 					<td>2019-11-09</td> -->
<!-- 				   	<td>N</td> -->
<!-- 				   	<td>BEST 선정</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>여름학기</td> -->
<!-- 				   	<td class="color-blue line-blue text-left">1회 오레아 오감 통합놀이</td> -->
<!-- 				   	<td class="color-blue line-blue">오윤희</td> -->
<!-- 				   	<td>1회 체험해봤어요 ~</td> -->
<!-- 				   	<td>mj8404</td> -->
<!-- 					<td>2019-11-09</td> -->
<!-- 				   	<td>Y</td> -->
<!-- 				   	<td></td> -->
<!-- 				</tr> -->
				
			</tbody>
		</table>
	</div>
	
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>
<script>
$(document).ready(function(){
	getList();
});
</script>
<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>