package ak_culture.controller.common;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import ak_culture.classes.Utils;
import ak_culture.model.common.AuthDAO;
import ak_culture.model.common.CommonDAO;

@Controller
@RequestMapping("/auth/*")

public class AuthController {
	
	private final Logger log = Logger.getLogger(this.getClass());
	
	@Autowired
	private AuthDAO auth_dao;
	@Autowired
	private CommonDAO common_dao;
	@RequestMapping("/proc")
	@ResponseBody
	public HashMap<String, Object> auth_proc(HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<>();	
		
		String seq_no = Utils.checkNullString(request.getParameter("seq_no"));
		String auth_uri = Utils.checkNullString(request.getParameter("auth_uri"));
		String auth_key = Utils.checkNullString(request.getParameter("auth_key"));
		int result = auth_dao.chk_new(seq_no, auth_uri);
		try {
			if(result == 0){
				auth_dao.write_proc(seq_no, auth_uri, auth_key);
			}else{
				auth_dao.modify_proc(seq_no, auth_uri, auth_key);
			}
			map.put("isSuc", "success");
			map.put("msg", "저장되었습니다.");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("isSuc", "fail");
			map.put("msg", "작업중 오류가 발생하였습니다.");
			return map;
		}
		
		return map;
	}
	
	@RequestMapping("/getAuth")
	@ResponseBody
	public List<HashMap<String, Object>> getAuth(HttpServletRequest request){
		String seq_no = Utils.checkNullString(request.getParameter("seq_no"));
		
		List<HashMap<String, Object>> result = auth_dao.getAuth(seq_no);
		
		return result;
	}
	
}