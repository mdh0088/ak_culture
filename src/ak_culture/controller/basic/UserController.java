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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.Utils;
import ak_culture.classes.CommonDes;
import ak_culture.model.basic.IpDAO;
import ak_culture.model.basic.UserDAO;
import ak_culture.model.common.AuthDAO;
import ak_culture.model.common.CommonDAO;

@Controller
@RequestMapping("/basic/user/*")

public class UserController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private UserDAO user_dao;
	@Autowired
	private CommonDAO common_dao;
	@Autowired
	private IpDAO ip_dao;
	
	@Autowired
	private AuthDAO auth_dao;
	
//	@Transactional //트랜잭션 처리
	@RequestMapping("/login")
	public ModelAndView login(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/login");
		
		String userId = Utils.checkNullString(request.getParameter("userId"));
		
		mav.addObject("userId", userId);
		
		//트랜젝션 처리 
		//try-catch 없어도 무관
		//try-catch 쓸거면 TransactionAspectSupport... 이거 써야하고 안쓸거면 없어도됨
//		try
//		{
//			common_dao.saveManagerLog("", "test", "");
//			common_dao.saveManagerLog("", "test2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssstest2ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss", "");
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
//		}
		
//		HttpSession session = request.getSession();
//		if(!"".equals(Utils.checkNullString(session.getAttribute("login_id"))))
//		{
//			System.out.println("Utils.checkNullString(session.getAttribute(\"first_uri\")) : "+Utils.checkNullString(session.getAttribute("first_uri")));
//			mav.setViewName("redirect:"+Utils.checkNullString(session.getAttribute("first_uri")));
//		}
		
		
		return mav;
	}
	@RequestMapping("/join")
	public ModelAndView join(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/join");
		
		return mav;
	}
	@RequestMapping("/level")
	public ModelAndView level(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/level");
		
		List<HashMap<String, Object>> cate = user_dao.getLevel_cate();
		mav.addObject("cate", cate);
		return mav;
	}
	@RequestMapping("/levelGet")
	@ResponseBody
	public List<HashMap<String, Object>> levelGet(HttpServletRequest request){
		String level_name = Utils.checkNullString(request.getParameter("level_name"));
		
		List<HashMap<String, Object>> map = user_dao.getLevel(level_name); 
		
		return map;
	}
	@Transactional
	@RequestMapping("/levelIns")
	@ResponseBody
	public HashMap<String, Object> levelIns(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String level_name = Utils.checkNullString(request.getParameter("level_name"));
		int result = user_dao.level_chk(level_name, "");
		if(result == 0){
			user_dao.insLevel(level_name);
			map.put("isSuc", "success");
			map.put("msg", "성공적으로 저장되었습니다.");
			List<HashMap<String, Object>> cate = user_dao.getLevel_cate();
			map.put("cate", cate);
		}else {
			map.put("isSuc", "fail");
			map.put("msg", "이미 사용중입니다.");
		}
		return map;
	}
	@Transactional
	@RequestMapping("/levelEdit")
	@ResponseBody
	public HashMap<String, Object> levelEdit(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String level_name = Utils.checkNullString(request.getParameter("level_name"));
		String up_level_name = Utils.checkNullString(request.getParameter("up_level_name"));
		int result = user_dao.level_chk(up_level_name, "");
		if(level_name.equals(up_level_name)){
			result = 0;
		}
		if(result == 0){
			user_dao.upLevel(level_name, up_level_name);
			map.put("isSuc", "success");
			map.put("msg", "성공적으로 저장되었습니다.");
			List<HashMap<String, Object>> cate = user_dao.getLevel_cate();
			map.put("cate", cate);
		}else {
			map.put("isSuc", "fail");
			map.put("msg", "이미 사용중입니다.");
		}
		
		return map;
	}
	@RequestMapping("/levelDel")
	@ResponseBody
	public HashMap<String, Object> levelDel(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String level_name = Utils.checkNullString(request.getParameter("level_name"));
		user_dao.level_del(level_name);
		map.put("isSuc", "success");
		map.put("msg", "삭제되었습니다.");
		return map;
	}
	@Transactional
	@RequestMapping("/levelProc")
	@ResponseBody
	public HashMap<String, Object> levelProc(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();	
		
		String level_name = Utils.checkNullString(request.getParameter("level_name"));
		String auth_uri = Utils.checkNullString(request.getParameter("auth_uri"));
		String auth_key = Utils.checkNullString(request.getParameter("auth_key"));
		int result = user_dao.level_chk(level_name, auth_uri);
		
		List<HashMap<String, Object>> list = user_dao.getUser_auth_name(level_name);
		System.out.println("----------------------------------------");
		System.out.println(list);
		if(list != null) {
			for(int i = 0; i < list.size(); i++) {
				System.out.println(list.get(i).get("SEQ_NO"));
			}
		}
		
		if(result == 0){
			user_dao.level_addAuth(level_name, auth_uri, auth_key);
		}else{
			user_dao.level_editAuth(level_name, auth_uri, auth_key);
		}
		map.put("isSuc", "success");
		map.put("msg", "성공적으로 저장되었습니다.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "운영자 권한 수정", level_name);
		return map;
	}	
	@Transactional
	@RequestMapping("/join_proc")	//승인
	public ModelAndView join_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/join_proc");
		
		String join_id = Utils.checkNullString(request.getParameter("join_id"));
		String join_pw = Utils.checkNullString(request.getParameter("join_pw"));
		String join_name = Utils.checkNullString(request.getParameter("join_name"));
		String join_tim = Utils.checkNullString(request.getParameter("join_tim"));
		String join_phone = Utils.checkNullString(request.getParameter("join_phone"));
		String join_email = Utils.checkNullString(request.getParameter("join_email"));
		String join_store = Utils.checkNullString(request.getParameter("join_store"));
		String join_seq_no = Utils.checkNullString(request.getParameter("join_seq_no"));
		String join_bizno = Utils.checkNullString(request.getParameter("join_bizno"));
		String join_status = Utils.checkNullString(request.getParameter("join_status"));
		if(user_dao.chk_insUser(join_seq_no) < 1){ //BAMANAGERTB select
			user_dao.insUser(join_id, join_pw, join_name, join_tim, join_phone, join_email, join_store, join_seq_no, join_bizno, join_status); //BAMANAGERTB INSERT
			List<HashMap<String, Object>> list = user_dao.getLevel("기본값"); //기본 초기셋팅을 해준다.
			for(int i = 0; i < list.size(); i++){
				String auth_key = Utils.checkNullString(list.get(i).get("AUTH_KEY"));
				String auth_uri = Utils.checkNullString(list.get(i).get("AUTH_URI"));
				int result = auth_dao.chk_new(join_seq_no, auth_uri);
				if(result == 0){
					if(auth_uri != ""){
						auth_dao.write_proc(join_seq_no, auth_uri, auth_key);
					}
				}else{
					auth_dao.modify_proc(join_seq_no, auth_uri, auth_key);
				}
			}
		}else {
			user_dao.edit_appro(join_seq_no, join_status);
		}
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	@RequestMapping("/appro_proc")	//승인 -> 미승인
	@ResponseBody
	public HashMap<String, Object> appro_proc(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String modify_seq_no = Utils.checkNullString(request.getParameter("modify_seq_no"));
		String modify_status = Utils.checkNullString(request.getParameter("modify_status"));
		
		user_dao.edit_appro(modify_seq_no, modify_status);
		map.put("isSuc", "success");
		map.put("msg", "반영되었습니다.");
		return map;
	}
	@Transactional
	@RequestMapping("/login_proc")
	public ModelAndView login_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/login_proc");
		
		String login_id = Utils.checkNullString(request.getParameter("login_id"));
		String login_pw = Utils.checkNullString(request.getParameter("login_pw"));
		String userId = Utils.checkNullString(request.getParameter("userId")); //url에 사번넣고 다이렉트로 들어온경우.
		login_pw = Utils.getHashString(login_pw);
		
		if(!"".equals(userId))
		{
			//http://localhost:8080/basic/user/login?userId=JclcjeEeP8hw6nPgqiKx8CsjDUFZNBFL
			System.out.println("enc userid : "+userId);
			userId = CommonDes.desCommon(userId, "1");
			System.out.println("des userid : "+userId);
			userId = userId.substring(14, userId.length());
			System.out.println("fin userid : "+userId);
		}
		
		
		
		HashMap<String, Object> data = null; 
		if("".equals(userId))
		{
//			data = user_dao.loginCheck(login_id, login_pw);
			data = user_dao.loginCheck(login_id, "");
		}
		else //url에 사번넣고 다이렉트로 들어온경우.
		{
			login_id = userId;
			data = user_dao.loginCheck(login_id, "");
		}
		
		if(data != null)
		{
			if("1".equals(Utils.checkNullString(data.get("STATUS"))))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "미승인 상태입니다.");
			}
			else if("3".equals(Utils.checkNullString(data.get("STATUS"))))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "반려 상태입니다.");
			}
			else if("4".equals(Utils.checkNullString(data.get("STATUS"))))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "로그인제한 상태입니다.");
			}
			else if("2".equals(Utils.checkNullString(data.get("STATUS"))))
			{
				if("".equals(Utils.checkNullString(data.get("STORE"))))
				{
					mav.addObject("isSuc", "fail");
					mav.addObject("msg", "관리자의 대표 지점이 선택되지 않았습니다.");
					
					return mav;
				}
				String ip_addr = Utils.getClientIP(request);
				int ipCnt = ip_dao.login_ipCheck(ip_addr);
				if(ipCnt == 0)
				{
					mav.addObject("isSuc", "fail");
					mav.addObject("msg", "허용되지않은 IP입니다.");
				}
				else
				{
					mav.addObject("isSuc", "success");
					mav.addObject("first_uri", data.get("FIRST_URI"));
					
					HttpSession session = request.getSession();
					//접근불가한 메뉴 검색
					List<HashMap<String, Object>> noneAuthList = user_dao.getNoneAuthList(Utils.checkNullString(data.get("SEQ_NO")));
					ArrayList<String> noneAuthArr = new ArrayList<String>();
					
					for(int i = 0; i < noneAuthList.size(); i++)
					{
						noneAuthArr.add(Utils.checkNullString(noneAuthList.get(i).get("AUTH_URI")));
					}
					session.setAttribute("noneAuthArr", noneAuthArr);
					//접근불가한 메뉴 검색
					
					
					session.setAttribute("login_id", data.get("ID"));
					session.setAttribute("login_name", data.get("NAME"));
					session.setAttribute("login_sct_nm", data.get("SCT_NM"));
					session.setAttribute("login_seq", data.get("SEQ_NO"));
					session.setAttribute("login_rep_store", data.get("STORE"));
					session.setAttribute("login_rep_store_nm", data.get("STORE_NM"));
					session.setAttribute("first_uri", data.get("FIRST_URI"));
					if("00".equals(Utils.checkNullString(data.get("STORE"))))
					{
						session.setAttribute("login_rep_store", "03");
						session.setAttribute("login_rep_store_nm", "분당점");
						session.setAttribute("isBonbu", "T");
					}
					else
					{
						session.setAttribute("isBonbu", "F");
					}
					
					if("1".equals(Utils.checkNullString(data.get("LEADER"))))
					{ 
						session.setAttribute("isLeader", "T");
					}
					else
					{
						session.setAttribute("isLeader", "F");
					}
					session.setAttribute("last_login", data.get("LAST_LOGIN"));
					user_dao.upLastLogin(Utils.checkNullString(data.get("SEQ_NO")));
					
					//POS 관련
					String tmp_store = Utils.checkNullString(data.get("STORE"));
					if("00".equals(tmp_store))
					{
						tmp_store = "03";
					}
					HashMap<String, Object> ipData = ip_dao.getPosnoByIp(ip_addr, tmp_store); 
					String pos_no = Utils.checkNullString(ipData.get("POS_NO"));
					String print_port = Utils.checkNullString(ipData.get("PPCARD_PORT"));
					String autosign_port = Utils.checkNullString(ipData.get("AUTOSIGN_PORT"));
					session.setAttribute("ip_addr", ip_addr);
					if(pos_no != null && !"".equals(pos_no))
					{
						session.setAttribute("pos_no", pos_no);
						session.setAttribute("print_port", print_port);
						session.setAttribute("autosign_port", autosign_port);
					}
					else
					{
						session.setAttribute("pos_no", "070003");
						session.setAttribute("print_port", "0");
						session.setAttribute("autosign_port", "0");
					}
					//POS 관련
					
					common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "로그인", Utils.checkNullString(session.getAttribute("login_seq")));
				}
			}
		}
		else
		{	
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "로그인에 실패하였습니다.");
		}
		return mav;
	}
	@RequestMapping("/logout")
	public ModelAndView logout(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/logout");
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		return mav;
	}
	@RequestMapping("/list_user")
	@ResponseBody
	public HashMap<String, Object> list_user(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_status = request.getParameter("search_status");
		System.out.println(search_status);
		if(search_status.equals("1")){
			search_status = "";
		}
		String store_text = Utils.checkNullString(request.getParameter("store_data"));
		List<String> store_data = new ArrayList<String>();
		if(request.getParameter("store_data") == "" || request.getParameter("store_data") == null) {
		}else{
			if(store_text.contains("|")){
				store_data = Arrays.asList(Utils.checkNullString(request.getParameter("store_data")).split("\\|"));
			}else{
				store_data = Arrays.asList(Utils.checkNullString(request.getParameter("store_data")));
			}
		}
		HttpSession session = request.getSession();
		String isBonbu = Utils.checkNullString(session.getAttribute("isBonbu"));
		if("F".equals(isBonbu))
		{
			store_data = new ArrayList<String>();
			store_data = Arrays.asList(Utils.checkNullString(session.getAttribute("login_rep_store")));
		}
		String auth_text = Utils.checkNullString(request.getParameter("auth_data"));
		List<String> auth_data = new ArrayList<String>();
		if(request.getParameter("auth_data") == "" || request.getParameter("auth_data") == null) {
		}else{
			if(auth_text.contains("|")){
				auth_data = Arrays.asList(Utils.checkNullString(request.getParameter("auth_data")).split("\\|"));
			}else{
				auth_data = Arrays.asList(Utils.checkNullString(request.getParameter("auth_data")));
			}
		}
		List<String> ret = new ArrayList<String>();
		List<HashMap<String, Object>> allCnt = user_dao.getUserCount("", "", store_data, "", ret);
		int allCount = Utils.checkNullInt(allCnt.get(0).get("CNT"));
		List<HashMap<String, Object>> listCnt = user_dao.getUserCount(search_name, search_type, store_data, search_status, auth_data);
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
		
		List<HashMap<String, Object>> list = user_dao.getUser(search_name, s_point, listSize*page, order_by, sort_type, search_type, store_data, search_status, auth_data);
		
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "운영자 조회", Utils.checkNullString(request.getParameter("store_data")));
		return map;
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/list");
		HttpSession session = request.getSession();
		List<HashMap<String, Object>> cate = user_dao.getLevel_cate();
		Utils.setPeriController(mav, common_dao, session);
		mav.addObject("cate", cate);
		
		return mav;
	}
	
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/view");
		
		String seq_no = Utils.checkNullString(request.getParameter("seq_no"));
		
		List<HashMap<String, Object>> cate = user_dao.getLevel_cate();
		HashMap<String, Object> data = user_dao.getUser_one(seq_no);
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		mav.addObject("cate", cate);
		mav.addObject("data", data);
		mav.addObject("seq_no", seq_no);
		
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "운영자 상세조회", seq_no);
		
		
		return mav;
	}
	@RequestMapping("/modify")
	public ModelAndView modify(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/modify");
		
		String seq_no = Utils.checkNullString(request.getParameter("seq_no"));
		String status = Utils.checkNullString(request.getParameter("view_status"));
		String leader = Utils.checkNullString(request.getParameter("view_leader"));
		String auth_name = Utils.checkNullString(request.getParameter("auth_level_name"));
		String rep_store = Utils.checkNullString(request.getParameter("rep_store"));
		
		user_dao.upUser(seq_no, status, leader, auth_name, rep_store);
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "운영자 수정", seq_no);
		return mav;
	}
	@RequestMapping("/log")
	public ModelAndView log(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/user/log");
		
		return mav;
	}
	@RequestMapping("/getUser_bizno")
	@ResponseBody
	public HashMap<String, Object> getUser_bizno(HttpServletRequest request){
		String bizno = Utils.checkNullString(request.getParameter("bizno"));
		
		HashMap<String, Object> data = user_dao.getUser_bizno(bizno);
		
		return data;
	} 
	
	@RequestMapping("/auth_custom")
	@ResponseBody
	public void auth_custom(HttpServletRequest request){
		String seq_no = Utils.checkNullString(request.getParameter("seq_no"));
		
		user_dao.auth_custom(seq_no);
	}
	@RequestMapping("/getManagerLogList")
	@ResponseBody
	public HashMap<String, Object> getManagerLogList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		
		String search_start = Utils.checkNullString(request.getParameter("search_start"));
		String search_end = Utils.checkNullString(request.getParameter("search_end"));
		search_start = search_start.replaceAll("-","");
		search_end = search_end.replaceAll("-","");
		List<HashMap<String, Object>> listCnt = user_dao.getManagerLogListCount(search_name, search_start, search_end);
		List<HashMap<String, Object>> listCnt_all = user_dao.getManagerLogListCount("","","");
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
		
		List<HashMap<String, Object>> list = user_dao.getManagerLogList(s_point, listSize*page, order_by, sort_type, search_name, search_start, search_end); 
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "운영자 로그 조회", "");

		return map;
	}
}