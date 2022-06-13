package ak_culture.controller.member;


import java.net.UnknownHostException;
import java.util.Enumeration;
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
import ak_culture.model.basic.UserDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.lecture.LecrDAO;
import ak_culture.model.member.CustDAO;
import ak_culture.model.member.LectDAO;

@Controller
@RequestMapping("/member/cust/*")

public class CustController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private PeriDAO peri_dao;

	@Autowired
	private CustDAO cust_dao;

	@Autowired
	private LecrDAO lecr_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private LectDAO lect_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/member/cust/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		List<HashMap<String, Object>> si_list = cust_dao.getAddr_si();

		mav.addObject("si_list", si_list);
		return mav;
	}
	
	@RequestMapping("/getAddr")
	@ResponseBody
	public HashMap<String, Object> getAddr(HttpServletRequest request) {
		
		
		String start = Utils.checkNullString(request.getParameter("start"));
		String end = Utils.checkNullString(request.getParameter("end"));
		String addr = Utils.checkNullString(request.getParameter("addr"));
		
	
		List<HashMap<String, Object>> list = cust_dao.getAddr(start,end,addr);  
			
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
	    return map;
	}
	
	
	@RequestMapping("/getCustList")
	@ResponseBody
	public HashMap<String, Object> getCustList(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HashMap<String, Object> param = new HashMap<>();
		Enumeration params = request.getParameterNames();
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		    param.put(name, Utils.checkNullString(request.getParameter(name)));
		}
		
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String start_peri = "";
		String end_peri = "";
		
		System.out.println("selYear2 : "+param.get("selYear2"));
		System.out.println("selSeason2 : "+param.get("selSeason2"));
		map.put("isSuc", "success");
		
		if(!"".equals(Utils.checkNullString(param.get("selBranch"))))
		{
			branchList = common_dao.getPeriList(Utils.checkNullString(param.get("selBranch")), Utils.checkNullString(param.get("selYear1")), Utils.checkNullString(param.get("selSeason1")));
			if(branchList.size() > 0)
			{
				start_peri = Utils.checkNullString(branchList.get(branchList.size()-1).get("PERIOD"));
			}
			
			branchList = common_dao.getPeriList(Utils.checkNullString(param.get("selBranch")), Utils.checkNullString(param.get("selYear2")), Utils.checkNullString(param.get("selSeason2")));
			if(branchList.size() > 0)
			{
				end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
			
		}
		
		if (start_peri.equals("")) {
			map.put("isSuc", "fail");
			map.put("msg", "검색한 시작 기수 값이 없습니다.");
			return map;
		}
		
		
		if (end_peri.equals("")) {
			map.put("isSuc", "fail");
			map.put("msg", "검색한 종료 기수 값이 없습니다.");
			return map;
		}
		
		
		System.out.println("start_peri : "+start_peri);
		System.out.println("end_peri : "+end_peri);
		param.put("start_peri", start_peri); 
		param.put("end_peri", end_peri);
		
		
		String lect_time_a =Utils.checkNullString(param.get("lect_time_a"));
		String lect_time_b =Utils.checkNullString(param.get("lect_time_b"));
		String lect_time_c =Utils.checkNullString(param.get("lect_time_c"));
		String lect_time_d =Utils.checkNullString(param.get("lect_time_d"));
		String lect_time_e =Utils.checkNullString(param.get("lect_time_e"));
		String lect_time_f =Utils.checkNullString(param.get("lect_time_f"));
		
		String cust_fg =Utils.checkNullString(param.get("cust_fg"));
		String last_amt_start =Utils.checkNullString(param.get("last_amt_start"));
		String last_amt_end =Utils.checkNullString(param.get("lect_time_f"));
		
		String main_cd =Utils.checkNullString(param.get("main_cd"));
		String sect_cd =Utils.checkNullString(param.get("sect_cd"));
		String subject_cd =Utils.checkNullString(param.get("subject_cd"));
		String dupl_cus_no =Utils.checkNullString(param.get("dupl_cus_no"));
		 
		
		param.put("lect_time_a",lect_time_a);
		param.put("lect_time_b",lect_time_b);
		param.put("lect_time_c",lect_time_c);
		param.put("lect_time_d",lect_time_d);
		param.put("lect_time_e",lect_time_e);
		param.put("lect_time_f",lect_time_f);
		
		param.put("cust_fg",cust_fg);
		param.put("last_amt_start",last_amt_start);
		param.put("last_amt_end",last_amt_end);
		
		param.put("main_cd",main_cd);
		param.put("sect_cd",sect_cd);
		param.put("subject_cd",subject_cd);
		param.put("dupl_cus_no",dupl_cus_no);
		
		/*
		if (1==1) {			
			System.out.println("test");
			HashMap<String, Object> test = new HashMap<>();
			return test;
		}
		*/
		String si2="";
		String si = Utils.checkNullString(param.get("si"));
		
		
		if (si.equals("세종특별자치시")) {
			si2 = "세종";
		}else if(si.equals("충청남도")) {
			si2 = "충남";
		}else if(si.equals("서울특별시")) {
			si2 = "서울";
		}else if(si.equals("대구광역시")) {
			si2 = "대구";
		}else if(si.equals("인천광역시")) {
			si2 = "인천";
		}else if(si.equals("충청북도")) {
			si2 = "충북";
		}else if(si.equals("경상북도")) {
			si2 = "경북";
		}else if(si.equals("강원도")) {
			si2 = "강원";
		}else if(si.equals("전라남도")) {
			si2 = "전남";
		}else if(si.equals("대전광역시")) {
			si2 = "대전";
		}else if(si.equals("전라북도")) {
			si2 = "전북";
		}else if(si.equals("경기도")) {
			si2 = "경기";
		}else if(si.equals("경상남도")) {
			si2 = "경남";
		}else if(si.equals("부산광역시")) {
			si2 = "부산";
		}else if(si.equals("광주광역시")) {
			si2 = "광주";
		}else if(si.equals("울산광역시")) {
			si2 = "울산";
		}else if(si.equals("제주특별자치도")) {
			si2 = "제주";
		}
		param.put("si2",Utils.checkNullString(si2));

		List<HashMap<String, Object>> list = cust_dao.getCustList(param); 
		
		
		//map.put("listCnt", listCnt.get(0).get("CNT"));
		//map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("list", list);
		//map.put("pageNum", pageNum);
		map.put("order_by", param.get("order_by"));
		map.put("sort_type", param.get("sort_type"));
		
	    return map;
	}
	
	
	
	@RequestMapping("/getTmCustList")
	@ResponseBody
	public HashMap<String, Object> getTmCustList(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String dupl_cus_no = Utils.checkNullString(request.getParameter("dupl_cus_no"));
		
		
		
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String period = "";
		map.put("isSuc", "success");
		if(!"".equals(store))
		{
			branchList = common_dao.getPeriList(store, selYear1, selSeason1);
			if(branchList.size() > 0)
			{
				period = Utils.checkNullString(branchList.get(branchList.size()-1).get("PERIOD"));
			}

		}
		
		if (period.equals("")) {
			map.put("isSuc", "fail");
			map.put("msg", "검색한 시작 기수 값이 없습니다.");
			return map;
		}
		System.out.println("store :"+store);
		System.out.println("selYear1 :"+selYear1);
		System.out.println("selSeason1 :"+selSeason1);
		System.out.println("period :"+period);
		System.out.println("main_cd :"+main_cd);
		System.out.println("sect_cd :"+sect_cd);
		System.out.println("subject_cd :"+subject_cd);
		System.out.println("dupl_cus_no :"+dupl_cus_no);
		

		List<HashMap<String, Object>> list = cust_dao.getCustList03(store,period,main_cd,sect_cd,subject_cd,dupl_cus_no); 
		

		map.put("list", list);

		//map.put("pageNum", pageNum);
		
		
	    return map;
	}
	
	
	
	@RequestMapping("/getCustList02")
	@ResponseBody
	public HashMap<String, Object> getCustList02(HttpServletRequest request) {
		
		HashMap<String, Object> param = new HashMap<>();
		HashMap<String, Object> forTotal = new HashMap<>(); //전체 cnt를 가져오기 위한 빈값 store랑 period만 들어감
		Enumeration params = request.getParameterNames();
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +request.getParameter(name));
		    param.put(name, Utils.checkNullString(request.getParameter(name)));
		    forTotal.put(name, "");
		}
		
		String lect_time_a =Utils.checkNullString(param.get("lect_time_a"));
		String lect_time_b =Utils.checkNullString(param.get("lect_time_b"));
		String lect_time_c =Utils.checkNullString(param.get("lect_time_c"));
		String lect_time_d =Utils.checkNullString(param.get("lect_time_d"));
		String lect_time_e =Utils.checkNullString(param.get("lect_time_e"));
		String lect_time_f =Utils.checkNullString(param.get("lect_time_f"));
		
		String cust_fg =Utils.checkNullString(param.get("cust_fg"));
		String last_amt_start =Utils.checkNullString(param.get("last_amt_start"));
		String last_amt_end =Utils.checkNullString(param.get("lect_time_f"));
		
		String main_cd =Utils.checkNullString(param.get("main_cd"));
		String sect_cd =Utils.checkNullString(param.get("sect_cd"));
		String subject_cd =Utils.checkNullString(param.get("subject_cd"));
		String dupl_cus_no =Utils.checkNullString(param.get("dupl_cus_no"));
		 
		
		param.put("lect_time_a",lect_time_a); 			forTotal.put("lect_time_a","");
		param.put("lect_time_b",lect_time_b);			forTotal.put("lect_time_b","");
		param.put("lect_time_c",lect_time_c); 			forTotal.put("lect_time_c","");
		param.put("lect_time_d",lect_time_d); 			forTotal.put("lect_time_d","");
		param.put("lect_time_e",lect_time_e); 			forTotal.put("lect_time_e","");
		param.put("lect_time_f",lect_time_f); 			forTotal.put("lect_time_f","");
		
		param.put("cust_fg",cust_fg);					forTotal.put("cust_fg","");
		param.put("last_amt_start",last_amt_start);		forTotal.put("last_amt_start","");
		param.put("last_amt_end",last_amt_end);			forTotal.put("last_amt_end","");
		
		param.put("main_cd",main_cd);					forTotal.put("main_cd","");
		param.put("sect_cd",sect_cd);					forTotal.put("sect_cd","");
		param.put("subject_cd",subject_cd);				forTotal.put("subject_cd","");
		param.put("dupl_cus_no",dupl_cus_no);			forTotal.put("dupl_cus_no","");
														forTotal.put("yoil","0000000");
		
		
		String si2="";
		String si = Utils.checkNullString(param.get("si"));
		
		
		if (si.equals("세종특별자치시")) {
			si2 = "세종";
		}else if(si.equals("충청남도")) {
			si2 = "충남";
		}else if(si.equals("서울특별시")) {
			si2 = "서울";
		}else if(si.equals("대구광역시")) {
			si2 = "대구";
		}else if(si.equals("인천광역시")) {
			si2 = "인천";
		}else if(si.equals("충청북도")) {
			si2 = "충북";
		}else if(si.equals("경상북도")) {
			si2 = "경북";
		}else if(si.equals("강원도")) {
			si2 = "강원";
		}else if(si.equals("전라남도")) {
			si2 = "전남";
		}else if(si.equals("대전광역시")) {
			si2 = "대전";
		}else if(si.equals("전라북도")) {
			si2 = "전북";
		}else if(si.equals("경기도")) {
			si2 = "경기";
		}else if(si.equals("경상남도")) {
			si2 = "경남";
		}else if(si.equals("부산광역시")) {
			si2 = "부산";
		}else if(si.equals("광주광역시")) {
			si2 = "광주";
		}else if(si.equals("울산광역시")) {
			si2 = "울산";
		}else if(si.equals("제주특별자치도")) {
			si2 = "제주";
		}
		param.put("si2",Utils.checkNullString(si2));
		forTotal.put("si2","");
		forTotal.put("selBranch",Utils.checkNullString(param.get("selBranch")));
		forTotal.put("selPeri",Utils.checkNullString(param.get("selPeri")));
		
		System.out.println("param : "+param);
		List<HashMap<String, Object>> listCnt = cust_dao.getCustListCount02(param);
		
		System.out.println("forTotal : "+forTotal);
		List<HashMap<String, Object>> listCnt_all = cust_dao.getCustListCount02(forTotal);
		
		int listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));
		System.out.println("listCount :"+listCount);
		int page = 1;
		if(!"".equals(Utils.checkNullString(param.get("page"))))
		{
			page = Integer.parseInt(Utils.checkNullString(param.get("page")));
		}
		int listSize = 20;
		if(!"".equals(Utils.checkNullString(param.get("listSize"))))
		{
			listSize = Integer.parseInt(Utils.checkNullString(param.get("listSize")));
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

		param.put("s_rownum",s_point);
		
		param.put("e_rownum",listSize*page);
		
		System.out.println(listSize);
		System.out.println(s_point);
		System.out.println(page);
		List<HashMap<String, Object>> list = cust_dao.getCustList02(param); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", param.get("order_by"));
		map.put("sort_type", param.get("sort_type"));
		
	    return map;
	}
	
	@RequestMapping("/getLecrDetail")
	@ResponseBody
	public HashMap<String, Object> getLecrDetail(HttpServletRequest request) {
		
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String grade = Utils.checkNullString(request.getParameter("grade"));
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
		String selYear2 = Utils.checkNullString(request.getParameter("selYear2"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
		String selSeason2 = Utils.checkNullString(request.getParameter("selSeason2"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		//평가결과
		String start_point = "";
		String end_point = "";
		if("A".equals(grade))
		{
			start_point = "90";
			end_point = "101";
		}
		else if("B".equals(grade))
		{
			start_point = "80";
			end_point = "90";
		}
		else if("C".equals(grade))
		{
			start_point = "70";
			end_point = "80";
		}
		else if("D".equals(grade))
		{
			start_point = "60";
			end_point = "70";
		}
		else if("E".equals(grade))
		{
			start_point = "50";
			end_point = "60";
		}
		//평가결과
		
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String start_peri = "";
		//String end_peri = "";
		if(!"".equals(store))
		{
			branchList = common_dao.getPeriList(store, selYear1, selSeason1);
			if(branchList.size() > 0)
			{
				start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
			/*
			branchList = common_dao.getPeriList(store, selYear2, selSeason2);
			if(branchList.size() > 0)
			{
				end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
			*/
		}
		//기수 검색
		List<HashMap<String, Object>> list = cust_dao.getLecr(search_name, store, start_point, end_point, start_peri, subject_fg);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("grade", grade);
		
		return map;
	}
	
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/cust/view");
		
		return mav;
	}
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/cust/write");
		
		return mav;
	}
	
	
	
	@Transactional
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/write_proc");
		
		String get_hq = Utils.checkNullString(request.getParameter("get_hq"));
	    String get_store = Utils.checkNullString(request.getParameter("get_store"));
	    String get_ip = Utils.checkNullString(request.getParameter("get_ip"));
	    
	    
	    HashMap<String, Object> peri_data = cust_dao.getPeri_no();
	    String newPeri = (String) peri_data.get("PERIOD");
	    
	    HashMap<String, Object> data = cust_dao.getCust_seq(newPeri);
	    int newCustNo = Integer.parseInt(Utils.checkNullString(data.get("CUST_NO")))+1;
	    System.out.println("newCustNo : "+newCustNo);
	    String newCustNoConv = Utils.f_setfill_zero(Integer.toString(newCustNo),4,"L");
	    System.out.println("newCustNoConv : "+newCustNoConv);
	    
	    
	    String cust_no = "77"+newPeri+newCustNoConv+"1";
	    System.out.println("cust_no : "+cust_no);
	    
	    
	    
		String kor_nm = Utils.checkNullString(request.getParameter("kor_nm"));
		String eng_nm = Utils.checkNullString(request.getParameter("eng_nm"));
		
		String birth_ymd = Utils.checkNullString(request.getParameter("birth_ymd"));
		String marry_fg = Utils.checkNullString(request.getParameter("marry_fg"));
		String marry_ymd = Utils.checkNullString(request.getParameter("marry_ymd"));
		String sex_fg = Utils.checkNullString(request.getParameter("sex_fg"));
		
		String post_no1 = Utils.checkNullString(request.getParameter("post_no1"));
		String post_no2 = Utils.checkNullString(request.getParameter("post_no2"));
		
		String addr_tx1 = Utils.checkNullString(request.getParameter("addr_tx1"));
		String addr_tx2 = Utils.checkNullString(request.getParameter("addr_tx2"));
		String addr_tx = addr_tx1+' '+addr_tx2;
		
		String phone_no = Utils.checkNullString(request.getParameter("phone_no"));
		String [] phone_no_arr = phone_no.split("-");
		
		String phone_no1 = phone_no_arr[0];
		String phone_no2 = phone_no_arr[1];
		String phone_no3 = phone_no_arr[2];
		
		String h_phone_no_1 = Utils.checkNullString(request.getParameter("h_phone_no_1"));
		String h_phone_no_2 = Utils.checkNullString(request.getParameter("h_phone_no_2"));
		String h_phone_no_3 = Utils.checkNullString(request.getParameter("h_phone_no_3"));
		
		String email_addr = Utils.checkNullString(request.getParameter("email_addr"));
		
		String email_yn = Utils.checkNullString(request.getParameter("email_yn"));
		String sms_yn = Utils.checkNullString(request.getParameter("sms_yn"));
		
		String point_no = Utils.checkNullString(request.getParameter("point_no"));
		
		
		String ptl_id = Utils.checkNullString(request.getParameter("ptl_id"));
		String ptl_pw = Utils.checkNullString(request.getParameter("ptl_pw"));
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		
		String ms_fg = "m"; //멤버스 회원 구분 m or c
		
		String di = Utils.checkNullString(request.getParameter("di"));
		String ci = Utils.checkNullString(request.getParameter("ci"));
		
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String create_date = Utils.checkNullString(request.getParameter("create_date"));
		String car_no = Utils.checkNullString(request.getParameter("car_no"));
		
		String memo_cont = Utils.checkNullString(request.getParameter("memo_cont"));
		
		String child_name = Utils.checkNullString(request.getParameter("child_name"));
		String child_gender = Utils.checkNullString(request.getParameter("child_gender"));
		String child_ymd = Utils.checkNullString(request.getParameter("child_ymd"));
		String child_age = Utils.checkNullString(request.getParameter("child_age"));
		
		
		
		cust_dao.insCust(
							cust_no,kor_nm,eng_nm,birth_ymd,marry_fg,marry_ymd,sex_fg,post_no1,
							post_no2,addr_tx1,addr_tx2,addr_tx,phone_no1,phone_no2,phone_no3,email_addr,email_yn,sms_yn,
							ptl_id,ptl_pw,cus_no,ms_fg,di,ci,create_resi_no,create_date,car_no,h_phone_no_1,
							h_phone_no_2,h_phone_no_3,point_no
						);
		
		if (!memo_cont.equals("")) {
			cust_dao.ins_memo(cust_no,memo_cont,create_resi_no);
		}
		
		String [] child_name_arr=child_name.split("\\|");
		String [] child_gender_arr=child_gender.split("\\|");
		String [] child_ymd_arr=child_ymd.split("\\|");
		String [] child_age_arr=child_age.split("\\|");
		
		for (int i = 0; i < child_name_arr.length; i++) {
			int child_no = lect_dao.getlast_childNo(cust_no); 
			lect_dao.saveChild(child_no, child_name_arr[i], child_gender_arr[i], child_ymd_arr[i], cust_no);
		
		}
		
		cust_dao.uptCarNo(cust_no,car_no,create_resi_no);
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	
	@RequestMapping("/list_mem")
	public ModelAndView list_mem(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/cust/list_mem");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String login_name = Utils.checkNullString(session.getAttribute("login_name"));
		String store_nm="";
		if (store.equals("02"))
		{
			store_nm="수원점";
		} 
		else if (store.equals("03"))
		{
			store_nm="분당점";
		}
		else if (store.equals("04"))
		{
			store_nm="평택점";
		}
		else if (store.equals("05"))
		{
			store_nm="원주점";
		}
		
		List<HashMap<String, Object>> list = cust_dao.getLectInfo(cust_no,store,"","1","",""); 
		int lect_sum =0;
		int lect_cnt =list.size();
		for (int i = 0; i < list.size(); i++) 
		{
			lect_sum += Integer.parseInt((list.get(i).get("NET_SALE_AMT").toString()));
		}
		
		
		mav.addObject("lect_sum", lect_sum);
		mav.addObject("lect_cnt", lect_cnt);
		mav.addObject("store_nm", store_nm);
		mav.addObject("login_name", login_name);
		mav.addObject("cust_no", cust_no);
		
		Utils.setPeriControllerAll(mav, common_dao, session);
		mav.addObject("year", Utils.getDateNow("year"));
		
		return mav;
	}
	
	@RequestMapping("/search_num")
	public ModelAndView search_num(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/cust/search_num");
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		
		List<HashMap<String, Object>> listCnt = cust_dao.getCustCount(search_name);
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
		
		List<HashMap<String, Object>> list = cust_dao.getCust(search_name, s_point, listSize*page, order_by, sort_type); 
		
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("order_by", order_by);
		mav.addObject("sort_type", sort_type);
		mav.addObject("search_name", search_name);
		mav.addObject("s_page", s_page);
		mav.addObject("e_page", e_page);
		mav.addObject("pageNum", pageNum);
		mav.addObject("listSize", listSize);
		
		return mav;
	}
	@RequestMapping("/getUserList")
	@ResponseBody
	public List<HashMap<String, Object>> getUserList(HttpServletRequest request) {
		
		String searchPhone = Utils.checkNullString(request.getParameter("searchPhone"));
		List<HashMap<String, Object>> list = cust_dao.getUser_byPhone_Last(searchPhone);
		
		
	    return list;
	}
	@RequestMapping("/getUserListByMembers")
	@ResponseBody
	public List<HashMap<String, Object>> getUserListByMembers(HttpServletRequest request) {
		
		String searchPhone = Utils.checkNullString(request.getParameter("searchPhone"));
		List<HashMap<String, Object>> list = cust_dao.getUserListByMembers(searchPhone);  
			
	    return list;
	}
	@RequestMapping("/getUserByMembers")
	@ResponseBody
	public HashMap<String, Object> getUserByMembers(HttpServletRequest request) {
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		HashMap<String, Object> data = cust_dao.getUserByMembers(cus_no); 
		
		return data;
	}
	
	@RequestMapping("/getMemo")
	@ResponseBody
	public HashMap<String, Object> getMemo(HttpServletRequest request) {
		
	
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		int listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		
		System.out.println("cust_no :"+cust_no);
		
		List<HashMap<String, Object>> list = cust_dao.getMemo(cust_no,order_by,sort_type,listSize);  
			
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
	    return map;
	}
	@RequestMapping("/getChildInfo")
	@ResponseBody
	public List<HashMap<String, Object>> getChildInfo(HttpServletRequest request) {
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		List<HashMap<String, Object>> list = cust_dao.getChildInfo(cust_no);  
			
	    return list;
	}
	
	
	@RequestMapping("/getCusList")
	@ResponseBody
	public List<HashMap<String, Object>> getCusList(HttpServletRequest request) {
		
		String search_cus = Utils.checkNullString(request.getParameter("search_cus"));
		List<HashMap<String, Object>> list = common_dao.getUser_byCus_no(search_cus);
		
		
	    return list;
	}
	
	@RequestMapping("/getMessageList")
	@ResponseBody
	public HashMap<String, Object> getMessageList(HttpServletRequest request) {
	
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String kor_nm = Utils.checkNullString(request.getParameter("kor_nm"));
		String start_day = Utils.checkNullString(request.getParameter("start_day"));
		String end_day = Utils.checkNullString(request.getParameter("end_day"));
		String send_type = Utils.checkNullString(request.getParameter("send_type"));
		String send_state = Utils.checkNullString(request.getParameter("send_state"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		int listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		List<HashMap<String, Object>> list = cust_dao.getSmsList(cust_no,kor_nm,start_day,end_day,send_type,send_state,order_by,sort_type,listSize);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
	    return map;
	}
	
	@RequestMapping("/getCustHistory")
	@ResponseBody
	public HashMap<String, Object> getCustHistory(HttpServletRequest request) {
	
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		int listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		
		List<HashMap<String, Object>> list = cust_dao.getCustHistory(cust_no,order_by,sort_type,listSize); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
	    return map;
	}
	
	@RequestMapping("/getLectInfo")
	@ResponseBody
	
	public HashMap<String, Object> getLectInfo(HttpServletRequest request) {	
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String period = Utils.checkNullString(request.getParameter("selPeri"));
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
		String selYear2 = Utils.checkNullString(request.getParameter("selYear2"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
		String selSeason2 = Utils.checkNullString(request.getParameter("selSeason2"));
		String listener = Utils.checkNullString(request.getParameter("listener"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String start_peri = "";
		String end_peri = "";
		if(!"".equals(store))
		{
			branchList = common_dao.getPeriList(store, selYear1, selSeason1);
			if(branchList.size() > 0)
			{
				start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
			branchList = common_dao.getPeriList(store, selYear2, selSeason2);
			if(branchList.size() > 0)
			{
				end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
		}
		//기수 검색
		
		List<HashMap<String, Object>> list = cust_dao.getLectInfo_mem(cust_no,store,period,listener,order_by,sort_type,start_peri, end_peri);  
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
	    return map;
	}
	
	@RequestMapping("/getSmsInfo")
	@ResponseBody
	public List<HashMap<String, Object>> getSmsInfo(HttpServletRequest request) {
		
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		List<HashMap<String, Object>> list = cust_dao.getSmsInfo(cust_no);  
		
			
	    return list;
	}
	
	@RequestMapping("/getTmList")
	@ResponseBody
	public HashMap<String, Object> getTmList(HttpServletRequest request) {	
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String kor_nm = Utils.checkNullString(request.getParameter("kor_nm"));
		String start_day = Utils.checkNullString(request.getParameter("start_day"));
		String end_day = Utils.checkNullString(request.getParameter("end_day"));
		String chk_myself = Utils.checkNullString(request.getParameter("chk_myself"));
		String recall_yn = Utils.checkNullString(request.getParameter("recall_yn"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		int listSize = Integer.parseInt(Utils.checkNullString(request.getParameter("listSize")));
		
		List<HashMap<String, Object>> list = cust_dao.getTmList(cust_no,kor_nm,start_day,end_day,
				chk_myself,recall_yn,order_by,sort_type,listSize);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
	    return map;
	}
	
	@RequestMapping("/userSearch")
	@ResponseBody
	public List<HashMap<String, Object>> userSearch(HttpServletRequest request) {
		
		String searchType = Utils.checkNullString(request.getParameter("searchType"));
		String searchVal = Utils.checkNullString(request.getParameter("searchVal"));
		String user_name = Utils.checkNullString(request.getParameter("user_name"));
		String birth = Utils.checkNullString(request.getParameter("birth"));
		List<HashMap<String, Object>> list = cust_dao.userSearch(searchType, searchVal, user_name, birth); 
		
	    return list;
	}
	@Transactional
	@RequestMapping("/cust_update")
	@ResponseBody
	public HashMap cust_update(HttpServletRequest request) throws UnknownHostException {
		HashMap<String, Object> map = new HashMap<>();
		
		
		HttpSession session = request.getSession();
		
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String car_no = Utils.checkNullString(request.getParameter("car_no"));
		String memo_list[] = Utils.checkNullString(request.getParameter("memo_list")).split("\\|");
		String child_nm[] = Utils.checkNullString(request.getParameter("child_nm")).split("\\|");
		String child_gender[] = Utils.checkNullString(request.getParameter("child_gender")).split("\\|");
		String child_birth[] = Utils.checkNullString(request.getParameter("child_birth")).split("\\|");		
	
		cust_dao.uptCarNo(cust_no,car_no,create_resi_no);
		
		for (int i = 0; i < memo_list.length; i++) {
			System.out.println("memo_list : "+ memo_list[i]);
			
			if (!memo_list[i].equals("")) {
				cust_dao.ins_memo(cust_no,memo_list[i],create_resi_no);
			}
			
		}
		
		for(int i = 0; i < child_nm.length; i++)
		{
			
			if (!child_nm[i].equals("")) {
				int child_no = lect_dao.getlast_childNo(cust_no); 
				lect_dao.saveChild(child_no, child_nm[i], child_gender[i], child_birth[i], cust_no);
			}
			
		}

	//	mav.addObject("e_page", e_page);
		
		map.put("msg", "저장되었습니다.");
		return map;
	}
	
	@RequestMapping("/getPereByChild")
	@ResponseBody
	public int getPereByChild(HttpServletRequest request) {	
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String child_no = Utils.checkNullString(request.getParameter("child_no"));
		
		//수강한 강좌가 있는지 확인
		int cnt = cust_dao.getPereByChild(cust_no, child_no);
		return cnt;
	}
	@RequestMapping("/delChild")
	@ResponseBody
	public HashMap<String, Object> delChild(HttpServletRequest request) {	
		HashMap<String, Object> map = new HashMap<>();
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String child_no = Utils.checkNullString(request.getParameter("child_no"));
		
		
		int result = cust_dao.delChild(cust_no, child_no); 
		if (result > 0) {			
			map.put("msg", "저장되었습니다.");
		}else {
			map.put("msg", "관리자에게 문의해주세요.");
		}
	    return map;
	}
	
	@RequestMapping("/delMemo")
	@ResponseBody
	public HashMap<String, Object> delMemo(HttpServletRequest request) {	
		HashMap<String, Object> map = new HashMap<>();
		
		String memo = Utils.checkNullString(request.getParameter("memo"));
		String memo_date = Utils.checkNullString(request.getParameter("memo_date"));
		
		
		int result = cust_dao.delMemo(memo, memo_date); 
		if (result > 0) {			
			map.put("msg", "저장되었습니다.");
		}else {
			map.put("msg", "관리자에게 문의해주세요.");
		}
	    return map;
	}
	
	@RequestMapping("/cust_join")
	public ModelAndView join(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/member/cust/cust_join");
		return mav;
	}
	@RequestMapping("/getCustListOld")
	@ResponseBody
	public List<HashMap<String, Object>> getCustListOld(HttpServletRequest request) {	
		
		String searchPhone = Utils.checkNullString(request.getParameter("searchPhone"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		List<HashMap<String, Object>> list = cust_dao.getCustListOld(searchPhone, order_by, sort_type); 
		return list;
	}
	@RequestMapping("/getAmsListOld")
	@ResponseBody
	public List<HashMap<String, Object>> getAmsListOld(HttpServletRequest request) {	
		
		String searchPhone = Utils.checkNullString(request.getParameter("searchPhone"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		List<HashMap<String, Object>> list = cust_dao.getAmsListOld(searchPhone, order_by, sort_type); 
		return list;
	}
	@Transactional
	@RequestMapping("/cust_join_proc")
	@ResponseBody
	public HashMap<String, Object> cust_join_proc(HttpServletRequest request) {	
		HashMap<String, Object> map = new HashMap<>();
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		String store = Utils.checkNullString(request.getParameter("store"));
		try
		{
			int cnt = cust_dao.upCusByCust(store, cust_no, cus_no);
			if(cnt > 0)
			{
				cust_dao.insNewCust(cus_no);
				List<HashMap<String, Object>> cust_no_list = cust_dao.getCustnoByCusno(cus_no);
				System.out.println("======================cus_no("+cus_no+")의 cust_no 조회");
				for(int j = 0; j < cust_no_list.size(); j++)
				{
					cust_dao.updateCust_pere(cus_no, cust_no, store);
					cust_dao.updateCust_kids(cus_no, cust_no, store);
				}
				HttpSession session = request.getSession();
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "회원 통합", cus_no);

				map.put("isSuc", "success");
				map.put("msg", "성공적으로 저장되었습니다.");
			}
			else
			{
				map.put("isSuc", "fail");
				map.put("msg", "오류 발생");
			}
		}
		catch(Exception e)
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		return map;
		
	}
	@RequestMapping("/cust_pere_list")
	@ResponseBody
	public List<HashMap<String, Object>> cust_pere_list(HttpServletRequest request) {	
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String store = Utils.checkNullString(request.getParameter("store"));
		List<HashMap<String, Object>> list = cust_dao.cust_pere_list(cust_no, store);
		
		return list;
		
	}
	
	
	
}