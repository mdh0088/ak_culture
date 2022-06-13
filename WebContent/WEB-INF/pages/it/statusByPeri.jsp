<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/pages/common/header.jsp"/>
<jsp:include page="/WEB-INF/pages/common/lnb.jsp"/>
<jsp:include page="/inc/date_picker/date_picker_month.html"/>
<jsp:include page="/WEB-INF/pages/common/excelDown.jsp"/>

<script>
function excelDown()
{
	var filename = "기수별 강사료 지급현황";
	var table = "excelTable";
    exportExcel(filename, table);
}
$(document).ready(function(){
	setPeri();
	fncPeri();
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
function comVat(val, vat_fg)
{
	var vat = 0;
	if(vat_fg == "YC")
	{
		vat = Math.floor((Number(val) / 1.1) * 0.1);
	}
	
	return Number(vat);
}
function comIncome(val)
{
	var income = Math.floor((Number(val) * 0.03) * 0.1) * 10;
	if(income < 1000)
	{
		income = 0;
	}
	return Number(income);
}
function comResi(val)
{
	var resi = Math.floor(((Number(val) * 0.03) * 0.1) * 0.1) * 10;
	if(comIncome(val) < 1000)
	{
		resi = 0;
	}
	return Number(resi);
}
function getList()
{
	getListStart();

	$.ajax({
		type : "POST", 
		url : "./getStatusByPeriList",
		dataType : "text",
		data : 
		{
			store : $("#selBranch").val(),
			period : $("#selPeri").val()
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
			
			var tot1 = 0;
			var tot2 = 0;
			var tot3 = 0;
			var tot4 = 0;
			var tot5 = 0;
			var tot6 = 0;
			if(result.length > 0)
			{
				var lecture_nm = "";
				var subject_nm = "";
				$("#list_target").html('');
				for(var i = 0; i < result.length; i++)
				{
					var lect_pay1 = nullChkZero(result[i].LECT_PAY_1);
					var lect_pay2 = nullChkZero(result[i].LECT_PAY_2);
					var lect_pay3 = nullChkZero(result[i].LECT_PAY_3);
					console.log(lect_pay3);
					
					if(result[i].CORP_FG == "1")
					{
						var vat1 = comVat(lect_pay1, result[i].VAT_FG);
						var vat2 = comVat(lect_pay2, result[i].VAT_FG);
						var vat3 = comVat(lect_pay3, result[i].VAT_FG);
						
						var net_lect_pay1 = lect_pay1 - vat1;
						var net_lect_pay2 = lect_pay2 - vat2;
						var net_lect_pay3 = lect_pay3 - vat3;
						inner += '<tr>';
						inner += '	<td>'+result[i].BIZ_NM+'</td>';
						inner += '	<td>'+comma(lect_pay1+lect_pay2+lect_pay3)+'</td>';
						inner += '	<td>'+comma(vat1+vat2+vat3)+'</td>';
						inner += '	<td>'+comma(net_lect_pay1+net_lect_pay2+net_lect_pay3)+'</td>';
						inner += '	<td>'+comma(net_lect_pay1)+'</td>';
						inner += '	<td>'+comma(net_lect_pay2)+'</td>';
						inner += '	<td>'+comma(net_lect_pay3)+'</td>';
						inner += '</tr>';
						
						tot1 += lect_pay1+lect_pay2+lect_pay3;
						tot2 += vat1+vat2+vat3;
						tot3 += net_lect_pay1+net_lect_pay2+net_lect_pay3;
						tot4 += net_lect_pay1;
						tot5 += net_lect_pay2;
						tot6 += net_lect_pay3;
					}
					if(result[i].CORP_FG == "2")
					{
						var resi1 = comResi(lect_pay1);
						var resi2 = comResi(lect_pay2);
						var resi3 = comResi(lect_pay3);
						
						var income1 = comIncome(lect_pay1);
						var income2 = comIncome(lect_pay2);
						var income3 = comIncome(lect_pay3);
						
						var net_lect_pay1 = lect_pay1 - resi1 - income1;
						var net_lect_pay2 = lect_pay2 - resi2 - income2;
						var net_lect_pay3 = lect_pay3 - resi3 - income3;
						
						inner += '<tr>';
						inner += '	<td>'+result[i].LECTURER_KOR_NM+'</td>';
						inner += '	<td>'+comma(lect_pay1+lect_pay2+lect_pay3)+'</td>';
						inner += '	<td>'+comma(resi1+resi2+resi3+income1+income2+income3)+'</td>';
						inner += '	<td>'+comma(net_lect_pay1+net_lect_pay2+net_lect_pay3)+'</td>';
						inner += '	<td>'+comma(net_lect_pay1)+'</td>';
						inner += '	<td>'+comma(net_lect_pay2)+'</td>';
						inner += '	<td>'+comma(net_lect_pay3)+'</td>';
						inner += '</tr>';
						
						tot1 += lect_pay1+lect_pay2+lect_pay3;
						tot2 += resi1+resi2+resi3+income1+income2+income3;
						tot3 += net_lect_pay1+net_lect_pay2+net_lect_pay3;
						tot4 += net_lect_pay1;
						tot5 += net_lect_pay2;
						tot6 += net_lect_pay3;
					}
// 					var isIn = false;
// 					if(i != 0 && result.list[i].WEB_LECTURER_NM == result.list[i-1].WEB_LECTURER_NM && result.list[i].SUBJECT_NM == result.list[i-1].SUBJECT_NM  && result.list[i].SUBJECT_CD == result.list[i-1].SUBJECT_CD)
// 					{
// 						if(result.list[i].LECT_YM == result.lect_ym1)
// 						{
// 							$("#td_"+(i-1)+"_1").html(comma(result.list[i].NET_LECT_PAY));
// 						}
// 						if(result.list[i].LECT_YM == result.lect_ym2)
// 						{
// 							$("#td_"+(i-1)+"_2").html(comma(result.list[i].NET_LECT_PAY));
// 						}
// 						if(result.list[i].LECT_YM == result.lect_ym3)
// 						{
// 							$("#td_"+(i-1)+"_3").html(comma(result.list[i].NET_LECT_PAY));
// 						}
// 						if(document.getElementById("td_"+(i-1)+"_tot"))
// 						{
// 							var tot = Number($("#td_"+(i-1)+"_tot").html().replace(/,/gi, "")); 
// 							tot += Number(result.list[i].NET_LECT_PAY);
// 							$("#td_"+(i-1)+"_tot").html(comma(tot));
// 						}
// 						isIn = true;
// 					}
// 					if(i != 0 && i != 1 && result.list[i].WEB_LECTURER_NM == result.list[i-2].WEB_LECTURER_NM && result.list[i].SUBJECT_NM == result.list[i-2].SUBJECT_NM && result.list[i].SUBJECT_CD == result.list[i-1].SUBJECT_CD)
// 					{
// 						if(result.list[i].LECT_YM == result.lect_ym1)
// 						{
// 							$("#td_"+(i-2)+"_1").html(comma(result.list[i].NET_LECT_PAY));
// 						}
// 						if(result.list[i].LECT_YM == result.lect_ym2)
// 						{
// 							$("#td_"+(i-2)+"_2").html(comma(result.list[i].NET_LECT_PAY));
// 						}
// 						if(result.list[i].LECT_YM == result.lect_ym3)
// 						{
// 							$("#td_"+(i-2)+"_3").html(comma(result.list[i].NET_LECT_PAY));
// 						}
// 						if(document.getElementById("td_"+(i-2)+"_tot"))
// 						{
// 							var tot = Number($("#td_"+(i-2)+"_tot").html().replace(/,/gi, "")); 
// 							tot += Number(result.list[i].NET_LECT_PAY);
// 							$("#td_"+(i-2)+"_tot").html(comma(tot));
// 						}
// 						isIn = true;
// 					}
// 					if(!isIn)
// 					{
// 						inner += '<tr>';
// 						inner += '	<td>'+result.list[i].SUBJECT_FG_NM+'</td>';
// 						inner += '	<td>'+result.list[i].WEB_LECTURER_NM+'</td>';
// 						inner += '	<td>'+result.list[i].SUBJECT_NM+'</td>';
// 						inner += '	<td>'+result.list[i].FIX_PAY_YN+'</td>';
// 						if(result.list[i].FIX_PAY_YN == "정액")
// 						{
// 							inner += '	<td>'+comma(result.list[i].FIX_AMT)+'</td>';
// 						}
// 						else
// 						{
// 							inner += '	<td>'+result.list[i].FIX_RATE+'</td>';
// 						}
// 						inner += '	<td id="td_'+i+'_tot" class="td_tot">'+comma(result.list[i].NET_LECT_PAY)+'</td>';
// 						if(result.list[i].LECT_YM == result.lect_ym1)
// 						{
// 							inner += '	<td id="td_'+i+'_1" class="td_1">'+comma(result.list[i].NET_LECT_PAY)+'</td>';
// 						}
// 						else
// 						{
// 							inner += '	<td id="td_'+i+'_1" class="td_1"></td>';
// 						}
// 						if(result.list[i].LECT_YM == result.lect_ym2)
// 						{
// 							inner += '	<td id="td_'+i+'_2" class="td_2">'+comma(result.list[i].NET_LECT_PAY)+'</td>';
// 						}
// 						else
// 						{
// 							inner += '	<td id="td_'+i+'_2" class="td_2"></td>';
// 						}
// 						if(result.list[i].LECT_YM == result.lect_ym3)
// 						{
// 							inner += '	<td id="td_'+i+'_3" class="td_3">'+comma(result.list[i].NET_LECT_PAY)+'</td>';
// 						}
// 						else
// 						{
// 							inner += '	<td id="td_'+i+'_3" class="td_3"></td>';
// 						}
// 						inner += '</tr>';
// 					}
// 					$("#list_target").append(inner);
// 					inner = "";
					
				}
			}
			else
			{
				inner += '<tr>';
				inner += '	<td colspan="7"><div class="no-data">검색결과가 없습니다.</div></td>';
				inner += '</tr>';
			}
			$("#list_target").html(inner);
			
// 			var td_tot = 0;
// 			var td_1 = 0;
// 			var td_2 = 0;
// 			var td_3 = 0;
// 			$('.td_tot').each(function(){
// 				var amt = $(this).html();
// 				if(amt != "")
// 				{
// 					td_tot += Number(nullChkZero(amt));
// 				}
// 			})
// 			$('.td_1').each(function(){
// 				var amt = $(this).html();
// 				if(amt != "")
// 				{
// 					td_1 += Number(nullChkZero(amt));
// 				}
// 			})
// 			$('.td_2').each(function(){
// 				var amt = $(this).html();
// 				if(amt != "")
// 				{
// 					td_2 += Number(nullChkZero(amt));
// 				}
// 			})
// 			$('.td_3').each(function(){
// 				var amt = $(this).html();
// 				if(amt != "")
// 				{
// 					td_3 += Number(nullChkZero(amt));
// 				}
// 			})
// 			var fin_inner = "";
// 			fin_inner += '<ul>';
// 			fin_inner += '	<li class="first">총 '+result.list.length+'건</li>';
// 			fin_inner += '	<li class="li02">계</li>';
// 			fin_inner += '	<li class="li03">'+comma(td_tot)+'</li>';
// 			fin_inner += '	<li class="li04">'+comma(td_1)+'</li>';
// 			fin_inner += '	<li class="li05">'+comma(td_2)+'</li>';
// 			fin_inner += '	<li class="li06">'+comma(td_3)+'</li>';
// 			//fin_inner += '	<li class="li07"></li>';
// 			fin_inner += '</ul>';
// 			$("#final_div").html(fin_inner);

			$(".first").html("총 "+result.length+"건");
			$(".li01").html(comma(tot1));
			$(".li02").html(comma(tot2));
			$(".li03").html(comma(tot3));
			$(".li04").html(comma(tot4));
			$(".li05").html(comma(tot5));
			$(".li06").html(comma(tot6));
			
			
			getListEnd();
		}
	});	
}
</script>
<div class="sub-tit">
	<h2>기수별 강사료 지급현황</h2>
	<a href="/"><i class="material-icons bc-home">home</i></a>
	<ul id="breadcrumbs" class="breadcrumb"></ul>

</div>


<div class="table-top">
	<div class="table">
		<div class="wid-4">
			<div class="table table-auto">
				<div class="wid-3">
					<div class="table table-auto">
						<jsp:include page="/WEB-INF/pages/common/peri1.jsp"/>
					</div>
					<div class="oddn-sel sel-scr">
						<jsp:include page="/WEB-INF/pages/common/peri2.jsp"/>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	<input class="search-btn02 btn btn02" type="button" value="Search" onclick="javascript:getList();">
</div>

<div class="table-cap table">
	<div class="cap-r text-right">
		<div class="table float-right">
			<div class="sel-scr">
				<a class="bor-btn btn01 mrg-l6" onclick="javascript:excelDown();"><i class="fas fa-file-download"></i></a>
			</div>
		</div>
	</div>
</div>
<div class="table-wr ">
	<div class="table-list  table-csplist">
		<table id="excelTable">
			<colgroup>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
				<col>
			</colgroup>
			<thead>
				<tr>
					<th>법인/강사명</th>
					<th>총 지급액</th>
					<th>총 세액</th>
					<th>총 공급액</th>
					<th>1차 실지급액</th>
					<th>2차 실지급액</th>
					<th>3차 실지급액</th>
				</tr>
				
			</thead>
			<tbody id="list_target">
<!-- 				<tr>					 -->
<!-- 					<td>이호걸</td>	 -->
<!-- 					<td>850402-1******</td> -->
<!-- 					<td>왕초보 줌마 영어반Ⅰ</td> -->
<!-- 					<td class="color-blue line-blue">24</td>					 -->
<!-- 					<td>550,000</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>1,650</td> -->
<!-- 					<td>4,835</td> -->
<!-- 					<td>43,515</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>921637-01-526312</td> -->
<!-- 					<td>2019-09-01</td>			 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td></td>	 -->
<!-- 					<td></td> -->
<!-- 					<td>왕초보 줌마 영어반Ⅰ</td> -->
<!-- 					<td class="color-blue line-blue">24</td>					 -->
<!-- 					<td>550,000</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>1,650</td> -->
<!-- 					<td>4,835</td> -->
<!-- 					<td>43,515</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td>2019-09-01</td>			 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr class="bg-red">					 -->
<!-- 					<td colspan="4">계</td>					 -->
<!-- 					<td>1,100,000</td> -->
<!-- 					<td colspan="2"></td>				 -->
<!-- 					<td>100,000</td> -->
<!-- 					<td>3,300</td> -->
<!-- 					<td>9,670</td> -->
<!-- 					<td>87,030</td> -->
<!-- 					<td colspan="5"></td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr>					 -->
<!-- 					<td>이호걸</td>	 -->
<!-- 					<td>850402-1******</td> -->
<!-- 					<td>왕초보 줌마 영어반Ⅰ</td> -->
<!-- 					<td class="color-blue line-blue">24</td>					 -->
<!-- 					<td>550,000</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>1,650</td> -->
<!-- 					<td>4,835</td> -->
<!-- 					<td>43,515</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td>국민</td> -->
<!-- 					<td>921637-01-526312</td> -->
<!-- 					<td>2019-09-01</td>			 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
<!-- 				<tr>					 -->
<!-- 					<td></td>	 -->
<!-- 					<td></td> -->
<!-- 					<td>왕초보 줌마 영어반Ⅰ</td> -->
<!-- 					<td class="color-blue line-blue">24</td>					 -->
<!-- 					<td>550,000</td> -->
<!-- 					<td>정률</td> -->
<!-- 					<td>50</td> -->
<!-- 					<td>50,000</td> -->
<!-- 					<td>1,650</td> -->
<!-- 					<td>4,835</td> -->
<!-- 					<td>43,515</td> -->
<!-- 					<td>2019-11-10</td> -->
<!-- 					<td></td> -->
<!-- 					<td></td> -->
<!-- 					<td>2019-09-01</td>			 -->
<!-- 					<td>소윤진</td>									 -->
<!-- 				</tr> -->
				
<!-- 				<tr class="bg-red">					 -->
<!-- 					<td colspan="4">계</td>					 -->
<!-- 					<td>1,100,000</td> -->
<!-- 					<td colspan="2"></td>				 -->
<!-- 					<td>100,000</td> -->
<!-- 					<td>3,300</td> -->
<!-- 					<td>9,670</td> -->
<!-- 					<td>87,030</td> -->
<!-- 					<td colspan="5"></td>									 -->
<!-- 				</tr> -->
				
			
			</tbody>
		</table>
	</div>
	<div class="total-fix total-fix04" id="final_div">
		<ul>
			<li class="first">총 725건</li>
			<li class="li01">374,550,000</li>
			<li class="li02"></li>
			<li class="li03">187,225,000</li>
			<li class="li04">154,211</li>
			<li class="li05">243,154</li>
			<li class="li06">243,154</li>
			<li class="li07"></li>
		</ul>
	</div>
	
</div>



<div id="write_layer" class="list-edit-wrap">
	<div class="le-cell">
		<div class="le-inner">
        	<div class="list-edit white-bg itend-edit">
        		<div class="close" onclick="javascript:$('#write_layer').fadeOut(200); close_act();">
        			닫기<i class="far fa-window-close"></i>
        		</div>
				<div>
				<!-- 여기 -->
					<form id="fncFormIp" name="fncFormIp" method="POST">
						<h3 class="status_now">작업 현황</h3>
						<div class="top-row change-wrap">
							<div class="wid10">
								<div class="table-list table-list_end">
									<table>
										<thead>
											<tr>
												<th>NO<i class="material-icons">import_export</i></th>
												<th>분개일시<i class="material-icons">import_export</i></th>
												<th>분개여부<i class="material-icons">import_export</i></th>
												<th>담당자<i class="material-icons">import_export</i></th>
												<th>전송건<i class="material-icons">import_export</i></th>
											</tr>
											
										</thead>
										<tbody>
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
<!-- 											<tr> -->
<!-- 												<td>1</td> -->
<!-- 												<td>2020-03-19 17:24</td> -->
<!-- 												<td>분개전송</td> -->
<!-- 												<td>이호걸</td> -->
<!-- 												<td>142</td> -->
<!-- 											</tr> -->
										</tbody>
									
									</table>
								</div>
							</div>
							
						</div>
					</form>
					<div class="btn-wr text-center">
						<a class="btn btn02 ok-btn" onclick="javascript:fncSubmitIp();">확인</a>
					</div>
				</div>
        	</div>
        </div>
    </div>	
</div>
<script>
$(document).ready(function(){
	getList();
});
</script>


<jsp:include page="/WEB-INF/pages/common/footer.jsp"/>