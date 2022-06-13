package ak_culture.model.common;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class AuthDAO extends SqlSessionDaoSupport{
	
	private String NS = "/authMapper";
	public HashMap<String, Object> getMgrNo(String seq_no, String uri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		map.put("uri", uri);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getMgrAuth", map);
		
		return data;
	}
	public int chk_new(String seq_no, String auth_uri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		map.put("auth_uri", auth_uri);
		int result = getSqlSession().selectOne(NS + ".chk_new",map); 
		return result;
	}
	public void write_proc(String seq_no, String auth_uri, String auth_key) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		map.put("auth_uri", auth_uri);
		map.put("auth_key", auth_key);
		
		getSqlSession().insert(NS + ".insAuth", map);
	}
	public void modify_proc(String seq_no, String auth_uri, String auth_key) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		map.put("auth_uri", auth_uri);
		map.put("auth_key", auth_key);
		
		getSqlSession().update(NS + ".upAuth", map);
	}
	public List<HashMap<String, Object>> getAuth(String seq_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		
		return getSqlSession().selectList(NS + ".getAuth", map);
	}
}

