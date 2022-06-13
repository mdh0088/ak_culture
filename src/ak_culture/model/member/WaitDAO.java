package ak_culture.model.member;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class WaitDAO extends SqlSessionDaoSupport{
	
	private String NS = "/member/waitMapper";

	public List<HashMap<String, Object>> getWaitCount(String search_type, String search_name, String store, String period, String main_cd, String sect_cd, String search_start, String search_end) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("period", period);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getWaitCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getWait(int s_rownum, int e_rownum, String order_by, String sort_type, String search_type, String search_name, String store, String period, String main_cd, String sect_cd, String search_start, String search_end) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("period", period);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getWait", map);
		return list;
	}
	public List<HashMap<String, Object>> getWaiter(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getWaiter", map);
		return list;
	}
	public void waitCancle(String cust_no, String store, String period, String subject_cd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("login_seq", login_seq);
		getSqlSession().update(NS + ".waitCancle", map);
	}
	public void insComment(String store, String period, String subject_cd, String cust_no, String comment) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cust_no", cust_no);
		map.put("comment", comment);
		getSqlSession().update(NS + ".insComment", map);
	}
}
