package model;

public class DBTest {
	public static void main(String[] args) {
//		PostDAO dao=new PostDAO();
//		
//		for(PostVO vo:dao.list(1, 5, "리액트")) {
//			System.out.println(vo.toString());
//		}
//		
//		System.out.println("게시글수:" + dao.total("리액트"));
		BookDAO dao = new BookDAO();
		
		System.out.println(dao.read(16));
	}
}
