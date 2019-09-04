package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.MemberVO;
import vo.ReplyVO;

public class MemberDAO {
	//모든 회원정보
	public ArrayList<MemberVO> getMemberlist(){
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		ArrayList<MemberVO> list = new ArrayList<MemberVO>();
		
		MemberVO vo = null;
		
		try {
			System.out.println("접속시작");
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("driver loaded");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("db connection");
			pt = con.prepareStatement
			("select * from member order by m_like desc");

			rs = pt.executeQuery();
			System.out.println("query success");
			while(rs.next()) {
				vo = new MemberVO();
				System.out.println("MemberVO create");
				vo.setEmail(rs.getString("email"));
				vo.setNickname(rs.getString("nickname"));
				vo.setJoindate(rs.getDate("joindate"));
				vo.setGender(rs.getInt("gender"));
				vo.setUser_level(rs.getInt("user_level"));
				vo.setBirthyear(rs.getInt("birthyear"));
				vo.setM_like(rs.getInt("m_like"));
				vo.setProfile_img(rs.getString("profile_img"));
				
				list.add(vo);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			con.close();
			}catch(SQLException e) {}
		}
		return list;
	}
	
	//email에 맞는 회원정보 가져오기
	public MemberVO getMember(String email) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		
		MemberVO vo = null;
		
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("driver loaded");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("db connection");
			pt = con.prepareStatement
			("select * from member where email=?");
			pt.setString(1, email);
			rs = pt.executeQuery();
			System.out.println("query success");
			if(rs.next()) {
				vo = new MemberVO();
				System.out.println("MemberVO create");
				vo.setEmail(rs.getString("email"));
				vo.setNickname(rs.getString("nickname"));
				vo.setJoindate(rs.getDate("joindate"));
				vo.setGender(rs.getInt("gender"));
				vo.setUser_level(rs.getInt("user_level"));
				vo.setBirthyear(rs.getInt("birthyear"));
				vo.setM_like(rs.getInt("m_like"));
				vo.setProfile_img(rs.getString("profile_img"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			con.close();
			}catch(SQLException e) {}
		}
		return vo;
	}
	
	//회원가입
	/*
	 * public void insertMember(MemberVO vo) { Connection con = null;
	 * PreparedStatement pt = null;
	 * 
	 * try { Class.forName ("oracle.jdbc.driver.OracleDriver");
	 * System.out.println("driver loaded"); con = DriverManager.getConnection
	 * ("jdbc:oracle:thin:@localhost:1521:xe", "mic", "mic");
	 * System.out.println("db connection"); pt = con.prepareStatement
	 * ("insert into member values(?,?,?,sysdate,?,null,?,0,?)"); pt.setString(1,
	 * vo.getEmail()); pt.setString(2, vo.getNickname()); pt.setString(3,
	 * vo.getPassword()); pt.setInt(4, vo.getGender()); pt.setInt(5,
	 * vo.getBirthyear()); pt.setString(6, vo.getProfile_img());
	 * 
	 * pt.executeUpdate(); System.out.println("query success");
	 * 
	 * }catch(Exception e) { e.printStackTrace(); }finally { try { con.close();
	 * }catch(SQLException e) {} } }
	 */
	
	//m_like +1
	public void setMlike(String writer) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("driver loaded");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("db connection");
			//1. m_like 가져오기
			pt = con.prepareStatement
					("select m_like from member where email=?");
			pt.setString(1, writer);
			rs = pt.executeQuery();
			
			//2. m_like+1
			if(rs.next()) {
				pt = con.prepareStatement
				("update member set m_like=? where email=?");
				pt.setInt(1, rs.getInt("m_like")+1);
				pt.setString(2, writer);
				
				pt.executeUpdate();
				System.out.println("query success");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			con.close();
			}catch(SQLException e) {}
		}
	}
	
}
