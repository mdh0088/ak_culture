package ak_culture.controller.basic;

import java.util.ArrayList;
import java.util.Arrays;
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
import ak_culture.model.basic.ParkDAO;
import ak_culture.model.common.CommonDAO;

@Controller
@RequestMapping("/basic/park/*")

public class ParkController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private ParkDAO park_dao;
	@Autowired
	private CommonDAO common_dao;
	
	@RequestMapping("/getParkList")
	@ResponseBody
	public HashMap<String, Object> getParkList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String date_start = Utils.checkNullString(request.getParameter("date_start")).replaceAll("-", "");
		String date_end = Utils.checkNullString(request.getParameter("date_end")).replaceAll("-", "");
		String car_num = Utils.checkNullString(request.getParameter("car_num"));
		String mgmt_num = Utils.checkNullString(request.getParameter("mgmt_num"));
		String park_info = Utils.checkNullString(request.getParameter("park_info"));
		String del_yn = Utils.checkNullString(request.getParameter("del_yn"));
		
		List<HashMap<String, Object>> listCnt = park_dao.getParkCount(store, date_start, date_end, car_num, mgmt_num, park_info, del_yn);
		List<HashMap<String, Object>> listCnt_all = park_dao.getParkCount(store, "", "", "", "", "", "");
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
		
		List<HashMap<String, Object>> list = park_dao.getPark(s_point, listSize*page, order_by, sort_type, store, date_start, date_end, car_num, mgmt_num, park_info, del_yn);
		
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "주차 조회", store);
		return map;
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/park/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		

		return mav;
	}
}