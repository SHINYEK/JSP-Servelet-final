package model;
import java.sql.*;
import java.util.*;

public class ReviewDAO {
	//좋아요 추가
	public void insertFavorite(String uid, int id) {
		try {
			String sql="insert into favorite_reviews(uid, id) values(?,?)";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("좋아요 추가:" + e.toString());
		}
	}
	
	//좋아요 삭제
	public void deleteFavorite(String uid, int id) {
		try {
			String sql="delete from favorite_reviews where uid=? and id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("좋아요 삭제:" + e.toString());
		}
	}
	//리뷰등록
	public void insert(ReviewVO vo) {
		try {
			String sql="insert into reviews(code,body,writer) values(?,?,?)";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, vo.getCode());
			ps.setString(2, vo.getBody());
			ps.setString(3, vo.getWriter());
			ps.execute();
		}catch(Exception e){
			System.out.println("리뷰등록:" + e.toString());
		}
	}
	
	//리뷰삭제
	public void delete(int id) {
		try {
			String sql="delete from reviews where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, id);
			ps.execute();
		}catch(Exception e){
			System.out.println("리뷰삭제:" + e.toString());
		}
	}
	
	//리뷰수정
	public void update(ReviewVO vo) {
		try {
			String sql="update reviews set body=?, date=now() where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getBody());
			ps.setInt(2, vo.getId());
			ps.execute();
		}catch(Exception e){
			System.out.println("리뷰수정:" + e.toString());
		}
	}
	
	//리뷰수
	public int total(int code) {
		int total=0;
		try {
			String sql="select count(*) from reviews where code=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, code);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) total=rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("리뷰수:" + e.toString());
		}
		return total;
	}
	//리뷰목록
	public ArrayList<ReviewVO> list(int code, int page, int size, String uid){
		ArrayList<ReviewVO> array=new ArrayList<ReviewVO>();
		try {
			String  sql ="select r.*,";
			sql+=" (select count(*) from favorite_reviews where uid=? and r.id=id) as favorite,";
			sql+=" (select count(*) from favorite_reviews where r.id=id) favoritecnt ";
			sql+=" from reviews r ";
			sql+=" where code=?";
			sql+=" order by id desc";
			sql+=" limit ?,?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ps.setInt(2, code);
			ps.setInt(3, (page-1)*size);
			ps.setInt(4, size);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				ReviewVO vo=new ReviewVO();
				vo.setId(rs.getInt("id"));
				vo.setCode(rs.getInt("code"));
				vo.setBody(rs.getString("body"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setWriter(rs.getString("writer"));
				vo.setFavorite(rs.getInt("favorite"));
				vo.setFavoritecnt(rs.getInt("favoritecnt"));
				array.add(vo);
			}	
		}catch(Exception e) {
			System.out.println("리뷰목록:" + e.toString());
		}
		return array;
	}
}
