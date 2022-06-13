<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script>
<script>
//공통
// 참고 출처 : https://redstapler.co/sheetjs-tutorial-create-xlsx/
function s2ab(s) { 
    var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
    var view = new Uint8Array(buf);  //create uint8array as viewer
    for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
    return buf;    
}
function exportExcel(filename, table){ 
    // step 1. workbook 생성
    var wb = XLSX.utils.book_new();

    // step 2. 시트 만들기 
    var newWorksheet = excelHandler.getWorksheet(table);
    
    // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

    // step 4. 엑셀 파일 만들기 
    var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

    // step 5. 엑셀 파일 내보내기 
    saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName(filename));
//     $(".material-icons").html('import_export');
    $(".notExcel").html(notExcelData);
}

</script>
<script>
var notExcelData = "";
var excelHandler = {
        getExcelFileName : function(filename){
            return filename+'.xlsx';
        },
        getSheetName : function(){
            return 'Sheet1';
        },
        getExcelData : function(table){
            return document.getElementById(table); 
        },
        getWorksheet : function(table){
//         	$(".material-icons").html('');
        	notExcelData = $(".notExcel").html();
        	$(".notExcel").html('');
            return XLSX.utils.table_to_sheet(this.getExcelData(table));
        }
}
</script>
</head>
