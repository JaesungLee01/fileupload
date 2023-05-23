<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%
	String dir = request.getServletContext().getRealPath("/upload");
	
	// 요청값 유효성 검사
	if(request.getParameter("boardNo") == null					// boardNo나 boardFileNo가 null이거나 공백이면
		|| request.getParameter("boardFileNo") == null
		|| request.getParameter("boardNo").equals("")
		|| request.getParameter("boardFileNo").equals("")) {
		// boardList로 가라
		response.sendRedirect(request.getContextPath() + "/boardList.jsp");
	}
	// 요청값 변수 저장
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int boardFileNo = Integer.parseInt(request.getParameter("boardFileNo"));
	//db 접속
	String driver = "org.mariadb.jdbc.Driver";
	String dburl = "jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbuser = "root";
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	// 파일 삭제
	String saveFilenameSql = "SElECT save_filename saveFilename FROM board_file WHERE board_file_no = ?";
	PreparedStatement saveFilenameStmt = conn.prepareStatement(saveFilenameSql);
	saveFilenameStmt.setInt(1, boardFileNo);
	ResultSet saveFilenameRs = saveFilenameStmt.executeQuery();
	String preSaveFilename = "";
	if(saveFilenameRs.next()) {
		preSaveFilename = saveFilenameRs.getString("saveFilename");
	}
	File f = new File(dir+"/"+preSaveFilename);
	if(f.exists()) {
		f.delete();
	}
	// board 삭제
	String deleteBoardSql = "DELETE FROM board WHERE board_no = ?";
	PreparedStatement deleteBoardStmt = conn.prepareStatement(deleteBoardSql);
	deleteBoardStmt.setInt(1,boardNo);
	int deleteBoardRow = deleteBoardStmt.executeUpdate();

	// boardList로 가라
	response.sendRedirect(request.getContextPath() + "/boardList.jsp");
%>