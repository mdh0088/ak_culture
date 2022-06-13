package ak_culture.controller.api;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import ak_culture.classes.HolidayUtil;
import ak_culture.classes.Utils;
import ak_culture.model.api.ApiDAO;

@Controller
@RequestMapping("/api/*")
public class ApiController {
	
	
	@Autowired
	private ApiDAO api_dao;
	
	@Autowired
	private ak_culture.model.lecture.LectDAO llect_dao;
	
	@RequestMapping("/insAttend")
	public ModelAndView insAttend(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/api/insAttend");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String cust1 = Utils.checkNullString(request.getParameter("cust1"));
		String cust2 = Utils.checkNullString(request.getParameter("cust2"));
		String cust3 = Utils.checkNullString(request.getParameter("cust3"));
		String p_cust = "";
		String c_cust1 = "";
		String c_cust2 = "";
		if(cust1.length() > 3) 
		{
			p_cust = cust1;
			c_cust1 = cust2;
			c_cust2 = cust3;
		}
		else
		{
			c_cust1 = cust1;
			c_cust2 = cust2;
		}
		try
		{
			HashMap<String, Object> data = api_dao.getAttendInfo(store,period,subject_cd);
			if (data!=null) 
			{
				String dayChk[] = Utils.checkNullString(data.get("DAY_CHK")).split("\\|");
				String dayVal ="";
				for (int j = 0; j < dayChk.length; j++) 
				{
					dayVal+="X|";
				}
				int cnt = api_dao.insAttend(store,period,subject_cd, "mobile","N",cust_no,dayVal, p_cust, c_cust1, c_cust2);
				if(cnt > 0)
				{
					mav.addObject("result", "success");
					mav.addObject("msg", "성공");
				}
				else
				{
					mav.addObject("result", "fail");
					mav.addObject("msg", "출석부 생성 실패");
				}
			}
			else
			{
				mav.addObject("result", "fail");
				mav.addObject("msg", "강좌가 정상적으로 생성되지 않았습니다.");
			}
		}
		catch(Exception e)
		{
			mav.addObject("result", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생");
			e.printStackTrace();
		}
		
		return mav;
	}
	@RequestMapping("/getEncdList")
	public ModelAndView getEncdList(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/api/getEncdList");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		try
		{
			
			List<HashMap<String, Object>> list;
			if (cust_no.equals("")) 
			{
				list = api_dao.getEncdList2(store,period);
			}
			else
			{				
				list = api_dao.getEncdList(store,period,cust_no,subject_cd);
			}
			
			ObjectMapper mapper = new ObjectMapper(); String jsonList=""; 
			jsonList = mapper.writeValueAsString(list);
			mav.addObject("result", "success");
			mav.addObject("msg", "성공");
			mav.addObject("items", jsonList);
			
			

		}
		catch(Exception e)
		{
			mav.addObject("result", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생");
			mav.addObject("items", "[]");
			e.printStackTrace();
		}
		
		return mav;
	}
	@RequestMapping("/getHalfPaymentPrice")
	public ModelAndView getHalfPaymentPrice(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(); 
		mav.setViewName("/WEB-INF/pages/api/getHalfPaymentPrice");
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		
		String half_regis_fee = ""; 
		String half_food_amt = ""; 
		try
		{
			List<HashMap<String, Object>> list = llect_dao.getPeltMid(store, period, subject_cd);
			
			String yoil = "";
			String day_flag = Utils.checkNullString(list.get(0).get("DAY_FLAG"));
			if(day_flag.split("")[0].equals("1")){yoil += ",월";}
			if(day_flag.split("")[1].equals("1")){yoil += ",화";}
			if(day_flag.split("")[2].equals("1")){yoil += ",수";}
			if(day_flag.split("")[3].equals("1")){yoil += ",목";}
			if(day_flag.split("")[4].equals("1")){yoil += ",금";}
			if(day_flag.split("")[5].equals("1")){yoil += ",토";}
			if(day_flag.split("")[6].equals("1")){yoil += ",일";}
			yoil = yoil.substring(1, yoil.length());
			
			List<HashMap<String, Object>> holiList = api_dao.getHoliday(store, period);
			String cancled_list_pelt = "";
			String cancled_list_peri = "";
			if(list.size() > 0 && list.get(0).get("CANCLED_LIST") != null)
			{
				cancled_list_pelt = Utils.checkNullString(list.get(0).get("CANCLED_LIST")).replaceAll("-", "");
			}
			if(holiList.size() > 0 && holiList.get(0).get("CANCLED_LIST") != null)
			{
				cancled_list_peri = Utils.checkNullString(holiList.get(0).get("CANCLED_LIST"));
			}
			
			final String DATE_PATTERN = "yyyyMMdd";
			String inputStartDate = Utils.checkNullString(list.get(0).get("START_YMD"));
			String inputEndDate = Utils.getCurrentDate();
			
			SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
			Date startDate = sdf.parse(inputStartDate);
			Date endDate = sdf.parse(inputEndDate);
			ArrayList<String> dates = new ArrayList<String>();
			Date currentDate = startDate;
			
			while (currentDate.compareTo(endDate) <= 0) 
			{
				for(int j = 0; j < yoil.split(",").length; j++)
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
					if(convWe.equals(yoil.split(",")[j]))
					{
						//기수 휴강일 제외, 강좌 휴강일 제외, 오늘날짜 제외
						if(cancled_list_pelt.indexOf(sdf.format(currentDate)) == -1 && cancled_list_peri.indexOf(sdf.format(currentDate)) == -1)
						{
							dates.add(sdf.format(currentDate));
						}
					}
				}
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}
			
			//강의료 계산
			int regis_fee = Utils.checkNullInt(list.get(0).get("REGIS_FEE"));
			int food_amt = 0;
			if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
			{
				food_amt = Utils.checkNullInt(list.get(0).get("FOOD_AMT"));
			}
			int lect_cnt = Utils.checkNullInt(list.get(0).get("LECT_CNT"));
			int mid_regis_fee = (int) Math.round((double)regis_fee / lect_cnt * dates.size());
			mid_regis_fee = (mid_regis_fee + 5)/10 * 10; //일의자리 반올림하기위함 
			
			
			int mid_food_amt = 0;
			if("Y".equals(Utils.checkNullString(list.get(0).get("FOOD_YN"))))
			{
				mid_food_amt = (int) Math.round((double)food_amt / lect_cnt * dates.size());
				mid_food_amt = (mid_food_amt + 5)/10 * 10; //일의자리 반올림하기위함 
			}
			
			half_regis_fee += mid_regis_fee;
			half_food_amt += mid_food_amt;
			
			
			mav.addObject("result", "success");
			mav.addObject("msg", "성공");
			mav.addObject("regis_fee", half_regis_fee);
			mav.addObject("food_amt", half_food_amt);
			
		}
		catch(Exception e)
		{
			mav.addObject("result", "fail");
			mav.addObject("msg", "알 수 없는 오류 발생");
			mav.addObject("regis_fee", "");
			mav.addObject("food_amt", "");
			e.printStackTrace();
		}
		
		return mav;
	}

}