<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*" %>
<%

	String url = "jdbc:oracle:thin:@91.1.101.67:1521/AKRIS";
	String user = "akrisys";
	String pass = "qmffn610";
	Connection conn;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();
	pstmt=conn.prepareStatement("select * from dual");
	rs = pstmt.executeQuery();
	
	while(rs.next())
	{
		out.println(":::::"+rs.getString("DUMMY")+":::::");
	}
	conn.close();
%>