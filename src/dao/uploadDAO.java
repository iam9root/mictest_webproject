package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import vo.uploadVO;

// album테이블  sql 삽입 구문
// insert into album values(1, album_seq.nextval, 'asd', 'ew','asd','ew','asd','b','qew','ew');
/*

FILE_TITLE                                NOT NULL VARCHAR2(150)
FILE_SINGER                               NOT NULL VARCHAR2(60)
ALBUM_IMG                                          VARCHAR2(4000)
ALBUM_TITLE                               NOT NULL VARCHAR2(150)
EMAIL                                     NOT NULL VARCHAR2(50)
FILE_NAME                                 NOT NULL VARCHAR2(150)
ALBUM_NAME*/
public class uploadDAO {
	//회원가입기능
	  public boolean insertMember(uploadVO vo)  {
		  System.out.println("1");
		  
		  ResultSet rs =  null;
		  try {
			  System.out.println();
			  
			  	Class.forName("oracle.jdbc.driver.OracleDriver"); 
				Connection con = DriverManager.getConnection
				("jdbc:oracle:thin:@localhost:1521:xe", 	"mic", "mic");
				String sql = "insert into album values(1,album_seq.nextval,?,?,?,?,?,'b',?,?)";
				
				System.out.println("2");
				
				//String sql = "insert into member values(?,'b','1',sysdate,'1',' ','1','0',' ')";
				
				PreparedStatement pt = con.prepareStatement(sql);
				
				System.out.println("3");
				
				pt.setString(1,  vo.getMusicUploadPath());			
				pt.setString(2, vo.getMusicname()); 
				pt.setString(3, vo.getArtist());
				pt.setString(4, vo.getAlbumUploadPath());
				pt.setString(5, vo.getAlbumname());
				// 이메일 추가 pt.setString(7, vo.get());
				pt.setString(6, vo.getMusicUploadPath());
				pt.setString(7, vo.getAlbumUploadPath());
			 
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
		  if(1==1) {

			  return true;
		  } else {
			  return false;
		  }	
	  }
}