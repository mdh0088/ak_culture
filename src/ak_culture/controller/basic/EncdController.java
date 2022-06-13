package ak_culture.controller.basic;

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
@RequestMapping("/basic/encd/*")

public class EncdController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private GiftDAO gift_dao;
	
	@Autowired
	private EncdDAO encd_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private CustDAO cust_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/encd/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		
		return mav;
	}
	
	@RequestMapping("/listed")
	public ModelAndView listed(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/encd/listed");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/getEncdlist")
	@ResponseBody
	public HashMap<String, Object> getEncdlist(HttpServletRequest request) {
		//ModelAndView mav = new ModelAndView();
		//mav.setViewName("/WEB-INF/pages/basic/gift/listed");
		//Utils.setPeriController(mav, common_dao);
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_con = Utils.checkNullString(request.getParameter("search_con"));
		String start_day = Utils.checkNullString(request.getParameter("start_day"));
		String end_day = Utils.checkNullString(request.getParameter("end_day"));
		String cust_fg = Utils.checkNullString(request.getParameter("cust_fg"));
		String encd_list = Utils.checkNullString(request.getParameter("encd_list"));
		
		List<HashMap<String, Object>> listCnt = encd_dao.getEncdCount(store,period,search_name,search_con,start_day,end_day,cust_fg,encd_list);
		List<HashMap<String, Object>> listCnt_all = encd_dao.getEncdCount(store,period,"","","","","","");
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
		
		List<HashMap<String, Object>> list = encd_dao.getEncd(store,period,search_name,search_con,start_day,end_day,
														cust_fg,encd_list, s_point, listSize*page, order_by, sort_type); 
		
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
	
	
	@RequestMapping("/getBfEncdList")
	@ResponseBody
	public HashMap<String, Object> getBfEncdList(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();

		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));

	
		

		List<HashMap<String, Object>> Bfperi = encd_dao.getBfperi(store,period);
		int cnt = Utils.checkNullInt(Bfperi.get(0).get("CNT"));
		if (cnt > 0) 
		{
			int result = encd_dao.insPreEncd(store,period);
			if (result > 0) 
			{
				map.put("isSuc", "success");
				map.put("msg", "불러오기가 완료되었습니다.");				
			}
			else
			{
				map.put("isSuc", "fail");
				map.put("msg", "알 수 없는 오류 발생 관리자에게 문의주세요.");
			}
			//List<HashMap<String, Object>> list = encd_dao.getBfperi(store,period);
		}
		else
		{
			
			map.put("isSuc", "fail");
			map.put("msg", "불러올 할인권이 없습니다.");
		}

		
		return map;
	}
	
	

	
	@RequestMapping("/getEncdlisted")
	@ResponseBody
	public HashMap<String, Object> getEncdlisted(HttpServletRequest request) {
		//ModelAndView mav = new ModelAndView();
		//mav.setViewName("/WEB-INF/pages/basic/gift/listed");
		//Utils.setPeriController(mav, common_dao);
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		
		
		List<HashMap<String, Object>> listCnt = encd_dao.getEncdListCount(store,period);
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
		
		List<HashMap<String, Object>> list = encd_dao.getEncdList(store,period,s_point, listSize*page, order_by, sort_type); 
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		
		return map;
	}
	
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/encd/write");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		
		
		//listed 페이지에서 가져오는 매개변수들
		String store = Utils.checkNullString(request.getParameter("store"));
		String enuri_year = Utils.checkNullString(request.getParameter("year"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String enuri_cd = Utils.checkNullString(request.getParameter("enuri_cd"));
		
		if (!store.equals("")) {
			
			List<HashMap<String, Object>> getEncdInfo = encd_dao.getEncdInfo(store,period,enuri_cd,"");
			
			mav.addObject("store", store);
			mav.addObject("enuri_year", enuri_year);
			mav.addObject("period", period);
			mav.addObject("enuri_cd", enuri_cd);
			
			
			if (getEncdInfo.size() > 0)  
			{	
				mav.addObject("enuri_nm", getEncdInfo.get(0).get("ENURI_NM"));
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
		}
		mav.addObject("isChk", true);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		Utils.setPeriController(mav, common_dao, session);		
		
		List<HashMap<String, Object>> si_list = cust_dao.getAddr_si();
		mav.addObject("si_list", si_list);
		
//		List<HashMap<String, Object>> EncdbranchList = encd_dao.getBranchList();
//		mav.addObject("EncdbranchList", EncdbranchList);

//		HttpSession session = request.getSession();
//		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		
		return mav;
	}
	
	@Transactional
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/basic/encd/write_proc");
		mav.addObject("msg", "저장 되었습니다.");
		mav.addObject("isSuc", "success");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		String chk_new = Utils.checkNullString(request.getParameter("chk_new"));
		String enuri_cd = Utils.checkNullString(request.getParameter("enuri_cd"));
		
		String new_encd_nm = Utils.checkNullString(request.getParameter("new_encd_nm"));
		String give_fg = Utils.checkNullString(request.getParameter("give_fg")); //고객대상, 대상자지정 구분자
		String custList = Utils.checkNullString(request.getParameter("custList"));
		String choose_val = Utils.checkNullString(request.getParameter("choose_val"));
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
		
		String lect_type = Utils.checkNullString(request.getParameter("lect_type"));
		String lect_main_cd = Utils.checkNullString(request.getParameter("lect_main_cd"));
		String lect_sect_cd = Utils.checkNullString(request.getParameter("lect_sect_cd"));
		String lect_subject_cd = Utils.checkNullString(request.getParameter("lect_subject_cd"));
		String dis_period_start = Utils.checkNullString(request.getParameter("dis_period_start"));
		String dis_period_end = Utils.checkNullString(request.getParameter("dis_period_end"));
		
		String encd_fg = Utils.checkNullString(request.getParameter("encd_fg"));
		String enuri = Utils.checkNullString(request.getParameter("enuri")).replaceAll(",", "");
		//String enuri = Utils.checkNullString(request.getParameter("enuri"));
		System.out.println("enuri : "+enuri);
		String encd_limit_pay = Utils.checkNullString(request.getParameter("encd_limit_pay")).replaceAll(",", "");
		//String encd_limit_pay = Utils.checkNullString(request.getParameter("encd_limit_pay"));
		System.out.println("encd_limit_pay : "+encd_limit_pay);
		
		String encd_limit_cnt = Utils.checkNullString(request.getParameter("encd_limit_cnt"));
		String fee_yn = Utils.checkNullString(request.getParameter("fee_yn"));
		String dupl_yn = Utils.checkNullString(request.getParameter("dupl_yn"));

		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		
		
		try {
			if (chk_new.equals("on")) //신규 chk를 했다면 insert
			{ 
				List<HashMap<String, Object>> getEncdInfo = encd_dao.getEncdInfo(store,period,"",new_encd_nm);
				if (getEncdInfo.size()==0)  //검색값이 없다면 유효성 통과
				{
					enuri_cd = Utils.checkNullString(encd_dao.getNewDisCode(store,period).get(0).get("ENURI_CD")); //새로 생성된 할인코드 세팅
					
					System.out.println("insert");
					System.out.println("new enuri_cd :"+enuri_cd);
					
					encd_dao.insEncdM(		store,				enuri_cd,				encd_fg,
											enuri,				new_encd_nm,			encd_limit_pay,
											create_resi_no,		encd_limit_cnt,			dis_period_start,
											fee_yn,				dupl_yn,				dis_period_end,
											period,				lect_type,				lect_main_cd,
											lect_sect_cd,		lect_subject_cd,		give_fg);
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
				encd_dao.updateEncdM(	store,					period,				    enuri_cd,
										lect_type,				lect_main_cd,			lect_sect_cd,
										lect_subject_cd,		dis_period_start,		dis_period_end,
										enuri,					encd_limit_pay,			encd_limit_cnt,
										dupl_yn,				fee_yn,					create_resi_no,
										encd_fg,				give_fg);
			}
			
			
			
			if (!custList.equals("") && !custList.equals("X"))  //세팅한 회원 리스트를 insert해주는 부분
			{
				String[] cust_arr = custList.split("\\|");
				String dupl_cust_list ="";
				if (cust_arr.length>0) 
				{
					for (int i = 0; i < cust_arr.length; i++) 
					{
						int result = Utils.checkNullInt(encd_dao.encd_dupl_chk(store,period,cust_arr[i],enuri_cd).get("CNT"));
						if (result>0) 
						{ //이미 지급된 적이 있다면 
							dupl_cust_list =dupl_cust_list+""+cust_arr[i]+"\\n";
							System.out.println("지급딤");
							mav.addObject("isSuc", "fail");
							mav.addObject("msg", "이미 지급된 회원이 있습니다. \\n ********회원번호******** \\n"+dupl_cust_list);
						}
						else 
						{
							System.out.println("안됨");
							encd_dao.insEncd(store,period,enuri_cd,create_resi_no,cust_arr[i]);
						}
						
					}
				}
			}
			
	
			if (give_fg.equals("G")) //지급대상이 고객등급별이면 custList 새로 세팅
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
				System.out.println("semester_cnt :"+semester_cnt);
				
				encd_dao.uptEncdMForGrade(store,period,enuri_cd,subject_fg,cust_fg,lect_cnt,semester_cnt,choose_val);
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		} 
		
		

		return mav;
	}
	
	@RequestMapping("/getEncdCode")
	@ResponseBody
	public List<HashMap<String, Object>> getEncdCode(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		
		List<HashMap<String, Object>> list = encd_dao.getEncdCode(store,period);
		
	    return list;
	}
	
	@RequestMapping("/getEncdInfo")
	@ResponseBody
	public List<HashMap<String, Object>> getEncdInfo(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String enuri_cd = Utils.checkNullString(request.getParameter("enuri_cd"));
		
		List<HashMap<String, Object>> list = encd_dao.getEncdInfo(store,period,enuri_cd,"");
		
	    return list;
	}
	
	@RequestMapping("/getEncdListByList")
	@ResponseBody
	public List<HashMap<String, Object>> getEncdListByList(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		List<HashMap<String, Object>> list = encd_dao.getEncdListByList(store,period);
		
	    return list;
	}
	@Transactional
	@RequestMapping("/delEncd")
	@ResponseBody
	public HashMap<String, Object> delEncd(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();

		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String enuri_cd[] = Utils.checkNullString(request.getParameter("enuri_cd")).split("\\|");
		int result=0;
		
		try {
			
			for(int i = 0; i < enuri_cd.length; i++)
			{
				result = encd_dao.delEncd(store,period,enuri_cd[i]);			
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