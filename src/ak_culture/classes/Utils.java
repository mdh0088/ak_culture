package ak_culture.classes;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.rmi.server.UID;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;

import com.ibm.icu.util.Calendar;

import ak_culture.model.common.CommonDAO;

public class Utils {
	static public boolean isNull(String strTemp)
	{
		if ( strTemp == null || strTemp.trim().length() == 0 )
		{
			return true;
		}
		else
		{
		return false;
		}
	}
	private static String toHex(byte hash[]) {
		StringBuffer buf = new StringBuffer(hash.length * 2);
		for(int i = 0; i < hash.length; i++) {
			int intVal = hash[i] & 0xff;
			if(intVal < 0x10) {
				buf.append("0");
			}
			buf.append(Integer.toHexString(intVal));
		}
		return buf.toString();
	}
	public static String getHashString(String str) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(str.getBytes());
			return toHex(md.digest());
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
			return str;
		}
	}
	
	public static synchronized String checkNullString(Object str) 
	{
		String strTmp;
		try 
		{
			if (str != null && str.toString().length() > 0 && !str.equals("") && !str.equals("null"))
			{
				strTmp = str.toString();
			}
			else
			{
				strTmp = "";
			}
		} 
		catch (Exception e) 
		{
			strTmp = "";
		}
		return strTmp;
	}
	
	public static synchronized int checkNullInt(Object num) 
	{
		int numTmp;
		try 
		{
			if (num != null && num.toString().length() > 0 && !num.equals(""))
			{
				numTmp = Integer.parseInt(num.toString().trim());
			}
			else
			{
				numTmp = 0;
			}
		} 
		catch (Exception e) 
		{
			numTmp = 0;
		}
		return numTmp;
	}
	
	public static String getDateNow(String type)
	{
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String year = (sdf.format(now)).substring(0,4);
		String month = (sdf.format(now)).substring(4,6);
		String day = (sdf.format(now)).substring(6,8);
		
		String ret = "";
		if("year".equals(type))
		{
			ret = year;
		}
		else if("month".equals(type))
		{
			ret = month;
		}
		else if("day".equals(type))
		{
			ret = day;
		}
		return ret;
	} 
	
	public static void setPeriController(ModelAndView mav, CommonDAO common_dao, HttpSession session)
	{
		mav.addObject("year", Utils.getDateNow("year"));
		List<HashMap<String, Object>> perilist = common_dao.getPeriList("", "", "");
		
		String rep_store = "";
		String isBonbu = Utils.checkNullString(session.getAttribute("isBonbu"));
		if("F".equals(isBonbu))
		{
			rep_store = Utils.checkNullString(session.getAttribute("login_rep_store"));
		}
		List<HashMap<String, Object>> branchList = common_dao.getBranch(rep_store); 
		
		mav.addObject("isBonbu", isBonbu);
		mav.addObject("login_rep_store_nm", Utils.checkNullString(session.getAttribute("login_rep_store_nm")));
		mav.addObject("perilist", perilist);
		mav.addObject("branchList", branchList);
	}
	public static void setPeriControllerAll(ModelAndView mav, CommonDAO common_dao, HttpSession session)
	{
		mav.addObject("year", Utils.getDateNow("year"));
		List<HashMap<String, Object>> perilist = common_dao.getPeriList("", "", "");
		
		String isBonbu = Utils.checkNullString(session.getAttribute("isBonbu"));
		List<HashMap<String, Object>> branchList = common_dao.getBranch(""); 
		
		mav.addObject("isBonbu", isBonbu);
		mav.addObject("login_rep_store_nm", Utils.checkNullString(session.getAttribute("login_rep_store_nm")));
		mav.addObject("perilist", perilist);
		mav.addObject("branchList", branchList);
	}
	public static String getClientIP(HttpServletRequest request) {
		System.out.println("X-Forwarded-For : "+request.getHeader("X-Forwarded-For"));
		System.out.println("Proxy-Client-IP : "+request.getHeader("Proxy-Client-IP"));
		System.out.println("WL-Proxy-Client-IP : "+request.getHeader("WL-Proxy-Client-IP"));
		System.out.println("HTTP_CLIENT_IP : "+request.getHeader("HTTP_CLIENT_IP"));
		System.out.println("HTTP_X_FORWARDED_FOR : "+request.getHeader("HTTP_X_FORWARDED_FOR"));
		System.out.println("X-Real-IP : "+request.getHeader("X-Real-IP"));
		System.out.println("X-RealIP : "+request.getHeader("X-RealIP"));
		System.out.println("REMOTE_ADDR : "+request.getHeader("REMOTE_ADDR"));
		System.out.println("default : "+request.getRemoteAddr());
		String ip = null;
		ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-Real-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("X-RealIP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("REMOTE_ADDR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	
	public static String repWord(String buffer) {
		buffer = buffer.replaceAll("&", "&amt;");
		buffer = buffer.replaceAll("<", "&lt;");
		buffer = buffer.replaceAll(">", "&gt;");
		buffer = buffer.replaceAll("\"", "&quot;");
		buffer = buffer.replaceAll("\'", "&#039;");
		buffer = buffer.replaceAll("\n", "<br>");
		return buffer;
	}

	public static String f_setfill_zero(String temp_str, int str_length, String str_flag) {
		int temp_len = 0;
		temp_len = trim(temp_str).length();
		if (trim(temp_str) == null)
			return zero(str_length);
		if (temp_len >= str_length)
			return temp_str.substring(0, str_length);
		if (str_flag == "R")
			return trim(temp_str) + zero(str_length - temp_len);
		else if (str_flag == "L")
			return zero(str_length - temp_len) + trim(temp_str);
		else {
			return temp_str;
		}
	}

	public static String trim(String str) {
		return str.trim();
	}

	public String space(int len) {
		String spaceString = "";
		for (int i = 0; i < len; i++) {
			spaceString = spaceString + " ";
		}
		return spaceString;
	}

	public static String zero(int len) {
		String zeroString = "";
		for (int i = 0; i < len; i++) {
			zeroString = zeroString + "0";
		}
		return zeroString;
	}
	public static String convertFileName(String filename, String uploadPath, int seq) {
		if(!"".equals(filename))
		{
			String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());  //현재시간
			int i = -1;
			i = filename.lastIndexOf("."); // 파일 확장자 위치
			String realFileName = now + seq + filename.substring(i, filename.length()); // 현재시간과 확장자 합치기
			
			File oldFile = new File(uploadPath + filename);
			File newFile = new File(uploadPath + realFileName);
			String upload_nfs = uploadPath.replace("upload", "upload_nfs");
			File copyFile = new File(upload_nfs + realFileName);
			
			oldFile.renameTo(newFile); // 파일명 변경
			
			if (newFile.exists()) { // 파일이 존재 하다면

				File directory = new File(upload_nfs);

				if (!directory.exists())
					directory.mkdirs(); // 해당 경로가 없다면 경로를 만듦니다.

				try {
					copyFile(newFile, copyFile);
				} catch (IOException e) {
					e.printStackTrace();
				} // 파일복사

			}



			
			return realFileName.toString();
		}
		else
		{
			return "";
		}
	}

	public static void copyFile(File file, File mfile) throws IOException {
		InputStream inStream = null;
		OutputStream outStream = null;

		try {
			inStream = new FileInputStream(file); // 원본파일
			outStream = new FileOutputStream(mfile); // 이동시킬 위치

			byte[] buffer = new byte[1024];

			int length;

			while ((length = inStream.read(buffer)) > 0) {
				outStream.write(buffer, 0, length);
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			inStream.close();
			outStream.close();
		}
	}



	public static long calDateBetweenAandB(String date1, String date2) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		// date1, date2 두 날짜를 parse()를 통해 Date형으로 변환.
		Date FirstDate = format.parse(date1);
		Date SecondDate = format.parse(date2);

		// Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화 하고 있다.
		// 연산결과 -950400000. long type 으로 return 된다.
		long calDate = FirstDate.getTime() - SecondDate.getTime();
		// Date.getTime() 은 해당날짜를 기준으로1970년 00:00:00 부터 몇 초가 흘렀는지를 반환해준다.
		// 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나온다.
		long calDateDays = calDate / (24 * 60 * 60 * 1000);
		calDateDays = Math.abs(calDateDays);
		
		return calDateDays;
	}
	
	public static String addDate(String dd, int days) throws ParseException
	{
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		
		Date date = df.parse(dd);
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.DATE, days);
		
		return df.format(cal.getTime());
	}
	
	public static String getMonFlag(String dateString) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		try{
		  date = sdf.parse(dateString);
		}catch(ParseException e){
		}

		Calendar cal = Calendar.getInstance(Locale.KOREA);
		cal.setTime(date);

		cal.add(Calendar.DATE, 2- cal.get(Calendar.DAY_OF_WEEK));
		
		return sdf.format(cal.getTime());
	}
	public static String getSunFlag(String dateString) throws ParseException
	{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Date date = new Date();
		try{
		  date = sdf.parse(dateString);
		}catch(ParseException e){
		}

		Calendar cal = Calendar.getInstance(Locale.KOREA);
		cal.setTime(date);

		cal.add(Calendar.DATE, 2- cal.get(Calendar.DAY_OF_WEEK));
		
		cal.setTime(date);

		cal.add(Calendar.DATE, 8 - cal.get(Calendar.DAY_OF_WEEK));

		return sdf.format(cal.getTime());
	}
	public static String getWeekDays(String inputStartDate, String inputEndDate) throws ParseException {
		final String DATE_PATTERN = "yyyyMMdd";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
		Date startDate = sdf.parse(inputStartDate);
		Date endDate = sdf.parse(inputEndDate);
		ArrayList<String> dates = new ArrayList<String>();
		Date currentDate = startDate;
		while (currentDate.compareTo(endDate) <= 0) {
			dates.add(sdf.format(currentDate));
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
		}
		String ret = "";
		for (String date : dates) {
			ret += date+"|";
		}
		return ret;
	}
	static public String getCurrentDate() {        
        String toDay = null;
        
        java.util.Date date = new java.util.Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        toDay = dateFormat.format(date);
        
        return toDay;
    }
    
    /*************************************************
     * 5. 현재 시간을 가져오는 함수 (서버모듈에서 실행)
     *    ex) getCurrentTime()
     * @param  void
     * @return String nowTime  : 현재시간(시분초 6자리 String)
     *************************************************/
    static public String getCurrentTime() {
        String nowTime = null;
        
        java.util.Date date = new java.util.Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat("HHmmss");
        nowTime = dateFormat.format(date);
        
        return nowTime;
    }
    static public String removeNULL(String str, String init)
 	{
        String result = init;
       
        if (str != null && !str.equals("null") && !str.equals("")){
          result = str.trim();
        }
       
        return result;
 	}
    public static byte[] imageToByteArray (String filePath) throws Exception
    {
    	byte[] returnValue = null;
    	ByteArrayOutputStream baos = null;
    	FileInputStream fis = null;
    	try
    	{
    		baos = new ByteArrayOutputStream();
    		fis = new FileInputStream(filePath);
    		
    		byte[] buf = new byte[1024];
    		int read = 0;
    		
    		while ((read=fis.read(buf, 0, buf.length)) != -1)
    		{
    			baos.write(buf, 0, read);
    		}
    		returnValue = baos.toByteArray();
    		
    	}
    	catch(Exception e)
    	{
    		e.printStackTrace();
    	}
    	finally
    	{
    		if(baos != null)
    		{
    			baos.close();
    		}
    		if(fis != null)
    		{
    			fis.close();
    		}
    	}
    	return returnValue;
    	
    }
    private static int counter = 0;
    private static final String UID = (new UID()).toString().replace(':', '_').replace('-', '_');
    public static String generateUniqueId() {
        int limit = 100000000;
        int current;
        synchronized(NamoMimePart.class) {
            current = counter++;
        }
        String id = Integer.toString(current);
        if(current < limit) {
            id = ("00000000" + id).substring(id.length());
        }
        return "namo_" + UID + "_" + id+".file";
    }
	public static synchronized double checkNullDouble(Object num) 
	{
		double numTmp;
		try 
		{
			if (num != null && num.toString().length() > 0 && !num.equals(""))
			{
				numTmp = Double.parseDouble(num.toString().trim());
			}
			else
			{
				numTmp = 0;
			}
		} 
		catch (Exception e) 
		{
			numTmp = 0;
		}
		return numTmp;
	}

}
