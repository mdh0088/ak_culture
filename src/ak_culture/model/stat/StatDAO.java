package ak_culture.model.stat;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import ak_culture.classes.Utils;


public class StatDAO extends SqlSessionDaoSupport{
	
	private String NS = "/stat/statMapper";

	public int isInTarget(String year, String season, String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("season", season);
		map.put("store", store);
		return getSqlSession().selectOne(NS + ".isInTarget", map);
	}
	public int insTarget(String year, String season, String store, String regis_no, String pay, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("season", season);
		map.put("store", store);
		map.put("regis_no", regis_no);
		map.put("pay", pay);
		map.put("login_seq", login_seq);
		return getSqlSession().insert(NS + ".insTarget", map);
	}
	public int upTarget(String year, String season, String store, String regis_no, String pay, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("season", season);
		map.put("store", store);
		map.put("regis_no", regis_no);
		map.put("pay", pay);
		map.put("login_seq", login_seq);
		return getSqlSession().update(NS + ".upTarget", map);
	}
	public List<HashMap<String, Object>> getTarget(String year, String season) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("season", season);
		return getSqlSession().selectList(NS + ".getTarget", map);
	}
	public HashMap<String, Object> getPerfor(String store, String start_peri, String end_peri, String subject_fg, String main_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("start_peri", start_peri);
		map.put("end_peri", end_peri);
		map.put("subject_fg", subject_fg);
		map.put("main_cd", main_cd);
		return getSqlSession().selectOne(NS + ".getPerfor", map);
	}
	public List<HashMap<String, Object>> getPerforLect(String store, String period, String target_store, String target_period, String start_ymd1, String end_ymd1, String start_ymd2, String end_ymd2, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("target_store", target_store);
		map.put("target_period", target_period);
		map.put("start_ymd1", start_ymd1);
		map.put("end_ymd1", end_ymd1);
		map.put("start_ymd2", start_ymd2);
		map.put("end_ymd2", end_ymd2);
		map.put("isPerformance", isPerformance);
		return getSqlSession().selectList(NS + ".getPerforLect", map);
	}
	public List<HashMap<String, Object>> getPayment(String store, String period, String target_store, String target_period, String lect_ym, String lect_ym_target) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("target_store", target_store);
		map.put("target_period", target_period);
		map.put("lect_ym", lect_ym);
		map.put("lect_ym_target", lect_ym_target);
		return getSqlSession().selectList(NS + ".getPayment", map);
	}
	public List<HashMap<String, Object>> getRoomList(String store, String period, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		return getSqlSession().selectList(NS + ".getRoomList", map);
	}
	public List<HashMap<String, Object>> getTargetLong(String store, String selYear1, String selSeason1) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("selYear1", selYear1);
		map.put("selSeason1", selSeason1);
		return getSqlSession().selectList(NS + ".getTargetLong", map);
	}
	public List<HashMap<String, Object>> getPerforUnion(String b_start_peri, String b_end_peri, String s_start_peri,
			String s_end_peri, String p_start_peri, String p_end_peri, String w_start_peri, String w_end_peri, String start_ymd, String end_ymd, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("b_start_peri", b_start_peri);
		map.put("b_end_peri", b_end_peri);
		map.put("s_start_peri", s_start_peri);
		map.put("s_end_peri", s_end_peri);
		map.put("p_start_peri", p_start_peri);
		map.put("p_end_peri", p_end_peri);
		map.put("w_start_peri", w_start_peri);
		map.put("w_end_peri", w_end_peri);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("isPerformance", isPerformance);
		return getSqlSession().selectList(NS + ".getPerforUnion", map);
	}
	public List<HashMap<String, Object>> getPeltCount(String store, String period, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getPelt(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPelt", map);
		return list;
	}
	public List<HashMap<String, Object>> getDetailCount(String store, String period, String subject_fg, String end_fg, String search_start, String search_end, String main_cd, String sect_cd, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("end_fg", end_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getDetailCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getDetail(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String subject_fg, String end_fg, String search_start, String search_end, String main_cd, String sect_cd, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("end_fg", end_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getDetail", map);
		return list;
	}
	public List<HashMap<String, Object>> getMemberLectureCount(String store, String period, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMemberLectureCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getMemberLecture(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMemberLecture", map);
		return list;
	}
	public List<HashMap<String, Object>> getDaylist(String store, String period, String search_start, String search_end, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getDaylist", map);
		return list;
	}
	public List<HashMap<String, Object>> getMemberList(String store, String period, String search_start, String search_end, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMemberList", map);
		return list;
	}
	public List<HashMap<String, Object>> getMemberListBest(String store, String period, String search_start, String search_end, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMemberListBest", map);
		return list;
	}
	public List<HashMap<String, Object>> getMemberListGender(String store, String period, String search_start, String search_end, String isPerformance) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("isPerformance", isPerformance);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getMemberListGender", map);
		return list;
	}
	public List<HashMap<String, Object>> getAttendCount(String s_peri, String b_peri, String p_peri, String w_peri, String subject_fg, String main_cd, String sect_cd, String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_peri", s_peri);
		map.put("b_peri", b_peri);
		map.put("p_peri", p_peri);
		map.put("w_peri", w_peri);
		
		map.put("subject_fg", subject_fg);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAttendCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getAttend(int s_rownum, int e_rownum, String order_by, String sort_type, String s_peri, String b_peri, String p_peri, String w_peri, String subject_fg, String main_cd, String sect_cd, String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		map.put("s_peri", s_peri);
		map.put("b_peri", b_peri);
		map.put("p_peri", p_peri);
		map.put("w_peri", w_peri);
		
		map.put("subject_fg", subject_fg);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAttend", map);
		return list;
	}
}
