package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
				String dbURL="jdbc:mariadb://localhost:3306/bbs?serverTimezone=UTC";
				String dbID="root";
				String dbPassword="1234";
				Class.forName("org.mariadb.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
				System.out.println("커넥션 생성");
		}catch (Exception e) {
			System.out.println("커넥션 가져오기 실패");
			e.printStackTrace();
		}
	}
	
	
	public int login(String userID, String userPassword) {
		String sql = "select userPassword from user where userID = ?";
		try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					if(rs.getString(1).equals(userPassword))
					{
						return 1;
					}else
						return 0;
				}
				return -1;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	
	public int join(User user) {
		String sql="insert into user values(?, ?, ? ,?)";
		try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, user.getUserID());
				pstmt.setString(2, user.getUserPassword());
				pstmt.setString(3, user.getUserAddress());
				pstmt.setString(4, user.getUserPhone_number());
				return pstmt.executeUpdate();
				
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1 ;
	}
}











