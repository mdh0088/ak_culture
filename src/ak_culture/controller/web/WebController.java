package ak_culture.controller.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ak_culture.classes.Utils;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.lecture.LectDAO;
import ak_culture.model.web.WebDAO;

@Controller
@RequestMapping("/web/*")

public class WebController {
	
	@Value("${upload_dir}")
	private String upload_dir;
	@Value("${image_dir}")
	private String image_dir;
	@Autowired
	private CommonDAO common_dao;
	@Autowired
	private WebDAO web_dao;
	@Autowired
	private LectDAO lect_dao;
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/list");
		
		return mav;
	}
	@RequestMapping("/preview_mbanner")
	public ModelAndView preview_mbanner(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/preview_mbanner");
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		seq = seq.substring(0, seq.length()-1);
		List<HashMap<String, Object>> list = web_dao.getMBannerByPreview(seq);
		mav.addObject("list", list);
		mav.addObject("image_dir", image_dir);
		return mav;
	}
	@RequestMapping("/preview_sbanner")
	public ModelAndView preview_sbanner(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/preview_sbanner");
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		seq = seq.substring(0, seq.length()-1);
		List<HashMap<String, Object>> list = web_dao.getSBannerByPreview(seq);
		mav.addObject("list", list);
		mav.addObject("image_dir", image_dir);
		return mav;
	}
	@RequestMapping("/preview_popup")
	public ModelAndView preview_popup(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/preview_popup");
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		seq = seq.substring(0, seq.length()-1);
		List<HashMap<String, Object>> list = web_dao.getPopupByPreview(seq);
		mav.addObject("list", list);
		mav.addObject("image_dir", image_dir);
		return mav;
	}
	
	@RequestMapping("/list_upload")
	public ModelAndView list_upload(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/list_upload");
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		
		if(!"".equals(seq))
		{
			HashMap<String, Object> data = web_dao.getMBannerOne(seq);
			mav.addObject("data", data);
			mav.addObject("seq", seq);
		}
		
		return mav;
	}
	
	@RequestMapping("/sublist")
	public ModelAndView sublist(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/sublist");
		
		return mav;
	}
	@RequestMapping("/sublist_upload")
	public ModelAndView sublist_upload(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/sublist_upload");
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		
		if(!"".equals(seq))
		{
			HashMap<String, Object> data = web_dao.getSBannerOne(seq);
			mav.addObject("data", data);
			mav.addObject("seq", seq);
		}
		
		return mav;
	}
	@RequestMapping("/popup")
	public ModelAndView popup(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/popup");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/popup_upload")
	public ModelAndView popup_upload(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/popup_upload");
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		
		if(!"".equals(seq))
		{
			HashMap<String, Object> data = web_dao.getPopupOne(seq);
			mav.addObject("data", data);
			mav.addObject("seq", seq);
		}
		
		return mav;
	}
	@RequestMapping("/lecture")
	public ModelAndView lecture(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/lecture");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		List<HashMap<String, Object>> list = web_dao.getRecoList("","","","","","","");
		
		//태그들 불러오기위함
		String tagList = ","; //구분하기위해 ,로 시작
		for(int i = 0; i < list.size(); i++)
		{
			String tag = "";
			if(list.get(i) != null && list.get(i).get("TAG") != null)
			{
				tag =  Utils.checkNullString(list.get(i).get("TAG"));
				String tagArr[] = tag.split("\\|");
				for(int z = 0; z < tagArr.length; z++)
				{
					if(tagList.indexOf(","+tagArr[z]) == -1)
					{
						tagList += tagArr[z]+",";
					}
				}
			}
		}
		if(!",".equals(tagList))
		{
			tagList = tagList.substring(1, tagList.length()-1);
		}
		else
		{
			tagList = "";
		}
		
		mav.addObject("tagList", tagList);
		
		return mav;
	}
	@RequestMapping("/academy")
	public ModelAndView academy(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/academy");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/getNewsList")
	@ResponseBody
	public HashMap<String, Object> getNewsList(HttpServletRequest request) {
		
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_date_type = Utils.checkNullString(request.getParameter("search_date_type"));
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String search_cate = Utils.checkNullString(request.getParameter("search_cate"));
		if(!"".equals(search_cate))
		{
			search_cate = search_cate.substring(0, search_cate.length()-1);
		}
		String search_store = Utils.checkNullString(request.getParameter("search_store"));
		if(!"".equals(search_store))
		{
			search_store = search_store.substring(0, search_store.length()-1);
		}
		
		List<HashMap<String, Object>> list = web_dao.getNewsList(search_type, search_name, search_date_type, search_start, search_end, search_cate, search_store); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", list.size());
		
		list = web_dao.getNewsList("","","","","","",""); 
		map.put("listCnt_all", list.size());
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "아카데미 뉴스 조회", "");
	    return map;
	}
	@RequestMapping("/getReviewList")
	@ResponseBody
	public HashMap<String, Object> getReviewList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "") + "000000";
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "") + "999999";
		String lecturer_nm = Utils.checkNullString(request.getParameter("lecturer_nm"));
		String subject_nm = Utils.checkNullString(request.getParameter("subject_nm"));
		String is_reco = Utils.checkNullString(request.getParameter("is_reco"));
		String is_best = Utils.checkNullString(request.getParameter("is_best"));
		
		List<HashMap<String, Object>> listCnt = web_dao.getReviewListCount(store, period, search_type, search_name, start_ymd, end_ymd, lecturer_nm, subject_nm, is_reco, is_best);
		List<HashMap<String, Object>> listCnt_all = web_dao.getReviewListCount("", "", "", "", "", "", "", "", "", "");
		
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
		
		List<HashMap<String, Object>> list = web_dao.getReviewList(s_point, listSize*page, order_by, sort_type, store, period, search_type, search_name, start_ymd, end_ymd, lecturer_nm, subject_nm, is_reco, is_best);
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "수강후기 관리 조회", store+"/"+period);
		return map;
	}
	@Transactional
	@RequestMapping("/bestAction")
	@ResponseBody
	public HashMap<String, Object> bestAction(HttpServletRequest request){
		
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		String act = Utils.checkNullString(request.getParameter("act"));
		String arr[] = chkList.split("\\|");
		
		for(int i = 0; i < arr.length; i++)
		{
			String store = arr[i].split("_")[0];
			String period = arr[i].split("_")[1];
			String subject_cd = arr[i].split("_")[2];
			
			web_dao.bestAction(store, period, subject_cd, act);
			HttpSession session = request.getSession();
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "수강후기 BEST 선정", store+"/"+period+"/"+subject_cd);
			
//			if (act.equals("Y")) { // 폐강 or 폐강취소 체크
//				act="1";		   // 1:폐강 2:폐강취소
//			}else {
//				act="2";
//			}
		}

		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
		
	}
	@RequestMapping("/getMBannerList")
	@ResponseBody
	public HashMap<String, Object> getMBannerList(HttpServletRequest request) {
		
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String search_show = Utils.checkNullString(request.getParameter("search_show"));
		if(!"".equals(search_show))
		{
			search_show = search_show.substring(0, search_show.length()-1);
		}
		
		List<HashMap<String, Object>> list = web_dao.getMBannerList(search_name, search_start, search_end, search_show); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", list.size());
		
		list = web_dao.getMBannerList("","","",""); 
		map.put("listCnt_all", list.size());
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "메인 배너 관리 조회", "");
		return map;
	}
	@RequestMapping("/getSBannerList")
	@ResponseBody
	public HashMap<String, Object> getSBannerList(HttpServletRequest request) {
		
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_date_type = Utils.checkNullString(request.getParameter("search_date_type"));
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String search_show = Utils.checkNullString(request.getParameter("search_show"));
		if(!"".equals(search_show))
		{
			search_show = search_show.substring(0, search_show.length()-1);
		}
		
		List<HashMap<String, Object>> list = web_dao.getSBannerList(search_name, search_date_type, search_start, search_end, search_show); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", list.size());
		
		list = web_dao.getSBannerList("","","","",""); 
		map.put("listCnt_all", list.size());
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "중간 배너 관리 조회", "");
		return map;
	}
	@RequestMapping("/getPopupList")
	@ResponseBody
	public HashMap<String, Object> getPopupList(HttpServletRequest request) {
		
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_date_type = Utils.checkNullString(request.getParameter("search_date_type"));
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		String search_show = Utils.checkNullString(request.getParameter("search_show"));
		if(!"".equals(search_show))
		{
			search_show = search_show.substring(0, search_show.length()-1);
		}
		
		List<HashMap<String, Object>> list = web_dao.getPopupList(search_name, search_date_type, search_start, search_end, search_show); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", list.size());
		
		list = web_dao.getPopupList("","","","",""); 
		map.put("listCnt_all", list.size());
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "팝업 관리 조회", "");
		return map;
	}
	@RequestMapping("/getRecoList")
	@ResponseBody
	public HashMap<String, Object> getRecoList(HttpServletRequest request) {
		
		String search_store = Utils.checkNullString(request.getParameter("search_store"));
		String search_period = Utils.checkNullString(request.getParameter("search_period"));
		String search_tag = Utils.checkNullString(request.getParameter("search_tag"));
		String search_show = Utils.checkNullString(request.getParameter("search_show"));
		String search_date_type = Utils.checkNullString(request.getParameter("search_date_type"));
		String search_start = Utils.checkNullString(request.getParameter("search_start")).replaceAll("-", "");
		String search_end = Utils.checkNullString(request.getParameter("search_end")).replaceAll("-", "");
		if(!"".equals(search_show))
		{
			search_show = search_show.substring(0, search_show.length()-1);
		}
		
		List<HashMap<String, Object>> list = web_dao.getRecoList(search_store, search_period, search_tag, search_show, search_start, search_end, search_date_type); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("listCnt", list.size());
		
		list = web_dao.getRecoList("","","","","","","");
		map.put("listCnt_all", list.size());
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "추천 강좌 리스트 조회", search_store+"/"+search_period);
		return map;
	}
	@RequestMapping("/delNews")
	@ResponseBody
	public HashMap<String, Object> delNews(HttpServletRequest request) {
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		if(!"".equals(seq))
		{
			seq = seq.substring(0, seq.length()-1);
		}
		web_dao.delNews(seq); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@RequestMapping("/delMBanner")
	@ResponseBody
	public HashMap<String, Object> delMBanner(HttpServletRequest request) {
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		if(!"".equals(seq))
		{
			seq = seq.substring(0, seq.length()-1);
		}
		web_dao.delMBanner(seq); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@RequestMapping("/delSBanner")
	@ResponseBody
	public HashMap<String, Object> delSBanner(HttpServletRequest request) {
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		if(!"".equals(seq))
		{
			seq = seq.substring(0, seq.length()-1);
		}
		web_dao.delSBanner(seq); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@RequestMapping("/delPopup")
	@ResponseBody
	public HashMap<String, Object> delPopup(HttpServletRequest request) {
		
		String seq = Utils.checkNullString(request.getParameter("seq"));
		if(!"".equals(seq))
		{
			seq = seq.substring(0, seq.length()-1);
		}
		web_dao.delPopup(seq); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@RequestMapping("/sortNews")
	@ResponseBody
	public void sortNews(HttpServletRequest request) {
		String seq = Utils.checkNullString(request.getParameter("seq"));
		String sort = Utils.checkNullString(request.getParameter("sort"));
		
		web_dao.sortNews(seq, sort);
	}
	@RequestMapping("/sortMBanner")
	@ResponseBody
	public void sortMBanner(HttpServletRequest request) {
		String seq = Utils.checkNullString(request.getParameter("seq"));
		String sort = Utils.checkNullString(request.getParameter("sort"));
		
		web_dao.sortMBanner(seq, sort);
	}
	@RequestMapping("/sortSBanner")
	@ResponseBody
	public void sortSBanner(HttpServletRequest request) {
		String seq = Utils.checkNullString(request.getParameter("seq"));
		String sort = Utils.checkNullString(request.getParameter("sort"));
		
		web_dao.sortSBanner(seq, sort);
	}
	@RequestMapping("/sortPopup")
	@ResponseBody
	public void sortPopup(HttpServletRequest request) {
		String seq = Utils.checkNullString(request.getParameter("seq"));
		String sort = Utils.checkNullString(request.getParameter("sort"));
		
		web_dao.sortPopup(seq, sort);
	}
	@RequestMapping("/academy_upload")
	public ModelAndView academy_upload(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/academy_upload");
		String seq = Utils.checkNullString(request.getParameter("seq"));
		
		if(!"".equals(seq))
		{
			HashMap<String, Object> data = web_dao.getNewsOne(seq);
			mav.addObject("data", data);
			mav.addObject("seq", seq);
		}
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/academy_upload_proc")
	public ModelAndView academy_upload_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/academy_upload_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
        String uploadPath = upload_dir+"news/";
        
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
			
        MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
        
        HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String store = Utils.checkNullString(multi.getParameter("selBranch"));
		String news_category = Utils.checkNullString(multi.getParameter("news_category"));
		String news_title = Utils.checkNullString(multi.getParameter("news_title"));
		String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd")).replaceAll("-", "");
		String is_show = Utils.checkNullString(multi.getParameter("is_show"));
		String contents = Utils.checkNullString(multi.getParameter("contents"));
		String filename = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("attach")), uploadPath, 1);
		String filename_ori = Utils.checkNullString(multi.getOriginalFileName("attach"));
		String banner = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("banner")), uploadPath, 1);
		String m_banner = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("m_banner")), uploadPath, 3);
		
		int seq = Utils.checkNullInt(multi.getParameter("seq"));
		if(seq > 0)
		{
			if("".equals(banner))
			{
				HashMap<String, Object> data = web_dao.getNewsFileName(seq);
				if(data != null && data.get("BANNER") != null)
				{
					banner = Utils.checkNullString(data.get("BANNER"));
				}
			}
			if("".equals(m_banner))
			{
				HashMap<String, Object> data = web_dao.getNewsFileName(seq);
				if(data != null && data.get("M_BANNER") != null)
				{
					m_banner = Utils.checkNullString(data.get("M_BANNER"));
				}
			}
			if("".equals(filename))
			{
				HashMap<String, Object> data = web_dao.getNewsFileName(seq);
				if(data != null && data.get("FILENAME") != null && data.get("FILENAME_ORI") != null)
				{
					filename = Utils.checkNullString(data.get("FILENAME"));
					filename_ori = Utils.checkNullString(data.get("FILENAME_ORI"));
				}
			}
			web_dao.upNews(seq, store, news_category, news_title, start_ymd, end_ymd, is_show, filename, filename_ori, contents, login_seq, banner, m_banner);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "아카데미 뉴스 수정", Integer.toString(seq));
		}
		else
		{
			seq = web_dao.getSeqByWeb("BABOARDTB");
			web_dao.insNews(seq, store, news_category, news_title, start_ymd, end_ymd, is_show, filename, filename_ori, contents, login_seq, banner, m_banner);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "아카데미 뉴스 등록", Integer.toString(seq));
		}
        	
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		
		return mav;
	}
	@RequestMapping("/list_upload_proc")
	public ModelAndView list_upload_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/list_upload_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
		String uploadPath = upload_dir+"main_banner/";
		
		File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String main_title = Utils.checkNullString(multi.getParameter("main_title"));
		String sub_title = Utils.checkNullString(multi.getParameter("sub_title"));
		String description = Utils.checkNullString(multi.getParameter("description"));
		description = Utils.repWord(description);
		String is_show = Utils.checkNullString(multi.getParameter("is_show"));
		String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd")).replaceAll("-", "");
		String banner = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("banner")), uploadPath, 1);
		String m_banner = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("m_banner")), uploadPath, 3);
		String contents = Utils.checkNullString(multi.getParameter("contents"));
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq);
		map.put("main_title", main_title);
		map.put("sub_title", sub_title);
		map.put("description", description);
		map.put("is_show", is_show);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("banner", banner);
		map.put("m_banner", m_banner);
		map.put("contents", contents);
		
		int seq = Utils.checkNullInt(multi.getParameter("seq"));
		if(seq > 0)
		{
			if("".equals(banner))
			{
				HashMap<String, Object> data = web_dao.getMBannerFileName(seq);
				if(data != null && data.get("BANNER") != null)
				{
					banner = Utils.checkNullString(data.get("BANNER"));
					map.put("banner", banner);
				}
			}
			if("".equals(m_banner))
			{
				HashMap<String, Object> data = web_dao.getMBannerFileName(seq);
				if(data != null && data.get("M_BANNER") != null)
				{
					m_banner = Utils.checkNullString(data.get("M_BANNER"));
					map.put("m_banner", m_banner);
				}
			}
			map.put("seq", seq);
			web_dao.upMBanner(map);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "메인 배너 수정", Integer.toString(seq));
		}
		else
		{
			seq = web_dao.getSeqByWeb("BAMBANNERTB");
			map.put("seq", seq);
			web_dao.insMBanner(map);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "메인 배너 등록", Integer.toString(seq));
		}
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		
		return mav;
	}
	@RequestMapping("/sublist_upload_proc")
	public ModelAndView sublist_upload_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/sublist_upload_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
		String uploadPath = upload_dir+"sub_banner/";
		
		File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String banner_name = Utils.checkNullString(multi.getParameter("banner_name"));
		String banner_desc = Utils.checkNullString(multi.getParameter("banner_desc"));
		String is_show = Utils.checkNullString(multi.getParameter("is_show"));
		String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd")).replaceAll("-", "");
		String banner_pop = Utils.checkNullString(multi.getParameter("banner_pop"));
		String banner = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("banner")), uploadPath, 1);
		String detail = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("detail")), uploadPath, 2);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq);
		map.put("banner_name", banner_name);
		map.put("banner_desc", banner_desc);
		map.put("is_show", is_show);
		map.put("banner_pop", banner_pop);
		map.put("banner", banner);
		map.put("detail", detail);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		
		int seq = Utils.checkNullInt(multi.getParameter("seq"));
		if(seq > 0)
		{
			if("".equals(banner))
			{
				HashMap<String, Object> data = web_dao.getSBannerFileName(seq);
				if(data != null && data.get("BANNER") != null)
				{
					banner = Utils.checkNullString(data.get("BANNER"));
					map.put("banner", banner);
				}
			}
			if("".equals(detail))
			{
				HashMap<String, Object> data = web_dao.getSBannerFileName(seq);
				if(data != null && data.get("DETAIL") != null)
				{
					detail = Utils.checkNullString(data.get("DETAIL"));
					map.put("detail", detail);
				}
			}
			map.put("seq", seq);
			web_dao.upSBanner(map);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "중간 배너 수정", Integer.toString(seq));
		}
		else
		{
			seq = web_dao.getSeqByWeb("BASBANNERTB");
			map.put("seq", seq);
			web_dao.insSBanner(map);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "중간 배너 등록", Integer.toString(seq));
		}
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		
		return mav;
	}
	@RequestMapping("/popup_upload_proc")
	public ModelAndView popup_upload_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/popup_upload_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
		String uploadPath = upload_dir+"popup/";
		
		File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String popup_title = Utils.checkNullString(multi.getParameter("popup_title"));
		String open_type = Utils.checkNullString(multi.getParameter("open_type"));
		String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd")).replaceAll("-", "");
		String is_show = Utils.checkNullString(multi.getParameter("is_show"));
		String margin_top = Utils.checkNullString(multi.getParameter("margin_top"));
		String margin_left = Utils.checkNullString(multi.getParameter("margin_left"));
		String is_center = Utils.checkNullString(multi.getParameter("is_center"));
		if("".equals(is_center)) { is_center = "N"; }
		String not_today = Utils.checkNullString(multi.getParameter("not_today"));
		if("".equals(not_today)) { not_today = "N"; }
		String popup_link = Utils.checkNullString(multi.getParameter("popup_link"));
		String popup_pop = Utils.checkNullString(multi.getParameter("popup_pop"));
		String popup_img = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("popup_img")), uploadPath, 1);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq);
		map.put("popup_title", popup_title);
		map.put("open_type", open_type);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("is_show", is_show);
		map.put("margin_top", margin_top);
		map.put("margin_left", margin_left);
		map.put("is_center", is_center);
		map.put("not_today", not_today);
		map.put("popup_link", popup_link);
		map.put("popup_pop", popup_pop);
		map.put("popup_img", popup_img);
		
		int seq = Utils.checkNullInt(multi.getParameter("seq"));
		if(seq > 0)
		{
			if("".equals(popup_img))
			{
				HashMap<String, Object> data = web_dao.getPopupFileName(seq);
				if(data != null && data.get("POPUP_IMG") != null)
				{
					popup_img = Utils.checkNullString(data.get("POPUP_IMG"));
					map.put("popup_img", popup_img);
				}
			}
			map.put("seq", seq);
			web_dao.upPopup(map);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "팝업 수정", Integer.toString(seq));
		}
		else
		{
			seq = web_dao.getSeqByWeb("BAPOPUPTB");
			map.put("seq", seq);
			web_dao.insPopup(map);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "팝업 등록", Integer.toString(seq));
		}
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		
		return mav;
	}
	@RequestMapping("/lecture_upload_proc")
	public ModelAndView lecture_upload_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/lecture_upload_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
		String uploadPath = upload_dir+"recom_lecture/";
		
		File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String store = Utils.checkNullString(multi.getParameter("store"));
		String period = Utils.checkNullString(multi.getParameter("period"));
		String subject_cd = Utils.checkNullString(multi.getParameter("subject_cd"));
//		String thumbnail = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("thumbnail")), uploadPath, 1);
		String change_show = Utils.checkNullString(multi.getParameter("change_show"));
		String start_ymd = Utils.checkNullString(multi.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(multi.getParameter("end_ymd")).replaceAll("-", "");
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("login_seq", login_seq);
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("change_show", change_show);
//		map.put("thumbnail", thumbnail);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		
//		if("".equals(thumbnail))
//		{
//			HashMap<String, Object> data = web_dao.getRecoFileName(store, period, subject_cd);
//			if(data != null && data.get("THUMBNAIL") != null)
//			{
//				thumbnail = Utils.checkNullString(data.get("THUMBNAIL"));
//				map.put("thumbnail", thumbnail);
//			}
//		}
		web_dao.upReco(map);
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "추천 강좌 수정", store+"/"+period+"/"+subject_cd);
		
		return mav;
	}
	@RequestMapping("/review")
	public ModelAndView review(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/review");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	
	@RequestMapping("/plan")
	public ModelAndView plan(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/plan");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		String contents = web_dao.getCanc();
		
		mav.addObject("canc_contents", contents);
		
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		return mav;
	}
	
	@RequestMapping("/plan_write")
	public ModelAndView plan_write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/plan_write");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		
		List<HashMap<String, Object>> list = lect_dao.getPlanDetail(store, period, subject_cd);
		HashMap<String, Object> data = lect_dao.getPeltOne(store, period, subject_cd);
		
		
		if(list.size() > 0)
		{
			list.get(0).put("ETC", Utils.checkNullString(list.get(0).get("ETC")).replaceAll("\n", "\\|"));
		}
		
		mav.addObject("list_size", list.size());
		mav.addObject("data", data);
		mav.addObject("list", list);
		mav.addObject("store", store);
		mav.addObject("period", period);
		mav.addObject("subject_cd", subject_cd);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의계획서 상세 조회", store+"/"+period+"/"+subject_cd);
		return mav;
	}
	@Transactional
	@RequestMapping("/plan_write_proc")
	public ModelAndView plan_write_proc(HttpServletRequest request) throws IOException {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lect/plan_write_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
        String uploadPath = upload_dir+"wlect/";
        
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		String thumbnail = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("thumbnail")), uploadPath, 1);
		String detail = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("detail")), uploadPath, 2);
		
		String thumbnail_del = Utils.checkNullString(multi.getParameter("thumbnail_del"));
		String detail_del = Utils.checkNullString(multi.getParameter("detail_del"));
		
		
		String store = Utils.checkNullString(multi.getParameter("store"));
		String period = Utils.checkNullString(multi.getParameter("period"));
		String subject_cd = Utils.checkNullString(multi.getParameter("subject_cd"));
		String subject_nm = Utils.checkNullString(multi.getParameter("subject_nm"));
		
		String lecturer_nm = Utils.checkNullString(multi.getParameter("lecturer_nm"));
		String lecturer_career = Utils.checkNullString(multi.getParameter("lecturer_career"));
		lecturer_career = Utils.repWord(lecturer_career);
		String lecture_content = Utils.checkNullString(multi.getParameter("lecture_content"));
		lecture_content = Utils.repWord(lecture_content);
		
		String lect_cnt = Utils.checkNullString(multi.getParameter("lect_cnt_list"));
		String lect_contents = Utils.checkNullString(multi.getParameter("lect_contents_list"));
		lect_contents = Utils.repWord(lect_contents);
		String etc = "";
		String lect_cnt_arr[] = lect_cnt.split("\\|");
		String lect_contents_arr[] = lect_contents.split("\\|");
		for(int i = 0; i < lect_cnt_arr.length; i++)
		{
			etc += lect_cnt_arr[i]+"회차 : "+lect_contents_arr[i]+"\n";
		}
		
		if("".equals(thumbnail))
		{
			HashMap<String, Object> getImg = lect_dao.getPeltOne(store, period, subject_cd);
			if(getImg != null && getImg.get("THUMBNAIL_IMG") != null)
			{
				thumbnail = Utils.checkNullString(getImg.get("THUMBNAIL_IMG"));
			}
			
		}
		if("".equals(detail))
		{
			HashMap<String, Object> getImg = lect_dao.getPeltOne(store, period, subject_cd);
			if(getImg != null && getImg.get("DETAIL_IMG") != null)
			{
				detail = Utils.checkNullString(getImg.get("DETAIL_IMG"));
			}
			
		}
		
		if("on".equals(thumbnail_del))
		{
			thumbnail = "";
		}
		if("on".equals(detail_del))
		{
			detail = "";
		}
		
		lect_dao.upPeltImg(store, period, subject_cd, thumbnail, detail);
		
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
//		String filename = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("attach")), uploadPath, 1);
		List<HashMap<String, Object>> list = lect_dao.getPlanDetail(store, period, subject_cd);
		if(list.size() > 0)
		{
//			if("".equals(filename) && list.get(0).get("IMAGE_PIC") != null)
//			{
//				filename = list.get(0).get("IMAGE_PIC").toString();
//			}
			lect_dao.upPlan(store, period, subject_cd, subject_nm, lecturer_nm, lecturer_career, lecture_content, etc, login_seq);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의계획서 수정", store+"/"+period+"/"+subject_cd);
		}
		else
		{
			lect_dao.insPlan(store, period, subject_cd, subject_nm, lecturer_nm, lecturer_career, lecture_content, etc, login_seq);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의계획서 등록", store+"/"+period+"/"+subject_cd);
		}
		
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		return mav;
	}
	@Transactional
	@RequestMapping("/insRecomLect")
	@ResponseBody
	public HashMap<String, Object> insRecomLect(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_arr[] = Utils.checkNullString(request.getParameter("subject_arr")).split("\\|");
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		for(int i = 0; i < subject_arr.length; i++)
		{
			String subject_cd = subject_arr[i];
			int cnt = web_dao.getRecoCnt(store, period, subject_cd);
			if(cnt > 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "이미 등록되어있습니다.");
				return map;
			}
			else
			{
				web_dao.insRecomLect(store, period, subject_cd, login_seq);
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "추천 강좌 등록", store+"/"+period+"/"+subject_cd);
			}
		}
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@RequestMapping("/insTagByReco")
	@ResponseBody
	public HashMap<String, Object> insTagByReco(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String tag = Utils.checkNullString(request.getParameter("tag"));
		
		web_dao.insTagByReco(store, period, subject_cd, tag);
		
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@RequestMapping("/delTagByReco")
	@ResponseBody
	public HashMap<String, Object> delTagByReco(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String tag = Utils.checkNullString(request.getParameter("tag"));
		
		web_dao.delTagByReco(store, period, subject_cd, tag);
		
		
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@Transactional
	@RequestMapping("/delReco")
	@ResponseBody
	public HashMap<String, Object> delReco(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String seq[] = Utils.checkNullString(request.getParameter("seq")).split(",");
		for(int i = 0; i < seq.length; i++)
		{
			if(!"".equals(seq[i].split("_")[0]) && !"".equals(seq[i].split("_")[1]) && !"".equals(seq[i].split("_")[2]))
			{
				String store = seq[i].split("_")[0];
				String period = seq[i].split("_")[1];
				String subject_cd = seq[i].split("_")[2];
				web_dao.delReco(store, period, subject_cd); 
			}
		}
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
	@RequestMapping("/sortReco")
	@ResponseBody
	public void sortReco(HttpServletRequest request) {
		String seq = Utils.checkNullString(request.getParameter("seq"));
		String store = seq.split("_")[0];
		String period = seq.split("_")[1];
		String subject_cd = seq.split("_")[2];
		String sort = Utils.checkNullString(request.getParameter("sort"));
		
		web_dao.sortReco(store, period, subject_cd, sort);
	}
	@RequestMapping("/insCanc")
	@ResponseBody
	public HashMap<String, Object> insCanc(HttpServletRequest request) {
		
		String contents = Utils.repWord(Utils.checkNullString(request.getParameter("contents")));
		
		web_dao.insCanc(contents);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강의계획서 취소/환불 규정 수정", "");
	    return map;
	}
	@RequestMapping("/preview_main")
	public ModelAndView preview_main(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/web/preview_main");
		
		return mav;
	}
	@RequestMapping("/getPrevPlan")
	@ResponseBody
	public HashMap<String, Object> getPrevPlan(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		if(!"".equals(store) && !"".equals(period) && !"".equals(subject_cd))
		{
			List<HashMap<String, Object>> peri_list = lect_dao.getPrevPeri(store); // 전 기수가 몇기인지 가져옵니다.

			String prev_period = "";
			int size = peri_list.size();
			for (int i = 0; i < size; i++) 
			{
				if (period.equals(Utils.checkNullString(peri_list.get(i).get("PERIOD")))) {
					if ((i + 1) < (size)) {
						prev_period = Utils.checkNullString(peri_list.get(i + 1).get("PERIOD")); // 전 기수 셋팅
					}
				}
			}
			lect_dao.insWlecPrev_one(store, period, prev_period, subject_cd); //전기의 강의계호기서를 불러옵니다.
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "강좌정보 오류");
			return map;
		}
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		return map;
	}
}