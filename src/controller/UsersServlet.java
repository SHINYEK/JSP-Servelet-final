package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.*;

@WebServlet(value={"/login", "/logout" ,"/admin/login","/admin/logout"})
public class UsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    UserDAO dao=new UserDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		HttpSession session=request.getSession();
		
		switch(request.getServletPath()) {
		case "/login":
			session.setAttribute("target", request.getParameter("target"));
			request.setAttribute("pageName", "/users/login.jsp");
			dis.forward(request, response);
			break;
		case "/logout":
			session.invalidate();
			response.sendRedirect("/");
			break;	
			
		case "/admin/logout":
			session.invalidate();
			response.sendRedirect("/admin");
			break;
			
		case "/admin/login":
			dis=request.getRequestDispatcher("/admin/home.jsp");
			request.setAttribute("pageName", "/admin/login.jsp");
			dis.forward(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		
		switch(request.getServletPath()) {
		case "/login":
			String uid=request.getParameter("uid");
			String upass=request.getParameter("upass");
			UserVO vo=dao.read(uid);
			int result=0;
			if(vo.getUid() != null) {
				if(vo.getUpass().equals(upass)) {
					session.setAttribute("uid", uid);
					session.setAttribute("uname", vo.getUname());
					result=1;
				}else {
					result=2;
				}
			}
			out.println(result);
			break;
		}
	}
}





