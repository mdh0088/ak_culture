package ak_culture.controller.stat;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.Utils;
import ak_culture.model.basic.PeriDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.stat.StatDAO;

@Controller
@RequestMapping("/stat/*")

public class StatController {
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private StatDAO stat_dao;
	
	@Autowired
	private PeriDAO peri_dao;
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping("/perfor")
	public ModelAndView perfor(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/perfor");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/list");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/receipt")
	public ModelAndView receipt(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/receipt");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		return mav;
	}
	
	@RequestMapping("/getPeltList")
	@ResponseBody
	public HashMap<String, Object> getPeltList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		List<HashMap<String, Object>> listCnt = stat_dao.getPeltCount(store, period, subject_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		List<HashMap<String, Object>> listCnt_all = stat_dao.getPeltCount(store, period, "", "", "", "", "", "");
		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 20;
		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		}
		
		
		int block = 5;
		int pageNum = (int)Math.ceil((double)listCount/listSize);
		int nowBlock = (int)Math.ceil((double)page/block);
		int s_page = (nowBlock * block) - (block-1);
		if (s_page <= 1) 
		{
			s_page = 1;
		}
		int e_page = nowBlock*block;
		if (pageNum <= e_page) {
			e_page = pageNum;
		}
		
		int s_point = (page-1) * listSize;
		
		List<HashMap<String, Object>> list = stat_dao.getPelt(s_point, listSize*page, order_by, sort_type, store, period, subject_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		List<HashMap<String, Object>> list_pay_top = stat_dao.getPelt(0, 1, "desc", "uprice", store, period, subject_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		List<HashMap<String, Object>> list_person_top = stat_dao.getPelt(0, 1, "desc", "regis_no", store, period, subject_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		List<HashMap<String, Object>> list_new_top = stat_dao.getPelt(0, 1, "desc", "new", store, period, subject_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("list", list);
		map.put("list_pay_top", list_pay_top);
		map.put("list_person_top", list_person_top);
		map.put("list_new_top", list_new_top);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌별 접수 현황 조회", store+"/"+period);
		return map;
	}
	@RequestMapping("/getDetailList")
	@ResponseBody
	public HashMap<String, Object> getDetailList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String end_fg = Utils.checkNullString(request.getParameter("end_fg"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		List<HashMap<String, Object>> listCnt = stat_dao.getDetailCount(store, period, subject_fg, end_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		List<HashMap<String, Object>> listCnt_all = stat_dao.getDetailCount(store, period, "", "", "", "", "", "", "");
		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 20;
		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		}
		
		
		int block = 5;
		int pageNum = (int)Math.ceil((double)listCount/listSize);
		int nowBlock = (int)Math.ceil((double)page/block);
		int s_page = (nowBlock * block) - (block-1);
		if (s_page <= 1) 
		{
			s_page = 1;
		}
		int e_page = nowBlock*block;
		if (pageNum <= e_page) {
			e_page = pageNum;
		}
		
		int s_point = (page-1) * listSize;
		
		List<HashMap<String, Object>> list = stat_dao.getDetail(s_point, listSize*page, order_by, sort_type, store, period, subject_fg, end_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌별 회원 상세 현황 조회", store+"/"+period);
		return map;
	}
	@RequestMapping("/getDaylist")
	@ResponseBody
	public HashMap<String, Object> getDaylist(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		
		List<HashMap<String, Object>> list = stat_dao.getDaylist(store, period, search_start, search_end, isPerformance);
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "일별 접수 현황 조회", store+"/"+period);
		return map;
	}
	@RequestMapping("/getMemberList")
	@ResponseBody
	public HashMap<String, Object> getMemberList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		
		List<HashMap<String, Object>> list = stat_dao.getMemberList(store, period, search_start, search_end, isPerformance);
		List<HashMap<String, Object>> best_list = stat_dao.getMemberListBest(store, period, search_start, search_end, isPerformance);
		List<HashMap<String, Object>> gender_list = stat_dao.getMemberListGender(store, period, search_start, search_end, isPerformance);
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("best_list", best_list);
		map.put("gender_list", gender_list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "전체 회원 통계 조회", store+"/"+period);
		return map;
	}

	@RequestMapping("/receipt_detail")
	public ModelAndView receipt_detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/receipt_detail");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		return mav;
	}
	@RequestMapping("/receipt_day")
	public ModelAndView receipt_day(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/receipt_day");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/member_list")
	public ModelAndView member_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/member_list");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/member_lecture")
	public ModelAndView member_lecture(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/member_lecture");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		return mav;
	}
	@RequestMapping("/member_receipt")
	public ModelAndView member_receipt(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/member_receipt");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/payment")
	public ModelAndView payment(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/payment");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/attend")
	public ModelAndView attend(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/attend");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		return mav;
	}
	@RequestMapping("/getAttend")
	@ResponseBody
	public HashMap<String, Object> getAttend(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String selYear = Utils.checkNullString(request.getParameter("selYear"));
		String selSeason = Utils.checkNullString(request.getParameter("selSeason"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		//기수검색
		if("1".equals(selSeason)) { selSeason = "봄"; }
		else if("2".equals(selSeason)) { selSeason = "여름"; }
		else if("3".equals(selSeason)) { selSeason = "가을"; }
		else if("4".equals(selSeason)) { selSeason = "겨울"; }
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String s_peri = "";
		branchList = common_dao.getPeriList("02", selYear, selSeason);
		if(branchList.size() > 0)
		{
			s_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String b_peri = "";
		branchList = common_dao.getPeriList("03", selYear, selSeason);
		if(branchList.size() > 0)
		{
			b_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String p_peri = "";
		branchList = common_dao.getPeriList("04", selYear, selSeason);
		if(branchList.size() > 0)
		{
			p_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String w_peri = "";
		branchList = common_dao.getPeriList("05", selYear, selSeason);
		if(branchList.size() > 0)
		{
			w_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		//기수 검색
		List<HashMap<String, Object>> listCnt = stat_dao.getAttendCount(s_peri, b_peri, p_peri, w_peri, subject_fg, main_cd, sect_cd, search_name);
		List<HashMap<String, Object>> listCnt_all = stat_dao.getAttendCount(s_peri, b_peri, p_peri, w_peri, "", "", "", "");
		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 20;
		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		}
		
		
		int block = 5;
		int pageNum = (int)Math.ceil((double)listCount/listSize);
		int nowBlock = (int)Math.ceil((double)page/block);
		int s_page = (nowBlock * block) - (block-1);
		if (s_page <= 1) 
		{
			s_page = 1;
		}
		int e_page = nowBlock*block;
		if (pageNum <= e_page) {
			e_page = pageNum;
		}
		
		int s_point = (page-1) * listSize;
		
		List<HashMap<String, Object>> list = stat_dao.getAttend(s_point, listSize*page, order_by, sort_type, s_peri, b_peri, p_peri, w_peri, subject_fg, main_cd, sect_cd, search_name);
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사별 출강점 현황 조회", selYear+"/"+selSeason);
		return map;
	}
	
	@RequestMapping("/target")
	public ModelAndView target(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/stat/target");
		
		HttpSession session = request.getSession();
		Utils.setPeriControllerAll(mav, common_dao, session);
		mav.addObject("year", Utils.getDateNow("year"));
		
		return mav;
	}
	@Transactional
	@RequestMapping("/target_proc")
	public ModelAndView target_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/stat/target_proc");
		
		
		HttpSession session = request.getSession();
		String year = Utils.checkNullString(request.getParameter("selYear"));
		String season = Utils.checkNullString(request.getParameter("selSeason"));
		String b_regis = Utils.checkNullString(request.getParameter("b_regis")).replaceAll(",", "");
		String b_pay = Utils.checkNullString(request.getParameter("b_pay")).replaceAll(",", "");
		String s_regis = Utils.checkNullString(request.getParameter("s_regis")).replaceAll(",", "");
		String s_pay = Utils.checkNullString(request.getParameter("s_pay")).replaceAll(",", "");
		String p_regis = Utils.checkNullString(request.getParameter("p_regis")).replaceAll(",", "");
		String p_pay = Utils.checkNullString(request.getParameter("p_pay")).replaceAll(",", "");
		String w_regis = Utils.checkNullString(request.getParameter("w_regis")).replaceAll(",", "");
		String w_pay = Utils.checkNullString(request.getParameter("w_pay")).replaceAll(",", "");
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		try
		{
			if("".equals(year) || "".equals(season))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "연도/학기 설정 오류");
				
				return mav;
			}
			
			if(!"".equals(b_regis) && !"".equals(b_pay))
			{
				int cnt = stat_dao.isInTarget(year, season, "03");
				if(cnt == 0)
				{
					cnt = stat_dao.insTarget(year, season, "03", b_regis, b_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
				else
				{
					cnt = stat_dao.upTarget(year, season, "03", b_regis, b_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
			}
			if(!"".equals(s_regis) && !"".equals(s_pay))
			{
				int cnt = stat_dao.isInTarget(year, season, "02");
				if(cnt == 0)
				{
					cnt = stat_dao.insTarget(year, season, "02", s_regis, s_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
				else
				{
					cnt = stat_dao.upTarget(year, season, "02", s_regis, s_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
			}
			if(!"".equals(p_regis) && !"".equals(p_pay))
			{
				int cnt = stat_dao.isInTarget(year, season, "04");
				if(cnt == 0)
				{
					cnt = stat_dao.insTarget(year, season, "04", p_regis, p_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
				else
				{
					cnt = stat_dao.upTarget(year, season, "04", p_regis, p_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
			}
			if(!"".equals(w_regis) && !"".equals(w_pay))
			{
				int cnt = stat_dao.isInTarget(year, season, "05");
				if(cnt == 0)
				{
					cnt = stat_dao.insTarget(year, season, "05", w_regis, w_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
				else
				{
					cnt = stat_dao.upTarget(year, season, "05", w_regis, w_pay, login_seq);
					if(cnt == 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "정상적으로 저장되지 않았습니다.");
						return mav;
					}
				}
			}
			
			mav.addObject("isSuc", "success");
			mav.addObject("msg", "성공적으로 저장되었습니다.");
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "목표입력 등록", year+"/"+season);

			return mav;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "알 수 없는 오류가 발생하였습니다.");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return mav;
		}
		
	}
	@RequestMapping("/getTarget")
	@ResponseBody
	public List<HashMap<String, Object>> getTarget(HttpServletRequest request) {
		
		String year = Utils.checkNullString(request.getParameter("year"));
		String season = Utils.checkNullString(request.getParameter("season"));
		List<HashMap<String, Object>> list = stat_dao.getTarget(year, season);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "목표입력 조회", year+"/"+season);

	    return list;
	}
	@RequestMapping("/getStartYmd")
	@ResponseBody
	public String getStartYmd(HttpServletRequest request) {
		
		String selYear = Utils.checkNullString(request.getParameter("selYear"));
		String selSeason = Utils.checkNullString(request.getParameter("selSeason"));
		if("1".equals(selSeason)) { selSeason = "봄"; }
		else if("2".equals(selSeason)) { selSeason = "여름"; }
		else if("3".equals(selSeason)) { selSeason = "가을"; }
		else if("4".equals(selSeason)) { selSeason = "겨울"; }
		List<HashMap<String, Object>> branchList = common_dao.getPeriList("03", selYear, selSeason);
		if(branchList.size() > 0)
		{
			return Utils.checkNullString(branchList.get(0).get("ADULT_S_BGN_YMD"));
		}
		else
		{
			return "";
		}
	}
	@RequestMapping("/getStartYmdPeri")
	@ResponseBody
	public String getStartYmdPeri(HttpServletRequest request) {
		
		String period = Utils.checkNullString(request.getParameter("period"));
		HashMap<String, Object> branchList = peri_dao.getPeriOne(period, "03");
		if(branchList.size() > 0)
		{
			return Utils.checkNullString(branchList.get("ADULT_S_BGN_YMD"));
		}
		else
		{
			return "";
		}
	}
	@RequestMapping("/getTargetLong")
	@ResponseBody
	public List<HashMap<String, Object>> getTargetLong(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
//		String selYear2 = Utils.checkNullString(request.getParameter("selYear2"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
//		String selSeason2 = Utils.checkNullString(request.getParameter("selSeason2"));
		List<HashMap<String, Object>> list = stat_dao.getTargetLong(store, selYear1, selSeason1);
			
	    return list;
	}
	@RequestMapping("/getPeri")
	@ResponseBody
	public HashMap<String, Object> getPeri(HttpServletRequest request) {
		
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
		String selYear2 = Utils.checkNullString(request.getParameter("selYear2"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
		String selSeason2 = Utils.checkNullString(request.getParameter("selSeason2"));
		if("1".equals(selSeason1)) { selSeason1 = "봄"; }
		else if("2".equals(selSeason1)) { selSeason1 = "여름"; }
		else if("3".equals(selSeason1)) { selSeason1 = "가을"; }
		else if("4".equals(selSeason1)) { selSeason1 = "겨울"; }
		if("1".equals(selSeason2)) { selSeason2 = "봄"; }
		else if("2".equals(selSeason2)) { selSeason2 = "여름"; }
		else if("3".equals(selSeason2)) { selSeason2 = "가을"; }
		else if("4".equals(selSeason2)) { selSeason2 = "겨울"; }
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String s_start_peri = "";
		String s_end_peri = "";
		branchList = common_dao.getPeriList("02", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			s_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("02", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			s_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String b_start_peri = "";
		String b_end_peri = "";
		branchList = common_dao.getPeriList("03", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			b_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("03", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			b_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String p_start_peri = "";
		String p_end_peri = "";
		branchList = common_dao.getPeriList("04", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			p_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("04", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			p_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String w_start_peri = "";
		String w_end_peri = "";
		branchList = common_dao.getPeriList("05", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			w_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("05", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			w_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		//기수 검색
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("b_start_peri", b_start_peri);
		map.put("b_end_peri", b_end_peri);
		map.put("s_start_peri", s_start_peri);
		map.put("s_end_peri", s_end_peri);
		map.put("p_start_peri", p_start_peri);
		map.put("p_end_peri", p_end_peri);
		map.put("w_start_peri", w_start_peri);
		map.put("w_end_peri", w_end_peri);
		
		return map;
	}
//	@RequestMapping("/getPerfor")
//	@ResponseBody
//	public HashMap<String, Object> getPerfor(HttpServletRequest request) {
//		
//		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
//		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
//		String b_start_peri = Utils.checkNullString(request.getParameter("b_start_peri"));
//		String b_end_peri = Utils.checkNullString(request.getParameter("b_end_peri"));
//		String s_start_peri = Utils.checkNullString(request.getParameter("s_start_peri"));
//		String s_end_peri = Utils.checkNullString(request.getParameter("s_end_peri"));
//		String p_start_peri = Utils.checkNullString(request.getParameter("p_start_peri"));
//		String p_end_peri = Utils.checkNullString(request.getParameter("p_end_peri"));
//		String w_start_peri = Utils.checkNullString(request.getParameter("w_start_peri"));
//		String w_end_peri = Utils.checkNullString(request.getParameter("w_end_peri"));
//		
//		
//		System.out.println("subject_fg : "+subject_fg);
//		System.out.println("main_cd : "+main_cd);
//		
//		
//		System.out.println("b_start_peri : "+b_start_peri);
//		System.out.println("b_end_peri : "+b_end_peri);
//		System.out.println("s_start_peri : "+s_start_peri);
//		System.out.println("s_end_peri : "+s_end_peri);
//		System.out.println("p_start_peri : "+p_start_peri);
//		System.out.println("p_end_peri : "+p_end_peri);
//		System.out.println("w_start_peri : "+w_start_peri);
//		System.out.println("w_end_peri : "+w_end_peri);
//		
//		HashMap<String, Object> b_data = stat_dao.getPerfor("03", b_start_peri, b_end_peri, subject_fg, main_cd);
//		HashMap<String, Object> s_data = stat_dao.getPerfor("02", s_start_peri, s_end_peri, subject_fg, main_cd);
//		HashMap<String, Object> p_data = stat_dao.getPerfor("04", p_start_peri, p_end_peri, subject_fg, main_cd);
//		HashMap<String, Object> w_data = stat_dao.getPerfor("05", w_start_peri, w_end_peri, subject_fg, main_cd);
//		
//		HashMap<String, Object> map = new HashMap<>();
//		
//		map.put("b_person", b_data.get("PERSON"));
//		map.put("b_regis_fee", b_data.get("REGIS_FEE"));
//		map.put("b_web", b_data.get("WEB"));
//		map.put("b_mobile", b_data.get("MOBILE"));
//		map.put("s_person", s_data.get("PERSON"));
//		map.put("s_regis_fee", s_data.get("REGIS_FEE"));
//		map.put("s_web", s_data.get("WEB"));
//		map.put("s_mobile", s_data.get("MOBILE"));
//		map.put("p_person", p_data.get("PERSON"));
//		map.put("p_regis_fee", p_data.get("REGIS_FEE"));
//		map.put("p_web", p_data.get("WEB"));
//		map.put("p_mobile", p_data.get("MOBILE"));
//		map.put("w_person", w_data.get("PERSON"));
//		map.put("w_regis_fee", w_data.get("REGIS_FEE"));
//		map.put("w_web", w_data.get("WEB"));
//		map.put("w_mobile", w_data.get("MOBILE"));
//		return map;
//	}
	@RequestMapping("/getPayment")
	@ResponseBody
	public HashMap<String, Object> getPayment(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String target_store = Utils.checkNullString(request.getParameter("target_store"));
		String target_period = Utils.checkNullString(request.getParameter("target_period"));
		HashMap<String, Object> branchList = peri_dao.getPeriOne(period, store);
		HashMap<String, Object> branchList_target = peri_dao.getPeriOne(target_period, target_store);
		
		
		String lect_ym_1 = Utils.checkNullString(branchList.get("TECH_1_YMD"));
		String lect_ym_2 = Utils.checkNullString(branchList.get("TECH_2_YMD"));
		String lect_ym_3 = Utils.checkNullString(branchList.get("TECH_3_YMD"));
		String lect_ym_1_target = Utils.checkNullString(branchList_target.get("TECH_1_YMD"));
		String lect_ym_2_target = Utils.checkNullString(branchList_target.get("TECH_2_YMD"));
		String lect_ym_3_target = Utils.checkNullString(branchList_target.get("TECH_3_YMD"));
		if(!"".equals(lect_ym_1)) {lect_ym_1 = lect_ym_1.substring(0,6);}
		if(!"".equals(lect_ym_2)) {lect_ym_2 = lect_ym_2.substring(0,6);}
		if(!"".equals(lect_ym_3)) {lect_ym_3 = lect_ym_3.substring(0,6);}
		if(!"".equals(lect_ym_1_target)) {lect_ym_1_target = lect_ym_1_target.substring(0,6);}
		if(!"".equals(lect_ym_2_target)) {lect_ym_2_target = lect_ym_2_target.substring(0,6);}
		if(!"".equals(lect_ym_3_target)) {lect_ym_3_target = lect_ym_3_target.substring(0,6);}
		
		List<HashMap<String, Object>> list_1 = stat_dao.getPayment(store, period, target_store, target_period, lect_ym_1, lect_ym_1_target);
		List<HashMap<String, Object>> list_2 = stat_dao.getPayment(store, period, target_store, target_period, lect_ym_2, lect_ym_2_target);
		List<HashMap<String, Object>> list_3 = stat_dao.getPayment(store, period, target_store, target_period, lect_ym_3, lect_ym_3_target);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list_1", list_1);
		map.put("list_2", list_2);
		map.put("list_3", list_3);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 지급 현황 조회", store+"/"+period+"/"+target_store+"/"+target_period);
		return map;
	}
	@RequestMapping("/getRoomList")
	@ResponseBody
	public HashMap<String, Object> getRoomList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		List<HashMap<String, Object>> list = stat_dao.getRoomList(store, period, subject_fg);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의실별 접수 현황 조회", store+"/"+period);
		return map;
	}
	@RequestMapping("/getPerforLect")
	@ResponseBody
	public HashMap<String, Object> getPerforLect(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String target_store = Utils.checkNullString(request.getParameter("target_store"));
		String target_period = Utils.checkNullString(request.getParameter("target_period"));
		String start_ymd1 = Utils.checkNullString(request.getParameter("start_ymd1")).replaceAll("-", "");
		String end_ymd1 = Utils.checkNullString(request.getParameter("end_ymd1")).replaceAll("-", "");
		String start_ymd2 = Utils.checkNullString(request.getParameter("start_ymd2")).replaceAll("-", "");
		String end_ymd2 = Utils.checkNullString(request.getParameter("end_ymd2")).replaceAll("-", "");
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		List<HashMap<String, Object>> list = stat_dao.getPerforLect(store, period, target_store, target_period, start_ymd1, end_ymd1, start_ymd2, end_ymd2, isPerformance);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌군별 실적 분석 조회", store+"/"+period+"/"+target_store+"/"+target_period);
		return map;
	}
//	@RequestMapping("/getPerforLect")
//	@ResponseBody
//	public HashMap<String, Object> getPerforLect(HttpServletRequest request) {
//		
//		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
//		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
//		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
//		String store = Utils.checkNullString(request.getParameter("store"));
//		String period = Utils.checkNullString(request.getParameter("period"));
//		String target_store = Utils.checkNullString(request.getParameter("target_store"));
//		String target_period = Utils.checkNullString(request.getParameter("target_period"));
//		
//		
//		HashMap<String, Object> data = stat_dao.getPerforLect(store, period, subject_fg, main_cd, sect_cd);
//		HashMap<String, Object> lect_data = stat_dao.getPerforLectCnt(store, period, subject_fg, main_cd, sect_cd);
//		HashMap<String, Object> target_data = stat_dao.getPerforLect(target_store, target_period, subject_fg, main_cd, sect_cd);
//		HashMap<String, Object> target_lect_data = stat_dao.getPerforLectCnt(target_store, target_period, subject_fg, main_cd, sect_cd);
//		
//		HashMap<String, Object> map = new HashMap<>();
//		
//		if(data != null)
//		{
//			map.put("lect_cnt", Utils.checkNullInt(lect_data.get("LECT_CNT")));
//			map.put("person", Utils.checkNullInt(data.get("PERSON")));
//			map.put("regis_fee", Utils.checkNullInt(data.get("REGIS_FEE")));
//		}
//		if(target_data != null)
//		{
//			map.put("target_lect_cnt", Utils.checkNullInt(target_lect_data.get("LECT_CNT")));
//			map.put("target_person", Utils.checkNullInt(target_data.get("PERSON")));
//			map.put("target_regis_fee", Utils.checkNullInt(target_data.get("REGIS_FEE")));
//		}
//		
//		return map;
//	}
	@RequestMapping("/getPerfor")
	@ResponseBody
	public HashMap<String, Object> getPerfor(HttpServletRequest request) {
		
		//기수조회
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
		String selYear2 = Utils.checkNullString(request.getParameter("selYear2"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
		String selSeason2 = Utils.checkNullString(request.getParameter("selSeason2"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "");
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		System.out.println("start_ymd : "+start_ymd);
		System.out.println("end_ymd : "+end_ymd);
		System.out.println("isPerformance : "+isPerformance);
		
		if("1".equals(selSeason1)) { selSeason1 = "봄"; }
		else if("2".equals(selSeason1)) { selSeason1 = "여름"; }
		else if("3".equals(selSeason1)) { selSeason1 = "가을"; }
		else if("4".equals(selSeason1)) { selSeason1 = "겨울"; }
		if("1".equals(selSeason2)) { selSeason2 = "봄"; }
		else if("2".equals(selSeason2)) { selSeason2 = "여름"; }
		else if("3".equals(selSeason2)) { selSeason2 = "가을"; }
		else if("4".equals(selSeason2)) { selSeason2 = "겨울"; }
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String s_start_peri = "000";
		String s_end_peri = "999";
		branchList = common_dao.getPeriList("02", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			s_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("02", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			s_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String b_start_peri = "000";
		String b_end_peri = "999";
		branchList = common_dao.getPeriList("03", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			b_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("03", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			b_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String p_start_peri = "000";
		String p_end_peri = "999";
		branchList = common_dao.getPeriList("04", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			p_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("04", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			p_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = null;
		String w_start_peri = "000";
		String w_end_peri = "999";
		branchList = common_dao.getPeriList("05", selYear1, selSeason1);
		if(branchList.size() > 0)
		{
			w_start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		branchList = common_dao.getPeriList("05", selYear2, selSeason2);
		if(branchList.size() > 0)
		{
			w_end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
		}
		//기수 검색
		
		
		List<HashMap<String, Object>> list = stat_dao.getPerforUnion(b_start_peri, b_end_peri, s_start_peri, s_end_peri, p_start_peri, p_end_peri, w_start_peri, w_end_peri, start_ymd, end_ymd, isPerformance);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "점별 실적 조회", selYear1+"/"+selSeason1+"~"+selYear1+"/"+selSeason1);

		return map;
	}
	@RequestMapping("/getMemberLecture")
	@ResponseBody
	public HashMap<String, Object> getMemberLecture(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		List<HashMap<String, Object>> listCnt = stat_dao.getMemberLectureCount(store, period, subject_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		List<HashMap<String, Object>> listCnt_all = stat_dao.getMemberLectureCount(store, period, "", "", "", "", "", isPerformance);
		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 20;
		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		}
		
		
		int block = 5;
		int pageNum = (int)Math.ceil((double)listCount/listSize);
		int nowBlock = (int)Math.ceil((double)page/block);
		int s_page = (nowBlock * block) - (block-1);
		if (s_page <= 1) 
		{
			s_page = 1;
		}
		int e_page = nowBlock*block;
		if (pageNum <= e_page) {
			e_page = pageNum;
		}
		
		int s_point = (page-1) * listSize;
		
		List<HashMap<String, Object>> list = stat_dao.getMemberLecture(s_point, listSize*page, order_by, sort_type, store, period, subject_fg, search_start, search_end, main_cd,sect_cd, isPerformance);
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌별 회원 구분 조회", store+"/"+period);
		return map;
	}
	
}