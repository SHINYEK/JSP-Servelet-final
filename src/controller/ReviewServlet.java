package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

@WebServlet(value={"/reviews.json", "/reviews.total", 
		"/reviews/insert", "/reviews/delete", "/reviews/update",
		"/reviews/favorite/insert", "/review/favorite/delete"})
public class ReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    ReviewDAO dao=new ReviewDAO();   

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		switch(request.getServletPath()) {
		case "/reviews.json":	
			int code=Integer.parseInt(request.getParameter("code"));
			int page=Integer.parseInt(request.getParameter("page"));
			int size=Integer.parseInt(request.getParameter("size"));
			String uid=request.getParameter("uid");
			Gson gson=new Gson();
			out.println(gson.toJson(dao.list(code, page, size, uid)));
			break;
		case "/reviews.total":
			code=Integer.parseInt(request.getParameter("code"));
			out.println(dao.total(code));
			break;
		case "/reviews/favorite/insert":
			int id=Integer.parseInt(request.getParameter("id"));
			uid=request.getParameter("uid");
			dao.insertFavorite(uid, id);
			break;
		case "/review/favorite/delete":
			id=Integer.parseInt(request.getParameter("id"));
			uid=request.getParameter("uid");
			System.out.println("..............\n" + id + ":" + uid);
			dao.deleteFavorite(uid, id);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		ReviewVO vo=new ReviewVO();
		vo.setBody(request.getParameter("body"));
		vo.setWriter(request.getParameter("writer"));
		
		switch(request.getServletPath()) {
		case "/reviews/insert":
			vo.setCode(Integer.parseInt(request.getParameter("code")));
			dao.insert(vo);
			break;
		case "/reviews/update":
			vo.setId(Integer.parseInt(request.getParameter("id")));
			dao.update(vo);
			break;
		case "/reviews/delete":
			dao.delete(Integer.parseInt(request.getParameter("id")));
			break;
		}
	}

}
