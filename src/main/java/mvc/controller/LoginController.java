package mvc.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.lo")
public class LoginController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String RequestURI = req.getRequestURI(); // 전체 경로를 가져옴.
        String contextPath = req.getContextPath(); // 프로젝트 Path만 가져옴.
        String command =  RequestURI.substring(contextPath.length()); // 전체경로에서 프로젝트 Path 길이 만큼의 인덱스 이후의 문자열을 가져옴.

        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        req.setCharacterEncoding("UTF-8");
		
		
        
        // 로그인 페이지
        if(command.contains("/LoginPage.lo")) { // 로그인 페이지 출력
        	
            RequestDispatcher rd = req.getRequestDispatcher("../member/loginMember.jsp");
            rd.forward(req, resp);
        }
        else if(command.contains("/Login.lo")) { // 로그인 버튼 눌렀을 때
        	requestLoginMember(req);
        	RequestDispatcher rd = req.getRequestDispatcher("../index.jsp");
            rd.forward(req, resp);
        }
	}

	private void requestLoginMember(HttpServletRequest req, ) {
		req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("id");
		String password = req.getParameter("password");
		String sql = "SELECT * FROM member WHERE id = ? AND password = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		rs = pstmt.executeQuery();
		if(rs.next()){
			session.setAttribute("sessionId", id);
			session.setAttribute("sessionMemberName", rs.getString("name"));
			
			//CartDAO cartDAO = new CartDAO();
			//cartDAO.updateCartBylogin(session);
			response.sendRedirect("resultMember.jsp?msg=2");
		}
		else{
			response.sendRedirect("loginMember.jsp?error=1");
		}
	}
	
}
