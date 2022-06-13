package ak_culture.model.basic;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class GiftDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/giftMapper";
	
	public List<HashMap<String, Object>> getGiftCount(String store,String period,String search_start,String search_end,String gubun,String gift_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("gubun", gubun);
		map.put("gift_fg", gift_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGiftCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGiftList(String store,String period,String search_start,String search_end,String gubun,String gift_fg, 
			int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("store", store);
		map.put("period", period);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("gubun", gubun);
		map.put("gift_fg", gift_fg);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGiftList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGiftCustCount(String store,String period,String start_ymd, String end_ymd, String search_type, String search_name,
			String gift_status ,String gift_fg, String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("gift_status", gift_status);
		map.put("gift_fg", gift_fg);
		map.put("gift_cd", gift_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGiftCustCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getCustGiftList(String store,String period,String start_ymd,String end_ymd,String search_type,String search_name, String gift_status , String gift_fg , String gift_cd,
			int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("store", store);
		map.put("period", period);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("gift_status", gift_status);
		map.put("gift_fg", gift_fg);
		map.put("gift_cd", gift_cd);
		
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustGiftList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> changeGift(String store,String period,String gift_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_fg", gift_fg);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".changeGift", map);
		return list;
	}
	public List<HashMap<String, Object>> getNewSubCode(String store, String period,String code_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("code_fg", code_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getNewSubCode", map);
		return list;
	}
	
	/////
	
	public void insGiftM(	String store,				String period,					String gift_fg,
							String gift_price,			String gift_cd,					String start_ymd,
							String end_ymd,				String gift_cnt_w,				String gift_cnt_m,
							String gift_cnt_d,			String return_fg,				String create_resi_no,
							String gift_cnt_t,			String new_gift_nm,				String give_type,
							String give_fg) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_fg", gift_fg);
		map.put("gift_price", gift_price);
		map.put("gift_cd", gift_cd);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("gift_cnt_w", gift_cnt_w);
		map.put("gift_cnt_m", gift_cnt_m);
		map.put("gift_cnt_d", gift_cnt_d);
		map.put("return_fg", return_fg);
		map.put("create_resi_no", create_resi_no);
		map.put("gift_cnt_t", gift_cnt_t);
		map.put("new_gift_nm", new_gift_nm);
		map.put("give_type", give_type);
		map.put("give_fg", give_fg);
	
		
		
		getSqlSession().insert(NS + ".insGiftM", map);
		}
	
	public void updateGiftM(	String store,			String period,				String gift_cd,
			
								String gift_price,		String gift_date_yn,		String start_ymd,
								String end_ymd,			String accept_type, 		String gift_cnt_t,
								String gift_cnt_w,		String gift_cnt_m,			String gift_cnt_d,
								String return_fg,		String create_resi_no,		String give_type,
								String give_fg) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_cd", gift_cd);
		map.put("gift_price", gift_price);
		map.put("gift_date_yn", gift_date_yn);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("accept_type", accept_type);
		map.put("gift_cnt_t", gift_cnt_t);
		map.put("gift_cnt_w", gift_cnt_w);
		map.put("gift_cnt_m", gift_cnt_m);
		map.put("gift_cnt_d", gift_cnt_d);
		map.put("return_fg", return_fg);
		map.put("create_resi_no", create_resi_no);
		map.put("give_type", give_type);
		map.put("give_fg", give_fg);
		
		getSqlSession().update(NS + ".updateGiftM", map);
		}	
	
	public void uptGiftMForGrade(	String store,			String period,				String gift_cd,
									String subject_fg,		String cust_fg,				int lect_cnt,
									int semester_cnt,		String choose_val	) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_cd", gift_cd);
		map.put("subject_fg", subject_fg);
		map.put("cust_fg", cust_fg);
		map.put("lect_cnt", lect_cnt);
		map.put("semester_cnt", semester_cnt);
		map.put("choose_val", choose_val);
		
		getSqlSession().update(NS + ".uptGiftMForGrade", map);
	}
	
	public HashMap<String, Object> gift_dupl_chk(String store, String period, String cust_no,String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("gift_cd", gift_cd);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".gift_dupl_chk", map);
		return data;
	}
	
	public int chk_left_cnt(String store, String period, String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_cd", gift_cd);
		int data = getSqlSession().selectOne(NS + ".chk_left_cnt", map);
		return data;
	}
	
	public void addGiftCode(String code_fg,String sub_code,String new_sub_code,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("code_fg", code_fg);
		map.put("sub_code", sub_code);
		map.put("new_sub_code", new_sub_code);
		map.put("create_resi_no", create_resi_no);


		getSqlSession().insert(NS + ".addGiftCode", map);
	}
	
	public void insGift(String store,String period, String cust_no, String gift_cd,String create_resi_no,String pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no",cust_no);
		map.put("gift_cd", gift_cd);
		map.put("create_resi_no",create_resi_no);
		map.put("pos_no",pos_no);
		getSqlSession().insert(NS + ".insGift", map);
	}
	
	public void insGiftForTarget(String store,String period, String cust_no, String gift_cd,String create_resi_no,String pos_no,String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no",cust_no);
		map.put("gift_cd", gift_cd);
		map.put("create_resi_no",create_resi_no);
		map.put("pos_no", pos_no);
		map.put("subject_cd", subject_cd);
		
		getSqlSession().insert(NS + ".insGiftForTarget", map);
	}
	
	public void UptGiftForTarget(String store,String period, String cust_no, String gift_cd,String create_resi_no,String pos_no,String subject_cd) {

		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no",cust_no);
		map.put("gift_cd", gift_cd);
		map.put("create_resi_no",create_resi_no);
		map.put("pos_no", pos_no);
		map.put("subject_cd", subject_cd);
		
		getSqlSession().update(NS + ".UptGiftForTarget", map);
	}
	
	public List<HashMap<String, Object>> getPeriList(String semester_cnt) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("semester_cnt", semester_cnt);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeriList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getCustInfo(String cust_list, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_list", cust_list);
		map.put("subject_fg", subject_fg);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCustInfo", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGiftInfo(String store, String period, String gift_cd, String gift_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_cd",gift_cd);
		map.put("gift_nm", gift_nm);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGiftInfo", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getNewGiftCode(String store,String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getNewGiftCode", map);
		return list;
	}
	
	public void insGiftHistory(String store, String period,String cust_no, String cust_fg,String code_fg,String sub_code,String gift_price, String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("cust_fg", cust_fg);
		map.put("code_fg", code_fg);
		map.put("sub_code", sub_code);
		map.put("gift_price", gift_price);
		map.put("create_resi_no", create_resi_no);

		getSqlSession().insert(NS + ".insGiftHistory", map);
	}
	
	public int updateContent(String store, String period,String cust_no, String gift_cd,String contents) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("gift_cd", gift_cd);
		map.put("contents", contents);
		return getSqlSession().update(NS + ".updateContent", map);
	}

	

	
	public int upGiftEnd(String store, String period,String act,String cust_no, String gift_cd,String pos_no, String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("act", act);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("gift_cd", gift_cd);
		map.put("pos_no", pos_no);
		map.put("create_resi_no", create_resi_no);
		return getSqlSession().update(NS + ".upGiftEnd", map);
	}
	
	public int delGift(String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("gift_cd", gift_cd);
		return getSqlSession().delete(NS + ".delGift", map);
	}
	
	
	public HashMap<String, Object> getTotCnt(String store,String period,String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_cd", gift_cd);
		return getSqlSession().selectOne(NS + ".getTotCnt", map);
	}
	
	public HashMap<String, Object> getGiveCnt(String store,String period,String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_cd", gift_cd);
		return getSqlSession().selectOne(NS + ".getGiveCnt", map);
	}
	
}
