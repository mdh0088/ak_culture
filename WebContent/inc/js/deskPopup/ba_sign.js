function signResult(){
	
	 if(document.getElementById("policy").checked == false){
		 alert("AK문화아카데미 이용동의에 대한 필수항목 동의를 체크해주세요.");
		 return false;
	 }
	 
	 if(document.getElementById("privacy").checked == false){
		 alert("AK문화아카데미 개인정보 수집에 대한 필수항목 동의를 체크해주세요.");
		 return false;
	 }
	 
	 if (signaturePad.isEmpty()) {
		 alert("고객님의 서명을 입력해주세요.");
         return false; 
       }

	  var data = signaturePad.toDataURL('image/jpeg');
	  
	  var akForm = document.form2;
	   
      akForm.sign.value = data;
      
      window.opener.document.form.sign_ck.value =  data;
      
      akForm.submit();
      
      //window.opener.document.form.step.src = "../../img/ba/step_03_on.jpg";
      
      //window.opener.confClose();
      
      return false;
	
}
	

		var canvas = document.getElementById('signature-pad');

		var signaturePad = new SignaturePad(canvas, {
		  minWidth : 3,
		  maxWidth : 3,
		  backgroundColor: 'rgb(255, 255, 255)' // necessary for saving image as JPEG; can be removed is only saving as PNG or SVG
		});

		document.getElementById('clear').addEventListener('click', function () {
		  signaturePad.clear();
		});
		
		