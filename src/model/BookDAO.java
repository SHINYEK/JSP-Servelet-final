package model;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.*;

public class BookDAO {
	DecimalFormat df=new DecimalFormat("#,###��");
	//������ ���ƿ� ����
	public int countFavorite(int code) {
		int count=0;
		try {
			String sql="select count(*) from favorite_books where code=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, code);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) count=rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("���ƿ� ����:" + e.toString());
		}
		return count;
	}
	
	//���ƿ� ����
	public void deleteFavorite(String uid, int code) {
		try {
			String sql="delete from favorite_books where uid=? and code=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, code);
			ps.execute();
		}catch(Exception e) {
			System.out.println("���ƿ� ����:" + e.toString());
		}
	}
	
	//���ƿ� �߰�
	public void insertFavorite(String uid, int code) {
		try {
			String sql="insert into favorite_books(uid,code) values(?,?)";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, code);
			ps.execute();
		}catch(Exception e) {
			System.out.println("���ƿ� �߰�:" + e.toString());
		}
	}
		
	//���ƿ� üũ
	public int checkFavorite(String uid, int code) {
		int check=0;
		try {
			String sql="select count(*) from favorite_books where uid=? and code=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, code);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) check=rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("���ƿ� üũ:" + e.toString());
		}
		return check;
	}
	
	//viewcnt 1������
	public void viewcnt(int code) {
		try {
			String sql="update books set viewcnt=viewcnt+1 where code=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, code);
			ps.execute();
		}catch(Exception e) {
			System.out.println("viewcnt 1������" + e.toString());
		}
	}
	
	//��������
	public void update(BookVO vo) {
		try {
			String sql="update books set title=?,author=?,image=?,price=? where code=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getAuthor());
			ps.setString(3, vo.getImage());
			ps.setInt(4, vo.getPrice());
			ps.setInt(5, vo.getCode());
			ps.execute();
		}catch(Exception e) {
			System.out.println("��������:" + e.toString());
		}
	}
	
	//��������
	public BookVO read(int code) {
		BookVO vo=new BookVO();
		try {
			String  sql= "select * from view_books where code=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, code);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setCode(rs.getInt("code"));
				vo.setTitle(rs.getString("title"));
				vo.setAuthor(rs.getString("author"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
				vo.setFmtPrice(df.format(rs.getInt("price")));
				vo.setViewcnt(rs.getInt("viewcnt"));
				vo.setFavoritecnt(rs.getInt("favoritecnt"));
			}
		}catch(Exception e) {
			System.out.println("��������:" + e.toString());
		}
		return vo;
	}
	
	//�������
	public void insert(BookVO vo) {
		try {
			String sql="insert into books(title,author,price,image) values(?,?,?,?)";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getAuthor());
			ps.setInt(3, vo.getPrice());
			ps.setString(4, vo.getImage());
			ps.execute();
		}catch(Exception e) {
			System.out.println("�������:" + e.toString());
		}
	}
	//�����˻���
	public int total(String word) {
		int total=0;
		try {
			String  sql= "select count(*) from books ";
					sql+="where title like ? or author like ? ";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, "%" + word + "%");
			ps.setString(2, "%" + word + "%");
			ResultSet rs=ps.executeQuery();
			if(rs.next()) total=rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("�����˻���:" + e.toString());
		}
		return total;
	}
	
	//�������
	public ArrayList<BookVO> list(String word, int page, int size){
		ArrayList<BookVO> array=new ArrayList<BookVO>();
		try {
			String  sql= "select * from view_books ";
					sql+="where title like ? or author like ? ";
					sql+="order by code desc ";
					sql+="limit ?,?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, "%" + word + "%");
			ps.setString(2, "%" + word + "%");
			ps.setInt(3, (page-1)*size);
			ps.setInt(4, size);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				BookVO vo=new BookVO();
				vo.setCode(rs.getInt("code"));
				vo.setTitle(rs.getString("title"));
				vo.setAuthor(rs.getString("author"));
				vo.setPrice(rs.getInt("price"));
				vo.setViewcnt(rs.getInt("viewcnt"));
				vo.setReviewcnt(rs.getInt("reviewcnt"));
				vo.setImage(rs.getString("image"));
				vo.setFmtPrice(df.format(rs.getInt("price")));
				vo.setFavoritecnt(rs.getInt("favoritecnt"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("�������:" + e.toString());
		}
		return array;
	}
}
