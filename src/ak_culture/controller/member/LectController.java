package ak_culture.controller.member;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.WeakHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kcp.J_PP_CLI_N;

import ak_culture.classes.AKCommon;
import ak_culture.classes.BABatchRun;
import ak_culture.classes.BAKCPUtil;
import ak_culture.classes.CmAKmembers;
import ak_culture.classes.MobileApp;
import ak_culture.classes.MobileAppResponse;
import ak_culture.classes.ModifiableHttpServletRequest;
import ak_culture.classes.Utils;
import ak_culture.model.basic.EncdDAO;
import ak_culture.model.basic.GiftDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.member.CustDAO;
import ak_culture.model.member.LectDAO;
import ak_culture.model.trms.TrmsDAO;

@Controller
@RequestMapping("/member/lect/*")

public class LectController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private LectDAO lect_dao;
	
	@Autowired
	private CommonDAO common_dao;
	
	@Autowired
	private TrmsDAO trms_dao;
	
	@Autowired
	private CustDAO cust_dao;
	
	@Autowired
	private GiftDAO gift_dao;
	
	@Autowired
	private EncdDAO encd_dao;
	
	@Value("${mem_url1}")
	private String mem_url1;
	@Value("${mem_url2}")
	private String mem_url2;
	@Value("${bundang_approve_ip}")
	private String bundang_approve_ip;
	@Value("${bundang_approve_port}")
	private String bundang_approve_port;
	@Value("${batch_ip}")
	private String batch_ip;
	@Value("${isTest}")
	private String isTest;
	 
	@RequestMapping("/view")
	public ModelAndView view(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/lect/view");
		
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		List<HashMap<String, Object>> maincdList = common_dao.get1Depth();
		mav.addObject("maincdList", maincdList);
		
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String print_port = Utils.checkNullString(session.getAttribute("print_port"));
		String autosign_port = Utils.checkNullString(session.getAttribute("autosign_port"));
		String ip_addr = Utils.checkNullString(session.getAttribute("ip_addr"));
		String login_name = Utils.checkNullString(session.getAttribute("login_name"));
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String login_rep_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
		
		mav.addObject("pos_no", pos_no);
		mav.addObject("print_port", print_port);
		mav.addObject("autosign_port", autosign_port);
		mav.addObject("user_ip", ip_addr);
		mav.addObject("login_name", login_name);
		mav.addObject("login_rep_store", login_rep_store);
		mav.addObject("login_seq", login_seq);
		
		
		//????????? ?????? ???????????????
		String data = Utils.checkNullString(request.getParameter("data"));
		if(!"".equals(data))
		{
			mav.addObject("isWait", "true");
			mav.addObject("cust_no", data.split("_")[0]);
			mav.addObject("store", data.split("_")[1]);
			mav.addObject("period", data.split("_")[2]);
			mav.addObject("subject_cd", data.split("_")[3]);
		}
		
		return mav;
	}
	
	@RequestMapping("/write")
	public ModelAndView write(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/lect/write");
		
		return mav;
	}
	
	@RequestMapping("/userSearch")
	@ResponseBody
	public List<HashMap<String, Object>> userSearch(HttpServletRequest request) {
		String search_name = Utils.checkNullString(request.getParameter("search_name"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		List<HashMap<String, Object>> list = lect_dao.userSearch(order_by, sort_type, search_name); 
		
		
		
	    return list;
	}
	@RequestMapping("/getRecptNoByCancel")
	@ResponseBody
	public List<HashMap<String, Object>> getRecptNoByCancel(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String recpt_pos_no = Utils.checkNullString(request.getParameter("recpt_pos_no"));
		List<HashMap<String, Object>> list = lect_dao.getRecptNoByCancel(store, pos_no, recpt_pos_no); 
		
		
		
		return list;
	}
	@RequestMapping("/getTotalPointSendList")
	@ResponseBody
	public List<HashMap<String, Object>> getTotalPointSendList(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		List<HashMap<String, Object>> list = lect_dao.getTotalPointSendList(store, pos_no, recpt_no, sale_ymd); 
		
		return list;
	}
	/*
	@RequestMapping("/getSideList")
	@ResponseBody
	public HashMap<String, Object> getSideList(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		
		List<HashMap<String, Object>> GiftList = lect_dao.getGiftList(store,period,cust_no); 

		HashMap<String, Object> map = new HashMap<>();
		map.put("GiftList", GiftList);
	//	map.put("EncdList", EncdList);

		
		return map;
	}
	*/
	
	@RequestMapping("/getGiftInfo")
	@ResponseBody
	public HashMap<String, Object> getGiftInfo(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd")).replaceAll("\\|", "");
		String msg ="";
		List<HashMap<String, Object>> list = common_dao.getLects(store, period, subject_cd);
		if (list.size() > 0) 
		{
			List<HashMap<String, Object>> gift_list = lect_dao.getGiftList(store, period,cust_no,Utils.checkNullString(list.get(0).get("SUBJECT_FG")));			
			if (gift_list.size() > 0) 
			{
				for (int j = 0; j < gift_list.size(); j++) {
					HashMap<String, Object> chkGift = lect_dao.chkGift(store,Utils.checkNullString(gift_list.get(j).get("PERIOD")),cust_no,Utils.checkNullString(gift_list.get(j).get("GIFT_CD")));
					if (gift_list.get(j).get("GIVE_FG").equals("G")) 
					{
						//if (chkGift==null && gift_list.get(j).get("GIVE_FG").equals("G")) 
						//{
							msg +="-"+gift_list.get(j).get("GIFT_NM")+"<br>";
						//}
					}
					else if(chkGift!=null && gift_list.get(j).get("GIVE_FG").equals("T"))
					{
						msg +="-"+gift_list.get(j).get("GIFT_NM")+"<br>";
					}
				}
			}
		}
		
		if (!msg.equals(""))
		{
			map.put("isSuc", "success");
			map.put("msg", "?????? ????????? ???????????? ????????????. <br>"+msg);
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "?????????????????????.");			
		}
		
		return map;
	}
	
	public HashMap<String, Object> returnGiftInfo(String store, String period, String subject_cd, String cust_no) {
		HashMap<String, Object> map = new HashMap<>();
		String msg ="";
		
		List<HashMap<String, Object>> chkGift = lect_dao.chkGiftForReturn(store,period,cust_no,subject_cd);
		if (chkGift.size() > 0) 
		{
			for (int i = 0; i < chkGift.size(); i++) {
				HashMap<String, Object> gift_info = lect_dao.getGiftInfoForReturn(store,period,chkGift.get(i).get("GIFT_CD").toString());
				if (gift_info!=null) 
				{
					if (chkGift.get(i).get("GIFT_STATUS").toString().equals("1")) 
					{
						msg +="-"+gift_info.get("GIFT_NM")+"<br>";						
					}
					lect_dao.uptGiftInfoForReturn(store,period,cust_no,chkGift.get(i).get("GIFT_CD").toString());
					
				}
			}
		}
		
		if (!msg.equals(""))
		{
			map.put("isSuc", "success");
			map.put("msg", "?????? ????????? ???????????? ????????????. <br>"+msg);
		}
		else
		{
			map.put("isSuc", "fail");
			//map.put("msg", "?????????????????????.");			
		}
		
		return map;
	}
	
	
	@RequestMapping("/uptCar")
	@ResponseBody
	public HashMap<String, Object> uptCar(HttpServletRequest request) {
	
		String store = Utils.checkNullString(request.getParameter("store"));
		String car_no = Utils.checkNullString(request.getParameter("car_no"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));

		lect_dao.uptCar(store,car_no,cust_no); 
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		
		return map;
	}
	
	@RequestMapping("/giveGift")
	@ResponseBody
	public HashMap<String, Object> giveGift(HttpServletRequest request) {
	
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String gift_val1 = Utils.checkNullString(request.getParameter("gift_val1"));
		String gift_val2 = Utils.checkNullString(request.getParameter("gift_val2"));
		
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
	
		
		String gift_cd1="";
		String gift_cd2="";
		
		System.out.println("*****************");
		System.out.println(gift_val1);
		System.out.println(gift_val2);
		
		if (!gift_val1.equals("")) {
			gift_cd1 = gift_val1.split("_")[0];
			System.out.println(gift_cd1);
				lect_dao.upt_giveGift(store,period,cust_no,gift_cd1,pos_no,create_resi_no);
		}
		
		if (!gift_val1.equals("") && !gift_val2.equals("")) {
			gift_cd2 = gift_val2.split("_")[0];
				lect_dao.upt_giveGift(store,period,cust_no,gift_cd2,pos_no,create_resi_no);
		}
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		
		return map;
	}
	
	@RequestMapping("/cancel_proc")
	@ResponseBody
	public HashMap<String, Object> cancel_proc(HttpServletRequest request) throws Exception {
		
		HashMap<String, Object> map = new HashMap<>();
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String recpt_pos_no = Utils.checkNullString(request.getParameter("recpt_pos_no"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		String pay_fg = Utils.checkNullString(request.getParameter("pay_fg"));
		String cancel_rmk = Utils.checkNullString(request.getParameter("cancel_rmk"));
		String approve_no = Utils.checkNullString(request.getParameter("approve_no"));
		String mc_approve_no = Utils.checkNullString(request.getParameter("mc_approve_no"));
		String card_amt = Utils.checkNullString(request.getParameter("card_amt"));
		String mc_card_amt = Utils.checkNullString(request.getParameter("mc_card_amt"));
		String akmem_use_point = Utils.checkNullString(request.getParameter("akmem_use_point"));
		String sign = Utils.checkNullString(request.getParameter("sign"));
		String result = Utils.checkNullString(request.getParameter("result"));
		String card_cancel_fail = Utils.checkNullString(request.getParameter("card_cancel_fail"));
		String mc_card_cancel_fail = Utils.checkNullString(request.getParameter("mc_card_cancel_fail"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String akmem_card_no = Utils.checkNullString(request.getParameter("akmem_card_no"));
		String akmem_approve_no = Utils.checkNullString(request.getParameter("akmem_approve_no"));
		String net_sale_amt = Utils.checkNullString(request.getParameter("net_sale_amt"));
		String discre_card = Utils.checkNullString(request.getParameter("discre_card"));
		System.out.println("net_sale_amt : "+net_sale_amt);
		
		map.put("store", store);
		map.put("recpt_pos_no", recpt_pos_no);
		map.put("pos_no", pos_no);
		map.put("period", period);
		map.put("sale_ymd", sale_ymd);
		map.put("recpt_no", recpt_no);
		map.put("pay_fg", pay_fg);
		map.put("cancel_rmk", cancel_rmk);
		map.put("approve_no", approve_no);
		map.put("mc_approve_no", mc_approve_no);
		map.put("card_amt", card_amt);
		map.put("mc_card_amt", mc_card_amt);
		map.put("akmem_use_point", akmem_use_point);
		map.put("sign", sign);
		map.put("result", result);
		map.put("card_cancel_fail", card_cancel_fail);
		map.put("mc_card_cancel_fail", mc_card_cancel_fail);
		map.put("cust_no", cust_no);
		map.put("discre_card", discre_card);
		
		
		
		
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		map.put("login_seq", login_seq);
		
		try
		{
			List<HashMap<String, Object>> list = lect_dao.getCancelSubject(store, recpt_pos_no, period, sale_ymd, recpt_no); 
			
			String cancelCheck = lect_dao.cancelCheck(store, sale_ymd, recpt_pos_no, recpt_no);
			
			if("Y".equals(cancelCheck)) {
	            throw new Exception("?????? ????????? ???????????????.\n?????? ????????? ?????????");
	        }
			String park_subject_cd = "";
			String rep_subject_cd = "";
			for(int i = 0; i < list.size(); i++)
			{
				if(i == 0) { rep_subject_cd = Utils.checkNullString(list.get(i).get("SUBJECT_CD"));}
				park_subject_cd += "\'"+Utils.checkNullString(list.get(i).get("SUBJECT_CD"))+"\',";
			}
			park_subject_cd = park_subject_cd.substring(0, park_subject_cd.length()-1);
			
			System.out.println("?????????????????? : "+list.size());
			for(int i = 0; i < list.size(); i++)
			{
				String subject_cd = Utils.checkNullString(list.get(i).get("SUBJECT_CD"));
				System.out.println("?????????????????? : "+store);
				System.out.println("?????????????????? : "+period);
				System.out.println("?????????????????? : "+subject_cd);
				
				//??????????????? ??????
				
				
				List<HashMap<String, Object>> listPere = lect_dao.getCancelSubjectPere(store, recpt_pos_no, period, sale_ymd, recpt_no, subject_cd); 
				if(listPere.size() > 0)
				{
					int person = 0;
					
					if("1".equals(Utils.checkNullString(listPere.get(0).get("MAIN_CD"))))
					{
						person = 1;
					}
					else if("2".equals(Utils.checkNullString(listPere.get(0).get("MAIN_CD"))))
					{
						if(!"".equals(Utils.checkNullString(listPere.get(0).get("CHILD_NO1"))) && !"0".equals(Utils.checkNullString(listPere.get(0).get("CHILD_NO1"))))
						{
							person = 3;
						}
						else
						{
							person = 2;
						}
					}
					else if("3".equals(Utils.checkNullString(listPere.get(0).get("MAIN_CD"))))
					{
						if("Y".equals(Utils.checkNullString(listPere.get(0).get("IS_TWO"))))
						{
							person = 2;
						}
						else
						{
							person = 1;
						}
					}
					else if("4".equals(Utils.checkNullString(listPere.get(0).get("MAIN_CD"))))
					{
						person = 1;
					}
					
					
					lect_dao.upPeltRegis_down(recpt_pos_no, store, period, subject_cd, person);
				}
				
				
			}
			// ???????????? ??????
			String car_no = lect_dao.getCar(store, cust_no);
			if (!"".equals(car_no) && car_no != null) {
				System.out.println("#############???????????? ????????????======" + car_no);
				List<HashMap<String, Object>> listCar = lect_dao.selCar(store, cust_no);
				if(listCar.size() > 0)
				{
					lect_dao.upCar(store, cust_no, login_seq, sale_ymd);
				}
				lect_dao.insCar_cancle(store, cust_no, car_no, period, rep_subject_cd, pos_no, recpt_no, net_sale_amt, login_seq, park_subject_cd, sale_ymd);
			}
			List<HashMap<String, Object>> list_recpt = lect_dao.getRecptNoByCancel(store, pos_no, recpt_pos_no);
			String new_recpt_no = Utils.checkNullString(list_recpt.get(0).get("NEW_RECPT_NO"));
			map.put("new_recpt_no", new_recpt_no);
			
			lect_dao.cancelProc(map, approve_no, mc_approve_no, recpt_pos_no);
			
			//????????? ??????
			lect_dao.delAttend(store, period, park_subject_cd, cust_no);
			
			//?????? ????????? ?????? ??? ????????????
			CmAKmembers cmAKmembers = new CmAKmembers();
			cmAKmembers.setANYLINK_AU1(mem_url1);
			cmAKmembers.setANYLINK_AU2(mem_url2);
			HashMap AKmemRead ;
			String AKmemCardStatus = null;
			String AKmemTotalPoint = "";
			akmem_card_no = lect_dao.getOri_akmem_card_no(store, recpt_pos_no, period, sale_ymd, recpt_no);
			
			System.out.println("akmem_card_no : "+akmem_card_no);
			
			if(!"".equals(akmem_card_no))
			{
				String ori_akmem_recpt_no = lect_dao.getOri_akmem_recpt_no(store, sale_ymd, recpt_pos_no, akmem_approve_no);
				System.out.println("ori_akmem_recpt_no : "+ori_akmem_recpt_no);
				AKmemRead = cmAKmembers.getAKmemRead( store, akmem_card_no, pos_no);
				AKmemCardStatus = cmAKmembers.getAKmemStatus(AKmemRead);
				System.out.println("AKmemCardStatus : "+AKmemCardStatus);
				
				String new_akmem_card_no = akmem_card_no;
				if ( "11".equals(AKmemCardStatus) ){ //BL ???????????? (????????? ??????????????? ????????????)
					new_akmem_card_no = common_dao.getMembersCard(cust_no.trim());
					AKmemRead = cmAKmembers.getAKmemRead( store, new_akmem_card_no, pos_no);
					AKmemCardStatus = cmAKmembers.getAKmemStatus(AKmemRead);
				}
				if ( "00".equals(AKmemCardStatus) ){
					AKmemTotalPoint = (String) AKmemRead.get("AKmem_total_point");
					HashMap<String, Object> rs = lect_dao.getPointAKmem(sale_ymd, store, recpt_pos_no, recpt_no, akmem_card_no);
					int AKMEM_RECPT_POINT = 0;
	                int AKMEM_USE_POINT = 0;
	                String AKMEM_APPROVE_NO = "";
	                int tempSum = 0;
	                if(rs != null)
	                {
	                	AKMEM_RECPT_POINT += Utils.checkNullInt(rs.get("AKMEM_RECPT_POINT"));
	                	AKMEM_USE_POINT += Utils.checkNullInt(rs.get("AKMEM_USE_POINT"));
	                }
	                System.out.println("AKMEM_USE_POINT : "+AKMEM_USE_POINT);
	                System.out.println("AKMEM_RECPT_POINT : "+AKMEM_RECPT_POINT);
	                tempSum = Integer.parseInt(AKmemTotalPoint) + AKMEM_USE_POINT - AKMEM_RECPT_POINT;
	                if(tempSum < -999){
	                	map.put("isSuc", "fail");
	            		map.put("msg", "???????????? ???????????? ???????????? ????????????, ?????? ????????? ?????? ????????????.");
	                    return map;
	                }
	                
	                String akmem_recpt_no = "";
	                if (!akmem_card_no.equals("")) {
	                	if ("01".equals(store)) {
	                		akmem_recpt_no = lect_dao.getAKmemRecptNo_01();
	                	} else if ("02".equals(store)) {
	                		akmem_recpt_no = lect_dao.getAKmemRecptNo_02();
	                	} else if ("03".equals(store)) {
	                		akmem_recpt_no = lect_dao.getAKmemRecptNo_03();
	                	} else if ("04".equals(store)) {
	                		akmem_recpt_no = lect_dao.getAKmemRecptNo_04();
	                	} else if ("05".equals(store)) {
	                		akmem_recpt_no = lect_dao.getAKmemRecptNo_05();
	                	}
	                }
	                CmAKmembers exeAKmem = new CmAKmembers();
	                HashMap<String, Object> rs2 = lect_dao.getAKmemUse(sale_ymd, store, recpt_pos_no, recpt_no, akmem_card_no);
	                if(AKMEM_USE_POINT > 0)
	                {
	                	 String realPay = ""; //??????????????? ????????? ?????? ??????????????? ????????????.
	             		 realPay = Integer.toString(Integer.parseInt(net_sale_amt) - Utils.checkNullInt(rs2.get("AKMEM_USE_POINT")));
	                	 HashMap map2 = exeAKmem.AKmemPoint(store
	                     		, new_akmem_card_no // ??????????????? ????????????
	                             , "0000000000000000" // ??????????????????
	                             , Utils.getCurrentDate() // recpt_sale_ymd (Sysdate)
	                             , recpt_pos_no // ????????? ?????? ??????
	                             , akmem_recpt_no // recpt_no ?????????????????? ???????????? ???????????? akmem_recpt_no
	                             , realPay // total_amt
	                             , Utils.checkNullString(rs2.get("AKMEM_RECPT_POINT")) // akmem_recpt_point
	                             , Utils.checkNullString(rs2.get("AKMEM_USE_POINT")) // akmem_recpt_point
	                             , sale_ymd // ????????? ???????????? ??? ?????? 2012.07.16)
	                             , ori_akmem_recpt_no // ????????? ????????? ?????? ??????????????? ??? ?????? (2012.07.16)
	                             , "USECANCLE");
	                	 
	                	 String AKmem_sApprovNo2 = (String) map2.get("RSP_CD");
	                     String AKmem_sMessage2 = (String) map2.get("MSG_TRMNL");
	                     System.out.println("???????????? ????????? : AKmem_sApprovNo2 : "+AKmem_sApprovNo2);
	                     if ("00".equals(AKmem_sApprovNo2)) {
	                         
	                         String AKmem_SaveApproveNo = (String) map2.get("PTCP_PERM_NO");
	                         String AKmem_SaveApproveNo_POS = (String) map2.get("PERM_NO");
	                         String AKmem_SaveApprove_Point = (String) map2.get("EUSE_PT");
	                         String AKmem_CustNo = (String) map2.get("CUS_NO");
	                         String AKmem_Create_Point = (String) map2.get("TOT_CREA_PT");
	                         String AKmem_send_buff = (String) map2.get("SEND_STR");
	                         String AKmem_recv_buff = (String) map2.get("RECV_BUFF");
	                         
	                         System.out.println("AKmem_SaveApprove_Point >>>>> ?????? ?????? >>>>> "+AKmem_SaveApprove_Point);
	                         
	                         // db insert
	                         HashMap<String, Object> ori_paramMap = lect_dao.getptcaOri(store, sale_ymd, recpt_pos_no, recpt_no);
//	                         HashMap<String, Object> paramMap = new HashMap<>();
//	                         paramMap.put("store", store);
//	                         paramMap.put("pos_no", pos_no);
//	                         paramMap.put("recpt_no", new_recpt_no);
//	                         paramMap.put("total_show_amt", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
//	                         paramMap.put("total_enuri_amt", Utils.checkNullString(ori_paramMap.get("ENURI_AMT")));
//	                         paramMap.put("total_regis_fee", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
//	                         paramMap.put("akmem_point_amt", Utils.checkNullString(rs2.get("AKMEM_USE_POINT")));
//	                         paramMap.put("AKmem_cardno", akmem_card_no);
//	                         paramMap.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);
//	                         paramMap.put("login_seq", login_seq);
//	                         paramMap.put("AKmem_CustNo", AKmem_CustNo);
//	                         paramMap.put("AKmem_Family_CustNo", "");
//	                         paramMap.put("AKmem_recpt_point", AKmem_Create_Point);
//	                         paramMap.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
	                         
	                         String tmp_pos_no = "";
	                         if("070013".equals(recpt_pos_no ) || "070014".equals(recpt_pos_no ))
	                         {
	                        	 tmp_pos_no = recpt_pos_no;
	                         }
	                         else 
	                         {
	                        	 tmp_pos_no = pos_no;
	                         }
	                         lect_dao.useAKmembersPointLog("00", store, tmp_pos_no, new_recpt_no, Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")), Utils.checkNullString(ori_paramMap.get("ENURI_AMT")), Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")), 
	                        		 new_akmem_card_no, AKmem_CustNo, "",
	                         		Utils.checkNullString(rs2.get("AKMEM_USE_POINT")), "0", "0", AKmem_SaveApprove_Point, AKmem_SaveApproveNo_POS, Utils.checkNullString(rs2.get("AKMEM_USE_POINT")), login_seq
	                         		
	                         		);
	                         
//	                         lect_dao.saveAKmembersPointLog(paramMap);
//	                         lect_dao.insWbptTbCancel(store, Utils.getCurrentDate(), sale_ymd, pos_no, recpt_pos_no, akmem_recpt_no, ori_akmem_recpt_no, AKmem_SaveApproveNo_POS, AKmem_send_buff, AKmem_recv_buff, AKmem_SaveApprove_Point);

	                         System.out.println("?????? ??????ok ->db-insert");
	                         System.out.println("AKmem_SaveApproveNo = "+ AKmem_SaveApproveNo);
	                         System.out.println("AKmem_SaveApproveNo_POS = " + AKmem_SaveApproveNo_POS);
	                         System.out.println("AKmem_SaveApprove_Point = " + AKmem_SaveApprove_Point);

	                         // return value??? ????????? ????????? ?????? ( ^????????????????????? ^????????? ?????????)

	                     } else {
	                    	 System.out.println("???????????? ?????? ?????? !!!!");
	                    	 String card_in_amt = Integer.toString(Utils.checkNullInt(AKmemRead.get("AKmem_total_point")) + Utils.checkNullInt(rs2.get("AKMEM_USE_POINT")));
	                    	 HashMap<String, Object> ori_paramMap = lect_dao.getptcaOri(store, sale_ymd, recpt_pos_no, recpt_no);
	                    	 String tmp_pos_no = "";
	                         if("070013".equals(recpt_pos_no ) || "070014".equals(recpt_pos_no ))
	                         {
	                        	 tmp_pos_no = recpt_pos_no;
	                         }
	                         else 
	                         {
	                        	 tmp_pos_no = pos_no;
	                         }
	                    	 lect_dao.useAKmembersPointLog("00", store, tmp_pos_no, new_recpt_no, Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")), Utils.checkNullString(ori_paramMap.get("ENURI_AMT")), Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")), 
	                    			 new_akmem_card_no, cust_no.trim(), "",
		                         		Utils.checkNullString(rs2.get("AKMEM_USE_POINT")), "0", "0", card_in_amt, Utils.checkNullString(rs2.get("AKMEM_APPROVE_NO")), Utils.checkNullString(rs2.get("AKMEM_USE_POINT")), login_seq
		                         		
		                         		);
	                    	 
	                     }
	                }
	                 HashMap<String, Object> rs3 = lect_dao.getAKmemSave(sale_ymd, store, recpt_pos_no, recpt_no, akmem_card_no);
	                 if(rs3 != null)
	                 {
	                	 HashMap map3 = exeAKmem.AKmemPoint(store
	                			 , new_akmem_card_no // ??????????????? ????????????
	                			 , "0000000000000000" // ??????????????????
	                			 , Utils.getCurrentDate() // recpt_sale_ymd (Sysdate)
	                			 , recpt_pos_no // ????????? ?????? ??????
	                			 , akmem_recpt_no // recpt_no ?????????????????? ???????????? ???????????? akmem_recpt_no
	                			 , net_sale_amt // total_amt
	                			 , Utils.checkNullString(rs3.get("AKMEM_RECPT_POINT")) // akmem_recpt_point
	                			 , Utils.checkNullString(rs3.get("AKMEM_USE_POINT")) // akmem_use_point
	                			 , sale_ymd // ????????? ???????????? ??? ?????? 2012.07.16)
	                			 , ori_akmem_recpt_no // ????????? ????????? ?????? ??????????????? ??? ?????? (2012.07.16)
	                			 , "SAVECANCLE");
	                	 String AKmem_sApprovNo = (String) map3.get("RSP_CD");
	                	 String AKmem_sMessage = (String) map3.get("MSG_TRMNL");
	                	 System.out.println("???????????? ????????? : AKmem_sApprovNo2 : "+AKmem_sApprovNo);
	                	 HashMap<String, Object> ori_paramMap = lect_dao.getptcaOri(store, sale_ymd, recpt_pos_no, recpt_no);
	                	 if ("00".equals(AKmem_sApprovNo)) {
	                		 
	                		 String AKmem_SaveApproveNo = (String) map3.get("PTCP_PERM_NO");
	                		 String AKmem_SaveApproveNo_POS = (String) map3.get("PERM_NO");
	                		 String AKmem_SaveApprove_Point = (String) map3.get("EUSE_PT");
	                		 String AKmem_CustNo = (String) map3.get("CUS_NO");
	                		 String AKmem_Create_Point = (String) map3.get("TOT_CREA_PT");
	                		 String AKmem_send_buff = (String) map3.get("SEND_STR");
	                		 String AKmem_recv_buff = (String) map3.get("RECV_BUFF");
	                		 
	                		 System.out.println("AKmem_SaveApprove_Point >>>>> ?????? ?????? >>>>> "+AKmem_SaveApprove_Point);
	                		 System.out.println("AKmem_SaveApproveNo = "+ AKmem_SaveApproveNo);
	                		 System.out.println("AKmem_SaveApproveNo_POS = " + AKmem_SaveApproveNo_POS);
	                		 
	                		 // db insert
	                         HashMap<String, Object> paramMap = new HashMap<>();
	                         String tmp_pos_no = "";
	                         if("070013".equals(recpt_pos_no ) || "070014".equals(recpt_pos_no ))
	                         {
	                        	 tmp_pos_no = recpt_pos_no;
	                         }
	                         else 
	                         {
	                        	 tmp_pos_no = pos_no;
	                         }
	                         paramMap.put("store", store);
	                         paramMap.put("pos_no", tmp_pos_no);
	                         paramMap.put("recpt_no", new_recpt_no);
	                         paramMap.put("total_show_amt", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
	                         paramMap.put("total_enuri_amt", Utils.checkNullString(ori_paramMap.get("ENURI_AMT")));
	                         paramMap.put("total_regis_fee", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
	                         paramMap.put("akmem_point_amt", Utils.checkNullString(rs3.get("AKMEM_USE_POINT")));
	                         paramMap.put("AKmem_cardno", new_akmem_card_no);
	                         paramMap.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);
	                         paramMap.put("login_seq", login_seq);
	                         paramMap.put("AKmem_CustNo", AKmem_CustNo);
	                         paramMap.put("AKmem_Family_CustNo", "");
	                         paramMap.put("AKmem_recpt_point", AKmem_Create_Point);
	                         paramMap.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
	                         
	                         lect_dao.saveAKmembersPointLog(paramMap);
//	                    		 lect_dao.insWbptTbCancel2(store, Utils.getCurrentDate(), sale_ymd, pos_no, recpt_pos_no, akmem_recpt_no, ori_akmem_recpt_no, AKmem_SaveApproveNo_POS, AKmem_send_buff, AKmem_recv_buff, AKmem_SaveApprove_Point);
	                		 System.out.println("?????? ??????ok ->db-insert");
	                		 System.out.println("AKmem_SaveApproveNo = "+ AKmem_SaveApproveNo);
	                		 System.out.println("AKmem_SaveApproveNo_POS = " + AKmem_SaveApproveNo_POS);
	                		 System.out.println("AKmem_SaveApprove_Point = " + AKmem_SaveApprove_Point);
	                		 
	                		 // return value??? ????????? ????????? ?????? ( ^????????????????????? ^????????? ?????????)
	                		 
	                	 } else {
	                		 
	                		 System.out.println("???????????? ?????? ?????? !!!!");
	                     
	                     	String card_in_amt = Integer.toString(Utils.checkNullInt(AKmemRead.get("AKmem_total_point")) - Utils.checkNullInt(rs3.get("AKMEM_RECPT_POINT")));
	                		 HashMap<String, Object> paramMap = new HashMap<>();
	                		 String tmp_pos_no = "";
	                         if("070013".equals(recpt_pos_no ) || "070014".equals(recpt_pos_no ))
	                         {
	                        	 tmp_pos_no = recpt_pos_no;
	                         }
	                         else 
	                         {
	                        	 tmp_pos_no = pos_no;
	                         }
	                         paramMap.put("store", store);
	                         paramMap.put("pos_no", tmp_pos_no);
	                         paramMap.put("recpt_no", new_recpt_no);
	                         paramMap.put("total_show_amt", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
	                         paramMap.put("total_enuri_amt", Utils.checkNullString(ori_paramMap.get("ENURI_AMT")));
	                         paramMap.put("total_regis_fee", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
	                         paramMap.put("akmem_point_amt", Utils.checkNullString(rs3.get("AKMEM_USE_POINT")));
	                         paramMap.put("AKmem_cardno", new_akmem_card_no);
	                         paramMap.put("AKmem_SaveApprove_Point", card_in_amt);
	                         paramMap.put("login_seq", login_seq);
	                         paramMap.put("AKmem_CustNo", cust_no.trim());
	                         paramMap.put("AKmem_Family_CustNo", "");
	                         paramMap.put("AKmem_recpt_point", Utils.checkNullString(rs3.get("AKMEM_RECPT_POINT")));
	                         paramMap.put("AKmem_SaveApproveNo_POS", Utils.checkNullString(rs3.get("AKMEM_APPROVE_NO")));
	                		 lect_dao.saveAKmembersPointLog(paramMap);
	                		 
	                		 
	                	 }
	                 }
	                     
	               
				}
			}
			//?????? ????????? ?????? ??? ????????????
			
			
			//?????? ????????? ??????
			HashMap<String, Object> gift = returnGiftInfo(store, period, park_subject_cd, cust_no);
			if(gift != null)
			{
				if("success".equals(gift.get("isSuc")))
				{
					map.put("isGift", "Y");
					map.put("gift_msg", gift.get("msg"));
				}
			}
			map.put("isSuc", "success");
			map.put("msg", "?????????????????????.");
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "???????????? ??????", store+"/"+period+"/"+cust_no);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "??? ??? ?????? ?????? ??????");
		}
		
		
		
		
		
		
		return map;
	}
	@RequestMapping("/getPereByCust")
	@ResponseBody
	public List<HashMap<String, Object>> getPereByCust(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String isCancel = Utils.checkNullString(request.getParameter("isCancel"));
		List<HashMap<String, Object>> list = lect_dao.getPereByCust(store, period, cust_no, isCancel); 
		
		return list;
	}
	@RequestMapping("/getPayment")
	@ResponseBody
	public List<HashMap<String, Object>> getPayment(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		String pos_no = Utils.checkNullString(request.getParameter("pos_no"));
		List<HashMap<String, Object>> list = lect_dao.getPayment(store, period, cust_no, subject_cd, sale_ymd, recpt_no, pos_no); 
		
		return list;
	}
	@RequestMapping("/getPaymentCancel")
	@ResponseBody
	public List<HashMap<String, Object>> getPaymentCancel(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String pos_no = Utils.checkNullString(request.getParameter("pos_no"));
		List<HashMap<String, Object>> list = lect_dao.getPaymentCancel(store, period, cust_no, pos_no, recpt_no); 
		
		return list;
	}
	@RequestMapping("/chargeCheck")
	@ResponseBody
	public HashMap<String, Object> chargeCheck(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		System.out.println("store : "+store);
		System.out.println("pos_no : "+pos_no);
		HashMap<String, Object> data = lect_dao.chargeCheck(store, pos_no); 
		
		return data;
	}
	@RequestMapping("/posEndCheck")
	@ResponseBody
	public String posEndCheck(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		List<HashMap<String, Object>> list = lect_dao.posEndCheck(store, pos_no); 
		
		if(list.size() > 0)
		{
			return Utils.checkNullString(list.get(0).get("SALE_END_YN"));
		}
		else
		{
			return "N";
		}
	}
	@RequestMapping("/getCpConvert")
	@ResponseBody
	public String getCpConvert(HttpServletRequest request) {
		
		String coupon_no = Utils.checkNullString(request.getParameter("coupon_no"));
		String a = lect_dao.getCpConvert(coupon_no);
		return a;
	}
	@RequestMapping("/getCpBack")
	@ResponseBody
	public int getCpBack(HttpServletRequest request) {
		
		String coupon_no = Utils.checkNullString(request.getParameter("coupon_no"));
		int a = lect_dao.getCpBack(coupon_no);
		return a;
	}
	@RequestMapping("/getCpInfo")
	@ResponseBody
	public HashMap<String, Object> getCpInfo(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String coupon_no = Utils.checkNullString(request.getParameter("coupon_no"));
		HashMap<String, Object> data = lect_dao.getCpInfo(store, coupon_no);
		return data;
	}
	@RequestMapping("/getEnuriByCust")
	@ResponseBody
	public List<HashMap<String, Object>> getEnuriByCust(HttpServletRequest request) {
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		List<HashMap<String, Object>> list = lect_dao.getEnuriByCust(store,period,cust_no); 
		
		return list;
	}
	@RequestMapping("/getGiftByCust")
	@ResponseBody
	public List<HashMap<String, Object>> getGiftByCust(HttpServletRequest request) {
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		List<HashMap<String, Object>> list = lect_dao.getGiftByCust(store, period, cust_no); 
		
		return list;
	}
	@RequestMapping("/getSaleByCust")
	@ResponseBody
	public List<HashMap<String, Object>> getSaleByCust(HttpServletRequest request) {
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		List<HashMap<String, Object>> list = lect_dao.getSaleByCust(cust_no); 
		
		return list;
	}
	
	@RequestMapping("/getChildByCust")
	@ResponseBody
	public List<HashMap<String, Object>> getChildByCust(HttpServletRequest request) {
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		List<HashMap<String, Object>> list = lect_dao.getChildByCust(cust_no); 
		
		return list;
	}
	
	
	@RequestMapping("/saveChild")
	@ResponseBody
	public HashMap<String, Object> saveChild(HttpServletRequest request) {
		
		String child_nm[] = Utils.checkNullString(request.getParameter("child_nm")).split("\\|");
		String child_gender[] = Utils.checkNullString(request.getParameter("child_gender")).split("\\|");
		String child_birth[] = Utils.checkNullString(request.getParameter("child_birth")).replaceAll("-", "").split("\\|");
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		
		
		for(int i = 0; i < child_nm.length; i++)
		{
			if (!child_nm[i].equals("")) {
				int child_no = lect_dao.getlast_childNo(cust_no); 
				lect_dao.saveChild(child_no, child_nm[i], child_gender[i], child_birth[i], cust_no);
			}
		}

		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		
        return map;
	}

	@RequestMapping("/GetApproveNo")
	@ResponseBody
	public HashMap<String, Object> GetApproveNo(HttpServletRequest request) throws Exception {
		
		
		String approve = null;
        String sApprovNo = null;
        String sMessage = null;

        String scBank_cd = null;
        String scRate = null;
        String return_cd = null;

        String identiNo = null; // ????????? ??????????????? ?????? VAN ??????????????????
        String rest_amt = null; // ???????????? ?????? (2012.01.10)

        String hq = Utils.checkNullString(request.getParameter("hq"));
        String store = Utils.checkNullString(request.getParameter("store"));
        String approve_no_exp = Utils.checkNullString(request.getParameter("approve_no_exp"));
        String ls_send_str_F = Utils.checkNullString(request.getParameter("ls_send_str_F"));
        String ls_send_str = Utils.checkNullString(request.getParameter("ls_send_str"));
        HashMap<String, Object> map = new HashMap<>();
        log.info("SEND_DATA : [" + ls_send_str + "]");
        String msgType = ls_send_str.trim().substring(0, 6);
        try
        {
			
		        
	        if(true)
	        {
	        	//return map; //???????????? ???????????????.
	        }
	        
			BABatchRun acard = new BABatchRun();
			
			if("00".equals(hq) && "01".equals(store))
			{
	            // ?????????
	            acard.setHost("172.10.1.71", 9302);
	        }
			else if("00".equals(hq) && "02".equals(store))
			{
	            // ?????????
	            acard.setHost("173.10.1.71", 9302);
	        }
			else if("00".equals(hq) && "03".equals(store))
			{
	            // ?????????
				acard.setHost(bundang_approve_ip, Integer.parseInt(bundang_approve_port));
	        }
			else if("00".equals(hq) && "04".equals(store))
			{
	            // ?????????
	            acard.setHost("174.10.1.71", 9302);
	        }
			else if("00".equals(hq) && "05".equals(store))
			{
	            // ?????????
	            acard.setHost("175.10.1.71", 9302);
	        }
		
        
			if("XA077S".equals(msgType) || "XB077S".equals(msgType)){ // "XB077S" ????????? `???????????? ?????? XA077S ?????? ?????? ??????
	            if(acard.start().equals("OK")){
	            	approve = acard.run(ls_send_str);
	                sApprovNo = approve.substring(0, 9);
	                scBank_cd = approve.substring(9, 10);
	                scRate = approve.substring(10, 11);
	                sMessage = approve.substring(11).trim();
	                if("XB077S".equals(msgType)){
	                    sMessage = approve.substring(11, 46).trim();
	                    identiNo = approve.substring(121, 133).trim();
	                }
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // ?????? ???????????????(OLD)
	        }else if("XA078S".equals(msgType)){
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);
	
	                sApprovNo = approve.substring(0, 9);
	                scBank_cd = approve.substring(9, 10);
	                scRate = approve.substring(10, 11);
	                sMessage = approve.substring(11).trim();
	                // approve);
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // ?????? ???????????????(NEW) ????????? ?????? ????????? ??????????????? ????????? ????????? ?????? ?????? (2012.08.20)
	        }else if("XA087S".equals(msgType) || // ????????? ?????? KITC KFTC?????????
	                "XA082S".equals(msgType) || // ??????????????? NICE 20161010
	                "XA084S".equals(msgType) || // ??????????????? KOVAN 20161010
	                "XA080S".equals(msgType) || // ??????????????? KICC 20161010
	                "XA085S".equals(msgType) || // ???????????? NICE ??????X20161010
	                "XA103S".equals(msgType) || // ???????????? KOVAN ??????X20161010
	                "XA104S".equals(msgType) || "XA085S".equals(msgType) || // JTNET
	                "XA093S".equals(msgType) || // KIS
	                "XA086S".equals(msgType) // SPCN
	        ){
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);
	
	                sApprovNo = approve.substring(0, 9);
	                scBank_cd = approve.substring(9, 10);
	                scRate = approve.substring(10, 11);
	                sMessage = approve.substring(11).trim();
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // ????????? ?????? ???????????????
	        }else if("XB080S".equals(msgType) || // ??????????????? KICC 20161010
	                "XB082S".equals(msgType) || // ??????????????? NICE 20161010
	                "XB084S".equals(msgType) || // ??????????????? KOVAN 20161010
	                "XB085S".equals(msgType) || // JTNET
	                "XB086S".equals(msgType) || // SPCN
	                "XB087S".equals(msgType) || // ????????? ?????? KITC KFTC?????????
	                "XB093S".equals(msgType) // KIS
	        ){
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);
	
	                sApprovNo = approve.substring(0, 9);
	                scBank_cd = approve.substring(9, 10);
	                scRate = approve.substring(10, 11);
	                sMessage = approve.substring(11,46).trim();
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // ???????????? ?????? ??????
	        }else if("XA081S".equals(msgType)){
	            acard.setHost("91.3.105.11", 9002);
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);
	
	                return_cd = approve.substring(0, 4);
	                sApprovNo = approve.substring(4, 12);
	                sMessage = approve.substring(12).trim();
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // ???????????? ?????? ??????(????????????)
	        }else if("XA071S".equals(msgType) || "XB071S".equals(msgType)
	                || "NFB71S".equals(msgType)){ // "XB071S" ????????? ???????????? ?????? XA071S
	                                                // ?????? ?????? ?????? NFB71S(RF??????) ??????
	            if(acard.start().equals("OK")){
	                // ???????????? ?????????????????? ???????????? ???????????? ??????
	                if("00".equals(hq) && "00".equals(store)){ // ?????????????????? ?????? ?????? ???????????? ??????
	
	                    // ?????????
	                    approve = acard.run(ls_send_str);
	                    sApprovNo = approve.substring(0, 8);
	                    scBank_cd = approve.substring(8, 9);
	                    scRate = approve.substring(9, 10);
	                    sMessage = approve.substring(10, 50).trim();
	                    rest_amt = approve.substring(50).trim();// ??????????????? ????????????????????? ?????? ??????
	                } else {
	                    // ??????,??????,??????,??????,+???????????? ?????????
	//                    approve = acard.run(ls_send_str);
	//
	//                    sApprovNo = approve.substring(0, 8);
	//                    scBank_cd = approve.substring(26, 27);
	//                    scRate = approve.substring(27, 28);
	//                    sMessage = subString(approve, 28, 40, null).trim();
	                    
	                    approve = acard.run(ls_send_str);
	                    return_cd = approve.substring(0, 4); // ????????????
	                    sApprovNo = approve.substring(4, 12);
	                    scBank_cd = approve.substring(12, 13);
	                    scRate = approve.substring(13, 14);
	                  //00000005162225 
	                    sMessage = approve.substring(14, 54).trim();
	                    rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                }
	
	
	                if(!"0000".equals(return_cd)){ // ????????? ???????????????
	                    sMessage = "[" + return_cd + "]" + sMessage;// ????????????
	                    map.put("isSuc", "fail");
	    	        	map.put("msg", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                }    
	                    
	                // scRate??? ???????????????.
	                // VAN_FG value
	                if("1".equals(scRate)){ // KFTC
	                    scRate = "01"; // KFTC
	                }else if("2".equals(scRate)){ // NICE
	                    scRate = "02"; // NICE
	                }else if("4".equals(scRate)){ // KOVEN
	                    scRate = "03"; // KOVEN
	                }else if("5".equals(scRate)){ // SSCARD
	                    scRate = "20";
	                }else if("6".equals(scRate)){ // KICC
	                    scRate = "05"; // KICC
	                }else if("7".equals(scRate)){ // JTNET
	                    scRate = "06"; // JTNET
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // KIS
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // SPCN
	                }
	                
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // KB????????? ?????? ?????? ?????? - 2017.07.12 ?????????
	        }else if("XA271S".equals(msgType) || "XA272S".equals(msgType)
	                || "XA273S".equals(msgType)){
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);
	
	                return_cd = approve.substring(6, 10); // ????????????
	
	                if(return_cd == null) { // ??????????????? null ??? ??????
	                	map.put("isSuc", "fail");
    	        		map.put("msg", "[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                }
	                if(return_cd.equals("0098")){ // Van??? ??????
	                    // ????????? ????????? ?????? ??????
	                    if("XA271S".equals(msgType)){ // ??????
	                        ls_send_str = "XA071S" + ls_send_str.substring(6);
	                    }else if("XA272S".equals(msgType)){ // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                        // ????????? ?????? ?????????
	                        String dupStr = "XA073S" + ls_send_str.substring(6, 46);
	                        String vanCd = ls_send_str.substring(6, 46); // ?????????
	                                                                        // ??????????????????(3)
	                        String cardNo = ls_send_str.substring(6, 46); // ????????????(16)
	                        String oAprvNo = ls_send_str.substring(6, 46); // ???????????????(8)
	                        String oTrdDt = ls_send_str.substring(6, 46); // ???????????????(8)
	                        String instMm = ls_send_str.substring(6, 46); // ????????????(2)
	                        String amt = ls_send_str.substring(6, 46); // ??????(11)
	
	                        // ????????? ???????????? ??????
	                        ls_send_str = dupStr + vanCd + cardNo + oAprvNo
	                                + oTrdDt + instMm + amt;
	                    }
	
	                    // ????????????????????? Timeout ????????????(0098) ??? ????????? ????????? ?????? ?????? ???????????? Van??? ??????
	                    acard.stop();
	
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);
	
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && ("00".equals(store))){
	                            // ?????????
	                            sApprovNo = approve.substring(0, 8);
	                            scBank_cd = approve.substring(8, 9);
	                            scRate = approve.substring(9, 10);
	                            sMessage = approve.substring(10).trim();
	                        } else {
	                            // ??????,??????,??????,??????,+????????????
	                            sApprovNo = approve.substring(0, 8);
	                            scBank_cd = approve.substring(26, 27);
	                            scRate = approve.substring(27, 28);
	                            sMessage = approve.substring(28).trim();
	                        }
	                    }
	                }else if("0099".equals(return_cd)){ // ?????????
	                	map.put("isSuc", "fail");
	    	        	map.put("msg", "[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                }else if(!"0000".equals(return_cd)){ // ?????????
	                    sMessage = acard.subString(approve, 28, 40, null).trim(); // ?????????
	                    sMessage = "[" + return_cd + "]" + sMessage;
	                    map.put("isSuc", "fail");
	    	        	map.put("msg", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                } else {
	                    if("XA271S".equals(msgType)){ // ??????
	                        System.out.println("KB ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }else if("XA272S".equals(msgType)){ // ??????
	                        System.out.println("KB ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }else if("XA273S".equals(msgType)){ // ?????????
	                        System.out.println("KB ????????? ????????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	
	                    approve = approve.substring(42); // ?????? ???????????? ????????? ?????? Body??? ??????
	
	                    sApprovNo = approve.substring(0, 8);
	                    scBank_cd = approve.substring(26, 27);
	                    scRate = approve.substring(27, 28);
	                    sMessage = acard.subString(approve, 28, 40, null).trim(); // ?????????
	                                                                        // ????????????
	                    sMessage = "[" + return_cd + "]" + sMessage;
	
	                }
	
	
	                // VAN_FG value
	                if("1".equals(scRate)){ // KFTC
	                    scRate = "01";
	                }else if("2".equals(scRate)){ // NICE
	                    scRate = "02";
	                }else if("4".equals(scRate)){ // KOVEN
	                    scRate = "03";
	                }else if("5".equals(scRate)){ // SSCARD
	                    scRate = "04";
	                }else if("6".equals(scRate)){ // KICC
	                    scRate = "05";
	                }else if("7".equals(scRate)){ // JTNET
	                    scRate = "06";
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07";
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08";
	                }else if("A".equals(scRate)){ // ????????? ?????????
	                    scRate = "10";
	                }else if("B".equals(scRate)){ // KB ?????????
	                    scRate = "11";
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	        }else if("XB271S".equals(msgType) || "XB272S".equals(msgType)
	                || "XB273S".equals(msgType)){
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);
	                return_cd = approve.substring(6, 10); // ????????????
	
	                if(return_cd == null)
	                {
	                	map.put("isSuc", "fail");
		    	        map.put("msg", "[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                }
	                if("0098".equals(return_cd)){ // Van??? ?????? ??????(SCS7010)??? ?????????  ???(KB?????????)??? ?????? ????????????
	                    // ????????? ????????? ?????? ??????
	                    if("XB271S".equals(msgType)){ // ??????
	                        ls_send_str = "XB071S"+ ls_send_str_F.substring(6);
	                    }else if("XB272S".equals(msgType)){ // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                        // ????????? ?????? ?????????
	                        String dupStr = "XA073S" + ls_send_str.substring(6, 46);
	                        String vanCd = ls_send_str.substring(6, 46); // ?????????
	                                                                        // ??????????????????(3)
	                        String cardNo = ls_send_str.substring(6, 46); // ????????????(16)
	                        String oAprvNo = ls_send_str.substring(6, 46); // ???????????????(8)
	                        String oTrdDt = ls_send_str.substring(6, 46); // ???????????????(8)
	                        String instMm = ls_send_str.substring(6, 46); // ????????????(2)
	                        String amt = ls_send_str.substring(6, 46); // ??????(11)
	
	                        // ????????? ???????????? ??????
	                        ls_send_str = dupStr + vanCd + cardNo + oAprvNo + oTrdDt + instMm + amt;
	                    }
	
	                    // ????????????????????? Timeout ????????????(0098) ??? ????????? ????????? ?????? ?????? ???????????? Van??? ??????
	                    acard.stop();
	
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);
	
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && "00".equals(store)){ // ????????? ?????? ?????? ?????? ???????????? ?????? ??? ?????????????????? ?????? ?????? ???????????? ??????
	                            // ?????????
	//                            approve = acard.run(ls_send_str);
	//                            sApprovNo = approve.substring(0, 8);
	//                            scBank_cd = approve.substring(8, 9);
	//                            scRate = approve.substring(9, 10);
	//                            sMessage = approve.substring(10, 50).trim();
	//                            rest_amt = approve.substring(50).trim();// ???????????????  ????????????????????? ?????? ??????
	                            
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        } else {
	                            // ??????,??????,??????,??????,+???????????? ????????? ?????? 
	//                            approve = acard.run(ls_send_str);
	//                            sApprovNo = approve.substring(0, 8);
	//                            scBank_cd = approve.substring(26, 27);
	//                            scRate = approve.substring(27, 28);
	//                            sMessage = subString(approve, 28, 40, null).trim();
	//                            approve = acard.run(ls_send_str);
	                            
	//                            sApprovNo = approve.substring(0, 8);
	//                            scBank_cd = approve.substring(8, 9);
	//                            scRate = approve.substring(9, 10);
	//                            sMessage = approve.substring(10, 50).trim();
	//                            rest_amt = approve.substring(50).trim();// ???????????????  ????????????????????? ?????? ??????
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        }
	                        
	                        if(!"0000".equals(return_cd)){ // ?????????
	                            sMessage = "[" + return_cd + "]" + sMessage;// ????????????
	                            map.put("isSuc", "fail");
	    		    	        map.put("msg", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                            throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        }    
	                    }
	                }else if("0099".equals(return_cd)){ // ????????? timeout
	                	map.put("isSuc", "fail");
		    	        map.put("msg", "[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception( "[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                }else if(!"0000".equals(return_cd)){ // ?????????
	                    sMessage = acard.subString(approve, 28, 40, null).trim(); // ?????????
	                    sMessage = "[" + return_cd + "]" + sMessage;// ????????????
	                    map.put("isSuc", "fail");
		    	        map.put("msg", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                } else {
	                    if("XB271S".equals(msgType)){ // ??????
	                        System.out.println("KB ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }else if("XB272S".equals(msgType)){ // ??????
	                        System.out.println("KB ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }else if("XB273S".equals(msgType)){ // ?????????
	                        System.out.println("KB ????????? ????????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	
	                    approve = approve.substring(42); // ?????? ???????????? ????????? ?????? Body??? ??????
	
	                    // ????????? ??????
	                    sApprovNo = approve.substring(0, 8);
	                    scBank_cd = approve.substring(26, 27);
	                    scRate = approve.substring(27, 28);
	                    sMessage = acard.subString(approve, 28, 40, null);
	                    sMessage = "[" + return_cd + "]" + sMessage;
	                    rest_amt = approve.substring(68, 77).trim(); // AK?????????(555),????????????(666) ????????? ?????? ?????? (12.01.17)
	                }
	
	
	                // scRate??? ???????????????.
	
	                // VAN_FG value
	                if("1".equals(scRate)){ // KFTC
	                    scRate = "01"; // KFTC
	                }else if("2".equals(scRate)){ // NICE
	                    scRate = "02"; // NICE
	                }else if("4".equals(scRate)){ // KOVEN
	                    scRate = "03"; // KOVEN
	                }else if("5".equals(scRate)){ // SSCARD
	                    scRate = "04";
	                }else if("6".equals(scRate)){ // KICC
	                    scRate = "05"; // KICC
	                }else if("7".equals(scRate)){ // JTNET
	                    scRate = "06"; // JTNET
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // KIS
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // SPCN
	                }else if("A".equals(scRate)){ // ????????? ?????????
	                    scRate = "10";
	                }else if("B".equals(scRate)){ // KB ?????????
	                    scRate = "11";
	                }
	                else if("C".equals(scRate)){ // BC ?????????
	                    scRate = "12";
	                }
	                else if("D".equals(scRate)){ // ?????? ?????????
	                    scRate = "13";
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	        }
	        // BC ?????? ????????? cmc 2019.05
	        else if("XB414S".equals(msgType) || "XB415S".equals(msgType) || "XB416S".equals(msgType)){
	           
	            if(acard.start().equals("OK")){
	                
	                approve = acard.run(ls_send_str);             //?????? ??????
	                return_cd = approve.substring(6, 10);       // ????????????
	                
	                if(return_cd == null) {
	                	map.put("isSuc", "fail");
	                	map.put("msg", "[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                }
	                if("0098".equals(return_cd)){   // Van??? ?????? ??????(SCS7010)??? ?????????  ???(?????????)??? ?????? ???????????? - ????????? ????????? ?????? ??????
	                
	                    if("XB414S".equals(msgType)){   // van??? ?????? ?????? ??????
	                        ls_send_str = "XB071S"+ ls_send_str_F.substring(6);
	                    }
	                    else if("XB415S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                    }
	                    
	                    //  ????????????????????? Timeout ????????????(0098) ??? ????????? ????????? ?????? ?????? ???????????? Van??? ??????
	                    acard.stop();
	                    
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);       //van??? ????????????
	
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && "00".equals(store)){  // ????????? ?????? ?????? ?????? ???????????? ?????? ??? ?????????????????? ?????? ?????? ???????????? ??????
	                            
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        } 
	                        else {                            
	                         //   approve = acard.run(ls_send_str);      // ?????? 2??? ????????? ??????????????? ???????????? ?????? ??????? cmc
	                            
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();            // ??????????????? ????????????????????? ?????? ??????
	                        }
	                        
	                        if(!"0000".equals(return_cd)){   // ?????????
	                            sMessage = "[" + return_cd + "]" + sMessage;        // ????????????
	                            throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        }
	                    }
	                }
	                else if("0099".equals(return_cd)){ // ????????? ??? ????????????
	                	map.put("isSuc", "fail");
	                	map.put("msg", "[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception( "[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    
	                    /* cmc - ????????? ?????? ?????? ???????????????, KB??? ???????????? ????????????????????? ???????????? ?????? ?????? - ????????? ?????? ??????(2019.06.19) */
	                    /*
	                    if("XB414S".equals(msgType)){   // ????????? ?????? ??????
	                        ls_send_str = "XB416S"+ param.getParameter("ls_send_str").substring(6);
	                    }
	                    else if("XB415S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? ????????? ?????? ??????
	                    }
	                    
	                    acard.stop();
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);       //????????? ????????????
	                    }
	                    
	                    if("XB414S".equals(msgType)){   // van??? ?????? ?????? ??????
	                        ls_send_str = "XB071S"+ param.getParameter("ls_send_str_F").substring(6);
	                    }
	                    else if("XB415S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                    }
	                    
	                    acard.stop();
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);       //van??? ????????????
	
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && "00".equals(store)){  // ????????? ?????? ?????? ?????? ???????????? ?????? ??? ?????????????????? ?????? ?????? ???????????? ??????
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        } 
	                        else {
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();            // ??????????????? ????????????????????? ?????? ??????
	                        }
	                        
	                        if(!"0000".equals(return_cd)){
	                            sMessage = "[" + return_cd + "]" + sMessage;        // ????????????
	                            throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        }
	                    }
	                    */
	                }
	                else if(!"0000".equals(return_cd)){ // ?????????                    
	                    
	                    sMessage = acard.subString(approve, 28, 40, null).trim();     // ?????????
	                    sMessage = "[" + return_cd + "]" + sMessage;          // ????????????
	                    map.put("isSuc", "fail");
	                	map.put("msg", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    
	                    // cmc - 98 ,99 ????????? ????????? ???????????? ?????????
	                    /*
	                    if("XB414S".equals(msgType)){   // van??? ?????? ?????? ??????
	                        ls_send_str = "XB071S"+ param.getParameter("ls_send_str_F").substring(6);
	                    }
	                    else if("XB415S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                    }
	                    
	                    //  ????????????????????? Timeout ????????????(0098) ??? ????????? ????????? ?????? ?????? ???????????? Van??? ??????
	                    acard.stop();
	                    
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);       //van??? ????????????
	
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && "00".equals(store)){  // ????????? ?????? ?????? ?????? ???????????? ?????? ??? ?????????????????? ?????? ?????? ???????????? ??????
	                            
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        } 
	                        else {                            
	                         //   approve = acard.run(ls_send_str);
	                            
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();            // ??????????????? ????????????????????? ?????? ??????
	                        }
	                        
	                        if(!"0000".equals(return_cd)){   // ?????????
	                            sMessage = "[" + return_cd + "]" + sMessage;        // ????????????
	                            throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        }
	                    }
	                    */
	                } 
	                else {
	                    if("XB414S".equals(msgType)){ // ??????
	                        System.out.println("BC ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	                    else if("XB415S".equals(msgType)){ // ??????
	                        System.out.println("BC ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	                    else if("XB416S".equals(msgType)){ // ?????????
	                        System.out.println("BC ????????? ????????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	
	                    approve = approve.substring(42);                    // ?????? ???????????? ????????? ?????? Body??? ??????
	
	                    // ????????? ??????
	                    sApprovNo = approve.substring(0, 8);
	                    scBank_cd = approve.substring(26, 27);
	                    scRate = approve.substring(27, 28);
	                    sMessage = acard.subString(approve, 28, 40, null);
	                    sMessage = "[" + return_cd + "]" + sMessage;
	                    rest_amt = approve.substring(68, 77).trim();    // AK?????????(555),????????????(666) ????????? ?????? ?????? (12.01.17)
	                }
	
	
	                // VAN_FG value
	                if("1".equals(scRate)){ // KFTC
	                    scRate = "01"; // KFTC
	                }
	                else if("2".equals(scRate)){ // NICE
	                    scRate = "02"; // NICE
	                }
	                else if("4".equals(scRate)){ // KOVEN
	                    scRate = "03"; // KOVEN
	                }
	                else if("5".equals(scRate)){ // SSCARD
	                    scRate = "04";
	                }
	                else if("6".equals(scRate)){ // KICC
	                    scRate = "05"; // KICC
	                }
	                else if("7".equals(scRate)){ // JTNET
	                    scRate = "06"; // JTNET
	                }
	                else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // KIS
	                }
	                else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // SPCN
	                }
	                else if("A".equals(scRate)){ // ????????? ?????????
	                    scRate = "10";
	                }
	                else if("B".equals(scRate)){ // KB ?????????
	                    scRate = "11";
	                }
	                else if("C".equals(scRate)){ // BC ?????????
	                    scRate = "12";
	                }
	                else if("D".equals(scRate)){ // ?????? ?????????
	                    scRate = "13";
	                }
	            } 
	            else {
	                sApprovNo = "Fail0000";
	            }
	        }    //BC ?????? ????????? ??? 
	        // ?????? ?????? ????????? cmc 2019.05
	        else if("XB424S".equals(msgType) || "XB425S".equals(msgType) || "XB426S".equals(msgType)){
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);   //?????? ??????
	                return_cd = approve.substring(6, 10);   // ????????????
	
	                if(return_cd == null)
	                {
	                	map.put("isSuc", "fail");
	                	map.put("msg", "[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] ??? ??? ?????? ?????? ??????, ???????????? ?????? ??????????????????.");
	                }
	                
	                if("0098".equals(return_cd)){       
	//                  Van??? ?????? ??????(SCS7010)??? ?????????  ???(KB?????????)??? ?????? ???????????? - ????????? ????????? ?????? ??????  
	                    if("XB424S".equals(msgType)){   //?????? ?????? ?????? ??????
	                        ls_send_str = "XB071S"+ ls_send_str_F.substring(6);
	                    }
	                    else if("XB425S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                    }
	                    
	                    // ????????????????????? Timeout ????????????(0098) ??? ????????? ????????? ?????? ?????? ???????????? Van??? ??????
	                    acard.stop();
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);
	                        
	                        
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && "00".equals(store)){  // ????????? ?????? ?????? ?????? ???????????? ?????? ??? ?????????????????? ?????? ?????? ???????????? ??????
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        } 
	                        else {
	                            //approve = acard.run(ls_send_str);   // ?????? 2??? ????????? ??????????????? ???????????? ?????? ??????? cmc
	                            
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();            // ??????????????? ????????????????????? ?????? ??????
	                        }
	                        
	                        if(!"0000".equals(return_cd)){   // ?????????
	                            sMessage = "[" + return_cd + "]" + sMessage;        // ????????????
	                            map.put("isSuc", "fail");
	    	                	map.put("msg", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                            throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        }
	                    }
	                }
	                else if("0099".equals(return_cd)){ // ????????? timeout
	                	map.put("isSuc", "fail");
	                	map.put("msg",  "[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception( "[??????] ??? ?????? ??????, ???????????? ?????? ??????????????????.");
	                    
	                    /* cmc - ????????? ?????? ?????? ???????????????, KB??? ???????????? ????????????????????? ???????????? ?????? ?????? - ????????? ?????? ??????(2019.06.19) */
	                    /*
	                    if("XB424S".equals(msgType)){  //????????? ?????? ??????
	                        ls_send_str = "XB426S"+ param.getParameter("ls_send_str").substring(6);
	                    }
	                    else if("XB425S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? ????????? ?????? ??????
	                    }
	                    
	                    acard.stop();
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);       //????????? ????????????
	                    }
	                    
	                    // VAN??? ?????? ?????? ??????
	                    if("XB424S".equals(msgType)){   // ??????
	                        ls_send_str = "XB071S"+ param.getParameter("ls_send_str_F").substring(6);
	                    }
	                    else if("XB425S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                    }
	                    
	                    acard.stop();
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);       //van??? ????????????
	
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && "00".equals(store)){  // ????????? ?????? ?????? ?????? ???????????? ?????? ??? ?????????????????? ?????? ?????? ???????????? ??????
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        } 
	                        else {
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();            // ??????????????? ????????????????????? ?????? ??????
	                        }
	                        
	                        if(!"0000".equals(return_cd)){   // ?????????
	                            sMessage = "[" + return_cd + "]" + sMessage;        // ????????????
	                            throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        }
	                    }
	                    */
	                }
	                else if(!"0000".equals(return_cd)){ // ?????????
	                    sMessage = acard.subString(approve, 28, 40, null).trim();     // ?????????
	                    sMessage = "[" + return_cd + "]" + sMessage;            // ????????????
	                    map.put("isSuc", "fail");
	                	map.put("msg",  "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    
	                    
	                    // 98, 99 ????????? ????????? ???????????? ????????? cmc
	                    /*
	                    if("XB424S".equals(msgType)){   //?????? ?????? ?????? ??????
	                        ls_send_str = "XB071S"+ param.getParameter("ls_send_str_F").substring(6);
	                    }
	                    else if("XB425S".equals(msgType)){  // ??????
	                        // ????????? ?????? ??? ????????? ?????? Van?????? ???????????? ????????? ?????????.
	                    }
	                    
	                    // ????????????????????? Timeout ????????????(0098) ??? ????????? ????????? ?????? ?????? ???????????? Van??? ??????
	                    acard.stop();
	                    if(acard.start().equals("OK")){
	                        approve = acard.run(ls_send_str);
	                        
	                        // ???????????? ?????????????????? ???????????? ???????????? ??????
	                        if("00".equals(hq) && "00".equals(store)){  // ????????? ?????? ?????? ?????? ???????????? ?????? ??? ?????????????????? ?????? ?????? ???????????? ??????
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
	                        } 
	                        else {
	                            //approve = acard.run(ls_send_str);   //?????? ?????? XB071S ??? ?????? ??????
	                            
	                            return_cd = approve.substring(0, 4); // ????????????
	                            sApprovNo = approve.substring(4, 12);
	                            scBank_cd = approve.substring(12, 13);
	                            scRate = approve.substring(13, 14);
	                            sMessage = approve.substring(14, 54).trim();
	                            rest_amt = approve.substring(54).trim();            // ??????????????? ????????????????????? ?????? ??????
	                        }
	                        
	                        if(!"0000".equals(return_cd)){   // ?????????
	                            sMessage = "[" + return_cd + "]" + sMessage;        // ????????????
	                            throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        }
	                    }
	                    */
	                } 
	                else {
	                    if("XB424S".equals(msgType)){ // ??????
	                        System.out.println("?????? ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	                    else if("XB425S".equals(msgType)){ // ??????
	                        System.out.println("?????? ????????? ?????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	                    else if("XB426S".equals(msgType)){ // ?????????
	                        System.out.println("?????? ????????? ????????? : (??????)   >>>>>>>>>>>>>>>>>>>>>>>>>>>");
	                    }
	
	                    approve = approve.substring(42);                    // ?????? ???????????? ????????? ?????? Body??? ??????
	                    sApprovNo = approve.substring(0, 8);
	                    scBank_cd = approve.substring(26, 27);
	                    scRate = approve.substring(27, 28);
	                    sMessage = acard.subString(approve, 28, 40, null);
	                    sMessage = "[" + return_cd + "]" + sMessage;
	                    rest_amt = approve.substring(68, 77).trim();        // AK?????????(555),????????????(666) ????????? ?????? ?????? (12.01.17)
	                }
	
	
	                // VAN_FG value
	                if("1".equals(scRate)){ // KFTC
	                    scRate = "01"; // KFTC
	                }
	                else if("2".equals(scRate)){ // NICE
	                    scRate = "02"; // NICE
	                }
	                else if("4".equals(scRate)){ // KOVEN
	                    scRate = "03"; // KOVEN
	                }
	                else if("5".equals(scRate)){ // SSCARD
	                    scRate = "04";
	                }
	                else if("6".equals(scRate)){ // KICC
	                    scRate = "05"; // KICC
	                }
	                else if("7".equals(scRate)){ // JTNET
	                    scRate = "06"; // JTNET
	                }
	                else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // KIS
	                }
	                else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // SPCN
	                }
	                else if("A".equals(scRate)){ // ????????? ?????????
	                    scRate = "10";
	                }
	                else if("B".equals(scRate)){ // KB ?????????
	                    scRate = "11";
	                }
	                else if("C".equals(scRate)){    // BC ?????????
	                    scRate = "12";
	                }
	                else if("D".equals(scRate)){    // ?????? ?????????
	                    scRate = "13";
	                }
	            } 
	            else {
	                sApprovNo = "Fail0000";
	            }
	        }   // ???????????? ????????? ???
	        // BCQR ?????? ?????? cmc 2019.05
	        else if("XB511S".equals(msgType) ) {
	            
	            if(acard.start().equals("OK")){
	                approve = acard.run(ls_send_str);
	                
	                // ????????????
	                return_cd = approve.substring(0, 4);
	                sApprovNo = approve.substring(4, 12);
	                scBank_cd = approve.substring(12, 13);
	                scRate = approve.substring(13, 14);
	                sMessage = approve.substring(14, 54).trim();
	                rest_amt = approve.substring(54).trim();        // ??????????????? ????????????????????? ?????? ??????
	                
	
	
	                if(!"0000".equals(return_cd)){ // ????????? ???????????????
	                    if("7804".equals(return_cd) || "1401".equals(return_cd)) { 
	                    }
	                    else {
	                        sMessage = "[" + return_cd + "]" + sMessage;// ????????????
	                        map.put("isSuc", "fail");
		                	map.put("msg",  "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                        throw new Exception("[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
	                    }
	                }
	
	                // VAN_FG value
	                if("1".equals(scRate)){ // KFTC
	                    scRate = "01"; // KFTC
	                }else if("2".equals(scRate)){ // NICE
	                    scRate = "02"; // NICE
	                }else if("4".equals(scRate)){ // KOVEN
	                    scRate = "03"; // KOVEN
	                }else if("5".equals(scRate)){ // SSCARD
	                    scRate = "04";
	                }else if("6".equals(scRate)){ // KICC
	                    scRate = "05"; // KICC
	                }else if("7".equals(scRate)){ // JTNET
	                    scRate = "06"; // JTNET
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // KIS
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // SPCN
	                }
	            } 
	            else {
	                sApprovNo = "Fail0000";
	            }
	        }   // bcqr  ???
	        //      AK?????????(555),????????????(666) ???????????? ?????? ??????(????????????)????????? ??????
	        else if("XB075S".equals(msgType)){
	            if(acard.start().equals("OK")){
	                // ?????? ??????
	
	                approve = acard.run(ls_send_str);
	                sApprovNo = approve.substring(0, 8);
	                scBank_cd = approve.substring(8, 9);
	                scRate = approve.substring(9, 10);
	                // sMessage = approve.substring(10,46);
	                sMessage = approve.substring(10, 50).trim();
	                rest_amt = approve.substring(50).trim(); // AK?????????(555),????????????(666) ????????? ?????? ??????(12.01.17)
	
	
	                // scRate??? ???????????????.
	
	                if("1".equals(scRate)){
	                    scRate = "01";
	                }else if("2".equals(scRate)){
	                    scRate = "02";
	                }else if("4".equals(scRate)){
	                    scRate = "03";
	                }else if("5".equals(scRate)){
	                    scRate = "04";
	                }else if("6".equals(scRate)){
	                    scRate = "05";
	                }else if("7".equals(scRate)){
	                    scRate = "06";
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // JTNET
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // JTNET
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // AK?????????(555),????????????(666) ???????????? ?????? ??????(????????????)
	            // (2011.01.17??????)(????????????20161010)
	        }else if("XA075S".equals(msgType)){
	            if(acard.start().equals("OK")){
	                // ?????? ??????
	                approve = acard.run(ls_send_str);
	                sApprovNo = approve.substring(0, 8);
	                scBank_cd = approve.substring(8, 9);
	                scRate = approve.substring(9, 10);
	                // sMessage = approve.substring(10,46);
	                sMessage = approve.substring(10, 46).trim();
	                rest_amt = approve.substring(46).trim(); // AK?????????(555),????????????(666)
	                                                            // ?????? ?????? (12.01.17)
	
	                // scRate??? ???????????????.
	
	                if("1".equals(scRate)){
	                    scRate = "01";
	                }else if("2".equals(scRate)){
	                    scRate = "02";
	                }else if("4".equals(scRate)){
	                    scRate = "03";
	                }else if("5".equals(scRate)){
	                    scRate = "04";
	                }else if("6".equals(scRate)){
	                    scRate = "05";
	                }else if("7".equals(scRate)){
	                    scRate = "06";
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // JTNET
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // JTNET
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // AK?????????(555),????????????(666) ?????????????????? ?????? ??????(????????????) (2011.01.17
	            // ??????)(????????????20161010)
	        }else if("XA076S".equals(msgType)){
	            if(acard.start().equals("OK")){
	
	                // ?????? ??????
	                approve = acard.run(ls_send_str);
	                sApprovNo = approve.substring(0, 8);
	                scBank_cd = approve.substring(8, 9);
	                scRate = approve.substring(9, 10);
	                sMessage = approve.substring(10, 46);
	                sMessage = approve.substring(10, 46).trim();
	                rest_amt = approve.substring(46).trim(); // AK?????????(555),????????????(666)
	                                                            // ?????? ?????? (12.01.17)
	
	                // scRate??? ???????????????.
	
	                if("1".equals(scRate)){
	                    scRate = "01";
	                }else if("2".equals(scRate)){
	                    scRate = "02";
	                }else if("4".equals(scRate)){
	                    scRate = "03";
	                }else if("5".equals(scRate)){
	                    scRate = "04";
	                }else if("6".equals(scRate)){
	                    scRate = "05";
	                }else if("7".equals(scRate)){
	                    scRate = "06";
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // JTNET
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // JTNET
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	
	            // AK?????????(555),????????????(666) ???????????? ?????? ??????(????????????) (2012.01.27 ??????) [?????????]
	            // ????????????????????? ?????? ????????????X(20161010)
	        }else if("XM090S".equals(msgType)){
	            if(acard.start().equals("OK")){
	                // ?????????
	                approve = acard.run(ls_send_str);
	                sApprovNo = approve.substring(10, 18);
	                scBank_cd = approve.substring(0, 1);
	                scRate = approve.substring(1, 2);
	                sMessage = approve.substring(28, 67);
	                sMessage = approve.substring(28, 67).trim();
	                rest_amt = approve.substring(18, 27); // AK?????????(555),????????????(666)
	                                                        // ?????? ?????? (12.01.17)
	
	                // scRate??? ???????????????.
	
	                if("1".equals(scRate)){
	                    scRate = "01";
	                }else if("2".equals(scRate)){
	                    scRate = "02";
	                }else if("4".equals(scRate)){
	                    scRate = "03";
	                }else if("5".equals(scRate)){
	                    scRate = "04";
	                }else if("6".equals(scRate)){
	                    scRate = "05";
	                }else if("7".equals(scRate)){
	                    scRate = "06";
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // JTNET
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // JTNET
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	            // AK?????????(555),????????????(666) ?????????????????? ?????? ??????(????????????) (2011.01.17 ??????) [?????????]
	            // ????????????????????? ?????? ????????????X(20161010)
	        }else if("XM091S".equals(msgType)){
	            if(acard.start().equals("OK")){
	
	                // ?????????
	                approve = acard.run(ls_send_str);
	                sApprovNo = approve.substring(10, 18);
	                scBank_cd = approve.substring(0, 1);
	                scRate = approve.substring(1, 2);
	                sMessage = approve.substring(28, 67);
	                sMessage = approve.substring(28, 67).trim();
	                rest_amt = approve.substring(18, 27); // AK?????????(555),????????????(666)
	                                                        // ?????? ?????? (12.01.17)
	
	                // scRate??? ???????????????.
	
	                if("1".equals(scRate)){
	                    scRate = "01";
	                }else if("2".equals(scRate)){
	                    scRate = "02";
	                }else if("4".equals(scRate)){
	                    scRate = "03";
	                }else if("5".equals(scRate)){
	                    scRate = "04";
	                }else if("6".equals(scRate)){
	                    scRate = "05";
	                }else if("7".equals(scRate)){
	                    scRate = "06";
	                }else if("8".equals(scRate)){ // KIS
	                    scRate = "07"; // JTNET
	                }else if("9".equals(scRate)){ // SPCN
	                    scRate = "08"; // JTNET
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	
	            // ???????????? ?????? ?????? ??????(????????????)
	        } else {
	            if(acard.start().equals("OK")){
	                // ???????????? ??????, ?????? ????????? ?????? ?????????????????? ?????? 5??? ??????????????? ???????????????.//
	                /*
	                 * ???????????? ?????? 09.04.18 if("00".equals(hq) && ("01".equals(store) ||
	                 * "02".equals(store))){ //??????, ?????? approve =
	                 * acard.run(ls_send_str);
	                 * 
	                 * sApprovNo = approve.substring(0,8); scBank_cd =
	                 * approve.substring(26,27); scRate = approve.substring(27,28);
	                 * sMessage = approve.substring(28).trim();
	                 * 
	                 *  } else if("00".equals(hq) && "03".equals(store)){ //??????
	                 * approve = acard.run(ls_send_str); sApprovNo =
	                 * approve.substring(0,8); scBank_cd = approve.substring(8,9);
	                 * scRate = approve.substring(9,10); sMessage =
	                 * approve.substring(10).trim(); }
	                 */
	
	                // ?????? ?????? ????????? ??? ??????->????????????????????? ??????(20161010)
	                if("00".equals(hq) && ("00".equals(store))){
	                    // ?????????
	                    approve = acard.run(ls_send_str);
	                    sApprovNo = approve.substring(0, 8);
	                    scBank_cd = approve.substring(8, 9);
	                    scRate = approve.substring(9, 10);
	                    sMessage = approve.substring(10).trim();
	                } else {
	                    // ??????,??????,??????,?????? + ??????
	                    approve = acard.run(ls_send_str);
	                    sApprovNo = approve.substring(0, 8);
	                    scBank_cd = approve.substring(26, 27);
	                    scRate = approve.substring(27, 28);
	                    sMessage = approve.substring(28).trim();
	                }
	
	                // 2014.10 ???????????? ?????? ????????? ?????? ????????? ?????? ?????? ???????????? ?????? ??????
	                // if(sMessage.trim().equals("?????????????????????????????????")){
	                if(sMessage.trim().indexOf("?????????????????????????????????") > -1){
	                    sApprovNo = approve_no_exp;
	                }
	
	
	                // scRate??? ???????????????.
	
	                // scRate????????? VAN_FG, ????????????VAN_FG??? ??????VAN_FG??? ?????? ??????
	                if("1".equals(scRate)){// ?????? 01:KFTC(???????????????) ??????
	                    scRate = "01";
	                }else if("2".equals(scRate)){ // 02:NICE
	                    scRate = "02";
	                }else if("4".equals(scRate)){ // 03:KOVAN
	                    scRate = "03";
	                }else if("5".equals(scRate)){// 04:SSCARD
	                    scRate = "04";
	                }else if("6".equals(scRate)){// 05:KICC
	                    scRate = "05";
	                }else if("7".equals(scRate)){ // 06:JTNET
	                    scRate = "06";
	                }else if("8".equals(scRate)){ // 07 KIS
	                    scRate = "07"; // ?????? JTNET
	                }else if("9".equals(scRate)){ // 08 SPCN
	                    scRate = "08"; // ?????? JTNET
	                }
	
	            } else {
	                sApprovNo = "Fail0000";
	            }
	        }
	
	        acard.stop();
	
	        if(sMessage == null || "".equals(sMessage)|| "Fail0000".equals(sApprovNo)){
	        	map.put("isSuc", "fail");
	        	map.put("msg", "?????? ??? ???????????? ????????? ?????????????????????.");
	            throw new Exception("?????? ??? ???????????? ????????? ?????????????????????.");
	        }
	    
        //??????????????????
        
	        //???????????? T-012 : ????????? ???????????? ????????? ?????? ?????? ??? ???????????? ?????? ??????
	        ModifiableHttpServletRequest m = new ModifiableHttpServletRequest(request);
			Random ran = new Random();
			Enumeration<String> paramKeys = request.getParameterNames();
			char v = (char)ran.nextInt(250);
			while (paramKeys.hasMoreElements()) {
				 String key = paramKeys.nextElement();
				 String convVal = "";
				 for(int i = 0; i < request.getParameter(key).length(); i++)
				 {
					 convVal += Character.toString(v); //??????????????? ??????????????? ??????
				 }
				 m.setParameter(key, convVal); //????????? ??????
			}
			request = (HttpServletRequest)m; //??????????????? request ??????
			v = 0xFF;
			while (paramKeys.hasMoreElements()) {
				String key = paramKeys.nextElement();
				String convVal = "";
				for(int i = 0; i < request.getParameter(key).length(); i++)
				{
					convVal += Character.toString(v); //??????????????? 0xFF??? ??????
				}
				m.setParameter(key, convVal); //0xFF ??????
			}
			request = (HttpServletRequest)m; //0xFF??? request ??????
			v = 0x00;
			while (paramKeys.hasMoreElements()) {
				String key = paramKeys.nextElement();
				String convVal = "";
				for(int i = 0; i < request.getParameter(key).length(); i++)
				{
					convVal += Character.toString(v); //??????????????? 0x00?????? ??????
				}
				m.setParameter(key, convVal); //0x00 ??????
			}
			request = (HttpServletRequest)m; //0x00?????? request ??????
			
	
			
			v = (char) ran.nextInt(250);
			String convVal = "";
			for (int i = 0; i < ls_send_str.length(); i++) 
			{
				convVal += Character.toString(v); // ??????????????? ??????????????? ??????
			}
			ls_send_str = convVal;
			v = 0xFF;
			convVal = "";
			for (int i = 0; i < ls_send_str.length(); i++) 
			{
				convVal += Character.toString(v); // ??????????????? ??????????????? ??????
			}
			ls_send_str = convVal;
			v = 0x00;
			convVal = "";
			for (int i = 0; i < ls_send_str.length(); i++) 
			{
				convVal += Character.toString(v); // ??????????????? ??????????????? ??????
			}
			ls_send_str = convVal;
			
			
			v = (char) ran.nextInt(250);
			convVal = "";
			for (int i = 0; i < ls_send_str_F.length(); i++) 
			{
				convVal += Character.toString(v); // ??????????????? ??????????????? ??????
			}
			ls_send_str_F = convVal;
			v = 0xFF;
			convVal = "";
			for (int i = 0; i < ls_send_str_F.length(); i++) 
			{
				convVal += Character.toString(v); // ??????????????? ??????????????? ??????
			}
			ls_send_str_F = convVal;
			v = 0x00;
			convVal = "";
			for (int i = 0; i < ls_send_str_F.length(); i++) 
			{
				convVal += Character.toString(v); // ??????????????? ??????????????? ??????
			}
			ls_send_str_F = convVal;
			request = null;
			
			char[] result = new char[256];
			result = ls_send_str.toCharArray();
			java.util.Arrays.fill(result, (char)0x20);
			ls_send_str = String.valueOf(result);
			result = new char[256];
			result = ls_send_str_F.toCharArray();
			java.util.Arrays.fill(result, (char)0x20);
			ls_send_str_F = String.valueOf(result);
			
			map = null;
	        map = new HashMap<>();
	        
	     // ??????????????? ????????? ????????? Collection ????????? ?????? ?????????. ??????????????? BBBB(?????????)
	        if("XA081S".equals(msgType)){
	            map.put("approve_no", sApprovNo);
	            map.put("return_cd", return_cd);
	            map.put("message", sMessage);
	        } else {
	            // Collection ????????? ??????
	            map.put("return_cd", return_cd);
	            map.put("approve_no", sApprovNo);
	            map.put("bank_cd", scBank_cd);
	            map.put("rate", scRate);
	            map.put("message", sMessage);
	            map.put("rest_amt", rest_amt); // AK?????????(555),????????????(666) ?????? ??????  (12.01.17) ?????? ??????????????? 18.02.12
	            map.put("identiNo", identiNo); // ????????? ??????????????? ?????? VAN ?????????????????? (18.02.08)
	        }
	        
	        
	        WeakHashMap<Integer, String> aa = new WeakHashMap<>();
	        aa = new WeakHashMap<>();
	        
	        System.gc();
	        
	        approve = null;
	        sApprovNo = null;
	        sMessage = null;
	        scBank_cd = null;
	        scRate = null;
	        return_cd = null;
	        identiNo = null; // ????????? ??????????????? ?????? VAN ??????????????????
	        rest_amt = null; // ???????????? ?????? (2012.01.10)
	        hq = null;
	        store = null;
	        approve_no_exp = null;
	        ls_send_str_F = null;
	        ls_send_str = null;
			msgType = null;
		    map.put("isSuc", "success");
        }
        catch(Exception e)
        {
        	map.put("isSuc", "fail");
        	map.put("msg", "??? ??? ?????? ?????? ??????");
        	e.printStackTrace();
        }
	        return map; 
		
		
		
	}
	@RequestMapping("/getSocket")
	public ModelAndView getSocket(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/lect/getSocket");
		
		try
		{
			ServerSocket s_socket = new ServerSocket(9999);
			Socket c_socket = s_socket.accept();
			
			try (OutputStream sender = c_socket.getOutputStream(); InputStream reciever = c_socket.getInputStream();) 
			{
				byte[] data = new byte[1024];
				reciever.read(data, 0, data.length);
				
				
				// ?????? ????????? ??????
				String message = new String(data);
				String out = String.format("%s", message);
				
				
				//?????????????????? ???????????????
				String ret_message = "XB071R0000       0       0       0       09913365700000000000000000026????????????                                                                                                                                                                                                                                                                                                                                                                                             091311883594Y19454D00213030000F20202020F2202020F22020202020F20000                                                                                                  ";
				ret_message += "XB071R0000       0       0       0       09913365700000000000000000026????????????                                                                                                                                                                                                                                                                                                                                                                                             091311883594Y19454D00213030000F20202020F2202020F22020202020F20000                                                                                                  ";
				data = ret_message.getBytes();
				sender.write(data, 0, data.length);
			}
			
			s_socket.close();
			c_socket.close();
		}
		catch (IOException e)
		{
			e.printStackTrace();
		}
		
		
		return mav;
	}
//	@RequestMapping("/GetApproveNo")
	//	@ResponseBody
//	public String GetApproveNo(HttpServletRequest request) {
//		
//		String ls_send_str = Utils.checkNullString(request.getParameter("ls_send_str"));
//		System.out.println(ls_send_str);
//		String hq = Utils.checkNullString(request.getParameter("hq"));
//		String store = Utils.checkNullString(request.getParameter("store"));
//		String out = "";
//		
//		try (Socket client = new Socket()) 
//		{
//			// ??????????????? ?????????
//			InetSocketAddress ipep = new InetSocketAddress("127.0.0.1", 9999); //test
////			InetSocketAddress ipep = new InetSocketAddress("91.1.101.67", 9001); //????????? ?????????
//			// ??????
//			client.connect(ipep);
//			// send,reciever ????????? ????????????
//			// ?????? close
//			try (OutputStream sender = client.getOutputStream(); InputStream receiver = client.getInputStream();) {
//				// ??????????????? ????????? ??????
//				// 11byte
//				byte[] data = new byte[1024];
//				receiver.read(data, 0, 1024);
////				// ??????????????? ??????
//				String message = new String(data);
//				out = String.format("%s", message);
//				System.out.println("client recieve data : "+out);
//				// ????????? ????????? ?????????
//				// 2byte
//				//?????? ?????? ??????????????? ????????? ????????? ????????????.
//				message = ls_send_str;
//				System.out.println("client send data : "+message);
//				data = message.getBytes();
//				sender.write(data, 0, data.length);
//				
//				
//				
//			}
//		} 
//		catch (Throwable e) 
//		{
//			e.printStackTrace();
//		}
//		//??????
//		out = "0000";
//		return out;	
//	}
//	@RequestMapping("/getSocket")
//	public ModelAndView getSocket(HttpServletRequest request) {
//		ModelAndView mav = new ModelAndView(); 
//		mav.setViewName("/WEB-INF/pages/member/lect/getSocket");
//		
//		try (ServerSocket server = new ServerSocket()) 
//		{
//			// ?????? ?????????
//			InetSocketAddress ipep = new InetSocketAddress(9999);
//			server.bind(ipep);
//			System.out.println("Initialize complate");
//			// LISTEN ??????
//			Socket client = server.accept();
//			System.out.println("Connection");
//			// send,reciever ????????? ????????????
//			// ?????? close
//			try (OutputStream sender = client.getOutputStream(); InputStream reciever = client.getInputStream();) 
//			{
//				// ?????????????????? hello world ????????? ?????????
//				// 11byte ?????????
//				String message = "0000";
//				System.out.println("server send data : "+message);
//				byte[] data = message.getBytes();
//				sender.write(data, 0, data.length);
////				// ???????????????????????? ????????? ??????
////				// 2byte ?????????
//				data = new byte[1024];
//				reciever.read(data, 0, data.length);
//				// ?????? ????????? ??????
//				message = new String(data);
//				String out = String.format("%s", message);
//				System.out.println("server recieve data : "+out);
//			}
//		} 
//		catch (Throwable e) 
//		{
//			e.printStackTrace();
//		}
//
//
//		
//		return mav;
//	}
	
	@RequestMapping("/getCardCount")
	@ResponseBody
	public int getCardCount(HttpServletRequest request) throws Exception {
		
		String encCardNo_send_str = Utils.checkNullString(request.getParameter("encCardNo_send_str"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String card_no = "";
		if(encCardNo_send_str != null && !"".equals(encCardNo_send_str)){
			AKCommon.setBundang_approve_ip(bundang_approve_ip);
			AKCommon.setBundang_approve_port(bundang_approve_port);
			card_no = AKCommon.GetCustEncCardNoDecStr(store, encCardNo_send_str); //???????????? ???????????????.
        } 
		
		int cnt = common_dao.getCardCount(card_no);
		
		return cnt;
	}
	@RequestMapping("/GetReqAuthDanmal")
	@ResponseBody
	public HashMap<String, Object> GetReqAuthDanmal(HttpServletRequest request) throws Exception {
		

        String recv_buff = "";
        String hq = "00";
        String store = Utils.checkNullString(request.getParameter("store"));
        String pos_head_str = Utils.checkNullString(request.getParameter("pos_head_str"));
        String reqAuth_send_str = Utils.checkNullString(request.getParameter("reqAuth_send_str"));
        String req_ipek_send_str = Utils.checkNullString(request.getParameter("req_ipek_send_str"));
        String req_ipk_send_str = Utils.checkNullString(request.getParameter("req_ipk_send_str"));
        String msgType = pos_head_str.trim().substring(0, 6);

        BABatchRun acard = new BABatchRun();

        // ?????? ?????? ip ??? port ?????? set.
        if("00".equals(hq) && "01".equals(store))
		{
            // ?????????
            acard.setHost("172.10.1.71", 9302);
        }
		else if("00".equals(hq) && "02".equals(store))
		{
            // ?????????
            acard.setHost("173.10.1.71", 9302);
        }
		else if("00".equals(hq) && "03".equals(store))
		{
            // ?????????
			acard.setHost(bundang_approve_ip, Integer.parseInt(bundang_approve_port));
        }
		else if("00".equals(hq) && "04".equals(store))
		{
            // ?????????
            acard.setHost("174.10.1.71", 9302);
        }
		else if("00".equals(hq) && "05".equals(store))
		{
            // ?????????
            acard.setHost("175.10.1.71", 9302);
        }

        // ?????????????????? ??????
        // test ip,port
        // 08??? 11????????? ?????? acard.setHost("91.1.111.92", 9302);
        // 12??? 5??? 13????????? ?????? acard.setHost("91.3.111.24", 9302);

        // ??? 12??? 5??? 14??? ?????????(??????????????? ??????) ?????? ????????? ????????? ????????????

//        acard.setHost("91.3.105.11", new Integer("9002").intValue());
        HashMap<String, Object> map = new HashMap<>();
        if(acard.start().equals("OK")){
            try {
                if("XB281S".equals(msgType)){
                    recv_buff = acard.ReqAuthDanmal_run(msgType, reqAuth_send_str);
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("randomHost", recv_buff.substring(146, 162));
                    map.put("iskver", recv_buff.substring(162, 164));
                    map.put("iskidx", recv_buff.substring(164, 168));
                    map.put("signDt", recv_buff.substring(168, 172));
                    map.put("signRhost", recv_buff.substring(172, 684));
                    // map.put("preText",recv_buff.substring(1198));
                }else if("XB282S".equals(msgType)){
                    recv_buff = acard.ReqAuthDanmal_run(msgType, req_ipek_send_str);
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("KSN", recv_buff.substring(146, 166));
                    map.put("ipekver", recv_buff.substring(166, 168));
                    map.put("ipekidx", recv_buff.substring(168, 172));
                    map.put("ipekalg", recv_buff.substring(172, 173));
                    map.put("eipeklen", recv_buff.substring(173, 177));
                    map.put("eipek", recv_buff.substring(177, 689));
                    map.put("maclen", recv_buff.substring(689, 693));
                    map.put("mac", recv_buff.substring(693, 709));
                    // map.put("preText",recv_buff.substring(709));
                }else if("XB283S".equals(msgType)){
                    recv_buff = acard.ReqAuthDanmal_run(msgType, req_ipk_send_str);
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("randomHost", recv_buff.substring(146, 162));
                    map.put("iskver", recv_buff.substring(162, 164));
                    map.put("iskidx", recv_buff.substring(164, 168));
                    map.put("signDt", recv_buff.substring(168, 172));
                    map.put("signRanHost", recv_buff.substring(172, 1196));
                    map.put("newIpkver", recv_buff.substring(1196, 1198));
                    map.put("newIpkidx", recv_buff.substring(1198, 1202));
                    map.put("enewIpkmodlen", recv_buff.substring(1202, 1206));
                    map.put("enewipkmod", recv_buff.substring(1206, 2230));
                    map.put("enewipkexplen", recv_buff.substring(2230, 2234));
                    map.put("enewipkexp", recv_buff.substring(2234, 3258));
                    // map.put("preText",recv_buff.substring(3258));
                }
                else if("XB411S".equals(msgType)){   /*  IC-BC ????????? ?????? ?????? (BC ??????)  cmc 2019.05  */
                    recv_buff = acard.ReqAuthDanmal_run(msgType, reqAuth_send_str);
                    
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("randomHost", recv_buff.substring(146, 162));
                    map.put("iskver", recv_buff.substring(162, 164));
                    map.put("iskidx", recv_buff.substring(164, 168));
                    map.put("signDt", recv_buff.substring(168, 172));
                    map.put("signRhost", recv_buff.substring(172, 684));
                }
                else if("XB412S".equals(msgType)){  /*  IC-BC ???????????? ???????????? ?????? (BC ??????) cmc 2019.05   */ 
                    recv_buff = acard.ReqAuthDanmal_run(msgType, req_ipek_send_str);
                    
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("KSN", recv_buff.substring(146, 166));
                    map.put("ipekver", recv_buff.substring(166, 168));
                    map.put("ipekidx", recv_buff.substring(168, 172));
                    map.put("ipekalg", recv_buff.substring(172, 173));
                    map.put("eipeklen", recv_buff.substring(173, 177));
                    map.put("eipek", recv_buff.substring(177, 689));
                    map.put("maclen", recv_buff.substring(689, 693));
                    map.put("mac", recv_buff.substring(693, 709));;
                }
                else if("XB413S".equals(msgType)){  /*  IC-BC IPK???????????? ?????? (BC ??????)   cmc 2019.05    */ 
                    recv_buff = acard.ReqAuthDanmal_run(msgType, req_ipk_send_str);
                    
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("randomHost", recv_buff.substring(146, 162));
                    map.put("iskver", recv_buff.substring(162, 164));
                    map.put("iskidx", recv_buff.substring(164, 168));
                    map.put("signDt", recv_buff.substring(168, 172));
                    map.put("signRanHost", recv_buff.substring(172, 1196));
                    map.put("newIpkver", recv_buff.substring(1196, 1198));
                    map.put("newIpkidx", recv_buff.substring(1198, 1202));
                    map.put("enewIpkmodlen", recv_buff.substring(1202, 1206));
                    map.put("enewipkmod", recv_buff.substring(1206, 2230));
                    map.put("enewipkexplen", recv_buff.substring(2230, 2234));
                    map.put("enewipkexp", recv_buff.substring(2234, 3258));
                }
                
                else if("XB421S".equals(msgType)){   /* IC-SH ????????? ?????? ?????? (????????????)  cmc 2019.05  */
                    recv_buff = acard.ReqAuthDanmal_run(msgType, reqAuth_send_str);
                    
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("randomHost", recv_buff.substring(146, 162));
                    map.put("iskver", recv_buff.substring(162, 164));
                    map.put("iskidx", recv_buff.substring(164, 168));
                    map.put("signDt", recv_buff.substring(168, 172));
                    map.put("signRhost", recv_buff.substring(172, 684));
                }
                else if("XB422S".equals(msgType)){  /* IC-SH ???????????? ???????????? ??????  (????????????)  cmc 2019.05  */ 
                    recv_buff = acard.ReqAuthDanmal_run(msgType, req_ipek_send_str);
                    
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("KSN", recv_buff.substring(146, 166));
                    map.put("ipekver", recv_buff.substring(166, 168));
                    map.put("ipekidx", recv_buff.substring(168, 172));
                    map.put("ipekalg", recv_buff.substring(172, 173));
                    map.put("eipeklen", recv_buff.substring(173, 177));
                    map.put("eipek", recv_buff.substring(177, 689));
                    map.put("maclen", recv_buff.substring(689, 693));
                    map.put("mac", recv_buff.substring(693, 709));;
                }
                else if("XB423S".equals(msgType)){  /* IC-SH IPK???????????? ?????? (????????????)  cmc 2019.05  */ 
                    recv_buff = acard.ReqAuthDanmal_run(msgType, req_ipk_send_str);
                    
                    map.put("recardBin", recv_buff.substring(60, 66));
                    map.put("resajaNo", recv_buff.substring(66, 76));
                    map.put("resCode", recv_buff.substring(142, 146));
                    map.put("randomHost", recv_buff.substring(146, 162));
                    map.put("iskver", recv_buff.substring(162, 164));
                    map.put("iskidx", recv_buff.substring(164, 168));
                    map.put("signDt", recv_buff.substring(168, 172));
                    map.put("signRanHost", recv_buff.substring(172, 1196));
                    map.put("newIpkver", recv_buff.substring(1196, 1198));
                    map.put("newIpkidx", recv_buff.substring(1198, 1202));
                    map.put("enewIpkmodlen", recv_buff.substring(1202, 1206));
                    map.put("enewipkmod", recv_buff.substring(1206, 2230));
                    map.put("enewipkexplen", recv_buff.substring(2230, 2234));
                    map.put("enewipkexp", recv_buff.substring(2234, 3258));
                }
            } catch (NullPointerException e){
            }
        } else {
            recv_buff = "Fail0000";
        }

        acard.stop();

        if(recv_buff.startsWith("Fail0000")){
            map.put("resCode", recv_buff);
        }
        //???????????? T-018 : ?????? ????????? ????????? ??? ????????? ??????/????????? ????????? ????????? ?????? ?????? ?????? ??????
        ModifiableHttpServletRequest m = new ModifiableHttpServletRequest(request);
		Random ran = new Random();
		Enumeration<String> paramKeys = request.getParameterNames();
		char v = (char)ran.nextInt(250);
		while (paramKeys.hasMoreElements()) {
			 String key = paramKeys.nextElement();
			 String convVal = "";
			 for(int i = 0; i < request.getParameter(key).length(); i++)
			 {
				 convVal += Character.toString(v); //??????????????? ??????????????? ??????
			 }
			 m.setParameter(key, convVal); //????????? ??????
		}
		request = (HttpServletRequest)m; //??????????????? request ??????
		v = 0xFF;
		while (paramKeys.hasMoreElements()) {
			String key = paramKeys.nextElement();
			String convVal = "";
			for(int i = 0; i < request.getParameter(key).length(); i++)
			{
				convVal += Character.toString(v); //??????????????? 0xFF??? ??????
			}
			m.setParameter(key, convVal); //0xFF ??????
		}
		request = (HttpServletRequest)m; //0xFF??? request ??????
		v = 0x00;
		while (paramKeys.hasMoreElements()) {
			String key = paramKeys.nextElement();
			String convVal = "";
			for(int i = 0; i < request.getParameter(key).length(); i++)
			{
				convVal += Character.toString(v); //??????????????? 0x00?????? ??????
			}
			m.setParameter(key, convVal); //0x00 ??????
		}
		request = (HttpServletRequest)m; //0x00?????? request ??????
		pos_head_str = null;
        reqAuth_send_str = null;
        req_ipek_send_str = null;
        req_ipk_send_str = null;
        msgType = null;
		System.gc();
		
        
        return map;
	}
	
	
	@RequestMapping("/getApproveCardCnt")
	@ResponseBody
	public int getApproveCardCnt(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String encCardNo_send_str = Utils.checkNullString(request.getParameter("encCardNo_send_str"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String card_fg = Utils.checkNullString(request.getParameter("card_fg"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		String pos_no = Utils.checkNullString(request.getParameter("pos_no"));
		
		String card_no = "";
		
		if (card_fg.equals("Q") || card_fg.equals("q") || card_fg.equals("N") || card_fg.equals("n")) {
			card_no = encCardNo_send_str;
		} else {
			AKCommon.setBundang_approve_ip(bundang_approve_ip);
			AKCommon.setBundang_approve_port(bundang_approve_port);
			card_no = AKCommon.GetCustEncCardNoDecStr(store, encCardNo_send_str); //???????????? ???????????????.
		}
		
		int cnt = lect_dao.getRecptCardChk(store, sale_ymd, pos_no, recpt_no, card_no);
		
		return cnt;
	}
	@RequestMapping("/getCardCount822")
	@ResponseBody
	public int getCardCount822(HttpServletRequest request) throws Exception {
		
		String encCardNo_send_str = Utils.checkNullString(request.getParameter("encCardNo_send_str"));
		String store = Utils.checkNullString(request.getParameter("store"));
		AKCommon.setBundang_approve_ip(bundang_approve_ip);
		AKCommon.setBundang_approve_port(bundang_approve_port);
		String card_no = AKCommon.GetCustEncCardNoDecStr(store, encCardNo_send_str); //???????????? ???????????????.
		
		int cnt = common_dao.getCardCount822(card_no);
		
		return cnt;
	}
	@RequestMapping("/getCardNo")
	@ResponseBody
	public HashMap<String, Object> getCardInfo(HttpServletRequest request) {
		
		String card_no = Utils.checkNullString(request.getParameter("card_no"));
		HashMap<String, Object> data = common_dao.getCardNo(card_no); 
	    return data;
		
	}
	@RequestMapping("/sendWait")
	@ResponseBody
	public HashMap<String, Object> sendWait(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String child_no1 = Utils.checkNullString(request.getParameter("child_no1"));
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		
		
		HashMap<String, Object> map = new HashMap<>();
		String main_cd = "";
		String sect_cd = "";
		if(!"".equals(subject_cd))
		{
			main_cd = subject_cd.substring(0,1);
			sect_cd = subject_cd.substring(1,3);
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "??????????????? ?????????????????????.");
			return map;
		}
		//????????? ????????? ???????????? ??????
		HashMap<String, Object> data = lect_dao.isWaitPossible(cust_no, store, period, subject_cd, child_no1);
		if(data != null)
		{
			if(Utils.checkNullInt(data.get("POSSIBLE_NO")) > 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "???????????? ????????? ???????????????. \n????????? ????????? ????????????.");
				return map;
			}
			if(Utils.checkNullInt(data.get("WAIT_CNT1")) > 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "?????? ???????????? ??????????????????.");
				return map;
			}
			if(Utils.checkNullInt(data.get("WAIT_CNT2")) > 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "?????? ???????????? ???????????????.");
				return map;
			}
		}
		lect_dao.insWait(store, period, subject_cd, main_cd, sect_cd, cust_no, login_seq, pos_no, child_no1);
		
		
		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		
        return map;
	}
	@RequestMapping("/cash_cancel_proc")
	@ResponseBody
	public HashMap<String, Object> cash_cancel_proc(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		HttpSession session = request.getSession();
		String hq = Utils.checkNullString(request.getParameter("hq"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String recpt_pos_no = Utils.checkNullString(request.getParameter("recpt_pos_no"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String new_recpt_no = Utils.checkNullString(request.getParameter("new_recpt_no"));
		String cash_amt = Utils.checkNullString(request.getParameter("cash_amt"));
		String repay_amt = Utils.checkNullString(request.getParameter("repay_amt"));
		String issue_fg = Utils.checkNullString(request.getParameter("issue_fg"));
		String id_fg = Utils.checkNullString(request.getParameter("id_fg"));
		String id_no = Utils.checkNullString(request.getParameter("id_no"));
		String approve_no = Utils.checkNullString(request.getParameter("approve_no"));
		String van_fg = Utils.checkNullString(request.getParameter("van_fg"));
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		
		lect_dao.cancelCash(store, recpt_pos_no, pos_no, new_recpt_no, cash_amt, repay_amt, issue_fg, id_fg, id_no, approve_no, van_fg, login_seq);
		
		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		
		return map;
	}
	@RequestMapping("/insert_integrity")
	@ResponseBody
	public HashMap<String, Object> insert_integrity(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String integrity = Utils.checkNullString(request.getParameter("integrity"));
		String secuVer = Utils.checkNullString(request.getParameter("secuVer"));
		String secuVer1 = Utils.checkNullString(request.getParameter("secuVer1"));
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		
		lect_dao.insert_integrity(store, pos_no, integrity, secuVer, secuVer1, login_seq);
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		
		return map;
	}
	@RequestMapping("/GetAkmemCustInfo")
	@ResponseBody
	public HashMap<String, Object> GetAkmemCustInfo(HttpServletRequest request) throws Exception{
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String recv_buff = null;
        String sApprovNo = null;
        String sMessage = null;

        String AKmem_Send_Str = Utils.checkNullString(request.getParameter("send_data"));
        
        
        String AKmem_Resp_No = null; // akmembers ????????????(00:?????? else ??????)
        String AKmem_Resp_Msg = null; // akmembers ???????????????
        String AKmem_CardNo = null; // akmembers ????????????
        String AKmem_CustNo = null; // akmembers ????????????
        String AKmem_Family_CustNo = null; // akmembers ????????????
        String AKmem_CustName = null; // akmembers ????????????
        String AKmem_CustLevel = null; // akmembers ????????????
        String AKmem_total_point = null; // akmembers ???????????????
        String AKmem_use_yn = null; // akmembers ??????????????????
        String AKmem_Card_Type = null; // akmembers
                                        // ????????????(1:???????????????,2:????????????,3:????????????,4:???????????????,5:VIP??????,8????????????)
        String AKmem_RegiCard_yn = null; // akmembers ????????? ????????????
                                            // ??????(0:??????????????????,1:????????????)
        String AKmem_RegiCard_no = null; // akmembers ????????? ???????????? List (max
                                            // 10pcs)
        String AKmem_Use_Min_Point = null; // akmembers ???????????? ?????????
        String AKmem_Use_Max_Point = null; // akmembers ???????????? ?????????
        String AKmem_Use_hurdle = null; // akmembers ????????????(??????) ?????????
        String AKmem_Stf_div = null; // akmembers ????????????
        String AKmem_SaveApproveNo = null; // akmembers ????????? ????????????
        String AKmem_SaveApproveNo_POS = null; // akmembers ????????? ????????????(POS)
        String AKmem_SaveApprove_Point = null; // akmembers ?????? ?????????
        String AKmem_CustGrade = null; // akmembers ????????????

        String hq = Utils.checkNullString(request.getParameter("hq"));
        String store = Utils.checkNullString(request.getParameter("store"));
        String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
        String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
        String total_pay = Utils.checkNullString(request.getParameter("total_pay"));
        String total_enuri_amt = Utils.checkNullString(request.getParameter("total_enuri_amt"));
        String total_regis_fee = Utils.checkNullString(request.getParameter("total_regis_fee"));
        String akmem_card_no = Utils.checkNullString(request.getParameter("akmem_card_no"));
        String akmem_point_amt = Utils.checkNullString(request.getParameter("akmem_point_amt"));
        
        String total_show_amt = Utils.checkNullString(request.getParameter("total_show_amt"));
        String akmem_cust_no = Utils.checkNullString(request.getParameter("akmem_cust_no"));
        String akmem_family_cust_no = Utils.checkNullString(request.getParameter("akmem_family_cust_no"));
        String akmem_recpt_point = Utils.checkNullString(request.getParameter("akmem_recpt_point"));
        String recpt_pos_no = Utils.checkNullString(request.getParameter("recpt_pos_no")); //??????????????? ???????????????
        
        
        String akmem_encCardNo_send_str = Utils.checkNullString(request.getParameter("akmem_encCardNo_send_str"));

        String akmem_cardno_des = null; // akmembers card_no ????????? ??????(10.02.09)
        String AKmem_Pswd = null;       // akmembers ???????????? (2019.03.11 ljs ??????)
        String AKmem_Use_Point = "0";   // akmembers ?????????????????? (2019.03.11 ljs ??????)
        String rsUseDivCd = "1";        // akmembers ??????????????????(1 : ??????, 2 : ??????)(2019.04.16 ljs ??????)  
        String Slip_Cnt = null;         // akmembers ??????????????????(1 : ??????, 2 : ??????)(2019.04.16 ljs ??????) 

        BABatchRun acard = new BABatchRun();
        
        if("00".equals(hq) && "01".equals(store))
		{
            // ?????????
            acard.setHost("172.10.1.71", 9302);
        }
		else if("00".equals(hq) && "02".equals(store))
		{
            // ?????????
            acard.setHost("173.10.1.71", 9302);
        }
		else if("00".equals(hq) && "03".equals(store))
		{
            // ?????????
			acard.setHost(bundang_approve_ip, Integer.parseInt(bundang_approve_port));
        }
		else if("00".equals(hq) && "04".equals(store))
		{
            // ?????????
            acard.setHost("174.10.1.71", 9302);
        }
		else if("00".equals(hq) && "05".equals(store))
		{
            // ?????????
            acard.setHost("175.10.1.71", 9302);
        }
        HashMap<String, Object> map = new HashMap<>();
        
        
        AKmem_Send_Str = AKmem_Send_Str.replaceAll("@@@@@@@@@@@@@@", AKCommon.getCurrentDate() + AKCommon.getCurrentTime());
        
        
        // ????????????
        if(acard.start().equals("OK")){
        	
         // AK????????? ????????????
            if("XA241S".equals(AKmem_Send_Str.trim().substring(0, 6)) // ????????? ?????? ??????IC ????????? ??????  XA241S = MS??????
                    || "XB241S".equals(AKmem_Send_Str.trim().substring(0, 6))){ // ?????????  ??????XA241S = IC??????
                String encst = AKmem_Send_Str.substring(185,269);
                String encDt = AKmem_Send_Str.substring(0,185);
                
                // IC ?????? ????????? 
                if(encst.trim().length()>0){
                    for(int i = 0; i < encst.length();i++){
                        int chPoint = ((int)encst.charAt(i))-1;
                        if(chPoint < 0) chPoint = 126;
                        char encChar = (char)chPoint;
                        encDt+= String.valueOf(encChar);
                    }
                    encDt += AKCommon.LPAD("",50,' ') ;
                    AKmem_Send_Str = encDt;
                }
                recv_buff = acard.encCardNo_run(AKmem_Send_Str);
                System.out.println("AKmem_Send_Str : "+AKmem_Send_Str);
                System.out.println("recv_buff : "+recv_buff);
                
                String kor_msg = AKCommon.ByteSubStr(recv_buff, 181, 64).replaceAll("[^\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]", "");
                String kor_name = AKCommon.ByteSubStr(recv_buff, 362+kor_msg.length(), 40).replaceAll("[^\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]", "");
                
                System.out.println("kor_msg : "+kor_msg.length());

                AKmem_Resp_No = AKCommon.ByteSubStr(recv_buff, 25, 2); // akmembers ????????????(00:?????? else??????)
                AKmem_Resp_Msg = AKCommon.ByteSubStr(recv_buff, 181, 64); // akmembers ???????????????
                AKmem_CardNo = AKCommon.ByteSubStr(recv_buff, 51, 16); // akmembers ????????????
                AKmem_CustNo = AKCommon.ByteSubStr(recv_buff, 121, 9); // akmembers ????????????
                AKmem_Family_CustNo = AKCommon.ByteSubStr(recv_buff, 130,10); // akmembers ????????????
                AKmem_CustName = AKCommon.ByteSubStr(recv_buff, 362+kor_msg.length(), 40); // akmembers ?????????
                AKmem_CustLevel = AKCommon.ByteSubStr(recv_buff, 254+kor_msg.length(), 7); // akmembers ????????????
                AKmem_total_point = AKCommon.ByteSubStr(recv_buff, 159, 10); // akmembers ???????????????
                AKmem_use_yn = AKCommon.ByteSubStr(recv_buff, 245+kor_msg.length(), 1); // akmembers ??????????????????
                AKmem_Card_Type = AKCommon.ByteSubStr(recv_buff, 246+kor_msg.length(), 1); // akmembers ????????????(1:???????????????,2:????????????,3:????????????,4:???????????????,5:VIP??????,8:????????????)
                AKmem_RegiCard_yn = AKCommon.ByteSubStr(recv_buff, 290+kor_msg.length(), 1); // akmembers ????????? ???????????? ??????(0:??????????????????,1:????????????)
                AKmem_RegiCard_no = AKCommon.ByteSubStr(recv_buff, 710+kor_msg.length()+kor_name.length(), 160); // akmembers ????????? ???????????? List (max 10pcs)
                AKmem_Stf_div = AKCommon.ByteSubStr(recv_buff, 289+kor_msg.length(), 1); // akmembers ????????????(1,2,3)
                AKmem_Use_Min_Point = AKCommon.ByteSubStr(recv_buff, 291+kor_msg.length(),10); // akmembers ???????????? ?????????
                AKmem_Use_Max_Point = AKCommon.ByteSubStr(recv_buff, 301+kor_msg.length(),10); // akmembers ???????????? ?????????
                AKmem_Use_hurdle = AKCommon.ByteSubStr(recv_buff, 311+kor_msg.length(), 10); // akmembers ????????????(??????) ?????????
                AKmem_Pswd = AKCommon.ByteSubStr(recv_buff, 88, 16); // akmembers ???????????? (2019.03.11 ljs ??????)
                
                System.out.println("AKmem_Resp_No : "+AKmem_Resp_No);
                System.out.println("AKmem_Resp_Msg : "+AKmem_Resp_Msg);
                System.out.println("AKmem_CardNo : "+AKmem_CardNo);
                System.out.println("AKmem_CustNo : "+AKmem_CustNo);
                System.out.println("AKmem_Family_CustNo : "+AKmem_Family_CustNo);
                System.out.println("AKmem_CustName : "+AKmem_CustName);
                System.out.println("AKmem_CustLevel : "+AKmem_CustLevel);
                System.out.println("AKmem_total_point : "+AKmem_total_point);
                System.out.println("AKmem_use_yn : "+AKmem_use_yn);
                System.out.println("AKmem_Card_Type : "+AKmem_Card_Type);
                System.out.println("AKmem_RegiCard_yn : "+AKmem_RegiCard_yn);
                System.out.println("AKmem_RegiCard_no : "+AKmem_RegiCard_no);
                System.out.println("AKmem_Stf_div : "+AKmem_Stf_div);
                System.out.println("AKmem_Use_Min_Point : "+AKmem_Use_Min_Point);
                System.out.println("AKmem_Use_Max_Point : "+AKmem_Use_Max_Point);
                System.out.println("AKmem_Use_hurdle : "+AKmem_Use_hurdle);
                System.out.println("AKmem_Pswd : "+AKmem_Pswd);
                
                if(AKmem_CustLevel != "" || AKmem_CustLevel != null){
                	AKmem_CustGrade = lect_dao.GetAkmemGrade(AKmem_CustLevel);
                }
                //2019.06.24 ljs "*"????????? ???????????? ????????? ??????
                if(!(akmem_encCardNo_send_str == null || "".equals(akmem_encCardNo_send_str))){
                	AKCommon.setBundang_approve_ip(bundang_approve_ip);
        			AKCommon.setBundang_approve_port(bundang_approve_port);
               	AKmem_CardNo =  AKCommon.GetCustEncCardNoDecStr(store, akmem_encCardNo_send_str);
               }
                
                map.put("sApprovNo", AKmem_Resp_No);
                map.put("sMessage", AKmem_Resp_Msg);
                map.put("AKmem_Resp_No", AKmem_Resp_No);
                map.put("AKmem_Resp_Msg", AKmem_Resp_Msg);
                map.put("AKmem_CardNo", AKmem_CardNo);
                map.put("AKmem_CustNo", AKmem_CustNo);
                map.put("AKmem_Family_CustNo", AKmem_Family_CustNo);
                map.put("AKmem_CustName", AKmem_CustName);
                map.put("AKmem_CustLevel", AKmem_CustLevel);
                map.put("AKmem_total_point", AKmem_total_point);
                map.put("AKmem_use_yn", AKmem_use_yn);
                map.put("AKmem_Card_Type", AKmem_Card_Type);
                map.put("AKmem_RegiCard_yn", AKmem_RegiCard_yn);
                map.put("AKmem_RegiCard_no", AKmem_RegiCard_no);
                map.put("AKmem_Use_Min_Point", AKmem_Use_Min_Point);
                map.put("AKmem_Use_Max_Point", AKmem_Use_Max_Point);
                map.put("AKmem_Use_hurdle", AKmem_Use_hurdle);
                map.put("AKmem_CustGrade", AKmem_CustGrade);
                map.put("point_amt", "0");            // point_amt ??????????????? (2019.03.11 ljs ??????)
                map.put("point_approve_yn", "N");     // ???????????????????????????  (2019.03.11 ljs ??????)
                map.put("AKmem_Pswd", AKmem_Pswd);    // akmembers ???????????? (2019.03.11 ljs ??????)

            }
            else if("XA242S".equals(AKmem_Send_Str.trim().substring(0, 6))
                    ||"XB242S".equals(AKmem_Send_Str.trim().substring(0, 6))){
//        	String kor = AKCommon.ByteSubStr(AKmem_Send_Str, 0, 999).replaceAll("[^\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]", "");
        	  System.out.println("AKmem_Send_Str.length>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>["+ AKmem_Send_Str.length() + "]");
        	  String encst = AKCommon.ByteSubStr(AKmem_Send_Str,882,84);
        	  String encDt = AKCommon.ByteSubStr(AKmem_Send_Str,0,882);
              System.out.println("AKmem_Send_Str.check>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>["+ encst+ "]["+encDt+"]");
            // IC ?????? ????????? 
            if(encst.trim().length()>0){
                for(int i = 0; i < encst.length();i++){
                    int chPoint = ((int)encst.charAt(i))-1;
                    if(chPoint < 0) chPoint = 126;
                    char encChar = (char)chPoint;
                    encDt+= String.valueOf(encChar);
                }
                encDt += AKCommon.LPAD("",142,' ') ;
                AKmem_Send_Str = encDt;
            }
            recv_buff = acard.encCardNo_run(AKmem_Send_Str);  //asis :  AKmem_run
            System.out.println("AKmem_Send_Str : "+AKmem_Send_Str);
            System.out.println("recv_buff : "+recv_buff);

            AKmem_Resp_No = AKCommon.ByteSubStr(recv_buff, 25, 2); // akmembers ????????????(00:??????  else ??????)
            AKmem_Resp_Msg = AKCommon.ByteSubStr(recv_buff, 270, 64); // akmembers  ???????????????
            AKmem_SaveApproveNo = AKCommon.ByteSubStr(recv_buff, 107,31); // akmembers ????????? ????????????
            AKmem_SaveApproveNo_POS = AKCommon.ByteSubStr(recv_buff,152, 9); // akmembers ????????? ????????????(POS)
            AKmem_SaveApprove_Point = AKCommon.ByteSubStr(recv_buff,250, 10); // akmembers ?????? ?????????

            map.put("sApprovNo", AKmem_Resp_No);
            map.put("sMessage", AKmem_Resp_Msg);
            map.put("AKmem_SaveApproveNo", AKmem_SaveApproveNo);
            map.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
            map.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);

            // DB Log insert
            if("00".equals(AKmem_Resp_No)){

                map.put("AKmem_sale_ymd", AKCommon.ByteSubStr(recv_buff, 138, 8));

                // 10.02.09 ????????? ???????????? ??????
                // **********************************************************************
                // map.put("AKmem_cardno",
                // AKCommon.ByteSubStr(recv_buff,51,37));
                //????????? ?????? akmem_cardno_des = param.getParameter("akmem_cardno_des"); // ????????????  // ??????????????????(10.02.09)
                //map.put("AKmem_cardno", akmem_cardno_des);
                
                if(!(akmem_encCardNo_send_str == null || "".equals(akmem_encCardNo_send_str))){
                	AKCommon.setBundang_approve_ip(bundang_approve_ip);
        			AKCommon.setBundang_approve_port(bundang_approve_port);
                   	AKmem_CardNo =  AKCommon.GetCustEncCardNoDecStr(store, akmem_encCardNo_send_str);
                   }

                // 10.02.09 ?????????
                // **********************************************************************

                map.put("AKmem_CustNo", AKCommon.ByteSubStr(recv_buff, 88, 9));
                map.put("AKmem_Family_CustNo", "");
                map.put("AKmem_recpt_point", AKCommon.ByteSubStr(recv_buff, 175, 10));
                map.put("AKmem_SaveApproveNo_POS",AKmem_SaveApproveNo_POS);
                map.put("AKmem_SaveApprove_Point",AKmem_SaveApprove_Point); // ?????? ???????????? ?????? ?????? (2013.09.05)

                // 18.02.19 ????????? ?????? KSN+encData??? ???????????? ????????????
                // **********************************************************************
                // if(AKmem_Send_Str.substring(840, 924).trim() != ""){
                // AKmem_Send_Str = "XB245S"+AKmem_Send_Str.substring(6,
                // 42)+ AKmem_Send_Str.substring(840, 924);
                // recv_buff = acard.AKmem_run(AKmem_Send_Str);
                // System.out.println("recv_buff>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>["
                // + recv_buff+"]");
                // akmem_cardno_des = recv_buff.substring(42, 126).trim();
                // map.put("AKmem_cardno", akmem_cardno_des);
                // }
                
                //2019.05.29 ljs  : ?????????????????? ???????????? ?????? ??????
                /*?????? ???????????? ?????? ????????? ????????? POS????????? ????????? POS????????? ?????? ??????????????? ????????? ?????? 
                 * [????????????]
					 * 1. ????????? ?????? -> DESK ??????
                 *    - BAPTCATB ?????? ????????? : ?????? DESK POS?????? ?????? -> ???????????? ??????
                 *    - ???????????? ?????? ?????? : ????????? POS?????? ??????(070014)
                 * 2. WEB ?????? -> DESK ?????? ???
                 *    - BAPTCATB ?????? ????????? : ?????? DESK POS?????? ?????? -> ???????????? ??????
                 *    - ???????????? ?????? ?????? : ?????? DESK POS?????? ?????? -> ???????????? ??????
                 */
                //?????? ?????? ??? ???????????? ??????????????????.
                map.put("recpt_pos_no", recpt_pos_no);
                
                //2019.04.04 ljs : ?????????????????? ????????? ?????????????????? update ?????? START
                AKmem_Use_Point = akmem_point_amt; //???????????? ??? ????????? ???????????? "0" ??????
                
                map.put("store", store);
                map.put("pos_no", pos_no);
                map.put("recpt_no", recpt_no);
                map.put("total_show_amt", total_show_amt);
                map.put("total_enuri_amt", total_enuri_amt);
                map.put("total_regis_fee", total_regis_fee);
                map.put("AKmem_cardno", akmem_card_no);
                map.put("akmem_point_amt", akmem_point_amt);
                map.put("login_seq", login_seq);
                int saveResult = lect_dao.saveAKmembersPointLog(map);
            }


        // AK????????? ???????????? ??????  (2019.03.25 ljs ??????) start
        }
            else if("XA243S".equals(AKmem_Send_Str.trim().substring(0, 6))
                    ||"XB243S".equals(AKmem_Send_Str.trim().substring(0, 6))){
            String encst = AKCommon.ByteSubStr(AKmem_Send_Str,383,84);
            String encDt = AKCommon.ByteSubStr(AKmem_Send_Str,0,383);
            
            // IC ?????? ????????? 
            if(encst.trim().length()>0){
                for(int i = 0; i < encst.length();i++){
                    int chPoint = ((int)encst.charAt(i))-1;
                    if(chPoint < 0) chPoint = 126;
                    char encChar = (char)chPoint;
                    encDt+= String.valueOf(encChar);
                }
                encDt += AKCommon.LPAD("",50,' ') ;        //?????????????????? POS?????? ????????????  FILLER?????? ??????
                AKmem_Send_Str = encDt;
            }
            recv_buff = acard.encCardNo_run(AKmem_Send_Str);
            System.out.println("AKmem_Send_Str : ["+AKmem_Send_Str+"]");
            System.out.println("recv_buff : ["+recv_buff+"]");


            AKmem_Resp_No = AKCommon.ByteSubStr(recv_buff, 25, 2); // akmembers ????????????(00:??????  else ??????)
            AKmem_Resp_Msg = AKCommon.ByteSubStr(recv_buff, 270, 64); // akmembers  ???????????????
            AKmem_SaveApproveNo = AKCommon.ByteSubStr(recv_buff, 107,31); // akmembers ????????? ????????????
            AKmem_SaveApproveNo_POS = AKCommon.ByteSubStr(recv_buff,152, 9); // akmembers ????????? ????????????(POS)
            AKmem_Use_Point = AKCommon.ByteSubStr(recv_buff,175, 10); // akmembers ?????? ?????????
            AKmem_SaveApprove_Point = AKCommon.ByteSubStr(recv_buff,250, 10); // akmembers ?????? ?????????
            String AKmem_vat_use_pt = AKCommon.ByteSubStr(recv_buff,334, 10); // ??????????????? ???????????????
            String AKmem_vat_ext_use_pt = AKCommon.ByteSubStr(recv_buff,344, 10); // ??????????????? ???????????????

            map.put("sApprovNo", AKmem_Resp_No);
            map.put("sMessage", AKmem_Resp_Msg);
            map.put("AKmem_SaveApproveNo", AKmem_SaveApproveNo);
            map.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
            map.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);
            

            // DB Log insert
            if("00".equals(AKmem_Resp_No)){
            	
            	map.put("AKmem_sale_ymd", AKCommon.ByteSubStr(recv_buff, 138, 8));

                if(!(akmem_encCardNo_send_str == null || "".equals(akmem_encCardNo_send_str))){
                	AKCommon.setBundang_approve_ip(bundang_approve_ip);
        			AKCommon.setBundang_approve_port(bundang_approve_port);
                   	AKmem_CardNo =  AKCommon.GetCustEncCardNoDecStr(store, akmem_encCardNo_send_str);
                }

                if(AKmem_Use_Point == null || "".equals(AKmem_Use_Point))
                {
                	AKmem_Use_Point = "0";
                }
                
                if(AKmem_vat_use_pt == null || "".equals(AKmem_vat_use_pt))
                {
                	AKmem_vat_use_pt = "0";
                }
                
                if(AKmem_vat_ext_use_pt == null || "".equals(AKmem_vat_ext_use_pt))
                {
                	AKmem_vat_ext_use_pt = "0";
                }
                
                AKmem_Use_Point = String.valueOf(Integer.valueOf(AKmem_Use_Point)); //???????????? ??? ????????? ???????????? "0" ??????
                AKmem_vat_use_pt = String.valueOf(Integer.valueOf(AKmem_vat_use_pt)); //???????????? ??? ????????? ???????????? "0" ??????
                AKmem_vat_ext_use_pt = String.valueOf(Integer.valueOf(AKmem_vat_ext_use_pt)); //???????????? ??? ????????? ???????????? "0" ??????
                
                map.put("AKmem_CustNo", AKCommon.ByteSubStr(recv_buff, 88, 9));
                map.put("AKmem_Family_CustNo", "");                      
                map.put("AKmem_SaveApproveNo_POS",AKmem_SaveApproveNo_POS);
                map.put("AKmem_SaveApprove_Point",AKmem_SaveApprove_Point); // ?????? ???????????? ?????? ?????? (2013.09.05)
                map.put("AKmem_Use_Point", AKmem_Use_Point);
                map.put("AKmem_vat_use_pt",AKmem_vat_use_pt);    
                map.put("AKmem_vat_ext_use_pt",AKmem_vat_ext_use_pt);
                
                //2019.05.29 ljs  : ?????????????????? ???????????? ?????? ??????
                /*?????? ???????????? ?????? ????????? ????????? POS????????? ????????? POS????????? ?????? ??????????????? ????????? ?????? 
                 * [????????????]
					 * 1. ????????? ?????? -> DESK ??????
                 *    - BAPTCATB ?????? ????????? : ?????? DESK POS?????? ?????? -> ???????????? ??????
                 *    - ???????????? ?????? ?????? : ????????? POS?????? ??????(070014)
                 * 2. WEB ?????? -> DESK ?????? ???
                 *    - BAPTCATB ?????? ????????? : ?????? DESK POS?????? ?????? -> ???????????? ??????
                 *    - ???????????? ?????? ?????? : ?????? DESK POS?????? ?????? -> ???????????? ??????
                 */
                map.put("recpt_pos_no",AKmem_vat_ext_use_pt);
                
                
                AKmem_CustNo = Utils.checkNullString(map.get("AKmem_CustNo"));
                AKmem_Family_CustNo = Utils.checkNullString(map.get("AKmem_Family_CustNo"));
                
                lect_dao.useAKmembersPointLog(hq, store, pos_no, recpt_no, total_pay, total_enuri_amt, total_regis_fee, 
                		akmem_card_no, AKmem_CustNo, AKmem_Family_CustNo,
                		AKmem_Use_Point, AKmem_vat_use_pt, AKmem_vat_ext_use_pt, AKmem_SaveApprove_Point, AKmem_SaveApproveNo_POS, akmem_point_amt, login_seq
                		
                		);
            }

            
        // AK????????? ???????????? ??????  (2019.03.25 ljs ??????) end   
        }
            else {
                // ???????????? ERR
                sApprovNo = "Fail0000";
                sMessage = "Header ERROR";
                map.put("sApprovNo", sApprovNo);
                map.put("sMessage", sMessage);
                System.out.println("HEADER FORMAT ERROR");
            }
        } else {
            sApprovNo = "Fail0000";
            sMessage = "AKmembers ??????????????????";
            map.put("sApprovNo", sApprovNo);
            map.put("sMessage", sMessage);
            System.out.println("XA241S ?????? ERROR");
        }
        acard.stop();

        return map;
	}
//	@RequestMapping("/sale_proc")
//	public ModelAndView sale_proc(HttpServletRequest request) throws Exception {
//		ModelAndView mav = new ModelAndView(); 
//		mav.setViewName("/WEB-INF/pages/member/lect/sale_proc");
//		
//		HttpSession session = request.getSession();
//		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
//		String cust_no = Utils.checkNullString(request.getParameter("cust_no")); 
//		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
//		String store = Utils.checkNullString(request.getParameter("selBranch"));
//		String period = Utils.checkNullString(request.getParameter("selPeri")); 
//		
//		int enuri = 0;
//		if(!"".equals(Utils.checkNullString(request.getParameter("encd_pay"))))
//		{
//			enuri = Integer.parseInt(Utils.checkNullString(request.getParameter("encd_pay")).replaceAll(",", ""));
//		}
//		
//		String recpt_no = trms_dao.getRecpt(store, pos_no);
//		mav.addObject("recpt_no", recpt_no);
//		
//		String cash_amt         = Utils.checkNullString(request.getParameter("cash")).replaceAll(",", "");
//		String card_amt         = Utils.checkNullString(request.getParameter("card_amt")).replaceAll(",", "");
//		String mcoupon_amt         = Utils.checkNullString(request.getParameter("mcoupon_amt"));
//		if("".equals(mcoupon_amt))
//		{
//			mcoupon_amt = "0";
//		}
//		String regis_fee         = Utils.checkNullString(request.getParameter("regis_fee")).replaceAll(",", "");
//		String food_amt         = Utils.checkNullString(request.getParameter("food_amt")).replaceAll(",", "");
//		String total_amt         = Utils.checkNullString(request.getParameter("total_pay")).replaceAll(",", "");
//		String total_show_amt         = Utils.checkNullString(request.getParameter("total_show_amt")).replaceAll(",", "");
//		String akmem_point_amt         = Utils.checkNullString(request.getParameter("akmem_point_amt"));
//		
//		
//		System.out.println("*****************cash_amt>>>>>>>>>>>>>>>>>>>>>>>>>>" + cash_amt);
//		System.out.println("*****************card_amt>>>>>>>>>>>>>>>>>>>>>>>>>>" + card_amt);
//		System.out.println("*****************mcoupon_amt>>>>>>>>>>>>>>>>>>>>>>>" + mcoupon_amt); // ????????? ?????? ?????? ??????
//		System.out.println("*****************food_amt>>>>>>>>>>>>>>>>>>>>>>>>>>" + food_amt);
//		System.out.println("*****************total_amt>>>>>>>>>>>>>>>>>>>>>>>>>" + total_amt);
//		System.out.println("*****************akmem_point_amt>>>>>>>>>>>>>>>>>>>"+akmem_point_amt);    //AK????????????????????????  2019.03.11 ljs ??????
//		
//		if( (card_amt == null || "0".equals(card_amt) || "".equals(card_amt)) && (mcoupon_amt == null || "0".equals(mcoupon_amt) || "".equals(mcoupon_amt)) ) {
//            System.out.println("*****************????????????0???,?????????????????????0???********************"); 
//            if(cash_amt == null || "0".equals(cash_amt) || "".equals(cash_amt)) {
//                System.out.println("*****************????????????0???********************");
//            } else {
//                System.out.println("*****************?????????????????????.********************");
//                cash_amt = String.valueOf((Integer.parseInt(cash_amt) - Integer.parseInt(food_amt)));
//                total_amt = String.valueOf((Integer.parseInt(total_amt) - Integer.parseInt(food_amt)));
//                total_show_amt = String.valueOf((Integer.parseInt(total_show_amt) - Integer.parseInt(food_amt)));                
//            }
//        }
//		
//		String send_yn = "";
//        String mc_send_yn = "";
//        
//        String total_card_amt = "";
//        
//        if ( Integer.parseInt(card_amt) > 0 ) { send_yn = "N"; }
//        if ( Integer.parseInt(mcoupon_amt) > 0 ) { mc_send_yn = "N"; }
//        
//        if ( mc_send_yn == "N" ) { 
//            total_card_amt = String.valueOf(Integer.parseInt(card_amt) + Integer.parseInt(mcoupon_amt));
//        } else {
//            total_card_amt = card_amt;
//        }
//		
//        //2 : ?????????, 3 : ????????????, 7 : ????????? + ?????????, 8 : ????????????  
//        String pay_fg = "";
//        if("0".equals(food_amt))
//        {
//        	pay_fg = "2";
//        }
//        else
//        {
//        	pay_fg = "7";
//        }
//        
//        String md = "";
//        String op = "";
//        String goods = "";
//        if(store.equals("01")) {
//			md = "090031";
//			op = "0001";	
//			goods = "09003100001130";
//		}else if(store.equals("02")) {
//			md = "090033";
//			op = "0001";
//			goods = "09003300001130";
//		}else if(store.equals("03")) {
//			md = "090012";
//			op = "0001";
//			goods = "09001200012238";
//		}else if(store.equals("04")) {  
//			md = "000152";
//			op = "0001";
//			goods = "00015200011201";
//		}else if(store.equals("05")) {
//			md = "000246";
//			op = "0001";
//			goods = "00024600012001";
//		}
//        
//        String card_data_fg = Utils.checkNullString(request.getParameter("card_data_fg"));
//        String encCardNo_send_str = Utils.checkNullString(request.getParameter("encCardNo_send_str"));
//        System.out.println("cardData : "+encCardNo_send_str);
//        String decCardNo = "";
//        
//        String before_amt = Integer.toString(Integer.parseInt(regis_fee) + Integer.parseInt(food_amt));
//        trms_dao.insTrms(store, pos_no, recpt_no, before_amt, total_amt, regis_fee, enuri, food_amt, cash_amt, total_card_amt, pay_fg, cust_no, period, md, op, login_seq, send_yn, mc_send_yn);
//        
//        if( (card_amt == null || "0".equals(card_amt) || "".equals(card_amt)) && (mcoupon_amt == null || "0".equals(mcoupon_amt) || "".equals(mcoupon_amt)) ) {
//            System.out.println("*****************????????????0???, ????????????????????? 0???********************");
//        } else {
//            if (card_data_fg.equals("Q") || card_data_fg.equals("q")) {
//                //cmc - bcqr ??? ??? ????????? ??????
//            }
//            else {
////                decCardNo = AKCommon.GetCustEncCardNoDec(store, encCardNo_send_str);//???????????? ???????????????.
//            	decCardNo = "0000"; //??????
//            	System.out.println("???????????? ???????????? : "+decCardNo);
//                //System.out.println("???????????? decCardNo = " + param.getParameter("decCardNo"));        
//                if(decCardNo == null || "".equals(decCardNo)){
//                    throw new Exception("???????????? ?????? ??? ????????? ????????????. ????????? ????????????!!");
//                }
//            }
//            
//            String approve_fg = "1"; //?????? ?????? ?????? ??? ????????????. BASale0202.xrw ?????? ?????? ??????(??????,??????) ??????
//            
//            String card_data = "";
//            if(card_data_fg.equals("Q") || card_data_fg.equals("q")) {
//                card_data = encCardNo_send_str;      // bc qr ??? ????????? ????????? ??????.  cmc - 20190513
//            }
//            else {
//            	card_data = decCardNo;          // IC????????? ?????? DB????????? ??????
//            }
//            
//            String approve_no = Utils.checkNullString(request.getParameter("recieve"));
//            String sign_data = Utils.checkNullString(request.getParameter("sign_data"));
//            String card_id = Utils.checkNullString(request.getParameter("card_id"));
//            String card_co_origin_seq = Utils.checkNullString(request.getParameter("card_co_origin_seq"));
//            String month = Utils.checkNullString(request.getParameter("month"));
//            String inst_fg = "";
//            if("00".equals(month))
//            {
//            	inst_fg = "0";
//            }
//            else
//            {
//            	inst_fg = "1";
//            }
//            trms_dao.insTrca(store, pos_no, recpt_no, card_data_fg, card_data, approve_no, approve_fg, sign_data, card_amt, card_id, card_co_origin_seq, month, inst_fg);
//            if(mcoupon_amt != null && !"0".equals(mcoupon_amt) && !"".equals(mcoupon_amt)) //?????????????????? ?????????
//            {
//            	//?????????????????? ?????? ?????????
//            }
//        }
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//		
//		
//		String chk_subject_cd = Utils.checkNullString(request.getParameter("chk_subject_cd")); 
//		String subject_cd[] = chk_subject_cd.split("\\|");
//		
//		for(int i = 0; i < subject_cd.length; i++)
//		{
//			List<HashMap<String, Object>> list = common_dao.getLects(subject_cd[i]);
//			if(list.size() == 0)
//			{
//				mav.addObject("isSuc", "fail");
//				mav.addObject("msg", "????????? ?????? ???????????? ????????????.");
//				return mav;
//			}
//		}
//		for(int i = 0; i < subject_cd.length; i++)
//		{
//			List<HashMap<String, Object>> list = common_dao.getLects(subject_cd[i]);
//			String main_cd = list.get(0).get("MAIN_CD").toString();
//			String sect_cd = list.get(0).get("SECT_CD").toString();
//			String cd_regis_fee = list.get(0).get("REGIS_FEE").toString();
//			String cd_food_fee = "0";
//			if("Y".equals(list.get(0).get("FOOD_YN").toString()))
//			{
//				cd_food_fee = list.get(0).get("FOOD_AMT").toString();
//			}
//			String enuri_yn = "N";
//			if(enuri > 0)
//			{
//				enuri_yn = "Y";
//			}
//			lect_dao.upPeltRegis(store, period, subject_cd[i].replaceAll("\'", ""));
//			lect_dao.insSale(store, pos_no, recpt_no, (i+1), subject_cd[i].replaceAll("\'", ""), cust_no, period, main_cd, sect_cd, cd_regis_fee, cd_food_fee, enuri_yn, login_seq);
//			trms_dao.insTrde(store, pos_no, recpt_no, (i+1), subject_cd[i].replaceAll("\'", ""), goods, cd_regis_fee, enuri, cd_food_fee);
//		}
//		
//		ModifiableHttpServletRequest m = new ModifiableHttpServletRequest(request);
//		Random ran = new Random();
//		Enumeration<String> paramKeys = request.getParameterNames();
//		char v = (char)ran.nextInt(250);
//		while (paramKeys.hasMoreElements()) {
//			 String key = paramKeys.nextElement();
//			 String convVal = "";
//			 for(int i = 0; i < request.getParameter(key).length(); i++)
//			 {
//				 convVal += Character.toString(v); //??????????????? ??????????????? ??????
//			 }
//			 m.setParameter(key, convVal); //????????? ??????
//		}
//		request = (HttpServletRequest)m; //??????????????? request ??????
//		v = 0xFF;
//		while (paramKeys.hasMoreElements()) {
//			String key = paramKeys.nextElement();
//			String convVal = "";
//			for(int i = 0; i < request.getParameter(key).length(); i++)
//			{
//				convVal += Character.toString(v); //??????????????? 0xFF??? ??????
//			}
//			m.setParameter(key, convVal); //0xFF ??????
//		}
//		request = (HttpServletRequest)m; //0xFF??? request ??????
//		v = 0x00;
//		while (paramKeys.hasMoreElements()) {
//			String key = paramKeys.nextElement();
//			String convVal = "";
//			for(int i = 0; i < request.getParameter(key).length(); i++)
//			{
//				convVal += Character.toString(v); //??????????????? 0x00?????? ??????
//			}
//			m.setParameter(key, convVal); //0x00 ??????
//		}
//		request = (HttpServletRequest)m; //0x00?????? request ??????
//		mav.addObject("isSuc", "success");
//		mav.addObject("msg", "?????????????????????.");
//		
//		return mav;
//	}
	@RequestMapping("/checkView")
	public ModelAndView checkView(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/lect/checkView");
		HttpSession session = request.getSession();
		Utils.setPeriController(mav, common_dao, session);
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos = Utils.checkNullString(request.getParameter("pos"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		
		if(!"".equals(store) && !"".equals(pos))
		{
			String pgm_arg = "00"+store+sale_ymd+pos;
			List<HashMap<String, Object>> list = lect_dao.getIntegrity(store, sale_ymd, pos);
			
			mav.addObject("list",list);
		}
		
		String store_name = common_dao.getStoreName(store);
		mav.addObject("store", store);
		mav.addObject("pos", pos);
		mav.addObject("store_name", store_name);
		mav.addObject("sale_ymd", sale_ymd);
		
		return mav;
	}
	@RequestMapping("/getCouponCdCombo")
	@ResponseBody
	public List<HashMap<String, Object>> getCouponCdCombo(HttpServletRequest request) {
		
		List<HashMap<String, Object>> list = lect_dao.getCouponCdCombo(); 
		
		return list;
	}
	@RequestMapping("/getCancelSubject")
	@ResponseBody
	public List<HashMap<String, Object>> getCancelSubject(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String recpt_pos_no = Utils.checkNullString(request.getParameter("recpt_pos_no"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		
		List<HashMap<String, Object>> list = lect_dao.getCancelSubject(store, recpt_pos_no, period, sale_ymd, recpt_no); 
		
		return list;
	}
	@RequestMapping("/getCouponInfo")
	@ResponseBody
	public List<HashMap<String, Object>> getCouponInfo(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos_no = Utils.checkNullString(request.getParameter("pos_no"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		
		List<HashMap<String, Object>> list = lect_dao.getCouponInfo(store, pos_no, sale_ymd, recpt_no); 
		
		return list;
	}
	@RequestMapping("/getBAMobileCouponCheck")
	@ResponseBody
	public HashMap<String, Object> getBAMobileCouponCheck(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> map = new HashMap<>();
		String msgType = "1900"; // (?????? : 1700, ?????? : 1800, ???????????? : 1900)
        String approve = "";

        String date = AKCommon.getCurrentDate().substring(4, 8);
        String tel_corp_fg = "1";
        
        String posNo = Utils.checkNullString(request.getParameter("pos_no"));
        String barcodeNo = Utils.checkNullString(request.getParameter("barcode_no"));
        String store = Utils.checkNullString(request.getParameter("store"));
        
        try
        {
        	 List<HashMap<String, Object>> list = lect_dao.GetMobileCouponTradeNo(store);
             
             if(list.size() == 0)
             {
             	map.put("isSuc", "fail");
     			map.put("msg", "?????????/?????? ?????? ?????? ??????!!");
     			return map;
             }
             
             String storeId = Utils.checkNullString(list.get(0).get("STORE_ID"));
             String tradeSeq = Utils.checkNullString(list.get(0).get("TRADE_NO"));
             tradeSeq = AKCommon.LPAD(tradeSeq, 6, "0".charAt(0));
             
             String tradeNo = date + posNo + tradeSeq; // ?????????_MMDD(4)+POSNO(6)+SEQ(6)
             
             MobileApp mobileApp = new MobileApp();
             mobileApp.setTranStmt(msgType, storeId, tradeNo, barcodeNo, null, null,null, null);
             
             if("OK".equals(mobileApp.start(tel_corp_fg))){
                 approve = mobileApp.run();
                 System.out.println("approve : "+approve);
             } else {
             	map.put("isSuc", "fail");
     			map.put("msg", "???????????????????????? ?????? ??????!!");
                 throw new Exception("???????????????????????? ?????? ??????!!");
             }
             mobileApp.stop();

             String res_code = approve.substring(145, 147);
             String remain_amt = approve.substring(38, 50);
             remain_amt = String.valueOf(Integer.parseInt(remain_amt));

             if(!("00").equals(res_code)){
             	map.put("isSuc", "fail");
     			map.put("msg", "[" + res_code + "] \r\n" + MobileAppResponse.getResponseStr(res_code));
                 throw new Exception("[" + res_code + "] "
                         + MobileAppResponse.getResponseStr(res_code));
             }
             
             map.put("isSuc", "success");
             map.put("result_cd", res_code);
             map.put("remain_amt", remain_amt);
        }
        catch(Exception e)
        {
        	map.put("isSuc", "fail");
 			map.put("msg", "??? ??? ?????? ?????? ??????");
        	e.printStackTrace();
        }
        
       
		
		return map;
	}
	@RequestMapping("/getApproveMobileCoupon")
	@ResponseBody
	public HashMap<String, Object> getApproveMobileCoupon(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> map = new HashMap<>();
		String msgType = "1700"; // (?????? : 1700, ?????? : 1800, ???????????? : 1900)
		String approve = "";
		
		String date = AKCommon.getCurrentDate().substring(4, 8);
		String tel_corp_fg = "1";
		
		String posNo = Utils.checkNullString(request.getParameter("pos_no"));
		String barcodeNo = Utils.checkNullString(request.getParameter("barcode_no"));
		String sale_amt = Utils.checkNullString(request.getParameter("sale_amt"));
		String store = Utils.checkNullString(request.getParameter("store"));
		
		try
		{
			List<HashMap<String, Object>> list = lect_dao.GetMobileCouponTradeNo(store);
			
			if(list.size() == 0)
			{
				map.put("isSuc", "fail");
				map.put("msg", "?????????/?????? ?????? ?????? ??????!!");
				return map;
			}
			
			String storeId = Utils.checkNullString(list.get(0).get("STORE_ID"));
			String tradeSeq = Utils.checkNullString(list.get(0).get("TRADE_NO"));
			tradeSeq = AKCommon.LPAD(tradeSeq, 6, "0".charAt(0));
			
			String tradeNo = date + posNo + tradeSeq; // ?????????_MMDD(4)+POSNO(6)+SEQ(6)
			
			MobileApp mobileApp = new MobileApp();
			mobileApp.setTranStmt(msgType, storeId, tradeNo, barcodeNo, sale_amt, null, null, null);
			
			if("OK".equals(mobileApp.start(tel_corp_fg))){
				approve = mobileApp.run();
			} else {
				throw new Exception("???????????????????????? ?????? ??????!!");
			}
			mobileApp.stop();
			
			String res_code = approve.substring(157, 159);
	        String aprv_amt = approve.substring(38, 50);
	        aprv_amt = String.valueOf(Integer.parseInt(aprv_amt));
	        String remain_amt = approve.substring(50, 62);
	        remain_amt = String.valueOf(Integer.parseInt(remain_amt));
	        String aprv_no = approve.substring(222, 233);
			
	        if(!("00").equals(res_code)){
	        	map.put("isSuc", "fail");
	        	map.put("msg", "[" + res_code + "] "+ MobileAppResponse.getResponseStr(res_code));
	            throw new Exception("[" + res_code + "] "+ MobileAppResponse.getResponseStr(res_code));
	        }
	        map.put("isSuc", "success");
	        map.put("result_cd", res_code);
	        map.put("approve_amt", aprv_amt);
	        map.put("coupon_remain_amt", remain_amt);
	        map.put("approve_no", aprv_no);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			map.put("isSuc", "fail");
        	map.put("msg", "??? ??? ?????? ?????? ??????");
		}
		
		
		return map;
	}
	@RequestMapping("/getRecpt")
	@ResponseBody
	public String getRecpt(HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String recpt_no = trms_dao.getRecpt(store, pos_no);
		
		return recpt_no;
	}
	@RequestMapping("/getMemberPay")
	@ResponseBody
	public HashMap<String, Object> getMemberPay(HttpServletRequest request) throws Exception{
		HashMap<String, Object> data = lect_dao.getMemberPay();
		
		return data;
	}
	@RequestMapping("/sale_proc")
	@ResponseBody
	public HashMap<String, Object> sale_proc(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> map = new HashMap<>();
		HashMap<String, Object> retMap = new HashMap<>();
		HttpSession session = request.getSession();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period")); 
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no")); 
		
		
		try
		{
			String recpt_no = trms_dao.getRecpt(store, pos_no);
			if (recpt_no == null || "".equals(recpt_no)) {
				retMap.put("isSuc", "fail");
				retMap.put("msg", "????????? ????????? ???????????? ???????????????!");
	            throw new Exception ("????????? ????????? ???????????? ???????????????!");
	        } else {
//	        	recpt_no = recpt_no;
	        }
			
			String cash_amt         = Utils.checkNullString(request.getParameter("cash_amt"));
	        String card_amt         = Utils.checkNullString(request.getParameter("card_amt"));
	        String mcoupon_amt      = Utils.checkNullString(request.getParameter("mcoupon_amt"));            // ????????? ?????? ?????? ??????
	        String food_amt         = Utils.checkNullString(request.getParameter("food_amt"));
	        String total_amt        = Utils.checkNullString(request.getParameter("total_amt"));
	        String total_show_amt   = Utils.checkNullString(request.getParameter("total_show_amt"));  //??????????????? ??????????????????
	        String akmem_point_amt  = Utils.checkNullString(request.getParameter("akmem_point_amt"));   //AK????????????????????????  2019.03.11 ljs ??????
	        String akmem_card_no  = Utils.checkNullString(request.getParameter("akmem_card_no"));
	        String akmem_card_status  = Utils.checkNullString(request.getParameter("akmem_card_status"));
	        
	        String regis_amt  = Utils.checkNullString(request.getParameter("regis_amt"));
	        String coupon_amt  = Utils.checkNullString(request.getParameter("coupon_amt"));
	        String md  = Utils.checkNullString(request.getParameter("md"));
	        String op  = Utils.checkNullString(request.getParameter("op"));
	        String goods  = Utils.checkNullString(request.getParameter("goods"));
	        String card_data_fg  = Utils.checkNullString(request.getParameter("card_data_fg"));
	        String encCardNo_send_str  = Utils.checkNullString(request.getParameter("encCardNo_send_str"));
	        String card_co_origin_seq  = Utils.checkNullString(request.getParameter("card_co_origin_seq"));
	        String card_approve_no  = Utils.checkNullString(request.getParameter("card_approve_no"));
	        String month  = Utils.checkNullString(request.getParameter("month"));
	        String rate  = Utils.checkNullString(request.getParameter("rate"));
	        String sign_data  = Utils.checkNullString(request.getParameter("sign_data"));
	        String barcode_no  = Utils.checkNullString(request.getParameter("barcode_no"));
	        String mcoupon_approve_no  = Utils.checkNullString(request.getParameter("mcoupon_approve_no"));
	        String mcoupon_approve_amt  = Utils.checkNullString(request.getParameter("mcoupon_approve_amt"));
	        String cash_approve_no  = Utils.checkNullString(request.getParameter("cash_approve_no"));
	        String cash_approve_amt  = Utils.checkNullString(request.getParameter("cash_approve_amt"));
	        String cash_issue_fg  = Utils.checkNullString(request.getParameter("cash_issue_fg"));
	        String cash_id_fg  = Utils.checkNullString(request.getParameter("cash_id_fg"));
	        String cash_id_no  = Utils.checkNullString(request.getParameter("cash_id_no"));
	        String cash_rate  = Utils.checkNullString(request.getParameter("cash_rate"));
	        String credit_yn  = Utils.checkNullString(request.getParameter("credit_yn"));
	        
	        
	        String coupon_fg_arr  = Utils.checkNullString(request.getParameter("coupon_fg_arr"));
	        String coupon_cd_arr  = Utils.checkNullString(request.getParameter("coupon_cd_arr"));
	        String coupon_no_arr  = Utils.checkNullString(request.getParameter("coupon_no_arr"));
	        String face_amt_arr  = Utils.checkNullString(request.getParameter("face_amt_arr"));
	        String cashrec_yn_arr  = Utils.checkNullString(request.getParameter("cashrec_yn_arr"));
	        String vat_cal_ext_rate_arr  = Utils.checkNullString(request.getParameter("vat_cal_ext_rate_arr"));
	        String vat_cal_rate_arr  = Utils.checkNullString(request.getParameter("vat_cal_rate_arr"));
	        String cp_chage_amt_arr  = Utils.checkNullString(request.getParameter("cp_chage_amt_arr"));
	        String cp_chage_apy_y_amt_arr  = Utils.checkNullString(request.getParameter("cp_chage_apy_y_amt_arr"));
	        String cp_chage_apy_n_amt_arr  = Utils.checkNullString(request.getParameter("cp_chage_apy_n_amt_arr"));
	        String cashrec_amt_arr  = Utils.checkNullString(request.getParameter("cashrec_amt_arr"));
	        String cashrec_n_amt_arr  = Utils.checkNullString(request.getParameter("cashrec_n_amt_arr"));
	        
	        String change  = Utils.checkNullString(request.getParameter("change"));
	        
	        
	        String subject_arr = Utils.checkNullString(request.getParameter("subject_arr"));
	        String part_subject_arr = Utils.checkNullString(request.getParameter("part_subject_arr"));
	        System.out.println("part_subject_arr : "+part_subject_arr);
	        String child_no1_arr = Utils.checkNullString(request.getParameter("child_no1_arr"));
	        String child_no2_arr = Utils.checkNullString(request.getParameter("child_no2_arr"));
	        String child_no3_arr = Utils.checkNullString(request.getParameter("child_no3_arr"));
	        String encd_no1_arr = Utils.checkNullString(request.getParameter("encd_no1_arr"));
	        String encd_no2_arr = Utils.checkNullString(request.getParameter("encd_no2_arr"));
	        String encd_amt1_arr = Utils.checkNullString(request.getParameter("encd_amt1_arr"));
	        String encd_amt2_arr = Utils.checkNullString(request.getParameter("encd_amt2_arr"));
	        String part_regis_fee_arr = Utils.checkNullString(request.getParameter("part_regis_fee_arr"));
	        String part_food_amt_arr = Utils.checkNullString(request.getParameter("part_food_amt_arr"));
	        
	        map.put("store", store);
	        map.put("period", period);
	        map.put("pos_no", pos_no);
	        map.put("login_seq", login_seq);
	        map.put("cust_no", cust_no);
	        map.put("recpt_no", recpt_no);
	        
	        map.put("cash_amt", cash_amt);
	        map.put("card_amt", card_amt);
	        map.put("mcoupon_amt", mcoupon_amt);
	        map.put("food_amt", food_amt);
	        map.put("total_amt", total_amt);
	        map.put("total_show_amt", total_show_amt);
	        map.put("akmem_point_amt", akmem_point_amt);
	        
	        map.put("regis_amt", regis_amt);
	        map.put("coupon_amt", coupon_amt);
	        map.put("md", md);
	        map.put("op", op);
	        map.put("goods", goods);
	        
	        map.put("card_data_fg", card_data_fg);
	        map.put("encCardNo_send_str", encCardNo_send_str);
	        map.put("card_co_origin_seq", card_co_origin_seq);
	        map.put("card_approve_no", card_approve_no);
	        map.put("month", month);
	        map.put("rate", rate);
	        map.put("sign_data", sign_data);
	        
	        map.put("barcode_no", barcode_no);
	        map.put("mcoupon_approve_no", mcoupon_approve_no);
	        map.put("mcoupon_approve_amt", mcoupon_approve_amt);
	        
	        
	        map.put("cash_approve_no", cash_approve_no);
	        map.put("cash_approve_amt", cash_approve_amt);
	        map.put("cash_issue_fg", cash_issue_fg);
	        map.put("cash_id_fg", cash_id_fg);
	        map.put("cash_id_no", cash_id_no);
	        map.put("cash_rate", cash_rate);
	        map.put("credit_yn", credit_yn);
	        
	        map.put("change", change);
	        
	        System.out.println("change : "+change);
	        System.out.println("cash_amt : "+cash_amt);
			
	        //??????????????? ????????? - ???, cash????????? ???????????? total_amt??? cash_amt??? ????????? ??? ???????????? ????????????.
	        if( (card_amt == null || "0".equals(card_amt) || "".equals(card_amt)) && (mcoupon_amt == null || "0".equals(mcoupon_amt) || "".equals(mcoupon_amt)) ) {
	            System.out.println("*****************????????????0???,?????????????????????0???********************"); 
	            if((cash_amt == null || "0".equals(cash_amt) || "".equals(cash_amt)) && (coupon_amt == null || "0".equals(coupon_amt) || "".equals(coupon_amt))) {
	                System.out.println("*****************????????????0???********************");
	            } else {
	                System.out.println("*****************?????????????????????.********************");
	                System.out.println("cash_approve_no : "+cash_approve_no);
	                cash_amt = String.valueOf((Integer.parseInt(cash_amt) - Integer.parseInt(food_amt)));
	                total_amt = String.valueOf((Integer.parseInt(total_amt) - Integer.parseInt(food_amt)));
	                total_show_amt = String.valueOf((Integer.parseInt(total_show_amt) - Integer.parseInt(food_amt)));           
	                map.put("cash_amt" ,        Integer.parseInt(cash_amt) - Integer.parseInt(change));
	                map.put("total_amt",        total_amt);
	                map.put("total_show_amt",   total_show_amt);
	            }
	        }
	        //??? ?????? ???????????? ?????? ???????????? ????????? ?????????.
	        
	        String send_yn = "";
	        String mc_send_yn = "";
	        
	        if( card_amt == null || "0".equals(card_amt) || "".equals(card_amt) ) {
	            card_amt = "0";
	        }
	        if( mcoupon_amt == null || "0".equals(mcoupon_amt) || "".equals(mcoupon_amt) ) {
	            mcoupon_amt = "0";
	        }
	        
	        if ( Integer.parseInt(card_amt) > 0 ) { send_yn = "N"; }
	        if ( Integer.parseInt(mcoupon_amt) > 0 ) { mc_send_yn = "N"; }
	        
	        if ( mc_send_yn == "N" ) { 
	            map.put("total_card_amt", String.valueOf(Integer.parseInt(card_amt) + Integer.parseInt(mcoupon_amt)) );
	        } else {
	            map.put("total_card_amt", card_amt);
	        }
	        
	        map.put("send_yn", send_yn);
	        map.put("mc_send_yn", mc_send_yn);
	        
	        if(Integer.parseInt(food_amt) > 0)
			{
				map.put("pay_fg", "7");
			}
			else
			{
				map.put("pay_fg", "2");
			}
			System.out.println("map.get(\"cash_amt\") : "+map.get("cash_amt"));
			
			String subject_cd[] = subject_arr.split("\\|");
	        String part_subject_cd[] = part_subject_arr.split("\\|");
	        String child_no1[] = child_no1_arr.split("\\|");
	        String child_no2[] = child_no2_arr.split("\\|");
	        String child_no3[] = child_no3_arr.split("\\|");
	        String encd_no1[] = encd_no1_arr.split("\\|");
	        String encd_no2[] = encd_no2_arr.split("\\|");
	        String encd_amt1[] = encd_amt1_arr.split("\\|");
	        String encd_amt2[] = encd_amt2_arr.split("\\|");
	        String part_regis_fee[] = part_regis_fee_arr.split("\\|");
	        String part_food_amt[] = part_food_amt_arr.split("\\|");
	        String rep_subject_cd = subject_cd[0]; //????????????
			
			int tot_enuri1 = 0;
	        int tot_enuri2 = 0;
	        
			for(int i = 0; i < subject_cd.length; i++)
			{
				String encdno1 = encd_no1[i];
				String encdno2 = encd_no2[i];
				String encdamt1 = encd_amt1[i];
				String encdamt2 = encd_amt2[i];
				if("undefined".equals(encdno1)) {encdno1 = "";}
				if("undefined".equals(encdno2)) {encdno2 = "";}
				if("undefined".equals(encdamt1)) {encdamt1 = "0";} else {tot_enuri1 += Integer.parseInt(encdamt1);}
				if("undefined".equals(encdamt2)) {encdamt2 = "0";} else {tot_enuri2 += Integer.parseInt(encdamt2);}
			}
			map.put("tot_enuri1", tot_enuri1);
			map.put("tot_enuri2", tot_enuri2);
			int check = lect_dao.insTrms(map);
	        if(check == -1) {
	        	retMap.put("isSuc", "fail");
				retMap.put("msg", "??????????????? ?????????(BATRMSTB) ????????? ?????????????????????!!");
	            throw new Exception ("??????????????? ?????????(BATRMSTB) ????????? ?????????????????????!!");
	        }
	        
	        
	        //BATRDETB INSERT, BAPERETB UPDATE
	        
	        String park_subject_cd = "";
	        
	        
			for(int i = 0; i < subject_cd.length; i++)
			{
				System.out.println("????????? ???????????? ::::"+subject_cd[i]);
				park_subject_cd += "\'"+subject_cd[i]+"\',";
				List<HashMap<String, Object>> list = common_dao.getLects(store, period, subject_cd[i]);
				String main_cd = Utils.checkNullString(list.get(0).get("MAIN_CD"));
				String sect_cd = Utils.checkNullString(list.get(0).get("SECT_CD"));
				String cd_regis_fee = Utils.checkNullString(list.get(0).get("REGIS_FEE"));
				String cd_food_fee = "0";
				if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
				{
					cd_food_fee = Utils.checkNullString(list.get(0).get("FOOD_AMT"));
				}
				
				String child1 = child_no1[i];
				String child2 = child_no2[i];
				String child3 = child_no3[i];
				String encdno1 = encd_no1[i];
				String encdno2 = encd_no2[i];
				String encdamt1 = encd_amt1[i];
				String encdamt2 = encd_amt2[i];
				String part_regis = part_regis_fee[i];
				String part_food = part_food_amt[i];
				
				String enuri_yn = "N";
				if("undefined".equals(child1)) {child1 = "0";}
				if("undefined".equals(child2)) {child2 = "0";}
				if("undefined".equals(child3)) {child3 = "0";}
				if("undefined".equals(encdno1)) {encdno1 = "";}
				if("undefined".equals(encdno2)) {encdno2 = "";}
				if("undefined".equals(encdamt1)) {encdamt1 = "0";} 
				if("undefined".equals(encdamt2)) {encdamt2 = "0";} 
				if("undefined".equals(part_regis)) {part_regis = "0";}
				if("undefined".equals(part_food)) {part_food = "0";}
				
				String p_cust = "";
				String c_cust1 = "";
				String c_cust2 = "";
				
				
				if(child1.length() > 3)
				{
					p_cust = child1;
					c_cust1 = child2;
					c_cust2 = child3;
				}
				else
				{
					c_cust1 = child1;
					c_cust2 = child2;
				}
				
				
				if(tot_enuri1 + tot_enuri2 > 0)
				{
					enuri_yn = "Y";
				}
				
				boolean isPart = false;
				for(int z = 0; z < part_subject_cd.length; z++)
				{
					if(part_subject_cd[z].equals(subject_cd[i]))
					{
						lect_dao.upPeltPart(store, period, subject_cd[i].replaceAll("\'", ""), part_regis); //??????????????? ????????????
						isPart = true;
					}
				}
				if(isPart)
				{
					System.out.println("???????????? ::::::" + subject_cd[i]);
					System.out.println("??????????????? ::::::" + part_regis);
					System.out.println("????????????????????? ::::::" + part_food);
					lect_dao.upPeltRegis_part(store, period, subject_cd[i].replaceAll("\'", ""));
//					lect_dao.insSale(store, pos_no, recpt_no, (i+1), subject_cd[i].replaceAll("\'", ""), cust_no, period, main_cd, sect_cd, part_regis, part_food, enuri_yn, login_seq, c_cust1, c_cust2, encdno1, encdno2);
					lect_dao.insTrde(store, pos_no, recpt_no, (i+1), subject_cd[i].replaceAll("\'", ""), goods, part_regis, encdamt1, encdamt2, part_food);
				}
				else
				{
					System.out.println("???????????? ::::::" + subject_cd[i]);
					System.out.println("??????????????? ::::::" + cd_regis_fee);
					System.out.println("????????????????????? ::::::" + cd_food_fee);
					int person = 0;
					if(!"0".equals(p_cust) && !"".equals(p_cust))
					{
						person ++;
					}
					if(!"0".equals(c_cust1) && !"".equals(c_cust1))
					{
						person ++;
					}
					if(!"0".equals(c_cust2) && !"".equals(c_cust2))
					{
						person ++;
					}
					
					lect_dao.upPeltRegis(store, period, subject_cd[i].replaceAll("\'", ""), person);
					lect_dao.insSale(store, pos_no, recpt_no, (i+1), subject_cd[i].replaceAll("\'", ""), cust_no, period, main_cd, sect_cd, cd_regis_fee, cd_food_fee, enuri_yn, login_seq, c_cust1, c_cust2, encdno1, encdno2);
					lect_dao.insTrde(store, pos_no, recpt_no, (i+1), subject_cd[i].replaceAll("\'", ""), goods, cd_regis_fee, encdamt1, encdamt2, cd_food_fee);
				}
				/*
				if (!encdno1.equals("")) 
				{
					int result = lect_dao.useEncd(store,period,cust_no,encdno1);
					if (result < 1) 
					{
						lect_dao.insEncd(store,period,cust_no,encdno1,login_seq);
					}
				}
				
				if (!encdno2.equals("")) 
				{
					int result = lect_dao.useEncd(store,period,cust_no,encdno2);	
					if (result < 1) 
					{
						lect_dao.insEncd(store,period,cust_no,encdno2,login_seq);
					}
				}
				*/
				
				lect_dao.upWait(store, period, subject_cd[i].replaceAll("\'", ""), cust_no, c_cust1); //????????? ?????? ???????????? ??????
				
				
				
				
				
				
				
				
			}
			
//	        Collection list = param.getInsertedGridData("grid_data");
//	        if(!list.isEmpty()) {
//	            dao.insertBASaleImportant020201(param, list);
//	        }
	        
	        
	        
	        //???????????? ????????? BATRCATB INSERT
	        if( (card_amt == null || "0".equals(card_amt) || "".equals(card_amt)) && (mcoupon_amt == null || "0".equals(mcoupon_amt) || "".equals(mcoupon_amt)) ) {
	            System.out.println("*****************????????????0???, ????????????????????? 0???********************");
	        } else {
	        	System.out.println("card_data_fg : "+card_data_fg);
	            if (card_data_fg.equals("Q") || card_data_fg.equals("q") || card_data_fg.equals("N") || card_data_fg.equals("n")) {
	                //cmc - bcqr ??? ??? ????????? ??????
	            	map.put("card_no", encCardNo_send_str);
	            }
	            else {
	            	if(card_amt == null || "0".equals(card_amt) || "".equals(card_amt)) //??????????????? ????????????????????? ???????????? ???????????????.
	            	{
	            		
	            	}
	            	else
	            	{
	            		System.out.println("???????????? ????????????111 : "+encCardNo_send_str);
	            		AKCommon.setBundang_approve_ip(bundang_approve_ip);
	        			AKCommon.setBundang_approve_port(bundang_approve_port);
	            		String decCardNo = AKCommon.GetCustEncCardNoDec(store, encCardNo_send_str);//?????? ????????? ???????????????
	            		System.out.println("DES_CARD_NO : "+decCardNo);
	            		if(decCardNo == null || "".equals(decCardNo)){
	            			retMap.put("isSuc", "fail");
	        				retMap.put("msg", "???????????? ?????? ??? ????????? ????????????. ????????? ????????????!!");
	            			throw new Exception("???????????? ?????? ??? ????????? ????????????. ????????? ????????????!!");
	            		}
	            		else
	            		{
	            			map.put("card_no", decCardNo);
	            		}
	            	}
	            }
	            String approve_fg = "1";
	            map.put("approve_fg", approve_fg);
	            
	            if(Integer.parseInt(mcoupon_amt) > 0 && Integer.parseInt(card_amt) > 0)
	            {
	            	//????????????
	            	for(int i = 1; i <= 2; i++)
	            	{
	            		map.put("seq_no", i);
	            		if(i == 1)
	            		{
	            			lect_dao.insTrca_card(map);
	            		}
	            		else
	            		{
	            			lect_dao.insTrca_mcoupon(map);
	            		}
	            	}
	            }
	            else if(Integer.parseInt(card_amt) > 0)
	            {
	            	//????????????
	            	map.put("seq_no", 1);
	            	lect_dao.insTrca_card(map);
	            }
	            else if(Integer.parseInt(mcoupon_amt) > 0)
	            {
	            	//????????????
	            	map.put("seq_no", 1);
	            	lect_dao.insTrca_mcoupon(map);
	            }
	            
	        }
	      //??????????????? ????????? BACASHTB INSERT
	        
	        if(cash_approve_no == null || cash_approve_no == "" || cash_approve_no.length() < 9) {
	        } else {
	            //??????????????????(12.01.18)
	            //int checkV2 = dao.insertBASaleImportant020202(param);
//	            if(param.getParameter("cash_encCardNo_send_str") != null && !"".equals(param.getParameter("cash_encCardNo_send_str"))){
//	                map.put("encCardNo_send_str", param.getParameter("cash_encCardNo_send_str"));
//	                common.GetCustEncCardNoDec(param);//?????? ????????? ???????????????
//	                
//	                if(param.getParameter("decCardNo")== null || "".equals(param.getParameter("decCardNo"))){
//	                    throw new Exception("??????????????? ?????? ?????? ??? ????????? ????????????. ????????? ????????????!!");
//	                }
//	                map.put("id_no", param.getParameter("decCardNo"));
//	                
//	            }
//	            
	            
	            //AK?????????:555,????????????:666 ????????? ??????(1201.18)
	            int checkV2 = lect_dao.insCash(map);
	            if(checkV2 == -1) {
	            	retMap.put("isSuc", "fail");
    				retMap.put("msg", "??????????????? ?????????(BACASHTB) ????????? ?????????????????????!!");
	                throw new Exception("??????????????? ?????????(BACASHTB) ????????? ?????????????????????!!");
	            }
	        }

	        //????????? ????????? AGPOSLTB INSERT
	        System.out.println("coupon_fg_arr : "+coupon_fg_arr);
	        System.out.println("coupon_cd_arr : "+coupon_cd_arr);
	        System.out.println("coupon_no_arr : "+coupon_no_arr);
	        System.out.println("face_amt_arr : "+face_amt_arr);
	        System.out.println("cashrec_yn_arr : "+cashrec_yn_arr);
	        System.out.println("vat_cal_ext_rate_arr : "+vat_cal_ext_rate_arr);
	        System.out.println("vat_cal_rate_arr : "+vat_cal_rate_arr);
	        System.out.println("vat_cal_rate_arr : "+vat_cal_rate_arr);
	        if(!"".equals(coupon_fg_arr)) {
	        	 String coupon_fg[] = coupon_fg_arr.split("\\|", -1);
	             String coupon_cd[] = coupon_cd_arr.split("\\|", -1);
	             String coupon_no[] = coupon_no_arr.split("\\|", -1);
	             String face_amt[] = face_amt_arr.split("\\|", -1);
	             String cashrec_yn[] = cashrec_yn_arr.split("\\|", -1);
	             String vat_cal_ext_rate[] = vat_cal_ext_rate_arr.split("\\|", -1);
	             String vat_cal_rate[] = vat_cal_rate_arr.split("\\|", -1);
	             String cp_chage_amt[] = cp_chage_amt_arr.split("\\|", -1);
	             String cp_chage_apy_y_amt[] = cp_chage_apy_y_amt_arr.split("\\|", -1);
	             String cp_chage_apy_n_amt[] = cp_chage_apy_n_amt_arr.split("\\|", -1);
	             String cashrec_amt[] = cashrec_amt_arr.split("\\|", -1);
	             String cashrec_n_amt[] = cashrec_n_amt_arr.split("\\|", -1);
	     		for(int i = 0; i < coupon_fg.length-1; i++)
	     		{
	     			map.put("coupon_fg", coupon_fg[i]);
	     	        map.put("coupon_cd", coupon_cd[i]);
	     	        map.put("coupon_no", coupon_no[i]);
	     	        map.put("face_amt", face_amt[i]);
	     	        map.put("cashrec_yn", cashrec_yn[i]);
	     	        map.put("vat_cal_ext_rate", vat_cal_ext_rate[i]);
	     	        map.put("vat_cal_rate", vat_cal_rate[i]);
	     	        map.put("cp_chage_amt", cp_chage_amt[i]);
	     	        map.put("cp_chage_apy_y_amt", cp_chage_apy_y_amt[i]);
	     	        map.put("cp_chage_apy_n_amt", cp_chage_apy_n_amt[i]);
	     	        map.put("cashrec_amt", cashrec_amt[i]);
	     	        map.put("cashrec_n_amt", cashrec_n_amt[i]);
	     	        
	     	        map.put("seq_no", (i+1));
	     	        
	     	        
	     			lect_dao.insTrcn(map);
	     			map.put("change", "0");
	     			if("01".equals(store)) {
	                     map.put("callbk_dept", "020294");
	                 } else if("02".equals(store)) {
	                     map.put("callbk_dept", "030394");                
	                 } else if("03".equals(store)) {
	                     map.put("callbk_dept", "011194");
	                 } else if("04".equals(store)) {  // ????????? ?????? 09.04.17
	                     map.put("callbk_dept", "040494");                
	                 } else if("05".equals(store)) {  // ????????? ?????? 16.05.16
	                     map.put("callbk_dept", "050594");                
	                 }
	     			
	     			if("0".equals(coupon_fg[i]) || "7".equals(coupon_fg[i]))
	     			{
	     				//?????? ???????????? ????????????.
	     				if(!"Y".equals(isTest))
	     		        {
	     					lect_dao.insAgposl(map); //???????????? ??????. ???????????? ????????? ????????????????????????.
	     		        }
	     			}
	     		}
	        }
	        
			// ???????????? ??????
			String car_no = lect_dao.getCar(store, cust_no);
			if (!"".equals(car_no) && car_no != null) {
				System.out.println("#############???????????? ????????????======" + car_no);
				List<HashMap<String, Object>> list = lect_dao.selCar(store, cust_no);
				if(list.size() > 0)
				{
					lect_dao.upCar(store, cust_no, login_seq, "");
				}
				park_subject_cd = park_subject_cd.substring(0, park_subject_cd.length()-1);
				lect_dao.insCar(store, cust_no, car_no, period, rep_subject_cd, pos_no, recpt_no, total_show_amt, login_seq, park_subject_cd);
			}
	       
	        
//	        Collection couponList = param.getInsertedGridData("grid_coupon");
//	        if(!list.isEmpty()) {
//	            //BATRCNTB ?????????????????? ????????? ???????????? ??????
//	            dao.insertBASaleImportant020204(param, couponList);
//	            //AGPOSLTB ????????? ?????? ?????? ??????
//	            dao.insertBASaleImportant020203(param, couponList);
//	        }
			
			//?????? ????????? ????????? ??? ???????????? ??????
			CmAKmembers exeAKmem = new CmAKmembers();
			exeAKmem.setANYLINK_AU1(mem_url1);
			exeAKmem.setANYLINK_AU2(mem_url2);
			String akmem_recpt_no = "";
			int slip_cnt = 0;
			int total_enuri_amt = tot_enuri1 + tot_enuri2;
			if ("00".equals(akmem_card_status)) {
				if ("01".equals(store)) {
					akmem_recpt_no = lect_dao.getAKmemRecptNo_01();
				} else if ("02".equals(store)) {
					akmem_recpt_no = lect_dao.getAKmemRecptNo_02();
				} else if ("03".equals(store)) {
					akmem_recpt_no = lect_dao.getAKmemRecptNo_03();
				} else if ("04".equals(store)) {
					akmem_recpt_no = lect_dao.getAKmemRecptNo_04();
				} else if ("05".equals(store)) {
					akmem_recpt_no = lect_dao.getAKmemRecptNo_05();
				}
			}
			//?????? 4, ?????? 8, ?????? W
			int SHINHANCount = 0;
			int KBCount = 0;
			int WBCount = 0;
			if("4".equals(card_data_fg))
			{
				SHINHANCount = 1;
			}
			else if("8".equals(card_data_fg))
			{
				KBCount = 1;
			}
			else if("W".equals(card_data_fg))
			{
				WBCount = 1;
			}
			String realPay = ""; //??????????????? ????????? ?????? ??????????????? ????????????.
			realPay = Integer.toString(Integer.parseInt(total_amt) - Integer.parseInt(akmem_point_amt));
			if(Integer.parseInt(akmem_point_amt) > 0)
			{
				HashMap akmap = exeAKmem.AKmemPoint(store 
	               		, akmem_card_no
	               		, "0000000000000000" // card_no
	                       , Utils.getCurrentDate() // recpt_sale_ymd
	                       , pos_no // ????????? ?????? ??????
	                       , akmem_recpt_no // recpt_no ?????????????????? ???????????? ???????????? akmem_recpt_no
	                       , realPay //?????????????????? ???????????????
	                       , Integer.toString(exeAKmem.getCalcAkmemPoint(SHINHANCount, KBCount, WBCount, Double.parseDouble(realPay), lect_dao)) // akmem_recpt_point
	                       , akmem_point_amt // akmem_recpt_point
	                       , ""
	                       , ""
	                       , "USE");
				
				String AKmem_sApprovNo2 = (String) akmap.get("RSP_CD");
	            String AKmem_sMessage2 = (String) akmap.get("MSG_TRMNL");
	            System.out.println("???????????? 1: "+AKmem_sApprovNo2);
				if ("00".equals(AKmem_sApprovNo2)) {
					String AKmem_SaveApproveNo = (String) akmap.get("PTCP_PERM_NO");
	                String AKmem_SaveApproveNo_POS = (String) akmap.get("PERM_NO");
	                String AKmem_SaveApprove_Point = (String) akmap.get("EUSE_PT");
	                String AKmem_CustNo = (String) akmap.get("CUS_NO");
	                String AKmem_Create_Point = "0";
	                String AKmem_send_buff = (String) akmap.get("SEND_STR");
	                String AKmem_recv_buff = (String) akmap.get("RECV_BUFF");
	                String AKmem_CardNo = (String) akmap.get("CARD_NO");
	                String USE_PT = Utils.removeNULL((String) akmap.get("USE_PT"),"0");
	                String VAT_CAL_USE_PT = Utils.removeNULL((String) akmap.get("VAT_USE_PT"),"0");
	                String VAT_CAL_EXT_USE_PT = Utils.removeNULL((String) akmap.get("VAT_EXT_USE_PT"),"0");
	                slip_cnt ++;
	                
	                HashMap<String, Object> paramMap2 = new HashMap<>();
	           		paramMap2.put("hq", "00");
	           		paramMap2.put("store", store);
	           		paramMap2.put("sDate", Utils.getCurrentDate());
	           		paramMap2.put("pos_no", pos_no);
	           		paramMap2.put("akmem_recpt_no", akmem_recpt_no);
	           		paramMap2.put("period", period);
	           		paramMap2.put("dTotalAmt", realPay);
	           		paramMap2.put("AKmem_CardNo", AKmem_CardNo);// ?????????????????????-????????? ??????(2018.06.20)
	           		paramMap2.put("AKmem_CustNo", AKmem_CustNo);
	           		paramMap2.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
	           		paramMap2.put("AKmem_SaveApprove_Point", Integer.parseInt(AKmem_SaveApprove_Point));
	           		
	           		paramMap2.put("USE_PT", Integer.parseInt(USE_PT));
	           		paramMap2.put("VAT_CAL_USE_PT", Integer.parseInt(VAT_CAL_USE_PT));
	           		paramMap2.put("VAT_CAL_EXT_USE_PT", Integer.parseInt(VAT_CAL_EXT_USE_PT));
	           		paramMap2.put("AKmem_send_buff", AKmem_send_buff);
	           		paramMap2.put("AKmem_recv_buff", AKmem_recv_buff);
	           		paramMap2.put("slip_cnt", slip_cnt);
	           		
	           		lect_dao.insWbptTb(paramMap2); 
	           		
	           		retMap.put("akmem_sApprovNo", AKmem_SaveApproveNo_POS); //???????????? ?????? ????????????
	           		retMap.put("akmem_recpt_point", AKmem_Create_Point); //???????????? ?????? ?????????
	           		retMap.put("akmem_save_approve_no_point", AKmem_SaveApprove_Point); //???????????? ?????? ?????????
	           		retMap.put("akmem_cust_no", AKmem_CustNo);
	                
	                VAT_CAL_USE_PT = String.valueOf(Integer.valueOf(VAT_CAL_USE_PT)); //?????? 0000 ?????????
	                VAT_CAL_EXT_USE_PT = String.valueOf(Integer.valueOf(VAT_CAL_EXT_USE_PT)); //?????? 0000 ?????????
	                
	                lect_dao.useAKmembersPointLog("00", store, pos_no, recpt_no, total_amt, Integer.toString(total_enuri_amt), regis_amt, 
	                		akmem_card_no, AKmem_CustNo, "",
	                		akmem_point_amt, VAT_CAL_USE_PT, VAT_CAL_EXT_USE_PT, AKmem_SaveApprove_Point, AKmem_SaveApproveNo_POS, akmem_point_amt, login_seq
	                		
	                		);
				} else {

				}
				
			}
			//?????? ????????? ????????? ??? ???????????? ??????
			
			//???????????? ??????
			if(Integer.parseInt(realPay) > 0)
			{
				HashMap akmap = exeAKmem.AKmemPoint(store 
	               		, akmem_card_no
	               		, "0000000000000000" // card_no
	                       , Utils.getCurrentDate() // recpt_sale_ymd
	                       , pos_no // ????????? ?????? ??????
	                       , akmem_recpt_no // recpt_no ?????????????????? ???????????? ???????????? akmem_recpt_no
	                       , realPay
	                       , Integer.toString(exeAKmem.getCalcAkmemPoint(SHINHANCount, KBCount, WBCount, Double.parseDouble(realPay), lect_dao)) // akmem_recpt_point
	                       , akmem_point_amt // akmem_recpt_point
	                       , ""
	                       , ""
	                       , "SAVE");
				String AKmem_sApprovNo = (String) akmap.get("RSP_CD");
	            String AKmem_sMessage = (String) akmap.get("MSG_TRMNL");
	            System.out.println("???????????? 3: "+AKmem_sApprovNo);
	            System.out.println("???????????? 4: "+akmem_recpt_no);
	            System.out.println("AKmem_sApprovNo : "+AKmem_sApprovNo);
	            if ("00".equals(AKmem_sApprovNo)) {
	            	String AKmem_SaveApproveNo = (String) akmap.get("PTCP_PERM_NO");
	                String AKmem_SaveApproveNo_POS = (String) akmap.get("PERM_NO");
	                String AKmem_SaveApprove_Point = (String) akmap.get("EUSE_PT");
	                String AKmem_CustNo = (String) akmap.get("CUS_NO");
	                String AKmem_Create_Point = (String) akmap.get("TOT_CREA_PT");
	                String AKmem_CardNo = (String) akmap.get("CARD_NO");
	                String AKmem_send_buff = (String) akmap.get("SEND_STR");
	                String AKmem_recv_buff = (String) akmap.get("RECV_BUFF");
	                
	                slip_cnt++;
	                System.out.println("AKmem_SaveApprove_Point >>>>> ??????1 >>>>> +"+AKmem_Create_Point);
	                System.out.println("AKmem_SaveApprove_Point >>>>> ??????2 >>>>> +"+AKmem_SaveApprove_Point);

	                // db insert
	                HashMap<String, Object> paramMap3 = new HashMap<>();
	           		paramMap3.put("hq", "00");
	           		paramMap3.put("store", store);
	           		paramMap3.put("sDate", Utils.getCurrentDate());
	           		paramMap3.put("pos_no", pos_no);
	           		paramMap3.put("akmem_recpt_no", akmem_recpt_no);
	           		paramMap3.put("dTotalAmt", realPay);
	           		paramMap3.put("AKmem_CardNo", AKmem_CardNo);// ?????????????????????-????????? ??????(2018.06.20)
	           		paramMap3.put("AKmem_CustNo", AKmem_CustNo);
	           		paramMap3.put("AKmem_Create_Point", AKmem_Create_Point);
	           		paramMap3.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
	           		paramMap3.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);
	           		paramMap3.put("AKmem_send_buff", AKmem_send_buff);
	           		paramMap3.put("AKmem_recv_buff", AKmem_recv_buff);
	           		paramMap3.put("slip_cnt", slip_cnt);
	           		lect_dao.insWbptTb2(paramMap3); 
	           		retMap.put("akmem_save_approve_no", AKmem_SaveApproveNo_POS); //???????????? ?????? ????????????
	           		retMap.put("akmem_recpt_point", AKmem_Create_Point); //???????????? ?????? ?????????
	           		retMap.put("akmem_save_approve_no_point", AKmem_SaveApprove_Point); //???????????? ?????? ?????????
	           		retMap.put("akmem_cust_no", AKmem_CustNo);
	                
	                HashMap<String, Object> paramMap = new HashMap<>();
	                paramMap.put("store", store);
	                paramMap.put("pos_no", pos_no);
	                paramMap.put("recpt_no", recpt_no);
	                paramMap.put("total_show_amt", total_show_amt);
	                paramMap.put("total_enuri_amt", total_enuri_amt);
	                paramMap.put("total_regis_fee", regis_amt);
	                paramMap.put("akmem_point_amt", akmem_point_amt);
	                paramMap.put("AKmem_cardno", AKmem_CardNo);
	                paramMap.put("AKmem_SaveApprove_Point", AKmem_SaveApprove_Point);
	                paramMap.put("login_seq", login_seq);
	                paramMap.put("AKmem_CustNo", AKmem_CustNo);
	                paramMap.put("AKmem_Family_CustNo", "");
	                paramMap.put("AKmem_recpt_point", AKmem_Create_Point);
	                paramMap.put("AKmem_SaveApproveNo_POS", AKmem_SaveApproveNo_POS);
	                
	                lect_dao.saveAKmembersPointLog(paramMap);
	                
	                
	            }
						
			}

			//???????????? T-012 : ????????? ???????????? ????????? ?????? ?????? ??? ???????????? ?????? ??????
			ModifiableHttpServletRequest m = new ModifiableHttpServletRequest(request);
			Random ran = new Random();
			Enumeration<String> paramKeys = request.getParameterNames();
			char v = (char)ran.nextInt(250);
			while (paramKeys.hasMoreElements()) {
				 String key = paramKeys.nextElement();
				 String convVal = "";
				 for(int i = 0; i < request.getParameter(key).length(); i++)
				 {
					 convVal += Character.toString(v); //??????????????? ??????????????? ??????
				 }
				 m.setParameter(key, convVal); //????????? ??????
			}
			request = (HttpServletRequest)m; //??????????????? request ??????
			v = 0xFF;
			while (paramKeys.hasMoreElements()) {
				String key = paramKeys.nextElement();
				String convVal = "";
				for(int i = 0; i < request.getParameter(key).length(); i++)
				{
					convVal += Character.toString(v); //??????????????? 0xFF??? ??????
				}
				m.setParameter(key, convVal); //0xFF ??????
			}
			request = (HttpServletRequest)m; //0xFF??? request ??????
			v = 0x00;
			while (paramKeys.hasMoreElements()) {
				String key = paramKeys.nextElement();
				String convVal = "";
				for(int i = 0; i < request.getParameter(key).length(); i++)
				{
					convVal += Character.toString(v); //??????????????? 0x00?????? ??????
				}
				m.setParameter(key, convVal); //0x00 ??????
			}
			request = (HttpServletRequest)m; //0x00?????? request ??????
			
	        
			cash_amt         = null;
	        card_amt         = null;
	        mcoupon_amt      = null;
	        food_amt         = null;
	        total_amt        = null;
	        total_show_amt   = null;
	        akmem_point_amt  = null;      
	        
	        regis_amt  = null;
	        tot_enuri1  = 0;
	        tot_enuri2  = 0;
	        coupon_amt  = null;
	        md  = null;
	        op  = null;
	        goods  = null;
	        card_data_fg  = null;
	        encCardNo_send_str  = null;
	        card_co_origin_seq  = null;
	        card_approve_no  = null;
	        month  = null;
	        sign_data  = null;
	        barcode_no  = null;
	        mcoupon_approve_no  = null;
	        mcoupon_approve_amt  = null;
	        cash_approve_no  = null;
	        cash_approve_amt  = null;
	        cash_issue_fg  = null;
	        cash_id_fg  = null;
	        cash_id_no  = null;
	        cash_rate  = null;
	        
	        
	        coupon_fg_arr  = null;
	        coupon_cd_arr  = null;
	        coupon_no_arr  = null;
	        face_amt_arr  = null;
	        cashrec_yn_arr  = null;
	        vat_cal_ext_rate_arr  = null;
	        vat_cal_rate_arr  = null;
	        cp_chage_amt_arr  = null;
	        cp_chage_apy_y_amt_arr  = null;
	        cp_chage_apy_n_amt_arr  = null;
	        cashrec_amt_arr  = null;
	        cashrec_n_amt_arr  = null;
	        
	        change  = null;
	        
	        subject_arr = null;
	        
	        map = null;
	        
	        WeakHashMap<Integer, String> aa = new WeakHashMap<>();
	        aa = new WeakHashMap<>();
	        
	        System.gc();
	        
	        
	        
	      ///????????? ?????? start
			for(int i = 0; i < subject_cd.length; i++)
			{
				//???????????? ??????
				List<HashMap<String, Object>> list = common_dao.getLects(store, period, subject_cd[i]);
				if (list.size() > 0) 
				{
				//????????? ??????????????? ???????????? ????????? ??????????????? ???????????? ????????? ??????
				List<HashMap<String, Object>> gift_list = lect_dao.getGiftList(store, period,cust_no,Utils.checkNullString(list.get(0).get("SUBJECT_FG")));
				
					//?????? ????????? ???????????? ?????????
					if (gift_list.size() > 0)
					{
						for (int j = 0; j < gift_list.size(); j++) {
							System.out.println("????????? recpt_no : "+recpt_no);
							System.out.println("????????? pos_no : "+pos_no);
							
							//?????? ???????????? ????????? ?????? ????????? ????????? ??????
							HashMap<String, Object> chkGift = lect_dao.chkGift(store,Utils.checkNullString(gift_list.get(j).get("PERIOD")),cust_no,Utils.checkNullString(gift_list.get(j).get("GIFT_CD")));
							
							System.out.println("chkGift : "+chkGift);
							
							//?????? ??? ?????? ????????? ?????? insert
							if (chkGift==null) 
							{
								gift_dao.insGiftForTarget(store,Utils.checkNullString(gift_list.get(j).get("PERIOD")),cust_no,Utils.checkNullString(gift_list.get(j).get("GIFT_CD")),login_seq,pos_no,subject_cd[i]);
								System.out.println("????????? ??????");
							}
							else
							{
								//?????? ????????? ???????????? ??????????????? ?????? ??????????????? ?????? update
								if (chkGift.get("GIFT_STATUS").toString().equals("0")) 
								{
									gift_dao.UptGiftForTarget(store,Utils.checkNullString(gift_list.get(j).get("PERIOD")),cust_no,Utils.checkNullString(gift_list.get(j).get("GIFT_CD")),login_seq,pos_no,subject_cd[i]);
									System.out.println("????????? ?????????");
								}
							}
						}					
					}
				}
			}
			
			///????????? ?????? end
	        
	        //????????? ?????? START
			/*
			for(int i = 0; i < subject_cd.length; i++)
			{
				HashMap<String, Object> data = lect_dao.getAttendInfo(store,period,subject_cd[i]);
				if (data!=null) 
				{
					String dayChk[] = Utils.checkNullString(data.get("DAY_CHK")).split("\\|");
					String dayVal ="";
					for (int j = 0; j < dayChk.length; j++) 
					{
						dayVal+="X|";
					}
					
					HashMap<String, Object> chk_cust_in_attend = lect_dao.ChkCustInAttend(store,period,subject_cd[i],login_seq);
					if (Integer.parseInt(chk_cust_in_attend.get("CNT").toString()) < 1) 
					{
						//?????? ?????? ????????? ??????
						lect_dao.insAttend(store,period,subject_cd[i], login_seq,"N",cust_no,dayVal);
					}
				}
			}
			*/
			//????????? ?????? END
			
			retMap.put("isSuc", "success");
			retMap.put("msg", "????????? ?????????????????????.");
			common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "???????????? ??????", store+"/"+period+"/"+cust_no);
		}
		catch(Exception e)
		{
			e.printStackTrace();
			retMap.put("isSuc", "fail");
			retMap.put("msg", "??? ??? ?????? ?????? ??????");
		}
		
		
		
		return retMap;
	}
	@RequestMapping("/card_cancel_proc")
	@ResponseBody
	public HashMap<String, Object> card_cancel_proc(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> map = new HashMap<>();
		
		String approve = null;
        String sApprovNo = null;
        String sMessage = null;

        String scBank_cd = null;
        String scRate = null;
        String return_cd = null;
        
        String hq = Utils.checkNullString(request.getParameter("hq"));
        String store = Utils.checkNullString(request.getParameter("store"));
        String approve_no_exp = Utils.checkNullString(request.getParameter("approve_no_exp"));
        String ls_send_str = Utils.checkNullString(request.getParameter("ls_send_str"));
        log.info("SEND_DATA : [" + ls_send_str + "]");
        String msgType = ls_send_str.trim().substring(0, 6);
        String rest_amt = null; // ???????????? ?????? (2012.01.10)
        
        BABatchRun acard = new BABatchRun();
        
        if("00".equals(hq) && "01".equals(store))
		{
            // ?????????
            acard.setHost("172.10.1.71", 9302);
        }
		else if("00".equals(hq) && "02".equals(store))
		{
            // ?????????
            acard.setHost("173.10.1.71", 9302);
        }
		else if("00".equals(hq) && "03".equals(store))
		{
            // ?????????
			acard.setHost(bundang_approve_ip, Integer.parseInt(bundang_approve_port));
        }
		else if("00".equals(hq) && "04".equals(store))
		{
            // ?????????
            acard.setHost("174.10.1.71", 9302);
        }
		else if("00".equals(hq) && "05".equals(store))
		{
            // ?????????
            acard.setHost("175.10.1.71", 9302);
        }
		
		
        if(!acard.start().equals("OK")){
            sApprovNo = "Fail0000";
        } else {
            approve = acard.run(ls_send_str);
            
            if("XA272S".equals(msgType)){
                return_cd = approve.substring(6, 10); // ????????????

                approve = approve.substring(42); // ?????? ???????????? ????????? ?????? Body??? ??????

                sApprovNo = approve.substring(0, 8);
                scBank_cd = approve.substring(26, 27);
                scRate = approve.substring(27, 28);
                sMessage = AKCommon.subString(approve, 28, 40, null).trim(); // ????????? ????????????
                sMessage = "[" + return_cd + "]" + sMessage;
                if("00J9".equals(return_cd) || "8037".equals(return_cd) || "8354".equals(return_cd) || "9604".equals(return_cd)){
                	map.put("isSuc", "fail");
                	map.put("message", "?????? ?????? ?????? ??????. ?????? ??????");
                	return map;
                }
            }else if("XB272S".equals(msgType)){
                return_cd = approve.substring(6, 10); // ????????????

                approve = approve.substring(42); // ?????? ???????????? ????????? ?????? Body??? ??????

                sApprovNo = approve.substring(0, 8);
                scBank_cd = approve.substring(26, 27);
                scRate = approve.substring(27, 28);
                sMessage = AKCommon.subString(approve, 28, 40, null).trim(); // ????????? ????????????
                sMessage = "[" + return_cd + "]" + sMessage;
                rest_amt = approve.substring(68, 77).trim(); // ????????? ?????? ?????? (12.01.17)
                
                if(!"0000".equals(return_cd)){
                	if("00J9".equals(return_cd) || "8037".equals(return_cd) || "8354".equals(return_cd) || "9604".equals(return_cd)){
                    	map.put("isSuc", "fail");
                    	map.put("message", "?????? ?????? ?????? ??????. ?????? ??????");
                    }
                	else
                	{
                		map.put("isSuc", "fail");
                		map.put("message", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
                	}
                	return map;
                }
            }
            else if("XB415S".equals(msgType)){  // BC ????????? ?????? ?????? cmc 2019.05
                
                return_cd = approve.substring(6, 10); // ????????????


                approve = approve.substring(42); // ?????? ???????????? ????????? ?????? Body??? ??????
                
                sApprovNo = approve.substring(0, 8);
                scBank_cd = approve.substring(26, 27);
                scRate = approve.substring(27, 28);
                sMessage = AKCommon.subString(approve, 28, 40, null).trim(); // ????????? ????????????
                sMessage = "[" + return_cd + "]" + sMessage;
                rest_amt = approve.substring(68, 77).trim(); // ????????? ?????? ?????? (12.01.17)
                
                if(!"0000".equals(return_cd)){
                	if("00J9".equals(return_cd) || "8037".equals(return_cd) || "8354".equals(return_cd) || "9604".equals(return_cd)){
                    	map.put("isSuc", "fail");
                    	map.put("message", "?????? ?????? ?????? ??????. ?????? ??????");
                    }
                	else
                	{
                		map.put("isSuc", "fail");
                		map.put("message", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
                	}
                	return map;
                }
            }       // bc ????????? ?????? ???
            else if("XB425S".equals(msgType)){      // ?????? ????????? ?????? ?????? cmc 2019.05
                
                return_cd = approve.substring(6, 10); // ????????????


                approve = approve.substring(42); // ?????? ???????????? ????????? ?????? Body??? ??????

                sApprovNo = approve.substring(0, 8);
                scBank_cd = approve.substring(26, 27);
                scRate = approve.substring(27, 28);
                sMessage = AKCommon.subString(approve, 28, 40, null).trim(); // ????????? ????????????
                sMessage = "[" + return_cd + "]" + sMessage;
                rest_amt = approve.substring(68, 77).trim(); // ????????? ?????? ?????? (12.01.17)
                
                if(!"0000".equals(return_cd)){
                	if("00J9".equals(return_cd) || "8037".equals(return_cd) || "8354".equals(return_cd) || "9604".equals(return_cd)){
                    	map.put("isSuc", "fail");
                    	map.put("message", "?????? ?????? ?????? ??????. ?????? ??????");
                    }
                	else
                	{
                		map.put("isSuc", "fail");
                		map.put("message", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
                	}
                	return map;
                }
            }           // ???????????? ????????? ?????? ???
            else if("XB512S".equals(msgType)){              //          bcqr ????????? ?????? ?????? cmc 2019.05
                
                return_cd = approve.substring(0, 4);
                sApprovNo = approve.substring(4, 12);
                scBank_cd = approve.substring(12, 13);
                scRate = approve.substring(13, 14);
                sMessage = approve.substring(14, 54).trim();
                rest_amt = approve.substring(54).trim();        // ??????????????? ????????????????????? ?????? ??????
                
                if(!"0000".equals(return_cd)){
                	if("00J9".equals(return_cd) || "8037".equals(return_cd) || "8354".equals(return_cd) || "9604".equals(return_cd)){
                    	map.put("isSuc", "fail");
                    	map.put("message", "?????? ?????? ?????? ??????. ?????? ??????");
                    }
                	else
                	{
                		map.put("isSuc", "fail");
                		map.put("message", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
                	}
                	return map;
                }
            }       // bc QR ???????????? ???
            else {
                // ?????? ?????? ????????? ??? ??????->????????????????????? ??????(20161010)
                if("00".equals(hq) && ("00".equals(store))){
                    // ?????????
                    sApprovNo = approve.substring(0, 8);
                    scBank_cd = approve.substring(8, 9);
                    scRate = approve.substring(9, 10);
                    sMessage = approve.substring(10).trim();
                } else {
                    // //??????,??????,??????,?????? + ??????
                    // sApprovNo = approve.substring(0,8); ???????????????
                    // scBank_cd = approve.substring(26,27);
                    // scRate = approve.substring(27,28);
                    // sMessage = subString(approve, 28, 40, null).trim();

                    // ?????????
//                    sApprovNo = approve.substring(0, 8);
//                    scBank_cd = approve.substring(8, 9);
//                    scRate = approve.substring(9, 10);
//                    sMessage = approve.substring(10, 50).trim();
                    
                    return_cd = approve.substring(0, 4); // ????????????
                    sApprovNo = approve.substring(4, 12);
                    scBank_cd = approve.substring(12, 13);
                    scRate = approve.substring(13, 14);
                    sMessage = approve.substring(14, 54).trim();
                    
                    if("XB072S".equals(msgType) || "XB076S".equals(msgType) || "CB".equals(msgType.substring(0, 2))){
                        //rest_amt = approve.substring(50).trim();// ??????????????? ??????/?????? ??????????????? ?????? ??????
                        rest_amt = approve.substring(54).trim();// ??????????????? ????????????????????? ?????? ??????
                    }
                    
                    if(!"0000".equals(return_cd)){
                    	if("00J9".equals(return_cd) || "8037".equals(return_cd) || "8354".equals(return_cd) || "9604".equals(return_cd)){
                        	map.put("isSuc", "fail");
                        	map.put("message", "?????? ?????? ?????? ??????. ?????? ??????");
                        }
                    	else
                    	{
                    		map.put("isSuc", "fail");
                    		map.put("message", "[??????] "+sMessage+" ??????, ???????????? ?????? ??????????????????.");
                    	}
                    	return map;
                    }
                }
            }

            // 2014.10 ???????????? ?????? ????????? ?????? ????????? ?????? ?????? ???????????? ?????? ??????
            if(sMessage.trim().indexOf("?????????????????????????????????") > -1){
                sApprovNo = approve_no_exp;
            }

            // scRate????????? VAN_FG, ????????????VAN_FG??? ??????VAN_FG??? ?????? ??????
            if("1".equals(scRate)){ // KFTC
                scRate = "01";
            }else if("2".equals(scRate)){ // NICE
                scRate = "02";
            }else if("4".equals(scRate)){ // KOVEN
                scRate = "03";
            }else if("5".equals(scRate)){ // SSCARD
                scRate = "04";
            }else if("6".equals(scRate)){ // KICC
                scRate = "05";
            }else if("7".equals(scRate)){ // JTNET
                scRate = "06";
            }else if("8".equals(scRate)){ // KIS
                scRate = "07";
            }else if("9".equals(scRate)){ // SPCN
                scRate = "08";
            }else if("A".equals(scRate)){ // ????????? ?????????
                scRate = "10";
            }else if("B".equals(scRate)){ // KB ?????????
                scRate = "11";
            }else if("C".equals(scRate)){ // BC ?????????
                scRate = "12";
            }else if("D".equals(scRate)){ // ??????(SH) ?????????
                scRate = "13";
            }

        }

        // /////////////////////////////////////////////////////////////////////////////

        acard.stop();

        if(sMessage == null || "".equals(sMessage)){
        	map.put("isSuc", "fail");
        	map.put("message", "?????? ??? ???????????? ????????? ?????????????????????.");
        	return map;
        }

        ArrayList list = new ArrayList();

        // Collection ????????? ??????
        map.put("approve_no", sApprovNo);
        map.put("bank_cd", scBank_cd);
        map.put("rate", scRate);
        map.put("message", sMessage);
        map.put("rest_amt", rest_amt);

		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		
		return map;
	}
	@RequestMapping("/cancel_pg_proc")
	@ResponseBody
	public String cancel_pg_proc(HttpServletRequest request) throws Exception{
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String sale_ymd = Utils.checkNullString(request.getParameter("sale_ymd"));
		String recpt_no = Utils.checkNullString(request.getParameter("recpt_no"));
		String pos_no_ori = Utils.checkNullString(request.getParameter("pos_no_ori"));
		String tid_ori = Utils.checkNullString(request.getParameter("tid"));
		String tid = "";
		String card_corp_no = Utils.checkNullString(request.getParameter("card_corp_no"));
		
		tid = lect_dao.cancel_pg_proc(store, period, sale_ymd, recpt_no, pos_no_ori, tid);
		
		System.out.println("tid_ori : "+tid_ori);
		System.out.println("tid : "+tid);
		
		if(!tid_ori.equals(Utils.checkNullString(tid)))
        {
			System.out.println("????????????");
        	return "FAIL";
        }
		
		// PG ?????? ?????? WINDOW, ?????? ??? ?????? ??????
		J_PP_CLI_N c_PayPlus = new J_PP_CLI_N();
        
        String g_conf_home_dir = "";
        
        // ?????????
        //String g_conf_gw_url = "paygw.kcp.co.kr";		// ?????????
        //String g_conf_gw_url = "203.238.36.136";		// ??????IDC
        String g_conf_gw_url = "";
        String g_conf_log_level = "3";
        String g_conf_site_cd = "";
        String g_conf_site_key = "";
        if("Y".equals(isTest))
        {
        	g_conf_gw_url = "210.122.73.58";
        	g_conf_home_dir = "C:\\Users\\AK\\Documents\\workspace\\ak_culture\\WebContent\\kcp";
        	g_conf_site_cd = "T0000";
        	g_conf_site_key = "3grptw1.zW0GSo4PQdaGvsF__";
        }
        else
        {
        	g_conf_gw_url = "103.215.145.30";
        	g_conf_home_dir = "/aksw/app/admin_app/kcp";
        	g_conf_site_cd = AKCommon.getSiteCdKeyPg(store, card_corp_no, "site_cd");
    	   	g_conf_site_key = AKCommon.getSiteCdKeyPg(store, card_corp_no, "site_key");
        }
        
        // TEST
        //String g_conf_gw_url = "210.122.73.58";
    	String g_conf_gw_port = "8090";
    	int g_conf_tx_mode = 0;
    	String tran_cd = "";
    	
    	
    	String res_cd = "";
    	String res_msg = "";
    	
    	c_PayPlus.mf_init( "", g_conf_gw_url, g_conf_gw_port, g_conf_tx_mode, g_conf_home_dir );
    	c_PayPlus.mf_init_set();
    	
    	int    mod_data_set_no;

        tran_cd = "00200000";
        mod_data_set_no = c_PayPlus.mf_add_set( "mod_data" );
        
        InetAddress local = InetAddress.getLocalHost();

	   	String cust_ip  = local.getHostAddress();
	   	System.out.println("cust_ip : "+cust_ip);
    	
        c_PayPlus.mf_set_us( mod_data_set_no, "tno",        tid ); // KCP ????????? ????????????
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_type",   "STSC"                            ); // ????????? ?????? ?????? ??????
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_ip",     cust_ip                           ); // ?????? ????????? IP
        c_PayPlus.mf_set_us( mod_data_set_no, "mod_desc",   "AK PLAZA ?????? ???????????? ??? ?????? ??????     " ); // ?????? ??????
        
        if ( tran_cd.length() > 0 ){
        	c_PayPlus.mf_do_tx( g_conf_site_cd, g_conf_site_key, tran_cd, "", "", g_conf_log_level, "0" );            		
    	    res_cd  = c_PayPlus.m_res_cd;  // ?????? ??????
    		res_msg = c_PayPlus.m_res_msg; // ?????? ?????????
    	}else{
            c_PayPlus.m_res_cd  = "9562";
            c_PayPlus.m_res_msg = "?????? ??????|Payplus Plugin??? ???????????? ???????????? tran_cd?????? ???????????? ???????????????.";
            System.out.println("?????? ????????? ????????? ????????????. KCP??? ?????? ????????????. ");
            return "FAIL";
        }
        
        if(!res_cd.equals("0000")) // ??????????????? ????????? ?????? ????????? ?????? 
        {
            System.out.println("res_cd====="+res_cd);
            System.out.println("res_msg====="+res_msg);
            

        	System.out.println("KCP ?????? ????????? ????????? ?????? ???????????????. KCP??? ?????? ????????????.  ");
            return "FAIL";
        }
    	/* ?????? ????????? (????????????)*/
    	/*
    	//String g_conf_key_dir = "";
    	//String g_conf_log_dir = "";
    	g_conf_home_dir = "C:\\AKProjectHome\\akris\\webapp\\kcp";
    	g_conf_key_dir = "C:\\AKProjectHome\\akris\\webapp\\kcp\\bin\\pub.key";
    	g_conf_log_dir = "C:\\AKProjectHome\\akris\\webapp\\kcp\\log";
        */
    	//c_PayPlus.mf_init( g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_key_dir, g_conf_log_dir, g_conf_tx_mode );    	
        
    	/* ??? ????????? */
//	   	g_conf_home_dir = "/aksw/app/front_app/kcp";
//	   	c_PayPlus.mf_init( g_conf_home_dir, g_conf_gw_url, g_conf_gw_port, g_conf_tx_mode, "" );
//	   	
//	   	c_PayPlus.mf_init_set();
//	   	g_conf_site_cd = "T0000";
//	   	g_conf_site_key = "3grptw1.zW0GSo4PQdaGvsF__";
//	   	 
//	   	 
//	   	int    mod_data_set_no;
//	   	tran_cd = "00200000";
//	   	mod_data_set_no = c_PayPlus.mf_add_set( "mod_data" );
//	   	InetAddress local = InetAddress.getLocalHost();
//
//	   	String cust_ip  = local.getHostAddress();
//	   	System.out.println("cust_ip : "+cust_ip);
//	   	 
//    	//param.getParameter(SESSION_USER_IP)
////    	c_PayPlus.mf_set_us( mod_data_set_no, "tno",        tid_ori ); // KCP ????????? ????????????
////        c_PayPlus.mf_set_us( mod_data_set_no, "mod_type",   "STSC"                            ); // ????????? ?????? ?????? ??????
////        c_PayPlus.mf_set_us( mod_data_set_no, "mod_ip",     cust_ip); // ?????? ????????? IP
////        c_PayPlus.mf_set_us( mod_data_set_no, "mod_desc",   "AK PLAZA ?????? ???????????? DESK ?????? ??????     " ); // ?????? ??????
//        
//        c_PayPlus.mf_set_us( mod_data_set_no, "tno",      tid_ori); // KCP ????????? ????????????
//        c_PayPlus.mf_set_us( mod_data_set_no, "mod_type", "STSC"   ); // ????????? ?????? ?????? ??????
//        c_PayPlus.mf_set_us( mod_data_set_no, "mod_ip",   cust_ip  ); // ?????? ????????? IP
//        c_PayPlus.mf_set_us( mod_data_set_no, "mod_desc", "????????? ?????? ?????? ?????? - ??????????????? ?????? ??????"  ); // ?????? ??????
//        
//        c_PayPlus.mf_set_us( ordr_data_set_no, "ordr_mony", Double.toString(actionobj.getDTotalAmt()).split("\\.")[0] );
//       
//        System.out.println("tran_cd : "+tran_cd);
//        
//        if ( tran_cd.length() > 0 )
//        {
//            c_PayPlus.mf_do_tx( g_conf_site_cd, g_conf_site_key, tran_cd, "", "", g_conf_log_level, "0" );            		
//    		
//    	    res_cd  = c_PayPlus.m_res_cd;  // ?????? ??????
//    		res_msg = c_PayPlus.m_res_msg; // ?????? ?????????
//    		System.out.println("res_cd1 : "+res_cd);
//    		System.out.println("res_msg1 : "+res_msg);
//    	}
//        else
//        {
//            c_PayPlus.m_res_cd  = "9562";
//            c_PayPlus.m_res_msg = "?????? ??????|Payplus Plugin??? ???????????? ???????????? tran_cd?????? ???????????? ???????????????.";
//            System.out.println("?????? ??????|Payplus Plugin??? ???????????? ???????????? tran_cd?????? ???????????? ???????????????.");
//            return "FAIL";
//        }
//        
//        if(!res_cd.equals("0000")) // ??????????????? ????????? ?????? ????????? ?????? 
//        {
//        	System.out.println("??? ??? ?????? ?????? ??????");
//        	return "FAIL";        	
//        }
        
        return "SUCCESS";
	}
	@RequestMapping("/getCancelMobileCoupon")
	@ResponseBody
	public HashMap<String, Object> getCancelMobileCoupon(HttpServletRequest request) throws Exception{
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String tel_corp_fg = Utils.checkNullString(request.getParameter("tel_corp_fg"));
		String posNo = Utils.checkNullString(request.getParameter("pos_no"));
		String aprvNo = Utils.checkNullString(request.getParameter("aprv_no"));
		String saleAmt = Utils.checkNullString(request.getParameter("aprv_amt"));
		String saleYmd = Utils.checkNullString(request.getParameter("sale_ymd"));
		
		String smsFg = "N"; // SMS ????????????
        String msgType = "1800"; // (?????? : 1700, ?????? : 1800, ???????????? : 1900)
        String approve = "";

        String date = AKCommon.getCurrentDate().substring(4, 8);
        
        saleYmd = saleYmd.length() > 4 ? saleYmd
                .substring(saleYmd.length() - 4) : saleYmd;
                
        List<HashMap<String, Object>> list = lect_dao.GetMobileCouponTradeNo(store);
        
        if(list.size() == 0)
        {
        	map.put("isSuc", "fail");
			map.put("msg", "?????????/?????? ?????? ?????? ??????!!");
			return map;
        }
        
        String storeId = Utils.checkNullString(list.get(0).get("STORE_ID"));
        String tradeSeq = Utils.checkNullString(list.get(0).get("TRADE_NO"));
        tradeSeq = AKCommon.LPAD(tradeSeq, 6, "0".charAt(0));
        
        String tradeNo = date + posNo + tradeSeq; // ?????????_MMDD(4)+POSNO(6)+SEQ(6)
        MobileApp mobileApp = new MobileApp();
        
        mobileApp.setTranStmt(msgType, storeId, tradeNo, null, saleAmt, aprvNo,
                saleYmd, smsFg);
        
        if("OK".equals(mobileApp.start(tel_corp_fg))){
            approve = mobileApp.run();
        } else {
            throw new Exception("???????????????????????? ?????? ??????!!");
        }
        mobileApp.stop();
        
        String res_code = null; // ????????????
        String res_appr_no = null; // ????????????
        String remain_amt = null; // ??????
        String result_msg = null; // ?????? ?????????

        if(approve != null && approve.trim().length() != 0){
            res_code = approve.substring(144, 146);
            res_appr_no = approve.substring(209, 220);
            remain_amt = approve.substring(50, 62);
            remain_amt = String.valueOf(Integer.parseInt(remain_amt));
            result_msg = "[" + res_code + "] " + MobileAppResponse.getResponseStr(res_code);
        }

        if(res_code == null || ("").equals(res_code.trim())){
            result_msg = "???????????????????????? ?????? ??????";
        }

        map.put("result_cd", res_code);
        map.put("approve_no", res_appr_no);
        map.put("cancel_amt", saleAmt);
        map.put("remain_amt", remain_amt);
        map.put("result_msg", result_msg);
		
		return map;
	}
	@RequestMapping("/insTempPere")
	@ResponseBody
	public HashMap<String, Object> insTempPere(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String subject_arr = Utils.checkNullString(request.getParameter("subject_arr"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		String subject_cd[] = subject_arr.split("\\|");
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		lect_dao.delTempPere(store, period, cust_no);
		for(int i = 0; i < subject_cd.length; i++)
		{
			lect_dao.insTempPere(store, period, subject_cd[i], Integer.toString(i+1), cust_no, pos_no, login_seq);
		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "?????????????????????.");
		return map;
		
	}
	
	@RequestMapping("/addToCulture")
	@ResponseBody
	public HashMap<String, Object> getUserMembers(HttpServletRequest request) {
		HttpSession session = request.getSession();
		HashMap<String, Object> map = new HashMap<>();
		String search_type = Utils.checkNullString(request.getParameter("search_type"));
		String cont = Utils.checkNullString(request.getParameter("cont"));
		
		HashMap<String, Object> data = 	lect_dao.getUserMembers(search_type,cont);
				
		if (data == null || data.size() == 0) {
			map.put("msg", "????????? ????????? ????????????.");
			return map;
		}
		HashMap<String, Object> peri_data = cust_dao.getPeri_no();
		String newPeri = (String) peri_data.get("PERIOD");
		HashMap<String, Object> cus_seq = cust_dao.getCust_seq(newPeri);
		int newCustNo = Utils.checkNullInt(cus_seq.get("CUST_NO"))+1;
		System.out.println("newCustNo : "+newCustNo);
		String newCustNoConv = Utils.f_setfill_zero(Integer.toString(newCustNo),4,"L");
		System.out.println("newCustNoConv : "+newCustNoConv);
		
//		String cust_no = "77"+newPeri+newCustNoConv+"1";
		String cust_no = Utils.checkNullString(data.get("CUS_NO"));
		System.out.println("cust_no : "+cust_no);
		String ms_fg = "m"; //????????? ?????? ?????? m or c
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String marry_fg = Utils.checkNullString(data.get("WEDD_YN"));
		if (marry_fg.equals("Y")) {
			marry_fg="1";
		}else {
			marry_fg="2";
		}
		data.put("marry_fg", marry_fg);
		data.put("cust_no", cust_no);
		data.put("ms_fg", ms_fg);
		data.put("create_resi_no", create_resi_no);
		
		String store = Utils.checkNullString(session.getAttribute("login_req_store"));
		data.put("store", store);
		
		int result = lect_dao.insMemberToCulture(data);
		if (result > 0) 
		{
			map.put("msg", "??????????????? ?????????????????????.");			
		}
		else 
		{
			map.put("msg", "??????????????? ??????????????????.");			
		}
		
		map.put("data", data);
		return map;
	}
	@RequestMapping("/getAKmemRead")
	@ResponseBody
	public HashMap getAKmemRead(HttpServletRequest request) {
		HttpSession session = request.getSession();
		CmAKmembers cmAKmembers = new CmAKmembers();
		cmAKmembers.setANYLINK_AU1(mem_url1);
		cmAKmembers.setANYLINK_AU2(mem_url2);
		String store = Utils.checkNullString(request.getParameter("store"));
		String card_no = Utils.checkNullString(request.getParameter("card_no"));
		String pos_no = Utils.checkNullString(session.getAttribute("pos_no"));
		HashMap AKmemRead ;
		AKmemRead = cmAKmembers.getAKmemRead( store, card_no, pos_no);
//		String AKmemCardStatus = null;
//		double AKmemPoint = 0;
//		AKmemCardStatus = cmAKmembers.getAKmemStatus(AKmemRead);
		return AKmemRead;
		
	}
	@RequestMapping("/getCancelSubjectList")
	@ResponseBody
	public List<HashMap<String, Object>> getCancelSubjectList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		
		List<HashMap<String, Object>> list = lect_dao.getCancelSubjectList(store, period, cust_no); 
		
		
		
	    return list;
	}
	
	@RequestMapping("/GetAkmemCustInfoDecode")
	@ResponseBody
	public HashMap<String, Object> GetAkmemCustInfoDecode(HttpServletRequest request) throws Exception{
		
	    String store = Utils.checkNullString(request.getParameter("store"));
	    String AKmem_Send_Str = Utils.checkNullString(request.getParameter("send_data"));
	    AKmem_Send_Str = AKmem_Send_Str.replaceAll("@@@@@@@@@@@@@@", AKCommon.getCurrentDate() + AKCommon.getCurrentTime());
		String akmem_encCardNo_send_str = Utils.checkNullString(request.getParameter("akmem_encCardNo_send_str"));
		HashMap<String, Object> map = new HashMap<>();
		
		if (!(akmem_encCardNo_send_str == null || "".equals(akmem_encCardNo_send_str))) 
		{
			AKCommon.setBundang_approve_ip(bundang_approve_ip);
			AKCommon.setBundang_approve_port(bundang_approve_port);
			String AKmem_CardNo = AKCommon.GetCustEncCardNoDecStr(store, akmem_encCardNo_send_str);
			map.put("akmem_card_no", AKmem_CardNo);
		}
		else
		{
			
		}
		
		return map;
		
	}
	
	
	@RequestMapping("/ptcaCancel_test")
	public ModelAndView ptcaCancel_test(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/lect/ptcaCancel_test");
		
		String store = "05";
		String pos_no = "070002"; //?????? ??????
		String new_sale_ymd = "20210428"; //????????????
		String new_recpt_no = "0011"; //?????? ?????????
		String recpt_pos_no = "070002"; //???????????????
		String sale_ymd = "20210428"; //????????? ??????
		String recpt_no = "0008"; //????????? ?????????
		String cust_no = "107134708";
		String akmem_card_no = "7920099107134708";

		
		String login_seq = "1810610";
		HashMap AKmemRead ;
		CmAKmembers cmAKmembers = new CmAKmembers();
		cmAKmembers.setANYLINK_AU1("http://91.1.111.61:30002/soaptest/receiver");
		cmAKmembers.setANYLINK_AU2("http://91.1.111.62:30002/soaptest/receiver");
		AKmemRead = cmAKmembers.getAKmemRead( store, akmem_card_no, pos_no);
		HashMap<String, Object> rs3 = lect_dao.getAKmemSave_test(sale_ymd, store, recpt_pos_no, recpt_no, akmem_card_no);
		String card_in_amt = Integer.toString(Utils.checkNullInt(AKmemRead.get("AKmem_total_point")) - Utils.checkNullInt(rs3.get("AKMEM_RECPT_POINT")));
		 HashMap<String, Object> paramMap = new HashMap<>();
		 String tmp_pos_no = "";
        if("070013".equals(recpt_pos_no ) || "070014".equals(recpt_pos_no ))
        {
       	 tmp_pos_no = recpt_pos_no;
        }
        else 
        {
       	 tmp_pos_no = pos_no;
        }
        HashMap<String, Object> ori_paramMap = lect_dao.getptcaOri_test(store, sale_ymd, recpt_pos_no, recpt_no);
        
        paramMap.put("store", store);
        paramMap.put("pos_no", tmp_pos_no);
        paramMap.put("recpt_no", new_recpt_no);
        paramMap.put("total_show_amt", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
        paramMap.put("total_enuri_amt", Utils.checkNullString(ori_paramMap.get("ENURI_AMT")));
        paramMap.put("total_regis_fee", Utils.checkNullString(ori_paramMap.get("SSAT_TOT_AMT")));
        paramMap.put("akmem_point_amt", Utils.checkNullString(rs3.get("AKMEM_USE_POINT")));
        paramMap.put("AKmem_cardno", akmem_card_no);
        paramMap.put("AKmem_SaveApprove_Point", card_in_amt);
        paramMap.put("login_seq", login_seq);
        paramMap.put("AKmem_CustNo", cust_no.trim());
        paramMap.put("AKmem_Family_CustNo", "");
        paramMap.put("new_sale_ymd", new_sale_ymd);
        paramMap.put("AKmem_recpt_point", Utils.checkNullString(rs3.get("AKMEM_RECPT_POINT")));
        paramMap.put("AKmem_SaveApproveNo_POS", Utils.checkNullString(rs3.get("AKMEM_APPROVE_NO")));
		lect_dao.saveAKmembersPointLog_test(paramMap);
		return mav;
	}
	
	
	
	
	@RequestMapping("/sendMem_test")
	public ModelAndView sendMem_test(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/member/lect/sendMem_test");
		
		try
		{
			
			CmAKmembers exeAKmem = new CmAKmembers();
			exeAKmem.setANYLINK_AU1("http://91.1.111.61:30002/soaptest/receiver");
			exeAKmem.setANYLINK_AU2("http://91.1.111.62:30002/soaptest/receiver");
			
			HashMap akmap = exeAKmem.AKmemPoint("02" 
               		, "7920090011511536"
               		, "0000000000000000" // card_no
                       , "20210912" // recpt_sale_ymd
                       , "070003" // ????????? ?????? ??????
                       , "8585" // recpt_no ?????????????????? ???????????? ???????????? akmem_recpt_no
                       , "95000" //?????????????????? ???????????????
                       , "0" // akmem_recpt_point
                       , "100" // akmem_recpt_point
                       , ""
                       , ""
                       , "USE");
			String AKmem_sApprovNo = (String) akmap.get("RSP_CD");
	        String AKmem_sMessage = (String) akmap.get("MSG_TRMNL");
	        System.out.println("???????????? 3: "+AKmem_sApprovNo);
	        System.out.println("???????????? 4: "+AKmem_sMessage);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return mav;
	}
}