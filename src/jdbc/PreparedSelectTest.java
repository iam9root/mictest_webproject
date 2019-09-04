package jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class PreparedSelectTest {

	public static void main(String[] args) {
		Connection con = null;
		//1.jdbc driver(=클래스) 등록
		try{
			Class.forName("oracle.jdbc.driver.OracleDriver"); //외부 라이브러리 등록
			//2. db정보 맞는 db연결
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","mic","mic");
			System.out.println("DB 연결 성공");
			
			//3. sql
			String memcntsql = "select count(*) from member";
			String memsql = "select * from member";
			
			//4. Statement
			Statement cntst = con.createStatement();
			ResultSet cntrs = cntst.executeQuery(memcntsql); //카운트 결과 저장
			
			/*
			 * while(cntrs.next()) { //int row = cntrs.getInt(1); //System.out.println(row);
			 * System.out.println(cntrs); }
			 */
			
//			
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(memsql); 
//			
//			//5. 실행-출력
			int cnt = 0;
			while(rs.next()) {
				String email = rs.getString("email");
				String nickname = rs.getString("nickname");
//				String name = rs.getString("name");
//				String phone = rs.getString("phone");
//				String email = rs.getString("email");
//				Date date = rs.getDate("joindate");
//				int gender = rs.getInt("gender");
//				System.out.println
//				( id + ":" + pw + ":" + name + ":" + phone + ":" + email + ":" + date + ":" + gender);
//				cnt++;
				System.out.println(email +"\t\t"+ nickname);
			} //while end
			
			
			} catch (ClassNotFoundException e){
				System.out.println("ojdbc6.jar 없거나 클래스명 확인하세요");
			} catch(SQLException e) {
				System.out.println("연결정보를 화인하세요");
				e.printStackTrace();
			} finally {
				System.out.println();
			}
		
		
		

	}

}
