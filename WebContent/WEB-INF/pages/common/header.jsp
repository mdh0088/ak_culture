<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<meta http-equiv="X-UA-Compatible" content="IE=11">
<script>
var isLogin = "<%=session.getAttribute("login_id")%>";
var link = location.href;
if ((isLogin == null || isLogin == "null") && link.indexOf("admin/basic/user/login") == -1) {
	alert("로그인 후 이용해주세요.");
	location.href = "/basic/user/login";
}

var login_rep_store = "<%=session.getAttribute("login_rep_store")%>";
var login_rep_store_nm = "<%=session.getAttribute("login_rep_store_nm")%>";
</script>
<html>
	<head>
		<meta charset="utf-8">
		<title>AK문화아카데미</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="shortcut icon" href="data:image/x-icon;," type="image/x-icon">
		<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
		<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
		<script src="http://malsup.github.io/min/jquery.form.min.js"></script>
		<script src="/inc/js/musign.js"></script>
		<script src="/inc/js/jquery.breadcrumbs-generator.js"></script>
		<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500|Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp">
		<script src="/inc/js/function.js"></script>
		<link rel="stylesheet" href="/inc/css/admin.css">
		<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
		<script>
		var loopStat = true;
		$.ajaxSetup({
			error: function(x, e){
				if(x.status == 555){
					loopStat = false;
					alert("해당 기능의 접근 권한이 없습니다.");
				}else{
					console.log("ajax error");
				}
			}
		});
		function changeScr()
		{
			resetCookie();
			if($("#scr_stat").html() == 'ON')
			{
				setCookie("scr_stat", "OFF", 9999);
				$("#scr_stat").html('OFF');
				$("#scr_stat").removeClass('on');
				$("#scr_stat").addClass('off');
			}
			else
			{
				setCookie("scr_stat", "ON", 9999);
				$("#scr_stat").html('ON');
				$("#scr_stat").removeClass('off');
				$("#scr_stat").addClass('on');
			}
			var nowLink = location.href.replace(location.host, "");
			nowLink = nowLink.replace("http://", "");
			nowLink = nowLink.replace("https://", "");
			location.href=nowLink;
		}
		function changePrint(val)
		{
			if($("#"+val+"_print_stat").html() == 'ON')
			{
				setCookie(val+"_print_stat", "OFF", 9999);
				$("#"+val+"_print_stat").html('OFF');
				$("#"+val+"_print_stat").removeClass('on');
				$("#"+val+"_print_stat").addClass('off');
			}
			else
			{
				setCookie(val+"_print_stat", "ON", 9999);
				$("#"+val+"_print_stat").html('ON');
				$("#"+val+"_print_stat").removeClass('off');
				$("#"+val+"_print_stat").addClass('on');
			}
			var nowLink = location.href.replace(location.host, "");
			nowLink = nowLink.replace("http://", "");
			nowLink = nowLink.replace("https://", "");
			location.href=nowLink;
		}
		$(document).ready(function(){
			$('.waitForLoad').hide();
			var scr_stat = getCookie("scr_stat");
			if(scr_stat == "ON")
			{
				$("#scr_stat").html('ON');
				$("#scr_stat").removeClass('off');
				$("#scr_stat").addClass('on');
			}
			else if(scr_stat == "OFF")
			{
				$("#scr_stat").html('OFF');
				$("#scr_stat").removeClass('on');
				$("#scr_stat").addClass('off');
			}
			else
			{
				$("#scr_stat").html('ON');
				$("#scr_stat").removeClass('off');
				$("#scr_stat").addClass('on');
				setCookie("scr_stat", "ON", 9999);
			}
			
			
			var nowLink = location.href.replace(location.host, "");
			nowLink = nowLink.replace("http://", "");
			nowLink = nowLink.replace("https://", "");
			if(nowLink.indexOf("member/lect/view") > -1)
			{
				$("#c_print_ul").show();
				$("#a_print_ul").show();
			}
			var c_print_stat = getCookie("c_print_stat");
			var a_print_stat = getCookie("a_print_stat");
			if(c_print_stat == "ON")
			{
				$("#c_print_stat").html('ON');
				$("#c_print_stat").removeClass('off');
				$("#c_print_stat").addClass('on');
			}
			else if(c_print_stat == "OFF")
			{
				$("#c_print_stat").html('OFF');
				$("#c_print_stat").removeClass('on');
				$("#c_print_stat").addClass('off');
			}
			else
			{
				$("#c_print_stat").html('ON');
				$("#c_print_stat").removeClass('off');
				$("#c_print_stat").addClass('on');
				setCookie("c_print_stat", "ON", 9999);
			}
			if(a_print_stat == "ON")
			{
				$("#a_print_stat").html('ON');
				$("#a_print_stat").removeClass('off');
				$("#a_print_stat").addClass('on');
			}
			else if(a_print_stat == "OFF")
			{
				$("#a_print_stat").html('OFF');
				$("#a_print_stat").removeClass('on');
				$("#a_print_stat").addClass('off');
			}
			else
			{
				$("#a_print_stat").html('ON');
				$("#a_print_stat").removeClass('off');
				$("#a_print_stat").addClass('on');
				setCookie("a_print_stat", "ON", 9999);
			}
	
			$(window).scroll(function(){
				var winTop = $(window).scrollTop();

			/*서브 메뉴 스크롤 fixed 이벤트 
				if(winTop >= 78){
					$('.infi-fix').addClass('fix');
					$('.contain').addClass('fix');
					
				}else{
					$('.infi-fix').removeClass('fix');
					$('.contain').removeClass('fix');
				}*/
				
			});
			
			//로그인 정보
			$("#login_ip").html('<%=(String)session.getAttribute("ip_addr")%>');
			$("#login_name").html('<%=(String)session.getAttribute("login_name")%>');
			var last_login = '<%=(String)session.getAttribute("last_login")%>';
			last_login = last_login.substring(2,4) + "-" + last_login.substring(4,6) + "-" +last_login.substring(6,8) + " " + 
			last_login.substring(8,10) + ":" + last_login.substring(10,12) + ":" + last_login.substring(12,14);
			$("#last_login").html(last_login);
			//로그인 정보
			
			//즐겨찾기 항목 검색
			var nowLink = location.href.replace(location.host, "");
			nowLink = nowLink.replace("http://", "");
			nowLink = nowLink.replace("https://", "");
			$.ajax({
				type : "POST", 
				url : "/common/getBookmark",
				dataType : "text",
				async : false,
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
						var bookmarkArr = nullChk(result[0].BOOKMARK).split("|");
						var titleArr = nullChk(result[0].TITLE).split("|");
						
						for(var i = 0; i < bookmarkArr.length; i++)
						{
							if(bookmarkArr[i].indexOf(nowLink) > -1)
							{
								$(".star").show();
							}
							$(".gnb-ul").append('<li> <a href="'+bookmarkArr[i]+'">'+titleArr[i]+'</a> </li>');
							
						}
					}
				}
			});
			//즐겨찾기 항목 검색
			
		});
		function bookmark(act)
		{
			var nowLink = location.href.replace(location.host, "");
			nowLink = nowLink.replace("http://", "");
			nowLink = nowLink.replace("https://", "");
			
			var tit = $(".sub-tit").find("h2").html();
			$.ajax({
				type : "POST", 
				url : "/common/setBookmark",
				dataType : "text",
				async : false,
				data : 
				{
					act : act,
					link : nowLink,
					tit : tit
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
		    			location.reload();
		    		}
		    		else
		    		{
		    			alert(result.msg);
		    		}
				}
			});
		}
	
		$(document).ready(function(){
			$(".infi-btn").each(function(){
				var $this = $(this);
				var btn = $(this).find(".infi-b");
				
				$this.click(function(){
					btn.toggleClass("act");	
				})
				
			})
		});
		$(document).ready(function(){
			$(".onoff").each(function(){
				var $this = $(this);
				var cli = $(this).find(".o2-li");
				
				$this.click(function(){
					cli.toggleClass("act");				
				})
				
			})
		});
		
		$(document).ready(function(){
			$(".list-edit-wrap").prepend("<div class='pop-bg'></div>");
			$(".list-edit-wrap .pop-bg").click(function(){
				$(".list-edit-wrap").fadeOut(200);
				
			})
		});
		
		$(document).ready(function(){
			$(".table-top").click(function(){
				$($(this).attr("href"))
				.attr("tabindex","0")
				.css("outline","0")
				.focus();
			});
		 });
		
		</script>
	</head>
	<body>
		<div class="waitForLoad" style="position:fixed; left:0; top:0; width:100%; height:100%;">
			<img src="/upload/loading/loading.gif" >
		</div>
		<div id="header">
		
		
			<div class="header-wr table">
				<div class="logo"><a href="/basic/user/list"><img src="/img/header-logo.png"></a></div>
				<div class="header-wrap">
					<div class="bene">
						<div><i class="material-icons" onclick="bookmark('on')">star_border</i></div>
						<div class="star"><i class="material-icons" onclick="bookmark('off')">star</i></div>
						
					</div>
					<div class="bene-list">
						<div class="gnb-p">즐겨찾기 메뉴</div>
						
						<ul class="gnb-ul">		
						</ul>
					</div>
				</div>
				<div class="gnb-ri">
					<ul class="gnb-ip">
						<li>현재접속 IP : <span id="login_ip"></span></li>
						<li id="login_name"></li>
						<li id="last_login">20-01-29 17:52:46</li>
					</ul>
					<ul class="infi" onclick="changeScr()">
						<li>Scroll</li>
						<li class="onoff">
							<div class="o2-li act" id="scr_stat">ON</div>
						</li>
					</ul>
					<ul class="infi" onclick="changePrint('c')" id="c_print_ul" style="display:none;">
						<li>고객영수증</li>
						<li class="onoff">
							<div class="o2-li act" id="c_print_stat">ON</div>
						</li>
					</ul>
					<ul class="infi" onclick="changePrint('a')" id="a_print_ul" style="display:none;">
						<li>가맹영수증</li>
						<li class="onoff">
							<div class="o2-li act" id="a_print_stat">ON</div>
						</li>
					</ul>
					<ul class="gnb-info">						
						<li><A href="#"><i class="material-icons material-icons-round">description</i>매뉴얼 ver 1.2</A></li>
						<li class="adm-menu"><A href="#"><i class="material-icons material-icons-round">person</i>Administor <i class="material-icons">arrow_drop_down</i></A>
							<ul class="adm-drop">
								<li><a href="/basic/user/logout"><i class="material-icons material-icons-round">exit_to_app</i>Logout</a></li>
							</ul>
						</li>
<!-- 						<li class="bell"><A style="cursor:pointer;"><i class="material-icons material-icons-round">notifications</i><span class="bellcount">1</span></A></li>			 -->
					</ul>
				</div>
			</div>
		</div>
		
		
		
		
