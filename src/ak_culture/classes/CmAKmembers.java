package ak_culture.classes;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import ak_culture.model.member.LectDAO;



public class CmAKmembers {
	
	
	
	public static String getANYLINK_AU1() {
		return ANYLINK_AU1;
	}
	public static void setANYLINK_AU1(String aNYLINK_AU1) {
		ANYLINK_AU1 = aNYLINK_AU1;
	}
	public static String getANYLINK_AU2() {
		return ANYLINK_AU2;
	}
	public static void setANYLINK_AU2(String aNYLINK_AU2) {
		ANYLINK_AU2 = aNYLINK_AU2;
	}
	private final String nowDate = getKSTFormat("yyyyMMdd");
	private final String nowTime = getKSTFormat("HHmmss"); 
	
	//TEST
//	private static String ANYLINK_AU1 = "http://91.1.111.92:30002/soaptest/receiver";
//	private static String ANYLINK_AU2 = "http://91.1.111.92:30002/soaptest/receiver";
	//REAL
//	private static String ANYLINK_AU1 = "http://91.1.111.61:30002/soaptest/receiver";
//	private static String ANYLINK_AU2 = "http://91.1.111.62:30002/soaptest/receiver";
	
	private static String ANYLINK_AU1;
	private static String ANYLINK_AU2;
	
	private Document doc = null;

	public String getAKmemStatus(HashMap AKmemRead) {
		String respNo = null;
		try {

			HashMap map = AKmemRead;

			//respNo 정보만 get
	          respNo = (String)map.get("AKmem_Resp_No");  //00 만 정상

		} catch (Exception e) {
			System.out.print("[ERROR]AKmem_Resp_No-->");
			e.printStackTrace();
		}

		return respNo;
	}
	public String getAKmemPw(HashMap AKmemRead) {
		String respNo = null;
		try {

			HashMap map = AKmemRead;

			//respNo 정보만 get
	          respNo = (String)map.get("AKmem_Pw");  //00 만 정상

		} catch (Exception e) {
			System.out.print("[ERROR]PSWD-->");
			e.printStackTrace();
		}

		return respNo;
	}
	public int getAKmemPoint(HashMap AKmemRead) {
		int rtnPoint = 0;
		try {

			HashMap map = AKmemRead;

			//마일리지 정보만 get
			rtnPoint = Integer.parseInt((String) map.get("AKmem_total_point"));

		} catch (Exception e) {
			System.out.print("[ERROR]getAKmemPoint-->");
			e.printStackTrace();
		}

		return rtnPoint;
	}

	public HashMap getAKmemRead(String store, String akmem_cardno, String pos_no) {
		HashMap map = null;
		try {
			//map = getAKmemCustInfo(store,akmem_cardno);
            //우회 방식에서 다이렉 방식으로 변경 20190522 김동현
        	map = getAKmemCustInfo_direct(store,akmem_cardno, pos_no);

		} catch (Exception e) {
			System.out.print("[ERROR]getAKmemPoint-->");
			e.printStackTrace();
		}

		return map;
	}
	public HashMap getAKmemCustInfo( String store, String akmem_cardno )
    {
        HashMap map = null  ;
        try {
          
          AKmemTran AKmem = new AKmemTran();
          //전문생성
          String ls_akmem_send_str = AKmem.AKmem_Run
                          ( store
                          , "XA241S"      //String pID
                          , akmem_cardno  //String akmem_cardno
                          , null          //String akmem_CustNo
                          , null          //String akmem_Family_CustNo
                          , null          //String akmem_use_yn
                          , null          //String recpt_cardno
                          , null          //String recpt_sale_ymd
                          , null          //Stirng ori_recpt_sale_ymd 원거래 매출일자  ★ 추가 (2012.07.16)
                          , "070013"      //String recpt_pos_no
                          , null          //String recpt_no
                          , null          //String ori_recpt_no 원거래 영수증번호  ★ 추가 (2012.07.16)
                          , null          //String total_amt
                          , null          //String akmem_recpt_point
                          , null);        //적립 및 취소경우 필요(취소 개발로 추가됨 적립경우:SAVE, 취소경우:CANCEL) 2012.07.16
          
          map = AKmem.AKmemExec(ls_akmem_send_str);
         
        } catch (Exception e) {
            System.out.print("[ERROR]getAKmemCustInfo-->");
            e.printStackTrace();
        }   
        
        return map;     
    }

	public HashMap getAKmemCustInfo_direct(String store, String akmem_cardno, String pos_no) {
		HashMap<String, String> map = new HashMap<String, String>();
		HashMap<String, String> rtMap = new HashMap<String, String>();

		try {
			// HashMap<String, String> map = new HashMap<String, String>();
			String strResult = "";
			String FRAN_CD = "";
			String FRAN_NM = "";
			String INST_CD = "";
			//  가맹점코드
			if("01".equals(store)) {
 	           FRAN_NM     =   "문화아카데미 구로점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
 	           FRAN_CD     =   "00103"; //  가맹점코드 00103 00203 00303 00403 00503
 	           INST_CD     =   "1011" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
 	        } else if("02".equals(store)) {
 	           FRAN_NM     =   "문화아카데미 분당점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
 	           FRAN_CD     =   "00203"; //  가맹점코드 00103 00203 00303 00403 00503
 	           INST_CD     =   "1031" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
 	        } else if("03".equals(store)) {
 	           FRAN_NM     =   "문화아카데미 분당점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
 	           FRAN_CD     =   "00303"; //  가맹점코드 00103 00203 00303 00403 00503
 	           INST_CD     =   "1021" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
 	        } else if("04".equals(store)) {
 	           FRAN_NM     =   "문화아카데미 분당점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
 	           FRAN_CD     =   "00403"; //  가맹점코드 00103 00203 00303 00403 00503
 	           INST_CD     =   "1021" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
 	        } else if("05".equals(store)) {
 	           FRAN_NM     =   "문화아카데미 분당점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
 	           FRAN_CD     =   "00503"; //  가맹점코드 00103 00203 00303 00403 00503
 	           INST_CD     =   "1021" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
 	        }
			String TEAM_CD     =   "   "; 

			map.put("inst_cd", INST_CD);
			map.put("card_no", akmem_cardno);
			map.put("fran_cd", FRAN_CD);
			map.put("store", store);
			strResult = memAuth(map, pos_no);
			System.out.println("strResult : "+strResult);
			
			parse(strResult);
			

			rtMap.put("sApprovNo", getTextByTagName("RSP_CD"));
			rtMap.put("sMessage", getTextByTagName("MSG_TRMNL"));
			rtMap.put("AKmem_Resp_No", getTextByTagName("RSP_CD"));
			rtMap.put("AKmem_Resp_Msg", getTextByTagName("MSG_TRMNL"));
			rtMap.put("AKmem_CustNo", getTextByTagName("CUS_NO"));
			rtMap.put("AKmem_Family_CustNo", getTextByTagName("FML_PT_MG_NO"));
			rtMap.put("AKmem_CustName", getTextByTagName("MBR_NM"));
			rtMap.put("AKmem_CustLevel", getTextByTagName("PTCP_MBR_GDC"));
			rtMap.put("AKmem_total_point", getTextByTagName("EUSE_PT"));
			rtMap.put("AKmem_use_yn", getTextByTagName("CUS_RG_YN"));
			rtMap.put("AKmem_Card_Type", getTextByTagName("CARD_KND_DIV_CD"));
			rtMap.put("AKmem_RegiCard_yn", getTextByTagName("NOR_CD_RG_YN"));
			rtMap.put("AKmem_RegiCard_no", getTextByTagName("NOR_CD_RG_LT"));
			rtMap.put("AKmem_Use_Min_Point", getTextByTagName("MIN_USE_PSB_PT"));
			rtMap.put("AKmem_Use_Max_Point", getTextByTagName("MAX_USE_PSB_PT"));
			rtMap.put("AKmem_Use_hurdle", getTextByTagName("USE_UNIT_PT"));
			rtMap.put("AKmem_Pswd", getTextByTagName("PSWD"));

			/*
    		 * AKmem_Resp_No        = ByteSubStr(recv_buff,25,2);    //akmembers 응답코드(00:정상 else 기타)
                AKmem_Resp_Msg       = ByteSubStr(recv_buff,181,64);  //akmembers 응답메세지                    
                AKmem_CustNo         = ByteSubStr(recv_buff,121,9);  //akmembers 회원번호
                AKmem_Family_CustNo  = ByteSubStr(recv_buff,130,10);  //akmembers 가족번호
                AKmem_CustName       = ByteSubStr(recv_buff,362,40);  //akmembers 회원명
                AKmem_CustLevel      = ByteSubStr(recv_buff,254,7);  //akmembers 회원등급
                AKmem_total_point    = ByteSubStr(recv_buff,159,10);  //akmembers 가용포인트
                AKmem_use_yn         = ByteSubStr(recv_buff,245,1);  //akmembers 고객등록여부
                AKmem_Card_Type      = ByteSubStr(recv_buff,246,1);  //akmembers 카드타입(1:단순멤버스,2:제휴신용,3:드림카드,4:플러스카드,5:VIP카드,8:국민제휴)
                AKmem_RegiCard_yn    = ByteSubStr(recv_buff,290,1);  //akmembers 등록된 신용카드 유무(0:등록카드없음,1:카드있음)
                AKmem_RegiCard_no    = ByteSubStr(recv_buff,710,160);  //akmembers 등록된 신용카드 List (max 10pcs)
                AKmem_Stf_div        = ByteSubStr(recv_buff,289,1);  //akmembers 직원구분(1,2,3)
                AKmem_Use_Min_Point  = ByteSubStr(recv_buff,291,10);  //akmembers 최소사용 포인트
                AKmem_Use_Max_Point  = ByteSubStr(recv_buff,301,10);  //akmembers 최대사용 포인트
                AKmem_Use_hurdle     = ByteSubStr(recv_buff,311,10);  //akmembers 사용단위(허들) 포인트
    		 * 
    		 */

		} catch (Exception e) {
			System.out.print("[ERROR]getAKmemCustInfo_new-->");
			e.printStackTrace();
		}

		return rtMap;
	}

	public void parse(String result) {
		try {
			// result = new String(result.getBytes("euc-kr"),"utf-8");
			byte[] b = result.getBytes("utf-8");
			ByteArrayInputStream bais = new ByteArrayInputStream(b);
			DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
			dbf.setNamespaceAware(true);
			DocumentBuilder dBuilder = null;
			// Document doc = null;

			dBuilder = dbf.newDocumentBuilder();
			doc = dBuilder.parse(bais);

		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// return doc;
	}

	public String getTextByTagName(String NodeName) {
		String returnVal = "";
		if ("".equals(NodeName)) {
			returnVal = "";
		} else {
			NodeList nodeL = doc.getElementsByTagName(NodeName);
			if (nodeL.getLength() == 0) {
				returnVal = "";
			} else {
				Node node = nodeL.item(0);
				returnVal = node.getTextContent();
			}
		}
		/*
		 * try { //returnVal = new String(returnVal.getBytes("UTF-8"),"EUC-KR"); } catch
		 * (UnsupportedEncodingException e) { e.printStackTrace(); }
		 */
		// returnVal = new String(returnVal);
		return returnVal;
	}

	public String memAuth(HashMap<String, String> hMap, String pos_no) {

		long lngStart = System.currentTimeMillis();
		HashMap<String, String> rtMap = new HashMap<String, String>();
		String strSend = "";
		String strResult = "";
		try {
			//회원인증전문날리기
			strSend = getGram2000(setControl("2000", (String) hMap.get("inst_cd")), hMap, pos_no);
			System.out.println("strSend : " +strSend);
			// strSend = getGram2000(setControl("2000","1014"), hMap);
			long lng2000 = System.currentTimeMillis();
			strResult = doSendSoap4AU(strSend);
		} catch (Exception e) {
		}

		return strResult;
	}

	private String getGram2000(StringBuffer sbG, HashMap hMap, String pos_no) {

		sbG.append("	<RequestType>");
		sbG.append("		<WCC>1</WCC>");
		sbG.append("		<PERM_RQ_DIV>2</PERM_RQ_DIV>");
		sbG.append("		<CARD_NO>").append((String) hMap.get("card_no")).append("</CARD_NO>");
		sbG.append("		<PSWD/>");
		sbG.append("		<NOR_CD_CK_YN>0</NOR_CD_CK_YN>");
		sbG.append("		<NOR_CDNO/>");
		sbG.append("		<DE_DIV_CD/>");
		sbG.append("		<DE_RSON/>");
		// sbG.append("
		// <FRAN_CD>").append((String)hMap.get("fran_cd")).append("</FRAN_CD>");
		sbG.append("		<FRAN_CD>").append((String) hMap.get("fran_cd")).append("</FRAN_CD>");
		sbG.append("		<TEAM_CD/>");
		sbG.append("		<POS_NO>"+pos_no+"</POS_NO>");
		sbG.append("		<MBR_INFO_RQ>0</MBR_INFO_RQ>");
		sbG.append("		<FILLER/>");
		sbG.append("	</RequestType>");
		sbG.append("</AAU>");
		sbG.append("</soap:Body>");
		sbG.append("</soap:Envelope>");

		return sbG.toString();
	}

	private StringBuffer setControl(String gramNo, String instCd) {

		String dataSize = "0";
		if("2000".equals(gramNo)){ //회원인증
			dataSize = "0193";
		}else if("1210".equals(gramNo)||"1220".equals(gramNo)){ //포인트사용
			dataSize = "0391";
		}else if("1310".equals(gramNo)){  //포인트조정 
			dataSize = "0389";
		}else if("1010".equals(gramNo)){
			dataSize = "395";
		}else if("1110".equals(gramNo)||"1120".equals(gramNo)){ //포인트적립
			dataSize = "0840";
		}

		StringBuffer sbG = new StringBuffer();
		sbG.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		sbG.append("<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">");
		sbG.append("<soap:Body>");
		sbG.append("<AAU>");
		sbG.append("	<ControlType>");
		sbG.append("		<HD_TY>I</HD_TY>");
		sbG.append("		<GRAM_NO>").append(gramNo).append("</GRAM_NO>");
		sbG.append("		<INST_CD>").append(instCd).append("</INST_CD>");
		sbG.append("		<TRS_DT>").append(nowDate).append("</TRS_DT>");
		sbG.append("		<TRS_PTM>").append(nowTime).append("</TRS_PTM>");
		sbG.append("		<GRAM_DIV>ON</GRAM_DIV>");
		sbG.append("		<RSP_CD/>");
		sbG.append("		<DATA_SZ>").append(dataSize).append("</DATA_SZ>");
		sbG.append("		<SYS_AREA/>");
		sbG.append("	</ControlType>");
		return sbG;
	}

	public static String getKSTFormat(String kfFormat) {
		SimpleDateFormat formatter = new SimpleDateFormat(kfFormat, Locale.KOREA);
		return formatter.format(new Date());
	}

	public static String doSendSoap4AU(String xmlData) throws Exception {
		String endPoint1 = ANYLINK_AU1;
		System.out.println("ANYLINK_AU1 : "+endPoint1);
		String endPoint2 = ANYLINK_AU2;
		System.out.println("ANYLINK_AU2 : "+endPoint2);
		String endPoint = "";
		String rtnMsg = "";

		if (isCheckHttp(endPoint1)) {
			System.out.println("seviceChk.isCheckHttp(endPoint1) ---> ANYLINK_AU1 : " + isCheckHttp(endPoint1));
			endPoint = endPoint1;
			rtnMsg = doSendSoap(endPoint, xmlData);
		} else if (isCheckHttp(endPoint2)) {
			System.out.println("seviceChk.isCheckHttp(endPoint1) ---> ANYLINK_AU2 : " + isCheckHttp(endPoint1));
			endPoint = endPoint2;
			rtnMsg = doSendSoap(endPoint, xmlData);
		} else {
			rtnMsg = "";
		}

		return rtnMsg;

	}

	public static String doSendSoap(String endPoint, String xmlData) throws Exception {

		String SOAPUrl = endPoint;

		String SOAPAction = "";

		// 전달 보낸 전문 로고 남기기.
		System.out.println("xmlData : "+xmlData);

		try {
			// Create the connection where we're going to send the file.
			URL url = new URL(SOAPUrl);
			URLConnection connection = url.openConnection();
			// connection.setReadTimeout(3000);
			HttpURLConnection httpConn = (HttpURLConnection) connection;

			// Open the input file. After we copy it to a byte array, we can see
			// how big it is so that we can set the HTTP Cotent-Length
			// property. (See complete e-mail below for more on this.)
	
			//FileInputStream fin = new FileInputStream(xmlFile2Send);
			//ByteArrayOutputStream bout = new ByteArrayOutputStream();
	
			// Copy the SOAP file to the open connection.
	
			//copy(fin, bout);
			//fin.close();
	
			//byte[] b = bout.toByteArray();
			//xmlData = new String(xmlData.getBytes("euc-kr"),"utf-8");
			//System.out.println("#######################  전문  Start #####################################");
			//System.out.println(xmlData);
			//System.out.println("######################### 전문  End###################################");
			byte[] b = xmlData.getBytes("utf-8");
			// b = makeSOAPMessageFromRawXml(b);
			// Set the appropriate HTTP parameters.

			httpConn.setRequestProperty("Content-Length", String.valueOf(b.length));
			httpConn.setRequestProperty("Content-Type", "text/xml; charset=utf-8");
			httpConn.setRequestProperty("SOAPAction", SOAPAction);
			httpConn.setRequestMethod("POST");
			httpConn.setDoOutput(true);
			httpConn.setDoInput(true);

			// Everything's set up; send the XML that was read in to b.
			OutputStream out = httpConn.getOutputStream();
			out.write(b);
			out.close();

			// Read the response and write it to standard out.

			// InputStreamReader isr = new InputStreamReader(httpConn.getInputStream());
			InputStreamReader isr = new InputStreamReader(httpConn.getInputStream(), "UTF-8");
			BufferedReader in = new BufferedReader(isr);
			String inputLine;
			StringBuffer rtnMsg = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				// inputLine = new String(inputLine.getBytes("utf-8"),"euc-kr");
				// System.out.println("Result==\n"+inputLine);
				inputLine = new String(inputLine.getBytes("utf-8"));
				rtnMsg.append(inputLine);
			}

			in.close();

			// 전달 받은 전문 로고 남기기.
			System.out.println("마일리지 리턴 메세지 : "+rtnMsg.toString());
			return rtnMsg.toString();
		} catch (IOException e) {
			throw new Exception(e);
		}
	}

	public static boolean isCheckHttp(String httpUrl) {

		Boolean svrIpInfo = false;
		URL httpCon = null;
		HttpURLConnection httpConn = null;

		try {
			httpCon = new URL(httpUrl);

			URLConnection conn = httpCon.openConnection();
			conn.setReadTimeout(2000);

			httpConn = (HttpURLConnection) conn; //서버에 Connection 요청.

			int responseCode = httpConn.getResponseCode(); // 불러올 사이트의 서버에서 넘겨준 접속
			// 값 → 200, 405, 404, 500 등
			
			// ANYLINK Soap 방식  기본 처리에 따라 단순  URL 을 날렸을 경우 Get 방식만 허용된다는 405를 던지면서 에러 처리를 하는 것을 포함해서 
			// 접속 상태를 200, 405 두개의 경우에 대해서 서비스를 정상이라고 처리한다.
			if ((responseCode == HttpURLConnection.HTTP_OK) || (responseCode == 405)) { // 서버에서 넘어온 접속값이 정상인 경우 
				svrIpInfo = true;
			} else {
				svrIpInfo = false;
			}

		} catch (MalformedURLException me) {
			me.printStackTrace();
			svrIpInfo = false;
		} catch (IOException ie) {
			// ie.printStackTrace();
			svrIpInfo = false;
		} finally {
			if (httpConn != null) {
				httpConn.disconnect();
			}
		}
		return svrIpInfo;
	}
	public HashMap AKmemPoint(String store
            , String akmem_cardno
            , String recpt_cardno
            , String recpt_sale_ymd
            , String recpt_pos_no
            , String recpt_no
            , String total_amt
            , String akmem_recpt_point
            , String uPointAmt
            , String ori_recpt_sale_ymd   //원거래 매출일자  ★ 추가 (2012.07.16)
            , String ori_recpt_no         //원거래 영수증번호  ★ 추가 (2012.07.1
            , String pType) throws Exception              // pType  적립 및 취소경우 필요(취소 개발로 추가됨 적립경우:SAVE, 취소경우:CANCEL) 2012.07.16
{
    
    
    	HashMap<String, String> hMap = new HashMap<String, String>();
    	
    	String ls_store    = store;
    	String FRAN_CD    =  "";
    	String FRAN_NM    =  "";
    	String INST_CD    =  "";
    	String DE_DT       =   Utils.getCurrentDate(); 			 	  //거래일자
    	String DE_PTM      =   Utils.getCurrentTime();       			  //시분초
      
    	String PTCP_PERM_NO=  "";
    	String ls_orgl_perm_no = "";
    	String ls_orgl_de_dt = "";
    	
        if("01".equals(ls_store)) {
           FRAN_NM     =   "문화아카데미 구로점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
           FRAN_CD     =   "00103"; //  가맹점코드 00103 00203 00303 00403 00503
           INST_CD     =   "1011" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
        } else if("02".equals(ls_store)) {
           FRAN_NM     =   "문화아카데미 수원점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
           FRAN_CD     =   "00203"; //  가맹점코드 00103 00203 00303 00403 00503
           INST_CD     =   "1031" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
        } else if("03".equals(ls_store)) {
           FRAN_NM     =   "문화아카데미 분당점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
           FRAN_CD     =   "00303"; //  가맹점코드 00103 00203 00303 00403 00503
           INST_CD     =   "1021" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
        } else if("04".equals(ls_store)) {
           FRAN_NM     =   "문화아카데미 평택점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
           FRAN_CD     =   "00403"; //  가맹점코드 00103 00203 00303 00403 00503
           INST_CD     =   "1021" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
        } else if("05".equals(ls_store)) {
           FRAN_NM     =   "문화아카데미 원주점"; //  가맹점명 문화아카데미 구로점 문화아카데미 수원점 문화아카데미 분당점 문화아카데미 평택점 문화아카데미 원주점
           FRAN_CD     =   "00503"; //  가맹점코드 00103 00203 00303 00403 00503
           INST_CD     =   "1021" ; // 점별 01 : 1011 02 : 1031 03 : 1021 04 : 1041 05 : 1021  
        }
        
    	if("USE".equals(pType)){
    		System.out.println(" === 마일리지 사용 === ");
    		
    		PTCP_PERM_NO=  FRAN_CD + recpt_sale_ymd + "" +recpt_pos_no+ "" + recpt_no + "22" + "000000" ;
        	PTCP_PERM_NO     =  f_setfill(PTCP_PERM_NO,31,"R");
        	
    		hMap.put("gram_no","1210"); //전문번호
    		hMap.put("de_rson","200"); //거래사유코드
    		hMap.put("rs_use_div_cd","1"); //적립사용구분코드
    		hMap.put("mbr_info_rq","1"); //회원정보요청
    		
    		
    		//여기 해야 됨
    		hMap.put("orgl_info_yn","0"); //1.원개래 정보 있음 2.원거래 정보 없음
    		hMap.put("orgl_info_div","2"); //"1":운영사 원승인정보, "2":참여사 원승인정보
    		hMap.put("orgl_perm_no",ls_orgl_perm_no); //원 승인번호
    		hMap.put("orgl_de_dt",ori_recpt_sale_ymd); //원 승인날짜
    		
    	} else if("USECANCLE".equals(pType)){
    		System.out.println(" === 마일리지 사용 취소 === ");
    		
    		PTCP_PERM_NO=  FRAN_CD + DE_DT + "" + recpt_pos_no + "" + recpt_no + "22" + "000001" ;
            PTCP_PERM_NO     =  f_setfill(PTCP_PERM_NO,31,"R");
            
            //ls_orgl_perm_no  =  f_setfill( FRAN_CD + ori_recpt_sale_ymd + "070013" + ori_recpt_no + "22" + "000000",31,"R");
            ls_orgl_perm_no  =  f_setfill( FRAN_CD + ori_recpt_sale_ymd + recpt_pos_no + ori_recpt_no + "22" + "000000",31,"R");
            ls_orgl_de_dt    =  f_setfill(ori_recpt_sale_ymd,8,"R");    //원 승인날짜
            
    		hMap.put("gram_no","1220"); //전문번호
    		hMap.put("de_rson","200"); //거래사유코드
    		hMap.put("rs_use_div_cd","2"); //적립사용구분코드
    		hMap.put("mbr_info_rq","1"); //회원정보요청
    		
    		
//    		여기 해야 됨
    		hMap.put("orgl_info_yn","1"); //1.원개래 정보 있음 2.원거래 정보 없음
    		hMap.put("orgl_info_div","2"); //"1":운영사 원승인정보, "2":참여사 원승인정보
    		hMap.put("orgl_perm_no",ls_orgl_perm_no); //원 승인번호
    		hMap.put("orgl_de_dt",ori_recpt_sale_ymd); //원 승인날짜
    	} else if("SAVE".equals(pType)){
    		System.out.println(" === 마일리지 적립 === ");
    		
    		PTCP_PERM_NO=   FRAN_CD + recpt_sale_ymd + "" + recpt_pos_no + "" + "00000000" + recpt_no;
            PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");
            
    		hMap.put("gram_no","1110"); //전문번호
    		hMap.put("de_rson","101"); //거래사유코드
    		hMap.put("rs_use_div_cd","1"); //적립사용구분코드
    		hMap.put("mbr_info_rq","1"); //회원정보요청
    		hMap.put("dfn_dt",recpt_sale_ymd); //확정일자
    		hMap.put("orgl_info_yn","0"); //1.원개래 정보 있음 2.원거래 정보 없음
    		hMap.put("orgl_info_div"," "); //"1":운영사 원승인정보, "2":참여사 원승인정보
    		hMap.put("orgl_perm_no",""); //원 승인번호
    		hMap.put("orgl_de_dt",""); //원 승인날짜
    	} else if("SAVECANCLE".equals(pType)){
    		System.out.println(" === 마일리지 적립 취소 === ");
    		
    		//ls_orgl_perm_no    =   f_setfill( FRAN_CD + ori_recpt_sale_ymd + "070013" + "00000000" + ori_recpt_no ,31,"R");    //가맹점코드(5)+원거래일자(8)+POS번호(6)+ "00000000" + 원거래번호(4)
    		ls_orgl_perm_no    =   f_setfill( FRAN_CD + ori_recpt_sale_ymd + recpt_pos_no + "00000000" + ori_recpt_no ,31,"R");    //가맹점코드(5)+원거래일자(8)+POS번호(6)+ "00000000" + 원거래번호(4)
            
            PTCP_PERM_NO=   FRAN_CD + recpt_sale_ymd + "" + recpt_pos_no + "" + "00000000" + recpt_no;       //가맹점코드(5)+거래일자(8)+POS번호(6)+ "00000000" + 거래번호(4)
            PTCP_PERM_NO=  f_setfill(PTCP_PERM_NO,31,"R");
    		
    		hMap.put("gram_no","1120"); //전문번호
    		hMap.put("de_rson","101"); //거래사유코드
    		hMap.put("rs_use_div_cd","2"); //적립사용구분코드
    		hMap.put("mbr_info_rq","1"); //회원정보요청
    		hMap.put("dfn_dt",recpt_sale_ymd); //확정일자
    		hMap.put("orgl_info_yn","1"); //1.원개래 정보 있음 2.원거래 정보 없음
    		hMap.put("orgl_info_div","2"); //"1":운영사 원승인정보, "2":참여사 원승인정보
    		hMap.put("orgl_perm_no",ls_orgl_perm_no); //원 승인번호
    		hMap.put("orgl_de_dt",ori_recpt_sale_ymd); //원 승인날짜
    	}
    	
    	int sumTotal = Integer.parseInt(total_amt) + Integer.parseInt(uPointAmt) ;
    	
		hMap.put("card_no",f_setfill(akmem_cardno,37,"R")); //카드번호
		hMap.put("sCard_no",recpt_cardno); //결제카드번호
		hMap.put("fran_cd",FRAN_CD); //가맹점코드
		hMap.put("ptcp_perm_no",PTCP_PERM_NO); //참여사승인번호
		hMap.put("inst_cd",INST_CD); //기관코드
		hMap.put("tot_sales_amt",""+f_setfill_zero(""+sumTotal,12,"L")); //총결제금액
		hMap.put("tot_crea_pt",""+f_setfill_zero(akmem_recpt_point,10,"L")); //
		
		hMap.put("use_pt",StringUtil.strFillLeft(""+uPointAmt,10,'0')); //사용포인트
		hMap.put("sl_nm",FRAN_NM + f_setfill("",50-lenByte(FRAN_NM),"R")); //매출명
		
		//hMap.put("orgl_info_yn","0"); //원거래정보유무	ORGL_INFO_YN	CHAR	1	"""1"":원거래정보있음, 
                                      //		""0"" : 원거래정보없음"	"1" : 원거래정보있음, "0" : 원거래정보없음
		//hMap.put("orgl_perm_no",""); //원승인번호	ORGL_PERM_NO	CHAR	31	"원거래정보구분==>
									/*	     ""1""이면 운영사 원승인번호(9자리),
										     ""2""이면 원참여사승인번호 
										     가맹점코드(5)+거래일자(8)+POS번호(6)+거래번호(12)"	"원거래정보구분==>
										     ""1""이면 운영사 원승인번호,
										     ""2""이면 원참여사승인번호 
										     가맹점코드(5)+거래일자(8)+POS번호(6)+거래번호(12)"
									*/
		//hMap.put("orgl_de_dt","");
		/*
		 * 원거래일자	ORGL_DE_DT	CHAR	8	"원거래정보구분=""1""이면 운영사 원승인일자,
               ""2""이면 참여사 원거래일자"	"원거래정보구분=""1""이면 운영사 원승인일자,
               ""2""이면 참여사 원거래일자" 
		 * */
		System.out.println("전문번호 === "+hMap.get("gram_no"));
		System.out.println(" store === > " +store );
		System.out.println(" akmem_cardno === > " +akmem_cardno );
		System.out.println(" recpt_cardno === > " +recpt_cardno );
		System.out.println(" recpt_sale_ymd === > " +recpt_sale_ymd );
		System.out.println(" recpt_pos_no === > " +recpt_pos_no );
		System.out.println(" recpt_no === > " +recpt_no );
		System.out.println(" total_amt === > " +total_amt );
		System.out.println(" akmem_recpt_point === > " +akmem_recpt_point );
		System.out.println(" uPointAmt === > " +uPointAmt );
		System.out.println(" ori_recpt_sale_ymd === > " +ori_recpt_sale_ymd );
		System.out.println(" ori_recpt_no === > " +ori_recpt_no );
		System.out.println(" pType === > " +pType );
		
		hMap = sendGram(hMap, recpt_pos_no);
		/*if(hMap != null){
			if("00".equals(hMap.get("rsp_cd"))){
				//actionobj.setPerm_no(hMap.get("perm_no"));
				System.out.println("PERM_NO === "+ hMap.get("PERM_NO"));
			}else{
				//actionobj.setPerm_no("ERROR");
				//actionobj.setResultMsg("승인에러 : "+hMap.get("MSG_TRMNL"));
				System.out.println("MSG_TRMNL === "+ hMap.get("MSG_TRMNL"));
			}		
		}*/
		
    	return hMap;
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
	public String trim(String str)
    {
      return str.trim();
    }
	public String space(int len) 
    {
        String spaceString = "";
        for(int i = 0; i < len; i++) {
            spaceString = spaceString + " ";
        }
        return spaceString;
    }  
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

	 public String zero(int len)
	    {
	        String zeroString = "";
	        for(int i = 0; i < len; i++) {
	            zeroString = zeroString + "0";
	        }
	        return zeroString;
	    }  
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
	 public HashMap sendGram(HashMap<String, String> hMap, String pos_no) throws Exception {
			if("1210".equals(hMap.get("gram_no"))||"1220".equals(hMap.get("gram_no"))){
				return sendGram1210(hMap, pos_no); //사용, 사용취소 전문처리 (회원인증+사용 또는 사용취소)
			}else if("1310".equals(hMap.get("gram_no"))){
				return sendGram1310(hMap, pos_no); //조정전문처리 (회원인증+조정)
			}else if("1010".equals(hMap.get("gram_no"))){
				return sendGram1010(hMap); //마일리지 포인트 조회 전문처리
			}else if("1110".equals(hMap.get("gram_no"))||"1120".equals(hMap.get("gram_no"))){
				return sendGram1110(hMap, pos_no); //적립, 적립취소 전문처리 (회원인증+적립 또는 적립취소)
			}
			
		return null;
	}
	 private HashMap sendGram1210(HashMap<String, String> hMap, String pos_no){

			long lngStart = System.currentTimeMillis();
			Print("XXX sendGram1210 ���� XXX ::: ����ð�="+lngStart);		
			HashMap<String, String> rtMap = new HashMap<String, String>();
			String strSend = "";
			String strResult = "";
			try{			
				//회원인증전문날리기
				strSend = getGram2000(setControl("2000",(String)hMap.get("inst_cd")), hMap, pos_no);
				long lng2000 = System.currentTimeMillis();
				Print("XXX 인증전문 Send 전 XXX ::: 현재시간="+lng2000);
				strResult = doSendSoap4AU(strSend);
				Print("XXX 인증전문 Send 끝  XXX ::: 현재시간="+System.currentTimeMillis()+", 인증전문통과시간="+new Long(System.currentTimeMillis() - lng2000));
				Print("인증전문 리턴 Result="+strResult);
				if(!"".equals(strResult)&& strResult!=null){
					parse(strResult); 	
					if("00".equals(getTextByTagName("RSP_CD"))){
						rtMap.put("rsp_cd",getTextByTagName("RSP_CD"));
						hMap.put("cus_no",getTextByTagName("CUS_NO"));
						hMap.put("fml_pt_mg_no",getTextByTagName("FML_PT_MG_NO"));
						hMap.put("cus_rg_yn",getTextByTagName("CUS_RG_YN"));
//						고객등록여부가 1이고 고객번호가 9자리인 경우(수정해야함!!)
						if (hMap.get("cus_rg_yn").equals("1")) {
							//사용전문날리기
								
							strSend = getGram1210(setControl(hMap.get("gram_no"),hMap.get("inst_cd")), hMap);
							long lng1210 = System.currentTimeMillis();
							Print("XXX 사용전문  Send 전 XXX ::: 현재시간="+lng1210);
							strResult = doSendSoap4AU(strSend);
							Print("XXX 사용전문  Send 후 XXX ::: 현재시간="+System.currentTimeMillis()+", 사용전문통과시간="+new Long(System.currentTimeMillis() - lng1210));
							Print("사용전문 리턴 Result="+strResult);
							if(!"".equals(strResult)&& strResult!=null){
								parse(strResult);
								
								if("00".equals(getTextByTagName("RSP_CD"))){
									
									rtMap.put("RSP_CD", "00");
									rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));
									rtMap.put("CUS_NO", getTextByTagName("CUS_NO")); //AKmem_CustNo
									rtMap.put("PTCP_PERM_NO", getTextByTagName("PTCP_PERM_NO")); //AKmem_SaveApproveNo
									rtMap.put("PERM_NO", getTextByTagName("PERM_NO")); //AKmem_SaveApproveNo_POS
									rtMap.put("EUSE_PT", getTextByTagName("EUSE_PT")); //AKmem_SaveApprove_Point
									rtMap.put("TOT_CREA_PT", getTextByTagName("TOT_CREA_PT")); //AKmem_Create_Point
									rtMap.put("DE_DT", getTextByTagName("DE_DT"));
									rtMap.put("DE_PTM", getTextByTagName("DE_PTM"));
									rtMap.put("PERM_DT", getTextByTagName("PERM_DT"));
									rtMap.put("PERM_PTM", getTextByTagName("PERM_PTM"));
									rtMap.put("CARD_NO", getTextByTagName("CARD_NO"));
									rtMap.put("VAT_USE_PT", getTextByTagName("VAT_USE_PT"));	
									rtMap.put("VAT_EXT_USE_PT", getTextByTagName("VAT_EXT_USE_PT"));	
									rtMap.put("USE_PT", getTextByTagName("USE_PT"));	
									rtMap.put("FML_PT_MG_NO", hMap.get("fml_pt_mg_no"));
									rtMap.put("SEND_STR", strSend); //AKmem_send_buff
									rtMap.put("RECV_BUFF", strResult); //AKmem_recv_buff
									rtMap.put("CUS_RG_YN", "1");
									
								}else{
									rtMap.put("DE_DT", nowDate);
									rtMap.put("DE_PTM", nowTime);
									rtMap.put("HD_TY", "O");
									rtMap.put("RSP_CD", "22");
									rtMap.put("CUS_RG_YN", "1");
									//rtMap.put("rsp_cd", getTextByTagName("RSP_CD"));
									rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));
								}	
							}else{
								Print("1210:  승인응답이 없습니다.");
								rtMap.put("CUS_RG_YN", "1");
								rtMap.put("DE_DT", nowDate);
								rtMap.put("DE_PTM", nowTime);
								rtMap.put("HD_TY", "O");
								rtMap.put("RSP_CD", "22");
								rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");				
							}
						}
					}else{
						rtMap.put("DE_DT", nowDate);
						rtMap.put("DE_PTM", nowTime);
						rtMap.put("HD_TY", "O");
						rtMap.put("RSP_CD", "22");
						rtMap.put("CUS_RG_YN", "0");
						rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));
					}
					Print("XXX sendGram1210 끝  XXX ::: 현재시간="+System.currentTimeMillis()+", 총 처리시간="+new Long(System.currentTimeMillis()-lngStart));
				}else{
					Print("2000:  승인응답이 없습니다.");
					rtMap.put("rsp_cd", "22");
					rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");
				}
			}catch(Exception ioE){
				Print(ioE.toString());
				rtMap.put("DE_DT", nowDate);
				rtMap.put("DE_PTM", nowTime);
				rtMap.put("HD_TY", "O");
				rtMap.put("RSP_CD", "22");
				rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");
				//throw new ApplicationException(ioE);
			}
			return rtMap;
		}
	 public void Print(String msg) 
	    {
	        //String LogFile = "C:/GramUtil_" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	    	//개발  
	    	//String LogFile = "/was/ak_app_song/logs/GramUtil_" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	    	//운영
	    	String LogFile = "/was/jeus/logs/tmpPortal/GramUtil_" + new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	    	
	    	String LogDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
	        BufferedWriter fw = null;	
	        try {
	        	
	        	fw =new BufferedWriter(new FileWriter(LogFile, true));
	            fw.write(LogDate + "(" + new Long(System.currentTimeMillis()).toString() +")" + " [" + msg + "]");
	            fw.newLine();
	            fw.flush();
	        } catch (FileNotFoundException e) {
	            //System.out.println(LogDate + "파일을 찾지못함 " + LogFile);
	        } catch (IOException e) {
	            //System.out.println(LogDate + "파일쓰기에서 IO에러 발생 " + LogFile);
	        } finally {
	            if(fw!=null) try{ fw.close(); } catch (IOException e){}
	        }
		}
	 private String getGram1210(StringBuffer sbG, HashMap<String, String> hMap) {	
			sbG.append("    <RequestType>");
			sbG.append("		<WCC>3</WCC> ");
			sbG.append("		<PERM_RQ_DIV>1</PERM_RQ_DIV> ");
			sbG.append("		<CARD_NO>").append(hMap.get("card_no")).append("</CARD_NO> ");
			sbG.append("		<CUS_NO>").append(hMap.get("cus_no")).append("</CUS_NO> ");
			sbG.append("		<FML_PT_MG_NO>").append(hMap.get("fml_pt_mg_no")).append("</FML_PT_MG_NO>");
			sbG.append("		<PSWD/>");
			sbG.append("		<FRAN_CD>").append(hMap.get("fran_cd")).append("</FRAN_CD>");
			sbG.append("		<TEAM_CD/>");
			sbG.append("		<PTCP_PERM_NO>").append(hMap.get("ptcp_perm_no")).append("</PTCP_PERM_NO>");
			sbG.append("		<DE_DT>").append(nowDate).append("</DE_DT>");
			sbG.append("		<DE_PTM>").append(nowTime).append("</DE_PTM>");
			sbG.append("		<DE_DIV>20</DE_DIV>");
			sbG.append("		<DE_RSON>").append(hMap.get("de_rson")).append("</DE_RSON>");
			sbG.append("		<RS_USE_DIV_CD>").append(hMap.get("rs_use_div_cd")).append("</RS_USE_DIV_CD>");
			sbG.append("		<USE_PT>").append(hMap.get("use_pt")).append("</USE_PT>");
			sbG.append("		<SL_NM>").append(hMap.get("sl_nm")).append("</SL_NM>");
			sbG.append("		<FSDE_PT_OC_YN>0</FSDE_PT_OC_YN>");
			sbG.append("		<FSDE_PT/>");
			sbG.append("		<BIRTH_PT_OC_YN>0</BIRTH_PT_OC_YN>");
			sbG.append("		<BIRTH_PT/>");
			sbG.append("		<WEDD_DT_PT_OC_YN>0</WEDD_DT_PT_OC_YN>");
			sbG.append("		<WEDD_DT_PT/>");
			sbG.append("		<ADDM_RS_PT_OC_YN1>0</ADDM_RS_PT_OC_YN1>");
			sbG.append("		<ADDM_RS_PT1/>");
			sbG.append("		<ADDM_RS_PT_OC_YN2>0</ADDM_RS_PT_OC_YN2>");
			sbG.append("		<ADDM_RS_PT2/>");
			sbG.append("		<MBR_INFO_RQ>1</MBR_INFO_RQ>");
			sbG.append("		<ORGL_INFO_YN>").append(hMap.get("orgl_info_yn")).append("</ORGL_INFO_YN>");
			sbG.append("		<ORGL_INFO_DIV>").append(hMap.get("orgl_info_div")).append("</ORGL_INFO_DIV>");
			sbG.append("		<ORGL_PERM_NO>").append(hMap.get("orgl_perm_no")).append("</ORGL_PERM_NO>");
			sbG.append("		<ORGL_DE_DT>").append(hMap.get("orgl_de_dt")).append("</ORGL_DE_DT>");
			sbG.append("		<FILLER/>");
			sbG.append("	</RequestType>");
			sbG.append("</AAU>");
			sbG.append("</soap:Body>");
			sbG.append("</soap:Envelope>");			
			return sbG.toString();
		}
	 private HashMap sendGram1310(HashMap<String, String> hMap, String pos_no){

			long lngStart = System.currentTimeMillis();
			Print("XXX sendGram1310 시작 XXX::: 현재시간="+lngStart);		
			HashMap<String, String> rtMap = new HashMap<String, String>();
			String strSend = "";
			String strResult = "";
			try{			
				//회원인증전문날리기
				strSend = getGram2000(setControl("2000",(String)hMap.get("inst_cd")), hMap, pos_no);
				long lng2000 = System.currentTimeMillis();
				Print("XXX 인증전문 Send 전 XXX ::: 현재시간="+lng2000);
				strResult = doSendSoap4AU(strSend);
				Print("XXX 인증전문 Send 끝  XXX ::: 현재시간="+System.currentTimeMillis()+", 인증전문통과시간="+new Long(System.currentTimeMillis() - lng2000));
				Print("인증전문 리턴 Result="+strResult);
				if(!"".equals(strResult)&& strResult!=null){
					parse(strResult);

					//회원인증에 성공한 경우
					if ("00".equals(getTextByTagName("RSP_CD"))){
						//고객번호, 가족포인트관리번호, 고객등록여부를 설정한다.
						hMap.put("cus_no",getTextByTagName("CUS_NO"));
						hMap.put("fml_pt_mg_no",getTextByTagName("FML_PT_MG_NO"));
						hMap.put("cus_rg_yn",getTextByTagName("CUS_RG_YN"));
						
						//고객등록여부가 1이고 고객번호가 9자리인 경우(수정해야함!!)
						if (hMap.get("cus_rg_yn").equals("1")) {
		
							//정산전문날리기					
							strSend = getGram1310(setControl("1310",(String)hMap.get("inst_cd")), hMap);
							long lng1310 = System.currentTimeMillis();
							Print("XXX 조정전문  Send 전 XXX ::: 현재시간="+lng1310);
							strResult = doSendSoap4AU(strSend);
							
							Print("XXX 조정전문  Send 후 XXX ::: 현재시간="+System.currentTimeMillis()+", 조정전문통과시간="+new Long(System.currentTimeMillis() - lng1310));
							Print("조정전문 리턴 Result="+strResult);
							
							if(!"".equals(strResult)&& strResult!=null){
								parse(strResult);
								rtMap.put("DE_DT", getTextByTagName("DE_DT"));
								rtMap.put("DE_PTM", getTextByTagName("DE_PTM"));
								rtMap.put("PTCP_PERM_NO", getTextByTagName("PTCP_PERM_NO"));
								rtMap.put("PERM_DT", getTextByTagName("PERM_DT"));
								rtMap.put("PERM_PTM", getTextByTagName("PERM_PTM"));
								rtMap.put("PERM_NO", getTextByTagName("PERM_NO"));
								rtMap.put("CARD_NO", getTextByTagName("CARD_NO"));	
								rtMap.put("FML_PT_MG_NO", hMap.get("fml_pt_mg_no"));
								rtMap.put("CUS_RG_YN", "1");
								rtMap.put("RSP_CD", "00");
							}else{
								Print("1210:  승인응답이 없습니다.");
								rtMap.put("DE_DT", nowDate);
								rtMap.put("DE_PTM", nowTime);
								rtMap.put("HD_TY", "O");
								rtMap.put("RSP_CD", "22");
								rtMap.put("CUS_RG_YN", "1");
								rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");
								return rtMap;
							}
						}
					}
				} else {
					Print("2000:  승인응답이 없습니다.");
					rtMap.put("DE_DT", nowDate);
					rtMap.put("DE_PTM", nowTime);
					rtMap.put("HD_TY", "O");
					rtMap.put("RSP_CD", "22");
					rtMap.put("CUS_RG_YN", "0");
					rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");
					return rtMap;
				}
			//	rtMap.put("HD_TY", xmlUtil.getTextByTagName("HD_TY"));
				rtMap.put("GRAM_NO", getTextByTagName("GRAM_NO"));
			//	rtMap.put("RSP_CD", xmlUtil.getTextByTagName("RSP_CD"));
				rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));
				Print("XXX sendGram1310 끝   XXX ::: 현재시간="+System.currentTimeMillis()+", 총 처리시간="+new Long(System.currentTimeMillis()-lngStart));


			}catch(Exception ioE){
				Print(ioE.toString());
				rtMap.put("HD_TY", "O");
				rtMap.put("DE_DT", nowDate);
				rtMap.put("DE_PTM", nowTime);
				rtMap.put("RSP_CD","22");
				rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");
				//throw new ApplicationException(ioE);
			}
			return rtMap;
		}
	 private String getGram1310(StringBuffer sbG, HashMap<String, String> map) {
			sbG.append("	<RequestType>");
			sbG.append("		<WCC>1</WCC>");
			sbG.append("		<PERM_RQ_DIV>2</PERM_RQ_DIV>");
			sbG.append("		<CARD_NO>").append(map.get("card_no")).append("</CARD_NO>");
			sbG.append("		<CUS_NO>").append(map.get("cus_no")).append("</CUS_NO>");
			sbG.append("		<FML_PT_MG_NO>").append(map.get("fml_pt_mg_no")).append("</FML_PT_MG_NO>");
			sbG.append("		<CUS_RG_YN>").append(map.get("cus_rg_yn")).append("</CUS_RG_YN>");
			sbG.append("		<DE_DIV_CD>").append(map.get("de_div_cd")).append("</DE_DIV_CD>");
			sbG.append("		<DE_RSON>").append(map.get("de_rson")).append("</DE_RSON>");
			sbG.append("		<FRAN_CD>").append(map.get("fran_cd")).append("</FRAN_CD>");
			sbG.append("		<TEAM_CD/>");
			sbG.append("		<PTCP_PERM_NO>").append(map.get("ptcp_perm_no")).append("</PTCP_PERM_NO>");
			sbG.append("		<DE_DT>").append(nowDate).append("</DE_DT>");
			sbG.append("		<DE_PTM>").append(nowTime).append("</DE_PTM>");
			sbG.append("		<MEDI_DIV>").append(map.get("medi_div")).append("</MEDI_DIV>");
			sbG.append("		<MEDI_PT_>").append(StringUtil.strFillLeft(map.get("medi_pt"), 9, '0')).append("</MEDI_PT_>");
			sbG.append("		<MEDI_RSON_CD>").append(map.get("medi_rson_cd")).append("</MEDI_RSON_CD>");
			sbG.append("		<MEDI_RSON>").append(map.get("medi_rson")).append("</MEDI_RSON>");
			sbG.append("		<RGR_ID>").append(map.get("rgr_id")).append("</RGR_ID>");
			sbG.append("		<MBR_INFO_RQ>0</MBR_INFO_RQ>");
			sbG.append("		<FILLER/>");
			sbG.append("	</RequestType>");
			sbG.append("</AAU>");
			sbG.append("</soap:Body>");
			sbG.append("</soap:Envelope>");	
			return sbG.toString();
		}
	 private HashMap sendGram1010(HashMap<String, String> hMap){

			long lngStart = System.currentTimeMillis();		
			HashMap rtMap = new HashMap();
			String strSend = "";
			String strResult = "";
			try{			
				//회원인증전문날리기
				strSend = getGram1010(setControl("1010",(String)hMap.get("inst_cd")), hMap);
				//strSend = getGram2000(setControl("2000",(String)hMap.get("inst_cd")), hMap);
				//strSend = getGram2000(setControl("2000","1014"), hMap);
				long lng1010 = System.currentTimeMillis();
				Print("XXX 조회전문 Send 전 XXX ::: 현재시간="+lng1010);
				strResult = doSendSoap4AU(strSend);
				Print("XXX 조회전문 Send 끝  XXX ::: 현재시간="+System.currentTimeMillis()+", 인증전문통과시간="+new Long(System.currentTimeMillis() - lng1010));
				Print("인증전문 리턴 Result="+strResult);
				
				if(!"".equals(strResult)&& strResult!=null){
					parse(strResult);
					if("00".equals(getTextByTagName("RSP_CD"))){
						rtMap.put("rsp_cd",getTextByTagName("RSP_CD"));
						rtMap.put("perm_no", getTextByTagName("PERM_NO"));
						rtMap.put("se_bgng_no", getTextByTagName("SE_BGNG_NO"));
						rtMap.put("se_rq_pg_no", getTextByTagName("SE_RQ_PG_NO"));
						rtMap.put("se_bgng_key", getTextByTagName("SE_BGNG_KEY"));
						rtMap.put("se_ed_key", getTextByTagName("SE_ED_KEY"));
						rtMap.put("array", getArrayListByTagName("ARRAY01"));
						
						
					}else{
						rtMap.put("RSP_CD", getTextByTagName("RSP_CD"));
						rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));
					}	
				}else{
					Print("1010:  승인응답이 없습니다.");
					rtMap.put("RSP_CD", "22");
					rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");							
				}
				
			}catch(Exception e){
				Print("[조회전문 에러]" + e.getMessage());
				
				e.printStackTrace();
				
			}
			
			return rtMap;
		}
	 public List getArrayListByTagName(String NodeName){
	    	
	    	List list = new LinkedList();
	    	if("".equals(NodeName)){
				
			}else{
				NodeList nodeList = doc.getElementsByTagName(NodeName);
				
				for ( int i = 0; i < nodeList.getLength(); i++) {
					HashMap hMap = new HashMap();
					Node node = nodeList.item(i);
					NodeList childList = node.getChildNodes();
					
					for ( int j = 0; j < childList.getLength(); j++){
						Node cNode = childList.item(j);
						hMap.put(cNode.getNodeName(), cNode.getTextContent());
					}
					
					list.add(hMap);
				}
				
			}
	    	
	    	return list;
	    }
	 private String getGram1010(StringBuffer sbG, HashMap hMap) {
			
			sbG.append("	<RequestType>");
			sbG.append("		<WCC>1</WCC>");
			sbG.append("		<PERM_RQ_DIV>2</PERM_RQ_DIV>");
			sbG.append("		<CARD_NO>").append((String)hMap.get("card_no")).append("</CARD_NO>");
			sbG.append("		<PSWD/>");
			sbG.append("		<FRAN_CD>").append((String)hMap.get("fran_cd")).append("</FRAN_CD>");
			sbG.append("		<DE_BGNG_DT>").append((String)hMap.get("de_bgng_dt")).append("</DE_BGNG_DT>");
			sbG.append("		<DE_ED_DT>").append((String)hMap.get("de_ed_dt")).append("</DE_ED_DT>");
			sbG.append("		<SE_FRAN_CD>").append((String)hMap.get("se_fran_cd")).append("</SE_FRAN_CD>");
			sbG.append("		<BU_DIV>").append((String)hMap.get("bu_div")).append("</BU_DIV>");
			sbG.append("		<SE_BGNG_NO>").append((String)hMap.get("se_bgng_no")).append("</SE_BGNG_NO>");
			sbG.append("		<SE_PG_CNT>").append((String)hMap.get("se_pg_cnt")).append("</SE_PG_CNT>");
			sbG.append("		<SE_PG_ROW_CNT>").append((String)hMap.get("se_pg_row_cnt")).append("</SE_PG_ROW_CNT>");
			sbG.append("		<SE_RQ_PG_NO>").append((String)hMap.get("se_rq_pg_no")).append("</SE_RQ_PG_NO>");
			sbG.append("		<SE_BGNG_KEY>").append((String)hMap.get("se_bgng_key")).append("</SE_BGNG_KEY>");
			sbG.append("		<SE_ED_KEY>").append((String)hMap.get("se_ed_key")).append("</SE_ED_KEY>");
			sbG.append("		<FILLER/>");
			sbG.append("	</RequestType>");
			sbG.append("</AAU>");
			sbG.append("</soap:Body>");
			sbG.append("</soap:Envelope>");	
		
			return sbG.toString();
		}
	 private HashMap sendGram1110(HashMap<String, String> hMap, String pos_no){

			long lngStart = System.currentTimeMillis();
			Print("XXX sendGram1110 시작 XXX ::: 현재시간="+lngStart);		
			HashMap<String, String> rtMap = new HashMap<String, String>();
			String strSend = "";
			String strResult = "";
			try{			
				//회원인증전문날리기
				strSend = getGram2000(setControl("2000",(String)hMap.get("inst_cd")), hMap, pos_no);
				long lng2000 = System.currentTimeMillis();
				Print("XXX 인증전문 Send 전 XXX ::: 현재시간="+lng2000);
				strResult = doSendSoap4AU(strSend);
				Print("XXX 인증전문 Send 끝  XXX ::: 현재시간="+System.currentTimeMillis()+", 인증전문통과시간="+new Long(System.currentTimeMillis() - lng2000));
				Print("인증전문 리턴 Result="+strResult);
				if(!"".equals(strResult)&& strResult!=null){
					parse(strResult); 	
					if("00".equals(getTextByTagName("RSP_CD"))){
						rtMap.put("rsp_cd",getTextByTagName("RSP_CD"));
						hMap.put("cus_no",getTextByTagName("CUS_NO"));
						hMap.put("fml_pt_mg_no",getTextByTagName("FML_PT_MG_NO"));
						hMap.put("cus_rg_yn",getTextByTagName("CUS_RG_YN"));
						
						//	고객등록여부가 1이고 고객번호가 9자리인 경우(수정해야함!!)
						if (hMap.get("cus_rg_yn").equals("1")) {
							//사용전문날리기
							strSend = getGram1110(setControl(hMap.get("gram_no"),hMap.get("inst_cd")), hMap);	
							long lng1210 = System.currentTimeMillis();
							Print("XXX 사용전문  Send 전 XXX ::: 현재시간="+lng1210);
							strResult = doSendSoap4AU(strSend);
							Print("XXX 사용전문  Send 후 XXX ::: 현재시간="+System.currentTimeMillis()+", 사용전문통과시간="+new Long(System.currentTimeMillis() - lng1210));
							Print("사용전문 리턴 Result="+strResult);
							if(!"".equals(strResult)&& strResult!=null){
								parse(strResult);
								
								if("00".equals(getTextByTagName("RSP_CD"))){
									rtMap.put("DE_DT", getTextByTagName("DE_DT"));
									rtMap.put("DE_PTM", getTextByTagName("DE_PTM"));
									rtMap.put("PTCP_PERM_NO", getTextByTagName("PTCP_PERM_NO"));
									rtMap.put("PERM_DT", getTextByTagName("PERM_DT"));
									rtMap.put("PERM_PTM", getTextByTagName("PERM_PTM"));
									rtMap.put("PERM_NO", getTextByTagName("PERM_NO"));
									rtMap.put("CARD_NO", getTextByTagName("CARD_NO"));
									rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));	
									rtMap.put("FML_PT_MG_NO", hMap.get("fml_pt_mg_no"));
									rtMap.put("CUMU_PT", getTextByTagName("CUMU_PT"));
									rtMap.put("CUS_NO", getTextByTagName("CUS_NO"));
									rtMap.put("CUS_RG_YN", "1");
									rtMap.put("TOT_CREA_PT", getTextByTagName("TOT_CREA_PT")); //AKmem_Create_Point
									rtMap.put("EUSE_PT", getTextByTagName("EUSE_PT")); //AKmem_Create_Point
									rtMap.put("VAT_USE_PT", "0");	
									rtMap.put("VAT_EXT_USE_PT", "0");	
									rtMap.put("USE_PT", "0");	
									rtMap.put("FML_PT_MG_NO", hMap.get("fml_pt_mg_no"));
									rtMap.put("SEND_STR", strSend); //AKmem_send_buff
									rtMap.put("RECV_BUFF", strResult); //AKmem_recv_buff
									rtMap.put("RSP_CD", "00");
									
								}else{
									rtMap.put("DE_DT", nowDate);
									rtMap.put("DE_PTM", nowTime);
									rtMap.put("HD_TY", "O");
									rtMap.put("RSP_CD", "22");
									rtMap.put("CUS_RG_YN", "1");
									//rtMap.put("rsp_cd", getTextByTagName("RSP_CD"));
									rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));
								}	
							}else{
								Print("1110:  승인응답이 없습니다.");
								rtMap.put("CUS_RG_YN", "1");
								rtMap.put("DE_DT", nowDate);
								rtMap.put("DE_PTM", nowTime);
								rtMap.put("HD_TY", "O");
								rtMap.put("RSP_CD", "22");
								rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");							
							}
						}
					}else{
						rtMap.put("DE_DT", nowDate);
						rtMap.put("DE_PTM", nowTime);
						rtMap.put("HD_TY", "O");
						rtMap.put("RSP_CD", "22");
						rtMap.put("CUS_RG_YN", "0");
						rtMap.put("MSG_TRMNL", getTextByTagName("MSG_TRMNL"));
					}
					Print("XXX sendGram1110 끝  XXX ::: 현재시간="+System.currentTimeMillis()+", 총 처리시간="+new Long(System.currentTimeMillis()-lngStart));
				}else{
					Print("2000:  승인응답이 없습니다.");
					rtMap.put("rsp_cd", "22");
					rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");
				}
			}catch(Exception ioE){
				Print(ioE.toString());
				rtMap.put("DE_DT", nowDate);
				rtMap.put("DE_PTM", nowTime);
				rtMap.put("HD_TY", "O");
				rtMap.put("RSP_CD", "22");
				rtMap.put("MSG_TRMNL","승인서버와의 통신에 장애가 있습니다");
				//throw new ApplicationException(ioE);
			}
			return rtMap;
		}
	 private String getGram1110(StringBuffer sbG, HashMap<String, String> hMap) {	
			sbG.append("    <RequestType>");
			sbG.append("		<WCC>3</WCC> ");
			sbG.append("		<PERM_RQ_DIV>1</PERM_RQ_DIV> ");
			sbG.append("		<CARD_NO>").append(hMap.get("card_no")).append("</CARD_NO>");
			sbG.append("		<CUS_NO>").append(hMap.get("cus_no")).append("</CUS_NO>");
			sbG.append("		<FML_PT_MG_NO>").append(hMap.get("fml_pt_mg_no")).append("</FML_PT_MG_NO>");
			sbG.append("		<CUS_RG_YN>").append(hMap.get("cus_rg_yn")).append("</CUS_RG_YN>");
			sbG.append("		<STT_CDNO>").append(hMap.get("sCard_no")).append("</STT_CDNO>");
			sbG.append("		<PSWD/>");
			sbG.append("		<FRAN_CD>").append(hMap.get("fran_cd")).append("</FRAN_CD>");
			sbG.append("		<TEAM_CD/>");
			sbG.append("		<PTCP_PERM_NO>").append(hMap.get("ptcp_perm_no")).append("</PTCP_PERM_NO>");
			sbG.append("		<DE_DT>").append(nowDate).append("</DE_DT>");
			sbG.append("		<DE_PTM>").append(nowTime).append("</DE_PTM>");
			sbG.append("		<DFN_DT>").append(hMap.get("dfn_dt")).append("</DFN_DT>");
			sbG.append("		<DE_DIV>10</DE_DIV>");
			sbG.append("		<DE_RSON>").append(hMap.get("de_rson")).append("</DE_RSON>");
			sbG.append("		<RS_USE_DIV_CD>").append(hMap.get("rs_use_div_cd")).append("</RS_USE_DIV_CD>");
			sbG.append("		<TOT_SALES_AMT>").append(hMap.get("tot_sales_amt")).append("</TOT_SALES_AMT>");
			sbG.append("		<SL_NM>").append(hMap.get("sl_nm")).append("</SL_NM>");
			sbG.append("		<DC_AMT>000000000000</DC_AMT> ");
			sbG.append("		<ITEM_QTY>000</ITEM_QTY> ");
			sbG.append("		<TOT_CREA_PT>").append(hMap.get("tot_crea_pt")).append("</TOT_CREA_PT> ");
			sbG.append("		<CASH_STT_AMT>000000000000</CASH_STT_AMT> ");
			sbG.append("		<CREA_PT_CASH>0000000000</CREA_PT_CASH> ");
			sbG.append("		<CD_STT_AMT>000000000000</CD_STT_AMT> ");
			sbG.append("		<CREA_PT_CD>0000000000</CREA_PT_CD> ");
			sbG.append("		<WRKCP_PDB_STT_AMT>000000000000</WRKCP_PDB_STT_AMT> ");
			sbG.append("		<CREA_PT_WRKCP_PDB>0000000000</CREA_PT_WRKCP_PDB> ");
			sbG.append("		<OCMP_PDB_STT_AMT>000000000000</OCMP_PDB_STT_AMT> ");
			sbG.append("		<CREA_PT_OCMP_PDB>0000000000</CREA_PT_OCMP_PDB> ");
			sbG.append("		<PT_STT_AMT>000000000000</PT_STT_AMT> ");
			sbG.append("		<CREA_PT_PT>0000000000</CREA_PT_PT> ");
			sbG.append("		<ETC_STT_AMT>000000000000</ETC_STT_AMT> ");
			sbG.append("		<CREA_PT_ETC>0000000000</CREA_PT_ETC> ");
			sbG.append("		<FSDE_PT_OC_YN>0</FSDE_PT_OC_YN> ");
			sbG.append("		<FSDE_PT>0000000000</FSDE_PT> ");
			sbG.append("		<BIRTH_PT_OC_YN>0</BIRTH_PT_OC_YN> ");
			sbG.append("		<BIRTH_PT>0000000000</BIRTH_PT> ");
			sbG.append("		<WEDD_DT_PT_OC_YN>0</WEDD_DT_PT_OC_YN> ");
			sbG.append("		<WEDD_DT_PT>0000000000</WEDD_DT_PT> ");
			sbG.append("		<ADDM_RS_PT_OC_YN1>0</ADDM_RS_PT_OC_YN1> ");
			sbG.append("		<ADDM_RS_PT1>0000000000</ADDM_RS_PT1> ");
			sbG.append("		<ADDM_RS_PT_OC_YN2>0</ADDM_RS_PT_OC_YN2> ");
			sbG.append("		<ADDM_RS_PT2>0000000000</ADDM_RS_PT2> ");
			sbG.append("		<MBR_INFO_RQ>").append(hMap.get("mbr_info_rq")).append("</MBR_INFO_RQ> ");
			sbG.append("		<FILLER></FILLER> ");
			sbG.append("		<ORGL_INFO_YN>").append(hMap.get("orgl_info_yn")).append("</ORGL_INFO_YN> ");
			sbG.append("		<ORGL_INFO_DIV>").append(hMap.get("orgl_info_div")).append("</ORGL_INFO_DIV> ");
			sbG.append("		<ORGL_PERM_NO>").append(hMap.get("orgl_perm_no")).append("</ORGL_PERM_NO> ");
			sbG.append("		<ORGL_DE_DT>").append(hMap.get("orgl_de_dt")).append("</ORGL_DE_DT> ");
			sbG.append("		<EV_CNT>0</EV_CNT> ");
			sbG.append("		<EV_CD1></EV_CD1> ");
			sbG.append("		<EV_NM1></EV_NM1> ");
			sbG.append("		<SALES_AMT1>000000000000</SALES_AMT1> ");
			sbG.append("		<EV_PT1>0000000000</EV_PT1> ");
			sbG.append("		<EV_CD2></EV_CD2> ");
			sbG.append("		<EV_NM2></EV_NM2> ");
			sbG.append("		<SALES_AMT2>000000000000</SALES_AMT2> ");
			sbG.append("		<EV_PT2>0000000000</EV_PT2> ");
			sbG.append("		<FILLER/>");
			sbG.append("	</RequestType>");
			sbG.append("</AAU>");
			sbG.append("</soap:Body>");
			sbG.append("</soap:Envelope>");			
			return sbG.toString();
		}
	 public int getCalcAkmemPoint(int SHINHANCount, int KBCount, int WBCount, double totAmt, LectDAO lectDAO)
	    {
	      /*  온라인은 카드결재만 있기때문에
         822 신한제휴 042국민제휴카드 = 50% 인정
         타사 카드  = 10% 인정 */
     double point = 0;
     double percent = 0;
     if (SHINHANCount == 1){
      	percent = akmempercent("20", lectDAO); //AK신한제휴카드
          point =totAmt * percent;  //50%인정
          System.out.println("\n AK신한제휴카드 인정 % -->"+percent);
          System.out.println("\n AK신한제휴카드 인정    -->"+point);
        }else if (KBCount == 1){
        	percent = akmempercent("23", lectDAO); //AKKB국민제휴카드
            point =totAmt * percent;  //50%인정
            System.out.println("\n AKKB국민제휴카드 인정 % -->"+percent);
            System.out.println("\n AKKB국민제휴카드 인정    -->"+point);    	  
        }else if(WBCount == 1){
            percent = akmempercent("24", lectDAO); //AKKB우리제휴카드
            point =totAmt * percent;  //50%인정
            System.out.println("\n AKWB우리제휴카드 인정 % -->"+percent);
            System.out.println("\n AKWB우리제휴카드 인정    -->"+point);        
        }else {
      	percent = akmempercent("22", lectDAO); //연계타사카드
          point = totAmt * percent;  //10%인정
          System.out.println("\n 타사카드 인정 % -->"+percent);
          System.out.println("\n 타사카드 인정    -->"+point);     
        }
     point = Math.ceil(point * 0.01);   //해당 인정 금액의 1% 가 적립액 (올림)
     System.out.println("\n적립 요청 마일리지 -->"+point);
     return (int)point;
   }
	 public double akmempercent(String subcode, LectDAO lectDAO)
		{
	        double akmemper = 0;
			try {
				akmemper = Double.parseDouble(lectDAO.akMemberPercent(subcode));
			} catch (Exception e) {
				e.printStackTrace();
			}
			return akmemper;     
		}
	    
}
