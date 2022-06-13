package ak_culture.model.akris;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import ak_culture.classes.EPApproval;
import ak_culture.classes.Utils;

public class AkrisDAO extends SqlSessionDaoSupport{
	
	private String NS = "/akris/akrisMapper";

	public String submit(EPApproval app) {
		String documentID = insertBCEPBHTB(app);
		if (app.getParticipantCount() > 0) {
			insertBCEPBDTB(app);
		}

		return documentID;
	}
	public List<HashMap<String, Object>> getTally(String store, String start_ymd, String end_ymd, String doc_type, String status_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("doc_type", doc_type);
		map.put("status_fg", status_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTally", map);
		return list;
	}
	public HashMap<String, Object> sapcancel(String login_seq, String store, String sale_ymd, String gbn_upmu) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq); 
		map.put("store", store); 
		map.put("sale_ymd", sale_ymd); 
		map.put("gbn_upmu", gbn_upmu); 
		getSqlSession().selectOne(NS + ".sapcancel", map);
		
		HashMap<String, Object> data = new HashMap<>();
		data.put("o_code", map.get("o_code"));
		data.put("o_message", map.get("o_message"));
		
		return data;
	}

	private void insertBCEPBDTB(EPApproval app) {
		List list = app.getParticipantList();
        for(Iterator iter = list.iterator(); iter.hasNext(); ) {
            String[] man = (String[])iter.next();
            
            HashMap<String, Object> queryParam = new HashMap<>();
            queryParam.put("system_id", app.getSystem_id());
            queryParam.put("view_id", app.getView_id());
            queryParam.put("submit_date", app.getSubmit_date());
            queryParam.put("seq", app.getSeq());
            queryParam.put("resi_no", man[0]);
            queryParam.put("activity", man[1]);
            
            System.out.println("=======================> 결재선 등록 start<=======================");
            System.out.println("system_id=======================> " + app.getSystem_id()+ " <=======================");
            System.out.println("view_id=======================> " + app.getView_id()+ " <=======================");
            System.out.println("submit_date=======================> " + app.getSubmit_date()+ " <=======================");
            System.out.println("seq=======================> " + app.getSeq()+ " <=======================");
            System.out.println("resi_no=======================> " + man[0]+ " <=======================");
            System.out.println("activity=======================> " + man[1]+ " <=======================");
            System.out.println("=======================> 결재선 등록 end<=======================");
            getSqlSession().selectOne(NS + ".insertBCEPBDTB", queryParam);
        }
	}
	private String insertBCEPBHTB(EPApproval app)  {
		HashMap<String, Object> queryParam = new HashMap<>();
        
        queryParam.put("system_id", app.getSystem_id());
        queryParam.put("view_id", app.getView_id());
        queryParam.put("submit_date", app.getSubmit_date());
        queryParam.put("subject", app.getSubject());
        queryParam.put("content", app.getBody());
        queryParam.put("athority_cnt", String.valueOf(app.getParticipantCount()));
        queryParam.put("ret_call_sp", app.getResultProcedure());
        
        System.out.println("=======================> 결재마스터 등록 start<=======================");
        System.out.println("system_id=======================> " + app.getSystem_id()+ " <=======================");
        System.out.println("view_id=======================> " + app.getView_id()+ " <=======================");
        System.out.println("submit_date=======================> " + app.getSubmit_date()+ " <=======================");
        System.out.println("subject=======================> " + app.getSubject()+ " <=======================");
        System.out.println("content=======================> " + app.getBody()+ " <=======================");
        System.out.println("athority_cnt=======================> " + String.valueOf(app.getParticipantCount())+ " <=======================");
        System.out.println("ret_call_sp=======================> " + app.getResultProcedure()+ " <=======================");
        System.out.println("=======================> 결재마스터 등록 end<=======================");
        
        getSqlSession().selectOne(NS + ".insertBCEPBHTB", queryParam);
        
        HashMap<String, Object> result = new HashMap<>();
        result.put("seq", queryParam.get("seq"));
        result.put("document_id", queryParam.get("document_id"));
        app.setSeq(Utils.checkNullString(result.get("seq")));
        System.out.println("seq =======================> " + app.getSeq()+ " <=======================");
        System.out.println("document_id =======================> " + Utils.checkNullString(result.get("document_id"))+ " <=======================");
        return Utils.checkNullString(result.get("document_id"));
    }
	public String getNamoFileNo() {
		return getSqlSession().selectOne(NS + ".getNamoFileNo");
	}
	public void insNamoFile(String file_no, String file_id, String file_nm, long file_size, String content_type,byte[] file_obj, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("file_no", file_no);
		map.put("file_id", file_id);
		map.put("file_nm", file_nm);
		map.put("file_size", file_size);
		map.put("content_type", content_type);
		map.put("file_obj", file_obj);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insNamoFile", map);
	}
	public void insertBCFILETB(String file_no, String file_nm, long file_size, byte[] file_obj) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("file_no", file_no);
		map.put("file_nm", file_nm);
		map.put("file_size", file_size);
		map.put("file_obj", file_obj);
		getSqlSession().insert(NS + ".insertBCFILETB", map);
	}
	public void insertBCEPBFTB(String file_nm, long file_size, String file_no, String system_id, String view_id, String submit_date, String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("file_nm", file_nm);
		map.put("file_size", file_size);
		map.put("file_no", file_no);
		map.put("system_id", system_id);
		map.put("view_id", view_id);
		map.put("submit_date", submit_date);
		map.put("seq", seq);
		
		getSqlSession().insert(NS + ".insertBCEPBFTB", map);
	}
	public String issueAttachFileNo() {
		return getSqlSession().selectOne(NS + ".issueAttachFileNo");
	}
}
