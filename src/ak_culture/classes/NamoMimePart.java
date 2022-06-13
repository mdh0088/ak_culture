/*
 * Title        : MIMEPart.java
 * Copyright    : Copyright 2007 Samsung SDS Co.,
 * Author       : 윤 석 진
 * Date         : 2007. 09. 29
 * Company      : Samsung SDS Co., Ltd.
 * Description  : 
 */
package ak_culture.classes;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.rmi.server.UID;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeUtility;

import org.apache.log4j.Logger;

/**
 * MIME Data의 한 파트
 * 
 * @author 윤 석 진
 * @version 1.0, 2007. 09. 29
 */
public class NamoMimePart {
    /**
     * Log4J Logging instance
     */
    static Logger logger = Logger.getLogger(NamoMimePart.class);
    private static final String UID = (new UID()).toString().replace(':', '_').replace('-', '_');
    private static int counter = 0;
    
    private String bodypart;
    private String contentType;
    private String contentID;
    private String encoding;
    private String name;
    private String uniqueID;
    private Map params;

    public NamoMimePart() {
        uniqueID = NamoMimePart.generateUniqueId();
        params = new HashMap(); 
    }
    public void setParameter(String key, String value) {
        params.put(key, value);
    }
    
    public Map getParameters() {
        return params;
    }
    public String getStoreLocation() {
        return uniqueID;
    }
    public String toString() {
        StringBuffer sb = new StringBuffer();
        sb.append("name:").append(name).append("\n");
        sb.append("contentType:").append(contentType).append("\n");
        sb.append("contentID:").append(contentID).append("\n");
        sb.append("encoding:").append(encoding).append("\n");
        sb.append("bodypart:").append(bodypart).append("\n");
        return sb.toString();
    }
    
    public byte[] get() throws MessagingException, IOException {
        InputStream in = null;
        ByteArrayOutputStream out = null;
        try {
            in = getInputStream();

            out = new ByteArrayOutputStream();
            byte[] buff = new byte[8*1024];
            int bytesRead = -1;
            while((bytesRead = in.read(buff)) != -1) {
                out.write(buff, 0, bytesRead);
            }
            out.flush();

            return out.toByteArray();
        } finally {
            if(in != null) try {in.close();} catch(IOException e){}
            if(out != null) try {out.close();} catch(IOException e){}
        }        
    }
    
    public String getText() throws MessagingException, IOException {
        return new String(get());
    }
    
    public InputStream getInputStream() throws MessagingException, IOException {
        if(encoding == null) {
            return new ByteArrayInputStream(bodypart.getBytes());
        } else {
            return MimeUtility.decode(
                        new ByteArrayInputStream(bodypart.getBytes("iso-8859-1")),
                        encoding
                   );
        }
    }
    public void write(File outFile) throws MessagingException, IOException {
        InputStream in = null;
        BufferedOutputStream out = null;
        try {
            in = getInputStream();

            out = new BufferedOutputStream(new FileOutputStream(outFile));
            
            byte[] buff = new byte[8*1024];
            int bytesRead = -1;
            while((bytesRead = in.read(buff)) != -1) {
                out.write(buff, 0, bytesRead);
            }
            out.flush();
        } finally {
            if(in != null) try {in.close();} catch(IOException e){}
            if(out != null) try {out.close();} catch(IOException e){}
        }
    }

    public void setName(String name) {
        String convstr = CodeConverter.getMIMEEncodedString(name);
        if(convstr != null)
            this.name = convstr;
        else
            this.name = name;   
    }

    public String getName() {
        return name;
    }

    public void setBodypart(String part) {
        bodypart = part;
    }

    public String getBodypart() {
        return bodypart;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentID(String contentID){
        this.contentID = contentID;
    }

    public String getContentID(){
        return contentID;
    }

    public void setEncoding(String encoding) {
        this.encoding = encoding;
    }

    public String getEncoding() {
        return encoding;
    }
    
    private static String generateUniqueId() {
        int limit = 100000000;
        int current;
        synchronized(NamoMimePart.class) {
            current = counter++;
        }
        String id = Integer.toString(current);
        if(current < limit) {
            id = ("00000000" + id).substring(id.length());
        }
        return "namo_" + UID + "_" + id+".file";
    }
    /**
     * @return the uniqueID
     */
    public String getUniqueID() {
        return uniqueID;
    }
}

