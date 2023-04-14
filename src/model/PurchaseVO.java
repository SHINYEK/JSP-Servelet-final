package model;

import java.util.Date;

public class PurchaseVO {
	private String oid;
	private String uid;
	private String uname;
	private String address;
	private String phone;
	private Date date;
	
	@Override
	public String toString() {
		return "PurchaseVO [oid=" + oid + ", uid=" + uid + ", uname=" + uname + ", address=" + address + ", phone="
				+ phone + ", getOid()=" + getOid() + ", getUid()=" + getUid() + ", getUname()=" + getUname()
				+ ", getAddress()=" + getAddress() + ", getPhone()=" + getPhone() + ", getClass()=" + getClass()
				+ ", hashCode()=" + hashCode() + ", toString()=" + super.toString() + "]";
	}
	
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
}
