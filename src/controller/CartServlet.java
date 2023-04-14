package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.BookDAO;
import model.BookVO;
import model.CartVO;

@WebServlet(value= {"/carts","/carts.json","/carts/insert","/carts/update","/carts/delete"})
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       BookDAO dao = new BookDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		ArrayList<CartVO> carts = session.getAttribute("carts") == null ? new ArrayList<CartVO>() : (ArrayList<CartVO>) session.getAttribute("carts");
		//타입 지정안나서 오류, 강제형변환
		switch(request.getServletPath()) {
		case "/carts":
			request.setAttribute("pageName", "/books/carts.jsp");
			dis.forward(request, response);
			break;
		case "/carts/insert":
			int code = Integer.parseInt(request.getParameter("code"));
			boolean find = false;
			//코드 존재여부 확인
			for(CartVO vo:carts) {
				if(code==vo.getCode()) { //code가 이미 장바구니에 있으면 수량 증가
					vo.setQnt(vo.getQnt()+1);
					find = true;
					break;
				}
			}
			
			//code가 장바구니에 없는 경우
			if(find==false) {
				BookVO bvo = dao.read(code);
				CartVO vo = new CartVO();				
				vo.setCode(code);
				vo.setQnt(1);				
				vo.setTitle(bvo.getTitle());
				vo.setImage(bvo.getImage());
				vo.setPrice(bvo.getPrice());
				vo.setFmtPrice(bvo.getFmtPrice());
				carts.add(vo);			
			}		
			session.setAttribute("carts", carts);
			session.setAttribute("cartcnt", carts.size());
			break;
		case "/carts.json":
			Gson gson = new Gson();
			out.println(gson.toJson(carts));
			break;
		case "/carts/delete":
			code = Integer.parseInt(request.getParameter("code"));
			for(CartVO vo:carts) {
				if(vo.getCode() == code) {
					carts.remove(vo);
					break;
				}
			}
			session.setAttribute("carts", carts);
			session.setAttribute("cartcnt", carts.size());
			break;
			
		case "/carts/update":
			code = Integer.parseInt(request.getParameter("code"));
			int qnt = Integer.parseInt(request.getParameter("qnt"));
			for(CartVO vo:carts) {
				if(code==vo.getCode()) {
					vo.setQnt(qnt);
				}
			}
			session.setAttribute("carts", carts);
			session.setAttribute("cartcnt", carts.size());
			break;
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		switch(request.getServletPath()) {
		
		
		case "/carts/delete":
			break;
		}
	}

}
