package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.AlbumVO;
import vo.Contest_BoardVO;

public class AlbumDAO {
	// c_file�� �´� file_seq �������� ��������
	public AlbumVO getAlbum(int c_file) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;

		AlbumVO vo = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("����̹��ε��Ϸ�");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mic", "mic");
			System.out.println("dbĿ�ؼǿϷ�");
			pt = con.prepareStatement("select * from album where file_seq=?");
			pt.setInt(1, c_file);
			rs = pt.executeQuery();
			System.out.println("�����Ϸ�");
			if (rs.next()) {
				vo = new AlbumVO();
				System.out.println("VO��ü���� �Ϸ�");
				vo.setAlbum_seq(rs.getInt("album_seq"));
				vo.setFile_seq(rs.getInt("file_seq"));
				vo.setFile_path(rs.getString("file_path"));
				vo.setFile_title(rs.getString("file_title"));
				vo.setFile_singer(rs.getString("file_singer"));
				vo.setAlbum_img(rs.getString("album_img"));
				vo.setAlbum_title(rs.getString("album_title"));
				vo.setEmail(rs.getString("email"));
				vo.setFile_name(rs.getString("file_name"));
				vo.setAlbum_name(rs.getString("album_name"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
			}
		}
		return vo;
	}

	// ���ε����� ����
	public void insertFile(int album_seq, String file_path, String file_title, String file_singer, String album_img,
			String album_title, String email, String file_name, String album_name) {

		Connection con = null;
		PreparedStatement pt = null;

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("driver loaded");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mic", "mic");
			System.out.println("db connection");
			pt = con.prepareStatement("insert into album values(?,album_seq.nextval,?,?,?,?,?,?,?,?)");
			pt.setInt(1, album_seq);
			pt.setString(2, file_path);
			pt.setString(3, file_title);
			pt.setString(4, file_singer);
			pt.setString(5, album_img);
			pt.setString(6, album_title);
			pt.setString(7, email);
			pt.setString(8, file_name);
			pt.setString(9, album_name);

			pt.executeUpdate();

			/////////////////////////////////////////////////////////////////////////////////////////////////////
			// file �뾽濡쒕뱶�븷 �븣 mel_music 留덉�留� 而щ읆+1 �븯湲� �쐞�빐 numberofsingusers 遺덈윭�삤湲�
			String sql = "select * from mel_music where real_title like ? and real_singer = ?";
			pt = con.prepareStatement(sql);
			pt.setString(1, file_title);
			pt.setString(2, file_singer);
			ResultSet rs = pt.executeQuery();
			int numberofsingusers = 0;

			// 遺덈윭�삩 而щ읆 ++
			if (rs.next()) {
				numberofsingusers = rs.getInt("numberofsingusers");
			}
			numberofsingusers++;
			System.out.println(file_title + " - " + file_singer + " - " + file_name);
			System.out.println("numberofsingusers : " + numberofsingusers);

			// numberofsingusers++ �쟻�슜
			sql = "update mel_music set numberofsingusers = ? where real_title like ? and real_singer = ?";
			pt = con.prepareStatement(sql);
			pt.setInt(1, numberofsingusers);
			pt.setString(2, file_title);
			pt.setString(3, file_singer);
			rs = pt.executeQuery();
			///////////////////////////////////////////////////////////////////////////////////////////////////

			System.out.println("query success");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
			}
		}
	}

	// id���� �´� �ٹ�����Ʈ ��������
	public ArrayList<AlbumVO> getAlbumList(String email) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;

		AlbumVO vo = null;
		ArrayList<AlbumVO> list = new ArrayList<AlbumVO>();

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("����̹��ε��Ϸ�");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mic", "mic");
			System.out.println("dbĿ�ؼǿϷ�");
			pt = con.prepareStatement("select * from album where email=?");
			pt.setString(1, email);
			rs = pt.executeQuery();
			System.out.println("�����Ϸ�");

			while (rs.next()) {
				vo = new AlbumVO();
				System.out.println("VO��ü���� �Ϸ�");
				vo.setAlbum_seq(rs.getInt("album_seq"));
				vo.setFile_seq(rs.getInt("file_seq"));
				vo.setFile_path(rs.getString("file_path"));
				vo.setFile_title(rs.getString("file_title"));
				vo.setFile_singer(rs.getString("file_singer"));
				vo.setAlbum_img(rs.getString("album_img"));
				vo.setAlbum_title(rs.getString("album_title"));
				vo.setEmail(rs.getString("email"));
				vo.setFile_name(rs.getString("file_name"));
				vo.setAlbum_name(rs.getString("album_name"));

				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
			}
		}
		return list;
	}
	
	//who am i?
	public ArrayList<AlbumVO> getSingerPercent(String email) {
		Connection con = null;
		PreparedStatement pt = null;
		ResultSet rs = null;

		AlbumVO vo = null;
		ArrayList<AlbumVO> list = new ArrayList<AlbumVO>();

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "mic", "mic");
			pt = con.prepareStatement("select count(*) as count from album where email = ?");
			pt.setString(1, email);
			rs = pt.executeQuery();
			
			int totalMySong = 0; //내앨범에 등록되어 있는 모든 노래 수
			int eachSong = 0; //가수 각각의 노래 개수
			double percent = 0;
			if (rs.next()) {
				totalMySong = rs.getInt("count");
			}
			System.out.print("query done. count = " + totalMySong);
			
			//select count(file_singer) sc, file_singer from album where email = 'user1@kitri.com' group by file_singer;
			pt = con.prepareStatement("select count(file_singer) as sc, file_singer from album where email = ? group by file_singer");
			pt.setString(1, email);
			rs = pt.executeQuery();
			
			while (rs.next()) {
				vo = new AlbumVO();
				eachSong = rs.getInt(1);
				System.out.println(", query done. eachSong = " + eachSong);
				
				//calculate percent
				percent = 100.0 * eachSong / totalMySong;
				System.out.println("percent = " + percent);
				
				vo.setCountEachSinger(percent);
				vo.setFile_singer(rs.getString("file_singer"));

				list.add(vo);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
			}
		}
		return list;
	}
	
}
