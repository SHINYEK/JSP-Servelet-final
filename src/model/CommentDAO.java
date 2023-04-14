package model;
import java.util.*;
import java.sql.*;

public class CommentDAO {
	//���ƿ� �߰�
	public void insertFavorite(String uid, int id) {
		try {
			String sql="insert into favorite_comments(uid, id) values(?,?)";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("���ƿ� �߰�:" + e.toString());
		}
	}
	
	//���ƿ� ����
	public void deleteFavorite(String uid, int id) {
		try {
			String sql="delete from favorite_comments where uid=? and id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("���ƿ� ����:" + e.toString());
		}
	}
	
	//��ۼ�
	public int total(int postid) {
		int total=0;
		try {
			String sql="select count(*) from comments where postid=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, postid);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) total=rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("��ۼ�:" + e.toString());
		}
		return total;
	}
	
	//��۸��
	public ArrayList<CommentVO> list(int postid, int page, int size, String uid){
		ArrayList<CommentVO> array=new ArrayList<CommentVO>();
		try {
			String  sql ="select c.*,";
					sql+=" (select count(*) from favorite_comments where uid=? and c.id=id) as favorite,";
					sql+=" (select count(*) from favorite_comments where c.id=id) favoritecnt ";
					sql+=" from comments c ";
					sql+=" where postid=?";
					sql+=" order by id desc";
					sql+=" limit ?,?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, postid);
			ps.setInt(3, (page-1)*size);
			ps.setInt(4, size);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				CommentVO vo=new CommentVO();
				vo.setId(rs.getInt("id"));
				vo.setBody(rs.getString("body"));
				vo.setWriter(rs.getString("writer"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setFavorite(rs.getInt("favorite"));
				vo.setFavoritecnt(rs.getInt("favoritecnt"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("��۸��:" + e.toString());
		}
		return array;
	}
	
	//��۵��
	public void insert(CommentVO vo) {
		try {
			String sql="insert into comments(postid, body, writer) values(?,?,?)";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, vo.getPostid());
			ps.setString(2, vo.getBody());
			ps.setString(3, vo.getWriter());
			ps.execute();
		}catch(Exception e) {
			System.out.println("��۵��:" + e.toString());
		}
	}
	
	//��ۼ���
	public void update(CommentVO vo) {
		try {
			String sql="update comments set body=? where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getBody());
			ps.setInt(2, vo.getId());
			ps.execute();
		}catch(Exception e) {
			System.out.println("��ۼ���:" + e.toString());
		}
	}
	
	//��ۻ���
	public void delete(int id) {
		try {
			String sql="delete from comments where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("��ۻ���:" + e.toString());
		}
	}
}
