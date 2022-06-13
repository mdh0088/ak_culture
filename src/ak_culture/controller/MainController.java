package ak_culture.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.HolidayUtil;
import ak_culture.classes.Utils;
import ak_culture.model.basic.PeriDAO;
import ak_culture.model.lecture.LecrDAO;
import ak_culture.model.lecture.LectDAO;
import ak_culture.model.member.CustDAO;

@Controller
@RequestMapping("/*")
public class MainController {
	
	//자녀 먼저 돌려야한다. pere쪽에 pk 오류가 나기때문.
	
	@Autowired
	private CustDAO cust_dao;
	
	@Autowired
	private PeriDAO peri_dao;
	
	@Autowired
	private LectDAO lect_dao;
	
	@Autowired
	private LecrDAO lecr_dao;
	
	@Autowired
	private ak_culture.model.member.LectDAO Mlect_dao;
	
	//자녀 먼저 해야된다!! 회원먼저하면안된다 !!
	@RequestMapping("/updateChild") //자녀 통합
	public ModelAndView updateChild(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/updateChild");
		
		List<HashMap<String, Object>> cust_no_list = cust_dao.getCusnoByChild();
		System.out.println("======================모든 자식의 CUST_NO 조회");
		
		System.out.println("cust_no_list.size() : "+cust_no_list.size());
		int child_no = 1;
		String p_cust_no = "";
		for(int i = 0; i < cust_no_list.size(); i++)
		{
			try
			{
				if(!p_cust_no.equals(Utils.checkNullString(cust_no_list.get(i).get("P_CUST_NO")))) //전에 넣은애랑 지금넣을애가 다르다면 child_no 초기화
				{
					child_no = 1;
				}
				p_cust_no = Utils.checkNullString(cust_no_list.get(i).get("P_CUST_NO")); //부모 cust
				String store = Utils.checkNullString(cust_no_list.get(i).get("STORE"));
				String c_cust_no = Utils.checkNullString(cust_no_list.get(i).get("C_CUST_NO")); //자식 cust
				String birth_ymd = Utils.checkNullString(cust_no_list.get(i).get("BIRTH_YMD")); //생일
				String gender = Utils.checkNullString(cust_no_list.get(i).get("RELATION")); //성별
				String kor_nm = Utils.checkNullString(cust_no_list.get(i).get("KOR_NM")); //이름
				
				cust_dao.insChildByCust(p_cust_no, child_no, gender, birth_ymd, kor_nm, store);
				System.out.println("======================새로운 자식 테이블에 INSERT");
				
				cust_dao.updateChild_pere(p_cust_no, c_cust_no, child_no, store);
				System.out.println("======================PERE TABLE INSERT");
				
				cust_dao.updateChild_wbtr(p_cust_no, c_cust_no, child_no, store);
				System.out.println("======================WBTR TABLE INSERT");
				
				cust_dao.updateChild_wait(p_cust_no, c_cust_no, child_no, store);
				System.out.println("======================WAIT TABLE INSERT");
				
				cust_dao.updateChild_free(p_cust_no, c_cust_no, child_no, store);
				System.out.println("======================FREE TABLE INSERT");
				
				cust_dao.updateChild_deci(p_cust_no, c_cust_no, child_no, store);
				System.out.println("======================DECI TABLE INSERT");
				
				child_no ++;
			}
			catch(Exception e)
	         {
	            e.printStackTrace();
	         }
			System.out.println(i + " / "+ cust_no_list.size());
		}
		System.out.println("완료!");
		return mav;
	}
	
	
	@RequestMapping("/updateCust") //회원 통합
	public ModelAndView main(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/updateCust");
		List<HashMap<String, Object>> cus_no_list = cust_dao.getCusnoAll();
		System.out.println("======================모든 CUS_NO 조회");
		
		for(int i = 0; i < cus_no_list.size(); i++)
		{
			try
			{
				String cus_no = Utils.checkNullString(cus_no_list.get(i).get("CUS_NO"));
				cust_dao.insNewCust(cus_no);
				List<HashMap<String, Object>> cust_no_list = cust_dao.getCustnoByCusno(cus_no);
				System.out.println("======================cus_no("+cus_no+")의 cust_no 조회");
				for(int j = 0; j < cust_no_list.size(); j++)
				{
					try
					{
						String cust_no = Utils.checkNullString(cust_no_list.get(j).get("CUST_NO"));
						String store = Utils.checkNullString(cust_no_list.get(j).get("STORE"));
						cust_dao.updateCust_pere(cus_no, cust_no, store);
						cust_dao.updateCust_sign(cus_no, cust_no, store);
						cust_dao.updateCust_temp(cus_no, cust_no, store);
						cust_dao.updateCust_smsl(cus_no, cust_no, store);
						cust_dao.updateCust_wait(cus_no, cust_no, store);
						cust_dao.updateCust_free(cus_no, cust_no, store);
						cust_dao.updateCust_wbtr(cus_no, cust_no, store);
						cust_dao.updateCust_mail(cus_no, cust_no, store);
						cust_dao.updateCust_trms(cus_no, cust_no, store);
						cust_dao.updateCust_deci(cus_no, cust_no, store);
						cust_dao.updateCust_park(cus_no, cust_no, store);
						cust_dao.updateCust_kids(cus_no, cust_no, store);
					}
					catch(Exception e)
			        {
			            e.printStackTrace();
			        }
				}
			}
			catch(Exception e)
	        {
	            e.printStackTrace();
	        }
			System.out.println(i + " / "+ cus_no_list.size());
		}
		System.out.println("완료!");
		return mav;
	}
	
	@RequestMapping("/updateAttend") //출석부
	public ModelAndView updateAttend(HttpServletRequest request) throws ParseException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/updateAttend");
		
		String store= "05";
		
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	//	String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
	//	List<HashMap<String, Object>> list = cust_dao.getLectList(store,period);
	//	System.out.println("lect_list.size() : "+list.size());
		
	
			//지점 별 기수값 세팅
			String period="021";
				List<HashMap<String, Object>> list = cust_dao.getLectList(store,period);
				for(int i = 0; i < list.size(); i++)
				{
					
					String subject_cd= Utils.checkNullString(list.get(i).get("SUBJECT_CD")); 
					System.out.println("뽑아낸 강좌 코드 : "+subject_cd);
					
					String day_flag = "";
					if(list.get(i).get("DAY_FLAG") != null) {day_flag = Utils.checkNullString(list.get(i).get("DAY_FLAG"));}
					String cancled_list = "";
					if(list.get(i).get("CANCLED_LIST") != null) {cancled_list = Utils.checkNullString(list.get(i).get("CANCLED_LIST"));}
					String lect_cnt = "";
					if(list.get(i).get("LECT_CNT") != null) {lect_cnt = Utils.checkNullString(list.get(i).get("LECT_CNT"));}
					
					HashMap<String, Object> data = peri_dao.getPeriOne(period, store); 
					List<HashMap<String, Object>> holiList = peri_dao.getHoliday(store, period);
					String cancled_list_peri = "";
					if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
					{
						cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
					}
					String yoil = "";
					if(day_flag.split("")[0].equals("1")){yoil += ",월";}
					if(day_flag.split("")[1].equals("1")){yoil += ",화";}
					if(day_flag.split("")[2].equals("1")){yoil += ",수";}
					if(day_flag.split("")[3].equals("1")){yoil += ",목";}
					if(day_flag.split("")[4].equals("1")){yoil += ",금";}
					if(day_flag.split("")[5].equals("1")){yoil += ",토";}
					if(day_flag.split("")[6].equals("1")){yoil += ",일";}
					yoil = yoil.substring(1, yoil.length());
					final String DATE_PATTERN = "yyyyMMdd";
						String inputStartDate = Utils.checkNullString(list.get(i).get("START_YMD"));
						//String inputStartDate = Utils.checkNullString(data.get("START_YMD"));
						SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
						Date startDate = sdf.parse(inputStartDate);
						ArrayList<String> dates = new ArrayList<String>();
						Date currentDate = startDate;
					
					int z = 0;
					while(true)
					{
						for(int k = 0; k < yoil.split(",").length; k++)
						{
							int we = HolidayUtil.getDayOfWeek(Utils.checkNullString(sdf.format(currentDate)));
							String convWe = "";
							if(we == 1) {convWe = "일";}
							if(we == 2) {convWe = "월";}
							if(we == 3) {convWe = "화";}
							if(we == 4) {convWe = "수";}
							if(we == 5) {convWe = "목";}
							if(we == 6) {convWe = "금";}
							if(we == 7) {convWe = "토";}
							if(convWe.equals(yoil.split(",")[k]))
							{
								//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
								if(cancled_list.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
								{
									dates.add(sdf.format(currentDate));
									z++;
								}
							}
						}
						if (lect_cnt.equals("0")) {
							break;
						}
						
						Calendar c = Calendar.getInstance();
						c.setTime(currentDate);
						c.add(Calendar.DAY_OF_MONTH, 1);
						currentDate = c.getTime();
						if(z == Integer.parseInt(lect_cnt))
						{
							break;
						}
					}
					String start_ymd = dates.get(0);
					String end_ymd = dates.get(dates.size()-1);
					
					for (String dd : dates) 
					{
						System.out.println("강의날짜 : "+dd);
					}
					String dayChk="";
					for (int l = 0; l < Integer.parseInt(lect_cnt); l++) {
						dayChk += Utils.checkNullString(dates.get(l))+"|";
						//dayChk += "X|";
					}
					System.out.println("result : "+dayChk);
					//lect_dao.insAttend(store, period, subject_cd, login_seq,"Y","000000000 ",dayChk,"0");
					lect_dao.uptAttendDayChk(store, period, subject_cd, dayChk);
					
				}
			
		

		return mav;
	}
	
	//강사 마이그레이션
	@RequestMapping("/updateLecr") 
	public ModelAndView updateLecr(HttpServletRequest request) throws ParseException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/updateLecr");
//		String login_store = "03";
		String login_seq = "1810547"; //정혜민대리님꺼
		try
		{
			List<HashMap<String, Object>> lemg_list = lecr_dao.getLemgListAll(); //addr_tx 컬럼에 cus_no, phone_no 컬럼에 store 임시로 넣어둠.
			System.out.println("lemg_list size : "+lemg_list.size());
			if(lemg_list.size() > 0)
			{
				for(int i = 0; i < lemg_list.size(); i++)
				{
					String car_no = Utils.checkNullString(lemg_list.get(i).get("CAR_NO"));
					String cus_no = Utils.checkNullString(lemg_list.get(i).get("ADDR_TX"));
					String store = Utils.checkNullString(lemg_list.get(i).get("PHONE_NO"));
					String lecturer_cd = Utils.checkNullString(lemg_list.get(i).get("LECTURER_CD"));
					String lectmgmt_no = Utils.checkNullString(lemg_list.get(i).get("LECTMGMT_NO"));
					lecr_dao.insLecture(lecturer_cd, cus_no, car_no, "10", "4", "30", "8", "", "", "", "", "", "", "", "52", login_seq, store);
					lecr_dao.upPeltByLecr(lecturer_cd, lectmgmt_no, cus_no);
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return mav;
		
	}
	
	//계약서 마이그레이션
	@RequestMapping("/updateContract") 
	public ModelAndView updateContract(HttpServletRequest request) throws ParseException {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/WEB-INF/pages/updateContract");
		HttpSession session = request.getSession();
		String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
		String[] store= {"03","02","04","05"};                                                      
		String period = "";
		try
		{
			for (int a = 0; a < store.length; a++) {
				
				//지점별 기수 GET
				List<HashMap<String, Object>> periList = lecr_dao.getPeriForContract(store[a]);
				for (int j = 0; j < periList.size(); j++) 
				{
					period = periList.get(j).get("PERIOD").toString();
					//회원 테이블 + 강좌 테이블 join후 cus_no있는 회원만 GET 
					List<HashMap<String, Object>> list = lecr_dao.getPelt(store[a],period); //addr_tx 컬럼에 cus_no 임시로 넣어둠.
					System.out.println("list.size() : "+list.size());
					if(list.size() > 0)
					{
						for(int i = 0; i < list.size(); i++)
						{
							String cus_no = Utils.checkNullString(list.get(i).get("CUS_NO"));
							String subject_cd = Utils.checkNullString(list.get(i).get("SUBJECT_CD"));
							String start_ymd = Utils.checkNullString(list.get(i).get("START_YMD"));
							String end_ymd = Utils.checkNullString(list.get(i).get("END_YMD"));
							String create_date = Utils.checkNullString(list.get(i).get("CREATE_DATE"));
							lecr_dao.insContract(store[a],period,cus_no,subject_cd,start_ymd,end_ymd,login_seq,create_date);
						}
					}
					
					
				}
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return mav;
		
	}
}