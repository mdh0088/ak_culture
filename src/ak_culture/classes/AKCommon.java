package ak_culture.classes;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;


public class AKCommon {
	private static String bundang_approve_ip;
	private static String bundang_approve_port;
	
	
	public static String getBundang_approve_ip() {
		return bundang_approve_ip;
	}

	public static void setBundang_approve_ip(String bundang_approve_ip) {
		AKCommon.bundang_approve_ip = bundang_approve_ip;
	}

	public static String getBundang_approve_port() {
		return bundang_approve_port;
	}

	public static void setBundang_approve_port(String bundang_approve_port) {
		AKCommon.bundang_approve_port = bundang_approve_port;
	}

	public static String GetCustEncCardNoDec(String store, String encCardNo_send_str) throws Exception {
        String recv_buff = null;
        String hq = "00";

        String decCardNo = null;
        BABatchRun acard = new BABatchRun();

        // 점별 통신 ip 와 port 번호 set.
        // setting to ak_configuration.properties

        // 점별 통신 ip 와 port 번호 set.
        if("00".equals(hq) && "01".equals(store))
		{
            // 구로점
            acard.setHost("172.10.1.71", 9302);
        }
		else if("00".equals(hq) && "02".equals(store))
		{
            // 수원점
            acard.setHost("173.10.1.71", 9302);
        }
		else if("00".equals(hq) && "03".equals(store))
		{
            // 분당점
			acard.setHost(bundang_approve_ip, Integer.parseInt(bundang_approve_port));
        }
		else if("00".equals(hq) && "04".equals(store))
		{
            // 평택점
            acard.setHost("174.10.1.71", 9302);
        }
		else if("00".equals(hq) && "05".equals(store))
		{
            // 원주점
            acard.setHost("175.10.1.71", 9302);
        }

        // 테스트서버인 경우
        // test ip,port
        // 08년 11월까지 사용 acard.setHost("91.1.111.92", 9302);
        // 12년 5월 13일까지 사용 acard.setHost("91.3.111.24", 9302);

        // ★ 12년 5월 14일 변경됨(조진수대리 통보) 현재 테스트 경우에 사용중임

        // 테스트서버인 경우
        // ////////////////////////////////////////////////////////////////////////////////////////////////////
//        try {
//            String serverUID = PropertyServiceUtil.getProperty("akris.server.uid");
//
//            if("TAKRIS".equals(serverUID)){
//                acard.setHost(BACommonUtil.cardHostTest, BACommonUtil.cardPortTest);
//                System.out.println("***** serverUID[" + serverUID + "] : " + BACommonUtil.cardHostTest + ":" + BACommonUtil.cardPortTest);
//            }
//        } catch (Exception e){
//            e.printStackTrace();
//        }
//        acard.setHost("91.3.105.11", new Integer("9002").intValue()); 
        // ////////////////////////////////////////////////////////////////////////////////////////////////////

        // System.out.println("<setHost -------- NEW : 91.3.105.15 > / <setPort : 9302
        // >");


        // sysdate setting

        // String encst = encCardNo_send_str.substring(0,42);
        // String encDt = encCardNo_send_str.substring(42);
        //        
        // for(int i = 0; i < encDt.length();i++){
        // int chPoint = ((int)encDt.charAt(i))+1;
        // char encChar = (char)chPoint;
        // encst+= String.valueOf(encChar);
        // }

        // 통신체크
        String btMsg = acard.start();
        if(btMsg.equals("OK")){
            recv_buff = acard.encCardNo_run(encCardNo_send_str);
            decCardNo = recv_buff.trim();
        } else {
            throw new Exception(btMsg);
        }

        if(decCardNo == null || decCardNo.startsWith("Fail0000")){
            throw new Exception(decCardNo);
        }

        acard.stop();
        return decCardNo;
    }
	
	static public String getCurrentDate() {
	     java.util.Date date = new java.util.Date();
	      SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");

	      return dateFormat.format(date);
	  }


	  /*************************************************
	   * 현재 시간을 가져오는 함수 (서버모듈에서 실행)
	   *
	   * @return            시분초 6자리 String
	   *************************************************/
	   static public String getCurrentTime() {
	      java.util.Date date = new java.util.Date();
	      SimpleDateFormat dateFormat = new SimpleDateFormat("HHmmss");

	      return dateFormat.format(date);
	  }
	   static public String RPAD(String str, int len, char pad) {
		     String result = str;
		     int templen = len - result.getBytes().length;

		     for (int i = 0; i < templen; i++) {
		        result = result + pad;
		     }

		     return result;
		  }
	   
	   public static String GetCustEncCardNoDecStr(String store, String encCardNo_send_str) throws Exception {
	        String recv_buff = null;
	        String hq = "00";

	        String decCardNo = null;
	        BABatchRun acard = new BABatchRun();

	        // 점별 통신 ip 와 port 번호 set.
	        // setting to ak_configuration.properties

	        // 점별 통신 ip 와 port 번호 set.
	        if("00".equals(hq) && "01".equals(store))
			{
	            // 구로점
	            acard.setHost("172.10.1.71", 9302);
	        }
			else if("00".equals(hq) && "02".equals(store))
			{
	            // 수원점
	            acard.setHost("173.10.1.71", 9302);
	        }
			else if("00".equals(hq) && "03".equals(store))
			{
	            // 분당점
				acard.setHost(bundang_approve_ip, Integer.parseInt(bundang_approve_port));
	        }
			else if("00".equals(hq) && "04".equals(store))
			{
	            // 평택점
	            acard.setHost("174.10.1.71", 9302);
	        }
			else if("00".equals(hq) && "05".equals(store))
			{
	            // 원주점
	            acard.setHost("175.10.1.71", 9302);
	        }

	        // 통신체크
	        String btMsg = acard.start();
	        if(btMsg.equals("OK")){
	            recv_buff = acard.encCardNo_run(encCardNo_send_str);
	            System.out.println("recv_buff : "+recv_buff);
	            decCardNo = recv_buff.trim();
	            System.out.println("decCardNo : "+decCardNo);
	        } else {
	        	System.out.println("복호화 실패");
	            throw new Exception(btMsg);
	        }

	        if(decCardNo == null || decCardNo.startsWith("Fail0000")){
	        	System.out.println("복호화 실패2");
	            throw new Exception(decCardNo);
	        }
	        
	        acard.stop();
	        return decCardNo;
	    }
	   static public String LPAD(String str, int len, char pad) {
		     String result = str;
		     int templen = len - result.getBytes().length;

		     for (int i = 0; i < templen; i++)
		        result = pad + result;

		     return result;
		  }
	   public static String ByteSubStr( String Pst_Str, int Pi_Off, int Pi_Len ) throws UnsupportedEncodingException
	    {
	        byte[] Ly_Str = Pst_Str.getBytes();
	        String Lst_Str = new String( Ly_Str, Pi_Off, Pi_Len );

	        return Lst_Str.trim();
	    }
	   
	   public static String subString(String str, int startIndex, int length, String encoding){
	        byte[] b1 = null;
	        byte[] b2 = null;
	        String strTmp = null;

	        try {
	            if(str == null){
	                return "";
	            }

	            if(encoding == null)
	                b1 = str.getBytes();
	            else
	                b1 = str.getBytes(encoding);

	            b2 = new byte[length];

	            if(length > (b1.length - startIndex)){
	                length = b1.length - startIndex;
	            }

	            System.arraycopy(b1, startIndex, b2, 0, length);
	        } catch (Exception e){
	            e.printStackTrace();
	        }

	        try {
	            if(encoding == null)
	                strTmp = new String(b2);
	            else
	                strTmp = new String(b2, encoding);
	        } catch (Exception e){
	        }

	        return strTmp;
	    }
	   public static String getSiteCdKeyPg(String store, String card_fg, String type)
	    {
	    	String site_cd = "";
	    	
	    	if(type.equals("site_cd"))
	    	{
	    		if(store.equals("02")){
	    			if(card_fg.equals("822")){ //신한
	    				site_cd = "D2936";
	                }else if(card_fg.equals("042")){ //국민
	                    site_cd = "A7NBR";
	    			}else if(card_fg.equals("034")){ //우리
	                    site_cd = "A8XQT";
	    			}else{
	    				site_cd = "D2935";
	    			}
	    		}else if(store.equals("03")){
	    			if(card_fg.equals("822")){
	    				site_cd = "D2939";                                       
	                }else if(card_fg.equals("042")){
	                    site_cd = "A7NBO";
	                }else if(card_fg.equals("034")){
	                    site_cd = "A8XQM";
	    			}else{
	    				site_cd = "D2938";
	    			}
	                // 실제 반영 시 주석 
	                // site_cd = "T0000";
	    		}else if(store.equals("04")){
	    			if(card_fg.equals("822")){
	    				site_cd = "A91CL";
	                }else if(card_fg.equals("042")){
	                    site_cd = "A91CN";
	                }else if(card_fg.equals("034")){
	                    site_cd = "A91CM";
	    			}else{
	    				site_cd = "A91C2";
	    			}
	    		}else if(store.equals("05")){
	    			if(card_fg.equals("822")){
	    				site_cd = "D8474";
	                }else if(card_fg.equals("042")){
	                    site_cd = "A7NBP";
	                }else if(card_fg.equals("034")){
	                    site_cd = "A8XQS";
	    			}else{
	    				site_cd = "D8473";
	    			}
	    		}
	    	}else if(type.equals("site_key")){
	    		if(store.equals("02")){
	    			if(card_fg.equals("822")){ 
	    				site_cd = "3jN-Rwp2pjKDqfIHzQOJYl7__";
	                }else if(card_fg.equals("042")){
	                    site_cd = "1NEF-aXhGekL3H4GXVc9XEf__";
	                }else if(card_fg.equals("034")){
	                    site_cd = "396h6qtw048nEJTgx6iP507__";
	                }else{
	    				site_cd = "2o4jvNPIQpRetsBzigP50V4__";
	    			}
	    		}else if(store.equals("03")){
	    			if(card_fg.equals("822")){
	    				site_cd = "4S0u5vw08FMG3WVK..tgH1X__";
	                }else if(card_fg.equals("042")){
	                    site_cd = "0v2AwLQcbTY7tMmlFN5CkIS__";
	                }else if(card_fg.equals("034")){
	                    site_cd = "24bqTD92LB67JAG5XHGw3f4__";
	                }else{
	    				site_cd = "10n5054r5SJ12OxRaxHABGN__";
	    			}
	                // TEST
	                // site_cd = "3grptw1.zW0GSo4PQdaGvsF__";
	    		}else if(store.equals("04")){
	    			if(card_fg.equals("822")){
	    				site_cd = "2PRQbkcaWuFvPUurHEIcwO4__";
	                }else if(card_fg.equals("042")){
	                    site_cd = "1l-FFr-aZgoH-s4jNDj66IN__";
	                }else if(card_fg.equals("034")){
	                    site_cd = "3Gj0NjJxyC3WWEsMOOCoKy6__";
	                }else{
	    				site_cd = "3SXs8hAwjfR0UYqe0Jh9P5l__";
	    			}
	    		}else if(store.equals("05")){
	    			if(card_fg.equals("822")){
	    				site_cd = "02q-T6ZMMW6t-vwxgkMb59S__";
	                }else if(card_fg.equals("042")){
	                    site_cd = "1ugODjFZwxvd7vXfIzI-DmL__";
	                }else if(card_fg.equals("034")){
	                    site_cd = "2Ua0JNXSB7xRhdFk3K6wXaf__";
	                }else{
	    				site_cd = "3BCKqT4rbt-bj9By28nFlM6__";
	    			}
	    		}
	    	} 	
	    	
	    	return site_cd;
	    }
}
