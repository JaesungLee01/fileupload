<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int boardFileNo = Integer.parseInt(request.getParameter("boardFileNo"));
	
	String driver = "org.mariadb.jdbc.Driver";
	String dburl = "jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbuser = "root";
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = null;
	conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	
	String sql = "SELECT b.board_no boardNo, b.board_title boardTitle, f.board_file_no boardFileNo, f.origin_filename originFilename FROM board b INNER JOIN board_file f ON b.board_no = f.board_no WHERE b.board_no=? AND f.board_file_no=?";
	
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setInt(1, boardNo);
	stmt.setInt(2, boardFileNo);
	ResultSet rs = stmt.executeQuery();
	
	HashMap<String, Object> map = null;
	if(rs.next()) {
		map = new HashMap<>();
   
		map.put("boardNo",rs.getString("boardNo"));
		map.put("boardTitle",rs.getString("boardTitle"));
		map.put("boardFileNo",rs.getString("boardFileNo"));
		map.put("originFilename",rs.getString("originFilename"));
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, th, td{
		border : 1px solid #FF0000;
	}
</style>
</head>
<body>
	<h1>board & boardFile 수정</h1>
	<form action="<%=request.getContextPath()%>/modifyBoardAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="boardNo" value="<%=map.get("boardNo")%>">
		<input type="hidden" name="boardFileNo" value="<%=map.get("boardFileNo")%>">
		<table>
			<tr>
				<th>제목</th>
				<td>
					<textarea rows="3" cols="5" name="boardTitle" required="required"><%=map.get("boardTitle")%></textarea>
				</td>
			</tr>
			<tr>
				<th>파일(수정전 파일 : <%=map.get("originFilename")%>)</th>
				<td>
					<input type="file" name="boardFile">
				</td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
</body>
</html>