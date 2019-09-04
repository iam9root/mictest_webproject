package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.MelMusicVO;

public class MelMusicDAO {
	String driver, url, account, dbpw;
	MelMusicVO mmvo = null;
	ArrayList<MelMusicVO> list = null;

	//db에 연결하는 생성자 | Constructor of connecting to DB
	public MelMusicDAO(String driver, String url, String account, String dbpw) {
		this.driver = driver;
		this.url = url;
		this.account = account;
		this.dbpw = dbpw;
	}
	
	//부른 사람수대로 인기차트
	public ArrayList<MelMusicVO> popularChart() {
		list = new ArrayList<MelMusicVO>();
		try {
			Class.forName(driver);
			
			Connection conn = DriverManager.getConnection(url, account, dbpw);

			String sql = "select * from MEL_MUSIC where numberofsingusers != 0 order by numberofsingusers desc";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				mmvo = new MelMusicVO();
				mmvo.setMusic_seq(rs.getInt("music_seq"));
				mmvo.setReal_singer(rs.getString("real_singer"));
				mmvo.setReal_title(rs.getString("real_title"));
				mmvo.setReal_album(rs.getString("real_album"));
				mmvo.setNumberofsingusers(rs.getInt("numberofsingusers"));
				list.add(mmvo);
			}

			conn.close();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
/////////////////////////////////////////////////////////////////////////////////////////////////////
// file 업로드할 때 mel_music 마지막 컬럼+1 하기 위해 numberofsingusers 불러오기
/*
* String sql =
* "select numberofsingusers from mel_music where real_title like ? and real_singer = ?"
* ; pt = con.prepareStatement(sql); pt.setString(1, "%"+file_title+"%");
* pt.setString(2, file_singer); ResultSet rs = pt.executeQuery(); int
* numberofsingusers = 0;
* 
* // 불러온 컬럼 ++ if(rs.next()) { numberofsingusers =
* rs.getInt("numberofsingusers"); } numberofsingusers++;
* 
* // numberofsingusers++ 적용 sql =
* "update mel_music set numberofsingusers = ? where real_title like ? and real_singer = ?"
* ; pt = con.prepareStatement(sql); pt.setInt(1, numberofsingusers);
* pt.setString(2, "%"+file_title+"%"); pt.setString(3, file_singer); rs =
* pt.executeQuery();
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
}
