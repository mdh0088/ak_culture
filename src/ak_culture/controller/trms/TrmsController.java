package ak_culture.controller.trms;


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

import ak_culture.classes.AKCommon;
import ak_culture.classes.BABatchRun;
import ak_culture.classes.Utils;
import ak_culture.model.akris.AkrisDAO;
import ak_culture.model.basic.CodeDAO;
import ak_culture.model.basic.PeriDAO;
import ak_culture.model.basic.PosDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.it.ItDAO;
import ak_culture.model.trms.TrmsDAO;

@Controller
@RequestMapping("/trms/trms/*")

public class TrmsController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private TrmsDAO trms_dao;
	
	@Autowired
	private PeriDAO peri_dao;
	@Autowired
	private AkrisDAO akris_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private PosDAO pos_dao;
	
	@Autowired
	private CodeDAO code_dao;
	@Autowired
	private ItDAO it_dao;
	
	@Value("${batch_ip}")
	private String batch_ip;
	
	@RequestMapping("/check")
	public ModelAndView check(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/check");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/print_proc")
	public ModelAndView print_proc(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/print_proc");
		HttpSession session = request.getSession();
		mav.addObject("login_rep_store_nm",  Utils.checkNullString(session.getAttribute("login_rep_store_nm")));
		mav.addObject("login_name",  Utils.checkNullString(session.getAttribute("login_name")));
		mav.addObject("pos_no",  Utils.checkNullString(session.getAttribute("pos_no")));
		mav.addObject("result",  Utils.checkNullString(request.getParameter("result")));
		
		return mav;
	}
	@RequestMapping("/getCheckList")
	@ResponseBody
	public HashMap<String, Object> getCheckList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		
		String pmg = Utils.checkNullString(request.getParameter("pmg"));
		String pgm_arg = "";
		if(!"".equals(store) && !"".equals(sale_ymd))
		{
			pgm_arg = "00"+store+sale_ymd+pos;
		}
		
		List<HashMap<String, Object>> listCnt = common_dao.getProcListCount(pgm_arg, pmg);
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
		
		List<HashMap<String, Object>> list = common_dao.getProcList(s_point, listSize*page, order_by, sort_type, pgm_arg, pmg); 
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("page", page);
		map.put("s_page", s_page);
		map.put("e_page", e_page);
		map.put("pageNum", pageNum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), pmg+" ??????", store);

		return map;
	}
	
	@RequestMapping("/close_write")
	public ModelAndView close_write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/close_write");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		mav.addObject("login_name", session.getAttribute("login_name"));
		mav.addObject("pos_no", session.getAttribute("pos_no"));
		return mav;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/detail");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		if(!"".equals(store))
		{
			List<HashMap<String, Object>> pgmList1 = trms_dao.getItDetailList("1", store, pos, start_ymd, end_ymd);
			List<HashMap<String, Object>> pgmList2 = trms_dao.getItDetailList("2", store, pos, start_ymd, end_ymd);
			List<HashMap<String, Object>> pgmList3 = trms_dao.getItDetailList("3", store, pos, start_ymd, end_ymd);
			mav.addObject("pmgList1",pgmList1);
			mav.addObject("pmgList2",pgmList2);
			mav.addObject("pmgList3",pgmList3);
			mav.addObject("pmgList1_size",pgmList1.size());
			mav.addObject("pmgList2_size",pgmList2.size());
			mav.addObject("pmgList3_size",pgmList3.size());
		}
		String store_name = common_dao.getStoreName(store);
		mav.addObject("store", store);
		mav.addObject("pos", pos);
		mav.addObject("store_name", store_name);
		mav.addObject("start_ymd", start_ymd);
		mav.addObject("end_ymd", end_ymd);
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "?????? ?????? ?????? ??????", store+"/"+start_ymd+"/"+end_ymd);
		return mav;
		
	}
	
	@RequestMapping("/list")
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/list");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		if(!"".equals(store))
		{
			List<HashMap<String, Object>> pgmList1 = trms_dao.getItTypeList("1", store, pos, start_ymd, end_ymd);
			List<HashMap<String, Object>> pgmList2 = trms_dao.getItTypeList("2", store, pos, start_ymd, end_ymd);
			List<HashMap<String, Object>> pgmList3 = trms_dao.getItTypeList("3", store, pos, start_ymd, end_ymd);

			//?????????????????????. 1????????????
			int cash_tot = 0;
			int repay_tot = 0;
			int jasa_coupon_tot = 0;
			int tasa_coupon_tot = 0;
			int card_tot = 0;
			int point_tot = 0;
			int enuri_tot = 0;
			int sale_tot = 0;
			int mc_tot = 0;
			int akgift_tot = 0;
			for(int i = 0; i < pgmList1.size(); i++)
			{
				cash_tot += Utils.checkNullInt(pgmList1.get(i).get("CASH_AMT"));
				repay_tot += Utils.checkNullInt(pgmList1.get(i).get("REPAY_AMT"));
				jasa_coupon_tot += Utils.checkNullInt(pgmList1.get(i).get("JASA_COUPON_AMT"));
				tasa_coupon_tot += Utils.checkNullInt(pgmList1.get(i).get("TASA_COUPON_AMT"));
				card_tot += Utils.checkNullInt(pgmList1.get(i).get("SHIN_AMT"))+Utils.checkNullInt(pgmList1.get(i).get("KB_AMT"))+Utils.checkNullInt(pgmList1.get(i).get("WB_AMT"))+Utils.checkNullInt(pgmList1.get(i).get("TASA_AMT"));
				point_tot += Utils.checkNullInt(pgmList1.get(i).get("POINT_AMT"));
				enuri_tot += Utils.checkNullInt(pgmList1.get(i).get("ENURI_AMT"));
				sale_tot += Utils.checkNullInt(pgmList1.get(i).get("SALE_AMT"));
				mc_tot += Utils.checkNullInt(pgmList1.get(i).get("MC_AMT"));
				akgift_tot += Utils.checkNullInt(pgmList1.get(i).get("AKGIFT_AMT"));
			}
			mav.addObject("cash_tot",cash_tot);
			mav.addObject("repay_tot",repay_tot);
			mav.addObject("jasa_coupon_tot",jasa_coupon_tot);
			mav.addObject("tasa_coupon_tot",tasa_coupon_tot);
			mav.addObject("card_tot",card_tot);
			mav.addObject("point_tot",point_tot);
			mav.addObject("enuri_tot",enuri_tot);
			mav.addObject("sale_tot",sale_tot);
			mav.addObject("mc_tot",mc_tot);
			mav.addObject("akgift_tot",akgift_tot);
			
			//?????????????????????. 2????????????
			int amt1_tot = 0;
			int amt2_tot = 0;
			for(int i = 0; i < pgmList2.size(); i++)
			{
				amt1_tot += Utils.checkNullInt(pgmList2.get(i).get("AMT1"));
				amt2_tot += Utils.checkNullInt(pgmList2.get(i).get("AMT2"));
			}
			mav.addObject("amt1_tot",amt1_tot);
			mav.addObject("amt2_tot",amt2_tot);
			
			//?????????????????????. 3????????????
			int face_tot = 0;
			for(int i = 0; i < pgmList3.size(); i++)
			{
				face_tot += Utils.checkNullInt(pgmList3.get(i).get("FACE_AMT"));
			}
			mav.addObject("face_tot",face_tot);
			
			
			//pgmList ??? ????????? IN_TYPE ????????? BACODE ??????????????? ???????????? ????????????. ?????? ?????? ????????? ?????????, ???????????? ??????????????? ?????????????????????.
			List<HashMap<String, Object>> intypeList = code_dao.getSubCode("06");
			for(int i = 0; i < pgmList1.size(); i++)
			{
				String intype = Utils.checkNullString(pgmList1.get(i).get("IN_TYPE"));
				for(int z = 0; z < intypeList.size(); z++)
				{
					String subcode = Utils.checkNullString(intypeList.get(z).get("SUB_CODE"));
					if(intype.equals(subcode))
					{
						pgmList1.get(i).put("IN_TYPE_TXT", Utils.checkNullString(intypeList.get(z).get("SHORT_NAME")));
					}
				}
			}
			mav.addObject("pmgList1",pgmList1);
			mav.addObject("pmgList2",pgmList2);
			mav.addObject("pmgList3",pgmList3);
			mav.addObject("pmgList1_size",pgmList1.size());
			mav.addObject("pmgList2_size",pgmList2.size());
			mav.addObject("pmgList3_size",pgmList3.size());
		}
		String store_name = common_dao.getStoreName(store);
		if("".equals(pos))
		{
			System.out.println("1");
			mav.addObject("pos_init", Utils.checkNullString(session.getAttribute("pos_no")));
		}
		else
		{
			System.out.println("2");
			mav.addObject("pos_init", "");
		}
		mav.addObject("store", store);
		mav.addObject("pos", pos);
		mav.addObject("store_name", store_name);
		mav.addObject("start_ymd", start_ymd);
		mav.addObject("end_ymd", end_ymd);
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "?????? ????????? ??????", store+"/"+start_ymd+"/"+end_ymd);

		return mav;
	}
	
	@RequestMapping("/print")
	public ModelAndView print(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/print");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/getPrint")
	@ResponseBody
	public HashMap<String, Object> getPrint(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String start_ymd = Utils.checkNullString(request.getParameter("start_ymd"));
		String end_ymd = Utils.checkNullString(request.getParameter("end_ymd"));
		
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = trms_dao.getItdeList(store, pos, start_ymd, end_ymd);
		
		map.put("list",list);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "????????? ?????? ??????", store+"/"+pos);

		return map;
	}
	
	@RequestMapping("/send")
	public ModelAndView send(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/send");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		return mav;
	}
	@RequestMapping("/getSendList")
	@ResponseBody
	public HashMap<String, Object> getSendList(HttpServletRequest request) {
		
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos = Utils.checkNullString(session.getAttribute("pos_no"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		
		String pmg = "bab0050b";
		String pgm_arg = "";
		if(!"".equals(store) && !"".equals(sale_ymd))
		{
			pgm_arg = "00"+store+sale_ymd+pos;
		}
		
		List<HashMap<String, Object>> listCnt = common_dao.getProcListCount(pgm_arg, pmg);
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
		
		List<HashMap<String, Object>> list = common_dao.getProcList(s_point, listSize*page, order_by, sort_type, pgm_arg, pmg); 
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
	@Transactional
	@RequestMapping("/send_proc")
	public ModelAndView send_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		
		mav.setViewName("/WEB-INF/pages/trms/trms/send_proc");
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String act = Utils.checkNullString(request.getParameter("act"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	    
	    for(int i = login_seq.length(); i < 7; i++)
	    {
	    	login_seq += "X"; //7????????? ???????????????.
	    }
		
		String close_fg = "";
		String programNm = "";
		if("send".equals(act))
		{
			close_fg = "BAA";
			programNm  = "?????????????????????";
		}
		else if("cancle".equals(act))
		{
			close_fg = "BAB";
			programNm  = "???????????????????????????";
		}
		else if("submit".equals(act))
		{
			close_fg = "BAC";
			programNm  = "???????????????????????????";
		}
		else if("send_cancle".equals(act))
		{
			close_fg = "BAC";
		}
		
		String close_status = trms_dao.getSendCloseStatus(store, close_fg, sale_ymd);		
		
		if("send_cancle".equals(act))
		{
			if(Utils.checkNullString(close_status).equals(""))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "??????????????? ????????? ????????????.");
			}
			else if("I".equals(close_status))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "?????????????????? ?????? ??? ?????????!");
				return mav;
			}
			else if("E".equals(close_status))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "?????????????????? ????????? ????????????!, ??????????????? ????????? ????????????.!");
				return mav;
			}
			else if("Y".equals(close_status))
			{
				String gbn_upmu = "CM6";
				HashMap<String, Object> data = akris_dao.sapcancel(login_seq, store, sale_ymd, gbn_upmu);
				if("-1".equals(data.get("o_code")))
				{
					mav.addObject("isSuc", "fail");
					mav.addObject("msg", "???????????? ????????? ????????? ?????????????????????.");
					System.out.println("?????????????????? ?????? : "+data.get("o_message"));
					return mav;
				}
				else
				{
					mav.addObject("isSuc", "success");
					mav.addObject("msg", "??????????????? ?????????????????????.");
				}
			}
		}
		else
		{
			if("I".equals(close_status))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", programNm+" ????????????.");
				return mav;
			}
			if("Y".equals(close_status))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "?????? "+programNm+" ???????????????.");
				return mav;
			}
			if("E".equals(close_status))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", programNm+"??? ????????? ?????????????????????. ???????????? ??????????????????.");
				return mav;
			}
			
			int sendCnt = 0;
			sendCnt = trms_dao.checkSend(store, sale_ymd);
	        
	        if(sendCnt > 0) {
	        	mav.addObject("isSuc", "fail");
				mav.addObject("msg", "???????????? ????????? ?????? ?????? ???????????????.");
				return mav;
	        }
	        
	        String todayDate = AKCommon.getCurrentDate();
	        sendCnt = trms_dao.checkSendIt(store, sale_ymd);
	        
	        if(sendCnt > 0) {
	        	if(sale_ymd.equals(todayDate))
	        	{
	        		mav.addObject("isSuc", "fail");
	        		mav.addObject("msg", "????????? ?????? ?????? ???????????????. ????????? ???????????????!");
	        		return mav;
	        	}
	        }
	        
	      //?????????????????????.
	        String programIDB =  "bab0050b";
	        
	        String toTime    = AKCommon.getCurrentTime();
	        
	        String args  = todayDate + toTime + login_seq + AKCommon.RPAD(programNm,50+programNm.length(),' ');
	        String prog_args = "00" + store + sale_ymd + close_fg;
	        
	        trms_dao.insSend(store, close_fg, login_seq, sale_ymd);
	        
	        BABatchRun batchjob = new BABatchRun();
	        batchjob.setHost(batch_ip, 10002);
	        String result = batchjob.setBathBun(programIDB,args + prog_args); //???????????? ????????????
//	        String result = "0";
	        
	        if("0".equals(result))
	        {
	        	mav.addObject("isSuc", "success");
	    		mav.addObject("msg", "??????????????? ?????????????????????.");
	        }
	        else
	        {
	        	mav.addObject("isSuc", "fail");
				mav.addObject("msg", "??????????????? ????????? ?????????????????????. ???????????? ??????????????????.");
	        }
		}
		
		
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "?????? ", store+"/"+sale_ymd+"/"+programNm);
		
		
		return mav;
	}
	@RequestMapping("/trms_write")
	public ModelAndView trms_write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/trms/trms/trms_write");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		mav.addObject("login_name", session.getAttribute("login_name"));
		mav.addObject("pos_no", session.getAttribute("pos_no"));
		return mav;
	}
	@Transactional
	@RequestMapping("/write_proc")
	public ModelAndView write_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		
		mav.setViewName("/WEB-INF/pages/trms/trms/write_proc");
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String tot_amt = Utils.checkNullString(request.getParameter("tot_amt")).replaceAll(",", "");
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	    String pos = Utils.checkNullString(session.getAttribute("pos_no"));
	    String adjust_item = "074";
	    
	    String end_yn = "";
	    String check = trms_dao.checkBASale0101(store, pos); //BAITDETB?????? 074??? ?????? (????????????)
	    if(Integer.parseInt(check) > 0) {
	    	HashMap<String, Object> data = trms_dao.getBASale0101(store, pos, adjust_item); //ITEM, ITDE ?????? ?????? 074??? ????????????.
	    	if(data != null)
	    	{
	    		end_yn = Utils.checkNullString(data.get("END_YN")); //POSM ??????????????? ??????
	    	}
        } 
	    if("Y".equals(end_yn))
	    {
	    	mav.addObject("isSuc", "fail");
			mav.addObject("msg", "POS ?????? ???????????????. ????????? ??????/?????? ??? ??? ????????????!");
			return mav;
	    }
	    
//	    List<HashMap<String, Object>> itList = trms_dao.selTodayIt(store, pos, adjust_item);
	    
	    if(Integer.parseInt(check) > 0) 
	    {
//	    	trms_dao.upIt(store, pos, tot_amt, login_seq, adjust_item); //ITDE??? ?????? ????????????
	    	trms_dao.updateBASale0101(store, pos, tot_amt);
	    }
	    else
	    {
//	    	trms_dao.insIt(store, pos, tot_amt, login_seq, adjust_item); //ITDE, ITEM??? INSERT.
	    	trms_dao.insertBASale0101(store, pos, tot_amt);
	    }
	    
	    check = trms_dao.checkBASale0103(store, pos);
	    
	    if(Integer.parseInt(check) > 0) {
        } else {
            //??????
        	trms_dao.insertBASale0103(store, pos, login_seq);
        }
	    
	    pos_dao.upPosStart(store, pos); //POS?????? ????????????.
	    mav.addObject("isSuc", "success");
		mav.addObject("msg", "??????????????? ?????????????????????.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "????????? ??????", store+"/"+pos+"/"+tot_amt);

		return mav;
	}
	@Transactional
	@RequestMapping("/close_proc")
	public ModelAndView close_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		
		mav.setViewName("/WEB-INF/pages/trms/trms/close_proc");
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String tot_amt = Utils.checkNullString(request.getParameter("tot_amt")).replaceAll(",", "");
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	    String adjust_item = "108";
	    String check = trms_dao.checkBASale0601(store, pos); //ITDE?????? ?????? 108, ???????????????
	    String amt = "";
	    HashMap<String, Object> data = trms_dao.getBASale0101(store, pos, "074"); //108??? ITEM ITDE ??????, POSM??????
	    if(data != null)
	    {
	    	amt = Utils.checkNullString(data.get("TOT_AMT"));
	    }
	    if("".equals(amt))
	    {
	    	mav.addObject("isSuc", "fail");
			mav.addObject("msg", "???????????? ???????????? ???????????????.");
			return mav;
	    }
	    if(Integer.parseInt(check) > 0) 
	    {
	    	trms_dao.upIt(store, pos, tot_amt, login_seq, adjust_item);
	    }
	    else
	    {
	    	trms_dao.insIt(store, pos, tot_amt, login_seq, adjust_item);
	    }
	    pos_dao.upPosEnd(store, pos);
	    mav.addObject("isSuc", "success");
		mav.addObject("msg", "??????????????? ?????????????????????.");
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "?????? ??????", store+"/"+pos+"/"+tot_amt);

		return mav;
	}
	@Transactional
	@RequestMapping("/check_proc")
	public ModelAndView check_proc(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(); 
		
		mav.setViewName("/WEB-INF/pages/trms/trms/check_proc");
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String pos = Utils.checkNullString(request.getParameter("selPos"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd")).replaceAll("-", "");
		String act = Utils.checkNullString(request.getParameter("act"));
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	    String period = common_dao.retrievePeriod(store);
	    
	    for(int i = login_seq.length(); i < 7; i++)
	    {
	    	login_seq += "X"; //7????????? ???????????????.
	    }
	    
	    if(("070013".equals(pos) || "070014".equals(pos)) && "send".equals(act))
	    {
	    	String pos_nm = "";
	    	if("070013".equals(pos)) { pos_nm = "?????????";}
	    	else if("070014".equals(pos)) { pos_nm = "?????????";}
	    	//1.????????? ???????????? ???????????? ?????? ?????? ?????????
	    	List<HashMap<String, Object>> list = trms_dao.processBASale1601(sale_ymd, store, period);
	    	String checkYn      = Utils.checkNullString(list.get(0).get("CHECK_YN"));
	        String today_date   = Utils.checkNullString(list.get(0).get("TODAY_DATE"));
	        if("Y".equals(checkYn)) {
	            if(today_date.equals(sale_ymd)) {
	                mav.addObject("isSuc", "fail");
	    			mav.addObject("msg", pos_nm+" ???????????? ????????????.\n??????????????? ???????????? ????????????.");
	    			return mav;
	            }
	        }
	        
	        //2.???????????? ??????
	        int count       = trms_dao.processBASale1602(sale_ymd, store, period);
	        if(count > 0) {
	            mav.addObject("isSuc", "fail");
    			mav.addObject("msg", "???????????? ?????? POS??? ????????????.\\n?????? ???????????????");
    			return mav;
	        }
	        //3.???????????? ??????
	        String adEndYn = trms_dao.processBASale1603(sale_ymd, store, period, pos);
	        if("Y".equals(adEndYn)) {
	            mav.addObject("isSuc", "fail");
    			mav.addObject("msg", "?????? ???????????? ???????????????.");
    			return mav;
	        }
	        //4.????????? POS ?????? ????????? ??????
	        int webPosCount = trms_dao.processBASale1604(sale_ymd, store, pos);
	        if(webPosCount == 0) {
	            mav.addObject("isSuc", "fail");
    			mav.addObject("msg", pos_nm+" ?????? ????????? ???????????? ????????????.");
    			return mav;
	        }
	        
	        trms_dao.processBASale1605(sale_ymd, store, pos, login_seq);
	        int baItemCheck = trms_dao.processBASale1606(sale_ymd, store, pos);
	        //??????????????? 070013 POS INSERT
	        if(baItemCheck == 0) {
        		trms_dao.processBASale1607(sale_ymd, store, login_seq, pos);
        		
        		//?????????????????? ????????? INSERT
        		String adjust_item = "074";
        		trms_dao.processBASale1608(sale_ymd, store, adjust_item, pos);
        		
        		//?????????????????? ???????????? INSERT
        		adjust_item = "108";       
        		trms_dao.processBASale1608(sale_ymd, store, adjust_item, pos);
	        }        
	    }
	    
		
		System.out.println("store : "+store);
		System.out.println("pos : "+pos);
		
		String close_fg = "";
		String programNm = "";
		if("send".equals(act))
		{
			close_fg = "BA1";
			programNm  = "?????????????????????";
		}
		else
		{
			close_fg = "BA2";
			programNm  = "???????????????????????????";
			
			if("070013".equals(pos) || "070014".equals(pos))
			{
				mav.addObject("isSuc", "fail");
				mav.addObject("msg", "?????????/????????? ????????? ????????? ????????? ??? ????????????.");
				return mav;
			}
		}
		
		String close_status = trms_dao.getCloseStatus(store, pos, close_fg, sale_ymd);		
		
		if("I".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", programNm+" ????????????.");
			return mav;
		}
		if("Y".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", "?????? "+programNm+" ???????????????.");
			return mav;
		}
		if("E".equals(close_status))
		{
			mav.addObject("isSuc", "fail");
			mav.addObject("msg", programNm+"??? ????????? ?????????????????????. ???????????? ??????????????????.");
			return mav;
		}
		
		int posCnt = 0;
		posCnt = pos_dao.checkPos(store, pos, sale_ymd);
        
        if(posCnt == 0) {
        	mav.addObject("isSuc", "fail");
			mav.addObject("msg", "POS??? ?????? ?????? ???????????????.");
			return mav;
        }
        
        posCnt = trms_dao.checkIt(store, pos, sale_ymd);
        
        if(posCnt > 0) {
        	mav.addObject("isSuc", "fail");
			mav.addObject("msg", "?????? ???????????? ???????????????.");
			return mav;
        }
        common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "????????????", store+"/"+pos+"/"+sale_ymd+"/"+programNm);

      //?????????????????????.
        String programIDB =  "bab0010b";
        
        
        String todayDate = AKCommon.getCurrentDate();
        String toTime    = AKCommon.getCurrentTime();
        
        String args  = todayDate + toTime + login_seq + AKCommon.RPAD(programNm,50+programNm.length(),' '); //48 50 55 57
        String prog_args = "00" + store + sale_ymd + pos + close_fg;
        
        trms_dao.insClos(store, pos, close_fg, login_seq, sale_ymd);
        
        BABatchRun batchjob = new BABatchRun();
        batchjob.setHost(batch_ip, 10002);
        String result = batchjob.setBathBun(programIDB,args + prog_args);
        //bab0010b 202104121034000musign0000320210412070003BA1
        //bab0010b20210412111754musign0?????????????????????                             000320210412070003BA1
        
        if("0".equals(result))
        {
        	mav.addObject("isSuc", "success");
    		mav.addObject("msg", "??????????????? ?????????????????????.");
        }
        else
        {
        	mav.addObject("isSuc", "fail");
			mav.addObject("msg", "??????????????? ????????? ?????????????????????. ???????????? ??????????????????.");
        }
		
		return mav;
	}
	
	@RequestMapping("/getIt")
	@ResponseBody
	public List<HashMap<String, Object>> getIt(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String adjust_item = Utils.checkNullString(request.getParameter("adjust_item"));
		
		List<HashMap<String, Object>> list = trms_dao.selTodayIt(store, pos, adjust_item);
			
	    return list;
	}
	@Transactional
	@RequestMapping("/itCancle")
	@ResponseBody
	public HashMap<String, Object> itCancle(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String adjust_item = Utils.checkNullString(request.getParameter("adjust_item")); //074
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String check = trms_dao.checkBASale0101(store, pos); //ITDE?????? ?????? 075???
		HashMap<String, Object> data = trms_dao.getBASale0101(store, pos, adjust_item); //ITEM, ITDE, POSM ?????? ?????? 074???
		String end_yn = "";
	    if(Integer.parseInt(check) > 0) {
	    	if(data != null)
	    	{
	    		end_yn = Utils.checkNullString(data.get("END_YN"));
	    	}
        } 
	    if("Y".equals(end_yn))
	    {
	    	map.put("isSuc", "fail");
			map.put("msg", "POS ?????? ???????????????. ????????? ??????/?????? ??? ??? ????????????!");
			return map;
	    }
	    if(data != null)
	    {
	    	if(!"".equals(Utils.checkNullString(data.get("ADJUST_DATE"))))
	    	{
	    		map.put("isSuc", "fail");
	    		map.put("msg", "??????????????? ?????? POS?????????! ????????? ?????? ??? ??? ????????????!");
	    		return map;
	    	}
	    }
	    
	    if(Integer.parseInt(check) == 0) {
	    	map.put("isSuc", "fail");
			map.put("msg", "???????????? ???????????? ???????????????.");
			return map;
	    }	    		
	    
	    String sale_ymd = AKCommon.getCurrentDate();
	    
	    
	    // 1) ??????????????? ???????????? ?????? (BATRMSTB)   
	    check = trms_dao.checkBASale0104(store, sale_ymd, pos);  
	    System.out.println("??????????????? ???????????? ?????? check  - 1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);  
	    if(Integer.parseInt(check) > 0) {
	    	map.put("isSuc", "fail");
			map.put("msg", "?????????????????? ???????????????. ????????? ??????????????????.");
			return map;
	    }
	    else
	    {
	    	System.out.println("??????????????? ???????????? ?????? check - 2  >>>>>>>>>>>>>>>>>>>>>>>>>>>>" );   
	    	// 2) ????????? ???????????? ??????(BAITDETB)
	    	check = trms_dao.checkBASale0105(store, sale_ymd, pos);
	    	System.out.println("????????? ???????????? ?????? check   - 1  >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
	    	
	    	if(Integer.parseInt(check) > 0) {
	    		map.put("isSuc", "fail");
				map.put("msg", "????????????  ????????????.\\n????????? ????????? ??????????????????.\\n ???????????? ??????????????????");
				return map;    
            }
	    	// 3) ????????? ???????????? ??????(BAITDETB)
            check = trms_dao.checkBASale0101(store, pos);
            System.out.println("????????? ???????????? ?????? check   - 1  >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            
            if(Integer.parseInt(check) > 0) {
               //??????
            	trms_dao.deleteBASale0106(store, sale_ymd, pos);
                System.out.println("????????? ???????????? ?????? check - 2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            }else {
            	map.put("msg", "????????? ????????? ???????????? ????????????.\n????????? ????????? ??????????????????.");    
            } 
	    	
	    	// 4)POS???????????? ??????(BAPOSMTB)
            check = trms_dao.checkBASale0107(store, sale_ymd, pos);
            System.out.println("POS???????????? ?????? check -1  >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            if(Integer.parseInt(check) > 0) {
                //??????(????????? ?????????)
                trms_dao.updateBASale0107(store, sale_ymd, pos, login_seq);
                System.out.println("POS???????????? ?????? check -2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            }else {
                map.put("isSuc", "fail");
				map.put("msg", "POS??? ?????????????????? ????????????.\n????????? ????????? ??????????????????.");
				return map;   
            }
         // 5) ???????????? ??????(BAITEMTB)
            check = trms_dao.checkBASale0108(store, sale_ymd, pos);
            System.out.println("???????????? ?????? check -1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
           if(Integer.parseInt(check) > 0) {
               // ??????
        	   trms_dao.deleteBASale0108(store, sale_ymd, pos);
               System.out.println("???????????? ?????? check -2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            } else {
//                map.put("isSuc", "fail");
//				map.put("msg", "???????????? ???????????? ????????????.\n????????? ????????? ??????????????????.");
//				return map;  
            }
           
           // 6) ???????????? ?????? ??????1(AXCLOSTB)
            check = trms_dao.checkBASale0109(store, sale_ymd, pos); 
            System.out.println("???????????? ?????? ??????1 check -1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);            
            if(Integer.parseInt(check) > 0) {
            	trms_dao.deleteBASale0109(store, sale_ymd, pos); 
                System.out.println("???????????? ?????? ??????1 check -2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            }
            String pmg_arg = "00"+store+sale_ymd+pos;
            
            // 7) ???????????? ?????? ??????2(AXPROCTB)
            check = trms_dao.checkBASale0110(sale_ymd, pmg_arg); 
            System.out.println("???????????? ?????? ??????2 check -1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            if(Integer.parseInt(check) > 0) {
            	trms_dao.deleteBASale0110(sale_ymd, pmg_arg); 
                System.out.println("???????????? ?????? ??????2 check -2 >>>>>>>>>>>>>>>>>>>>>>>>>>>>" + check);
            }   
            map.put("isSuc", "success");
			map.put("msg", "?????????????????????.");
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "????????? ??????", store+"/"+pos);

			return map;
	    }
	}
	@Transactional
	@RequestMapping("/itCancle_close")
	@ResponseBody
	public HashMap<String, Object> itCancle_close(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("selBranch"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String adjust_item = Utils.checkNullString(request.getParameter("adjust_item"));
		String check = trms_dao.checkBASale0101(store, pos);
		HashMap<String, Object> data = trms_dao.getBASale0101(store, pos, adjust_item);
		String amt = "";
	    if(Integer.parseInt(check) > 0) {
	    	if(data != null)
	    	{
	    		amt = Utils.checkNullString(data.get("TOT_AMT"));
	    	}
        } 
	    if("".equals(amt))
	    {
	    	map.put("isSuc", "fail");
			map.put("msg", "??????????????? ???????????? ???????????????.");
			return map;
	    }
	    String sale_ymd = AKCommon.getCurrentDate();
	    trms_dao.deleteBASale0601(store, pos, sale_ymd);
	    trms_dao.updateBASale0603(store, pos, sale_ymd);
	    
	    map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "?????? ??????", store+"/"+pos);

		return map;
	   
	}
	
}