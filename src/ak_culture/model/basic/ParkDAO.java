package ak_culture.model.basic;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.mapping.ParameterMapping;
import org.mybatis.spring.support.SqlSessionDaoSupport;

public class ParkDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/parkMapper";

	public List<HashMap<String, Object>> getPark(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String date_start, String date_end, String car_num, String mgmt_num, String park_info, String del_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("date_start", date_start);
		map.put("date_end", date_end);
		map.put("car_num", car_num);
		map.put("mgmt_num", mgmt_num);
		map.put("park_info", park_info);
		map.put("del_yn", del_yn);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPark", map);
		
		return list;
	}
	public List<HashMap<String, Object>> getParkCount(String store, String date_start, String date_end, String car_num, String mgmt_num, String park_info, String del_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("date_start", date_start);
		map.put("date_end", date_end);
		map.put("car_num", car_num);
		map.put("mgmt_num", mgmt_num);
		map.put("park_info", park_info);
		map.put("del_yn", del_yn);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getParkCount", map);
		return list;
	}
}
