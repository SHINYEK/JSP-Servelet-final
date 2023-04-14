package controller;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.*;

@WebServlet(value={
		"/comments.json",  "/comments.total",
		"/comments/insert","/comments/update", "/comments/delete",
		"/comments/favorite/insert","/comments/favorite/delete"})

public class CommentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CommentDAO dao=new CommentDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		
		switch(request.getServletPath()) {
		case "/comments/favorite/insert":
			int id=Integer.parseInt(request.getParameter("id"));
			String uid=request.getParameter("uid");
			dao.insertFavorite(uid, id);
			break;
		case "/comments/favorite/delete":
			id=Integer.parseInt(request.getParameter("id"));
			uid=request.getParameter("uid");
			dao.deleteFavorite(uid, id);
			break;	
		case "/comments.json":
			int postid=Integer.parseInt(request.getParameter("postid"));
			int page=Integer.parseInt(request.getParameter("page"));
			int size=Integer.parseInt(request.getParameter("size"));
			uid=request.getParameter("uid");
			ArrayList<CommentVO> array=dao.list(postid, page, size, uid);
			Gson gson=new Gson();
			out.println(gson.toJson(array));
			break;
		case "/comments.total":
			postid=Integer.parseInt(request.getParameter("postid"));
			out.println(dao.total(postid));
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		switch(request.getServletPath()) {
		case "/comments/insert":
			CommentVO vo=new CommentVO();
			vo.setPostid(Integer.parseInt(request.getParameter("postid")));
			vo.setBody(request.getParameter("body"));
			vo.setWriter(request.getParameter("writer"));
			dao.insert(vo);
			break;
		case "/comments/update":
			vo=new CommentVO();
			vo.setId(Integer.parseInt(request.getParameter("id")));
			vo.setBody(request.getParameter("body"));
			dao.update(vo);
			break;
		case "/comments/delete":
			int id=Integer.parseInt(request.getParameter("id"));
			dao.delete(id);
			break;
		}
	}
}
