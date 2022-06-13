/*
 * Title        : NamoContentsProvider.java
 * Copyright    : Copyright 2007 Samsung SDS Co.,
 * Author       : 윤 석 진
 * Date         : 2007. 09. 29
 * Company      : Samsung SDS Co., Ltd.
 * Description  : 
 */
package ak_culture.classes;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.apache.log4j.Logger;

/**
 * Namo Wec로부터 전송된 MIME encoding형태의 메시지를 decoding한다.
 * 본문내용과 첨부된 파일의 내용을 제공해준다.
 * 첨부된 파일은 temp 폴더에 저장되고, 본문내용을 변경하여 접근가능한 형태의 url로 변경한다.
 * @author 윤 석 진
 * @version 1.0, 2007. 09. 29
 */
public class NamoContentsProvider {
    /**
     * Log4J Logging instance
     */
    static Logger logger = Logger.getLogger(NamoContentsProvider.class);
    final static class MIME {
        public static int BEGIN = 0;
        public static int HEADER = 1;
        public static int BODY = 2;
        public static int END = 3;

    };
    
    /** 
     * multipart 
     */
    private boolean multipart = false;
    /** 
     * multipart 인 경우 바운더리 text
     */
    private String boundary;
    
    /**
     * MIME Part List
     */
    private List partList;

    private String accessPath;    
    public void setAccessPath(String accesspath) {
        this.accessPath = accesspath;
    }

    public NamoContentsProvider() {
        partList = new ArrayList();
    }
    
    public String getBodyContents() throws MessagingException, IOException {
        String body = ((NamoMimePart)partList.get(0)).getText();
        return changeCIDPath(body);
    }
    /**
     * MIME encoding된 text를 decoding한다.
     * 
     * @param encodedString
     */
    public void decodeMIME(String encodedString) throws MimeDecodeException {
        checkMimeType(encodedString);
        
        splitMimePart(encodedString);
    }

    /**
     * MultiPart 인 경우 MIME part 처리
     */
    protected void splitMultiPart(String encodedString) throws MimeDecodeException {
        int start = 0;
        int pos = 0;
        
        while(true) {
            pos = encodedString.indexOf("--" + boundary, start);
            if(pos == -1) { // 다음 바운더리가 없는 경우 패스
                break;
            }
            start = encodedString.indexOf("--" + boundary, pos + boundary.length() + 2);
            if(start == -1) {
                break;
            }
            splitSinglePart(encodedString.substring(pos + boundary.length() + 2, start));
        }
    }
    /**
     * 하나의 MIME Part를 헤더, 본문 으로 분리한다.
     */
    protected void splitSinglePart(String encodedString) throws MimeDecodeException {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new StringReader(encodedString));
            String line = null;
            String body = new String();
            NamoMimePart part = new NamoMimePart();
    
            int nowState = MIME.BEGIN;
            while(((line = br.readLine()) != null) && (nowState != MIME.END)) {
                line = line.trim();
                if(line.length() == 0 && nowState == MIME.BEGIN) { // 시작부분에 있는 공백 무시
                    continue;
                } else {
                    // 이전 상황에 시작이었으면 헤더상태로
                    if(nowState == MIME.BEGIN) nowState = MIME.HEADER;
    
                    String compare = line.toLowerCase();
                    if(nowState == MIME.HEADER) {
                        // MIME Version은 저장하지 않는다                    
                        if(compare.indexOf("mime-version") != -1) {
                            continue;
                        } else if(compare.indexOf("content-type") != -1) {
                            part.setContentType(compare.substring(compare.indexOf(":") + 1).trim());
                        } else if(compare.indexOf("content-transfer-encoding") != -1) {
                            part.setEncoding(line.substring(line.indexOf(":") + 1).trim());
                        } else if(compare.indexOf("content-id") != -1) {
                            compare = line.substring(line.indexOf("<") + 1, line.indexOf(">"));
                            part.setContentID(compare);
                        } else if(compare.indexOf("name") != -1) {
                            compare = line.substring(line.indexOf("\"") + 1, line.length() - 1);
                            part.setName(compare);
                        } else if(compare.length() == 0) { // 헤더 상태에서 공백이 오면 본문상태로 전환
                            nowState = MIME.BODY;
                        }
                    } else if(nowState == MIME.BODY) {
                        if(logger.isDebugEnabled()) {
                            logger.debug("body");
                        }                    
                        if(line.length() == 0 && multipart) {
                            nowState = MIME.END;
                        } else {
                            body = encodedString.substring(encodedString.indexOf(line));
                            break;
                        }
                    }
                }
            }
            part.setBodypart(body);
            partList.add(part);
        }catch(IOException e) {
            logger.error(e);
            throw new MimeDecodeException(e.getMessage());
        }
    }    
    /**
     * MIME 을 part 별로 나누고, 정보를 분석한다
     */ 
    protected void splitMimePart(String encodedString) throws MimeDecodeException {
        if(this.multipart) {
            splitMultiPart(encodedString);
        } else {
            splitSinglePart(encodedString);
        }
    }
    
    /**
     * MIME 데이터의 형식을 검사한다.
     */
    private void checkMimeType(String encodedString) throws MimeDecodeException {
        if(logger.isDebugEnabled()) {
            logger.debug("checkMimeType");
        }        
        String header = getHeaderString(encodedString);
        if(logger.isDebugEnabled()) {
            logger.debug("header : " + header);
        }
        int pos = 0;
        String data = header.toLowerCase(); 
        // find content-type
        if((pos = data.indexOf("content-type")) == -1) { 
            throw new MimeDecodeException("Not found content-type");
        }
        // find multipart directive
        if((pos = data.indexOf("multipart", pos+1)) != -1) { 
            this.multipart = true;
            // find boundary
            if((pos = data.indexOf("boundary")) == -1) { 
                throw new MimeDecodeException("Not found boundary");
            }
            if((pos = data.indexOf("\"", pos+1)) == -1) {
                throw new MimeDecodeException("Not found boundary");
            }
            //find boundary data
            this.boundary = header.substring(pos+1, header.indexOf("\"", pos+1));
            if(logger.isDebugEnabled()) {
                logger.debug("boundary : " + boundary);
            }            
        } else {
            this.multipart = false;
        }
    }    
    
    /**
     * MIME encoding된 스트링으로부터 header정보를 리턴한다.
     * @param encodedString
     * @return
     * @throws IOException
     * @throws MimeDecodeException
     */
    private String getHeaderString(String encodedString) throws MimeDecodeException {
        BufferedReader br = null;
        try {
            br = new BufferedReader(new StringReader(encodedString));
            StringBuffer sb = new StringBuffer();
            while(true) {
                String line = br.readLine().trim();
                if(line == null || line.length() <= 0) {
                    break;
                }
                sb.append(line);
            }
            if(sb.length() <= 0) {
                throw new MimeDecodeException("Not found MIME Header");
            }
            return sb.toString();
        }catch(IOException e) {
            logger.error(e);
            throw new MimeDecodeException(e.getMessage());
        }finally {
            if(br != null) try {br.close();}catch(IOException e) {}
        }
    }

    /**
     * 첨부된 파일이 있을 경우 CID 링크 내용을 저장한 파일 이름으로 변경한다.
     */
    private String changeCIDPath(String content) {
        String convert = content;

        for(int i=1; i<partList.size(); i++) {
            NamoMimePart part = (NamoMimePart)partList.get(i);
            if(part.getContentID() != null) {
                StringBuffer sb = new StringBuffer();
                sb.append(accessPath).append("?");
                Map params = part.getParameters();
                for(Iterator iter = params.keySet().iterator(); iter.hasNext(); ) {
                    String key = (String)iter.next();
                    String value = (String)params.get(key);
                    sb.append(key).append("=").append(value).append("&");
                }
                //file id
                sb.append("file_id=").append(part.getUniqueID());
                
                convert = replace(convert, "cid:" + part.getContentID(), sb.toString());
            }
        }

        return convert;
    }    

    /**
     * @return the partList
     */
    public List getPartList() {
        return partList;
    }    
    private String replace(String src, String from, String to) {
        StringBuffer sb = new StringBuffer(src);
        int len = from.length();
        int i = src.lastIndexOf(from);
        while(i >= 0) {
            sb.replace(i, i+len, to);
            i = src.lastIndexOf(from, i-1);
        }
        return sb.toString();
    }    

}
