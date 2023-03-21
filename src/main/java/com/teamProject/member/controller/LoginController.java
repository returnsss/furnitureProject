package com.teamProject.member.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.teamProject.member.database.DBConnection;
import com.teamProject.member.model.MemberDAO;

@WebServlet("*.lo")
public class LoginController extends HttpServlet {

	MemberDAO memberDAO = MemberDAO.getInstance();
	
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
        	
            RequestDispatcher rd = req.getRequestDispatcher("/member/loginMember.jsp");
            if (rd != null) {
                rd.forward(req, resp);
            } else {
                // 에러 처리 코드
        		// rd = req.getRequestDispatcher("/error/404error.jsp");
            }
        }
        else if(command.contains("/Login.lo")) { // 로그인 버튼 눌렀을 때
        	RequestDispatcher rd = null;
        	
        	try {
        		int loginResult = requestLoginMember(req, resp);
				if(loginResult == 0) { // state == 0 일반회원 로그인
					rd = req.getRequestDispatcher("/index.jsp");
					// 합칠떄 인덱스로 가게 만들기
				}
				else if(loginResult == 1) { // state == 1 이용 제한 고객
					rd = req.getRequestDispatcher("/member/processResultMember.jsp");
				}
				else if(loginResult == 2) { // state == 2 탈퇴한 회원
					rd = req.getRequestDispatcher("/member/processResultMember.jsp");
				}
				else if(loginResult == 3) { // state == 3 관리자 로그인
					rd = req.getRequestDispatcher("/member/processResultMember.jsp");
				}
				else {
					rd = req.getRequestDispatcher("/member/loginMember.jsp?error=1");
					rd.forward(req, resp);
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
        	
        	rd.forward(req, resp);
        }
        else if(command.contains("/AddMemberPage.lo")) { // 회원 가입페이지로 이동
        	
        	RequestDispatcher rd = req.getRequestDispatcher("/member/addMember.jsp");
            rd.forward(req, resp);
        }
        else if(command.contains("/AddMember.lo")) { // 회원가입 버튼 클릭시
        	addMember(req, resp);
        	RequestDispatcher rd = req.getRequestDispatcher("/member/resultMember.jsp?msg=1");
            rd.forward(req, resp);
            
            
        }
        else if(command.contains("AjaxIdCheck.lo")) { // 회원 아이디 중복 확인
        	//idCheck(req, resp);
        	String result = idCheck(req, resp);
        	req.setAttribute("result", result);
        	RequestDispatcher rd = req.getRequestDispatcher("/member/popupIdCheck.jsp");
            rd.forward(req, resp);
        }
        else if(command.contains("UpdateMemberPage.lo")) { // 회원 수정으로 이동
        	
        	RequestDispatcher rd = req.getRequestDispatcher("/member/updateMember.jsp");
            rd.forward(req, resp);
        }
        else if(command.contains("UpdateMember.lo")) { // 회원 수정하기 버튼 클릭시
        	updateMember(req, resp);
        	RequestDispatcher rd = req.getRequestDispatcher("/member/resultMember.jsp?msg=3");
            rd.forward(req, resp);
        }
        else if(command.contains("Logout.lo")) { // 로그아웃 버튼 클릭 시
        	logoutMember(req, resp);
        	RequestDispatcher rd = req.getRequestDispatcher("/LoginPage.lo");
            rd.forward(req, resp);
        }
        else if(command.contains("WithdrawalMember.lo")) { // 회원 탈퇴 버튼 클릭시
        	withdrawalMember(req, resp);
        	
        	RequestDispatcher rd = req.getRequestDispatcher("/LoginPage.lo");
            rd.forward(req, resp);
        }
        
        
	}

	

	private void withdrawalMember(HttpServletRequest req, HttpServletResponse resp) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        
        HttpSession session = req.getSession();
        
        String sessionId = session.getAttribute("sessionId").toString();
		
        
        
        try {
				
				String sql = "UPDATE member set state=2 where id=?";
				conn = DBConnection.getConnection();
				pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, sessionId);
	            pstmt.executeUpdate();
	            
	            logoutMember(req, resp);
	        
            
    } catch (Exception e) {
        System.out.println("withdrawalMember() 에러 : " + e);
    }
    finally {
        try {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
            
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
        
        
	}

	private void logoutMember(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		
		session.invalidate();
	}

	private void updateMember(HttpServletRequest req, HttpServletResponse resp) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        HttpSession session = req.getSession();
    	
		
    	
    	
    	
    	String id = (String) session.getAttribute("sessionId");
    	//String id = request.getParameter("id"); 이렇게 쓰면 해킹 당함
    	String password = req.getParameter("password");
    	String name = req.getParameter("name");
    	String gender = req.getParameter("gender");
    	String year = req.getParameter("birthyy");
    	String month = req.getParameterValues("birthmm")[0];
    	String day = req.getParameter("birthdd");
    	String birth = year + "/" + month + "/" + day;
    	String mail1 = req.getParameter("mail1");
    	String mail2 = req.getParameterValues("mail2")[0];
    	String mail = mail1 + "@" + mail2;
    	String zipcode = req.getParameter("zipcode");
    	String address1 = req.getParameter("address1");
    	String address2 = req.getParameter("address2");
    	String address = zipcode + "/" + address1 + "/" + address2;
    	String phone1 = req.getParameterValues("phone1")[0];
    	String phone2 = req.getParameter("phone2");
    	String phone3 = req.getParameter("phone3");
    	String phone = phone1 + "-" + phone2 + "-" + phone3;
    	String receive_mail = req.getParameter("mailYN");
    	String receive_phone = req.getParameter("smsYN");
    	String agreement = req.getParameter("termsYN");
    	
    	
    	
    	
    	
        
        try {
                String sql = "UPDATE member set password=?, name=?, birth=?, gender=?, mail=?,"
                		+ "address=?, phone=?, receive_mail=?, receive_phone=?, agreement=? where id=?";
                
                conn = DBConnection.getConnection();
                pstmt = conn.prepareStatement(sql);
                
                pstmt.setString(1, req.getParameter("password"));
                pstmt.setString(2, req.getParameter("name"));
                pstmt.setString(3, birth);
                pstmt.setString(4, req.getParameter("gender"));
                pstmt.setString(5, mail);
                pstmt.setString(6, address);
                pstmt.setString(7, phone);
                pstmt.setString(8, receive_mail);
                pstmt.setString(9, receive_phone);
                pstmt.setString(10, agreement);
                pstmt.setString(11, req.getParameter("id"));
                pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("updateMember() 에러 : " + e);
        }
        finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
	}

	private String idCheck(HttpServletRequest req, HttpServletResponse resp) {
		
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int rowCount = 0;
        String result = "true";
		
        String id = req.getParameter("id");
        
		try {
            String sql = "SELECT COUNT(*) AS cnt FROM member WHERE id=?";

            conn = DBConnection.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            if(rs.next()){
				rowCount = rs.getInt(1);
			}
			if(rowCount == 0) {
				result = "false";
				
			}
            
            
    } catch (Exception e) {
        System.out.println("idCheck() 에러 : " + e);
    }
    finally {
        try {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        } catch (Exception ex) {
            throw new RuntimeException(ex.getMessage());
        }
    }
		return result;
		
	}

	private void addMember(HttpServletRequest req, HttpServletResponse resp) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        
    	
    	String year = req.getParameter("birthyy");
    	String month = req.getParameterValues("birthmm")[0];
    	String day = req.getParameter("birthdd");
    	String birth = year + "/" + month + "/" + day;
    	
    	String mail1 = req.getParameter("mail1");
    	String mail2 = req.getParameterValues("mail2")[0];
    	String mail = mail1 + "@" + mail2;
    	String zipcode = req.getParameter("zipcode");
    	String address1 = req.getParameter("address1");
    	String address2 = req.getParameter("address2");
    	String address = zipcode + "/" + address1 + "/" + address2; 
    	String phone1 = req.getParameterValues("phone1")[0];
    	String phone2 = req.getParameter("phone2");
    	String phone3 = req.getParameter("phone3");
    	String phone = phone1 + "-" + phone2 + "-" + phone3;
    	
        
        try {
                String sql = "INSERT INTO member VALUES (?,?,?,?,?,?,?,?,?,?,?,now(),0)";
                conn = DBConnection.getConnection();
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, req.getParameter("id"));
                pstmt.setString(2, req.getParameter("password"));
                pstmt.setString(3, req.getParameter("name"));
                pstmt.setString(4, birth);
                pstmt.setString(5, req.getParameter("gender"));
                pstmt.setString(6, mail);
                pstmt.setString(7, address);
                pstmt.setString(8, phone);
                pstmt.setString(9, req.getParameter("mailYN"));
                pstmt.setString(10, req.getParameter("smsYN"));
                pstmt.setString(11, req.getParameter("termsYN"));
                pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("addMember() 에러 : " + e);
        }
        finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                throw new RuntimeException(ex.getMessage());
            }
        }
	}
	
	
	private int requestLoginMember(HttpServletRequest req, HttpServletResponse resp) throws ClassNotFoundException {

		int result = 0;
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        HttpSession session = req.getSession();
		
		String id = req.getParameter("id");
		String password = req.getParameter("password");
		String sql = "SELECT state FROM member WHERE id = ? AND password = ?";
		
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			rs = pstmt.executeQuery();
			if(rs.next()){
				if(rs.getInt(1) == 0) {
					session.setAttribute("sessionId", id);
					//session.setAttribute("sessionMemberName", rs.getString("name"));
					
					//CartDAO cartDAO = new CartDAO();
					//cartDAO.updateCartBylogin(session);
					
					//resp.sendRedirect("resultMember.jsp?msg=2");
					result = 0;
					return result;
				}
				else if(rs.getInt(1) == 1) {
					
					
					result = 1;
					return result;
				}
				else if(rs.getInt(1) == 2) {
					
					
					result = 2;
					return result;
				}
				else if(rs.getInt(1) == 3) {
					
					
					result = 3;
					return result;
				}
				
				
			}
			else{
				//resp.sendRedirect("loginMember.jsp?error=1");
				result = 4;
				req.setAttribute("error", 1);
				
				return result;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	
	
}
