(function($) { 
	$(function() {
		$(".menu-ul").clone().appendTo(".gnb-depwr");
		$(".hambtn").click(function(){
			var chk = $(".menu-wrap").css("display");
			if(chk == "none"){
				$(".hambtn").addClass("active");
				$(".menu-ham .menu-wrap").show();
				setTimeout(function(){
					$(".menu-ham .menu-wrap").addClass("active");
					$(".menu-ham .menu-ul > li").eq(0).find(".dep02").slideToggle();
				},500);
				setTimeout(function(){
					$(".menu-ham .menu-ul > li").eq(0).addClass("active");
				},1500)

			}else{
				$(".hambtn").removeClass("active");
				$(".menu-ham .menu-ul > li").removeClass("active");
				$(".menu-ham .menu-wrap").addClass("active-end");
				setTimeout(function(){
					$(".menu-ham .menu-wrap").removeClass("active");
					$(".menu-ham .menu-wrap").hide();
					$(".menu-ham .menu-wrap").removeClass("active-end");
					$(".menu-ham .menu-ul > li").find(".dep02").hide();
				},1000);
			}
		})
		$(".acad-btn").click(function(){
			var chk = $(".myaca-wrap").css("display");
			$(".myaca-wrap").show();
			setTimeout(function(){
				$(".myaca-wrap").addClass("active");
				//$(".menu-ul > li").eq(0).find(".dep02").slideToggle();
			},500);
		})
		$(".aca-clo").click(function(){
			$(".myaca-wrap").removeClass("active");
			setTimeout(function(){
				$(".myaca-wrap").hide();
			},1000);
		})
		$(".search-box").not(".disable").each(function(){
			var btn = $(this).find("p");
			var ul = $(this).find(".sear-ul");
			btn.click(function(){
				var chk = ul.css("display");
				if(chk == "none"){
					$(".search-box .on").removeClass("on");
					$(".sear-ul").hide();
					btn.addClass("on");
				}else{
					btn.removeClass("on");
				}
				ul.slideToggle();
			})
			$(".main-sec").click(function(){
				$(".search-box .on").removeClass("on");
				$(".sear-ul").hide();
			})
		})

		$(".family-tit").click(function(){
			var chk = $(".fam-ul").css("display");
			if(chk == "none"){
				$(".family-tit").addClass("on");
			}else{
				$(".family-tit").removeClass("on");
			}
			$(".fam-ul").slideToggle();
		})

	}); 


	$(function(){
		
		$(".menu-ham .menu-ul > li").click(function(){
			$(".menu-ham .menu-ul > li").removeClass("active");
			$(this).addClass("active");
			$(".menu-ham .menu-ul > li .dep02").hide("slide");
			$(this).find(".dep02").slideToggle();
		})

		$(".menu-img").each(function(){
			var img = $(this).find("img").attr("src");
			$(this).css("background-image","url("+img+")");
		
		});

		$(".main-slide").find(".msli-p").click(function(){
			var chk = $(".main-slide .msli-sns ul").css("display");
			if(chk == "none"){
				$(".main-slide .msli-sns ul").show();
				$(".main-slide .swiper-pagination-bullet").hide();
				setTimeout(function(){
					$(".main-slide .msli-sns ul").hide();
					$(".main-slide .swiper-pagination-bullet").show();
				},5000)
			}else{
				$(".main-slide .msli-sns ul").hide();
				$(".main-slide .swiper-pagination-bullet").show();
			}
		})
	});

	$(function(){
		$(".lnb-ul li").each(function(){
			var $this = $(this);
				href = $this.find("a").attr("href");
				path = location.pathname;
			
			if(href==path){
				$this.addClass("active");
			}

			

		})
	})
	$(function(){
		$(".edit-bg, .close-btn").click(function(){
			$(".edit-popup").fadeOut(200);
		})
	

	})

	$(function(){
		$(".nav-ul01 > li").not(".not-li").each(function(){
			var $this = $(this);
			var ind = $this.index();
			var depth = $(".gnb-depth .menu-ul > li");
			
			$this.mouseenter(function(){
				$(".nav-ul01 > li").removeClass("on");
				depth.hide();
				$(this).addClass("on");
				depth.eq(ind).show();
				$(".gnb-depth").show();

			});
			$(".gnb-depth").mouseleave(function(){
				$(".nav-ul01 > li").removeClass("on");
				depth.hide();
				$(".gnb-depth").hide();

			});

			

		})
	})
	
	
	$(window).ready(function(){
		$(".tab").each(function(){
			var li =	$(this).find(".tab-ul > li");
			var cont = $(this).find(".tab-cont > div");

			li.click(function(){
				var ind = $(this).index();
				cont.removeClass("active");
				li.removeClass("active");
				cont.eq(ind).addClass("active");
				li.eq(ind).addClass("active");

			})
		})
	})

	/*selectbox 관련 */
	$(function(){
		
		$('select').each(function (index, element) {
			var this_id = $(this).attr("id");
			var title = $(this).attr("de-data");
			$(this).wrap("<div class='select-box'></div>");
			$(this).parent(".select-box").prepend("<div class='selectedOption "+this_id+"'></div><ul class='sear-ul "+this_id+"_ul'></ul>")

			$(element).each(function (idx, elm) {
				$('option', elm).each(function (id, el) {
					var op = $(this).attr("value");
					$('.select-box ul:last').append('<li option-data="'+op+'">' + el.text + '</li>');
				});
				$('.select-box ul').hide();
				$('.makeMeUl').children('div.selectedOption').text("select");
			});
			$('.select-box:last').children('div.selectedOption').text(title);
		});
		
		
		$(document).on('click','.selectedOption', function () {
			var $this = $(this);
			 var chk =  $(this).next('ul').css('display');
			  $('.select-box').removeClass('on');
			 if(chk == "none"){
				 $this.parents(".select-box").addClass('on');	
			 }else{
				 $this.parents(".select-box").removeClass('on');
			 }
			$(this).next('ul').slideToggle(200);
			$('.selectedOption').not(this).next('ul').hide();
		   
			
		});
		$(document).on('click','.msear-bar .search-box:not(.search-box-two) > p ', function () {
			$(this).parents('.search-box').find('.selectedOption').trigger('click');   
		});
		$(document).on('click','.msear-bar .search-box-two > p ', function () {
			$(this).parents('.search-box').find('.li-dep .selectedOption').trigger('click');   
		});
		$(document).on('mouseover','.msear-bar .li-dep .sear-ul > li', function () {
			var ind = $(this).index();
			$(".sear-2dep > .select-box").removeClass('on');	
			$(".sear-2dep > .select-box").eq(ind).addClass('on');	
			$(".sear-2dep > .select-box").eq(ind).find('ul').slideToggle(200);
		});

		$(document).on('click','.select-box ul li', function () {
			var $this = $(this);
			var selectedLI = $(this).text();
			var select = $this.parents(".select-box").find("select");
			var ind = $this.index();
			
			select.find("option").eq(ind).attr("selected","selected");
			$(this).parent().prev('.selectedOption').text(selectedLI);
			$this.parents(".select-box").removeClass('on');
			$(this).parent('ul').hide();
			select.trigger("onchange");
			
		});

		$('.select-box').show();
		$('select').hide();

		
	});
//	$(window).load(function(){
//		$(".scroll-d, .sear-ul, .myin-scr").each(function(){
//			$(this).niceScroll({
//				cursorcolor:"#313131",
//				cursorwidth:"4px",
//				cursorborder:'none',
//				background:"#cfb6a4",
//				cursorborderradius:0,
//				autohidemode:'leave',
//					horizrailenabled: false,
//			});
//		})
//		setTimeout(function(){
//			$(".nicescroll-rails").css("opacity","1");
//		},500)
//	})
} ) ( jQuery);