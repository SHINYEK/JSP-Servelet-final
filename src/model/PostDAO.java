package model;
import java.util.*;
import java.sql.*;

public class PostDAO {
	//게시글 등록
	public void insert(PostVO vo) {
		try {
			String sql="insert into posts(title,body,writer) values(?,?,?)";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getBody());
			ps.setString(3, vo.getWriter());
			ps.execute();
		}catch(Exception e) {
			System.out.println("게시글수정:" + e.toString());
		}
	}
	
	//게시글 수정
	public void update(PostVO vo) {
		try {
			String sql="update posts set title=?,body=?,date=now() where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getBody());
			ps.setInt(3, vo.getId());
			ps.execute();
		}catch(Exception e) {
			System.out.println("게시글수정:" + e.toString());
		}
	}
	
	//게시글 삭제
	public void delete(int id) {
		try {
			String sql="delete from posts where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("게시글삭제:" + e.toString());
		}
	}
	
	//viewcnt 1씩증가
	public void viewcnt(int id) {
		try {
			String sql="update posts set viewcnt=viewcnt+1 where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, id);
			ps.execute();
		}catch(Exception e) {
			System.out.println("viewcnt 1씩증가" + e.toString());
		}
	}
	
	//게시글정보
	public PostVO read(int id) {
		PostVO vo=new PostVO();
		try {
			String  sql	="select *, date_format(date, '%y-%m-%d %T') fmtDate from view_posts ";
					sql+="where id=?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();		
			if(rs.next()) {
				vo.setId(rs.getInt("id"));
				vo.setTitle(rs.getString("title"));
				vo.setBody(rs.getString("body"));
				vo.setWriter(rs.getString("writer"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setFmtDate(rs.getString("fmtDate"));
				vo.setUname(rs.getString("uname"));
				vo.setViewcnt(rs.getInt("viewcnt"));
				vo.setCommentcnt(rs.getInt("commentcnt"));
			}
		}catch(Exception e) {
			System.out.println("게시글정보:" + e.toString());
		}
		return vo;
	}
	
	//게시글수
	public int total(String word) {
		int total=0;
		try {
			String  sql	="select count(*) from posts ";
					sql+="where title like ? or body like ? or writer like ? ";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, "%" + word + "%");
			ps.setString(2, "%" + word + "%");
			ps.setString(3, "%" + word + "%");
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				total=rs.getInt("count(*)");
			}
		}catch(Exception e) {
			System.out.println("게시글수:" + e.toString());
		}
		return total;
	}
	
	//게시글목록
	public ArrayList<PostVO> list(int page, int size, String word){
		ArrayList<PostVO> array=new ArrayList<PostVO>();
		try {
			String  sql	="select *, date_format(date, '%y-%m-%d %T') fmtDate from view_posts ";
					sql+="where title like ? or body like ? or writer like ? or uname like ?";
					sql+="order by id desc ";
					sql+="limit ?, ?";
			PreparedStatement ps=DB.CON.prepareStatement(sql);
			ps.setString(1, "%" + word + "%");
			ps.setString(2, "%" + word + "%");
			ps.setString(3, "%" + word + "%");
			ps.setString(4, "%" + word + "%");
			ps.setInt(5, (page-1) * size);
			ps.setInt(6, size);
			ResultSet rs=ps.executeQuery();		
			while(rs.next()) {
				PostVO vo=new PostVO();
				vo.setId(rs.getInt("id"));
				vo.setTitle(rs.getString("title"));
				vo.setBody(rs.getString("body"));
				vo.setWriter(rs.getString("writer"));
				vo.setDate(rs.getTimestamp("date"));
				vo.setFmtDate(rs.getString("fmtDate"));
				vo.setUname(rs.getString("uname"));
				vo.setViewcnt(rs.getInt("viewcnt"));
				vo.setCommentcnt(rs.getInt("commentcnt"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("게시글목록:" + e.toString());
		}
		return array;
	}
}
