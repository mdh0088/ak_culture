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
import ak_culture.model.member.WaitDAO;

@Controller
@RequestMapping("/member/wait/*")

public class WaitController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private WaitDAO wait_dao;
	@Autowired
	private CommonDAO common_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/member/wait/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		String search_name = Utils.checkNullString(request.getParameter("search_name"));
//		
//		String store = Utils.checkNullString(request.getParameter("selBranch"));
//		String period = Utils.checkNullString(request.getParameter("selPeri"));
//		
//		List<HashMap<String, Object>> listCnt = wait_dao.getWaitCount(search_name, store, period);
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
//		List<HashMap<String, Object>> list = wait_dao.getWait(search_name, s_point, listSize*page, order_by, sort_type, store, period); 
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
		return mav;
	}
	@RequestMapping("/getWaitLectList")
	@ResponseBody
	public HashMap<String, Object> getWaitLectList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start"));
		String search_end = Utils.checkNullString(request.getParameter("search_end"));
		search_start = search_start.replaceAll("-","");
		search_end = search_end.replaceAll("-","");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		
		List<HashMap<String, Object>> listCnt = wait_dao.getWaitCount(search_type, search_name, store, period, main_cd, sect_cd, search_start, search_end);
		List<HashMap<String, Object>> listCnt_all = wait_dao.getWaitCount("", "", store, period, "", "", "", "");
		int listCount = listCnt.size(); //group by 때문에 얘만 다름
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
		
		List<HashMap<String, Object>> list = wait_dao.getWait(s_point, listSize*page, order_by, sort_type, search_type, search_name, store, period, main_cd, sect_cd, search_start, search_end); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.size());
		map.put("listCnt_all", listCnt_all.size());
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "대기자관리 조회", store+"/"+period);

		return map;
	}
	@RequestMapping("/waitCancle")
	@ResponseBody
	public HashMap<String, Object> waitCancle(HttpServletRequest request) {
		
		String chkList[] = Utils.checkNullString(request.getParameter("chkList")).split("\\|");
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		for(int i = 0; i < chkList.length; i++)
		{
			System.out.println(chkList[i]);
			String cust_no = chkList[i].split("_")[0];
			String store = chkList[i].split("_")[1];
			String period = chkList[i].split("_")[2];
			String subject_cd = chkList[i].split("_")[3];
			
			
			wait_dao.waitCancle(cust_no, store, period, subject_cd, login_seq);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "대기 취소", store+"/"+period+"/"+subject_cd+"/"+cust_no);

		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
	}
	@RequestMapping("/insComment")
	@ResponseBody
	public HashMap<String, Object> insComment(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String comment = Utils.repWord(Utils.checkNullString(request.getParameter("comment")));
		wait_dao.insComment(store, period, subject_cd, cust_no, comment);
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
	}
	@RequestMapping("/getWaiter")
	@ResponseBody
	public List<HashMap<String, Object>> getWaiter(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		List<HashMap<String, Object>> list = wait_dao.getWaiter(store, period, subject_cd); 
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "대기자 상세 조회", store+"/"+period+"/"+subject_cd);

		
		return list;
	}
	
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/wait/view");
		
		return mav;
	}
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/wait/write");
		
		return mav;
	}
}