<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script>
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
$(document).ready(function(){
	$("#selBranch").val(login_rep_store);
	$(".selBranch").html(login_rep_store_nm);
	$( ".sortable" ).sortable();
    $( ".sortable" ).disableSelection();
	fncPeri();
})
function setSort()
{
	for(var i = 0; i<document.getElementsByName('seqs').length; i++)
	{
		var seq = document.getElementsByName('seqs')[i].getAttribute('id').replace("seq_", "")
		$.ajax({
			type : "GET", //전송방식을 지정한다 (POST,GET)
			url : "./sortReco?sort="+i+"&seq="+seq,//호출 URL을 설정한다. GET방식일경우 뒤에 파라티터를 붙여서 사용해도된다.
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
	location.reload();
}
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
	var chkShow = "";
	$("[name='is_show']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkShow += '\''+$(this).val()+"\',";
		}
	});
	$.ajax({
		type : "POST", 
		url : "./getRecoList",
		dataType : "text",
		data : 
		{
			search_store : $("#selBranch").val(),
			search_period : $("#selPeri").val(),
			search_tag : $("#selTag").val(),
			search_date_type : $("#search_date_type").val(),
			search_start : $("#search_start").val(),
			search_end : $("#search_end").val(),
			search_show : chkShow
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
					inner += '	<ul class="ul15">';
					inner += '		<li class="tr-bor">';
					inner += '			<input type="hidden" id="seq_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'" name="seqs">';
					inner += '			<span class="tdwid-20"><input type="checkbox" id="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'" name="chk_val" value=""><label for="chk_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'"></label></span>';
					inner += '			<span class="tdwid-20">'+(nullChkZero(result.list[i].SORT)+1)+'</span>';
					inner += '			<span class="tdwid-40">'+result.list[i].STORE_NM+'</span>';
					inner += '			<span class="tdwid-80">'+result.list[i].SUBJECT_FG+'</span>';
					if(nullChk(result.list[i].START_YMD) != "" && nullChk(result.list[i].END_YMD) != "")
					{
						inner += '			<span class="tdwid-140">'+cutDate(result.list[i].START_YMD)+' ~'+cutDate(result.list[i].END_YMD)+'</span>';
					}
					else
					{
						inner += '			<span class="tdwid-140">노출기간이 지정되지않았습니다.</span>';
					}
					inner += '			<span class="tdwid-400">'+result.list[i].SUBJECT_NM+'</span>';
					inner += '			<span class="tdwid-140">'+cutDate(result.list[i].PELT_START_YMD)+' ~'+cutDate(result.list[i].PELT_END_YMD)+'</span>';
					inner += '			<span class="">'+result.list[i].WEB_LECTURER_NM+'</span>';
					inner += '			<span class="tdwid-80">'+cutLectHour(result.list[i].LECT_HOUR)+'</span>';
					inner += '			<span>'+cutYoil(result.list[i].DAY_FLAG)+'</span>';
					inner += '			<span>'+result.list[i].END_STATE+'</span>';
					inner += '			<span>'+comma(nullChkZero(result.list[i].FOOD_AMT))+'</span>';
					inner += '			<span>'+comma(nullChkZero(result.list[i].REGIS_FEE))+'</span>';
					inner += '			<span>'+nullChk(result.list[i].IS_SHOW)+'</span>';
					inner += '			<span class="open tdwid-80"><b onclick="javascript:viewReco(\''+encodeURI(JSON.stringify(result.list[i]))+'\')">수정</b></span>';
					inner += '		</li>';
					inner += '		<li class="tr-tag">';
					inner += '			<div>';
					inner += '				<span class="tag-btn" onclick="javascript:insTagByReco(\''+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'\')"><i class="material-icons">add</i>태그등록</span>';
					inner += '				<input type="text" id="tag_'+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'" placeholder="태그를 입력해 주세요. Enter 키를 통해 태그를 연속으로 입력할 수 있습니다. (최대 10개)" onkeypress="excuteEnter_param(insTagByReco, \''+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'\')" style="width:90%;">';						
					inner += '			</div>';
					inner += '			<div class="tag-plus">';
					if(nullChk(result.list[i].TAG) != "")
					{
						var tagArr = result.list[i].TAG.split("|");
						for(var z = 0; z < tagArr.length-1; z++)
						{
							inner += '			<span style="cursor:auto;">#'+tagArr[z]+'<i class="far fa-window-close" onclick="javascript:delTagByReco(\''+result.list[i].STORE+'_'+result.list[i].PERIOD+'_'+result.list[i].SUBJECT_CD+'_'+tagArr[z]+'\')"></i></span>';
						}
					}
					inner += '			</div>';
					inner += '		</li>';
					inner += '	</ul>';
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
function viewReco(ret)
{
	$('#retou_layer').fadeIn(200);
	var result = JSON.parse(decodeURI(ret));
	var inner = "";
	inner += '<tr>';
	inner += '	<td>'+result.SUBJECT_NM+'</td>';
	inner += '	<td>'+result.WEB_LECTURER_NM+'</td>';
	inner += '	<td><div><div class="cal-row cal-row02 table"><div class="cal-input"><input type="text" id="start_ymd" name="start_ymd" value="'+nullChk(cutDate(result.START_YMD))+'" class="date-i" /><i class="material-icons">event_available</i></div><div class="cal-dash">-</div>';
	inner += '	<div class="cal-input"><input type="text" id="end_ymd" name="end_ymd" value="'+nullChk(cutDate(result.END_YMD))+'" class="date-i" /><i class="material-icons">event_available</i></div></div></div></td>';
	inner += '	<td class="plan-onof">';
	inner += '		<select class="wid-5" id="change_show" name="change_show" de-data="'+result.IS_SHOW+'">';
	inner += '			<option value="Y">Y</option>';
	inner += '			<option value="N">N</option>';
	inner += '		</select>';
	inner += '	</td>'; 				
	inner += '</tr>';
	$("#target_tbody").html(inner);
	
	$("#store").val(result.STORE);
	$("#period").val(result.PERIOD);
	$("#subject_cd").val(result.SUBJECT_CD);
	
	selectInit_one("change_show");
	$("#change_show").val(result.IS_SHOW);
	$(".change_show").html(result.IS_SHOW);
	
	dateInit();
	thSize();
	
	
}
function fncSubmit()
{
	$("#fncForm").ajaxSubmit({
		success: function(data)
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
function delReco()
{
	var chkSeq = "";
	$("[name='chk_val']").each(function() 
	{
		if( $(this).prop("checked")==true )
		{
			chkSeq += $(this).attr("id").replace("chk_", "")+",";
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
			url : "./delReco",
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
function insTagByReco(val)
{
	var store = val.split("_")[0];
	var period = val.split("_")[1];
	var subject_cd = val.split("_")[2];
	
	if($("#tag_"+store+"_"+period+"_"+subject_cd).val() == "")
	{
		alert("태그명을 입력해주세요.");
		return;
	}
	$.ajax({
		type : "POST", 
		url : "./insTagByReco",
		dataType : "text",
		data : 
		{
			store : store,
			period : period,
			subject_cd : subject_cd,
			tag : $("#tag_"+store+"_"+period+"_"+subject_cd).val()
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
function delTagByReco(val)
{
	var store = val.split("_")[0];
	var period = val.split("_")[1];
	var subject_cd = val.split("_")[2];
	var tag = val.split("_")[3];
	
	$.ajax({
		type : "POST", 
		url : "./delTagByReco",
		dataType : "text",
		data : 
		{
			store : store,
			period : period,
			subject_cd : subject_cd,
			tag : tag
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
function lecture()
{
	$('#search_layer').fadeIn(200);	
	thSize();
}
$(window).ready(function(){
	
})
function selMainCd(code)
{
	$.ajax({
		type : "POST", 
		url : "/common/getSecCd",
		dataType : "text",
		data : 
		{
			maincd : code,
			selBranch : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			var inner ="";
			if(result.length > 0)
			{
				inner="";
				for (var i = 0; i < result.length; i++) 
				{
					inner += '<li onclick="selSectCd(\''+result[i].MAIN_CD+'\', \''+result[i].SECT_CD+'\')">'+result[i].SECT_NM+'</li>';
				}
			}
			else
			{
				
			}
			$(".sect_ul").html(inner);
		}
	});	
}
function selSectCd(maincd, sectcd)
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeltBySect",
		dataType : "text",
		data : 
		{
			maincd : maincd,
			sectcd : sectcd,
			store : $("#selBranch").val(),
			period : $("#selPeri").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result = JSON.parse(data);
			
			var inner = "";
			if(result.length > 0)
			{
				for(var i = 0; i< result.length; i++)
				{
					inner += '<li onclick="selPeltCd(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
					inner += '	<div class="tit">'+result[i].SUBJECT_NM+'</div>';
					inner += '	<div class="date">'+cutYoil(result[i].DAY_FLAG)+' '+cutLectHour(result[i].LECT_HOUR)+'/'+result[i].WEB_LECTURER_NM+'</div>';
					inner += '</li>';
				}
			}
			else
			{
				inner += '<li>';
				inner += '	검색결과가 없습니다.';
				inner += '</li>';
			}
			
			$(".pelt_ul").html(inner);
			
		}
	});	
}
function selPeltCd(ret)
{
	var result = JSON.parse(decodeURI(ret));	
	var inner = "";
	if(!document.getElementById("tr_"+trim(result.SUBJECT_CD)))
	{
		inner += '<tr id="tr_'+trim(result.SUBJECT_CD)+'">';
		inner += '	<td class="td-chk">';
		inner += '		<input type="checkbox" id="pelt_'+trim(result.SUBJECT_CD)+'" name="chk_pelt_list"><label for="pelt_'+trim(result.SUBJECT_CD)+'"></label>';
		inner += '	</td>';
		inner += '	<td>'+result.SUBJECT_NM+'</td>';
		inner += '	<td>'+result.WEB_LECTURER_NM+'</td>';
		inner += '	<td>'+cutYoil(result.DAY_FLAG)+'</td>';
		inner += '	<td>'+cutLectHour(result.LECT_HOUR)+'</td>';
		inner += '</tr>';
		
		$(".selLectTable").append(inner);
		chk_pelt_init();
	}
	else
	{
		alert("이미 등록되었습니다.");
	}
}
function chk_pelt_init()
{
	$("#chk_pelt").change(function() {
		if($("input:checkbox[name='chk_pelt']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_pelt").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_pelt").val()+"']").prop("checked", false);
		}
	});
}

function peltTrAct(act)
{
	var subject_arr = "";
	$("input:checkbox[name='chk_pelt_list']").each(function(){
	    if($(this).is(":checked"))
    	{
    		var subCd = $(this).attr("id").replace("pelt_", "");
			if(act == 'del')
			{
				$("#tr_"+subCd).remove();
			}
			else
			{
				if(subject_arr.indexOf(subCd) == -1)
				{
					subject_arr += subCd+"|";
				}
			}
    	}
	});
	if(act != 'del')
	{
		if(subject_arr == "")
		{
			alert("선택된 강좌가 없습니다.");
			return;
		}
		else
		{
			$.ajax({
				type : "POST", 
				url : "./insRecomLect",
				dataType : "text",
				async : false,
				data :
				{
					store : $("#selBranch").val(),
					period : $("#selPeri").val(),
					subject_arr : subject_arr
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
		    		}
		    		else
		    		{
			    		alert(result.msg);
		    		}
					
				}
			});
			$('#search_layer').fadeOut(200);	
			getList();
		}
	}
}
</script>
<div class="sub-tit">
	<h2>추천 강좌 리스트</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<A class="btn btn01 btn01_1" onclick="javascript:lecture()"><i class="material-icons">add</i>추천강좌 등록 </A>
	</div>
</div>
	
<div class="table-top table-top02">
	<div class="table">		
		<div class="wid-3">
			<div class="table table-auto">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<div class="oddn-sel02">
				<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
			</div>
		</div>
		<div class="wid-15">		
			<div class="table margin-auto">				
				<div class="sear-tit sear-tit_70">태그</div>
				<div>
					<div class="select">
						<select id="selTag" name="selTag" de-data="전체">
							<option value="">전체</option>
							<c:forEach items="${fn:split(tagList, ',') }" var="item">
							    <option value="${item}">${item}</option>
							</c:forEach>
						</select>
					</div>
				</div>				
			</div>
		</div>
		<div class="wid-35">
			<div class="table table02 table-90">
				<div>
					<select class="wid-10" id="search_date_type" name="search_date_type" de-data="등록일">
						<option value="등록일">등록일</option>
						<option value="수정일">수정일</option>
					</select>
				</div>
				<div>
					<div class="cal-row table table-auto">
						<div class="cal-input  cal-input_170">
							<input type="text" id="search_start" name="search_start" value="" class="date-i three-i" />
							<i class="material-icons">event_available</i>
						</div>
						<div class="cal-dash">-</div>
						<div class="cal-input cal-input_170">
							<input type="text" id="search_end" name="search_end" value="" class="date-i ready-i" />
							<i class="material-icons">event_available</i>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="wid-15">
			<div class="table">
				<div class="sear-tit">노출 여부</div>
				<div>
					<ul class="chk-ul">
						<li>
							<input type="checkbox" id="is_show1" name="is_show" value="Y" />
							<label for="is_show1">Y</label>
						</li>
						<li>
							<input type="checkbox" id="is_show2" name="is_show" value="N" />
							<label for="is_show2">N</label>
						</li>
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
<!-- 				<a class="btn btn01" href="#">화면 미리보기</a> -->
				<a class="btn btn03" onclick="javascript:setSort();">순서 저장하기</a>
				<a class="btn btn01" onclick="javascript:delReco();">선택 삭제</a>
				<!-- <a class="bor-btn btn01 mrg-l6" href="#"><i class="fas fa-file-download"></i></a> -->
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

<div class="table-dragwr table-dragwr02">
	<div class="table-inner">
	
		<ul class="ul15">
			<li class="table-th">
				<span class="tdwid-20"><input type="checkbox" id="chk_all" name="chk_all" value="chk_val"><label for="chk_all"></label></span>
				<span class="tdwid-20">NO</span>
				<span class="tdwid-40">지점</span>
				<span class="tdwid-80">강좌유형</span>
				<span class="tdwid-140">노출기간</span>
				<span class="tdwid-400">강좌명</span>
				<span class="tdwid-140">강좌일정</span>
				<span>강사명</span>
				<span class="tdwid-80">시간</span>
				<span>요일</span>
				<span>상태</span>
				<span>재료비</span>
				<span>수강료</span>
				<span>노출</span>
				<span class="tdwid-80">관리</span>	
			</li>
		</ul>
		<ul class="ul9 sortable" id="target">
<!-- 			<li> -->
<!-- 				<ul class="ul15"> -->
<!-- 					<li class="tr-bor"> -->
<!-- 						<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 						<span class="td-40">45</span> -->
<!-- 						<span>분당점</span> -->
<!-- 						<span class="td-80">정규</span> -->
<!-- 						<span><img src="/img/img insert.png" /></span> -->
<!-- 						<span class="td-170">사진 촬영 고급 기법 클래스</span> -->
<!-- 						<span class="td-140">2019-10-16 ~ 2019-10-16</span> -->
<!-- 						<span>강민영</span> -->
<!-- 						<span class="td-80">10:30 ~ 11:500</span> -->
<!-- 						<span>목</span> -->
<!-- 						<span>모집중</span> -->
<!-- 						<span>0</span> -->
<!-- 						<span>90,000</span> -->
<!-- 						<span>Y</span> -->
<!-- 						<span class="open"><b onclick="javascript:retouch()">수정</b></span> -->
<!-- 					</li> -->
<!-- 					<li class="tr-tag"> -->
<!-- 						<div> -->
<!-- 							<span class="tag-btn"><i class="material-icons">add</i>태그등록</span> -->
<!-- 							<span class="tag-txt">태그를 입력해 주세요. 쉼표(,) 또는 Enter 키를 통해 태그를 연속으로 입력할 수 있습니다. (최대 10개)</span>						 -->
<!-- 						</div> -->
<!-- 					</li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
			
<!-- 			<li> -->
<!-- 				<ul class="ul15"> -->
<!-- 					<li class="tr-bor"> -->
<!-- 						<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 						<span class="td-40">45</span> -->
<!-- 						<span>분당점</span> -->
<!-- 						<span class="td-80">정규</span> -->
<!-- 						<span><img src="/img/img insert.png" /></span> -->
<!-- 						<span class="td-170">사진 촬영 고급 기법 클래스</span> -->
<!-- 						<span class="td-140">2019-10-16 ~ 2019-10-16</span> -->
<!-- 						<span>강민영</span> -->
<!-- 						<span class="td-80">10:30 ~ 11:500</span> -->
<!-- 						<span>목</span> -->
<!-- 						<span>모집중</span> -->
<!-- 						<span>0</span> -->
<!-- 						<span>90,000</span> -->
<!-- 						<span>Y</span> -->
<!-- 						<span class="open"><b onclick="javascript:retouch()">수정</b></span> -->
<!-- 					</li> -->
<!-- 					<li class="tr-tag"> -->
<!-- 						<div> -->
<!-- 							<span class="tag-btn"><i class="material-icons">add</i>태그등록</span> -->
<!-- 							<span class="tag-txt">태그를 입력해 주세요. 쉼표(,) 또는 Enter 키를 통해 태그를 연속으로 입력할 수 있습니다. (최대 10개)</span>						 -->
<!-- 						</div> -->
<!-- 						<div class="tag-plus"><span>#성인<i class="far fa-window-close"></i></span><span>#취미/공예</span><span>#촬영기법</span></div> -->
<!-- 					</li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
			
<!-- 			<li class="move-tr"> -->
<!-- 				<ul class="ul15"> -->
<!-- 					<li class="tr-bor"> -->
<!-- 						<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 						<span class="td-40">45</span> -->
<!-- 						<span>분당점</span> -->
<!-- 						<span class="td-80">정규</span> -->
<!-- 						<span><img src="/img/img insert.png" /></span> -->
<!-- 						<span class="td-170">사진 촬영 고급 기법 클래스</span> -->
<!-- 						<span class="td-140">2019-10-16 ~ 2019-10-16</span> -->
<!-- 						<span>강민영</span> -->
<!-- 						<span class="td-80">10:30 ~ 11:500</span> -->
<!-- 						<span>목</span> -->
<!-- 						<span>모집중</span> -->
<!-- 						<span>0</span> -->
<!-- 						<span>90,000</span> -->
<!-- 						<span>Y</span> -->
<!-- 						<span class="open"><b onclick="javascript:retouch()">수정</b></span> -->
<!-- 					</li> -->
<!-- 					<li class="tr-tag"> -->
<!-- 						<div> -->
<!-- 							<span class="tag-btn"><i class="material-icons">add</i>태그등록</span> -->
<!-- 							<span class="tag-txt">태그를 입력해 주세요. 쉼표(,) 또는 Enter 키를 통해 태그를 연속으로 입력할 수 있습니다. (최대 10개)</span>						 -->
<!-- 						</div> -->
<!-- 						<div class="tag-plus"><span>#성인<i class="far fa-window-close"></i></span><span>#취미/공예</span><span>#촬영기법</span></div> -->
<!-- 					</li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
			
<!-- 			<li> -->
<!-- 				<ul class="ul15"> -->
<!-- 					<li class="tr-bor"> -->
<!-- 						<span class="td-chk"><input type="checkbox" name="idx1"><label></label></span> -->
<!-- 						<span class="td-40">45</span> -->
<!-- 						<span>분당점</span> -->
<!-- 						<span class="td-80">정규</span> -->
<!-- 						<span><img src="/img/web-sample.png" /></span> -->
<!-- 						<span class="td-170">사진 촬영 고급 기법 클래스</span> -->
<!-- 						<span class="td-140">2019-10-16 ~ 2019-10-16</span> -->
<!-- 						<span>강민영</span> -->
<!-- 						<span class="td-80">10:30 ~ 11:500</span> -->
<!-- 						<span>목</span> -->
<!-- 						<span>모집중</span> -->
<!-- 						<span>0</span> -->
<!-- 						<span>90,000</span> -->
<!-- 						<span>Y</span> -->
<!-- 						<span class="open"><b onclick="javascript:retouch()">수정</b></span> -->
<!-- 					</li> -->
<!-- 					<li class="tr-tag"> -->
<!-- 						<div> -->
<!-- 							<div class="tag-btn"><i class="material-icons">add</i>태그등록</div> -->
<!-- 							<div class="tag-plus"><span>#성인</span><span>#취미/공예</span><span>#촬영기법</span></div>						 -->
<!-- 						</div> -->
<!-- 					</li> -->
<!-- 				</ul> -->
<!-- 			</li> -->
			
		</ul>
		
		
	</div>
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>

</div>

<!-- 
<div class="table-wr ip-list">
	
	<div class="table-list table-stlist" >
		<table>
			<thead>
				<tr>
					<th class="td-chk">
						<input type="checkbox" id="checkAll"><label ></label>
					</th>
					<th class="td-40">NO</th>
					<th>지점</th>
					<th class="td-80">강좌유형</th>
					<th>이미지</th>
					<th class="td-170">강좌명</th>
					<th class="td-140">기간</th>
					<th>강사명</th>
					<th class="td-80">시간</th>
					<th>요일</th>
					<th>상태</th>
					<th>재료비</th>
					<th>수강료</th>
					<th>노출</th>
					<th>관리</th>		
				</tr>	
			</thead>
			
			<tbody>
				<tr class="tr-wlect">
					<td colspan="15">
						<table>
							<tr class="tr-bor">
								<td class="td-chk">
									<input type="checkbox" name="idx1"><label></label>
								</td>
								<td class="td-40">45</td>
								<td>분당점</td>
								<td class="td-80">정규</td>
								<td><img src="/img/img insert.png" /></td>
								<td class="td-170">사진 촬영 고급 기법 클래스</td>
								<td class="td-140">2019-10-16 ~ 2019-10-16</td>
								<td>강민영</td>
								<td class="td-80">10:30 ~ 11:500</td>
								<td>목</td>
								<td>모집중</td>
								<td>0</td>
								<td>90,000</td>
								<td>Y</td>
								<td class="open">
							   		<span onclick="javascript:retouch()">수정</span>
							   	</td>
							</tr>
							<tr class="tr-tag">
								<td colspan="15">
									<div class="tag-btn"><i class="material-icons">add</i>태그등록</div>
									<div class="tag-txt">태그를 입력해 주세요. 쉼표(,) 또는 Enter 키를 통해 태그를 연속으로 입력할 수 있습니다. (최대 10개)</div>						
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr class="tr-wlect">
					<td colspan="15">
						<table>
							<tr class="tr-bor">
								<td class="td-chk">
									<input type="checkbox" name="idx1"><label></label>
								</td>
								<td class="td-40">45</td>
								<td>분당점</td>
								<td class="td-80">정규</td>
								<td><img src="/img/img insert.png" /></td>
								<td class="td-170">사진 촬영 고급 기법 클래스</td>
								<td class="td-140">2019-10-16 ~ 2019-10-16</td>
								<td>강민영</td>
								<td class="td-80">10:30 ~ 11:500</td>
								<td>목</td>
								<td>모집중</td>
								<td>0</td>
								<td>90,000</td>
								<td>Y</td>
								<td class="open">
							   		<span onclick="javascript:retouch()">수정</span>
							   	</td>
							</tr>
							<tr class="tr-tag">
								<td colspan="15">
									<div class="tag-btn"><i class="material-icons">add</i>태그등록</div>
									<div class="tag-txt">태그를 입력해 주세요. 쉼표(,) 또는 Enter 키를 통해 태그를 연속으로 입력할 수 있습니다. (최대 10개)</div>						
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr class="tr-wlect">
					<td colspan="15">
						<table>
							<tr class="tr-bor">
								<td class="td-chk">
									<input type="checkbox" name="idx1"><label></label>
								</td>
								<td class="td-40">45</td>
								<td>분당점</td>
								<td class="td-80">정규</td>
								<td><img src="/img/web-sample.png" /></td>
								<td class="td-170">사진 촬영 고급 기법 클래스</td>
								<td class="td-140">2019-10-16 ~ 2019-10-16</td>
								<td>강민영</td>
								<td class="td-80">10:30 ~ 11:500</td>
								<td>목</td>
								<td>모집중</td>
								<td>0</td>
								<td>90,000</td>
								<td>Y</td>
								<td class="open">
							   		<span onclick="javascript:retouch()">수정</span>
							   	</td>
							</tr>
							<tr class="tr-tag">
								<td colspan="15">
									<div class="tag-btn"><i class="material-icons">add</i>태그등록</div>						
									<div class="tag-plus"><span>#성인</span><span>#취미/공예</span></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr class="tr-wlect move-tr">
					<td colspan="15">
						<table>
							<tr class="tr-bor">
								<td class="td-chk">
									<input type="checkbox" name="idx1"><label></label>
								</td>
								<td class="td-40">45</td>
								<td>분당점</td>
								<td class="td-80">정규</td>
								<td><img src="/img/web-sample.png" /></td>
								<td class="td-170">사진 촬영 고급 기법 클래스</td>
								<td class="td-140">2019-10-16 ~ 2019-10-16</td>
								<td>강민영</td>
								<td class="td-80">10:30 ~ 11:500</td>
								<td>목</td>
								<td>모집중</td>
								<td>0</td>
								<td>90,000</td>
								<td>Y</td>
								<td class="open">
							   		<span onclick="javascript:retouch()">수정</span>
							   	</td>
							</tr>
							<tr class="tr-tag">
								<td colspan="15">
									<div class="tag-btn"><i class="material-icons">add</i>태그등록</div>						
									<div class="tag-plus"><span>#성인</span><span>#취미/공예</span><span>#촬영기법</span></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
				<tr class="tr-wlect">
					<td colspan="15">
						<table>
							<tr class="tr-bor">
								<td class="td-chk">
									<input type="checkbox" name="idx1"><label></label>
								</td>
								<td class="td-40">45</td>
								<td>분당점</td>
								<td class="td-80">정규</td>
								<td><img src="/img/web-sample.png" /></td>
								<td class="td-170">사진 촬영 고급 기법 클래스</td>
								<td class="td-140">2019-10-16 ~ 2019-10-16</td>
								<td>강민영</td>
								<td class="td-80">10:30 ~ 11:500</td>
								<td>목</td>
								<td>모집중</td>
								<td>0</td>
								<td>90,000</td>
								<td>Y</td>
								<td class="open">
							   		<span onclick="javascript:retouch()">수정</span>
							   	</td>
							</tr>
							<tr class="tr-tag">
								<td colspan="15">
									<div class="tag-btn"><i class="material-icons">add</i>태그등록</div>						
									<div class="tag-plus"><span>#성인</span><span>#취미/공예</span></div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				
			</tbody>
		</table>
	</div> <br>
	
	<jsp:include page="/WEB-INF/pages/common/paging_new.jsp"/>
</div>
			
 -->

<div id="search_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg edit-scroll">
        		<div class="close" onclick="javascript:$('#search_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3>강좌검색</h3>
        			<!-- 
        			<div class="table-top bg01">
        				<div class="table">        					
        					<div class="wid-25">
        						<div class="table table-90">
	        						<div class="sear-tit sear-tit_70">강좌코드</div>
	        						<div>
	        							<input type="text"  class="" >
	        						</div>
        						</div>
        					</div>
        					<div class="wid-25 ">
        						<div class="table table-90">
	        						<div class="sear-tit sear-tit_70">강사명</div>
	        						<div>
	        							<input type="text"  class="" >
	        						</div>
        						</div>
        					</div>
        					<div class="wid-25 ">
        						<div class="table table-90">
	        						<div class="sear-tit sear-tit_70">강좌명</div>
	        						<div>
	        							<input type="text"  class="" >
	        						</div>
        						</div>
        					</div>
        					<div class="">
	        					<a class="btn btn02 " >조회</a>
	        				</div>
        				</div>
        			</div>
        			 -->
        			<div class="lect-pwrap02">
        				<div class="table">
        					<div class="wid-5 lec-1dept">
        						<div class="table">
        							<div class="wid-5">
		        						<p class="h3-stit">대분류</p>
		        						<ul class="sect_ul_big">
		        							<c:forEach var="j" items="${maincdList}" varStatus="loop">
												<li onclick="selMainCd('${j.SUB_CODE}')">${j.SHORT_NAME}</li>
											</c:forEach>
		        						</ul>
	        						</div>
	        						<div class="wid-5">
		        						<p class="h3-stit">중분류</p>
		        						<ul class="sect_ul">
		        						</ul>
	        						</div>
        						</div>
        					</div>
        					<div class="wid-5 lec-2dept">
        						<p class="h3-stit">강좌명</p>
        						<div>
	        						<ul class="pelt_ul">
	        							
	        						</ul>
	        					</div>
        					</div>
        				</div>
        			
        			</div> <!-- // lect-pwrap02 -->
        			
					<div class="lect-pwrap03">
						<h3>선택된 강좌</h3>
						<a class="btn btn01" onclick="peltTrAct('del')">삭제</a>
						<div class="table-wr">
							<div class="table-list">
								<table>
									<thead>
										<tr>
											<th class="td-chk">
												<input type="checkbox" id="chk_pelt" name="chk_pelt" value="chk_pelt_list"><label for="chk_pelt"></label>
											</th>
											<th>강좌명<i class="material-icons">import_export</i></th>
											<th>강사명<i class="material-icons">import_export</i></th>
											<th>강의요일<i class="material-icons">import_export</i></th>
											<th>강의시간<i class="material-icons">import_export</i></th>
										</tr>
									</thead>
									
									<tbody class="selLectTable">
									</tbody>
									
								</table>
							
							</div>
						</div>
					
					</div> <!-- // lect-pwrap03 -->
					
					<div class=" text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:peltTrAct('sel');">선택완료</a>
					</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>




<div id="retou_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit list-edit_web white-bg popwid-1200">
        		<div class="close" onclick="javascript:$('#retou_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3>추천 강좌 수정</h3>
					<div class="table-wr">
						<div class="thead-box">
							<table>
								<colgroup>
									<col />
									<col width="100px">
									<col width="350px">
									<col width="100px">
								</colgroup>
								<thead>
									<tr>
										<th class="">강좌명</th>
										<th class="">강사명</th>
										<th>기간</th>
										<th class="">노출</th>
									</tr>
								</thead>
							</table>
						</div>
						<div class="table-list">
							<form id="fncForm" name="fncForm" action="./lecture_upload_proc" method="POST" enctype="multipart/form-data">
								<input type="hidden" id="store" name="store">
								<input type="hidden" id="period" name="period">
								<input type="hidden" id="subject_cd" name="subject_cd">
								<table>
									<colgroup>
										<col />
										<col width="100px">
										<col width="350px">
										<col width="100px">
									</colgroup>
									<thead>
										<tr>
											<th class="">강좌명</th>
											<th class="">강사명</th>
											<th>기간</th>
											<th class="">노출</th>
										</tr>
									</thead>
									
									<tbody id="target_tbody">
		<!-- 								<tr> -->
		<!-- 									<td>10</td> -->
		<!-- 									<td>트니트니 율동체조</td> -->
		<!-- 									<td>이호걸</td> -->
		<!-- 									<td> -->
		<!-- 										<div class="filebox">  -->
		<!-- 											<label for="file"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
		<!-- 											<input type="file" id="file">  -->
													
		<!-- 											<input class="upload-name" value="2020년 AK Members Card 혜택 프로모션 배너_200602.jpg"> -->
		<!-- 										</div> -->
		<!-- 									</td> -->
		<!-- 									<td class="plan-onof"> -->
		<!-- 				 						<a onclick="javascript:changeStatus('tech', 1)" id="tech_1" name="tech_1" class="btn04 bor-btn btn-inline">N</a> -->
		<!-- 				 						<input type="hidden" id="tech_1_status" name="tech_1_status" value="N"> -->
		<!-- 				 					</td> 				 -->
		<!-- 								</tr> -->
		<!-- 								<tr> -->
		<!-- 									<td>10</td> -->
		<!-- 									<td>트니트니 율동체조</td> -->
		<!-- 									<td>이호걸</td> -->
		<!-- 									<td> -->
		<!-- 										<div class="filebox">  -->
		<!-- 											<label for="file"><img src="/img/img-file.png" /> 이미지 첨부</label>  -->
		<!-- 											<input type="file" id="file">  -->
													
		<!-- 											<input class="upload-name" value="2020년 AK Members Card 혜택 프로모션 배너_200602.jpg"> -->
		<!-- 										</div> -->
		<!-- 									</td> -->
		<!-- 									<td class="plan-onof"> -->
		<!-- 				 						<a onclick="javascript:changeStatus('tech', 1)" id="tech_1" name="tech_1" class="btn03 bor-btn btn-inline">Y</a> -->
		<!-- 				 						<input type="hidden" id="tech_1_status" name="tech_1_status" value="Y"> -->
		<!-- 				 					</td> 				 -->
		<!-- 								</tr> -->
										
									</tbody>
								</table>
							</form>
						</div>
					</div>
					<br>
					<div class=" text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();">저장</a>
					</div>
	        	</div>
        	</div>
        </div>
    </div>	
</div>








<script>
$(document).ready(function(){
	getList();
	init();
})
</script>



<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>