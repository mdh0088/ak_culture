package ak_culture.model.it;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class ItDAO extends SqlSessionDaoSupport{
	
	private String NS = "/it/itMapper";

	public List<HashMap<String, Object>> getPeltCount(String search_type, String search_name, String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getPelt(String search_type, String search_name, int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPelt", map);
		return list;
	}
	public List<HashMap<String, Object>> getACLASS(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getACLASS", map);
		return list;
	}
	public void insChfix(String store, String period, String subject_cd, String prev_fix_pay_yn, String prev_fix_amt, String prev_fix_rate, 
			String next_fix_pay_yn, String next_fix_amt, String next_fix_rate, String change_reason, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("prev_fix_pay_yn", prev_fix_pay_yn);
		map.put("prev_fix_amt", prev_fix_amt);
		map.put("prev_fix_rate", prev_fix_rate);
		map.put("next_fix_pay_yn", next_fix_pay_yn);
		map.put("next_fix_amt", next_fix_amt);
		map.put("next_fix_rate", next_fix_rate);
		map.put("change_reason", change_reason);
		map.put("login_seq", login_seq);
		
		getSqlSession().insert(NS + ".insChfix", map);
	}
	public void upChfix(String store, String period, String subject_cd, String prev_fix_pay_yn, String prev_fix_amt, String prev_fix_rate, 
			String next_fix_pay_yn, String next_fix_amt, String next_fix_rate, String change_reason, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("prev_fix_pay_yn", prev_fix_pay_yn);
		map.put("prev_fix_amt", prev_fix_amt);
		map.put("prev_fix_rate", prev_fix_rate);
		map.put("next_fix_pay_yn", next_fix_pay_yn);
		map.put("next_fix_amt", next_fix_amt);
		map.put("next_fix_rate", next_fix_rate);
		map.put("change_reason", change_reason);
		map.put("login_seq", login_seq);
		
		getSqlSession().update(NS + ".upChfix", map);
	}
	public List<HashMap<String, Object>> getChfix(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getChfix", map);
		return list;
	}
	public void upChangeConfirm(String store, String period, String subject_cd, String act, String no_reason, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("act", act);
		map.put("no_reason", no_reason);
		map.put("login_seq", login_seq);
		getSqlSession().update(NS + ".upChangeConfirm", map);
	}
	public void upPeltFix(String store, String period, String subject_cd, String fix_pay_yn, String fix_amt, String fix_rate) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("fix_pay_yn", fix_pay_yn);
		map.put("fix_amt", fix_amt);
		map.put("fix_rate", fix_rate);
		getSqlSession().update(NS + ".upPeltFix", map);
	}
	public List<HashMap<String, Object>> getPaymentCheckCount(String store, String period, String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPaymentCheckCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getPaymentCheck(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPaymentCheck", map);
		return list;
	}
	public List<HashMap<String, Object>> getDoc(String type_l) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("type_l", type_l);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getDoc", map);
		return list;
	}
	public List<HashMap<String, Object>> getPayment1(String store, String start_ymd, String end_ymd, String doc_type, String status_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("doc_type", doc_type);
		map.put("status_fg", status_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPayment1", map);
		return list;
	}
	public List<HashMap<String, Object>> getPayment2(String store, String start_ymd, String end_ymd, String doc_type, String status_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("doc_type", doc_type);
		map.put("status_fg", status_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPayment2", map);
		return list;
	}
	public String getEndCloseStatus(String store, String close_fg, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("close_fg", close_fg);
		map.put("sale_ymd", sale_ymd);
		String ret = getSqlSession().selectOne(NS + ".getEndCloseStatus", map);
		return ret;
	}
	public void insEnd(String store, String close_fg, String sale_ymd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("close_fg", close_fg);
		map.put("sale_ymd", sale_ymd);
		map.put("login_seq", login_seq);
		
		getSqlSession().insert(NS + ".insEnd", map);
	}
	public List<HashMap<String, Object>> getElectListCount(String store, String period, String lect_ym, String journal_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym", lect_ym);
		map.put("journal_yn", journal_yn);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getElectListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getElectList(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String lect_ym, String journal_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym", lect_ym);
		map.put("journal_yn", journal_yn);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getElectList", map);
		return list;
	}
//	public List<HashMap<String, Object>> getStatusListCount(String store, String start_ymd, String end_ymd, String corp_fg, String detail_fg) {
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("store", store);
//		map.put("start_ymd", start_ymd);
//		map.put("end_ymd", end_ymd);
//		
//		List<HashMap<String, Object>> list = null;
//		
//		if("1".equals(corp_fg))
//		{
//			//법인
//			if("lect_sort".equals(detail_fg)) 
//			{
//                //강좌별
//				list = getSqlSession().selectList(NS + ".getStatusListCount1", map);
//            } 
//			else 
//            {
//                //강사별
//				list = getSqlSession().selectList(NS + ".getStatusListCount2", map);
//            }
//		}
//		else
//		{
//			//개인
//			if("lect_sort".equals(detail_fg)) 
//			{
//                //강좌별
//				list = getSqlSession().selectList(NS + ".getStatusListCount3", map);
//            } 
//			else 
//            {
//                //강사별
//				list = getSqlSession().selectList(NS + ".getStatusListCount4", map);
//            }
//		}
//		return list;
//	}
	public List<HashMap<String, Object>> getStatusList(String store, String period, String corp_fg, String lect_ym, String journal_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym", lect_ym);
		map.put("journal_yn", journal_yn);
		
		List<HashMap<String, Object>> list = null;
		
		if("1".equals(corp_fg))
		{
			list = getSqlSession().selectList(NS + ".getStatusList1", map);
		}
		else
		{
			list = getSqlSession().selectList(NS + ".getStatusList2", map);
		}
		
		return list;
	}
	public List<HashMap<String, Object>> getStatusByPeriList(String store, String period, String lect_ym1, String lect_ym2, String lect_ym3) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym1", lect_ym1);
		map.put("lect_ym2", lect_ym2);
		map.put("lect_ym3", lect_ym3);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getStatusByPeriList", map);
		
		return list;
	}
	public List<HashMap<String, Object>> getStatusByPeriList_food(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getStatusByPeriList_food", map);
		
		return list;
	}
	public List<HashMap<String, Object>> getCorpListCount(String corp_fg, String store, String period, String lect_ym, String subject_fg, String end_yn, String journal_yn, String pay_day, String act, String submit_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym", lect_ym);
		map.put("subject_fg", subject_fg);
		map.put("end_yn", end_yn);
		map.put("journal_yn", journal_yn);
		map.put("pay_day", pay_day);
		map.put("act", act);
		map.put("submit_yn", submit_yn);
		
		List<HashMap<String, Object>> list = null;
		if("1".equals(corp_fg)) //법인강사
		{
			list = getSqlSession().selectList(NS + ".getCorp1ListCount", map);
		}
		else
		{
			list = getSqlSession().selectList(NS + ".getCorp2ListCount", map);
		}
		return list;
	}
	public List<HashMap<String, Object>> getCorpList(int s_rownum, int e_rownum, String order_by, String sort_type, String corp_fg, String store, String period, String lect_ym, String subject_fg, String end_yn, String journal_yn, String pay_day, String act, String submit_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym", lect_ym);
		map.put("subject_fg", subject_fg);
		map.put("end_yn", end_yn);
		map.put("journal_yn", journal_yn);
		map.put("pay_day", pay_day);
		map.put("act", act);
		map.put("submit_yn", submit_yn);
		
		List<HashMap<String, Object>> list = null;
		if("1".equals(corp_fg)) //법인강사
		{
			list = getSqlSession().selectList(NS + ".getCorp1List", map);
		}
		else
		{
			list = getSqlSession().selectList(NS + ".getCorp2List", map);
		}
		
		return list;
	}
	public List<HashMap<String, Object>> getFoodListCount(String store, String period, String food_ym, String journal_yn, String end_yn,  String pay_day, String act, String submit_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("food_ym", food_ym);
		map.put("journal_yn", journal_yn);
		map.put("end_yn", end_yn);
		map.put("pay_day", pay_day);
		map.put("act", act);
		map.put("submit_yn", submit_yn);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getFoodListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getFoodList(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String food_ym, String journal_yn, String end_yn,  String pay_day, String act, String submit_yn, String food_ym1, String food_ym2, String food_ym3) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("food_ym", food_ym);
		map.put("journal_yn", journal_yn);
		map.put("end_yn", end_yn);
		map.put("pay_day", pay_day);
		map.put("act", act);
		map.put("submit_yn", submit_yn);
		map.put("food_ym1", food_ym1);
		map.put("food_ym2", food_ym2);
		map.put("food_ym3", food_ym3);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getFoodList", map);
		return list;
	}
	public List<HashMap<String, Object>> getMaterialList(String store, String period_from, String period_to) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period_from", period_from);
		map.put("period_to", period_to);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMaterialList", map);
		return list;
	}
	public void saveJr(String corp_fg, String store, String period, String subject_cd, String lect_ym, String main_cd, String sect_cd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("lect_ym", lect_ym);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("login_seq", login_seq);
		if("1".equals(corp_fg))
		{
			map.put("procedure", "PR_BA_BAJRCOTB");
		}
		else
		{
			map.put("procedure", "PR_BA_BAJRPRTB");
		}
		getSqlSession().insert(NS + ".saveJr", map);
		
	}
	public int delJr(String corp_fg, String store, String period, String subject_cd, String lect_ym, String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("lect_ym", lect_ym);
		map.put("lecturer_cd", lecturer_cd);
		int cnt = 0;
		if("1".equals(corp_fg))
		{
			cnt = getSqlSession().delete(NS + ".delJr1", map);
		}
		else
		{
			cnt = getSqlSession().delete(NS + ".delJr2", map);
		}
		return cnt;
	}
	public void saveFood(String store, String period, String subject_cd, String food_ym, String main_cd, String sect_cd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("food_ym", food_ym);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("login_seq", login_seq);
		System.out.println("시작!");
		getSqlSession().insert(NS + ".saveFood", map);
		System.out.println("끝!");
		
	}
	public int delFood(String store, String period, String subject_cd, String food_ym) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("food_ym", food_ym);
		int cnt = getSqlSession().delete(NS + ".delFood", map);
		
		return cnt;
	}
	public HashMap<String, Object> getPaydayByPeri(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectOne(NS + ".getPaydayByPeri", map);
	}
	public int getRegisEndCount(String corp_fg, String lect_ym) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lect_ym", lect_ym);
		if("1".equals(corp_fg))
		{
			map.put("table", "bajrcotb");
		}
		else if("2".equals(corp_fg))
		{
			map.put("table", "bajrprtb");
		}
		else
		{
			map.put("table", "");
		}
		int cnt = getSqlSession().selectOne(NS + ".getRegisEndCount", map);
		return cnt;
	}
	public List<HashMap<String, Object>> getRegisEndList(String corp_fg, String store, String period, String lect_ym, String subject_fg, String search_name, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("corp_fg", corp_fg);
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym", lect_ym);
		map.put("subject_fg", subject_fg);
		map.put("search_name", search_name);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		if("1".equals(corp_fg))
		{
			map.put("table", "bajrcotb");
		}
		else if("2".equals(corp_fg))
		{
			map.put("table", "bajrprtb");
		}
		else
		{
			map.put("table", "");
		}
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRegisEndList", map);
		return list;
	}
	public int getFoodEndCount(String lect_ym) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lect_ym", lect_ym);
		int cnt = getSqlSession().selectOne(NS + ".getFoodEndCount", map);
		return cnt;
	}
	public List<HashMap<String, Object>> getFoodEndList(String store, String period, String food_ym, String search_name, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("food_ym", food_ym);
		map.put("search_name", search_name);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getFoodEndList", map);
		return list;
	}
	public List<HashMap<String, Object>> getFoodYmList(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getFoodYmList", map);
		return list;
	}
	public int getFoodEndOne(String store, String period, String food_ym, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("food_ym", food_ym);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectOne(NS + ".getFoodEndOne", map);
	}
	public List<HashMap<String, Object>> getElectDetailList(String store, String period, String lecturer_cd, String lect_ym) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lecturer_cd", lecturer_cd);
		map.put("lect_ym", lect_ym);
		return getSqlSession().selectList(NS + ".getElectDetailList", map);
	}
	public void saveElect(String store, String period, String lect_ym, String lecturer_cd, String accept_yn,
			String journal_yn, String seq, String vat_fg, String pay_day, String accept_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("lect_ym", lect_ym);
		map.put("lecturer_cd", lecturer_cd);
		map.put("accept_yn", accept_yn);
		map.put("journal_yn", journal_yn);
		map.put("seq", seq);
		map.put("vat_fg", vat_fg);
		map.put("pay_day", pay_day);
		map.put("accept_ymd", accept_ymd);
		
		getSqlSession().update(NS + ".saveElect", map);
		
		
	}
}
