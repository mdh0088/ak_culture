package ak_culture.model.basic;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class PeriDAO extends SqlSessionDaoSupport{
	
	private String NS = "/basic/periMapper";
	
	public HashMap<String, Object> getPeriOne(String selPeri, String selBranch) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selPeri", selPeri);
		map.put("selBranch", selBranch);
		
		HashMap<String, Object> data = getSqlSession().selectOne(NS + ".getPeriOne", map);
		return data;
	}

	public List<HashMap<String, Object>> getLastPeri(String selBranch) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getLastPeri", map);
		return list;
	}
	public void insPeri(String selBranch, String selYear, String selSeason, String period, String start_ymd,
			String end_ymd, String cancled_list, String web_open_ymd, String adult_s_bgn_ymd, String adult_f_bgn_ymd,
			String tech_1_ymd, String tech_1_status, String tech_2_ymd, String tech_2_status, String tech_3_ymd,
			String tech_3_status, String mate_1_ymd, String mate_1_status, String mate_2_ymd, String mate_2_status,
			String mate_3_ymd, String mate_3_status, String login_seq, String lect_hour, String is_cancel) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		map.put("selYear", selYear);
		map.put("selSeason", selSeason);
		map.put("web_text", selYear+"년도 "+selSeason);
		if(period.length() == 1)
		{
			map.put("period", "00"+period);
		}
		else if(period.length() == 2)
		{
			map.put("period", "0"+period);
		}
		else if(period.length() == 3)
		{
			map.put("period", period);
		}
		
		map.put("start_ymd", start_ymd.replace("-", ""));
		map.put("end_ymd", end_ymd.replace("-", ""));
		map.put("cancled_list", cancled_list.replace("-", ""));
		map.put("web_open_ymd", web_open_ymd.replace("-", ""));
		map.put("adult_s_bgn_ymd", adult_s_bgn_ymd.replace("-", ""));
		map.put("adult_f_bgn_ymd", adult_f_bgn_ymd.replace("-", ""));
		map.put("is_cancel", is_cancel);
		map.put("tech_1_ymd", tech_1_ymd.replace("-", ""));
		map.put("tech_1_status", tech_1_status);
		map.put("tech_2_ymd", tech_2_ymd.replace("-", ""));
		map.put("tech_2_status", tech_2_status);
		map.put("tech_3_ymd", tech_3_ymd.replace("-", ""));
		map.put("tech_3_status", tech_3_status);
		map.put("mate_1_ymd", mate_1_ymd.replace("-", ""));
		map.put("mate_1_status", mate_1_status);
		map.put("mate_2_ymd", mate_2_ymd.replace("-", ""));
		map.put("mate_2_status", mate_2_status);
		map.put("mate_3_ymd", mate_3_ymd.replace("-", ""));
		map.put("mate_3_status", mate_3_status);
		map.put("login_seq", login_seq);
		map.put("lect_hour", lect_hour);
		
		getSqlSession().insert(NS + ".insPeri", map);
	}
	public void upPeri(String selBranch, String selYear, String selSeason, String period, String start_ymd,
			String end_ymd, String cancled_list, String web_open_ymd, String adult_s_bgn_ymd, String adult_f_bgn_ymd,
			String tech_1_ymd, String tech_1_status, String tech_2_ymd, String tech_2_status, String tech_3_ymd,
			String tech_3_status, String mate_1_ymd, String mate_1_status, String mate_2_ymd, String mate_2_status,
			String mate_3_ymd, String mate_3_status, String lect_hour, String is_cancel) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("selBranch", selBranch);
		map.put("selYear", selYear);
		map.put("selSeason", selSeason);
		map.put("web_text", selYear+"년도 "+selSeason);
		if(period.length() == 1)
		{
			map.put("period", "00"+period);
		}
		else if(period.length() == 2)
		{
			map.put("period", "0"+period);
		}
		else if(period.length() == 3)
		{
			map.put("period", period);
		}
		
		map.put("start_ymd", start_ymd.replace("-", ""));
		map.put("end_ymd", end_ymd.replace("-", ""));
		map.put("cancled_list", cancled_list.replace("-", ""));
		map.put("web_open_ymd", web_open_ymd.replace("-", ""));
		map.put("adult_s_bgn_ymd", adult_s_bgn_ymd.replace("-", ""));
		map.put("adult_f_bgn_ymd", adult_f_bgn_ymd.replace("-", ""));
		map.put("is_cancel", is_cancel);
		map.put("tech_1_ymd", tech_1_ymd.replace("-", ""));
		map.put("tech_1_status", tech_1_status);
		map.put("tech_2_ymd", tech_2_ymd.replace("-", ""));
		map.put("tech_2_status", tech_2_status);
		map.put("tech_3_ymd", tech_3_ymd.replace("-", ""));
		map.put("tech_3_status", tech_3_status);
		map.put("mate_1_ymd", mate_1_ymd.replace("-", ""));
		map.put("mate_1_status", mate_1_status);
		map.put("mate_2_ymd", mate_2_ymd.replace("-", ""));
		map.put("mate_2_status", mate_2_status);
		map.put("mate_3_ymd", mate_3_ymd.replace("-", ""));
		map.put("mate_3_status", mate_3_status);
		map.put("lect_hour", lect_hour);
		
		
		getSqlSession().update(NS + ".upPeri", map);
	}

	public void upCancled(String store, String period, String main_cd, String sect_cd, String cancled) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("cancled", cancled);
		getSqlSession().update(NS + ".upCancled", map);
	}
	public void insCancled(String store, String period, String main_cd, String sect_cd, String cancled) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		map.put("cancled", cancled);
		getSqlSession().update(NS + ".insCancled", map);
	}
	public List<HashMap<String, Object>> getCancled(String store, String period, String main_cd, String sect_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("main_cd", main_cd);
		map.put("sect_cd", sect_cd);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getCancled", map);
		return list;
	}

	public List<HashMap<String, Object>> getHoliday(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getHoliday", map);
		return list;
	}
	public List<HashMap<String, Object>> getHoliday_test(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		List<HashMap<String, Object>> list = getSqlSession().selectList(NS + ".getHoliday_test", map);
		return list;
	}

	public void setWebPeri(String store, String period, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("login_seq", login_seq);
		getSqlSession().update(NS + ".setWebPeri", map);
	}

	public int seqPeriCount(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectOne(NS + ".seqPeriCount", map);
	}

	public void insPeriSeq(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		getSqlSession().insert(NS + ".insPeriSeq", map);
	}

	public int getPeriodByDate(String store, String start_ymd, String end_ymd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		return getSqlSession().selectOne(NS + ".getPeriodByDate", map);
	}

	public String getIs_cancel(String store, String period) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		return getSqlSession().selectOne(NS + ".getIs_cancel", map);
	}

}
