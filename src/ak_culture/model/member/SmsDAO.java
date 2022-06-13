package ak_culture.model.member;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.mybatis.spring.support.SqlSessionDaoSupport;

import ak_culture.classes.Utils;

public class SmsDAO extends SqlSessionDaoSupport{
	
	private String NS = "/member/smsMapper";
	
	public List<HashMap<String, Object>> getTmCust(String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("tm_seq", tm_seq);


		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmCust", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmCustMemo(String cust_no,String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("tm_seq", tm_seq);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmCustMemo", map);
		return list;
	}
	
	public int getSmsSeq(String store,String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getSmsSeq", map);
		return Utils.checkNullInt(data.get("SMS_SEQ"));
	}
	
	public List<HashMap<String, Object>> getTmSeq() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmSeq", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getSmsCustInfo(String cust_no,String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsCustInfo", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getSmsAmstInfo(String cust_no,String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsAmstInfo", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getSmsLecrInfo(String cust_no,String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsLecrInfo", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> choose_message(String sms_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sms_seq", sms_seq);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".choose_message", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmCustInfo(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmCustInfo", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmLecrInfo(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmLecrInfo", map);
		return list;
	}
	
	
	public void add_tm_memo(String store,String period,String tm_seq,String cust_no,String memo,String receiver,String recall_yn,String create_resi_no) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("tm_seq", tm_seq);
		map.put("cust_no", cust_no);
		map.put("memo", memo);
		map.put("receiver", receiver);
		map.put("recall_yn", recall_yn);
		map.put("create_resi_no", create_resi_no);

		getSqlSession().insert(NS + ".add_tm_memo", map);
	}
	
	public void upt_tm_Custinfo(String store, String period, String tm_seq,String cust_no,String memo,String receiver,String recall_yn,String memo_seq,String create_resi_no) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("tm_seq", tm_seq);
		map.put("cust_no", cust_no);
		map.put("memo", memo);
		map.put("receiver", receiver);
		map.put("recall_yn", recall_yn);
		map.put("memo_seq", memo_seq);
		
		map.put("create_resi_no", create_resi_no);

		getSqlSession().update(NS + ".upt_tm_Custinfo", map);
	}

	public int insSms(String send_type,String sms_sender,String cont_type,String cont_title,String create_resi_no,String message_area,String store,String period) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("send_type", send_type);
		map.put("sms_sender", sms_sender);
		map.put("cont_type", cont_type);
		map.put("cont_title", cont_title);
		map.put("create_resi_no", create_resi_no);
		map.put("message_area", message_area);
		map.put("store", store);
		map.put("period", period);
		getSqlSession().insert(NS + ".insSms", map);
	
		
		return Utils.checkNullInt(map.get("sms_seq"));
	}
	
	
	public List<HashMap<String, Object>> getTmCustList(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmCustList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> messageList(String store, String send_state) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("send_state", send_state);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".messageList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTargetCustList( String store,String year,String season,String main_cd,String sect_cd,String subject_cd){
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("year", year);
		map.put("season", season);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTargetCustList", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getSmsCount(String store,String search_name,String start_day,String end_day,String search_type,String send_type,String send_state) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("start_day", start_day);
		map.put("end_day", end_day);
		map.put("search_type", search_type);
		map.put("send_type", send_type);
		map.put("send_state", send_state);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsCount", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getSmsCustListCount(String store,String period,String sms_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("sms_seq", sms_seq);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsCustListCount", map);
		return list;
	}
	
	public HashMap<String, Object> getContent(String store,String period,String sms_seq,String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("sms_seq", sms_seq);
		map.put("cust_no", cust_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getContent", map);
		return data;
	}
	
	
	
	public List<HashMap<String, Object>> getSmsCustList(String store,String period,String sms_seq,int s_rownum,int e_rownum,String order_by,String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("sms_seq", sms_seq);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsCustList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getSms(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type,
			String store, String start_day, String end_day, String search_type, String send_type,String send_state) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		map.put("store", store);
		map.put("start_day", start_day);
		map.put("end_day", end_day);
		map.put("search_type", search_type);
		map.put("send_type", send_type);
		map.put("send_state", send_state);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSms", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmCount(String store, String period,String search_name,
			String searchType, String start_day, String end_day,String purpose,String result) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		
		map.put("store", store);
		map.put("period", period);
		map.put("searchType", searchType);
		map.put("start_day", start_day);
		map.put("end_day", end_day);
		map.put("purpose", purpose);
		map.put("result", result);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmList(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type,
			String store, String period, String searchType, String start_day, String end_day,String purpose,String result) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		map.put("store", store);
		map.put("period", period);
		map.put("searchType", searchType);
		System.out.println("model searchType : "+searchType);
		map.put("start_day", start_day);
		map.put("end_day", end_day);
		map.put("purpose", purpose);
		map.put("result", result);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmListForCustCount(String store,String period,String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("tm_seq", tm_seq);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmListForCustCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmListForLecrCount(String store,String period,String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("tm_seq", tm_seq);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmListForLecrCount", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getTmListForCust(int s_rownum, int e_rownum, String order_by, String sort_type,String tm_seq,String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("tm_seq", tm_seq);
		map.put("store", store);
		map.put("period", period);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmListForCust", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTmListForLecr(int s_rownum, int e_rownum, String order_by, String sort_type,String tm_seq,String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		map.put("tm_seq", tm_seq);
		map.put("store", store);
		map.put("period", period);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmListForLecr", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> recentCustList(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".recentCustList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> choose_custList(String sms_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sms_seq", sms_seq);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".choose_custList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> send_kakao(String receiver,String sender,String message,String sender_key,String templete_code,String reserve_time,String store_id,String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("receiver", receiver);
		map.put("sender", sender);
		map.put("message", message);
		map.put("sender_key", sender_key);
		map.put("templete_code", templete_code);
		map.put("reserve_time", reserve_time);
		map.put("store_id", store_id);
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".send_kakao", map);
		return list;
	}	
	
	public void insSmsList(String store,String cust_no,String kor_nm ,String receiver,String  sms_sender,String message, 
							String reserve_time, String create_resi_no,String send_type,String send_state,
							int sms_seq,String send_result,String period,String title,String cont_type) {		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		map.put("kor_nm", kor_nm);
		map.put("receiver", receiver);
		map.put("sms_sender", sms_sender);
		map.put("message", message);
		map.put("reserve_time", reserve_time);
		map.put("create_resi_no", create_resi_no);
		map.put("send_type", send_type);
		map.put("send_state", send_state);
		map.put("sms_seq", sms_seq);
		map.put("send_result", send_result);
		map.put("period", period);
		map.put("title", title);
		map.put("cont_type", cont_type);
		getSqlSession().insert(NS + ".insSmsList", map);
	}
	
	public int insTm(String store,String period, String subject_cd, String act,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		//map.put("tm_seq", tm_seq);
		map.put("subject_cd", subject_cd);
		map.put("act", act);
		map.put("create_resi_no", create_resi_no);
		getSqlSession().insert(NS + ".insTm", map);
		return Utils.checkNullInt(map.get("tm_seq"));
	}
	
	public int writeTm(String store,String period,String title,String purpose,String create_resi_no,String lect_cd,String is_lec,String dead_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("title", title);
		map.put("purpose", purpose);
		map.put("create_resi_no", create_resi_no);
		map.put("lect_cd", lect_cd);
		map.put("is_lec", is_lec);
		map.put("dead_ymd", dead_ymd);
		
		getSqlSession().insert(NS + ".writeTm", map);
		return Utils.checkNullInt(map.get("tm_seq"));
	}
	
	public int writeTmList(int tm_seq,String custlist, String create_resi_no,String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("tm_seq", tm_seq);
		map.put("custlist", custlist);
		map.put("create_resi_no", create_resi_no);
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().insert(NS + ".writeTmList", map);
	}
	
	
	public void uptTMLCustInfo(String store, String period,String tm_seq,String cust_no,String recall_yn,String create_resi_no,String receiver) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("tm_seq", tm_seq);
		map.put("cust_no", cust_no);
		map.put("recall_yn", recall_yn);		
		map.put("create_resi_no", create_resi_no);
		map.put("receiver", receiver);
		
		getSqlSession().update(NS + ".uptTMLCustInfo", map);
	}
	
	public String getTmMemoResult(String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("tm_seq", tm_seq);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getTmMemoResult", map);
		return Utils.checkNullString(data.get("RESULT"));
	}
	
	public HashMap<String, Object> getTmmInfo(String store,String period,String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("tm_seq", tm_seq);

		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getTmmInfo", map);
		return data;
	}
	
	
	
	public int uptTmlAll(String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("tm_seq", tm_seq);
		int result = getSqlSession().update(NS + ".uptTmlAll", map);
		return result;
	}
	
	public int uptTmMemoAll(String tm_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("tm_seq", tm_seq);
		int result = getSqlSession().update(NS + ".uptTmMemoAll", map);
		return result;
	}
	

	public HashMap<String, Object> getLectData(String store,String period,String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getLectData", map);
		return data;
	}
	
	public void delTm(String store, String period,String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("seq", seq);
		getSqlSession().delete(NS + ".delTm", map);
		getSqlSession().delete(NS + ".delTml", map);
	}
	
	public HashMap<String, Object> ChkUserForCustExcel(String p1,String p2,String p3) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("p1", p1);
		map.put("p2", p2);
		map.put("p3", p3);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".ChkUserForCustExcel", map);
		return data;
	}
	
	public HashMap<String, Object> ChkUserForAMSExcel(String p1,String p2,String p3) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("p1", p1);
		map.put("p2", p2);
		map.put("p3", p3);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".ChkUserForAMSExcel", map);
		return data;
	}
	
	public HashMap<String, Object> SmsCust_nm(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);

		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".SmsCust_nm", map);
		return data;
	}
	
	public HashMap<String, Object> Smslecr_nm(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);

		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".Smslecr_nm", map);
		return data;
	}
	
	public HashMap<String, Object> getPeltInfo(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getPeltInfo", map);
		return data;
	}
	
}
