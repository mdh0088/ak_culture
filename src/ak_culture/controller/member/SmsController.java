package ak_culture.controller.member;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sun.org.apache.bcel.internal.generic.IF_ACMPEQ;

import ak_culture.classes.Utils;
import ak_culture.controller.common.CommonController;
import ak_culture.model.basic.EncdDAO;
import ak_culture.model.basic.GiftDAO;
import ak_culture.model.basic.UserDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.lecture.LectDAO;
import ak_culture.model.member.CustDAO;
import ak_culture.model.member.SmsDAO;


@Controller
@RequestMapping("/member/sms/*")



public class SmsController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private SmsDAO sms_dao;
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private CustDAO cust_dao;
	
	@Autowired
	private EncdDAO encd_dao;
	
	@Autowired
	private GiftDAO gift_dao;
	
	@Autowired
	private LectDAO lect_dao;
	
	@Autowired
	private CommonController  common_cr;
	
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/member/sms/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		
		return mav;
	}
	
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/view");
		
		return mav;
	}
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/write");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		List<HashMap<String, Object>> si_list = cust_dao.getAddr_si();
		mav.addObject("si_list", si_list);
		
		//List<HashMap<String, Object>> messageList = sms_dao.messageList();
		//mav.addObject("messageList", messageList);
		
		//List<HashMap<String, Object>> recentCustList = sms_dao.recentCustList("03");
		//mav.addObject("recentCustList", recentCustList);
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		String login_rep_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
		//String getCustNo = Utils.checkNullString(request.getParameter("getCustNo"));
		//mav.addObject("getCustNo", getCustNo);
		mav.addObject("login_rep_store", login_rep_store);
		return mav;
	}
	
	@RequestMapping("/list_tm")
	public ModelAndView list_tm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/list_tm");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		String referer = (String)request.getHeader("REFERER");
		System.out.println("referer : "+referer);
		mav.addObject("referer", referer);
		return mav;
	}
//	@RequestMapping("/tm_cust")
//	public ModelAndView tm_cust(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView(); 
//		mav.setViewName("/WEB-INF/pages/member/sms/tm_cust");
//		
//		return mav;
//	}
	
	@RequestMapping("/sms")
	public ModelAndView sms(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/sms");
		
		return mav;
	}
	
	
	@RequestMapping("/choose_message")
	@ResponseBody
	public List<HashMap<String, Object>> choose_message(HttpServletRequest request) {
		
		String sms_seq = Utils.checkNullString(request.getParameter("sms_seq"));
		
		List<HashMap<String, Object>> list = sms_dao.choose_message(sms_seq);
		
	    return list;
	}
	
	@RequestMapping("/getSendList")
	@ResponseBody
	public HashMap<String, Object> getSendList(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String send_state = Utils.checkNullString(request.getParameter("send_state"));
	    List<HashMap<String, Object>> list = sms_dao.messageList(store,send_state);

		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);

		
		
		return map;
	}
	
	@RequestMapping("/getMessageList")
	@ResponseBody
	public HashMap<String, Object> getMessageList(HttpServletRequest request) {
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String start_day = Utils.checkNullString(request.getParameter("start_day"));
		String end_day = Utils.checkNullString(request.getParameter("end_day"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String send_type = Utils.checkNullString(request.getParameter("send_type"));
		String send_state = Utils.checkNullString(request.getParameter("send_state"));
		
		System.out.println("store : "+store);
		System.out.println("start_day : "+start_day);
		System.out.println("end_day : "+end_day);
		System.out.println("search_type : "+search_type);
		System.out.println("send_type : "+send_type);
		System.out.println("send_state : "+send_state);
		
		List<HashMap<String, Object>> listCnt = sms_dao.getSmsCount(store,search_name,start_day,end_day,search_type,send_type,send_state);
		List<HashMap<String, Object>> listCnt_all = sms_dao.getSmsCount(store,"",start_day,end_day,"","","");
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

		List<HashMap<String, Object>> list = sms_dao.getSms(search_name,s_point, listSize*page, order_by,sort_type,store,start_day,end_day,search_type,send_type,send_state); 

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
	
	
	@RequestMapping("/getSmsCustList")
	@ResponseBody
	public HashMap<String, Object> getSmsCustList(HttpServletRequest request) {
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String sms_seq = Utils.checkNullString(request.getParameter("sms_seq"));
		
		
		
		List<HashMap<String, Object>> listCnt = sms_dao.getSmsCustListCount(store,period,sms_seq);
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

		List<HashMap<String, Object>> list = sms_dao.getSmsCustList(store,period,sms_seq,s_point, listSize*page, order_by,sort_type); 

		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		return map;
	}
	
	@RequestMapping("/getContent")
	@ResponseBody
	public HashMap<String, Object> getReview(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String sms_seq = Utils.checkNullString(request.getParameter("sms_seq"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		
		HashMap<String, Object> data = sms_dao.getContent(store,period,sms_seq,cust_no);
		
		return data;
	}
	
	
	@RequestMapping("/getTmList")
	@ResponseBody
	public HashMap<String, Object> getTmList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String searchType = Utils.checkNullString(request.getParameter("searchType"));
		String start_day = Utils.checkNullString(request.getParameter("start_day"));
		String end_day = Utils.checkNullString(request.getParameter("end_day"));
		String purpose = Utils.checkNullString(request.getParameter("purpose"));
		String result = Utils.checkNullString(request.getParameter("result"));
		
	
		List<HashMap<String, Object>> listCnt = sms_dao.getTmCount(store,period,search_name,searchType,start_day,end_day,purpose,result);
		List<HashMap<String, Object>> listCnt_all = sms_dao.getTmCount(store,period,"","","","","","");
		int listCount=0;
		if (listCnt.size() > 0) 
		{
			listCount = Utils.checkNullInt(listCnt.get(0).get("CNT"));			
		}
		
		int listCount_all=0;
		if (listCnt_all.size() > 0) 
		{
			listCount_all = Utils.checkNullInt(listCnt_all.get(0).get("CNT"));			
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
		

		System.out.println("controller searchType : "+searchType);
		List<HashMap<String, Object>> list = sms_dao.getTmList(search_name,s_point, listSize*page,order_by,sort_type,
				store,period,searchType,start_day,end_day,purpose,result);
		
		HashMap<String, Object> map = new HashMap<>();
		
		
		map.put("listCnt", listCount);
		map.put("listCnt_all", listCount_all);
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
	    return map;
	}


	
	@RequestMapping("/sms_cust")
	public ModelAndView sms_cust(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/sms_cust");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String sms_seq = Utils.checkNullString(request.getParameter("sms_seq"));
		
		//HttpSession session = request.getSession();
		//String login_name = Utils.checkNullString(session.getAttribute("login_name"));
		//mav.addObject("login_name", login_name);
		
		//List<HashMap<String, Object>> list = sms_dao.getSmsCustList(sms_seq); 
		mav.addObject("store", store);
		mav.addObject("period", period);
		mav.addObject("sms_seq", sms_seq);
		
		return mav;
	}
	
	@RequestMapping("/tm_cust")
	public ModelAndView tm_cust(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/tm_cust");
		
		String tm_seq = Utils.checkNullString(request.getParameter("tm_seq"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		System.out.println("subject_cd : "+subject_cd);
		
		HashMap<String, Object> data = lect_dao.getPeltOne(store, period, subject_cd);
		mav.addObject("data", data);
		mav.addObject("store", store);
		mav.addObject("period", period);
		mav.addObject("tm_seq", tm_seq);		
		mav.addObject("subject_cd", subject_cd);
		
		if (!subject_cd.equals("")) 
		{
			HashMap<String, Object> getPeltInfo = sms_dao.getPeltInfo(store, period, subject_cd);
			if (getPeltInfo!=null)
			{
				for (String key : getPeltInfo.keySet()) 
				{
					System.out.println(key +":"+getPeltInfo.get(key));
					
					mav.addObject(key, getPeltInfo.get(key));
				}
			}
			else
			{
				mav.addObject("subject_cd", "");
			}
		}
		
//		List<HashMap<String, Object>> list = sms_dao.getTmCust(tm_seq);
//		mav.addObject("list", list);
		HttpSession session = request.getSession();
		String login_name = Utils.checkNullString(session.getAttribute("login_name"));
		
		mav.addObject("login_name",login_name);
		
		
		return mav;
	}
	
	@RequestMapping("/tm_cust_list")
	@ResponseBody
	public HashMap<String, Object> tm_cust_list(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String tm_seq = Utils.checkNullString(request.getParameter("tm_seq"));

		HashMap<String, Object> getTmmInfo = sms_dao.getTmmInfo(store, period, tm_seq);
		String islec = Utils.checkNullString(getTmmInfo.get("IS_LEC"));
		
		List<HashMap<String, Object>> listCnt = new ArrayList<HashMap<String, Object>>();
		if (islec.equals("N")) 
		{
			listCnt = sms_dao.getTmListForCustCount(store,period,tm_seq);
		}
		else
		{
			listCnt = sms_dao.getTmListForLecrCount(store,period,tm_seq);
		}
		
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

		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		if (islec.equals("N")) 
		{
			list = sms_dao.getTmListForCust(s_point, listSize*page,order_by,sort_type,tm_seq,store,period);
		}
		else
		{
			list = sms_dao.getTmListForLecr(s_point, listSize*page,order_by,sort_type,tm_seq,store,period);
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
	    return map;
	}
	
	@RequestMapping("/getTmCustMemo")
	@ResponseBody
	public HashMap<String, Object> getTmCustMemo(HttpServletRequest request) {
	
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String tm_seq = Utils.checkNullString(request.getParameter("tm_seq"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		
		HashMap<String, Object> getTmmInfo = sms_dao.getTmmInfo(store, period, tm_seq);
		String islec = Utils.checkNullString(getTmmInfo.get("IS_LEC"));
		
		
		List<HashMap<String, Object>> list = sms_dao.getTmCustMemo(cust_no,tm_seq);
		
		List<HashMap<String, Object>> cust_info = new ArrayList<HashMap<String, Object>>();
		if (islec.equals("N")) {
			cust_info = sms_dao.getTmCustInfo(cust_no);			
		}else {
			cust_info = sms_dao.getTmLecrInfo(cust_no);		
		}
		
		
		
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("list", list);
		map.put("cust_info", cust_info);
		
		return map;
	}
	
	@RequestMapping("/choose_custList")
	@ResponseBody
	public List<HashMap<String, Object>> choose_custList(HttpServletRequest request) {
		
		String sms_seq = Utils.checkNullString(request.getParameter("sms_seq"));
		
		List<HashMap<String, Object>> list = sms_dao.choose_custList(sms_seq);
		
		
		return list;
	}
	
	
//	@RequestMapping("/getEncdCustList")
//	@ResponseBody
//	public List<HashMap<String, Object>> getEncdCustList(HttpServletRequest request) {
//		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
//		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
//		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
//		String lect_cd = Utils.checkNullString(request.getParameter("lect_cd"));
//		String start_day = Utils.checkNullString(request.getParameter("start_day"));
//		String end_day = Utils.checkNullString(request.getParameter("end_day"));
//		List<HashMap<String, Object>> list = encd_dao.getEncdCustList(selBranch,main_cd,sect_cd,lect_cd,start_day,end_day);
//		
//	    return list;
//	}
	@Transactional
	@RequestMapping("/write_tm_info")
	public ModelAndView write_tm_info(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/write_tm_info");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String tm_seq = Utils.checkNullString(request.getParameter("tm_seq"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		//String title = Utils.checkNullString(request.getParameter("title"));
		String memo = Utils.checkNullString(request.getParameter("memo"));
		String receiver = Utils.checkNullString(request.getParameter("receiver"));
		String recall_yn = Utils.checkNullString(request.getParameter("recall_yn"));
		
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		//String[] upt_title = request.getParameterValues("upt_title[]");
		String[] upt_memo = request.getParameterValues("upt_memo[]");
		String[] upt_receiver = request.getParameterValues("upt_receiver[]");
		String[] upt_recall = request.getParameterValues("upt_recall[]");
		String[] upt_memo_seq = request.getParameterValues("upt_memo_seq[]");
		
		try {
			
			
			if (upt_memo!=null) {
				for (int i = 0; i < upt_memo.length; i++) {
					if (i == 0) 
					{
						sms_dao.uptTMLCustInfo(store,period,tm_seq,cust_no,upt_recall[i],create_resi_no,upt_receiver[i]);
					}
					sms_dao.upt_tm_Custinfo(store,period,tm_seq,cust_no,upt_memo[i],upt_receiver[i],upt_recall[i],upt_memo_seq[i],create_resi_no);		
				}
			}
	//		HttpSession session = request.getSession();
	//		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
			
			if (!memo.equals("")) {
			//	sms_dao.add_tm_memo(tm_seq,cust_no,title,memo,receiver,recall_yn,create_resi_no);
				sms_dao.add_tm_memo(store,period,tm_seq,cust_no,memo,receiver,recall_yn,create_resi_no);
				sms_dao.uptTMLCustInfo(store,period,tm_seq,cust_no,recall_yn,create_resi_no,receiver);
			}
			//String result_yn = sms_dao.getTmMemoResult(tm_seq);
			//sms_dao.uptTMLCustInfo(tm_seq,cust_no,result_yn,create_resi_no);
		
		}catch (Exception e) {
			e.printStackTrace();
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	
	
	/*
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/write_proc");
		
		String send_type = Utils.checkNullString(request.getParameter("SEND_TYPE"));
		String sms_sender = Utils.checkNullString(request.getParameter("SMS_SENDER"));
		String send_set = Utils.checkNullString(request.getParameter("SEND_SET"));
		String send_set_day = Utils.checkNullString(request.getParameter("SEND_SET_DAY"));
		String send_set_time = Utils.checkNullString(request.getParameter("SEND_SET_TIME"));
		String cont_type = Utils.checkNullString(request.getParameter("CONT_TYPE"));
		String cont_title = Utils.checkNullString(request.getParameter("CONT_TITLE"));
		String cust_list = Utils.checkNullString(request.getParameter("CUST_LIST"));
		String massage = Utils.checkNullString(request.getParameter("MASSAGE"));
		
	//	String send_state = Utils.checkNullString(request.getParameter("SEND_STATE"));
		
		
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String sms_seq ="";
		List<HashMap<String, Object>> getSmsSeq = sms_dao.getSmsSeq();
		sms_seq = Utils.checkNullString(getSmsSeq.get(0).get("SMS_SEQ"));


		//sms_dao.insSms(sms_seq,send_type,sms_sender,send_set,send_set_day,send_set_time,cont_type,cont_title,create_resi_no,send_state);
		//sms_dao.insSms(sms_seq,send_type,sms_sender,send_set,send_set_day,send_set_time,cont_type,cont_title,create_resi_no);
		
		String[] cust_list_array;
		cust_list_array = cust_list.split("@");
		
		for (int i = 0; i < cust_list_array.length; i++) {
//			sms_dao.insSmsList(cust_list_array[i],sms_seq,send_type,sms_sender,send_set,massage,send_state,send_set_day,send_set_time,create_resi_no);
//			sms_dao.insSmsList(cust_list_array[i],sms_seq,send_type,sms_sender,send_set,massage,send_set_day,send_set_time,create_resi_no);
		}
		
		sms_dao.add_seq();
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	*/
	
	@RequestMapping("/getTargetCustList")
	@ResponseBody
	public List<HashMap<String, Object>> getTargetCustList(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String year = Utils.checkNullString(request.getParameter("year"));
		String season = Utils.checkNullString(request.getParameter("season"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd")); 
		
		List<HashMap<String, Object>> list = sms_dao.getTargetCustList(store,year,season,main_cd,sect_cd,subject_cd);
	    
		return list;
	}
	
	@Transactional
	@RequestMapping("/sms_send")
	@ResponseBody
	public ModelAndView sms_send(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/sms/write_proc");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		//String id ="";
	    //String pw="";
		//String isSMS = Utils.checkNullString(request.getParameter("send_type_b")); //SMS
		//String isKakao = Utils.checkNullString(request.getParameter("send_type_a")); //알림톡
		String lms_flag = Utils.checkNullString(request.getParameter("lms_flag")); //알림톡
		String store = Utils.checkNullString(request.getParameter("store")); //지점
		String reserve_time = Utils.checkNullString(request.getParameter("store")); //지점
		String period = common_dao.retrievePeriod(store);
		String excel_list = Utils.checkNullString(request.getParameter("excel_list")); 
		String cont_type = Utils.checkNullString(request.getParameter("cont_type")); //발송내용 1:휴강안내/취소 2:이강안내 3:폐강안내 4:개강 5:기타
		String message_title = Utils.checkNullString(request.getParameter("message_title")); //메시지 제목
		//String message_area = Utils.repWord(Utils.checkNullString(request.getParameter("message_area")));
		String message_area = Utils.checkNullString(request.getParameter("message_area"));
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		String cust_list = Utils.checkNullString(request.getParameter("cust_list"));
		String is_lec = Utils.checkNullString(request.getParameter("is_lec"));
		
		
		String send_type="";
		String result="";
		String result_txt="";
		System.out.println("lms_flag : "+lms_flag);
		
		send_type="2";
		if (lms_flag.equals("true")) 
		{
			send_type="3";
		}
		
		
		//지점별 전송번호 세팅
		String sms_sender="";
		if (store.equals("03")) 
		{
			sms_sender="0317793810";
		}
		else if (store.equals("02")) 
		{
			sms_sender="0312400521";
		}
		else if (store.equals("04")) 
		{
			sms_sender="0316151050";
		}
		else if (store.equals("05")) 
		{
			sms_sender="0338115001";
		}

		System.out.println("----지점 기수-----");
		System.out.println("store : "+store); 
		System.out.println("period : "+period); 
		System.out.println("-----------------");

		System.out.println("----발송수단-----");
		System.out.println("send_type (2:SMS / 3:LMS) : "+send_type);
		System.out.println("-----------------");
		
		System.out.println("----발송대상-----");
		System.out.println("excel_list : "+excel_list);
		System.out.println("cust_list : "+cust_list);
		System.out.println("-----------------");
		
		System.out.println("----발송내용-----");
		System.out.println("cont_type : "+cont_type);
		System.out.println("message_title : "+message_title);
		System.out.println("message_area : "+message_area);
		System.out.println("-----------------");
		

		
		try {
			int sms_seq = sms_dao.insSms(send_type,sms_sender,cont_type,Utils.repWord(message_title),create_resi_no,Utils.repWord(message_area),store,period);	

			//엑셀 전송부 start
			if (!excel_list.equals("")) 
			{
				
				String[] excel_arr = excel_list.split("\\|");
				String p1=""; String p2=""; String p3 =""; 
				for (int i = 0; i < excel_arr.length; i++) 
				{
					excel_arr[i] = excel_arr[i].replaceAll("－", "").replaceAll(" ","");
					//System.out.println("excel_arr[i].length() : "+excel_arr[i].length());
					if (excel_arr[i].length() != 11 && excel_arr[i].length() != 10) 
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "전송이 불가능한 데이터가 있습니다 관리자에게 문의주세요.");
						return mav;
					}
					
					
				}
				
				
				for (int i = 0; i < excel_arr.length; i++) 
				{
					if (i==0 || i % 200==0) 
					{
						System.out.println("len cust : "+i);
						System.out.println("create token ****start*****");
						JSONParser jsonParse = new JSONParser();
						JSONObject jsonObj = new JSONObject();
						String returnText = common_cr.getAuthToken(request);
						jsonObj = (JSONObject) jsonParse.parse(returnText);		      
						request.setAttribute("accessToken", Utils.checkNullString(jsonObj.get("accessToken")));
						request.setAttribute("schema", Utils.checkNullString(jsonObj.get("schema")));
						System.out.println("create token ****end*****");
					}
					
					excel_arr[i] = excel_arr[i].replaceAll("－", "");
					
					if (excel_arr[i].length() == 11) 
					{
						p1 = excel_arr[i].substring(0,3);
						p2 = excel_arr[i].substring(3,7);
						p3 = excel_arr[i].substring(7,11);						
					}
					else if(excel_arr[i].length() == 10)
					{
						p1 = excel_arr[i].substring(0,3);
						p2 = excel_arr[i].substring(3,6);
						p3 = excel_arr[i].substring(6,10);
					}
					
					//유효성 검사
					Boolean phone_chk = common_dao.isVaildCell(p1, p2, p3);
					HashMap<String, Object> data = sms_dao.ChkUserForCustExcel(p1,p2,p3);
					if (data==null) 
					{
						data = sms_dao.ChkUserForAMSExcel(p1,p2,p3);
					}
					
					if (data!=null) 
					{
						
						message_area=Utils.checkNullString(message_area.replaceAll("\\{memId\\}", Utils.checkNullString(data.get("PTL_ID"))));
						message_area=Utils.checkNullString(message_area.replaceAll("\\{memNm\\}",Utils.checkNullString(data.get("KOR_NM"))));
						message_area=Utils.checkNullString(message_area.replaceAll("\\{groupNm\\}",Utils.checkNullString(data.get("CLASS"))));
						message_area=Utils.checkNullString(message_area.replaceAll("\\{carNb\\}",Utils.checkNullString(data.get("CAR_NO"))));
		
						
						request.setAttribute("cust_phone_num", "82"+""+p1.substring(1)+""+p2+""+p3); 
						request.setAttribute("message", new String(message_area.getBytes("euc-kr"),"euc-kr"));
						request.setAttribute("title", message_title);
						//발신자
						request.setAttribute("store_no", sms_sender);								 
						
						
						if (data.get("SMS_YN").toString().equals("Y")) 
						{
							if (phone_chk!=false)
					        {
								System.out.println("smsSend start******");
								result = common_cr.sendSms(request);		//SMS발송 파트
					        	//result_status="R004";
								System.out.println("result : "+result);
								System.out.println("smsSend end******");
							}
						}
						
				        
						
						if (result.equals("R000")) 
				        {
				        	result_txt="발송성공";
				        	result="S";
						}
				        else
				        {
				        	if(result.equals("R001")) {result =  "F"; result="일시적 서비스 장애";}
					        else if(result.equals("R002")) {result =  "F"; result_txt="인증 실패";}
					        else if(result.equals("R002")) {result =  "F"; result_txt="수신번호 형식 어류";}
					        else if(result.equals("R007")) {result =  "F"; result_txt="유효하지 않은 파라미터 오류";}
					        else if(result.equals("R009")) {result =  "F"; result_txt="서버 capacity 초과, 재시도 요망";}
					        else if(result.equals("R012")) {result =  "F"; result_txt="해당 서비스 유형 전송 권한 없음";}
					        else if(result.equals("R013")) {result =  "F"; result_txt="발송 가능 건수 초과";}
					        else if(result.equals("R999")) {result =  "F"; result_txt="알려지지 않은 에러";}
					        else if(result.equals("R102")) {result =  "F"; result_txt="유효하지 않은 수신번호";}
					        else if(result.equals("R103")) {result =  "F"; result_txt="네트워크 에러";}
					        else {result_txt="발송실패"; result =  "F"; }
				        }
				        
				        if (phone_chk==false)
				        {
				        	result_txt="발신번호오류";
				        	result="F";
						}
				        
				        if (data.get("SMS_YN").toString().equals("N")) 
						{
							result_txt="SMS수신거부";
				        	result="F";
						}
				        
				        sms_dao.insSmsList(store,data.get("CUST_NO").toString(),data.get("KOR_NM").toString(),p1+""+p2+""+p3,sms_sender,Utils.repWord(message_area),reserve_time,create_resi_no,send_type,result,sms_seq,result_txt,period,Utils.repWord(message_title),cont_type);
					
					
					}
				}
			}
			//*엑셀 전송부 end
			
			
			//*회원 전송부 start
			if (!cust_list.equals("")) 
			{
				String[] cust_listArray = cust_list.split("\\|");
				for (int i = 0; i < cust_listArray.length; i++) 
				{
					if (i==0 || i % 200==0) 
					{
						System.out.println("len cust : "+i);
						System.out.println("create token ****start*****");
						JSONParser jsonParse = new JSONParser();
						JSONObject jsonObj = new JSONObject();
						String returnText = common_cr.getAuthToken(request);
						jsonObj = (JSONObject) jsonParse.parse(returnText);		      
						request.setAttribute("accessToken", Utils.checkNullString(jsonObj.get("accessToken")));
						request.setAttribute("schema", Utils.checkNullString(jsonObj.get("schema")));
						
						System.out.println("create token ****end*****");
					}
					System.out.println("cust_list : " +cust_listArray[i]);
					
					//고객정보 조회
					List<HashMap<String, Object>> getSmsCustInfo = new ArrayList<HashMap<String, Object>>();
					String kor_nm="";
					
					getSmsCustInfo=sms_dao.getSmsCustInfo(cust_listArray[i],store);
					if (getSmsCustInfo.size() > 0) 
					{
						kor_nm = sms_dao.SmsCust_nm(cust_listArray[i]).get("KOR_NM").toString();
					}
					else
					{
						getSmsCustInfo=sms_dao.getSmsAmstInfo(cust_listArray[i],store);
						kor_nm = sms_dao.Smslecr_nm(cust_listArray[i]).get("CUS_PN").toString();						
					}
					
					if (getSmsCustInfo.size() > 0) 
					{
						message_area = Utils.checkNullString(request.getParameter("message_area"));
				
						
						String phone_no1 = Utils.checkNullString(getSmsCustInfo.get(0).get("H_PHONE_NO_1"));
							   phone_no1 = "82"+""+phone_no1.substring(phone_no1.length()-2, phone_no1.length()); //국제 표준 전화번호 세팅
						String real_phone_no1 = Utils.checkNullString(getSmsCustInfo.get(0).get("H_PHONE_NO_1"));
						String phone_no2 = Utils.checkNullString(getSmsCustInfo.get(0).get("H_PHONE_NO_2"));
						String phone_no3 = Utils.checkNullString(getSmsCustInfo.get(0).get("H_PHONE_NO_3"));
						
						String real_cust_phone_num= real_phone_no1+""+phone_no2+""+phone_no3;
						String cust_phone_num= phone_no1+""+phone_no2+""+phone_no3;
						Boolean phone_chk = common_dao.isVaildCell(real_phone_no1, phone_no2, phone_no3);
	
						message_area=Utils.checkNullString(message_area.replaceAll("\\{memId\\}", Utils.checkNullString(getSmsCustInfo.get(0).get("PTL_ID"))));
						message_area=Utils.checkNullString(message_area.replaceAll("\\{memNm\\}",Utils.checkNullString(getSmsCustInfo.get(0).get("KOR_NM"))));
						message_area=Utils.checkNullString(message_area.replaceAll("\\{groupNm\\}",Utils.checkNullString(getSmsCustInfo.get(0).get("CLASS"))));
						message_area=Utils.checkNullString(message_area.replaceAll("\\{carNb\\}",Utils.checkNullString(getSmsCustInfo.get(0).get("CAR_NO"))));
		
						System.out.println("message_area : "+message_area);
						System.out.println("cust_no : "+cust_listArray[i]);
						System.out.println("kor_nm : "+kor_nm);
						request.setAttribute("cust_phone_num", cust_phone_num);
						
				        request.setAttribute("message", new String(message_area.getBytes("euc-kr"),"euc-kr"));
				        
				        request.setAttribute("title", message_title);
				        
				        request.setAttribute("store_no", sms_sender);
				        
						if (phone_chk!=false)
				        {
							System.out.println("smsSend start******");
							result = common_cr.sendSms(request);		//SMS발송 파트
				        	//result_status="R004";
							System.out.println("smsSend end******");
						}
				        
						
						
						
				        if (result.equals("R000")) 
				        {
				        	result_txt="발송성공";
				        	result="S";
						}
				        else
				        {
				        	if(result.equals("R001")) {result =  "F"; result="일시적 서비스 장애";}
					        else if(result.equals("R002")) {result =  "F"; result_txt="인증 실패";}
					        else if(result.equals("R002")) {result =  "F"; result_txt="수신번호 형식 어류";}
					        else if(result.equals("R007")) {result =  "F"; result_txt="유효하지 않은 파라미터 오류";}
					        else if(result.equals("R009")) {result =  "F"; result_txt="서버 capacity 초과, 재시도 요망";}
					        else if(result.equals("R012")) {result =  "F"; result_txt="해당 서비스 유형 전송 권한 없음";}
					        else if(result.equals("R013")) {result =  "F"; result_txt="발송 가능 건수 초과";}
					        else if(result.equals("R999")) {result =  "F"; result_txt="알려지지 않은 에러";}
					        else if(result.equals("R102")) {result =  "F"; result_txt="유효하지 않은 수신번호";}
					        else if(result.equals("R103")) {result =  "F"; result_txt="네트워크 에러";}
					        else {result_txt="발송실패"; result =  "F"; }
				        }
				        
				        if (phone_chk==false)
				        {
				        	result_txt="발신번호오류";
				        	result="F";
						}
				        
				        
				        sms_dao.insSmsList(store,cust_listArray[i],kor_nm,real_cust_phone_num,sms_sender,Utils.repWord(message_area),reserve_time,create_resi_no,send_type,result,sms_seq,result_txt,period,Utils.repWord(message_title),cont_type);
	
					}
				}		
			}
			//*회원 전송부 end
			
			mav.addObject("isSuc", "success");
			mav.addObject("msg", "발송되었습니다.");
		} 
		catch (Exception e) 
		{
			System.out.println("error : "+e);
			mav.addObject("msg", "통신 ERROR 관리자에게 문의해주세요.");
			mav.addObject("isSuc", "fail");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			
			
		}
		
		return mav;	
		
	}
	
	

	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("/sendMessage")
	@ResponseBody
	public static void getToken(HttpServletRequest request) throws IllegalStateException, IOException, ParseException {
		//token 조회 시작
		URL url = null;
	    HttpURLConnection conn = null;
	    String jsonData = "";
	    BufferedReader br = null;
	    StringBuffer sb = null;
	    String returnText = "";
	    
	    url = new URL("https://auth.supersms.co:7000/auth/v3/token");
        conn = (HttpURLConnection) url.openConnection();
        conn.setRequestProperty("X-IB-Client-Id", "ak_center1b");
        conn.setRequestProperty("X-IB-Client-Passwd", "HR21SMXG691UOMVL10PX");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestMethod("POST");
        conn.connect();
 
        br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
 
        sb = new StringBuffer();
 
        while ((jsonData = br.readLine()) != null) {
            sb.append(jsonData);
        }
 
        returnText = Utils.checkNullString(sb);
        
        JSONParser jsonParse = new JSONParser();
        JSONObject jsonObj = (JSONObject) jsonParse.parse(returnText);
        
        String accessToken = Utils.checkNullString(jsonObj.get("accessToken"));
        String schema = Utils.checkNullString(jsonObj.get("schema"));
        //token 조회 끝
        
        String cus_phone = "821047753790@821066046260@821035076453@";
        String[] cus_list;
        cus_list = cus_phone.split("@");
        for (int i = 0; i < cus_list.length; i++) {
        
        //메세지전송 시작
        url = new URL("https://sms.supersms.co:7020/sms/v3/multiple-destinations");
        
        conn = (HttpURLConnection) url.openConnection();
        conn.setDoOutput(true); //OutputStreamWriter를 쓰려면 이게 있어야합니다.
        conn.setRequestProperty("Authorization", schema+" "+accessToken);
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("content-type", "application/json");
        conn.setRequestMethod("POST");
        

        JSONObject cred = new JSONObject();
        JSONObject to = new JSONObject();
        JSONArray destinations = new JSONArray();
        
	        to.put("to", cus_list[i]);
	        destinations.add(to);
	        cred.put("title","tt");
	        cred.put("from","0317793810");
	        cred.put("text","알려줘");
	        cred.put("destinations",destinations);
	        cred.put("ttl","100");
	        
	        OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
	        wr.write(Utils.checkNullString(cred));
	        wr.flush();
	        conn.connect();
	        br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        sb = new StringBuffer();
	        
	        while ((jsonData = br.readLine()) != null) {
	            sb.append(jsonData);
	        }
	 
	        returnText = Utils.checkNullString(sb);
        
	        jsonObj =  (JSONObject) jsonParse.parse(returnText);
	        System.out.println("*********************************");
	        System.out.println(jsonObj);
	        System.out.println("*********************************");
	        System.out.println("문자보내기 결과 : "+returnText);   
        }
	}
	
	@RequestMapping("/writeTm")
	@ResponseBody
	public HashMap<String, Object> writeTm(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store")); 
		String period = Utils.checkNullString(request.getParameter("period")); 
		String custlist[] = Utils.checkNullString(request.getParameter("custlist")).split("\\|"); 
		String title = Utils.checkNullString(request.getParameter("title")); 
		String purpose = Utils.checkNullString(request.getParameter("purpose")); 
		String lect_cd = Utils.checkNullString(request.getParameter("lect_cd")); 
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		String is_lec = Utils.checkNullString(request.getParameter("is_lec")); 
		String dead_ymd = Utils.checkNullString(request.getParameter("dead_ymd")); 
		
		
		System.out.println("store : "+store);
		System.out.println("period : "+period);
		System.out.println("title : "+title);
		System.out.println("purpose : "+purpose);
		System.out.println("create_resi_no : "+create_resi_no);
		
		try {
			
			int tm_seq =  sms_dao.writeTm(store,period,title,purpose,create_resi_no,lect_cd,is_lec,dead_ymd);
		
			int result=0;
		for (int i = 0; i < custlist.length; i++) {
			result = sms_dao.writeTmList(tm_seq,custlist[i],create_resi_no,store,period);	
			if (result < 1) {
				map.put("isSuc", "fail");
				map.put("msg", "알 수 없는 오류 발생");
				return map;
			}
		}			
		
		
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
		}
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	
	
	
	@RequestMapping("/saveAllPass")
	@ResponseBody
	public HashMap<String, Object> saveAllPass(HttpServletRequest request) {
		
		
		String tm_seq = Utils.checkNullString(request.getParameter("tm_seq")); 
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		int tml_seq =  sms_dao.uptTmlAll(tm_seq);
		if (tml_seq < 1) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "관리자에게 문의해주세요.");
			
		}
		int tm_memo_seq =  sms_dao.uptTmMemoAll(tm_seq);
		if (tml_seq < 1) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "관리자에게 문의해주세요.");
		}
		return map;
	}
	
	@RequestMapping("/delTm")
	@ResponseBody
	public HashMap<String, Object> delTm(HttpServletRequest request) {
		
		
		String store = Utils.checkNullString(request.getParameter("store")); 
		String period = Utils.checkNullString(request.getParameter("period"));
		String[] seq = Utils.checkNullString(request.getParameter("seq")).split("\\|");
		HashMap<String, Object> map = new HashMap<>();
		
		try {
			map.put("isSuc", "success");
			map.put("msg", "저장되었습니다.");
			for (int i = 0; i < seq.length; i++) {
				sms_dao.delTm(store,period,seq[i]);
			
			}
		} catch (Exception e) {
			map.put("isSuc", "fail");
			map.put("msg", "관리자에게 문의해주세요.");
		}
		return map;
	}
	

	@RequestMapping("/recentCustList")
	@ResponseBody
	public List<HashMap<String, Object>> recentCustList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		
		List<HashMap<String, Object>> list = sms_dao.recentCustList(store);
		
		
		return list;
	}
}