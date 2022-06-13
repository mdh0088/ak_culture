package ak_culture.classes;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;


public class EPApproval implements Serializable {
    public final static String MIS_ID = "EAKIRS";
    public final static int TEXT = 0;
    public final static int HTML = 1;
    
    private String system_id;
    
    private String view_id;
    
    private String submit_date;
    
    private String seq;
    
    /** 
     * 본문타입 0:Text, 1:HTML, 2:MHTML 
     */
    private int bodyType;

    /** 
     * 결재본문 
     */
    private String body;
    
    /** 
     * 결재문서 제목 
     */
    private String subject;
    
    /** 
     * 결재참가자 리스트 
     */
    private List participantList = new ArrayList();;
    
    /** 
     * 첨부파일 리스트 
     */
    private List attachFileList;
    
    /**
     * 결재 후속 프로시져 명
     */
    private String resultProcedure;
    
    public EPApproval() {
        system_id = "BA";
        view_id = "BALect";
        submit_date = AKCommon.getCurrentDate();
        
//        String files = "";
//        participantList = new ArrayList();
//        if(param.getAttachFileCount() > 0) {
//            attachFileList = param.getAttachFileList();    
//        }
    }
    
    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    public void setContents(String body, int type) {
        this.body = body;
        this.bodyType = type;
    }
    
    public void addParticipant(String userId, String activity) {
        participantList.add(new String[]{userId, activity});
    }

    public int getParticipantCount() {
        return (participantList == null) ? 0 : participantList.size(); 
    }
    /**
     * @return the system_id
     */
    public String getSystem_id() {
        return system_id;
    }

    /**
     * @return the view_id
     */
    public String getView_id() {
        return view_id;
    }

    /**
     * @return the submit_date
     */
    public String getSubmit_date() {
        return submit_date;
    }

    /**
     * @return the body
     */
    public String getBody() {
        return body;
    }

    /**
     * @return the subject
     */
    public String getSubject() {
        return subject;
    }

    /**
     * @return the seq
     */
    public String getSeq() {
        return seq;
    }

    /**
     * @param seq the seq to set
     */
    public void setSeq(String seq) {
        this.seq = seq;
    }

    /**
     * @return the attachFileList
     */
    public List getAttachFileList() {
        return attachFileList;
    }

    public int getAttachFileCount() {
        return (attachFileList == null) ? 0 : attachFileList.size(); 
    }
    
    /**
     * @return the participantList
     */
    public List getParticipantList() {
        return participantList;
    }

    public String getResultProcedure() {
        return resultProcedure;
    }

    public void setResultProcedure(String resultProcedure) {
        this.resultProcedure = resultProcedure;
    }
}
