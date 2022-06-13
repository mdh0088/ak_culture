package ak_culture.model.web;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;

public class WebDAO extends SqlSessionDaoSupport{
	
	private String NS = "/web/webMapper";

	public void insNews(int seq, String store, String news_category, String news_title, String start_ymd, String end_ymd, String is_show, String filename, String filename_ori, String contents, String login_seq, String banner, String m_banner) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("store", store);
		map.put("news_category", news_category);
		map.put("news_title", news_title);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("is_show", is_show);
		map.put("filename", filename);
		map.put("filename_ori", filename_ori);
		map.put("contents", contents);
		map.put("login_seq", login_seq);
		map.put("banner", banner);
		map.put("m_banner", m_banner);
		getSqlSession().insert(NS + ".insNews", map);
	}

	public int getSeqByWeb(String table) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("table", table);
		return getSqlSession().selectOne(NS + ".getSeqByWeb", map);
	}

	public HashMap<String, Object> getNewsOne(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getNewsOne", map);
	}

	public void upNews(int seq, String store, String news_category, String news_title, String start_ymd, String end_ymd, String is_show, String filename, String filename_ori, String contents, String login_seq, String banner, String m_banner) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("store", store);
		map.put("news_category", news_category);
		map.put("news_title", news_title);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("is_show", is_show);
		map.put("filename", filename);
		map.put("filename_ori", filename_ori);
		map.put("contents", contents);
		map.put("login_seq", login_seq);
		map.put("banner", banner);
		map.put("m_banner", m_banner);
		getSqlSession().update(NS + ".upNews", map);
	}

	public HashMap<String, Object> getNewsFileName(int seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getNewsFileName", map);
	}

	public List<HashMap<String, Object>> getNewsList(String search_type, String search_name, String search_date_type, String search_start, String search_end, String search_cate, String search_store) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("search_date_type", search_date_type);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("search_cate", search_cate);
		map.put("search_store", search_store);
		return getSqlSession().selectList(NS + ".getNewsList", map);
	}

	public void sortNews(String seq, String sort) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("sort", sort);
		getSqlSession().update(NS + ".sortNews", map);
	}
	public void sortMBanner(String seq, String sort) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("sort", sort);
		getSqlSession().update(NS + ".sortMBanner", map);
	}
	public void sortSBanner(String seq, String sort) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("sort", sort);
		getSqlSession().update(NS + ".sortSBanner", map);
	}
	public void sortPopup(String seq, String sort) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		map.put("sort", sort);
		getSqlSession().update(NS + ".sortPopup", map);
	}

	public void delNews(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		getSqlSession().delete(NS + ".delNews", map);
	}
	public void delMBanner(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		getSqlSession().delete(NS + ".delMBanner", map);
	}
	public void delSBanner(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		getSqlSession().delete(NS + ".delSBanner", map);
	}
	public void delPopup(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		getSqlSession().delete(NS + ".delPopup", map);
	}
	public void delReco(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		getSqlSession().delete(NS + ".delReco", map);
	}

	public HashMap<String, Object> getMBannerFileName(int seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getMBannerFileName", map);
	}
	public HashMap<String, Object> getSBannerFileName(int seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getSBannerFileName", map);
	}
	public HashMap<String, Object> getPopupFileName(int seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getPopupFileName", map);
	}
	public HashMap<String, Object> getRecoFileName(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectOne(NS + ".getRecoFileName", map);
	}

	public void upMBanner(HashMap<String, Object> map) {
		getSqlSession().update(NS + ".upMBanner", map);
	}
	public void insMBanner(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insMBanner", map);
	}
	public void upSBanner(HashMap<String, Object> map) {
		getSqlSession().update(NS + ".upSBanner", map);
	}
	public void insSBanner(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insSBanner", map);
	}

	public HashMap<String, Object> getMBannerOne(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getMBannerOne", map);
	}
	public HashMap<String, Object> getSBannerOne(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getSBannerOne", map);
	}

	public List<HashMap<String, Object>> getMBannerList(String search_name, String search_start, String search_end, String search_show) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("search_show", search_show);
		return getSqlSession().selectList(NS + ".getMBannerList", map);
	}
	public List<HashMap<String, Object>> getSBannerList(String search_name, String search_date_type, String search_start, String search_end, String search_show) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_date_type", search_date_type);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("search_show", search_show);
		return getSqlSession().selectList(NS + ".getSBannerList", map);
	}
	public List<HashMap<String, Object>> getPopupList(String search_name, String search_date_type, String search_start, String search_end, String search_show) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_name", search_name);
		map.put("search_date_type", search_date_type);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("search_show", search_show);
		return getSqlSession().selectList(NS + ".getPopupList", map);
	}

	public void insRecomLect(String store, String period, String subject_cd, String login_seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("login_seq", login_seq);
		getSqlSession().insert(NS + ".insRecomLect", map);
	}
	public int getRecoCnt(String store, String period, String subject_cd) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		return getSqlSession().selectOne(NS + ".getRecoCnt", map);
	}

	public List<HashMap<String, Object>> getRecoList(String search_store, String search_period, String search_tag, String search_show, String search_start, String search_end, String search_date_type) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("search_store", search_store);
		map.put("search_period", search_period);
		map.put("search_tag", search_tag);
		map.put("search_show", search_show);
		map.put("search_start", search_start);
		map.put("search_end", search_end);
		map.put("search_date_type", search_date_type);
		return getSqlSession().selectList(NS + ".getRecoList", map);
	}

	public void insTagByReco(String store, String period, String subject_cd, String tag) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("tag", tag);
		getSqlSession().update(NS + ".insTagByReco", map);
	}
	public void delTagByReco(String store, String period, String subject_cd, String tag) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("tag", tag);
		getSqlSession().update(NS + ".delTagByReco", map);
	}

	public void upReco(HashMap<String, Object> map) {
		getSqlSession().update(NS + ".upReco", map);
	}

	public void sortReco(String store, String period, String subject_cd, String sort) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("sort", sort);
		getSqlSession().update(NS + ".sortReco", map);
	}

	public void upPopup(HashMap<String, Object> map) {
		getSqlSession().update(NS + ".upPopup", map);
	}
	public void insPopup(HashMap<String, Object> map) {
		getSqlSession().insert(NS + ".insPopup", map);
	}

	public HashMap<String, Object> getPopupOne(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectOne(NS + ".getPopupOne", map);
	}

	public List<HashMap<String, Object>> getReviewListCount(String store, String period, String search_type, String search_name, String start_ymd,
			String end_ymd, String lecturer_nm, String subject_nm, String is_reco, String is_best) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("lecturer_nm", lecturer_nm);
		map.put("subject_nm", subject_nm);
		map.put("is_reco", is_reco);
		map.put("is_best", is_best);
		return getSqlSession().selectList(NS + ".getReviewListCount", map);
	}

	public List<HashMap<String, Object>> getReviewList(int s_rownum, int e_rownum, String order_by, String sort_type, String store, String period, String search_type, String search_name, String start_ymd,
			String end_ymd, String lecturer_nm, String subject_nm, String is_reco, String is_best) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("s_rownum", s_rownum);
		map.put("e_rownum", e_rownum);
		map.put("order_by", order_by);
		map.put("sort_type", sort_type);
		map.put("store", store);
		map.put("period", period);
		map.put("search_type", search_type);
		map.put("search_name", search_name);
		map.put("start_ymd", start_ymd);
		map.put("end_ymd", end_ymd);
		map.put("lecturer_nm", lecturer_nm);
		map.put("subject_nm", subject_nm);
		map.put("is_reco", is_reco);
		map.put("is_best", is_best);
		return getSqlSession().selectList(NS + ".getReviewList", map);
	}

	public void bestAction(String store, String period, String subject_cd, String act) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("store", store);
		map.put("period", period);
		map.put("subject_cd", subject_cd);
		map.put("act", act);
		getSqlSession().update(NS + ".bestAction", map);
	}

	public void insCanc(String contents) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("contents", contents);
		getSqlSession().update(NS + ".insCanc", map);
	}

	public String getCanc() {
		return getSqlSession().selectOne(NS + ".getCanc");
	}

	public List<HashMap<String, Object>> getMBannerByPreview(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectList(NS + ".getMBannerByPreview", map);
	}
	public List<HashMap<String, Object>> getSBannerByPreview(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectList(NS + ".getSBannerByPreview", map);
	}
	public List<HashMap<String, Object>> getPopupByPreview(String seq) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("seq", seq);
		return getSqlSession().selectList(NS + ".getPopupByPreview", map);
	}
}
