package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Contest_BoardVO;
import vo.ReplyVO;

public class ReplyDAO {
	//contestNo에 맞는 댓글수
	/*
	 * public int getCount(int cf, int board_seq) { int count=0;
	 * 
	 * Connection con = null; PreparedStatement pt = null; ResultSet rs = null;
	 * ArrayList<ReplyVO> list = new ArrayList<ReplyVO>(); try { Class.forName
	 * ("oracle.jdbc.driver.OracleDriver"); System.out.println("드라이버로딩완료"); con =
	 * DriverManager.getConnection ("jdbc:oracle:thin:@localhost:1521:xe", "mic",
	 * "mic"); System.out.println("db커넥션완료"); pt = con.prepareStatement
	 * ("select count(*) from Reply where c_0_f_1=? and board_seq=?"); pt.setInt(1,
	 * cf); pt.setInt(2, board_seq); rs = pt.executeQuery();
	 * System.out.println("쿼리완료"); rs.next(); count = rs.getInt("count(*)");
	 * }catch(Exception e) { e.printStackTrace(); }finally { try { con.close();
	 * }catch(SQLException e) {} } return count; }
	 */
	
	//contestNo에 맞는 댓글
	public ArrayList<ReplyVO> getReply(int cf, int board_seq) {
		
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		ArrayList<ReplyVO> list = new ArrayList<ReplyVO>();
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버로딩완료");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("db커넥션완료");
			pt = con.prepareStatement
			("select * from Reply where c_0_f_1=? and board_seq=?");
			pt.setInt(1, cf);
			pt.setInt(2, board_seq);
			rs = pt.executeQuery();
			System.out.println("쿼리완료");
			while(rs.next()) {
				ReplyVO vo = new ReplyVO();
				System.out.println("ReplyVO객체생성 완료");
				vo.setC_0_f_1(rs.getInt("c_0_f_1"));
				vo.setBoard_seq(rs.getInt("board_seq"));
				vo.setCm_seq(rs.getInt("cm_seq"));
				vo.setCm_contents(rs.getString("cm_contents"));
				vo.setWriter(rs.getString("writer"));
				vo.setCmdate(rs.getDate("cmdate"));
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
	
	//댓글입력
	public int insertComment(int cf, int board_seq, String cm_contents, String writer) {
		Connection con = null;
		PreparedStatement pt = null;
		
		int result=0;
		
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버로딩완료");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("db커넥션완료");
			pt = con.prepareStatement
			("insert into reply values(?,?,reply_seq.nextval,?,?,sysdate)");
			pt.setInt(1, cf);
			pt.setInt(2, board_seq);
			pt.setString(3, cm_contents);
			pt.setString(4, writer);
			
			pt.executeUpdate();
			System.out.println("쿼리완료");			
			
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
