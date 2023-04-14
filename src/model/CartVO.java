package model;

public class CartVO extends BookVO{
	private int qnt;
	//장바구니, bookVO 상속받아 정보 사용
	@Override
	public String toString() {
		return "CartVO [qnt=" + qnt + "]";
	}

	public int getQnt() {
		return qnt;
	}

	public void setQnt(int qnt) {
		this.qnt = qnt;
	}
	
}
