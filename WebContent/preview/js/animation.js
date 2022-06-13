(function($) { 
	$(function(){
		$(".slide-text").children("*").addClass("eff-t")
		$(".eff-t").each(function(){
			$(this).wrapInner("<b></b>");
		})
	})
	$(window).load(function(){
		img_event();
		effT();
		$(window).scroll(function(e){
			var s = $(window).scrollTop();	// 현재 window scrollTop
			if(s>50){
				img_event();
				effT();
			}
		})

		$(window).scroll(function(e){
			var s = $(window).scrollTop();	// 현재 window scrollTop
			if(s>50){
				img_event();
				effT();
			}
		})

		function img_event(){
			$(".img-ani").each(function(){
				var w_t = $(window).scrollTop() + $(window).height();
				var i_t = $(this).offset().top;
				if(w_t > i_t + 200){
					$(this).addClass("img-aniload");
				}
			})
		}
		function effT(){
//			$(".eff-t").not(".main .eff-t").each(function(){
			$(".eff-t").each(function(){
				var w_t = $(window).scrollTop() + $(window).height();
				var i_t = $(this).offset().top;

				if(w_t > i_t){
					$(this).addClass("on");
				}
			})
		}
	})

	
	
} ) ( jQuery);