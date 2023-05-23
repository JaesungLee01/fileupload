<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
	//db 접속
	String driver = "org.mariadb.jdbc.Driver";
	String dburl = "jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbuser = "root";
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	// board와 board_file 테이블 정보 조인하여 조회
	String sql = "SELECT b.board_no boardNo, b.board_title boardTitle, f.board_file_no boardFileNo, f.origin_filename originFilename, f.save_filename saveFilename, path FROM board b INNER JOIN board_file f ON b.board_no = f.board_no ORDER BY b.createdate DESC";
	PreparedStatement stmt = conn.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	// HashMap ArrayList에 조회한 값 저장
	ArrayList<HashMap<String, Object>> list = new ArrayList<>();
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<>();
		m.put("boardNo",rs.getInt("boardNo"));
		m.put("boardTitle",rs.getString("boardTitle"));
		m.put("boardFileNo",rs.getInt("boardFileNo"));
		m.put("originFilename",rs.getString("originFilename"));
		m.put("saveFilename",rs.getString("saveFilename"));
		m.put("path",rs.getString("path"));
		list.add(m);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<style>
	table, th, td{
		border : 1px solid #FF0000;
	}
</style>
</head>
<body>
	<div class="container">
	<h1>PDF자료 목록</h1>
	<div class="d-grid">
			<a href="<%=request.getContextPath()%>/addBoard.jsp">
				<button type="button">추가</button>
			</a>
			<%
				//세션 유효성 검사(로그인 유무)
				if(session.getAttribute("loginMemberId") != null) {
			%>
				<a href="<%=request.getContextPath()%>/logout.jsp">
					<button type="button" >로그아웃</button>
				</a>
			<%
				}
			%>
	</div>
	<table class="table table-bordered">
		<tr>
			<th>제목</th>
			<th>파일</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
		%>
				<tr>
					<td><%=(String)m.get("boardTitle")%></td>
					<td>
						<%=(String)m.get("originFilename")%>
						<%
							//세션 유효성 검사(로그인 유무)
							if(session.getAttribute("loginMemberId") != null) {
						%>
							<a href="<%=request.getContextPath()%>/<%=(String)m.get("path")%>/<%=(String)m.get("saveFilename")%>" download="<%=(String)m.get("originFilename")%>">
								<button type="button">다운로드</button>
							</a>
						<%
							} else {
						%>
							<a href="<%=request.getContextPath()%>/login.jsp">
								<button type="button">다운로드</button>
							</a>
						<%		
							}
						%>
					</td>
					<td>
						<div class="d-grid">
							<a href="<%=request.getContextPath()%>/modifyBoard.jsp?boardNo=<%=m.get("boardNo")%>&boardFileNo=<%=m.get("boardFileNo")%>">
								<button type="button">수정</button>
							</a>
						</div>
					</td>
					<td>
						<div class="d-grid">
							<a href="<%=request.getContextPath()%>/removeBoard.jsp?boardNo=<%=m.get("boardNo")%>&boardFileNo=<%=m.get("boardFileNo")%>">
								<button type="button">삭제</button>
							</a>
						</div>
					</td>
				</tr>
		<%		
			}
		%>
	</table>
	</div>
</body>
</html>