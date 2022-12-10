package bbs;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;



public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
//	기본생성자
	public BbsDAO() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/bbs";
			String dbID = "root";
			String dbPassword="1234";
			Class.forName ("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
//	날짜 부여 메소드
	public String getDate() {
		String sql = "select now()";
		try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getString(1);
				}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
//	게시글 번호 부여 메소드
	public int getNext() {
//		현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String sql = "select bbsID from bbs order by bbsID desc";
		try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					return rs.getInt(1) + 1;
				}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 1; //첫번째 게시글인 경우
	}

	public int write(int boardID, String bbsTitle, String userID, String bbsContent) {
		String sql = "insert into bbs values(?, ?, ?, ?, ?, ?, ?)";
		try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boardID);
				pstmt.setInt(2, getNext());
				pstmt.setString(3, bbsTitle);
				pstmt.setString(4, userID);
				pstmt.setString(5, getDate());
				pstmt.setString(6, bbsContent);
				pstmt.setInt(7, 1); //글의 유효번호
				pstmt.executeUpdate();
				return getNext();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1; //데이터베이스 오류
	}
	
	//게시글 리스트 메소드
	public ArrayList<Bbs> getList(int boardID, int pageNumber) {
		String sql = "select * from bbs where boardID =? AND bbsID <? and bbsAvailable = 1 order by bbsID desc limit 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boardID);
				pstmt.setInt(2, getNext() - (pageNumber -1 ) * 10);
				rs = pstmt.executeQuery(); 
				while(rs.next()) {
					Bbs bbs = new Bbs();
					bbs.setBoardID(rs.getInt(1));	
					bbs.setBbsID(rs.getInt(2));
					bbs.setBbsTitle(rs.getString(3));
					bbs.setUserID(rs.getString(4));
					bbs.setBbsDate(rs.getString(5));
					bbs.setBbsContent(rs.getString(6));
					bbs.setBbsAvailable(rs.getInt(7));
					list.add(bbs);
				}
		} catch (Exception e) {
				e.printStackTrace();
		}
		return list;
	}
//	페이징 처리 메소드 
	public boolean nextPage(int boardID, int pageNumber) {
		String sql = "select * from bbs where boardID=? and bbsID <? and bbsAvailable = 1";
		try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, boardID);
				pstmt.setInt(2, getNext()- (pageNumber - 1) * 10);
				rs= pstmt.executeQuery();
				while(rs.next()) {
					return true;
				}
		} catch (Exception e) {
				e.printStackTrace();
		}
		return false;
	}

	public Bbs getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBoardID(rs.getInt(1));
				bbs.setBbsID(rs.getInt(2));
				bbs.setBbsTitle(rs.getString(3));
				bbs.setUserID(rs.getString(4));
				bbs.setBbsDate(rs.getString(5));
				bbs.setBbsContent(rs.getString(6));
				bbs.setBbsAvailable(rs.getInt(7));
				return bbs;
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String sql = "update bbs set bbsTitle =?, bbsContent =? where bbsID like?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, bbsContent);
			
			return pstmt.executeUpdate();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터 베이스 오류
	}
	
	public int delete(int bbsID) {
		String sql = "delete from bbs where bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터 베이스 오류
	}
}


















