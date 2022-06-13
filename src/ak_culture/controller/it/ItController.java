package ak_culture.controller.it;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.AKCommon;
import ak_culture.classes.BABatchRun;
import ak_culture.classes.Utils;
import ak_culture.model.akris.AkrisDAO;
import ak_culture.model.basic.PeriDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.it.ItDAO;
import ak_culture.model.lecture.LectDAO;

@Controller
@RequestMapping("/it/*")

public class ItController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	
	@Autowired
	private CommonDAO common_dao;
	@Autowired
	private AkrisDAO akris_dao;
	@Autowired
	private ItDAO it_dao;
	@Autowired
	private PeriDAO peri_dao;
	@Autowired
	private LectDAO lect_dao;
	@Value("${batch_ip}")
	private String batch_ip;
	
	
	@RequestMapping("/a")
	public ModelAndView a(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/a");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/change")
	public ModelAndView change(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/change");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		String springVersion = org.springframework.core.SpringVersion.getVersion();

		System.out.println("스프링 프레임워크 버전 : " + springVersion);
		return mav;
	}
	@RequestMapping("/getChange")
	@ResponseBody
	public HashMap<String, Object> getChange(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		List<HashMap<String, Object>> listCnt = it_dao.getPeltCount(search_type, search_name, store, period);
		List<HashMap<String, Object>> listCnt_all = it_dao.getPeltCount("", "", store, period);
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
		
		List<HashMap<String, Object>> list = it_dao.getPelt(search_type, search_name, s_point, listSize*page, order_by, sort_type, store, period);
		for(int i = 0; i < list.size(); i++)
		{
			String l_store = Utils.checkNullString(list.get(i).get("STORE"));
			String l_period = Utils.checkNullString(list.get(i).get("PERIOD"));
			String l_subject_cd = Utils.checkNullString(list.get(i).get("SUBJECT_CD"));
			
			int aclass_cnt = 0;
			List<HashMap<String, Object>> a_list = it_dao.getACLASS(l_store, l_period, l_subject_cd);
			for(int j = 0; j < a_list.size(); j++)
			{
				if("A".equals(a_list.get(j).get("ACLASS")))
				{
					aclass_cnt++;
				}
			}
			list.get(i).put("A_CNT", aclass_cnt);
			
			
			List<HashMap<String, Object>> ch_list = it_dao.getChfix(l_store, l_period, l_subject_cd);
			if(ch_list.size() > 0)
			{
				list.get(i).put("NEXT_FIX_PAY_YN", ch_list.get(0).get("NEXT_FIX_PAY_YN"));
				list.get(i).put("NEXT_FIX_AMT", ch_list.get(0).get("NEXT_FIX_AMT"));
				list.get(i).put("NEXT_FIX_RATE", ch_list.get(0).get("NEXT_FIX_RATE"));
				list.get(i).put("PREV_FIX_PAY_YN", ch_list.get(0).get("PREV_FIX_PAY_YN"));
				list.get(i).put("PREV_FIX_AMT", ch_list.get(0).get("PREV_FIX_AMT"));
				list.get(i).put("PREV_FIX_RATE", ch_list.get(0).get("PREV_FIX_RATE"));
				list.get(i).put("NEXT_CREATE_DATE", ch_list.get(0).get("CREATE_DATE"));
				list.get(i).put("NEXT_CREATE_NAME", ch_list.get(0).get("CREATE_NAME"));
				list.get(i).put("NEXT_UPDATE_DATE", ch_list.get(0).get("UPDATE_DATE"));
				list.get(i).put("NEXT_UPDATE_NAME", ch_list.get(0).get("UPDATE_NAME"));
				list.get(i).put("CONFIRM_YN", ch_list.get(0).get("CONFIRM_YN"));
			}
			else
			{
				list.get(i).put("NEXT_FIX_PAY_YN", "");
				list.get(i).put("NEXT_FIX_AMT", "");
				list.get(i).put("NEXT_FIX_RATE", "");
				list.get(i).put("PREV_FIX_PAY_YN", "");
				list.get(i).put("PREV_FIX_AMT", "");
				list.get(i).put("PREV_FIX_RATE", "");
				list.get(i).put("NEXT_CREATE_DATE", "");
				list.get(i).put("NEXT_CREATE_NAME", "");
				list.get(i).put("NEXT_UPDATE_DATE", "");
				list.get(i).put("NEXT_UPDATE_NAME", "");
				list.get(i).put("CONFIRM_YN", "");
			}
			
		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 기준 변경 조회", store+"/"+period);

		return map;
	}
	@RequestMapping("/getPaymentCheck")
	@ResponseBody
	public HashMap<String, Object> getPaymentCheck(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym")).replaceAll("-", "");
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String pay_day = "";
		String pay_day2 = "";
		
		HashMap<String, Object> data = it_dao.getPaydayByPeri(store, period);
		if(data != null)
		{
			if(data.get("TECH_1_YMD") != null && data.get("TECH_2_YMD") != null && data.get("TECH_3_YMD") != null)
			{
				if(lect_ym.equals(Utils.checkNullString(data.get("TECH_1_YMD")).substring(0, 6)))
				{
					pay_day = "1";
					pay_day2 = Utils.checkNullString(data.get("TECH_1_YMD")).substring(0, 8);
				}
				else if(lect_ym.equals(Utils.checkNullString(data.get("TECH_2_YMD")).substring(0, 6)))
				{
					pay_day = "2";
					pay_day2 = Utils.checkNullString(data.get("TECH_2_YMD")).substring(0, 8);
				}
				else if(lect_ym.equals(Utils.checkNullString(data.get("TECH_3_YMD")).substring(0, 6)))
				{
					pay_day = "3";
					pay_day2 = Utils.checkNullString(data.get("TECH_3_YMD")).substring(0, 8);
				}
			}
			else
			{
				pay_day = "";
			}
		}
		HashMap<String, Object> map = new HashMap<>();
		if(!"".equals(pay_day))
		{
			String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
			String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
			String submit_yn = Utils.checkNullString(request.getParameter("submit_yn"));
			String end_yn = Utils.checkNullString(request.getParameter("end_yn"));
			String journal_yn = Utils.checkNullString(request.getParameter("journal_yn"));
			String act = Utils.checkNullString(request.getParameter("act")); //지급제외여부
			
			List<HashMap<String, Object>> listCnt = it_dao.getCorpListCount(corp_fg, store, period, lect_ym, subject_fg, end_yn, journal_yn, pay_day, act, submit_yn);
			List<HashMap<String, Object>> listCnt_all = it_dao.getCorpListCount(corp_fg, store, period, "", "", "", "", "", act, "");
			
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
			
			List<HashMap<String, Object>> list = it_dao.getCorpList(s_point, listSize*page, order_by, sort_type, corp_fg, store, period, lect_ym, subject_fg, end_yn, journal_yn, pay_day, act, submit_yn); 
			map.put("list", list);
			map.put("listCnt", listCnt.get(0).get("CNT"));
			map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
			map.put("page", page);
			map.put("s_page", s_page);
			map.put("e_page", e_page);
			map.put("pageNum", pageNum);
			map.put("order_by", order_by);
			map.put("sort_type", sort_type);
			map.put("isSuc", "success");
			map.put("pay_day2", pay_day2);
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "대상연월을 확인해주세요.");
		}
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "지급기준 점검 조회", store+"/"+period);

		return map;
		
	}
	@RequestMapping("/getRegisEnd")
	@ResponseBody
	public HashMap<String, Object> getRegisEnd(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym")).replaceAll("-", "");
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		
		int cnt = it_dao.getRegisEndCount(corp_fg, lect_ym);
		
		
		List<HashMap<String, Object>> list = it_dao.getRegisEndList(corp_fg, store, period, lect_ym, subject_fg, search_name, order_by, sort_type); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", list.size());
		map.put("listCnt_all", cnt);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 마감내역 조회", store+"/"+period);

		return map;
		
	}
	@RequestMapping("/getFoodEnd")
	@ResponseBody
	public HashMap<String, Object> getFoodEnd(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String food_ym = Utils.checkNullString(request.getParameter("food_ym")).replaceAll("-", "");
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		
		int cnt = it_dao.getFoodEndCount(food_ym);
		
		
		List<HashMap<String, Object>> list = it_dao.getFoodEndList(store, period, food_ym, search_name, order_by, sort_type);
		
		
//		int now_food_amt = 0;
//		for(int i = 0; i < list.size(); i++)
//		{
//			List<HashMap<String, Object>> ym_list = it_dao.getFoodYmList(store, period, Utils.checkNullString(list.get(i).get("SUBJECT_CD")));
//			int prev_food_amt = 0;
//			String prev_food_ym = "";
//			for(int z = 0; z < ym_list.size(); z++)
//			{
//				if(food_ym.equals(Utils.checkNullString(ym_list.get(z).get("FOOD_YM"))))
//				{
//					if(z == 0)
//					{
//						prev_food_ym = food_ym; //1차라면 앞에께 없으니까 현재 기지급액이 현지급액이 된다.
//					}
//					else
//					{
//						prev_food_ym = Utils.checkNullString(ym_list.get(z-1).get("FOOD_YM"));
//						
//					}
//				}
//			}
//			
//			prev_food_amt = it_dao.getFoodEndOne(store, period, prev_food_ym, Utils.checkNullString(list.get(i).get("SUBJECT_CD")));
//			
//			now_food_amt = Utils.checkNullInt(list.get(i).get("FD_PAY_AMT")); //1차라면 앞에께 없으니까 현재 기지급액이 현지급액이 된다.
//			if(!food_ym.equals(prev_food_ym)) //1차가 아니라면 현재 기지급액과 이전 기지급액을 뺀다.
//			{
//				now_food_amt = now_food_amt - prev_food_amt;
//			}
//			list.get(i).put("NOW_FOOD_AMT", Integer.toString(now_food_amt));
//		}
		
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", list.size());
		map.put("listCnt_all", cnt);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "재료비 마감내역 조회", store+"/"+period);

		return map;
		
	}
	@RequestMapping("/getChangeOne")
	@ResponseBody
	public List<HashMap<String, Object>> getChangeOne(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		List<HashMap<String, Object>> list = it_dao.getChfix(store, period, subject_cd);
			
		return list;
			
	}
	
	@RequestMapping("/change_master")
	public ModelAndView change_master(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/change_master");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String store_nm = "";
		if("02".equals(store)){store_nm = "수원점";}
		else if("03".equals(store)){store_nm = "분당점";}
		else if("04".equals(store)){store_nm = "평택점";}
		else if("05".equals(store)){store_nm = "원주점";}
		HashMap<String, Object> data = peri_dao.getPeriOne(Utils.checkNullString(request.getParameter("period")), store); 
		
		mav.addObject("r_store", store);
		mav.addObject("r_store_nm", store_nm);
		mav.addObject("r_period", Utils.checkNullString(request.getParameter("period")));
		if(data != null)
		{
			mav.addObject("r_webtext", Utils.checkNullString(data.get("WEB_TEXT")));
		}
		mav.addObject("r_subject_cd", Utils.checkNullString(request.getParameter("subject_cd")));
		
		return mav;
	}
	
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/regisEnd")
	public ModelAndView regisEnd(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/regisEnd");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/foodEnd")
	public ModelAndView foodEnd(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/foodEnd");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/corp1_write")
	public ModelAndView corp1_write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/corp1_write");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/corp2_write")
	public ModelAndView corp2_write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/corp2_write");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		return mav;
	}
	@RequestMapping("/food_write")
	public ModelAndView food_write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/food_write");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		return mav;
	}
	@RequestMapping("/end")
	public ModelAndView end(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/end");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/elect")
	public ModelAndView elect(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/elect");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}

	@RequestMapping("/status")
	public ModelAndView status(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/status");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/statusByPeri")
	public ModelAndView statusByPeri(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/statusByPeri");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/material")
	public ModelAndView material(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/material");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/tally")
	public ModelAndView tally(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/tally");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/payment")
	public ModelAndView payment(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/payment");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/check")
	public ModelAndView check(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/check");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/deadline")
	public ModelAndView deadline(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/it/deadline");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/getPeltOne")
	@ResponseBody
	public List<HashMap<String, Object>> getPeltOne(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		
		return list;
		
	}
	@RequestMapping("/sendChange")
	@ResponseBody
	public HashMap<String, Object> sendChange(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String prev_fix_pay_yn = Utils.checkNullString(request.getParameter("prev_fix_pay_yn"));
		String prev_fix_data = Utils.checkNullString(request.getParameter("prev_fix_data")).replaceAll(",", "");
		String next_fix_pay_yn = Utils.checkNullString(request.getParameter("next_fix_pay_yn"));
		String next_fix_data = Utils.checkNullString(request.getParameter("next_fix_data")).replaceAll(",", "");
		String change_reason = Utils.repWord(Utils.checkNullString(request.getParameter("change_reason")));
		
		
		if("정액".equals(prev_fix_pay_yn))
		{
			prev_fix_pay_yn = "Y";
		}
		else if("정률".equals(prev_fix_pay_yn))
		{
			prev_fix_pay_yn = "N";
		}
		
		String prev_fix_amt = "0";
		String prev_fix_rate = "0";
		
		if("N".equals(prev_fix_pay_yn))
		{
			prev_fix_rate = prev_fix_data;
		}
		else
		{
			prev_fix_amt = prev_fix_data;
		}
		
		String next_fix_amt = "0";
		String next_fix_rate = "0";
		
		if("N".equals(next_fix_pay_yn))
		{
			next_fix_rate = next_fix_data;
		}
		else
		{
			next_fix_amt = next_fix_data;
		}
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		List<HashMap<String, Object>> ch_list = it_dao.getChfix(store, period, subject_cd);
		if(ch_list.size() > 0)
		{
			it_dao.upChfix(store, period, subject_cd, prev_fix_pay_yn, prev_fix_amt, prev_fix_rate, next_fix_pay_yn, next_fix_amt, next_fix_rate, change_reason, login_seq);
		}
		else
		{
			it_dao.insChfix(store, period, subject_cd, prev_fix_pay_yn, prev_fix_amt, prev_fix_rate, next_fix_pay_yn, next_fix_amt, next_fix_rate, change_reason, login_seq);
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 기준 변경 신청", store+"/"+period+"/"+subject_cd);

        return map;
		
	}
	@Transactional
	@RequestMapping("/changeApprove")
	@ResponseBody
	public HashMap<String, Object> changeApprove(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String act = Utils.checkNullString(request.getParameter("act"));
		String no_reason = Utils.checkNullString(request.getParameter("no_reason"));
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		List<HashMap<String, Object>> list = it_dao.getChfix(store, period, subject_cd);
		if(!"1".equals(Utils.checkNullString(list.get(0).get("CONFIRM_YN"))))
		{
			map.put("isSuc", "fail");
			map.put("msg", "이미 승인/반려 처리되었습니다.");
			return map;
		}
		
		no_reason = "";
		String fix_pay_yn = Utils.checkNullString(list.get(0).get("NEXT_FIX_PAY_YN"));
		String fix_amt = Utils.checkNullString(list.get(0).get("NEXT_FIX_AMT"));
		String fix_rate = Utils.checkNullString(list.get(0).get("NEXT_FIX_RATE"));
		
		String prev_fix_pay_yn = Utils.checkNullString(list.get(0).get("PREV_FIX_PAY_YN"));
		String prev_fix_amt = Utils.checkNullString(list.get(0).get("PREV_FIX_AMT"));
		String prev_fix_rate = Utils.checkNullString(list.get(0).get("PREV_FIX_RATE"));
		
		
			
		if("3".equals(act)) //반려
		{
			it_dao.upChangeConfirm(store, period, subject_cd, act, no_reason, login_seq);
			it_dao.upPeltFix(store, period, subject_cd, prev_fix_pay_yn, prev_fix_amt, prev_fix_rate);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 기준변경 반려", store+"/"+period+"/"+subject_cd);
		}
		else if("2".equals(act)) //승인
		{
			it_dao.upChangeConfirm(store, period, subject_cd, act, no_reason, login_seq);
			it_dao.upPeltFix(store, period, subject_cd, fix_pay_yn, fix_amt, fix_rate);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 기준변경 승인", store+"/"+period+"/"+subject_cd);
		}
		

		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");

        return map;
	}
	@RequestMapping("/getDoc")
	@ResponseBody
	public List<HashMap<String, Object>> getDoc(HttpServletRequest request) {
		
		String type_l = Utils.checkNullString(request.getParameter("type_l"));
		
		List<HashMap<String, Object>> list = it_dao.getDoc(type_l);
		
		return list;
		
	}
	@RequestMapping("/getPayment")
	@ResponseBody
	public List<HashMap<String, Object>> getPayment(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "");
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String status_fg = Utils.checkNullString(request.getParameter("status_fg"));
		
		List<HashMap<String, Object>> list = null;
		if(status_fg.equals("AP7")){
            list = it_dao.getPayment1(store, start_ymd, end_ymd, doc_type, status_fg);
        }else{
        	list = it_dao.getPayment2(store, start_ymd, end_ymd, doc_type, status_fg);
        }
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "대금지불 의뢰서 조회", store+"/"+start_ymd+"/"+end_ymd+"/"+doc_type);

		return list;
	}
	@RequestMapping("/getTally")
	@ResponseBody
	public List<HashMap<String, Object>> getTally(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "");
		String doc_type = Utils.checkNullString(request.getParameter("doc_type"));
		String status_fg = Utils.checkNullString(request.getParameter("status_fg"));
		
		List<HashMap<String, Object>> list = akris_dao.getTally(store, start_ymd, end_ymd, doc_type, status_fg);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "계정별 집계표 조회", store+"/"+start_ymd+"/"+end_ymd+"/"+doc_type);

		return list;
	}
	@RequestMapping("/getEndList")
	@ResponseBody
	public HashMap<String, Object> getEndList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		
		String pmg = "";
		if("1".equals(corp_fg))
		{
			pmg = "bab2010b";
		}
		else
		{
			pmg = "bab1010b";
		}
		String pgm_arg = "";
		if(!"".equals(store) && !"".equals(sale_ymd))
		{
			pgm_arg = "00"+store+sale_ymd;
		}
		
		
		List<HashMap<String, Object>> list = common_dao.getProcList_noPaging(pgm_arg, pmg); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 분개전송 조회", store+"/"+sale_ymd);

		return map;
	}
	@RequestMapping("/getDeadList")
	@ResponseBody
	public HashMap<String, Object> getDeadList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String period = Utils.checkNullString(request.getParameter("period"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		
		String pmg = "bab3010b";
		String pgm_arg = "";
		if(!"".equals(store) && !"".equals(sale_ymd))
		{
			pgm_arg = "00"+store+sale_ymd+period;
		}
		
		
		List<HashMap<String, Object>> list = common_dao.getProcList_noPaging(pgm_arg, pmg); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "재료비 분개전송 조회", store+"/"+sale_ymd);
		return map;
	}
	@RequestMapping("/getPeriList")
	@ResponseBody
	public List<HashMap<String, Object>> getPeriList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		List<HashMap<String, Object>> perilist = common_dao.getPeriList(store, "", ""); 
		return perilist;
	}
	@Transactional
	@RequestMapping("/end_proc")
	public ModelAndView end_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		
		mav.setViewName("/WEB-INF/pages/it/end_proc");
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String act = Utils.checkNullString(request.getParameter("act"));
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	    
	    for(int i = login_seq.length(); i < 7; i++)
	    {
	    	login_seq += "X"; //7글자로 채우기위함.
	    }
	    
	    String close_fg = "";
		String programNm = "";
		String programIDB = "";
		
		if("1".equals(corp_fg))
		{
			programIDB = "bab2010b";
			programNm  = "법인강사료";
			if("send".equals(act))
			{
				close_fg = "BAD";
				programNm  += "분개작업";
			}
			else if("cancle".equals(act))
			{
				close_fg = "BAE";
				programNm  += "분개취소작업";
			}
			else if("submit".equals(act))
			{
				close_fg = "BAF";
				programNm  += "분개전송작업";
			}
		}
		else
		{
			programIDB = "bab1010b";
			programNm  = "전문강사료";
			if("send".equals(act))
			{
				close_fg = "BA3";
				programNm  += "분개작업";
			}
			else if("cancle".equals(act))
			{
				close_fg = "BA4";
				programNm  += "분개취소작업";
			}
			else if("submit".equals(act))
			{
				close_fg = "BA5";
				programNm  += "분개전송작업";
			}
		}
		
		
		
		String close_status = it_dao.getEndCloseStatus(store, close_fg, sale_ymd);	
		
		if("I".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", programNm+" 중입니다.");
			return mav;
		}
		if("Y".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "이미 "+programNm+" 되었습니다.");
			return mav;
		}
		if("E".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", programNm+"중 오류가 발생하였습니다. 전산실에 문의해주세요.");
			return mav;
		}
		
		String todayDate = AKCommon.getCurrentDate();
        String toTime    = AKCommon.getCurrentTime();
        
        String args  = todayDate + toTime + login_seq + AKCommon.RPAD(programNm,50+programNm.length(),' ');
        String prog_args = "00" + store + sale_ymd + close_fg;
        
        it_dao.insEnd(store, close_fg, sale_ymd, login_seq);
        
        BABatchRun batchjob = new BABatchRun();
        batchjob.setHost(batch_ip, 10002);
        String result = batchjob.setBathBun(programIDB,args + prog_args); //테스트시 풀어야함
//        String result = "0";
        
        if("0".equals(result))
        {
        	mav.addObject("isSuc", "success");
    		mav.addObject("msg", "성공적으로 저장되었습니다.");
    		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 분개 전송", store+"/"+sale_ymd+"/"+close_fg);
        }
        else
        {
        	mav.addObject("isSuc", "fail");
			mav.addObject("msg", "정산작업중 오류가 발생하였습니다. 전산실에 문의해주세요.");
        }
		return mav;
	}
	@Transactional
	@RequestMapping("/dead_proc")
	public ModelAndView dead_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		
		mav.setViewName("/WEB-INF/pages/it/dead_proc");
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String act = Utils.checkNullString(request.getParameter("act"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		String period = Utils.checkNullString(request.getParameter("selPeri"));
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		for(int i = login_seq.length(); i < 7; i++)
		{
			login_seq += "X"; //7글자로 채우기위함.
		}
		
		String close_fg = "";
		String programNm = "";
		String programIDB = "bab3010b";
		
		if("send".equals(act))
		{
			close_fg = "BA6";
			programNm  = "재료비분개작업";
		}
		else if("cancle".equals(act))
		{
			close_fg = "BA7";
			programNm  = "재료비분개취소작업";
		}
		else if("submit".equals(act))
		{
			close_fg = "BA8";
			programNm  = "재료비분개전송작업";
		}
		
		String close_status = it_dao.getEndCloseStatus(store, close_fg, sale_ymd);	
		
		if("I".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", programNm+" 중입니다.");
			return mav;
		}
		if("Y".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "이미 "+programNm+" 되었습니다.");
			return mav;
		}
		if("E".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", programNm+"중 오류가 발생하였습니다. 전산실에 문의해주세요.");
			return mav;
		}
		
		String todayDate = AKCommon.getCurrentDate();
		String toTime    = AKCommon.getCurrentTime();
		
		String args  = todayDate + toTime + login_seq + AKCommon.RPAD(programNm,50+programNm.length(),' ');
		String prog_args = "00" + store + sale_ymd + period + close_fg;
		
		it_dao.insEnd(store, close_fg, sale_ymd, login_seq);
		
		BABatchRun batchjob = new BABatchRun();
		batchjob.setHost(batch_ip, 10002);
        String result = batchjob.setBathBun(programIDB,args + prog_args); //테스트시 풀어야함
//		String result = "0";
		
		if("0".equals(result))
		{
			mav.addObject("isSuc", "success");
			mav.addObject("msg", "성공적으로 저장되었습니다.");
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "재료비 분개 전송", store+"/"+sale_ymd+"/"+close_fg);
		}
		else
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "정산작업중 오류가 발생하였습니다. 전산실에 문의해주세요.");
		}
		return mav;
	}
	@Transactional
	@RequestMapping("/jaemu_end_proc")
	public ModelAndView jaemu_end_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/it/jaemu_end_proc");
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		
		String gbn_upmu = "";
		String close_fg = "";
		if("1".equals(corp_fg))
		{
			gbn_upmu = "CM4";
			close_fg = "BAF";
		}
		else
		{
			gbn_upmu = "CM3";
			close_fg = "BA5";
		}
		String close_status = it_dao.getEndCloseStatus(store, close_fg, sale_ymd);
		if("".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "재무전송한 내역이 없습니다.");
			return mav;
		}
		if("I".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "재무전송취소 작업 중 입니다!");
			return mav;
		}
		if("E".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "재무전송취소 작업중 오류발생!, 전산실문의 하시기 바랍니다.!");
			return mav;
		}
		if("Y".equals(close_status))
		{
			HashMap<String, Object> data = akris_dao.sapcancel(login_seq, store, sale_ymd, gbn_upmu);
			
			if("-1".equals(data.get("o_code")))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "재무전송 취소중 오류가 발생하였습니다.");
				System.out.println("재무전송취소 오류 : "+data.get("o_message"));
				return mav;
			}
			else
			{
				mav.addObject("isSuc", "success");
				mav.addObject("msg", "성공적으로 저장되었습니다.");
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 분개 전송", store+"/"+sale_ymd+"/"+close_fg);

			}
		}
		
		return mav;
	}
	@Transactional
	@RequestMapping("/jaemu_dead_proc")
	public ModelAndView jaemu_dead_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/it/jaemu_dead_proc");
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		String close_fg = "BA8";
		String close_status = it_dao.getEndCloseStatus(store, close_fg, sale_ymd);
		if("".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "재무전송한 내역이 없습니다.");
			return mav;
		}
		if("I".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "재무전송취소 작업 중 입니다!");
			return mav;
		}
		if("E".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "재무전송취소 작업중 오류발생!, 전산실문의 하시기 바랍니다.!");
			return mav;
		}
		if("Y".equals(close_status))
		{
			String gbn_upmu = "CM2";
			HashMap<String, Object> data = akris_dao.sapcancel(login_seq, store, sale_ymd, gbn_upmu);
			
			if("-1".equals(data.get("o_code")))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "재무전송 취소중 오류가 발생하였습니다.");
				System.out.println("재무전송취소 오류 : "+data.get("o_message"));
				return mav;
			}
			else
			{
				mav.addObject("isSuc", "success");
				mav.addObject("msg", "성공적으로 저장되었습니다.");
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "재료비 분개 전송", store+"/"+sale_ymd+"/"+close_fg);
			}
		}
		return mav;
	}
	@RequestMapping("/getElectList")
	@ResponseBody
	public HashMap<String, Object> getElectList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym")).replaceAll("-", "");
		String journal_yn = Utils.checkNullString(request.getParameter("journal_yn")).replaceAll("-", "");
		
		List<HashMap<String, Object>> listCnt = it_dao.getElectListCount(store, period, lect_ym, journal_yn);
		List<HashMap<String, Object>> listCnt_all = it_dao.getElectListCount(store, period, "", "");
		int listCount = 0;
		if(listCnt.size() > 0)
		{
			listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
		}
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
		
		List<HashMap<String, Object>> list = it_dao.getElectList(s_point, listSize*page, order_by, sort_type, store, period, lect_ym, journal_yn); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 전자증빙 조회", store+"/"+period);

		return map;
	}
	@RequestMapping("/getCorp1List")
	@ResponseBody
	public HashMap<String, Object> getCorp1List(HttpServletRequest request) {
		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		
//		String store = Utils.checkNullString(request.getParameter("store"));
//		String period = Utils.checkNullString(request.getParameter("period"));
//		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym")).replaceAll("-", "");
//		
//		List<HashMap<String, Object>> listCnt = it_dao.getCorp1ListCount(store, period, lect_ym);
//		int listCount = 0;
//		if(listCnt.size() > 0)
//		{
//			listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
//		}
//		int page = 1;
//		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
//		{
//			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
//		}
//		int listSize = 20;
//		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
//		{
//			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
//		}
//		
//		
//		int block = 5;
//		int pageNum = (int)Math.ceil((double)listCount/listSize);
//		int nowBlock = (int)Math.ceil((double)page/block);
//		int s_page = (nowBlock * block) - (block-1);
//		if (s_page <= 1) 
//		{
//			s_page = 1;
//		}
//		int e_page = nowBlock*block;
//		if (pageNum <= e_page) {
//			e_page = pageNum;
//		}
//		
//		int s_point = (page-1) * listSize;
//		
//		List<HashMap<String, Object>> list = it_dao.getCorp1List(s_point, listSize*page, order_by, sort_type, store, period, lect_ym); 
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("list", list);
//		map.put("page", page);
//		map.put("s_page", s_page);
//		map.put("e_page", e_page);
//		map.put("pageNum", pageNum);
//		map.put("order_by", order_by);
//		map.put("sort_type", sort_type);
//		return map;
		return null;
	}
	@RequestMapping("/getCorp2List")
	@ResponseBody
	public HashMap<String, Object> getCorp2List(HttpServletRequest request) {
		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		
//		String store = Utils.checkNullString(request.getParameter("store"));
//		String period = Utils.checkNullString(request.getParameter("period"));
//		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym")).replaceAll("-", "");
//		
//		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
//		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
//		String journal_yn = Utils.checkNullString(request.getParameter("journal_yn"));
//		
//		
//		List<HashMap<String, Object>> listCnt = it_dao.getCorp2ListCount(store, period, lect_ym, main_cd, sect_cd, journal_yn);
//		int listCount = 0;
//		if(listCnt.size() > 0)
//		{
//			listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
//		}
//		int page = 1;
//		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
//		{
//			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
//		}
//		int listSize = 20;
//		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
//		{
//			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
//		}
//		
//		
//		int block = 5;
//		int pageNum = (int)Math.ceil((double)listCount/listSize);
//		int nowBlock = (int)Math.ceil((double)page/block);
//		int s_page = (nowBlock * block) - (block-1);
//		if (s_page <= 1) 
//		{
//			s_page = 1;
//		}
//		int e_page = nowBlock*block;
//		if (pageNum <= e_page) {
//			e_page = pageNum;
//		}
//		
//		int s_point = (page-1) * listSize;
//		
//		List<HashMap<String, Object>> list = it_dao.getCorp2List(s_point, listSize*page, order_by, sort_type, store, period, lect_ym, main_cd, sect_cd, journal_yn); 
//		HashMap<String, Object> map = new HashMap<>();
//		map.put("list", list);
//		map.put("page", page);
//		map.put("s_page", s_page);
//		map.put("e_page", e_page);
//		map.put("pageNum", pageNum);
//		map.put("order_by", order_by);
//		map.put("sort_type", sort_type);
//		return map;
		return null;
	}
	@RequestMapping("/getFoodList")
	@ResponseBody
	public HashMap<String, Object> getFoodList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String food_ym = Utils.checkNullString(request.getParameter("food_ym")).replaceAll("-", "");
		
		String journal_yn = Utils.checkNullString(request.getParameter("journal_yn"));
		String pay_day = "";
		String pay_day2 = "";
		
		HashMap<String, Object> data = it_dao.getPaydayByPeri(store, period);
		if(data != null)
		{
			if(data.get("MATE_1_YMD") != null && data.get("MATE_2_YMD") != null && data.get("MATE_3_YMD") != null)
			{
				if(food_ym.equals(Utils.checkNullString(data.get("MATE_1_YMD")).substring(0, 6)))
				{
					pay_day = "1";
					pay_day2 = Utils.checkNullString(data.get("MATE_1_YMD")).substring(0, 8);
				}
				else if(food_ym.equals(Utils.checkNullString(data.get("MATE_2_YMD")).substring(0, 6)))
				{
					pay_day = "2";
					pay_day2 = Utils.checkNullString(data.get("MATE_2_YMD")).substring(0, 8);
				}
				else if(food_ym.equals(Utils.checkNullString(data.get("MATE_3_YMD")).substring(0, 6)))
				{
					pay_day = "3";
					pay_day2 = Utils.checkNullString(data.get("MATE_3_YMD")).substring(0, 8);
				}
			}
			else
			{
				pay_day = "";
			}
		}
		
		String food_ym1 = Utils.checkNullString(data.get("MATE_1_YMD")).substring(0, 6);
		String food_ym2 = Utils.checkNullString(data.get("MATE_2_YMD")).substring(0, 6);
		String food_ym3 = Utils.checkNullString(data.get("MATE_3_YMD")).substring(0, 6);
		
		HashMap<String, Object> map = new HashMap<>();
		if(!"".equals(pay_day))
		{
			String end_yn = Utils.checkNullString(request.getParameter("end_yn"));
			String act = Utils.checkNullString(request.getParameter("act")); //지급제외여부
			String submit_yn = Utils.checkNullString(request.getParameter("submit_yn"));
			
			List<HashMap<String, Object>> listCnt = it_dao.getFoodListCount(store, period, food_ym, journal_yn, end_yn, pay_day, act, submit_yn);
			List<HashMap<String, Object>> listCnt_all = it_dao.getFoodListCount(store, period, "", "", "", "", act, "");
			int listCount = 0;
			if(listCnt.size() > 0)
			{
				listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
			}
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
			
			List<HashMap<String, Object>> list = it_dao.getFoodList(s_point, listSize*page, order_by, sort_type, store, period, food_ym, journal_yn, end_yn, pay_day, act, submit_yn, food_ym1, food_ym2, food_ym3); 
			
			map.put("list", list);
			map.put("listCnt", listCnt.get(0).get("CNT"));
			map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
			map.put("page", page);
			map.put("s_page", s_page);
			map.put("e_page", e_page);
			map.put("pageNum", pageNum);
			map.put("order_by", order_by);
			map.put("sort_type", sort_type);
			map.put("isSuc", "success");
			map.put("pay_day2", pay_day2);
			
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "대상연월을 확인해주세요.");
		}
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "재료비 점검 조회", store+"/"+period);

		return map;
	}
	@RequestMapping("/getStatusList")
	@ResponseBody
	public HashMap<String, Object> getStatusList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String journal_yn = Utils.checkNullString(request.getParameter("journal_yn"));
		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym")).replaceAll("-", "");
		
		List<HashMap<String, Object>> list = it_dao.getStatusList(store, period, corp_fg, lect_ym, journal_yn); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 현황", store+"/"+period);

		return map;
	}
	@RequestMapping("/getStatusByPeriList")
	@ResponseBody
	public List<HashMap<String, Object>> getStatusByPeriList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		HashMap<String, Object> data = it_dao.getPaydayByPeri(store, period);
		String lect_ym1 = Utils.checkNullString(data.get("TECH_1_YMD")).substring(0, 6);
		String lect_ym2 = Utils.checkNullString(data.get("TECH_2_YMD")).substring(0, 6);
		String lect_ym3 = Utils.checkNullString(data.get("TECH_3_YMD")).substring(0, 6);
		
		
		List<HashMap<String, Object>> list = it_dao.getStatusByPeriList(store, period, lect_ym1, lect_ym2, lect_ym3); 
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "기수별 강사료 지급현황 조회", store+"/"+period);

		return list;
	}
	@RequestMapping("/getStatusByPeriList_food")
	@ResponseBody
	public HashMap<String, Object> getStatusByPeriList_food(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		List<HashMap<String, Object>> list = it_dao.getStatusByPeriList_food(store, period); 
		HashMap<String, Object> data = it_dao.getPaydayByPeri(store, period);
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("food_ym1", Utils.checkNullString(data.get("MATE_1_YMD")).substring(0, 6));
		map.put("food_ym2", Utils.checkNullString(data.get("MATE_2_YMD")).substring(0, 6));
		map.put("food_ym3", Utils.checkNullString(data.get("MATE_3_YMD")).substring(0, 6));
		map.put("list", list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "기수별 재료비 지급현황 조회", store+"/"+period);

		return map;
	}
	@RequestMapping("/getMaterialList")
	@ResponseBody
	public HashMap<String, Object> getMaterialList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period_from = Utils.checkNullString(request.getParameter("period_from"));
		String period_to = Utils.checkNullString(request.getParameter("period_to"));
		
		
		List<HashMap<String, Object>> list = it_dao.getMaterialList(store, period_from, period_to); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		return map;
	}
	@Transactional
	@RequestMapping("/saveJr")
	@ResponseBody
	public HashMap<String, Object> saveJr(HttpServletRequest request) {
		
		System.out.println("111");
		HashMap<String, Object> map = new HashMap<>();
		
		String chkList[] = Utils.checkNullString(request.getParameter("chkList")).split("\\|");
		String act = Utils.checkNullString(request.getParameter("act"));
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym")).replace("-", "");
		System.out.println("act : "+act);
		System.out.println("corp_fg : "+corp_fg);
		System.out.println("lect_ym : "+lect_ym);
		for(int i = 0; i < chkList.length; i++)
		{
			System.out.println(i);
			String store = chkList[i].split("_")[0];
			String period = chkList[i].split("_")[1];
			String subject_cd = chkList[i].split("_")[2];
			List<HashMap<String, Object>> list = common_dao.getPeltBySubjectCd(store, period, subject_cd);
			String main_cd = Utils.checkNullString(list.get(0).get("MAIN_CD"));
			String sect_cd = Utils.checkNullString(list.get(0).get("SECT_CD"));
			HttpSession session = request.getSession();
		    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
			
			if("1".equals(corp_fg)) //법인강사
			{
				String accept_yn = chkList[i].split("_")[3];
				if("Y".equals(act)) //등록
				{
					it_dao.saveJr(corp_fg, store, period, subject_cd, lect_ym, main_cd, sect_cd, login_seq);
					common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 마감 등록", store+"/"+period+"/"+subject_cd);
				}
				else //등록취소
				{
					if (!("N").equals(accept_yn)) 
					{
						map.put("isSuc", "fail");
						map.put("msg", "세금계산서 발행 되었거나  수취된 후에는 지불항목 등록 재작업 불가! 발행 여부를 확인하세요!\\n[미승인:세금계산서 발행상태, 승인:수취상태, 등록가능:지불항목등록 가능].");
						return map;
					}
					else 
					{
						// 발행 되지 않았을 경우, 삭제 가능하게 수정.
						String lecturer_cd = Utils.checkNullString(list.get(0).get("LECTURER_CD"));
						int cnt = it_dao.delJr(corp_fg, store, period, subject_cd, lect_ym, lecturer_cd);
						if (cnt == 0) 
						{
							map.put("isSuc", "fail");
							map.put("msg", "삭제가 불가한 데이터 입니다. 분개 또는 작성 여부를 확인해주세요.");
							return map;
						}
						else
						{
							common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사료 마감 취소", store+"/"+period+"/"+subject_cd);
						}
					}
				}
			}
			else
			{
				String journal_yn = chkList[i].split("_")[3];
				if("Y".equals(act)) //등록
				{
					if(journal_yn.equals("N")) // 분개가 안되었을 경우
					{
						it_dao.saveJr(corp_fg, store, period, subject_cd, lect_ym, main_cd, sect_cd, login_seq);
					}
				}
				else
				{
					int cnt = it_dao.delJr(corp_fg, store, period, subject_cd, lect_ym, "");
					if (cnt == 0) 
					{
						map.put("isSuc", "fail");
						map.put("msg", "삭제가 불가한 데이터 입니다. 분개 또는 작성 여부를 확인해주세요.");
						return map;
					}
				}
			}
		}
		

		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
        return map;
	}
	@Transactional
	@RequestMapping("/saveFood")
	@ResponseBody
	public HashMap<String, Object> saveFood(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		String chkList[] = Utils.checkNullString(request.getParameter("chkList")).split("\\|");
		String act = Utils.checkNullString(request.getParameter("act"));
		String food_ym = Utils.checkNullString(request.getParameter("food_ym")).replace("-", "");
		
		System.out.println("act : "+act);
		System.out.println("food_ym : "+food_ym);
		for(int i = 0; i < chkList.length; i++)
		{
			String store = chkList[i].split("_")[0];
			String period = chkList[i].split("_")[1];
			String subject_cd = chkList[i].split("_")[2];
			List<HashMap<String, Object>> list = common_dao.getPeltBySubjectCd(store, period, subject_cd);
			String main_cd = Utils.checkNullString(list.get(0).get("MAIN_CD"));
			String sect_cd = Utils.checkNullString(list.get(0).get("SECT_CD"));
			HttpSession session = request.getSession();
			String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
			
			String journal_yn = chkList[i].split("_")[3];
			if("Y".equals(act)) //등록
			{
				if(journal_yn.equals("N")) // 분개가 안되었을 경우
				{
					it_dao.saveFood(store, period, subject_cd, food_ym, main_cd, sect_cd, login_seq);
					common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "재료비 마감 등록", store+"/"+period+"/"+subject_cd);

				}
			}
			else
			{
				int cnt = it_dao.delFood(store, period, subject_cd, food_ym);
				if (cnt == 0) 
				{
					map.put("isSuc", "fail");
					map.put("msg", "삭제가 불가한 데이터 입니다. 분개 또는 작성 여부를 확인해주세요.");
					return map;
				}
				else
				{
					common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "재료비 마감 취소", store+"/"+period+"/"+subject_cd);
				}
			}
		}
		
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
	}
	@RequestMapping("/getElectDetailList")
	@ResponseBody
	public List<HashMap<String, Object>> getElectDetailList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd"));
		String lect_ym = Utils.checkNullString(request.getParameter("lect_ym"));
		
		List<HashMap<String, Object>> list = it_dao.getElectDetailList(store, period, lecturer_cd, lect_ym);
		return list;
	}
	@Transactional
	@RequestMapping("/saveElect")
	@ResponseBody
	public HashMap<String, Object> saveElect(HttpServletRequest request) {
		
		String chkList[] = Utils.checkNullString(request.getParameter("chkList")).split("\\|");
		HttpSession session = request.getSession();
		for(int i = 0; i < chkList.length; i++)
		{
			String data[] = chkList[i].split("_");
			String store = data[0];
			String period = data[1];
			String lect_ym = data[2];
			String lecturer_cd = data[3];
			String accept_yn = data[4];
			String journal_yn = data[5];
			String seq = data[6];
			String vat_fg = data[7];
			String pay_day = data[8];
			String accept_ymd = data[9];
			
			it_dao.saveElect(store, period, lect_ym, lecturer_cd, accept_yn, journal_yn, seq, vat_fg, pay_day, accept_ymd);
			
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "법인강사료 전자증빙 저장", store+"/"+period+"/"+lecturer_cd);

		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
        return map;
	}
	@RequestMapping("/getPayMonth")
	@ResponseBody
	public HashMap<String, Object> getPayMonth(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		HashMap<String, Object> data = it_dao.getPaydayByPeri(store, period);
		return data;
	}
}