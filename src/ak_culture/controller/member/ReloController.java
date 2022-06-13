package ak_culture.controller.member;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.Utils;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.lecture.LectDAO;
import ak_culture.model.member.ReloDAO;
import ak_culture.model.member.SmsDAO;

@Controller
@RequestMapping("/member/relo/*")

public class ReloController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private ReloDAO relo_dao;
	@Autowired
	private LectDAO lect_dao;
	
	@Autowired
	private SmsDAO sms_dao;
	
	@Autowired
	private ak_culture.model.member.LectDAO m_lect_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/member/relo/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		List<HashMap<String, Object>> listCnt = relo_dao.getLemvCount(search_name);
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
		
		List<HashMap<String, Object>> list = relo_dao.getLemv(search_name, s_point, listSize*page, order_by, sort_type); 
		
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
	@RequestMapping("/getReloUser")
	@ResponseBody
	public List<HashMap<String, Object>> getReloUser(HttpServletRequest request) {
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_phone = Utils.checkNullString(request.getParameter("search_phone"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		List<HashMap<String, Object>> list = relo_dao.getReloUser(search_name, search_phone, order_by, sort_type); 
		
		return list;
	}
	@RequestMapping("/getReloUserPere")
	@ResponseBody
	public List<HashMap<String, Object>> getReloUserPere(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		
		List<HashMap<String, Object>> list = relo_dao.getReloUserPere(store, period, cust_no); 
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "이강신청 회원 조회", store+"/"+period+"/"+cust_no);

		return list;
	}
	@RequestMapping("/getSamePriceLect")
	@ResponseBody
	public List<HashMap<String, Object>> getSamePriceLect(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd); 
		
		int regis_fee = Utils.checkNullInt(list.get(0).get("REGIS_FEE"));
		int food_amt = 0;
		String food_yn = Utils.checkNullString(list.get(0).get("FOOD_YN"));
		if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
		{
			food_amt = Utils.checkNullInt(list.get(0).get("FOOD_AMT"));
		}
		
		List<HashMap<String, Object>> list_relo = relo_dao.getSamePriceLect(store, period, subject_cd, food_yn, regis_fee, food_amt); 
		
		
		return list_relo;
	}
	@RequestMapping("/movePelt")
	@ResponseBody
	public HashMap<String, Object> movePelt(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String ori_child_no = Utils.checkNullString(request.getParameter("ori_child_no")); //원래 수강자
		String child1_no = Utils.checkNullString(request.getParameter("child1_no"));
		if("".equals(child1_no)) {child1_no = "0";}
		String child2_no = Utils.checkNullString(request.getParameter("child2_no"));
		if("".equals(child2_no)) {child2_no = "0";}
		String prev_subject_cd = Utils.checkNullString(request.getParameter("prev_subject_cd"));
		String next_subject_cd = Utils.checkNullString(request.getParameter("next_subject_cd"));
		
		System.out.println("prev no : "+prev_subject_cd);
		System.out.println("next no : "+next_subject_cd);
		
		
		List<HashMap<String, Object>> prev_list = lect_dao.getPeltMid(store, period, prev_subject_cd);
		List<HashMap<String, Object>> next_list = lect_dao.getPeltMid(store, period, next_subject_cd);
		
		String main_cd = Utils.checkNullString(next_list.get(0).get("MAIN_CD"));
		String sect_cd = Utils.checkNullString(next_list.get(0).get("SECT_CD"));
		
		
		List<HashMap<String, Object>> list = relo_dao.getReloUserPereSubject(store, period, cust_no, prev_subject_cd, ori_child_no);
		
		int person1 = 0;
		
		if("1".equals(Utils.checkNullString(prev_list.get(0).get("MAIN_CD"))))
		{
			person1 = 1;
		}
		else if("2".equals(Utils.checkNullString(prev_list.get(0).get("MAIN_CD"))))
		{
			if(!"".equals(Utils.checkNullString(list.get(0).get("CHILD_NO1")).trim()) && !"0".equals(Utils.checkNullString(list.get(0).get("CHILD_NO1")).trim()))
			{
				person1 = 3;
			}
			else
			{
				person1 = 2;
			}
		}
		else if("3".equals(Utils.checkNullString(prev_list.get(0).get("MAIN_CD"))))
		{
			if("Y".equals(Utils.checkNullString(prev_list.get(0).get("IS_TWO"))))
			{
				person1 = 2;
			}
			else
			{
				person1 = 1;
			}
		}
		else if("4".equals(Utils.checkNullString(prev_list.get(0).get("MAIN_CD"))))
		{
			person1 = 1;
		}
		
		
		
		int person2 = 0;
		
		if("1".equals(Utils.checkNullString(next_list.get(0).get("MAIN_CD"))))
		{
			person2 = 1;
		}
		else if("2".equals(Utils.checkNullString(next_list.get(0).get("MAIN_CD"))))
		{
			if(!"".equals(child2_no.trim()) && !"0".equals(child2_no.trim()))
			{
				person2 = 3;
			}
			else
			{
				person2 = 2;
			}
		}
		else if("3".equals(Utils.checkNullString(next_list.get(0).get("MAIN_CD"))))
		{
			if("Y".equals(Utils.checkNullString(next_list.get(0).get("IS_TWO"))))
			{
				person2 = 2;
			}
			else
			{
				person2 = 1;
			}
		}
		else if("4".equals(Utils.checkNullString(next_list.get(0).get("MAIN_CD"))))
		{
			person2 = 1;
		}
		
		if("2".equals(Utils.checkNullString(prev_list.get(0).get("MAIN_CD"))) || "2".equals(Utils.checkNullString(next_list.get(0).get("MAIN_CD"))))
		{
			if((person1 == 3 && person2 != 3) || (person1 != 3 && person2 == 3))
			{
				System.out.println("person1 : "+person1);
				System.out.println("person2 : "+person2);
				map.put("isSuc", "fail");
				map.put("msg", "3인수강 강좌는 3인수강으로만 변경 가능합니다.");
				return map;
			}
		}
		
		m_lect_dao.upPeltRegis_down("070003", store, period, prev_subject_cd, person1); //070003으로 박아놔도됨. 데스크라는것만 표시하면됨.
		relo_dao.movePelt(store, period, cust_no, prev_subject_cd, next_subject_cd, main_cd, sect_cd, ori_child_no, child1_no, child2_no);
		m_lect_dao.upWait(store, period, next_subject_cd, cust_no, child1_no); //대기자 명단 등록으로 변경
		m_lect_dao.upPeltRegis(store, period, next_subject_cd, person2);
		
		list = relo_dao.getReloUserPereSubject(store, period, cust_no, next_subject_cd, child1_no);
		
		for(int i = 0; i < list.size(); i++)
		{
			String recpt_no = Utils.checkNullString(list.get(i).get("RECPT_NO"));
			String sale_ymd = Utils.checkNullString(list.get(i).get("SALE_YMD"));
			String pos_no = Utils.checkNullString(list.get(i).get("POS_NO"));
			relo_dao.upTrde(store, recpt_no, sale_ymd, pos_no, prev_subject_cd, next_subject_cd);
			if("070013".equals(pos_no) || "070014".equals(pos_no))
			{
				String pos_type = "";
				if("070013".equals(pos_no))
				{
					pos_type = "W";
				}
				else
				{
					pos_type = "M";
				}
				relo_dao.upWbtr(store, recpt_no, sale_ymd, pos_type, prev_subject_cd, next_subject_cd);
			}
		}
		
		
		
		
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		relo_dao.insLemv(store, period, cust_no, prev_subject_cd, next_subject_cd, login_seq);
		

		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "이강 신청", store+"/"+period+"/"+cust_no+"/"+prev_subject_cd+">"+next_subject_cd);

		//지금 듣고 있는 강좌의 출석 정보
		//HashMap<String, Object> prev_attend_data = m_lect_dao.getCustAttendInfo(store,period,prev_subject_cd,cust_no);

		//이전할 강좌의 출석정보
		HashMap<String, Object> next_attend_data = m_lect_dao.getAttendInfo(store,period,next_subject_cd);
		
		
		if (next_attend_data!=null) 
		{
			String dayChk[] = Utils.checkNullString(next_attend_data.get("DAY_CHK")).split("\\|");
			String dayVal ="";
			for (int j = 0; j < dayChk.length; j++) 
				
			{
				System.out.println("dayChk : "+dayChk[j]);
				dayVal+="X|";
			}
			System.out.println("dayVal : "+dayVal);
			//이강 강좌 출석부 생성
			//lect_dao.insAttend(store,period,subject_cd[i], login_seq,"N",cust_no,dayVal, p_cust, c_cust1, c_cust2);
			//HashMap<String, Object> chk_cust_in_attend = m_lect_dao.ChkCustInAttend(store,period,prev_subject_cd,login_seq);
			//if (Integer.parseInt(chk_cust_in_attend.get("CNT").toString()) < 1) {
				//이강 강좌 출석부 생성
			//	m_lect_dao.insAttend(store,period,prev_subject_cd,login_seq,"N",cust_no,dayVal);
			//}
			//m_lect_dao.uptCustAttendInfo(store,period,prev_subject_cd,next_subject_cd,cust_no,dayVal);
		}
		
		
	
		
		/*
		String tm_seq ="";
		String act ="3";
		List<HashMap<String, Object>> getTmSeq = sms_dao.getTmSeq();
		tm_seq = getTmSeq.get(0).get("TM_SEQ").toString();
		
		int seq = sms_dao.insTm(store, period,next_subject_cd,act,login_seq);
		sms_dao.insTmList(seq,cust_no);
		*/
		
		
		
		
		
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
        return map;
		
	}
	
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/relo/view");
		
		return mav;
	}
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/relo/write");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		return mav;
	}
	@RequestMapping("/getPeltInfo")
	@ResponseBody
	public List<HashMap<String, Object>> getPeltInfo(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		List<HashMap<String, Object>> list = lect_dao.getPeltMid(store, period, subject_cd);
		
		return list;
	}
}