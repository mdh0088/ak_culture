<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>

<link rel="import" href="/inc/date_picker/date_picker.html">

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
var order_by = "";
var sort_type = "";
function reSortAjax(act)
{
	if(!isLoading)
	{
		sort_type = act.replace("sort_", "");
		if(order_by == "")
		{
			order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		else if(order_by == "desc")
		{
			order_by = "asc";
			$("#"+act).attr("src", "/img/th_up.png");
		}
		else if(order_by == "asc")
		{
			order_by = "desc";
			$("#"+act).attr("src", "/img/th_down.png");
		}
		getReloUser();
	}
}
function getReloUser()
{
	if($("#search_name").val() == "" && $("#search_phone").val() == "")
	{
		alert("회원명이나 휴대폰번호를 입력해주세요.");
		return;
	}
	else
	{
		if(!isLoading)
		{
			getListStart();
			$.ajax({
				type : "POST", 
				url : "./getReloUser",
				dataType : "text",
				data : 
				{
					search_name : $("#search_name").val(),
					search_phone : $("#search_phone").val(),
					order_by : order_by,
					sort_type : sort_type
				},
				error : function() 
				{
					console.log("AJAX ERROR");
				},
				success : function(data) 
				{
					console.log("123 : "+data);
					var result = JSON.parse(data);
					$("#user_target").html("");
					var inner = "";
					if(result.length > 1)
					{
						for(var i = 0; i < result.length; i++)
						{
							inner += '<tr onclick="selUser(\''+encodeURI(JSON.stringify(result[i]))+'\')">';
							inner += '	<td>'+nullChk(result[i].KOR_NM)+'</td>';
							inner += '	<td>'+nullChk(result[i].CUS_NO)+'</td>';
							inner += '	<td>'+cutDate(nullChk(result[i].BIRTH_YMD))+'</td>';
							inner += '	<td>'+nullChk(result[i].PTL_ID)+'</td>';
							inner += '</tr>';
						}
						$("#user_target").html(inner);
						$("#user_search_layer").fadeIn(200);
					}
					else if(result.length == 1)
					{
						selUser(encodeURI(JSON.stringify(result[0])));
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
function selUser(ret)
{
	$("#lect_search_layer").fadeOut(200);
	var result = JSON.parse(decodeURI(ret));
	cust_no = result.CUST_NO;
	
	$.ajax({
		type : "POST", 
		url : "./getReloUserPere",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			cust_no : result.CUST_NO
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data+"123456567567u");
			var result_ = JSON.parse(data);
			var inner = "";
			$(".cap-numb").html(result_.length+"건이 검색되었습니다.");
			for(var i = 0; i < result_.length; i++)
			{
				inner += '<tr>';
				inner += '	<td>'+result.KOR_NM+'</td>';
				if(result_[i].MAIN_CD == "2") //베이비
				{
					var tmp = result_[i].CUST_NM;
					if(nullChk(result_[i].CHILD1_NM) != '') { tmp += "/"+result_[i].CHILD1_NM; }
					if(nullChk(result_[i].CHILD2_NM) != '') { tmp += "/"+result_[i].CHILD2_NM; }
					inner += '	<td>'+tmp+'</td>';
				}
				else if(result_[i].MAIN_CD == "3") //키즈
				{
					var tmp = "";
					if(nullChk(result_[i].CHILD1_NM) != '') { tmp += ""+result_[i].CHILD1_NM; }
					if(nullChk(result_[i].CHILD2_NM) != '') { tmp += "/"+result_[i].CHILD2_NM; }
					inner += '	<td>'+tmp+'</td>';
				}
				else if(result_[i].MAIN_CD == "4") //패밀리
				{
					var tmp = "";
					if(nullChk(result_[i].CHILD1_NM) != '') { tmp += ""+result_[i].CHILD1_NM; }
					else if(nullChk(result_[i].CHILD2_NM) != '') { tmp += ""+result_[i].CHILD2_NM; }
					else
					{
						tmp = result_[i].CUST_NM;
					}
					inner += '	<td>'+tmp+'</td>';
				}
				else
				{
					inner += '	<td>'+result_[i].CUST_NM+'</td>';
				}
				inner += '	<td>'+result.CUS_NO+'</td>';
				inner += '	<td>'+result.PTL_ID+'</td>';
				inner += '	<td>'+result_[i].SUBJECT_CD+'</td>';
				inner += '	<td>'+result_[i].SUBJECT_NM+'</td>';
				inner += '	<td>'+cutDate(result_[i].START_YMD)+'~'+cutDate(result_[i].END_YMD)+'</td>';
				inner += '	<td><span class="btn btn07" onclick="getSamePriceLect(\''+result_[i].SUBJECT_CD+'\', \''+result_[i].CHILD_NO+'\')">조회</span></td>';
				inner += '</tr>';
			}
			$("#relo_target").html(inner);
			$('#user_search_layer').fadeOut(200);
		}
	});	
}
var prev_subject_cd = "";
var next_subject_cd = "";
var cust_no = "";
var ori_child_no = "";
function getSamePriceLect(subject_cd, child_val)
{
	ori_child_no = child_val
	prev_subject_cd = trim(subject_cd);
	$.ajax({
		type : "POST", 
		url : "./getSamePriceLect",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			subject_cd : subject_cd
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			var inner = "";
			$(".cap-numb2").html(result.length+"건이 검색되었습니다.");
			for(var i = 0; i < result.length; i++)
			{
				inner += '<tr>';
				inner += '	<td>';
				inner += '		<input type="radio" id="radio_'+trim(result[i].SUBJECT_CD)+'" value="'+trim(result[i].SUBJECT_CD)+'" name="radio_pelt">';
				inner += '		<label for="radio_'+trim(result[i].SUBJECT_CD)+'"></label>';
				inner += '	</td>';
				inner += '	<td>'+result[i].SUBJECT_CD+'</td>';
				inner += '	<td>'+result[i].SUBJECT_NM+'</td>';
				inner += '	<td>'+result[i].WEB_LECTURER_NM+'</td>';
				inner += '	<td>'+result[i].CAPACITY_NO+'</td>';
				inner += '	<td>'+comma(Number(nullChkZero(result[i].REGIS_NO)) + Number(nullChkZero(result[i].WEB_REGIS_NO)))+'</td>';
				inner += '	<td>'+comma(result[i].REGIS_FEE)+'</td>';
				inner += '	<td>'+cutDate(result[i].START_YMD)+'~'+cutDate(result[i].END_YMD)+'</td>';
				inner += '	<td>'+cutYoil(result[i].DAY_FLAG)+'</td>';
				inner += '	<td>'+cutLectHour(result[i].LECT_HOUR)+'</td>';
				inner += '</tr>';
			}
			$("#same_target").html(inner);
		}
	});	
}
function movePelt2()
{
	next_subject_cd = $('input[name="radio_pelt"]:checked').val();
	var main_cd = "";
	var is_two = false;
	
	$.ajax({
		type : "POST", 
		url : "./getPeltInfo",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			subject_cd : next_subject_cd
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			for(var i = 0; i < result.length; i++)
			{
				main_cd = result[i].MAIN_CD;
				if(result[i].IS_TWO == "Y")
				{
					is_two = true;
				}
				else
				{
					is_two = false;
				}
			}
		}
	});	
	$.ajax({
		type : "POST", 
		url : "/member/cust/getChildInfo",
		dataType : "text",
		async:false,
		data : 
		{
			cust_no : cust_no
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if(main_cd == "2" || main_cd == "3") //베이비면 체크박스, 아니면 라디오
			{
				if(result.length == 0) 
				{
					alert("해당 고객님은 자녀강좌를 신청할 수 없습니다.");
					return false;
				}
			}
			$(".child-wrap").html('');
			var inner = "";
			inner += '			<ul class="chk-ul">';
			if(main_cd == "1")
			{
				inner += '<li><input type="radio" id="selChild_0" name="selChild" value="0" checked="checked"><label for="bag_type"><span class="selChild_0">본인</span></label></li>';
			}
			else if(main_cd == "2") //베이비면 체크박스, 아니면 라디오
			{
				
				inner += '<li><input type="checkbox" id="selChild_0" name="selChild" value="S" checked="checked" disabled="true"><label for="selChild_0"><span class="bagbor">본인</span></label></li>';
				for(var i = 0; i < result.length; i++)
				{
					var gender = trim(result[i].GENDER) == "M" ? '아들':'딸';
					inner += '<li><input type="checkbox" id="selChild_'+result[i].CHILD_NO+'" name="selChild" value="S" ><label for="selChild_'+result[i].CHILD_NO+'"><span class="bagbor">'+gender+'</span>'+result[i].CHILD_NM+' <span class="bag-birth">'+cutDate(result[i].BIRTH)+'</span></label></li>';
				}
			}
			else if(main_cd == "3" && is_two) //베이비면 체크박스, 아니면 라디오
			{
				inner += '<li><input type="checkbox" id="selChild_0" name="selChild" value="S" checked="checked" disabled="true"><label for="selChild_0"><span class="bagbor">본인</span></label></li>';
				for(var i = 0; i < result.length; i++)
				{
					var gender = trim(result[i].GENDER) == "M" ? '아들':'딸';
					inner += '<li><input type="checkbox" id="selChild_'+result[i].CHILD_NO+'" name="selChild" value="S" ><label for="selChild_'+result[i].CHILD_NO+'"><span class="bagbor">'+gender+'</span>'+result[i].CHILD_NM+' <span class="bag-birth">'+cutDate(result[i].BIRTH)+'</span></label></li>';
				}
			}
			else if(main_cd == "3" && !is_two) //베이비면 체크박스, 아니면 라디오
			{
				for(var i = 0; i < result.length; i++)
				{
					var gender = trim(result[i].GENDER) == "M" ? '아들':'딸';
					if(i == 0)
					{
						inner += '<li><input type="radio" id="selChild_'+result[i].CHILD_NO+'" name="selChild" value="'+result[i].CHILD_NO+'" checked="checked"><label for="selChild_'+result[i].CHILD_NO+'"><span class="bagbor">'+gender+'</span>'+result[i].CHILD_NM+' <span class="bag-birth">'+cutDate(result[i].BIRTH)+'</span></label></li>';
					}
					else
					{
						inner += '<li><input type="radio" id="selChild_'+result[i].CHILD_NO+'" name="selChild" value="'+result[i].CHILD_NO+'" ><label for="selChild_'+result[i].CHILD_NO+'"><span class="bagbor">'+gender+'</span>'+result[i].CHILD_NM+' <span class="bag-birth">'+cutDate(result[i].BIRTH)+'</span></label></li>';
					}
				}
			}
			else
			{
				inner += '<li><input type="radio" id="selChild_0" name="selChild" value="0" checked="checked"><label for="selChild_0"><span class="bagbor">본인</span></label></li>';
				for(var i = 0; i < result.length; i++)
				{
					var gender = trim(result[i].GENDER) == "M" ? '아들':'딸';
					inner += '<li><input type="radio" id="selChild_'+result[i].CHILD_NO+'" name="selChild" value="'+result[i].CHILD_NO+'" ><label for="selChild_'+result[i].CHILD_NO+'"><span class="bagbor">'+gender+'</span>'+result[i].CHILD_NM+' <span class="bag-birth">'+cutDate(result[i].BIRTH)+'</span></label></li>';
				}
			}
			inner += '			</ul>';
			inner += '<div style="text-align:center;"><a class="btn btn02 ok-btn" onclick="javascript:movePelt(\''+main_cd+'\', \''+is_two+'\');">선택한 강좌로 이강신청</a></div>'
			$(".child-wrap").append(inner);
			
			
		}
	});	
	
	
	$('#child_layer').fadeIn(200);
	
}
function movePelt(main_cd, is_two)
{
	child1_no = "";
	child2_no = "";
	if(main_cd == "2")
	{
		var chkList = "";
		var childCnt = 0;
		$("input:checkbox[name='selChild']").each(function(){
			var child_no = $(this).attr('id').replace('selChild_', '');
		    if($(this).is(":checked") && child_no != '0')
	    	{
		    	if(childCnt == 0) {child1_no = child_no;}
		    	else if(childCnt == 1) {child2_no = child_no;}
		    	childCnt ++;
	    	}
		});
		if(childCnt > 2)
		{
			alert("자녀는 두명까지 선택가능합니다.");
			return;
		}
		else if(childCnt == 0)
		{
			alert("자녀 한명은 필수로 선택하셔야합니다.");
			return;
		}
	}
	else if(main_cd == "3" && is_two == "true")
	{
		var chkList = "";
		var childCnt = 0;
		$("input:checkbox[name='selChild']").each(function(){
			var child_no = $(this).attr('id').replace('selChild_', '');
		    if($(this).is(":checked") && child_no != '0')
	    	{
		    	if(childCnt == 0) {child1_no = child_no;}
		    	else if(childCnt == 1) {child1_no = child_no;}
		    	childCnt ++;
	    	}
		});
		if(childCnt > 1)
		{
			alert("자녀는 한명까지 선택가능합니다.");
			return;
		}
		else if(childCnt == 0)
		{
			alert("자녀 한명은 필수로 선택하셔야합니다.");
			return;
		}
	}
	else if(main_cd == "3" && is_two != "true")
	{
		child1_no = $('input[name="selChild"]:checked').val();
	}
	else
	{
		child1_no = $('input[name="selChild"]:checked').val();
	}
	
	var isStart = false;
	next_subject_cd = $('input[name="radio_pelt"]:checked').val();
	$.ajax({
		type : "POST", 
		url : "./getPeltInfo",
		dataType : "text",
		async : false,
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val(),
			subject_cd : next_subject_cd
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			for(var i = 0; i < result.length; i++)
			{
				if(result[i].START_YMD <= getNow())
				{
					isStart = true;
				}
			}
		}
	});	

	if(isStart)
	{
		if(confirm("시작일이 지난 강좌가 있습니다.\n이강하시겠습니까?"))
		{
			$.ajax({
				type : "POST", 
				url : "./movePelt",
				dataType : "text",
				async : false,
				data : 
				{
					store : $("#selBranch").val(),
					period : $("#selPeri").val(),
					cust_no : cust_no,
					prev_subject_cd : prev_subject_cd,
					next_subject_cd : next_subject_cd,
					ori_child_no : ori_child_no,
					child1_no:child1_no,
					child2_no:child2_no
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
	else
	{
		$.ajax({
			type : "POST", 
			url : "./movePelt",
			dataType : "text",
			async : false,
			data : 
			{
				store : $("#selBranch").val(),
				period : $("#selPeri").val(),
				cust_no : cust_no,
				prev_subject_cd : prev_subject_cd,
				next_subject_cd : next_subject_cd,
				ori_child_no : ori_child_no,
				child1_no:child1_no,
				child2_no:child2_no
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
</script>
<div class="sub-tit">
	<h2>이강신청</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>
	<div class="float-right">
		<a class="btn btn01" href="list">이강리스트</a>
	</div>
</div>
<div class="table-top first">
	<div class="top-row sear-wr">
		<div class="wid-35">
			<div class="table table02 table-input wid-contop">
				<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
			</div>
			<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
		</div>
		<div class="wid-2">
			<div class="table table-90">
				<div class="sear-tit sear-tit-70">회원명<span class="req-sp">*</span></span></div>
				<div>
					<input type="text" id="search_name" name="search_name" placeholder="입력하세요." onkeypress="excuteEnter(getReloUser)">
				</div>
			</div>
		</div>
		<div class="wid-45">
			<div class="table table-input">
				<div class="sear-tit ">휴대폰번호</div>
				<div>
					<input type="text" id="search_phone" name="search_phone" placeholder="휴대폰 뒷번호 네자리 입력하세요." onkeypress="excuteEnter(getReloUser)">
				</div>
				<!-- <div>
					<input class="search-btn03 btn btn-mar6 btn02" type="button" value="조회" onclick="getReloUser()">
				</div>  -->
			</div>
		</div>
		
	</div>
	
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="getReloUser()">
</div>
<div class="table-cap table">
	<div class="cap-l" >
		<p class="cap-numb"></p>
	</div>
	<div class="cap-r text-right">
		<div class="table float-right sel-scr">
			<div>
				<a class="bor-btn btn01" href="#"><i class="fas fa-file-download"></i></a>
				<select id="listSize" name="listSize" onchange="reSelect()" de-data="10개 보기">
					<option value="20">10개 보기</option>
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
<div class="table-wr table-relo">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="80px">
				<col width="80px">
				<col>
				<col>
				<col>
				<col width="300px">
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>고객명 </th>
					<th>수강자 </th>
					<th>멤버스번호 </th>
					<th>포털ID </th>
<!-- 					<th></th> -->
<!-- 					<th>신청강좌수 </th> -->
					<th>강좌코드 </th>
					<th class="td-300">강좌명 </th>
					<th>시작일/종료일 </th>
					<th>이강가능강좌 </th>	
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-list-shot">
		<table>
			<colgroup>
				<col width="80px">
				<col width="80px">
				<col>
				<col>
				<col>
				<col width="300px">
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>고객명 </th>
					<th>수강자 </th>
					<th>멤버스번호 </th>
					<th>포털ID </th>
<!-- 					<th></th> -->
<!-- 					<th>신청강좌수 </th> -->
					<th>강좌코드 </th>
					<th class="td-300">강좌명 </th>
					<th>시작일/종료일 </th>
					<th>이강가능강좌 </th>	
				</tr>
			</thead>
			<tbody id="relo_target">
<!-- 				<tr> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>본인</td> -->
<!-- 					<td>12345689</td> -->
<!-- 					<td>musign</td> -->
<!-- 					<td>042</td> -->
<!-- 					<td><input type="radio" id="rad-c" name="rad-1" checked=""><label for="rad-c"></label></td> -->
<!-- 					<td>1</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>트니트니 신체발달</td> -->
<!-- 					<td>확정</td> -->
<!-- 					<td><span class="btn btn07">조회</span></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td>이강준</td> -->
<!-- 					<td>자녀</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td><input type="radio" id="rad-c" name="rad-1" checked=""><label for="rad-c"></label></td> -->
<!-- 					<td>1</td> -->
<!-- 					<td>101076</td> -->
<!-- 					<td>중장년을 위한 노화방지 요가</td> -->
<!-- 					<td>확정</td> -->
<!-- 					<td><span class="btn btn07">조회</span></td> -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	
</div>
<div class="table-cap table">
	<div class="cap-l" style="width:30%;">
		<p class="cap-numb2"></p>
	</div>
<!-- 	<div class="cap-r text-right sel-scr"> -->
<!-- 		<p class="sel-txt">결과 내 검색</p> -->
<!-- 		<input class="btn-inline btn06" type="text" id="" name="" value="" placeholder="강좌명"> -->
<!-- 		<input class="btn-inline btn06" type="text" id="" name="" value="" placeholder="강좌코드"> -->
<!-- 		<input class="search-btn03 btn btn02 btn-mar6" type="button" value="조회" > -->
<!-- 	</div> -->
</div>
<div class="table-wr">
	<div class="thead-box">
		<table>
			<colgroup>
				<col width="60px">
				<col>
				<col width="300px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
					</th>
					<th>강좌코드 </th>					
					<th>강좌명 </th>
					<th>강사명 </th>
					<th>정원 </th>
					<th>현원 </th>
					<th>수강료 </th>
					<th>시작일/종료일 </th>
					<th>강의요일 </th>
					<th>강의시간 </th>	
				</tr>
			</thead>
		</table>
	</div>
	<div class="table-list table-list-shot">
		<table>
			<colgroup>
				<col width="60px">
				<col>
				<col width="300px">
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th class="td-chk">
					</th>
					<th>강좌코드 </th>					
					<th>강좌명 </th>
					<th>강사명 </th>
					<th>정원 </th>
					<th>현원 </th>
					<th>수강료 </th>
					<th>시작일/종료일 </th>
					<th>강의요일 </th>
					<th>강의시간 </th>					
				</tr>
			</thead>
			<tbody id="same_target">
<!-- 				<tr> -->
<!-- 					<td class="td-chk"> -->
<%-- 						<input type="checkbox" id="idx${readCnt }" name="idx" value="${readCnt }"><label for="idx${readCnt }"></label> --%>
<!-- 					</td> -->
<!-- 					<td>101076</td>					 -->
<!-- 					<td>일요 밸런스 요가</td> -->
<!-- 					<td>이호걸</td> -->
<!-- 					<td>25</td> -->
<!-- 					<td>24</td> -->
<!-- 					<td>80,000</td> -->
<!-- 					<td>목</td> -->
<!-- 					<td>10:30~11:50</td> -->
<!-- 				</tr> -->
			</tbody>
		</table>
	</div>
	<div class="btn-wr text-center">
		<a class="btn btn02 ok-btn" onclick="javascript:movePelt2();">선택한 강좌로 이강신청</a>
	</div>
</div>
<div id="user_search_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg edit-scroll">
        		<div class="close" onclick="javascript:$('#user_search_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
        		<br>
        		<div class="thead-box">
					<table>
						<colgroup>
							<col width="60px">
							<col>
							<col>
						</colgroup>
						<thead>
							<tr>
								<th onclick="reSortAjax('sort_kor_nm')">고객명 <img src="/img/th_up.png" id="sort_kor_nm"></th>
								<th onclick="reSortAjax('sort_cus_no')">멤버스번호 <img src="/img/th_up.png" id="sort_cus_no"></th>
								<th onclick="reSortAjax('sort_birth_ymd')">생년월일 <img src="/img/th_up.png" id="sort_birth_ymd"></th>
								<th onclick="reSortAjax('sort_ptl_id')">포털아이디 <img src="/img/th_up.png" id="sort_ptl_id"></th>
							</tr>
						</thead>
					</table>
				</div>
        		<div class="table-list">
	        		<table>
	        			<colgroup>
							<col width="60px">
							<col>
							<col>
						</colgroup>
						<thead>
							<tr>
								<th onclick="reSortAjax('sort_kor_nm')">고객명 <img src="/img/th_up.png" id="sort_kor_nm"></th>
								<th onclick="reSortAjax('sort_cus_no')">멤버스번호 <img src="/img/th_up.png" id="sort_cus_no"></th>
								<th onclick="reSortAjax('sort_birth_ymd')">생년월일 <img src="/img/th_up.png" id="sort_birth_ymd"></th>
								<th onclick="reSortAjax('sort_ptl_id')">포털아이디 <img src="/img/th_up.png" id="sort_ptl_id"></th>
							</tr>
						</thead>
						<tbody id="user_target">									
						</tbody>
					</table>
				</div>
        	</div>
        </div>
    </div>	
</div>

<div id="child_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg phone-edit">
        		<div class="close" onclick="javascript:$('#child_layer').fadeOut(200);">
        			닫기<i class="far fa-window-close"></i>
        		</div>
	        	<div class="child-wrap">
				</div>
        	</div>
        </div>
    </div>	
</div>

<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>