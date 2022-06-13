package ak_culture.model.api;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class ApiDAO extends SqlSessionDaoSupport{
	
	private String NS = "/api/apiMapper";
	
	public HashMap<String, Object> getAttendInfo(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getAttendInfo", map);
		return data;
	}
	
	
	public int insAttend(String store, String period, String subject_cd, String login_seq,String isLec,String cust_no,String dayVal,String p_cust, String c_cust1, String c_cust2) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("login_seq", login_seq);
		map.put("isLec", isLec);
		map.put("cust_no", cust_no);
		map.put("dayVal", dayVal);
		map.put("p_cust", p_cust);
		map.put("c_cust1", c_cust1);
		map.put("c_cust2", c_cust2);
		
		return getSqlSession().insert(NS + ".insAttend", map);
	}
	
	public List<HashMap<String, Object>> getEncdList(String store, String period, String cust_no, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectList(NS + ".getEncdList", map);
	}
	
	public List<HashMap<String, Object>> getEncdList2(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);

		return getSqlSession().selectList(NS + ".getEncdList2", map);
	}
	
	public List<HashMap<String, Object>> getPeltMid(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltMid", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getHoliday(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getHoliday", map);
		return list;
	}
	

}
