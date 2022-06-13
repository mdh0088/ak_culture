package ak_culture.classes;

import java.io.PrintWriter;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import ak_culture.model.common.AuthDAO;

public class Interceptor extends HandlerInterceptorAdapter{
	@Autowired
	private AuthDAO auth_dao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{
		response.setContentType("text/html; charset=UTF-8");
//		HttpSession session = request.getSession();
//		String seq_no = Utils.checkNullString(session.getAttribute("login_seq"));
//		System.out.println("seq_no : "+seq_no);
//		String chk_admin = Utils.checkNullString(session.getAttribute("login_id"));
//		System.out.println("chk_admin : "+chk_admin);
//		String auth_chk = Utils.checkNullString(request.getParameter("auth_chk"));
//		System.out.println("auth_chk : "+auth_chk);
//		String isLeader = Utils.checkNullString(session.getAttribute("isLeader"));
//		String refererURI = "";	//요청전 uri
//		try {
//			refererURI = (new URI(request.getHeader("referer")).getPath());
//		} catch (Exception e) {
//			refererURI = "";
//		}
//		System.out.println("refererURI : "+refererURI);
//		String query_uri = Utils.checkNullString(request.getRequestURI());	//요청할 uri
//		System.out.println("query_uri : "+query_uri);
//		System.out.println(query_uri);
//		
//		if(seq_no.equals("") || chk_admin.equals("admin")) {
//			return true;
//		}
//		
//		Boolean result = false;
//		if(query_uri.indexOf("login") > -1 || query_uri.indexOf("logout") > -1 || query_uri.indexOf("/main") > -1) {
//			return true;
//		}
//		
//		if(query_uri.indexOf("change_master") > -1 && "T".equals(isLeader)) { //팀장권한을 가진사람이 강사료기준변경 팀장페이지로 간다면 true
//			return true;
//		}
//		
//		List<HashMap<String, Object>> authList = auth_dao.getAuth(seq_no);
//		//주소 목록
//		ArrayList<String> authArr = new ArrayList<>();
//		for(int i = 0; i < authList.size(); i++) {
//			authArr.add(Utils.checkNullString(authList.get(i).get("AUTH_URI")));
//		}
//		//권한값
//		HashMap<String, Object> data = auth_dao.getMgrNo(seq_no, query_uri);
//		String auth_key = "";
//		int length = 0;
//		
//		if(data != null) {
//			auth_key = Utils.checkNullString(data.get("AUTH_KEY"));
//			length = data.size();
//		}
//		System.out.println("auth_key :"+auth_key);
//		System.out.println("-----------------------------------"+query_uri);
//		if(auth_chk.equals(""))		//쓰기 권한을 요구하지 않을때
//		{
//			if(query_uri.indexOf("/auth/") > -1){
//				return true;
//			}
//			if(authArr.indexOf(query_uri) > -1 && auth_key.indexOf("R") > -1) {
//				//요청 경로가 authArr에 포함되어있고, 권한에 "R"이 포함되어 있을 경우 
//				result = true;
//			}else if(authArr.indexOf(query_uri) < 0 && !refererURI.equals("") && authArr.indexOf(refererURI) > -1) {
//				//요청 경로가 authArr에 포함되어 있지 않으며, 이전 경로가 공백이 아니고 authArr에 포함되어있을 경우
//				data = auth_dao.getMgrNo(seq_no, refererURI);
//				if(data != null) {
//					auth_key = Utils.checkNullString(data.get("AUTH_KEY"));
//					length = data.size();
//				}
//				if(auth_key.indexOf("R") > -1) {
//					result = true;
//				}else {
//					PrintWriter out = response.getWriter();
////					out.println("<script language='javascript'>");
////					out.println("alert('읽기 권한이 없습니다.');");
////					out.println("location.href='/';");
////					out.println("</script>");
////					out.flush();
//					result = false;
//				}
//			}else {
////				PrintWriter out = response.getWriter();
////				out.println("<script language='javascript'>");
////				out.println("alert('읽기 권한이 없습니다.');");
////				out.println("location.href='/';");
////				out.println("</script>");
////				out.flush();
//				result = false;
//			}
//		}
//		else if(!auth_chk.equals(""))	//쓰기 권한을 요구할때 
//		{
//			if(authArr.indexOf(query_uri) > -1 && auth_key.indexOf("RW") > -1) {
//				//요청 경로가 authArr에 포함되어있고, 권한에 "RW"가 포함되어 있을 경우 
//				result = true;
//			}else if(authArr.indexOf(query_uri) < 0 && !refererURI.equals("") && authArr.indexOf(refererURI) > -1){
//				//요청 경로가 authArr에 포함되어 있지 않으며, 이전 경로가 공백이 아니고 authArr에 포함되어있을 경우
//				data = auth_dao.getMgrNo(seq_no, refererURI);
//				if(data != null) {
//					auth_key = Utils.checkNullString(data.get("AUTH_KEY"));
//					length = data.size();
//				}
//				if(auth_key.indexOf("RW") > -1) {
//					result = true;
//				}else {
//					response.sendError(555);
//					result = false;
//				}
//			}else {
//				response.sendError(555);
//				result = false;
//			}
//		}
		return true;
		/*
		if(length > 0 && (auth_key != "" && auth_key != null)) {
			result = true;
			if(!auth_key.equals("R") && !auth_key.equals("RW")) {
				PrintWriter out = response.getWriter();
				out.println("{\"isSuc\": \"fail\", \"msg\": \"읽기 권한이 없습니다.\"}");
				out.flush();
				result = false;
			}
			if(auth_chk != "" && auth_chk != null) {
				if(!auth_key.equals("RW")) {
					PrintWriter out = response.getWriter();
					out.println("{\"isSuc\": \"fail\", \"msg\": \"쓰기 권한이 없습니다.\"}");
					out.flush();
					result = false;
				}
			}
		}else {
			PrintWriter out = response.getWriter();
			out.println("<script language='javascript'>");
			out.println("alert('접근 권한이 없습니다.');");
			out.println("location.href='/main';");
			out.println("</script>");
			out.flush();
		}
		*/
	}
	
/*	public boolean isWriteAuth(String uri)
	{
		Boolean result = false;
		List<String> list = new ArrayList<String>(Arrays.asList(Utils.checkNullString(uri).split("/")));
		list.remove(list.size()-1);
		String query_uri = String.join("/", list);
		HashMap<String, Object> data = auth_dao.getMgrNo(seq_no, query_uri);
		String auth_key = "";
		int length = 0;
		
		if(data != null) {
			auth_key = Utils.checkNullString(data.get("AUTH_KEY"));
			length = data.size();
		}
		if(권한이이따)
			result = true;
		else
		
			result = false;
		return result;
	}*/
}