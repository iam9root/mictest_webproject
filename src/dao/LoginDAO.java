package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.LoginVO;
//회원관리 기능 구현
import vo.MemberVO;

public class LoginDAO { 	
	
	  public boolean insertMember(LoginVO vo)  {
		  System.out.println("1");
		  
		  String dbemail="";
		  ResultSet rs =  null;
		  try {
			  System.out.println();
			  
			  	Class.forName("oracle.jdbc.driver.OracleDriver"); 
				Connection con = DriverManager.getConnection
				("jdbc:oracle:thin:@localhost:1521:xe", 	"mic", "mic");
				String sql = "insert into member values(?,?,?,sysdate,?,null,?,0,?)";
				
				System.out.println("2");
				
				//String sql = "insert into member values(?,'b','1',sysdate,'1',' ','1','0',' ')";
				
				PreparedStatement pt = con.prepareStatement(sql);
				
				System.out.println("3");
				
				pt.setString(1, vo.getEmail());
				pt.setString(2, vo.getNickname());
				pt.setString(3, vo.getPassword());
				pt.setInt(4, vo.getGender());
				pt.setInt(5, vo.getBirthyear());
				pt.setString(6, vo.getProfile_img());
			 
			 System.out.println("4");
			 
			
			/*
			 * rs = pt.executeQuery();
			 * 
			 * if(rs.next()) { dbemail = rs.getString("email"); }
			 */
			
				
				pt.executeUpdate();
				
				System.out.println("5");
				
				con.close();
		  }
		  catch(Exception e) {
			  System.out.println("6");
				e.printStackTrace();
				return false;
		  } 
		  if(dbemail.equals(vo.getPassword())) {
			  System.out.println("7");
			  return true;
		  } else {
			  return false;
		  }		  
	  }
	  
	  //이메일 중복체크
	  public boolean checkEmail(String email) {
		  String dbpw="";
		  ResultSet rs =  null;
		  boolean result=false; //중복x
		  try {
			
			Class.forName
			("oracle.jdbc.driver.OracleDriver"); 
			Connection con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe", 	"mic", "mic");
			String sql = "select email from member where email=?";
			
			PreparedStatement pt = con.prepareStatement(sql);
			pt.setString(1,  email);
			rs = pt.executeQuery();
			
			if(rs.next()) {
				result=true;
			}
			
			con.close();
		  }
		  catch(Exception e) {
			e.printStackTrace();
		  }
		  return result;
	  }
	  
  public boolean login(LoginVO vo)  {//로그인기능
	  String dbpw="";
	  ResultSet rs =  null;
	  try {
		
		Class.forName
		("oracle.jdbc.driver.OracleDriver"); 
		Connection con = DriverManager.getConnection
		("jdbc:oracle:thin:@localhost:1521:xe", 	"mic", "mic");
		String sql = "select password from member where email=?";
		
		PreparedStatement pt = con.prepareStatement(sql);
		pt.setString(1,  vo.getEmail());
		rs = pt.executeQuery();
		
		if(rs.next()) {
			dbpw = rs.getString("password");
		}
		
		con.close();
	  }
	  catch(Exception e) {
		e.printStackTrace();
		return false;
	  } 
	  System.out.println(vo.getEmail()+":"+vo.getPassword()+":'"+dbpw+"'");
	  if(dbpw.equals(vo.getPassword())) {
		return true;
	  } else {
		return false;
	  }		
  }
}
