package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import com.google.gson.Gson;

@WebServlet(value={"/posts", "/posts/read", "/posts.json", "/posts.total", "/posts/delete", "/posts/update", "/posts/insert"})
public class PostsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    PostDAO dao=new PostDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/posts":
			int page=request.getParameter("page")==null? 3 :
				Integer.parseInt(request.getParameter("page"));
			request.setAttribute("page", page);
			request.setAttribute("pageName", "/posts/list.jsp");
			dis.forward(request, response);
			break;
		case "/posts/read":
			int id=Integer.parseInt(request.getParameter("id"));
			dao.viewcnt(id);
			request.setAttribute("post", dao.read(id));
			request.setAttribute("pageName", "/posts/read.jsp");
			dis.forward(request, response);
			break;
		case "/posts.json":
			String word=request.getParameter("word");
			page=Integer.parseInt(request.getParameter("page"));
			int size=Integer.parseInt(request.getParameter("size"));
			Gson gson=new Gson();
			out.println(gson.toJson(dao.list(page, size, word)));
			break;
		case "/posts.total":
			word=request.getParameter("word");
			out.println(dao.total(word));
			break;
		case "/posts/delete":
			id=Integer.parseInt(request.getParameter("id"));
			dao.delete(id);
			break;
		case "/posts/update":
			id=Integer.parseInt(request.getParameter("id"));
			request.setAttribute("post", dao.read(id));
			request.setAttribute("pageName", "/posts/update.jsp");
			dis.forward(request, response);
			break;
		case "/posts/insert":
			request.setAttribute("pageName", "/posts/insert.jsp");
			dis.forward(request, response);
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		PostVO vo=new PostVO();
		vo.setTitle(request.getParameter("title"));
		vo.setBody(request.getParameter("body"));
		
		switch(request.getServletPath()) {
		case "/posts/update":
			vo.setId(Integer.parseInt(request.getParameter("id")));
			dao.update(vo);
			response.sendRedirect("/posts");
			break;
		case "/posts/insert":
			vo.setWriter(request.getParameter("writer"));
			dao.insert(vo);
			response.sendRedirect("/posts");
			break;
		}
	}
}










