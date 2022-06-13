$(function () {
	$('select').each(function (index, element) {
		var $this = $(this);
		var this_id = $(this).attr("id");
    	var title = $(this).attr("de-data");
    	$(this).wrap("<div class='select-box'></div>");
    	$(this).parent(".select-box").prepend("<div class='selectedOption "+this_id+"'></div><ul class='select-ul "+this_id+"_ul'></ul>")

        $(element).each(function (idx, elm) {
            $('option', elm).each(function (id, el) {
            	$this.parent('.select-box').find("ul").append('<li>' + el.text + '</li>');
            });
            $('.select-box ul').hide();
            $('.makeMeUl').children('div.selectedOption').text("select");
        });
    	$(this).parent('.select-box:last').children('div.selectedOption').text(title);
        $(".selPeri").hide();
        $(".selPeri_ul").hide();
    });
	

	
    $(document).on('click','.gnb-p', function () {
    	var $this = $(this);
		var chk =  $(this).next('ul').css('display');
		$('.gnb-p').removeClass('on');
		if(chk == "none"){
			$this.addClass('on');	
		}else{
			$this.removeClass('on');
		}
        $(this).next('ul').slideToggle(200);
        $('.gnb-ul').not(this).next('ul').hide();
    });
    
   
    $(document).on('click','.bene>div', function () {
    	if($(".star").css("display") == "none"){
			$(".star").css("display","block");
		}else{
			$(".star").css("display","none");
		}

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
    $('body').on('click', function (e) {
    	var chk = $(".select-box ul").css('display');
    	if(!$(e.target).parents(".select-box-no") && !$(e.target).hasClass("selectedOption")) {
 
	    	$(".select-box").removeClass('on');       
	    	$(".select-box").find('ul').hide();
    	}
    });


    $(document).on('click','.select-box:not(.select-box-no) ul li', function () {
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

    $('.select-box').not(".chk-select").show();
    $('select').hide();
});
function selectInit(){
	$('select').each(function (index, element) {
		var this_id = $(this).attr("id");
		var title = $(this).attr("de-data");
		$(this).wrap("<div class='select-box'></div>");
		$(this).parent(".select-box").prepend("<div class='selectedOption "+this_id+"'></div><ul class='select-ul "+this_id+"_ul'></ul>")
		
		$(element).each(function (idx, elm) {
			$('option', elm).each(function (id, el) {
				$('.select-box ul:last').append('<li>' + el.text + '</li>');
			});
			$('.select-box ul').hide();
			$('.makeMeUl').children('div.selectedOption').text("select");
		});
		$('.select-box:last').children('div.selectedOption').text(title);
	});
	
	$('.select-box').not(".chk-select").show();
	$('select').hide();
	
	$(".selPeri").hide();
	$(".selPeri_ul").hide();
}
function selectInit_one(val){
	$('#'+val).each(function (index, element) {
		var this_id = $(this).attr("id");
		var title = $(this).attr("de-data");
		$(this).wrap("<div class='select-box'></div>");
		$(this).parent(".select-box").prepend("<div class='selectedOption "+this_id+"'></div><ul class='select-ul "+this_id+"_ul'></ul>")
		
		$(element).each(function (idx, elm) {
			$('option', elm).each(function (id, el) {
				$('.'+this_id+'_ul').append('<li>' + el.text + '</li>');
			});
			$('.select-box ul').hide();
			$('.makeMeUl').children('div.selectedOption').text("select");
		});
		$("."+this_id).text(title);
	});
	
	$('.select-box').not(".chk-select").show();
	$('select').hide();
	
	$(".selPeri").hide();
	$(".selPeri_ul").hide();
	
	
	if(scr_stat == "ON")
	{
		$(".listSize-box").hide();
		$(".table-list").scroll(function() {
			var scrollTop = $(this).scrollTop();
	        var innerHeight = $(this).innerHeight();
	        var scrollHeight = $(this).prop('scrollHeight');

	        if($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight)
	        {
	        	if(!isLoading)
	        	{
	        		if($(this).hasClass("scroll1"))
	        		{
	        			isLoading = true;
			        	page = page + 1;
			        	pageMoveScroll(page);
	        		}
	        		else if($(this).hasClass("scroll2"))
	        		{
	        			isLoading = true;
			        	m_page = m_page + 1;
			        	pageMoveScroll2(m_page);
	        		}
	        	}
	        }
		});
	}
	else
	{
		$(".listSize-box").show();
	}
}

function target_selectInit_one(val){
	$('#'+val).each(function (index, element) {
		var this_id = $(this).attr("id");
		var title = $(this).attr("de-data");
		$(this).wrap("<div class='select-box'></div>");
		$(this).parent(".select-box").prepend("<div class='selectedOption "+this_id+"'></div><ul class='select-ul "+this_id+"_ul'></ul>")
		
		$(element).each(function (idx, elm) {
			$('option', elm).each(function (id, el) {
				$('.'+this_id+'_ul').append('<li>' + el.text + '</li>');
			});
			$('.select-box ul').hide();
			$('.makeMeUl').children('div.selectedOption').text("select");
		});
		$("."+this_id).text(title);
	});
	
	$('.select-box').not(".chk-select").show();
	$('select').hide();
	
	$(".target_selPeri").hide();
	$(".target_selPeri_ul").hide();
}

$(window).ready(function(){
	$(".table-list tr").each(function(){
		var $this = $(this);
		var chk = $(this).find(".td-chk input");
		chk.change(function(){
			if(chk.is(":checked")){
				$this.addClass("on");
			}else{
				$this.removeClass("on");
			}
		});
		
	})
})

$(window).ready(function(){
	$(".table-top").each(function(){
		var btn = $(this).find(".searto-btn");
		var cont = $(this).find(".sear-toggle");
		btn.click(function(){
			if(cont.css("display") == "none"){
				btn.addClass("on");
				btn.find("span").text("상세검색 닫힘")
			}else{
				btn.removeClass("on");
				btn.find("span").text("상세검색 펼침")
			}
			cont.slideToggle();
			
		})
	})
})
function back(){
	window.history.back();
}
$(window).load(function(){
	setTimeout(function(){
		append();
		thSize();
	},500)
});
$(window).resize(function(){
	thSize();
})
function thSize(){
//	$(".scr-staton").each(function(){
//		var $this = $(this);
//		var td = $(this).find('tbody tr:first-child > td');
//		var table = $this.children("table").outerWidth();
//
//
//		var thRow = $(this).find('.thead-box thead tr');
//		var th = $(this).find('.thead-box thead tr > th');
//		
//		$(this).find('.thead-box').css("width",table);
//		//thRow.css("width",table);
//
//		if(td.length > 1){
//			for(var i=0; i<th.length; i++){
//				var w = $this.find('tbody > tr:first-child > td').eq(i).outerWidth();
//				th.eq(i).css("width",w+"px");
//			}
//		}else{
//			var leng = th.length;
//			th.css("width",table/leng+"px");
//		}
//		
//		
//		if(thRow.length > 1){
//			var leng = thRow.eq(1).length;
//			thRow.eq(1).css("width",table/leng+"px");
//		}
//		
//		//$(this).find('thead').css("opacity","1");
//	});
	
	//체크박스 클릭 함수가 안먹어서 추가.
	$("#chk_all1").change(function() {
		if($("input:checkbox[name='chk_all1']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all1").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all1").val()+"']").prop("checked", false);
		}
	});
	$("#chk_all2").change(function() {
		if($("input:checkbox[name='chk_all2']").is(":checked"))
		{
			$("input:checkbox[name='"+$("#chk_all2").val()+"']").prop("checked", true);
		}
		else
		{
			$("input:checkbox[name='"+$("#chk_all2").val()+"']").prop("checked", false);
		}
	});
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
function append(){
//	$(".scr-staton").each(function(){
//		var thead = $(this).find('thead');
//		var table = $(this).find("table").outerWidth();
//
//		if($(this).find(".thead-box").length < 1){
//			$(this).prepend("<div class='thead-box'><table><thead>"+thead.html()+"</thead></table></div>");
//		}
//		$(this).find('.thead-box').css("width",table);
//	});	
}




