package ak_culture.controller.basic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.Utils;
import ak_culture.model.basic.PosDAO;
import ak_culture.model.common.CommonDAO;

@Controller
@RequestMapping("/basic/pos/*")

public class PosController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private PosDAO pos_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/pos/write");
		
		return mav;
	}
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/pos/write_proc");
		String write_hq = "00"; //Utils.checkNullString(request.getParameter("write_hq"));
		String write_store = Utils.checkNullString(request.getParameter("write_store"));
		String write_pos_no = Utils.checkNullString(request.getParameter("write_pos_no"));
		String write_sale_ymd = "";//Utils.checkNullString(request.getParameter("write_sale_ymd"));
		String write_open_yn = "N";//Utils.checkNullString(request.getParameter("write_open_yn"));
		String write_sale_end_yn = "N";//Utils.checkNullString(request.getParameter("write_sale_end_yn"));
		String write_ad_end_yn = "N";//Utils.checkNullString(request.getParameter("write_ad_end_yn"));
		String write_delete_yn = "N"; //Utils.checkNullString(request.getParameter("write_delete_yn"));
		String write_send_yn = "N"; //Utils.checkNullString(request.getParameter("write_send_yn"));
		String write_create_resi_no = Utils.checkNullString(request.getParameter("write_create_resi_no"));
		String write_pos_type = "D"; //Utils.checkNullString(request.getParameter("write_pos_type"));
		
		int result = Utils.checkNullInt(pos_dao.posDup(write_hq, write_store, write_pos_no));
		String isSuc;
		String msg;
		if(result == 0) {
			pos_dao.insPos(write_hq, write_store, write_pos_no, write_sale_ymd, write_open_yn, write_sale_end_yn, write_ad_end_yn, write_delete_yn, write_send_yn, write_create_resi_no, write_pos_type);
			isSuc = "success";
			msg = "성공적으로 저장되었습니다.";
			HttpSession session = request.getSession();
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "POS 등록", write_store+"/"+write_pos_no);
		}else{
			isSuc = "duplicate";
			msg = "이미 존재하는 데이터입니다.";
		}
		mav.addObject("isSuc", isSuc);
		mav.addObject("msg", msg);
		
		return mav;
	}
	@RequestMapping("/modify")
	@ResponseBody
	public HashMap<String, Object> modify(HttpServletRequest request) {
		
		String get_hq = Utils.checkNullString(request.getParameter("get_hq"));
		String get_store = Utils.checkNullString(request.getParameter("get_store"));
		String get_pos_no = Utils.checkNullString(request.getParameter("get_pos_no"));
		HashMap<String, Object> data = pos_dao.getPos_one(get_hq, get_store, get_pos_no);
		
	    return data;
	}
	@RequestMapping("/delete_proc")
	@ResponseBody
	public HashMap<String, Object> delete_proc(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String get_hq = Utils.checkNullString(request.getParameter("get_hq"));
		String get_store = Utils.checkNullString(request.getParameter("get_store"));
		String get_pos_no = Utils.checkNullString(request.getParameter("get_pos_no"));
		int result = 9;
		String isSuc;
		String msg;
		if(!get_hq.equals("") || !get_store.equals("") || !get_pos_no.equals("")) {
			result = Utils.checkNullInt(pos_dao.useChk(get_hq, get_store, get_pos_no));
		}
		if(result == 0) {
			pos_dao.delPos(get_hq, get_store, get_pos_no);
			isSuc = "success";
			msg = "삭제되었습니다.";
			HttpSession session = request.getSession();
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "POS 삭제", get_store+"/"+get_pos_no);
		}else{
			isSuc = "duplicate";
			msg = "해당 POS를 사용중인 IP가 존재합니다.";
		}
		map.put("isSuc", isSuc);
		map.put("msg", msg);
		return map;
	}
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/pos/list");
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_store = Utils.checkNullString(request.getParameter("search_store"));
		
		List<HashMap<String, Object>> allCnt = pos_dao.getPosCount("", "");
		int allCount = Utils.checkNullInt(allCnt.get(0).get("CNT"));
		
		List<HashMap<String, Object>> listCnt = pos_dao.getPosCount(search_name, search_store);
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
		
		List<HashMap<String, Object>> list = pos_dao.getPos(search_name, s_point, listSize*page, order_by, sort_type, search_store);
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		mav.addObject("allCount", allCount);
		mav.addObject("listCount", listCount);
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("order_by", order_by);
		mav.addObject("sort_type", sort_type);
		mav.addObject("search_name", search_name);
		mav.addObject("s_page", s_page);
		mav.addObject("e_page", e_page);
		mav.addObject("pageNum", pageNum);
		mav.addObject("listSize", listSize);
		mav.addObject("search_store", search_store);
		return mav;
	}
	@RequestMapping("/list_pos")
	@ResponseBody
	public HashMap<String, Object> list_user(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_store = Utils.checkNullString(request.getParameter("search_store"));
		
		List<String> ret = new ArrayList<String>();
		List<HashMap<String, Object>> allCnt = pos_dao.getPosCount("", "");
		int allCount = Utils.checkNullInt(allCnt.get(0).get("CNT"));
		List<HashMap<String, Object>> listCnt = pos_dao.getPosCount(search_name, search_store);
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
		
		List<HashMap<String, Object>> list = pos_dao.getPos(search_name, s_point, listSize*page, order_by, sort_type, search_store);
		
		map.put("allCount", allCount);
		map.put("listCount", listCount);
		map.put("list", list);
		map.put("page", page);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("listSize", listSize);
		/*
		map.put("search_type", search_type);
		map.put("search_status", search_status);
		map.put("store_text", store_text);
		map.put("auth_text", auth_text);
		*/
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "POS 조회", search_store);
		return map;
	}
}