package ak_culture.model.basic;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.mapping.ParameterMapping;
import org.mybatis.spring.support.SqlSessionDaoSupport;

public class PosDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/posMapper";
	public void insPos(String write_hq, String write_store, String write_pos_no, String write_sale_ymd, String write_open_yn, String write_sale_end_yn, String write_ad_end_yn, String write_delete_yn, String write_send_yn, String write_create_resi_no, String write_pos_type) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("write_hq", write_hq);
		map.put("write_store", write_store);
		map.put("write_pos_no", write_pos_no);
		map.put("write_sale_ymd", write_sale_ymd);
		map.put("write_open_yn", write_open_yn);
		map.put("write_sale_end_yn", write_sale_end_yn);
		map.put("write_ad_end_yn", write_ad_end_yn);
		map.put("write_delete_yn", write_delete_yn);
		map.put("write_send_yn", write_send_yn);
		map.put("write_create_resi_no", write_create_resi_no);
		map.put("write_pos_type", write_pos_type);
		
		getSqlSession().insert(NS + ".insPos", map);
	}
	public int posDup(String write_hq, String write_store, String write_pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("write_hq", write_hq);
		map.put("write_store", write_store);
		map.put("write_pos_no", write_pos_no);
		int result = getSqlSession().selectOne(NS + ".posDup", map);
		
		return result;
	}
	public List<HashMap<String, Object>> getPos(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type, String search_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_store", search_store);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPos", map);
		
		return list;
	}
	public List<HashMap<String, Object>> getPosCount(String search_name, String search_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_store", search_store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPosCount", map);
		return list;
	}
	public HashMap<String, Object> getPos_one(String get_hq, String get_store, String get_pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("get_hq", get_hq);
		map.put("get_store", get_store);
		map.put("get_pos_no", get_pos_no);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getPos_one", map);
		
		return data;
	}
	public int useChk(String modify_hq, String modify_store, String modify_pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("modify_hq", modify_hq);
		map.put("modify_store", modify_store);
		map.put("modify_pos_no", modify_pos_no);
		
		int result = getSqlSession().selectOne(NS + ".useChk", map);
		return result;
	}
	public void delPos(String get_hq, String get_store, String get_pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("get_hq", get_hq);
		map.put("get_store", get_store);
		map.put("get_pos_no", get_pos_no);
		String sql = getSqlSession().getConfiguration().getMappedStatement(NS+".delPos").getBoundSql(map).getSql();
		List<ParameterMapping> parameterMappings = getSqlSession().getConfiguration().getMappedStatement(NS+".delPos").getBoundSql(map).getParameterMappings();
		for(ParameterMapping parameterMapping : parameterMappings) {
			String param = String.valueOf(map.get(parameterMapping.getProperty()));
			sql = sql.replaceFirst("\\?", "'" + param + "'");
		}
		System.out.println("SQL_query-------------"+sql);
		getSqlSession().delete(NS + ".delPos", map);
	}
	public void upPosStart(String store, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		getSqlSession().update(NS + ".upPosStart", map);
	}
	public void upPosEnd(String store, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		getSqlSession().update(NS + ".upPosEnd", map);
	}
	public int checkPos(String store, String pos, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("sale_ymd", sale_ymd);
		int cnt = getSqlSession().selectOne(NS + ".checkPos", map);
		return cnt;
	}
}
