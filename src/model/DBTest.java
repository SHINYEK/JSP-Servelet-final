package model;

public class DBTest {
	public static void main(String[] args) {
//		PostDAO dao=new PostDAO();
//		
//		for(PostVO vo:dao.list(1, 5, "����Ʈ")) {
//			System.out.println(vo.toString());
//		}
//		
//		System.out.println("�Խñۼ�:" + dao.total("����Ʈ"));
		BookDAO dao = new BookDAO();
		
		System.out.println(dao.read(16));
	}
}
