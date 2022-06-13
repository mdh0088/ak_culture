package ak_culture.model.member;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class CustDAO extends SqlSessionDaoSupport{
	
	private String NS = "/member/custMapper";
	
	public List<HashMap<String, Object>> getCustCount(String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getAddr_si() {
		HashMap<String, Object> map = new HashMap<>();
	
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAddr_si", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getAddr(String start, String end, String addr) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("addr", addr);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAddr", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getCust(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCust", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getCustListCount(HashMap<String, Object> param) {
		System.out.println(param);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustListCount", param);
		return list;
	}
	
	public List<HashMap<String, Object>> getCustList(HashMap<String, Object> param) {
		System.out.println(param);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustList", param);
		return list;
	}
	
	public List<HashMap<String, Object>> getCustListCount02(HashMap<String, Object> param) {
		System.out.println(param);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustListCount02", param);
		return list;
	}
	
	public List<HashMap<String, Object>> getCustList02(HashMap<String, Object> param) {
		System.out.println(param);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustList02", param);
		return list;
	}
	public List<HashMap<String, Object>> getCustList03(String selBranch,String selPeri,String main_cd,String sect_cd,String subject_cd,String dupl_cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		map.put("selPeri", selPeri);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("subject_cd", subject_cd);
		map.put("dupl_cus_no", dupl_cus_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustList03", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getLecr(String search_name, String store, String start_point, String end_point, String start_peri, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("start_point", start_point);
		map.put("end_point", end_point);
		map.put("start_peri", start_peri);
		map.put("subject_fg", subject_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecr", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getUser_byPhone_Last(String phone) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("phone", phone);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUser_byPhone_Last", map);
		return list;
	}
	public HashMap<String, Object> getUserByMembers(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getUserByMembers", map);
		return data;
	}
	public List<HashMap<String, Object>> getUserListByMembers(String phone) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("phone", phone);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUserListByMembers", map);
		return list;
	}
	
	public List<HashMap<String, Object>> userSearch(String searchType, String searchVal,String  user_name,String  birth) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchVal", searchVal);
		map.put("user_name", user_name);
		map.put("birth", birth);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".userSearch", map);
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
	
	public void insCust(
							String cust_no,String kor_nm, String eng_nm, String birth_ymd, String marry_fg, String marry_ymd, String sex_fg,String post_no1,
							String post_no2, String addr_tx1, String addr_tx2, String addr_tx, String phone_no1, String phone_no2, String phone_no3,String email_addr, 
							String email_yn, String sms_yn,String ptl_id, String ptl_pw, String cus_no, String ms_fg, String di, String ci,String create_resi_no,
							String create_date ,String car_no, String h_phone_no_1, String h_phone_no_2, String h_phone_no_3, String point_no
						) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
//		map.put("hq", hq);
//		map.put("store", store);
		map.put("kor_nm", kor_nm);
		map.put("eng_nm", eng_nm);
		map.put("birth_ymd", birth_ymd);
		map.put("marry_fg", marry_fg);
		map.put("marry_ymd", marry_ymd);
		map.put("sex_fg", sex_fg);
		map.put("post_no1", post_no1);
		map.put("post_no2", post_no2);
		map.put("addr_tx1", addr_tx1);
		map.put("addr_tx2", addr_tx2);
		map.put("addr_tx", addr_tx);
		map.put("phone_no1", phone_no1);
		map.put("phone_no2", phone_no2);
		map.put("phone_no3", phone_no3);
		map.put("email_addr", email_addr);
		map.put("email_yn", email_yn);
		map.put("sms_yn", sms_yn);
		map.put("ptl_id", ptl_id);
		map.put("ptl_pw", ptl_pw);
		map.put("cus_no", cus_no);
		map.put("ms_fg", ms_fg);
		map.put("di", di);
		map.put("ci", ci);
		map.put("create_resi_no",create_resi_no);
		map.put("create_date",create_date);
		map.put("car_no", car_no);
		map.put("h_phone_no_1", h_phone_no_1);
		map.put("h_phone_no_2", h_phone_no_2);
		map.put("h_phone_no_3", h_phone_no_3);
		map.put("point_no", point_no);

		getSqlSession().insert(NS + ".insCust", map);
	}
	
	public HashMap<String, Object> getCust_seq(String period) {
	      HashMap<String, Object> map = new HashMap<>();
	      map.put("period", period);
	      HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getCust_seq", map);
	      return data;
	}
	
	public HashMap<String, Object> getPeri_no() {
	      HashMap<String, Object> map = new HashMap<>();
	      HashMap<String, Object> peri_data = getSqlSession().selectOne(NS + ".getPeri_no", map);
	      return peri_data;
	}
	
	public List<HashMap<String, Object>> getMemo(String cust_no,String order_by,String sort_type,int listSize) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("listSize", listSize);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMemo", map);
		return list;
	}
	
public List<HashMap<String, Object>> getLectInfo(String cust_no,String store,String period,String listener,String order_by,String sort_type) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("store", store);
		map.put("period", period);
		map.put("listener", listener);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectInfo", map);
		return list;
	}
public List<HashMap<String, Object>> getLectInfo_mem(String cust_no,String store,String period,String listener,String order_by,String sort_type,String start_peri, String end_peri) {
	
	HashMap<String, Object> map = new HashMap<>();
	map.put("cust_no", cust_no);
	map.put("store", store);
	map.put("period", period);
	map.put("listener", listener);
	map.put("order_by", order_by);
	map.put("sort_type", sort_type);
	map.put("start_peri", start_peri);
	map.put("end_peri", end_peri);
	
	List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectInfo_mem", map);
	return list;
}
	
	
	
	public List<HashMap<String, Object>> getSmsInfo(String cust_no) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsInfo", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getChildInfo(String cust_no) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getChildInfo", map);
		return list;
	}
	
	
	
	public List<HashMap<String, Object>> getTmList(String cust_no,String kor_nm,String start_day,String end_day,String chk_myself,
			String recall_yn,String order_by,String sort_type,int listSize) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("kor_nm", kor_nm);
		map.put("start_day", start_day);
		map.put("end_day",  end_day);
		map.put("chk_myself", chk_myself);
		map.put("recall_yn", recall_yn);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("listSize", listSize);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTmList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getSmsList(String cust_no,String kor_nm,String start_day,String end_day,String send_type,String send_state,String order_by,String sort_type, int listSize) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("kor_nm", kor_nm);
		map.put("start_day", start_day);
		map.put("end_day", end_day);
		map.put("send_type", send_type);
		map.put("send_state",send_state);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("listSize",listSize);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSmsList", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getCustHistory(String cust_no,String order_by,String sort_type,int listSize) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("listSize", listSize);

		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustHistory", map);
		return list;
	}
	
	public void ins_memo(String cust_no,String memo_cont,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("memo_cont", memo_cont);
		map.put("create_resi_no",create_resi_no);


		getSqlSession().insert(NS + ".ins_memo", map);
	}
	
	public void addChangeHistory(String cust_no,String ip,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("ip", ip);
		map.put("create_resi_no",create_resi_no);


		getSqlSession().insert(NS + ".addChangeHistory", map);
	}

	
	public void remove_child(String cust_no,String child_num,String update_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("child_num", child_num);
		map.put("update_resi_no",update_resi_no);


		getSqlSession().update(NS + ".remove_child", map);
	}
	public void uptCarNo(String cust_no,String car_no, String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("car_no", car_no);
		map.put("update_resi_no",create_resi_no);


		getSqlSession().update(NS + ".uptCarNo", map);
	}
	
	public int delChild(String cust_no,String child_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("child_no", child_no);

		return getSqlSession().update(NS + ".delChild", map);
	}
	
	public int delMemo(String memo,String memo_date) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("memo", memo);
		map.put("memo_date", memo_date);

		return getSqlSession().delete(NS + ".delMemo", map);
	}

	public List<HashMap<String, Object>> getCusnoAll() {
		return getSqlSession().selectList(NS + ".getCusnoAll");
	}
	public List<HashMap<String, Object>> getCusnoByChild() {
		return getSqlSession().selectList(NS + ".getCusnoByChild");
	}
	public List<HashMap<String, Object>> getCustnoByCusno(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		return getSqlSession().selectList(NS + ".getCustnoByCusno", map);
	}
	
	public List<HashMap<String, Object>> getLectList(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectList(NS + ".getLectList", map);
	}
	
	public List<HashMap<String, Object>> getCustForAttend(String store, String period,String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectList(NS + ".getCustForAttend", map);
	}

	public void updateCust_pere(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_pere", map);
	}
	public void updateCust_sign(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_sign", map);
	}
	public void updateCust_temp(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_temp", map);
	}
	public void updateCust_smsl(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_smsl", map);
	}
	public void updateCust_wait(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_wait", map);
	}
	public void updateCust_free(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_free", map);
	}
	public void updateCust_wbtr(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_wbtr", map);
	}
	public void updateCust_mail(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_mail", map);
	}
	public void updateCust_trms(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_trms", map);
	}
	public void updateCust_deci(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_deci", map);
	}
	public void updateCust_park(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_park", map);
	}
	public void updateCust_kids(String cus_no, String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("cust_no", cust_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateCust_kids", map);
	}

	public void insChildByCust(String p_cust_no, int child_no, String gender, String birth_ymd, String kor_nm, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", p_cust_no);
		map.put("child_no", child_no);
		map.put("gender", gender);
		map.put("birth", birth_ymd.replaceAll("-", ""));
		map.put("child_nm", kor_nm);
		map.put("store", store);
		getSqlSession().update(NS + ".insChildByCust", map);
	}

	public void updateChild_pere(String p_cust_no, String c_cust_no, int child_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("p_cust_no", p_cust_no);
		map.put("c_cust_no", c_cust_no);
		map.put("child_no", child_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateChild_pere", map);
	}
	public void updateChild_wbtr(String p_cust_no, String c_cust_no, int child_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("p_cust_no", p_cust_no);
		map.put("c_cust_no", c_cust_no);
		map.put("child_no", child_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateChild_wbtr", map);
	}
	
	public void updateChild_wait(String p_cust_no, String c_cust_no, int child_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("p_cust_no", p_cust_no);
		map.put("c_cust_no", c_cust_no);
		map.put("child_no", child_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateChild_wait", map);
	}
	
	public void updateChild_free(String p_cust_no, String c_cust_no, int child_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("p_cust_no", p_cust_no);
		map.put("c_cust_no", c_cust_no);
		map.put("child_no", child_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateChild_free", map);
	}
	
	public void updateChild_deci(String p_cust_no, String c_cust_no, int child_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("p_cust_no", p_cust_no);
		map.put("c_cust_no", c_cust_no);
		map.put("child_no", child_no);
		map.put("store", store);
		getSqlSession().update(NS + ".updateChild_deci", map);
	}
	

	public void insNewCust(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		getSqlSession().insert(NS + ".insNewCust", map);
	}

	public List<HashMap<String, Object>> getCustListOld(String searchPhone, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchPhone", searchPhone);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		return getSqlSession().selectList(NS + ".getCustListOld", map);
	}
	public List<HashMap<String, Object>> getAmsListOld(String searchPhone, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchPhone", searchPhone);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		return getSqlSession().selectList(NS + ".getAmsListOld", map);
	}

	public int upCusByCust(String store, String cust_no, String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		map.put("cus_no", cus_no);
		return getSqlSession().update(NS + ".upCusByCust", map);
	}

	public List<HashMap<String, Object>> cust_pere_list(String cust_no, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		return getSqlSession().selectList(NS + ".cust_pere_list", map);
	}

	public int getPereByChild(String cust_no, String child_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("child_no", child_no);
		return getSqlSession().selectOne(NS + ".getPereByChild", map);
	}
	
	
}
