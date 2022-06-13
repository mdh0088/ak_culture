package ak_culture.classes;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.SocketException;
import java.net.SocketTimeoutException;
import java.net.UnknownHostException;

import org.apache.log4j.Logger;

public class BABatchRun {
	boolean DEBUG              = true;
	private final Logger log = Logger.getLogger(this.getClass());
	private Socket socket       = null;
    private String host = "";
    private int port = 0;
    private PrintWriter    toServer ;
    private InputStream inB;
    private String approve_no  = null;
    private String return_msg  = null;
    private String vensa_fg    = null;
    private String balance  = null;
    private String identiNo  = null;
    private String  batch_Info  = ""; 
    
    public void setHost(String host, int port) {
        if (host != null) {
            this.host = host;
        }
        
        if (port > 0) {
            this.port = port;
        }
    } 
    
    public String ReqAuthDanmal_run(String msgType, String ReqAuthDanmal_inform) {
        if (DEBUG) {
            System.out.println("BA.ReqAuthDanmal_run() called...");
        }
//        String line = null;
//        String TranHeader = null;
        String recv_buff = null;
        byte[] buffer        = null;
        
        try {
            
            //TFTLogWriter.Log("GN", "TEST01");                    
            toServer.println(ReqAuthDanmal_inform);
            toServer.flush();
            
            if("XB283S".equals(msgType)){
                buffer = getSocketDataWithException(inB, 4096);
            }
            else if("XB413S".equals(msgType)){  // BC  ipk-������Ʈ
                buffer = getSocketDataWithException(inB, 4096);
            }
            else if("XB423S".equals(msgType)){  // ����  ipk-������Ʈ
                buffer = getSocketDataWithException(inB, 4096);
            }else{
                buffer = getSocketDataWithException(inB, 2048);
            }
            recv_buff = new String(buffer);
           // TranHeader    = line.substring(0, 6);
            //recv_buff     = line.substring(42, line.length());  //���� �ʿ��� data
            
            return recv_buff;
            
        } catch (SocketException e) {
            if (DEBUG) {
                System.out.println("BA.ReqAuthDanmal_run():�ý������(SocketException)");
            }
            return "Fail0000:�ý������(SocketException)";
        } catch (IOException e) {
            if (DEBUG) {
                System.out.println("BA.ReqAuthDanmal_run():�ý������(IOException)");
            }
            return "Fail0000:�ý������(IOException)";
        } catch (NullPointerException e) {
            if (DEBUG) {
                System.out.println("BA.ReqAuthDanmal_run():�ý������(NullPointerException)");
            }
            return "Fail0000:�ý������(NullPointerException)";
        } catch (Exception e) {
            if (DEBUG) {
                System.out.println("BA.ReqAuthDanmal_run():�ý������(Exception)");
            }
            return "Fail0000:�ý������(Exception)";
        }
    }
	
	public static byte[] getSocketDataWithException(InputStream dis, int nTargetLen) throws SocketTimeoutException, Exception{
		
		
        int offset = 0;
        int len=0;
        byte[] buffer = new byte[ nTargetLen];

        // nTargetLen 만큼 읽기
        int wanted = nTargetLen;
        while( wanted > 0 )
        {
            try{
                len = dis.read( buffer, offset, wanted );
                if( len == -1 ) {
                    throw new Exception("read error");
                }
            }catch(SocketTimeoutException stoe){
                throw  stoe;
            }catch(Exception e){
                throw  e;
            }
            wanted -= len;
            offset += len;
        }

        return buffer;
    }
	public String start() {
	      
        try  {
            socket = new Socket(host, port);
            socket.setSoTimeout(15000);

            if (socket != null) {
//                inB  = new BufferedReader(new InputStreamReader(socket.getInputStream()));//소켓의 입력 스트림을 돌려줍니다
                inB = socket.getInputStream();
                toServer = new PrintWriter(new OutputStreamWriter(socket.getOutputStream(), "EUC-KR")); //소켓의 출력 스트림을 돌려줍니다. 
                return "OK";
            } else {
                System.out.println("Fail0000:시스템장애(Exception:In/Out Socket Streams...)");
                return "Fail0000:시스템장애(Exception:In/Out Socket Streams...)";            
            }
            
        } catch ( UnknownHostException e ) {
            System.out.println("Fail0000:시스템장애(UnknownHostException):"+host);
            return "Fail0000:시스템장애(UnknownHostException):" + host;
        } catch ( IOException e ) {
            System.out.println("Fail0000:시스템장애(IOException):" + host+":"+port);
            return "Fail0000:시스템장애(IOException):" + host+":"+port;
        }    
    }
public String run() {
        
        String line = "";
        byte[] buffer        = null;
        try {            
            //서버에 정보를 보냄
        	System.out.println("batch_Info : "+batch_Info);
            toServer.println(batch_Info); //String를 출력해, 행을 종료합니다. 
            toServer.flush();            
            
            buffer = getSocketDataWithException(inB, 1);
            String enco = new String(buffer, "euc-kr");
            buffer = enco.getBytes();
            
            line = new String(buffer);
            log.info("RETURN_DATA : [" + line + "]");
        } catch (NullPointerException e) {
            System.out.println("BatchRun.run():시스템장애(NullPointerException)");
            return "Fail0000:시스템장애(NullPointerException)";
        } catch (Exception e) {
            System.out.println("BatchRun.run():시스템장애(Exception)");
            return "Fail0000:시스템장애(Exception)";
        }
        return line;
    }
	  public String run(String card_inform) {
	        if (DEBUG) {
	            System.out.println("BA.run() called...");
	        }
	        String line           = null;
	        String line_cp       = null;
	        String TranHeader = null;
	        byte[] buffer        = null;
//
	        try {
	            //서버에 카드정보를 보냄
	            toServer.println(card_inform);
	            toServer.flush();
	            //승인여부를 받아옴
	            
	            buffer = getSocketDataWithException(inB, 1024);
	            String enco = new String(buffer, "euc-kr");
	            buffer = enco.getBytes();
	            
	            line = new String(buffer);
	            log.info("RETURN_DATA : [" + line + "]");
	            
	            
	            // 원거래 정보가 틀릴 경우, 리턴메시지가 "CALLISSUER" 로 날아올 때 처리
	            if(line.indexOf("CALLISSUER") > -1) {
	                line = line.replaceFirst("CALLISSUER", "결제정보가 올바르지 않습니다.");
	            }

	            TranHeader      = line.substring(0, 6);     
	            approve_no      = line.substring(42, 50);    
	            vensa_fg          = line.substring(50, 52);
	            return_msg       = line.substring(52);
	            
	            line_cp = line;

	            // 구 전문과의 혼용으로 인해 바이트 수가 안맞을 경우 채워줌 (터미널코드, VAN코드가 통신서버로부터 오지 않음)
	            if(vensa_fg == null || vensa_fg.trim().equals("")) {
	                vensa_fg += "  ";
	            }

	            // 정상적인경우
	            if (TranHeader.equals("XA071R")){
	                return approve_no + vensa_fg + return_msg;
	                
	            } else if (TranHeader.equals("XB071R")|| // 여전법이후 카드승인
	                        TranHeader.equals("NFB71R")|| // 여전법이후 rf거래
	                        TranHeader.equals("XB072R")) {// 여전법이후 카드취소) 
	                String returncd = line.substring(6, 10); //여전법 이후 밴사도 응답코드로 처리
	                approve_no  = line.substring(42, 50);  //여전법시행 응답전문 변경
	                vensa_fg    = line.substring(68, 70);
	                return_msg  = getByteSubstr(buffer,70,110);
	                balance =  getByteSubstr(buffer,114, 123); // 타사선불카드 잔액
	                return returncd+approve_no + vensa_fg + return_msg+balance;                
	                
	            } else if (TranHeader.equals("XA075R")) {               // AK기프트(555),홈플러스(666) 정상/취소인경우 [분당점제외]
	                return approve_no + vensa_fg + return_msg;                
	            } else if (TranHeader.equals("XB075R")) {               // AK기프트(555),홈플러스(666) 정상/취소인경우 [분당점제외] 여전법이후 
	                approve_no  = line.substring(42, 50);    
	                vensa_fg    = line.substring(50, 52);
	                return_msg  = getByteSubstr(buffer,52,92);
	                balance     = getByteSubstr(buffer,92,101);
	                return approve_no + vensa_fg + return_msg+balance;
	            } else if (TranHeader.equals("XM090R")) {              // AK기프트(555),홈플러스(666) 정상/취소인경우[분당점] (12.01.27)
	                return approve_no + vensa_fg + return_msg;
	            } else if (TranHeader.equals("XA077R")) {               // 현금영수증 //2018.01.30 
	                return approve_no + vensa_fg + return_msg;
	            } else if (TranHeader.equals("XB077R")) {  // 현금영수증 //2018.01.30 여전법 시행XA077R=> XB077R 변경
	                approve_no  = line.substring(42, 51);  //여전법시행 응답전문 변경
	                vensa_fg    = line.substring(51, 53);
	                return_msg  = getByteSubstr(buffer,53,163);
	                identiNo  = getByteSubstr(buffer,163,175);//VAN 거래고유번호
	                return approve_no + vensa_fg + return_msg + identiNo;
	            } else if (TranHeader.equals("XA081R")) {               // 수표조회          
	                return approve_no + vensa_fg + return_msg;
	            } else if (TranHeader.equals("XA078R")) {               // 현금 영수증 취소
	                return approve_no + vensa_fg + return_msg;    
	            } else if (TranHeader.equals("XA271R") || TranHeader.equals("XA272R") || TranHeader.equals("XA273R")) {     // KB 직승인(승인,취소,망취소) - 2017.07.13 황인철
	                return line_cp;
	            } else if (TranHeader.equals("XB271R") || TranHeader.equals("XB272R") || TranHeader.equals("XB273R")) {     // KB 직승인(승인,취소,망취소) - 2017.07.13 황인철
	                return line_cp;         
	            }
	            else if (TranHeader.equals("XB414R") || TranHeader.equals("XB415R") || TranHeader.equals("XB416R")) {     // BC카드 직승인(승인,취소,망취소)
	                return line_cp;         
	            }
	            else if (TranHeader.equals("XB424R") || TranHeader.equals("XB425R") || TranHeader.equals("XB426R")) {     // 신한카드 직승인(승인,취소,망취소)
	                return line_cp;         
	            }
	            else if (TranHeader.equals("XB511R")|| TranHeader.equals("XB512R")) {    // BC카드 QR 코드 승인, 취소
	                String returncd = line.substring(6, 10); //여전법 이후 밴사도 응답코드로 처리
	                approve_no  = line.substring(42, 50);  //여전법시행 응답전문 변경
	                vensa_fg    = line.substring(68, 70);
	                return_msg  = getByteSubstr(buffer,70,110);
	                balance =  getByteSubstr(buffer,114, 123); // 타사선불카드 잔액
	                
	                return returncd + approve_no + vensa_fg + return_msg + balance;
	            }
	            else {
	                return approve_no + vensa_fg + return_msg; 
	            }
	        } catch (SocketException e) {
	            if (DEBUG)
	                System.out.println("BA.run():시스템장애(SocketException)");
	            return "Fail0000:시스템장애(SocketException)";
	        } catch (IOException e) {
	            if (DEBUG)
	                System.out.println("BA.run():시스템장애(IOException)");
	            return "Fail0000:시스템장애(IOException)";
	        } catch (NullPointerException e) {
	            if (DEBUG)
	                System.out.println("BA.run():시스템장애(NullPointerException)");
	            return "Fail0000:시스템장애(NullPointerException)";
	        } catch (Exception e) {
	            if (DEBUG)
	                System.out.println("BA.run():시스템장애(Exception)");
	            return "Fail0000:시스템장애(Exception)";
	        }
	    }
	  
	  private String getByteSubstr(byte[] btStr, int strNum, int endNum){
	        int len = endNum-strNum;
	        String reStr = null;
	        if(btStr.length == 0)return null;
	        if(btStr.length < len)return null;
	        
	        byte[] str = new byte[len] ;
	        for(int cs = strNum, i = 0 ; cs < endNum; cs++){
	           str[i] = btStr[cs];
	           i++;
	        }
	        reStr = new String(str);
	        len = len - reStr.length();
	        for(int sp = 0 ; sp < len ; sp++){
	            if(reStr.length() == len)break;      
	            reStr +=" ";
	        }
	        
	        return reStr;
	    }
	  public void stop() {

	        try {
	            if (inB != null) {
	                inB.close();
	                inB = null;
	            }
	            if (toServer != null) {
	                toServer.close();
	                toServer = null;
	            } 
	            if (socket != null) {
	                socket.close();
	                socket = null;
	            }
	            } catch (Exception e) {
	        } 
	    }
	  public String subString(String str, int startIndex, int length, String encoding){
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
	  
	  public String encCardNo_run(String card_inform) {
	        if (DEBUG) {
	            System.out.println("BA.encCardNo_run() called...");
	        }
	        String line = null;
	        String recv_buff = null;
	        byte[] buffer        = null;
	        
	        try {
	            //서버에 카드정보를 보냄
	            
	            //TFTLogWriter.Log("GN", "TEST01");
//	        	toServer.println(new String(card_inform.getBytes("UTF-8"), "EUC-KR"));
	            toServer.println(card_inform);
	            toServer.flush();
	            
	            //승인여부를 받아옴
	            
	            buffer = getSocketDataWithException(inB, 1024);
	            line = new String(buffer, "EUC-KR");
	            recv_buff       = line.substring(42, line.length());  //실제 필요한 data
	            return recv_buff;
	            
	        } catch (SocketException e) {
	            if (DEBUG) {
	                System.out.println("BA.run():시스템장애(SocketException)");
	            }
	            return "Fail0000:시스템장애(SocketException)";
	        } catch (IOException e) {
	            if (DEBUG) {
	                System.out.println("BA.run():시스템장애(IOException)");
	            }
	            return "Fail0000:시스템장애(IOException)";
	        } catch (NullPointerException e) {
	            if (DEBUG) {
	                System.out.println("BA.run():시스템장애(NullPointerException)");
	            }
	            return "Fail0000:시스템장애(NullPointerException)";
	        } catch (Exception e) {
	            if (DEBUG) {
	                System.out.println("BA.run():시스템장애(Exception)");
	            }
	            return "Fail0000:시스템장애(Exception)";
	        }
	    }
	  public String setBathBun( String batchFileName, String args ){
	        String resultVal ="";
	        setBatchInfo(batchFileName, args);

	        if (start().equals("OK")) {
	            
	            System.out.println("*******************Batch Process Start*******************");
	            resultVal = run();
	            resultVal = "0";
	        } else {
	            resultVal = "1";
	        }
	        stop();
	        
	        return resultVal;
	    }
	  public void setBatchInfo( String batchFileName, String args ) {
	        
	        // client로 부터 입력받을 card정보 
	        batch_Info+=batchFileName+args;


	    } 
}
