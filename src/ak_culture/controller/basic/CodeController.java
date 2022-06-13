package ak_culture.controller.basic;

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
import ak_culture.model.basic.CodeDAO;

@Controller
@RequestMapping("/basic/code/*")

public class CodeController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private CodeDAO code_dao;
	
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/code/list");
		
		String code_fg ="00";
		
		List<HashMap<String, Object>> codelist = code_dao.getLastCodeNum(code_fg);
		String LastCode = Utils.checkNullString(codelist.get(0).get("SUB_CODE"));
		List<HashMap<String, Object>> code_list = code_dao.getCodeList();
		
		mav.addObject("LastCode", LastCode);
		mav.addObject("code_list", code_list);
		
		return mav;
	}
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/code/list");
		
		
		return mav;
	}
	@Transactional
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/write_proc");
		
		String[] main_code_arr = Utils.checkNullString(request.getParameter("main_code")).split("@");
	    String[] sub_code_arr = Utils.checkNullString(request.getParameter("sub_code")).split("-");
	    String[] sub_code_title_arr = Utils.checkNullString(request.getParameter("sub_code_title")).split("-");
	    String[] sub_code_cont_arr = Utils.checkNullString(request.getParameter("sub_code_cont")).split("-");
		
	    HttpSession session = request.getSession();
	    String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
	    
	    
	    
	    for (int i = 0; i < main_code_arr.length; i++) {
			String[] insert_sub_code = sub_code_arr[i].split("@");
			String[] insert_sub_code_title = sub_code_title_arr[i].split("@");
			String[] insert_sub_code_cont = sub_code_cont_arr[i].split("@");
			
			for (int j = 0; j < insert_sub_code.length; j++) {
				code_dao.insCode(main_code_arr[i],insert_sub_code[j],insert_sub_code_title[j],insert_sub_code_cont[j],create_resi_no);
			}
		}
	    
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	@Transactional
	@RequestMapping("/addMainCode")
	public ModelAndView addMainCode(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/write_proc");
		
		String[] main_code_arr = Utils.checkNullString(request.getParameter("main_code")).split("\\|");
	    String[] main_code_nm_arr = Utils.checkNullString(request.getParameter("main_code_nm")).split("\\|");
	    String[] main_code_cont_arr = Utils.checkNullString(request.getParameter("main_code_cont")).split("\\|");
	    
		
	    HttpSession session = request.getSession();
	    String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
	    
	    for (int i = 0; i < main_code_arr.length; i++) {
			code_dao.insMainCode(main_code_arr[i],main_code_nm_arr[i],main_code_cont_arr[i],create_resi_no);
		}
	    
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	
	@RequestMapping("/getMainCd")
	@ResponseBody
	public HashMap<String, Object> getMemo(HttpServletRequest request) {
		
	
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
	
		
		List<HashMap<String, Object>> list = code_dao.getCode(order_by,sort_type);
		
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
	    return map;
	}
	@Transactional
	@RequestMapping("/sub_edit")
	@ResponseBody
	public ModelAndView sub_edit(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/basic/code/write_proc");
		
		String code_fg = Utils.checkNullString(request.getParameter("code_fg"));
		String way = Utils.checkNullString(request.getParameter("way"));
		String sub_code = Utils.checkNullString(request.getParameter("sub_code"));
		String short_name = Utils.checkNullString(request.getParameter("short_name"));
		String long_name = Utils.checkNullString(request.getParameter("long_name"));
		String edit_sub_code = Utils.checkNullString(request.getParameter("edit_sub_code"));
		

		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		

		
		
		if (way.equals("edit")) {
			System.out.println("업데이드!");
			code_dao.edit_sub_code(code_fg,edit_sub_code,sub_code,create_resi_no,short_name,long_name);
			mav.addObject("isSuc", "success");
			mav.addObject("msg", "수정되었습니다.");
		}else if (way.equals("del")) {
			code_dao.del_sub_code(code_fg,sub_code,create_resi_no);
			mav.addObject("isSuc", "success");
			mav.addObject("msg", "삭제되었습니다.");
		}else if (way.equals("upt")) {
			code_dao.upt_sub_code(code_fg,sub_code,create_resi_no);
			mav.addObject("isSuc", "success");
			mav.addObject("msg", "수정되었습니다.");
		}
		
		
	//	mav.addObject("e_page", e_page);
		return mav;
	}
	
	@RequestMapping("/getSub")
	@ResponseBody
	public List<HashMap<String, Object>> getSub(HttpServletRequest request) {
		
		String code_fg = Utils.checkNullString(request.getParameter("code_fg"));
		List<HashMap<String, Object>> list = code_dao.getSubCode(code_fg); 
		
	    return list;
	}
	
	
	@RequestMapping("/getLastSub")
	@ResponseBody
	public List<HashMap<String, Object>> getLastSub(HttpServletRequest request) {
		
		String code_fg = Utils.checkNullString(request.getParameter("code_fg"));
		List<HashMap<String, Object>> list = code_dao.getLastCodeNum(code_fg);
		
	    return list;
	}
	
}