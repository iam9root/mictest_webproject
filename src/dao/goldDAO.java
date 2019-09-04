package dao;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.FreeBoardVO;
import vo.goldVO;

public class goldDAO {
	/*@@@@@@@@@@@@@@ 골든마이크 @@@@@@@@@@@@@@@@@*/
	public goldVO goldMic() {
		goldVO gvo = null;

		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbid = "mic";
		String dbpw = "mic";
		try {
			Class.forName(dbdriver);
			Connection conn = DriverManager.getConnection(dburl,dbid,dbpw);
			
			/*가장 높은 c_like 받은사람 닉네임*/
			String sql = "select nickname from member where email in (select writer from (select * from contest_board order by c_like desc) where rownum =1)";
			/*가장 높은 c_like 받은 사람이 부른 노래 제목, 가수, 파일 경로*/
			String sql2 = "select file_singer, file_title, file_name from album where email in (select writer from (select * from contest_board order by c_like desc) where rownum =1)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			PreparedStatement ps2 = conn.prepareStatement(sql2);
			ResultSet rs2 = ps2.executeQuery();
			
			if(rs.next()) {
				gvo = new goldVO();
				
				gvo.setNick(rs.getString("nickname"));
				if(rs2.next()) {
				gvo.setArtist_Name(rs2.getString("file_singer"));
				gvo.setMusic_Name(rs2.getString("file_title"));
				gvo.setFile_name(rs2.getString("file_name"));
				}
			}
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	return gvo;
	
	}
	/*@@@@@@@@@@@@@@@ 파이널 진출자 @@@@@@@@@@@@@@@@@@  */
	public ArrayList<goldVO> micfinal() {
		goldVO gvo2 = null;
		ArrayList<goldVO> hf = new ArrayList<goldVO>();
			
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbid = "mic";
		String dbpw = "mic";
		
		try {
			Class.forName(dbdriver);
			Connection conn = DriverManager.getConnection(dburl,dbid,dbpw);
			
			/*가장 높은 c_like 받은사람 닉네임*/
			String sql = "select nickname, profile_img from member where email in (select writer from (select * from contest_board order by c_like desc) where rownum <=3)";
			/*가장 높은 c_like 받은 사람이 부른 노래 제목, 가수, 파일 경로*/
			/*
			 * String sql2 =
			 * "select * from album where email in (select writer from (select * from contest_board order by c_like desc) where rownum <=3)"
			 * ;
			 */
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			/*
			 * PreparedStatement ps2 = conn.prepareStatement(sql2); ResultSet rs2 =
			 * ps2.executeQuery();
			 */
			
			while(rs.next()) {
				gvo2 = new goldVO();
				
				gvo2.setNick(rs.getString("nickname"));
				
				gvo2.setProfile_Img(rs.getString("profile_img"));
				
							
				/*
				 * if(rs2.next()) { gvo2.setArtist_Name(rs2.getString("file_singer"));
				 * gvo2.setMusic_Name(rs2.getString("file_title"));
				 * gvo2.setFile_name(rs2.getString("file_name"));
				 * 
				 * }
				 */
				hf.add(gvo2);
			}
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return hf;
	}

	
	
	
}

