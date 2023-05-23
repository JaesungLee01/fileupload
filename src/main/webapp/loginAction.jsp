<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="vo.*" %>
<%
	//세션 유효성 검사(로그인 유무)
	if(session.getAttribute("loginMemberId") != null) {
		response.sendRedirect(request.getContextPath()+"/boardList.jsp");
		return;
	}
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	
	//db 접속
	String driver = "org.mariadb.jdbc.Driver";
	String dburl = "jdbc:mariadb://127.0.0.1:3306/fileupload";
	String dbuser = "root";
	String dbpw = "java1234";
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(dburl, dbuser, dbpw);
	// 로그인 정보 조회
	String loginSql = "SElECT member_id memberId FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
	PreparedStatement loginStmt = conn.prepareStatement(loginSql);
	loginStmt.setString(1, memberId);
	loginStmt.setString(2, memberPw);
	ResultSet loginRs = loginStmt.executeQuery();
	// 로그인 성공 유무
	if(loginRs.next()){
		// 로그인 성공시
		// 세션에 로그인 정보 저장
		session.setAttribute("loginMemberId", loginRs.getString("memberId"));
		System.out.println("로그인 성공 세션정보 : " + session.getAttribute("loginMemberId"));
	} else {
		// 로그인 실패시
		System.out.println("로그인 실패"); 
	}
	
	response.sendRedirect(request.getContextPath()+"/boardList.jsp");
%>