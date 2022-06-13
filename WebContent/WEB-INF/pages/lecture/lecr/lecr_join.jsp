<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker.html"/>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
var isLoading = false;
function getListStart()
{
	console.log("aaaaaaaaaaaaaa");
	$(".btn02").addClass("loading-sear");
	$(".btn02").prop("disabled", true);
	isLoading = true;
}
function getListEnd()
{
	console.log("bbbbbbbbbbbbbbbbbbb");
	$(".btn02").removeClass("loading-sear");		
	$(".btn02").prop("disabled", false);
	isLoading = false;
}
$(document).ready(function(){

});
var order_by1 = "";
var sort_type1 = "";
var order_by2 = "";
var sort_type2 = "";
function reSortAjax1(act)
{
	if(!isLoading)
	{
		sort_type1 = act.replace("sort_", "");
		if(order_by1 == "")
		{
			order_by1 = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		else if(order_by1 == "desc")
		{
			order_by1 = "asc";
			$("#"+act).attr("src", "/img/th_up.png");
		}
		else if(order_by1 == "asc")
		{
			order_by1 = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		getLemgListOld();
	}
}
function reSortAjax2(act)
{
	if(!isLoading)
	{
		sort_type2 = act.replace("sort_", "");
		if(order_by2 == "")
		{
			order_by2 = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		else if(order_by2 == "desc")
		{
			order_by2 = "asc";
			$("#"+act).attr("src", "/img/th_up.png");
		}
		else if(order_b2y == "asc")
		{
			order_by2 = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		getAmsListOld();
	}
}
function getLemgListOld()
{
	if($("#searchLemg").val() == "")
	{
		alert("강사관리번호를 입력해주세요.");
		$("#searchLemg").focus();
		return;
	}
	else
	{
		if(!isLoading)
		{
			getListStart();
			$.ajax({				
				type : "POST", 
				url : "./getLemgListOld",
				dataType : "text",
				data : 
				{
					searchLemg : $("#searchLemg").val(),
					order_by : order_by1,
					sort_type : sort_type1
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					var result = JSON.parse(data);
					var inner = "";
					if(result.length > 1)
					{
						for(var i = 0; i < result.length; i++)
						{
							inner += '<tr ondblclick="selLemg(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
							inner += '	<td>'+nullChk(result[i].LECTURER_NM)+'</td>';
							inner += '	<td>'+cutDate(nullChk(result[i].BIRTH_YMD))+'</td>';
							inner += '	<td>'+nullChk(result[i].PHONE_NO)+'</td>';
							inner += '</tr>';
						}
						$("#left_target").html(inner);
						$("#left_layer").fadeIn(200);
					}
					else if(result.length == 1)
					{
						selLemg(encodeURI(JSON.stringify(result[0])));
					}
					else
					{
						alert("검색결과가 없습니다.");
					}
					getListEnd();
				}
			});
		}
	}
}
function getAmsListOld()
{
	if($("#searchAms").val() == "")
	{
		alert("휴대폰번호를 입력해주세요.");
		$("#searchAms").focus();
		return;
	}
	else
	{
		if(!isLoading)
		{
			getListStart();
			$.ajax({				
				type : "POST", 
				url : "/member/cust/getAmsListOld",
				dataType : "text",
				data : 
				{
					searchPhone : $("#searchAms").val(),
					order_by : order_by2,
					sort_type : sort_type2
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					var result = JSON.parse(data);
					var inner = "";
					if(result.length > 1)
					{
						for(var i = 0; i < result.length; i++)
						{
							inner += '<tr ondblclick="selAms(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
							inner += '	<td>'+result[i].CUS_PN+'</td>';
							inner += '	<td>'+cutDate(nullChk(result[i].BMD))+'</td>';
							inner += '	<td>'+nullChk(result[i].MTEL_IDENT_NO)+"-"+nullChk(result[i].MMT_EX_NO)+"-"+nullChk(result[i].MTEL_UNIQ_NO)+'</td>';
							inner += '	<td>'+result[i].CUS_NO+'</td>';
							inner += '</tr>';
						}
						$("#right_target").html(inner);
						$("#right_layer").fadeIn(200);
					}
					else if(result.length == 1)
					{
						selAms(encodeURI(JSON.stringify(result[0])));
					}
					else
					{
						alert("검색결과가 없습니다.");
					}
					getListEnd();
				}
			});
		}
	}
}

var result_lecturer_cd = "";
var result_lectmgmt_no = "";
var result_cus = "";
function selLemg(ret)
{
	$('#left_layer').fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
	$("#lemg_nm").val(result.LECTURER_NM);
	$("#lemg_phone").val(cutPhone(result.PHONE_NO));
	result_lecturer_cd = result.LECTURER_CD;
	result_lectmgmt_no = result.LECTMGMT_NO;
	
	$.ajax({				
		type : "POST", 
		url : "./lecr_lect_list",
		dataType : "text",
		async : false,
		data : 
		{
			lectmgmt_no : result_lectmgmt_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			var result2 = JSON.parse(data);
			var inner = "";
			if(result2.length > 0)
			{
				for(var i = 0; i < result2.length; i++)
				{
					inner += '<tr>';
					inner += '	<td>'+(i+1)+'</td>';
					inner += '	<td></td>';
					inner += '	<td>'+nullChk(result2[i].BIRTH_YMD)+'</td>';
					inner += '	<td>'+nullChk(result2[i].STORE_NM)+'</td>';
					inner += '	<td>'+nullChk(result2[i].PERIOD)+'</td>';
					inner += '	<td>'+nullChk(result2[i].SUBJECT_NM)+'</td>';
					inner += '</tr>';
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="6"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target").html(inner);
		}
	});
}
function selAms(ret)
{
	$('#right_layer').fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
 	$("#ams_nm").val(result.CUS_PN);
 	$("#ams_phone").val(result.MTEL_IDENT_NO+"-"+result.MMT_EX_NO+"-"+result.MTEL_UNIQ_NO);
 	result_cus = result.CUS_NO;
}


function fncSubmit()
{
	if($("#lemg_nm").val() != $("#ams_nm").val() || $("#lemg_phone").val() != $("#ams_phone").val())
	{
		alert("강사와 멤버스 회원정보가 다릅니다.");
		return;
	}
	else
	{
		$.ajax({				
			type : "POST", 
			url : "./lecr_join_proc",
			dataType : "text",
			data : 
			{
				lecturer_cd : result_lecturer_cd,
				lectmgmt_no : result_lectmgmt_no,
				cus_no : result_cus
			},
			error : function() 
			{
				console.log("AJAX ERROR");
			},
			success : function(data) 
			{
				var result = JSON.parse(data);
	    		if(result.isSuc == "success")
	    		{
	    			alert(result.msg);
	    			$.ajax({				
	    				type : "POST", 
	    				url : "./lecr_lect_list2",
	    				dataType : "text",
	    				async : false,
	    				data : 
	    				{
	    					cus_no : result_cus
	    				},
	    				error : function() 
	    				{
	    					console.log("AJAX ERROR");
	    				},
	    				success : function(data) 
	    				{
	    					var result2 = JSON.parse(data);
	    					var inner = "";
	    					if(result2.length > 0)
	    					{
	    						for(var i = 0; i < result2.length; i++)
	    						{
	    							inner += '<tr>';
	    							inner += '	<td>'+(i+1)+'</td>';
	    							inner += '	<td style="color:red;">'+nullChk(result2[i].CUS_NO)+'</td>';
	    							inner += '	<td>'+nullChk(result2[i].BIRTH_YMD)+'</td>';
	    							inner += '	<td>'+nullChk(result2[i].STORE_NM)+'</td>';
	    							inner += '	<td>'+nullChk(result2[i].PERIOD)+'</td>';
	    							inner += '	<td>'+nullChk(result2[i].SUBJECT_NM)+'</td>';
	    							inner += '</tr>';
	    						}
	    					}
	    					else
	    					{
	    						inner += '<tr>';
	    						inner += '	<td colspan="6"><div class="no-data">검색결과가 없습니다.</div></td>';
	    						inner += '</tr>';
	    					}
	    					$("#list_target").html(inner);
	    				}
	    			});
	    		}
	    		else
	    		{
	    			alert(result.msg);
	    		}
			}
		});
	}
}

</script>
<div class="sub-tit">
	<h2>강사 통합</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="btn-right">
		<div>
			<!-- <A class="btn btn02" href="#">정보수정</A>  -->
<!-- 			<A class="btn btn01 btn01_1" onclick="javascript:lecrNew()"><i class="material-icons">add</i>강사 평가</A> -->
		</div>		
	</div>
</div>
<div class="row view-page peri-list">
	<div class="wid-5">
		<div class="white-bg ak-wrap_new">
			<h3 class="h3-tit">강사 정보</h3>
			
			<div class="bor-div first">
				<div class="top-row">
					<div class="wid-10">
						<div class="table lecr-searwr">
							<div class="lecr-sear lecr-sear-snm">
								<div class="table table02 table-searnum">
									<div class="wid-10">
										<input type="text" data-name="강사관리번호" id="searchLemg" name="searchLemg" class="inp-100" placeholder="(강사) 강사번호/휴대폰번호를 입력하세요." onkeypress="excuteEnter(getLemgListOld)">
									</div>
					        	</div>
								<div>
									<a class="btn btn02" onclick="javascript:getLemgListOld()">검색</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			
				<div class="top-row table-input">
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit">강사명</div>
							<div>
								<input type="text" class="inputDisabled" id="lemg_nm" name="lemg_nm" readOnly/>
							</div>
						</div>
					</div>
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit sear-tit_120 sear-tit_left">휴대폰</div>
							<div>
								<input type="text" class="inputDisabled" id="lemg_phone" name="lemg_phone" readOnly/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="wid-5">
		<div class="white-bg ak-wrap_new">
			<h3 class="h3-tit">멤버스 회원정보</h3>
			
			<div class="bor-div first">
				<div class="top-row">
					<div class="wid-10">
						<div class="table lecr-searwr">
							<div class="lecr-sear lecr-sear-snm">
								<div class="table table02 table-searnum">
									<div class="wid-10">
										<input type="text" data-name="휴대폰 뒷자리" id="searchAms" name="searchAms" class="inp-100" placeholder="(멤버스 회원) 휴대폰 뒷번호 네자리 입력하세요." onkeypress="excuteEnter(getAmsListOld)">
									</div>
					        	</div>
								<div>
									<a class="btn btn02" onclick="javascript:getAmsListOld()">검색</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			
				<div class="top-row table-input">
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit">회원명</div>
							<div>
								<input type="text" class="inputDisabled" id="ams_nm" name="ams_nm" readOnly/>
							</div>
						</div>
					</div>
					<div class="wid-5">
						<div class="table">
							<div class="sear-tit sear-tit_120 sear-tit_left">휴대폰</div>
							<div>
								<input type="text" class="inputDisabled" id="ams_phone" name="ams_phone" readOnly/>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</div>
<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="">
				<col />
				<col />
				<col />
				<col />
				<col width="40%">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th>멤버스번호</th>
					<th>생년월일</th>
					<th>지점</th>
					<th>기수</th>
					<th>강좌명</th>
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list" style="height:800px; overflow-y:scroll;">
		<table id="excelTable">
			<colgroup>
				<col width="40px">
				<col />
				<col />
				<col />
				<col />
				<col width="40%">
			</colgroup>
			<thead>
				<tr>
					<th class="td-no">NO.</th>
					<th>멤버스번호</th>
					<th>생년월일</th>
					<th>지점</th>
					<th>기수</th>
					<th>강좌명</th>
				</tr>
			</thead>
			<tbody id="list_target">
				
			</tbody>
		</table>
	</div>
</div>
<div class="btn-wr text-center">
	<a class="btn btn01 ok-btn" onclick="pageReset()">초기화</a>
	<a class="btn btn02 ok-btn" onclick="javascript:fncSubmit();">저장</a>
</div>

<div id="left_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg edit-scroll">
        		<div class="close" onclick="javascript:$('#left_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">강사 조회</h3>
					<div class="table table02 table-searnum">
						<div class="wid-5 sel-scr">
							<input type="hidden" id="searchResult" name="searchResult">
<!-- 								<a class="btn btn02" onclick="choose_confirm('search');">선택완료</a> -->
						</div>
	        		</div>
	        		<div class="top-row">
						<div class="table-list table-csplist table-wid10" style="display:block !important;">
							<table>
								<thead>
									<tr>
										<th onclick="reSortAjax1('sort_lecturer_nm')">회원명 <img src="/img/th_up.png" id="sort_lecturer_nm"></th>
										<th onclick="reSortAjax1('sort_birth_ymd')">생년월일 <img src="/img/th_up.png" id="sort_birth_ymd"></th>
										<th onclick="reSortAjax1('sort_phone_no')">연락처 <img src="/img/th_up.png" id="sort_phone_no"></th>
									</tr>
								</thead>
								<tbody id="left_target">
								</tbody>
							</table>
						</div>
					</div>		
	        	</div>
        	</div>
        </div>
    </div>	
</div>
<div id="right_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg edit-scroll">
        		<div class="close" onclick="javascript:$('#right_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<div>
        			<h3 class="text-center">멤버스 조회</h3>
					<div class="table table02 table-searnum">
						<div class="wid-5 sel-scr">
							<input type="hidden" id="searchResult" name="searchResult">
<!-- 								<a class="btn btn02" onclick="choose_confirm('search');">선택완료</a> -->
						</div>
	        		</div>
	        		<div class="top-row">
						<div class="table-list table-csplist table-wid10" style="display:block !important;">
							<table>
								<thead>
									<tr>
										<th onclick="reSortAjax2('sort_cus_pn')">회원명 <img src="/img/th_up.png" id="sort_cus_pn"></th>
										<th onclick="reSortAjax2('sort_bmd')">생년월일 <img src="/img/th_up.png" id="sort_bmd"></th>
										<th onclick="reSortAjax2('sort_mtel_ident_no')">연락처 <img src="/img/th_up.png" id="sort_mtel_ident_no"></th>
										<th onclick="reSortAjax2('sort_cus_no')">멤버스번호 <img src="/img/th_up.png" id="sort_cus_no"></th>
									</tr>
								</thead>
								<tbody id="right_target">
								</tbody>
							</table>
						</div>
					</div>		
	        	</div>
        	</div>
        </div>
    </div>	
</div>






<jsp:include page="/WEB-INF/pages/common/footer.jsp"/> 