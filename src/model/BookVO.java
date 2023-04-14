package model;

public class BookVO {
	private int code;
	private String title;
	private int price;
	private String author;
	private String image;
	private String fmtPrice;
	private int reviewcnt;
	private int viewcnt;
	private int favoritecnt;
	
	public int getFavoritecnt() {
		return favoritecnt;
	}
	public void setFavoritecnt(int favoritecnt) {
		this.favoritecnt = favoritecnt;
	}
	
	public int getReviewcnt() {
		return reviewcnt;
	}
	public void setReviewcnt(int reviewcnt) {
		this.reviewcnt = reviewcnt;
	}
	public int getViewcnt() {
		return viewcnt;
	}
	public void setViewcnt(int viewcnt) {
		this.viewcnt = viewcnt;
	}
	public String getFmtPrice() {
		return fmtPrice;
	}
	public void setFmtPrice(String fmtPrice) {
		this.fmtPrice = fmtPrice;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	@Override
	public String toString() {
		return "BookVO [code=" + code + ", title=" + title + ", price=" + price + ", author=" + author + ", image="
				+ image + "]";
	}
}
