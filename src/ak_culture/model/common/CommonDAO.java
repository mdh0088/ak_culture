package ak_culture.model.common;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class CommonDAO extends SqlSessionDaoSupport{
	
	private String NS = "/commonMapper";
	public List<HashMap<String, Object>> getPeriList(String selBranch, String selYear, String selSeason) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		map.put("selYear", selYear);
		map.put("selSeason", selSeason);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeriList", map);
		return list;
	}
	
	public HashMap<String, Object> getStartPeri(String selBranch, String selYear, String selSeason) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		map.put("selYear", selYear);
		map.put("selSeason", selSeason);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getStartPeri", map);
		return data;
	}
	
	public HashMap<String, Object> getEndPeri(String selBranch, String selYear, String selSeason) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		map.put("selYear", selYear);
		map.put("selSeason", selSeason);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getEndPeri", map);
		return data;
	}
	
	public List<HashMap<String, Object>> getPeriList2(String selPeri, String selBranch) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selPeri", selPeri);
		map.put("selBranch", selBranch);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeriList2", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getBranch(String rep_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("rep_store", rep_store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getBranch", map);
		return list;
	}
	public List<HashMap<String, Object>> get1Depth() {
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".get1Depth");
		return list;
	}
	public List<HashMap<String, Object>> get1Depth_incDel() { //삭제포함
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".get1Depth_incDel");
		return list;
	}
	public List<HashMap<String, Object>> getUser_byPhone(String phone) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("phone", phone);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUser_byPhone", map);
		return list;
	}
	public List<HashMap<String, Object>> getAms_byPhone(String phone) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("phone", phone);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAms_byPhone", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getRecentPeri(int semester_cnt ,String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("semester_cnt", semester_cnt);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRecentPeri", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getRecentPeriforTarget(int num,String year,String season) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("num", num);
		map.put("year", year);
		map.put("season", season);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRecentPeriforTarget", map);
		return list;
	}

	
	public List<HashMap<String, Object>> getUser_byCus_no(String cusno) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cusno", cusno);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUser_byCus_no", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getSecCd(String maincd, String selBranch) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("maincd", maincd);
		map.put("selBranch", selBranch);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getSecCd", map);
		return list;
	}
	public void delMainCd(String maincd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("maincd", maincd);
		getSqlSession().update(NS + ".delMainCd", map);
	}
	public HashMap<String, Object> getUserByCust(String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cust_no", cust_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getUserByCust", map);
		return data;
	}
	public List<HashMap<String, Object>> getUserByAms(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getUserByAms", map);
		return list;
	}

	public HashMap<String, Object> getUserByMembersCard(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getUserByMembersCard", map);
		return data;
	}
	public List<HashMap<String, Object>> getLectSearch(String order_by, String sort_type, String searchVal, String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("searchVal", searchVal);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectSearch", map);
		return list;
	}
	public List<HashMap<String, Object>> getLects(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLects", map);
		return list;
	}
	public HashMap<String, Object> getCardNo(String card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("card_no", card_no);
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getCardNo", map);
		return data;
	}
	public List<HashMap<String, Object>> getPosList(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPosList", map);
		return list;
	}
	public String getStoreName(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		String store_name = getSqlSession().selectOne(NS + ".getStoreName", map);
		return store_name;
	}
	public int getCardCount(String card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("card_no", card_no);
		int cnt = getSqlSession().selectOne(NS + ".getCardCount", map);
		return cnt;
	}
	public int getCardCount822(String card_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("card_no", card_no);
		int cnt = getSqlSession().selectOne(NS + ".getCardCount822", map);
		return cnt;
	}
	public List<HashMap<String, Object>> getPeltBySect(String store, String period, String main_cd, String sect_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltBySect", map);
		return list;
	}
	public List<HashMap<String, Object>> getPeltBySubjectCd(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltBySubjectCd", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getTargetCustList(String selBranch, String year, String season, String main_cd, String sect_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		map.put("year", year);
		map.put("season", season);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getTargetCustList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getProcListCount(String pgm_arg, String pgm_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("pgm_arg", pgm_arg);
		map.put("pgm_id", pgm_id);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getProcListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getProcList(int s_rownum, int e_rownum, String order_by, String sort_type, String pgm_arg, String pgm_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("pgm_arg", pgm_arg);
		map.put("pgm_id", pgm_id);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getProcList", map);
		return list;
	}
	public List<HashMap<String, Object>> getProcList_noPaging(String pgm_arg, String pgm_id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("pgm_arg", pgm_arg);
		map.put("pgm_id", pgm_id);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getProcList_noPaging", map);
		return list;
	}
	
	
	public static boolean isVaildCell(String cell1, String cell2, String cell3) throws Exception { 
		String[] check = {"010", "011", "016", "017", "018", "019"}; //유효한 휴대폰 첫자리 번호 데이터 
		String temp = cell1 + cell2 + cell3; 
		
		for(int i=0; i < temp.length(); i++){ 
			if (temp.charAt(i) < '0' || temp.charAt(i) > '9') { 
				return false; 
				} 
			} //숫자가 아닌 값이 들어왔는지를 확인 
		
		for(int i = 0; i < check.length; i++){ 
			if(cell1.equals(check[i])) { 
				break; 
			} 
			
			if(i == check.length - 1) { 
				return false; 
			} 
		} // 휴대폰 첫자리 번호입력의 유효성 체크 
		
		if(cell2.charAt(0) == '0') { 
			return false;
		} 
		
		if(cell2.length() != 3 && cell2.length() !=4) {
			return false; 
		} 
		
		if(cell3.length() != 4) { 
			return false; 
		} 
		
		return true; 
		}
	
	public List<HashMap<String, Object>> getBookmark(String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getBookmark", map);
		return list;
	}
	public void upBookmark(String login_seq, String link, String tit) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq);
		map.put("link", link);
		map.put("tit", tit);
		getSqlSession().update(NS + ".upBookmark", map);
	}
	public void insBookmark(String login_seq, String link, String tit) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq);
		map.put("link", link);
		map.put("tit", tit);
		getSqlSession().insert(NS + ".insBookmark", map);
	}
	
	public String retrievePeriod(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		return getSqlSession().selectOne(NS + ".retrievePeriod", map);
	}
	public HashMap<String, Object> isFullPeltByCust(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectOne(NS + ".isFullPeltByCust", map);
	}
	public HashMap<String, Object> isInPeltByCust(String store, String period, String subject_cd, String cust_no, String child_no1) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cust_no", cust_no);
		map.put("child_no1", child_no1);
		
		return getSqlSession().selectOne(NS + ".isInPeltByCust", map);
	}
	public List<HashMap<String, Object>> getAxuserByName(String user_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("user_nm", user_nm);
		return getSqlSession().selectList(NS + ".getAxuserByName", map);
	}

	public List<HashMap<String, Object>> BACust0101_S01(String val) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("val", val);
		return getSqlSession().selectList(NS + ".BACust0101_S01", map);
	}
	
	public List<HashMap<String, Object>> BACust0101_S02(String val) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("val", val);
		return getSqlSession().selectList(NS + ".BACust0101_S02", map);
	}
	
	public List<HashMap<String, Object>> get_AMS_info_by_tel(String val) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("val", val);
		return getSqlSession().selectList(NS + ".get_AMS_info_by_tel", map);
	}
	
	public List<HashMap<String, Object>> get_AMS_info_by_cus_no(String val) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("val", val);
		return getSqlSession().selectList(NS + ".get_AMS_info_by_cus_no", map);
	}
	
	public int addToculture(String cus_no, String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().insert(NS + ".addToculture", map);
	}

	public void saveManagerLog(String create_resi_no, String detail, String target) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("create_resi_no", create_resi_no);
		map.put("detail", detail);
		map.put("target", target);
		getSqlSession().insert(NS + ".saveManagerLog", map);
	}

	public HashMap<String, Object> isPartPayByCust(String store, String period, String subject_cd, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cust_no", cust_no);
		
		return getSqlSession().selectOne(NS + ".isPartPayByCust", map);
	}

	public String getMembersCard(String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("cus_no", cus_no);
		return getSqlSession().selectOne(NS + ".getMembersCard", map);
	}

	public List<HashMap<String, Object>> getChangeByLeader() {
		return getSqlSession().selectList(NS + ".getChangeByLeader");
	}
	
}

