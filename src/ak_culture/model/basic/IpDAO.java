package ak_culture.model.basic;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class IpDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/ipMapper";
	public void insIp(String write_hq, String write_store, String write_ip, String write_pos_no, String write_autosign_port, String write_create_resi_no, String write_update_resi_no, String write_delete_yn, String write_status) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("write_hq", write_hq);
		map.put("write_store", write_store);
		map.put("write_ip", write_ip);
		map.put("write_pos_no", write_pos_no);
		map.put("write_autosign_port", write_autosign_port);
		map.put("write_create_resi_no", write_create_resi_no);
		map.put("write_update_resi_no", write_update_resi_no);
		map.put("write_delete_yn", write_delete_yn);
		map.put("write_status", write_status);
		
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAA"+map);
		getSqlSession().insert(NS + ".insIp", map);
	}
	public List<HashMap<String, Object>> getIp(int s_rownum, int e_rownum, String order_by, String sort_type, String search_name, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("store", store);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getIp", map);
		return list;
	}
	public HashMap<String, Object> getIp_one(String get_hq, String get_store, String get_ip) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("get_hq", get_hq);
		map.put("get_store", get_store);
		map.put("get_ip", get_ip);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getIp_one", map);
		return data;
	}
	public List<HashMap<String, Object>> getIpCount(String search_name, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getIpCount", map);
		return list;
	}
	public void upIp(String modify_hq, String modify_store, String modify_ip, String modify_pos_no, String modify_pos_print_yn, String modify_ppcard_print_yn, String modify_ppcard_port, String modify_autosign_port, String modify_update_resi_no, String modify_delete_yn, String modify_status, String get_hq, String get_store, String get_ip) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("modify_hq", modify_hq);
		map.put("modify_store", modify_store);
		map.put("modify_ip", modify_ip);
		map.put("modify_pos_no", modify_pos_no);
		map.put("modify_pos_print_yn", modify_pos_print_yn);
		map.put("modify_ppcard_print_yn", modify_ppcard_print_yn);
		map.put("modify_ppcard_port", modify_ppcard_port);
		map.put("modify_autosign_port", modify_autosign_port);
		map.put("modify_update_resi_no", modify_update_resi_no);
		map.put("modify_delete_yn", modify_delete_yn);
		map.put("modify_status", modify_status);
		
		map.put("get_hq", get_hq);
		map.put("get_store", get_store);
		map.put("get_ip", get_ip);

		getSqlSession().update(NS + ".upIp", map);
	}
	public void delete_yn(String get_hq, String get_store, String get_ip, String delete_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("get_hq", get_hq);
		map.put("get_store", get_store);
		map.put("get_ip", get_ip);
		map.put("delete_yn", delete_yn);
		
		getSqlSession().update(NS + ".upIp_delete_yn", map);
	}
	public int ipDup(String write_hq, String write_store, String write_ip) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("write_hq", write_hq);
		map.put("write_store", write_store);
		map.put("write_ip", write_ip);
		
		int result = getSqlSession().selectOne(NS + ".ipDup", map);
		
		return result;
	}
	public HashMap<String, Object> getPosnoByIp(String ip, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("ip", ip);
		map.put("store", store);
		return getSqlSession().selectOne(NS + ".getPosnoByIp", map);
	}
	public List<HashMap<String, Object>> getPos_no(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPos_no", map);
		return list;
	}
	public int login_ipCheck(String ip_addr) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("ip_addr", ip_addr);
		return getSqlSession().selectOne(NS + ".login_ipCheck", map);
	}
	
}
