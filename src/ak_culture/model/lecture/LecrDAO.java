package ak_culture.model.lecture;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import ak_culture.classes.EPApproval;
import ak_culture.classes.Utils;

public class LecrDAO extends SqlSessionDaoSupport{
	
	private String NS = "/lecture/lecrMapper";
	
	public List<HashMap<String, Object>> getLecrCount(String search_name, String store, String start_point, String end_point, String start_peri, String end_peri, String subject_fg, String status_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("start_point", start_point);
		map.put("end_point", end_point);
		map.put("start_peri", start_peri);
		map.put("end_peri", end_peri);
		map.put("subject_fg", subject_fg);
		map.put("status_fg", status_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getLecr(int s_rownum, int e_rownum, String order_by, String sort_type, String search_name, String store, String start_point, String end_point, String start_peri, String end_peri, String subject_fg, String status_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("start_point", start_point);
		map.put("end_point", end_point);
		map.put("start_peri", start_peri);
		map.put("end_peri", end_peri);
		map.put("subject_fg", subject_fg);
		map.put("status_fg", status_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecr", map);
		return list;
	}
	public HashMap<String, Object> getLecrOne(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		return getSqlSession().selectOne(NS + ".getLecrOne", map);
	}
	public List<HashMap<String, Object>> getLepoByCust(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLepoByCust", map);
		return list;
	}
	public List<HashMap<String, Object>> getLecrByCust(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrByCust", map);
		return list;
	}
	public void insLecr(String lecturer_cd, String lecturer_kor_nm, String corp_fg, String biz_no, String bank_cd, String account_nm, String account_no,
			String biz_nm, String president_nm, String industry_c, String industry_s, String biz_post_no, String biz_addr, String biz_addr_tx1, String biz_addr_tx2, String login_seq, String rep_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		map.put("lecturer_kor_nm", lecturer_kor_nm);
		map.put("corp_fg", corp_fg);
		map.put("biz_no", biz_no);
		map.put("bank_cd", bank_cd);
		map.put("account_nm", account_nm);
		map.put("account_no", account_no);
		map.put("biz_nm", biz_nm);
		map.put("president_nm", president_nm);
		map.put("industry_c", industry_c);
		map.put("industry_s", industry_s);
		map.put("biz_post_no", biz_post_no);
		map.put("biz_addr", biz_addr);
		map.put("biz_addr_tx1", biz_addr_tx1);
		map.put("biz_addr_tx2", biz_addr_tx2);
		map.put("login_seq", login_seq);
		map.put("rep_store", rep_store);
		
		getSqlSession().update(NS + ".insLecr", map);
		
	}
	public void insLecture(String lecturer_cd, String cus_no, String car_no, String point_1, String point_2, String point_3, String point_4, String point_5,
			String school, String school_cate, String start_ymd, String end_ymd, String history, String other, String point, String login_seq, String rep_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		map.put("cus_no", cus_no);
		map.put("car_no", car_no);
		map.put("point_1", point_1);
		map.put("point_2", point_2);
		map.put("point_3", point_3);
		map.put("point_4", point_4);
		map.put("point_5", point_5);
		map.put("school", school);
		map.put("school_cate", school_cate);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("history", history);
		map.put("other", other);
		map.put("point", point);
		map.put("login_seq", login_seq);
		map.put("rep_store", rep_store);
		
		getSqlSession().insert(NS + ".insLecture", map);
		
	}
	public void insACBI(String id_reg, String hq, String lecturer_cd){
		HashMap<String, Object> map = new HashMap<>();
		map.put("id_reg", id_reg);
		map.put("hq", hq);
		map.put("lecturer_cd", lecturer_cd);
		getSqlSession().insert(NS + ".insACBI", map);
	}
	public List<HashMap<String, Object>> getLecrPointCount(String search_type, String search_name, String corp_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("corp_fg", corp_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrPointCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getLecrPoint(int s_rownum, int e_rownum, String order_by, String sort_type, String search_type, String search_name, String corp_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("corp_fg", corp_fg);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrPoint", map);
		return list;
	}
	public List<HashMap<String, Object>> getLecrDetail(String cus_no, String store, String start_peri, String end_peri, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("store", store);
		map.put("start_peri", start_peri);
		map.put("end_peri", end_peri);
		map.put("subject_fg", subject_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrDetail", map);
		return list;
	}
	public HashMap<String, Object> getLectCountByLecr(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getLectCountByLecr", map);
		return data;
	}
	public List<HashMap<String, Object>> getLectListByLecrCount(String store, String period, String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cus_no", cus_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectListByLecrCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getLectListByLecr(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("cus_no", cus_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectListByLecr", map);
		return list;
	}
	public void ins_memo(String cus_no,String memo_cont,String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("memo_cont", memo_cont);
		map.put("login_seq",login_seq);
		getSqlSession().insert(NS + ".ins_memo", map);
	}
	
	public void del_memo(String cus_no,String reg_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("reg_no", reg_no);
		
		getSqlSession().delete(NS + ".del_memo", map);
	}
	
	
	public List<HashMap<String, Object>> getMemo(String cus_no) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMemo", map);
		return list;
	}
	public List<HashMap<String, Object>> getApplyListCount(String store,String aply_type,String search_type, String search_name, String start_ymd,String end_ymd,String status) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("aply_type", aply_type);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("status", status);

		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getApplyListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getApplyList(int s_rownum, int e_rownum, String order_by, String sort_type, String store,String aply_type,String search_type, String search_name, String start_ymd,String end_ymd,String status) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("aply_type", aply_type);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("status", status);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getApplyList", map);
		return list;
	}
	public HashMap<String, Object> getReview(String cust_no,String reg_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("reg_no", reg_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getReview", map);
		return data;
	}
	public int saveReview(String cust_no,String reg_no, String review) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("reg_no", reg_no);
		map.put("review", review);
		return getSqlSession().insert(NS + ".saveReview", map);
	}
	public void upLecr(String lecturer_cd, String lecturer_kor_nm, String corp_fg, String biz_no, String bank_cd, String account_nm, String account_no,
			String biz_nm, String president_nm, String industry_c, String industry_s, String biz_post_no, String biz_addr, String biz_addr_tx1, String biz_addr_tx2, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		map.put("lecturer_kor_nm", lecturer_kor_nm);
		map.put("corp_fg", corp_fg);
		map.put("biz_no", biz_no);
		map.put("bank_cd", bank_cd);
		map.put("account_nm", account_nm);
		map.put("account_no", account_no);
		map.put("biz_nm", biz_nm);
		map.put("president_nm", president_nm);
		map.put("industry_c", industry_c);
		map.put("industry_s", industry_s);
		map.put("biz_post_no", biz_post_no);
		map.put("biz_addr", biz_addr);
		map.put("biz_addr_tx1", biz_addr_tx1);
		map.put("biz_addr_tx2", biz_addr_tx2);
		map.put("login_seq", login_seq);
		
		getSqlSession().update(NS + ".upLecr", map);
		
	}
	public List<HashMap<String, Object>> getLectListByLecr2(String cus_no, String store, String start_peri, String end_peri) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("store", store);
		map.put("start_peri", start_peri);
		map.put("end_peri", end_peri);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectListByLecr2", map);
		return list;
	}
	public List<HashMap<String, Object>> getTax(String store, String period, String lecturer_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lecturer_nm", lecturer_nm);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTax", map);
		return list;
	}
	public List<HashMap<String, Object>> getTaxDetail(String store, String period, String lecturer_cd, String subject_cd, String tb) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lecturer_cd", lecturer_cd);
		map.put("subject_cd", subject_cd);
		map.put("tb", tb);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTaxDetail", map);
		return list;
	}
	public List<HashMap<String, Object>> getLectPayCount(String store, String period, String start_ymd, String end_ymd, String subject_fg, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("subject_fg", subject_fg);
		map.put("isPerformance", isPerformance);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectPayCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getLectPay(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String start_ymd, String end_ymd, String subject_fg, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("subject_fg", subject_fg);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectPay", map);
		return list;
	}
	
	public int get_passReslt(String cust_no,String passValue, String reg_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("passValue", passValue);
		map.put("reg_no", reg_no);
		return getSqlSession().update(NS + ".get_passReslt", map);
	}
	
	public int get_passReslt2(String cust_no,String reg_no, String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("reg_no", reg_no);
		map.put("create_resi_no", create_resi_no);
		return  getSqlSession().update(NS + ".get_passReslt2", map);		
	}
	
	public HashMap<String, Object> getLectureDetail(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		return getSqlSession().selectOne(NS + ".getLectureDetail", map);
	}
	public int selLecrCnt(String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		return getSqlSession().selectOne(NS + ".selLecrCnt", map);
	}
	
	public List<HashMap<String, Object>> getContractCount(String store,String period,String search_type, String search_name,
														String subject_fg,String contract_type01,String contract_type02,String contract_type03,String contract_type04) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("contract_type01", contract_type01);
		map.put("contract_type02", contract_type02);
		map.put("contract_type03", contract_type03);
		map.put("contract_type04", contract_type04);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getContractCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getContract(int s_rownum, int e_rownum, String order_by, String sort_type, String search_type, String search_name, 
													String store, String period,String subject_fg,String contract_type01,String contract_type02,
													String contract_type03,String contract_type04) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("contract_type01", contract_type01);
		map.put("contract_type02", contract_type02);
		map.put("contract_type03", contract_type03);
		map.put("contract_type04", contract_type04);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getContract", map);
		return list;
	}
	public List<HashMap<String, Object>> getLecrToLine(String searchLecr) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("searchLecr", searchLecr);
		return getSqlSession().selectList(NS + ".getLecrToLine", map);
	}
	public void upLecture(String lecturer_cd, String cus_no, String car_no, String point_1, String point_2, String point_3, String point_4, String point_5,
			String school, String school_cate, String start_ymd, String end_ymd, String history, String other, String point, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		map.put("cus_no", cus_no);
		map.put("car_no", car_no);
		map.put("point_1", point_1);
		map.put("point_2", point_2);
		map.put("point_3", point_3);
		map.put("point_4", point_4);
		map.put("point_5", point_5);
		map.put("school", school);
		map.put("school_cate", school_cate);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("history", history);
		map.put("other", other);
		map.put("point", point);
		map.put("login_seq", login_seq);
		
		getSqlSession().update(NS + ".upLecture", map);
		
	}
	public void upLecture_point(String cus_no, String point_1, String point_2, String point_3, String point_4, String point_5,
			String school, String school_cate, String start_ymd, String end_ymd, String history, String other, String point, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("point_1", point_1);
		map.put("point_2", point_2);
		map.put("point_3", point_3);
		map.put("point_4", point_4);
		map.put("point_5", point_5);
		map.put("school", school);
		map.put("school_cate", school_cate);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("history", history);
		map.put("other", other);
		map.put("point", point);
		map.put("login_seq", login_seq);
		
		getSqlSession().update(NS + ".upLecture_point", map);
		
	}

	
	public HashMap<String, Object> getapplicntInfo(String store,String period,String subject_cd,String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cus_no", cus_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getapplicntInfo", map);
		return data;
	}
	
	public int uptContract(String store,String period,String subject_cd,String cus_no,String contract_start,
							String contract_end,String auto_term,String naver_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cus_no", cus_no);
		map.put("contract_start", contract_start);
		map.put("contract_end", contract_end);
		map.put("auto_term", auto_term);
		map.put("naver_yn", naver_yn);
		int result = getSqlSession().update(NS + ".uptContract", map);
		return result;
	}

	public List<HashMap<String, Object>> getLecrLineListCount(String store, String search_name, String search_corp_fg, String status_fg, String rep_store) {
	
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_corp_fg", search_corp_fg);
		map.put("status_fg", status_fg);
		map.put("rep_store", rep_store);
		map.put("store", store);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrLineListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getLecrLineList(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String search_name, String search_corp_fg, String status_fg, String rep_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("search_corp_fg", search_corp_fg);
		map.put("status_fg", status_fg);
		map.put("rep_store", rep_store);
		map.put("store", store);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrLineList", map);
		return list;
	}
	public List<HashMap<String, Object>> getBankCdCombo() {
		return getSqlSession().selectList(NS + ".getBankCdCombo");
	}
	
	public HashMap<String, Object> getContractInfo(String reg_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("reg_no", reg_no);
		HashMap<String, Object> list = getSqlSession().selectOne(NS + ".getContractInfo", map);
		return list;
	}	

	
	public int confirm(String create_resi_no, String store,String period,String subject_cd,String cus_no,String way) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("create_resi_no", create_resi_no);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cus_no", cus_no);
		map.put("way", way);
		int result = getSqlSession().update(NS + ".confirm", map);
		return result;
	}
	public HashMap<String, Object> getLecrCntAsLine(String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		return getSqlSession().selectOne(NS + ".getLecrCntAsLine", map);
	}
	public List<HashMap<String, Object>> getNewLecrDetailCount(String search_name, String store, String start_point, String end_point, String start_ymd, String end_ymd, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("start_point", start_point);
		map.put("end_point", end_point);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("subject_fg", subject_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getNewLecrDetailCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getNewLecrDetail(int s_rownum, int e_rownum, String order_by, String sort_type, String search_name, String store, String start_point, String end_point, String start_ymd, String end_ymd, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("start_point", start_point);
		map.put("end_point", end_point);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("subject_fg", subject_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getNewLecrDetail", map);
		return list;
	}
	
	public HashMap<String, Object> getApplyInfo(String reg_no,String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("reg_no", reg_no);
		map.put("cust_no", cust_no);
		HashMap<String, Object> list = getSqlSession().selectOne(NS + ".getApplyInfo", map);
		return list;
	}

	public List<HashMap<String, Object>> getLemgList(String lectmgmt_no, String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lectmgmt_no", lectmgmt_no);
		map.put("lecturer_cd", lecturer_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLemgList", map);
		return list;	
	}
	public List<HashMap<String, Object>> getLemgListAll() {
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLemgListAll");
		return list;	
	}
	public List<HashMap<String, Object>> getLemgListOld(String searchLemg, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lectmgmt_no", searchLemg);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLemgListOld", map);
		return list;	
	}
	public void upPeltByLecr(String lecturer_cd, String lectmgmt_no, String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		map.put("lectmgmt_no", lectmgmt_no);
		map.put("cus_no", cus_no);
		getSqlSession().update(NS + ".upPeltByLecr", map);
	}
	public List<HashMap<String, Object>> lecr_lect_list(String lectmgmt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lectmgmt_no", lectmgmt_no);
		return getSqlSession().selectList(NS + ".lecr_lect_list", map);
	}
	public List<HashMap<String, Object>> lecr_lect_list2(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		return getSqlSession().selectList(NS + ".lecr_lect_list2", map);
	}
	
	
	public List<HashMap<String, Object>> getPelt(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPelt", map);
		return list;	
	}
	
	public List<HashMap<String, Object>> getPeriForContract(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeriForContract", map);
		return list;	
	}
	
	
	public void insContract(String store, String period, String cus_no, String subject_cd, String start_ymd, String end_ymd, String login_seq,String create_date) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cus_no", cus_no);
		map.put("subject_cd", subject_cd);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("login_seq", login_seq);
		map.put("create_date", create_date);
		
		getSqlSession().insert(NS + ".insContract", map);
		
	}
	public String getConnectInfo(String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		return getSqlSession().selectOne(NS + ".getConnectInfo", map);
	}
	public int getJrCnt(String store, String period, String subject_cd, String corp_tb, String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("corp_tb", corp_tb);
		map.put("lecturer_cd", lecturer_cd);
		return getSqlSession().selectOne(NS + ".getJrCnt", map);
	}
	public List<HashMap<String, Object>> getConnectPelt(String cus_no, String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("lecturer_cd", lecturer_cd);
		return getSqlSession().selectList(NS + ".getConnectPelt", map);
	}
	public void upPeltLecturer(String lecturer_cd_ori, String lecturer_cd_connect, String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd_ori", lecturer_cd_ori);
		map.put("lecturer_cd_connect", lecturer_cd_connect);
		map.put("cus_no", cus_no);
		getSqlSession().update(NS + ".upPeltLecturer1", map);
		getSqlSession().update(NS + ".upPeltLecturer2", map);
	}
	public List<HashMap<String, Object>> getLecrDetailByTransaction(String chkList) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("chkList", chkList);
		return getSqlSession().selectList(NS + ".getLecrDetailByTransaction", map);
	}
	public void delLecr(String chkList) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("chkList", chkList);
		getSqlSession().delete(NS + ".delLecr", map);
	}
	public void insPrintb(String cus_no, String type, String line, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("type", type);
		map.put("line", line);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insPrintb", map);
	}
	public List<HashMap<String, Object>> getPrintListCount(String print_type, String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("print_type", print_type);
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPrintListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getPrintList(int s_rownum, int e_rownum, String order_by, String sort_type, String print_type, String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("print_type", print_type);
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPrintList", map);
		return list;
	}
	public void upLecrAppr(String approval_no, String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("approval_no", approval_no);
		map.put("lecturer_cd", lecturer_cd);
		getSqlSession().update(NS + ".upLecrAppr", map);
	}
	public int isInLectureByCust(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		return getSqlSession().selectOne(NS + ".isInLectureByCust", map);
	}
	public void insAkhracLine(String corp_fg, String lecturer_cd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecturer_cd", lecturer_cd);
		map.put("login_seq", login_seq);
		if("1".equals(corp_fg)) //법인
		{
			getSqlSession().insert(NS + ".insAkhracLine1", map);
		}
		else if("2".equals(corp_fg)) //개인
		{
			getSqlSession().insert(NS + ".insAkhracLine2", map);
		}
		
	}
	
	
	public int del_passReslt(String cust_no, String reg_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("reg_no", reg_no);
		return getSqlSession().delete(NS + ".del_passReslt", map);
	}
	
	public int del_passReslt2(String cust_no,String reg_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		map.put("reg_no", reg_no);
		return  getSqlSession().delete(NS + ".del_passReslt2", map);		
	}
	

}
