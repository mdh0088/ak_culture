package ak_culture.controller.common;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import ak_culture.classes.HolidayUtil;
import ak_culture.classes.Utils;
import ak_culture.model.basic.PeriDAO;
import ak_culture.model.common.CommonDAO;
import ak_culture.model.member.CustDAO;
import ak_culture.model.member.LectDAO;
import ak_culture.model.member.SmsDAO;
import niceid.comp.CACheck;

@Controller
@RequestMapping("/common/*")

public class CommonController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private SmsDAO sms_dao;
	@Autowired
	private PeriDAO peri_dao;
	@Autowired
	private CommonDAO common_dao;

	@Autowired
	private CustDAO cust_dao;
	@Autowired
	private LectDAO lect_dao;
	@Value("${upload_dir}")
	private String upload_dir;
	@Value("${image_dir}")
	private String image_dir;
	
	@RequestMapping("/getPeriList")
	@ResponseBody
	public List<HashMap<String, Object>> getPeriList(HttpServletRequest request) {
		
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		String selYear = Utils.checkNullString(request.getParameter("selYear"));
		String selSeason = Utils.checkNullString(request.getParameter("selSeason"));
		
		List<HashMap<String, Object>> list = common_dao.getPeriList(selBranch, selYear, selSeason); 
		
	    return list;
	}
	@RequestMapping("/getPeriList2")
	@ResponseBody
	public List<HashMap<String, Object>> getPeriList2(HttpServletRequest request) {
		
		String selPeri = Utils.checkNullString(request.getParameter("selPeri"));
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		
		System.out.println("기영 : "+selPeri);
		System.out.println("기영 : "+selBranch);
		
		List<HashMap<String, Object>> list = common_dao.getPeriList2(selPeri, selBranch); 
		
		return list;
	}
	@RequestMapping("/ckeditor_upload")
	@ResponseBody
	public void ckeditor_upload(HttpServletRequest request, HttpServletResponse resp) throws Exception {
		
		int sizeLimit = 30*1024*1024; //10메가 까지 가능
        String uploadPath = upload_dir+"ckeditor/";
        
        File dir = new File(uploadPath);
		if (!dir.exists()) { // 디렉토리가 존재하지 않으면
			dir.mkdirs(); // 디렉토리 생성
		}
			
        MultipartRequest multi = new MultipartRequest(request, uploadPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
        
        String filename = Utils.convertFileName(Utils.checkNullString(multi.getOriginalFileName("upload")), uploadPath, 1);
        System.out.println("filename : "+filename);
        
        JSONObject json = new JSONObject();
        String fileUrl = image_dir + "ckeditor/"+filename;
        json.put("uploaded", 1);
        json.put("fileName", filename);
        json.put("url", fileUrl);
        System.out.println("fileurl : "+fileUrl);
        
        PrintWriter printWriter = resp.getWriter();
        printWriter.println(json);
	}
	
	@RequestMapping("/getTargetPeriList")
	@ResponseBody
	public List<HashMap<String, Object>> getTargetPeriList(HttpServletRequest request) {
		
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		String selYear = Utils.checkNullString(request.getParameter("selYear"));
		String selSeason = Utils.checkNullString(request.getParameter("selSeason"));
		
		List<HashMap<String, Object>> list = common_dao.getPeriList(selBranch, selYear, selSeason); 
		
	    return list;
	}
	@RequestMapping("/getTargetPeriList2")
	@ResponseBody
	public List<HashMap<String, Object>> getTargetPeriList2(HttpServletRequest request) {
		
		String selPeri = Utils.checkNullString(request.getParameter("selPeri"));
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		
		System.out.println("기영 : "+selPeri);
		System.out.println("기영 : "+selBranch);
		
		List<HashMap<String, Object>> list = common_dao.getPeriList2(selPeri, selBranch); 
		
		return list;
	}
	@RequestMapping("/getSecCd")
	@ResponseBody
	public List<HashMap<String, Object>> getSecCd(HttpServletRequest request) {
		
		String maincd = Utils.checkNullString(request.getParameter("maincd"));
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		
		List<HashMap<String, Object>> list = common_dao.getSecCd(maincd, selBranch);
		
		return list;
	}
	@RequestMapping("/delMainCd")
	@ResponseBody
	public HashMap<String, Object> delMainCd(HttpServletRequest request) {
		
		String maincd = Utils.checkNullString(request.getParameter("maincd"));
		common_dao.delMainCd(maincd);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("isSuc", "success");
		map.put("msg", "저장되었습니다.");
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "대분류 삭제", maincd);
		return map;
	}
	@RequestMapping("/get1Depth")
	@ResponseBody
	public List<HashMap<String, Object>> get1Depth(HttpServletRequest request) {
		
		List<HashMap<String, Object>> list = common_dao.get1Depth();
		return list;
	}
	
	@RequestMapping("/getTargetCustList")
	@ResponseBody
	public List<HashMap<String, Object>> getTargetCustList(HttpServletRequest request) {
		String selBranch = Utils.checkNullString(request.getParameter("selBranch"));
		String year = Utils.checkNullString(request.getParameter("year"));
		String season = Utils.checkNullString(request.getParameter("season"));
		String main_cd = Utils.checkNullString(request.getParameter("main_cd"));
		String sect_cd = Utils.checkNullString(request.getParameter("sect_cd"));
		List<HashMap<String, Object>> list = common_dao.getTargetCustList(selBranch,year,season,main_cd,sect_cd);
	    return list;
	}
	
	@RequestMapping("/getHoliday_byDate")
	@ResponseBody
	public ArrayList<String> getHoliday(HttpServletRequest request) {
		
		String s_date = request.getParameter("s_date").replaceAll("-", "");
		String e_date = request.getParameter("e_date").replaceAll("-", "");
		ArrayList<String> holidayList = HolidayUtil.getHoliday(s_date, e_date);
		
		
	    return holidayList;
	}
	
	@RequestMapping("/getUserByCust")
	@ResponseBody
	public HashMap<String, Object> getUserByCust(HttpServletRequest request) throws UnknownHostException {
		HashMap<String, Object> map = new HashMap<>();
		
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));		
		HashMap<String, Object> cust_info = common_dao.getUserByCust(cust_no); 
		
		
		if (!cust_info.get("STORE").toString().equals("")) {
			List<HashMap<String, Object>> list = cust_dao.getLectInfo(cust_no,cust_info.get("STORE").toString(),"","1","",""); 
			int lect_sum =0;
			int lect_cnt =list.size();
			for (int i = 0; i < list.size(); i++) 
			{
				lect_sum += Integer.parseInt((list.get(i).get("NET_SALE_AMT").toString()));
			}
			map.put("lect_sum", lect_sum);
			map.put("lect_cnt", lect_cnt);
		}
		
		//List<HashMap<String, Object>> custHistory = cust_dao.getCustHistory(cust_no); 

		map.put("list", cust_info);
		//map.put("custHistory", custHistory);
		HttpSession session = request.getSession();
		common_dao.saveManagerLog(Utils.checkNullString(session.getAttribute("login_seq")), "수강관리 회원 조회", cust_no);
		
		
	    return map;
	}
	@RequestMapping("/getUserByAms")
	@ResponseBody
	public List<HashMap<String, Object>> getUserByAms(HttpServletRequest request) {
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		List<HashMap<String, Object>> list = common_dao.getUserByAms(cus_no); 
		return list;
	}

	@RequestMapping("/getUserByMembersCard")
	@ResponseBody
	public HashMap<String, Object> getUserByMembersCard(HttpServletRequest request) {
		
		String cus_no = Utils.checkNullString(request.getParameter("cus_no"));
		HashMap<String, Object> data = common_dao.getUserByMembersCard(cus_no); 
		
		return data;
	}
	@RequestMapping("/getLectSearch")
	@ResponseBody
	public List<HashMap<String, Object>> getLectSearch(HttpServletRequest request) {
		
		String searchVal = Utils.checkNullString(request.getParameter("searchVal"));
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String order_by = Utils.checkNullString(request.getParameter("order_by"));
		String sort_type = Utils.checkNullString(request.getParameter("sort_type"));
		List<HashMap<String, Object>> list = common_dao.getLectSearch(order_by, sort_type, searchVal, store, period, subject_cd); 
		
		return list;
	}
	@RequestMapping("/getPeltBySubjectCd")
	@ResponseBody
	public List<HashMap<String, Object>> getPeltBySubjectCd(HttpServletRequest request) {
		
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		if(!"".equals(subject_cd))
		{
			subject_cd = subject_cd.substring(0, subject_cd.length()-1);
			subject_cd = subject_cd.replaceAll("\\|", "','");
		}
		subject_cd = "'"+subject_cd+"'";
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		List<HashMap<String, Object>> list = common_dao.getPeltBySubjectCd(store, period, subject_cd); 
		return list;
	}
	@RequestMapping("/isFullPeltByCust")
	@ResponseBody
	public HashMap<String, Object> isFullPeltByCust(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		HashMap<String, Object> data = common_dao.isFullPeltByCust(store, period, subject_cd); 
		return data;
	}
	@RequestMapping("/isInPeltByCust")
	@ResponseBody
	public HashMap<String, Object> isInPeltByCust(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String child_no1 = Utils.checkNullString(request.getParameter("child_no1"));
		HashMap<String, Object> data = common_dao.isInPeltByCust(store, period, subject_cd, cust_no, child_no1); 
		return data;
	}
	@RequestMapping("/isPartPayByCust")
	@ResponseBody
	public HashMap<String, Object> isPartPayByCust(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		HashMap<String, Object> data = common_dao.isPartPayByCust(store, period, subject_cd, cust_no); 
		return data;
	}
	
	@RequestMapping("/getPosList")
	@ResponseBody
	public List<HashMap<String, Object>> getPosList(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		List<HashMap<String, Object>> list = common_dao.getPosList(store); 
		
		return list;
	}
	@RequestMapping("/getPeltBySect")
	@ResponseBody
	public List<HashMap<String, Object>> getPeltBySect(HttpServletRequest request) {
		
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String sect_cd = Utils.checkNullString(request.getParameter("sectcd"));
		String main_cd = Utils.checkNullString(request.getParameter("maincd"));
		List<HashMap<String, Object>> list = common_dao.getPeltBySect(store, period, main_cd, sect_cd); 
		
		return list;
	}
	
	@RequestMapping("/getPeltBySectForTm")
	@ResponseBody
	public List<HashMap<String, Object>> getPeltBySectForTm(HttpServletRequest request) {

		String store = Utils.checkNullString(request.getParameter("store"));
		String year = Utils.checkNullString(request.getParameter("year"));
		String season = Utils.checkNullString(request.getParameter("season"));

		String sect_cd = Utils.checkNullString(request.getParameter("sectcd"));
		String main_cd = Utils.checkNullString(request.getParameter("maincd"));
		
		List<HashMap<String, Object>> branchList = null;
		List<HashMap<String, Object>> list = null;
		String period = "";
		
		System.out.println("period : "+period);
		
		branchList = common_dao.getPeriList(store, year, season);
		System.out.println("branchList : "+branchList.size());
		if(branchList.size() > 0)
		{
			period = Utils.checkNullString(branchList.get(branchList.size()-1).get("PERIOD"));
			list = common_dao.getPeltBySect(store, period, main_cd, sect_cd); 
		}

		return list;
	}
	
	
	@RequestMapping("/setBookmark")
	@ResponseBody
	public HashMap<String, Object> setBookmark(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		String act = Utils.checkNullString(request.getParameter("act"));
		String link = Utils.checkNullString(request.getParameter("link"));
		String tit = Utils.checkNullString(request.getParameter("tit"));
		
		
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	    try
	    {
	    	List<HashMap<String, Object>> list = common_dao.getBookmark(login_seq);
	    	if("on".equals(act))
	    	{
	    		if(list.size() > 0)
	    		{
	    			String convLink = Utils.checkNullString(list.get(0).get("BOOKMARK")) + link+"|";
	    			String convTit = Utils.checkNullString(list.get(0).get("TITLE")) + tit+"|";
	    			common_dao.upBookmark(login_seq, convLink, convTit);
	    		}
	    		else
	    		{
	    			common_dao.insBookmark(login_seq, link+"|", tit+"|");
	    		}
	    	}
	    	else
	    	{
	    		String convLink = Utils.checkNullString(list.get(0).get("BOOKMARK"));
	    		convLink = convLink.replaceAll(link+"\\|", "");
	    		String convTit = Utils.checkNullString(list.get(0).get("TITLE"));
	    		convTit = convTit.replaceAll(tit+"\\|", "");
	    		common_dao.upBookmark(login_seq, convLink, convTit);
	    	}
	    	map.put("isSuc", "success");
	    }
	    catch(Exception e)
		{
			map.put("isSuc", "fail");
			map.put("msg", "알 수 없는 오류 발생");
			e.printStackTrace();
		}
	    return map;
	}
		
	@RequestMapping("/getBookmark")
	@ResponseBody
	public List<HashMap<String, Object>> getBookmark(HttpServletRequest request) {
		
		
		HttpSession session = request.getSession();
	    String login_seq = Utils.checkNullString(session.getAttribute("login_seq"));
	    List<HashMap<String, Object>> list = common_dao.getBookmark(login_seq);
		
		return list;
	}
	@RequestMapping("/coocon_api")
	@ResponseBody
	public HashMap<String, Object> coocon_api(HttpServletRequest request, HttpServletResponse response) throws IOException, NoSuchAlgorithmException, KeyManagementException {
		String JSONDataVal = request.getParameter("JSONData");
		TrustManager[] trustAllCerts = new TrustManager[] { new X509TrustManager() {
			public java.security.cert.X509Certificate[] getAcceptedIssuers() { return null; }
			public void checkClientTrusted(X509Certificate[] certs, String authType) { }
			public void checkServerTrusted(X509Certificate[] certs, String authType) { }
			}
		};
		// Create all-trusting host name verifier
		HostnameVerifier allHostsValid = new HostnameVerifier() {
			public boolean verify(String hostname, SSLSession session) { return true; }
		};

		SSLContext sc = SSLContext.getInstance("SSL");
		sc.init(null, trustAllCerts, new java.security.SecureRandom());
		HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
		HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);

		String url = "https://gw.coocon.co.kr/sol/gateway/acctnm_rcms_wapi.jsp";	// API 개발주소

		byte[] resMessage = null;
		
		HttpURLConnection conn;

		try {
			conn = (HttpURLConnection) new URL(url).openConnection();
			conn.setDoInput(true);
			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setUseCaches(false);
			OutputStreamWriter os = new OutputStreamWriter(conn.getOutputStream());

			String postString = "JSONData="+JSONDataVal;
			os.write(postString);
			os.flush();
			os.close();
			
			DataInputStream in = new DataInputStream(conn.getInputStream());
			ByteArrayOutputStream bout = new ByteArrayOutputStream();
			
			int bcount = 0;
			byte[] buf = new byte[2048];
			while (true) {
			int n = in.read(buf);
			if (n == -1) break;
				bout.write(buf, 0, n);
			}
			bout.flush();
			resMessage = bout.toByteArray();
			conn.disconnect();
		}
		catch (MalformedURLException e) {
			System.out.println("MalformedURLException");
		}
		catch (IOException e) {
			e.printStackTrace();
		}
		HashMap<String, Object> mav = new HashMap<>(); 
		//결과처리
		String temp = new String(resMessage, "euc-kr");
		temp = temp.replaceAll("\r\n","");
		temp = temp.replaceAll("\r","");
		temp = temp.replaceAll("\n","");
		System.out.println(temp);
		System.out.println(temp.trim());
		mav.put("res", temp.trim());
		return mav;
	}
	@RequestMapping("/nice_api")
	@ResponseBody
	public HashMap<String, Object> nice_api(HttpServletRequest request, HttpServletResponse response){
		HashMap<String, Object> mav = new HashMap<>();
		String gubun = Utils.checkNullString(request.getParameter("gubun"));
		String reqNum = Utils.checkNullString(request.getParameter("reqNum"));
		System.out.println("A: 사업자번호, B: 법인번호" + gubun);
		System.out.println("데이터: " + reqNum);
		// Request
	    CACheck caComp = new CACheck();
	    int iReturn = -1;

	    //iReturn = caComp.fnRequest("사이트코드", "사이트비밀번호", "요청구분", "사업자번호", "법인번호", "사업자/법인명", "대표자명");
	    //인자값은 요청구분과 관계없이 NULL 이외의 값을 입력해주세요.(매뉴얼 참조) 
		//ex) caComp.fnRequest("사이트코드", "사이트비밀번호", "1", "1168102001", "0000000000000", "nice", "test");
	    if(gubun.equals("B")){
	    	iReturn = caComp.fnRequest("EY06", "43460599", "B", "0000000000", reqNum, "", "");
	    }else{
	    	iReturn = caComp.fnRequest("EY06", "43460599", "A", reqNum, "0000000000000", "", "");
	    }
	   
	    String isSuc = "";
	    String msg = "";
	    if( iReturn == 0 ) 
	    {
	    	List<String> fail_arr = Arrays.asList("02", "03", "05", "12", "13", "22", "23");
	    	String retCode = caComp.getReturnCode();
	        String statCode = caComp.getStatusCode();
	        if(retCode.equals("01"))
	        {
	        	isSuc = "success";
	        	switch(statCode) {
	        		case "0": msg="정보없음"; break;
	        		case "1": msg="정상"; break;
	        		case "6": msg="부도"; break;
	        		case "7": msg="휴업"; break;
	        		case "8": msg="폐업"; break;
	        		case "9": msg="기타"; break;
	        	}
	        	mav.put("compName", caComp.getReturnCompName());	// 응답 기업명
	        	mav.put("repName", caComp.getReturnRepName());		// 응답 대표자명
	        }
	        else if(fail_arr.contains(retCode))
	        {
	        	isSuc = "failed";
	        	msg = "실패";
	        }
	        else if(!retCode.equals("01") && !fail_arr.contains(retCode))
	        {
	        	isSuc = "fatal";
	        	msg = "시스템 에러";
	        }
	        
	        System.out.println("RETURN_CODE=" + caComp.getReturnCode());    		// 인증결과코드
	        System.out.println("STATUS_CODE=" + caComp.getStatusCode());    		// 기업상태코드
	        System.out.println("RETURN_COMPNAME=" + caComp.getReturnCompName());  	// 응답 기업명
	        System.out.println("RETURN_REPNAME=" + caComp.getReturnRepName());    	// 응답 대표자명
	    }
	    else 
	    {
	        isSuc = "fatal";
	        msg = "시스템 에러";
	        mav.put("errCode", iReturn);
	        
	        System.out.println("AUTH_ERROR=" + iReturn);
	    }
	    mav.put("isSuc", isSuc);
	    mav.put("msg", msg);
		return mav;
	}
	@RequestMapping("/getEncdList")
	@ResponseBody
	public HashMap<String, Object> getEncdList(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<>();
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		String cust_no = Utils.checkNullString(request.getParameter("cust_no"));
		String subject_cd = Utils.checkNullString(request.getParameter("subject_cd"));
		String enuri_yn = lect_dao.getisEncdYN(store,period,subject_cd);
		String grade= Utils.checkNullString(request.getParameter("grade"));
		
		if("Y".equals(enuri_yn))
		{
			map.put("isSuc", "success");
			HashMap<String, Object> data = lect_dao.getCustGrade(cust_no);
			if (data !=null) 
			{
				
				List<HashMap<String, Object>> list = lect_dao.getEncdList(store,period,cust_no,subject_cd,Utils.checkNullString(data.get("CLASS")),Utils.checkNullString(data.get("AK_CLASS")));
				map.put("list", list);
			}
			else
			{
				map.put("isSuc", "fail");
				map.put("msg", "고객 등급 정보를 가져오지 못합니다 관리자에게 문의해주세요.");	
			}
		}
		else
		{
			map.put("isSuc", "fail");
			map.put("msg", "할인이 불가한 강좌입니다.");
		}
		return map;
	}
	
	@RequestMapping("/single_send_sms")
	@ResponseBody
	public HashMap<String, Object> single_send_sms(HttpServletRequest request) throws Exception {
		HashMap<String, Object> map = new HashMap<>();
		
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = common_dao.retrievePeriod(store);
		String send_phone_no = "82"+""+Utils.checkNullString(request.getParameter("phone_no")).substring(1);
		String phone_no = Utils.checkNullString(request.getParameter("phone_no"));
		
		String title = Utils.checkNullString(request.getParameter("title"));
		String msg = Utils.checkNullString(request.getParameter("msg"));
		//msg = Utils.repWord(msg);
		
		System.out.println("store : "+store);
		System.out.println("period : "+period);
		System.out.println("phone_no : "+phone_no);
		System.out.println("title : "+title);
		System.out.println("msg : "+msg);
		
		HttpSession session = request.getSession();
		String create_resi_no = Utils.checkNullString(session.getAttribute("login_seq"));
		
		String sms_sender="";
		if (store.equals("03")) 
		{
			sms_sender="0317793810";
		}
		else if (store.equals("02")) 
		{
			sms_sender="0312400521";
		}
		else if (store.equals("04")) 
		{
			sms_sender="0316151050";
		}
		else if (store.equals("05")) 
		{
			sms_sender="0338115001";
		}
		
		String p1 = phone_no.substring(0,3);
		String p2 = phone_no.substring(3,7);
		String p3 = phone_no.substring(7,11);
		
		Boolean phone_chk = common_dao.isVaildCell(p1, p2, p3);
		if (phone_chk==false)
        {
			map.put("isSuc", "fail");
			map.put("msg", "유효하지 않은 전화번호입니다.");
			return map;
		}
		
		try {
			
			JSONParser jsonParse = new JSONParser();
			JSONObject jsonObj = new JSONObject();
			
			String returnText = getAuthToken(request); //토큰 발급
			jsonObj = (JSONObject) jsonParse.parse(returnText);		
	
	        request.setAttribute("accessToken", Utils.checkNullString(jsonObj.get("accessToken")));
	        request.setAttribute("schema", Utils.checkNullString(jsonObj.get("schema")));
	        request.setAttribute("cust_phone_num", send_phone_no);
	        request.setAttribute("message", new String(msg.getBytes("euc-kr"),"euc-kr"));
	        request.setAttribute("store_no", sms_sender);
	        
	        sendSms(request);	//전송부
	        
			int sms_seq = sms_dao.insSms("2",sms_sender,"6",title,create_resi_no,Utils.repWord(msg),store,period);
			//sms_dao.insSmsList("","2",sms_sender,msg,create_resi_no,sms_seq,"S",phone_no);
		
			map.put("isSuc", "success");
			map.put("msg", "저장되었습니다.");
		} catch (Exception e) {
			map.put("isSuc", "fail");
			map.put("msg", "전송실패");
		}
		
		return map;
	}
	

	
	@RequestMapping(value = "/sendCooconApi", produces = "application/text; charset=utf8")
	@ResponseBody
	public String sendCooconApi(HttpServletRequest request) {
		
		String bank_cd = Utils.checkNullString(request.getParameter("bank_cd"));
		String search_acct_no = Utils.checkNullString(request.getParameter("search_acct_no"));
		double ran = Math.random();
		String trsc_seq_no = Integer.toString((int)(ran*999999));
		
		//https://gw.coocon.co.kr/sol/gateway/acctnm_rcms_wapi.jsp?JSONData={"SECR_KEY":"26ITwrC3lVJCeh3XeBYr","KEY":"ACCTNM_RCMS_WAPI","REQ_DATA":[{"BANK_CD":"020","SEARCH_ACCT_NO":"1002932315913","ACNM_NO":"","ICHE_AMT":"0","TRSC_SEQ_NO":"1231236"}]}

		String targetUrl = "http://10.10.11.70:5001/coocon/sendCooconApi?";
		targetUrl += "api_key=parknoeun";
		targetUrl += "&BANK_CD="+bank_cd;
		targetUrl += "&ACNM_NO=";
		targetUrl += "&SEARCH_ACCT_NO="+search_acct_no;
		targetUrl += "&TRSC_SEQ_NO="+"1"+trsc_seq_no;
		URL url = null;
		HttpURLConnection conn = null;
		String jsonData = "";
		BufferedReader br = null;
		StringBuffer sb = null;
		String returnText = "";

		try {
			url = new URL(targetUrl);

			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Accept", "application/json");
			conn.setRequestMethod("GET");
			conn.connect();

			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));

			sb = new StringBuffer();

			while ((jsonData = br.readLine()) != null) {
				sb.append(jsonData);
			}

			returnText = sb.toString();

		} catch (IOException e) {
			e.printStackTrace();
			return "{\"RSLT_CD\":\"-1\"}";
		} finally {
			try {
				if (br != null)
					br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return returnText;
	}
	
	
	@RequestMapping(value = "/sendComplus", produces = "application/text; charset=utf8")
	@ResponseBody
	public String sendComplus(HttpServletRequest request) {
		
		String biz_no = Utils.checkNullString(request.getParameter("biz_no"));
		
		String targetUrl = "http://10.10.11.70:5001/nice/sendComplus?";
		targetUrl += "api_key=parknoeun";
		targetUrl += "&SAUP_NUMBER="+biz_no;
		URL url = null;
		HttpURLConnection conn = null;
		String jsonData = "";
		BufferedReader br = null;
		StringBuffer sb = null;
		String returnText = "";
		
		try {
			url = new URL(targetUrl);
			
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Accept", "application/json");
			conn.setRequestMethod("GET");
			conn.connect();
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			sb = new StringBuffer();
			
			while ((jsonData = br.readLine()) != null) {
				sb.append(jsonData);
			}
			
			returnText = sb.toString();
			
		} catch (IOException e) {
			e.printStackTrace();
			return "{\"RESULT_CODE\":\"-1\"}";
		} finally {
			try {
				if (br != null)
					br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println("returnText : "+returnText);
		return returnText;
	}
	
	
	@RequestMapping(value = "/getAuthToken", produces = "application/text; charset=utf8")
	@ResponseBody
	public String getAuthToken(HttpServletRequest request) {
		
		String store = Utils.checkNullString(request.getParameter("store"));
		
		String targetUrl = "http://10.10.11.70:5001/sms/getAuthToken?";
		targetUrl += "api_key=parknoeun";
		targetUrl += "&store="+store;
		URL url = null;
		HttpURLConnection conn = null;
		String jsonData = "";
		BufferedReader br = null;
		StringBuffer sb = null;
		String returnText = "";
		
		try {
			url = new URL(targetUrl);
			
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Accept", "application/json");
			conn.setRequestMethod("GET");
			conn.connect();
			
			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			
			sb = new StringBuffer();
			
			while ((jsonData = br.readLine()) != null) {
				sb.append(jsonData);
			}
			
			returnText = sb.toString();
			
		} catch (IOException e) {
			e.printStackTrace();
			return "{\"RESULT_CODE\":\"-1\"}";
		} finally {
			try {
				if (br != null)
					br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		System.out.println("returnText : "+returnText);
		return returnText;
	}	
	
	@RequestMapping(value = "/sendSms", produces = "application/text; charset=euc-kr")
	@ResponseBody
	public String sendSms(HttpServletRequest request){
		
		String accessToken = Utils.checkNullString(request.getAttribute("accessToken"));
		String schema = Utils.checkNullString(request.getAttribute("schema"));
		String from = Utils.checkNullString(request.getAttribute("store_no"));
		String to = Utils.checkNullString(request.getAttribute("cust_phone_num"));
		String title = Utils.checkNullString(request.getAttribute("title"));
		String text = Utils.checkNullString(request.getAttribute("message"));
		String authToken = accessToken;
		JSONObject jo1 = new JSONObject();
		String jsonData = "";
		BufferedReader br = null;
		StringBuffer sb = null;
		String returnText = "";
		String result="";
		jo1.put("authToken", authToken);
		jo1.put("from", from);
		jo1.put("title", title);
		jo1.put("text", text);
		jo1.put("ref", "");
		jo1.put("ttl", 100);
		
		JSONArray ja = new JSONArray();
		JSONObject jo2 = new JSONObject();
		jo2.put("to", to);
		ja.add(jo2);

		jo1.put("destinations", ja);
		
		System.out.println(jo1.toJSONString());
		
		try {
			URL url = new URL("http://10.10.11.70:5001/sms/sendSms?api_key=parknoeun"); // 호출할 url
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			
			conn.setDoOutput(true);
			conn.setRequestProperty("Accept", "application/json");
	        conn.setRequestProperty("content-type", "application/json");
	        conn.setRequestMethod("POST");
	        OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
	        wr.write(Utils.checkNullString(jo1));
	        wr.flush();
	        conn.connect();
	        
	        
			
	        br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	        sb = new StringBuffer();
	        System.out.println("br : "+br);
	        String temp="";
	        while ((jsonData = br.readLine()) != null) {
	            sb.append(jsonData);
	            
	            System.out.println("jsonData :"+jsonData);
	            temp=jsonData;
	            System.out.println("jsonData :"+jsonData.getClass().getName());
	        }
	        
	        System.out.println("temp :"+temp);
	        
            if (temp.indexOf("Request failed with status code 400") != -1) {result =  "ERROR"; }
	        else if(temp.indexOf("R000") != -1) {result =  "R000";}
	        else if(temp.indexOf("R001") != -1) {result =  "R001";}
	        else if(temp.indexOf("R002") != -1) {result =  "R002";}
	        else if(temp.indexOf("R003") != -1) {result =  "R003";}
	        else if(temp.indexOf("R007") != -1) {result =  "R007";}
	        else if(temp.indexOf("R009") != -1) {result =  "R009";}
	        else if(temp.indexOf("R012") != -1) {result =  "R012";}
	        else if(temp.indexOf("R013") != -1) {result =  "R013";}
	        else if(temp.indexOf("R999") != -1) {result =  "R999";}
	        else if(temp.indexOf("R102") != -1) {result =  "R102";}
	        else if(temp.indexOf("R103") != -1) {result =  "R103";}
	        else{result =  "ERROR";}
	        
		} catch (IOException e) {
			System.out.println("sendSms 전송에 실패했습니다.");
			e.printStackTrace();
			result =  "F";
			
		} 
		return result;
		
	}
	@RequestMapping("/BACust0101_S01")
	@ResponseBody
	public List<HashMap<String, Object>> BACust0101_S01(HttpServletRequest request) {
		
		String val = Utils.checkNullString(request.getParameter("val"));
		
		List<HashMap<String, Object>> list = common_dao.BACust0101_S01(val);
		
	    return list;
	}
	
	@RequestMapping("/get_AMS_info_by_tel")
	@ResponseBody
	public HashMap<String, Object> get_AMS_info_by_tel(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String val = Utils.checkNullString(request.getParameter("val"));
		boolean culture_chk =false;
		boolean member_chk=false;
		String cus_no="";
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		int result=0;
		
		
		System.out.println("store : "+store);
		System.out.println("period : "+period);
		
		List<HashMap<String, Object>> get_culture_info = common_dao.BACust0101_S01(val);
		if (get_culture_info.size() > 0) 
		{
			culture_chk = true;
		}
		
		List<HashMap<String, Object>> get_member_info= common_dao.get_AMS_info_by_tel(val);
		if (get_member_info.size() > 0) 
		{
			member_chk = true;
			cus_no = get_member_info.get(0).get("CUS_NO").toString();
		}
		
		if (member_chk==true && culture_chk==true) 
		{
			map.put("isSuc", "success");
			map.put("msg", "통헙된 회원입니다.");
			map.put("cus_no", cus_no);
		}
		//멤버스에는 있고 문화에는 없다면 -> 통합 대상
		else if (member_chk==true && culture_chk==false) 
		{
			result = common_dao.addToculture(cus_no,store,period);
			if (result > 0) 
			{
				map.put("isSuc", "success");
				map.put("msg", "등록 되었습니다.");
				map.put("cus_no", cus_no);
			}
		}
		else if (member_chk==false) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "회원 정보가 존재하지 않습니다. 담당자에게 문의하세요.");
		}
		
		
		
	    return map;
	}
	
	@RequestMapping("/get_AMS_info_by_cus_no")
	@ResponseBody
	public HashMap<String, Object> get_AMS_info_by_cus_no(HttpServletRequest request) {
		HashMap<String, Object> map = new HashMap<>();
		
		String val = Utils.checkNullString(request.getParameter("val"));
		boolean culture_chk =false;
		boolean member_chk=false;
		String cus_no="";
		String store = Utils.checkNullString(request.getParameter("store"));
		String period = Utils.checkNullString(request.getParameter("period"));
		int result=0;
		
		
		System.out.println("store : "+store);
		System.out.println("period : "+period);
		
		List<HashMap<String, Object>> get_culture_info = common_dao.BACust0101_S02(val);
		if (get_culture_info.size() > 0) 
		{
			culture_chk = true;
		}
		
		List<HashMap<String, Object>> get_member_info= common_dao.get_AMS_info_by_cus_no(val);
		if (get_member_info.size() > 0) 
		{
			member_chk = true;
			cus_no = get_member_info.get(0).get("CUS_NO").toString();
		}
		
		if (member_chk==true && culture_chk==true) 
		{
			map.put("isSuc", "success");
			map.put("msg", "통합된 회원입니다.");
			map.put("cus_no", cus_no);
		}
		//멤버스에는 있고 문화에는 없다면 -> 통합 대상
		else if (member_chk==true && culture_chk==false) 
		{
			result = common_dao.addToculture(cus_no,store,period);
			if (result > 0) 
			{
				map.put("isSuc", "success");
				map.put("msg", "등록 되었습니다.");
				map.put("cus_no", cus_no);
			}
		}
		else if (member_chk==false) 
		{
			map.put("isSuc", "fail");
			map.put("msg", "회원 정보가 존재하지 않습니다. 담당자에게 문의하세요.");
		}
		
		
		
	    return map;
	}
	@RequestMapping("/getChangeByLeader")
	@ResponseBody
	public List<HashMap<String, Object>> getChangeByLeader(HttpServletRequest request) {
		
		List<HashMap<String, Object>> list = common_dao.getChangeByLeader(); 
		
		return list;
	}
}
