<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 성공</title>
</head>
<body>
	<%
		String mid = request.getParameter("id");
		String mpw = request.getParameter("pw");
		String mname = request.getParameter("name");
		String memail = request.getParameter("email");
	%>
	<%
		String driverName = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/jsp_testdb";
		String userName = "root";
		String password = "1234";
		// String sql = "INSERT INTO members(id, pw, name, email) VALUES ('"+mid+"', '"+mpw+"', '"+mname+"', '"+memail+"')";
		String sql = "INSERT INTO members(id, pw, name, email) VALUES(?,?,?,?)";
							
		Connection conn = null; 
		PreparedStatement pstmt = null;
				
		try {
			Class.forName(driverName); // 드라이버 로딩			
			conn = DriverManager.getConnection(url, userName, password); // 연결생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, mpw);
			pstmt.setString(3, mname);
			pstmt.setString(4, memail);
			
			int dbFlag = pstmt.executeUpdate(); // sql문 실행
			// sql문이 성공적으로 실행되면 db에서 1이 반환되고, 아니면 다른 값
			if(dbFlag == 1) {
				out.println("회원가입성공!!");
			} else {
				out.println("회원가입실패!!");
			}
			
		} catch(ClassNotFoundException e) {
			out.println("드라이버 로딩 실패!!!");
		} catch(SQLException e) {
			out.println("DB 연결 실패!!!");
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();				
				}				
				if(conn != null) {
					conn.close();				
				}
			} catch(Exception e) {
				e.printStackTrace(); // 에러발생시 에러의 내용을 출력
			}
		}
	
	%>
</body>
</html>