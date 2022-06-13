package ak_culture.model.member;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class ReloDAO extends SqlSessionDaoSupport{
	
	private String NS = "/member/reloMapper";

	public List<HashMap<String, Object>> getReloUser(String search_name, String search_phone, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_phone", search_phone);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getReloUser", map);
		return list;
	}

	public List<HashMap<String, Object>> getReloUserPere(String store, String period, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getReloUserPere", map);
		return list;
	}
	public List<HashMap<String, Object>> getReloUserPereSubject(String store, String period, String cust_no, String subject_cd, String child_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		map.put("child_no", child_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getReloUserPereSubject", map);
		return list;
	}

	public List<HashMap<String, Object>> getSamePriceLect(String store, String period, String subject_cd, String food_yn, int regis_fee, int food_amt) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("regis_fee", regis_fee);
		map.put("food_yn", food_yn);
		map.put("food_amt", food_amt);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSamePriceLect", map);
		return list;
	}

	public void movePelt(String store, String period, String cust_no, String prev_subject_cd, String next_subject_cd, String main_cd, String sect_cd, String ori_child_no, String child1_no, String child2_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("prev_subject_cd", prev_subject_cd);
		map.put("next_subject_cd", next_subject_cd);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("ori_child_no", ori_child_no);
		map.put("child1_no", child1_no);
		map.put("child2_no", child2_no);
		getSqlSession().update(NS + ".movePelt", map);
	}

	public void upPeltRegis(String store, String period, String prev_subject_cd,  String next_subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("prev_subject_cd", prev_subject_cd);
		map.put("next_subject_cd", next_subject_cd);
		getSqlSession().update(NS + ".upPeltRegis_minus", map);
		getSqlSession().update(NS + ".upPeltRegis_plus", map);
	}

	public void insLemv(String store, String period, String cust_no, String prev_subject_cd, String next_subject_cd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("prev_subject_cd", prev_subject_cd);
		map.put("next_subject_cd", next_subject_cd);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insLemv", map);
	}
	public List<HashMap<String, Object>> getLemv(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLemv", map);
		return list;
	}
	public List<HashMap<String, Object>> getLemvCount(String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLemvCount", map);
		return list;
	}

	public void upTrde(String store, String recpt_no, String sale_ymd, String pos_no,
			String prev_subject_cd, String next_subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("recpt_no", recpt_no);
		map.put("sale_ymd", sale_ymd);
		map.put("pos_no", pos_no);
		map.put("prev_subject_cd", prev_subject_cd);
		map.put("next_subject_cd", next_subject_cd);
		getSqlSession().update(NS + ".upTrde", map);
	}
	public void upWbtr(String store, String recpt_no, String sale_ymd, String pos_type,
			String prev_subject_cd, String next_subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("recpt_no", recpt_no);
		map.put("sale_ymd", sale_ymd);
		map.put("pos_type", pos_type);
		map.put("prev_subject_cd", prev_subject_cd);
		map.put("next_subject_cd", next_subject_cd);
		getSqlSession().update(NS + ".upWbtr", map);
	}
}
