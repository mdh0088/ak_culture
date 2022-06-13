<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="ak_culture.classes.*" %>
<script>
$(document).ready(function(){
	setPeri();
	fncPeri();
	yearInit();
});
function yearInit()
{
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#selBranch").val()
		},
		error : function() 
		{
			console.log("AJAX ERROR");
		},
		success : function(data) 
		{
			console.log(data);
			var result = JSON.parse(data);
			$("#selYear").val(result[0].WEB_TEXT.substring(0,4));
			$(".selYear").html(result[0].WEB_TEXT.substring(0,4));
		}
	});	
	fncPeri();
}

function fncPeri()
{
	if($("#selBranch").val() != '')
	{
		$(".selSeason").show();
		$(".selYear").show();
		$.ajax({
			type : "POST", 
			url : "/common/getPeriList",
			dataType : "text",
			async:false,
			data : 
			{
				selBranch : $("#selBranch").val(),
				selYear : $("#selYear").val()
	// 			selSeason : $("#selSeason").val()
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
					$(".selPeri").html(result[0].PERIOD+" / "+result[0].STORE_NM);
					$("#selPeri").val(result[0].PERIOD);
				}
				else
				{
					$(".selPeri").html("검색된 기수정보가 없습니다.");
					$("#selPeri").val('99999'); //전체검색을 막기위해
	// 				inner += '<select de-data="봄학기 / 기수없음" id="selSeason" name="selSeason" onchange="fncPeri()">';
	// 				inner += '	<option value="봄학기">봄학기 / 기수없음</option>';
	// 				inner += '	<option value="여름학기">여름학기 / 기수없음</option>';
	// 				inner += '	<option value="가을학기">가을학기 / 기수없음</option>';
	// 				inner += '	<option value="겨울학기">겨울학기 / 기수없음</option>';
	// 				inner += '</select>';
					
				}
				
				for(var i = 0; i < result.length; i++)
				{
					if(is_spring && result[i].WEB_TEXT.indexOf("봄") > -1)
					{
						if(i == 0)
						{
							inner += '<select de-data="봄학기 / '+result[i].PERIOD+'" id="selSeason" name="selSeason" onchange="fncPeri2()">';
						}
						inner += '<option value="봄학기">봄학기 / '+result[i].PERIOD+'</option>';
						is_spring = true;
					}
					if(is_summer && result[i].WEB_TEXT.indexOf("여름") > -1)
					{
						if(i == 0)
						{
							inner += '<select de-data="여름학기 / '+result[i].PERIOD+'" id="selSeason" name="selSeason" onchange="fncPeri2()">';
						}
						inner += '<option value="여름학기">여름학기 / '+result[i].PERIOD+'</option>';
						is_summer = true;
					}
					if(is_autumn && result[i].WEB_TEXT.indexOf("가을") > -1)
					{
						if(i == 0)
						{
							inner += '<select de-data="가을학기 / '+result[i].PERIOD+'" id="selSeason" name="selSeason" onchange="fncPeri2()">';
						}
						inner += '<option value="가을학기">가을학기 / '+result[i].PERIOD+'</option>';
						is_autumn = true;
					}
					if(is_winter && result[i].WEB_TEXT.indexOf("겨울") > -1)
					{
						if(i == 0)
						{
							inner += '<select de-data="겨울학기 / '+result[i].PERIOD+'" id="selSeason" name="selSeason" onchange="fncPeri2()">';
						}
						inner += '<option value="겨울학기">겨울학기 / '+result[i].PERIOD+'</option>';
						is_winter = true;
					}
				}
				if(!is_spring && !is_summer && !is_autumn && !is_winter)
				{
					inner += '<select de-data="봄학기 / 기수없음" id="selSeason" name="selSeason" onchange="fncPeri()">';
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
				
				$("#season_target").html(inner);
				selectInit_one('selSeason');
			}
		});	
		//혹시나 작업중에 기수정보를 바꿨을때 실행되는 함수입니다.
		if(typeof periInit == 'function' ) 
		{
			periInit();
		}
		if(typeof selPeri == 'function' ) 
		{
			selPeri();
		}
		if(typeof selPeri1 == 'function' ) 
		{
			selPeri1();
		}
	}
	else
	{
		$(".selSeason").hide();
		$(".selYear").hide();
	}
}
function fncPeri2()
{
	
	//혹시나 작업중에 기수정보를 바꿨을때 실행되는 함수입니다.
	/*
	if(typeof periInit == 'function' ) 
	{
		periInit();
	}
	*/
	
	$.ajax({
		type : "POST", 
		url : "/common/getPeriList",
		dataType : "text",
		async:false,
		data : 
		{
			selBranch : $("#selBranch").val(),
			selYear : $("#selYear").val(),
			selSeason : $("#selSeason").val()
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
			if(result.length > 0)
			{
				$(".selPeri").html(result[0].PERIOD+" / "+result[0].STORE_NM);
				$("#selPeri").val(result[0].PERIOD);
			}
			else
			{
				$(".selPeri").html("검색된 기수정보가 없습니다.");
				$("#selPeri").val('99999'); //전체검색을 막기위해
			}
			if(typeof selPeri == 'function' ) 
			{
				selPeri();
			}
			if(typeof selPeri1 == 'function' ) 
			{
				selPeri1();
			}
			
		}
	});	
	if(typeof periInit == 'function' ) 
	{
		periInit();
	}
}
</script>
<div>
	<select de-data="${branchList[0].SHORT_NAME}" id="selBranch" name="selBranch" onchange="javascript:fncPeri(); yearInit();">
		<c:forEach var="i" items="${branchList}" varStatus="loop">
			<option value="${i.SUB_CODE}">${i.SHORT_NAME}</option> 
		</c:forEach>
	</select>
</div>
<div class="sel-scr">
	<select de-data="${year}" id="selYear" name="selYear" onchange="fncPeri()">
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
<div id="season_target"></div>