package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import model.CartVO;
import model.OrderDAO;
import model.OrderVO;
import model.PurchaseVO;
import model.UserDAO;
import model.UserVO;


@WebServlet(value= {"/ordered","/orders","/purchase/insert","/orders/insert","/orders/list",
		"/admin/orders/list","/purchase.json","/orders.json","/orders/all.json"})
public class OrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	  UserDAO dao = new UserDAO();
	  OrderDAO odao = new OrderDAO();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		RequestDispatcher dis = request.getRequestDispatcher("/home.jsp");
		HttpSession session = request.getSession();
		Gson gson = new Gson();
		switch(request.getServletPath()) {
		case "/orders":
			String orders = request.getParameter("orders");
			String[] array = orders.split(","); //배열 쪼개기 (상품 인덱스)
			ArrayList<CartVO> carts = (ArrayList<CartVO>)session.getAttribute("carts");
			ArrayList<CartVO> list = new ArrayList<CartVO>();
			int sum = 0;
			for(String index:array) {
				CartVO vo = carts.get(Integer.parseInt(index));
				list.add(vo);
				sum += vo.getPrice()*vo.getQnt();
			}
			String uid = (String)session.getAttribute("uid");
			UserVO user = dao.read(uid);
			request.setAttribute("user", user); //유저정보
			request.setAttribute("list", list); //상품목록
			request.setAttribute("sum", sum); //주문금액합계
			request.setAttribute("pageName", "/books/orders.jsp");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String date = sdf.format(new Date());
			UUID uuid = UUID.randomUUID(); //랜덤숫자 - 주문번호
			String no = date +"_"+ uuid.toString().substring(0,6);
			request.setAttribute("no", no); //주문번호
			dis.forward(request, response);
			break;
		case "/ordered":
			request.setAttribute("pageName", "/books/ordered.jsp");
			dis.forward(request, response);
			break;
		case "/orders/list":
			request.setAttribute("pageName", "/orders/list.jsp");
			dis.forward(request, response);
			break;
			
		case "/purchase.json":		
			uid = request.getParameter("uid");
			out.println(gson.toJson(odao.list(uid)));
			break;
			
		case "/orders.json":
			String oid = request.getParameter("oid");
			out.println(gson.toJson(odao.olist(oid)));
			break;
		case "/admin/orders/list":
			dis = request.getRequestDispatcher("/admin/home.jsp");
			request.setAttribute("pageName", "/orders/allList.jsp");
			dis.forward(request, response);
			break;
		case "/orders/all.json":
			String word = request.getParameter("word");
			out.println(gson.toJson(odao.all_list(word)));
			break;

		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		OrderDAO dao = new OrderDAO();
		switch(request.getServletPath()) {
		case "/purchase/insert":
			PurchaseVO vo = new PurchaseVO();
			vo.setOid(request.getParameter("oid"));
			vo.setUid(request.getParameter("uid"));
			vo.setUname(request.getParameter("uname"));
			vo.setAddress(request.getParameter("address"));
			vo.setPhone(request.getParameter("phone"));
			dao.pinsert(vo);
			break;
		case "/orders/insert":
			OrderVO ovo = new OrderVO();
			ovo.setOid(request.getParameter("oid"));
			ovo.setCode(Integer.parseInt(request.getParameter("code")));
			ovo.setPrice(Integer.parseInt(request.getParameter("price")));
			ovo.setQnt(Integer.parseInt(request.getParameter("qnt")));
			dao.oinsert(ovo);
			break;
		}
	}

}
