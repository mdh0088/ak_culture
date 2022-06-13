<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
			</div><!-- //contain -->
		</div><!-- //container -->

		<div class="footer">
			<p class="copyright">Copyright ⓒ 2020 AK PLAZA Department Store All Rights Reserved.</p>			
		</div>
	</body>
</html>

<script>
if(scr_stat == "ON")
{
	$("#listSize").val("20");
	$('.table-list').not(".table-list-no").addClass('scr-staton');
	$('.thead-box').addClass('on');
	//thSize();

}

document.title = "AK_"+$(".sub-tit > h2").html();
</script>