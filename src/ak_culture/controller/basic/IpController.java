package ak_culture.controller.basic;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.Utils;
import ak_culture.model.basic.IpDAO;
import ak_culture.model.basic.PosDAO;
import ak_culture.model.common.CommonDAO;

@Controller
@RequestMapping("/basic/ip/*")

public class IpController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private IpDAO ip_dao;
	@Autowired
	private CommonDAO common_dao;
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/ip/write");
		
		return mav;
	}
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/ip/write_proc");
		
		String write_hq = "00"; //Utils.checkNullString(request.getParameter("write_hq"));
		String write_store = Utils.checkNullString(request.getParameter("write_store"));
		String write_ip = Utils.checkNullString(request.getParameter("write_ip"));
		String write_pos_no = Utils.checkNullString(request.getParameter("write_pos_no"));
//		String write_pos_print_yn = Utils.checkNullString(request.getParameter("write_pos_print_yn"));
//		String write_ppcard_print_yn = Utils.checkNullString(request.getParameter("write_ppcard_print_yn"));
//		String write_ppcard_port = Utils.checkNullString(request.getParameter("write_ppcard_port"));
		String write_autosign_port = Utils.checkNullString(request.getParameter("write_autosign_port"));
		String write_create_resi_no = Utils.checkNullString(request.getParameter("write_create_resi_no"));
		String write_update_resi_no = Utils.checkNullString(request.getParameter("write_update_resi_no"));
		String write_delete_yn = Utils.checkNullString(request.getParameter("write_delete_yn"));
		String write_status = Utils.checkNullString(request.getParameter("write_status"));
		int result = ip_dao.ipDup(write_hq, write_store, write_ip);
		String isSuc;
		String msg;
		if(result == 0) {
			ip_dao.insIp(write_hq, write_store, write_ip, write_pos_no, write_autosign_port, write_create_resi_no, write_update_resi_no, write_delete_yn, write_status);
			isSuc = "success";
			msg = "성공적으로 저장되었습니다.";
		}else {
			isSuc = "duplicate";
			msg = "이미 존재하는 데이터입니다.";
		}
		mav.addObject("isSuc", isSuc);
		mav.addObject("msg", msg);
		
		return mav;
	}
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/ip/list");
		
//		String order_by = Utils.checkNullString(request.getParameter("order_by"));
//		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
//		String search_name = Utils.checkNullString(request.getParameter("search_name"));
//		String store_text = Utils.checkNullString(request.getParameter("store_data"));
//		List<String> store_data = new ArrayList<String>();
//		if(request.getParameter("store_data") == "" || request.getParameter("store_data") == null) {
//		}else{
//			if(store_text.contains("|")){
//				store_data = Arrays.asList(Utils.checkNullString(request.getParameter("store_data")).split("\\|"));
//			}else{
//				store_data = Arrays.asList(Utils.checkNullString(request.getParameter("store_data")));
//			}
//		}
//		
//		List<String> ret = new ArrayList<String>();
//		List<HashMap<String, Object>> allCnt = ip_dao.getIpCount("", ret);
//		int allCount = Integer.parseInt(allCnt.get(0).get("CNT").toString());
//		
//		List<HashMap<String, Object>> listCnt = ip_dao.getIpCount(search_name, store_data);
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
//		List<HashMap<String, Object>> list = ip_dao.getIp(search_name, s_point, listSize*page, order_by, sort_type, store_data); 
//		mav.addObject("allCount", allCount);
//		mav.addObject("listCount", listCount);
//		mav.addObject("list", list);
//		mav.addObject("page", page);
//		mav.addObject("order_by", order_by);
//		mav.addObject("sort_type", sort_type);
//		mav.addObject("search_name", search_name);
//		mav.addObject("s_page", s_page);
//		mav.addObject("e_page", e_page);
//		mav.addObject("pageNum", pageNum);
//		mav.addObject("listSize", listSize);
//		mav.addObject("store_text", store_text);
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/list_ip")
	@ResponseBody
	public HashMap<String, Object> list_user(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		List<HashMap<String, Object>> listCnt = ip_dao.getIpCount(search_name, store);
		List<HashMap<String, Object>> listCnt_all = ip_dao.getIpCount("", store);
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
		
		List<HashMap<String, Object>> list = ip_dao.getIp(s_point, listSize*page, order_by, sort_type, search_name, store); 
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "IP 조회", store);
		return map;
	}
	@RequestMapping("/getPosList")
	@ResponseBody
	public List<HashMap<String, Object>> getPosList(HttpServletRequest request){
		String store = Utils.checkNullString(request.getParameter("store"));
		List<HashMap<String, Object>> list = ip_dao.getPos_no(store);
		
		return list;
	}
	/*
	@RequestMapping("/modify")
	@ResponseBody
	public ModelAndView modify(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		
		String get_hq = Utils.checkNullString(request.getParameter("get_hq"));
		String get_store = Utils.checkNullString(request.getParameter("get_store"));
		String get_ip = Utils.checkNullString(request.getParameter("get_ip"));
		HashMap<String, Object> edit = ip_dao.getIp_one(get_hq, get_store, get_ip);
		
		mav.setView(jsonView);
		mav.addObject("edit", edit);
		mav.addObject("isSuc", "success");
		return mav;
	}
	*/
	@RequestMapping("/modify")
	@ResponseBody
	public HashMap<String, Object> modify(HttpServletRequest request) {
		ObjectMapper mapper = new ObjectMapper();
		
		String get_hq = Utils.checkNullString(request.getParameter("get_hq"));
		String get_store = Utils.checkNullString(request.getParameter("get_store"));
		String get_ip = Utils.checkNullString(request.getParameter("get_ip"));
		HashMap<String, Object> edit = ip_dao.getIp_one(get_hq, get_store, get_ip);
		String result = "";
		try {
			String json = mapper.writeValueAsString(edit);
			System.out.println(edit);
			result = json;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return edit;
	}
	@Transactional
	@RequestMapping("/modify_proc")
	public ModelAndView modify_proc(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/ip/modify_proc");
		
		String modify_hq = "00"; //Utils.checkNullString(request.getParameter("write_hq"));
		String modify_store = Utils.checkNullString(request.getParameter("write_store"));
		String modify_ip = Utils.checkNullString(request.getParameter("write_ip"));
		String modify_pos_no = Utils.checkNullString(request.getParameter("write_pos_no"));
		String modify_pos_print_yn = Utils.checkNullString(request.getParameter("write_pos_print_yn"));
		String modify_ppcard_print_yn = Utils.checkNullString(request.getParameter("write_ppcard_print_yn"));
		String modify_ppcard_port = Utils.checkNullString(request.getParameter("write_ppcard_port"));
		String modify_autosign_port = Utils.checkNullString(request.getParameter("write_autosign_port"));
		String modify_update_resi_no = Utils.checkNullString(request.getParameter("write_update_resi_no"));
		String modify_delete_yn = Utils.checkNullString(request.getParameter("write_delete_yn"));
		String modify_status = Utils.checkNullString(request.getParameter("write_status"));
		
		String get_hq = Utils.checkNullString(request.getParameter("get_hq"));
		String get_store = Utils.checkNullString(request.getParameter("get_store"));
		String get_ip = Utils.checkNullString(request.getParameter("get_ip"));
		
		int result = 0;
		String isSuc;
		String msg;
		if(!get_hq.equals(modify_hq) || !get_store.equals(modify_store) || !get_ip.equals(modify_ip)) {
			result = Utils.checkNullInt(ip_dao.ipDup(modify_hq, modify_store, modify_ip));
		}
		if(result == 0) {
			ip_dao.upIp(modify_hq, modify_store, modify_ip, modify_pos_no, modify_pos_print_yn, modify_ppcard_print_yn, modify_ppcard_port, modify_autosign_port, modify_update_resi_no, modify_delete_yn, modify_status, get_hq, get_store, get_ip);
			isSuc = "success";
			msg = "성공적으로 저장되었습니다.";
		}else{
			isSuc = "duplicate";
			msg = "이미 존재하는 데이터입니다.";
		}
		mav.addObject("isSuc", isSuc);
		mav.addObject("msg", msg);
		
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "IP 설정 수정", modify_ip);
		return mav;
	}
	@Transactional
	@RequestMapping("/delete_yn")
	@ResponseBody
	void delete_yn(HttpServletRequest request) {
		
		String get_hq = "00";//Utils.checkNullString(request.getParameter("get_hq"));
		String get_store = Utils.checkNullString(request.getParameter("get_store"));
		String get_ip = Utils.checkNullString(request.getParameter("get_ip"));
		String delete_yn = Utils.checkNullString(request.getParameter("delete_yn"));
		System.out.println(get_hq + get_store + get_ip + delete_yn);
		ip_dao.delete_yn(get_hq, get_store, get_ip, delete_yn);
		
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "IP 사용상태 수정", get_ip);
		
	}
}