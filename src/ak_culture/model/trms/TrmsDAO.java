package ak_culture.model.trms;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.web.servlet.ModelAndView;

public class TrmsDAO extends SqlSessionDaoSupport{
	
	private String NS = "/trms/trmsMapper";
	
	public void updateBASale0101(String store, String pos, String tot_amt) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("tot_amt", tot_amt);
		getSqlSession().update(NS + ".updateBASale0101", map);
	}
	public void insertBASale0101(String store, String pos, String tot_amt) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("tot_amt", tot_amt);
		getSqlSession().insert(NS + ".insertBASale0101", map);
	}
	public void insertBASale0103(String store, String pos, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insertBASale0103", map);
	}
	public String checkBASale0103(String store, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0103", map);
	}
	
	public void insIt(String store, String pos, String tot_amt, String login_seq, String adjust_item) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("tot_amt", tot_amt);
		map.put("login_seq", login_seq);
		map.put("adjust_item", adjust_item);
		
		getSqlSession().insert(NS + ".insItde", map);
		if("074".equals(adjust_item))
		{
			getSqlSession().insert(NS + ".insItem", map);
		}
	}
	public void upIt(String store, String pos, String tot_amt, String login_seq, String adjust_item) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("tot_amt", tot_amt);
		map.put("login_seq", login_seq);
		map.put("adjust_item", adjust_item);
		
		getSqlSession().insert(NS + ".upItde", map);
	}

	public List<HashMap<String, Object>> selTodayIt(String store, String pos, String adjust_item) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("adjust_item", adjust_item);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".selTodayIt", map);
		return list;
	}
	public String getRecpt(String store, String pos_no) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos_no);
		
		String recpt = getSqlSession().selectOne(NS + ".getRecpt", map);
		return recpt;
	}
	
	public String getCloseStatus(String store, String pos, String close_fg, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos);
		map.put("close_fg", close_fg);
		map.put("sale_ymd", sale_ymd);
		String ret = getSqlSession().selectOne(NS + ".getCloseStatus", map);
		
		return ret;
	}
	public int checkIt(String store, String pos, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos);
		map.put("sale_ymd", sale_ymd);
		
		int ret = getSqlSession().selectOne(NS + ".checkIt", map);
		
		return ret;
	}
	public void insClos(String store, String pos, String close_fg, String login_seq, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos);
		map.put("close_fg", close_fg);
		map.put("login_seq", login_seq);
		map.put("sale_ymd", sale_ymd);
		
		getSqlSession().insert(NS + ".insClos", map);
	}
	public List<HashMap<String, Object>> getItdeList(String store, String pos, String start_ymd, String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getItdeList", map);
		return list;
	}
	public List<HashMap<String, Object>> getItTypeList(String type, String store, String pos, String start_ymd, String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getItTypeList"+type, map);
		return list;
	}
	public List<HashMap<String, Object>> getItDetailList(String type, String store, String pos, String start_ymd, String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos_no", pos);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getItDetailList"+type, map);
		return list;
	}
	public String getSendCloseStatus(String store, String close_fg, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("close_fg", close_fg);
		map.put("sale_ymd", sale_ymd);
		String ret = getSqlSession().selectOne(NS + ".getSendCloseStatus", map);
		return ret;
	}
	public int checkSend(String store, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		int cnt = getSqlSession().selectOne(NS + ".checkSend", map);
		return cnt;
	}
	public int checkSendIt(String store, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		int cnt = getSqlSession().selectOne(NS + ".checkSendIt", map);
		return cnt;
	}
	public void insSend(String store, String close_fg, String login_seq, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("close_fg", close_fg);
		map.put("login_seq", login_seq);
		map.put("sale_ymd", sale_ymd);
		
		getSqlSession().insert(NS + ".insSend", map);
	}
	public List<HashMap<String, Object>> processBASale1601(String sale_ymd, String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".processBASale1601", map);
		return list;
	}
	public int processBASale1602(String sale_ymd, String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectOne(NS + ".processBASale1602", map);
	}
	public String processBASale1603(String sale_ymd, String store, String period, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("period", period);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".processBASale1603", map);
	}
	public int processBASale1604(String sale_ymd, String store, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".processBASale1604", map);
	}
	public void processBASale1605(String sale_ymd, String store, String pos, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("pos", pos);
		map.put("login_seq", login_seq);
		getSqlSession().update(NS + ".processBASale1605", map);
	}
	public int processBASale1606(String sale_ymd, String store, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".processBASale1606", map);
	}
	public void processBASale1607(String sale_ymd, String store, String login_seq, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("login_seq", login_seq);
		map.put("pos", pos);
		getSqlSession().insert(NS + ".processBASale1607", map);
	}
	public void processBASale1608(String sale_ymd, String store, String adjust_item, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("store", store);
		map.put("adjust_item", adjust_item);
		map.put("pos", pos);
		getSqlSession().insert(NS + ".processBASale1608", map);
	}
	public String checkBASale0101(String store, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0101", map);
	}
	public String checkBASale0601(String store, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0601", map);
	}
	public HashMap<String, Object> getBASale0101(String store, String pos, String adjust_item) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("pos", pos);
		map.put("adjust_item", adjust_item);
		return getSqlSession().selectOne(NS + ".getBASale0101", map);
	}
	public String checkBASale0104(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0104", map);
	}
	public String checkBASale0105(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0105", map);
	}
	public void deleteBASale0106(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		getSqlSession().delete(NS + ".deleteBASale0106", map);
	}
	public String checkBASale0107(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0107", map);
	}
	public void updateBASale0107(String store, String sale_ymd, String pos, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		map.put("login_seq", login_seq);
		getSqlSession().update(NS + ".updateBASale0107", map);
	}
	public String checkBASale0108(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0108", map);
	}
	public void deleteBASale0108(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		getSqlSession().delete(NS + ".deleteBASale0108", map);
	}
	public String checkBASale0109(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		return getSqlSession().selectOne(NS + ".checkBASale0109", map);
	}
	public void deleteBASale0109(String store, String sale_ymd, String pos) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		getSqlSession().delete(NS + ".deleteBASale0109", map);
	}
	public String checkBASale0110(String sale_ymd, String pmg_arg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("pmg_arg", pmg_arg);
		return getSqlSession().selectOne(NS + ".checkBASale0110", map);
	}
	public void deleteBASale0110(String sale_ymd, String pmg_arg) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("sale_ymd", sale_ymd);
		map.put("pmg_arg", pmg_arg);
		getSqlSession().delete(NS + ".deleteBASale0110", map);
	}
	public void deleteBASale0601(String store, String pos, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		getSqlSession().delete(NS + ".deleteBASale0601", map);
	}
	public void updateBASale0603(String store, String pos, String sale_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("sale_ymd", sale_ymd);
		map.put("pos", pos);
		getSqlSession().update(NS + ".updateBASale0603", map);
	}
}
