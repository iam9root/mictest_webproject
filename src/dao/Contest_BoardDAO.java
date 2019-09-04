package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Contest_BoardVO;

public class Contest_BoardDAO {
	//���庰 ���׽�Ʈ ����Ʈ ��������
	public ArrayList<Contest_BoardVO> getContest_BoardList(int round) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		ArrayList<Contest_BoardVO> list = new ArrayList<Contest_BoardVO>();
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("����̹��ε��Ϸ�");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("dbĿ�ؼǿϷ�");
			pt = con.prepareStatement
			("select * from contest_board where round=?");
			pt.setInt(1, round);
			rs = pt.executeQuery();
			System.out.println("�����Ϸ�");
			while(rs.next()) {
				Contest_BoardVO vo = new Contest_BoardVO();
				System.out.println("BoardVO��ü���� �Ϸ�");
				vo.setContest_seq(rs.getInt("contest_seq"));
				vo.setC_title(rs.getString("c_title"));
				vo.setC_contents(rs.getString("c_contents"));
				vo.setWriter(rs.getString("writer"));				
				vo.setC_viewcount(rs.getInt("c_viewcount"));
				vo.setC_like(rs.getInt("c_like"));
				vo.setCdate(rs.getDate("cdate"));
				vo.setRound(rs.getInt("round"));
				vo.setC_file(rs.getInt("c_file"));
				
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
	
	//���׽�Ʈ ��ȣ�� �´� �������� ��ȸ�� ����
	public int setViewcount(int contestNo) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		Contest_BoardVO vo = null;
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("����̹��ε��Ϸ�");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("dbĿ�ؼǿϷ�");
			
			pt = con.prepareStatement
			("select * from contest_board where contest_seq=?");
			pt.setInt(1, contestNo);
			rs = pt.executeQuery();
			System.out.println("�����Ϸ�");

			rs.next();
			pt = con.prepareStatement
			("update contest_board set c_viewcount=? where contest_seq=?");
			pt.setInt(1, rs.getInt("c_viewcount")+1);
			pt.setInt(2, contestNo);
			pt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			con.close();
			}catch(SQLException e) {}
		}
		return 1;
	}
	
	//���׽�Ʈ��ȣ�� �´� ������ ��������
	public Contest_BoardVO getContest_Board(int contestNo) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;
		Contest_BoardVO vo = null;
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("����̹��ε��Ϸ�");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("dbĿ�ؼǿϷ�");
			
			pt = con.prepareStatement
			("select * from contest_board where contest_seq=?");
			pt.setInt(1, contestNo);
			rs = pt.executeQuery();
			System.out.println("�����Ϸ�");

			rs.next();			
			vo = new Contest_BoardVO();
			System.out.println("BoardVO��ü���� �Ϸ�");
			vo.setContest_seq(rs.getInt("contest_seq"));
			vo.setC_title(rs.getString("c_title"));
			vo.setC_contents(rs.getString("c_contents"));
			vo.setWriter(rs.getString("writer"));
			vo.setC_viewcount(rs.getInt("c_viewcount"));
			vo.setC_like(rs.getInt("c_like"));
			vo.setCdate(rs.getDate("cdate"));
			vo.setC_file(rs.getInt("c_file"));
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			con.close();
			}catch(SQLException e) {}
		}
		return vo;
	}
	
	//������û
	public int insertContest_Board(String c_title, String c_contents, String writer, int c_file) {
		Connection con = null;
		PreparedStatement pt = null;
		
		try {
			Class.forName
			("oracle.jdbc.driver.OracleDriver");
			System.out.println("����̹��ε��Ϸ�");
			con = DriverManager.getConnection
			("jdbc:oracle:thin:@localhost:1521:xe",
				"mic", "mic");
			System.out.println("dbĿ�ؼǿϷ�");
			
			pt = con.prepareStatement
			("insert into contest_board values(contest_board_seq.nextval,?,?,?,0,0,sysdate,1,?)");
			
			pt.setString(1, c_title);
			pt.setString(2, c_contents);
			pt.setString(3, writer);
			pt.setInt(4, c_file);
			
			pt.executeUpdate();
			System.out.println("�����Ϸ�");
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			con.close();
			}catch(SQLException e) {}
		}
		return 1;
	}
	
	//like++
		public int setClike(int contestNo) {
			Connection con = null;
			PreparedStatement pt = null;
			ResultSet rs = null;
			try {
				Class.forName
				("oracle.jdbc.driver.OracleDriver");
				System.out.println("����̹��ε��Ϸ�");
				con = DriverManager.getConnection
				("jdbc:oracle:thin:@localhost:1521:xe",
					"mic", "mic");
				System.out.println("dbĿ�ؼǿϷ�");
				
				pt = con.prepareStatement
				("select * from contest_board where contest_seq=?");
				pt.setInt(1, contestNo);
				rs = pt.executeQuery();
				System.out.println("�����Ϸ�");

				if(rs.next()) {
					pt = con.prepareStatement
					("update contest_board set c_like=? where contest_seq=?");
					pt.setInt(1, rs.getInt("c_like")+1);
					pt.setInt(2, contestNo);
				}
				pt.executeUpdate();
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
				con.close();
				}catch(SQLException e) {}
			}
			return 1;
		}
		
		//ranking per round
		public ArrayList<Contest_BoardVO> getContest_BoardRankList(int round) {
			Connection con = null;
			PreparedStatement pt = null;
			ResultSet rs = null;
			ArrayList<Contest_BoardVO> list = new ArrayList<Contest_BoardVO>();
			try {
				Class.forName
				("oracle.jdbc.driver.OracleDriver");
				System.out.println("����̹��ε��Ϸ�");
				con = DriverManager.getConnection
				("jdbc:oracle:thin:@localhost:1521:xe",
					"mic", "mic");
				System.out.println("dbĿ�ؼǿϷ�");
				pt = con.prepareStatement
				("select contest_seq, writer, c_like, round, c_file from contest_board where round=? order by c_like desc");
				pt.setInt(1, round);
				rs = pt.executeQuery();
				System.out.println("�����Ϸ�");
				while(rs.next()) {
					Contest_BoardVO vo = new Contest_BoardVO();
					System.out.println("BoardVO��ü���� �Ϸ�");
					vo.setContest_seq(rs.getInt("contest_seq"));
					vo.setWriter(rs.getString("writer"));		
					vo.setC_like(rs.getInt("c_like"));
					vo.setC_file(rs.getInt("c_file"));
					vo.setRound(rs.getInt("round"));
					
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
		
		//update round
		public void setRound(int round, int contest_seq) {
			Connection con = null;
			PreparedStatement pt = null;
			try {
				Class.forName
				("oracle.jdbc.driver.OracleDriver");
				System.out.println("����̹��ε��Ϸ�");
				con = DriverManager.getConnection
				("jdbc:oracle:thin:@localhost:1521:xe",
					"mic", "mic");
				System.out.println("dbĿ�ؼǿϷ�");
				pt = con.prepareStatement
				("update contest_board set round=? where contest_seq=?");
				pt.setInt(1, round);
				pt.setInt(2, contest_seq);

				pt.executeUpdate();
				System.out.println("�����Ϸ�");
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
				con.close();
				}catch(SQLException e) {}
			}
		}
}
