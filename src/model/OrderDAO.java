package model;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class OrderDAO {
	//��ü ����� �ֹ����
		public ArrayList<PurchaseVO> all_list(String word) {
			ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
			try {
				String sql = "select * from purchase where uid like ? or uname like ? or address like ? or oid like ? or phone like ? order by date desc";
				PreparedStatement ps = DB.CON.prepareStatement(sql);
				ps.setString(1, "%"+word+"%");
				ps.setString(2, "%"+word+"%");
				ps.setString(3, "%"+word+"%");
				ps.setString(4, "%"+word+"%");
				ps.setString(5, "%"+word+"%");
				ResultSet rs = ps.executeQuery();
				while(rs.next()) {
					PurchaseVO vo = new PurchaseVO();
					vo.setOid(rs.getString("oid"));
					vo.setUid(rs.getString("uid"));
					vo.setUname(rs.getString("uname"));
					vo.setAddress(rs.getString("address"));
					vo.setOid(rs.getString("oid"));
					vo.setPhone(rs.getString("phone"));
					vo.setDate(rs.getTimestamp("date"));
					array.add(vo);
				}
			}catch(Exception e) {
				System.out.println("��ü�ֹ����"+e.toString());
			}
			return array;
		}
	//�ֹ���ǰ ���
	public ArrayList<OrderVO> olist(String oid) {
		ArrayList<OrderVO> array = new ArrayList<OrderVO>();
		try {
			String sql = "select * from view_orders where oid=?";
			PreparedStatement ps = DB.CON.prepareStatement(sql);
			ps.setString(1, oid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				OrderVO vo = new OrderVO();
				vo.setOid(rs.getString("oid"));
				vo.setCode(rs.getInt("code"));
				vo.setPrice(rs.getInt("price"));
				vo.setImage(rs.getString("image"));
				vo.setTitle(rs.getString("title"));
				vo.setQnt(rs.getInt("qnt"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("������ֹ����"+e.toString());
		}
		return array;
	}
	
	//Ư�� ����� �ֹ����
	public ArrayList<PurchaseVO> list(String uid) {
		ArrayList<PurchaseVO> array = new ArrayList<PurchaseVO>();
		try {
			String sql = "select * from purchase where uid = ? order by date desc";
			PreparedStatement ps = DB.CON.prepareStatement(sql);
			ps.setString(1, uid);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				PurchaseVO vo = new PurchaseVO();
				vo.setUid(rs.getString("uid"));
				vo.setUname(rs.getString("uname"));
				vo.setAddress(rs.getString("address"));
				vo.setOid(rs.getString("oid"));
				vo.setPhone(rs.getString("phone"));
				vo.setDate(rs.getTimestamp("date"));
				array.add(vo);
			}
		}catch(Exception e) {
			System.out.println("������ֹ����"+e.toString());
		}
		return array;
	}
	//�ֹ��� ��������
	public void pinsert(PurchaseVO vo) {
		try {
			String sql = "insert into purchase(oid, uid, uname, address, phone) values(?,?,?,?,?)";
			PreparedStatement ps = DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getOid());
			ps.setString(2, vo.getUid());
			ps.setString(3, vo.getUname());
			ps.setString(4, vo.getAddress());
			ps.setString(5, vo.getPhone());
			ps.execute();
		}catch(Exception e) {
			System.out.println("�ֹ��������������"+e.toString());
		}
	}
	
	public void oinsert(OrderVO vo) {
		try {
			String sql = "insert into orders(oid, code, price, qnt) values(?,?,?,?)";
			PreparedStatement ps = DB.CON.prepareStatement(sql);
			ps.setString(1, vo.getOid());
			ps.setInt(2, vo.getCode());
			ps.setInt(3,vo.getPrice());
			ps.setInt(4, vo.getQnt());
			ps.execute();
		}catch(Exception e) {
			System.out.println("�ֹ���ǰ�������"+e.toString());
		}
	}
}
