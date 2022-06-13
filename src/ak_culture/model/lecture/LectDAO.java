package ak_culture.model.lecture;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

import ak_culture.classes.Utils;

public class LectDAO extends SqlSessionDaoSupport{
	
	private String NS = "/lecture/lectMapper";
	
	public List<HashMap<String, Object>> getLecrCount(String search_name) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrCount", map);
		return list;
	}	
	
	public List<HashMap<String, Object>> getLecr(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecr", map);
		return list;
	}
	
	public String getlectcode() {
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("main_code", main_code);
//		map.put("sect_code", sect_code);
		
		String a = getSqlSession().selectOne(NS + ".getlectcode");
		return a;
	}
	public List<HashMap<String, Object>> getLecrList(String lecr_name, String lecr_phone) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("lecr_name", lecr_name);
		map.put("lecr_phone", lecr_phone);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLecrList", map);
		return list;
	}
//	public void insLect(String store, String period, String subject_cd, String subject_nm, String main_cd, String sect_cd, String lect_cd, String login_seq) {
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("store", store);
//		map.put("period", period);
//		map.put("subject_cd", subject_cd);
//		map.put("subject_nm", subject_nm);
//		map.put("main_cd", main_cd);
//		map.put("sect_cd", sect_cd);
//		map.put("lect_cd", lect_cd);
//		map.put("login_seq", login_seq);
//		getSqlSession().insert(NS + ".insLect", map);
//	}
	public void insPelt(String store, String period, String subject_cd, String main_cd, String sect_cd,
			String day_flag, String lect_hour, String web_cancle_ymd, String lect_cnt, String classroom, String lecturer_cd, String lecturer_cd1,
			String start_ymd, String end_ymd, String capacity_no, String subject_fg, String regis_fee,
			String fix_pay_yn, String fix_amt, String fix_rate, String pay_day, String food_yn, String food_amt,
			String web_lecturer_nm, String web_lecturer_nm1, String month_no, String month_no1, String subject_nm,
			String cancled_list, String login_seq, String cus_no, String cus_no1, String corp_fg, String is_two, String regis_fee_cnt, String food_amt_cnt,String isLec,
			String lectmgmt_no, String thumbnail_img, String detail_img, String end_yn) {
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("day_flag", day_flag);
		map.put("lect_hour", lect_hour);
		map.put("web_cancle_ymd", web_cancle_ymd);
		map.put("lect_cnt", lect_cnt);
		map.put("classroom", classroom);
		map.put("lecturer_cd", lecturer_cd);
		map.put("lecturer_cd1", lecturer_cd1);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("capacity_no", capacity_no);
		map.put("subject_fg", subject_fg);
		map.put("regis_fee", regis_fee);
		map.put("fix_pay_yn", fix_pay_yn);
		map.put("fix_amt", fix_amt);
		map.put("fix_rate", fix_rate);
		map.put("pay_day", pay_day);
		map.put("food_yn", food_yn);
		map.put("food_amt", food_amt);
		map.put("web_lecturer_nm", web_lecturer_nm);
		map.put("web_lecturer_nm1", web_lecturer_nm1);
		map.put("month_no", month_no);
		map.put("month_no1", month_no1);
		map.put("subject_nm", subject_nm);
		map.put("cancled_list", cancled_list);
		map.put("login_seq", login_seq);
		map.put("cus_no", cus_no);
		map.put("cus_no1", cus_no1);
		map.put("corp_fg", corp_fg);
		map.put("is_two", is_two);
		map.put("regis_fee_cnt", regis_fee_cnt);
		map.put("food_amt_cnt", food_amt_cnt);
		map.put("isLec", isLec);
		map.put("lectmgmt_no", lectmgmt_no);
		map.put("thumbnail_img", thumbnail_img);
		map.put("detail_img", detail_img);
		map.put("end_yn", end_yn);
		
		
		getSqlSession().insert(NS + ".insPelt", map);		
	}
	
	
	public void insContract(String store, String period,String cus_no, String subject_cd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("cus_no", cus_no);
		map.put("subject_cd", subject_cd);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insContract", map);
	}
	
	public void insAttend(String store, String period, String subject_cd, String login_seq,String isLec,String cust_no,String dayChk,String child_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("login_seq", login_seq);
		map.put("isLec", isLec);
		map.put("cust_no", cust_no);
		map.put("dayChk", dayChk);
		map.put("child_no", child_no);
		getSqlSession().insert(NS + ".insAttend", map);
	}
	
	public void uptAttend(HashMap<String, Object> param) {
		System.out.println("확인! : "+param);
		getSqlSession().update(NS + ".uptAttend", param);
	}
	
	public void uptAttendDayChk(String store,String period,String subject_cd,String dayChk) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("dayChk", dayChk);
		
		getSqlSession().update(NS + ".uptAttendDayChk", map);
	}
	
	public void uptAttendDayChk_X(String store,String period,String subject_cd,String dayChk) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("dayChk", dayChk);
		
		getSqlSession().update(NS + ".uptAttendDayChk_X", map);
	}
	
	public List<HashMap<String, Object>> selLectCate(String insShortName) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("insShortName", insShortName);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".selLectCate", map);
		return list;
	}
	public List<HashMap<String, Object>> selLastCode() {
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".selLastCode");
		return list;
	}
	public void insBigCode(int insCode, String insShortName, String insLongName, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("insCode", insCode);
		map.put("insShortName", insShortName);
		map.put("insLongName", insLongName);
		map.put("login_seq", login_seq);
		
		getSqlSession().insert(NS + ".insBigCode", map);
	}
	public List<HashMap<String, Object>> selSectName(String sect_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sect_nm", sect_nm);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".selSectName", map);
		return list;
	}
	public List<HashMap<String, Object>> selLastSect(String store, String main_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("main_cd", main_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".selLastSect", map);
		return list;
	}
	public void insMiddleCode(String store, String main_cd, String sect_cd, String sect_nm, String contents, String performance, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("sect_nm", sect_nm);
		map.put("contents", contents);
		map.put("performance", performance);
		map.put("login_seq", login_seq);
		
		getSqlSession().insert(NS + ".insMiddleCode", map);
	}
	public void upSectPerformance(String store, String main_cd, String sect_cd, String selAction) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("performance", selAction);
		
		getSqlSession().update(NS + ".upSectPerformance", map);
	}
	public void upSectPerformance_del(String store, String main_cd, String sect_cd, String selAction) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("performance", selAction);
		
		getSqlSession().update(NS + ".upSectPerformance_del", map);
	}
	public void insRoom(String store, String room_nm, String contents, String location, String capacity_no, String area_size, String usage, String delete_yn, String login_seq) {
		int SEQ_NO = getSqlSession().selectOne(NS + ".getRoomSeq");
		HashMap<String, Object> map = new HashMap<>();
		map.put("SEQ_NO", SEQ_NO);
		map.put("store", store);
		map.put("room_nm", room_nm);
		map.put("contents", contents);
		map.put("location", location);
		map.put("capacity_no", capacity_no);
		map.put("area_size", area_size);
		map.put("usage", usage);
		map.put("delete_yn", delete_yn);
		map.put("login_seq", login_seq);
		
		getSqlSession().insert(NS + ".insRoom", map);
	}
	public void editRoom(String store, String room_nm, String contents, String location, String capacity_no, String area_size, String usage, String delete_yn, String login_seq, String seq) {
		int SEQ_NO = getSqlSession().selectOne(NS + ".getRoomSeq");
		HashMap<String, Object> map = new HashMap<>();
		map.put("SEQ_NO", SEQ_NO);
		map.put("store", store);
		map.put("room_nm", room_nm);
		map.put("contents", contents);
		map.put("location", location);
		map.put("capacity_no", capacity_no);
		map.put("area_size", area_size);
		map.put("usage", usage);
		map.put("delete_yn", delete_yn);
		map.put("login_seq", login_seq);
		map.put("seq", seq);
		
		getSqlSession().update(NS + ".editRoom", map);
	}
	public List<HashMap<String, Object>> getRoomCount(String store, String del_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("del_yn", del_yn);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRoomCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getRoom(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String del_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		map.put("store", store);
		map.put("del_yn", del_yn);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRoom", map);
		return list;
	}
	public void upRoomChange(String seq, String delete_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq);
		map.put("delete_yn", delete_yn);
		
		getSqlSession().update(NS + ".upRoomChange", map);
	}
	public void upCateChange(String maincd, String delete_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("maincd", maincd);
		map.put("delete_yn", delete_yn);
		
		getSqlSession().update(NS + ".upCateChange", map);
	}
	public List<HashMap<String, Object>> getRoomByStore(String store, String delete_yn) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("delete_yn", delete_yn);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getRoomByStore", map);
		return list;
	}
	public List<HashMap<String, Object>> getLectListCount(String store, String period, String search_type, String search_name, String pelt_status, String subject_fg, String act,
				String search_start, String search_end, String lect_cnt_start, String lect_cnt_end, String lect_nm, String main_cd, String sect_cd, 
				String day_flag) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("act", act);
		
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("lect_cnt_start", lect_cnt_start);
		map.put("lect_cnt_end", lect_cnt_end);
		map.put("lect_nm", lect_nm);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("day_flag", day_flag);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectListCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getLectList(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String search_type, String search_name, String pelt_status, String subject_fg, String act,
				String search_start, String search_end, String lect_cnt_start, String lect_cnt_end, String lect_nm, String main_cd, String sect_cd, 
				String day_flag) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("act", act);
		
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("lect_cnt_start", lect_cnt_start);
		map.put("lect_cnt_end", lect_cnt_end);
		map.put("lect_nm", lect_nm);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("day_flag", day_flag);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLectList", map);
		return list;
	}
	
	
	
	public List<HashMap<String, Object>> getAttendLectListCount(String store, String period, String search_type, String search_name, String pelt_status, String subject_fg, String act,
			String search_start, String search_end, String lect_cnt_start, String lect_cnt_end, String lect_nm, String main_cd, String sect_cd, 
			String day_flag) {
	
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("act", act);
		
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("lect_cnt_start", lect_cnt_start);
		map.put("lect_cnt_end", lect_cnt_end);
		map.put("lect_nm", lect_nm);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("day_flag", day_flag);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAttendLectListCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getAttendLectList(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String search_type, String search_name, String pelt_status, String subject_fg, String act,
				String search_start, String search_end, String lect_cnt_start, String lect_cnt_end, String lect_nm, String main_cd, String sect_cd, 
				String day_flag) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("act", act);
		
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("lect_cnt_start", lect_cnt_start);
		map.put("lect_cnt_end", lect_cnt_end);
		map.put("lect_nm", lect_nm);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("day_flag", day_flag);
		
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAttendLectList", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getPeltMid(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltMid", map);
		return list;
	}
	public void upPeltEnd(String store, String period, String subject_cd, String act) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("act", act);
		
		getSqlSession().update(NS + ".upPeltEnd", map);
	}
	public HashMap<String, Object> getPeltOne(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getPeltOne", map);
		return data;
	}
	public List<HashMap<String, Object>> getPeltDetail(String search_name, int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltDetail", map);
		return list;
	}
	public List<HashMap<String, Object>> getPeltDetailCount(String search_name, String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltDetailCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getPrevPeri(String store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPrevPeri", map);
		return list;
	}
	public List<HashMap<String, Object>> getPrevPelt(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPrevPelt", map);
		return list;
	}
	

//	public void upLect(String store, String period, String subject_cd, String subject_nm, String main_cd, String sect_cd, String lect_cd, String login_seq, String prev_subject_cd) {
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("store", store);
//		map.put("period", period);
//		map.put("subject_cd", subject_cd);
//		map.put("subject_nm", subject_nm);
//		map.put("main_cd", main_cd);
//		map.put("sect_cd", sect_cd);
//		map.put("lect_cd", lect_cd);
//		map.put("login_seq", login_seq);
//		map.put("prev_subject_cd", prev_subject_cd);
//		getSqlSession().update(NS + ".upLect", map);
//	}
	public int upPelt(String store, String period, String subject_cd, String main_cd, String sect_cd,
			String day_flag, String lect_hour, String web_cancle_ymd, String lect_cnt, String classroom, String lecturer_cd, String lecturer_cd1,
			String start_ymd, String end_ymd, String capacity_no, String subject_fg, String regis_fee,
			String fix_pay_yn, String fix_amt, String fix_rate, String pay_day, String food_yn, String food_amt,
			String web_lecturer_nm, String web_lecturer_nm1, String month_no, String month_no1, String subject_nm,
			String cancled_list, String login_seq, String cus_no, String cus_no1, String corp_fg, String is_two, String prev_subject_cd, String regis_fee_cnt, String food_amt_cnt) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("day_flag", day_flag);
		map.put("lect_hour", lect_hour);
		map.put("web_cancle_ymd", web_cancle_ymd);
		map.put("lect_cnt", lect_cnt);
		map.put("classroom", classroom);
		map.put("lecturer_cd", lecturer_cd);
		map.put("lecturer_cd1", lecturer_cd1);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("capacity_no", capacity_no);
		map.put("subject_fg", subject_fg);
		map.put("regis_fee", regis_fee);
		map.put("fix_pay_yn", fix_pay_yn);
		map.put("fix_amt", fix_amt);
		map.put("fix_rate", fix_rate);
		map.put("pay_day", pay_day);
		map.put("food_yn", food_yn);
		map.put("food_amt", food_amt);
		map.put("web_lecturer_nm", web_lecturer_nm);
		map.put("web_lecturer_nm1", web_lecturer_nm1);
		map.put("month_no", month_no);
		map.put("month_no1", month_no1);
		map.put("subject_nm", subject_nm);
		map.put("cancled_list", cancled_list);
		map.put("login_seq", login_seq);
		map.put("cus_no", cus_no);
		map.put("cus_no1", cus_no1);
		map.put("corp_fg", corp_fg);
		map.put("is_two", is_two);
		map.put("prev_subject_cd", prev_subject_cd);
		map.put("regis_fee_cnt", regis_fee_cnt);
		map.put("food_amt_cnt", food_amt_cnt);
		return getSqlSession().update(NS + ".upPelt", map);
		
	}

	public List<HashMap<String, Object>> getPlanDetail(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPlanDetail", map);
		return list;
	}
	public void upPlan(String store, String period, String subject_cd, String subject_nm, String lecturer_nm, String lecturer_career, String lecture_content, String etc, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("subject_nm", subject_nm);
		map.put("lecturer_nm", lecturer_nm);
		map.put("lecturer_career", lecturer_career);
		map.put("lecture_content", lecture_content);
		map.put("etc", etc);
		map.put("login_seq", login_seq);
		getSqlSession().update(NS + ".upPlan", map);
	}
	public void insPlan(String store, String period, String subject_cd, String subject_nm, String lecturer_nm, String lecturer_career, String lecture_content, String etc, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("subject_nm", subject_nm);
		map.put("lecturer_nm", lecturer_nm);
		map.put("lecturer_career", lecturer_career);
		map.put("lecture_content", lecture_content);
		map.put("etc", etc);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insPlan", map);
	}
	public List<HashMap<String, Object>> getPeltCount(String store, String period, String search_name, String pelt_status, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, 
			String day_flag, String is_finish) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
//		map.put("mon", mon);
//		map.put("tue", tue);
//		map.put("wed", wed);
//		map.put("thu", thu);
//		map.put("fri", fri);
//		map.put("sat", sat);
//		map.put("sun", sun);
		map.put("day_flag", day_flag);
		map.put("is_finish", is_finish);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltCount", map);
		return list;
	}
	public List<HashMap<String, Object>> getPeltCount2(String store, String period, String search_name, String pelt_status, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, 
			String day_flag, String is_finish) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
//		map.put("mon", mon);
//		map.put("tue", tue);
//		map.put("wed", wed);
//		map.put("thu", thu);
//		map.put("fri", fri);
//		map.put("sat", sat);
//		map.put("sun", sun);
		map.put("day_flag", day_flag);
		map.put("is_finish", is_finish);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPeltCount2", map);
		return list;
	}
	public int getPeltPer(String store, String period, String search_name, String pelt_status, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, 
			String day_flag, String is_finish) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
//		map.put("mon", mon);
//		map.put("tue", tue);
//		map.put("wed", wed);
//		map.put("thu", thu);
//		map.put("fri", fri);
//		map.put("sat", sat);
//		map.put("sun", sun);
		map.put("day_flag", day_flag);
		map.put("is_finish", is_finish);
		return getSqlSession().selectOne(NS + ".getPeltPer", map);
	}
	
	public List<HashMap<String, Object>> getPelt(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String search_name, String pelt_status, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, 
			String day_flag, String is_finish) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
//		map.put("mon", mon);
//		map.put("tue", tue);
//		map.put("wed", wed);
//		map.put("thu", thu);
//		map.put("fri", fri);
//		map.put("sat", sat);
//		map.put("sun", sun);
		map.put("day_flag", day_flag);
		map.put("is_finish", is_finish);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPelt", map);
		return list;
	}
	public List<HashMap<String, Object>> getPelt2(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String search_name, String pelt_status, String subject_fg, String search_start, String search_end, String main_cd, String sect_cd, 
			String day_flag, String is_finish) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
//		map.put("mon", mon);
//		map.put("tue", tue);
//		map.put("wed", wed);
//		map.put("thu", thu);
//		map.put("fri", fri);
//		map.put("sat", sat);
//		map.put("sun", sun);
		map.put("day_flag", day_flag);
		map.put("is_finish", is_finish);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getPelt2", map);
		return list;
	}
	
	
	public List<HashMap<String, Object>> getEndPeltCount(String store, String period, String search_type, String search_name, String pelt_status, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEndPeltCount", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getEndPelt(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String search_type, String search_name, String pelt_status, String subject_fg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("pelt_status", pelt_status);
		map.put("subject_fg", subject_fg);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getEndPelt", map);
		return list;
	}
	
	public void lectDel(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		getSqlSession().delete(NS + ".lectDel", map);
	}
	public void contractDel(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		getSqlSession().delete(NS + ".contractDel", map);
	}
	
	public HashMap<String, Object> getAttend(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getAttend", map);
		return data;
	}
	
	public HashMap<String, Object> getNewAttendeeCnt(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getNewAttendeeCnt", map);
		return data;
	}
	
	public void addNewAttendee(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		getSqlSession().insert(NS + ".addNewAttendee", map);
	}
	
	
	public HashMap<String, Object> getSeason(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getSeason", map);
		return data;
	}
	
	
	public List<HashMap<String, Object>> getAttendList(int s_rownum, int e_rownum, String order_by, String sort_type,String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAttendList", map);
		return list;
	}
	
	public List<HashMap<String, Object>> getAttendListCount(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getAttendListCount", map);
		return list;
	}

	public HashMap<String, Object> getRoomView(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getRoomView", map);
	}

	public HashMap<String, Object> getScheduleByPeri(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectOne(NS + ".getScheduleByPeri", map);
	}

	public List<HashMap<String, Object>> getPeltBySchedule(String store, String period, String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("seq", seq);
		return getSqlSession().selectList(NS + ".getPeltBySchedule", map);
	}

	public void upPeltImg(String store, String period, String subject_cd, String thumbnail, String detail) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd",subject_cd);
		map.put("thumbnail", thumbnail);
		map.put("detail", detail);
		getSqlSession().update(NS + ".upPeltImg", map);
	}

	public void delRoom(String seq_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		getSqlSession().delete(NS + ".delRoom", map);
	}

	public int getRoomCapacity(String seq_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		return getSqlSession().selectOne(NS + ".getRoomCapacity", map);
	}

	public int searchUseRoom(String seq_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq_no", seq_no);
		return getSqlSession().selectOne(NS + ".searchUseRoom", map);
	}

	public void delAttend(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		
		getSqlSession().delete(NS + ".delAttend", map);
	}
	
	public int lectMidChk(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectOne(NS + ".lectMidChk", map);
	}
	
	public int ContractDuplChk(String store, String period, String subject_cd,String cus_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("cus_no", cus_no);
		return getSqlSession().selectOne(NS + ".ContractDuplChk", map);
	}
	

	public HashMap<String, Object> getConnectInfo(String confirmStore, String confirmPeri, String prev_subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", confirmStore);
		map.put("period", confirmPeri);
		map.put("subject_cd", prev_subject_cd);
		return getSqlSession().selectOne(NS + ".getConnectInfo", map);
	}
	public HashMap<String, Object> getPrevInfo(String confirmStore, String confirmPeri, String prev_subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", confirmStore);
		map.put("period", confirmPeri);
		map.put("subject_cd", prev_subject_cd);
		return getSqlSession().selectOne(NS + ".getPrevInfo", map);
	}
	public int getJrCnt(String store, String subject_cd, String corp_tb, String lecturer_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", "");
		map.put("subject_cd", subject_cd);
		map.put("corp_tb", corp_tb);
		map.put("lecturer_cd", lecturer_cd);
		return getSqlSession().selectOne(NS + ".getJrCnt", map);
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

	public int getPereCnt(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectOne(NS + ".getPereCnt", map);
	}

	public void insWlecPrev(String store, String period, String prev_period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("prev_period", prev_period);
		getSqlSession().insert(NS + ".insWlecPrev", map);
	}
	public void insWlecPrev_one(String store, String period, String prev_period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("prev_period", prev_period);
		map.put("subject_cd", subject_cd);
		getSqlSession().insert(NS + ".insWlecPrev_one", map);
	}


	public List<HashMap<String, Object>> getAttendCustList(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectList(NS + ".getAttendCustList", map);
	}

	public List<HashMap<String, Object>> getSchedule_test(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectList(NS + ".getSchedule_test", map);
	}
	public List<HashMap<String, Object>> getSchedule(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectList(NS + ".getSchedule", map);
	}

	public void upPeltSchedule_test(String store, String period, String  subject_cd, String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("end_ymd", end_ymd);
		getSqlSession().update(NS + ".upPeltSchedule_test", map);
	}
	public void upPeltSchedule(String store, String period, String  subject_cd, String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("end_ymd", end_ymd);
		getSqlSession().update(NS + ".upPeltSchedule", map);
	}

	public int getReadyPelt(String store, String period, String prev_period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("prev_period", prev_period);
		return getSqlSession().selectOne(NS + ".getReadyPelt", map);
	}

	public void upPlanSubjectNm(String store, String period, String subject_cd, String subject_nm) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("subject_nm", subject_nm);
		getSqlSession().update(NS + ".upPlanSubjectNm", map);
	}
}
