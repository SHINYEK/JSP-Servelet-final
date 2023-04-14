package model;

import java.util.Date;

public class CommentVO {
	private int id;
	private int postid;
	private String body;
	private String writer;
	private Date date;
	private int favorite;
	private int favoritecnt;
	
	public int getFavorite() {
		return favorite;
	}
	public void setFavorite(int favorite) {
		this.favorite = favorite;
	}
	public int getFavoritecnt() {
		return favoritecnt;
	}
	public void setFavoritecnt(int favoritecnt) {
		this.favoritecnt = favoritecnt;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getPostid() {
		return postid;
	}
	public void setPostid(int postid) {
		this.postid = postid;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "CommentVO [id=" + id + ", postid=" + postid + ", body=" + body + ", writer=" + writer + ", date=" + date
				+ "]";
	}
}
