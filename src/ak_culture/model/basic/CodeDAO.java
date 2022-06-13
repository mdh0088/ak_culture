package ak_culture.model.basic;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class CodeDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/codeMapper";
	
	public List<HashMap<String, Object>> getCodeList() {
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCodeList");
		return list;
	}
	
	public List<HashMap<String, Object>> getCode(String order_by,String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCode", map);
		return list;
	}
	public List<HashMap<String, Object>> getSubCode(String code_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("code_fg", code_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSubCode", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getLastCodeNum(String code_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("code_fg", code_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLastCodeNum", map);
		return list;
	}
	
	
	public void insCode(String main_code,String sub_code, String sub_code_title, String sub_code_cont, String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("code_fg", main_code);
		map.put("sub_code", sub_code);
		map.put("short_name", sub_code_title);
		map.put("long_name", sub_code_cont);
		map.put("create_resi_no",create_resi_no);

		getSqlSession().insert(NS + ".insCode", map);
	}
	
	public void insMainCode(String main_code,String main_code_nm, String main_code_cont,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("main_code", main_code);
		map.put("main_code_nm", main_code_nm);
		map.put("main_code_cont", main_code_cont);
		map.put("create_resi_no",create_resi_no);

		getSqlSession().insert(NS + ".insMainCode", map);
	}
	
	public void edit_sub_code(String code_fg,String edit_sub_code,String sub_code,String create_resi_no,String short_name, String long_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("code_fg", code_fg);
		map.put("edit_sub_code",edit_sub_code);
		map.put("sub_code", sub_code);
		map.put("create_resi_no", create_resi_no);
		map.put("short_name", short_name);
		map.put("long_name", long_name);

		getSqlSession().update(NS + ".edit_sub_code", map);
	}
	
	public void del_sub_code(String code_fg,String sub_code,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("code_fg", code_fg);
		map.put("sub_code", sub_code);
		map.put("create_resi_no", create_resi_no);


		getSqlSession().update(NS + ".del_sub_code", map);
	}
	
	public void upt_sub_code(String code_fg,String sub_code,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("code_fg", code_fg);
		map.put("sub_code", sub_code);
		map.put("create_resi_no", create_resi_no);


		getSqlSession().update(NS + ".upt_sub_code", map);
	}
	
}
