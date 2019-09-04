package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.FreeBoardVO;

public class FreeBoardDAO {
	String driver, url, account, dbpw;
	ArrayList<FreeBoardVO> fblist = new ArrayList<FreeBoardVO>();

	public FreeBoardDAO(String driver, String url, String account, String dbpw) {
		this.driver = driver;
		this.url = url;
		this.account = account;
		this.dbpw = dbpw;
	}

	/////// 자유게시판 insert
	public String freeBoardInsert(FreeBoardVO fbvo) {
		String result = "";

		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url, account, dbpw);

			String sql = "insert into free_board values(free_board_seq.nextval, ?, ?, ?, sysdate, 0, ?)";// category = 1(자유게시판)
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, fbvo.getF_title());
			ps.setString(2, fbvo.getF_contents());
			ps.setString(3, fbvo.getWriter());
			ps.setInt(4, fbvo.getCategory());
			ResultSet rs = ps.executeQuery();

			result = "작성한 글이 등록되었습니다.";

			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	/////// 자유게시판 목록 보기 List
	public ArrayList<FreeBoardVO> freeBoardList(int start, int end, int total) {
		FreeBoardVO fbvo = null;
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url, account, dbpw);
			
			/*select r, free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, nickname
			from
			(
				select rownum r, free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, nickname
				from 
				(
					select free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, m.nickname
					from free_board fb, MEMBER m
					where fb.writer = m.email and category = 1 
					order by free_seq desc
				)
				where rownum between 1 and 9
			)
			where r between 5 and 8*/
			
			
			String sql = "select r, free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, nickname "
						+ "from ( "
							+ "select rownum r, free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, nickname "
							+ "from ("
									+ "select free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, m.nickname "
									+ "from free_board fb, MEMBER m "
									+ "where fb.writer = m.email and category = 1 "
									+ "order by free_seq desc "
									+ ") "
							+ "where rownum between 1 and ? "
						+ ") "
						+ "where r between ? and ? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, total);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				fbvo = new FreeBoardVO();
				fbvo.setFree_board_seq(rs.getInt("free_seq"));
				fbvo.setF_title(rs.getString("f_title"));
				fbvo.setF_contents(rs.getString("f_contents"));
				fbvo.setWriter(rs.getString("writer"));
				fbvo.setFdate(rs.getString("fdate"));
				fbvo.setF_viewcount(rs.getInt("f_viewcount"));
				fbvo.setCategory(rs.getInt("category"));
				fbvo.setNickname(rs.getString("nickname"));
				fbvo.setBoardNum(rs.getInt("r"));

				fblist.add(fbvo);
				
			}

			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return fblist;
	}

	/////// 게시글 보기
	public ArrayList<FreeBoardVO> viewBoard(int idx) {
		FreeBoardVO fbvo = null;
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url, account, dbpw);

			//해당 게시글 불러오기
			String sql = "select free_seq, f_title, f_contents, writer, m.nickname, f_viewcount, category from free_board fb, member m where free_seq = ? and fb.writer = m.email";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				fbvo = new FreeBoardVO();
				fbvo.setFree_board_seq(rs.getInt("free_seq"));
				fbvo.setF_title(rs.getString("f_title"));
				fbvo.setF_contents(rs.getString("f_contents"));
				fbvo.setWriter(rs.getString("writer"));
				fbvo.setNickname(rs.getString("nickname"));
				fbvo.setCategory(rs.getInt("category"));
				
				//게시글을 눌렀으므로 viewcount를 +1 업데이트
				int viewcount = rs.getInt("f_viewcount");
				viewcount++;
				
				sql = "update free_board set f_viewcount = ? where free_seq = ?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, viewcount);
				ps.setInt(2, idx);
				ps.executeUpdate();		
				fbvo.setF_viewcount(viewcount);
				fblist.add(fbvo);
			}
			

			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return fblist;
	}
	
	/////// 자유게시판 delete
	public void freeBoardDelete(int idx) {
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url, account, dbpw);

			String sql = "delete from free_board where free_seq = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, idx);
			ResultSet rs = ps.executeQuery();

			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	////// 자유게시판 modify
	public void freeBoardModify(FreeBoardVO fbvo) {
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url, account, dbpw);

			String sql = "update free_board set f_title = ?, f_contents = ? where free_seq = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, fbvo.getF_title());
			ps.setString(2, fbvo.getF_contents());
			ps.setInt(3, fbvo.getFree_board_seq());
			ResultSet rs = ps.executeQuery();

			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/////// 공지게시판 목록 보기 List
	public ArrayList<FreeBoardVO> noticeBoardList(int start, int end, int total) {
		FreeBoardVO fbvo = null;
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url, account, dbpw);
			
			String sql = "select r, free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, nickname "
						+ "from ( "
							+ "select rownum r, free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, nickname "
							+ "from ("
									+ "select free_seq, f_title, f_contents, writer, fdate, f_viewcount, category, m.nickname "
									+ "from free_board fb, MEMBER m "
									+ "where fb.writer = m.email and category = 0 "
									+ "order by free_seq desc "
									+ ") "
							+ "where rownum between 1 and ? "
						+ ") "
						+ "where r between ? and ? ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, total);
			ps.setInt(2, start);
			ps.setInt(3, end);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				fbvo = new FreeBoardVO();
				fbvo.setFree_board_seq(rs.getInt("free_seq"));
				fbvo.setF_title(rs.getString("f_title"));
				fbvo.setF_contents(rs.getString("f_contents"));
				fbvo.setWriter(rs.getString("writer"));
				fbvo.setFdate(rs.getString("fdate"));
				fbvo.setF_viewcount(rs.getInt("f_viewcount"));
				fbvo.setCategory(rs.getInt("category"));
				fbvo.setNickname(rs.getString("nickname"));
				fbvo.setBoardNum(rs.getInt("r"));

				fblist.add(fbvo);
				
			}

			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return fblist;
	}
}
