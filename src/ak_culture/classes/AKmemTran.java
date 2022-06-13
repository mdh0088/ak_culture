package ak_culture.classes;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.Vector;


public class AKmemTran {

    //AKmembers 전문 Header 생성
    public String AKmem_Header(String store, String pID, String pType)
    {
        String ls_send_programID       =  pID ;    //멤버스 회원인증 
        String ls_store    =   store ;
        String ls_inst_cd  = null;
            //기관코드 셋팅
            if( "01".equals(ls_store))  {  ls_inst_cd   =   "1011"; }
            if( "02".equals(ls_store))  {  ls_inst_cd   =   "1031"; }
            if( "03".equals(ls_store))  {  ls_inst_cd   =   "1021"; }
            if( "04".equals(ls_store))  {  ls_inst_cd   =   "1021"; }
            //if( ls_inst_cd == "" )  {  alert("기관코드 셋팅 오류 전산실 연락"); return false; }
                                        
        String product = ls_send_programID + "0000" + space(32);
        
            //헤더 셋팅
        String HD_TY           =   "I"; //요청
        String GRAM_NO         =  null;       //전문번호(2000:회원인증요청,1110:포인트적립요청,1120:포인트적립취소)
            if( "XA241S".equals(pID)) {   GRAM_NO =   "2000"; }
            if( "XA242S".equals(pID)) {
              
                //적립,취소 분리함(2012.07.16)
                if( "SAVE".equals(pType)) {
                    GRAM_NO =   "1110";
                }else if ( "CANCEL".equals(pType)) {
                    GRAM_NO =   "1120";
                }
            }
        String INST_CD     =   ls_inst_cd ;
        String TRS_DT      =   Utils.getCurrentDate(); //매출일자
        String TRS_PTM     =   Utils.getCurrentTime();       //시분초
        String GRAM_DIV        =   "ON";       //ONLINE
        String RSP_CD      =   "  ";
        String DATA_SZ     =   null ;   //data size(header+deail)
            if( "XA241S".equals(pID)) {   DATA_SZ =   "0193"; }
            if( "XA242S".equals(pID)) {   DATA_SZ =   "0840"; }
        String SYS_AREA        =   "                    "; 
        
        String ls_header   =   product + HD_TY + GRAM_NO + INST_CD + TRS_DT + TRS_PTM + GRAM_DIV + RSP_CD + DATA_SZ + SYS_AREA ;
        
        System.out.println("AKmem_Header >>>>>> 헤더전문  >>>>>>>>>> ls_header:"+ls_header);
        
        return ls_header;
    }
      
      //AKmembers 전문 생성
    public String AKmem_Run(String store
                          , String pID
                          , String akmem_cardno
                          , String akmem_CustNo
                          , String akmem_Family_CustNo
                          , String akmem_use_yn
                          , String recpt_cardno
                          , String recpt_sale_ymd
                          , String ori_recpt_sale_ymd
                          , String recpt_pos_no
                          , String recpt_no
                          , String ori_recpt_no
                          , String total_amt
                          , String akmem_recpt_point
                          , String pType)
    {
        String ls_store    =   store;
        String send_data   =   null;
        
        if("XA241S".equals(pID)) {
            //----------------------------------------------//
            //    회원 인증 조회 로직                               //
            //----------------------------------------------//
            String ls_akmem_card_no        =  akmem_cardno;  
            
            String ls_header   =      AKmem_Header(store,pID,pType);   	 		//CREATE HEADER
            //Data
            String WCC         =   "3";    						                //  KEY-IN
            String PERM_RQ_DIV =   "1";   				 		                //  1.POS/2.단말
            String CARD_NO     =   f_setfill(ls_akmem_card_no,37,"R"); 			//  카드번호
            String PSWD            =   f_setfill("",16,"R");//"                ";  	 //  space(16)
            String NOR_CD_CK_YN    =   "1";    						            //일반신용카드 체크여부
            String NOR_CDNO        =   "                "; 				        //일반신용카드번호
            String DE_DIV_CD       =   "  ";   						            //  거래구분코드
            String DE_RSON     =   "   ";  						                //  거래사유코드
            String FRAN_NM     =   ""; 							                //  가맹점명
            String FRAN_CD     =   ""; 							                //  가맹점코드
                if ( "01".equals(ls_store) ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                if ( "02".equals(ls_store) ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                if ( "03".equals(ls_store) ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                if ( "04".equals(ls_store) ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}
            String TEAM_CD     =   "   ";  						              //  팀코드
            String POS_NO      =   recpt_pos_no;     					      //pos번호
            String MBR_INFO_RQ =   "1";    						              //  
            String FILLER      =   "                                                  "; //space(50)
            
            String ls_data =   WCC + PERM_RQ_DIV + CARD_NO + PSWD + NOR_CD_CK_YN + NOR_CDNO + DE_DIV_CD + DE_RSON + FRAN_CD + TEAM_CD + POS_NO + MBR_INFO_RQ + FILLER ;
            
            send_data   =   f_setfill( ls_header + ls_data, 1024, "R"); //1024byte를 항상 채워준다.    
            
            System.out.println("AKmem_Run >>>>>>>>>회원인증 >>>>>>> ls_header:"+ls_header);
            
            
        }
        else if("XA242S".equals(pID))
        {
            if("SAVE".equals(pType)) {
            //----------------------------------------------//
            //    포인트 적립 로직                                                           //
            //----------------------------------------------//                    
            
                //타입에 맞게 valid
                String ls_akmem_card_no =   akmem_cardno;  
                String ls_custno   =   f_setfill(akmem_CustNo,9,"R");  			    //고객번호
                String ls_fam_custno=  f_setfill(akmem_Family_CustNo,10,"R");  	 	//가족번호
                String ls_cus_rg_yn=   akmem_use_yn;  			        		    //고객등록여부
                String ls_stt_cdno =   recpt_cardno;  					            //구매결재카드정보
                String ls_sale_ymd =   recpt_sale_ymd;                              // sysdate (적립일자) 현재일
                String ls_pos_no   =   recpt_pos_no;                                // 적립포스번호
                String ls_recpt_no =   recpt_no;                                    // 멤버스적립영수증번호 
                String ls_rs_use_div_cd=   "1";     					            //적립구분(1.적립,2.취소)
                String ls_tot_sales_amt=   total_amt;    					        //총결재금액
                String ls_recpt_point=     akmem_recpt_point; 				        //총적립요청금액
                String ls_orgl_info_yn    =   "0";    					            //1.원개래 정보 있음 2.원거래 정보 없음
                String ls_orgl_info_div   =   " ";    					            //"1":운영사 원승인정보, "2":참여사 원승인정보
                String ls_orgl_perm_no    =   f_setfill("",31,"R");   	  		    //원 승인번호
                String ls_orgl_de_dt  =   f_setfill("",8,"R");   				    //원 승인날짜                
          
                String ls_header   =      AKmem_Header(store,pID,pType);  			//CREATE HEADER
                //Data
                String WCC         =   "3";    						                //  KEY-IN
                String PERM_RQ_DIV =   "1";    						                //  1.POS/2.단말
                String CARD_NO     =   f_setfill(ls_akmem_card_no,37,"R");		    //  카드번호
                String CUS_NO      =   ls_custno;  					         	    //고객번호
                String FML_PT_MG_NO =  f_setfill(ls_fam_custno,10,"R"); 			//가족번호
                String CUS_RG_YN   =   ls_cus_rg_yn ;  					            //고객등록여부     
                String STT_CDNO    =   f_setfill(ls_stt_cdno,16,"R");   			//구매결재카드정보
                String PSWD        =   f_setfill("",16,"R");//"                ";  	//  space(16)
                String FRAN_NM     =   ""; 							                //  가맹점명            
                String FRAN_CD     =   ""; 							                //  가맹점코드
                    if ( "01".equals(ls_store) ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                    if ( "02".equals(ls_store) ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                    if ( "03".equals(ls_store) ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                    if ( "04".equals(ls_store) ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}
                String TEAM_CD     =   "   ";  						              //  팀코드
                										                          //가맹점코드(5)+거래일자(8)+POS번호(6)+ "00000000" + 거래번호(4)
                String PTCP_PERM_NO=   FRAN_CD + ls_sale_ymd + ls_pos_no + "00000000" + ls_recpt_no;
                       PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");
                String DE_DT       =   Utils.getCurrentDate(); 			 	  //거래일자
                String DE_PTM      =   Utils.getCurrentTime();       			  //시분초
                String DFN_DT      =   ls_sale_ymd;  					          //확정일자 space(8)
                String DE_DIV      =   "10";               					      //10.적립
                String DE_RSON     =   "101";          					          //거래사유코드 (100.대금결재,101.문화센터강좌신청)
                String RS_USE_DIV_CD   =   ls_rs_use_div_cd;                	  //적립구분(1.적립,2.취소)
                String TOT_SALES_AMT=  f_setfill_zero(ls_tot_sales_amt,12,"L");	  //총결재금액
                String SL_NM       =   FRAN_NM + f_setfill("",50-lenByte(FRAN_NM),"R");     //매출대표명                        
                String DC_AMT      =   fill("0",12);   					          //에누리 space(12)
                String ITEM_QTY        =   fill("0",3);    					      //품목수량 space(3)
                String TOT_CREA_PT =   f_setfill_zero(ls_recpt_point,10,"L");  	  //총적립요청금액
                String CASH_STT_AMT    =   fill("0",12);   				   	      //space(12)
                String CREA_PT_CASH    =   fill("0",10);   
                String CD_STT_AMT  =   fill("0",12);   
                String CREA_PT_CD  =   fill("0",10);   
                String WRKCP_PDB_STT_AMT   =   fill("0",12);   
                String CREA_PT_WRKCP_PDB   =   fill("0",10);   
                String OCMP_PDB_STT_AMT    =   fill("0",12);   
                String CREA_PT_OCMP_PDB    =   fill("0",10);   
                String PT_STT_AMT  =   fill("0",12);   
                String CREA_PT_PT  =   fill("0",10);   
                String ETC_STT_AMT =   fill("0",12);   
                String CREA_PT_ETC =   fill("0",10);   
                String FSDE_PT_OC_YN=  "0";
                String FSDE_PT     =   fill("0",10);   
                String BIRTH_PT_OC_YN= "0";
                String BIRTH_PT        =   fill("0",10);   
                String WEDD_DT_PT_OC_YN=   "0";
                String WEDD_DT_PT  =   fill("0",10);   
                String ADDM_RS_PT_OC_YN1=  "0";
                String ADDM_RS_PT1 =   fill("0",10);   
                String ADDM_RS_PT_OC_YN2=  "0";
                String ADDM_RS_PT2 =   fill("0",10);   
                String MBR_INFO_RQ =   "1";                                    //회원정보요청
                String FILLER      =   f_setfill("",50,"R");
                String ORGL_INFO_YN    =   ls_orgl_info_yn;    				   //1.원개래 정보 있음 2.원거래 정보 없음
                String ORGL_INFO_DIV   =   ls_orgl_info_div;    			   //"1":운영사 원승인정보, "2":참여사 원승인정보
                String ORGL_PERM_NO    =   ls_orgl_perm_no;   				   //원 승인번호
                String ORGL_DE_DT      =   ls_orgl_de_dt;    				   //원 승인날짜
                String EV_CNT      =   "0";
                String EV_CD1      =   f_setfill("",10,"R");  				   //이벤트코드
                String EV_NM1      =   f_setfill("",100,"R");  				   //이벤트코드
                String SALES_AMT1  =   fill("0",12);   					       //이벤트코드
                String EV_PT1      =   fill("0",10);   					       //이벤트코드
                String EV_CD2      =   f_setfill("",10,"R");   				   //이벤트코드
                String EV_NM2      =   f_setfill("",100,"R");  				   //이벤트코드
                String SALES_AMT2  =   fill("0",12);   					       //이벤트코드
                String EV_PT2      =   fill("0",10);   					       //이벤트코드
                
                String ls_data =   WCC + PERM_RQ_DIV + CARD_NO + CUS_NO + FML_PT_MG_NO + CUS_RG_YN + STT_CDNO + PSWD + FRAN_CD + TEAM_CD ;
                ls_data   = ls_data +  PTCP_PERM_NO + DE_DT + DE_PTM + DFN_DT + DE_DIV + DE_RSON + RS_USE_DIV_CD + TOT_SALES_AMT + SL_NM ;
                ls_data   = ls_data +  DC_AMT + ITEM_QTY + TOT_CREA_PT + CASH_STT_AMT + CREA_PT_CASH + CD_STT_AMT + CREA_PT_CD + WRKCP_PDB_STT_AMT ;
                ls_data   = ls_data +  CREA_PT_WRKCP_PDB + OCMP_PDB_STT_AMT + CREA_PT_OCMP_PDB + PT_STT_AMT + CREA_PT_PT + ETC_STT_AMT + CREA_PT_ETC ;
                ls_data   = ls_data +  FSDE_PT_OC_YN + FSDE_PT + BIRTH_PT_OC_YN + BIRTH_PT + WEDD_DT_PT_OC_YN + WEDD_DT_PT + ADDM_RS_PT_OC_YN1 + ADDM_RS_PT1 ;
                ls_data   = ls_data +  ADDM_RS_PT_OC_YN2 + ADDM_RS_PT2 + MBR_INFO_RQ + FILLER + ORGL_INFO_YN + ORGL_INFO_DIV + ORGL_PERM_NO + ORGL_DE_DT ;
                ls_data   = ls_data +  EV_CNT + EV_CD1 + EV_NM1 + SALES_AMT1 + EV_PT1 + EV_CD2 + EV_NM2 + SALES_AMT2 + EV_PT2;
    
                send_data   =   f_setfill( ls_header + ls_data, 1024, "R"); 		//1024byte를 항상 채워준다.
                
                System.out.println("AKmem_Run >>>>>>>>>적립 >>>>>>> send_data:"+send_data);
                
            }else if("CANCEL".equals(pType)) {
            //----------------------------------------------//
            //    포인트 차감 로직                                                           //
            //----------------------------------------------//                
/*
                //타입에 맞게 valid
                String FRAN_NM     =   "";                                          //  가맹점명           
                String FRAN_CD     =   "";                                          //  가맹점코드
                    //멤버스 오픈 이후 거래 문화센터 가맹점번호 set
                    if ( ls_store == "01" ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                    if ( ls_store == "02" ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                    if ( ls_store == "03" ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                    if ( ls_store == "04" ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}                         
                    
                String ls_akmem_card_no =   akmem_cardno;  
                String ls_custno   =   f_setfill(akmem_CustNo,9,"R");               //고객번호
                String ls_fam_custno=  f_setfill(akmem_Family_CustNo,10,"R");       //가족번호
                String ls_cus_rg_yn=   "Y";                                         //고객등록여부
                String ls_stt_cdno =   " ";                                          //구매결재카드정보
               
                String ls_sys_ymd  =   recpt_sale_ymd;                              //시스템 날짜 (차감일자) 현재일
                String ls_sale_ymd =   ori_recpt_sale_ymd;                           //원거래 일자 
                String ls_pos_no   =   recpt_pos_no;                                //원거래포스번호(070013)
                String ls_pos_no2  =   recpt_pos_no;                                //취소처리 포스번호(070013)
                String ls_orgl_recpt_no = ori_recpt_no;                             //원거래 영수증번호
                String ls_recpt_no =   recpt_no;                                    //멤버스차감 영수증번호
                                                       
                String ls_rs_use_div_cd = "2";                                     //적립구분(1.적립,2.취소)
                String ls_tot_sales_amt = total_amt;                               //총결재금액
                String ls_recpt_point   = akmem_recpt_point;                       //총적립요청금액
                String ls_orgl_info_yn  = "1";                                     //1.원개래 정보 있음 2.원거래 정보 없음
                String ls_orgl_info_div = "2";                                     //1:운영사 원승인정보, 2:참여사 원승인정보 (멤버스 오픈 이전 원거래 취소 때문에 참여사 승인정보로 변경)
                String ls_orgl_perm_no  = f_setfill( FRAN_CD + ls_sale_ymd + ls_pos_no + "00000000" + ls_orgl_recpt_no ,31,"R");                  //원 승인번호
                String ls_orgl_de_dt    = f_setfill(ls_sale_ymd,8,"R");            //원 승인날짜
                
             
                
                String ls_header   =      AKmem_Header(store,pID,pType);            //CREATE HEADER
                //Data
                String WCC         =   "3";                                         //  KEY-IN
                String PERM_RQ_DIV =   "1";                                         //  1.POS/2.단말
                String CARD_NO     =   f_setfill(ls_akmem_card_no,37,"R");          //  카드번호
                String CUS_NO      =   ls_custno;                                   //고객번호
                String FML_PT_MG_NO =  f_setfill(ls_fam_custno,10,"R");             //가족번호
                String CUS_RG_YN   =   ls_cus_rg_yn ;                               //고객등록여부     
                String STT_CDNO    =   f_setfill(ls_stt_cdno,16,"R");               //구매결재카드정보
                String PSWD        =   f_setfill("",16,"R");//"                ";   //  space(16)
                //멤버스 오픈 이후 거래 문화센터 가맹점번호 set
                FRAN_CD     =   "";
                if ( ls_store == "01" ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                if ( ls_store == "02" ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                if ( ls_store == "03" ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                if ( ls_store == "04" ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}     
                String TEAM_CD     =   "   ";                                     //  팀코드
                                                                                  //가맹점코드(5)+거래일자(8)+POS번호(6)+ "00000000" + 거래번호(4)
                String PTCP_PERM_NO=    FRAN_CD + ls_sys_ymd + ls_pos_no2 + "00000000" + ls_recpt_no;
                       PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");
                String DE_DT       =   Common.getCurrentDate();                   //거래일자
                String DE_PTM      =   Common.getCurrentTime();                   //시분초
                String DFN_DT      =   ls_sale_ymd;                               //확정일자 space(8)
                String DE_DIV      =   "10";                                      //10.적립
                String DE_RSON     =   "101";                                     //거래사유코드 (100.대금결재,101.문화센터강좌신청)
                String RS_USE_DIV_CD   =   ls_rs_use_div_cd;                      //적립구분(1.적립,2.취소)
                String TOT_SALES_AMT=  f_setfill_zero(ls_tot_sales_amt,12,"L");   //총결재금액
                String SL_NM       =   FRAN_NM + f_setfill("",50-lenByte(FRAN_NM),"R");     //매출대표명                        
                String DC_AMT      =   fill("0",12);                              //에누리 space(12)
                String ITEM_QTY        =   fill("0",3);                           //품목수량 space(3)
                String TOT_CREA_PT =   f_setfill_zero(ls_recpt_point,10,"L");     //총적립요청금액
                String CASH_STT_AMT    =   fill("0",12);                          //space(12)
                String CREA_PT_CASH    =   fill("0",10);   
                String CD_STT_AMT  =   fill("0",12);   
                String CREA_PT_CD  =   fill("0",10);   
                String WRKCP_PDB_STT_AMT   =   fill("0",12);   
                String CREA_PT_WRKCP_PDB   =   fill("0",10);   
                String OCMP_PDB_STT_AMT    =   fill("0",12);   
                String CREA_PT_OCMP_PDB    =   fill("0",10);   
                String PT_STT_AMT  =   fill("0",12);   
                String CREA_PT_PT  =   fill("0",10);   
                String ETC_STT_AMT =   fill("0",12);   
                String CREA_PT_ETC =   fill("0",10);   
                String FSDE_PT_OC_YN=  "0";
                String FSDE_PT     =   fill("0",10);   
                String BIRTH_PT_OC_YN= "0";
                String BIRTH_PT        =   fill("0",10);   
                String WEDD_DT_PT_OC_YN=   "0";
                String WEDD_DT_PT  =   fill("0",10);   
                String ADDM_RS_PT_OC_YN1=  "0";
                String ADDM_RS_PT1 =   fill("0",10);   
                String ADDM_RS_PT_OC_YN2=  "0";
                String ADDM_RS_PT2 =   fill("0",10);   
                String MBR_INFO_RQ =   "1";                                    //회원정보요청
                String FILLER      =   f_setfill("",50,"R");
                String ORGL_INFO_YN    =   ls_orgl_info_yn;                    //1.원개래 정보 있음 2.원거래 정보 없음
                String ORGL_INFO_DIV   =   ls_orgl_info_div;                   //"1":운영사 원승인정보, "2":참여사 원승인정보
                String ORGL_PERM_NO    =   ls_orgl_perm_no;                    //원 승인번호
                String ORGL_DE_DT      =   ls_orgl_de_dt;                      //원 승인날짜
                String EV_CNT      =   "0";
                String EV_CD1      =   f_setfill("",10,"R");                   //이벤트코드
                String EV_NM1      =   f_setfill("",100,"R");                  //이벤트코드
                String SALES_AMT1  =   fill("0",12);                           //이벤트코드
                String EV_PT1      =   fill("0",10);                           //이벤트코드
                String EV_CD2      =   f_setfill("",10,"R");                   //이벤트코드
                String EV_NM2      =   f_setfill("",100,"R");                  //이벤트코드
                String SALES_AMT2  =   fill("0",12);                           //이벤트코드
                String EV_PT2      =   fill("0",10);                           //이벤트코드
                
                String ls_data =   WCC + PERM_RQ_DIV + CARD_NO + CUS_NO + FML_PT_MG_NO + CUS_RG_YN + STT_CDNO + PSWD + FRAN_CD + TEAM_CD ;
                ls_data   = ls_data +  PTCP_PERM_NO + DE_DT + DE_PTM + DFN_DT + DE_DIV + DE_RSON + RS_USE_DIV_CD + TOT_SALES_AMT + SL_NM ;
                ls_data   = ls_data +  DC_AMT + ITEM_QTY + TOT_CREA_PT + CASH_STT_AMT + CREA_PT_CASH + CD_STT_AMT + CREA_PT_CD + WRKCP_PDB_STT_AMT ;
                ls_data   = ls_data +  CREA_PT_WRKCP_PDB + OCMP_PDB_STT_AMT + CREA_PT_OCMP_PDB + PT_STT_AMT + CREA_PT_PT + ETC_STT_AMT + CREA_PT_ETC ;
                ls_data   = ls_data +  FSDE_PT_OC_YN + FSDE_PT + BIRTH_PT_OC_YN + BIRTH_PT + WEDD_DT_PT_OC_YN + WEDD_DT_PT + ADDM_RS_PT_OC_YN1 + ADDM_RS_PT1 ;
                ls_data   = ls_data +  ADDM_RS_PT_OC_YN2 + ADDM_RS_PT2 + MBR_INFO_RQ + FILLER + ORGL_INFO_YN + ORGL_INFO_DIV + ORGL_PERM_NO + ORGL_DE_DT ;
                ls_data   = ls_data +  EV_CNT + EV_CD1 + EV_NM1 + SALES_AMT1 + EV_PT1 + EV_CD2 + EV_NM2 + SALES_AMT2 + EV_PT2;
    
                send_data   =   f_setfill( ls_header + ls_data, 1024, "R");         //1024byte를 항상 채워준다.
*/                
                
                //타입에 맞게 valid
                String ls_akmem_card_no =   akmem_cardno;  
                String ls_custno   =   f_setfill(akmem_CustNo,9,"R");               //고객번호
                String ls_fam_custno=  f_setfill(akmem_Family_CustNo,10,"R");       //가족번호
                String ls_cus_rg_yn=   akmem_use_yn;                                //고객등록여부
                String ls_stt_cdno =   recpt_cardno;                                //구매결재카드정보
                String ls_sys_ymd  =   recpt_sale_ymd;                              // sysdate (적립일자) 현재일
                String ls_sale_ymd =   ori_recpt_sale_ymd;                           //원거래 일자 
                String ls_pos_no   =   recpt_pos_no;                                // 적립포스번호
                String ls_recpt_no =   recpt_no;                                    // 멤버스적립영수증번호 
                String ls_orgl_recpt_no = ori_recpt_no;                             // 원거래 영수증번호
                String ls_rs_use_div_cd=   "2";                                     //적립구분(1.적립,2.취소)
                String ls_tot_sales_amt=   total_amt;                               //총결재금액
                String ls_recpt_point=     akmem_recpt_point;                       //총적립요청금액
                String ls_orgl_info_yn    =   "1";                                  //1.원개래 정보 있음 2.원거래 정보 없음
                String ls_orgl_info_div   =   "2";                                  //"1":운영사 원승인정보, "2":참여사 원승인정보
                
                String ls_orgl_de_dt  =   f_setfill(ls_sale_ymd,8,"R");            //원 승인날짜    
          
                String ls_header   =      AKmem_Header(store,pID,pType);            //CREATE HEADER
                //Data
                String WCC         =   "3";                                         //  KEY-IN
                String PERM_RQ_DIV =   "1";                                         //  1.POS/2.단말
                String CARD_NO     =   f_setfill(ls_akmem_card_no,37,"R");          //  카드번호
                String CUS_NO      =   ls_custno;                                   //고객번호
                String FML_PT_MG_NO =  f_setfill(ls_fam_custno,10,"R");             //가족번호
                String CUS_RG_YN   =   ls_cus_rg_yn ;                               //고객등록여부     
                String STT_CDNO    =   f_setfill(ls_stt_cdno,16,"R");               //구매결재카드정보
                String PSWD        =   f_setfill("",16,"R");//"                ";   //  space(16)
                String FRAN_NM     =   "";                                          //  가맹점명            
                String FRAN_CD     =   "";                                          //  가맹점코드
                    if ( "01".equals(ls_store) ) { FRAN_CD = "00103"; FRAN_NM = "문화아카데미 구로점";}
                    if ( "02".equals(ls_store) ) { FRAN_CD = "00203"; FRAN_NM = "문화아카데미 수원점";}
                    if ( "03".equals(ls_store) ) { FRAN_CD = "00303"; FRAN_NM = "문화아카데미 분당점";}
                    if ( "04".equals(ls_store) ) { FRAN_CD = "00403"; FRAN_NM = "문화아카데미 평택점";}
                String TEAM_CD     =   "   ";                                     //  팀코드
                
                String ls_orgl_perm_no    =   f_setfill( FRAN_CD + ls_sale_ymd + ls_pos_no + "00000000" + ls_orgl_recpt_no ,31,"R");    //가맹점코드(5)+원거래일자(8)+POS번호(6)+ "00000000" + 원거래번호(4)
                
                String PTCP_PERM_NO=   FRAN_CD + ls_sys_ymd + ls_pos_no + "00000000" + ls_recpt_no;       //가맹점코드(5)+거래일자(8)+POS번호(6)+ "00000000" + 거래번호(4)
                       PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");
                String DE_DT       =   Utils.getCurrentDate();                   //거래일자
                String DE_PTM      =   Utils.getCurrentTime();                   //시분초
                String DFN_DT      =   ls_sys_ymd;                                //확정일자 space(8)
                String DE_DIV      =   "10";                                      //10.적립
                String DE_RSON     =   "101";                                     //거래사유코드 (100.대금결재,101.문화센터강좌신청)
                String RS_USE_DIV_CD   =   ls_rs_use_div_cd;                      //적립구분(1.적립,2.취소)
                String TOT_SALES_AMT=  f_setfill_zero(ls_tot_sales_amt,12,"L");   //총결재금액
                String SL_NM       =   FRAN_NM + f_setfill("",50-lenByte(FRAN_NM),"R");     //매출대표명                        
                String DC_AMT      =   fill("0",12);                              //에누리 space(12)
                String ITEM_QTY        =   fill("0",3);                           //품목수량 space(3)
                String TOT_CREA_PT =   f_setfill_zero(ls_recpt_point,10,"L");     //총적립요청금액
                String CASH_STT_AMT    =   fill("0",12);                          //space(12)
                String CREA_PT_CASH    =   fill("0",10);   
                String CD_STT_AMT  =   fill("0",12);   
                String CREA_PT_CD  =   fill("0",10);   
                String WRKCP_PDB_STT_AMT   =   fill("0",12);   
                String CREA_PT_WRKCP_PDB   =   fill("0",10);   
                String OCMP_PDB_STT_AMT    =   fill("0",12);   
                String CREA_PT_OCMP_PDB    =   fill("0",10);   
                String PT_STT_AMT  =   fill("0",12);   
                String CREA_PT_PT  =   fill("0",10);   
                String ETC_STT_AMT =   fill("0",12);   
                String CREA_PT_ETC =   fill("0",10);   
                String FSDE_PT_OC_YN=  "0";
                String FSDE_PT     =   fill("0",10);   
                String BIRTH_PT_OC_YN= "0";
                String BIRTH_PT        =   fill("0",10);   
                String WEDD_DT_PT_OC_YN=   "0";
                String WEDD_DT_PT  =   fill("0",10);   
                String ADDM_RS_PT_OC_YN1=  "0";
                String ADDM_RS_PT1 =   fill("0",10);   
                String ADDM_RS_PT_OC_YN2=  "0";
                String ADDM_RS_PT2 =   fill("0",10);   
                String MBR_INFO_RQ =   "1";                                    //회원정보요청
                String FILLER      =   f_setfill("",50,"R");
                String ORGL_INFO_YN    =   ls_orgl_info_yn;                    //1.원개래 정보 있음 2.원거래 정보 없음
                String ORGL_INFO_DIV   =   ls_orgl_info_div;                   //"1":운영사 원승인정보, "2":참여사 원승인정보
                String ORGL_PERM_NO    =   ls_orgl_perm_no;                    //원 승인번호
                String ORGL_DE_DT      =   ls_orgl_de_dt;                      //원 승인날짜
                String EV_CNT      =   "0";
                String EV_CD1      =   f_setfill("",10,"R");                   //이벤트코드
                String EV_NM1      =   f_setfill("",100,"R");                  //이벤트코드
                String SALES_AMT1  =   fill("0",12);                           //이벤트코드
                String EV_PT1      =   fill("0",10);                           //이벤트코드
                String EV_CD2      =   f_setfill("",10,"R");                   //이벤트코드
                String EV_NM2      =   f_setfill("",100,"R");                  //이벤트코드
                String SALES_AMT2  =   fill("0",12);                           //이벤트코드
                String EV_PT2      =   fill("0",10);                           //이벤트코드
                
                String ls_data =   WCC + PERM_RQ_DIV + CARD_NO + CUS_NO + FML_PT_MG_NO + CUS_RG_YN + STT_CDNO + PSWD + FRAN_CD + TEAM_CD ;
                ls_data   = ls_data +  PTCP_PERM_NO + DE_DT + DE_PTM + DFN_DT + DE_DIV + DE_RSON + RS_USE_DIV_CD + TOT_SALES_AMT + SL_NM ;
                ls_data   = ls_data +  DC_AMT + ITEM_QTY + TOT_CREA_PT + CASH_STT_AMT + CREA_PT_CASH + CD_STT_AMT + CREA_PT_CD + WRKCP_PDB_STT_AMT ;
                ls_data   = ls_data +  CREA_PT_WRKCP_PDB + OCMP_PDB_STT_AMT + CREA_PT_OCMP_PDB + PT_STT_AMT + CREA_PT_PT + ETC_STT_AMT + CREA_PT_ETC ;
                ls_data   = ls_data +  FSDE_PT_OC_YN + FSDE_PT + BIRTH_PT_OC_YN + BIRTH_PT + WEDD_DT_PT_OC_YN + WEDD_DT_PT + ADDM_RS_PT_OC_YN1 + ADDM_RS_PT1 ;
                ls_data   = ls_data +  ADDM_RS_PT_OC_YN2 + ADDM_RS_PT2 + MBR_INFO_RQ + FILLER + ORGL_INFO_YN + ORGL_INFO_DIV + ORGL_PERM_NO + ORGL_DE_DT ;
                ls_data   = ls_data +  EV_CNT + EV_CD1 + EV_NM1 + SALES_AMT1 + EV_PT1 + EV_CD2 + EV_NM2 + SALES_AMT2 + EV_PT2;
    
                send_data   =   f_setfill( ls_header + ls_data, 1024, "R");         //1024byte를 항상 채워준다.
                
                System.out.println("AKmem_Run >>>>>>>> 차감 >>>>>>> send_data:"+send_data);
            }
            
        }
        return send_data;
    }               
  
  public HashMap AKmemExec(String ls_akmem_send_str)
  {
    String  recv_buff     = null;
    String  sApprovNo   = null;
    String  sMessage    = null;
    
    String AKmem_Send_Str       = ls_akmem_send_str;
    String AKmem_Resp_No        = null;  //akmembers 응답코드(00:정상 else 오류)
    String AKmem_Resp_Msg       = null;  //akmembers 응답메세지    
    String AKmem_CustNo         = null;  //akmembers 회원번호
    String AKmem_Family_CustNo  = null;  //akmembers 가족번호
    String AKmem_CustName       = null;  //akmembers 회원이름
    String AKmem_CustLevel      = null;  //akmembers 회원등급
    String AKmem_total_point    = null;  //akmembers 가용포인트
    String AKmem_use_yn         = null;  //akmembers 고객등록여부
    String AKmem_Card_Type      = null;  //akmembers 카드타입(1:단순멤버스,2:제휴신용,3:드림카드,4:플러스카드,5:VIP카드)
    String AKmem_RegiCard_yn    = null;  //akmembers 등록된 신용카드 유무(0:등록카드없음,1:카드있음)
    String AKmem_RegiCard_no    = null;  //akmembers 등록된 신용카드 List (max 10pcs)
    String AKmem_Use_Min_Point  = null;  //akmembers 최소사용 포인트
    String AKmem_Use_Max_Point  = null;  //akmembers 최대사용 포인트
    String AKmem_Use_hurdle     = null;  //akmembers 사용단위(허들) 포인트
    String AKmem_Stf_div        = null;  //akmembers 직원구분
    String AKmem_SaveApproveNo      = null;  //akmembers 멤버스 승인번호
    String AKmem_SaveApproveNo_POS  = null;  //akmembers 참여사 승인번호(POS)
    String AKmem_SaveApprove_Point  = null;  //akmembers 가용 포인트
    String AKmem_Create_Point  = null;   //akmembers 적립요청 포인트
    
    String return_cd    = null;

    AKmemSock acard = new AKmemSock();
    
	String opHost    = XmlPropertyManager.getSystemProperty("op_mem_host");  // 운영서버
	int opPort       = Integer.parseInt(XmlPropertyManager.getSystemProperty("op_mem_port"));
	String devHost   = XmlPropertyManager.getSystemProperty("dev_mem_host");  // 개발서버
	int devPort      = Integer.parseInt(XmlPropertyManager.getSystemProperty("dev_mem_port"));
	
	System.out.println("hostAddress() : "+hostAddress());

    if(hostAddress().equals("dev")){
    	System.out.println("=======================개발서버에서 Members 적립/취소 실행=======================");
    	acard.setHost(devHost, devPort); //테스트 서버 접속  open시 실 통신서버로 전환
    } else {
    	System.out.println("=======================운영서버에서 Members 적립/취소 실행=======================");
    	acard.setHost(opHost, opPort); //운영 분당 통신서버  
    }

    HashMap map = new HashMap();
    
    //sysdate setting
    System.out.println("run_date="+ Utils.getCurrentDate());
    System.out.println("run_time="+ Utils.getCurrentTime());
    
    System.out.println("ls_akmem_send_str>>>"+AKmem_Send_Str+"end");
    
    //통신체크
    if (acard.start().equals("OK")) {
        //AK멤버스 회원인증
        if("XA241S".equals(AKmem_Send_Str.trim().substring(0, 6))) {
            
        		System.out.println("AKmem_Send_Str.length>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + AKmem_Send_Str.length());
                
                recv_buff     = acard.AKmem_run(AKmem_Send_Str);
                System.out.println("recv_buff>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + recv_buff);

                AKmem_Resp_No        = ByteSubStr(recv_buff,25,2);    //akmembers 응답코드(00:정상 else 기타)
                AKmem_Resp_Msg       = ByteSubStr(recv_buff,181,64);  //akmembers 응답메세지                    
                AKmem_CustNo         = ByteSubStr(recv_buff,121,9);  //akmembers 회원번호
                AKmem_Family_CustNo  = ByteSubStr(recv_buff,130,10);  //akmembers 가족번호
                AKmem_CustName       = ByteSubStr(recv_buff,362,40);  //akmembers 회원명
                AKmem_CustLevel      = ByteSubStr(recv_buff,254,7);  //akmembers 회원등급
                AKmem_total_point    = ByteSubStr(recv_buff,159,10);  //akmembers 가용포인트
                AKmem_use_yn         = ByteSubStr(recv_buff,245,1);  //akmembers 고객등록여부
                AKmem_Card_Type      = ByteSubStr(recv_buff,246,1);  //akmembers 카드타입(1:단순멤버스,2:제휴신용,3:드림카드,4:플러스카드,5:VIP카드)
                AKmem_RegiCard_yn    = ByteSubStr(recv_buff,290,1);  //akmembers 등록된 신용카드 유무(0:등록카드없음,1:카드있음)
                AKmem_RegiCard_no    = ByteSubStr(recv_buff,710,160);  //akmembers 등록된 신용카드 List (max 10pcs)
                AKmem_Stf_div        = ByteSubStr(recv_buff,289,1);  //akmembers 직원구분(1,2,3)
                AKmem_Use_Min_Point  = ByteSubStr(recv_buff,291,10);  //akmembers 최소사용 포인트
                AKmem_Use_Max_Point  = ByteSubStr(recv_buff,301,10);  //akmembers 최대사용 포인트
                AKmem_Use_hurdle     = ByteSubStr(recv_buff,311,10);  //akmembers 사용단위(허들) 포인트
                
                map.put("sApprovNo"                 , AKmem_Resp_No);
                map.put("sMessage"                  , AKmem_Resp_Msg);
                map.put("AKmem_Resp_No"             , AKmem_Resp_No);
                map.put("AKmem_Resp_Msg"            , AKmem_Resp_Msg);                
                map.put("AKmem_CustNo"              , AKmem_CustNo);
                map.put("AKmem_Family_CustNo"       , AKmem_Family_CustNo);
                map.put("AKmem_CustName"            , AKmem_CustName);
                map.put("AKmem_CustLevel"           , AKmem_CustLevel);
                map.put("AKmem_total_point"         , AKmem_total_point);
                map.put("AKmem_use_yn"              , AKmem_use_yn);
                map.put("AKmem_Card_Type"           , AKmem_Card_Type);                
                map.put("AKmem_RegiCard_yn"         , AKmem_RegiCard_yn);
                map.put("AKmem_RegiCard_no"         , AKmem_RegiCard_no);
                map.put("AKmem_Use_Min_Point"       , AKmem_Use_Min_Point);
                map.put("AKmem_Use_Max_Point"       , AKmem_Use_Max_Point);
                map.put("AKmem_Use_hurdle"          , AKmem_Use_hurdle);
                //list.add(map);
                
                System.out.println("AKmem_Resp_No         ="+AKmem_Resp_No);
                System.out.println("AKmem_Resp_Msg        ="+AKmem_Resp_Msg);
                System.out.println("AKmem_CustNo          ="+AKmem_CustNo);
                System.out.println("AKmem_Family_CustNo   ="+AKmem_Family_CustNo);
                System.out.println("AKmem_CustName        ="+AKmem_CustName);
                System.out.println("AKmem_CustLevel       ="+AKmem_CustLevel);
                System.out.println("AKmem_total_point     ="+AKmem_total_point);
                System.out.println("AKmem_use_yn          ="+AKmem_use_yn);
                System.out.println("AKmem_Card_Type       ="+AKmem_Card_Type);
                System.out.println("AKmem_RegiCard_yn     ="+AKmem_RegiCard_yn);
                System.out.println("AKmem_RegiCard_no     ="+AKmem_RegiCard_no);
                System.out.println("AKmem_Stf_div         ="+AKmem_Stf_div);
                System.out.println("AKmem_Use_Min_Point   ="+AKmem_Use_Min_Point);
                System.out.println("AKmem_Use_Max_Point   ="+AKmem_Use_Max_Point);
                System.out.println("AKmem_Use_hurdle      ="+AKmem_Use_hurdle);
                
        //AK멤버스 마일리지 적립
        } else if("XA242S".equals(AKmem_Send_Str.trim().substring(0, 6))) {
        	System.out.println("AKmem_Send_Str.length>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + AKmem_Send_Str.length());
            
            recv_buff     = acard.AKmem_run(AKmem_Send_Str);
            System.out.println("recv_buff>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + recv_buff);

            AKmem_Resp_No               = ByteSubStr(recv_buff,25,2);     //akmembers 응답코드(00:정상 else 기타)
            AKmem_Resp_Msg              = ByteSubStr(recv_buff,270,64);   //akmembers 응답메세지
            AKmem_SaveApproveNo         = ByteSubStr(recv_buff,107,31);  //akmembers 멤버스 승인번호
            AKmem_SaveApproveNo_POS     = ByteSubStr(recv_buff,152,9);   //akmembers 참여사 승인번호(POS)
            AKmem_SaveApprove_Point     = ByteSubStr(recv_buff,250,10);  //akmembers 가용 포인트

            AKmem_CustNo                = ByteSubStr(recv_buff,88,9);     //akmembers 회원번호
            AKmem_Create_Point          = ByteSubStr(recv_buff,175,10);   //총적립요청금액

            map.put("sApprovNo"                        , AKmem_Resp_No);
            map.put("sMessage"                         , AKmem_Resp_Msg);
            map.put("AKmem_Resp_Msg"                   , AKmem_Resp_Msg);                
            map.put("AKmem_CustNo"                     , AKmem_CustNo);            
            map.put("AKmem_SaveApproveNo"              , AKmem_SaveApproveNo);
            map.put("AKmem_SaveApproveNo_POS"          , AKmem_SaveApproveNo_POS);
            map.put("AKmem_SaveApprove_Point"          , AKmem_SaveApprove_Point);
            map.put("AKmem_CustNo"                     , AKmem_CustNo);
            map.put("AKmem_Create_Point"               , AKmem_Create_Point);
            map.put("AKmem_send_buff"                  , AKmem_Send_Str);
            map.put("AKmem_recv_buff"                  , recv_buff);

            System.out.println("AKmem_Resp_No         ="+AKmem_Resp_No);
            System.out.println("AKmem_Resp_Msg        ="+AKmem_Resp_Msg);                        
            System.out.println("AKmem_SaveApproveNo   ="+AKmem_SaveApproveNo);
            System.out.println("AKmem_SaveApproveNo_POS   ="+AKmem_SaveApproveNo_POS);
            System.out.println("AKmem_SaveApprove_Point   ="+AKmem_SaveApprove_Point);
            System.out.println("AKmem_CustNo   ="+AKmem_CustNo);
            System.out.println("AKmem_Create_Point   ="+AKmem_Create_Point);
            
        } else {
            //전문요청 ERR
            sApprovNo   = "Fail0000";                 
            sMessage    = "Header ERROR";
            map.put("sApprovNo"                , sApprovNo);
            map.put("sMessage"                 , sMessage);
            System.out.println("HEADER FORMAT ERROR");            
        }
    } else {
        sApprovNo   = "Fail0000";
        sMessage    = "AKmembers 통신오류발생";
        map.put("sApprovNo"                , sApprovNo);
        map.put("sMessage"                 , sMessage);
        System.out.println("XA241S 통신 ERROR");
    }                     
    acard.stop();
            
    System.out.println("승인Check>>>>>>>>>>>>>>>>>>>" + AKmem_Send_Str.trim().substring(0, 6));
    
    return map;
    //return list;             
  }
  
  
  public String f_setfill(String temp_str, int str_length, String str_flag)
  {
      int temp_len = 0;
      temp_len = trim(temp_str).length();
      if(trim(temp_str) == null)   return space(str_length);
      if(temp_len >= str_length)   return temp_str.substring(0, str_length);
      if(str_flag == "R")          return trim(temp_str) + space(str_length - temp_len);
      else if(str_flag == "L")     return space(str_length - temp_len) + trim(temp_str);
      else { return temp_str ;}
  }
  
  /**
   * 작성자 : 이충훈
   * 0으로 zero로 채워준다.
   */
  public String f_setfill_zero(String temp_str, int str_length, String str_flag)
  {
      int temp_len = 0;
      temp_len = trim(temp_str).length();
      if(trim(temp_str) == null)   return zero(str_length);
      if(temp_len >= str_length)   return temp_str.substring(0, str_length);
      if(str_flag == "R")          return trim(temp_str) + zero(str_length - temp_len);
      else if(str_flag == "L")     return zero(str_length - temp_len) + trim(temp_str);
      else { return temp_str ;}
  }
  /**
   * 인자값의 길이만큼 공백을 만들어낸다. 
   */ 
  public String space(int len)
  {
      String spaceString = "";
      for(int i = 0; i < len; i++) {
          spaceString = spaceString + " ";
      }
      return spaceString;
  }  
  /**
   * 인자값의 길이만큼 0을 채워낸다. 
   * 작성자 : 이충훈
   */ 
  public String zero(int len)
  {
      String zeroString = "";
      for(int i = 0; i < len; i++) {
          zeroString = zeroString + "0";
      }
      return zeroString;
  }  
  
  /* trim */
  public String trim(String str)
  {
    return str.trim();
  }    

/**
 * addString의 문자를 length만큼 채운다.
 * addString : 문자열, length : 길이
 */
public String fill(String addString, int len)
{
    String charString = "";
    for(int i = 0; i < len; i++) {
        charString = charString + addString;
    }
    return charString;
}  
/* log 출력 */
private void logPrint ( String message ) {
        System.out.println(message);
}
/**
 *  substrb
 *  : oracle substrb과 같은기능 byte로 짤라서 return
 *
 *  @param      source      변환할 문자열
 *  @return     string
 *  @author     이충훈
 *  @since      1.0         2008.12.12
 */
public static String ByteSubStr( String Pst_Str, int Pi_Off, int Pi_Len )
{
    byte[] Ly_Str = Pst_Str.getBytes();
    String Lst_Str = new String( Ly_Str, Pi_Off, Pi_Len );

    return Lst_Str.trim();
}

/**
 *  splitString
 *  : split return
 *  jvm1.3 이라 안되서 구현함. 1.4부터는 됨.
 *  @param      source      
 *  @return     string
 *  @author     이충훈
 *  @since      1.0         2008.12.12
 */
public static String[] splitString(String pStr, String pDelim) throws Exception
{
      if (pStr == null || pStr.length() == 0 || pDelim == null || pDelim.length() == 0)
      {
          return null;
      }
      String[] results = null;
      Vector vec = null;
      int len = pDelim.length();
      int srclen = pStr.length();
      int pos = 0;
      int oldpos = 0;
      
      try{
          vec = new Vector();

      	while ((pos = pStr.indexOf(pDelim,oldpos)) >= 0){
      		String temp = pStr.substring(oldpos, pos);
      		vec.addElement(temp);
      		oldpos = pos + len;
      	}
        if (oldpos < srclen) {
        	String temp1 = pStr.substring(oldpos, srclen);
        	vec.addElement(temp1);
        }
      	results = new String[vec.size()];
         
          for (int i = 0; i < results.length; i++)
          {
              results[i] = (String)vec.elementAt(i);
          }
      	
      }
      finally
      {
          vec = null;
      }
      return results;
}

/**
 *  byte계산
 *  @param      source      
 *  @return     string
 *  @author     이충훈
 *  @since      1.0         2009.02.12
 */
public int lenByte(String code)
{
  int strLen = 0;
  try{  
    byte[] bs = code.getBytes();
    strLen = bs.length;
  }
  finally
  {
    return strLen;  
  }
}

	/**
	 *  서버 구분자 리턴
	 *  @param      source      
	 *  @return     string
	 *  @author     김인수
	 *  @since      1.0         2009.10.19
	 */
	public String hostAddress()
	{	
		String wasSection = "";
		
		try{
			InetAddress inet = InetAddress.getLocalHost();
			String inet_ip   = inet.getHostAddress();
			
	        if(inet_ip.equals(XmlPropertyManager.getSystemProperty("dev_was"))){ //개발서버인 경우..
	        	wasSection = "dev";
	        }else if(inet_ip.equals(XmlPropertyManager.getSystemProperty("front_was1")) || inet_ip.equals(XmlPropertyManager.getSystemProperty("front_was2"))){
	        	wasSection = "op";
	        }
			
		} finally {
			return wasSection;
		}
	}

}