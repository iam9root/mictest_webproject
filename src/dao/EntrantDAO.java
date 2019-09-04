package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import vo.EntrantVO;

public class EntrantDAO {
	//진출자명단 가져오기
	public EntrantVO getEntrant(int round) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		
		EntrantVO vo = null;
		
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버로딩완료");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("db커넥션완료");
			pt = con.prepareStatement
			("select * from entrant where round=?");
			pt.setInt(1, round);
			
			rs = pt.executeQuery();			
			System.out.println("쿼리완료");
			
			if(rs.next()) {
				vo = new EntrantVO();
				vo.setStartdate(rs.getString("Startdate"));
				vo.setFinishdate(rs.getString("finishdate"));
				vo.setRound(rs.getInt("round"));
				vo.setNames(rs.getString("names"));
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
	
	//진출자명단 수정
	public int updateEntrant(String startdate, String finishdate, int round, String names) {
		int result=0;
		
		Connection con = null;
		PreparedStatement pt = null;
		
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버로딩완료");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("db커넥션완료");
			pt = con.prepareStatement
			("update entrant set startdate=?,finishdate=?,names=? where round=?");
			pt.setString(1, startdate);
			pt.setString(2, finishdate);
			pt.setString(3, names);
			pt.setInt(4, round);
			
			pt.executeUpdate();
			System.out.println("쿼리완료");
			result=1;
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			con.close();
			}catch(SQLException e) {}
		}
		
		return result;
	}
}
