package ak_culture.controller.lecture;


import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ak_culture.classes.AKCommon;
import ak_culture.classes.HolidayUtil;
import ak_culture.classes.Utils;
import ak_culture.model.basic.PeriDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.lecture.LecrDAO;
import ak_culture.model.lecture.LectDAO;
import ak_culture.model.member.SmsDAO;

@Controller
@RequestMapping("/lecture/lect/*")

public class LectController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Value("${upload_dir}")
	private String upload_dir;
	
	@Autowired
	private PeriDAO peri_dao;
	
	@Autowired
	private LectDAO lect_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private SmsDAO sms_dao;
	
	@Autowired
	private LecrDAO lecr_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lect/list");
		
		HttpSession session = request.getSession();
		Utils.setPeriControllerAll(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		String search_name = Utils.checkNullString(request.getParameter("search_name"));
//		
//		List<HashMap<String, Object>> listCnt = lect_dao.getLectCount(search_name);
//		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
//		int page = 1;
//		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
//		{
//			
//			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
//		}
//		int listSize = 20;
//		if(!"".equals(Utils.checkNullString(request.getParameter("listSize"))))
//		{
//			listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
//		}
//		System.out.println(listSize);
//		
//		int block = 5;
//		int pageNum = (int)Math.ceil((double)listCount/listSize);
//		int nowBlock = (int)Math.ceil((double)page/block);
//		int s_page = (nowBlock * block) - (block-1);
//		if (s_page <= 1) 
//		{
//		    s_page = 1;
//		}
//		int e_page = nowBlock*block;
//		if (pageNum <= e_page) {
//		    e_page = pageNum;
//		}
//		
//		int s_point = (page-1) * listSize;
//		
//		List<HashMap<String, Object>> list = lect_dao.getLect(search_name, s_point, listSize*page, order_by, sort_type); 
//		
//		mav.addObject("list", list);
//		mav.addObject("page", page);
//		mav.addObject("order_by", order_by);
//		mav.addObject("sort_type", sort_type);
//		mav.addObject("search_name", search_name);
//		mav.addObject("s_page", s_page);
//		mav.addObject("e_page", e_page);
//		mav.addObject("pageNum", pageNum);
//		mav.addObject("listSize", listSize);
		
		
//		List<HashMap<String, Object>> list_lecr = lecr_dao.getLecr(search_name, s_point, listSize*page, order_by, sort_type); 
//		
//		mav.addObject("lecr_list", list_lecr);
//		mav.addObject("lecr_page", page);
//		mav.addObject("lecr_order_by", order_by);
//		mav.addObject("lecr_sort_type", sort_type);
//		mav.addObject("lecr_search_name", search_name);
//		mav.addObject("lecr_s_page", s_page);
//		mav.addObject("lecr_e_page", e_page);
//		mav.addObject("lecr_pageNum", pageNum);
//		mav.addObject("lecr_listSize", listSize);
		
		
		return mav;
	}
	
	@RequestMapping("/print_proc")
	public ModelAndView print_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/print_proc");
		mav.addObject("subject_nm",  Utils.checkNullString(request.getParameter("subject_nm")));
		mav.addObject("subject_cd",  Utils.checkNullString(request.getParameter("subject_cd")));
		mav.addObject("lecr_nm",  Utils.checkNullString(request.getParameter("lecr_nm")));
		
		mav.addObject("result",  Utils.checkNullString(request.getParameter("result")));
		mav.addObject("day_chk",  Utils.checkNullString(request.getParameter("day_chk")));
		mav.addObject("phone_chk",  Utils.checkNullString(request.getParameter("phone_chk")));
		return mav;
	}
	
	@RequestMapping("/attend_print_proc")
	public ModelAndView attend_print_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/attend_print_proc");
		mav.addObject("attend_value",  Utils.checkNullString(request.getParameter("attend_value")));

		return mav;
	}
	
	
	@RequestMapping("/getPeltList2")
	@ResponseBody
	public HashMap<String, Object> getPeltList2(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String pelt_status = Utils.checkNullString(request.getParameter("pelt_status"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String is_finish = Utils.checkNullString(request.getParameter("is_finish"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start"));
		String search_end = Utils.checkNullString(request.getParameter("search_end"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String day_flag = Utils.checkNullString(request.getParameter("day_flag"));
//		String mon = "";
//		String tue = "";
//		String wed = "";
//		String thu = "";
//		String fri = "";
//		String sat = "";
//		String sun = "";
//		if(!"".equals(day_flag))
//		{
//			mon = day_flag.substring(0,1);
//			tue = day_flag.substring(1,2);
//			wed = day_flag.substring(2,3);
//			thu = day_flag.substring(3,4);
//			fri = day_flag.substring(4,5);
//			sat = day_flag.substring(5,6);
//			sun = day_flag.substring(6,7);
//		}
		
		search_start = search_start.replaceAll("-","");
		search_end = search_end.replaceAll("-","");
		List<HashMap<String, Object>> listCnt = lect_dao.getPeltCount2(store, period, search_name, pelt_status, subject_fg, search_start, search_end, main_cd,sect_cd, day_flag, is_finish);
		List<HashMap<String, Object>> listCnt_all = lect_dao.getPeltCount2(store, period, "", "", "", "", "", "", "", "0000000", "");
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
		
		List<HashMap<String, Object>> list = lect_dao.getPelt2(s_point, listSize*page, order_by, sort_type, store, period, search_name, pelt_status, subject_fg, search_start, search_end, main_cd,sect_cd, day_flag, is_finish); 
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌 리스트 조회", store+"/"+period);

		return map;
	}
	@RequestMapping("/getPeltList")
	@ResponseBody
	public HashMap<String, Object> getPeltList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String pelt_status = Utils.checkNullString(request.getParameter("pelt_status"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String is_finish = Utils.checkNullString(request.getParameter("is_finish"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start"));
		String search_end = Utils.checkNullString(request.getParameter("search_end"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String day_flag = Utils.checkNullString(request.getParameter("day_flag"));
//		String mon = "";
//		String tue = "";
//		String wed = "";
//		String thu = "";
//		String fri = "";
//		String sat = "";
//		String sun = "";
//		if(!"".equals(day_flag))
//		{
//			mon = day_flag.substring(0,1);
//			tue = day_flag.substring(1,2);
//			wed = day_flag.substring(2,3);
//			thu = day_flag.substring(3,4);
//			fri = day_flag.substring(4,5);
//			sat = day_flag.substring(5,6);
//			sun = day_flag.substring(6,7);
//		}
		
		search_start = search_start.replaceAll("-","");
		search_end = search_end.replaceAll("-","");
		List<HashMap<String, Object>> listCnt = lect_dao.getPeltCount(store, period, search_name, pelt_status, subject_fg, search_start, search_end, main_cd,sect_cd, day_flag, is_finish);
		List<HashMap<String, Object>> listCnt_all = lect_dao.getPeltCount(store, period, "", "", "", "", "", "", "", "0000000", "");
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
		
		List<HashMap<String, Object>> list = lect_dao.getPelt(s_point, listSize*page, order_by, sort_type, store, period, search_name, pelt_status, subject_fg, search_start, search_end, main_cd,sect_cd, day_flag, is_finish); 
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
		
		//강의계획서를 위한 부분
		double tot_per = Utils.checkNullInt(listCnt.get(0).get("CNT")) * 100; //전체 퍼센트를 구함.
		double plan_per = Double.parseDouble(Utils.checkNullString(lect_dao.getPeltPer(store, period, search_name, pelt_status, subject_fg, search_start, search_end, main_cd,sect_cd, day_flag, is_finish)));
		
		
		
		double a = plan_per / tot_per;
		int percent = (int) (a * 100);
		
		map.put("percent", percent);
		//강의계획서를 위한 부분
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의계획서 리스트 조회", store+"/"+period);
		return map;
	}
	
	@RequestMapping("/getEndPeltList")
	@ResponseBody
	public HashMap<String, Object> getEndPeltList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String pelt_status = Utils.checkNullString(request.getParameter("pelt_status"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		
		List<HashMap<String, Object>> listCnt = lect_dao.getEndPeltCount(store, period, search_type, search_name, pelt_status, subject_fg);
		List<HashMap<String, Object>> listCnt_all = lect_dao.getEndPeltCount("", "", "", "", "", "");
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
		
		List<HashMap<String, Object>> list = lect_dao.getEndPelt(s_point, listSize*page, order_by, sort_type, store, period, search_type, search_name, pelt_status, subject_fg); 
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
		
		return map;
	}
	
	
//	@RequestMapping("/getLecrList")
//	@ResponseBody
//	public List<HashMap<String, Object>> getLecrList(HttpServletRequest request) {
//		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		String search_name = Utils.checkNullString(request.getParameter("search_name"));
//		
//		List<HashMap<String, Object>> listCnt = lect_dao.getLecrCount(search_name);
//		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
//		int page = 1;
//		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
//		{
//			
//			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
//		}
//		int listSize = 10;
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
//		    s_page = 1;
//		}
//		int e_page = nowBlock*block;
//		if (pageNum <= e_page) {
//		    e_page = pageNum;
//		}
//		
//		int s_point = (page-1) * listSize;
//		
//		List<HashMap<String, Object>> list_lecr = lect_dao.getLecr(search_name, s_point, listSize*page, order_by, sort_type); 
//		
//		return list_lecr;
//	}	
//	
	@RequestMapping("/addLect")
	@ResponseBody
	public List<HashMap<String, Object>> addLect(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		List<HashMap<String, Object>> listCnt = lect_dao.getLecrCount(search_name);
		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
		int page = 1;
		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
		{
			
			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
		}
		int listSize = 10;
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
		
		List<HashMap<String, Object>> list_lecr = lect_dao.getLecr(search_name, s_point, listSize*page, order_by, sort_type); 
		
		return list_lecr;
	}	
	
	@RequestMapping("/getlectcode")
	@ResponseBody
	public String getlectcode(HttpServletRequest request) {
		
		String a = lect_dao.getlectcode();
		return a;
	}
	@RequestMapping("/getLecrList")
	@ResponseBody
	public List<HashMap<String, Object>> getLecrList(HttpServletRequest request) {
		
		String lecr_name = Utils.checkNullString(request.getParameter("lecr_name"));
		String lecr_phone = Utils.checkNullString(request.getParameter("lecr_phone"));
		
		List<HashMap<String, Object>> lecr_list = lect_dao.getLecrList(lecr_name, lecr_phone); 
		
		return lecr_list;
	}
	
	@RequestMapping("/getScheduleByPeri")
	@ResponseBody
	public HashMap<String, Object> getScheduleByPeri(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		HashMap<String, Object> data = lect_dao.getScheduleByPeri(store, period); 
		
		return data;
	}
	
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/write");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		String search_name = Utils.checkNullString(request.getParameter("search_name"));
//		
//		List<HashMap<String, Object>> listCnt = lect_dao.getLecrCount(search_name);
//		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
//		int page = 1;
//		if(!"".equals(Utils.checkNullString(request.getParameter("page"))))
//		{
//			
//			page = Integer.parseInt(Utils.checkNullString(request.getParameter("page")));
//		}
//		int listSize = 10;
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
//		    s_page = 1;
//		}
//		int e_page = nowBlock*block;
//		if (pageNum <= e_page) {
//		    e_page = pageNum;
//		}
//		
//		int s_point = (page-1) * listSize;
//		
//		List<HashMap<String, Object>> list = lect_dao.getLecr(search_name, s_point, listSize*page, order_by, sort_type); 
//		
//		mav.addObject("list", list);
//		mav.addObject("page", page);
//		mav.addObject("order_by", order_by);
//		mav.addObject("sort_type", sort_type);
//		mav.addObject("search_name", search_name);
//		mav.addObject("s_page", s_page);
//		mav.addObject("e_page", e_page);
//		mav.addObject("pageNum", pageNum);
//		mav.addObject("listSize", listSize);
		
		//mav.addObject("list", list);
		

		
		return mav;
	}
	
	@Transactional
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) throws ParseException, IOException {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/write_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
		String uploadPath = upload_dir+"wlect/";
		
		File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		
		String confirmPeri = Utils.checkNullString(multi.getParameter("confirmPeri"));
		String confirmStore = Utils.checkNullString(multi.getParameter("confirmStore"));
		String lect_cnt = Utils.checkNullString(multi.getParameter("lect_cnt"));
		String subject_fg = Utils.checkNullString(multi.getParameter("subject_fg"));
		if("정규".equals(subject_fg))
		{
			subject_fg = "1";
		}
		else if("단기".equals(subject_fg))
		{
			subject_fg = "2";
		}
		else if("특강".equals(subject_fg))
		{
			subject_fg = "3";
		}
		String subject_nm = Utils.checkNullString(multi.getParameter("subject_nm"));
		String main_cd = Utils.checkNullString(multi.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(multi.getParameter("sect_cd"));
		String lect_cd = Utils.checkNullString(multi.getParameter("lect_cd"));
//		String subject_cd = main_cd+sect_cd+lect_cd;
		String month_no = Utils.checkNullString(multi.getParameter("month_no"));
		String month_no1 = Utils.checkNullString(multi.getParameter("month_no1"));
		String web_lecturer_nm = Utils.checkNullString(multi.getParameter("web_lecture_nm1"));
		String web_lecturer_nm1 = Utils.checkNullString(multi.getParameter("web_lecture_nm2"));
		String lecturer_cd = Utils.checkNullString(multi.getParameter("lecturer_cd"));
		String lecturer_cd1 = Utils.checkNullString(multi.getParameter("lecturer_cd1"));
		String cus_no = Utils.checkNullString(multi.getParameter("cus_no"));
		String cus_no1 = Utils.checkNullString(multi.getParameter("cus_no1"));
		String capacity_no = Utils.checkNullString(multi.getParameter("capacity_no"));
		String classroom = Utils.checkNullString(multi.getParameter("classroom"));
		String day_flag = Utils.checkNullString(multi.getParameter("day_flag"));
		String corp_fg = Utils.checkNullString(multi.getParameter("corp_fg"));
		String is_two = Utils.checkNullString(multi.getParameter("is_two"));
		String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd")).replaceAll("-", "");
		String lect_hour1 = Utils.checkNullString(multi.getParameter("lect_hour1"));
		String lect_hour2 = Utils.checkNullString(multi.getParameter("lect_hour2"));
		String lect_hour3 = Utils.checkNullString(multi.getParameter("lect_hour3"));
		String lect_hour4 = Utils.checkNullString(multi.getParameter("lect_hour4"));
		String lect_hour = lect_hour1+lect_hour2+lect_hour3+lect_hour4;
		String web_cancle_ymd = Utils.checkNullString(multi.getParameter("web_cancle_ymd")).replaceAll("-", "");
		String cancled_list = Utils.checkNullString(multi.getParameter("cancled_list"));
		String fix_pay_yn = Utils.checkNullString(multi.getParameter("fix_pay_yn"));
		String fix_amt = Utils.checkNullString(multi.getParameter("fix_amt")).replaceAll(",", "");
		String fix_rate = Utils.checkNullString(multi.getParameter("fix_rate"));
		
		
		if("on".equals(is_two)) 
		{
			is_two = "Y";
		}
		else
		{
			is_two = "N";
		}
		
		//쓸데없는값 들어가지않도록 
		if("N".equals(fix_pay_yn))
		{
			fix_amt = ""; 
		}
		else
		{
			fix_rate = "";
		}
		String regis_fee = Utils.checkNullString(multi.getParameter("regis_fee")).replaceAll(",", "");
		String food_amt = Utils.checkNullString(multi.getParameter("food_amt")).replaceAll(",", "");
		String food_star = Utils.checkNullString(multi.getParameter("food_star"));
		String food_yn = "";
		if("0".equals(food_amt) || "".equals(food_amt))
		{
			food_yn = "N";
		}
		else
		{
			food_yn = "Y";
		}
		
		if("on".equals(food_star))
		{
			food_yn = "R";
		}
		String regis_fee_cnt = Utils.checkNullString(multi.getParameter("regis_fee_cnt"));
		String food_amt_cnt = "";
		String food_amt_cnt1 = Utils.checkNullString(multi.getParameter("food_amt_cnt1"));
		String food_amt_cnt2 = Utils.checkNullString(multi.getParameter("food_amt_cnt2"));
		String food_amt_cnt3 = Utils.checkNullString(multi.getParameter("food_amt_cnt3"));
		if("on".equals(food_amt_cnt1))
		{
			food_amt_cnt += "1|";
		}
		if("on".equals(food_amt_cnt2))
		{
			food_amt_cnt += "2|";
		}
		if("on".equals(food_amt_cnt3))
		{
			food_amt_cnt += "3|";
		}
		
		HashMap<String, Object> data = peri_dao.getPeriOne(confirmPeri, confirmStore);
		
		String pay_day = "";
		
		System.out.println("regis_fee_cnt : "+regis_fee_cnt);
		System.out.println("food_amt_cnt : "+food_amt_cnt);
		
		if("1".equals(regis_fee_cnt))
		{
			pay_day = Utils.checkNullString(data.get("TECH_1_YMD")).substring(6,8);
		}
		else if("2".equals(regis_fee_cnt))
		{
			pay_day = Utils.checkNullString(data.get("TECH_2_YMD")).substring(6,8);
		}
		else if("3".equals(regis_fee_cnt))
		{
			pay_day = Utils.checkNullString(data.get("TECH_3_YMD")).substring(6,8);
		}
		
		System.out.println("pay_day : "+pay_day);
	
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
//		lect_dao.insLect(confirmStore, confirmPeri, lect_cd, subject_nm, main_cd, sect_cd, lect_cd.substring(3, lect_cd.length()), login_seq);
		lect_dao.insPelt(confirmStore, confirmPeri, lect_cd, main_cd, sect_cd, day_flag, lect_hour, web_cancle_ymd, lect_cnt, classroom, lecturer_cd, lecturer_cd1, start_ymd, end_ymd
						,capacity_no, subject_fg, regis_fee, fix_pay_yn, fix_amt, fix_rate, pay_day, food_yn, food_amt, web_lecturer_nm, web_lecturer_nm1
						,month_no, month_no1, subject_nm, cancled_list, login_seq, cus_no, cus_no1, corp_fg, is_two, regis_fee_cnt, food_amt_cnt,"Y","","","","");
		
		//강좌 중도체크
		int lectMidChk = lect_dao.lectMidChk(confirmStore, confirmPeri,lect_cd);
		System.out.println("lectMidChk : "+lectMidChk);
		if (lectMidChk > 0) 
		{
			if (!cus_no.equals("")) 
			{
				lect_dao.insContract(confirmStore,confirmPeri,cus_no,lect_cd,login_seq);			
			}
			if (!cus_no1.equals("") && !cus_no1.equals(cus_no)) 
			{
				lect_dao.insContract(confirmStore,confirmPeri,cus_no1,lect_cd,login_seq);			
			}
		}
		
		//lect_dao.insAttend(confirmStore, confirmPeri, lect_cd, login_seq,"Y","");
		
		
		//출석부 생성 start
		
//		ModifiableHttpServletRequest m = new ModifiableHttpServletRequest((HttpServletRequest) multi); //추가 파라미터 세팅
//		m.setParameter("isChk", "save");
//		m.setParameter("subject_cd", lect_cd);
//		request=(HttpServletRequest)m;
//		
//		//request.setAttribute("selBranch", confirmStore); //setSchedule 지점 값 세팅
//		//request.setAttribute("selPeri", confirmPeri);	//setSchedule 기수 값 세팅
//		request.setAttribute("isChk", "save");	//setSchedule 기수 값 세팅
//		setSchedule(request); //출석부 날짜 생성(2020.08.28)
		
		
		String store = Utils.checkNullString(multi.getParameter("selBranch"));
		System.out.println("store : "+store);
		String period = Utils.checkNullString(multi.getParameter("selPeri"));
		HashMap<String, Object> periData = peri_dao.getPeriOne(period, store); 
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_pelt = Utils.checkNullString(multi.getParameter("cancled_list")).replaceAll("-", "");
		String cancled_list_peri = "";
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		String yoil = "";
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		
		final String DATE_PATTERN = "yyyyMMdd";
		String inputStartDate = Utils.checkNullString(periData.get("START_YMD"));
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date startDate = sdf.parse(inputStartDate);
        ArrayList<String> dates = new ArrayList<String>();
        Date currentDate = startDate;
        
        
        int i = 0;
        while(true)
        {
        	for(int j = 0; j < yoil.split(",").length; j++)
        	{
        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
    		    String convWe = "";
    		    if(we == 1) {convWe = "일";}
    		    if(we == 2) {convWe = "월";}
    		    if(we == 3) {convWe = "화";}
    		    if(we == 4) {convWe = "수";}
    		    if(we == 5) {convWe = "목";}
    		    if(we == 6) {convWe = "금";}
    		    if(we == 7) {convWe = "토";}
        		if(convWe.equals(yoil.split(",")[j]))
        		{
        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
        			if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
        			{
        				dates.add(sdf.format(currentDate));
        				i++;
        			}
        		}
        	}
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
            if(i == Integer.parseInt(lect_cnt))
			{
				break;
			}
        }
        
        String isChk = "save";
        String subject_cd = lect_cd;

        
        for (String dd : dates) 
        {
        	System.out.println("강의날짜 : "+dd);
        }
	        
	     if (isChk.equals("save")) {
		    //HashMap<String, Object> uptinfo = new HashMap<String, Object>();
	    	 
	    	 
		    String dayChk="";
            for (int j = 0; j < Integer.parseInt(lect_cnt); j++) {
	        	dayChk += Utils.checkNullString(dates.get(j))+"|";
			}
            /*
			uptinfo.put("store", store);
		    uptinfo.put("period", period);
		    uptinfo.put("subject_cd", subject_cd);
		    uptinfo.put("target", "Y");
		    */
            System.out.println("dayChk : "+dayChk);
            
            //개설 강좌, 강사 출석부 생성
		    lect_dao.insAttend(store, period, subject_cd, login_seq,"Y","000000000 ",dayChk,"0");
		    
		    //lect_dao.uptAttend(uptinfo);
		    //System.out.println("uptinfo : "+uptinfo);
	    }
		
		
		
		//출석부 생성 end
		
	    common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌 등록", store+"/"+period+"/"+subject_cd);

		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	@Transactional
	@RequestMapping("/modify_proc")
	public ModelAndView modify_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/modify_proc");
		
		try 
		{
		
			int sizeLimit = 30*1024*1024; //10메가 까지 가능
			String uploadPath = upload_dir+"wlect/";
			
			File dir = new File(uploadPath);
			if (!dir.exists()) { // 디렉토리가 존재하지 않으면
				dir.mkdirs(); // 디렉토리 생성
			}
			MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
			
			String confirmPeri = Utils.checkNullString(multi.getParameter("confirmPeri"));
			String confirmStore = Utils.checkNullString(multi.getParameter("confirmStore"));
			String lect_cnt = Utils.checkNullString(multi.getParameter("lect_cnt"));
			String subject_fg = Utils.checkNullString(multi.getParameter("subject_fg"));
			if("정규".equals(subject_fg))
			{
				subject_fg = "1";
			}
			else if("단기".equals(subject_fg))
			{
				subject_fg = "2";
			}
			else if("특강".equals(subject_fg))
			{
				subject_fg = "3";
			}
			String subject_nm = Utils.checkNullString(multi.getParameter("subject_nm"));
			String main_cd = Utils.checkNullString(multi.getParameter("main_cd"));
			String sect_cd = Utils.checkNullString(multi.getParameter("sect_cd"));
			String lect_cd = Utils.checkNullString(multi.getParameter("lect_cd"));
	//		String subject_cd = main_cd+sect_cd+lect_cd;
			String month_no = Utils.checkNullString(multi.getParameter("month_no"));
			String month_no1 = Utils.checkNullString(multi.getParameter("month_no1"));
			String web_lecturer_nm = Utils.checkNullString(multi.getParameter("web_lecture_nm1"));
			String web_lecturer_nm1 = Utils.checkNullString(multi.getParameter("web_lecture_nm2"));
			String lecturer_cd = Utils.checkNullString(multi.getParameter("lecturer_cd"));
			String lecturer_cd1 = Utils.checkNullString(multi.getParameter("lecturer_cd1"));
			String cus_no = Utils.checkNullString(multi.getParameter("cus_no"));
			String cus_no1 = Utils.checkNullString(multi.getParameter("cus_no1"));
			String capacity_no = Utils.checkNullString(multi.getParameter("capacity_no"));
			String classroom = Utils.checkNullString(multi.getParameter("classroom"));
			String day_flag = Utils.checkNullString(multi.getParameter("day_flag"));
			String corp_fg = Utils.checkNullString(multi.getParameter("corp_fg"));
			String is_two = Utils.checkNullString(multi.getParameter("is_two"));
			String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
			String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd")).replaceAll("-", "");
			String lect_hour1 = Utils.checkNullString(multi.getParameter("lect_hour1"));
			String lect_hour2 = Utils.checkNullString(multi.getParameter("lect_hour2"));
			String lect_hour3 = Utils.checkNullString(multi.getParameter("lect_hour3"));
			String lect_hour4 = Utils.checkNullString(multi.getParameter("lect_hour4"));
			String lect_hour = lect_hour1+lect_hour2+lect_hour3+lect_hour4;
			String web_cancle_ymd = Utils.checkNullString(multi.getParameter("web_cancle_ymd")).replaceAll("-", "");
			String cancled_list = Utils.checkNullString(multi.getParameter("cancled_list"));
			String fix_pay_yn = Utils.checkNullString(multi.getParameter("fix_pay_yn"));
			String fix_amt = Utils.checkNullString(multi.getParameter("fix_amt")).replaceAll(",", "");
			String fix_rate = Utils.checkNullString(multi.getParameter("fix_rate"));
			String prev_subject_cd = Utils.checkNullString(multi.getParameter("prev_subject_cd"));
			
			
			
			
			/*
			
			System.out.println("*****************test start************");
			String store_test = Utils.checkNullString(multi.getParameter("confirmStore"));
			System.out.println("store : "+store_test);
			String period_test = Utils.checkNullString(multi.getParameter("confirmPeri"));
			String day_flag_test = Utils.checkNullString(multi.getParameter("day_flag"));
			int lect_cnt_test = Utils.checkNullInt(Utils.checkNullInt(multi.getParameter("lect_cnt")));
			String start_ymd_test = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
			HashMap<String, Object> data_test = peri_dao.getPeriOne(period_test, store_test); 
			
			List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store_test, period_test);
			String cancled_list_pelt = Utils.checkNullString(multi.getParameter("cancled_list")).replaceAll("-", "");
			String cancled_list_peri = "";
			if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
			{
				cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
			}
			
			String yoil = "";
			if(day_flag.split("")[0].equals("1")){yoil += ",월";}
			if(day_flag.split("")[1].equals("1")){yoil += ",화";}
			if(day_flag.split("")[2].equals("1")){yoil += ",수";}
			if(day_flag.split("")[3].equals("1")){yoil += ",목";}
			if(day_flag.split("")[4].equals("1")){yoil += ",금";}
			if(day_flag.split("")[5].equals("1")){yoil += ",토";}
			if(day_flag.split("")[6].equals("1")){yoil += ",일";}
			yoil = yoil.substring(1, yoil.length());
	        
	        
			final String DATE_PATTERN = "yyyyMMdd";
			String inputStartDate = start_ymd;
			
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
	        Date startDate = sdf.parse(inputStartDate);
	        ArrayList<String> dates = new ArrayList<String>();
	        Date currentDate = startDate;
			
	        int i = 0;
	        while(true)
	        {
	        	for(int j = 0; j < yoil.split(",").length; j++)
	        	{
	        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
	    		    String convWe = "";
	    		    if(we == 1) {convWe = "일";}
	    		    if(we == 2) {convWe = "월";}
	    		    if(we == 3) {convWe = "화";}
	    		    if(we == 4) {convWe = "수";}
	    		    if(we == 5) {convWe = "목";}
	    		    if(we == 6) {convWe = "금";}
	    		    if(we == 7) {convWe = "토";}
	        		if(convWe.equals(yoil.split(",")[j]))
	        		{
	        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
	        			if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
	        			{
	        				dates.add(sdf.format(currentDate));
	        				i++;
	        			}
	        		}
	        	}
	            Calendar c = Calendar.getInstance();
	            c.setTime(currentDate);
	            c.add(Calendar.DAY_OF_MONTH, 1);
	            currentDate = c.getTime();
	            if(i == lect_cnt_test)
				{
					break;
				}
	        }
	        
	        for (String dd : dates) 
	        {
	        	System.out.println("강의날짜 : "+dd);
	        }
	        
			System.out.println("*****************test  end************");
			*/
			
			if("on".equals(is_two)) 
			{
				is_two = "Y";
			}
			else
			{
				is_two = "N";
			}
			
			//쓸데없는값 들어가지않도록 
			if("N".equals(fix_pay_yn))
			{
				fix_amt = ""; 
			}
			else
			{
				fix_rate = "";
			}
			String regis_fee = Utils.checkNullString(multi.getParameter("regis_fee")).replaceAll(",", "");
			String food_amt = Utils.checkNullString(multi.getParameter("food_amt")).replaceAll(",", "");
			String food_star = Utils.checkNullString(multi.getParameter("food_star"));
			String food_yn = "";
			
			System.out.println("food_amt : " +food_amt);
			if("0".equals(food_amt) || "".equals(food_amt))
			{
				food_yn = "N";
			}
			else
			{
				food_yn = "Y";
			}
			
			if("on".equals(food_star))
			{
				food_yn = "R";
			}
			System.out.println("food_yn : " +food_yn);
			String regis_fee_cnt = Utils.checkNullString(multi.getParameter("regis_fee_cnt"));
			String food_amt_cnt = "";
			String food_amt_cnt1 = Utils.checkNullString(multi.getParameter("food_amt_cnt1"));
			String food_amt_cnt2 = Utils.checkNullString(multi.getParameter("food_amt_cnt2"));
			String food_amt_cnt3 = Utils.checkNullString(multi.getParameter("food_amt_cnt3"));
			if("on".equals(food_amt_cnt1))
			{
				food_amt_cnt += "1|";
			}
			if("on".equals(food_amt_cnt2))
			{
				food_amt_cnt += "2|";
			}
			if("on".equals(food_amt_cnt3))
			{
				food_amt_cnt += "3|";
			}
			
			HashMap<String, Object> data = peri_dao.getPeriOne(confirmPeri, confirmStore);
			
			String pay_day = "";
			
			System.out.println("regis_fee_cnt : "+regis_fee_cnt);
			System.out.println("food_amt_cnt : "+food_amt_cnt);
			
			if("1".equals(regis_fee_cnt))
			{
				pay_day = Utils.checkNullString(data.get("TECH_1_YMD")).substring(6,8);
			}
			else if("2".equals(regis_fee_cnt))
			{
				pay_day = Utils.checkNullString(data.get("TECH_2_YMD")).substring(6,8);
			}
			else if("3".equals(regis_fee_cnt))
			{
				pay_day = Utils.checkNullString(data.get("TECH_3_YMD")).substring(6,8);
			}
			
			System.out.println("pay_day : "+pay_day);
			
			
			
			HttpSession session = request.getSession();
			String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	//		lect_dao.upLect(confirmStore, confirmPeri, lect_cd, subject_nm, main_cd, sect_cd, lect_cd.substring(3, lect_cd.length()), login_seq, prev_subject_cd);
			
			HashMap<String, Object> lecrData = lect_dao.getConnectInfo(confirmStore, confirmPeri, prev_subject_cd);
			HashMap<String, Object> peltData = lect_dao.getPrevInfo(confirmStore, confirmPeri, prev_subject_cd);
			if(lecrData != null && peltData != null) //기존 데이터와 비교해서 변경되면 안되는 항목을 찾는다.
			{
				String corp_tb = Utils.checkNullString(lecrData.get("CORP_TB"));
				String lecturer_cd_ori = Utils.checkNullString(lecrData.get("LECTURER_CD"));
				String lecturer_cd_ori1 = Utils.checkNullString(lecrData.get("LECTURER_CD1"));
				
				String fix_pay_yn_ori = Utils.checkNullString(peltData.get("FIX_PAY_YN"));
				String fix_rate_ori = Utils.checkNullString(peltData.get("FIX_RATE"));
				String fix_amt_ori = Utils.checkNullString(peltData.get("FIX_AMT"));
				String regis_fee_ori = Utils.checkNullString(peltData.get("REGIS_FEE"));
				String food_amt_ori = Utils.checkNullString(peltData.get("FOOD_AMT"));
				String regis_fee_cnt_ori = Utils.checkNullString(peltData.get("REGIS_FEE_CNT"));
				String food_amt_cnt_ori = Utils.checkNullString(peltData.get("FOOD_AMT_CNT"));
				
				System.out.println("fix_pay_yn_ori : "+fix_pay_yn_ori);
				System.out.println("fix_pay_yn : "+fix_pay_yn);
				System.out.println("fix_rate_ori : "+fix_rate_ori);
				System.out.println("fix_rate : "+fix_rate);
				System.out.println("fix_amt_ori : "+fix_amt_ori);
				System.out.println("fix_amt : "+fix_amt);
				
				if("N".equals(fix_pay_yn_ori))
				{
					fix_amt_ori = ""; 
				}
				else
				{
					fix_amt_ori = "";
				}
				if(!fix_pay_yn_ori.equals(fix_pay_yn) || !fix_rate_ori.equals(fix_rate) || !fix_amt_ori.equals(fix_amt))
				{
					if(!"0000000000000".equals(lecturer_cd_ori) && !"".equals(lecturer_cd_ori))
					{
						int cntLecr = lect_dao.getJrCnt(confirmStore, prev_subject_cd, corp_tb, lecturer_cd_ori);
						if(cntLecr > 0)
						{
							mav.addObject("isSuc", "fail");
							mav.addObject("msg", "강사료 지급이력이 있는 강좌입니다. 변경이 필요한 경우, 강사료 지급기준 변경 승인을 통해 변경 바랍니다.");
							return mav;
						}
					}
					if(!"0000000000000".equals(lecturer_cd_ori1) && !"".equals(lecturer_cd_ori1))
					{
						int cntLecr = lect_dao.getJrCnt(confirmStore, prev_subject_cd, corp_tb, lecturer_cd_ori1);
						if(cntLecr > 0)
						{
							mav.addObject("isSuc", "fail");
							mav.addObject("msg", "강사료 지급이력이 있는 강좌입니다. 변경이 필요한 경우, 강사료 지급기준 변경 승인을 통해 변경 바랍니다.");
							return mav;
						}
					}
				}
//				if(!regis_fee.equals(regis_fee_ori) || !food_amt.equals(food_amt_ori))
//				{
//					if(!"0000000000000".equals(lecturer_cd_ori) && !"".equals(lecturer_cd_ori))
//					{
//						int cntLecr = lect_dao.getJrCnt(confirmStore, prev_subject_cd, corp_tb, lecturer_cd_ori);
//						if(cntLecr > 0)
//						{
//							mav.addObject("isSuc", "fail");
//							mav.addObject("msg", "강사료 지급이력이 있는 강좌입니다. 변경이 필요한 경우, 강사료 지급기준 변경 승인을 통해 변경 바랍니다.");
//							return mav;
//						}
//					}
//					if(!"0000000000000".equals(lecturer_cd_ori1) && !"".equals(lecturer_cd_ori1))
//					{
//						int cntLecr = lect_dao.getJrCnt(confirmStore, prev_subject_cd, corp_tb, lecturer_cd_ori1);
//						if(cntLecr > 0)
//						{
//							mav.addObject("isSuc", "fail");
//							mav.addObject("msg", "강사료 지급이력이 있는 강좌입니다. 변경이 필요한 경우, 강사료 지급기준 변경 승인을 통해 변경 바랍니다.");
//							return mav;
//						}
//					}
//				}
				
				
				int cnt = lect_dao.upPelt(confirmStore, confirmPeri, lect_cd, main_cd, sect_cd, day_flag, lect_hour, web_cancle_ymd, lect_cnt, classroom, lecturer_cd, lecturer_cd1, start_ymd, end_ymd
						,capacity_no, subject_fg, regis_fee, fix_pay_yn, fix_amt, fix_rate, pay_day, food_yn, food_amt, web_lecturer_nm, web_lecturer_nm1
						,month_no, month_no1, subject_nm, cancled_list, login_seq, cus_no, cus_no1, corp_fg, is_two, prev_subject_cd, regis_fee_cnt, food_amt_cnt);
				
				if(cnt > 0)
				{
					lect_dao.upPlanSubjectNm(confirmStore, confirmPeri, prev_subject_cd, subject_nm);
					mav.addObject("isSuc", "success");
					mav.addObject("msg", "저장되었습니다.");
					
					
					common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌 수정", confirmStore+"/"+confirmPeri+"/"+prev_subject_cd);

					if (!cus_no.equals("")) 
					{
						int dupl_chk = lect_dao.ContractDuplChk(confirmStore, confirmPeri,lect_cd,cus_no);
						if (dupl_chk == 0) 
						{
							lect_dao.insContract(confirmStore,confirmPeri,cus_no,lect_cd,login_seq);			
						}
					}
					if (!cus_no1.equals("") && !cus_no1.equals(cus_no)) 
					{
						int dupl_chk = lect_dao.ContractDuplChk(confirmStore, confirmPeri,lect_cd,cus_no1);
						if (dupl_chk == 0) 
						{							
							lect_dao.insContract(confirmStore,confirmPeri,cus_no1,lect_cd,login_seq);			
						}
					}
					
				}
				else
				{
					mav.addObject("isSuc", "fail");
					mav.addObject("msg", "강좌가 정상적으로 수정되지 않았습니다.");
				}
			}
			else
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "강좌가 정상적으로 수정되지 않았습니다.");
				return mav;
			}
			
		}
		catch(Exception e)
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생");
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
//		
		
		return mav;
	}
	
	
	
	@RequestMapping("/cate_proc1")
	public ModelAndView cate_proc1(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/cate_proc1");
		
		String insShortName = Utils.checkNullString(request.getParameter("insShortName"));
		String insLongName = Utils.checkNullString(request.getParameter("insLongName"));
		
		List<HashMap<String, Object>> lect_cate = lect_dao.selLectCate(insShortName);
		if(lect_cate.size() > 0)
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "이미 같은 이름의 대분류가 있습니다.");
			return mav;
		}
		
		List<HashMap<String, Object>> lastCode = lect_dao.selLastCode();
		
		int insCode=1;
		if (lastCode.size() > 0) {
			insCode = Utils.checkNullInt(lastCode.get(0).get("SUB_CODE")) +1;
		}
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		lect_dao.insBigCode(insCode, insShortName, insLongName, login_seq);
		
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "대분류 등록", Integer.toString(insCode));
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	@RequestMapping("/room_proc")
	public ModelAndView room_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/room_proc");
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String room_nm = Utils.checkNullString(request.getParameter("room_nm"));
		String contents = Utils.checkNullString(request.getParameter("contents"));
		String location = Utils.checkNullString(request.getParameter("location"));
		String capacity_no = Utils.checkNullString(request.getParameter("capacity_no"));
		String area_size = Utils.checkNullString(request.getParameter("area_size"));
		String usage = Utils.checkNullString(request.getParameter("usage"));
		String delete_yn = Utils.checkNullString(request.getParameter("delete_yn_new_status"));
		if("N".equals(delete_yn))
		{
			delete_yn = "Y";
		}
		else if("Y".equals(delete_yn))
		{
			delete_yn = "N";
		}
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		if("new".equals(seq))
		{
			lect_dao.insRoom(store, room_nm, contents, location, capacity_no, area_size, usage, delete_yn, login_seq);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의실 등록", store+"/"+room_nm);
		}
		else
		{
			lect_dao.editRoom(store, room_nm, contents, location, capacity_no, area_size, usage, delete_yn, login_seq, seq);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의실 수정", store+"/"+seq);
		}
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	@Transactional
	@RequestMapping("/cate_proc2")
	public ModelAndView cate_proc2(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/cate_proc2");
		
		String sect_nm_list = Utils.checkNullString(request.getParameter("sect_nm_list"));
		String sect_contents_list = Utils.checkNullString(request.getParameter("sect_contents_list"));
		String sect_performance_list = Utils.checkNullString(request.getParameter("sect_performance_list"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		
		String nm_arr[] = sect_nm_list.split("\\|");
		String contents_arr[] = sect_contents_list.split("\\|");
		String performance_arr[] = sect_performance_list.split("\\|");
		
		for(int i = 0; i< nm_arr.length; i++)
		{
			List<HashMap<String, Object>> sect_list = lect_dao.selSectName(nm_arr[i]);
			if(sect_list.size() > 0)
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "이미 같은 이름의 중분류가 있습니다.");
				return mav;
			}
		}
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		for(int i = 0; i< nm_arr.length; i++)
		{
			List<HashMap<String, Object>> lastCode = lect_dao.selLastSect(store, main_cd);
			int selCode = 0;
			if(lastCode.size() > 0)
			{
				selCode = Utils.checkNullInt(lastCode.get(0).get("SECT_CD")) +1;
			}
			else
			{
				selCode = 1;
			}
			String sect_cd = "";
			if(selCode < 10)
			{
				sect_cd = "0"+Integer.toString(selCode);
			}
			else
			{
				sect_cd = Integer.toString(selCode);
			}
			
			if("".equals(store)) { store = "99";}
			lect_dao.insMiddleCode(store, main_cd, sect_cd, nm_arr[i], contents_arr[i], performance_arr[i], login_seq);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "중분류 등록", main_cd+"/"+sect_cd);
		}
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	@RequestMapping("/list_cate")
	public ModelAndView list_cate(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/list_cate");
		
		List<HashMap<String, Object>> depth1List = common_dao.get1Depth_incDel(); //삭제된거 포함 
		mav.addObject("depth1List", depth1List);
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌 분류 조회", "");
		return mav;
	}
	@RequestMapping("/list_close")
	public ModelAndView list_close(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/list_close");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/plan")
	public ModelAndView plan(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/plan");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		return mav;
	}
//	@RequestMapping("/plan_write_proc")
//	public ModelAndView plan_write_proc(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView(); 
//		mav.setViewName("/WEB-INF/pages/lecture/lect/plan_write_proc");
//		
//		String store = Utils.checkNullString(request.getParameter("store"));
//		String period = Utils.checkNullString(request.getParameter("period"));
//		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
//		
//		String target = Utils.repWord(Utils.checkNullString(request.getParameter("target")));
//		String food_amt = Utils.repWord(Utils.checkNullString(request.getParameter("food_amt")));
//		String food_contents = Utils.repWord(Utils.checkNullString(request.getParameter("food_contents")));
//		String lect_intro = Utils.repWord(Utils.checkNullString(request.getParameter("lect_intro")));
//		
//		String lect_cnt = Utils.repWord(Utils.checkNullString(request.getParameter("lect_cnt_list")));
//		String lect_contents = Utils.repWord(Utils.checkNullString(request.getParameter("lect_contents_list")));
//		String lect_food = Utils.repWord(Utils.checkNullString(request.getParameter("lect_food_list")));
//		
//		HttpSession session = request.getSession();
//		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
//		
//		List<HashMap<String, Object>> list = lect_dao.getPlanDetail(store, period, subject_cd);
//		if(list.size() > 0)
//		{
//			lect_dao.upPlan(store, period, subject_cd, target, food_amt, food_contents, lect_intro, lect_cnt, lect_contents, lect_food, login_seq);
//		}
//		else
//		{
//			lect_dao.insPlan(store, period, subject_cd, target, food_amt, food_contents, lect_intro, lect_cnt, lect_contents, lect_food, login_seq);
//		}
//		
//		
//		
//		mav.addObject("isSuc", "success");
//		mav.addObject("msg", "저장되었습니다.");
//		return mav;
//	}
	@RequestMapping("/getRoomList")
	@ResponseBody
	public HashMap<String, Object> getRoomList(HttpServletRequest request) {
		

		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String del_yn = Utils.checkNullString(request.getParameter("del_yn"));

		List<HashMap<String, Object>> listCnt = lect_dao.getRoomCount(store,del_yn);
		List<HashMap<String, Object>> listCnt_all = lect_dao.getRoomCount(store, "");
		//List<HashMap<String, Object>> listCnt = lect_dao.getPeltCount(store, period, search_type, search_name, pelt_status, subject_fg);
		//List<HashMap<String, Object>> listCnt_all = lect_dao.getPeltCount("", "", "", "", "", "");
		//List<HashMap<String, Object>> listCnt = lect_dao.getRoomCount(search_name);
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
		
		
		
		List<HashMap<String, Object>> list = lect_dao.getRoom(s_point, listSize*page, order_by, sort_type, store, del_yn); 
		
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의실 조회", store);

		return map;
	}
	
	@RequestMapping("/room")
	public ModelAndView room(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/room");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		/*
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		if("".equals(sort_type))
		{
			sort_type = "create_date";
		}
		if("".equals(order_by))
		{
			order_by = "desc";
		}
		
		List<HashMap<String, Object>> listCnt = lect_dao.getRoomCount(search_name);
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
		
		List<HashMap<String, Object>> list = lect_dao.getRoom(search_name, s_point, listSize*page, order_by, sort_type); 
		
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("order_by", order_by);
		mav.addObject("sort_type", sort_type);
		mav.addObject("search_name", search_name);
		mav.addObject("s_page", s_page);
		mav.addObject("e_page", e_page);
		mav.addObject("pageNum", pageNum);
		mav.addObject("listSize", listSize);
		*/
		
		return mav;
	}
	@RequestMapping("/attend")
	public ModelAndView attend(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/attend");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		
		return mav;
	}
	
	
//	@RequestMapping("/plan_write")
//	public ModelAndView plan_write(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView(); 
//		mav.setViewName("/WEB-INF/pages/lecture/lect/plan_write");
//		
//		String store = Utils.checkNullString(request.getParameter("store"));
//		String period = Utils.checkNullString(request.getParameter("period"));
//		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
//		
//		
//		List<HashMap<String, Object>> list = lect_dao.getPlanDetail(store, period, subject_cd);
//		HashMap<String, Object> data = lect_dao.getPeltOne(store, period, subject_cd);
//		
//		
//		int percent = 0;
//		if(list.size() > 0)
//		{
//			double nowCnt = (double)list.get(0).get("LECT_CNT").toString().split("\\|").length;
//			double totalCnt = Double.parseDouble(data.get("LECT_CNT").toString());
//			double a = nowCnt / totalCnt;
//			percent = (int) (a * 100);
//		}
//		
//		
//		mav.addObject("percent", percent);
//		mav.addObject("data", data);
//		mav.addObject("list", list);
//		mav.addObject("store", store);
//		mav.addObject("period", period);
//		mav.addObject("subject_cd", subject_cd);
//		return mav;
//	}
	
	@RequestMapping("/room_view")
	public ModelAndView room_view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/room_view");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		String seq = Utils.checkNullString(request.getParameter("seq")); 
		
		HashMap<String, Object> data = lect_dao.getRoomView(seq);
		mav.addObject("data", data);
		
		String store = Utils.checkNullString(data.get("STORE"));
		
		List<HashMap<String, Object>> room_list = lect_dao.getRoomByStore(store, "");
		mav.addObject("room_list", room_list);
		mav.addObject("seq", seq);
		
		return mav;
	}

	@RequestMapping("/attend_detail")
	public ModelAndView attend_detail(HttpServletRequest request) throws ParseException {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/attend_detail");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		
		
		HashMap<String, Object> data = lect_dao.getPrevInfo(store, period, subject_cd); 
		
		String day_flag = "";
		if(data.get("DAY_FLAG") != null) {day_flag = Utils.checkNullString(data.get("DAY_FLAG"));}
		String cancled_list = "";
		if(data.get("CANCLED_LIST") != null) {cancled_list = Utils.checkNullString(data.get("CANCLED_LIST")).replaceAll("-","");}
		String lect_cnt = "";
		if(data.get("LECT_CNT") != null) {lect_cnt = Utils.checkNullString(data.get("LECT_CNT"));}
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_peri = "";
		
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		String yoil = "";
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		final String DATE_PATTERN = "yyyyMMdd";
			String inputStartDate = Utils.checkNullString(data.get("START_YMD"));
			//String inputStartDate = Utils.checkNullString(data.get("START_YMD"));
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
			Date startDate = sdf.parse(inputStartDate);
			ArrayList<String> dates = new ArrayList<String>();
			Date currentDate = startDate;
		
		int z = 0;
		while(true)
		{
			for(int k = 0; k < yoil.split(",").length; k++)
			{
				int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
				String convWe = "";
				if(we == 1) {convWe = "일";}
				if(we == 2) {convWe = "월";}
				if(we == 3) {convWe = "화";}
				if(we == 4) {convWe = "수";}
				if(we == 5) {convWe = "목";}
				if(we == 6) {convWe = "금";}
				if(we == 7) {convWe = "토";}
				if(convWe.equals(yoil.split(",")[k]))
				{
					//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
					if(cancled_list.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
					{
						dates.add(sdf.format(currentDate));
						z++;
					}
				}
			}
			if (lect_cnt.equals("0")) {
				break;
			}
			
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
			if(z == Integer.parseInt(lect_cnt))
			{
				break;
			}
		}
		String start_ymd = dates.get(0);
		String end_ymd = dates.get(dates.size()-1);
		
		for (String dd : dates) 
		{
			System.out.println("강의날짜 : "+dd);
		}
		String dayChk="";
		String dayChk_X ="";
		int dayChkCnt=0;
		for (int l = 0; l < Integer.parseInt(lect_cnt); l++) {
			dayChk += Utils.checkNullString(dates.get(l))+"|";
			//dayChk += "X|";
			dayChk_X +="X|";
					
			dayChkCnt++;
		}
		System.out.println("result : "+dayChk);
		//lect_dao.insAttend(store, period, subject_cd, login_seq,"Y","000000000 ",dayChk,"0");
		lect_dao.uptAttendDayChk(store, period, subject_cd, dayChk);
		
		List<HashMap<String, Object>> getAttendCustList = lect_dao.getAttendCustList(store, period, subject_cd);
		if (getAttendCustList.size() > 0) 
		{
			int new_day_cnt = dayChk_X.split("\\|").length; 
			int prev_day_cnt = getAttendCustList.get(0).get("DAY_CHK").toString().split("\\|").length;
			System.out.println("new_day_cnt : "+new_day_cnt);
			System.out.println("prev_day_cnt : "+prev_day_cnt);
			
			if (new_day_cnt!=prev_day_cnt) 
			{
				lect_dao.uptAttendDayChk_X(store, period, subject_cd, dayChk_X);				
			}
			
			/*
			int len = getAttendCustList.get(0).get("DAY_CHK").toString().split("\\|").length;
			System.out.println("len : "+len);
			System.out.println("dayChkCnt : "+dayChkCnt);
			
			String dayVal="";
			
			
			if (dayChkCnt > len) 
			{
				for (int i = 0; i < (dayChkCnt-len); i++) {
					dayVal +="X|";
				}
				
			}
			else if(dayChkCnt < len)
			{
				String custval="";
				for (int i = 0; i < getAttendCustList.size(); i++) {
					custval=getAttendCustList.get(i).get("DAY_CHK").toString();
					
					
					
				}				
			}
			*/
		}
		
		
		
		
		
		
		int attendeeCnt =0;
		HashMap<String, Object> getNewAttendeeCnt = lect_dao.getNewAttendeeCnt(store, period, subject_cd);
		if (getNewAttendeeCnt!=null) 
		{
			System.out.println("null아님!");
			attendeeCnt = Integer.parseInt(getNewAttendeeCnt.get("CNT").toString());
			System.out.println("attendeeCnt : "+ attendeeCnt);
			if (attendeeCnt > 0) 
			{
				System.out.println("insert 인원있음");
				lect_dao.addNewAttendee(store, period, subject_cd);
			}
		}
		
		
		
		
		
		
		HashMap<String, Object> getAttend = lect_dao.getAttend(store, period, subject_cd);
		for (String key : getAttend.keySet()) 
		{
			System.out.println(key +":"+getAttend.get(key));
			if (key.equals("SUBJECT_NM")) 
			{
				mav.addObject("EXCEL_SUBJECT_NM", Utils.repWord(getAttend.get(key).toString()));
			}
			mav.addObject(key, getAttend.get(key));
		}
		HashMap<String, Object> getSeason = lect_dao.getSeason(store, period);
		mav.addObject("WEB_TEXT", getSeason.get("WEB_TEXT"));
		mav.addObject("store",store);
		mav.addObject("period",period);
		mav.addObject("subject_cd",subject_cd);
		
		return mav;
	}
	
	@RequestMapping("/getCustAttendList")
	@ResponseBody
	public HashMap<String, Object> getCustAttendList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));

		
		List<HashMap<String, Object>> list = lect_dao.getAttendList(0, 9999, order_by, sort_type, store, period,subject_cd);
		List<HashMap<String, Object>> list_cnt = lect_dao.getAttendListCount(store, period,subject_cd);
		
		HashMap<String, Object> map = new HashMap<>();
		
		HashMap<String, Object> getAttend = lect_dao.getAttend(store, period, subject_cd);
		
		if (getAttend!=null) {
			map.put("isSuc","success");
			map.put("day_chk", getAttend.get("DAY_CHK"));		
			map.put("start_ymd", getAttend.get("START_YMD"));
			map.put("end_ymd", getAttend.get("END_YMD"));
			map.put("lect_hour", getAttend.get("LECT_HOUR"));
			map.put("subject_nm", getAttend.get("SUBJECT_NM"));
			map.put("subject_cd", getAttend.get("SUBJECT_CD"));
			map.put("web_lecturer_nm", getAttend.get("WEB_LECTURER_NM"));
			map.put("store_nm", getAttend.get("STORE_NM"));
			map.put("period", getAttend.get("PERIOD"));
		}else {
			map.put("isSuc","fail");
			map.put("msg","등록된 강좌가 없습니다.");
		}
		
		map.put("list", list);
		map.put("list_cnt", list_cnt.get(0).get("CNT"));
		return map;
	}
	
	@RequestMapping("/closed")
	public ModelAndView closed(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/closed");
		
		return mav;
	}
	@Transactional
	@RequestMapping("/sectAction")
	@ResponseBody
	public HashMap<String, Object> sectAction(HttpServletRequest request) {
		
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		String selAction = Utils.checkNullString(request.getParameter("selAction"));
		
		String chkList_[] = chkList.split("\\|");
		
		HttpSession session = request.getSession();
		for(int i = 0; i < chkList_.length; i++)
		{
			String data_chk[] = chkList_[i].split("_");
			String maincd = data_chk[1];
			String sectcd = data_chk[2];
			if(!"del".equals(selAction))
			{
				lect_dao.upSectPerformance(selBranch, maincd, sectcd, selAction);
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "중분류 수정", maincd+"/"+sectcd);
			}
			else if("del".equals(selAction))
			{
				lect_dao.upSectPerformance_del(selBranch, maincd, sectcd, selAction);
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "중분류 삭제", maincd+"/"+sectcd);
			}
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
        return map;
		
	}
	@RequestMapping("/changeDelete")
	@ResponseBody
	public HashMap<String, Object> changeDelete(HttpServletRequest request) {
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		String delete_yn = Utils.checkNullString(request.getParameter("delete_yn"));
		if("N".equals(delete_yn))
		{
			delete_yn = "Y";
		}
		else if("Y".equals(delete_yn))
		{
			delete_yn = "N";
		}
		
		lect_dao.upRoomChange(seq, delete_yn);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의실 상태 변경", seq+"/"+delete_yn);

		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
		
	}
	@RequestMapping("/changeDelete_cate")
	@ResponseBody
	public HashMap<String, Object> changeDelete_cate(HttpServletRequest request) {
		
		String maincd = Utils.checkNullString(request.getParameter("maincd"));
		String delete_yn = Utils.checkNullString(request.getParameter("delete_yn"));
		if("N".equals(delete_yn))
		{
			delete_yn = "Y";
		}
		else if("Y".equals(delete_yn))
		{
			delete_yn = "N";
		}
		
		lect_dao.upCateChange(maincd, delete_yn);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
		
	}
	@RequestMapping("/changeDelete_pelt")
	@ResponseBody
	public HashMap<String, Object> changeDelete_pelt(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String delete_yn = Utils.checkNullString(request.getParameter("delete_yn"));
		
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		lect_dao.upPeltEnd(store, period, subject_cd, delete_yn);
		
		String cust_no="";
		String act="";
		if (delete_yn.equals("Y")) { // 폐강 or 폐강취소 체크
			act="1";		   // 1:폐강 2:폐강취소
		}else {
			act="2";
		}
		
		System.out.println("act : "+act);
		System.out.println("delete_yn : "+delete_yn);
		
		
		HashMap<String, Object> LectData = sms_dao.getLectData(store, period,subject_cd);
		List<HashMap<String, Object>> getTmCustList = sms_dao.getTmCustList(store, period,subject_cd);
		if (getTmCustList.size()!=0) { //폐강시 수강생이 있다면
			//int tm_seq = sms_dao.insTm(store, period,subject_cd,act,create_resi_no);
			int tm_seq =  sms_dao.writeTm(store,period,"",act,create_resi_no,subject_cd,"N",LectData.get("START_YMD").toString());
			for (int j = 0; j < getTmCustList.size(); j++) {
				cust_no = Utils.checkNullString(getTmCustList.get(j).get("CUST_NO"));
				sms_dao.writeTmList(tm_seq,cust_no,create_resi_no,store,period);
			}
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
		
	}
	@RequestMapping("/getClassroom")
	@ResponseBody
	public List<HashMap<String, Object>> getClassroom(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		List<HashMap<String, Object>> room_list = lect_dao.getRoomByStore(store, "N"); 
		
		return room_list;
		
	}
	@RequestMapping("/getLectList")
	@ResponseBody
	public HashMap<String, Object> getLectList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String act = Utils.checkNullString(request.getParameter("act"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String pelt_status = Utils.checkNullString(request.getParameter("pelt_status"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start"));
		String search_end = Utils.checkNullString(request.getParameter("search_end"));
		String lect_cnt_start = Utils.checkNullString(request.getParameter("lect_cnt_start"));
		String lect_cnt_end = Utils.checkNullString(request.getParameter("lect_cnt_end"));
		String lect_nm = Utils.checkNullString(request.getParameter("lect_nm"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String day_flag = Utils.checkNullString(request.getParameter("day_flag"));
//		String mon = day_flag.substring(0,1);
//		String tue = day_flag.substring(1,2);
//		String wed = day_flag.substring(2,3);
//		String thu = day_flag.substring(3,4);
//		String fri = day_flag.substring(4,5);
//		String sat = day_flag.substring(5,6);
//		String sun = day_flag.substring(6,7);
		
		
		List<HashMap<String, Object>> listCnt = lect_dao.getLectListCount(store, period, search_type, search_name, pelt_status, subject_fg, act,
														search_start, search_end, lect_cnt_start, lect_cnt_end, lect_nm, main_cd,sect_cd, day_flag);
		List<HashMap<String, Object>> listCnt_all = lect_dao.getLectListCount(store, period, "", "", "", "", "","","","","","","","","0000000");
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
		System.out.println("listCount"+listCount);
		System.out.println("pageNum"+pageNum);
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
		
		List<HashMap<String, Object>> list = lect_dao.getLectList(s_point, listSize*page, order_by, sort_type, store, period, search_type, search_name, pelt_status, subject_fg, act, 
																	search_start, search_end, lect_cnt_start, lect_cnt_end, lect_nm, main_cd,sect_cd,day_flag);
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
		map.put("search_name", search_name);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "개설강좌 조회", store+"/"+period);
		return map;
		
	}
	
	@RequestMapping("/getAttendList")
	@ResponseBody
	public HashMap<String, Object> getAttendList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String act = Utils.checkNullString(request.getParameter("act"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String pelt_status = Utils.checkNullString(request.getParameter("pelt_status"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start"));
		String search_end = Utils.checkNullString(request.getParameter("search_end"));
		String lect_cnt_start = Utils.checkNullString(request.getParameter("lect_cnt_start"));
		String lect_cnt_end = Utils.checkNullString(request.getParameter("lect_cnt_end"));
		String lect_nm = Utils.checkNullString(request.getParameter("lect_nm"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String day_flag = Utils.checkNullString(request.getParameter("day_flag"));
//		String mon = day_flag.substring(0,1);
//		String tue = day_flag.substring(1,2);
//		String wed = day_flag.substring(2,3);
//		String thu = day_flag.substring(3,4);
//		String fri = day_flag.substring(4,5);
//		String sat = day_flag.substring(5,6);
//		String sun = day_flag.substring(6,7);
		
		
		
		List<HashMap<String, Object>> listCnt = lect_dao.getAttendLectListCount(store, period, search_type, search_name, pelt_status, subject_fg, act,
																		search_start, search_end, lect_cnt_start, lect_cnt_end, lect_nm, main_cd,sect_cd, day_flag);
		List<HashMap<String, Object>> listCnt_all = lect_dao.getAttendLectListCount(store, period, "", "", "", "", "","","","","","","","","");
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
		System.out.println("listCount"+listCount);
		System.out.println("pageNum"+pageNum);
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
		
		List<HashMap<String, Object>> list = lect_dao.getAttendLectList(s_point, listSize*page, order_by, sort_type, store, period, search_type, search_name, pelt_status, subject_fg, act,
																	search_start, search_end, lect_cnt_start, lect_cnt_end, lect_nm, main_cd,sect_cd,day_flag); 
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
		map.put("search_name", search_name);
		return map;
		
	}
	
	@RequestMapping("/setMid")
	@ResponseBody
	public HashMap<String, Object> setMid(HttpServletRequest request) throws ParseException {
		
		HashMap<String, Object> map = new HashMap<>();
		
		String mid = Utils.checkNullString(request.getParameter("mid"));
		
		String store = mid.split("_")[0];
		String period = mid.split("_")[1];
		String subject_cd = mid.split("_")[2];
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		
		//중도수강인원 계산
//		int capacity_no = Integer.parseInt(list.get(0).get("CAPACITY_NO").toString());
//		int regis_no = Integer.parseInt(list.get(0).get("REGIS_NO").toString());
//		String mid_capacity_no = Integer.toString(capacity_no-regis_no);
		//중도수강인원 계산
		
		//남은 강좌수 계산
		String yoil = "";
		String day_flag = Utils.checkNullString(list.get(0).get("DAY_FLAG"));
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_pelt = "";
		String cancled_list_peri = "";
		if(list.size() > 0 && list.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_pelt = Utils.checkNullString(list.get(0).get("CANCLED_LIST")).replaceAll("-", "");
		}
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		
	    final String DATE_PATTERN = "yyyyMMdd";
        String inputStartDate = AKCommon.getCurrentDate();
        String inputEndDate = Utils.checkNullString(list.get(0).get("END_YMD"));
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date startDate = sdf.parse(inputStartDate);
        Date endDate = sdf.parse(inputEndDate);
        ArrayList<String> dates = new ArrayList<String>();
        Date currentDate = startDate;
        
        while (currentDate.compareTo(endDate) <= 0) 
        {
        	for(int j = 0; j < yoil.split(",").length; j++)
        	{
        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
    		    String convWe = "";
    		    if(we == 1) {convWe = "일";}
    		    if(we == 2) {convWe = "월";}
    		    if(we == 3) {convWe = "화";}
    		    if(we == 4) {convWe = "수";}
    		    if(we == 5) {convWe = "목";}
    		    if(we == 6) {convWe = "금";}
    		    if(we == 7) {convWe = "토";}
        		if(convWe.equals(yoil.split(",")[j]))
        		{
        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
        			if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
        			{
        				dates.add(sdf.format(currentDate));
        			}
        		}
        	}
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
        }
        int z = 0;
        String start_ymd = "";
        for (String dd : dates) 
        {
        	if(z == 0)
        	{
        		start_ymd = dd;
        	}
        	System.out.println("강의날짜 : "+dd);
        	z++;
        }
        
        
        System.out.println("남은강좌수 : "+dates.size());
		
		//강의료 계산
		int regis_fee = Utils.checkNullInt(list.get(0).get("REGIS_FEE"));
		int food_amt = 0;
		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
		{
			food_amt = Utils.checkNullInt(list.get(0).get("FOOD_AMT"));
		}
		int lect_cnt = Utils.checkNullInt(list.get(0).get("LECT_CNT"));
		int mid_regis_fee = (int) Math.round((double)regis_fee / lect_cnt * dates.size());
		mid_regis_fee = (mid_regis_fee + 900)/1000 * 1000; //일의자리 반올림하기위함 
		
		
		int mid_food_amt = 0;
		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
		{
			mid_food_amt = (int) Math.round((double)food_amt / lect_cnt * dates.size());
			mid_food_amt = (mid_food_amt + 900)/1000 * 1000; //일의자리 반올림하기위함 
		}
		
		
		
		
	    
//		String main_cd = list.get(0).get("MAIN_CD").toString();
//		String sect_cd = list.get(0).get("SECT_CD").toString();
//		List<HashMap<String, Object>> code_list = lect_dao.getlectcode(main_cd, sect_cd); 
//		String mid_subject_cd = "";
//		String mid_lect_cd = Integer.toString(Integer.parseInt(code_list.get(0).get("LECT_CD").toString())+1);
//		if(mid_lect_cd.length() == 1)
//		{
//			mid_lect_cd = "000"+mid_lect_cd;
//		}
//		else if(mid_lect_cd.length() == 2)
//		{
//			mid_lect_cd = "00"+mid_lect_cd;
//		}
//		else if(mid_lect_cd.length() == 3)
//		{
//			mid_lect_cd = "0"+mid_lect_cd;
//		}
//		mid_subject_cd = list.get(0).get("MAIN_CD").toString() + list.get(0).get("SECT_CD").toString() + mid_lect_cd;
	    
	    
	    
//		String lect_hour = "";
//		if(list.get(0).get("LECT_HOUR") != null) {lect_hour = list.get(0).get("LECT_HOUR").toString();}
//		String web_cancle_ymd = "";
//		if(list.get(0).get("WEB_CANCEL_YMD") != null) {web_cancle_ymd = list.get(0).get("WEB_CANCEL_YMD").toString();}
//		String classroom = "";
//		if(list.get(0).get("CLASSROOM") != null) {classroom = list.get(0).get("CLASSROOM").toString();}
//		String lecturer_cd = "";
//		if(list.get(0).get("LECTURER_CD") != null) {lecturer_cd = list.get(0).get("LECTURER_CD").toString();}
//		String lecturer_cd1 = "";
//		if(list.get(0).get("LECTURER_CD1") != null) {lecturer_cd = list.get(0).get("LECTURER_CD1").toString();}
//		String end_ymd = "";
//		if(list.get(0).get("END_YMD") != null) {end_ymd = list.get(0).get("END_YMD").toString();}
//		String subject_fg = "";
//		if(list.get(0).get("SUBJECT_FG") != null) {subject_fg = list.get(0).get("SUBJECT_FG").toString();}
//		String fix_pay_yn = "";
//		if(list.get(0).get("FIX_PAY_YN") != null) {fix_pay_yn = list.get(0).get("FIX_PAY_YN").toString();}
//		String fix_amt = "";
//		if(list.get(0).get("FIX_AMT") != null) {fix_amt = list.get(0).get("FIX_AMT").toString();}
//		String fix_rate = "";
//		if(list.get(0).get("FIX_RATE") != null) {fix_rate = list.get(0).get("FIX_RATE").toString();}
//		String pay_day = "";
//		if(list.get(0).get("PAY_DAY") != null) {pay_day = list.get(0).get("PAY_DAY").toString();}
//		String food_yn = "";
//		if(list.get(0).get("FOOD_YN") != null) {food_yn = list.get(0).get("FOOD_YN").toString();}
//		String web_lecturer_nm = "";
//		if(list.get(0).get("WEB_LECTURER_NM") != null) {web_lecturer_nm = list.get(0).get("WEB_LECTURER_NM").toString();}
//		String web_lecturer_nm1 = "";
//		if(list.get(0).get("WEB_LECTURER_NM1") != null) {web_lecturer_nm1 = list.get(0).get("WEB_LECTURER_NM1").toString();}
//		String month_no = "";
//		if(list.get(0).get("MONTH_NO") != null) {month_no = list.get(0).get("MONTH_NO").toString();}
//		String month_no1 = "";
//		if(list.get(0).get("MONTH_NO1") != null) {month_no1 = list.get(0).get("MONTH_NO1").toString();}
//		String subject_nm = "";
//		if(list.get(0).get("SUBJECT_NM") != null) {subject_nm = "(중도)"+list.get(0).get("SUBJECT_NM").toString();}
//		String cancled_list = "";
//		if(list.get(0).get("CANCLED_LIST") != null) {cancled_list = list.get(0).get("CANCLED_LIST").toString();}
//		String cus_no = "";
//		if(list.get(0).get("CUS_NO") != null) {cus_no = list.get(0).get("CUS_NO").toString();}
//		String cus_no1 = "";
//		if(list.get(0).get("CUS_NO1") != null) {cus_no1 = list.get(0).get("CUS_NO1").toString();}
//		String corp_fg = "";
//		if(list.get(0).get("CORP_FG") != null) {corp_fg = list.get(0).get("CORP_FG").toString();}
//		String is_two = "";
//		if(list.get(0).get("IS_TWO") != null) {is_two = list.get(0).get("IS_TWO").toString();}
		
		
//		HttpSession session = request.getSession();
//		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
//		lect_dao.insLect(store, period, mid_subject_cd, subject_nm, main_cd, sect_cd, mid_lect_cd, login_seq);
//		lect_dao.insPelt(store, period, mid_subject_cd, main_cd, sect_cd,
//				day_flag, lect_hour, web_cancle_ymd, Integer.toString(dates.size()), classroom, lecturer_cd, lecturer_cd1,
//				start_ymd, end_ymd, mid_capacity_no, subject_fg, Integer.toString(mid_regis_fee),
//				fix_pay_yn, fix_amt, fix_rate, pay_day, food_yn, Integer.toString(mid_food_amt),
//				web_lecturer_nm, web_lecturer_nm1, month_no, month_no1, subject_nm,
//				cancled_list, login_seq, cus_no, cus_no1, corp_fg, is_two); 			
				
			
		
		
		map.put("regis_fee", mid_regis_fee);
		map.put("food_amt", mid_food_amt);
		map.put("start_ymd", start_ymd);
        map.put("lect_cnt", dates.size());
        
        //부모강좌의 데이터
        map.put("store", store);
        map.put("period", period);
        map.put("subject_cd", subject_cd);
		
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
		
	}
	@Transactional
	@RequestMapping("/lectDel")
	@ResponseBody
	public HashMap<String, Object> lectDel(HttpServletRequest request) throws ParseException {
		
		HashMap<String, Object> map = new HashMap<>();
		
		String mid = Utils.checkNullString(request.getParameter("mid"));
		String[] mid_arr = mid.split("\\|");
		for (int i = 0; i < mid_arr.length; i++) {
			String store = mid_arr[i].split("_")[0];
			String period = mid_arr[i].split("_")[1];
			String subject_cd = mid_arr[i].split("_")[2];
			
			System.out.println(store);
			System.out.println(period);
			System.out.println(subject_cd);
			
			int cnt = lect_dao.getPereCnt(store, period, subject_cd);
			if(cnt > 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "결제이력이 있는 강좌의 경우 삭제가 불가합니다.");
			}
			else
			{
				lect_dao.lectDel(store,period,subject_cd);
				lect_dao.contractDel(store,period,subject_cd);
				lect_dao.delAttend(store,period,subject_cd);
				map.put("isSuc", "success");
				map.put("msg", "저장되었습니다.");
				HttpSession session = request.getSession();
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌 삭제", store+"/"+period+"/"+subject_cd);
			}
			
			
		}
		//List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		return map;
		
		
		
		
	}
	
	@RequestMapping("/endAction")
	@ResponseBody
	public HashMap<String, Object> endAction(HttpServletRequest request){
		
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		String act = Utils.checkNullString(request.getParameter("act"));
		String arr[] = chkList.split("\\|");
		String send_tm = Utils.checkNullString(request.getParameter("send_tm"));
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String cust_no="";
		//String tm_seq ="";
		//List<HashMap<String, Object>> getTmSeq = sms_dao.getTmSeq();
		//tm_seq = getTmSeq.get(0).get("TM_SEQ").toString();
		
		
		for(int i = 0; i < arr.length; i++)
		{
			String store = arr[i].split("_")[0];
			String period = arr[i].split("_")[1];
			String subject_cd = arr[i].split("_")[2];
			
			lect_dao.upPeltEnd(store, period, subject_cd, act);
			
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌 상태 변경", store+"/"+period+"/"+subject_cd+"/"+act);
			
			String tm_act = "2";
			if (act.equals("Y")) { // 폐강 or 폐강취소 체크
				tm_act="1";		   // 1:폐강 2:폐강취소
			}else {
				tm_act="2";
			}
			
			
			HashMap<String, Object> LectData = sms_dao.getLectData(store, period,subject_cd);
			List<HashMap<String, Object>> getTmCustList = sms_dao.getTmCustList(store, period,subject_cd);
			if (getTmCustList.size()!=0 && send_tm.equals("Y")) { //폐강시 수강생이 있다면
				//int tm_seq = sms_dao.insTm(store, period,subject_cd,act,create_resi_no);
				int tm_seq =  sms_dao.writeTm(store,period,"",tm_act,create_resi_no,subject_cd,"N",LectData.get("START_YMD").toString());
				for (int j = 0; j < getTmCustList.size(); j++) {
					cust_no = Utils.checkNullString(getTmCustList.get(j).get("CUST_NO"));
					sms_dao.writeTmList(tm_seq,cust_no,create_resi_no,store,period);
				}
			}

			
			
		}
		//if (send_tm.equals("Y")) {
		//	sms_dao.add_TmSeq();
		//}

		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
		
	}
	@RequestMapping("/delRoom")
	@ResponseBody
	public HashMap<String, Object> delRoom(HttpServletRequest request){
		
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		String arr[] = chkList.split("\\|");
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		for(int i = 0; i < arr.length; i++)
		{
			String seq_no = arr[i];
			
			lect_dao.delRoom(seq_no);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의실 삭제", seq_no);
		}

		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");

		return map;
		
	}
	@RequestMapping("/searchUseRoom")
	@ResponseBody
	public int searchUseRoom(HttpServletRequest request){
		
		String seq_no = Utils.checkNullString(request.getParameter("seq_no"));
		int cnt = lect_dao.searchUseRoom(seq_no);
		return cnt;
		
	}
	@RequestMapping("/getRoomCapacity")
	@ResponseBody
	public int getRoomCapacity(HttpServletRequest request){
		
		String seq_no = Utils.checkNullString(request.getParameter("seq_no"));
		return lect_dao.getRoomCapacity(seq_no);
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("/WEB-INF/pages/lecture/lect/detail");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/main")
	public ModelAndView main(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("/WEB-INF/pages/lecture/lect/main");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		return mav;
	}
	@RequestMapping("/list_detail")
	public ModelAndView list_detail(HttpServletRequest request) throws ParseException {
		ModelAndView mav = new ModelAndView();		
		mav.setViewName("/WEB-INF/pages/lecture/lect/list_detail");
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		HashMap<String, Object> getSeason = lect_dao.getSeason(store, period);
		mav.addObject("WEB_TEXT", getSeason.get("WEB_TEXT"));
		
		List<HashMap<String, Object>> list_plan = lect_dao.getPlanDetail(store, period, subject_cd);
		mav.addObject("list", list_plan);
		
		HashMap<String, Object> data = lect_dao.getPeltOne(store, period, subject_cd);
		mav.addObject("data", data);
		mav.addObject("subject_cd", subject_cd);
		mav.addObject("store", store);
		mav.addObject("period", period);
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		//강의진행도 계산
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		int lect_cnt = Utils.checkNullInt(list.get(0).get("LECT_CNT"));
		String cancled_list_pelt = Utils.checkNullString(list.get(0).get("CANCLED_LIST")).replaceAll("-", "");
		String cancled_list_peri = "";
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		String yoil = "";
		String day_flag = Utils.checkNullString(list.get(0).get("DAY_FLAG"));
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		final String DATE_PATTERN = "yyyyMMdd";
		String inputStartDate = Utils.checkNullString(data.get("START_YMD"));
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date startDate = sdf.parse(inputStartDate);
        ArrayList<String> dates = new ArrayList<String>();
        Date currentDate = startDate;
        
        int i = 0;
        while(true)
        {
        	for(int j = 0; j < yoil.split(",").length; j++)
        	{
        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
    		    String convWe = "";
    		    if(we == 1) {convWe = "일";}
    		    if(we == 2) {convWe = "월";}
    		    if(we == 3) {convWe = "화";}
    		    if(we == 4) {convWe = "수";}
    		    if(we == 5) {convWe = "목";}
    		    if(we == 6) {convWe = "금";}
    		    if(we == 7) {convWe = "토";}
        		if(convWe.equals(yoil.split(",")[j]))
        		{
        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
        			if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
        			{
        				dates.add(sdf.format(currentDate));
        				i++;
        			}
        		}
        	}
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
            if(i == lect_cnt)
			{
				break;
			}
        }
        int inputStartDate2 = Integer.parseInt(AKCommon.getCurrentDate());
        int z = 0;
        for (String dd : dates) 
        {
        	if(inputStartDate2 < Integer.parseInt(dd))
        	{
        		System.out.println("아직강의안했다. : "+dd);
        		break;
        	}
        	z++;
        	System.out.println("강의날짜 : "+dd);
        }
        System.out.println("지금까지 한 강의수 : "+z);
        System.out.println("총 강의수 : "+lect_cnt);
        
        int percent = (int) (((double)z / (double)lect_cnt) * 100);
        System.out.println("퍼센트 : "+percent);
        
        mav.addObject("percent", percent);
		//강의진행도 계산
		
        
        //강의계획서
        List<HashMap<String, Object>> plan_list = lect_dao.getPlanDetail(store, period, subject_cd);
		HashMap<String, Object> plan_data = lect_dao.getPeltOne(store, period, subject_cd);
		
		
		if(plan_list.size() > 0)
		{
			plan_list.get(0).put("ETC", Utils.checkNullString(plan_list.get(0).get("ETC")).replaceAll("\n", "\\|"));
		}
		
		mav.addObject("plan_list_size", plan_list.size());
		mav.addObject("plan_data", plan_data);
		mav.addObject("plan_list", plan_list);
        //강의계획서
		
//		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		String search_name = Utils.checkNullString(request.getParameter("search_name"));
//		
//		List<HashMap<String, Object>> listCnt = lect_dao.getPeltDetailCount(search_name, store, period, subject_cd);
//		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
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
//		    s_page = 1;
//		}
//		int e_page = nowBlock*block;
//		if (pageNum <= e_page) {
//		    e_page = pageNum;
//		}
//		
//		int s_point = (page-1) * listSize;
//		
//		List<HashMap<String, Object>> list = lect_dao.getPeltDetail(search_name, s_point, listSize*page, order_by, sort_type, store, period, subject_cd);
//		
//		mav.addObject("list", list);
//		mav.addObject("page", page);
//		mav.addObject("order_by", order_by);
//		mav.addObject("sort_type", sort_type);
//		mav.addObject("search_name", search_name);
//		mav.addObject("s_page", s_page);
//		mav.addObject("e_page", e_page);
//		mav.addObject("pageNum", pageNum);
//		mav.addObject("listSize", listSize);
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌 상세 조회", store+"/"+period+"/"+subject_cd);

		
		
		HashMap<String, Object> getAttend = lect_dao.getAttend(store, period, subject_cd);
		if(getAttend != null)
		{
			for (String key : getAttend.keySet()) 
			{
				System.out.println(key +":"+getAttend.get(key));
				if (key.equals("SUBJECT_NM")) 
				{
					mav.addObject("EXCEL_SUBJECT_NM", Utils.repWord(getAttend.get(key).toString()));
				}
				
				if (key.equals("WEB_LECTURER_NM") || key.equals("START_YMD") || key.equals("END_YMD") || key.equals("LECT_HOUR")) {
					mav.addObject(key, getAttend.get(key));				
				}
			}
		}
		
		
		return mav;
	}
	@RequestMapping("/getRegisByLect")
	@ResponseBody
	public HashMap<String, Object> getRegisByLect(HttpServletRequest request) {
		
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		System.out.println("order_by : "+order_by);
		System.out.println("sort_type : "+sort_type);
		
		List<HashMap<String, Object>> list = lect_dao.getPeltDetail("", 0, 9999, order_by, sort_type, store, period, subject_cd);
		List<HashMap<String, Object>> list_cnt = lect_dao.getPeltDetailCount("", store, period, subject_cd);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("list_cnt", list_cnt.get(0).get("CNT"));
		return map;
	}
	@RequestMapping("/setSchedule_test")
	@ResponseBody
	public void setSchedule_test(HttpServletRequest request) throws ParseException{
		
		String store = "03";
		String period = "095";
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday_test(store, period);
		
		List<HashMap<String, Object>> list = lect_dao.getSchedule_test(store, period); 
		for(int z = 0; z < list.size(); z++)
		{
			String day_flag = Utils.checkNullString(list.get(z).get("DAY_FLAG"));
			int lect_cnt = Utils.checkNullInt(list.get(z).get("LECT_CNT"));
			String start_ymd = Utils.checkNullString(list.get(z).get("START_YMD"));
			String end_ymd = Utils.checkNullString(list.get(z).get("END_YMD"));
			
			System.out.println("원래 강좌일정 : "+start_ymd+" ~ " +end_ymd + " / "+list.get(z).get("SUBJECT_CD"));
			String cancled_list_pelt = Utils.checkNullString(list.get(z).get("CANCLED_LIST")).replaceAll("-", "");
			String cancled_list_peri = "";
			if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
			{
				cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
			}
			String yoil = "";
			if(day_flag.split("")[0].equals("1")){yoil += ",월";}
			if(day_flag.split("")[1].equals("1")){yoil += ",화";}
			if(day_flag.split("")[2].equals("1")){yoil += ",수";}
			if(day_flag.split("")[3].equals("1")){yoil += ",목";}
			if(day_flag.split("")[4].equals("1")){yoil += ",금";}
			if(day_flag.split("")[5].equals("1")){yoil += ",토";}
			if(day_flag.split("")[6].equals("1")){yoil += ",일";}
			yoil = yoil.substring(1, yoil.length());
			
			final String DATE_PATTERN = "yyyyMMdd";
			String inputStartDate = "";
			inputStartDate = start_ymd;
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
	        Date startDate = sdf.parse(inputStartDate);
	        ArrayList<String> dates = new ArrayList<String>();
	        Date currentDate = startDate;
	        
	        int i = 0;
	        while(true)
	        {
	        	for(int j = 0; j < yoil.split(",").length; j++)
	        	{
	        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
	    		    String convWe = "";
	    		    if(we == 1) {convWe = "일";}
	    		    if(we == 2) {convWe = "월";}
	    		    if(we == 3) {convWe = "화";}
	    		    if(we == 4) {convWe = "수";}
	    		    if(we == 5) {convWe = "목";}
	    		    if(we == 6) {convWe = "금";}
	    		    if(we == 7) {convWe = "토";}
	        		if(convWe.equals(yoil.split(",")[j]))
	        		{
	        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외 //특강은 그냥 무시
	        			if(lect_cnt == 1)
	        			{
	        				dates.add(sdf.format(currentDate));
	        				i++;
	        			}
	        			else
	        			{
	        				if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
	        				{
	        					dates.add(sdf.format(currentDate));
		        				i++;
	        				}
	        			}
	        				
	        		}
	        	}
	            Calendar c = Calendar.getInstance();
	            c.setTime(currentDate);
	            c.add(Calendar.DAY_OF_MONTH, 1);
	            currentDate = c.getTime();
	            if(i == lect_cnt)
				{
					break;
				}
	        }
	        if(!dates.get(dates.size()-1).equals(end_ymd))
	        {
	        	System.out.println("수정된 강좌일정 : "+dates.get(0)+" ~ " +dates.get(dates.size()-1) + " / "+list.get(z).get("SUBJECT_CD"));
	        	lect_dao.upPeltSchedule_test(store, period, Utils.checkNullString(list.get(z).get("SUBJECT_CD")), dates.get(dates.size()-1));
	        }
		}

	}
	@RequestMapping("/setSchedule_all")
	@ResponseBody
	public HashMap<String, Object> setSchedule_all(HttpServletRequest request) throws ParseException{
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		
		List<HashMap<String, Object>> list = lect_dao.getSchedule(store, period); 
		for(int z = 0; z < list.size(); z++)
		{
			try 
			{
				String day_flag = Utils.checkNullString(list.get(z).get("DAY_FLAG"));
				int lect_cnt = Utils.checkNullInt(list.get(z).get("LECT_CNT"));
				String start_ymd = Utils.checkNullString(list.get(z).get("START_YMD"));
				String end_ymd = Utils.checkNullString(list.get(z).get("END_YMD"));
				
				System.out.println("원래 강좌일정 : "+start_ymd+" ~ " +end_ymd + " / "+list.get(z).get("SUBJECT_CD"));
				String cancled_list_pelt = Utils.checkNullString(list.get(z).get("CANCLED_LIST")).replaceAll("-", "");
				String cancled_list_peri = "";
				if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
				{
					cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
				}
				String yoil = "";
				if(day_flag.split("")[0].equals("1")){yoil += ",월";}
				if(day_flag.split("")[1].equals("1")){yoil += ",화";}
				if(day_flag.split("")[2].equals("1")){yoil += ",수";}
				if(day_flag.split("")[3].equals("1")){yoil += ",목";}
				if(day_flag.split("")[4].equals("1")){yoil += ",금";}
				if(day_flag.split("")[5].equals("1")){yoil += ",토";}
				if(day_flag.split("")[6].equals("1")){yoil += ",일";}
				yoil = yoil.substring(1, yoil.length());
				
				final String DATE_PATTERN = "yyyyMMdd";
				String inputStartDate = "";
				inputStartDate = start_ymd;
				SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
		        Date startDate = sdf.parse(inputStartDate);
		        ArrayList<String> dates = new ArrayList<String>();
		        Date currentDate = startDate;
		        
		        int i = 0;
		        while(true)
		        {
		        	for(int j = 0; j < yoil.split(",").length; j++)
		        	{
		        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
		    		    String convWe = "";
		    		    if(we == 1) {convWe = "일";}
		    		    if(we == 2) {convWe = "월";}
		    		    if(we == 3) {convWe = "화";}
		    		    if(we == 4) {convWe = "수";}
		    		    if(we == 5) {convWe = "목";}
		    		    if(we == 6) {convWe = "금";}
		    		    if(we == 7) {convWe = "토";}
		        		if(convWe.equals(yoil.split(",")[j]))
		        		{
		        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외 //특강은 그냥 무시
		        			if(lect_cnt == 1)
		        			{
		        				dates.add(sdf.format(currentDate));
		        				i++;
		        			}
		        			else
		        			{
		        				if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
		        				{
		        					dates.add(sdf.format(currentDate));
			        				i++;
		        				}
		        			}
		        				
		        		}
		        	}
		            Calendar c = Calendar.getInstance();
		            c.setTime(currentDate);
		            c.add(Calendar.DAY_OF_MONTH, 1);
		            currentDate = c.getTime();
		            if(i == lect_cnt)
					{
						break;
					}
		        }
		        if(!dates.get(dates.size()-1).equals(end_ymd))
		        {
		        	System.out.println("수정된 강좌일정 : "+dates.get(0)+" ~ " +dates.get(dates.size()-1) + " / "+list.get(z).get("SUBJECT_CD"));
		        	lect_dao.upPeltSchedule(store, period, Utils.checkNullString(list.get(z).get("SUBJECT_CD")), dates.get(dates.size()-1));
		        }
			} 
			catch (Exception e) 
			{
				e.printStackTrace();
			}
		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌일정 일괄적용", store+"/"+period);
		return map;

	}
	
	@RequestMapping("/setSchedule")
	@ResponseBody
	public HashMap<String, Object> setSchedule(HttpServletRequest request) throws ParseException{
		
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		System.out.println("store : "+store);
		String period = Utils.checkNullString(request.getParameter("selPeri"));
		String day_flag = Utils.checkNullString(request.getParameter("day_flag"));
		int lect_cnt = Utils.checkNullInt(Utils.checkNullInt(request.getParameter("lect_cnt")));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String act = Utils.checkNullString(request.getParameter("act"));
		HashMap<String, Object> data = peri_dao.getPeriOne(period, store); 
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_pelt = Utils.checkNullString(request.getParameter("cancled_list")).replaceAll("-", "");
		String cancled_list_peri = "";
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		String yoil = "";
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		
		final String DATE_PATTERN = "yyyyMMdd";
		String inputStartDate = "";
		if("init".equals(act))
		{
			inputStartDate = Utils.checkNullString(data.get("START_YMD"));
		}
		else
		{
			inputStartDate = start_ymd;
		}
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date startDate = sdf.parse(inputStartDate);
        ArrayList<String> dates = new ArrayList<String>();
        Date currentDate = startDate;
        
        
        int i = 0;
        while(true)
        {
        	for(int j = 0; j < yoil.split(",").length; j++)
        	{
        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
    		    String convWe = "";
    		    if(we == 1) {convWe = "일";}
    		    if(we == 2) {convWe = "월";}
    		    if(we == 3) {convWe = "화";}
    		    if(we == 4) {convWe = "수";}
    		    if(we == 5) {convWe = "목";}
    		    if(we == 6) {convWe = "금";}
    		    if(we == 7) {convWe = "토";}
        		if(convWe.equals(yoil.split(",")[j]))
        		{
        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
        			if(lect_cnt == 1)
        			{
        				dates.add(sdf.format(currentDate));
        				i++;
        			}
        			else
        			{
        				if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
        				{
        					dates.add(sdf.format(currentDate));
	        				i++;
        				}
        			}
        		}
        	}
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
            if(i == lect_cnt)
			{
				break;
			}
        }
        
        String isChk = Utils.checkNullString(request.getParameter("isChk"));
        String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
        System.out.println("store : "+store);
        System.out.println("period : "+period);
        System.out.println("day_flag : "+day_flag);
        System.out.println("subject_cd : "+subject_cd);
        System.out.println("isChk : "+isChk);
        
	        for (String dd : dates) 
	        {
	        	System.out.println("강의날짜 : "+dd);
	        }
	        
	     if (isChk.equals("save")) {
		    HashMap<String, Object> uptinfo = new HashMap<String, Object>();
		    uptinfo.put("DAY1", "X"); uptinfo.put("DAY5", "X"); uptinfo.put("DAY9", "X");
		    uptinfo.put("DAY2", "X"); uptinfo.put("DAY6", "X"); uptinfo.put("DAY10", "X");
		    uptinfo.put("DAY3", "X"); uptinfo.put("DAY7", "X"); uptinfo.put("DAY11", "X");
		    uptinfo.put("DAY4", "X"); uptinfo.put("DAY8", "X"); uptinfo.put("DAY12", "X");
		    try {
			        for (int j = 0; j < 12; j++) {
			        	uptinfo.put("DAY"+(j+1), Utils.checkNullString(dates.get(j)));
					}
			    System.out.println("12강 됨");
		    } catch (Exception e) {
		    	System.out.println("12강 안됨");
		    }
		    uptinfo.put("store", store);
		    uptinfo.put("period", period);
		    uptinfo.put("subject_cd", subject_cd);
		    uptinfo.put("target", "Y");
		    lect_dao.uptAttend(uptinfo);
		    System.out.println("uptinfo : "+uptinfo);
	    }
	    
	    
		
        HashMap<String, Object> map = new HashMap<>();
        map.put("START_YMD", dates.get(0));
        map.put("END_YMD", dates.get(dates.size()-1));
        return map;
	}
	@RequestMapping("/computeMid")
	@ResponseBody
	public HashMap<String, Object> computeMid(HttpServletRequest request) throws ParseException{
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		
		String yoil = "";
		String day_flag = Utils.checkNullString(list.get(0).get("DAY_FLAG"));
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_pelt = "";
		String cancled_list_peri = "";
		if(list.size() > 0 && list.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_pelt = Utils.checkNullString(list.get(0).get("CANCLED_LIST")).replaceAll("-", "");
		}
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		
	    final String DATE_PATTERN = "yyyyMMdd";
        String inputStartDate = start_ymd;
        String inputEndDate = Utils.checkNullString(list.get(0).get("END_YMD"));
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date startDate = sdf.parse(inputStartDate);
        Date endDate = sdf.parse(inputEndDate);
        ArrayList<String> dates = new ArrayList<String>();
        Date currentDate = startDate;
        
        while (currentDate.compareTo(endDate) <= 0) 
        {
        	for(int j = 0; j < yoil.split(",").length; j++)
        	{
        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
    		    String convWe = "";
    		    if(we == 1) {convWe = "일";}
    		    if(we == 2) {convWe = "월";}
    		    if(we == 3) {convWe = "화";}
    		    if(we == 4) {convWe = "수";}
    		    if(we == 5) {convWe = "목";}
    		    if(we == 6) {convWe = "금";}
    		    if(we == 7) {convWe = "토";}
        		if(convWe.equals(yoil.split(",")[j]))
        		{
        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
        			if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
        			{
        				dates.add(sdf.format(currentDate));
        			}
        		}
        	}
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
        }
        
        //강의료 계산
  		int regis_fee = Utils.checkNullInt(list.get(0).get("REGIS_FEE"));
  		int food_amt = 0;
  		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
  		{
  			food_amt = Utils.checkNullInt(list.get(0).get("FOOD_AMT"));
  		}
  		int lect_cnt = Utils.checkNullInt(list.get(0).get("LECT_CNT"));
  		int mid_regis_fee = (int) Math.round((double)regis_fee / lect_cnt * dates.size());
  		mid_regis_fee = (mid_regis_fee + 900)/1000 * 1000; //일의자리 반올림하기위함 
  		
  		
  		int mid_food_amt = 0;
  		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
  		{
  			mid_food_amt = (int) Math.round((double)food_amt / lect_cnt * dates.size());
  			mid_food_amt = (mid_food_amt + 900)/1000 * 1000; //일의자리 반올림하기위함 
  		}
		
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("regis_fee", mid_regis_fee);
		map.put("food_amt", mid_food_amt);
		map.put("start_ymd", start_ymd);
        map.put("lect_cnt", dates.size());
        map.put("total_lect_cnt", Utils.checkNullString(list.get(0).get("LECT_CNT")));
        map.put("total_regis_fee", Utils.checkNullString(list.get(0).get("REGIS_FEE")));
        map.put("total_food_amt", Utils.checkNullString(list.get(0).get("FOOD_AMT")));
		return map;
	}
	@RequestMapping("/computeMid2")
	@ResponseBody
	public HashMap<String, Object> computeMid2(HttpServletRequest request) throws ParseException{
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		
		String yoil = "";
		String day_flag = Utils.checkNullString(list.get(0).get("DAY_FLAG"));
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_pelt = "";
		String cancled_list_peri = "";
		if(list.size() > 0 && list.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_pelt = Utils.checkNullString(list.get(0).get("CANCLED_LIST")).replaceAll("-", "");
		}
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		
	    final String DATE_PATTERN = "yyyyMMdd";
        String inputStartDate = Utils.checkNullString(list.get(0).get("START_YMD"));
        String inputEndDate = Utils.getCurrentDate();
        String inputLectEndDate = Utils.checkNullString(list.get(0).get("END_YMD")); //강좌종료일
        
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date startDate = sdf.parse(inputStartDate);
        Date lectEndDate = sdf.parse(inputLectEndDate);
		ArrayList<String> listenDates = new ArrayList<String>();
		ArrayList<String> lectDates = new ArrayList<String>();
		Date currentDate = startDate;
        
		while (currentDate.compareTo(lectEndDate) <= 0) 
        {
        	for(int j = 0; j < yoil.split(",").length; j++)
        	{
        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
    		    String convWe = "";
    		    if(we == 1) {convWe = "일";}
    		    if(we == 2) {convWe = "월";}
    		    if(we == 3) {convWe = "화";}
    		    if(we == 4) {convWe = "수";}
    		    if(we == 5) {convWe = "목";}
    		    if(we == 6) {convWe = "금";}
    		    if(we == 7) {convWe = "토";}
        		if(convWe.equals(yoil.split(",")[j]))
        		{
        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
        			if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
        			{
        				if(Integer.parseInt(inputEndDate) >= Integer.parseInt(sdf.format(currentDate)))
						{
							listenDates.add(sdf.format(currentDate)); //오늘날짜, 강좌시작일, 강의요일, 강좌휴강일, 기수공휴일로 계산해서 강의를 들은날을 dates에 넣음.
						}
						lectDates.add(sdf.format(currentDate)); //오늘날짜, 강좌시작일, 강의요일, 강좌휴강일, 기수공휴일로 계산해서 강의를 들은날을 dates에 넣음.
        			}
        		}
        	}
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
        }
		
		for(int j = 0; j < listenDates.size(); j++)
		{
			String tmp = listenDates.get(j);
			String y = tmp.substring(0,4);
			String m = tmp.substring(4,6);
			String d = tmp.substring(6,8);
			System.out.println("들은강좌 : "+y+"-"+m+"-"+d);
		}
		for(int j = 0; j < lectDates.size(); j++)
		{
			String tmp = lectDates.get(j);
			String y = tmp.substring(0,4);
			String m = tmp.substring(4,6);
			String d = tmp.substring(6,8);
			System.out.println("총 강좌 : "+y+"-"+m+"-"+d);
		}
		
		String is_cancel = peri_dao.getIs_cancel(store, period);
		int listenCnt = 0;
		
		if("N".equals(is_cancel))
		{
			listenCnt = listenDates.size();
		}
		else
		{
			HashMap<String, Object> lectMonthMap = new HashMap<>();
			for(int j = 0; j < lectDates.size(); j++)
			{
				String month = lectDates.get(j).substring(4,6);
				if(lectMonthMap.get(month) != null)
				{
					lectMonthMap.put(month, Utils.checkNullDouble(lectMonthMap.get(month))+1);
				}
				else
				{
					lectMonthMap.put(month, 1);
				}
			}
			
			HashMap<String, Object> listenMonthMap = new HashMap<>();
			for(int j = 0; j < listenDates.size(); j++)
			{
				String month = listenDates.get(j).substring(4,6);
				if(listenMonthMap.get(month) != null)
				{
					listenMonthMap.put(month, Utils.checkNullDouble(listenMonthMap.get(month))+1);
				}
				else
				{
					listenMonthMap.put(month, 1);
				}
			}
			
			Iterator<String> keys = lectMonthMap.keySet().iterator(); 
			while (keys.hasNext())
			{ 
				String key = keys.next();
				double lectMonthCnt = Utils.checkNullDouble(lectMonthMap.get(key)) / 2;
				double listenMonthCnt = Utils.checkNullDouble(listenMonthMap.get(key));
				if(lectMonthCnt < listenMonthCnt)
				{
					listenMonthMap.put(key, lectMonthMap.get(key));
				}
			}
			
			keys = null;
			keys = lectMonthMap.keySet().iterator();
			
			while (keys.hasNext())
			{ 
				String key = keys.next();
				double listenMonthCnt = Utils.checkNullDouble(listenMonthMap.get(key));
				listenCnt += listenMonthCnt;
			}
		}
		
		
        
        //강의료 계산
  		int regis_fee = Utils.checkNullInt(list.get(0).get("REGIS_FEE"));
  		int food_amt = 0;
  		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
  		{
  			food_amt = Utils.checkNullInt(list.get(0).get("FOOD_AMT"));
  		}
  		int lect_cnt = Utils.checkNullInt(list.get(0).get("LECT_CNT"));
  		int mid_regis_fee = (int) Math.round((double)regis_fee / lect_cnt * listenCnt);
  		mid_regis_fee = (mid_regis_fee + 900)/1000 * 1000; //일의자리 반올림하기위함 
  		
  		
  		int mid_food_amt = 0;
  		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
  		{
  			mid_food_amt = (int) Math.round((double)food_amt / lect_cnt * listenCnt);
  			mid_food_amt = (mid_food_amt + 900)/1000 * 1000; //일의자리 반올림하기위함 
  		}
		
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("regis_fee", mid_regis_fee);
		map.put("food_amt", mid_food_amt);
		map.put("start_ymd", start_ymd);
        map.put("lect_cnt", listenCnt);
        map.put("total_lect_cnt", Utils.checkNullString(list.get(0).get("LECT_CNT")));
        map.put("total_regis_fee", Utils.checkNullString(list.get(0).get("REGIS_FEE")));
        map.put("total_food_amt", Utils.checkNullString(list.get(0).get("FOOD_AMT")));
		return map;
	}
	@Transactional
	@RequestMapping("/makeMid")
	@ResponseBody
	public HashMap<String, Object> makeMid(HttpServletRequest request) throws ParseException {
		
		HashMap<String, Object> map = new HashMap<>();
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		
		//중도수강인원 계산
		int capacity_no = Utils.checkNullInt(list.get(0).get("CAPACITY_NO"));
		int regis_no = Utils.checkNullInt(list.get(0).get("REGIS_NO"));
		String mid_capacity_no = Integer.toString(capacity_no-regis_no);
		//중도수강인원 계산
		
		//남은 강좌수 계산
		String yoil = "";
		String day_flag = Utils.checkNullString(list.get(0).get("DAY_FLAG"));
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_pelt = "";
		String cancled_list_peri = "";
		if(list.size() > 0 && list.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_pelt = Utils.checkNullString(list.get(0).get("CANCLED_LIST")).replaceAll("-", "");
		}
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		
	    final String DATE_PATTERN = "yyyyMMdd";
	    String inputStartDate = start_ymd;
        String inputEndDate = Utils.checkNullString(list.get(0).get("END_YMD"));
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        Date startDate = sdf.parse(inputStartDate);
        Date endDate = sdf.parse(inputEndDate);
        ArrayList<String> dates = new ArrayList<String>();
        Date currentDate = startDate;
        
        while (currentDate.compareTo(endDate) <= 0) 
        {
        	for(int j = 0; j < yoil.split(",").length; j++)
        	{
        		int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
    		    String convWe = "";
    		    if(we == 1) {convWe = "일";}
    		    if(we == 2) {convWe = "월";}
    		    if(we == 3) {convWe = "화";}
    		    if(we == 4) {convWe = "수";}
    		    if(we == 5) {convWe = "목";}
    		    if(we == 6) {convWe = "금";}
    		    if(we == 7) {convWe = "토";}
        		if(convWe.equals(yoil.split(",")[j]))
        		{
        			//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
        			if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
        			{
        				dates.add(sdf.format(currentDate));
        			}
        		}
        	}
            Calendar c = Calendar.getInstance();
            c.setTime(currentDate);
            c.add(Calendar.DAY_OF_MONTH, 1);
            currentDate = c.getTime();
        }
        
        
        
        
        System.out.println("남은강좌수 : "+dates.size());
		
		//강의료 계산
		int regis_fee = Utils.checkNullInt(list.get(0).get("REGIS_FEE"));
		int food_amt = 0;
		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
		{
			food_amt = Utils.checkNullInt(list.get(0).get("FOOD_AMT"));
		}
		int lect_cnt = Utils.checkNullInt(list.get(0).get("LECT_CNT"));
		int mid_regis_fee = (int) Math.round((double)regis_fee / lect_cnt * dates.size());
		mid_regis_fee = (mid_regis_fee + 900)/1000 * 1000; //일의자리 반올림하기위함 
		
		
		int mid_food_amt = 0;
		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
		{
			mid_food_amt = (int) Math.round((double)food_amt / lect_cnt * dates.size());
			mid_food_amt = (mid_food_amt + 900)/1000 * 1000; //일의자리 반올림하기위함 
		}
		
		
		
		
	    
		String main_cd = Utils.checkNullString(list.get(0).get("MAIN_CD"));
		String sect_cd = Utils.checkNullString(list.get(0).get("SECT_CD"));
//		List<HashMap<String, Object>> code_list = lect_dao.getlectcode(main_cd, sect_cd); 
		String mid_subject_cd = "";
		String mid_lect_cd = lect_dao.getlectcode();
		if(mid_lect_cd.length() == 1)
		{
			mid_lect_cd = "000"+mid_lect_cd;
		}
		else if(mid_lect_cd.length() == 2)
		{
			mid_lect_cd = "00"+mid_lect_cd;
		}
		else if(mid_lect_cd.length() == 3)
		{
			mid_lect_cd = "0"+mid_lect_cd;
		}
		mid_subject_cd = mid_lect_cd;
	    
		String lect_hour = "";
		if(list.get(0).get("LECT_HOUR") != null) {lect_hour = Utils.checkNullString(list.get(0).get("LECT_HOUR"));}
		String web_cancle_ymd = "";
		if(list.get(0).get("WEB_CANCEL_YMD") != null) {web_cancle_ymd = Utils.checkNullString(list.get(0).get("WEB_CANCEL_YMD"));}
		String classroom = "";
		if(list.get(0).get("CLASSROOM") != null) {classroom = Utils.checkNullString(list.get(0).get("CLASSROOM"));}
		String lecturer_cd = "";
		if(list.get(0).get("LECTURER_CD") != null) {lecturer_cd = Utils.checkNullString(list.get(0).get("LECTURER_CD"));}
		String lecturer_cd1 = "";
		if(list.get(0).get("LECTURER_CD1") != null) {lecturer_cd = Utils.checkNullString(list.get(0).get("LECTURER_CD1"));}
		String start_ymd_prev = "";
		if(list.get(0).get("START_YMD") != null) {start_ymd_prev = Utils.checkNullString(list.get(0).get("START_YMD"));}
		String end_ymd = "";
		if(list.get(0).get("END_YMD") != null) {end_ymd = Utils.checkNullString(list.get(0).get("END_YMD"));}
		String subject_fg = "";
		if(list.get(0).get("SUBJECT_FG") != null) {subject_fg = Utils.checkNullString(list.get(0).get("SUBJECT_FG"));}
		String fix_pay_yn = "";
		if(list.get(0).get("FIX_PAY_YN") != null) {fix_pay_yn = Utils.checkNullString(list.get(0).get("FIX_PAY_YN"));}
		String fix_amt = "";
		if(list.get(0).get("FIX_AMT") != null) {fix_amt = Utils.checkNullString(list.get(0).get("FIX_AMT"));}
		String fix_rate = "";
		if(list.get(0).get("FIX_RATE") != null) {fix_rate = Utils.checkNullString(list.get(0).get("FIX_RATE"));}
		String pay_day = "";
		if(list.get(0).get("PAY_DAY") != null) {pay_day = Utils.checkNullString(list.get(0).get("PAY_DAY"));}
		String food_yn = "";
		if(list.get(0).get("FOOD_YN") != null) {food_yn = Utils.checkNullString(list.get(0).get("FOOD_YN"));}
		String web_lecturer_nm = "";
		if(list.get(0).get("WEB_LECTURER_NM") != null) {web_lecturer_nm = Utils.checkNullString(list.get(0).get("WEB_LECTURER_NM"));}
		String web_lecturer_nm1 = "";
		if(list.get(0).get("WEB_LECTURER_NM1") != null) {web_lecturer_nm1 = Utils.checkNullString(list.get(0).get("WEB_LECTURER_NM1"));}
		String month_no = "";
		if(list.get(0).get("MONTH_NO") != null) {month_no = Utils.checkNullString(list.get(0).get("MONTH_NO"));}
		String month_no1 = "";
		if(list.get(0).get("MONTH_NO1") != null) {month_no1 = Utils.checkNullString(list.get(0).get("MONTH_NO1"));}
		String subject_nm = "";
		if(list.get(0).get("SUBJECT_NM") != null) {subject_nm = "(중도)"+Utils.checkNullString(list.get(0).get("SUBJECT_NM"));}
		String cancled_list = "";
		if(list.get(0).get("CANCLED_LIST") != null) {cancled_list = Utils.checkNullString(list.get(0).get("CANCLED_LIST"));}
		String cus_no = "";
		if(list.get(0).get("CUS_NO") != null) {cus_no = Utils.checkNullString(list.get(0).get("CUS_NO"));}
		String cus_no1 = "";
		if(list.get(0).get("CUS_NO1") != null) {cus_no1 = Utils.checkNullString(list.get(0).get("CUS_NO1"));}
		String corp_fg = "";
		if(list.get(0).get("CORP_FG") != null) {corp_fg = Utils.checkNullString(list.get(0).get("CORP_FG"));}
		String is_two = "";
		if(list.get(0).get("IS_TWO") != null) {is_two = Utils.checkNullString(list.get(0).get("IS_TWO"));}
		String regis_fee_cnt = "";
		if(list.get(0).get("REGIS_FEE_CNT") != null) {regis_fee_cnt = Utils.checkNullString(list.get(0).get("REGIS_FEE_CNT"));}
		String food_amt_cnt = "";
		if(list.get(0).get("FOOD_AMT_CNT") != null) {food_amt_cnt = Utils.checkNullString(list.get(0).get("FOOD_AMT_CNT"));}
		String lectmgmt_no = "";
		if(list.get(0).get("LECTMGMT_NO") != null) {lectmgmt_no = Utils.checkNullString(list.get(0).get("LECTMGMT_NO"));}
		String thumbnail_img = "";
		if(list.get(0).get("THUMBNAIL_IMG") != null) {thumbnail_img = Utils.checkNullString(list.get(0).get("THUMBNAIL_IMG"));}
		String detail_img = "";
		if(list.get(0).get("DETAIL_IMG") != null) {detail_img = Utils.checkNullString(list.get(0).get("DETAIL_IMG"));}
		String end_yn = "";
		if(list.get(0).get("END_YN") != null) {end_yn = Utils.checkNullString(list.get(0).get("END_YN"));}
		if("O".equals(end_yn)) //개강 상태인경우는 초기화해서 가져온다.
		{
			end_yn = "";
		}
		
		if(Integer.parseInt(start_ymd.replaceAll("-", "")) > Integer.parseInt(end_ymd.replaceAll("-", "")) || Integer.parseInt(start_ymd.replaceAll("-", "")) < Integer.parseInt(start_ymd_prev.replaceAll("-", "")))
		{
			map.put("isSuc", "fail");
			map.put("msg", "시작일을 확인해주세요.");
			return map;
		}
		
		
	    
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
//		lect_dao.insLect(store, period, mid_subject_cd, subject_nm, main_cd, sect_cd, mid_lect_cd, login_seq);
		lect_dao.insPelt(store, period, mid_subject_cd, main_cd, sect_cd,
				day_flag, lect_hour, web_cancle_ymd, Integer.toString(dates.size()), classroom, lecturer_cd, lecturer_cd1,
				start_ymd, end_ymd, mid_capacity_no, subject_fg, Integer.toString(mid_regis_fee),
				fix_pay_yn, fix_amt, fix_rate, pay_day, food_yn, Integer.toString(mid_food_amt),
				web_lecturer_nm, web_lecturer_nm1, month_no, month_no1, subject_nm,
				cancled_list, login_seq, cus_no, cus_no1, corp_fg, is_two, regis_fee_cnt, food_amt_cnt,"Y",lectmgmt_no, thumbnail_img, detail_img, end_yn); 			
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "중도수강코드 생성", store+"/"+period+"/"+mid_subject_cd);
		 for (String dd : dates) 
	        {
	        	
	        }
		
		String dayChk="";
		System.out.println("lect_cnt : "+lect_cnt);
		System.out.println("dates : "+dates.size());
        for (int j = 0; j < dates.size(); j++) {
        	dayChk += Utils.checkNullString(dates.get(j))+"|";
        	System.out.println("test12213강의날짜 : "+dates.get(j));
		}
	        
        
        //중도 수강 출석부 생성
        
		lect_dao.insAttend(store, period, mid_subject_cd, login_seq,"Y","000000000 ",dayChk,"0");
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
		
	}
	@RequestMapping("/getPrevPeri_ready")
	@ResponseBody
	public int getPrevPeri_ready(HttpServletRequest request) throws ParseException {
		
		String store = Utils.checkNullString(request.getParameter("store")); //지점
	      String period = Utils.checkNullString(request.getParameter("period")); //현재 기수 
	      
	      List<HashMap<String, Object>> peri_list = lect_dao.getPrevPeri(store); //전 기수가 몇기인지 가져옵니다.
	      
	      String prev_period = "";
	     int size = peri_list.size();
	      for(int i = 0; i < size; i++)
	      {
	         if(period.equals(Utils.checkNullString(peri_list.get(i).get("PERIOD"))))
	         {
	            if((i+1) < (size))
	            {
	               prev_period = Utils.checkNullString(peri_list.get(i+1).get("PERIOD")); //전 기수 셋팅
	            }
	         }
	      }
	      
	      return lect_dao.getReadyPelt(store, period, prev_period); //전기의 개설강좌를 불러옵니다.
	}
	@RequestMapping("/getPrevPeri")
	@ResponseBody
	public HashMap<String, Object> getPrevPeri(HttpServletRequest request) throws ParseException {
		
		String store = Utils.checkNullString(request.getParameter("store")); //지점
	      String period = Utils.checkNullString(request.getParameter("period")); //현재 기수 
	      
	      List<HashMap<String, Object>> peri_list = lect_dao.getPrevPeri(store); //전 기수가 몇기인지 가져옵니다.
	      
	      String prev_period = "";
	     int size = peri_list.size();
	      for(int i = 0; i < size; i++)
	      {
	         if(period.equals(Utils.checkNullString(peri_list.get(i).get("PERIOD"))))
	         {
	            if((i+1) < (size))
	            {
	               prev_period = Utils.checkNullString(peri_list.get(i+1).get("PERIOD")); //전 기수 셋팅
	            }
	         }
	      }
	      
//	      lect_dao.insWlecPrev(store, period, prev_period); //전기의 강의계호기서를 불러옵니다.
	      
	      List<HashMap<String, Object>> list = lect_dao.getPrevPelt(store, prev_period); //전기의 개설강좌를 불러옵니다.
	      
	      size = list.size();
	      for(int i = 0; i < size; i++) //전기의 개설강좌 반복문
	      {
	         try
	         {
	            //여기서부터는 기존강좌의 데이터를 각각 변수에 담는 로직입니다.
	            String lect_hour = "";
	            if(list.get(i).get("LECT_HOUR") != null) {lect_hour = Utils.checkNullString(list.get(i).get("LECT_HOUR"));}
	            String web_cancle_ymd = "";
	            String classroom = "";
	            if(list.get(i).get("CLASSROOM") != null) {classroom = Utils.checkNullString(list.get(i).get("CLASSROOM"));}
	            String lecturer_cd = "";
	            if(list.get(i).get("LECTURER_CD") != null) {lecturer_cd = Utils.checkNullString(list.get(i).get("LECTURER_CD"));}
	            String lecturer_cd1 = "";
	            if(list.get(i).get("LECTURER_CD1") != null) {lecturer_cd = Utils.checkNullString(list.get(i).get("LECTURER_CD1"));}
	            String subject_fg = "";
	            if(list.get(i).get("SUBJECT_FG") != null) {subject_fg = Utils.checkNullString(list.get(i).get("SUBJECT_FG"));}
	            String fix_pay_yn = "";
	            if(list.get(i).get("FIX_PAY_YN") != null) {fix_pay_yn = Utils.checkNullString(list.get(i).get("FIX_PAY_YN"));}
	            String fix_amt = "";
	            if(list.get(i).get("FIX_AMT") != null) {fix_amt = Utils.checkNullString(list.get(i).get("FIX_AMT"));}
	            String fix_rate = "";
	            if(list.get(i).get("FIX_RATE") != null) {fix_rate = Utils.checkNullString(list.get(i).get("FIX_RATE"));}
	            String pay_day = "";
	            if(list.get(i).get("PAY_DAY") != null) {pay_day = Utils.checkNullString(list.get(i).get("PAY_DAY"));}
	            String food_yn = "";
	            if(list.get(i).get("FOOD_YN") != null) {food_yn = Utils.checkNullString(list.get(i).get("FOOD_YN"));}
	            String food_amt = "0";
	            if(list.get(i).get("FOOD_AMT") != null) {food_amt = Utils.checkNullString(list.get(i).get("FOOD_AMT"));}
	            String web_lecturer_nm = "";
	            if(list.get(i).get("WEB_LECTURER_NM") != null) {web_lecturer_nm = Utils.checkNullString(list.get(i).get("WEB_LECTURER_NM"));}
	            String web_lecturer_nm1 = "";
	            if(list.get(i).get("WEB_LECTURER_NM1") != null) {web_lecturer_nm1 = Utils.checkNullString(list.get(i).get("WEB_LECTURER_NM1"));}
	            String month_no = "";
	            if(list.get(i).get("MONTH_NO") != null) {month_no = Utils.checkNullString(list.get(i).get("MONTH_NO"));}
	            String month_no1 = "";
	            if(list.get(i).get("MONTH_NO1") != null) {month_no1 = Utils.checkNullString(list.get(i).get("MONTH_NO1"));}
	            String subject_nm = "";
	            if(list.get(i).get("SUBJECT_NM") != null) {subject_nm = Utils.checkNullString(list.get(i).get("SUBJECT_NM"));}
	            String cancled_list = "";
	            if(list.get(i).get("CANCLED_LIST") != null) {cancled_list = Utils.checkNullString(list.get(i).get("CANCLED_LIST"));}
	            String cus_no = "";
	            if(list.get(i).get("CUS_NO") != null) {cus_no = Utils.checkNullString(list.get(i).get("CUS_NO"));}
	            String cus_no1 = "";
	            if(list.get(i).get("CUS_NO1") != null) {cus_no1 = Utils.checkNullString(list.get(i).get("CUS_NO1"));}
	            String corp_fg = "";
	            if(list.get(i).get("CORP_FG") != null) {corp_fg = Utils.checkNullString(list.get(i).get("CORP_FG"));}
	            String is_two = "";
	            if(list.get(i).get("IS_TWO") != null) {is_two = Utils.checkNullString(list.get(i).get("IS_TWO"));}
	            String subject_cd = "";
	            if(list.get(i).get("SUBJECT_CD") != null) {subject_cd = Utils.checkNullString(list.get(i).get("SUBJECT_CD"));}
	            String main_cd = "";
	            if(list.get(i).get("MAIN_CD") != null) {main_cd = Utils.checkNullString(list.get(i).get("MAIN_CD"));}
	            String sect_cd = "";
	            if(list.get(i).get("SECT_CD") != null) {sect_cd = Utils.checkNullString(list.get(i).get("SECT_CD"));}
	            String day_flag = "";
	            if(list.get(i).get("DAY_FLAG") != null) {day_flag = Utils.checkNullString(list.get(i).get("DAY_FLAG"));}
	            String capacity_no = "";
	            if(list.get(i).get("CAPACITY_NO") != null) {capacity_no = Utils.checkNullString(list.get(i).get("CAPACITY_NO"));}
	            String regis_fee = "";
	            if(list.get(i).get("REGIS_FEE") != null) {regis_fee = Utils.checkNullString(list.get(i).get("REGIS_FEE"));}
	            String lect_cnt = "";
	            if(list.get(i).get("LECT_CNT") != null) {lect_cnt = Utils.checkNullString(list.get(i).get("LECT_CNT"));}
	            String regis_fee_cnt = "";
	            if(list.get(i).get("REGIS_FEE_CNT") != null) {regis_fee_cnt = Utils.checkNullString(list.get(i).get("REGIS_FEE_CNT"));}
	            String food_amt_cnt = "";
	            if(list.get(i).get("FOOD_AMT_CNT") != null) {food_amt_cnt = Utils.checkNullString(list.get(i).get("FOOD_AMT_CNT"));}
	            String lectmgmt_no = "";
	            if(list.get(i).get("LECTMGMT_NO") != null) {lectmgmt_no = Utils.checkNullString(list.get(i).get("LECTMGMT_NO"));}
	            String thumbnail_img = "";
	            if(list.get(i).get("THUMBNAIL_IMG") != null) {thumbnail_img = Utils.checkNullString(list.get(i).get("THUMBNAIL_IMG"));}
	            String detail_img = "";
	            if(list.get(i).get("DETAIL_IMG") != null) {detail_img = Utils.checkNullString(list.get(i).get("DETAIL_IMG"));}
	            String end_yn = "";
	            if(list.get(i).get("END_YN") != null) {end_yn = Utils.checkNullString(list.get(i).get("END_YN"));}
	            if("O".equals(end_yn)) //개강 상태인경우는 초기화해서 가져옵니다.
	            {
	               end_yn = "";
	            }
	            //기존강좌의 데이터를 각각 변수에 담는 로직 종료.
	            
	            

	            //기존 데이터 셋팅
	            HashMap<String, Object> data = peri_dao.getPeriOne(period, store); //현재 기수의 정보를 가져옵니다.
	            List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period); //현재기수의 공휴일을 체크합니다.
	            String cancled_list_peri = "";
	            if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
	            {
	               cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST")); //공휴일 정보 셋팅
	            }
	            
	            //날짜계산 시작
	            String yoil = "";
	            if(day_flag.split("")[0].equals("1")){yoil += ",월";}
	            if(day_flag.split("")[1].equals("1")){yoil += ",화";}
	            if(day_flag.split("")[2].equals("1")){yoil += ",수";}
	            if(day_flag.split("")[3].equals("1")){yoil += ",목";}
	            if(day_flag.split("")[4].equals("1")){yoil += ",금";}
	            if(day_flag.split("")[5].equals("1")){yoil += ",토";}
	            if(day_flag.split("")[6].equals("1")){yoil += ",일";}
	            yoil = yoil.substring(1, yoil.length());
	            
	            final String DATE_PATTERN = "yyyyMMdd";
	            String inputStartDate = Utils.checkNullString(data.get("START_YMD"));
	              SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
	              Date startDate = sdf.parse(inputStartDate);
	              ArrayList<String> dates = new ArrayList<String>();
	              Date currentDate = startDate;
	              int z = 0;
	              while(true)
	              {
	                 for(int j = 0; j < yoil.split(",").length; j++)
	                 {
	                    int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
	                    String convWe = "";
	                    if(we == 1) {convWe = "일";}
	                    if(we == 2) {convWe = "월";}
	                    if(we == 3) {convWe = "화";}
	                    if(we == 4) {convWe = "수";}
	                    if(we == 5) {convWe = "목";}
	                    if(we == 6) {convWe = "금";}
	                    if(we == 7) {convWe = "토";}
	                    if(convWe.equals(yoil.split(",")[j]))
	                    {
	                       //기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
	                       if(cancled_list.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
	                       {
	                          dates.add(sdf.format(currentDate));
	                          z++;
	                       }
	                    }
	                 }
	                  Calendar c = Calendar.getInstance();
	                  c.setTime(currentDate);
	                  c.add(Calendar.DAY_OF_MONTH, 1);
	                  currentDate = c.getTime();
	                  if(z == Integer.parseInt(lect_cnt))
	               {
	                  break;
	               }
	              }
	              //날짜계산 끝
	              
	              
	              
	              
	              
	              String start_ymd = dates.get(0); //기수의 시작일
	              String end_ymd = dates.get(dates.size()-1); //기수의 종료일
	             
	             
	             SimpleDateFormat  formatter = new SimpleDateFormat("yyyyMMdd");    
	             Date setDate = formatter.parse(start_ymd);
	             Calendar cal = Calendar.getInstance();
	             cal.setTime(setDate);
	             cal.add(Calendar.DATE, -1);
	             web_cancle_ymd = formatter.format(cal.getTime());
	             
	            
	            HttpSession session = request.getSession();
	            String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	            
	            //셋팅된 정보 insert
	            lect_dao.insPelt(store, period, subject_cd, main_cd, sect_cd,
	                  day_flag, lect_hour, web_cancle_ymd, lect_cnt, classroom, lecturer_cd, lecturer_cd1,
	                  start_ymd, end_ymd, capacity_no, subject_fg, regis_fee,
	                  fix_pay_yn, fix_amt, fix_rate, pay_day, food_yn, food_amt,
	                  web_lecturer_nm, web_lecturer_nm1, month_no, month_no1, subject_nm,
	                  cancled_list, login_seq, cus_no, cus_no1, corp_fg, is_two, regis_fee_cnt, food_amt_cnt,"Y", lectmgmt_no, thumbnail_img, detail_img, end_yn);    
	            
	            
	            //출석부 생성
	            for (String dd : dates) 
	              {
	                 System.out.println("강의날짜 : "+dd);
	              }
	             String dayChk="";
	               for (int j = 0; j < Integer.parseInt(lect_cnt); j++) {
	                 dayChk += Utils.checkNullString(dates.get(j))+"|";
	            }
	               System.out.println("dayChk : "+dayChk);
	              //이전 기수 강좌 출석부 생성
	             lect_dao.insAttend(store, period, subject_cd, login_seq,"Y","000000000 ",dayChk,"0");
	           //출석부 생성
	            
	         }
	         catch(Exception e)
	         {
	            e.printStackTrace();
	         }
	         
	            
	      }
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "전기 개설강좌 불러오기", store+"/"+period);
		return map;
	}
	@RequestMapping("/getLectPay")
	@ResponseBody
	public HashMap<String, Object> getLectPay(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "");
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String isPerformance = Utils.checkNullString(request.getParameter("isPerformance"));
		
		System.out.println("store : "+store);
		System.out.println("period : "+period);
		System.out.println("start_ymd : "+start_ymd);
		System.out.println("end_ymd : "+end_ymd);
		System.out.println("subject_fg : "+subject_fg);
		System.out.println("isPerformance : "+isPerformance);
	
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		List<HashMap<String, Object>> listCnt = lecr_dao.getLectPayCount(store, period, start_ymd, end_ymd, subject_fg, isPerformance);
		List<HashMap<String, Object>> listCnt_all = lecr_dao.getLectPayCount(store, period, "", "", "", "");
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
		
		List<HashMap<String, Object>> list = lecr_dao.getLectPay(s_point, listSize*page, order_by, sort_type, store, period, start_ymd, end_ymd, subject_fg, isPerformance); 
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강좌별 매출 상세 현황 조회", store+"/"+period);

		return map;
	}
	@RequestMapping("/getWeekCnt")
	@ResponseBody
	public HashMap<String, Object> getWeekCnt(HttpServletRequest request) throws ParseException {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = common_dao.retrievePeriod(store);
		HashMap<String, Object> data = lect_dao.getScheduleByPeri(store, period);
		String start_ymd = Utils.checkNullString(data.get("START_YMD"));
		String end_ymd = Utils.checkNullString(data.get("END_YMD"));
		
		long days = Utils.calDateBetweenAandB(start_ymd, end_ymd); //날짜 차이 계산
		long weekCnt = (long) Math.ceil(days/7.0); //주 몇회인지 계산
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("weekCnt", weekCnt);
		
		return map;
	}
	@RequestMapping("/getPeltBySchedule")
	@ResponseBody
	public List<HashMap<String, Object>> getPeltBySchedule(HttpServletRequest request) throws ParseException {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = common_dao.retrievePeriod(store);
		String seq = Utils.checkNullString(request.getParameter("seq")); 
		int weekCnt = Utils.checkNullInt(request.getParameter("weekCnt"));
		HashMap<String, Object> data = lect_dao.getScheduleByPeri(store, period);
		String start_ymd = Utils.checkNullString(data.get("START_YMD"));
		String flagDay = Utils.addDate(start_ymd, (weekCnt-1)*7);
		String flagMon = Utils.getMonFlag(flagDay);
		String flagSun = Utils.getSunFlag(flagDay);
		System.out.println("기수 시작일 : "+start_ymd);
		System.out.println("주차 : "+weekCnt);
		System.out.println("주차를 더한거 : "+flagDay);
		System.out.println("해당주차 월요일 : "+flagMon);
		System.out.println("해당주차 일요일 : "+flagSun);
		System.out.println("사이값 : "+Utils.getWeekDays(flagMon, flagSun));
		
		
		List<HashMap<String, Object>> list = lect_dao.getPeltBySchedule(store, period, seq);
		
		
		String weekDays[] = Utils.getWeekDays(flagMon, flagSun).split("\\|");
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		
		for(int i = 0; i < list.size(); i++)
		{
			for(int z = 0; z < weekDays.length; z++)
			{
				String cancled_list = (list.get(i).get("CANCLED_LIST") != null) ? Utils.checkNullString(list.get(i).get("CANCLED_LIST")).replaceAll("-", "") : "";
				String peri_cancled_list = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
				System.out.println("윅 : "+weekDays[z]);
				System.out.println("캔슬드 : "+cancled_list);
				System.out.println("페리캔슬드 : "+peri_cancled_list);
				String col = "";
				if(z == 0) {col = "IS_MON";} else if(z == 0) {col = "IS_TUE";} else if(z == 0) {col = "IS_WED";} else if(z == 0) {col = "IS_THU";}
				else if(z == 0) {col = "IS_FRI";} else if(z == 0) {col = "IS_SAT";} else if(z == 0) {col = "IS_SUN";}
				if(cancled_list.indexOf(weekDays[z]) > -1 || peri_cancled_list.indexOf(weekDays[z]) > -1)
				{
					list.get(i).put(col, "N");
				}
			}
		}
		for(int i = 0; i < list.size(); i++)
		{
			System.out.println(list.get(i).get("IS_MON") + " " + list.get(i).get("IS_TUE") + " " + list.get(i).get("IS_WED") + " " + list.get(i).get("IS_THU") + " " + list.get(i).get("IS_FRI") + " " + list.get(i).get("IS_SAT") + " " + list.get(i).get("IS_SUN"));
		}
		
		return list;
	}
	@RequestMapping(value = "/getStoreNm", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getStoreNm(HttpServletRequest request) throws ParseException {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String store_nm = common_dao.getStoreName(store);
		System.out.println("store_nm : "+store_nm);
		return store_nm;
	}
	
	
	
	@RequestMapping("/uptAttendDay")
	@ResponseBody
	public HashMap<String, Object> uptAttendDay(HttpServletRequest request) throws ParseException {
		

		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));

		HashMap<String, Object> data = lect_dao.getPrevInfo(store, period, subject_cd); 
		
		String day_flag = "";
		if(data.get("DAY_FLAG") != null) {day_flag = Utils.checkNullString(data.get("DAY_FLAG"));}
		String cancled_list = "";
		if(data.get("CANCLED_LIST") != null) {cancled_list = Utils.checkNullString(data.get("CANCLED_LIST")).replaceAll("-","");}
		String lect_cnt = "";
		if(data.get("LECT_CNT") != null) {lect_cnt = Utils.checkNullString(data.get("LECT_CNT"));}
		
		List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
		String cancled_list_peri = "";
		
		if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
		{
			cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
		}
		String yoil = "";
		if(day_flag.split("")[0].equals("1")){yoil += ",월";}
		if(day_flag.split("")[1].equals("1")){yoil += ",화";}
		if(day_flag.split("")[2].equals("1")){yoil += ",수";}
		if(day_flag.split("")[3].equals("1")){yoil += ",목";}
		if(day_flag.split("")[4].equals("1")){yoil += ",금";}
		if(day_flag.split("")[5].equals("1")){yoil += ",토";}
		if(day_flag.split("")[6].equals("1")){yoil += ",일";}
		yoil = yoil.substring(1, yoil.length());
		final String DATE_PATTERN = "yyyyMMdd";
			String inputStartDate = Utils.checkNullString(data.get("START_YMD"));
			//String inputStartDate = Utils.checkNullString(data.get("START_YMD"));
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
			Date startDate = sdf.parse(inputStartDate);
			ArrayList<String> dates = new ArrayList<String>();
			Date currentDate = startDate;
		
		int z = 0;
		while(true)
		{
			for(int k = 0; k < yoil.split(",").length; k++)
			{
				int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
				String convWe = "";
				if(we == 1) {convWe = "일";}
				if(we == 2) {convWe = "월";}
				if(we == 3) {convWe = "화";}
				if(we == 4) {convWe = "수";}
				if(we == 5) {convWe = "목";}
				if(we == 6) {convWe = "금";}
				if(we == 7) {convWe = "토";}
				if(convWe.equals(yoil.split(",")[k]))
				{
					//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
					if(cancled_list.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
					{
						dates.add(sdf.format(currentDate));
						z++;
					}
				}
			}
			if (lect_cnt.equals("0")) {
				break;
			}
			
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
			if(z == Integer.parseInt(lect_cnt))
			{
				break;
			}
		}
		String start_ymd = dates.get(0);
		String end_ymd = dates.get(dates.size()-1);
		
		for (String dd : dates) 
		{
			System.out.println("강의날짜 : "+dd);
		}
		String dayChk="";
		String dayChk_X ="";
		int dayChkCnt=0;
		for (int l = 0; l < Integer.parseInt(lect_cnt); l++) {
			dayChk += Utils.checkNullString(dates.get(l))+"|";
			//dayChk += "X|";
			dayChk_X +="X|";
					
			dayChkCnt++;
		}
		System.out.println("result : "+dayChk);
		//lect_dao.insAttend(store, period, subject_cd, login_seq,"Y","000000000 ",dayChk,"0");
		lect_dao.uptAttendDayChk(store, period, subject_cd, dayChk);
		
		List<HashMap<String, Object>> getAttendCustList = lect_dao.getAttendCustList(store, period, subject_cd);
		if (getAttendCustList.size() > 0) 
		{
			int new_day_cnt = dayChk_X.split("\\|").length; 
			int prev_day_cnt = getAttendCustList.get(0).get("DAY_CHK").toString().split("\\|").length;
			System.out.println("new_day_cnt : "+new_day_cnt);
			System.out.println("prev_day_cnt : "+prev_day_cnt);
			
			if (new_day_cnt!=prev_day_cnt) 
			{
				lect_dao.uptAttendDayChk_X(store, period, subject_cd, dayChk_X);				
			}
			
			/*
			int len = getAttendCustList.get(0).get("DAY_CHK").toString().split("\\|").length;
			System.out.println("len : "+len);
			System.out.println("dayChkCnt : "+dayChkCnt);
			
			String dayVal="";
			
			
			if (dayChkCnt > len) 
			{
				for (int i = 0; i < (dayChkCnt-len); i++) {
					dayVal +="X|";
				}
				
			}
			else if(dayChkCnt < len)
			{
				String custval="";
				for (int i = 0; i < getAttendCustList.size(); i++) {
					custval=getAttendCustList.get(i).get("DAY_CHK").toString();
					
					
					
				}				
			}
			*/
		}
		HashMap<String, Object> map = new HashMap<>();
		

		
		return map;
	}
}