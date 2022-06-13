$(function(){
  
	  let isChrome = /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);

	  let scenes = [];
	  let y = 0;
	  
	  // initial smooth-scrollbar
	  let scroll = Scrollbar.init(
		document.querySelector("#container-scroll")
	  );
	  
	 
	  // initiate ScrollMagic Controller
	  let controller = 
		  new ScrollMagic.Controller(
				{
					refreshInterval: 0,
				}
		  );
	  
	  // update scrollY controller
	  if(isChrome){
		controller.scrollPos(function () {
		  return y;
		});
	  }
	 
	  // initiate ScrollMagic Scene each section
	  $(".ani-eff.text").each(function(){
		let text = $(this);
		
		let tl = new TimelineMax();
			tl.to(text, 1, { yPercent: -15, rotation: 0.01 }, "start")
		
		scenes.push(
		  new ScrollMagic
				.Scene(
					{ offset: 100 , triggerHook: "onEnter", triggerElement: $(this)[0], duration: $(window).height(), reverse:true })
				.setTween(tl)
				.on("leave", function(){
				  //console.log('leave scene');
				})
				.on("enter", function(){
				  //console.log('enter scene');
				})
				.on("progress", function(e){
				  //console.log("progress => ", e.progress);
				})
				.addTo(controller)
		  );
		});

		// initiate ScrollMagic Scene each section
		$(".ani-eff.image").each(function(){
			let image = $(this).find("img");

			let tl = new TimelineMax();
				tl.to(image, 1, { autoAlpha: 1, yPercent: 0, scale: 1.1 }, "start")

			scenes.push(
			  new ScrollMagic
					.Scene(
						{ offset: 100 , triggerHook: "onEnter", triggerElement: $(this)[0], duration: $(window).height(), reverse:true })
					.setTween(tl)
					.on("leave", function(){
					  //console.log('leave scene');
					})
					.on("enter", function(){
					  //console.log('enter scene');
					})
					.on("progress", function(e){
					  //console.log("progress => ", e.progress);
					})
					.addTo(controller)
			);
		});


	  // listener smooth-scrollbar, update controller
	  scroll.addListener(function(status) {

		y = status.offset.y;
		
		if(isChrome){ 
		  controller.update();
		} else {
		  scenes.forEach(function(scene){
				 scene.refresh();       
		  });
		}
		
	  });
	  
	  
});
$(window).load(function(){
	var wh = $(window).height();
	var h = $(".scroll-content").height();
	var agent = navigator.userAgent.toLowerCase();
	$(".rline-h").css("height",wh/h*100+"%");
	height();
	scroll();
	//window.addEventListener("mousewheel", function () {
	$(window).on("DOMMouseScroll wheel", function (event) {
		setTimeout(function(){
			height()
		},100)
		scroll();
	});
	function height(){
		if ((navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1)) {
			var top = $(".scroll-content").css("transform").match(/matrix(?:(3d)\(-{0,1}\d+(?:, -{0,1}\d+)*(?:, (-{0,1}\d+))(?:, (-{0,1}\d+))(?:, (-{0,1}\d+)), -{0,1}\d+\)|\(-{0,1}\d+(?:, -{0,1}\d+)*(?:, (-{0,1}\d+))(?:, (-{0,1}\d+))\))/);
			var top2 = top[3]*-1;
			$(".rline-h").css("top",top2/h*100+"%");			
		}else{
			var top = $(".scroll-content").css("transform").match(/matrix(?:(3d)\(-{0,1}\d+(?:, -{0,1}\d+)*(?:, (-{0,1}\d+))(?:, (-{0,1}\d+))(?:, (-{0,1}\d+)), -{0,1}\d+\)|\(-{0,1}\d+(?:, -{0,1}\d+)*(?:, (-{0,1}\d+))(?:, (-{0,1}\d+))\))/);
			var top2 = top[6]*-1;
			$(".rline-h").css("top",top2/h*100+"%");
		}
		//var top = $(".scroll-content").css("transform").replace(/[^0-9\-.,]/g, '').split(",");
		//var top2 = top[5]*-1;

		//$(".rline-h").css("top",top2/h*100+"%");
	}
	function scroll(){
		$(".main .eff-t").not(".main-slide .eff-t").each(function(){
			var w_t = $(window).scrollTop() + $(window).height();
			var i_t = $(this).offset().top;
			if(w_t > i_t-w_t/2){
				$(this).addClass("on");
			}
		})
	}
})

checkMobileDevice();
function checkMobileDevice() {
	var mobileKeyWords = new Array('Android', 'iPhone', 'iPod', 'BlackBerry', 'Windows CE', 'SAMSUNG', 'LG', 'MOT', 'SonyEricsson');
	for (var info in mobileKeyWords) {
		if (navigator.userAgent.match(mobileKeyWords[info]) != null) {
			location.href='/mobile/academy/lector01';

		}
	}
	return false;
}