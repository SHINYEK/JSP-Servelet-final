package controller;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.FileUtils;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import model.BookDAO;
import model.BookVO;


@WebServlet(value={"/admin/books","/books/favorite","/books/read",
		"/admin/books/update","/admin/books/insert", "/books.json",
		"/books.total", "/admin/books/search","/books/favorite/count",
		"/books/favorite/insert","/books/favorite/delete","/admin/books/save"})
public class BooksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    BookDAO dao=new BookDAO();
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out=response.getWriter();
		RequestDispatcher dis=request.getRequestDispatcher("/home.jsp");
		
		switch(request.getServletPath()) {
		case "/books/favorite":
			String uid=request.getParameter("uid");
			int code=Integer.parseInt(request.getParameter("code"));
			out.println(dao.checkFavorite(uid, code));
			break;
		case "/books/favorite/insert":
			uid=request.getParameter("uid");
			code=Integer.parseInt(request.getParameter("code"));
			dao.insertFavorite(uid, code);
			break;
		case "/books/favorite/delete":
			uid=request.getParameter("uid");
			code=Integer.parseInt(request.getParameter("code"));
			dao.deleteFavorite(uid, code);
			break;
		case "/books/favorite/count":
			code=Integer.parseInt(request.getParameter("code"));
			out.println(dao.countFavorite(code));
			break;
		case "/books/read":
			code=Integer.parseInt(request.getParameter("code"));
			dao.viewcnt(code);
			request.setAttribute("book", dao.read(code));
			request.setAttribute("pageName", "/books/read.jsp");
			dis.forward(request, response);
			break;
		case "/admin/books/update":
			dis=request.getRequestDispatcher("/admin/home.jsp");
			code=Integer.parseInt(request.getParameter("code"));
			request.setAttribute("book", dao.read(code));
			request.setAttribute("pageName", "/books/update.jsp");
			dis.forward(request, response);
			break;
		case "/admin/books/insert":
			dis=request.getRequestDispatcher("/admin/home.jsp");
			request.setAttribute("pageName", "/books/insert.jsp");
			dis.forward(request, response);
			break;
		case "/books.total":
			String word=request.getParameter("word");
			out.println(dao.total(word));
			break;
		case "/books.json":
			word=request.getParameter("word");
			int page=Integer.parseInt(request.getParameter("page"));
			int size=Integer.parseInt(request.getParameter("size"));
			Gson  gson=new Gson();
			out.println(gson.toJson(dao.list(word, page, size)));
			break;
		case "/admin/books":
			dis=request.getRequestDispatcher("/admin/home.jsp");
			request.setAttribute("pageName", "/books/list.jsp");
			dis.forward(request, response);
			break;
		case "/admin/books/search":
			dis=request.getRequestDispatcher("/admin/home.jsp");
			request.setAttribute("pageName", "/books/search.jsp");
			dis.forward(request, response);
			break;
		case "/admin/books/save":
			//이미지 업로드
			String url_image = request.getParameter("url");
			BookVO vo = new BookVO();
			vo.setTitle(request.getParameter("title"));
			vo.setPrice(Integer.parseInt(request.getParameter("price")));
			vo.setAuthor(request.getParameter("author"));
			String file =  System.currentTimeMillis()+".jpg";
			vo.setImage(file);
			dao.insert(vo);
			try {
				URL url = new URL(url_image);
				InputStream in = url.openStream();
				OutputStream outs = new FileOutputStream("c:/images/books/"+file);
				while(true) {
					int data = in.read();
					if(data == -1) break;
					outs.write(data);
				}
			}catch(Exception e) {
				System.out.println("이미지업로드 오류:"+e.toString());
			}
			break;
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		//이미지 업로드
		MultipartRequest multi=new MultipartRequest(
				request, 
				"c:/images/books", 
				1000*1000*10, 
				"utf-8", 
				new DefaultFileRenamePolicy());
		String image=multi.getFilesystemName("image");
		
		//데이타저장
		BookVO vo=new BookVO();
		vo.setImage(image);
		vo.setTitle(multi.getParameter("title"));
		vo.setAuthor(multi.getParameter("author"));
		vo.setPrice(Integer.parseInt(multi.getParameter("price")));
		
		switch(request.getServletPath()) {
		case "/admin/books/insert":
			dao.insert(vo);
			response.sendRedirect("/admin/books");
			break;
		case "/admin/books/update":
			vo.setCode(Integer.parseInt(request.getParameter("code")));
			if(multi.getOriginalFileName("image") == null) {
				vo.setImage(multi.getParameter("old"));
			}
			dao.update(vo);
			response.sendRedirect("/admin/books");
			break;
		
		}
	}

}
