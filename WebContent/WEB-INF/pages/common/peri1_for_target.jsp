<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<script>
$(document).ready(function(){
	target_setPeri();
	target_fncPeri();
	target_yearInit();
});
function target_setPeri()
{
	$("#target_selBranch").val(login_rep_store);
	$(".target_selBranch").html(login_rep_store_nm);
}
function target_yearInit()
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#target_selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$("#target_selYear").val(result[0].WEB_TEXT.substring(0,4));
			$(".target_selYear").html(result[0].WEB_TEXT.substring(0,4));
		}
	});	
	target_fncPeri();
}

function target_fncPeri()
{
	//혹시나 작업중에 기수정보를 바꿨을때 실행되는 함수입니다.
	if(typeof periInit == 'function' ) 
	{
		periInit();
	}
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#target_selBranch").val(),
			selYear : $("#target_selYear").val()
//			selSeason : $("#target_selSeason").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
// 			$("#selPeri").html("");
// 			$(".select-ul:eq(3)").html("");
// 			for(var i = 0; i < result.length; i++)
// 	 		{
// 				$(".select-ul:eq(3)").append("<li>"+result[i].PERIOD+"</li>");
// 				$("#selPeri").append("<option value='"+result[i].PERIOD+"'>"+result[i].PERIOD+"</option>");
// 			}
			var inner = "";
			var is_spring = false;
			var is_summer = false;
			var is_autumn = false;
			var is_winter = false;
			for(var i = 0; i < result.length; i++)
			{
				if(result[i].WEB_TEXT.indexOf("봄") > -1 )
				{
					is_spring = true;
				}
				else if(result[i].WEB_TEXT.indexOf("여름") > -1)
				{
					is_summer = true;
				}
				else if(result[i].WEB_TEXT.indexOf("가을") > -1)
				{
					is_autumn = true;
				}
				else if(result[i].WEB_TEXT.indexOf("겨울") > -1)
				{
					is_winter = true;
				}
			}
			if(result.length > 0)
			{
				$(".target_selPeri").html(result[0].PERIOD+" / "+result[0].STORE_NM);
				$("#target_selPeri").val(result[0].PERIOD);
			}
			else
			{
				$(".target_selPeri").html("검색된 기수정보가 없습니다.");
				$("#target_selPeri").val('99999'); //전체검색을 막기위해
// 				inner += '<select de-data="봄학기 / 기수없음" id="target_selSeason" name="target_selSeason" onchange="target_fncPeri()">';
// 				inner += '	<option value="봄학기">봄학기 / 기수없음</option>';
// 				inner += '	<option value="여름학기">여름학기 / 기수없음</option>';
// 				inner += '	<option value="가을학기">가을학기 / 기수없음</option>';
// 				inner += '	<option value="겨울학기">겨울학기 / 기수없음</option>';
// 				inner += '</select>';
			}
			
			//순서를 위해 따로돌립니다.
			for(var i = 0; i < result.length; i++)
			{
				if(is_spring && result[i].WEB_TEXT.indexOf("봄") > -1)
				{
					if(i == 0)
					{
						inner += '<select de-data="봄학기 / '+result[i].PERIOD+'" id="target_selSeason" name="target_selSeason" onchange="target_fncPeri2()">';
					}
					inner += '<option value="봄학기">봄학기 / '+result[i].PERIOD+'</option>';
					is_spring = true;
				}
				if(is_summer && result[i].WEB_TEXT.indexOf("여름") > -1)
				{
					if(i == 0)
					{
						inner += '<select de-data="여름학기 / '+result[i].PERIOD+'" id="target_selSeason" name="target_selSeason" onchange="target_fncPeri2()">';
					}
					inner += '<option value="여름학기">여름학기 / '+result[i].PERIOD+'</option>';
					is_summer = true;
				}
				if(is_autumn && result[i].WEB_TEXT.indexOf("가을") > -1)
				{
					if(i == 0)
					{
						inner += '<select de-data="가을학기 / '+result[i].PERIOD+'" id="target_selSeason" name="target_selSeason" onchange="target_fncPeri2()">';
					}
					inner += '<option value="가을학기">가을학기 / '+result[i].PERIOD+'</option>';
					is_autumn = true;
				}
				if(is_winter && result[i].WEB_TEXT.indexOf("겨울") > -1)
				{
					if(i == 0)
					{
						inner += '<select de-data="겨울학기 / '+result[i].PERIOD+'" id="target_selSeason" name="target_selSeason" onchange="target_fncPeri2()">';
					}
					inner += '<option value="겨울학기">겨울학기 / '+result[i].PERIOD+'</option>';
					is_winter = true;
				}
			}
			if(!is_spring && !is_summer && !is_autumn && !is_winter)
			{
				inner += '<select de-data="봄학기 / 기수없음" id="target_selSeason" name="target_selSeason" onchange="fncPeri()">';
			}
			if(!is_spring)
			{
				inner += '<option value="봄학기">봄학기 / 기수없음</option>';
				is_spring = true;
			}
			if(!is_summer)
			{
				inner += '<option value="여름학기">여름학기 / 기수없음</option>';
				is_summer = true;
			}
			if(!is_autumn)
			{
				inner += '<option value="가을학기">가을학기 / 기수없음</option>';
				is_autumn = true;
			}
			if(!is_winter)
			{
				inner += '<option value="겨울학기">겨울학기 / 기수없음</option>';
				is_winter = true;
			}
			inner += '</select>';
			$("#tar_get_season_target").html(inner);
			target_selectInit_one('target_selSeason');
			
			
		}
	});	
	if(typeof selPeri2 == 'function' ) 
	{
		selPeri2();
	}
}
function target_fncPeri2()
{
	//혹시나 작업중에 기수정보를 바꿨을때 실행되는 함수입니다.
	if(typeof periInit == 'function') 
	{
		periInit();
	}
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#target_selBranch").val(),
			selYear : $("#target_selYear").val(),
			selSeason : $("#target_selSeason").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			if(result.length > 0)
			{
				$(".target_selPeri").html(result[0].PERIOD+" / "+result[0].STORE_NM);
				$("#target_selPeri").val(result[0].PERIOD);
			}
			else
			{
				$(".target_selPeri").html("검색된 기수정보가 없습니다.");
				$("#target_selPeri").val('99999'); //전체검색을 막기위해
			}
			
		}
	});	
	if(typeof selPeri2 == 'function' ) 
	{
		selPeri2();
	}
}
</script>
<div>
	<select de-data="${branchList[0].SHORT_NAME}" id="target_selBranch" name="target_selBranch" onchange="javascript:target_fncPeri(); target_yearInit();">
		<c:forEach var="i" items="${branchList}" varStatus="loop">
			<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
		</c:forEach>
	</select>
</div>
<div class="sel-scr">
	<select de-data="${year}" id="target_selYear" name="target_selYear" onchange="target_fncPeri()">
		<%
		int year = Utils.checkNullInt(request.getAttribute("year"));
		for(int i = year+1; i > 1980; i--)
		{
			if(i == year)
			{
				%>
				<option value="<%=i%>" selected><%=i%></option>
				<%
			}
			else
			{
				%>
				<option value="<%=i%>"><%=i%></option>
				<%
			}
		}
		%>
	</select>
</div>
<div id="tar_get_season_target" ></div>