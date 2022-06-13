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
import ak_culture.model.basic.PeriDAO;
import ak_culture.model.common.CommonDAO;

@Controller
@RequestMapping("/basic/peri/*")

public class PeriController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private PeriDAO peri_dao;
	@Autowired
	private CommonDAO common_dao;
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/peri/list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> depth1List = common_dao.get1Depth(); 
		mav.addObject("depth1List", depth1List);
		
		return mav;
	}
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/peri/write_proc");
		
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		String selYear = Utils.checkNullString(request.getParameter("selYear"));
		String selSeason = Utils.checkNullString(request.getParameter("selSeason"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "");
		String cancled_list = Utils.checkNullString(request.getParameter("cancled_list"));
		String web_open_ymd = Utils.checkNullString(request.getParameter("web_open_ymd"));
		String adult_s_bgn_ymd = Utils.checkNullString(request.getParameter("adult_s_bgn_ymd"));
		String adult_f_bgn_ymd = Utils.checkNullString(request.getParameter("adult_f_bgn_ymd"));
		String lect_hour1 = Utils.checkNullString(request.getParameter("lect_hour1"));
		String lect_hour2 = Utils.checkNullString(request.getParameter("lect_hour2"));
		String lect_hour = lect_hour1+lect_hour2+"00";
		//기존접수일, 신규접수일 하나만 입력했을경우 나머지도 같은걸로 채워준다.
		if("".equals(adult_s_bgn_ymd) && !"".equals(adult_f_bgn_ymd))
		{
			adult_s_bgn_ymd = adult_f_bgn_ymd;
		}
		else if(!"".equals(adult_s_bgn_ymd) && "".equals(adult_f_bgn_ymd))
		{
			adult_f_bgn_ymd = adult_s_bgn_ymd;
		}
		
		String is_cancel = Utils.checkNullString(request.getParameter("is_cancel_status"));
		String tech_1_ymd = Utils.checkNullString(request.getParameter("tech_1_ymd"));
		String tech_1_status = Utils.checkNullString(request.getParameter("tech_1_status"));
		String tech_2_ymd = Utils.checkNullString(request.getParameter("tech_2_ymd"));
		String tech_2_status = Utils.checkNullString(request.getParameter("tech_2_status"));
		String tech_3_ymd = Utils.checkNullString(request.getParameter("tech_3_ymd"));
		String tech_3_status = Utils.checkNullString(request.getParameter("tech_3_status"));
		String mate_1_ymd = Utils.checkNullString(request.getParameter("mate_1_ymd"));
		String mate_1_status = Utils.checkNullString(request.getParameter("mate_1_status"));
		String mate_2_ymd = Utils.checkNullString(request.getParameter("mate_2_ymd"));
		String mate_2_status = Utils.checkNullString(request.getParameter("mate_2_status"));
		String mate_3_ymd = Utils.checkNullString(request.getParameter("mate_3_ymd"));
		String mate_3_status = Utils.checkNullString(request.getParameter("mate_3_status"));
		
		int cnt = peri_dao.getPeriodByDate(selBranch, start_ymd, end_ymd);
		
		if(cnt > 0)
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "날짜가 중복되는 기수가 있습니다.");
			return mav;
		}
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		peri_dao.insPeri(selBranch, selYear, selSeason, period, start_ymd, end_ymd, cancled_list, web_open_ymd, adult_s_bgn_ymd, adult_f_bgn_ymd, 
				tech_1_ymd, tech_1_status, tech_2_ymd, tech_2_status, tech_3_ymd, tech_3_status, 
				mate_1_ymd, mate_1_status, mate_2_ymd, mate_2_status, mate_3_ymd, mate_3_status, login_seq, lect_hour, is_cancel
				);
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "기수 등록", selBranch+"/"+period);
		return mav;
	}
	@RequestMapping("/modify_proc")
	public ModelAndView modify_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/peri/modify_proc");
		
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		String selYear = Utils.checkNullString(request.getParameter("selYear"));
		String selSeason = Utils.checkNullString(request.getParameter("selSeason"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "");
		String cancled_list = Utils.checkNullString(request.getParameter("cancled_list"));
		String web_open_ymd = Utils.checkNullString(request.getParameter("web_open_ymd"));
		String adult_s_bgn_ymd = Utils.checkNullString(request.getParameter("adult_s_bgn_ymd"));
		String adult_f_bgn_ymd = Utils.checkNullString(request.getParameter("adult_f_bgn_ymd"));
		String lect_hour1 = Utils.checkNullString(request.getParameter("lect_hour1"));
		String lect_hour2 = Utils.checkNullString(request.getParameter("lect_hour2"));
		String lect_hour = lect_hour1+lect_hour2+"00";
		
		//기존접수일, 신규접수일 하나만 입력했을경우 나머지도 같은걸로 채워준다.
		if("".equals(adult_s_bgn_ymd) && !"".equals(adult_f_bgn_ymd))
		{
			adult_s_bgn_ymd = adult_f_bgn_ymd;
		}
		else if(!"".equals(adult_s_bgn_ymd) && "".equals(adult_f_bgn_ymd))
		{
			adult_f_bgn_ymd = adult_s_bgn_ymd;
		}
		String is_cancel = Utils.checkNullString(request.getParameter("is_cancel_status"));
		String tech_1_ymd = Utils.checkNullString(request.getParameter("tech_1_ymd"));
		String tech_1_status = Utils.checkNullString(request.getParameter("tech_1_status"));
		String tech_2_ymd = Utils.checkNullString(request.getParameter("tech_2_ymd"));
		String tech_2_status = Utils.checkNullString(request.getParameter("tech_2_status"));
		String tech_3_ymd = Utils.checkNullString(request.getParameter("tech_3_ymd"));
		String tech_3_status = Utils.checkNullString(request.getParameter("tech_3_status"));
		String mate_1_ymd = Utils.checkNullString(request.getParameter("mate_1_ymd"));
		String mate_1_status = Utils.checkNullString(request.getParameter("mate_1_status"));
		String mate_2_ymd = Utils.checkNullString(request.getParameter("mate_2_ymd"));
		String mate_2_status = Utils.checkNullString(request.getParameter("mate_2_status"));
		String mate_3_ymd = Utils.checkNullString(request.getParameter("mate_3_ymd"));
		String mate_3_status = Utils.checkNullString(request.getParameter("mate_3_status"));
		
		int cnt = peri_dao.getPeriodByDate(selBranch, start_ymd, end_ymd);
		
		if(cnt > 1) //자기자신은 제외
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "날짜가 중복되는 기수가 있습니다.");
			return mav;
		}
		
		peri_dao.upPeri(selBranch, selYear, selSeason, period, start_ymd, end_ymd, cancled_list, web_open_ymd, adult_s_bgn_ymd, adult_f_bgn_ymd, 
				tech_1_ymd, tech_1_status, tech_2_ymd, tech_2_status, tech_3_ymd, tech_3_status, 
				mate_1_ymd, mate_1_status, mate_2_ymd, mate_2_status, mate_3_ymd, mate_3_status, lect_hour, is_cancel
				);
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "기수 수정", selBranch+"/"+period);
		return mav;
	}
	
	@RequestMapping("/getPeriOne")
	@ResponseBody
	public HashMap<String, Object> getPeriOne(HttpServletRequest request) {
		
		String selPeri = Utils.checkNullString(request.getParameter("selPeri"));
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		
		HashMap<String, Object> data = peri_dao.getPeriOne(selPeri, selBranch); 
		
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "기수 조회", selBranch+"/"+selPeri);
		
		return data;
	}
	@RequestMapping("/getLastPeri")
	@ResponseBody
	public List<HashMap<String, Object>> getLastPeri(HttpServletRequest request) {
		
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		
		List<HashMap<String, Object>> list = peri_dao.getLastPeri(selBranch); 
		
		return list;
	}
	@RequestMapping("/setWebPeri")
	@ResponseBody
	public HashMap<String, Object> setWebPeri(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		
		peri_dao.setWebPeri(store, period, login_seq);
		int count =  peri_dao.seqPeriCount(store, period);
		if(count == 0) {
			peri_dao.insPeriSeq(store, period);             
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		
		return map;
	}
	@RequestMapping("/getWebPeri")
	@ResponseBody
	public String getWebPeri(HttpServletRequest request) {
		
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		
		return common_dao.retrievePeriod(selBranch);
	}
	@Transactional
	@RequestMapping("/cancle_proc")
	public ModelAndView cancle_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/basic/peri/cancle_proc");
		
		String store = Utils.checkNullString(request.getParameter("canStore"));
		String period = Utils.checkNullString(request.getParameter("canPeriod"));
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		String selList = Utils.checkNullString(request.getParameter("selList"));
		
		
		if(!"".equals(chkList) && !"".equals(selList))
		{
			String chkList_[] = chkList.split("\\|");
			String selList_[] = selList.split("\\|");
			for(int i = 0; i < chkList_.length; i++)
			{
				String data_chk[] = chkList_[i].split("_");
				String main_cd = data_chk[1];
				String sect_cd = data_chk[2];
				String cancled = selList_[i];
				
				List<HashMap<String, Object>> list = peri_dao.getCancled(store, period, main_cd, sect_cd);
				if(list.size() > 0)
				{
					peri_dao.upCancled(store, period, main_cd, sect_cd, cancled); 
				}
				else
				{
					peri_dao.insCancled(store, period, main_cd, sect_cd, cancled);
				}
			}
		}
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		
		return mav;
	}
	@RequestMapping("/getCancled")
	@ResponseBody
	public List<HashMap<String, Object>> getCancled(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("selStore"));
		String period = Utils.checkNullString(request.getParameter("selPeri"));
		String maincd = Utils.checkNullString(request.getParameter("selMainCd"));
		String sectcd = Utils.checkNullString(request.getParameter("selSectCd"));
		
		List<HashMap<String, Object>> list = peri_dao.getCancled(store, period, maincd, sectcd); 
		
		return list;
	}
		
}