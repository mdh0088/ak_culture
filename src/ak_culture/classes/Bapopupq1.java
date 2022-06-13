package ak_culture.classes;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ak_culture.model.basic.CodeDAO;
import ak_culture.model.member.LectDAO;


public class Bapopupq1 {
//	static String url = "jdbc:oracle:thin:@91.1.111.91:1521/WOOJIN";
	static String url = "jdbc:oracle:thin:@10.10.10.53:1521/CSDDB";
    static String id = "neocult";
    static String pw = "vjvmf610";
	//문화아카데미
	public static boolean SignIns (String store, String cust_no, String period, String pos_no, String  sign, String resi_no )
	{
	    Connection         conn       = null;
	    PreparedStatement  pstmt      = null;
	    PreparedStatement  pstmt1      = null;
	    PreparedStatement  pstmt2      = null;
	    Statement           stmt      = null;
	    ResultSet          rs         = null;
	    String             sqlQuery   = null;       
	    String             sqlQuery1   = null;
	    String             sqlQuery2   = null;
	    String             sqlQuery3   = null;
	    String             sign_no   = "";
	    String             free_yn   = "";
	    
	    
	    
	    int sucess    = 0;
	    boolean bResult = true;                                                     
	                                            
	    try
	    {
	    	Class.forName("oracle.jdbc.driver.OracleDriver");
	        conn=DriverManager.getConnection(url,id,pw);                    

	//*******************************************************************************//
	//1. 서명 번호를 등록한다.
	//*******************************************************************************//

	        sqlQuery ="\n SELECT NVL(MAX(SIGN_NO)+1,1) SIGN_NO "
	                + "FROM BASIGNTB"
	                + " WHERE STORE = '"+store+"'"
	                + "AND CUST_NO = "+cust_no
	                + " AND PERIOD = '"+period+"'"
	                + " AND SALE_YMD = TO_CHAR(SYSDATE,'YYYYMMDD')";
	        
	        System.out.println("***************************************************************");          
	        System.out.println("...select SignIns....sqlQuery:"+sqlQuery);
	        System.out.println("***************************************************************");        
	        stmt = conn.createStatement();
	        rs = stmt.executeQuery(sqlQuery);       
	            if ( rs.next() )
	            {
	                sign_no = rs.getString(1); // seq 값을 셋팅
	            }
	            
	            System.out.println("SignIns-sign_no===="+sign_no);
	            
	            
	            
	    //*******************************************************************************//
	    //2. 서명정보외 등록한다.
	    //*******************************************************************************//
	            sqlQuery ="\n INSERT INTO  BASIGNTB " 
	                    +"\n (STORE, CUST_NO, PERIOD, POS_NO, SALE_YMD, SALE_TIME, SIGN_NO, SUBJECT_CNT, SUBJECT_CD, " 
	                    +"\n  SUBJECT_NM,LECT_HOUR,DAY_FLAG,START_YMD,END_YMD,REGIS_FEE,FOOD_AMT, CREATE_RESI_NO, CREATE_DATE ) "
	                    +"\n ( SELECT A.STORE, A.CUST_NO, A.PERIOD, '"+pos_no+"', TO_CHAR(SYSDATE,'YYYYMMDD') ,TO_CHAR(SYSDATE,'HH24MI') "
	                    +"\n   ,'"+sign_no+"' "
	                    +"\n   ,ROWNUM AS SUBJECT_CNT "
	                    +"\n   ,A.SUBJECT_CD "
	                    +"\n   ,B.SUBJECT_NM "
	                    +"\n   ,SUBSTR(B.LECT_HOUR,1,2)||':'||SUBSTR(B.LECT_HOUR,3,2)||'~'||SUBSTR(B.LECT_HOUR,5,2)||':'||SUBSTR(B.LECT_HOUR,7) LECT_HOUR "
	                    +"\n   ,(CASE WHEN SUBSTR(B.DAY_FLAG, 1, 1) = '1' THEN '월' ELSE '' END)|| "
	                    +"\n    (CASE WHEN SUBSTR(B.DAY_FLAG, 2, 1) = '1' THEN '화' ELSE '' END)|| "
	                    +"\n   (CASE WHEN SUBSTR(B.DAY_FLAG, 3, 1) = '1' THEN '수' ELSE '' END)|| "
	                    +"\n   (CASE WHEN SUBSTR(B.DAY_FLAG, 4, 1) = '1' THEN '목' ELSE '' END)|| "
	                    +"\n   (CASE WHEN SUBSTR(B.DAY_FLAG, 5, 1) = '1' THEN '금' ELSE '' END)|| "
	                    +"\n   (CASE WHEN SUBSTR(B.DAY_FLAG, 6, 1) = '1' THEN '토' ELSE '' END)|| "
	                    +"\n   (CASE WHEN SUBSTR(B.DAY_FLAG, 7, 1) = '1' THEN '일' ELSE '' END) AS DAY_FLAG "
	                    +"\n   ,SUBSTR(B.START_YMD,0,4)||'. '||SUBSTR(B.START_YMD,5,2)||'. '||SUBSTR(B.START_YMD,7) AS START_YMD "
	                    +"\n   ,SUBSTR(B.END_YMD,0,4)||'. '||SUBSTR(B.END_YMD,5,2)||'. '||SUBSTR(B.END_YMD,7) AS END_YMD "
	                    +"\n   ,NVL2(B.REGIS_FEE,DECODE(B.REGIS_FEE,0,'0',SUBSTR(B.REGIS_FEE,1,LENGTH(B.REGIS_FEE)-3) ||','||SUBSTR(B.REGIS_FEE,LENGTH(B.REGIS_FEE)-2)),0) REGIS_FEE "
	                    +"\n   ,DECODE(B.FOOD_YN,'Y','/ '||SUBSTR(B.FOOD_AMT,1,LENGTH(B.FOOD_AMT)-3)||','||SUBSTR(B.FOOD_AMT,LENGTH(B.FOOD_AMT)-2)||'원','R','/ 별도','') FOOD_AMT "
	                    +"\n   ,'"+resi_no+"'  ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') "                
	                    +"\n FROM BAPERETB A, BAPELTTB# B "
	                    +"\n   WHERE A.HQ = A.HQ "
	                    +"\n   AND A.STORE = B.STORE "
	                    +"\n   AND A.PERIOD = B.PERIOD "
	                    +"\n   AND A.SUBJECT_CD = B.SUBJECT_CD "
	                    +"\n   AND RECPT_NO ='*' "       
	                    +"\n   AND A.STORE = '"+store+"' "
	                    +"\n   AND A.PERIOD = '"+period+"' " 
	                    +"\n   AND A.CUST_NO = "+cust_no+" ) ";

		            
	               
		            pstmt = conn.prepareStatement(sqlQuery);
//	                pstmt.setString(1,pos_no);
//	                pstmt.setString(2,sign_no);
//	                pstmt.setString(3,resi_no);
//	                pstmt.setString(4,store);
//	                pstmt.setString(5,period);
//	                pstmt.setString(6,cust_no);         
	                
	                System.out.println("pos_no : "+pos_no);
	                System.out.println("sign_no : "+sign_no);
	                System.out.println("resi_no : "+resi_no);
	                System.out.println("store : "+store);
	                System.out.println("period : "+period);
	                System.out.println("cust_no : "+cust_no);
//	                System.out.println("1........store:["+store+"]");
//		            System.out.println("2........cust_no  :["+cust_no  +"]");
//		            System.out.println("3........period:["+period+"]");
//		            System.out.println("4........pos_no  :["+pos_no  +"]");
//		            System.out.println("5........sign:["+sign+"]");
//		            System.out.println("6........resi_no  :["+resi_no  +"]");

	            System.out.println("***************************************************************");          
	            System.out.println("... insert.SignIns..sqlQuery:"+sqlQuery);
	            System.out.println("***************************************************************");
	            sucess = pstmt.executeUpdate();
	        
	            System.out.println("sucess : "+sucess);
	            System.out.println("pstmt.executeUpdate() : "+pstmt.executeUpdate());
	        if(sucess == 0)
	        {               
	            bResult = false;
	            conn.rollback();
	            throw new SQLException("BaPopupq1-----INSERT(SignIns) - 실패[2]!");
	        }
	        else
	        {
	          //*******************************************************************************//
	          //3. 서명 정보를 등록한다.
	          //*******************************************************************************//
	        	
	        	int clob_len = sign.length() / 3000; //4천자 넘어가면 안돼서 
	            int max_len = (sign.length() / clob_len)+1;
	            
	            String tmp = "";
	            for(int i = 0; i < clob_len; i++)
	            {
	            	if(i != 0)
	            	{
	            		tmp += "||";
	            	}
	            	tmp += "to_clob('";
	            	if((i+1) == clob_len)
	            	{
	            		tmp += sign.substring(i*max_len, sign.length()); 
	            	}
	            	else
	            	{
	            		tmp += sign.substring(i*max_len, (i+1)*max_len);
	            	}
	            	tmp += "')";
	            }
	            System.out.println("sign : "+sign);
	            System.out.println("tmp : "+tmp);
	            sqlQuery1 ="\n UPDATE  BASIGNTB " 
	                    +"\n SET SIGN_DATA = "+tmp
	                    +"\n WHERE CUST_NO = "+cust_no
	                    +"\n AND SALE_YMD = TO_CHAR(SYSDATE,'YYYYMMDD') "
	                    +"\n AND SIGN_NO = '"+sign_no+"' "
	                    +"\n AND SUBJECT_CNT = '1' ";

	            pstmt1 = conn.prepareStatement(sqlQuery1);
	            
//	            pstmt1.setString(1,sign);
//	            pstmt1.setString(2,cust_no);
//	            pstmt1.setString(3,sign_no);
	            
	            
	            
	            
	            System.out.println("sign.length : "+sign.length() );
	            
	            System.out.println("1........sign:["+sign+"]");
	            System.out.println("2........cust_no  :["+cust_no  +"]");
	            System.out.println("3........sign_no:["+sign_no+"]");
	            
	            System.out.println("***************************************************************");          
	            System.out.println("... update.SignIns..sqlQuery:"+sqlQuery1);
	            System.out.println("***************************************************************");
	            
	            sucess = pstmt1.executeUpdate();
	            
	            
	            if(sucess == 0)
	            {               
	                bResult = false;
	                conn.rollback();
	                throw new SQLException("BaPopupq1-----UPDATE(SignIns) - 실패[1]!");
	            }
	            else
	            {
	                //*******************************************************************************//
	                //4. 무료강좌 정보를 조회한다.
	                //*******************************************************************************//
	                sqlQuery2 ="\n SELECT DECODE(COUNT(SUBJECT_CD),0,'N','Y') FREE_YN "
	                        + "FROM BAPERETB"
	                        + " WHERE STORE = '"+store+"'"
	                        + "AND CUST_NO = "+cust_no
	                        + " AND PERIOD = '"+period+"'"
	                        + " AND RECPT_NO ='*' "
	                        + " AND REGIS_FEE ='0' "
	                        + " AND  PAY_YN ='N' ";
	                
	                System.out.println("***************************************************************");          
	                System.out.println("...select REGIS_FEE00000....sqlQuery:"+sqlQuery2);
	                System.out.println("***************************************************************");        
	                
	                rs = stmt.executeQuery(sqlQuery2);       
	                    if ( rs.next() )
	                    {
	                        free_yn = rs.getString(1); // free_yn 값을 셋팅
	                    }
	                    
	                    System.out.println("free_fee-free_yn===="+free_yn);
	                    
	                   if("Y".equals(free_yn)){
	                       
	                       //*******************************************************************************//
	                       //5. 무료강좌 정보를 등록한다.
	                       //*******************************************************************************//
	                       sqlQuery3 ="\n  UPDATE BAPERETB "   
	                               +"\n  SET PAY_YN = 'Y' "
	                               +"\n ,RECPT_NO = '9999' "
	                               +"\n ,FOOD_CANCEL_YN = 'N' "
	                               +"\n ,UPDATE_RESI_NO = '"+resi_no+"' "
	                               +"\n ,UPDATE_DATE = TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS') "
	                               +"\n WHERE RECPT_NO = '*' "
	                               +"\n AND REGIS_FEE = '0' "
	                               +"\n AND HQ = '00' "
	                               +"\n AND STORE = '"+store+"' "
	                               +"\n AND PERIOD = '"+period+"' "
	                               +"\n AND CUST_NO = "+cust_no;
	                       
	                         pstmt2 = conn.prepareStatement(sqlQuery3);
	                         
//	                         pstmt2.setString(1,resi_no);
//	                         pstmt2.setString(2,store);
//	                         pstmt2.setString(3,period);
//	                         pstmt2.setString(4,cust_no);
	                         
	                         System.out.println("1........resi_no:["+resi_no+"]");
	                         System.out.println("2........store  :["+store  +"]");
	                         System.out.println("3........period:["+period+"]");
	                         System.out.println("4........cust_no:["+cust_no+"]");
	                         
	                         System.out.println("***************************************************************");          
	                         System.out.println("... update.SignIns..sqlQuery:"+sqlQuery3);
	                         System.out.println("***************************************************************");
	                         
	                         sucess = pstmt2.executeUpdate();
	                         
	                         if(sucess == 0)
	                         {               
	                             bResult = false;
	                             conn.rollback();
	                             throw new SQLException("BaPopupq1-----UPDATE(regis_fee000) - 실패[1]!");
	                         }
	                         else
	                         {
	                             bResult = true;
	                             conn.commit();
	                         }
	                   }else{
	                       bResult = true;
	                       conn.commit();    
	                   }
	               
	            }
	        }
	        
	    } catch ( SQLException e ) {
	        bResult = false;
	        e.printStackTrace(System.out);
	        System.out.print("BaPopupq1...insert...1->"+e.getMessage());
	    } catch ( Exception ex ) {
	        bResult = false;
	        ex.printStackTrace(System.out);
	        System.out.print("BaPopupq1...insert...2->"+ex.getMessage());
	    } finally {
	        if ( rs   != null )  try { rs.close();   } catch ( Exception e ) {}
	        if ( pstmt != null ) try { pstmt.close();} catch ( Exception e ) {}
	        if ( conn != null )  try { conn.setAutoCommit(true); } catch ( Exception e ) {}         
	        if ( conn != null )  try { conn.close(); } catch ( Exception e ) {}
	    }
	    System.out.println("bResult : "+bResult);

	    return bResult;     
	}
	
	//서명저장 즉시 조회 시 추후 다이렉트조회로 변경 필요-sign테이블정보변경됨
	public static Vector SubjectRead(String store,String period,String cust_no) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sqlQuery = null;
		
		try{
	        
	        Class.forName("oracle.jdbc.driver.OracleDriver");
	        conn=DriverManager.getConnection(url,id,pw);

	        sqlQuery = "\n SELECT "
	                + "\n B.SUBJECT_NM "
	                + "\n ,SUBSTR(B.LECT_HOUR,1,2)||':'||SUBSTR(B.LECT_HOUR,3,2)||'~'||SUBSTR(B.LECT_HOUR,5,2)||':'||SUBSTR(B.LECT_HOUR,7) LECT_HOUR "
	                + "\n ,(CASE WHEN SUBSTR(B.DAY_FLAG, 1, 1) = '1' THEN '월' ELSE '' END)|| "
	                + "\n (CASE WHEN SUBSTR(B.DAY_FLAG, 2, 1) = '1' THEN '화' ELSE '' END)|| "
	                + "\n (CASE WHEN SUBSTR(B.DAY_FLAG, 3, 1) = '1' THEN '수' ELSE '' END)|| "
	                + "\n (CASE WHEN SUBSTR(B.DAY_FLAG, 4, 1) = '1' THEN '목' ELSE '' END)|| "
	                + "\n (CASE WHEN SUBSTR(B.DAY_FLAG, 5, 1) = '1' THEN '금' ELSE '' END)|| "
	                + "\n (CASE WHEN SUBSTR(B.DAY_FLAG, 6, 1) = '1' THEN '토' ELSE '' END)|| "
	                + "\n (CASE WHEN SUBSTR(B.DAY_FLAG, 7, 1) = '1' THEN '일' ELSE '' END) AS DAY_FLAG "
	                + "\n ,SUBSTR(B.START_YMD,0,4)||'. '||SUBSTR(B.START_YMD,5,2)||'. '||SUBSTR(B.START_YMD,7) AS START_YMD "
	                + "\n ,SUBSTR(B.END_YMD,0,4)||'. '||SUBSTR(B.END_YMD,5,2)||'. '||SUBSTR(B.END_YMD,7) AS END_YMD "
	                + "\n ,NVL2(B.REGIS_FEE,DECODE(B.REGIS_FEE,0,'0',SUBSTR(B.REGIS_FEE,1,LENGTH(B.REGIS_FEE)-3) ||','||SUBSTR(B.REGIS_FEE,LENGTH(B.REGIS_FEE)-2)),0) REGIS_FEE "
	                + "\n ,DECODE(B.FOOD_YN,'Y','/ '||SUBSTR(B.FOOD_AMT,1,LENGTH(B.FOOD_AMT)-3)||','||SUBSTR(B.FOOD_AMT,LENGTH(B.FOOD_AMT)-2)||'원','R','/ 별도','') FOOD_AMT "                
	                + "\n FROM BAPERETB A, BAPELTTB# B "
	                + "\n WHERE A.HQ = A.HQ "
	                + "\n AND A.STORE = B.STORE "
	                + "\n AND A.PERIOD = B.PERIOD "
	                + "\n AND A.SUBJECT_CD = B.SUBJECT_CD "
	                + "\n AND RECPT_NO ='*' "
	                + "\n AND A.HQ = '00' "
	                + "\n AND A.STORE = '"+store+"'"
	                + "\n AND A.PERIOD = '"+period+"'"
	                + "\n AND A.CUST_NO = "+cust_no;
	        
	        System.out.println("씨발 : "+sqlQuery);
	        
	        Statement st = conn.createStatement();
	        pstmt = conn.prepareStatement(sqlQuery);
	        
	        Vector v = new Vector();

	        rs = pstmt.executeQuery();

	        while(rs.next())
	        {
	        	v.addElement(new BaPopupBn ( rs.getString(1)
					                        , rs.getString(2)
					                        , rs.getString(3)
					                        , rs.getString(4)
					                        , rs.getString(5)
					                        , rs.getString(6)
					                        , rs.getString(7)
	        			));
	        }
	        return v;
		}
		catch (Exception e)
		{
	        e.printStackTrace();
		}
		finally
		{
	        if (rs != null) try{rs.close();}
	        catch (SQLException ex) {}

	        if (pstmt != null) try {pstmt.close();}
	        catch (SQLException ex) {}

	        if (conn != null) try {conn.close();}
	        catch (SQLException ex) {}
		}
		return null;
	}

	// 서명저장 조회 시
	public static Vector SubjectDetail(String store, String period, String cust_no, String sale_ymd, String sign_no)
			throws Exception {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sqlQuery = null;

		try {
			sqlQuery = "\n SELECT SUBJECT_CNT, SUBJECT_NM, LECT_HOUR, DAY_FLAG, START_YMD, END_YMD, REGIS_FEE,FOOD_AMT,SIGN_DATA"
					+ "\n  FROM BASIGNTB " + "\n WHERE STORE = '" + store + "'" + "\n AND PERIOD = '" + period + "'"
					+ "\n AND CUST_NO = " + cust_no + "\n AND SALE_YMD = '" + sale_ymd + "'"
					+ "\n AND SIGN_NO = '" + sign_no + "'" + "\n ORDER BY SUBJECT_CNT ";

			System.out.println("SubjectDetail-sqlQuery:" + sqlQuery);
			 Class.forName("oracle.jdbc.driver.OracleDriver");
		        conn=DriverManager.getConnection(url,id,pw);
			stmt = conn.createStatement();

			rs = stmt.executeQuery(sqlQuery);

			Vector v = new Vector();

			while (rs.next()) {
				v.addElement(new BaPopupBn(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(4),
						rs.getString(5), rs.getString(6), rs.getString(7), rs.getString(8), rs.getString(9)));
			}

			return v;

		} finally {

			try {

				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (conn != null)
					conn.close();
			} catch (SQLException sqe) {

				sqe.printStackTrace(System.out);
			}
		}
	}
	

}
