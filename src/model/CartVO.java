package model;

public class CartVO extends BookVO{
	private int qnt;
	//��ٱ���, bookVO ��ӹ޾� ���� ���
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
