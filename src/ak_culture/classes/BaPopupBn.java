package ak_culture.classes;


public class BaPopupBn {
    
    private String  store  ;
    private String  period  ;
    private String  cust_no  ;
    private String  subject_cd ;
    private String  subject_nm ;
    private String  lect_hour;
    private String  day_flag ;    
    private String  start_ymd ;                  
    private String  end_ymd  ;
    private String  regis_fee ;
    private String  food_amt;
    private String  create_date;
    private String  create_resi_no;
    private String  update_date;
    private String  update_resi_no;
    private String  subject_cnt;
    private String  sign_data;
    
    
    public  BaPopupBn() {};
    public  BaPopupBn(
            String  subject_cnt
           ,String  subject_nm
           ,String  lect_hour
           ,String  day_flag
           ,String  start_ymd
           ,String  end_ymd
           ,String  regis_fee
           ,String  food_amt
           ,String  sign_data
       ){
               this.subject_cnt = subject_cnt;
               this.subject_nm = subject_nm;
               this.lect_hour = lect_hour;                         
               this.day_flag = day_flag;
               this.start_ymd = start_ymd;
               this.end_ymd = end_ymd;
               this.regis_fee = regis_fee;
               this.food_amt = food_amt;
               this.sign_data = sign_data;
           }
    
    public  BaPopupBn(
    					String  subject_nm
    					,String  lect_hour
    					,String  day_flag
    					,String  start_ymd
    					,String  end_ymd
    					,String  regis_fee
    					,String  food_amt
    				){
    						this.subject_nm = subject_nm;
    						this.lect_hour = lect_hour;    						
    						this.day_flag = day_flag;
    						this.start_ymd = start_ymd;
    						this.end_ymd = end_ymd;
    						this.regis_fee = regis_fee;
    						this.food_amt = food_amt;
    					}
    
    
    public String getSign_data() {
        return sign_data;
    }
    public void setSign_data(String sign_data) {
        this.sign_data = sign_data;
    }
    public String getSubject_cnt() {
        return subject_cnt;
    }
    public void setSubject_cnt(String subject_cnt) {
        this.subject_cnt = subject_cnt;
    }
    public String getStore() {
        return store;
    }
    public void setStore(String store) {
        this.store = store;
    }
    public String getPeriod() {
        return period;
    }
    public void setPeriod(String period) {
        this.period = period;
    }
    public String getCust_no() {
        return cust_no;
    }
    public void setCust_no(String cust_no) {
        this.cust_no = cust_no;
    }
    public String getSubject_cd() {
        return subject_cd;
    }
    public void setSubject_cd(String subject_cd) {
        this.subject_cd = subject_cd;
    }
    public String getSubject_nm() {
        return subject_nm;
    }
    public void setSubject_nm(String subject_nm) {
        this.subject_nm = subject_nm;
    }
    public String getLect_hour() {
        return lect_hour;
    }
    public void setLect_hour(String lect_hour) {
        this.lect_hour = lect_hour;
    }
    public String getDay_flag() {
        return day_flag;
    }
    public void setDay_flag(String day_flag) {
        this.day_flag = day_flag;
    }
    public String getStart_ymd() {
        return start_ymd;
    }
    public void setStart_ymd(String start_ymd) {
        this.start_ymd = start_ymd;
    }
    public String getEnd_ymd() {
        return end_ymd;
    }
    public void setEnd_ymd(String end_ymd) {
        this.end_ymd = end_ymd;
    }
    public String getRegis_fee() {
        return regis_fee;
    }
    public void setRegis_fee(String regis_fee) {
        this.regis_fee = regis_fee;
    }
    public String getFood_amt() {
        return food_amt;
    }
    public void setFood_amt(String food_amt) {
        this.food_amt = food_amt;
    }
    public String getCreate_date() {
        return create_date;
    }
    public void setCreate_date(String create_date) {
        this.create_date = create_date;
    }
    public String getCreate_resi_no() {
        return create_resi_no;
    }
    public void setCreate_resi_no(String create_resi_no) {
        this.create_resi_no = create_resi_no;
    }
    public String getUpdate_date() {
        return update_date;
    }
    public void setUpdate_date(String update_date) {
        this.update_date = update_date;
    }
    public String getUpdate_resi_no() {
        return update_resi_no;
    }
    public void setUpdate_resi_no(String update_resi_no) {
        this.update_resi_no = update_resi_no;
    };
    
	
   
}