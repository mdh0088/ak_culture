package ak_culture.controller.basic;

import java.util.Arrays;
import java.util.Collections;
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
import ak_culture.model.basic.EncdDAO;
import ak_culture.model.basic.GiftDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.member.CustDAO;

@Controller
@RequestMapping("/basic/gift/*")


public class GiftController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	

	@Autowired
	private EncdDAO encd_dao;
	
	@Autowired
	private GiftDAO gift_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private CustDAO cust_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/gift/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/getGiftlist")
	@ResponseBody
	public HashMap<String, Object> getGiftlist(HttpServletRequest request) {
		//ModelAndView mav = new ModelAndView();
		//mav.setViewName("/WEB-INF/pages/basic/gift/listed");
		//Utils.setPeriController(mav, common_dao);
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_day"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_day"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String gift_status = Utils.checkNullString(request.getParameter("gift_status"));
		String gift_fg = Utils.checkNullString(request.getParameter("gift_fg"));
		String gift_cd = Utils.checkNullString(request.getParameter("gift_cd"));
			
		List<HashMap<String, Object>> listCnt = gift_dao.getGiftCustCount(store,period,start_ymd,end_ymd,search_type,search_name,gift_status,gift_fg,gift_cd);
		List<HashMap<String, Object>> listCnt_all = gift_dao.getGiftCustCount(store,period,"","","","","","","");
		
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
		
		
		int block=5;
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
		System.out.println(listSize);
		System.out.println(s_page);
		System.out.println(page);
		
		List<HashMap<String, Object>> list = gift_dao.getCustGiftList(store,period,start_ymd,end_ymd,search_type,search_name,gift_status,gift_fg,gift_cd, s_point, listSize*page, order_by, sort_type); 

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
		//map.put("listSize", listSize);
		
		return map;
	}

	@RequestMapping("/listed")
	public ModelAndView listed(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/gift/listed");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/getGiftlisted")
	@ResponseBody
	public HashMap<String, Object> getGiftlisted(HttpServletRequest request) {
		//ModelAndView mav = new ModelAndView();
		//mav.setViewName("/WEB-INF/pages/basic/gift/listed");
		//Utils.setPeriController(mav, common_dao);
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		//search_start search_end gubun code_fg
		String store  = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_start = Utils.checkNullString(request.getParameter("start_day"));
		String search_end = Utils.checkNullString(request.getParameter("end_day"));
		String gubun = Utils.checkNullString(request.getParameter("gubun"));
		String gift_fg = Utils.checkNullString(request.getParameter("gift_fg"));
		
		
		List<HashMap<String, Object>> listCnt = gift_dao.getGiftCount(store,period,search_start,search_end,gubun,gift_fg);
		List<HashMap<String, Object>> listCnt_all = gift_dao.getGiftCount(store,period,"","","","");
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
		
		
		int block=5;
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
		
		List<HashMap<String, Object>> list = gift_dao.getGiftList(store,period,search_start,search_end,gubun,gift_fg, s_point, listSize*page, order_by, sort_type); 
		
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
	
	@Transactional
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/gift/write");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		//listed 페이지에서 가져오는 매개변수들
		String store = Utils.checkNullString(request.getParameter("store"));
		String gift_year = Utils.checkNullString(request.getParameter("year"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String gift_cd = Utils.checkNullString(request.getParameter("gift_cd"));
		
		if (!store.equals("") && !period.equals("") && !gift_cd.equals("")) {
			List<HashMap<String, Object>> getGiftInfo = gift_dao.getGiftInfo(store,period,gift_cd,"");
			mav.addObject("store", store);
			mav.addObject("gift_year", gift_year);
			mav.addObject("period", period);
			mav.addObject("gift_cd", gift_cd);
			mav.addObject("isChk", true);
			
			if (getGiftInfo.size() > 0)  
			{
				mav.addObject("gift_fg", getGiftInfo.get(0).get("GIFT_FG"));
				mav.addObject("gift_nm", getGiftInfo.get(0).get("GIFT_NM"));
			}
			
		}
		
		String season = Utils.checkNullString(request.getParameter("season"));
		String season_nm="";
		if (season.equals("1")) 
		{
			season_nm="봄학기";
		}
		else if(season.equals("2"))
		{
			season_nm="여름학기";
		}
		else if(season.equals("3"))
		{
			season_nm="가을학기";
		}
		else if(season.equals("4"))
		{
			season_nm="겨울학기";
		}
		mav.addObject("season_nm", season_nm);
		
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		Utils.setPeriController(mav, common_dao, session);
		
		List<HashMap<String, Object>> si_list = cust_dao.getAddr_si();
		mav.addObject("si_list", si_list);
		
		//String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		return mav;
	}
	
	@Transactional
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/basic/gift/write_proc");
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String chk_new = Utils.checkNullString(request.getParameter("chk_new"));
		String gift_cd = Utils.checkNullString(request.getParameter("gift_cd"));
		String gift_fg = Utils.checkNullString(request.getParameter("gift_fg"));
		String new_gift_nm = Utils.checkNullString(request.getParameter("new_gift_nm"));
		String gift_price = Utils.checkNullString(request.getParameter("gift_price"));
		String give_fg = Utils.checkNullString(request.getParameter("give_fg"));
		String con1_subject_fg_a = Utils.checkNullString(request.getParameter("con1_subject_fg_a"));
		String con1_subject_fg_b = Utils.checkNullString(request.getParameter("con1_subject_fg_b"));
		String con1_subject_fg_c = Utils.checkNullString(request.getParameter("con1_subject_fg_c"));
		String cust_fg = Utils.checkNullString(request.getParameter("cust_fg"));
		
		int lect_cnt = 0;
		if(!"".equals(Utils.checkNullString(request.getParameter("lect_cnt"))))
		{
			lect_cnt = Integer.parseInt(Utils.checkNullString(request.getParameter("lect_cnt")));
		}
		
		int semester_cnt = 0;
		if(!"".equals(Utils.checkNullString(request.getParameter("semester_cnt"))))
		{
			semester_cnt = Integer.parseInt(Utils.checkNullString(request.getParameter("semester_cnt")));
		}
		
		String give_type = Utils.checkNullString(request.getParameter("give_type"));
		String gift_date_yn = Utils.checkNullString(request.getParameter("gift_date_yn"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		String accept_type = Utils.checkNullString(request.getParameter("accept_type"));
		String gift_cnt_t = Utils.checkNullString(request.getParameter("gift_cnt_t"));
		String gift_cnt_w = Utils.checkNullString(request.getParameter("gift_cnt_w"));
		String gift_cnt_m = Utils.checkNullString(request.getParameter("gift_cnt_m"));
		String gift_cnt_d = Utils.checkNullString(request.getParameter("gift_cnt_d"));
		String return_fg = Utils.checkNullString(request.getParameter("return_fg"));
		String custList = Utils.checkNullString(request.getParameter("custList"));
		String choose_val = Utils.checkNullString(request.getParameter("choose_val"));
		String pos_no ="";
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		try {
			if (chk_new.equals("on")) //신규 chk를 했다면 insert
			{
				List<HashMap<String, Object>> getGiftInfo = gift_dao.getGiftInfo(store,period,"",new_gift_nm);
				if (getGiftInfo.size()==0)  //검색값이 없다면 유효성 통과
				{ 
					gift_cd = Utils.checkNullString(gift_dao.getNewGiftCode(store,period).get(0).get("GIFT_CD")); //새로 생성된 할인코드 세팅
					System.out.println("insert");
					System.out.println("new gift_cd :"+gift_cd);
					
					gift_dao.insGiftM(	store,				period,				gift_fg,
										gift_price,			gift_cd,			start_ymd,
										end_ymd,			gift_cnt_w,			gift_cnt_m,
										gift_cnt_d,			return_fg,			create_resi_no,
										gift_cnt_t,			new_gift_nm,		give_type,
										give_fg);
				}
				else
				{
					
					mav.addObject("isSuc", "fail");
					mav.addObject("msg", "중복된 코드명입니다.");
					return mav;
					
				}
			}
			else 
			{
				System.out.println("update");
				gift_dao.updateGiftM(	store,					period,				    gift_cd,
										gift_price,				gift_date_yn,			start_ymd,
										end_ymd,				accept_type,			gift_cnt_t,
										gift_cnt_w,				gift_cnt_m,				gift_cnt_d,
										return_fg,				create_resi_no,			give_type,
										give_fg);
			}
			
			if (!custList.equals("")) //세팅한 회원 리스트를 insert해주는 부분
			{
				String[] cust_arr = custList.split("\\|");
				System.out.println("give_type : "+give_type);
				
				if (give_type.equals("2"))  //지급방식이 무작위 라면
				{	
					Collections.shuffle(Arrays.asList(cust_arr));
				}
		
				String dupl_cust_list ="";
				System.out.println("custList : "+custList);
				System.out.println("cust_arr.length : "+cust_arr.length);
				if (cust_arr.length>0) 
				{	
					for (int i = 0; i < cust_arr.length; i++) 
					{
						
						int left_cnt = gift_dao.chk_left_cnt(store,period,gift_cd);
						if (left_cnt<=0) 
						{
							mav.addObject("isSuc", "fail");
							mav.addObject("msg", "남은 사은품이 없습니다.");
							return mav;
						}
						
						int result = Utils.checkNullInt(gift_dao.gift_dupl_chk(store,period,cust_arr[i],gift_cd).get("CNT"));
						if (result>0) //이미 지급된 적이 있다면 
						{ 
							dupl_cust_list =dupl_cust_list+""+cust_arr[i]+"\\n";
							System.out.println("지급됨");
							mav.addObject("isSuc", "fail");
							mav.addObject("msg", "이미 지급된 회원이 있습니다. \\n ********회원번호******** \\n"+dupl_cust_list);
						}
						else 
						{
							System.out.println("안됨");
							pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
							
							gift_dao.insGift(store,period,cust_arr[i],gift_cd,create_resi_no,pos_no);
						}
						
					}
				}
				
			}
			
			if (give_fg.equals("G"))  //지급대상이 고객등급별이면 custList 새로 세팅
			{
				System.out.println("grade : "+choose_val);
				String subject_fg = "";
				
				if (!con1_subject_fg_a.equals("")) 
				{
					subject_fg +=con1_subject_fg_a+"|";
				}
				if(!con1_subject_fg_b.equals(""))
				{
					subject_fg +=con1_subject_fg_b+"|";
				}
				if(!con1_subject_fg_c.equals(""))
				{
					subject_fg +=con1_subject_fg_c+"|";
				}
				//고객등급 chk시 저장값 세팅
				gift_dao.uptGiftMForGrade(store,period,gift_cd,subject_fg,cust_fg,lect_cnt,semester_cnt,choose_val);
				
				/*
				//custList = Utils.checkNullString( encd_dao.getCustList(store,period,con1_subject_fg_a,con1_subject_fg_b,con1_subject_fg_c,cust_fg,lect_cnt,semester_cnt,choose_val).get(0).get("CUST_NO"));
				if (custList.equals("X")) 
				{
					//mav.addObject("msg", "검색된 회원이 없습니다.");
					//return mav;
				}
				*/
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		
		
		return mav;
	}
	
	@RequestMapping("/give")
	public ModelAndView give(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/gift/give");
		
		
		return mav;
	}

	@RequestMapping("/changeGift")
	@ResponseBody
	public List<HashMap<String, Object>> changeGift(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String gift_fg = Utils.checkNullString(request.getParameter("gift_fg"));
		
		
		List<HashMap<String, Object>> list = gift_dao.changeGift(store,period,gift_fg);
		
	    return list;
	}

	@RequestMapping("/getGiftInfo")
	@ResponseBody
	public List<HashMap<String, Object>> getGiftInfo(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String gift_cd = Utils.checkNullString(request.getParameter("gift_cd"));
		List<HashMap<String, Object>> list = gift_dao.getGiftInfo(store,period,gift_cd,"");
		
	    return list;
	}

	@RequestMapping("/updateContent")
	@ResponseBody
	public HashMap<String, Object> updateContent(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String gift_cd = Utils.checkNullString(request.getParameter("gift_cd"));
		String contents = Utils.checkNullString(request.getParameter("contents"));
		
		try {
			int result = gift_dao.updateContent(store,period,cust_no,gift_cd,contents);
			if (result < 1) {
				map.put("isSuc", "fail");
				map.put("msg", "알 수 없는 오류 발생");
			}
			
			map.put("isSuc", "success");
			map.put("msg", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
		}
		
        return map;
	}
	
	
	@Transactional
	@RequestMapping("/endAction")
	@ResponseBody
	public HashMap<String, Object> endAction(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		String act = Utils.checkNullString(request.getParameter("act"));
		String arr[] = chkList.split("\\|");
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		HttpSession session = request.getSession();
		
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		
		int result =0;
		
		try {
			for(int i = 0; i < arr.length; i++)
			{
				String cust_no = arr[i].split("_")[0];
				String gift_cd = arr[i].split("_")[1];
				
				HashMap<String, Object> tot_data = gift_dao.getTotCnt(store,period,gift_cd);
				HashMap<String, Object> give_data = gift_dao.getGiveCnt(store,period,gift_cd);
				
				int tot_cnt = Integer.parseInt(tot_data.get("GIFT_CNT_T").toString());
				int give_cnt = Integer.parseInt(give_data.get("CNT").toString());
				
				System.out.println("tot_cnt : "+tot_cnt);
				System.out.println("give_cnt : "+give_cnt);
				
				if ( (give_cnt == tot_cnt) && act.equals("1")) 
				{
					map.put("isSuc", "fail");
					map.put("msg", "지급 가능한 사은품 수를 초과했습니다.");
					return map;
				}
				
				result = gift_dao.upGiftEnd(store,period,act,cust_no,gift_cd,pos_no,create_resi_no);
				if (result < 1)
				{
					map.put("isSuc", "fail");
					map.put("msg", "알 수 없는 오류 발생");
					return map;
				}
			}
			map.put("isSuc", "success");
			map.put("msg", "저장되었습니다.");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}

		return map;
		
	}
	@Transactional
	@RequestMapping("/delGift")
	@ResponseBody
	public HashMap<String, Object> delGift(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String gift_cd[] = Utils.checkNullString(request.getParameter("gift_cd")).split("\\|");
		int result=0;
		
		try {
			
			for(int i = 0; i < gift_cd.length; i++)
			{
				result = gift_dao.delGift(gift_cd[i]);	
				if (result < 1) {
					map.put("isSuc", "fail");
					map.put("msg", "알 수 없는 오류 발생");
					return map;
				}
			}
			
			map.put("isSuc", "success");
			map.put("msg", "저장되었습니다.");
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		return map;
	}
	
	
}