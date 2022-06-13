<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<object id="printer" classid="clsid:ccb90152-b81e-11d2-ab74-0040054c3719" style="left:5px; top:500px; width:0px; height:0px; "></object>
<script>
posInit();
function posInit() {
	if(printer.DeviceEnabled ) {
		printer.ReleaseDevice();
		printer.close();
	} 
	/*
	else {
		//프린터 DeviceEnadbled 결과에 따라 반드시 return문을 추가해주어야 explore down을 방지할 수 있습니다.
		alert('프린터가 연결되어 있지 않습니다!!!');
		return false;
	}*/
	

	if (printer.Open("IPOS_PRINTER") != 0) {
		alert('프린터가 연결되어 있지 않습니다!!!-1');
		printer.Release();
		printer.close();
		return false;
	} else {
		if (printer.ClaimDevice("1000") != 0 ) {
			alert("프린터가 연결되어 있지 않습니다!!!-2");
			printer.Release();
			printer.close();
			return false;
		} else {
			printer.DeviceEnabled = true;
			printer.RecLineChars = 40;
			return true;
		}
	}
}//posInit()
</script>
</body>
</html>