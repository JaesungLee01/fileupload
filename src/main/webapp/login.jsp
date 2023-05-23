<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginMemberId") != null) {
		response.sendRedirect(request.getContextPath()+"/bosrdList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="<%=request.getContextPath()%>/loginAction.jsp">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="memberId" required="required">
				</td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="memberPw" required="required">
				</td>
			</tr>
		</table>
		<button type="submit">로그인</button>
	</form>
</body>
</html>