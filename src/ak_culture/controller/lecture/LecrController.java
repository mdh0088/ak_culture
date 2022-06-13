package ak_culture.controller.lecture;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ak_culture.classes.EPApproval;
import ak_culture.classes.Utils;
import ak_culture.model.akris.AkrisDAO;
import ak_culture.model.basic.GiftDAO;
import ak_culture.model.basic.UserDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.lecture.LecrDAO;

@Controller
@RequestMapping("/lecture/lecr/*")

public class LecrController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private LecrDAO lecr_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private UserDAO user_dao;
	
	@Autowired
	private GiftDAO gift_dao;
	
	@Autowired
	private AkrisDAO akris_dao;
	
	@Value("${upload_dir}")
	private String upload_dir;
	@Value("${image_dir}")
	private String image_dir;
	
	
	
	public AkrisDAO getAkris_dao() {
		return akris_dao;
	}
	public void setAkris_dao(AkrisDAO akris_dao) {
		this.akris_dao = akris_dao;
	}
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/list");
		
		HttpSession session = request.getSession();
		Utils.setPeriControllerAll(mav, common_dao, session);
		mav.addObject("year", Utils.getDateNow("year"));
		
		return mav;
	}
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/write");
		
		List<HashMap<String, Object>> bank_list = lecr_dao.getBankCdCombo();
		
		mav.addObject("bank_list", bank_list);
		
		return mav;
	}
	@Transactional
	@RequestMapping("/trans_proc")
	public ModelAndView trans_proc(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/trans_proc");
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
        String uploadPath = upload_dir+"lecrTrans/";
        
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		String idList[] = Utils.checkNullString(multi.getParameter("idList")).split("\\|");
		String lineList[] = Utils.checkNullString(multi.getParameter("lineList")).split("\\|");
		String fileList[] = Utils.checkNullString(multi.getParameter("fileList")).split("\\|");
		String chkList[] = Utils.checkNullString(multi.getParameter("chkList")).split(",");
		String htmlContent = Utils.checkNullString(multi.getParameter("htmlContent"));
		EPApproval app = new EPApproval();
		
//		for(int i = 0; i < fileList.length; i++)
//		{
//			String trans_file = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("trans_file_"+fileList[i])), uploadPath, (i+1));
//			
//			htmlContent += "<li><a href=\""+image_dir+"lecrTrans/"+trans_file+"\" target=\"_blank\">첨부파일"+(i+1)+"</a></li>";
//		}
		
		
		app.setSubject(multi.getParameter("subject"));
		app.setContents("<ul>"+htmlContent+"</ul>", EPApproval.HTML); //여기에 나중에 첨부파일넣고 그렇게하자..
		app.setResultProcedure("PR_BA_LECTURER_APPROVAL");
		
		String id = login_seq;
		String line = "0";
		app.addParticipant(id, line);
		for(int i = 0; i < idList.length; i++)
		{
			id = idList[i];
			line = lineList[i];
			app.addParticipant(id, line);
		}
		//상신
		String approval_no = akris_dao.submit(app);
		System.out.println("approval_no : "+approval_no);
		System.out.println("Utils.checkNullString(multi.getParameter(\"chkList\")) : "+Utils.checkNullString(multi.getParameter("chkList")));
		
		//blob에 파일넣기
		if(fileList.length > 0 && !"".equals(Utils.checkNullString(multi.getParameter("fileList"))))
		{
			String file_no = akris_dao.getNamoFileNo();
			InputStream is = null;
			for(int i = 0; i < fileList.length; i++)
			{
				String trans_file = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("trans_file_"+fileList[i])), uploadPath, (i+1));
				File f = new File(upload_dir+"lecrTrans/"+trans_file);
				MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
				
				byte[] file_obj = Utils.imageToByteArray(upload_dir+"lecrTrans/"+trans_file);
				long file_size = f.length();
				String content_type = mimeTypesMap.getContentType(upload_dir+"lecrTrans/"+trans_file);
				String file_id = Utils.generateUniqueId();
				
				akris_dao.insNamoFile(file_no, file_id, trans_file, file_size, content_type, file_obj, login_seq);
				
				file_no = akris_dao.issueAttachFileNo();
				akris_dao.insertBCFILETB(file_no, trans_file, file_size, file_obj);
				akris_dao.insertBCEPBFTB(trans_file, file_size, file_no, app.getSystem_id(), app.getView_id(), app.getSubmit_date(), app.getSeq());
			}
			
		}
		
		lecr_dao.upLecrAppr(approval_no, Utils.checkNullString(multi.getParameter("chkList")));
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "저장되었습니다.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "거래선 상신", Utils.checkNullString(multi.getParameter("chkList")).replaceAll("'", ""));
		return mav;
	}
	@RequestMapping("/lecr_eval")
	public ModelAndView lecr_eval(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/lecr_eval");
		
		return mav;
	}
	@Transactional
	@RequestMapping("/write_proc1")
	public ModelAndView write_proc1(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/write_proc1");
		
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		if("".equals(cus_no))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "강사 검색을 먼저 해주세요.");
			
			return mav;
		}
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String rep_store = "";
		
		String isBonbu = Utils.checkNullString(session.getAttribute("isBonbu"));
		if("T".equals(isBonbu))
		{
			rep_store = "03";
		}
		else
		{
			rep_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
		}
		String car_no = Utils.checkNullString(request.getParameter("car_no"));
//		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd")).replaceAll("-", "");
		String lecturer_cd_connect = Utils.checkNullString(request.getParameter("lecturer_cd_connect")).replaceAll("-", "");
		String lecturer_cd_ori = Utils.checkNullString(request.getParameter("lecturer_cd_ori")).replaceAll("-", "");
		
		System.out.println("lecturer_cd_connect : "+lecturer_cd_connect);
		System.out.println("lecturer_cd_ori : "+lecturer_cd_ori);
		
		
		String point_1 = Utils.checkNullString(request.getParameter("1_point"));
		String point_2 = Utils.checkNullString(request.getParameter("2_point"));
		String point_3 = Utils.checkNullString(request.getParameter("3_point"));
		String point_4 = Utils.checkNullString(request.getParameter("4_point"));
		String point_5 = "";
		String point_5_1 = Utils.checkNullString(request.getParameter("5_point_1"));
		String point_5_2 = Utils.checkNullString(request.getParameter("5_point_2"));
		String point_5_3 = Utils.checkNullString(request.getParameter("5_point_3"));
		String point_5_4 = Utils.checkNullString(request.getParameter("5_point_4"));
		if("on".equals(point_5_1))
		{
			point_5 += "언론매체 출연|";
		}
		if("on".equals(point_5_2))
		{
			point_5 += "관련 저서|";
		}
		if("on".equals(point_5_3))
		{
			point_5 += "입상 및 자격증|";
		}
		if("on".equals(point_5_4))
		{
			point_5 += "기타|";
		}
		String school = Utils.checkNullString(request.getParameter("school"));
		String school_cate = Utils.checkNullString(request.getParameter("school_cate"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd_list"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd_list"));
		String history = Utils.checkNullString(request.getParameter("history_list"));
		String other = Utils.repWord(Utils.checkNullString(request.getParameter("other")));
		String point = Utils.checkNullString(request.getParameter("t_point"));
		
		
		String isIn = Utils.checkNullString(request.getParameter("isIn"));
		
		
		if("".equals(lecturer_cd_connect))
		{
			lecturer_cd_connect = "0000000000000";
		}
		if("신규강사".equals(isIn))
		{
			lecr_dao.insLecture(lecturer_cd_connect, cus_no, car_no, point_1, point_2, point_3, point_4, point_5, school, school_cate, start_ymd, end_ymd, history, other, point, login_seq, rep_store);
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사 등록", cus_no);
		}
		else if("기존강사".equals(isIn))
		{
			if(!lecturer_cd_ori.equals(lecturer_cd_connect))
			{
				String corp_tb = lecr_dao.getConnectInfo(lecturer_cd_ori);
				List<HashMap<String, Object>> list = lecr_dao.getConnectPelt(cus_no, lecturer_cd_ori);
				for(int i = 0; i < list.size(); i++)
				{
					String store = Utils.checkNullString(list.get(i).get("STORE"));
					String period = Utils.checkNullString(list.get(i).get("PERIOD"));
					String subject_cd = Utils.checkNullString(list.get(i).get("SUBJECT_CD"));
					int cnt = lecr_dao.getJrCnt(store, period, subject_cd, corp_tb, lecturer_cd_ori);
					if(cnt > 0)
					{
						mav.addObject("isSuc", "fail");
						mav.addObject("msg", "강사료가 마감된 이후 거래선을 변경할 수 없습니다.");
						return mav;
					}
				}
			}
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사 수정", cus_no);
			lecr_dao.upLecture(lecturer_cd_connect, cus_no, car_no, point_1, point_2, point_3, point_4, point_5, school, school_cate, start_ymd, end_ymd, history, other, point, login_seq);
			lecr_dao.upPeltLecturer(lecturer_cd_ori, lecturer_cd_connect, cus_no);
		}
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		
		return mav;
	}
	@Transactional
	@RequestMapping("/modify_point")
	public ModelAndView modify_point(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/modify_point");
		
		
		String cus_no = Utils.checkNullString(request.getParameter("point_cus_no"));
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String rep_store = "";
		
		String isBonbu = Utils.checkNullString(session.getAttribute("isBonbu"));
		if("T".equals(isBonbu))
		{
			rep_store = "03";
		}
		else
		{
			rep_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
		}
		String car_no = Utils.checkNullString(request.getParameter("car_no"));
		
		
		String point_1 = Utils.checkNullString(request.getParameter("1_point"));
		String point_2 = Utils.checkNullString(request.getParameter("2_point"));
		String point_3 = Utils.checkNullString(request.getParameter("3_point"));
		String point_4 = Utils.checkNullString(request.getParameter("4_point"));
		String point_5 = "";
		String point_5_1 = Utils.checkNullString(request.getParameter("5_point_1"));
		String point_5_2 = Utils.checkNullString(request.getParameter("5_point_2"));
		String point_5_3 = Utils.checkNullString(request.getParameter("5_point_3"));
		String point_5_4 = Utils.checkNullString(request.getParameter("5_point_4"));
		if("on".equals(point_5_1))
		{
			point_5 += "언론매체 출연|";
		}
		if("on".equals(point_5_2))
		{
			point_5 += "관련 저서|";
		}
		if("on".equals(point_5_3))
		{
			point_5 += "입상 및 자격증|";
		}
		if("on".equals(point_5_4))
		{
			point_5 += "기타|";
		}
		String school = Utils.checkNullString(request.getParameter("school"));
		String school_cate = Utils.checkNullString(request.getParameter("school_cate"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd_list"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd_list"));
		String history = Utils.checkNullString(request.getParameter("history_list"));
		String other = Utils.repWord(Utils.checkNullString(request.getParameter("other")));
		String point = Utils.checkNullString(request.getParameter("t_point"));
		
		
		
		lecr_dao.upLecture_point(cus_no, point_1, point_2, point_3, point_4, point_5, school, school_cate, start_ymd, end_ymd, history, other, point, login_seq);
		
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사 평가 수정", cus_no);
		return mav;
	}
	@Transactional
	@RequestMapping("/write_proc2")
	public ModelAndView write_proc2(HttpServletRequest request) {
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/write_proc2");
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd_lecr")).replaceAll("-", "");
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String biz_no = Utils.checkNullString(request.getParameter("biz_no")).replaceAll("-", "");
		String bank_cd = Utils.checkNullString(request.getParameter("bank_cd"));
		String account_nm = Utils.checkNullString(request.getParameter("account_nm"));
		String account_no = Utils.checkNullString(request.getParameter("account_no"));
		String biz_nm = Utils.checkNullString(request.getParameter("biz_nm"));
		String president_nm = Utils.checkNullString(request.getParameter("president_nm"));
		String industry_c = Utils.checkNullString(request.getParameter("industry_c"));
		String industry_s = Utils.checkNullString(request.getParameter("industry_s"));
		String biz_post_no = Utils.checkNullString(request.getParameter("biz_post_no"));
		String biz_addr_tx1 = Utils.checkNullString(request.getParameter("biz_addr_tx1"));
		String biz_addr_tx2 = Utils.checkNullString(request.getParameter("biz_addr_tx2"));
		String biz_addr = biz_addr_tx1 + " " + biz_addr_tx2; 
		String lecturer_kor_nm = "";
		
		
		try
		{
			if("1".equals(corp_fg))
			{
				lecturer_kor_nm = president_nm;
			}
			else if("2".equals(corp_fg))
			{
				lecturer_kor_nm = account_nm;
			}
			
			String rep_store = "";
			String isBonbu = Utils.checkNullString(session.getAttribute("isBonbu"));
			if("T".equals(isBonbu))
			{
				rep_store = "03";
			}
			else
			{
				rep_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
			}
			
			HashMap<String, Object> data = lecr_dao.getLecrCntAsLine(lecturer_cd);
			
			//2021-10-14 현정님 요청으로 수정
//			if(Utils.checkNullInt(data.get("LINE_CNT")) > 0)
//			{
//				mav.addObject("isSuc", "fail");
//				mav.addObject("msg", "이미 거래선 상신 완료된 강사입니다. 수정이 불가합니다.");
//				return mav;
//			}
			if(Utils.checkNullInt(data.get("NOTLINE_CNT")) > 0)
			{
				lecr_dao.upLecr(lecturer_cd, lecturer_kor_nm, corp_fg, biz_no, bank_cd, account_nm, account_no, biz_nm, president_nm, industry_c, industry_s, biz_post_no, biz_addr, biz_addr_tx1, biz_addr_tx2, login_seq);
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "거래선 수정", lecturer_cd);
			}
			else
			{
				lecr_dao.insLecr(lecturer_cd, lecturer_kor_nm, corp_fg, biz_no, bank_cd, account_nm, account_no, biz_nm, president_nm, industry_c, industry_s, biz_post_no, biz_addr, biz_addr_tx1, biz_addr_tx2, login_seq, rep_store);
				lecr_dao.insAkhracLine(corp_fg, lecturer_cd, login_seq);
				common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "거래선 등록", lecturer_cd);
			}
			
			mav.addObject("isSuc", "success");
			mav.addObject("msg", "성공적으로 저장되었습니다.");
			return mav;
		}
		catch(Exception e)
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "오류가 발생되었습니다.");
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return mav;
		}
	}
//	@RequestMapping("/modify_proc")
//	public ModelAndView modify_proc(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("/WEB-INF/pages/lecture/lecr/modify_proc");
//		String cus_no = Utils.checkNullString(request.getParameter("cus_no2"));
//		String car_no = Utils.checkNullString(request.getParameter("car_no"));
//		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd")).replaceAll("-", "");
//		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
//		String biz_no = Utils.checkNullString(request.getParameter("biz_no")).replaceAll("-", "");
//		String bank_cd = Utils.checkNullString(request.getParameter("bank_cd"));
//		String account_nm = Utils.checkNullString(request.getParameter("account_nm"));
//		String account_no = Utils.checkNullString(request.getParameter("account_no")).replaceAll("-", "");
//		String biz_nm = Utils.checkNullString(request.getParameter("biz_nm"));
//		String president_nm = Utils.checkNullString(request.getParameter("president_nm"));
//		String industry_c = Utils.checkNullString(request.getParameter("industry_c"));
//		String industry_s = Utils.checkNullString(request.getParameter("industry_s"));
//		String biz_post_no = Utils.checkNullString(request.getParameter("biz_post_no"));
//		String biz_addr_tx1 = Utils.checkNullString(request.getParameter("biz_addr_tx1"));
//		String biz_addr_tx2 = Utils.checkNullString(request.getParameter("biz_addr_tx2"));
//		String biz_addr = biz_addr_tx1 + " " + biz_addr_tx2; 
//		
//		lecr_dao.upLecr(cus_no, lecturer_cd, corp_fg, biz_no, bank_cd, account_nm, account_no, biz_nm, president_nm, industry_c, industry_s, biz_post_no, biz_addr, biz_addr_tx1, biz_addr_tx2);
//		
//		String memo_list = Utils.checkNullString(request.getParameter("memo_list"));
//		
//		String[] memo_list_array =memo_list.split("\\|");
//		
//		HttpSession session = request.getSession();
//		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
//		
//		if (!memo_list.equals("")) {
//			for (int i = 0; i < memo_list_array.length; i++) {
//				lecr_dao.ins_memo(cus_no,memo_list_array[i],login_seq);
//			}
//		}
//		
//		mav.addObject("isSuc", "success");
//		mav.addObject("msg", "성공적으로 저장되었습니다.");
//		
//		return mav;
//	}
	@RequestMapping("/getUserList")
	@ResponseBody
	public List<HashMap<String, Object>> getUserList(HttpServletRequest request) {
		
		String searchPhone = Utils.checkNullString(request.getParameter("searchPhone"));
		List<HashMap<String, Object>> list = common_dao.getUser_byPhone(searchPhone);  
			
	    return list;
	}
	@RequestMapping("/getAmsList")
	@ResponseBody
	public List<HashMap<String, Object>> getAmsList(HttpServletRequest request) {
		
		String searchPhone = Utils.checkNullString(request.getParameter("searchPhone"));
		List<HashMap<String, Object>> list = common_dao.getAms_byPhone(searchPhone);  
		
		return list;
	}
	@RequestMapping("/getLecrList")
	@ResponseBody
	public List<HashMap<String, Object>> getLecrList(HttpServletRequest request) {
		
		String searchLecr = Utils.checkNullString(request.getParameter("searchLecr"));
		List<HashMap<String, Object>> list = lecr_dao.getLecrToLine(searchLecr);  
		
		return list;
	}
	@RequestMapping("/getLectureDetail")
	@ResponseBody
	public HashMap<String, Object> getLectureDetail(HttpServletRequest request) {
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		HashMap<String, Object> data = lecr_dao.getLectureDetail(cus_no);  
		return data;
	}
	@RequestMapping("/getLectListByLecr")
	@ResponseBody
	public HashMap<String, Object> getLectListByLecr(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
//		List<HashMap<String, Object>> list = lecr_dao.getLectListByLecr(store, period, cus_no);
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		List<HashMap<String, Object>> listCnt = lecr_dao.getLectListByLecrCount(store, period, cus_no);
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
		
		List<HashMap<String, Object>> list = lecr_dao.getLectListByLecr(s_point, listSize*page, order_by, sort_type, store, period, cus_no); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		return map;
	}
	@RequestMapping("/getLectListByLecr2")
	@ResponseBody
	public List<HashMap<String, Object>> getLectListByLecr2(HttpServletRequest request) {
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
		String selYear2 = Utils.checkNullString(request.getParameter("selYear2"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
		String selSeason2 = Utils.checkNullString(request.getParameter("selSeason2"));
		
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String start_peri = "";
		String end_peri = "";
		if(!"".equals(store))
		{
			branchList = common_dao.getPeriList(store, selYear1, selSeason1);
			if(branchList.size() > 0)
			{
				start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
			branchList = common_dao.getPeriList(store, selYear2, selSeason2);
			if(branchList.size() > 0)
			{
				end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
		}
		//기수 검색
		List<HashMap<String, Object>> list = lecr_dao.getLectListByLecr2(cus_no, store, start_peri, end_peri); 
		return list;
	}
	@RequestMapping("/getApplyList")
	@ResponseBody
	public HashMap<String, Object> getApplyList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String aply_type = Utils.checkNullString(request.getParameter("aply_type"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		String status = Utils.checkNullString(request.getParameter("status"));
		
		List<HashMap<String, Object>> listCnt = lecr_dao.getApplyListCount(store,aply_type,search_type,search_name,start_ymd,end_ymd,status);
		List<HashMap<String, Object>> listCnt_all = lecr_dao.getApplyListCount("", "", "", "", "", "","");
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
		
		List<HashMap<String, Object>> list = lecr_dao.getApplyList(s_point, listSize*page, order_by, sort_type,store,aply_type,search_type,search_name,start_ymd,end_ymd,status); 
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
	@RequestMapping("/getLecrDetail")
	@ResponseBody
	public HashMap<String, Object> getLecrDetail(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String grade = Utils.checkNullString(request.getParameter("grade"));
		String selYear1 = Utils.checkNullString(request.getParameter("selYear1"));
		String selYear2 = Utils.checkNullString(request.getParameter("selYear2"));
		String selSeason1 = Utils.checkNullString(request.getParameter("selSeason1"));
		String selSeason2 = Utils.checkNullString(request.getParameter("selSeason2"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String status_fg = Utils.checkNullString(request.getParameter("status_fg"));
		
		//평가결과
		String start_point = "";
		String end_point = "";
		if("A".equals(grade))
		{
			start_point = "90";
			end_point = "101";
		}
		else if("B".equals(grade))
		{
			start_point = "80";
			end_point = "90";
		}
		else if("C".equals(grade))
		{
			start_point = "70";
			end_point = "80";
		}
		else if("D".equals(grade))
		{
			start_point = "60";
			end_point = "70";
		}
		else if("E".equals(grade))
		{
			start_point = "50";
			end_point = "60";
		}
		//평가결과
		
		//기수 검색
		List<HashMap<String, Object>> branchList = null;
		String start_peri = "";
		String end_peri = "";
		if(!"".equals(store))
		{
			branchList = common_dao.getPeriList(store, selYear1, selSeason1);
			if(branchList.size() > 0)
			{
				start_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
			branchList = common_dao.getPeriList(store, selYear2, selSeason2);
			if(branchList.size() > 0)
			{
				end_peri = Utils.checkNullString(branchList.get(0).get("PERIOD"));
			}
		}
		//기수 검색
		
		List<HashMap<String, Object>> listCnt = lecr_dao.getLecrCount(search_name, store, start_point, end_point, start_peri, end_peri, subject_fg,status_fg);
		List<HashMap<String, Object>> listCnt_all = lecr_dao.getLecrCount("", store, "", "", start_peri, end_peri, "","");
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
		
		List<HashMap<String, Object>> list = lecr_dao.getLecr(s_point, listSize*page, order_by, sort_type, search_name, store, start_point, end_point, start_peri, end_peri, subject_fg,status_fg);
		
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
		map.put("grade", grade);
		
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사조회", store+"/"+start_peri+"~"+end_peri);
		return map;
	}
	@Transactional
	@RequestMapping("/ins_memo")
	@ResponseBody
	public HashMap<String, Object> insMemo(HttpServletRequest request) {
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		String memo_list = Utils.checkNullString(request.getParameter("memo_list"));
		String[] memo_list_array =memo_list.split("\\|");
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		if (!memo_list.equals("")) {
			for (int i = 0; i < memo_list_array.length; i++) {
				lecr_dao.ins_memo(cus_no,memo_list_array[i],login_seq);
			}
		}
		
	
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "성공적으로 저장되었습니다.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사 메모 등록", cus_no);
		return map;
	}
	@RequestMapping("/getLecrDetailByTransaction")
	@ResponseBody
	public List<HashMap<String, Object>> getLecrDetailByTransaction(HttpServletRequest request) {
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		List<HashMap<String, Object>> list = lecr_dao.getLecrDetailByTransaction(chkList);
		return list;
	}
	@RequestMapping("/delLecr")
	@ResponseBody
	public HashMap<String, Object> delLecr(HttpServletRequest request) {
		String chkList = Utils.checkNullString(request.getParameter("chkList"));
		lecr_dao.delLecr(chkList);
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "성공적으로 저장되었습니다.");
		
		return map;
	}
	@Transactional
	@RequestMapping("/del_memo")
	@ResponseBody
	public HashMap<String, Object> del_memo(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		String reg_no = Utils.checkNullString(request.getParameter("reg_no"));
		
		lecr_dao.del_memo(cus_no,reg_no);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "성공적으로 저장되었습니다.");
		
		return map;
	}
	
	@RequestMapping("/getReview")
	@ResponseBody
	public HashMap<String, Object> getReview(HttpServletRequest request) {
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String reg_no = Utils.checkNullString(request.getParameter("reg_no"));
		
		HashMap<String, Object> data = lecr_dao.getReview(cust_no,reg_no);
		
		return data;
	}
	
	@RequestMapping("/listed")
	public ModelAndView listed(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/listed");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		String cus_no = Utils.checkNullString(request.getParameter("cn"));
		HashMap<String, Object> lecr = lecr_dao.getLecrOne(cus_no);
		HashMap<String, Object> lect_cnt = lecr_dao.getLectCountByLecr(cus_no);
		mav.addObject("lecr",lecr);
		mav.addObject("total_lect_cnt",lect_cnt.get("CNT"));
		List<HashMap<String, Object>> lecr_point = lecr_dao.getLepoByCust(cus_no);
		
		mav.addObject("lecr_point", lecr_point);
		
		String login_name = Utils.checkNullString(session.getAttribute("login_name"));
		mav.addObject("login_name", login_name);
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사 상세조회", cus_no);
		return mav;
	}
	@Transactional
	@RequestMapping("/saveReview")
	public ModelAndView saveReview(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/saveReview");
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String reg_no = Utils.checkNullString(request.getParameter("reg_no"));
		String review = Utils.checkNullString(request.getParameter("review"));
		review = Utils.repWord(review);
		
		try {
			int result = lecr_dao.saveReview(cust_no,reg_no, review);
			if (result < 1) {
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "알 수 없는 오류 발생.");
				return mav;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생.");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		mav.addObject("isSuc", "success");
		mav.addObject("msg", "성공적으로 저장되었습니다.");
		
		return mav;
	}
	
	
	@RequestMapping("/contract")
	public ModelAndView contract(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/contract");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
	
		return mav;
	}
	
	
	
	@RequestMapping("/getcontlist")
	@ResponseBody
	public HashMap<String, Object> getcontlist(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		String contract_type01 = Utils.checkNullString(request.getParameter("contract_type01"));
		String contract_type02 = Utils.checkNullString(request.getParameter("contract_type02"));
		String contract_type03 = Utils.checkNullString(request.getParameter("contract_type03"));
		String contract_type04 = Utils.checkNullString(request.getParameter("contract_type04"));
		
		
		

		
		List<HashMap<String, Object>> listCnt = lecr_dao.getContractCount(store,period,search_type, search_name,
																		subject_fg,contract_type01,contract_type02,contract_type03,contract_type04);
		List<HashMap<String, Object>> listCnt_all = lecr_dao.getContractCount(store, period, "", "", "","", "","","");
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
		
		List<HashMap<String, Object>> list = lecr_dao.getContract(s_point, listSize*page, order_by, sort_type, search_type, search_name,store,period,
																subject_fg,contract_type01,contract_type02,contract_type03,contract_type04);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("listCnt", listCnt.get(0).get("CNT"));
		map.put("listCnt_all", listCnt_all.get(0).get("CNT"));
		
		map.put("list", list);
		map.put("page", page);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("search_name", search_name);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("listSize", listSize);
		
		return map;
	}
	@Transactional
	@RequestMapping("/contract_write")
	public ModelAndView contract_write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/contract_write");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		
		
		HashMap<String, Object> data = lecr_dao.getapplicntInfo(store,period,subject_cd,cus_no);
		for (String key : data.keySet()) {
			System.out.println(key+":"+data.get(key));				
			mav.addObject(key, data.get(key));
		}
		
		String cont_day =  Utils.checkNullString(data.get("CONTRACT_DAY"));
		
		if (!cont_day.equals("")) {
			mav.addObject("CONT_YEAR", cont_day.substring(0, 4));
			mav.addObject("CONT_MON", cont_day.substring(4, 6));
			mav.addObject("CONT_DAY", cont_day.substring(6, 8));
		}
		else
		{
			mav.addObject("CONT_YEAR", "0000");
			mav.addObject("CONT_MON", "00");
			mav.addObject("CONT_DAY", "00");
		}
		
		int regis_fee = Utils.checkNullInt(data.get("REGIS_FEE"));
	    int food_amt = 0;
	    if("Y".equals(Utils.checkNullString(data.get("FOOD_YN"))))
	    {
	       food_amt = Utils.checkNullInt(data.get("FOOD_AMT"));
	    }
	    int lect_cnt = Utils.checkNullInt(data.get("LECT_CNT"));
	    int mid_regis_fee = (int) Math.round((double)regis_fee / lect_cnt );
	    mid_regis_fee = (mid_regis_fee + 5)/10 * 10; //일의자리 반올림하기위함 
	      
	      
	    int mid_food_amt = 0;
	    if("Y".equals(Utils.checkNullString(data.get("FOOD_YN"))))
	    {
	       mid_food_amt = (int) Math.round((double)food_amt / lect_cnt);
	       mid_food_amt = (mid_food_amt + 5)/10 * 10; //일의자리 반올림하기위함 
	    }
		
	    mav.addObject("lect_cnt", lect_cnt);
	    mav.addObject("regis_fee", regis_fee);
	    mav.addObject("mid_regis_fee", mid_regis_fee);
	    mav.addObject("mid_food_amt", mid_food_amt);
	    return mav;
	}
	
	@RequestMapping("/transaction")
	public ModelAndView transaction(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/transaction");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		String login_name = Utils.checkNullString(session.getAttribute("login_name"));
		String login_sct_nm = Utils.checkNullString(session.getAttribute("login_sct_nm"));
		mav.addObject("login_name", login_name);
		mav.addObject("login_sct_nm", login_sct_nm);
		Utils.setPeriControllerAll(mav, common_dao, session);
		return mav;
	}
	
	@RequestMapping("/certificate")
	public ModelAndView certificate(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/certificate");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		return mav;
	}
	
	@RequestMapping("/list_new")
	public ModelAndView list_new(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/list_new");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		mav.addObject("year", Utils.getDateNow("year"));
		
		return mav;
	}
	@RequestMapping("/getNewLecrDetail")
	@ResponseBody
	public HashMap<String, Object> getNewLecrDetail(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String grade = Utils.checkNullString(request.getParameter("grade"));
		String subject_fg = Utils.checkNullString(request.getParameter("subject_fg"));
		
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd")).replaceAll("-", "");
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd")).replaceAll("-", "");
		
		//평가결과
		String start_point = "";
		String end_point = "";
		if("A".equals(grade))
		{
			start_point = "90";
			end_point = "101";
		}
		else if("B".equals(grade))
		{
			start_point = "80";
			end_point = "90";
		}
		else if("C".equals(grade))
		{
			start_point = "70";
			end_point = "80";
		}
		else if("D".equals(grade))
		{
			start_point = "60";
			end_point = "70";
		}
		else if("E".equals(grade))
		{
			start_point = "50";
			end_point = "60";
		}
		//평가결과
		
		
		List<HashMap<String, Object>> listCnt = lecr_dao.getNewLecrDetailCount(search_name, store, start_point, end_point, start_ymd, end_ymd, subject_fg);
		List<HashMap<String, Object>> listCnt_all = lecr_dao.getNewLecrDetailCount("", store, "", "", "", "", "");
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
		
		List<HashMap<String, Object>> list = lecr_dao.getNewLecrDetail(s_point, listSize*page, order_by, sort_type, search_name, store, start_point, end_point, start_ymd, end_ymd, subject_fg);
		for(int i = 0; i < list.size(); i++)
		{
			String cus_no = Utils.checkNullString(list.get(i).get("CUS_NO"));
			List<HashMap<String, Object>> lecr_list = lecr_dao.getLecrDetail(cus_no, store, "", "", subject_fg);
			if(lecr_list.size() > 0)
			{
				list.get(i).put("STORE_NM", lecr_list.get(0).get("STORE_NM"));
				list.get(i).put("WEB_TEXT", lecr_list.get(0).get("WEB_TEXT"));
				list.get(i).put("MAIN_NM", lecr_list.get(0).get("MAIN_NM"));
				list.get(i).put("SECT_NM", lecr_list.get(0).get("SECT_NM"));
				list.get(i).put("POINT", lecr_list.get(0).get("POINT"));
				list.get(i).put("REGIS_NO", lecr_list.get(0).get("REGIS_NO"));
				list.get(i).put("FIX_PAY_YN", lecr_list.get(0).get("FIX_PAY_YN"));
				list.get(i).put("FIX_AMT", lecr_list.get(0).get("FIX_AMT"));
				list.get(i).put("FIX_RATE", lecr_list.get(0).get("FIX_RATE"));
				list.get(i).put("SUBJECT_NM", lecr_list.get(0).get("SUBJECT_NM"));
				list.get(i).put("SUBJECT_FG_NM", lecr_list.get(0).get("SUBJECT_FG_NM"));
			}
		}
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
		map.put("grade", grade);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "신규강사 평가리스트 조회", store);
		return map;
	}
	@RequestMapping("/status")
	public ModelAndView status(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/status");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		mav.addObject("login_rep_store", session.getAttribute("login_rep_store").toString());	
		mav.addObject("login_rep_store_nm", session.getAttribute("login_rep_store_nm").toString());	
		return mav;
	}
	
	@RequestMapping("/trans_master")
	public ModelAndView trans_master(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/trans_master");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		return mav;
	}
	
	
	@RequestMapping("/certificate_list")
	public ModelAndView certificate_list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/certificate_list");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		return mav;
	}
	@RequestMapping("/certificate_tax")
	public ModelAndView certificate_tax(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/certificate_tax");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		mav.addObject("year", Utils.getDateNow("year"));
		return mav;
	}
	@RequestMapping("/tax")
	public ModelAndView tax(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/tax");
		String lecturer_nm = Utils.checkNullString(request.getParameter("lecturer_nm"));
		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd"));
		String cus_address = Utils.checkNullString(request.getParameter("cus_address"));
		String biz_nm = Utils.checkNullString(request.getParameter("biz_nm"));
		String biz_no = Utils.checkNullString(request.getParameter("biz_no"));
		String biz_addr_tx = Utils.checkNullString(request.getParameter("biz_addr_tx"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		String tb = "";
		if("1".equals(corp_fg))
		{
			tb = "co";
		}
		else if("2".equals(corp_fg))
		{
			tb = "pr";
		}
		String subject_list = Utils.checkNullString(request.getParameter("subject_list"));
		subject_list = subject_list.substring(0, subject_list.length()-1);
		
		String selSubject = "";
		for(int i = 0; i < subject_list.split("\\|").length; i++)
		{
			if(i != 0)
			{
				selSubject += ",";
			}
			selSubject += "\'"+subject_list.split("\\|")[i]+"\'";
		}
		
		
		
		List<HashMap<String, Object>> list = lecr_dao.getTaxDetail(store, period, lecturer_cd, selSubject, tb);  
		mav.addObject("lecturer_nm",lecturer_nm);
		mav.addObject("lecturer_cd",lecturer_cd);
		mav.addObject("cus_address",cus_address);
		mav.addObject("biz_nm",biz_nm);
		mav.addObject("biz_no",biz_no);
		mav.addObject("biz_addr_tx",biz_addr_tx);
		mav.addObject("store",store);
		mav.addObject("period",period);
		mav.addObject("subject_list",subject_list);
		mav.addObject("selSubject",selSubject);
		mav.addObject("list",list);
		mav.addObject("y",Utils.getDateNow("year"));
		mav.addObject("m",Utils.getDateNow("month"));
		mav.addObject("d",Utils.getDateNow("day"));
		
		if("02".equals(store))
		{
			mav.addObject("ak_biz_no", "124-81-28579");
			mav.addObject("ak_corp_no", "130111-0034487");
			mav.addObject("ak_biz_nm", "수원애경역사 (주)");
			mav.addObject("ak_biz_addr", "경기도 수원시 팔달구 덕영대로 924, 1층(매산로 1가)");
		}
		if("03".equals(store))
		{
			mav.addObject("ak_biz_no", "129-85-42346");
			mav.addObject("ak_corp_no", "131311-0029384");
			mav.addObject("ak_biz_nm", "에이케이에스앤디 (주)");
			mav.addObject("ak_biz_addr", "경기도 성남시 분당구 황새울로360번길 42, 1층(서현동)");
		}
		if("04".equals(store))
		{
			mav.addObject("ak_biz_no", "378-85-01457");
			mav.addObject("ak_corp_no", "131311-0029384");
			mav.addObject("ak_biz_nm", "에이케이에스앤디(주) AK평택점");
			mav.addObject("ak_biz_addr", "경기도 평택시 평택로 51, 1층(평택동)");
		}
		if("05".equals(store))
		{
			mav.addObject("ak_biz_no", "224-85-23362");
			mav.addObject("ak_corp_no", "131311-0029384");
			mav.addObject("ak_biz_nm", "에이케이에스앤디(주) AK원주점'");
			mav.addObject("ak_biz_addr", "강원도 원주시 봉화로 1, 1층(단계동)");
		}
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		lecr_dao.insPrintb(cus_no, "원천징수영수증", "DESK", login_seq);//내역 저장
		
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "원천징수영수증 발급", cus_no);
		return mav;
	}
	
	@RequestMapping("/attend")
	public ModelAndView attend(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/attend");
		String subject_list = Utils.checkNullString(request.getParameter("subject_list"));
		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd"));
		String isJumin = Utils.checkNullString(request.getParameter("isJumin"));
		String lecturer_nm = Utils.checkNullString(request.getParameter("lecturer_nm"));
		String cus_addr = Utils.checkNullString(request.getParameter("cus_addr"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		String printStore = Utils.checkNullString(request.getParameter("printStore"));
		
		
		
		subject_list = subject_list.substring(0, subject_list.length()-1);
		int cnt = subject_list.split("\\|").length;
		System.out.println("cnt : "+cnt);
		
		if(cnt > 1)
		{
			System.out.println(subject_list);
			System.out.println("subject_list.lastIndexOf(\"\\\\|\") : "+subject_list.lastIndexOf("|"));
			subject_list = subject_list.substring(0, subject_list.indexOf("|")) + " 외 "+(cnt-1);
		}
		
		
		if(lecturer_cd.length() == 13)
		{
			if("Y".equals(isJumin))
			{
				lecturer_cd = lecturer_cd.substring(0, 6)+"-"+lecturer_cd.substring(6, 7)+"******";
			}
			else
			{
				lecturer_cd = lecturer_cd.substring(0, 6)+"-"+lecturer_cd.substring(6, 13);
			}
		}
		else
		{
			lecturer_cd = "주민등록번호 오류";
		}
		
		mav.addObject("subject_list", subject_list);
		mav.addObject("lecturer_cd", lecturer_cd);
		mav.addObject("lecturer_nm", lecturer_nm);
		mav.addObject("cus_addr", cus_addr);
		mav.addObject("start_ymd", start_ymd);
		mav.addObject("end_ymd", end_ymd);
		mav.addObject("cnt", cnt);
		if("02".equals(printStore)) {mav.addObject("printStore", "수원점");}
		else if("03".equals(printStore)) {mav.addObject("printStore", "분당점");}
		else if("04".equals(printStore)) {mav.addObject("printStore", "평택점");}
		else if("05".equals(printStore)) {mav.addObject("printStore", "원주점");}
		
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		lecr_dao.insPrintb(cus_no, "출강증명서", "DESK", login_seq);//내역 저장
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "출강증명서 발급", cus_no);
		return mav;
	}
	
	
	@RequestMapping("/getMemo")
	@ResponseBody
	public List<HashMap<String, Object>> getMemo(HttpServletRequest request) {
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		List<HashMap<String, Object>> list = lecr_dao.getMemo(cus_no);  
			
	    return list;
	}
	@RequestMapping("/getTax")
	@ResponseBody
	public List<HashMap<String, Object>> getTax(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String lecturer_nm = Utils.checkNullString(request.getParameter("lecturer_nm"));
//		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd")).replace("-", "");
		
		List<HashMap<String, Object>> list = lecr_dao.getTax(store, period, lecturer_nm);  
		
	    return list;
		
	}
	@RequestMapping("/getTaxDetail")
	@ResponseBody
	public List<HashMap<String, Object>> getTaxDetail(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String corp_fg = Utils.checkNullString(request.getParameter("corp_fg"));
		String tb = "";
		if("1".equals(corp_fg))
		{
			tb = "co";
		}
		else if("2".equals(corp_fg))
		{
			tb = "pr";
		}
		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd"));
		
		List<HashMap<String, Object>> list = lecr_dao.getTaxDetail(store, period, lecturer_cd, "", tb);  
		
		return list;
		
	}
	
	@Transactional
	@RequestMapping("/doPass")
	@ResponseBody
	public HashMap<String, Object> doPass(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));

		String passValue = Utils.checkNullString(request.getParameter("passValue"));
		String[] arr =  Utils.checkNullString(request.getParameter("chk_list")).split("\\|");
		String cust_no="";
		String reg_no="";
	
		try {			
			for (int i = 0; i < arr.length; i++) {
				cust_no = arr[i].split("_")[0];
				reg_no = arr[i].split("_")[1];
				int result1 = lecr_dao.get_passReslt(cust_no,passValue, reg_no); 
				int result2 = lecr_dao.get_passReslt2(cust_no,reg_no,create_resi_no); 
				
				if ((result1+result2) > 1) {
					map.put("isSuc", "success");
					map.put("msg", "저장되었습니다.");
				}else {
					map.put("isSuc", "fail");
					map.put("msg", "알 수 없는 오류 발생");
					return map;
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		
		return map;
	}
	
	
	@Transactional
	@RequestMapping("/doDelete")
	@ResponseBody
	public HashMap<String, Object> doDelete(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		
		HttpSession session = request.getSession();
		String[] arr =  Utils.checkNullString(request.getParameter("chk_list")).split("\\|");
		String cust_no="";
		String reg_no="";
	
		try {			
			for (int i = 0; i < arr.length; i++) {
				cust_no = arr[i].split("_")[0];
				reg_no = arr[i].split("_")[1];
				int result1 = lecr_dao.del_passReslt(cust_no, reg_no); 
				int result2 = lecr_dao.del_passReslt2(cust_no,reg_no); 
				
				if ((result1+result2) > 1) {
					map.put("isSuc", "success");
					map.put("msg", "저장되었습니다.");
				}else {
					map.put("isSuc", "fail");
					map.put("msg", "알 수 없는 오류 발생");
					return map;
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		
		return map;
	}
	
	@RequestMapping("/getapplicntInfo")
	@ResponseBody
	public HashMap<String, Object>  getapplicntInfo(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		
		HashMap<String, Object>  data = lecr_dao.getapplicntInfo(store,period,subject_cd,cus_no);
		
		int regis_fee = Utils.checkNullInt(data.get("REGIS_FEE"));
	    int food_amt = 0;
	    if("Y".equals(Utils.checkNullString(data.get("FOOD_YN"))))
	    {
	       food_amt = Utils.checkNullInt(data.get("FOOD_AMT"));
	    }
	    int lect_cnt = Utils.checkNullInt(data.get("LECT_CNT"));
	    int mid_regis_fee = (int) Math.round((double)regis_fee / lect_cnt );
	    mid_regis_fee = (mid_regis_fee + 5)/10 * 10; //일의자리 반올림하기위함 
	      
	      
	    int mid_food_amt = 0;
	    if("Y".equals(Utils.checkNullString(data.get("FOOD_YN"))))
	    {
	       mid_food_amt = (int) Math.round((double)food_amt / lect_cnt);
	       mid_food_amt = (mid_food_amt + 5)/10 * 10; //일의자리 반올림하기위함 
	    }
	    
	    data.put("lect_cnt", lect_cnt);
	    data.put("regis_fee", regis_fee);
	    data.put("mid_regis_fee", mid_regis_fee);
	    data.put("mid_food_amt", mid_food_amt);
	    
	    
		return data;
	}
	
	
	@RequestMapping("/saveInfo")
	@ResponseBody
	public HashMap<String, Object>  saveInfo(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		String contract_start = Utils.checkNullString(request.getParameter("contract_start"));
		String contract_end = Utils.checkNullString(request.getParameter("contract_end"));
		String auto_term = Utils.checkNullString(request.getParameter("auto_term"));
		String naver_yn = Utils.checkNullString(request.getParameter("naver_yn"));
		
		try {
			int result = lecr_dao.uptContract(store,period,subject_cd,cus_no,contract_start,contract_end,auto_term,naver_yn);
			if (result>0) {
				map.put("isSuc", "success");
				map.put("msg", "저장되었습니다.");
			}else {
				map.put("isSuc", "faile");
				map.put("msg", "알 수 없는 오류 발생");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
		}
		return map;
	}
	
	@RequestMapping("/getLecrLineList")
	@ResponseBody
	public HashMap<String, Object> getLecrLineList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
//		String period = Utils.checkNullString(request.getParameter("period"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String search_corp_fg = Utils.checkNullString(request.getParameter("search_corp_fg"));
//		String is_new = Utils.checkNullString(request.getParameter("is_new"));
		String status_fg = Utils.checkNullString(request.getParameter("status_fg"));
		
		String rep_store = "";
		
		HttpSession session = request.getSession();
		String isBonbu = Utils.checkNullString(session.getAttribute("isBonbu"));
		if("T".equals(isBonbu))
		{
			rep_store = "";
		}
		else
		{
			rep_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
		}
		
		List<HashMap<String, Object>> listCnt = lecr_dao.getLecrLineListCount(store, search_name, search_corp_fg, status_fg, rep_store);
		List<HashMap<String, Object>> listCnt_all = lecr_dao.getLecrLineListCount(store, "", "", status_fg, rep_store);
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
		System.out.println("listCount"+listCount);
		System.out.println("pageNum"+pageNum);
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
		
		System.out.println("search_name : "+search_name);
		
		List<HashMap<String, Object>> list = lecr_dao.getLecrLineList(s_point, listSize*page, order_by, sort_type, store, search_name, search_corp_fg, status_fg, rep_store);
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
		map.put("search_name", search_name);
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "거래선 상신 조회", store);
		return map;
		
	}
	

	
	@RequestMapping("/confirm")
	@ResponseBody
	public HashMap<String, Object> confirm(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		String way = Utils.checkNullString(request.getParameter("way"));

		try {
			
			int result = lecr_dao.confirm(login_seq,store,period,subject_cd,cus_no,way);
			if (result>0) {
				if (way.equals("R")) {
					map.put("isSuc", "success");
					map.put("msg", "회수되었습니다.");
				}else{
					map.put("isSuc", "success");
					map.put("msg", "발송되었습니다.");		
				}
			}else {
				map.put("isSuc", "fail");
				map.put("msg", "알 수 없는 오류 발생");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
		}
		return map;
	}
	@RequestMapping("/line_search")
	@ResponseBody
	public List<HashMap<String, Object>> line_search(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		String user_nm = Utils.checkNullString(request.getParameter("user_nm"));
		List<HashMap<String, Object>> list = common_dao.getAxuserByName(user_nm);
		
		return list;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/detail");
		
		String reg_no = Utils.checkNullString(request.getParameter("reg_no"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		HashMap<String, Object> list = lecr_dao.getApplyInfo(reg_no,cust_no);
		for (String key : list.keySet()) {
			System.out.println(key+":"+list.get(key));				
			mav.addObject(key, list.get(key));
		}
		
		
		return mav;
	}
	@RequestMapping("/getLemgListOld")
	@ResponseBody
	public List<HashMap<String, Object>> getLemgListOld(HttpServletRequest request) {	
		
		String searchLemg = Utils.checkNullString(request.getParameter("searchLemg"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		List<HashMap<String, Object>> list = lecr_dao.getLemgListOld(searchLemg, order_by, sort_type);
		return list;
	}
	@Transactional
	@RequestMapping("/lecr_join_proc")
	@ResponseBody
	public HashMap<String, Object> lecr_join_proc(HttpServletRequest request) {	
		HashMap<String, Object> map = new HashMap<>();
		
		String lecturer_cd = Utils.checkNullString(request.getParameter("lecturer_cd"));
		String lectmgmt_no = Utils.checkNullString(request.getParameter("lectmgmt_no"));
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		HttpSession session = request.getSession();
		String login_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		try
		{
			List<HashMap<String, Object>> lemg_list = lecr_dao.getLemgList(lectmgmt_no, lecturer_cd); 
			if(lemg_list.size() > 0)
			{
				int cnt = lecr_dao.isInLectureByCust(cus_no); 
				if(cnt > 0)
				{
					map.put("isSuc", "fail");
					map.put("msg", "이미 등록된 강사입니다.");
				}
				else
				{
					String car_no = Utils.checkNullString(lemg_list.get(0).get("CAR_NO"));
					lecr_dao.insLecture(lecturer_cd, cus_no, car_no, "10", "4", "30", "8", "", "", "", "", "", "", "", "52", login_seq, login_store);
					lecr_dao.upPeltByLecr(lecturer_cd, lectmgmt_no, cus_no);
					map.put("isSuc", "success");
					map.put("msg", "성공적으로 저장되었습니다.");
					common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "강사 통합", cus_no);
				}
			}
			else
			{
				map.put("isSuc", "fail");
				map.put("msg", "오류 발생");
			}
		}
		catch(Exception e)
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
		
		return map;
		
	}
	@RequestMapping("/lecr_join")
	public ModelAndView lecr_join(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/lecture/lecr/lecr_join");
		return mav;
	}
	@RequestMapping("/lecr_lect_list")
	@ResponseBody
	public List<HashMap<String, Object>> lecr_lect_list(HttpServletRequest request) {	
		String lectmgmt_no = Utils.checkNullString(request.getParameter("lectmgmt_no"));
		List<HashMap<String, Object>> list = lecr_dao.lecr_lect_list(lectmgmt_no);
		return list;
	}
	@RequestMapping("/lecr_lect_list2")
	@ResponseBody
	public List<HashMap<String, Object>> lecr_lect_list2(HttpServletRequest request) {	
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		List<HashMap<String, Object>> list = lecr_dao.lecr_lect_list2(cus_no);
		return list;
	}
	
	@RequestMapping("/print_proc")
	public ModelAndView print_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/lecture/lecr/print_proc");
		mav.addObject("result",  Utils.checkNullString(request.getParameter("result")));
		return mav;
	}
	@RequestMapping("/getPrintList")
	@ResponseBody
	public HashMap<String, Object> getPrintList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String print_type = Utils.checkNullString(request.getParameter("print_type"));
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		List<HashMap<String, Object>> listCnt = lecr_dao.getPrintListCount(print_type, search_name);
		List<HashMap<String, Object>> listCnt_all = lecr_dao.getPrintListCount("", "");
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
		
		List<HashMap<String, Object>> list = lecr_dao.getPrintList(s_point, listSize*page, order_by, sort_type, print_type, search_name); 
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
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "증명서 발급 리스트 조회", "");
		return map;
	}
	
}