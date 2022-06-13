package ak_culture.model.member;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import ak_culture.classes.Utils;


public class LectDAO extends SqlSessionDaoSupport{
	
	private String NS = "/member/lectMapper";

	public List<HashMap<String, Object>> userSearch(String order_by, String sort_type, String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".userSearch", map);
		return list;
	}

	public void insSale(String store, String pos_no, String recpt_no, int seq_no, String subject_cd, String cust_no, String period, 
			String main_cd, String sect_cd, String regis_fee, String food_fee, String enuri_yn, String login_seq, String child_no1, String child_no2, String encdno1, String encdno2) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		map.put("seq_no", seq_no);
		map.put("subject_cd", subject_cd);
		map.put("cust_no", cust_no);
		map.put("period", period);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("regis_fee", regis_fee);
		map.put("food_fee", food_fee);
		map.put("enuri_yn", enuri_yn);
		map.put("login_seq", login_seq);
		map.put("child_no1", child_no1);
		map.put("child_no2", child_no2);
		map.put("encdno1", encdno1);
		map.put("encdno2", encdno2);
		getSqlSession().insert(NS + ".insSale", map);
		
		
		
	}
	
	public int insAttend(String store, String period, String subject_cd, String login_seq,String isLec,String cust_no,String dayVal) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("login_seq", login_seq);
		map.put("isLec", isLec);
		map.put("cust_no", cust_no);
		map.put("dayVal", dayVal);		
		
		return getSqlSession().insert(NS + ".insAttend", map);
	}
	

	public void upPeltRegis(String store, String period, String subject_cd, int person) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("person", person);
		getSqlSession().update(NS + ".upPeltRegis", map);
	}
	public void upPeltRegis_part(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		getSqlSession().update(NS + ".upPeltRegis_part", map);
	}
	
	public int useEncd(String store, String period,String cust_no, String enuri_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("enuri_cd", enuri_cd);
		return getSqlSession().update(NS + ".useEncd", map);
	}
	
	public void insEncd(String store,String period, String cust_no,String enuri_cd,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("enuri_cd", enuri_cd);
		map.put("cust_no",cust_no);
		map.put("create_resi_no",create_resi_no);
		
		getSqlSession().insert(NS + ".insEncd", map);
	}
	
	
	public void uptCar(String store, String car_no,String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("car_no", car_no);
		map.put("cust_no", cust_no);
		getSqlSession().update(NS + ".uptCar", map);
	}

	public void insWait(String store, String period, String subject_cd, String main_cd, String sect_cd, String cust_no, String login_seq, String pos_no, String child_no1) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("cust_no", cust_no);
		map.put("login_seq", login_seq);
		map.put("pos_no", pos_no);
		map.put("child_no1", child_no1);
		getSqlSession().insert(NS + ".insWait", map);
	}
	

	
	public void upt_giveGift(String store, String period,String cust_no, String gift_cd, String pos_no,String create_resi_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("gift_cd", gift_cd);
		map.put("pos_no", pos_no);
		map.put("update_resi_no", create_resi_no);
		getSqlSession().update(NS + ".upt_giveGift", map);
	}

	
	public List<HashMap<String, Object>> getPereByCust(String store, String period, String cust_no, String isCancel) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("isCancel", isCancel);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPereByCust", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getGiftList(String store, String period, String cust_no,String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_fg", subject_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGiftList", map);
		return list;
	}
	public List<HashMap<String, Object>> getGiftMList(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGiftMList", map);
		return list;
	}
	public List<HashMap<String, Object>> getEnuriByCust(String store, String period,String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEnuriByCust", map);
		return list;
	}
	public List<HashMap<String, Object>> getSaleByCust(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSaleByCust", map);
		return list;
	}
	public List<HashMap<String, Object>> getGiftByCust(String store, String period, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getGiftByCust", map);
		return list;
	}

	public void insert_integrity(String store, String pos_no, String integrity, String secuVer, String secuVer1, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		map.put("integrity", integrity);
		map.put("secuVer", secuVer);
		map.put("secuVer1", secuVer1);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insert_integrity", map);
	}

	public List<HashMap<String, Object>> getIntegrity(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getIntegrity", map);
		return list;
	}

	public List<HashMap<String, Object>> getChildByCust(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getChildByCust", map);
		return list;
	}

	public void saveChild(int child_no, String child_nm,String child_gender ,String child_birth, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("child_no", child_no);
		map.put("child_nm", child_nm);
		map.put("child_gender", child_gender);
		map.put("child_birth", child_birth);
		map.put("cust_no", cust_no);
		getSqlSession().insert(NS + ".saveChild", map);
	}

	public String GetAkmemGrade(String aKmem_CustLevel) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("aKmem_CustLevel", aKmem_CustLevel);
		return getSqlSession().selectOne(NS + ".GetAkmemGrade", map);
	}

	public List<HashMap<String, Object>> getCouponCdCombo() {
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCouponCdCombo");
		return list;
	}

	public List<HashMap<String, Object>> GetMobileCouponTradeNo(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".GetMobileCouponTradeNo", map);
		return list;
	}

	public void useAKmembersPointLog(String hq, String store, String pos_no, String recpt_no, String total_pay,
			String total_enuri_amt, String total_regis_fee, String akmem_card_no, String aKmem_CustNo,
			String aKmem_Family_CustNo, String aKmem_Use_Point, String aKmem_vat_use_pt, String aKmem_vat_ext_use_pt,
			String aKmem_SaveApprove_Point, String aKmem_SaveApproveNo_POS, String akmem_point_amt, String login_seq) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("hq", hq);
		map.put("store", store);
		map.put("pos_no", pos_no);
		map.put("pos_no", pos_no);
		
		map.put("recpt_no", recpt_no);
        map.put("total_show_amt", total_pay);
        map.put("total_enuri_amt", total_enuri_amt);
        map.put("total_regis_fee", total_regis_fee);    //net_sale_amt
        map.put("AKmem_cardno", akmem_card_no);
        map.put("AKmem_CustNo", aKmem_CustNo);
        map.put("AKmem_Family_CustNo", aKmem_Family_CustNo);
        map.put("AKmem_Use_Point", aKmem_Use_Point);         // 사용마일리지
        map.put("AKmem_vat_use_pt", aKmem_vat_use_pt);        // 부가세포함 사용포인트
        map.put("AKmem_vat_ext_use_pt", aKmem_vat_ext_use_pt);    // 부가세제외 사용포인트
        map.put("AKmem_SaveApprove_Point", aKmem_SaveApprove_Point); // 누적 마일리지 금액 추가 (2013.09.05)
        map.put("AKmem_SaveApproveNo_POS", aKmem_SaveApproveNo_POS);
        map.put("akmem_point_amt", akmem_point_amt);   //사용 마일리지 금액 추가
        map.put("login_seq", login_seq);   //사용 마일리지 금액 추가
		getSqlSession().insert(NS + ".useAKmembersPointLog", map);
		
	}

	public HashMap<String, Object> getMemberPay() {
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getMemberPay");
		return data;
	}

	public int insTrms(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insTrms", map);
		return 0;
	}
	public void insTrca_card(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insTrca_card", map);
	}
	public void insTrca_mcoupon(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insTrca_mcoupon", map);
	}
	public int insCash(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insCash", map);
		return 0;
	}
	public void insTrcn(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insTrcn", map);
	}
	public void insAgposl(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insAgposl", map);
	}
	public void insTrde(String store, String pos_no, String recpt_no, int seq_no, String subject_cd, String goods, String uprice, String encdamt1, String encdamt2, String food_amt) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		map.put("seq_no", seq_no);
		map.put("subject_cd", subject_cd);
		map.put("goods", goods);
		map.put("uprice", uprice);
		map.put("encdamt1", encdamt1);
		map.put("encdamt2", encdamt2);
		map.put("food_amt", food_amt);
		
		getSqlSession().insert(NS + ".insTrde", map);
	}

	public int saveAKmembersPointLog(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".saveAKmembersPointLog", map);
		return 0;
	}
	public int saveAKmembersPointLog_test(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".saveAKmembersPointLog_test", map);
		return 0;
	}

	public List<HashMap<String, Object>> posEndCheck(String store, String pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".posEndCheck", map);
		return list;
	}

	public HashMap<String, Object> chargeCheck(String store, String pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".chargeCheck", map);
		return data;
	}
	public int getRecptCardChk(String store, String sale_ymd, String pos_no, String recpt_no, String card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		map.put("card_no", card_no);
		int a = getSqlSession().selectOne(NS + ".getRecptCardChk", map);
		return a;
	}

	public List<HashMap<String, Object>> getRecptNoByCancel(String store, String pos_no, String recpt_pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		map.put("recpt_pos_no", recpt_pos_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRecptNoByCancel", map);
		return list;
	}
	public List<HashMap<String, Object>> getTotalPointSendList(String store, String pos_no, String recpt_no, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		map.put("sale_ymd", sale_ymd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTotalPointSendList", map);
		return list;
	}

	public String cancel_pg_proc(String store, String period, String sale_ymd, String recpt_no, String pos_no_ori, String tid) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		map.put("pos_no_ori", pos_no_ori);
		map.put("tid", tid);
		return getSqlSession().selectOne(NS + ".cancel_pg_proc", map);
	}

	public List<HashMap<String, Object>> getCancelSubject(String store, String recpt_pos_no, String period, String sale_ymd, String recpt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("recpt_pos_no", recpt_pos_no);
		map.put("period", period);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCancelSubject", map);
		return list;
	}
	public String getOri_akmem_card_no(String store, String recpt_pos_no, String period, String sale_ymd, String recpt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("recpt_pos_no", recpt_pos_no);
		map.put("period", period);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		return getSqlSession().selectOne(NS + ".getOri_akmem_card_no", map);
	}
	public List<HashMap<String, Object>> getCancelSubjectPere(String store, String recpt_pos_no, String period, String sale_ymd, String recpt_no, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("recpt_pos_no", recpt_pos_no);
		map.put("period", period);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCancelSubjectPere", map);
		return list;
	}
	public List<HashMap<String, Object>> getCouponInfo(String store, String pos_no, String sale_ymd, String recpt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCouponInfo", map);
		return list;
	}

	public String cancelCheck(String store, String sale_ymd, String recpt_pos_no, String recpt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("recpt_pos_no", recpt_pos_no);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		String a = getSqlSession().selectOne(NS + ".cancelCheck", map);
		return a;
	}

	public void upPeltRegis_down(String recpt_pos_no, String store, String period, String subject_cd, int person) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("recpt_pos_no", recpt_pos_no);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("person", person);
		getSqlSession().update(NS + ".upPeltRegis_down", map);
	}

	public void cancelProc(HashMap<String, Object> map, String approve_no, String mc_approve_no, String recpt_pos_no) {
		getSqlSession().update(NS + ".cancelTrms1", map);
		getSqlSession().insert(NS + ".cancelTrms2", map);
		getSqlSession().insert(NS + ".cancelTrde", map);
		if((approve_no == null || "".equals(approve_no)) && (mc_approve_no == null || "".equals(mc_approve_no))) 
		{
			System.out.println("카드/모바일상품권 승인번호가 없으므로 030108로직을 타지 않습니다.!!");
        } 
		else 
		{
			getSqlSession().insert(NS + ".cancelTrca", map);
		}
		
		getSqlSession().update(NS + ".cancelPere", map);
		if("070013".equals(recpt_pos_no) || "070014".equals(recpt_pos_no)) {
			getSqlSession().update(NS + ".cancelWbtr", map);
		}
		
	}

	public void cancelCash(String store, String recpt_pos_no, String pos_no, String new_recpt_no, String cash_amt,String repay_amt, String issue_fg, String id_fg, String id_no, 
			String approve_no, String van_fg,String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("recpt_pos_no", recpt_pos_no);
		map.put("pos_no", pos_no);
		map.put("new_recpt_no", new_recpt_no);
		map.put("cash_amt", cash_amt);
		map.put("repay_amt", repay_amt);
		map.put("issue_fg", issue_fg);
		map.put("id_fg", id_fg);
		map.put("id_no", id_no);
		map.put("approve_no", approve_no);
		map.put("van_fg", van_fg);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".cancelCash", map);
	}

	public String getCpConvert(String coupon_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("coupon_no", coupon_no);
		String a = getSqlSession().selectOne(NS + ".getCpConvert", map);
		return a;
	}

	public HashMap<String, Object> getCpInfo(String store, String coupon_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("coupon_no", coupon_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getCpInfo", map);
		return data;
	}

	public int getCpBack(String coupon_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("coupon_no", coupon_no);
		int a = getSqlSession().selectOne(NS + ".getCpBack", map);
		return a;
	}

	public String getCar(String store, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		String a = getSqlSession().selectOne(NS + ".getCar", map);
		return a;
	}

	public List<HashMap<String, Object>> selCar(String store, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".selCar", map);
		return list;
		
	}

	public void upCar(String store, String cust_no, String login_seq, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		map.put("login_seq", login_seq);
		map.put("sale_ymd", sale_ymd);
		getSqlSession().update(NS + ".upCar", map);
	}

	public void insCar(String store, String cust_no, String car_no, String period, String rep_subject_cd, String pos_no,
			String recpt_no, String total_show_amt, String login_seq, String park_subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		map.put("car_no", car_no);
		map.put("period", period);
		map.put("rep_subject_cd", rep_subject_cd);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		map.put("total_show_amt",total_show_amt);
		map.put("login_seq", login_seq);
		map.put("park_subject_cd", park_subject_cd);
		getSqlSession().insert(NS + ".insCar1", map);
		getSqlSession().insert(NS + ".insCar2", map); //당일주차 
	}
	public void insCar_cancle(String store, String cust_no, String car_no, String period, String rep_subject_cd, String pos_no,
			String recpt_no, String total_show_amt, String login_seq, String park_subject_cd, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("cust_no", cust_no);
		map.put("car_no", car_no);
		map.put("period", period);
		map.put("rep_subject_cd", rep_subject_cd);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		map.put("total_show_amt",total_show_amt);
		map.put("login_seq", login_seq);
		map.put("park_subject_cd", park_subject_cd);
		map.put("sale_ymd", sale_ymd);
		getSqlSession().insert(NS + ".insCar1", map);
		getSqlSession().insert(NS + ".insCar3", map); //당일주차 
	}

	public List<HashMap<String, Object>> getPayment(String store, String period, String cust_no, String subject_cd,
			String sale_ymd, String recpt_no, String pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		map.put("pos_no", pos_no);
		return getSqlSession().selectList(NS + ".getPayment", map);
	}

	public HashMap<String, Object> isWaitPossible(String cust_no, String store, String period, String subject_cd, String child_no1) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		map.put("child_no1", child_no1);
		return getSqlSession().selectOne(NS + ".isWaitPossible", map);
	}

	public void upWait(String store, String period, String subject_cd, String cust_no, String child_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		map.put("child_no", child_no);
		getSqlSession().selectOne(NS + ".upWait", map);
	}

	public void insTempPere(String store, String period, String subject_cd, String seq, String cust_no, String pos_no, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		map.put("seq", seq);
		map.put("pos_no", pos_no);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insTempPere", map);
	}
	
	public int getlast_childNo(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		return getSqlSession().selectOne(NS + ".getlast_childNo", map);
	}
	
	public HashMap<String, Object> getAttendInfo(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getAttendInfo", map);
		return data;
	}
	
	public HashMap<String, Object> ChkCustInAttend(String store, String period, String subject_cd,String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cust_no", cust_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".ChkCustInAttend", map);
		return data;
	}
	
	public HashMap<String, Object> getCustAttendInfo(String store, String period, String subject_cd, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cust_no", cust_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getCustAttendInfo", map);
		return data;
	}
	
	public void uptCustAttendInfo(String store, String period, String prev_subject_cd,String next_subject_cd, String cust_no,String day_chk) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("prev_subject_cd", prev_subject_cd);
		map.put("next_subject_cd", next_subject_cd);
		map.put("cust_no", cust_no);
		map.put("day_chk", day_chk);
		getSqlSession().update(NS + ".uptCustAttendInfo", map);
	}
	
	public HashMap<String, Object> getUserMembers(String search_type, String cont) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("cont", cont);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getUserMembers", map);
		return data;
	}
	
	public int insMemberToCulture(HashMap<String, Object> data) {
		return getSqlSession().insert(NS + ".insMemberToCulture", data);
	}
	
	public List<HashMap<String, Object>> getEncdList(String store, String period, String cust_no, String subject_cd,String grade,String ak_grade) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		map.put("grade", grade);
		map.put("ak_grade", ak_grade);
		return getSqlSession().selectList(NS + ".getEncdList", map);
	}

	public void upPeltPart(String store, String period, String subject_cd, String regis_fee) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("regis_fee", regis_fee);
		getSqlSession().update(NS + ".upPeltPart", map);
	}

	public String akMemberPercent(String subcode) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("subcode", subcode);
		return getSqlSession().selectOne(NS + ".akMemberPercent", map);
	}

	public String getAKmemRecptNo_01() {
		return getSqlSession().selectOne(NS + ".getAKmemRecptNo_01");
	}
	public String getAKmemRecptNo_02() {
		return getSqlSession().selectOne(NS + ".getAKmemRecptNo_02");
	}
	public String getAKmemRecptNo_03() {
		return getSqlSession().selectOne(NS + ".getAKmemRecptNo_03");
	}
	public String getAKmemRecptNo_04() {
		return getSqlSession().selectOne(NS + ".getAKmemRecptNo_04");
	}
	public String getAKmemRecptNo_05() {
		return getSqlSession().selectOne(NS + ".getAKmemRecptNo_05");
	}

	public HashMap<String, Object> getPointAKmem(String sale_ymd, String store, String recpt_pos_no, String recpt_no, String akmem_card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("pos_no", recpt_pos_no);
		map.put("recpt_no", recpt_no);
		map.put("akmem_card_no", akmem_card_no);
		return getSqlSession().selectOne(NS + ".getPointAKmem", map);
	}

	public HashMap<String, Object> getAKmemUse(String sale_ymd, String store, String recpt_pos_no, String recpt_no, String akmem_card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("pos_no", recpt_pos_no);
		map.put("recpt_no", recpt_no);
		map.put("akmem_card_no", akmem_card_no);
		return getSqlSession().selectOne(NS + ".getAKmemUse", map);
	}
	public HashMap<String, Object> getAKmemSave(String sale_ymd, String store, String recpt_pos_no, String recpt_no, String akmem_card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("pos_no", recpt_pos_no);
		map.put("recpt_no", recpt_no);
		map.put("akmem_card_no", akmem_card_no);
		return getSqlSession().selectOne(NS + ".getAKmemSave", map);
	}
	public HashMap<String, Object> getAKmemSave_test(String sale_ymd, String store, String recpt_pos_no, String recpt_no, String akmem_card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("pos_no", recpt_pos_no);
		map.put("recpt_no", recpt_no);
		map.put("akmem_card_no", akmem_card_no);
		return getSqlSession().selectOne(NS + ".getAKmemSave_test", map);
	}

	public void insWbptTb(HashMap<String, Object> map) {
		 getSqlSession().insert(NS + ".insWbptTb", map);
	}

	public void insWbptTb2(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insWbptTb2", map);
	}
	public void insWbptTb2_test(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insWbptTb2_test", map);
	}

	public String getOri_akmem_recpt_no(String store, String sale_ymd, String pos_no, String akmem_approve_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos_no", pos_no);
		map.put("akmem_approve_no", akmem_approve_no);
		return getSqlSession().selectOne(NS + ".getOri_akmem_recpt_no", map);
	}

	public void delAttend(String store, String period, String park_subject_cd, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("park_subject_cd", park_subject_cd);
		map.put("cust_no", cust_no);
		getSqlSession().delete(NS + ".delAttend", map);
	}

	public List<HashMap<String, Object>> getCancelSubjectList(String store, String period, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		return getSqlSession().selectList(NS + ".getCancelSubjectList", map);
	}

	public void insWbptTbCancel(String store, String sale_ymd, String ori_sale_ymd, String pos_no, String ori_pos_no, String akmem_recpt_no, String ori_akmem_recpt_no, String AKmem_SaveApproveNo_POS, String AKmem_send_buff, String AKmem_recv_buff, String AKmem_SaveApprove_Point) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("ori_sale_ymd", ori_sale_ymd);
		map.put("pos_no", pos_no);
		map.put("ori_pos_no", ori_pos_no);
		map.put("akmem_recpt_no", akmem_recpt_no);
		map.put("ori_akmem_recpt_no", ori_akmem_recpt_no);
		map.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
		map.put("AKmem_send_buff", AKmem_send_buff);
		map.put("AKmem_recv_buff", AKmem_recv_buff);
		map.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);
		getSqlSession().insert(NS + ".insWbptTbCancel", map);
	}
	public void insWbptTbCancel2(String store, String sale_ymd, String ori_sale_ymd, String pos_no, String ori_pos_no, String akmem_recpt_no, String ori_akmem_recpt_no, String AKmem_SaveApproveNo_POS, String AKmem_send_buff, String AKmem_recv_buff, String AKmem_SaveApprove_Point) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("ori_sale_ymd", ori_sale_ymd);
		map.put("pos_no", pos_no);
		map.put("ori_pos_no", ori_pos_no);
		map.put("akmem_recpt_no", akmem_recpt_no);
		map.put("ori_akmem_recpt_no", ori_akmem_recpt_no);
		map.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
		map.put("AKmem_send_buff", AKmem_send_buff);
		map.put("AKmem_recv_buff", AKmem_recv_buff);
		map.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);
		getSqlSession().insert(NS + ".insWbptTbCancel2", map);
	}

	public HashMap<String, Object> getptcaOri(String store, String sale_ymd, String pos_no, String recpt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		return getSqlSession().selectOne(NS + ".getptcaOri", map);
	}
	public HashMap<String, Object> getptcaOri_test(String store, String sale_ymd, String pos_no, String recpt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		return getSqlSession().selectOne(NS + ".getptcaOri_test", map);
	}

	public String getisEncdYN(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectOne(NS + ".getisEncdYN", map);
	}

	public void delTempPere(String store, String period, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		getSqlSession().delete(NS + ".delTempPere", map);
	}
	
	public HashMap<String, Object> chkGift(String store, String period, String cust_no, String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("gift_cd", gift_cd);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".chkGift", map);
		return data;
	}
	
	public List<HashMap<String, Object>> chkGiftForReturn(String store, String period, String cust_no, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".chkGiftForReturn", map);
		return list;
	}
	
	public HashMap<String, Object> getGiftInfoForReturn(String store, String period, String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("gift_cd", gift_cd);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getGiftInfoForReturn", map);
		return data;
	}
	
	public void uptGiftInfoForReturn(String store, String period, String cust_no,String gift_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("gift_cd", gift_cd);
		getSqlSession().update(NS + ".uptGiftInfoForReturn", map);
	}

	public List<HashMap<String, Object>> getPaymentCancel(String store, String period, String cust_no, String pos_no, String recpt_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cust_no", cust_no);
		map.put("pos_no", pos_no);
		map.put("recpt_no", recpt_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPaymentCancel", map);
		return list;
	}
	
	
	public HashMap<String, Object> getCustGrade(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getCustGrade", map);
		return data;
	}
	
}
