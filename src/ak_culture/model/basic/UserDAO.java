package ak_culture.model.basic;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class UserDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/userMapper";
	public void insUser(String join_id, String join_pw, String join_name, String join_tim, String join_phone, String join_email, String join_store, String join_seq_no, String join_bizno, String join_status) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("join_id", join_id);
		map.put("join_pw", join_pw);
		map.put("join_name", join_name);
		map.put("join_tim", join_tim);
		map.put("join_phone", join_phone);
		map.put("join_email", join_email);
		map.put("join_store", join_store);
		map.put("join_seq_no", join_seq_no);
		map.put("join_bizno", join_bizno);
		map.put("join_status", join_status);
		
		getSqlSession().insert(NS + ".insUser", map);
	}
	public List<HashMap<String, Object>> getUser(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type, String search_type, List<String> store_data, String search_status, List<String> auth_data) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_type", search_type);
		map.put("search_status", search_status);
		if(store_data.size() > 0){
			map.put("store_data", store_data);
		}
		if(auth_data.size() > 0){
			map.put("auth_data", auth_data);
		}
		System.out.println("search_status : "+search_status);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUser", map);
		return list;
	}
	public HashMap<String, Object> getUser_one(String seq_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getUser_one", map);
		return data;
	}
	public List<HashMap<String, Object>> getUserCount(String search_name, String search_type, List<String> store_data, String search_status, List<String> auth_data) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_type", search_type);
		map.put("search_status", search_status);
		if(store_data.size() > 0){
			map.put("store_data", store_data);
		}
		if(auth_data.size() > 0){
			map.put("auth_data", auth_data);
		}
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUserCount", map);
		return list;
	}
	public HashMap<String, Object> loginCheck(String login_id, String login_pw) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_id", login_id);
		map.put("login_pw", login_pw);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".loginCheck", map);
		return data;
	}
	public void upLastLogin(String seq_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		getSqlSession().update(NS + ".upLastLogin", map);
	}
	public void upUser(String seq_no, String status, String leader, String auth_name, String rep_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		map.put("status", status);
		map.put("leader", leader);
		map.put("auth_name", auth_name);
		map.put("rep_store", rep_store);
		
		System.out.println("======================"+map);
		getSqlSession().update(NS + ".upUser", map);
	}
	public List<HashMap<String, Object>> getLevel(String level_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("level_name", level_name);
		List<HashMap<String, Object>> data = getSqlSession().selectList(NS + ".getLevel", map);
		
		return data;
	}
	public List<HashMap<String, Object>> getLevel_cate() {
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLevel_cate");
		return list;
	}
	public void insLevel(String level_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("level_name", level_name);
		getSqlSession().insert(NS + ".insLevel", map);
	}
	public void upLevel(String level_name, String up_level_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("level_name", level_name);
		map.put("up_level_name", up_level_name);
		getSqlSession().update(NS + ".upLevel", map);
		getSqlSession().update(NS + ".upLevel_toUser", map);
	}
	public int level_chk(String level_name, String auth_uri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("level_name", level_name);
		map.put("auth_uri", auth_uri);
		
		int result = getSqlSession().selectOne(NS + ".level_chk", map);
		return result;
	}
	public void level_addAuth(String level_name, String auth_uri, String auth_key) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("level_name", level_name);
		map.put("auth_uri", auth_uri);
		map.put("auth_key", auth_key);
		
		getSqlSession().insert(NS + ".level_addAuth", map);
	}
	public void level_editAuth(String level_name, String auth_uri, String auth_key) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("level_name", level_name);
		map.put("auth_uri", auth_uri);
		map.put("auth_key", auth_key);
		
		getSqlSession().update(NS + ".level_editAuth", map);
		getSqlSession().update(NS + ".level_editUser", map);
	}
	public void level_del(String level_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("level_name", level_name);
		
		getSqlSession().delete(NS + ".level_delAuth", map);
	}
	public HashMap<String, Object> getUser_bizno(String bizno) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("bizno", bizno);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getBizno", map);
		return data;
	}
	public void edit_appro(String modify_seq_no, String modify_status) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("modify_seq_no", modify_seq_no);
		map.put("modify_status", modify_status);

		getSqlSession().update(NS + ".edit_appro", map);
	}
	public int chk_insUser(String join_seq_no) {
		return getSqlSession().selectOne(NS + ".chk_insUser", join_seq_no);
	}
	public List<HashMap<String, Object>> getUser_auth_name(String level_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("auth_name", level_name);

		return getSqlSession().selectList(NS + ".getAuthName", map);
	}
	public void auth_custom(String seq_no){
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		getSqlSession().update(NS + ".auth_custom", map);
	}
	public List<HashMap<String, Object>> getNoneAuthList(String seq_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);

		return getSqlSession().selectList(NS + ".getNoneAuthList", map);
	}
	public List<HashMap<String, Object>> getManagerLogListCount(String search_name, String search_start, String search_end) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getManagerLogListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getManagerLogList(int s_rownum, int e_rownum, String order_by, String sort_type, String search_name, String search_start, String search_end) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getManagerLogList", map);
		return list;
	}
}
