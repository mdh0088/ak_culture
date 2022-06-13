package ak_culture.model.basic;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class EncdDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/encdMapper";
	
	public List<HashMap<String, Object>> getEncdCount(String store, String period,String search_name,String search_con,String start_day,String end_day,String cust_fg,String encd_list) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		map.put("search_con", search_con);
		map.put("start_day", start_day);
		map.put("end_day", end_day);
		map.put("cust_fg", cust_fg);
		map.put("encd_list", encd_list);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncdCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getEncd(String store, String period,String search_name,String search_con,String start_day,String end_day,String cust_fg,String encd_list,
			int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		map.put("search_con", search_con);
		map.put("start_day", start_day);
		map.put("end_day", end_day);
		map.put("cust_fg", cust_fg);
		map.put("encd_list", encd_list);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncd", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getEncdListCount(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("store", store);
		map.put("period", period);

		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncdListCount", map);
		return list;
	}	
	
	/*
	public List<HashMap<String, Object>> getNewDisCode(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getNewDisCode", map);
		return list;
	}	
	*/
	
	public List<HashMap<String, Object>> getEncdList(String store, String period,int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("store", store);
		map.put("period", period);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncdList", map);
		return list;
	}
	
	
	
	public List<HashMap<String, Object>> getEncdCode(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncdCode", map);
		return list;
	}
	
//	public List<HashMap<String, Object>> getEncdCustList(String selBranch, String main_cd, String sect_cd, String lect_cd, String start_day, String end_day) {
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("selBranch", selBranch);
//		map.put("main_cd", main_cd);
//		map.put("sect_cd", sect_cd);
//		map.put("lect_cd", lect_cd);
//		map.put("start_day", start_day)
//		map.put("end_day", end_day);
//		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncdCustList", map);
//		return list;
//	}
	public List<HashMap<String, Object>> getNewDisCode(String store,String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getNewDisCode", map);
		return list;
	}
	
	public void insEncdM(	String store,				String enuri_cd,				String encd_fg,
							String enuri,				String new_encd_nm,				String encd_limit_pay,
							String create_resi_no,		String encd_limit_cnt,			String discount_period_start,
							String fee_yn,				String dupl_yn,					String discount_period_end,
							String period,				String lect_type,				String lect_main_cd,
							String lect_sect_cd,		String lect_subject_cd,			String give_fg) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("enuri_cd", enuri_cd);
		map.put("encd_fg", encd_fg);
		map.put("enuri", enuri);
		map.put("new_encd_nm", new_encd_nm);
		map.put("encd_limit_pay", encd_limit_pay);
		map.put("create_resi_no", create_resi_no);
		map.put("encd_limit_cnt", encd_limit_cnt);
		map.put("discount_period_start", discount_period_start);
		map.put("fee_yn", fee_yn);
		map.put("dupl_yn", dupl_yn);
		map.put("discount_period_end", discount_period_end);
		map.put("period", period);
		map.put("lect_type", lect_type);
		map.put("lect_main_cd", lect_main_cd);
		map.put("lect_sect_cd", lect_sect_cd);
		map.put("lect_subject_cd", lect_subject_cd);
		map.put("give_fg", give_fg);
		
		getSqlSession().insert(NS + ".insEncdM", map);
	}
	
	
	public List<HashMap<String, Object>> getCustList( 		String store, 					String period,			 
															String con1_subject_fg_a, 		String con1_subject_fg_b, 			String con1_subject_fg_c, 	
															String cust_fg, 				int lect_cnt, 						int semester_cnt, 
															String choose_val){
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("con1_subject_fg_a", con1_subject_fg_a);
		map.put("con1_subject_fg_b", con1_subject_fg_b);
		map.put("con1_subject_fg_c", con1_subject_fg_c);
		map.put("cust_fg", cust_fg);
		map.put("lect_cnt", lect_cnt);
		map.put("semester_cnt", semester_cnt);
		map.put("choose_val", choose_val);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustList", map);
		return list;
		}
	
	
	
	public HashMap<String, Object> encd_dupl_chk(String store, String period, String cust_no,String enuri_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("enuri_cd", enuri_cd);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".encd_dupl_chk", map);
		return data;
	}
	
	public List<HashMap<String, Object>> getTargetCustList( String store, 
															String year, 		String season, 			String main_cd, 	
															String sect_cd, 	String enuri_cd, 		String subject_fg, 
															String cust_fg,		String lect_cnt, 		int semester_cnt,	String periList,
															String period,		String cust_list_grade,	String cust_list,	String give_type,
															String subject_cd){
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("year", year);
		map.put("season", season);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("subject_cd", subject_cd);
		
		map.put("enuri_cd", enuri_cd);
		
		map.put("subject_fg", subject_fg);
		map.put("cust_fg", cust_fg);
		map.put("lect_cnt", lect_cnt);
		map.put("semester_cnt", semester_cnt);
		map.put("periList", periList);
		map.put("period", period);
		map.put("cust_list_grade", cust_list_grade);
		map.put("cust_list", cust_list);
		map.put("give_type", give_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTargetCustList", map);
		return list;
	}	

	
	public void updateEncdM(	String store,			String period,					String enuri_cd,
								String lect_type,		String lect_main_cd,			String lect_sect_cd,
								String lect_subject_cd,	String discount_period_start, 	String discount_period_end,
								String enuri,			String encd_limit_pay,			String encd_limit_cnt,
								String dupl_yn,			String fee_yn,					String create_resi_no,
								String encd_fg,			String give_fg
						) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("enuri_cd", enuri_cd);
		
		map.put("lect_type", lect_type);
		map.put("lect_main_cd", lect_main_cd);
		map.put("lect_sect_cd", lect_sect_cd);
		map.put("lect_subject_cd", lect_subject_cd);
		map.put("discount_period_start", discount_period_start);
		map.put("discount_period_end", discount_period_end);
		map.put("enuri", enuri);
		map.put("encd_limit_pay", encd_limit_pay);
		map.put("encd_limit_cnt", encd_limit_cnt);
		map.put("dupl_yn", dupl_yn);
		map.put("fee_yn", fee_yn);
		map.put("create_resi_no", create_resi_no);
		map.put("encd_fg", encd_fg);
		map.put("give_fg", give_fg);
		
		getSqlSession().update(NS + ".updateEncdM", map);
	}
	
	public void uptEncdMForGrade(	String store,			String period,				String enuri_cd,
									String subject_fg,		String cust_fg,				int lect_cnt,
									int semester_cnt,		String choose_val	) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("enuri_cd", enuri_cd);
		map.put("subject_fg", subject_fg);
		map.put("cust_fg", cust_fg);
		map.put("lect_cnt", lect_cnt);
		map.put("semester_cnt", semester_cnt);
		map.put("choose_val", choose_val);
		
		getSqlSession().update(NS + ".uptEncdMForGrade", map);
	}
	
	
	public void insEncd(String store,String period, String enuri_cd, String create_resi_no,String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("enuri_cd", enuri_cd);
		map.put("create_resi_no",create_resi_no);
		map.put("cust_no",cust_no);
		
		getSqlSession().insert(NS + ".insEncd", map);
	}

	
	
	public List<HashMap<String, Object>> getEncdInfo(String store,String period,String enuri_cd,String enuri_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("enuri_cd", enuri_cd);
		map.put("enuri_nm", enuri_nm);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncdInfo", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getPeriListForEncd(String store,String semester_cnt) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("semester_cnt", semester_cnt);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeriListForEncd", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getEncdListByList(String store,String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEncdListByList", map);
		return list;
	}
	
	public int delEncd(String store,String period,String enuri_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("enuri_cd", enuri_cd);
		return getSqlSession().delete(NS + ".delEncd", map);
	}
	
	public List<HashMap<String, Object>> getBfperi(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getBfperi", map);
		return list;
	}
	
	public int insPreEncd(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().insert(NS + ".insPreEncd", map);
		}

}
