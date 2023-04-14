package model;

public class OrderVO {
	private String oid;
	private int code;
	private int price;
	private int qnt;
	private String title;
	private String image;
	
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getQnt() {
		return qnt;
	}
	public void setQnt(int qnt) {
		this.qnt = qnt;
	}
	@Override
	public String toString() {
		return "OrderVO [oid=" + oid + ", code=" + code + ", price=" + price + ", qnt=" + qnt + ", getOid()=" + getOid()
				+ ", getCode()=" + getCode() + ", getPrice()=" + getPrice() + ", getQnt()=" + getQnt() + ", getClass()="
				+ getClass() + ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
}
