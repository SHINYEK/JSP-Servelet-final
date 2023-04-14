package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet(value= {"/","/admin"})
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		switch(request.getServletPath()) {
		case "/":
			RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");		
			request.setAttribute("pageName", "/about.jsp");
			dis.forward(request, response);
			break;
		case "/admin":
			String uid = session.getAttribute("uid")==null ? "" : (String)session.getAttribute("uid");
			if(!uid.equals("admin")) {
				session.invalidate();
			}
			dis=request.getRequestDispatcher("/admin/home.jsp");
			request.setAttribute("pageName", "/admin/about.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
